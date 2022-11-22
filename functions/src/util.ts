import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as fs from "fs";
import sharp = require("sharp");
import * as os from "os";
import * as path from "path";
import { v4 as uuidv4 } from 'uuid';

export default class Util {
    static run() {
        return functions.runWith({
            timeoutSeconds: 60,
            memory: "512MB",
            minInstances: 0,
        }).region("us-central1");
    }

    static runHeavy() {
        return functions.runWith({
            timeoutSeconds: 540,
            memory: "4GB",
            minInstances: 0,
        }).region("us-central1");
    }

    static lastPath(path: string): string {
        const b: string[] = path.split("/");
        return b[b.length - 1];
    }

    static nextPath(path: string, key: string): string {
        const b: string[] = path.split("/");
        return b[b.indexOf(key) + 1];
    }

    static async touch(document: string, data: any) {
        var d = await admin.firestore().doc(document).get();

        if (!d.exists) {
            await d.ref.create(data);
        }
    }

    // Creates a signed url for access to cloud storage
    static async getSignedUrl(path: string, action: 'read' | 'write' | 'delete' | 'resumable', expireInMs: number, contentType: string): Promise<string> {
        const signedUrlResponse: string[] = await admin.storage()
            .bucket()
            .file(path)
            .getSignedUrl({
                contentType: contentType,
                action: action,
                expires: new Date(Date.now() + expireInMs),
            });
        const assetUrl: string = signedUrlResponse[0];
        return assetUrl;
    }
//
    static unlink(path: string) {
        fs.unlinkSync(path);
    }

    static newTempFile(): string {
        return path.join(os.tmpdir(), uuidv4());
    }

    static resize(limit: number, x: number, y: number): number[] {
        return new Array(Math.ceil(x >= y ? limit : limit * (x / y)), Math.ceil(y >= x ? limit : limit * (y / x)));
    }

    static async resizeImageFile(path: string, dest: string, limit: number) {
        await sharp(path).rotate().resize(
            limit, limit, {
            fit: "inside",
            withoutEnlargement: true,
            fastShrinkOnLoad: true,
        }
        ).webp().toFile(dest);
    }

    static async resizeImageFileJpeg(path: string, dest: string, limit: number) {
        await sharp(path).rotate().resize(
            limit, limit, {
            fit: "inside",
            withoutEnlargement: true,
            fastShrinkOnLoad: true,
        }
        ).jpeg().toFile(dest);
    }

    static docufyFilePath(path: string): string {
        var doc: string[] = [];
        path.split("/").forEach((i) => {
            doc.push(i);
            doc.push(i);
        });
        doc.splice(0, 1);
        doc.pop();
        return doc.join("/");
    }
}