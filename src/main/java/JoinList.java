

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
import java.time.LocalDate;
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
		
		String searchFrmSubmit = request.getParameter("searchFrmSubmit");
		
		//System.out.println(request.getParameter("gender"));
		
		/* 검색지역 조건 */
		String[] searchAreaList = request.getParameterValues("search-area");
		String searchAreaSQL = "";
		if(searchAreaList != null && !searchAreaList[0].equals("all")) {
			searchAreaSQL = "and (";
			for(int i=0; i<searchAreaList.length; i++) {
				//System.out.println(searchAreaList[i]);
				if(i > 0) {
					searchAreaSQL += "or ";
				}
				searchAreaSQL += "join_area like '%," + searchAreaList[i] + "%' ";
				request.setAttribute("area_"+searchAreaList[i], searchAreaList[i]);
			}
			searchAreaSQL += ") ";
			
		}else {
			request.setAttribute("area_all", "all");
		}
		//System.out.println(searchSQL);
		
		/* 검색성별 조건 */
		//System.out.println(request.getParameter("gender"));
		String searchGender = request.getParameter("gender");
		String searchGenderSQL = "";
		
		if(searchGender != null && !searchGender.equals("all")) {
			//System.out.println(searchGender);
			searchGenderSQL = "and gender = '" +searchGender+ "' ";
			if(searchGender.equals("male")) {
				request.setAttribute("gender_male", "male");
			}else if(searchGender.equals("female")) {
				request.setAttribute("gender_female", "female");
			}
		}else {
			request.setAttribute("gender_all", "all");
		}
		//System.out.println(searchGenderSQL);
		
		/* 조인 시간대 */
		//System.out.println(request.getParameter("searchFrmSubmit") + ", " + request.getParameter("teeup_time_2"));
		String teeupTimeSQL = "";
		if(searchFrmSubmit != null && searchFrmSubmit.equals("true")) {
			teeupTimeSQL = "and (";
			
			String teeup_time_1 = request.getParameter("teeup_time_1");
			String teeup_time_2 = request.getParameter("teeup_time_2");
			String teeup_time_3 = request.getParameter("teeup_time_3");
			
			if(teeup_time_1 != null && teeup_time_1.equals("1")) {
				teeupTimeSQL += "teeup_time = 1";
				request.setAttribute("teeup_time_1", "1");	
				
				if(teeup_time_2 != null || teeup_time_3 != null) {
					teeupTimeSQL += " or ";
				}
			}
			
			if(teeup_time_2 != null && teeup_time_2.equals("2")) {
				teeupTimeSQL += "teeup_time = 2";
				request.setAttribute("teeup_time_2", "2");	
				
				if(teeup_time_3 != null) {
					teeupTimeSQL += " or ";
				}
			}
			
			if(teeup_time_3 != null && teeup_time_3.equals("3")) {
				teeupTimeSQL += "teeup_time = 3";
				request.setAttribute("teeup_time_3", "3");	
			}
			
			teeupTimeSQL += ") ";
			
		}else {
			request.setAttribute("teeup_time_1", "1");
			request.setAttribute("teeup_time_2", "2");
			request.setAttribute("teeup_time_3", "3");
		}
		//System.out.println(teeupTimeSQL);
		
		/* 검색날짜 */
		String searchDateSQL = "";
		LocalDate ldate = LocalDate.now();
		if(request.getParameter("join_date_start") == null) {
			
			request.setAttribute("join_date_start", ldate);
			request.setAttribute("join_date_end", ldate.plusMonths(6));
			request.setAttribute("join_date_min", ldate);
			request.setAttribute("join_date_max", ldate.plusYears(1));
		}else {
		//	System.out.println(request.getParameter("join_date_start"));
			request.setAttribute("join_date_start", request.getParameter("join_date_start"));
			request.setAttribute("join_date_end", request.getParameter("join_date_end"));
			request.setAttribute("join_date_min", ldate);
			request.setAttribute("join_date_max", ldate.plusYears(1));
			searchDateSQL = "and date_format(join_date, '%Y-%m-%d') between date_format('"+request.getParameter("join_date_start")+"', '%Y-%m-%d') and date_format('"+request.getParameter("join_date_end")+"', '%Y-%m-%d') ";
		}
		
		
		DBConnection dbconn = new DBConnection();
		Connection con = dbconn.dbConn();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		try {
			String sql = "select seq, join_name, anyone_chk, join_date, join_area, gender, hole_num, teeup_time, start_greenfee, end_greenfee, people_num, stroke_num from join_main where 1=1 "
					+ searchAreaSQL
					+ searchGenderSQL
					+ teeupTimeSQL
					+ searchDateSQL
					+ "order by SUBSTRING_INDEX(join_date, '-', 1) asc, cast(SUBSTRING_INDEX(SUBSTRING_INDEX(join_date, '-', -2), '-', 1) as unsigned) asc, cast(SUBSTRING_INDEX(join_date, '-', -1) as unsigned) asc";
			System.out.println(sql);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			List<JoinMainVO> joinList = new ArrayList<JoinMainVO>();
			
			while(rs.next()) {
				//System.out.println("=>"+rs.getString(5).substring(1));
				String[] areaList = rs.getString(5).substring(1).split(",");
				//System.out.println("==>"+areaList);
				
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
