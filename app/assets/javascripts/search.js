$(document).on('keyup', '.search_form_user', function (event) {
  $.get($('.search_form_user').attr('action'), $('.search_form_user').serialize(), null, 'script')
  return false;
});

$(document).on('change', '.roles_search', function (event) {
  $.get($('.search_form_user').attr('action'), $('.search_form_user').serialize(), null, 'script')
  return false;
});

$(document).on('keyup', '.search_form_group', function (event) {
  $.get($('.search_form_group').attr('action'), $('.search_form_group .search_text').serialize(), null, 'script')
  return false;
});

$(document).on('keyup', '.search_form_fiction', function (event) {
  $.get($('.search_form_fiction').attr('action'), $('.search_form_fiction .search_text').serialize(), null, 'script')
  return false;
});

$(document).on('keyup', '.search_form_value_fiction', function (event) {
  $.get($('.search_form_value_fiction').attr('action'), $('.search_form_value_fiction .search_text').serialize(), null, 'script')
  return false;
});

$(document).on('keyup', '.search_form_data_cancer', function (event) {
  $.get($('.search_form_data_cancer').attr('action'), $('.search_form_data_cancer .search_text').serialize(), null, 'script')
  return false;
});

$(document).on('click', '.search_diagnose', function (event) {
  $.get($('.search_form_diagnose').attr('action'), $('.search_form_diagnose').serialize(), null, 'script')
  return false;
});

$(document).on('click', '.search_user_diagnose', function (event) {
  $.get($('.search_form_user_diagnose').attr('action'), $('.search_form_user_diagnose').serialize(), null, 'script')
  return false;
});
