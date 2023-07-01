//Data validation onSubmit
function validateForm(formId) {
	$('#' + formId).submit(function(e) {
		e.preventDefault(); // Prevent the form to submit
		validateEmptyRequired();

		var totalError = 0;
		var element, invalid;

		// Loop through all input fields to find out the input with invalid input
		$("#" + formId + " input").not(":hidden").each(function() {
			element = $("#" + $(this).attr("id"));
			invalid = element.hasClass('invalid-input');
			if (invalid) {
				totalError++;
			}
		});

		// If there is at least one invalid input
		if (totalError !== 0) {
			e.preventDefault(); // Prevent the form to submit
		} else {
			this.submit();
		}
	});
}

// Validate form with empty required fields
function validateEmptyRequired() {
	var isValid = true;
	$('form input, form select').each(function() {
		if ($(this).attr("required") === "required") {
			if (!$(this).val()) {
				isValid = false;
				$(this).addClass('invalid-input');
				$(this).removeClass('valid-input');
				$('#error-' + ($(this).attr('id'))).html(
						'Please fill out this field');
			}
		}
	});
	return isValid;
}

// Checking of username exceeds maximum length
function checkUsernameLength() {
	// Validate only when it is not empty
    if ($('#username').val()) {
    	let length = $('#username').val().length;
    	if (length > 30) {
            showError('username', "Please make sure not exceed 30 characters");
        } else {
            hideError('username');
        }
    }
}

// Data validation onBlur

// Checking for empty input field after blur the field
// Change the bottom border color of the input that is empty
$('form input').blur(function(e) {
	var inputId = $(this).attr('id');
		  
	if (inputId === 'password') {
		return; // Skip validation for password input as handle by other script
	}

	if (!$(this).val()) {
		e.preventDefault(); // Prevent the form to submit
		$(this).addClass('invalid-input');
		$(this).removeClass('valid-input');
		$('#error-' + ($(this).attr('id'))).html('Please fill out this field');
	} else {
		$(this).addClass('valid-input');
		$(this).removeClass('invalid-input');
		$('#error-' + ($(this).attr('id'))).html('');
	}
});

// Validate email on blur if the input is not empty
$('#email').on('blur', function() {
	if ($(this).val() !== '') {
		validateEmail(this.value);
	}
});

// Check length of username on blur
$('#username').blur(function() {
	checkUsernameLength();
});

/*
 * Input validation of email address
 * - must contain @ and dot
 * - at least two characters after the dot
 * - cannot start or end with a dot or a @
 * - should not contain spaces into the string
 * - should not contain special chars (<:,*)
 * - can contain dots in the middle of mail address before the @
 * - can contain a double domain
 */
function validateEmail(str) {
	var regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	if (!regex.test(str)) {
		showError('email', 'Invalid email');
		return false;
	} else {
		hideError('email');
		return true;
	}
}

// Data validation onInput

/* When user is typing in the field, and it has invalid input class 
 * (means it's not the first time user made error)
 * Then do validation checking of email on the spot
 */ 
$('#email').on('input', function() {
	if ($(this).hasClass('invalid-input')) {
		$(this).on('input', function() {
			if ($(this).val() !== '') {
				validateEmail($(this).val());
			}
		});
	}
});

// Check length of username onInput
$('#username').on('input', function() {
	if ($(this).hasClass('invalid-input')) {
		$(this).on('input', function() {
			if ($(this).val() !== '') {
				checkUsernameLength();
			}
		});
	}
});

// Function to show error message and change border bottom colour to red
function showError(selector, msg) {
	$('#error-' + selector).html(msg);
	$('#' + selector).addClass('invalid-input');
	$('#' + selector).removeClass('valid-input');
}

// Function to hide error message and change border bottom colour to green
function hideError(selector) {
	$('#error-' + selector).html('');
	$('#' + selector).addClass('valid-input');
	$('#' + selector).removeClass('invalid-input');
}