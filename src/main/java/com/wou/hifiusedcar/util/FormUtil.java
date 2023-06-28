package com.wou.hifiusedcar.util;

import java.util.ArrayList;
import java.util.List;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public class FormUtil {
	/**
     * Check validation of form data
     *
     * @param result the BindingResult object
     * @param redirectAttributes the RedirectAttributes object
     * @return true for valid, false for invalid
     */
    public static boolean checkValidation(BindingResult result, RedirectAttributes redirectAttributes) {
        // The data consists any error
        if (result.hasErrors()) {
            // Get the list of error message
            List<String> errorMessages = new ArrayList<>();
            for (FieldError error : result.getFieldErrors()) {
                errorMessages.add(error.getDefaultMessage());
            }

            // Add a error message flash attribute
            if (!errorMessages.isEmpty()) {
                String errorMessage = String.join("<br> ", errorMessages);
                redirectAttributes.addFlashAttribute("errMsg", errorMessage);
            }

            return true;
        }
        return false;
    }

    /**
     * Validates a non-required field and returns a boolean indicating
     * whether the field is empty or not.
     *
     * @param nonRequiredField the non-required field to validate
     * @return true if the field is null or empty; false otherwise
     */
    public static boolean validateNonRequiredField(String nonRequiredField) {
        return nonRequiredField == null || nonRequiredField.trim().equals("");
    }
}
