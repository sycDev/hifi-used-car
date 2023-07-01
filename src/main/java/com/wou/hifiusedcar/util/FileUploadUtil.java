package com.wou.hifiusedcar.util;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Objects;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileUploadUtil {
	@Value("${uploadDir}")
    private String UPLOAD_DIR;

    /**
     * Uploads a file to the specified directory.
     *
     * @param folder the name of the subdirectory where the file should be saved
     * @param name the base name of the file, without the extension
     * @param multipartFile the file to be uploaded
     * @return the name of the uploaded file, including the generated unique identifier and extension
     * @throws IOException if there is an error saving the file
     */
    public String uploadFile(String folder, String name, MultipartFile multipartFile) throws IOException {
        // Generate a unique file name
        String originalFileName = StringUtils.cleanPath(Objects.requireNonNull(multipartFile.getOriginalFilename()));
        String fileExt = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
        String fileName = name + "_" + UUID.randomUUID() + "." + fileExt;

        Path uploadPath = Paths.get(UPLOAD_DIR + folder);
        // Create directory if not exists
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // Upload the file to the directory
        try (InputStream inputStream = multipartFile.getInputStream()) {
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
            return fileName;
        } catch (IOException ioe) {
            throw new IOException("Could not save image file: " + fileName, ioe);
        }
    }
}
