# WindowsクライアントからlannerへCentOS7のインストール手順

## 事前準備

USBポートにCOMケーブルを指す

## 1.コンソール準備

ここではTeraTermを使用して行いました。

### 1.TeraTermを起動し、「シリアル」を選択する

<img src="./images/1.teraterm/1-select-serial-port.png" width="30%">

### 2.「設定」-> 「シリアルポート設定」を選択し、以下の項目を設定する

<img src="./images/1.teraterm/2-setting-serial-port.png" width="30%">

  + ポートレート: 115200
  + データ: 8bit
  + パリティ: none
  + ストップ: 1bit
  + フロー制御: none

### 3.全般で言語：[Engish]を選択する

<img src="./images/1.teraterm/3-setting-all.png" width="30%">

## 2.boot biosの変更

+ lannerの電源を入れる
+ teratermでシリアルコンソールを表示しておく
+ Beepオンが鳴ったときにESCでBIOS SETUP画面を表示

### BIOSのbootタグで「boot option#1」でDVDを設定する(UEFIがある方)

CentOS-7-x86_64-Minimal-1804.isoをUSBメモリで入れて行いました。

<img src="./images/2.bios-setup/1-main.png" width="30%">

<img src="./images/2.bios-setup/5-boot.png" width="30%">

<img src="./images/2.bios-setup/6-save-exit.png" width="30%">

## 3.CentOS7のインストール

### 1.インストールメニューで編集

「Install CentOS7」を選択した状態でeキー入力

<img src="./images/3.centos7-install/1-boot-menu.png" width="30%">

### 2.TEXTモードでインストール

「quiet」を削除し、「console=tty0 console=ttyS0,115200n8 inst.text」を入力し、Ctrl+x

<img src="./images/3.centos7-install/2-edit-command.png" width="30%">

### 3.インストールメニュー

<img src="./images/3.centos7-install/3-install-menu.png" width="30%">

### 3-1.timezoneの設定

2 -> 1(Set timezone) -> 2(Asia) -> ENTER -> 72(Tokyo)

<img src="./images/3.centos7-install/3_1_1-set-timezone.png" width="30%">

<img src="./images/3.centos7-install/3_1_2-select-timezone-asia.png" width="30%">

<img src="./images/3.centos7-install/3_1_3-select-timezone-tokyo.png" width="30%">

### 3-2.インストール先の選択

5 -> c(INTEL SSD...) -> c(Use All Space) -> c(LVM)

<img src="./images/3.centos7-install/3_2_1-installation-destination.png" width="30%">

<img src="./images/3.centos7-install/3_2_2-autopartitioning.png" width="30%">

<img src="./images/3.centos7-install/3_2_3-partition-scheme.png" width="30%">

### 3-3.rootパスワードの設定

8 -> root password入力

<img src="./images/3.centos7-install/3_3_1-root-password.png" width="30%">

### 3-4.インストールを開始

b(begin installation)

<img src="./images/3.centos7-install/3_4_1-begin-installation.png" width="30%">

### 3-5.インストール完了

<img src="./images/3.centos7-install/3_5-installation-complete.png" width="30%">

## 4.rootでログイン

<img src="./images/login.png" width="30%">

以上