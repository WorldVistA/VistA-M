ZOSVONUT ; VEN/SMH - Unit Tests for Cache Encryption Functions XUSHSH;2017-10-30  5:32 pm ; 6/6/18 6:46am
 ;;8.0;KERNEL;**10001,10002**;;Build 26
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Authored by Sam Habiel 2017
 ; This is a copy of ZOSVGUT2 modified to work on Cache
 ;
 ; Windows Users:
 ; Openssl for Windows: https://slproweb.com/products/Win32OpenSSL.html - Restart Cache after install
 ; Wget for Windows: https://eternallybored.org/misc/wget/
 ;
 D EN^%ut($t(+0),3)
 quit
 ;
XUSHSH ; @TEST Top of XUSHSH
 N X S X="TEST"
 D ^XUSHSH
 D CHKTF^%ut(X="TEST")
 QUIT
 ;
SHA ; @TEST SHA-1 and SHA-256 in Hex and Base64
 D CHKEQ^%ut($$SHAHASH^XUSHSH(160,"test"),"A94A8FE5CCB19BA61C4C0873D391E987982FBBD3")
 D CHKEQ^%ut($$SHAHASH^XUSHSH(160,"test","H"),"A94A8FE5CCB19BA61C4C0873D391E987982FBBD3")
 D CHKEQ^%ut($$SHAHASH^XUSHSH(160,"test","B"),"qUqP5cyxm6YcTAhz05Hph5gvu9M=")
 D CHKEQ^%ut($$SHAHASH^XUSHSH(256,"test"),"9F86D081884C7D659A2FEAA0C55AD015A3BF4F1B2B0B822CD15D6C15B0F00A08")
 QUIT
 ;
BASE64 ; @TEST Base 64 Encode and Decode
 D CHKEQ^%ut($$B64ENCD^XUSHSH("test"),"dGVzdA==")
 D CHKEQ^%ut($$B64DECD^XUSHSH("dGVzdA=="),"test")
 QUIT
 ;
