/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_akademik_tutup_tahun_pelajaran;
var m_akademik_tutup_tahun_pelajaran_d = _g_root +'/module/akademik_tutup_tahun_pelajaran/';

function M_AkademikTutupTahunPelajaran(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'saldo_awal' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_akademik_tutup_tahun_pelajaran_d +'data.jsp'
		,	autoLoad	: false
	});

	this.form_saldo_awal = new Ext.ux.NumericField({
			allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Saldo Awal'
			, dataIndex		: 'saldo_awal'
			, sortable		: true
			, editor		: this.form_saldo_awal
			, editable		: false
			, align			: 'right'
			, width			: 300
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_process = new Ext.Button({
			text	: '<b>Tutup Tahun Pelajaran</b>'
		,	iconCls	: 'dirup16'
		,	scope	: this
		,	handler	: function() {
				this.do_process();
			}
	});

	this.tbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.bbar = new Ext.Toolbar({
		items	: [
			this.btn_process
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id					: 'akademik_tutup_tahun_pelajaran_panel'
		,	title				: this.title
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.tbar
		,	bbar				: this.bbar
	});

	this.do_process = function()
	{
		Ext.MessageBox.confirm('Konfirmasi', 'Tutup Tahun Pelajaran?', function(btn, text){
			if (btn == 'ok'){
				this.dml_type = 5;
				Ext.Ajax.request({
						params  : {
								saldo_awal	: this.form_saldo_awal.getValue()
							,	dml_type	: this.dml_type
						}
					,	url		: m_akademik_tutup_tahun_pelajaran_d +'submit.jsp'
					,	waitMsg	: 'Mohon Tunggu ...'
					,	success :
							function (response)
							{
								var msg = Ext.util.JSON.decode(response.responseText);

								if (msg.success == false) {
									Ext.MessageBox.alert('Pesan', msg.info);
								}

								this.do_load();
							}
					,	scope	: this
				});
			}
		});
	}

	this.do_check = function()
	{
		Ext.Ajax.request({
			url		: m_akademik_tutup_tahun_pelajaran_d +'data_saldo_awal.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					return;
				}

				if (msg.jumlah > 0 || msg.kd_periode_belajar != '2'){
					this.btn_process.setDisabled(true);
				} else {
					this.btn_process.setDisabled(false);
				}
			}
		,	scope	: this
		});
	}
	
	this.do_load = function()
	{
		this.store.load();

		this.do_check();
		
		if (this.store.getTotalCount() < 1){
			this.btn_process.setDisabled(true);
		} else {
			this.btn_process.setDisabled(false);
		}
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (this.ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (this.ha_level > 1) {
			this.btn_process.setDisabled(false);
		} else {
			this.btn_process.setDisabled(true);
		}

		this.do_load();
	}
}

m_akademik_tutup_tahun_pelajaran = new M_AkademikTutupTahunPelajaran('Tutup Tahun Pelajaran');

//@ sourceURL=m_akademik_tutup_tahun_pelajaran.layout.js
