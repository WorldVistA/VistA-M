ZOSVGUT2 ; VEN/SMH - Unit Tests for GT.M VistA Port;2018-06-06  1:11 PM
 ;;8.0;KERNEL;**10001,10002**;;Build 26
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Authored by Sam Habiel 2016.
 ;
STARTUP QUIT
 ;
SHUTDOWN ; 
 S $ZSOURCE="ZOSVGUT2"
 QUIT
 ;
NOOP ; @TEST Top doesn't do anything.
 D ^%ZOSV2
 D SUCCEED^%ut
 QUIT
 ;
SAVE1 ; @TEST Save a Routine normal
 N XCN,DIE
 S XCN=0,DIE=$$OREF^DILF($NA(^TMP($J)))
 K ^TMP($J)
 S ^TMP($J,$I(XCN),0)="KBANHELLO ; VEN/SMH - Sample Testing Routine"
 S ^TMP($J,$I(XCN),0)=" ;;"
 S ^TMP($J,$I(XCN),0)=";this is not supposed to be saved"
 S ^TMP($J,$I(XCN),0)=" WRITE ""HELLO WORLD"""
 S ^TMP($J,$I(XCN),0)=" QUIT"
 S XCN=0
 D SAVE^%ZOSV2("KBANHELLO")
 D CHKTF^%ut($T(+1^KBANHELLO)["VEN/SMH")
 D CHKTF^%ut($T(+2^KBANHELLO)[";;")
 D CHKTF^%ut($T(+3^KBANHELLO)["HELLO WORLD")
 D CHKTF^%ut($T(+4^KBANHELLO)["QUIT")
 D CHKTF^%ut($T(+3^KBANHELLO)'[$C(9)) ; no tabs
 D CHKTF^%ut($T(+4^KBANHELLO)'[$C(9)) ; no tabs
 QUIT
 ;
SAVE2 ; @TEST Save a Routine with syntax errors -- should not show.
 N XCN,DIE
 S XCN=0,DIE=$$OREF^DILF($NA(^TMP($J)))
 K ^TMP($J)
 S ^TMP($J,$I(XCN),0)="KBANHELLO ; VEN/SMH - Sample Testing Routine"
 S ^TMP($J,$I(XCN),0)=" ;;"
 S ^TMP($J,$I(XCN),0)=" WROTE ""HELLO WORLD"""
 S ^TMP($J,$I(XCN),0)=" W $P(""TEST"")"
 S ^TMP($J,$I(XCN),0)=" QUIT"
 S XCN=0
 N % S %=$$RETURN^%ZOSV("rm -f /tmp/kbanhello.mje",1)
 ; ZEXCEPT: SAVE,error,%ZOSV2,in,out,PASS
 J SAVE^%ZOSV2("KBANHELLO"):(error="/tmp/kbanhello.mje":in="/dev/null":out="/dev/null":PASS)
 F  H .001  Q:($$RETURN^%ZOSV("stat /tmp/kbanhello.mje",1)=0)
 D CHKTF^%ut(+$$RETURN^%ZOSV("wc -l /tmp/kbanhello.mje")=0)
 QUIT
 ;
LOAD ; @TEST Load Routine
 N XCN,DIE
 S XCN=0,DIE=$$OREF^DILF($NA(^TMP($J)))
 K ^TMP($J)
 S ^TMP($J,$I(XCN),0)="KBANHELLO ; VEN/SMH - Sample Testing Routine"
 S ^TMP($J,$I(XCN),0)=" ;;"
 S ^TMP($J,$I(XCN),0)=";this is not supposed to be saved"
 S ^TMP($J,$I(XCN),0)=" WRITE ""HELLO WORLD"""
 S ^TMP($J,$I(XCN),0)=" QUIT"
 S XCN=0
 D SAVE^%ZOSV2("KBANHELLO")
 N DIF
 K ^TMP($J)
 S DIF=$$OREF^DILF($NA(^TMP($J,"ROU")))
 D LOAD^%ZOSV2("KBANHELLO")
 D CHKTF^%ut(^TMP($J,"ROU",1,0)["KBANHELLO")
 D CHKTF^%ut(^TMP($J,"ROU",4,0)["QUIT")
 QUIT
 ;
RSUM ; @TEST Checksums
 D CHKTF^%ut($$RSUM^%ZOSV2("KBANHELLO"))
 D CHKTF^%ut($$RSUM2^%ZOSV2("KBANHELLO"))
 QUIT
 ;
TESTR ; @TEST Test existence of routine
 D CHKTF^%ut($$TEST^%ZOSV2("KBANHELLO")]"")
 QUIT
 ;
DELSUPER ; @TEST Test Super Duper Deleter
 H .01 ; Necessary so that object deletion would work
 D DEL^%ZOSV2("KBANHELLO")
 D CHKTF^%ut($T(+1^KBANHELLO)="")
 D CHKTF^%ut($$TEST^%ZOSV2("KBANHELLO")="")
 QUIT
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
 ; Create RSA certificate and private key w/ no password
 N %CMD
 S %CMD="openssl req -x509 -nodes -days 365 -sha256 -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -newkey rsa:2048 -keyout /tmp/mycert.key -out /tmp/mycert.pem"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 N CIPHERTEXT S CIPHERTEXT=$$RSAENCR^XUSHSH(SECRET,"/tmp/mycert.pem")
 D CHKTF^%ut($ZL(CIPHERTEXT)>$ZL(SECRET))
 N DECRYPTION S DECRYPTION=$$RSADECR^XUSHSH(CIPHERTEXT,"/tmp/mycert.key")
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
 S %CMD="openssl genrsa -aes128 -passout pass:monkey1234 -out /tmp/mycert.key 2048"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 S %CMD="openssl req -new -key /tmp/mycert.key -passin pass:monkey1234 -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -out /tmp/mycert.csr"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 S %CMD="openssl req -x509 -days 365 -sha256 -in /tmp/mycert.csr -key /tmp/mycert.key -passin pass:monkey1234 -out /tmp/mycert.pem"
 ;I $$VERSION^%ZOSV["arwin" S %CMD="openssl req -x509 -days 365 -sha256 -in /tmp/mycert.csr -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -key /tmp/mycert.key -passin pass:monkey1234 -out /tmp/mycert.pem"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 N CIPHERTEXT S CIPHERTEXT=$$RSAENCR^XUSHSH(SECRET,"/tmp/mycert.pem")
 D CHKTF^%ut($ZL(CIPHERTEXT)>$ZL(SECRET))
 N DECRYPTION S DECRYPTION=$$RSADECR^XUSHSH(CIPHERTEXT,"/tmp/mycert.key","monkey1234")
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
BROKER ; @TEST Test the new GT.M MTL Broker
 ; Old version died after first connection.
 ; NB: It DOES NOT WANT anything that's not IPv4.
 ; Hard to do on any modern computer that is hardwired to give you IPv6
 ; addressed for localhost.
 N PORT S PORT=58738
 ; ZEXCEPT: ZISTCP,XWBTCPM1
 J ZISTCP^XWBTCPM1(58738)
 N BROKERJOB S BROKERJOB=$ZJOB
 N % S %=$$TEST^XWBTCPMT("127.0.0.1",PORT)
 D CHKEQ^%ut(+%,1)
 N % S %=$$TEST^XWBTCPMT("127.0.0.1",PORT)
 D CHKEQ^%ut(+%,1)
 N % S %=$$TEST^XWBTCPMT("127.0.0.1",PORT)
 D CHKEQ^%ut(+%,1)
 N % S %=$$TEST^XWBTCPMT("127.0.0.1",PORT)
 D CHKEQ^%ut(+%,1)
 N % S %=$$RETURN^%ZOSV("$gtm_dist/mupip stop "_BROKERJOB)
 H .05 ; It doesn't die right away...
 D CHKTF^%ut('$ZGETJPI(BROKERJOB,"ISPROCALIVE"))
 W ! ; reset $X
 QUIT
 ;
ACTJPEEK ; @TEST Active Jobs using $$^%PEEKBYNAME("node_local.ref_cnt",...)
 Q:$T(^%PEEKBYNAME)=""
 N % S %=$$^%PEEKBYNAME("node_local.ref_cnt","DEFAULT")
 D CHKTF^%ut(%>1)
 QUIT
ACTJREG ; @TEST Active Jobs using current API
 K ^XUTL("XUSYS","CNT")
 N % S %=$$ACTJ^%ZOSV
 D CHKTF^%ut(%>1)
 QUIT
XTROU ;;
 ;;ZOSVGUT3
