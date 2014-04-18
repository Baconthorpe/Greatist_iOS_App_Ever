
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
 
Parse.Cloud.define("GRTUser", function(request, response){
    var query = new Parse.Query('GRTUser');
    query.find({
        success: function(results){
            response.success(results); 
        }, 
        error: function(){
            response.error("user lookup failed"); 
        }
 
    }); 
 
}); 
Parse.Cloud.define("friendPosts", function(request, response){
    var query = new Parse.Query("GRTUser"); 
    query.containedIn("facebookID", request.params.facebook_ids_array);
    query.find({
        success: function(results){
             
            console.log("results =" + results[0]); 
 
            var friendIDs = new Array(); 
             
            for (var i = 0; i < results.length; i++)
            {
                friendIDs.push(results[i].get("facebookID")); 
            }
             
 
            var query = new Parse.Query("GRTPost");
            query.containedIn("facebookID", friendIDs); 
            query.find ({
                success: function(results){
                    console.log(results);
                    response.success(results);  
                }, 
                error: function(){
                    response.error("Post lookup failed"); 
                }
            }); 
        },
        error: function(){
            response.error("Friend lookup failed"); 
        }
    });
}); 