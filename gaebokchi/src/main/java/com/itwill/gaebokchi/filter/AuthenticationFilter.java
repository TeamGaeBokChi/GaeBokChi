package com.itwill.gaebokchi.filter;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthenticationFilter extends HttpFilter {

	private static final long serialVersionUID = 1L;
	public static final String SESSION_ATTR_USER = "signedInUser";

	@Override
	public void init() throws ServletException {
		log.debug("authFilter 초기화...");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		Object signedInUser = session.getAttribute(SESSION_ATTR_USER);
		if (signedInUser != null) {
			log.debug("로그인 됨: {}", signedInUser);

			chain.doFilter(request, response);
			return;
		}

		log.debug("로그인 안됨 ---> 로그인 페이지로 이동");

		String url = req.getRequestURL().toString();
		log.debug("[url] {}", url);

		String qs = req.getQueryString();
		log.debug("[query string] {}", qs);

		String target = "";
		if (qs == null) {
			target = URLEncoder.encode(url, "UTF-8");
		} else {
			target = URLEncoder.encode(url + "?" + qs, "UTF-8");
		}
		log.debug("[target] {}", target);

		String signInPage = req.getContextPath() + "/user/signin?target=" + target;

		((HttpServletResponse) response).sendRedirect(signInPage);
	}

}
