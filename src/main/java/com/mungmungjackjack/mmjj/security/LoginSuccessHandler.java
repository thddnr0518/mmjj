package com.mungmungjackjack.mmjj.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.RequestCacheAwareFilter;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mungmungjackjack.mmjj.member.domain.ResponseDataCode;
import com.mungmungjackjack.mmjj.member.domain.ResponseDataDTO;
import com.mungmungjackjack.mmjj.member.domain.ResponseDataStatus;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {

		log.info("Login Success Handle");
		
		SavedRequest savedRequest = requestCache.getRequest(request, response);

			if (savedRequest == null) {
				super.onAuthenticationSuccess(request, response, auth);

				return;
			}
	    
		log.info("savedRequest -> " + savedRequest.getRedirectUrl());
		
		ObjectMapper mapper = new ObjectMapper();
		
		ResponseDataDTO responseDataDTO = new ResponseDataDTO();
		responseDataDTO.setCode(ResponseDataCode.SUCCESS);
		responseDataDTO.setStatus(ResponseDataStatus.SUCCESS);
		responseDataDTO.setMessage(savedRequest.getRedirectUrl());
		
		response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print(mapper.writeValueAsString(responseDataDTO));
        response.getWriter().flush();
	}
}
