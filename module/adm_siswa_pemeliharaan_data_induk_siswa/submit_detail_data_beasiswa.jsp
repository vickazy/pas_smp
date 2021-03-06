<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "java.io.File" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String 		kd_tahun_ajaran			= (String) session.getAttribute("kd.tahun_pelajaran");
	
	int	dml 							= Integer.parseInt(request.getParameter("dml_type"));
	String id_siswa						= request.getParameter("id_siswa");
	String kd_beasiswa					= request.getParameter("kd_beasiswa");
	String kd_beasiswa_old				= request.getParameter("kd_beasiswa_old");
	String tahun_masuk					= request.getParameter("tahun_masuk");
	String tahun_masuk_old				= request.getParameter("tahun_masuk_old");
	String jumlah_beasiswa_per_bulan	= request.getParameter("jumlah_beasiswa_per_bulan");
	String keterangan					= request.getParameter("keterangan");
	String username						= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	="  insert into t_siswa_beasiswa"
			+"( id_siswa"
			+", kd_tahun_ajaran"
			+", kd_beasiswa"
			+", tahun_masuk"
			+", jumlah_beasiswa_per_bulan"
			+", keterangan"
			+", username)"
			+"  values("
			+"   "+ id_siswa
			+", '"+ kd_tahun_ajaran + "'"
			+", '"+ kd_beasiswa + "'"
			+",  "+ tahun_masuk
			+",  "+ jumlah_beasiswa_per_bulan
			+", '"+ keterangan + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_siswa_beasiswa"
			+" set		kd_beasiswa					= '"+ kd_beasiswa + "'"
			+" ,		tahun_masuk					=  "+ tahun_masuk
			+" ,		jumlah_beasiswa_per_bulan	=  "+ jumlah_beasiswa_per_bulan
			+" ,		keterangan					= '"+ keterangan + "'"
			+" ,		username					= '"+ username +"'"
			+" where	id_siswa					=  "+ id_siswa
			+" and		kd_tahun_ajaran				= '"+ kd_tahun_ajaran + "'"
			+" and		kd_beasiswa					=  "+ kd_beasiswa_old
			+" and		tahun_masuk					=  "+ tahun_masuk_old;
		break;
	case 4:
		q 	= " delete	from t_siswa_beasiswa"
			+ " where	id_siswa			=  "+ id_siswa
			+ " and		kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_beasiswa			=  "+ kd_beasiswa
			+ " and		tahun_masuk			=  "+ tahun_masuk;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (SQLException e){
	Properties	props	= new Properties();
	
	props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"error.properties")));
	
	String		err_msg = props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = Kesalahan operasi, silahkan hubungi direktorat.'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + err_msg + "'}");
	}
}
%>
