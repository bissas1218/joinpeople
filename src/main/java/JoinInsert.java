

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class JoinInsert
 */
@WebServlet("/JoinInsert")
public class JoinInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinInsert() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/join-insert.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("join name: "+request.getParameter("gender"));
		
		DBConnection dbconn = new DBConnection();
		Connection con = dbconn.dbConn();
		PreparedStatement pstmt = null;
		
		String anyone_chk = "N";
		if(request.getParameter("anyone") != null) {
			anyone_chk = "Y";
		}
		
		try {
			String sql = "insert into join_main (join_name, anyone_chk, pwd, join_area, join_date, gender, hole_num, teeup_time, start_greenfee, end_greenfee, people_num, join_exp) "
					+ "values (?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, request.getParameter("joinName"));
			pstmt.setString(2, anyone_chk);
			pstmt.setString(3, request.getParameter("pwd"));
			pstmt.setString(4, request.getParameter("area_list"));
			pstmt.setString(5, request.getParameter("join_date"));
			pstmt.setString(6, request.getParameter("gender"));
			pstmt.setString(7, request.getParameter("hole_num"));
			pstmt.setString(8, request.getParameter("teeup_time"));
			pstmt.setString(9, request.getParameter("start_greenfee").replace(",", ""));
			pstmt.setString(10, request.getParameter("end_greenfee").replace(",", ""));
			pstmt.setString(11, request.getParameter("people_num"));
			pstmt.setString(12, request.getParameter("join_exp"));
			pstmt.execute();
			
		}catch(SQLException e) {
			
		}finally {
			try {

				if (pstmt != null) {
					pstmt.close();
				}
				
				if (con != null && !con.isClosed()) {
					con.close();
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print("<html><script>alert('새로운 조인방이 생성되었습니다.');window.location.href='/JoinList';</script></html>");
		out.close();
		//response.sendRedirect("/join-list.jsp");
	}

}
