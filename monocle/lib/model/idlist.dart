import 'dart:convert';

import 'package:fast_log/fast_log.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lzstring/lzstring.dart';
import 'package:protobuf/protobuf.dart';

part "idlist.g.dart";

@JsonSerializable()
class IDList {
  String? data;

  @JsonKey(ignore: true)
  List<int>? raw;

  IDList();

  void _explode() {
    if (data != null && data!.isNotEmpty) {
      raw = _getAllIds();
      data = null;
    }
  }

  void _optimize() {
    if (getIds().isEmpty) {
      return;
    }

    List<int> aids = getIds();
    aids.sort();
    List<String> tokens = [];
    List<int> sequenceBuffer = [];

    for (int i = 0; i < aids.length; i++) {
      int id = aids[i];
      if (sequenceBuffer.isEmpty || sequenceBuffer.last + 1 == id) {
        sequenceBuffer.add(id);
      } else {
        if (sequenceBuffer.length > 1) {
          tokens.add("${sequenceBuffer.first}-${sequenceBuffer.last}");
        } else if (sequenceBuffer.length == 1) {
          tokens.add(sequenceBuffer.first.toString());
        }
        sequenceBuffer.clear();
        i--;
      }
    }

    if (sequenceBuffer.length > 1) {
      tokens.add("${sequenceBuffer.first}-${sequenceBuffer.last}");
      sequenceBuffer.clear();
    } else if (sequenceBuffer.length == 1) {
      tokens.add(sequenceBuffer.first.toString());
      sequenceBuffer.clear();
    }

    info("tokens: ${tokens.length} from ${aids.length}");

    raw = null;
    if (tokens.isEmpty) {
      data = "";
      return;
    }

    data = compress(tokens.join(","));
  }

  List<int> _getAllIds() {
    List<int> oids = [];

    if (raw != null) {
      oids.addAll(raw!);
    }

    String d = data ?? "";

    if (d.isEmpty) {
      return oids;
    }

    String decompressed = decompress(data!);
    List<String> ids =
        decompressed.contains(",") ? decompressed.split(",") : [decompressed];

    oids.addAll(ids.mapMany((e) {
      List<String> tokens = [];

      if (e.contains(",")) {
        tokens.addAll(e.split(","));
      } else {
        tokens.add(e);
      }

      return tokens;
    }).mapMany((e) {
      List<int> idx = [];

      if (e.contains("-")) {
        List<String> tokens = e.split("-");
        int start = int.parse(tokens[0]);
        int end = int.parse(tokens[1]);

        for (int i = start; i <= end; i++) {
          idx.add(i);
        }
      } else {
        idx.add(int.parse(e));
      }

      return idx;
    }));

    return oids;
  }

  String compress(String f) {
    CodedBufferWriter w = CodedBufferWriter();
    List<String> tokens = f.split(",");
    List<String> ranges = [];
    List<String> normals = [];

    for (String i in tokens) {
      if (i.contains("-")) {
        ranges.add(i);
      } else {
        normals.add(i);
      }
    }

    w.writeInt32NoTag(ranges.length);
    w.writeInt32NoTag(normals.length);

    for (String i in ranges) {
      List<String> tokens = i.split("-");
      int start = int.parse(tokens[0]);
      int end = int.parse(tokens[1]);
      w.writeInt32NoTag(start);
      w.writeInt32NoTag(end);
    }

    for (String i in normals) {
      w.writeInt32NoTag(int.parse(i));
    }

    return base64Encode(w.toBuffer());
  }

  String decompress(String f) {
    CodedBufferReader r = CodedBufferReader(base64Decode(f));
    List<String> tokens = [];
    int ranges = r.readInt32();
    int normals = r.readInt32();

    for (int i = 0; i < ranges; i++) {
      int start = r.readInt32();
      int end = r.readInt32();
      tokens.add("$start-$end");
    }

    for (int i = 0; i < normals; i++) {
      tokens.add(r.readInt32().toString());
    }

    return tokens.join(",");
  }

  String _compressOld(String f) {
    String c = LZString.compressToEncodedURIComponentSync(f)!;

    if (c.length < f.length) {
      return "!$c";
    }

    return f;
  }

  String _decompressOld(String f) {
    if (f.startsWith("!")) {
      return LZString.decompressFromEncodedURIComponentSync(f.substring(1))!;
    }

    return f;
  }

  List<int> getIds() {
    return raw ?? [];
  }

  void add(int id) {
    raw ??= [];
    raw!.add(id);
  }

  void addAll(List<int> ids) {
    raw ??= [];
    raw!.addAll(ids);
  }

  factory IDList.fromJson(Map<String, dynamic> json) =>
      _$IDListFromJson(json).._explode();

  Map<String, dynamic> toJson() => _$IDListToJson(this.._optimize());
}
