

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
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
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("join name: "+request.getParameter("area_list"));
		
		DBConnection dbconn = new DBConnection();
		Connection con = dbconn.dbConn();
		PreparedStatement pstmt = null;
		
		String anyone_chk = "N";
		if(request.getParameter("anyone") != null) {
			anyone_chk = "Y";
		}
		
		try {
			String sql = "insert into join_main (join_name, anyone_chk, pwd) values (?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, request.getParameter("joinName"));
			pstmt.setString(2, anyone_chk);
			pstmt.setString(3, request.getParameter("pwd"));
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
		//PrintWriter out = response.getWriter();
		response.sendRedirect("/join-list.jsp");
	}

}
