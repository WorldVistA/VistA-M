ZOSVONUT ; VEN/SMH - Unit Tests for Cache Encryption Functions XUSHSH;2017-10-30  5:32 pm ; 10/30/17 2:52pm
 ;;8.0;KERNEL;**10001**;;Build 18
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Authored by Sam Habiel 2017
 ; This is a copy of ZOSVGUT2 modified to work on Cache
 ;
 D EN^%ut($t(+0),3)
 quit
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
 N % S %=$ZF(-1,%CMD)
 D CHKTF^%ut(%=0)
 N CIPHERTEXT S CIPHERTEXT=$$RSAENCR^XUSHSH(SECRET,"/tmp/mycert.pem")
 D CHKTF^%ut($L(CIPHERTEXT)>$L(SECRET))
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
 N % S %=$ZF(-1,%CMD)
 D CHKTF^%ut(%=0)
 S %CMD="openssl req -new -key /tmp/mycert.key -passin pass:monkey1234 -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -out /tmp/mycert.csr"
 N % S %=$ZF(-1,%CMD)
 D CHKTF^%ut(%=0)
 S %CMD="openssl req -x509 -days 365 -sha256 -in /tmp/mycert.csr -key /tmp/mycert.key -passin pass:monkey1234 -out /tmp/mycert.pem"
 ;I $$VERSION^%ZOSV["arwin" S %CMD="openssl req -x509 -days 365 -sha256 -in /tmp/mycert.csr -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -key /tmp/mycert.key -passin pass:monkey1234 -out /tmp/mycert.pem"
 N % S %=$ZF(-1,%CMD)
 D CHKTF^%ut(%=0)
 N CIPHERTEXT S CIPHERTEXT=$$RSAENCR^XUSHSH(SECRET,"/tmp/mycert.pem")
 D CHKTF^%ut($L(CIPHERTEXT)>$L(SECRET))
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
