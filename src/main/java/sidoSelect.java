

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

import org.json.JSONObject;


/**
 * Servlet implementation class sidoSelect
 */
@WebServlet("/sidoSelect")
public class sidoSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public sidoSelect() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("===sidoSelect==="+request.getParameter("sidoCode"));
		
		DBConnection dbconn = new DBConnection();
		Connection con = dbconn.dbConn();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<DongCodeVO> guList = new ArrayList<DongCodeVO>();
		String sidoCode = request.getParameter("sidoCode");
		
		try {
			String sql = "select code, substr(name, instr(name, ' ')) name from DO_SI_GUN where use_yn = 'Y' and code like concat( substr(?, 1, 2), '%') and code != ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sidoCode);
			pstmt.setString(2, sidoCode);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println(rs.getString(1)+", "+rs.getString(2));
				DongCodeVO dongCdVO = new DongCodeVO();
				dongCdVO.setCode(rs.getString(1));
				dongCdVO.setName(rs.getString(2));
				guList.add(dongCdVO);
			}
			
		}catch(SQLException e) {
			
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
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		JSONObject jObj = new JSONObject();
		jObj.put("guList", guList);
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jObj);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
