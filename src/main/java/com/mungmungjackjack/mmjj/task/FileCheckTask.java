package com.mungmungjackjack.mmjj.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mungmungjackjack.mmjj.board.domain.BoardAttachDTO;
import com.mungmungjackjack.mmjj.board.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {

	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper attachMapper;
	
	private String uploadPath =
			"D:\\workspace\\sts_4.8.1\\mmjj\\src\\main\\webapp\\resources\\fileUpload";
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron = "0 0 2 * * *")
	public void checkFiles() throws Exception{
		
		log.info("File Check Task run............");
		log.info(new Date());
		// file list in database
		List<BoardAttachDTO> fileList = attachMapper.getOldFiles();
		
		// ready for check file in directory with database file list
		List<Path> fileListPaths = fileList.stream().map(bDto -> 
		Paths.get(uploadPath,
		bDto.getUploadPath(), "s_" + bDto.getUuid() + "_" +
		bDto.getFileName())).collect(Collectors.toList());
		
		// image file has thumnail file
		fileList.stream().filter(bDto -> bDto.isFiletype() == true).map(bDto -> 
		Paths.get(uploadPath,
		bDto.getUploadPath(), "s_" + bDto.getUuid() + "_" + bDto.getFileName()))
		.forEach(p -> fileListPaths.add(p));
		
		log.info("===============================");
		
		fileListPaths.forEach(p -> log.info(p));
		
		// files in yesterday directory
		File targetDir = 
		Paths.get(uploadPath,
					getFolderYesterDay()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> 
				fileListPaths.contains(file.toPath()) == false);
		
		log.info("-----------------------------");
		
		if(removeFiles != null) {
			
			for(File file : removeFiles) {
				log.info(file.getAbsolutePath());
				
				file.delete();
			}
		}
	}
}
