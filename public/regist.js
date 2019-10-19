var regist = function(){
    var username = document.getElementById('username').value;
    var password = document.getElementById('password').value;

    var json = {"name":username, "passwd":password};
   json = JSON.stringify(json);

    $.ajax({
        url: "/users",
		type:'POST',
		dataType: 'json',
		data : json
    }).done(handle_login_result).fail(function(data){
        $("#msg").empty();

        if ($.isArray(data.responseJSON) === true){
            $.each(data.responseJSON, function(index, val){
                $("#msg").append(val.ErrorMessage);
                $("#msg").append("<br>");
            });
        }else{
            $("#msg").append(data.responseJSON.ErrorMessage);    
        }
    });

}


var handle_login_result = function(data){
    $("#msg").empty();
    $("#msg").append("ユーザ登録成功<br/>");
}