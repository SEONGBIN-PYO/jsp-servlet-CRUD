package member.command;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.service.InvaildNameException;
import member.service.MemberNotFoundException;
import member.service.SearchPasswordService;
import mvc.command.CommandHandler;

public class SearchPasswordHandler implements CommandHandler {
	private static final String FORM_VIEW = "/WEB-INF/view/searchPasswordForm.jsp";
	private SearchPasswordService searchPwdSvc = new SearchPasswordService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) 
	throws Exception {
		if (req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req, res);
		} else if (req.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(req, res);
		} else {
			res.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}
	}

	private String processForm(HttpServletRequest req, HttpServletResponse res) {
		return FORM_VIEW;
	}


	private String processSubmit(HttpServletRequest req, HttpServletResponse res)
	throws Exception {
		String curId = req.getParameter("id");
		String curName = req.getParameter("name");

		Map<String, Boolean> errors = new HashMap<>();
		req.setAttribute("errors", errors);
		
		if (curId == null || curId.isEmpty()) {
			errors.put("curId", Boolean.TRUE);
		}
		if (curName == null || curName.isEmpty()) {
			errors.put("curName", Boolean.TRUE);
		}
		
		if (!errors.isEmpty()) {
			return FORM_VIEW;
		}
		
		try {
			searchPwdSvc.issuedTemporaryPassword(curId, curName, req);
			return "/WEB-INF/view/temporaryPassword.jsp";
		} catch (InvaildNameException e) {
			errors.put("badCurPwd", Boolean.TRUE);
			return FORM_VIEW;
		} catch (MemberNotFoundException e) {
			res.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return null;
		}
	}
}
