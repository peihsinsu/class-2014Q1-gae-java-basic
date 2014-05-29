package com.mitac.blobstore.sample;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

public class Upload extends HttpServlet {
    private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {
    	Logger log = Logger.getLogger("Upload");
    	//Using Upload Blobs... (deprecated)
//    	Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(req);
//    	log.warning("Blob map:" + blobs.toString());
//    	BlobKey blobKey = blobs.get("file");
//    	log.warning(blobKey.getKeyString());
//        if (blobKey == null) {
//        	log.warning("blobKey is null.....");
//            res.sendRedirect("/");
//        } else {
//        	log.warning("go to serve of blob-key:" + blobKey.getKeyString());
//            res.sendRedirect("/serve?blob-key=" + blobKey.getKeyString());
//        }

    	//Using Blob Info
    	Map<String, List<BlobInfo>> blobs2 = blobstoreService.getBlobInfos(req);
    	log.warning("From blobInfos..." + blobs2.toString());
    	
        BlobInfo blobinfo = blobs2.get("file").get(0);
        log.warning(blobinfo.getBlobKey().getKeyString());

        if (blobinfo == null) {
        	log.warning("blobKey is null.....");
            res.sendRedirect("/");
        } else {
        	log.warning("go to serve of blob-key:" + blobinfo.getBlobKey().getKeyString());
            res.sendRedirect("/serve?blob-key=" + blobinfo.getBlobKey().getKeyString());
        }
    }
}

