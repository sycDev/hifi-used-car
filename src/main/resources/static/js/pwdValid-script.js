$(document).ready(function() {
	let lengthCheck, lowercaseCheck, uppercaseCheck, numCheck, specialCharCheck, valid;
	const letter = "qwertyuiopasdfghjklzxcvbnm";
	const specialChars = "!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?`~";
	const numbers = "0123456789";
	
	// Hide the checkmark initially
	$(".requirements").addClass("wrong");
	
	// Show the password requirements checklist onFocus
	$("#password").focus(function() {
		$("#password-alert").removeClass("d-none");
	});
	
	$("#password").on("input", function() {
		let value = $("#password").val();
	
		// Check at least 8 characters
		if (value.length < 8) {
			lengthCheck = false;
		} else if (value.length > 7) {
			lengthCheck = true;
		}
	
		// Contains at least 1 lowercase letter
		if (value.toUpperCase() === value) {
			lowercaseCheck = false;
		} else {
			lowercaseCheck = true;
		}
		
		// Contains at least 1 uppercase letter
		if (value.toLowerCase() === value) {
			uppercaseCheck = false;
		} else {
			uppercaseCheck = true;
		}
		
		// Contains at least 1 number
		numCheck = false;
		for (let i = 0; i < value.length; i++) {
			for (let j = 0; j < numbers.length; j++) {
				if (value[i] === numbers[j]) {
					numCheck = true;
				}
			}
		}
	
		// Contains at least 1 special character
		specialCharCheck = false;
		for (let i = 0; i < value.length; i++) {
			for (let j = 0; j < specialChars.length; j++) {
				if (value[i] === specialChars[j]) {
					specialCharCheck = true;
				}
			}
		}
	
		// Check fulfil all requirements
		if (lengthCheck && lowercaseCheck && uppercaseCheck && numCheck && specialCharCheck) {
			// Valid password
			valid = true;

			// Change border bottom to green
			$("#password").removeClass("invalid-input").addClass("valid-input");

			// Hide the error message
			$('#error-password').html('');

			$(".requirements").removeClass("wrong").addClass("good");
		} else {
			// Invalid password
			valid = false;

			// Change border bottom to red
			$("#password").removeClass("valid-input").addClass("invalid-input");

			// Change sign of checkmark or cross based on criteria
			if (!lengthCheck) {
				$(".length").addClass("wrong").removeClass("good");
			} else {
				$(".length").addClass("good").removeClass("wrong");
			}
			
			if (!lowercaseCheck) {
				$(".lowercase").addClass("wrong").removeClass("good");
			} else {
				$(".lowercase").addClass("good").removeClass("wrong");
			}
			
			if (!uppercaseCheck) {
				$(".uppercase").addClass("wrong").removeClass("good");
			} else {
				$(".uppercase").addClass("good").removeClass("wrong");
			}
			
			if (!numCheck) {
				$(".num").addClass("wrong").removeClass("good");
			} else {
				$(".num").addClass("good").removeClass("wrong");
			}
			
			if (!specialCharCheck) {
				$(".special-char").addClass("wrong").removeClass("good");
			} else {
				$(".special-char").addClass("good").removeClass("wrong");
			}
		}
	});
	
	// Check password field onBlur
	$("#password").blur(function() {
		if (!$("#password").hasClass("valid-input")) {
			// Change border bottom to red
			$("#password").addClass("invalid-input");
		}
		if (!valid) {
			// Show error message if not yet meets all requirements
			$('#error-password').html('Please fulfil the password requirements');
		} else {
			// Hide the password requirements checklist if meets all requirements
			$("#password-alert").addClass("d-none");
		}
	});
});
