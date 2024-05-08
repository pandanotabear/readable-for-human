-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 192.168.0.120
-- Waktu pembuatan: 08 Bulan Mei 2024 pada 00.47
-- Versi server: 8.0.36-0ubuntu0.22.04.1
-- Versi PHP: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kalimosodo_app`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `antrian_pelanggan`
--

CREATE TABLE `antrian_pelanggan` (
  `antrian_id` int NOT NULL,
  `id` varchar(225) NOT NULL,
  `hold` tinyint(1) NOT NULL,
  `gudang_id` int NOT NULL,
  `user_id` int NOT NULL,
  `nama_pelanggan` varchar(225) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `antrian_pesanan`
--

CREATE TABLE `antrian_pesanan` (
  `antrian_pesanan_id` int NOT NULL,
  `walk_in_customer` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `nama_antrian` varchar(225) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `api_access`
--

CREATE TABLE `api_access` (
  `api_id` int NOT NULL,
  `api_key` varchar(225) NOT NULL,
  `domain_lists` text NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `app_config`
--

CREATE TABLE `app_config` (
  `id` int NOT NULL,
  `config_name` varchar(225) NOT NULL,
  `config_value` text,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `produk_id` int NOT NULL,
  `barang_id` int NOT NULL,
  `satuan_beli_local` int DEFAULT NULL,
  `harga_jual_level_1` double DEFAULT NULL,
  `satuan_jual_level_1` int DEFAULT NULL,
  `isi_jual_level_1` int DEFAULT NULL,
  `harga_jual_level_2` double DEFAULT NULL,
  `satuan_jual_level_2` int DEFAULT NULL,
  `isi_jual_level_2` int DEFAULT NULL,
  `harga_jual_level_3` double DEFAULT NULL,
  `satuan_jual_level_3` int DEFAULT NULL,
  `isi_jual_level_3` int DEFAULT NULL,
  `harga_jual_level_4` double DEFAULT NULL,
  `satuan_jual_level_4` int DEFAULT NULL,
  `isi_jual_level_4` int DEFAULT NULL,
  `jumlah_stok` varchar(225) NOT NULL DEFAULT '0 Unknown',
  `stok_sekarang` int NOT NULL DEFAULT '0' COMMENT 'dalam Pcs',
  `minimal_stok_limit` int NOT NULL DEFAULT '1',
  `gudang_id` int NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_harga`
--

