$('#ops_nav a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
})
$('a[data-toggle="tab"]:first').tab('show'); //Select first tab
