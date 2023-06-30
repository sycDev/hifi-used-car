package com.wou.hifiusedcar.exception;

public class ListingNotFoundException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public ListingNotFoundException() {
		super("Listing Not Found");
	}
}
