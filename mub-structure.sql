-- Adminer 4.8.1 MySQL 5.5.5-10.8.3-MariaDB dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT 0,
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `jns_akun`;
CREATE TABLE `jns_akun` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kd_aktiva` varchar(5) DEFAULT NULL,
  `jns_trans` varchar(50) NOT NULL,
  `akun` enum('Aktiva','Pasiva') DEFAULT NULL,
  `laba_rugi` enum('','PENDAPATAN','BIAYA') NOT NULL DEFAULT '',
  `pemasukan` enum('Y','N') DEFAULT NULL,
  `pengeluaran` enum('Y','N') DEFAULT NULL,
  `aktif` enum('Y','N') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `kd_aktiva` (`kd_aktiva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `jns_angsuran`;
CREATE TABLE `jns_angsuran` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ket` int(11) NOT NULL,
  `aktif` enum('Y','T','','') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `jns_simpan`;
CREATE TABLE `jns_simpan` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `jns_simpan` varchar(30) NOT NULL,
  `jumlah` double NOT NULL,
  `tampil` enum('Y','T') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `nama_kas_tbl`;
CREATE TABLE `nama_kas_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nama` varchar(225) CHARACTER SET latin1 NOT NULL,
  `aktif` enum('Y','T') CHARACTER SET latin1 NOT NULL,
  `tmpl_simpan` enum('Y','T') CHARACTER SET latin1 NOT NULL,
  `tmpl_penarikan` enum('Y','T') CHARACTER SET latin1 NOT NULL,
  `tmpl_pinjaman` enum('Y','T') CHARACTER SET latin1 NOT NULL,
  `tmpl_bayar` enum('Y','T') CHARACTER SET latin1 NOT NULL,
  `tmpl_pemasukan` enum('Y','T') NOT NULL,
  `tmpl_pengeluaran` enum('Y','T') NOT NULL,
  `tmpl_transfer` enum('Y','T') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `pekerjaan`;
CREATE TABLE `pekerjaan` (
  `id_kerja` varchar(5) NOT NULL,
  `jenis_kerja` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `suku_bunga`;
CREATE TABLE `suku_bunga` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `opsi_key` varchar(20) NOT NULL,
  `opsi_val` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `tbl_anggota`;
CREATE TABLE `tbl_anggota` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) CHARACTER SET latin1 NOT NULL,
  `identitas` varchar(255) NOT NULL,
  `jk` enum('L','P') NOT NULL,
  `tmp_lahir` varchar(225) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `status` varchar(30) NOT NULL,
  `agama` varchar(30) NOT NULL,
  `departement` varchar(255) NOT NULL,
  `pekerjaan` varchar(30) NOT NULL,
  `alamat` text CHARACTER SET latin1 NOT NULL,
  `kota` varchar(255) NOT NULL,
  `notelp` varchar(12) NOT NULL,
  `tgl_daftar` date NOT NULL,
  `jabatan_id` int(10) NOT NULL,
  `aktif` enum('Y','N') NOT NULL,
  `pass_word` varchar(225) NOT NULL,
  `file_pic` varchar(225) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identitas` (`identitas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `tbl_barang`;
CREATE TABLE `tbl_barang` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nm_barang` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `merk` varchar(50) NOT NULL,
  `harga` double NOT NULL,
  `jml_brg` int(11) NOT NULL,
  `ket` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tbl_pengajuan`;
CREATE TABLE `tbl_pengajuan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `no_ajuan` int(11) NOT NULL,
  `ajuan_id` varchar(255) NOT NULL,
  `anggota_id` bigint(20) NOT NULL,
  `tgl_input` datetime NOT NULL,
  `jenis` varchar(255) NOT NULL,
  `nominal` bigint(20) NOT NULL,
  `lama_ags` int(11) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `alasan` varchar(255) DEFAULT NULL,
  `tgl_cair` date DEFAULT NULL,
  `tgl_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`anggota_id`),
  CONSTRAINT `tbl_pengajuan_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `tbl_anggota` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `tbl_pinjaman_d`;
CREATE TABLE `tbl_pinjaman_d` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tgl_bayar` datetime NOT NULL,
  `pinjam_id` bigint(20) NOT NULL,
  `angsuran_ke` bigint(20) NOT NULL,
  `jumlah_bayar` int(11) NOT NULL,
  `denda_rp` int(11) DEFAULT NULL,
  `terlambat` int(11) DEFAULT NULL,
  `ket_bayar` enum('Angsuran','Pelunasan','Bayar Denda') NOT NULL,
  `dk` enum('D','K') NOT NULL,
  `kas_id` bigint(20) NOT NULL,
  `jns_trans` bigint(20) NOT NULL,
  `update_data` datetime DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `kas_id` (`kas_id`),
  KEY `user_name` (`user_name`),
  KEY `pinjam_id` (`pinjam_id`),
  KEY `jns_trans` (`jns_trans`),
  CONSTRAINT `tbl_pinjaman_d_ibfk_1` FOREIGN KEY (`pinjam_id`) REFERENCES `tbl_pinjaman_h` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_pinjaman_d_ibfk_2` FOREIGN KEY (`kas_id`) REFERENCES `nama_kas_tbl` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_pinjaman_d_ibfk_3` FOREIGN KEY (`user_name`) REFERENCES `tbl_user` (`u_name`) ON DELETE CASCADE,
  CONSTRAINT `tbl_pinjaman_d_ibfk_4` FOREIGN KEY (`jns_trans`) REFERENCES `jns_akun` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `tbl_pinjaman_h`;
CREATE TABLE `tbl_pinjaman_h` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tgl_pinjam` datetime NOT NULL,
  `anggota_id` bigint(20) NOT NULL,
  `barang_id` bigint(20) DEFAULT NULL,
  `lama_angsuran` bigint(20) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `bunga` float(10,2) NOT NULL,
  `biaya_adm` int(11) NOT NULL,
  `lunas` enum('Belum','Lunas') NOT NULL,
  `dk` enum('D','K') NOT NULL,
  `kas_id` bigint(20) NOT NULL,
  `jns_trans` bigint(20) NOT NULL,
  `update_data` datetime DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `contoh` int(23) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `anggota_id` (`anggota_id`),
  KEY `kas_id` (`kas_id`),
  KEY `user_name` (`user_name`),
  KEY `jns_trans` (`jns_trans`),
  KEY `barang_id` (`barang_id`),
  CONSTRAINT `tbl_pinjaman_h_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `tbl_anggota` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_pinjaman_h_ibfk_2` FOREIGN KEY (`kas_id`) REFERENCES `nama_kas_tbl` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_pinjaman_h_ibfk_3` FOREIGN KEY (`user_name`) REFERENCES `tbl_user` (`u_name`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_pinjaman_h_ibfk_4` FOREIGN KEY (`jns_trans`) REFERENCES `jns_akun` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_pinjaman_h_ibfk_5` FOREIGN KEY (`barang_id`) REFERENCES `tbl_barang` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `tbl_setting`;
CREATE TABLE `tbl_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opsi_key` varchar(255) NOT NULL,
  `opsi_val` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `tbl_trans_kas`;
CREATE TABLE `tbl_trans_kas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tgl_catat` datetime NOT NULL,
  `jumlah` double NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `akun` enum('Pemasukan','Pengeluaran','Transfer') NOT NULL,
  `dari_kas_id` bigint(20) DEFAULT NULL,
  `untuk_kas_id` bigint(20) DEFAULT NULL,
  `jns_trans` bigint(20) DEFAULT NULL,
  `dk` enum('D','K') DEFAULT NULL,
  `update_data` datetime DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_name` (`user_name`),
  KEY `dari_kas_id` (`dari_kas_id`,`untuk_kas_id`),
  KEY `untuk_kas_id` (`untuk_kas_id`),
  KEY `jns_trans` (`jns_trans`),
  CONSTRAINT `tbl_trans_kas_ibfk_2` FOREIGN KEY (`user_name`) REFERENCES `tbl_user` (`u_name`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_trans_kas_ibfk_3` FOREIGN KEY (`dari_kas_id`) REFERENCES `nama_kas_tbl` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_trans_kas_ibfk_4` FOREIGN KEY (`untuk_kas_id`) REFERENCES `nama_kas_tbl` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_trans_kas_ibfk_5` FOREIGN KEY (`jns_trans`) REFERENCES `jns_akun` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `tbl_trans_sp`;
CREATE TABLE `tbl_trans_sp` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tgl_transaksi` datetime NOT NULL,
  `anggota_id` bigint(20) NOT NULL,
  `jenis_id` int(5) NOT NULL,
  `jumlah` double NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `akun` enum('Setoran','Penarikan') NOT NULL,
  `dk` enum('D','K') NOT NULL,
  `kas_id` bigint(20) NOT NULL,
  `update_data` datetime DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  `nama_penyetor` varchar(255) NOT NULL,
  `no_identitas` varchar(20) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `anggota_id` (`anggota_id`),
  KEY `jenis_id` (`jenis_id`),
  KEY `kas_id` (`kas_id`),
  KEY `user_name` (`user_name`),
  CONSTRAINT `tbl_trans_sp_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `tbl_anggota` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_trans_sp_ibfk_2` FOREIGN KEY (`kas_id`) REFERENCES `nama_kas_tbl` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_trans_sp_ibfk_4` FOREIGN KEY (`jenis_id`) REFERENCES `jns_simpan` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_trans_sp_ibfk_5` FOREIGN KEY (`user_name`) REFERENCES `tbl_user` (`u_name`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `u_name` varchar(255) NOT NULL,
  `pass_word` varchar(255) NOT NULL,
  `aktif` enum('Y','N') NOT NULL,
  `level` enum('admin','operator','pinjaman') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_name` (`u_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP VIEW IF EXISTS `v_hitung_pinjaman`;
CREATE TABLE `v_hitung_pinjaman` (`id` bigint(20), `tgl_pinjam` datetime, `anggota_id` bigint(20), `lama_angsuran` bigint(20), `jumlah` int(11), `bunga` float(10,2), `biaya_adm` int(11), `lunas` enum('Belum','Lunas'), `dk` enum('D','K'), `kas_id` bigint(20), `user_name` varchar(255), `pokok_angsuran` decimal(14,4), `bunga_pinjaman` double(17,0), `ags_per_bulan` double(17,0), `tempo` datetime /* mariadb-5.3 */, `tagihan` double(17,0), `keterangan` varchar(255), `barang_id` bigint(20), `bln_sudah_angsur` bigint(20));


DROP VIEW IF EXISTS `v_transaksi`;
CREATE TABLE `v_transaksi` (`tbl` varchar(1), `id` bigint(20), `tgl` datetime /* mariadb-5.3 */, `kredit` double, `debet` double, `dari_kas` bigint(20), `untuk_kas` bigint(20), `transaksi` bigint(20), `ket` varchar(255), `user` varchar(255));


DROP TABLE IF EXISTS `v_hitung_pinjaman`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_hitung_pinjaman` AS select `tbl_pinjaman_h`.`id` AS `id`,`tbl_pinjaman_h`.`tgl_pinjam` AS `tgl_pinjam`,`tbl_pinjaman_h`.`anggota_id` AS `anggota_id`,`tbl_pinjaman_h`.`lama_angsuran` AS `lama_angsuran`,`tbl_pinjaman_h`.`jumlah` AS `jumlah`,`tbl_pinjaman_h`.`bunga` AS `bunga`,`tbl_pinjaman_h`.`biaya_adm` AS `biaya_adm`,`tbl_pinjaman_h`.`lunas` AS `lunas`,`tbl_pinjaman_h`.`dk` AS `dk`,`tbl_pinjaman_h`.`kas_id` AS `kas_id`,`tbl_pinjaman_h`.`user_name` AS `user_name`,`tbl_pinjaman_h`.`jumlah` / `tbl_pinjaman_h`.`lama_angsuran` AS `pokok_angsuran`,round(ceiling(`tbl_pinjaman_h`.`jumlah` / `tbl_pinjaman_h`.`lama_angsuran` * `tbl_pinjaman_h`.`bunga` / 100),-2) AS `bunga_pinjaman`,round(ceiling((`tbl_pinjaman_h`.`jumlah` / `tbl_pinjaman_h`.`lama_angsuran` * `tbl_pinjaman_h`.`bunga` / 100 + `tbl_pinjaman_h`.`jumlah` / `tbl_pinjaman_h`.`lama_angsuran` + `tbl_pinjaman_h`.`biaya_adm`) * 100 / 100),-2) AS `ags_per_bulan`,`tbl_pinjaman_h`.`tgl_pinjam` + interval `tbl_pinjaman_h`.`lama_angsuran` month AS `tempo`,round(ceiling((`tbl_pinjaman_h`.`jumlah` / `tbl_pinjaman_h`.`lama_angsuran` * `tbl_pinjaman_h`.`bunga` / 100 + `tbl_pinjaman_h`.`jumlah` / `tbl_pinjaman_h`.`lama_angsuran` + `tbl_pinjaman_h`.`biaya_adm`) * 100 / 100),-2) * `tbl_pinjaman_h`.`lama_angsuran` AS `tagihan`,`tbl_pinjaman_h`.`keterangan` AS `keterangan`,`tbl_pinjaman_h`.`barang_id` AS `barang_id`,ifnull(max(`tbl_pinjaman_d`.`angsuran_ke`),0) AS `bln_sudah_angsur` from (`tbl_pinjaman_h` left join `tbl_pinjaman_d` on(`tbl_pinjaman_h`.`id` = `tbl_pinjaman_d`.`pinjam_id`)) group by `tbl_pinjaman_h`.`id`;

DROP TABLE IF EXISTS `v_transaksi`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_transaksi` AS select 'A' AS `tbl`,`tbl_pinjaman_h`.`id` AS `id`,`tbl_pinjaman_h`.`tgl_pinjam` AS `tgl`,`tbl_pinjaman_h`.`jumlah` AS `kredit`,0 AS `debet`,`tbl_pinjaman_h`.`kas_id` AS `dari_kas`,NULL AS `untuk_kas`,`tbl_pinjaman_h`.`jns_trans` AS `transaksi`,`tbl_pinjaman_h`.`keterangan` AS `ket`,`tbl_pinjaman_h`.`user_name` AS `user` from `tbl_pinjaman_h` union select 'B' AS `tbl`,`tbl_pinjaman_d`.`id` AS `id`,`tbl_pinjaman_d`.`tgl_bayar` AS `tgl`,0 AS `kredit`,`tbl_pinjaman_d`.`jumlah_bayar` AS `debet`,NULL AS `dari_kas`,`tbl_pinjaman_d`.`kas_id` AS `untuk_kas`,`tbl_pinjaman_d`.`jns_trans` AS `transaksi`,`tbl_pinjaman_d`.`keterangan` AS `ket`,`tbl_pinjaman_d`.`user_name` AS `user` from `tbl_pinjaman_d` union select 'C' AS `tbl`,`tbl_trans_sp`.`id` AS `id`,`tbl_trans_sp`.`tgl_transaksi` AS `tgl`,if(`tbl_trans_sp`.`dk` = 'K',`tbl_trans_sp`.`jumlah`,0) AS `kredit`,if(`tbl_trans_sp`.`dk` = 'D',`tbl_trans_sp`.`jumlah`,0) AS `debet`,if(`tbl_trans_sp`.`dk` = 'K',`tbl_trans_sp`.`kas_id`,NULL) AS `dari_kas`,if(`tbl_trans_sp`.`dk` = 'D',`tbl_trans_sp`.`kas_id`,NULL) AS `untuk_kas`,`tbl_trans_sp`.`jenis_id` AS `transaksi`,`tbl_trans_sp`.`keterangan` AS `ket`,`tbl_trans_sp`.`user_name` AS `user` from `tbl_trans_sp` union select 'D' AS `tbl`,`tbl_trans_kas`.`id` AS `id`,`tbl_trans_kas`.`tgl_catat` AS `tgl`,if(`tbl_trans_kas`.`dk` = 'K',`tbl_trans_kas`.`jumlah`,if(`tbl_trans_kas`.`dk` is null,`tbl_trans_kas`.`jumlah`,0)) AS `kredit`,if(`tbl_trans_kas`.`dk` = 'D',`tbl_trans_kas`.`jumlah`,if(`tbl_trans_kas`.`dk` is null,`tbl_trans_kas`.`jumlah`,0)) AS `debet`,`tbl_trans_kas`.`dari_kas_id` AS `dari_kas`,`tbl_trans_kas`.`untuk_kas_id` AS `untuk_kas`,`tbl_trans_kas`.`jns_trans` AS `transaksi`,`tbl_trans_kas`.`keterangan` AS `ket`,`tbl_trans_kas`.`user_name` AS `user` from `tbl_trans_kas` order by `tgl`;

-- 2023-04-05 08:08:02
