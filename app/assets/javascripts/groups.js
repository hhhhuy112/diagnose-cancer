//group.js
$(document).ready(function() {
  $("#select-all-user-outside").click(function(e) {
    if($(this).is(':checked')){
       $(".checkbox-user-group input[type = checkbox]").prop('checked', true);
    }else{
      $(".checkbox-user-group input[type = checkbox]").prop('checked', false);
    }
  });

  $(document).on('click', '.member-group', function(e) {
    if($(this).is(':checked')){
      values_delete = add_delete_value($(this).val());
      $("#user_ids").val(values_delete);
    }else{
      values_delete = remove_delete_value($(this).val());
      $("#user_ids").val(values_delete);
    }
    is_all_checked();
  });

  $("#select-all-user-inside").click(function(e) {
    if($(this).is(':checked')){
      $("#list-users-group input[type = checkbox]").prop('checked', true);
      if($("#search").val() === ""){
        $("#user_ids").val(getValuesDelete());
      }else{
        set_add_all_checked();
      }
    }else{
      $("#list-users-group input[type = checkbox]").prop('checked', false);
      if($("#search").val() === ""){
        $("#user_ids").val(getValuesDelete());
      }else{
        set_delete_all_checked();
      }
    }
  });
});

$(document).on('keyup', '#group_members_search input', function (event) {
  $.get($('#group_members_search').attr('action'), $('#group_members_search').serialize(), null, 'script').done(function( data ) {
    setValuesdelete();
    is_all_checked();
  });
  return false;
});

function set_add_all_checked(){
  current_value = $(".member-group:checked").map(function(a){
    return $(this).val();
  }).get();

   if(current_value.length >0){
    current_value.forEach(function(value){
      values_delete = add_delete_value(value);
      $("#user_ids").val(values_delete);
    });
  }
}

function set_delete_all_checked(){
  values_delete = $("#user_ids").val().split(",");
  current_value = $(".member-group:checked").map(function(a){
    return $(this).val();
  }).get();

  if(current_value.length >0){
    current_value.forEach(function(value){
      values_delete = remove_delete_value(value);
      $("#user_ids").val(values_delete);
    });
  }
}

function getValuesDelete(){
  return $(".member-group:checked").map(function(a){
    return $(this).val();
  }).get().valueOf();
}

function is_all_checked(){
  if($('.member-group').not(':checked').length == 0){
    $("#select-all-user-inside").prop('checked', true);
  }else{
    $("#select-all-user-inside").prop('checked', false);
  }
}

function setValuesdelete(){
  values_delete = $("#user_ids").val().split(",");
   if(values_delete.length > 0){
      values_delete.forEach(function(value){
        $("#" + value).prop('checked', true);
      });
   }
}

function add_delete_value(value){
  value_input = $("#user_ids").val();
  values_delete = (value_input !== "") ?  value_input.split(",") : [];
  if(values_delete.indexOf(value) === -1){
    values_delete.push(value);
  }
  return values_delete.valueOf();
}

function remove_delete_value(value){
   values_delete = $("#user_ids").val().split(",");
   index = values_delete.indexOf(value);
   if(index > -1){
    values_delete.splice(index, 1);
  }
  return values_delete.valueOf();
}

//end group.js


//add member group

$(document).ready(function(){
});

$(document).on('keyup', '#assign-list-user-group-search', function (event) {
  $(".hide-user-group-search").hide();
  search_user_outside($("#assign-list-user-group-search").val());
});

 $(document).on('click', '.search-checkbox input[type = checkbox]', function(e) {
    is_all_checked_member_outside();
  });

 function is_all_checked_member_outside(){
  if($('.search-checkbox input[type = checkbox]').not(':checked').length == 0){
    $("#select-all-user-outside").prop('checked', true);
  }else{
    $("#select-all-user-outside").prop('checked', false);
  }
}

function search_user_outside(text_search){
  if(text_search === ""){
    $(".hide-user-group-search").show();
  }else{
    search(text_search);
  }
}

function search(text_search){
  value_member_outsides = $(".hide-user-group-search .search-checkbox > label");
  for(i=1; i <= value_member_outsides.length; i++) {
    value_user_outside = $(".hide-user-group-search:nth-of-type(" + i + ") .search-checkbox > label").text();
    if(value_user_outside.toLowerCase().indexOf(text_search.toLowerCase()) > -1){
      $(".hide-user-group-search:nth-of-type(" + i + ")").show();
    }
  }
}

// end member group
