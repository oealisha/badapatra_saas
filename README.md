# bada_patra_task

A new Flutter project on Nagarik Badapatra App.
By Alisha Pokhrel for [Xelwel Innovation Pvt. Ltd]

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

LOGIN PAGE
HOME PAGE: HEADER, FOOTER, NEWS NAV BAR,
HOME PAGE: RAW TABLE
HOME PAGE:TABLE WITH DESIGN
HOME PAGE: TABLE WITH DATA FETCH FROM API

# What is Nagarik Badapatra App?

A Flutter-based mobile application developed for managing and issuing official recommendation letters (बडापत्र) for the local municipality office, Bhanu Municipality, Tanahun. This app helps digitalize public services like citizenship verification, marriage certificates, and more.

## Features

- **Login Page** – Secure login system for users and officials.
- **Home Page UI** – Includes:
- Header
- Footer
- News/Notices Navigation Bar
- **Data Tables** –
- Static table layout
- Styled tables
- Dynamic tables with API-integrated data fetching
- **API Integration** – Fetches and displays real-time data from a live government system.

## Screenshots

## Getting Started

- Flutter SDK installed
- Android Studio / VS Code
- Dart
- Git
- A connected emulator or real device

### Installation Steps

cd bada_patra_task
flutter pub get
flutter run

## Localization

Folder: L10n

- app_en.arb (for English Language Mapping)
- app_ne.arb (for Nepali Language Mapping)

But Hardcode for the static text of the table header:
final headers = [
'क्र.स',
'सेवाको किसिम',
'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
'लाग्‍ने शुल्क',
'लाग्‍ने समय',
'सेवा दिने शाखा',
'गुनासो सुन्‍ने अधिकारी',
];

## For news nav bar and marquee

Used marquee: ^2.2.3 package

## Packages Used

audioplayers: Used to play local audio files in the app.

connectivity_plus: Helps check if the user has internet access or not.

crypto: Can be used for encoding or hashing sensitive data securely.

sqflite: To manage local databases—storing data even when offline.

flutter_secure_storage: Stores sensitive information like login tokens securely on the device.

flutter_tts: Converts text to speech.

flutter_svg: Show SVG images, which are scalable and used for icons or logos.

http: Used for sending or receiving data from a backend server.

intl: Helps format dates, times, and numbers according to the Nepali locale.

marquee: Used to scroll news or notifications automatically across the screen.

path, path_provider: Help locate where to read or write files inside the app's internal storage.

provider: Manages the app’s state means how data flows and updates across the app.

shared_preferences: Saves simple data like user login status or settings.

socket_io_client: Allows real-time communication, like pushing live updates.

sembast, sembast_web: These are used for local storage in both mobile and web versions of the app.

url_launcher: Opens links, such as government websites, from within the app.

## todo:

make table responsive

both landscape and portrait mode

portrait:
header text justify: DONE
color change of the footer: black to blue and red to font red:DONE

landscape:
logo justify, text justify with top margin: DONE
sidebar: text in one line, bold font size reduce, contact info,
qr code margin :DONE

TODO:

- - click garda chai search bar ma janu paryo tv bata herda, _ click garda search bar ma janxa, popup open hunxa ani next time _ click garda popup cancel hunu parxa.
    SN le dherai leko xa width, design mileko xaina. sn tala mathi xa
    type garda popup ma aaunu paryo code row

login with thumb:

login: username insted of employee
password ma \***\*\*\*\*\*\***

forgot password.

login at once (connection with server): DONE

server set 10 min

M2006C3LI (mobile) • OZDEZ9XOYX6TQ4V8 • android-arm • Android 10 (API 29)
push notification/ pop

landscape mode once

reduce the size and height of the search bar

reduce the height of the table header
reduce the width of the second column: 'सेवा किसिम: take only the space where text adjust

reduce the column 2nd

restart garepaci socket ko save hunu paryo local ma

admin/ server le delete garepaci pani dlt hunu paryo local ma

socket: change domain, keep broadcast with youtube video that must directly open using socket
80 port

RSS bata tanni news headline
notice bar is top bar 

socket should listen and play youtube video

https://sprta.digitalbadapatra.com/api/v1/get_fetch_data_record

all table data should refresh
news bar slow
landscape table
qr code