

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class JoinList
 */
@WebServlet("/JoinList")
public class JoinList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DBConnection dbconn = new DBConnection();
		Connection con = dbconn.dbConn();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select seq, join_name, anyone_chk, join_date, join_area from join_main "
					+ "order by SUBSTRING_INDEX(join_date, '-', 1) asc, cast(SUBSTRING_INDEX(SUBSTRING_INDEX(join_date, '-', -2), '-', 1) as unsigned) asc, cast(SUBSTRING_INDEX(join_date, '-', -1) as unsigned) asc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			List<JoinMainVO> joinList = new ArrayList<JoinMainVO>();
			
			while(rs.next()) {
				System.out.println(rs.getString(5));
				String[] areaList = rs.getString(5).split(",");
				for(int i=0; i<areaList.length; i++) {
					System.out.println(areaList[i]);
				}
				JoinMainVO joinVo = new JoinMainVO();
				joinVo.setSeq(rs.getInt(1));
				joinVo.setJoinName(rs.getString(2));
				joinVo.setAnyoneChk(rs.getString(3));
				joinVo.setJoinDate(rs.getString(4));
				joinList.add(joinVo);
			}
			
			request.setAttribute("joinList", joinList);
			
		}catch(SQLException e) {
			e.printStackTrace();
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
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/join-list.jsp");

		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
