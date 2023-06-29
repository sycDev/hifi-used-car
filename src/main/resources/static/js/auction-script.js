$(document).ready(function() {
	$('#yearFrom').change(function() {
		if ($(this).val() !== '') {
			$('#yearTo').prop('disabled', false);
		} else {
			$('#yearTo').prop('disabled', true);
		}
		$('#yearTo').datepicker('setStartDate', $(this).val());
	});
});

// Enable Bootstrap Datepicker for Year From
$('#yearFrom').datepicker({
	format: "yyyy",
	autoclose: true,
  	minViewMode: "years",
 	orientation: "bottom right"
}).on('changeDate', function(selected){
    startDate = $("#yearFrom").val();
    $('#yearTo').datepicker('setStartDate', startDate); // Prevent yearTo earlier than yearFrom
});

// Enable Bootstrap Datepicker for Year To
$('#yearTo').datepicker({
	format: "yyyy",
	autoclose: true,
  	minViewMode: "years",
 	orientation: "bottom right"
});