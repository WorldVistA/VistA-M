ZOSVGUT2 ; VEN/SMH - Unit Tests for GT.M VistA Port;2017-09-10  12:16 PM
 ;;8.0;KERNEL;**10001**;;Build 18
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Authored by Sam Habiel 2016.
 ;
STARTUP QUIT
 ;
SHUTDOWN ; 
 S $ZSOURCE="ZOSVGUT1"
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
OPENH ; @TEST Read a Text File in w/ Handle
 ; OPEN^%ZISH([handle][,path,]filename,mode[,max][,subtype]) 
 N POP
 K ^TMP($J)
 D OPEN^%ZISH("FILE1","/usr/include/","stdio.h","R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 D USE^%ZISUTL("FILE1")
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CLOSE^%ZISH("FILE1")
 W !
 D CHKTF^%ut(^TMP($J)>25)
 D CHKTF^%ut($D(^TMP($J,^TMP($J)-1)))
 QUIT
 ;
OPENNOH ; @TEST Read a Text File w/o a Handle
 N POP
 K ^TMP($J)
 D OPEN^%ZISH(,"/usr/include/","stdio.h","R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CLOSE^%ZISH()
 W !
 D CHKTF^%ut(^TMP($J)>25)
 D CHKTF^%ut($D(^TMP($J,^TMP($J)-1)))
 QUIT
 ;
OPENBLOR ; @TEST Read a File as a binary device (FIXED WIDTH)
 N POP
 K ^TMP($J)
 D OPEN^%ZISH(,"/usr/include/","stdio.h","RB")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CLOSE^%ZISH()
 W !
 D CHKEQ^%ut($ZL(^TMP($J,5)),512,"Blocks are 512 bytes each")
 D CHKEQ^%ut($ZL(^TMP($J,5)),$ZL(^TMP($J,6)),"Blocks should all be the same size")
 QUIT
 ;
OPENBLOW ; @TEST Write a File as a binary device (Use Capri zip file in 316.18)
 N POP
 K ^TMP($J)
 N SUB S SUB=$O(^DVB(396.18,1,3,0))
 N FNNODE S FNNODE=^DVB(396.18,1,3,SUB,0)
 N L S L=$P(FNNODE," ",2)
 N FN S FN=$P(FNNODE," ",3)
 D OPEN^%ZISH(,$$DEFDIR^%ZISH(),FN,"WB",61)
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  S SUB=$O(^DVB(396.18,1,3,SUB)) Q:'SUB  W ^(SUB,0)
 D CLOSE^%ZISH()
 D OPEN^%ZISH(,$$DEFDIR^%ZISH(),FN,"RB",61)
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 N X R X:0
 D CLOSE^%ZISH()
 W !
 D CHKTF^%ut($L(X)=61,"record size isn't correct")
 QUIT
 ;
OPENBLOV ; @TEST Write and Read a variable record file
 N POP
 K ^TMP($J)
 N SUB S SUB=$O(^DVB(396.18,174,3,0))
 N FNNODE S FNNODE=^DVB(396.18,174,3,SUB,0)
 N L S L=$P(FNNODE," ",2)
 N FN S FN=$P(FNNODE," ",3)
 D OPEN^%ZISH(,$$DEFDIR^%ZISH(),FN,"W",61)
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  S SUB=$O(^DVB(396.18,174,3,SUB)) Q:'SUB  W ^(SUB,0),!
 D CLOSE^%ZISH()
 D OPEN^%ZISH(,$$DEFDIR^%ZISH(),FN,"R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 N X R X:0
 D CLOSE^%ZISH()
 W !
 D CHKTF^%ut($L(X)=61,"record size isn't correct")
 QUIT
 ;
OPENDF ; @TEST Open File from Default HFS Directory
 ; Uses the file from the last test.
 N POP
 N SUB S SUB=$O(^DVB(396.18,1,3,0))
 N FNNODE S FNNODE=^DVB(396.18,1,3,SUB,0)
 N L S L=$P(FNNODE," ",2)
 N FN S FN=$P(FNNODE," ",3)
 D OPEN^%ZISH(,,FN,"RB",61)
 D CHKTF^%ut(POP'=1)
 D CLOSE^%ZISH()
 QUIT
 ;
OPENSUB ; @TEST Open file with a Specific Subtype
 ; ZEXCEPT: IOM,IOSL
 N POP
 K ^TMP($J)
 D OPEN^%ZISH(,"/usr/include/","stdio.h","R",,"P-HFS/80/99999")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CHKTF^%ut(^TMP($J)>25)
 D CHKTF^%ut($D(^TMP($J,^TMP($J)-1)))
 D CHKTF^%ut(IOM=80)
 D CHKTF^%ut(IOSL=65500)
 D CLOSE^%ZISH()
 QUIT
 ;
OPENDLM ; @TEST Forget delimiter in Path
 N POP
 K ^TMP($J)
 D OPEN^%ZISH(,"/usr/include","stdio.h","R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CHKTF^%ut(^TMP($J)>25)
 D CHKTF^%ut($D(^TMP($J,^TMP($J)-1)))
 D CLOSE^%ZISH()
 QUIT
 ;
OPENAPP ; @TEST Open with appending
 N POP
 D OPEN^%ZISH(,,"test-for-sam.txt","W")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 W "TEST 1",!
 D CLOSE^%ZISH
 D OPEN^%ZISH(,,"test-for-sam.txt","WA")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 W "TEST 2",!
 D CLOSE^%ZISH
 D CHKTF^%ut($$RETURN^%ZOSV("wc -l "_$$DEFDIR^%ZISH()_"test-for-sam.txt | xargs | cut -d' ' -f1")=2)
 QUIT
 ;
PWD ; @TEST Get Current Working Directory
 D CHKTF^%ut($$PWD^%ZISH()=$ZD)
 QUIT
 ;
DEFDIR ; @TEST Default Directory
 N DEFDIR S DEFDIR=$$DEFDIR^%ZISH
 D CHKTF^%ut(DEFDIR["/tmp/"!(DEFDIR["/shm/"),"1")
 S DEFDIR=$$DEFDIR^%ZISH(".")
 D CHKTF^%ut(DEFDIR=$ZD,"2")
 S DEFDIR=$$DEFDIR^%ZISH("/usr/lib")
 D CHKTF^%ut($E(DEFDIR,$L(DEFDIR))="/","3")
 N OLDD S OLDD=$ZD
 S $ZD="/usr/"
 S DEFDIR=$$DEFDIR^%ZISH("./lib")
 D CHKTF^%ut(DEFDIR="/usr/lib/","4")
 S $ZD=OLDD
 D
 . N $ET,$ES S $ET="S $EC="""" D SUCCEED^%ut,UNWIND^%ZTER"
 . S DEFDIR=$$DEFDIR^%ZISH("/LKJASDLJ/ASLKDAIOUWRE/ASLK")
 QUIT
 ;
LIST ; @TEST LIST^%ZISH
 N PATH S PATH="/usr/include"
 N %ARR S %ARR("std*")=""
 N %RET
 N % S %=$$LIST^%ZISH(PATH,$NA(%ARR),$NA(%RET))
 N CNT,I
 S CNT=0,I=""
 F  S I=$O(%RET(I)) Q:I=""  S CNT=CNT+1
 D CHKTF^%ut(CNT'<3,1)
 D CHKTF^%ut(%,2)
 ;
 N PATH S PATH="/dsdfsadf/klasjdfasdf"
 N %ARR S %ARR("*")=""
 N %RET
 N % S %=$$LIST^%ZISH(PATH,$NA(%ARR),$NA(%RET))
 D CHKTF^%ut('%,3)
 ;
 I $ZPARSE("$vista_home/r/")="" QUIT
 N %ARR S %ARR("*")=""
 N %RET
 N % S %=$$LIST^%ZISH("$vista_home/r/",$NA(%ARR),$NA(%RET))
 N CNT,I
 S CNT=0,I=""
 F  S I=$O(%RET(I)) Q:I=""  S CNT=CNT+1
 D CHKTF^%ut(CNT>20000,4)
 D CHKTF^%ut(%,5)
 QUIT
 ;
MV ; @TEST MV^%ZISH
 N POP
 D OPEN^%ZISH(,,"test_for_sam2.txt","W")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 W "LINE1",!
 W "LINE2",!
 D CLOSE^%ZISH
 N % S %=$$MV^%ZISH(,"test_for_sam2.txt",,"test_for_sam3.txt")
 D OPEN^%ZISH(,,"test_for_sam3.txt","R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 E  D SUCCEED^%ut
 D CLOSE^%ZISH
 D OPEN^%ZISH(,,"test_for_sam2.txt","R")
 D CHKTF^%ut(POP)
 QUIT
 ;
FTGGTF ; @TEST $$FTG^%ZISH & $$GTF^%ZISH
 K ^TMP($J)
 N % S %=$$FTG^%ZISH("/usr/include","stdlib.h",$NA(^TMP($J,1,0)),2,"VVV")
 N LASTLINE S LASTLINE=$O(^TMP($J," "),-1)
 D CHKTF^%ut(LASTLINE>50,1)
 K ^TMP($J)
 N I F I=1:1:20 S $P(^TMP($J,I,0),"=",300)="="
 N % S %=$$GTF^%ZISH($NA(^TMP($J,1,0)),2,"/tmp/","test_long_records.glo")
 D CHKTF^%ut(%,2)
 D CHKTF^%ut($$RETURN^%ZOSV("stat /tmp/test_long_records.glo",1)=0,3)
 K ^TMP($J)
 N % S %=$$FTG^%ZISH("/tmp/","test_long_records.glo",$NA(^TMP($J,1,0)),2,"VVV")
 N LASTLINE S LASTLINE=$O(^TMP($J," "),-1)
 D CHKTF^%ut(LASTLINE=20,4)
 N VVV S VVV=0
 N I F I=0:0 S I=$O(^TMP($J,I)) Q:'I  I $D(^(I,"VVV")) S VVV=1
 D CHKTF^%ut(VVV=0,5)
 ;
 ; Test maximum length
 N MAX S MAX=$$MAXREC^%ZISH($NA(^TMP($J,1,0)))
 N A,B,C
 S $P(A,"=",MAX+20)="="
 S $P(B,"=",MAX+20)="="
 S $P(C,"=",MAX+20)="="
 D OPEN^%ZISH(,"/tmp/","test_overflow_records.glo","W")
 U IO W A,!,B,!,C,!
 D CLOSE^%ZISH()
 K ^TMP($J)
 N % S %=$$FTG^%ZISH("/tmp/","test_overflow_records.glo",$NA(^TMP($J,1,0)),2,"VVV")
 N VVV S VVV=0
 N I F I=0:0 S I=$O(^TMP($J,I)) Q:'I  I $D(^(I,"VVV")) S VVV=1
 D CHKTF^%ut(VVV=1,6)
 QUIT
 ;
GATF ; @TEST $$GATF^%ZISH
 N % S %=$$GATF^%ZISH($NA(^VA(200,1,0)),2,"/tmp/","test_append_records.glo")
 D CHKTF^%ut(%=1)
 N % S %=$$GATF^%ZISH($NA(^DIC(5,1,0)),2,"/tmp/","test_append_records.glo")
 D CHKTF^%ut(%=1)
 N % S %=$$GATF^%ZISH($NA(^DIC(4,1,0)),2,"/tmp/","test_append_records.glo")
 D CHKTF^%ut(%=1)
 N VA200,DIC5,DIC4
 S (VA200,DIC5,DIC4)=0
 K ^TMP($J)
 N % S %=$$FTG^%ZISH("/tmp/","test_append_records.glo",$NA(^TMP($J,1,0)),2)
 N I,Z F I=0:0 S I=$O(^TMP($J,I)) Q:'I  S Z=^(I,0) D
 . I Z["TASKMAN" S VA200=1 ; Taskman User
 . I Z["DOCTOR" S VA200=1  ; ditto, WV
 . I Z["CANADA" S DIC5=1   ; State File
 . I Z["VISN" S DIC4=1     ; Institution File
 . I Z["GALLUP" S DIC4=1   ; Ditto, for RPMS
 D CHKTF^%ut(VA200=1)
 D CHKTF^%ut(DIC5=1)
 D CHKTF^%ut(DIC4=1)
 QUIT
 ;
DEL1 ; @TEST DEL1^%ZISH
 ; Diabetes.pnl.zip
 ; test_append_records.glo
 ; test_for_sam3.txt
 ; test_long_records.glo
 ; test_overflow_records.glo
 ; test.sam
 N % S %=$$DEL1^%ZISH("/tmp/Diabetes.pnl.zip")
 D CHKTF^%ut(%=1)
 N % S %=$$DEL1^%ZISH("/tmp/test_append_records.glo")
 D CHKTF^%ut(%=1)
 N % S %=$$DEL1^%ZISH("/tmp/test_for_sam3.txt")
 D CHKTF^%ut(%=1)
 N % S %=$$DEL1^%ZISH("/tmp/test_long_records.glo")
 D CHKTF^%ut(%=1)
 N % S %=$$DEL1^%ZISH("/tmp/test_overflow_records.glo")
 D CHKTF^%ut(%=1)
 N % S %=$$RETURN^%ZOSV("stat /tmp/test_overflow_records.glo",1)
 D CHKTF^%ut(%'=0)
 QUIT
 ;
DEL ; @TEST Delete files we created in the tests
 I $$VERSION^%ZOSV(0)<6.1 QUIT  ; $ZCLOSE
 ;
 N DELARRAY
 S DELARRAY("test-for-sam.txt")=""
 ;
 N SUB S SUB=$O(^DVB(396.18,1,3,0))
 N FNNODE S FNNODE=^DVB(396.18,1,3,SUB,0)
 N FN S FN=$P(FNNODE," ",3)
 S DELARRAY(FN)=""
 ;
 N DIR S DIR=$$DEFDIR^%ZISH()
 ;
 N FULLPATH
 S FULLPATH=DIR_"test-for-sam.txt"
 N STATCMD S STATCMD="stat -t "
 I $$VERSION^%ZOSV(1)["Darwin" S STATCMD="stat -q "
 N % S %=$$RETURN^%ZOSV(STATCMD_FULLPATH,1)
 D CHKTF^%ut(%=0,1)
 S FULLPATH=DIR_FN
 N % S %=$$RETURN^%ZOSV(STATCMD_FULLPATH,1)
 D CHKTF^%ut(%=0,2)
 N % S %=$$DEL^%ZISH(DIR,$NA(DELARRAY))
 D CHKTF^%ut(%=1,2.5)
 S FULLPATH=DIR_"test-for-sam.txt"
 N % S %=$$RETURN^%ZOSV(STATCMD_FULLPATH,1)
 D CHKTF^%ut(%'=0,3)
 S FULLPATH=DIR_FN
 N % S %=$$RETURN^%ZOSV(STATCMD_FULLPATH,1)
 D CHKTF^%ut(%'=0,4)
 QUIT
 ;
DELERR ; @TEST Delete Error
 D
 . N $ET,$ES
 . D DELERR^%ZISH
 D SUCCEED^%ut
 QUIT
 ;
