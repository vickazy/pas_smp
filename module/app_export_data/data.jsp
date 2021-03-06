<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	
	String q=" select	a.kd_tahun_ajaran"
			+" ,		b.nm_tahun_ajaran"
			+" ,		a.npsn"
			+" ,		a.id_propinsi"
			+" ,		a.id_kabupaten"
			+" ,		a.id_kecamatan"
			+" from		t_sekolah_identitas	as a"
			+" ,		r_tahun_ajaran		as b"
			+" where	a.kd_tahun_ajaran	= b.kd_tahun_ajaran"
			+" and		a.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("kd_tahun_ajaran") + "'"
				+ ",\""+ rs.getString("nm_tahun_ajaran") +"\""
				+ ",'"+ rs.getString("npsn") +"'"
				+ ",'"+ rs.getString("id_propinsi") +"'"
				+ ",'"+ rs.getString("id_kabupaten") +"'"
				+ ",'"+ rs.getString("id_kecamatan") +"'"
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