RSAENC ; @TEST Test RSA Encryption
 N SECRET S SECRET="Alice and Bob had Sex!"
 ;
 N TD S TD=$$DEFDIR^%ZISH()
 ;
 ; Create RSA certificate and private key w/ no password
 N %CMD
 S %CMD="openssl req -x509 -nodes -days 365 -sha256 -subj ""/C=US/ST=Washington/L=Seattle/CN=www.smh101.com"" -newkey rsa:2048 -keyout "_TD_"mycert.key -out "_TD_"mycert.pem"
 N % S %=$ZF(-1,%CMD)
 D CHKTF^%ut(%=0)
 N CIPHERTEXT S CIPHERTEXT=$$RSAENCR^XUSHSH(SECRET,TD_"mycert.pem")
 D CHKTF^%ut($L(CIPHERTEXT)>$L(SECRET))
 N DECRYPTION S DECRYPTION=$$RSADECR^XUSHSH(CIPHERTEXT,TD_"mycert.key")
 D CHKEQ^%ut(SECRET,DECRYPTION)
 ;
 ; Create RSA certificate and private key with a password
 ; Apparently, no way to do all of this in a single line in openssl; have to do
 ; it the traditional way: key, CSR, Cert.
 ; VEN/SMH - For some reason, the darwin command doesn't create the
 ; certificate when running from inside GT.M; it does okay in Bash.
 ; So, for now, let's just disable this check on Darwin; I don't have time
 ; for this shit.
 I $$VERSION^%ZOSV(1)["Darwin" QUIT
 I $$VERSION^%ZOSV(1)["CYGWIN" QUIT
 ;
 N %CMD
 S %CMD="openssl genrsa -aes128 -passout pass:monkey1234 -out "_TD_"mycert.key 2048"
 N % S %=$ZF(-1,%CMD)
 D CHKTF^%ut(%=0)
 S %CMD="openssl req -new -key "_TD_"mycert.key -passin pass:monkey1234 -subj ""/C=US/ST=Washington/L=Seattle/CN=www.smh101.com"" -out "_TD_"mycert.csr"
 N % S %=$ZF(-1,%CMD)
 D CHKTF^%ut(%=0)
 S %CMD="openssl req -x509 -days 365 -sha256 -in "_TD_"mycert.csr -key "_TD_"mycert.key -passin pass:monkey1234 -out "_TD_"mycert.pem"
 ;I $$VERSION^%ZOSV["arwin" S %CMD="openssl req -x509 -days 365 -sha256 -in /tmp/mycert.csr -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -key /tmp/mycert.key -passin pass:monkey1234 -out /tmp/mycert.pem"
 N % S %=$ZF(-1,%CMD)
 D CHKTF^%ut(%=0)
 N CIPHERTEXT S CIPHERTEXT=$$RSAENCR^XUSHSH(SECRET,TD_"mycert.pem")
 D CHKTF^%ut($L(CIPHERTEXT)>$L(SECRET))
 N DECRYPTION S DECRYPTION=$$RSADECR^XUSHSH(CIPHERTEXT,TD_"mycert.key","monkey1234")
 D CHKEQ^%ut(SECRET,DECRYPTION)
 QUIT
 ;
AESENC ; @TEST Test AES Encryption
 N SECRET S SECRET="Alice and Bob had Sex!"
 N X S X=$$AESENCR^XUSHSH(SECRET,"ABCDABCDABCDABCD","DCBADCBADCBADCBA")
 N Y S Y=$$AESDECR^XUSHSH(X,"ABCDABCDABCDABCD","DCBADCBADCBADCBA")
 D CHKEQ^%ut(SECRET,Y)
 QUIT
 ;
SIZE ; @TEST $$SIZE^%ZISH
 N OS S OS=$$OS^%ZOSV
 N %
 I OS="UNIX" S %=$$SIZE^%ZISH("/usr/include/","stdio.h")
 I OS="NT"   S %=$$SIZE^%ZISH("c:\windows\system32\","cmd.exe")
 D CHKTF^%ut(%>1000)
 QUIT
 ;
MKDIR ; @TEST $$MKDIR^%ZISH for Unix
 N OS S OS=$$OS^%ZOSV
 I OS'="UNIX" QUIT
 N % S %=$$RETURN^%ZOSV("rm -r /tmp/foo/boo",1)
 D CHKTF^%ut(%=0)
 N % S %=$$MKDIR^%ZISH("/tmp/foo/boo")
 D CHKTF^%ut(%=0)
 N % S %=$$RETURN^%ZOSV("stat /tmp/foo/boo",1)
 D CHKTF^%ut(%=0)
 QUIT
 ;
MDWIN ; @TEST $$MKDIR^%ZISH for Windows
 N OS S OS=$$OS^%ZOSV
 I OS'="NT" QUIT
 N % S %=$$RETURN^%ZOSV("rmdir /s /q %temp%\foo",1)
 N % S %=$$MKDIR^%ZISH("%temp%\foo\boo")
 D CHKTF^%ut(%=0)
 N % S %=$$RETURN^%ZOSV("dir %temp%\foo\boo",1)
 D CHKTF^%ut(%=0)
 QUIT
 ;
WGETSYNC ; @TEST $$WGETSYNC^%ZISH on NDF DAT files for Unix and Windows
 N OS S OS=$$OS^%ZOSV
 N FOLDER
 I OS="UNIX" S FOLDER="/tmp/foo/boo"
 n temp s temp=$System.Util.GetEnviron("TEMP")
 I OS="NT" S FOLDER=temp_"\foo\boo"
 N SEC1 S SEC1=$P($H,",",2)
 N % S %=$$WGETSYNC^%ZISH("foia-vista.osehra.org","Patches_By_Application/PSN-NATIONAL DRUG FILE (NDF)/PPS_DATS/",FOLDER,"*.DAT*")
 D CHKTF^%ut(%=0)
 N A,CURR S A("*")=""
 N % S %=$$LIST^%ZISH(FOLDER,"A","CURR")
 D CHKTF^%ut($D(CURR("PPS_0PRV_1NEW.DAT")))
 ;
 ; Do it again. Should be faster.
 N SEC2 S SEC2=$P($H,",",2)
 N % S %=$$WGETSYNC^%ZISH("foia-vista.osehra.org","Patches_By_Application/PSN-NATIONAL DRUG FILE (NDF)/PPS_DATS/",FOLDER,"*.DAT*")
 N A,CURR S A("*")=""
 N % S %=$$LIST^%ZISH(FOLDER,"A","CURR")
 D CHKTF^%ut($D(CURR("PPS_0PRV_1NEW.DAT")))
 ;
 ; Remove a file and download again
 N SEC3 S SEC3=$P($H,",",2)
 I OS="UNIX" N % S %=$$RETURN^%ZOSV("rm /tmp/foo/boo/PPS_2PRV_3NEW.DAT",1)
 I OS="NT"   N % S %=$$RETURN^%ZOSV("del /q /f %temp%\foo\boo\PPS_2PRV_3NEW.DAT",1)
 D CHKTF^%ut(%=0)
 N % S %=$$WGETSYNC^%ZISH("foia-vista.osehra.org","Patches_By_Application/PSN-NATIONAL DRUG FILE (NDF)/PPS_DATS/",FOLDER,"*.DAT*")
 N A,CURR S A("*")=""
 N % S %=$$LIST^%ZISH(FOLDER,"A","CURR")
 D CHKTF^%ut($D(CURR("PPS_2PRV_3NEW.DAT")))
 ;
 D CHKTF^%ut((SEC3-SEC2)'>(SEC2-SEC1))
 QUIT
