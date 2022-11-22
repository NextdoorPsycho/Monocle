import Util from "../util";

exports.beforeCreate = Util.run().auth.user().beforeCreate(async (user, context) => {
    await Promise.all([
        Util.touch("user/" + user.uid, {})
    ]);
  });
  
exports.beforeSignIn = Util.run().auth.user().beforeSignIn(async (user, context) => {
    await Promise.all([
        
    ]);
  });