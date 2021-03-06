<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String	kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
String	npsn				= request.getParameter("npsn");
String	id_propinsi			= request.getParameter("id_propinsi");
String	id_kabupaten		= request.getParameter("id_kabupaten");
String	id_kecamatan		= request.getParameter("id_kecamatan");

String 	q	= "";
int		iLf	= 10;
char	cLf	= (char)iLf;

File		outputFile	= new File("C:\\08 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_PEGAWAI_03.XML");
outputFile.createNewFile();
FileWriter	outFile		= new FileWriter(outputFile);

outFile.write("<?xml version='1.0' encoding='UTF-8'?>" + cLf);
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	
	q	=" SELECT	KD_TAHUN_AJARAN"
		+" ,		ID_PROPINSI"
		+" ,		ID_KABUPATEN"
		+" ,		ID_KECAMATAN"
		+" ,		NPSN"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR < 20"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR < 20"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR >= 20"
		+" 								AND	v_pegawai_detil.UMUR < 30"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR >= 20"
		+" 								AND	v_pegawai_detil.UMUR < 30"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR >= 30"
		+" 								AND	v_pegawai_detil.UMUR < 40"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_03_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR >= 30"
		+" 								AND	v_pegawai_detil.UMUR < 40"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_03_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR >= 40"
		+" 								AND	v_pegawai_detil.UMUR < 50"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_04_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR >= 40"
		+" 								AND	v_pegawai_detil.UMUR < 50"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_04_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR >= 50"
		+" 								AND	v_pegawai_detil.UMUR < 60"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_05_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR >= 50"
		+" 								AND	v_pegawai_detil.UMUR < 60"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_05_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR >= 60"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil		ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_06_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.UMUR >= 60"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_UMR_06_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 5"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 5"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 5"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 10"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 5"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 10"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 10"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 15"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_03_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 10"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 15"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_03_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 15"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 20"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_04_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 15"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 20"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_04_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 20"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 25"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_05_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 20"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 25"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_05_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 25"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_06_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('01','02','03','10','11','12','25')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 25"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_detil 	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GTP_MSK_06_P"
		+" FROM	t_sekolah_identitas"
		+" WHERE	KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'";
	
	ResultSet	rs	= db_stmt.executeQuery(q);

	outFile.write("<DATA>" + cLf);
	
	while (rs.next()){
		outFile.write("<DATA_ROW>" + cLf);
		outFile.write("<KD_TAHUN_AJARAN>" + rs.getString("KD_TAHUN_AJARAN") + "</KD_TAHUN_AJARAN>" + cLf);
		outFile.write("<ID_PROPINSI>" + rs.getString("ID_PROPINSI") + "</ID_PROPINSI>" + cLf);
		outFile.write("<ID_KABUPATEN>" + rs.getString("ID_KABUPATEN") + "</ID_KABUPATEN>" + cLf);
		outFile.write("<ID_KECAMATAN>" + rs.getString("ID_KECAMATAN") + "</ID_KECAMATAN>" + cLf);
		outFile.write("<NPSN>" + rs.getString("NPSN") + "</NPSN>" + cLf);
		outFile.write("<GTP_UMR_01_L>" + rs.getString("GTP_UMR_01_L") + "</GTP_UMR_01_L>" + cLf);
		outFile.write("<GTP_UMR_01_P>" + rs.getString("GTP_UMR_01_P") + "</GTP_UMR_01_P>" + cLf);
		outFile.write("<GTP_UMR_02_L>" + rs.getString("GTP_UMR_02_L") + "</GTP_UMR_02_L>" + cLf);
		outFile.write("<GTP_UMR_02_P>" + rs.getString("GTP_UMR_02_P") + "</GTP_UMR_02_P>" + cLf);
		outFile.write("<GTP_UMR_03_L>" + rs.getString("GTP_UMR_03_L") + "</GTP_UMR_03_L>" + cLf);
		outFile.write("<GTP_UMR_03_P>" + rs.getString("GTP_UMR_03_P") + "</GTP_UMR_03_P>" + cLf);
		outFile.write("<GTP_UMR_04_L>" + rs.getString("GTP_UMR_04_L") + "</GTP_UMR_04_L>" + cLf);
		outFile.write("<GTP_UMR_04_P>" + rs.getString("GTP_UMR_04_P") + "</GTP_UMR_04_P>" + cLf);
		outFile.write("<GTP_UMR_05_L>" + rs.getString("GTP_UMR_05_L") + "</GTP_UMR_05_L>" + cLf);
		outFile.write("<GTP_UMR_05_P>" + rs.getString("GTP_UMR_05_P") + "</GTP_UMR_05_P>" + cLf);
		outFile.write("<GTP_UMR_06_L>" + rs.getString("GTP_UMR_06_L") + "</GTP_UMR_06_L>" + cLf);
		outFile.write("<GTP_UMR_06_P>" + rs.getString("GTP_UMR_06_P") + "</GTP_UMR_06_P>" + cLf);
		outFile.write("<GTP_MSK_01_L>" + rs.getString("GTP_MSK_01_L") + "</GTP_MSK_01_L>" + cLf);
		outFile.write("<GTP_MSK_01_P>" + rs.getString("GTP_MSK_01_P") + "</GTP_MSK_01_P>" + cLf);
		outFile.write("<GTP_MSK_02_L>" + rs.getString("GTP_MSK_02_L") + "</GTP_MSK_02_L>" + cLf);
		outFile.write("<GTP_MSK_02_P>" + rs.getString("GTP_MSK_02_P") + "</GTP_MSK_02_P>" + cLf);
		outFile.write("<GTP_MSK_03_L>" + rs.getString("GTP_MSK_03_L") + "</GTP_MSK_03_L>" + cLf);
		outFile.write("<GTP_MSK_03_P>" + rs.getString("GTP_MSK_03_P") + "</GTP_MSK_03_P>" + cLf);
		outFile.write("<GTP_MSK_04_L>" + rs.getString("GTP_MSK_04_L") + "</GTP_MSK_04_L>" + cLf);
		outFile.write("<GTP_MSK_04_P>" + rs.getString("GTP_MSK_04_P") + "</GTP_MSK_04_P>" + cLf);
		outFile.write("<GTP_MSK_05_L>" + rs.getString("GTP_MSK_05_L") + "</GTP_MSK_05_L>" + cLf);
		outFile.write("<GTP_MSK_05_P>" + rs.getString("GTP_MSK_05_P") + "</GTP_MSK_05_P>" + cLf);
		outFile.write("<GTP_MSK_06_L>" + rs.getString("GTP_MSK_06_L") + "</GTP_MSK_06_L>" + cLf);
		outFile.write("<GTP_MSK_06_P>" + rs.getString("GTP_MSK_06_P") + "</GTP_MSK_06_P>" + cLf);
		outFile.write("</DATA_ROW>" + cLf);
	}	
	
	outFile.write("</DATA>" + cLf);
	
	rs.close();
	outFile.close();
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
	outFile.close();
}
%>
