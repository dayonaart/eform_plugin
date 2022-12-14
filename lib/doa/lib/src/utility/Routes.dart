import 'package:eformplugin/doa/lib/src/models/pekerjaan-model.dart';
import 'package:eformplugin/doa/lib/src/views/buka-rekening/pemilihan-rekening.dart';
import 'package:eformplugin/doa/lib/src/views/buka-rekening/home-buka-rekening.dart';
import 'package:eformplugin/doa/lib/src/views/data-file/data-file-list.dart';
import 'package:eformplugin/doa/lib/src/views/data-file/ktp-dan-npwp/ktp-dan-npwp.dart';
import 'package:eformplugin/doa/lib/src/views/data-file/tanda-tangan/tanda-tangan.dart';
import 'package:eformplugin/doa/lib/src/views/data-file/wajah-dan-ktp/wajah-dan-ktp.dart';
import 'package:eformplugin/doa/lib/src/views/datadiri-page/data-diri-1.dart';
import 'package:eformplugin/doa/lib/src/views/form-alamat/alamat-indonesia.dart';
import 'package:eformplugin/doa/lib/src/views/form-alamat/alamat-luar-indonesia.dart';
import 'package:eformplugin/doa/lib/src/views/otp-page/otp-screen.dart';
import 'package:eformplugin/doa/lib/src/views/pekerjaan-page/pekerjaan_screen.dart';
import 'package:eformplugin/doa/lib/src/views/pemilihan-cabang-page/pemilihanCabangIndonesia_page.dart';
import 'package:eformplugin/doa/lib/src/views/pemilihan-cabang-page/pemilihanCabangLuar_page.dart';
import 'package:eformplugin/doa/lib/src/views/pemilik-dana-page/pemilikdana_screen.dart';
import 'package:eformplugin/doa/lib/src/views/register/Acknowledgement/acknowledgement_screen.dart';
import 'package:eformplugin/doa/lib/src/views/register/create_pin/create_pin_screen.dart';
import 'package:eformplugin/doa/lib/src/views/register/register_card_type/card_type_screen.dart';
import 'package:eformplugin/doa/lib/src/views/register/register_card_type/card_type_screen_taplus_bisnis.dart';
import 'package:eformplugin/doa/lib/src/views/register/register_card_type/card_type_screen_taplus_diaspora.dart';
import 'package:eformplugin/doa/lib/src/views/register/register_card_type/card_type_screen_taplus_muda.dart';
import 'package:eformplugin/doa/lib/src/views/register/verification/phone_verification_screen.dart';
import 'package:eformplugin/doa/lib/src/views/register/work/work_detail/work_detail_screen.dart';
import 'package:eformplugin/doa/lib/src/views/register/work/work_detail/work_detail_screen_alt.dart';
import 'package:eformplugin/doa/lib/src/views/registrasi/register_nomor_page.dart';
import 'package:eformplugin/doa/lib/src/views/splash-page/splash-screen.dart';
import 'package:eformplugin/doa/lib/src/views/success-page/create-mbank.dart';
import 'package:eformplugin/doa/lib/src/views/success-page/success-screen.dart';
import 'package:eformplugin/doa/lib/src/views/tipe-tabungan/tabungan-indonesia.dart';
import 'package:eformplugin/doa/lib/src/views/tipe-tabungan/tabungan-luar-indonesia.dart';
import 'package:get/get.dart';
import '../views/datadiri-page/data-diri-2.dart';
import '../views/home-page/home-screen.dart';
import '../views/syarat-dan-ketentuan/syarat-dan-ketentuan.dart';

