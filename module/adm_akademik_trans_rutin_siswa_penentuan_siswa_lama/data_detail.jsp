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

	String kd_tahun_ajaran		= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas		= request.getParameter("kd_tingkat_kelas");
	
	String q=" select	a.kd_tahun_ajaran"
			+" ,		a.kd_tingkat_kelas"
			+" ,		a.kd_rombel"
			+" ,		a.id_siswa"
			+" ,		b.nm_tingkat_kelas"
			+" ,		c.nis"
			+" ,		c.nm_siswa"
			+" ,		if(a.kd_status_siswa = '0', 'Naik Kelas', 'Tinggal Kelas') as kd_status_siswa"
			+" ,		(select sum(d.nilai) from t_nilai_rapor_nilai as d where d.id_siswa = a.id_siswa and d.kd_tahun_ajaran = a.kd_tahun_ajaran - 1) as nilai"
			+" from		t_siswa_tingkat_thn		as a"
			+" ,		r_tingkat_kelas			as b"
			+" ,		t_siswa					as c"
			+" where	a.kd_tingkat_kelas	= b.kd_tingkat_kelas"
			+" and		a.id_siswa			= c.id_siswa"
			+" and		a.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" and		a.kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
			+" and		a.kd_tingkat_kelas	is not null"
			+" and		a.id_siswa			in (select id_siswa from t_siswa_tingkat)"
			+" order by	nilai desc";
	
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
				+ ",'"+ rs.getString("kd_tingkat_kelas") + "'"
				+ ",'"+ rs.getString("kd_rombel") +"'"
				+ ","+ rs.getString("id_siswa")
				+ ",'"+ rs.getString("nm_tingkat_kelas") +"'"
				+ ",'"+ rs.getString("nis") +"'"
				+ ",\""+ rs.getString("nm_siswa") +"\""
				+ ",'"+ rs.getString("kd_status_siswa") + "'"
				+ ","+ rs.getString("nilai")
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
