

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
		ResultSet rs2 = null;
		
		try {
			String sql = "select seq, join_name, anyone_chk, join_date, join_area, gender, hole_num, teeup_time, start_greenfee, end_greenfee, people_num, stroke_num from join_main "
					+ "order by SUBSTRING_INDEX(join_date, '-', 1) asc, cast(SUBSTRING_INDEX(SUBSTRING_INDEX(join_date, '-', -2), '-', 1) as unsigned) asc, cast(SUBSTRING_INDEX(join_date, '-', -1) as unsigned) asc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			List<JoinMainVO> joinList = new ArrayList<JoinMainVO>();
			
			while(rs.next()) {
			//	System.out.println("=>"+rs.getString(5));
				String[] areaList = rs.getString(5).split(",");
				String areaListStr = "";
				for(int i=0; i<areaList.length; i++) {
					//System.out.println(areaList[i]);
					sql = "select name from do_si_gun where code = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, areaList[i]);
					rs2 = pstmt.executeQuery();
					rs2.next();
				//	System.out.println(rs2.getString(1));
					areaListStr += rs2.getString(1);
					if(i+1 < areaList.length) {
						areaListStr += ", ";
					}
				}
				
				JoinMainVO joinVo = new JoinMainVO();
				joinVo.setSeq(rs.getInt(1));
				joinVo.setJoinName(rs.getString(2));
				joinVo.setAnyoneChk(rs.getString(3));
				joinVo.setJoinDate(rs.getString(4));
				joinVo.setGender(rs.getString(6));
				joinVo.setHoleNum(rs.getString(7));
				joinVo.setTeeupTime(rs.getString(8));
				joinVo.setStartGreenfee(rs.getString(9));
				joinVo.setEndGreenfee(rs.getString(10));
				joinVo.setPeopleNum(rs.getString(11));
				joinVo.setStrokeNum(rs.getString(12));
				joinVo.setAreaListStr(areaListStr);
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
				
				if(rs != null) {
					rs.close();
				}
				
				if(rs2 != null) {
					rs2.close();
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
