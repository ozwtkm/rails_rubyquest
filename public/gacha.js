

var get_gachas = function(){
    $.getJSON("/gacha", append_gacha_list);
}



function append_gacha_list(data){
	$('#gache_list').empty();


	$.each(data, function(index, val){
		var content = "<tr>";

		$.each(val, function(index2, val2){
			switch(index2){
				case "name":
					content += "<td align='center'>" + val2 + "</td>";
					break;
				case "id":
					content += "<td id='gacha_id' class='nondisplayFrame'>" + val2 + "</td>";
					break;
			}
		});

		content += "</tr>";

		$("#gacha_list").append(content);
	});

	$(".nondisplayFrame").css('display', 'none');

    set_colorfunc("gacha_list");

    $("#gacha_list tr").click(function() {
        var value = $(this)[0].cells[0].innerText //タグのidをキーにしてうまいこと引っ張りたい
        $("#candidate_gacha_id").empty();
        $("#candidate_gacha_id").append("<input type='hidden' id='gacha_id' value='" + value + "'>");
    });
}


var execute_gacha = function(){
    var gacha_id = Number($("input#gacha_id")[0].value);

    var array = [gacha_id];

	var json = JSON.stringify(array);

    $.ajax({
		url: "/gacha",
		type:'POST',
		dataType: 'json',
		data : json
    }).done(handle_gacha_result).fail(function(data){
        $("#msg").empty();

        var res = $.parseJSON(data.responseText);

        $("#msg").append(res.ErrorMessage);
    });

}


var handle_gacha_result = function(data){
	$("#msg").empty();
	var rarity = convert_rarity(data.rarity);

	$("#msg").append(data.name + "をゲットした! レア度：　" + rarity);
}