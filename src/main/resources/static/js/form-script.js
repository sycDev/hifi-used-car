$(document).ready(function() {
    checkEmptyOnBlur();

    // For image upload function
    $('#imageFile').change(function() {
        let imageFile = this.files[0];
        let extension = imageFile.name.substring(imageFile.name.lastIndexOf("."));
        let allowedFileTypeReg =  /(\.jpg|\.jpeg|\.png)$/i;
        let isAllowed = allowedFileTypeReg.test(extension);

        if ($(this).val() === '') {
            clearImageFileInput();
        } else if (imageFile.size > 2097152) {
            // If image file exceed maximum size of 2MB
            Swal.fire({
                icon: 'error',
                title: "Oops...",
                text: "File is too big! (Max: 2MB)",
                confirmButtonColor: '#17b978',
            })
            clearImageFileInput();
        } else if (!isAllowed) {
            // If image file type is not supported
            Swal.fire({
                icon: 'error',
                title: "Oops...",
                text: "File type not supported (Only allowed: .jpeg/.jpg/.png)",
                confirmButtonColor: '#17b978',
            })
            clearImageFileInput();
        } else {
            showImagePreview(this);
        }
    });

    $('#clear-img-btn').click(function() {
        clearImageFileInput();
    });
});

// Function to validate form before submit
function validateForm(formId, fields) {
    let totalError = 0;
    let element, invalid;

    // Validate all required fields
    validateEmptyRequired();

    // Validate each field based on its validation criteria
    fields.forEach(function(field) {
        validateFieldLength(field.selector, field.minLength, field.maxLength);
    });

    // Loop through all input fields to find out the input with invalid input
    $(formId + ' input, ' + formId + ' select').not(':hidden').each(function() {
        element = $('#' + $(this).attr('id'));
        invalid = element.hasClass('invalid-input');
        if (invalid) {
            totalError++;
        }
    });

    // If there is at least one invalid input
    if (totalError !== 0) {
        return false;
    } else {
        return true;
    }
}

// Function to clear the selected image
function clearImageFileInput() {
    $('#imageFile').val("");
    // Hide image preview
    $('#img-preview-div').removeClass('d-block').addClass('d-none');
}

// Function to show the preview of selected imageFile
function showImagePreview(imgFile) {
    let file = imgFile.files[0];
    let reader = new FileReader();
    reader.onload = function(e) {
        $('#imgPreview').attr('src', e.target.result);
    };
    reader.readAsDataURL(file);
    $('#img-preview-div').removeClass('d-none').addClass('d-block');
}

// Function to validate form with empty required fields
function validateEmptyRequired() {
    let isValid = true;
    $('form input, form select').each(function() {
        if ($(this).attr('required') === 'required') {
            if (!$(this).val()) {
                isValid = false;
                $(this).addClass('invalid-input');
                $(this).removeClass('valid-input');
                $('#error-' + ($(this).attr('id'))).html("Please fill out this field");
            }
        }
    });
    return isValid;
}

// Function to validate required fields onBlur
function checkEmptyOnBlur() {
    // Checking for empty input field after blur the field
    // Change the bottom border color of the input that is empty
    $('form input, form select').blur(function() {
        if ($(this).attr('required') === 'required') {
            if (!$(this).val()) {
                showError($(this).attr('id'), "Please fill out this field");
            } else {
                hideError($(this).attr('id'));
            }
        }
    });
}

// Function to check length of field onBlur
function checkLengthOnBlur(elementId, min, max) {
    $(elementId).blur(function () {
        // Validate only when it is not empty
        if ($(this).val()) {
            validateFieldLength(elementId, min, max);
        }

        // For non-required fields, remove all indicator when it is empty
        if (!$(this).val() && !$(this).attr('required')) {
            $('#error-' + elementId.replace("#", "")).html('');
            $(elementId).removeClass('valid-input').removeClass('invalid-input');
        }
    });
}

// Function to validate the field with restricted length
function validateFieldLength(elementId, min, max) {
    let field = $(elementId);
    let length = field.val().length;

    if (length < min) {
        showError(field.attr('id'), "Please make sure at least " + min + " characters");
    } else if (length > max) {
        showError(field.attr('id'), "Please make sure not exceed " + max + " characters");
    } else {
        hideError(field.attr('id'));
    }
}

// Function to show error message and change border bottom colour to red
function showError(selector, msg) {
    $('#error-' + selector).html(msg);
    $('#' + selector).addClass('invalid-input').removeClass('valid-input');
}

// Function to hide error message and change border bottom colour to green
function hideError(selector) {
    $('#error-' + selector).html('');
    $('#' + selector).addClass('valid-input').removeClass('invalid-input');
}