CREATE TABLE `barang_harga` (
  `barang_harga_id` int NOT NULL,
  `nama_harga_baru` varchar(225) NOT NULL,
  `barang_id` int NOT NULL,
  `barang_harga_baru` double NOT NULL,
  `satuan_harga_baru` int NOT NULL,
  `isi_harga_baru` int NOT NULL,
  `tanggal_perubahan` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `barang_keluar_id` int NOT NULL,
  `user_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `produk_id` int NOT NULL,
  `jumlah_keluar` varchar(255) NOT NULL,
  `jumlah_pcs` int NOT NULL,
  `tanggal_keluar` date NOT NULL,
  `log` enum('kasir','transfer','surat_kirim','manual','order_cs') DEFAULT 'manual',
  `catatan` varchar(225) DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `barang_masuk_id` int NOT NULL,
  `produk_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `user_id` int NOT NULL,
  `jumlah_masuk` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `jumlah_pcs` int NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `catatan` text COLLATE utf8mb4_general_ci,
  `log` enum('batal_kirim','batal_transfer','pembelian','edit_manual') COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `biaya`
--

CREATE TABLE `biaya` (
  `biaya_id` int NOT NULL,
  `nama_biaya` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `jumlah_biaya` double NOT NULL,
  `unit_biaya` enum('percent','nominal') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'percent',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL,
  `gudang_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `customers`
--

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `profile_id` int NOT NULL,
  `customer_email` varchar(225) NOT NULL,
  `customer_username` varchar(225) NOT NULL,
  `customer_password` varchar(225) NOT NULL,
  `customer_uuid` varchar(225) NOT NULL,
  `customer_identity` varchar(100) DEFAULT NULL,
  `customer_token` varchar(225) DEFAULT NULL,
  `request_edit` tinyint NOT NULL DEFAULT '0',
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `depositories`
--

CREATE TABLE `depositories` (
  `depot_id` int NOT NULL,
  `depot_code` varchar(20) NOT NULL,
  `depot_name` varchar(225) NOT NULL,
  `depot_address` text NOT NULL,
  `depot_status` tinyint(1) NOT NULL DEFAULT '1',
  `force_key` varchar(4) DEFAULT NULL,
  `flag_colors` varchar(225) DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `diskon`
--

CREATE TABLE `diskon` (
  `diskon_id` int NOT NULL,
  `nama_diskon` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi_diskon` text COLLATE utf8mb4_general_ci NOT NULL,
  `jumlah_diskon` double NOT NULL,
  `unit_diskon` enum('percent','nominal') COLLATE utf8mb4_general_ci NOT NULL,
  `status_diskon` tinyint(1) NOT NULL DEFAULT '1',
  `periode_mulai` date DEFAULT NULL,
  `periode_akhir` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL,
  `gudang_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `flag_barang_baru`
--

CREATE TABLE `flag_barang_baru` (
  `flag_id` int NOT NULL,
  `initial_code` varchar(225) NOT NULL,
  `is_new` tinyint(1) NOT NULL DEFAULT '1',
  `gudang_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `font_icons`
--

CREATE TABLE `font_icons` (
  `id` int NOT NULL,
  `icon` varchar(225) NOT NULL,
  `unicode` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `histori_barang`
--

CREATE TABLE `histori_barang` (
  `histori_barang_id` int NOT NULL,
  `histori_barang_tipe` enum('ERROR','INFO','WARNING') NOT NULL,
  `histori_barang_detail` mediumtext NOT NULL,
  `histori_barang_waktu` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `histori_harga`
--

CREATE TABLE `histori_harga` (
  `histori_harga_id` int NOT NULL,
  `barang_id` int NOT NULL,
  `harga_beli` double DEFAULT NULL,
  `harga_jual_level_1` double DEFAULT NULL,
  `harga_jual_level_2` double DEFAULT NULL,
  `harga_jual_level_3` double DEFAULT NULL,
  `harga_jual_level_4` double DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `histori_pembayaran_hutang`
--

CREATE TABLE `histori_pembayaran_hutang` (
  `histori_pembayaran_hutang_id` int NOT NULL,
  `user_id` int NOT NULL,
  `transaksi_id` int NOT NULL,
  `jumlah_bayar` double NOT NULL,
  `sisa_hutang` double NOT NULL,
  `status_pembayaran` enum('Lunas','Belum Lunas') COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_pembayaran` date NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `internal_barcode`
--

CREATE TABLE `internal_barcode` (
  `internal_barcode_id` int NOT NULL,
  `barang_id` int NOT NULL,
  `internal_barcode` varchar(20) NOT NULL,
  `kode_harga` varchar(10) NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kas_kasir`
--

CREATE TABLE `kas_kasir` (
  `kas_id` int NOT NULL,
  `user_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `nama_kas` varchar(225) NOT NULL,
  `jumlah_uang` double NOT NULL,
  `jenis_kas` enum('keluar','masuk') NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `kategori_id` int NOT NULL,
  `kategori_nama` varchar(225) NOT NULL,
  `kategori_deskripsi` varchar(225) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `keranjang_belanja`
--

CREATE TABLE `keranjang_belanja` (
  `keranjang_belanja_id` int NOT NULL,
  `walk_in_customer` varchar(225) NOT NULL,
  `user_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `barang_id` int NOT NULL,
  `jumlah` int DEFAULT NULL,
  `satuan_jual_nama` varchar(225) NOT NULL,
  `sub_total` varchar(225) DEFAULT NULL,
  `jenis_harga` enum('harga_jual_level_1','harga_jual_level_2','harga_jual_level_3','harga_jual_level_4') DEFAULT NULL,
  `nego_harga_level_1` double DEFAULT NULL,
  `nego_harga_level_2` double DEFAULT NULL,
  `nego_harga_level_3` double DEFAULT NULL,
  `nego_harga_level_4` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `keys`
--

CREATE TABLE `keys` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `key` varchar(40) NOT NULL,
  `level` int NOT NULL,
  `ignore_limits` tinyint(1) NOT NULL DEFAULT '0',
  `is_private_key` tinyint(1) NOT NULL DEFAULT '0',
  `ip_addresses` text,
  `date_created` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktur dari tabel `logs`
--

CREATE TABLE `logs` (
  `id` int NOT NULL,
  `uri` varchar(255) NOT NULL,
  `method` varchar(6) NOT NULL,
  `params` text,
  `api_key` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `time` int NOT NULL,
  `rtime` float DEFAULT NULL,
  `authorized` varchar(1) NOT NULL,
  `response_code` smallint DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_activities`
--

CREATE TABLE `log_activities` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `gudang_id` int DEFAULT NULL,
  `ip_address` varchar(225) NOT NULL,
  `activity` varchar(225) NOT NULL,
  `login_time` datetime DEFAULT NULL,
  `logout_time` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `messages`
--

CREATE TABLE `messages` (
  `message_id` int NOT NULL,
  `message_response_id` varchar(225) NOT NULL,
  `contact_number` varchar(30) NOT NULL,
  `contact_name` varchar(225) NOT NULL,
  `from_device` varchar(20) NOT NULL,
  `message` text NOT NULL,
  `message_type` enum('inbox','outbox','draft') NOT NULL DEFAULT 'outbox',
  `status` enum('pending','queued','sent','failed') NOT NULL DEFAULT 'pending',
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pajak`
--

CREATE TABLE `pajak` (
  `pajak_id` int NOT NULL,
  `nama_pajak` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `jumlah_pajak` double NOT NULL,
  `unit_pajak` enum('percent','nominal') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'percent',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL,
  `gudang_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `paket_promo`
--

CREATE TABLE `paket_promo` (
  `paket_promo_id` int NOT NULL,
  `promo_id` int NOT NULL,
  `barang_id` int NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembelian`
--

CREATE TABLE `pembelian` (
  `pembelian_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `produk_id` int NOT NULL,
  `harga_beli` double NOT NULL,
  `total_beli` double NOT NULL,
  `tanggal_pembelian` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL,
  `metadata` longtext COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan`
--

CREATE TABLE `penjualan` (
  `penjualan_id` int NOT NULL,
  `user_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `no_transaksi` varchar(225) NOT NULL,
  `initial_code` varchar(20) NOT NULL,
  `barang_nama` varchar(225) NOT NULL,
  `jumlah` float NOT NULL,
  `sub_total` double NOT NULL,
  `jenis_harga` enum('harga_jual_level_1','harga_jual_level_2','harga_jual_level_3','harga_jual_level_4') NOT NULL,
  `nego_harga_level_1` double DEFAULT NULL,
  `nego_harga_level_2` double DEFAULT NULL,
  `nego_harga_level_3` double DEFAULT NULL,
  `nego_harga_level_4` double DEFAULT NULL,
  `tanggal_transaksi` date NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `presensi`
--

CREATE TABLE `presensi` (
  `presensi_id` int NOT NULL,
  `user_id` int NOT NULL,
  `status` enum('BERANGKAT','TIDAK_BERANGKAT') COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_presensi` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `printers`
--

CREATE TABLE `printers` (
  `printer_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  `computer_name` varchar(225) NOT NULL,
  `printer_nama` varchar(225) NOT NULL,
  `printer_node` varchar(225) DEFAULT NULL,
  `computer_node` varchar(225) NOT NULL,
  `printer_source` varchar(225) NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `produk`
--

CREATE TABLE `produk` (
  `produk_id` int NOT NULL,
  `kategori_id` int NOT NULL,
  `suplier_id` int NOT NULL,
  `gtin_14` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `initial_code` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `barang_nama` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `barang_kode` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `harga_beli` double NOT NULL,
  `satuan_beli` int NOT NULL,
  `isi_per_pcs` int NOT NULL,
  `hpp_per_pcs` double NOT NULL,
  `tanggal_expired` varchar(225) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `profiles`
--

CREATE TABLE `profiles` (
  `profile_id` int NOT NULL,
  `fullname` varchar(225) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `phone_alt` varchar(20) DEFAULT NULL,
  `address` text NOT NULL,
  `email_alt` varchar(225) DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `promo`
--

CREATE TABLE `promo` (
  `promo_id` int NOT NULL,
  `promo_nama` varchar(225) NOT NULL,
  `promo_paket_harga` varchar(225) NOT NULL,
  `promo_potongan_diskon` varchar(225) DEFAULT NULL,
  `promo_harga_final` varchar(225) NOT NULL,
  `promo_rule` varchar(225) DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `promosi`
--

CREATE TABLE `promosi` (
  `promo_id` int NOT NULL,
  `user_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `kode_promo` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `nama_promosi` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `periode_promosi` tinyint(1) NOT NULL DEFAULT '0',
  `jumlah_pembelian` int NOT NULL,
  `tipe_promosi` enum('barang','kategori','apapun') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'apapun',
  `opsi_tambahan` enum('status','dan','atau') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'status',
  `minimal_transaksi_pembelian` double NOT NULL,
  `tipe_benefit` enum('produk','diskon') COLLATE utf8mb4_general_ci NOT NULL,
  `ketentuan_hari` varchar(225) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ketentuan_jam` varchar(225) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `syarat_khusus` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `promosi_barang`
--

CREATE TABLE `promosi_barang` (
  `promosi_barang_id` int NOT NULL,
  `promosi_id` int NOT NULL,
  `barang_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `promosi_benefit_barang`
--

CREATE TABLE `promosi_benefit_barang` (
  `promosi_benefit_barang_id` int NOT NULL,
  `promosi_id` int NOT NULL,
  `barang_id` int NOT NULL,
  `jumlah_barang` int NOT NULL,
  `jumlah_humanable` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `promosi_benefit_diskon`
--

CREATE TABLE `promosi_benefit_diskon` (
  `promosi_benefit_diskon_id` int NOT NULL,
  `promosi_id` int NOT NULL,
  `jumlah_diskon_benefit` double NOT NULL,
  `unit_diskon_benefit` enum('percent','nominal') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'percent',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `promosi_kategori`
--

CREATE TABLE `promosi_kategori` (
  `promosi_kategori` int NOT NULL,
  `promosi_id` int NOT NULL,
  `kategori_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `promosi_periode`
--

CREATE TABLE `promosi_periode` (
  `promosi_periode_id` int NOT NULL,
  `promosi_id` int NOT NULL,
  `periode_mulai` date NOT NULL,
  `periode_akhir` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `riteldb`
--

CREATE TABLE `riteldb` (
  `id` int NOT NULL,
  `type` varchar(100) NOT NULL,
  `gtin_14` varchar(100) NOT NULL,
  `barcode` double NOT NULL,
  `nama_barang` varchar(225) NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `role_key` varchar(225) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `stok_opname`
--

CREATE TABLE `stok_opname` (
  `so_id` int NOT NULL,
  `produk_id` int NOT NULL,
  `so_stok_komputer` int NOT NULL,
  `so_satuan_stok_komputer` varchar(225) NOT NULL,
  `so_stok_fisik` int NOT NULL,
  `so_satuan_stok_fisik` varchar(225) NOT NULL,
  `so_selisih_barang` int NOT NULL,
  `so_satuan_selisih_barang` varchar(225) NOT NULL,
  `so_selisih_modal` double NOT NULL,
  `so_tanggal` date NOT NULL,
  `so_user_id` int NOT NULL,
  `so_gudang_id` int NOT NULL,
  `so_keterangan` varchar(225) NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `supir`
--

CREATE TABLE `supir` (
  `supir_id` int NOT NULL,
  `nama_supir` varchar(225) NOT NULL,
  `telepon_supir` varchar(25) NOT NULL,
  `alamat_supir` text NOT NULL,
  `kota_supir` varchar(100) NOT NULL,
  `is_active` enum('Aktif','Tidak') NOT NULL DEFAULT 'Aktif',
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `supliers`
--

CREATE TABLE `supliers` (
  `suplier_id` int NOT NULL,
  `suplier_code` varchar(100) NOT NULL,
  `suplier_name` varchar(225) NOT NULL,
  `suplier_phone` varchar(20) NOT NULL,
  `suplier_phone_alt` varchar(20) NOT NULL,
  `suplier_address` text NOT NULL,
  `suplier_status` tinyint(1) DEFAULT '1',
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `surat`
--

CREATE TABLE `surat` (
  `surat_id` int NOT NULL,
  `user_id` int NOT NULL,
  `transportasi_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `nomor_surat` varchar(225) NOT NULL,
  `pengirim` int NOT NULL,
  `penerima` int NOT NULL,
  `tanggal_kirim` date NOT NULL,
  `tempo_bayar` date NOT NULL,
  `is_price_display` tinyint(1) NOT NULL DEFAULT '0',
  `status_pengiriman` tinyint(1) DEFAULT '0',
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `surat_detail`
--

CREATE TABLE `surat_detail` (
  `surat_detail_id` int NOT NULL,
  `surat_id` int NOT NULL,
  `nomor_surat` varchar(225) NOT NULL,
  `barang_id` int NOT NULL,
  `jumlah_kirim` int NOT NULL,
  `harga` double NOT NULL,
  `nego_metadata` text,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `surat_transaksi`
--

CREATE TABLE `surat_transaksi` (
  `surat_transaksi_id` int NOT NULL,
  `surat_id` int DEFAULT NULL,
  `no_transaksi` varchar(225) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tempat_pembuangan_akhir`
--

CREATE TABLE `tempat_pembuangan_akhir` (
  `tpa_id` int NOT NULL,
  `tanggal_expired` date NOT NULL,
  `nama_sampah` varchar(225) NOT NULL,
  `jumlah` int NOT NULL,
  `kategori_id` int NOT NULL,
  `is_confirm` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `temp_barang`
--

CREATE TABLE `temp_barang` (
  `barang_id` int NOT NULL,
  `produk_id` int NOT NULL,
  `harga_jual_level_1` double DEFAULT '0',
  `satuan_jual_level_1` int DEFAULT NULL,
  `isi_jual_level_1` int DEFAULT NULL,
  `harga_jual_level_2` double DEFAULT '0',
  `satuan_jual_level_2` int DEFAULT NULL,
  `isi_jual_level_2` int DEFAULT NULL,
  `harga_jual_level_3` double DEFAULT '0',
  `satuan_jual_level_3` int DEFAULT NULL,
  `isi_jual_level_3` int DEFAULT NULL,
  `harga_jual_level_4` double DEFAULT '0',
  `satuan_jual_level_4` int DEFAULT NULL,
  `isi_jual_level_4` int DEFAULT NULL,
  `jumlah_stok` varchar(225) NOT NULL DEFAULT '0 Unknown',
  `stok_sekarang` int NOT NULL DEFAULT '0' COMMENT 'dalam Pcs',
  `minimal_stok_limit` int NOT NULL DEFAULT '1',
  `gudang_id` int NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `temp_produk`
--

CREATE TABLE `temp_produk` (
  `produk_id` int NOT NULL,
  `kategori_id` int NOT NULL,
  `suplier_id` int NOT NULL,
  `gtin_14` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `initial_code` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `barang_nama` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `barang_kode` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `harga_beli` double NOT NULL,
  `satuan_beli` int NOT NULL,
  `isi_per_pcs` int NOT NULL,
  `hpp_per_pcs` double NOT NULL,
  `tanggal_expired` varchar(225) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaction_histories`
--

CREATE TABLE `transaction_histories` (
  `transaction_history_id` int NOT NULL,
  `sender_wallet_uuid` varchar(225) NOT NULL,
  `reciever_wallet_uuid` varchar(225) NOT NULL,
  `note` varchar(225) DEFAULT NULL,
  `transaction_balance` double NOT NULL,
  `transaction_type` enum('topup','transfer','recieve') NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `transaksi_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `kasir_id` int NOT NULL,
  `no_transaksi` varchar(225) NOT NULL,
  `customer_id` int NOT NULL,
  `tgl_transaksi` date NOT NULL,
  `diskon` double DEFAULT NULL,
  `total_transaksi` varchar(225) NOT NULL,
  `uang_diterima` varchar(225) NOT NULL,
  `uang_kembali` varchar(225) NOT NULL,
  `jenis_pembayaran` enum('Tunai','Non Tunai') NOT NULL,
  `jatuh_tempo` date DEFAULT NULL,
  `uang_titip` double DEFAULT NULL,
  `ekspedisi` varchar(225) DEFAULT NULL,
  `ongkir` double DEFAULT NULL,
  `pajak` double NOT NULL DEFAULT '0',
  `potongan_member` double NOT NULL DEFAULT '0',
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_detail`
--

CREATE TABLE `transaksi_detail` (
  `id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `no_transaksi` varchar(225) NOT NULL,
  `barang_id` int NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_promosi`
--

CREATE TABLE `transaksi_promosi` (
  `transaksi_promosi_id` int NOT NULL,
  `gudang_id` int NOT NULL,
  `user_id` int NOT NULL,
  `no_transaksi` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `kode_promosi` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `nama_promosi` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `metadata` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transfer`
--

CREATE TABLE `transfer` (
  `transfer_id` int NOT NULL,
  `no_transfer` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `transfer_dari` int NOT NULL,
  `transfer_ke` int NOT NULL,
  `transfer_status` enum('tertunda','diterima','dibatalkan') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'tertunda',
  `transportasi_id` int DEFAULT NULL,
  `pengirim` int DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transfer_detail`
--

CREATE TABLE `transfer_detail` (
  `transfer_detail_id` int NOT NULL,
  `no_transfer` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `produk_id` int NOT NULL,
  `jumlah_transfer` int NOT NULL,
  `jumlah_tolak` int DEFAULT NULL,
  `jumlah_terima` int DEFAULT NULL,
  `hostiry_update` text COLLATE utf8mb4_general_ci COMMENT 'Mencatat history update detail transfer berdasarkan barang',
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transportasi`
--

CREATE TABLE `transportasi` (
  `transportasi_id` int NOT NULL,
  `jenis_kendaraan` enum('Truk','Pribadi','Box','Container','Lainnya') NOT NULL,
  `nomor_kendaraan` varchar(225) NOT NULL,
  `pajak_berakhir` date NOT NULL,
  `kondisi` enum('BAIK','RUSAK','PERBAIKAN') NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `units`
--

CREATE TABLE `units` (
  `unit_id` int NOT NULL,
  `nama_unit` varchar(100) NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `user_uuid` varchar(225) NOT NULL,
  `profile_id` int NOT NULL,
  `email` varchar(225) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(225) NOT NULL,
  `role_id` int NOT NULL,
  `gudang_id` int DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ga_status` tinyint(1) NOT NULL DEFAULT '0',
  `ga_secret` varchar(225) DEFAULT NULL,
  `token` varchar(225) DEFAULT NULL,
  `is_login` tinyint(1) NOT NULL DEFAULT '0',
  `refresh_token` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_akses`
--

CREATE TABLE `user_akses` (
  `id` int NOT NULL,
  `role_id` int NOT NULL,
  `user_menu_id` int NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `can_create` tinyint(1) NOT NULL DEFAULT '1',
  `can_read` tinyint(1) NOT NULL DEFAULT '1',
  `can_update` tinyint(1) NOT NULL DEFAULT '1',
  `can_delete` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_depot_groups`
--

CREATE TABLE `user_depot_groups` (
  `user_depot_id` int NOT NULL,
  `user_id` int NOT NULL,
  `depot_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_menu`
--

CREATE TABLE `user_menu` (
  `id` int NOT NULL,
  `parent_key` varchar(225) NOT NULL,
  `menu_key` varchar(225) NOT NULL,
  `menu_type` varchar(225) NOT NULL,
  `menu_name` varchar(225) NOT NULL,
  `menu_icon` varchar(225) NOT NULL,
  `menu_url` varchar(225) NOT NULL,
  `order_number` int DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `wallets`
--

CREATE TABLE `wallets` (
  `wallet_id` int NOT NULL,
  `wallet_uuid` varchar(225) NOT NULL,
  `wallet_number` varchar(225) NOT NULL,
  `customer_id` int NOT NULL,
  `wallet_login_pass` varchar(225) NOT NULL,
  `wallet_trans_pass` varchar(225) NOT NULL,
  `wallet_balance` double NOT NULL,
  `otp` enum('none','sms','email') NOT NULL DEFAULT 'none',
  `reCAPTCHA` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `antrian_pelanggan`
--
ALTER TABLE `antrian_pelanggan`
  ADD PRIMARY KEY (`antrian_id`),
  ADD KEY `gudang_id` (`gudang_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `antrian_pelanggan_id_IDX` (`id`) USING BTREE,
  ADD KEY `antrian_pelanggan_hold_IDX` (`hold`) USING BTREE;

--
-- Indeks untuk tabel `antrian_pesanan`
--
ALTER TABLE `antrian_pesanan`
  ADD PRIMARY KEY (`antrian_pesanan_id`),
  ADD UNIQUE KEY `antrian_pesanan_UN` (`walk_in_customer`),
  ADD KEY `antrian_pesanan_walk_in_customer_IDX` (`walk_in_customer`) USING BTREE;

--
-- Indeks untuk tabel `api_access`
--
ALTER TABLE `api_access`
  ADD PRIMARY KEY (`api_id`);

--
-- Indeks untuk tabel `app_config`
--
ALTER TABLE `app_config`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`barang_id`),
  ADD KEY `barang_deleted_at_IDX` (`deleted_at`) USING BTREE,
  ADD KEY `harga_jual` (`harga_jual_level_1`,`harga_jual_level_2`,`harga_jual_level_3`,`harga_jual_level_4`) USING BTREE,
  ADD KEY `satuan_beli_local` (`satuan_beli_local`) USING BTREE,
  ADD KEY `isi_jual_level_1` (`isi_jual_level_1`),
  ADD KEY `produk_barang` (`produk_id`) USING BTREE,
  ADD KEY `gudang_barang` (`gudang_id`) USING BTREE;

--
-- Indeks untuk tabel `barang_harga`
--
ALTER TABLE `barang_harga`
  ADD PRIMARY KEY (`barang_harga_id`),
  ADD KEY `barang_id` (`barang_id`),
  ADD KEY `satuan_harga` (`satuan_harga_baru`);

--
-- Indeks untuk tabel `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD PRIMARY KEY (`barang_keluar_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `gudang_id` (`gudang_id`),
  ADD KEY `produk_id` (`produk_id`);

--
-- Indeks untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`barang_masuk_id`),
  ADD KEY `produk_id` (`produk_id`),
  ADD KEY `gudang_id` (`gudang_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `biaya`
--
ALTER TABLE `biaya`
  ADD PRIMARY KEY (`biaya_id`),
  ADD KEY `gudang_id` (`gudang_id`);

--
-- Indeks untuk tabel `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `profile_customer` (`profile_id`) USING BTREE;

--
-- Indeks untuk tabel `depositories`
--
ALTER TABLE `depositories`
  ADD PRIMARY KEY (`depot_id`),
  ADD KEY `depositories_depot_name_IDX` (`depot_name`) USING BTREE,
  ADD KEY `depositories_deleted_at_IDX` (`deleted_at`) USING BTREE,
  ADD KEY `depositories_depot_code_IDX` (`depot_code`) USING BTREE;

--
-- Indeks untuk tabel `diskon`
--
ALTER TABLE `diskon`
  ADD PRIMARY KEY (`diskon_id`),
  ADD KEY `gudang_id` (`gudang_id`);

--
-- Indeks untuk tabel `flag_barang_baru`
--
ALTER TABLE `flag_barang_baru`
  ADD PRIMARY KEY (`flag_id`),
  ADD KEY `gudang_id` (`gudang_id`);

--
-- Indeks untuk tabel `font_icons`
--
ALTER TABLE `font_icons`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `histori_barang`
--
ALTER TABLE `histori_barang`
  ADD PRIMARY KEY (`histori_barang_id`);

--
-- Indeks untuk tabel `histori_harga`
--
ALTER TABLE `histori_harga`
  ADD PRIMARY KEY (`histori_harga_id`),
  ADD KEY `barang_id` (`barang_id`);

--
-- Indeks untuk tabel `histori_pembayaran_hutang`
--
ALTER TABLE `histori_pembayaran_hutang`
  ADD PRIMARY KEY (`histori_pembayaran_hutang_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `transaksi_id` (`transaksi_id`);

--
-- Indeks untuk tabel `internal_barcode`
--
ALTER TABLE `internal_barcode`
  ADD PRIMARY KEY (`internal_barcode_id`),
  ADD KEY `barang_id` (`barang_id`),
  ADD KEY `internal_barcode_internal_barcode_IDX` (`internal_barcode`) USING BTREE;

--
-- Indeks untuk tabel `kas_kasir`
--
ALTER TABLE `kas_kasir`
  ADD PRIMARY KEY (`kas_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `gudang_id` (`gudang_id`),
  ADD KEY `kas_kasir_jumlah_uang_IDX` (`jumlah_uang`) USING BTREE,
  ADD KEY `kas_kasir_jenis_kas_IDX` (`jenis_kas`) USING BTREE,
  ADD KEY `kas_kasir_nama_kas_IDX` (`nama_kas`) USING BTREE,
  ADD KEY `kas_kasir_deleted_at_IDX` (`deleted_at`) USING BTREE;

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`kategori_id`),
  ADD KEY `kategori_kategori_nama_IDX` (`kategori_nama`) USING BTREE,
  ADD KEY `kategori_deleted_at_IDX` (`deleted_at`) USING BTREE;

--
-- Indeks untuk tabel `keranjang_belanja`
--
ALTER TABLE `keranjang_belanja`
  ADD PRIMARY KEY (`keranjang_belanja_id`),
  ADD KEY `walk_in_customer` (`walk_in_customer`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `gudang_id` (`gudang_id`) USING BTREE,
  ADD KEY `barang_id` (`barang_id`);

--
-- Indeks untuk tabel `keys`
--
ALTER TABLE `keys`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `log_activities`
--
ALTER TABLE `log_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `gudang_id` (`gudang_id`);

--
-- Indeks untuk tabel `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`);

--
-- Indeks untuk tabel `pajak`
--
ALTER TABLE `pajak`
  ADD PRIMARY KEY (`pajak_id`),
  ADD KEY `gudang_id` (`gudang_id`);

--
-- Indeks untuk tabel `paket_promo`
--
ALTER TABLE `paket_promo`
  ADD PRIMARY KEY (`paket_promo_id`),
  ADD KEY `promo_id` (`promo_id`),
  ADD KEY `barang_id` (`barang_id`);

--
-- Indeks untuk tabel `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`pembelian_id`),
  ADD KEY `produk_id` (`produk_id`),
  ADD KEY `gudang_id` (`gudang_id`);

--
-- Indeks untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`penjualan_id`),
  ADD KEY `gudang_id` (`gudang_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `tanggal_transaksi` (`tanggal_transaksi`) USING BTREE,
  ADD KEY `no_transaksi` (`no_transaksi`) USING BTREE,
  ADD KEY `initial_code_produk` (`initial_code`) USING BTREE;

--
-- Indeks untuk tabel `presensi`
--
ALTER TABLE `presensi`
  ADD PRIMARY KEY (`presensi_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `printers`
--
ALTER TABLE `printers`
  ADD PRIMARY KEY (`printer_id`),
  ADD KEY `gudang_id` (`gudang_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `printers_printer_nama_IDX` (`printer_nama`) USING BTREE,
  ADD KEY `printers_printer_node_IDX` (`printer_node`) USING BTREE,
  ADD KEY `printers_deleted_at_IDX` (`deleted_at`) USING BTREE;

--
-- Indeks untuk tabel `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`produk_id`),
  ADD UNIQUE KEY `initial_code` (`initial_code`) USING BTREE,
  ADD KEY `tanggal_expired` (`tanggal_expired`) USING BTREE,
  ADD KEY `harga_beli` (`harga_beli`) USING BTREE,
  ADD KEY `kategori_id` (`kategori_id`) USING BTREE,
  ADD KEY `barang_nama` (`barang_nama`) USING BTREE,
  ADD KEY `barang_kode` (`barang_kode`) USING BTREE,
  ADD KEY `satuan_beli` (`satuan_beli`) USING BTREE,
  ADD KEY `suplier_id` (`suplier_id`) USING BTREE;

--
-- Indeks untuk tabel `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`profile_id`),
  ADD KEY `profiles_fullname_IDX` (`fullname`) USING BTREE,
  ADD KEY `profiles_phone_number_IDX` (`phone_number`) USING BTREE;

--
-- Indeks untuk tabel `promo`
--
ALTER TABLE `promo`
  ADD PRIMARY KEY (`promo_id`);

--
-- Indeks untuk tabel `promosi`
--
ALTER TABLE `promosi`
  ADD PRIMARY KEY (`promo_id`),
  ADD UNIQUE KEY `kode_promo` (`kode_promo`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `gudang_id` (`gudang_id`);

--
-- Indeks untuk tabel `promosi_barang`
--
ALTER TABLE `promosi_barang`
  ADD PRIMARY KEY (`promosi_barang_id`),
  ADD KEY `promosi_id` (`promosi_id`),
  ADD KEY `barang_id` (`barang_id`);

--
-- Indeks untuk tabel `promosi_benefit_barang`
--
ALTER TABLE `promosi_benefit_barang`
  ADD PRIMARY KEY (`promosi_benefit_barang_id`),
  ADD KEY `promosi_id` (`promosi_id`),
  ADD KEY `barang_id` (`barang_id`);

--
-- Indeks untuk tabel `promosi_benefit_diskon`
--
ALTER TABLE `promosi_benefit_diskon`
  ADD PRIMARY KEY (`promosi_benefit_diskon_id`),
  ADD KEY `promosi_id` (`promosi_id`);

--
-- Indeks untuk tabel `promosi_kategori`
--
ALTER TABLE `promosi_kategori`
  ADD PRIMARY KEY (`promosi_kategori`),
  ADD KEY `promosi_id` (`promosi_id`),
  ADD KEY `kategori_id` (`kategori_id`);

--
-- Indeks untuk tabel `promosi_periode`
--
ALTER TABLE `promosi_periode`
  ADD PRIMARY KEY (`promosi_periode_id`),
  ADD KEY `promosi_id` (`promosi_id`);

--
-- Indeks untuk tabel `riteldb`
--
ALTER TABLE `riteldb`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `stok_opname`
--
ALTER TABLE `stok_opname`
  ADD PRIMARY KEY (`so_id`),
  ADD KEY `so_user_id` (`so_user_id`),
  ADD KEY `so_gudang_id` (`so_gudang_id`),
  ADD KEY `produk_id` (`produk_id`);

--
-- Indeks untuk tabel `supir`
--
ALTER TABLE `supir`
  ADD PRIMARY KEY (`supir_id`),
  ADD KEY `supir_nama_supir_IDX` (`nama_supir`) USING BTREE,
  ADD KEY `supir_deleted_at_IDX` (`deleted_at`) USING BTREE,
  ADD KEY `supir_is_active_IDX` (`is_active`) USING BTREE;

--
-- Indeks untuk tabel `supliers`
--
ALTER TABLE `supliers`
  ADD PRIMARY KEY (`suplier_id`),
  ADD KEY `supliers_suplier_code_IDX` (`suplier_code`) USING BTREE,
  ADD KEY `supliers_suplier_name_IDX` (`suplier_name`) USING BTREE,
  ADD KEY `supliers_suplier_phone_IDX` (`suplier_phone`) USING BTREE,
  ADD KEY `supliers_suplier_status_IDX` (`suplier_status`) USING BTREE,
  ADD KEY `supliers_deleted_at_IDX` (`deleted_at`) USING BTREE;

--
-- Indeks untuk tabel `surat`
--
ALTER TABLE `surat`
  ADD PRIMARY KEY (`surat_id`),
  ADD KEY `nomor_surat` (`nomor_surat`),
  ADD KEY `pembuat_surat` (`user_id`) USING BTREE,
  ADD KEY `transportasi_pengirim` (`transportasi_id`) USING BTREE,
  ADD KEY `gudang_pengirim` (`gudang_id`) USING BTREE,
  ADD KEY `pengirim_pesanan` (`pengirim`) USING BTREE,
  ADD KEY `penerima_pesanan` (`penerima`) USING BTREE;

--
-- Indeks untuk tabel `surat_detail`
--
ALTER TABLE `surat_detail`
  ADD PRIMARY KEY (`surat_detail_id`),
  ADD KEY `surat_id` (`surat_id`),
  ADD KEY `barang_pesanan` (`barang_id`) USING BTREE;

--
-- Indeks untuk tabel `surat_transaksi`
--
ALTER TABLE `surat_transaksi`
  ADD PRIMARY KEY (`surat_transaksi_id`),
  ADD KEY `no_transaksi` (`no_transaksi`) USING BTREE,
  ADD KEY `surat_id` (`surat_id`) USING BTREE,
  ADD KEY `PRIMAY` (`surat_transaksi_id`) USING BTREE;

--
-- Indeks untuk tabel `tempat_pembuangan_akhir`
--
ALTER TABLE `tempat_pembuangan_akhir`
  ADD PRIMARY KEY (`tpa_id`);

--
-- Indeks untuk tabel `temp_barang`
--
ALTER TABLE `temp_barang`
  ADD PRIMARY KEY (`barang_id`),
  ADD KEY `produk_id` (`produk_id`),
  ADD KEY `gudang_id` (`gudang_id`);

--
-- Indeks untuk tabel `temp_produk`
--
ALTER TABLE `temp_produk`
  ADD PRIMARY KEY (`produk_id`),
  ADD KEY `kategori_id` (`kategori_id`),
  ADD KEY `suplier_id` (`suplier_id`),
  ADD KEY `satuan_beli` (`satuan_beli`);

--
-- Indeks untuk tabel `transaction_histories`
--
ALTER TABLE `transaction_histories`
  ADD PRIMARY KEY (`transaction_history_id`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`transaksi_id`),
  ADD UNIQUE KEY `no_transaksi` (`no_transaksi`) USING BTREE,
  ADD KEY `tgl_transaksi` (`tgl_transaksi`) USING BTREE,
  ADD KEY `deleted_at` (`deleted_at`) USING BTREE,
  ADD KEY `jenis_pembayaran` (`jenis_pembayaran`) USING BTREE,
  ADD KEY `customer_transaksi` (`customer_id`) USING BTREE,
  ADD KEY `kasir_transaksi` (`kasir_id`) USING BTREE,
  ADD KEY `gudang_transaksi` (`gudang_id`) USING BTREE;

--
-- Indeks untuk tabel `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nomor_transaksi` (`no_transaksi`) USING BTREE,
  ADD KEY `gudang_detail_transaksi` (`gudang_id`) USING BTREE,
  ADD KEY `barang_detail_transaksi` (`barang_id`) USING BTREE;

--
-- Indeks untuk tabel `transaksi_promosi`
--
ALTER TABLE `transaksi_promosi`
  ADD PRIMARY KEY (`transaksi_promosi_id`),
  ADD KEY `gudang_id` (`gudang_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `kode_promosi` (`kode_promosi`);

--
-- Indeks untuk tabel `transfer`
--
ALTER TABLE `transfer`
  ADD PRIMARY KEY (`transfer_id`),
  ADD UNIQUE KEY `no_transfer` (`no_transfer`),
  ADD KEY `no_transfer_2` (`no_transfer`),
  ADD KEY `gudang_asal` (`transfer_dari`) USING BTREE,
  ADD KEY `gudang_tujuan` (`transfer_ke`) USING BTREE,
  ADD KEY `kendaraan` (`transportasi_id`) USING BTREE,
  ADD KEY `supir_pengirim` (`pengirim`) USING BTREE;

--
-- Indeks untuk tabel `transfer_detail`
--
ALTER TABLE `transfer_detail`
  ADD PRIMARY KEY (`transfer_detail_id`),
  ADD KEY `produk_id` (`produk_id`),
  ADD KEY `no_transfer` (`no_transfer`);

--
-- Indeks untuk tabel `transportasi`
--
ALTER TABLE `transportasi`
  ADD PRIMARY KEY (`transportasi_id`),
  ADD KEY `transportasi_jenis_kendaraan_IDX` (`jenis_kendaraan`) USING BTREE,
  ADD KEY `transportasi_nomor_kendaraan_IDX` (`nomor_kendaraan`) USING BTREE,
  ADD KEY `transportasi_pajak_berakhir_IDX` (`pajak_berakhir`) USING BTREE,
  ADD KEY `transportasi_kondisi_IDX` (`kondisi`) USING BTREE,
  ADD KEY `transportasi_deleted_at_IDX` (`deleted_at`) USING BTREE;

--
-- Indeks untuk tabel `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unit_id`),
  ADD KEY `units_nama_unit_IDX` (`nama_unit`) USING BTREE,
  ADD KEY `units_deleted_at_IDX` (`deleted_at`) USING BTREE;

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_user` (`email`) USING BTREE,
  ADD KEY `posisi_user` (`role_id`) USING BTREE,
  ADD KEY `gudang_user` (`gudang_id`) USING BTREE,
  ADD KEY `profile_user` (`profile_id`) USING BTREE;

--
-- Indeks untuk tabel `user_akses`
--
ALTER TABLE `user_akses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `user_menu_id` (`user_menu_id`);

--
-- Indeks untuk tabel `user_depot_groups`
--
ALTER TABLE `user_depot_groups`
  ADD PRIMARY KEY (`user_depot_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `depot_id` (`depot_id`);

--
-- Indeks untuk tabel `user_menu`
--
ALTER TABLE `user_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`wallet_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `antrian_pelanggan`
--
ALTER TABLE `antrian_pelanggan`
  MODIFY `antrian_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `antrian_pesanan`
--
ALTER TABLE `antrian_pesanan`
  MODIFY `antrian_pesanan_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `api_access`
--
ALTER TABLE `api_access`
  MODIFY `api_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `app_config`
--
ALTER TABLE `app_config`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `barang`
--
ALTER TABLE `barang`
  MODIFY `barang_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `barang_harga`
--
ALTER TABLE `barang_harga`
  MODIFY `barang_harga_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `barang_keluar`
--
ALTER TABLE `barang_keluar`
  MODIFY `barang_keluar_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  MODIFY `barang_masuk_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `biaya`
--
ALTER TABLE `biaya`
  MODIFY `biaya_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `depositories`
--
ALTER TABLE `depositories`
  MODIFY `depot_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `diskon`
--
ALTER TABLE `diskon`
  MODIFY `diskon_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `flag_barang_baru`
--
ALTER TABLE `flag_barang_baru`
  MODIFY `flag_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `font_icons`
--
ALTER TABLE `font_icons`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `histori_barang`
--
ALTER TABLE `histori_barang`
  MODIFY `histori_barang_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `histori_harga`
--
ALTER TABLE `histori_harga`
  MODIFY `histori_harga_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `histori_pembayaran_hutang`
--
ALTER TABLE `histori_pembayaran_hutang`
  MODIFY `histori_pembayaran_hutang_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `internal_barcode`
--
ALTER TABLE `internal_barcode`
  MODIFY `internal_barcode_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kas_kasir`
--
ALTER TABLE `kas_kasir`
  MODIFY `kas_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `kategori_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `keranjang_belanja`
--
ALTER TABLE `keranjang_belanja`
  MODIFY `keranjang_belanja_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `keys`
--
ALTER TABLE `keys`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `log_activities`
--
ALTER TABLE `log_activities`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pajak`
--
ALTER TABLE `pajak`
  MODIFY `pajak_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `paket_promo`
--
ALTER TABLE `paket_promo`
  MODIFY `paket_promo_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pembelian`
--
ALTER TABLE `pembelian`
  MODIFY `pembelian_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  MODIFY `penjualan_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `presensi`
--
ALTER TABLE `presensi`
  MODIFY `presensi_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `printers`
--
ALTER TABLE `printers`
  MODIFY `printer_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `produk`
--
ALTER TABLE `produk`
  MODIFY `produk_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `profiles`
--
ALTER TABLE `profiles`
  MODIFY `profile_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `promo`
--
ALTER TABLE `promo`
  MODIFY `promo_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `promosi`
--
ALTER TABLE `promosi`
  MODIFY `promo_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `promosi_barang`
--
ALTER TABLE `promosi_barang`
  MODIFY `promosi_barang_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `promosi_benefit_barang`
--
ALTER TABLE `promosi_benefit_barang`
  MODIFY `promosi_benefit_barang_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `promosi_benefit_diskon`
--
ALTER TABLE `promosi_benefit_diskon`
  MODIFY `promosi_benefit_diskon_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `promosi_kategori`
--
ALTER TABLE `promosi_kategori`
  MODIFY `promosi_kategori` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `promosi_periode`
--
ALTER TABLE `promosi_periode`
  MODIFY `promosi_periode_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `riteldb`
--
ALTER TABLE `riteldb`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `stok_opname`
--
ALTER TABLE `stok_opname`
  MODIFY `so_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `supir`
--
ALTER TABLE `supir`
  MODIFY `supir_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `supliers`
--
ALTER TABLE `supliers`
  MODIFY `suplier_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `surat`
--
ALTER TABLE `surat`
  MODIFY `surat_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `surat_detail`
--
ALTER TABLE `surat_detail`
  MODIFY `surat_detail_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `surat_transaksi`
--
ALTER TABLE `surat_transaksi`
  MODIFY `surat_transaksi_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tempat_pembuangan_akhir`
--
ALTER TABLE `tempat_pembuangan_akhir`
  MODIFY `tpa_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `temp_barang`
--
ALTER TABLE `temp_barang`
  MODIFY `barang_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `temp_produk`
--
ALTER TABLE `temp_produk`
  MODIFY `produk_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaction_histories`
--
ALTER TABLE `transaction_histories`
  MODIFY `transaction_history_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `transaksi_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi_promosi`
--
ALTER TABLE `transaksi_promosi`
  MODIFY `transaksi_promosi_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transfer`
--
ALTER TABLE `transfer`
  MODIFY `transfer_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transfer_detail`
--
ALTER TABLE `transfer_detail`
  MODIFY `transfer_detail_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transportasi`
--
ALTER TABLE `transportasi`
  MODIFY `transportasi_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `user_akses`
--
ALTER TABLE `user_akses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `user_depot_groups`
--
ALTER TABLE `user_depot_groups`
  MODIFY `user_depot_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `user_menu`
--
ALTER TABLE `user_menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `wallets`
--
ALTER TABLE `wallets`
  MODIFY `wallet_id` int NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`produk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_ibfk_3` FOREIGN KEY (`satuan_beli_local`) REFERENCES `units` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `barang_harga`
--
ALTER TABLE `barang_harga`
  ADD CONSTRAINT `barang_harga_ibfk_1` FOREIGN KEY (`barang_id`) REFERENCES `barang_old` (`barang_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD CONSTRAINT `barang_keluar_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `barang_keluar_ibfk_2` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`),
  ADD CONSTRAINT `barang_keluar_ibfk_3` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`produk_id`);

--
-- Ketidakleluasaan untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD CONSTRAINT `barang_masuk_ibfk_1` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`produk_id`),
  ADD CONSTRAINT `barang_masuk_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `barang_masuk_ibfk_3` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`);

--
-- Ketidakleluasaan untuk tabel `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `histori_harga`
--
ALTER TABLE `histori_harga`
  ADD CONSTRAINT `histori_harga_ibfk_1` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`barang_id`);

--
-- Ketidakleluasaan untuk tabel `histori_pembayaran_hutang`
--
ALTER TABLE `histori_pembayaran_hutang`
  ADD CONSTRAINT `histori_pembayaran_hutang_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `histori_pembayaran_hutang_ibfk_2` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`);

--
-- Ketidakleluasaan untuk tabel `internal_barcode`
--
ALTER TABLE `internal_barcode`
  ADD CONSTRAINT `internal_barcode_ibfk_1` FOREIGN KEY (`barang_id`) REFERENCES `barang_old` (`barang_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kas_kasir`
--
ALTER TABLE `kas_kasir`
  ADD CONSTRAINT `kas_kasir_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kas_kasir_ibfk_2` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `keranjang_belanja`
--
ALTER TABLE `keranjang_belanja`
  ADD CONSTRAINT `keranjang_belanja_ibfk_1` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `keranjang_belanja_ibfk_2` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`barang_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `keranjang_belanja_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `paket_promo`
--
ALTER TABLE `paket_promo`
  ADD CONSTRAINT `paket_promo_ibfk_2` FOREIGN KEY (`barang_id`) REFERENCES `barang_old` (`barang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `paket_promo_ibfk_3` FOREIGN KEY (`promo_id`) REFERENCES `promosi` (`promo_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `penjualan_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `penjualan_ibfk_3` FOREIGN KEY (`no_transaksi`) REFERENCES `transaksi` (`no_transaksi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`kategori_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `produk_ibfk_2` FOREIGN KEY (`suplier_id`) REFERENCES `supliers` (`suplier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `produk_ibfk_3` FOREIGN KEY (`satuan_beli`) REFERENCES `units` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `promosi`
--
ALTER TABLE `promosi`
  ADD CONSTRAINT `promosi_ibfk_1` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`),
  ADD CONSTRAINT `promosi_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `promosi_barang`
--
ALTER TABLE `promosi_barang`
  ADD CONSTRAINT `promosi_barang_ibfk_1` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`barang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `promosi_barang_ibfk_2` FOREIGN KEY (`promosi_id`) REFERENCES `promosi` (`promo_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `promosi_benefit_barang`
--
ALTER TABLE `promosi_benefit_barang`
  ADD CONSTRAINT `promosi_benefit_barang_ibfk_1` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`barang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `promosi_benefit_barang_ibfk_2` FOREIGN KEY (`promosi_id`) REFERENCES `promosi` (`promo_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `promosi_benefit_diskon`
--
ALTER TABLE `promosi_benefit_diskon`
  ADD CONSTRAINT `promosi_benefit_diskon_ibfk_1` FOREIGN KEY (`promosi_id`) REFERENCES `promosi` (`promo_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `promosi_kategori`
--
ALTER TABLE `promosi_kategori`
  ADD CONSTRAINT `promosi_kategori_ibfk_1` FOREIGN KEY (`promosi_id`) REFERENCES `promosi` (`promo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `promosi_kategori_ibfk_2` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`kategori_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `promosi_periode`
--
ALTER TABLE `promosi_periode`
  ADD CONSTRAINT `promosi_periode_ibfk_1` FOREIGN KEY (`promosi_id`) REFERENCES `promosi` (`promo_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `surat`
--
ALTER TABLE `surat`
  ADD CONSTRAINT `surat_ibfk_1` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `surat_ibfk_2` FOREIGN KEY (`penerima`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `surat_ibfk_3` FOREIGN KEY (`pengirim`) REFERENCES `supir` (`supir_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `surat_ibfk_4` FOREIGN KEY (`transportasi_id`) REFERENCES `transportasi` (`transportasi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `surat_ibfk_5` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `surat_detail`
--
ALTER TABLE `surat_detail`
  ADD CONSTRAINT `surat_detail_ibfk_1` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`barang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `surat_detail_ibfk_2` FOREIGN KEY (`surat_id`) REFERENCES `surat` (`surat_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`kasir_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaksi_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  ADD CONSTRAINT `transaksi_detail_ibfk_1` FOREIGN KEY (`no_transaksi`) REFERENCES `transaksi` (`no_transaksi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaksi_detail_ibfk_2` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`barang_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi_promosi`
--
ALTER TABLE `transaksi_promosi`
  ADD CONSTRAINT `transaksi_promosi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `transaksi_promosi_ibfk_2` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`),
  ADD CONSTRAINT `transaksi_promosi_ibfk_3` FOREIGN KEY (`kode_promosi`) REFERENCES `promosi` (`kode_promo`);

--
-- Ketidakleluasaan untuk tabel `transfer`
--
ALTER TABLE `transfer`
  ADD CONSTRAINT `transfer_ibfk_1` FOREIGN KEY (`pengirim`) REFERENCES `supir` (`supir_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transfer_ibfk_2` FOREIGN KEY (`transfer_dari`) REFERENCES `depositories` (`depot_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transfer_ibfk_3` FOREIGN KEY (`transportasi_id`) REFERENCES `transportasi` (`transportasi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transfer_ibfk_4` FOREIGN KEY (`transfer_ke`) REFERENCES `depositories` (`depot_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transfer_detail`
--
ALTER TABLE `transfer_detail`
  ADD CONSTRAINT `transfer_detail_ibfk_1` FOREIGN KEY (`no_transfer`) REFERENCES `transfer` (`no_transfer`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transfer_detail_ibfk_2` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`produk_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`gudang_id`) REFERENCES `depositories` (`depot_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
