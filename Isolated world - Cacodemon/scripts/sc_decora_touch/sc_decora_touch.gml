/// @arg instList
/// @arg list


var instList = argument0;
var list_box = argument1;

//触发互动事件

var num = ds_list_size(instList);

var tempNum = 0;

for (var i = 0; i < num; ++i) {
	var temp = instList[| i];
	if(list_box == undefined){
		 with(temp){
			event_user(0);
		}
		tempNum ++;
	}else if(ds_list_find_index(list_box,temp) < 0){
		ds_list_add(list_box,temp);
	    with(temp){
			event_user(0);
		}
		tempNum ++;
	}
}

return tempNum;