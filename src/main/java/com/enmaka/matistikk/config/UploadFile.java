
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.enmaka.matistikk.config;
 
import com.enmaka.matistikk.objects.PictureUpload;
import java.io.File;
import java.io.IOException;
import java.util.List;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.enmaka.matistikk.service.UserService;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
 
public class UploadFile extends HttpServlet {
 
    private UserService userService;
    private static final long serialVersionUID = 1L;
    private final String UPLOAD_DIRECTORY = "C:/uploadtemp/";
 
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 
        // process only if it is multipart content
        if (isMultipart) {
            // Create a factory for disk-based file items
            FileItemFactory factory = new DiskFileItemFactory();
 
            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);
            try {
                // Parse the request
                List<FileItem> multiparts = upload.parseRequest(request);
 
                for (FileItem item : multiparts) {
                    if (!item.isFormField()) {
                        String name = new File(item.getName()).getName();
                        String path = UPLOAD_DIRECTORY + name;
                        item.write(new File(path));
                        response.getWriter().write(path);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
 