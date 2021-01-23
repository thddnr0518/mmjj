package com.mungmungjackjack.mmjj.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mungmungjackjack.mmjj.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@Log4j
public class UploadController {
	
	// 파일 용량 산정
	// 1kb = 1024byte, 1Mb = 1024kb, 10Mb = 10 X 1024 X 1024

	private String uploadPath =
			"D:\\workspace\\sts_4.8.1\\mmjj\\src\\main\\webapp\\resources\\fileUpload";
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		for (MultipartFile multipartFile : uploadFile) {
			
			log.info("---------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Name : " + multipartFile.getSize());
			log.info("Upload File Name : " + multipartFile.getContentType());
			
			File saveFile = new File(uploadPath, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/oneUploadAjaxAction",
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<AttachFileDTO> oneUploadAjaxPost(MultipartFile uploadFile){
		log.info("oneUploadAjaxPost.....................");
		
		String uploadFolderPath = getFolder();
		
		File uploadFolder = new File(uploadPath, getFolder());
		log.info("uploadFolder path : " + uploadFolder);
		
		if (uploadFolder.exists() == false) {
			uploadFolder.mkdirs();
		}
		
		log.info("---------------------------------");
		log.info("Upload File Name : " + uploadFile.getOriginalFilename());
		log.info("Upload File Size : " + uploadFile.getSize());
		log.info("Upload File Type : " + uploadFile.getContentType());
		
		AttachFileDTO attachFileDto = new AttachFileDTO();
		
		String uploadFileName = uploadFile.getOriginalFilename();
		
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		log.info("only file name : " + uploadFileName);
		
		attachFileDto.setFileName(uploadFileName);
		
		UUID uuid = UUID.randomUUID();
		
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		try {
			File saveFile = new File(uploadFolder, uploadFileName);
			uploadFile.transferTo(saveFile);
			
			attachFileDto.setUuid(uuid.toString());
			attachFileDto.setUploadPath(uploadFolderPath);
			
			if (checkImageType(saveFile)) {
				attachFileDto.setImage(true);
				
				File thumbnail = new File(uploadFolder, "s_" + uploadFileName);
				
				Thumbnails.of(saveFile).size(300, 200).toFile(thumbnail);
			}
			
			
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return new ResponseEntity<AttachFileDTO>(attachFileDto, HttpStatus.OK);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/uploadAjaxAction",
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile){
		log.info("update ajax post.....................");
		
		List<AttachFileDTO> attachList = new ArrayList<AttachFileDTO>();
		String uploadFolderPath = getFolder();
		
		File uploadFolder = new File(uploadPath, getFolder());
		log.info("uploadFolder path : " + uploadFolder);
		
		if (uploadFolder.exists() == false) {
			uploadFolder.mkdirs();
		}
		
		for (MultipartFile multipartFile : uploadFile) {
			log.info("---------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			log.info("Upload File Type : " + multipartFile.getContentType());
			
			AttachFileDTO attachFileDto = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name : " + uploadFileName);
			
			attachFileDto.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadFolder, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachFileDto.setUuid(uuid.toString());
				attachFileDto.setUploadPath(uploadFolderPath);
				
				if (checkImageType(saveFile)) {
					attachFileDto.setImage(true);
					
					File thumbnail = new File(uploadFolder, "s_" + uploadFileName);
					
					Thumbnails.of(saveFile).size(100, 100).toFile(thumbnail);
				}
				
				attachList.add(attachFileDto);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		
		return new ResponseEntity<List<AttachFileDTO>>(attachList, HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName : " + fileName);
		
		File file = new File(uploadPath + "\\" + fileName);
		
		log.info("file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@GetMapping("/download")
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		Resource resource = new FileSystemResource(uploadPath + "\\");
		
		if (resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
			
			String downloadName = null;
			
			if (checkIE) {
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replace("\\+", "");
			}else {
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("deleteFile : " + fileName);
		
		File file;
		
		try {
			file = new File(uploadPath + "\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			
			file.delete();
			
			if (type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("\\s_","\\");
				log.info("largeFileName : " + largeFileName);

				file = new File(largeFileName);
				
				if (file.exists()) {
					if (file.delete()) {
						log.info("large file : " + largeFileName);
					}
				}
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
	
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