class Routes {
  final homeBukaRekening = "/homeBukaRekening";
  final splashScreen = "/splashScreen";
  final pilihRekening = "/pilihRekening";
  final home = "/";
  final syarat = "/syarat";
  final registrasinomor = "/registrasinomor";
  final jenisTabunganDalam = '/jenisTabunganDalam';
  final jenisTabunganLuar = 'jenisTabunganLuar';
  final taplusdigital = '/taplusdigital';
  final taplusmudadigital = '/taplusmudadigital';
  final taplusbisnisdigital = '/taplusbisnisdigital';
  final diaspora = '/diaspora';
  final datadiri = "/datadiri";
  final datadiri2 = '/datadiri2';
  final alamatDalam = '/alamatDalam';
  final alamatLuar = '/alamatLuar';
  final pekerjaan = '/pekerjaan';
  final pemilikDana = '/pemilikDana';
  final detailPekerjaan = '/detailPekerjaan';
  final pemilihanCabangIndonesia = "/pemilihanCabangIndonesia";
  final pemilihanCabangLuar = "/pemilihanCabangLuarIndonesia";
  final datafile = '/datafile';
  final phoneVerification = '/phoneVerification';
  final otp = '/otp';
  final createPin = '/createPin';
  final acknowledgement = "/acknowledgement";
  final createMbank = '/createMbank';
  final successPage = '/successPage';
  final tandatangan = '/tandatangan';
  final ktpnpwp = '/ktpnpwp';
  final wajahktp = '/wajahktp';

  List<GetPage> listPage = [
    GetPage(name: '/homeBukaRekening', page: () => HomeBukaRekening()),
    GetPage(name: '/pilihRekening', page: () => PilihRekeningPage()),
    GetPage(name: '/splashScreen', page: () => SplashScreen()),
    GetPage(name: '/', page: () => HomeScreeen()),
    GetPage(name: '/syarat', page: () => SyaratDanKetentuanPage()),
    GetPage(name: '/registrasinomor', page: () => RegisterNomorPageAlt()),
    GetPage(name: '/jenisTabunganDalam', page: () => TabunganIndonesia()),
    GetPage(name: '/jenisTabunganLuar', page: () => TabunganLuarIndonesia()),
    GetPage(name: '/taplusdigital', page: () => CardTypeScreen()),
    GetPage(name: '/taplusmudadigital', page: () => CardTypeMuda()),
    GetPage(name: '/taplusbisnisdigital', page: () => CardTypeBisnis()),
    GetPage(name: '/diaspora', page: () => CardTypeDiaspora()),
    GetPage(name: '/datadiri', page: () => DataDiri1()),
    GetPage(name: '/datadiri2', page: () => DataDiri2()),
    GetPage(name: '/alamatDalam', page: () => AlamatIndonesia()),
    GetPage(name: '/alamatLuar', page: () => AlamatLuarIndonesia()),
    GetPage(name: '/pekerjaan', page: () => PekerjaanScreeen()),
    GetPage(name: '/pemilikDana', page: () => PemilikDanaScreeen()),
    GetPage(name: '/detailPekerjaan', page: () => WorkDetailScreenAlt()),
    // GetPage(name: '/detailPekerjaan', page: () => WorkDetailScreenAlt()),
    GetPage(
        name: '/pemilihanCabangIndonesia',
        page: () => PemilihanCabangIndonesiaPage()),
    GetPage(
        name: '/pemilihanCabangLuar', page: () => PemilihanCabangLuarPage()),
    GetPage(name: '/datafile', page: () => DataFileListPage()),
    GetPage(name: '/phoneVerification', page: () => PhoneVerificationScreen()),
    GetPage(name: '/detailPekerjaan', page: () => WorkDetailScreen()),
    GetPage(name: '/otp', page: () => OTPScreen()),
    GetPage(name: '/acknowledgement', page: () => AcknowledgementScreen()),
    GetPage(name: '/createPin', page: () => CreatePinScreen()),
    // GetPage(name: '/createPin', page: () => CreatePinScreenAlt()),
    GetPage(name: '/tandatangan', page: () => TandaTanganPage()),
    GetPage(name: '/ktpnpwp', page: () => KtpDanNpwpPage()),
    GetPage(name: '/successPage', page: () => SuccessScreen()),
    GetPage(name: '/wajahktp', page: () => WajahDanKtpPage()),
    GetPage(name: '/acknowledgement', page: () => AcknowledgementScreen()),
    GetPage(name: '/createMbank', page: () => CreateMbank()),
    GetPage(
        name: '/pemilihanCabangLuarIndonesia',
        page: () => PemilihanCabangLuarPage()),
    //Nanti Cifnum nya dihapus
    // GetPage(
    //     name: '/createMbank', page: () => CreateMbank(cifnum: '9100781908')),
  ];
}
