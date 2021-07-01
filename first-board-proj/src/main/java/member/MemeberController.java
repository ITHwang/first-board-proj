package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/*")
public class MemeberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberDAO memberDAO;

	public void init() throws ServletException {
		memberDAO = new MemberDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String nextPage = null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		HttpSession session;
		String action = request.getPathInfo();
		System.out.println("action: " + action);

		if (action == null || action.equals("/listMembers.do")) {
			List<MemberVO> membersList = memberDAO.listMembers();
			request.setAttribute("membersList", membersList);
			nextPage = "/viewMember/listMembers.jsp";

		} else if (action.equals("/addMember.do")) {
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			MemberVO memberVO = new MemberVO(id, pwd, name, email);
			memberDAO.addMember(memberVO);
			request.setAttribute("msg", "addMember");
			nextPage = "/member/loginForm.do";

		} else if (action.equals("/memberForm.do")) {
			nextPage = "/viewMember/memberForm.jsp";

		} else if (action.equals("/modMemberForm.do")) {
			String id = request.getParameter("id");
			MemberVO memInfo = memberDAO.findMember(id);
			request.setAttribute("memInfo", memInfo);
			nextPage = "/viewMember/modMemberForm.jsp";

		} else if (action.equals("/modMember.do")) {
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");

			MemberVO memberVO = new MemberVO(id, pwd, name, email);
			memberDAO.modMember(memberVO);
			request.setAttribute("msg", "modified");
			nextPage = "/member/listMembers.do";

		} else if (action.equals("/delMember.do")) {
			String id = request.getParameter("id");
			memberDAO.delMember(id);
			request.setAttribute("msg", "deleted");
			nextPage = "/member/listMmeber.do";
		} else if (action.equals("/loginForm.do")) { // 로그인 창으로
			nextPage = "/viewMember/loginForm.jsp";
		} else if (action.equals("/loginPass.do")) { // loginForm.jsp에서 로그인 성공하고 포워딩 받기
			String id = request.getParameter("user_id");
			String pwd = request.getParameter("user_pwd");

			Map<String, String> loginInfo = new HashMap<String, String>();
			loginInfo.put("id", id);
			loginInfo.put("pwd", pwd);
			session = request.getSession();
			session.setAttribute("loginInfo", loginInfo);
			nextPage = "/board/listArticles.do";
		} else if (action.equals("/loginCheck.do")) { // loginForm.jsp에서 ajax로 로그인 체크
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");

			if (memberDAO.isMember(id, pwd)) {
				writer.print("pass");
			} else {
				writer.print("nonpass");
			}

			return;
		} else if (action.equals("/logout.do")) { // 로그아웃: 세션에 담긴 로그인 정보 없애기
			session = request.getSession();
			session.setAttribute("loginInfo", null);
			request.setAttribute("msg", "logouted");
			nextPage = "/board/listArticles.do";
		} else if (action.equals("/mypage.do")) {
			String id = request.getParameter("id");
			MemberVO memInfo = memberDAO.findMember(id);
			request.setAttribute("memInfo", memInfo);
			nextPage = "/viewMember/mypage.jsp";
		} else if (action.equals("/modMypage.do")) {
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");

			MemberVO memberVO = new MemberVO(id, pwd, name, email);
			memberDAO.modMember(memberVO);
			request.setAttribute("msg", "modified");
			nextPage = "/member/mypage.do";
		} else if (action.equals("/exitMember.do")) {
			String id = request.getParameter("id");
			memberDAO.delMember(id);

			session = request.getSession();
			session.setAttribute("loginInfo", null);

			request.setAttribute("msg", "deleted");
			nextPage = "/board/listArticles.do";
		} else {
			List<MemberVO> membersList = memberDAO.listMembers();
			request.setAttribute("membersList", membersList);
			nextPage = "/viewMember/listMembers.jsp";
		}

		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}

}
