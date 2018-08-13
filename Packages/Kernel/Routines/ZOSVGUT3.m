ZOSVGUT3 ; VEN/SMH - Unit Tests for GT.M VistA Port;2018-04-20  10:03 AM
 ;;8.0;KERNEL;**10002**;;Build 26
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Authored by Sam Habiel 2017.
STARTUP QUIT
 ;
SHUTDOWN ; 
 S $ZSOURCE="ZOSVGUT3"
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
 I $O(^AUTTSITE(0)) QUIT  ; RPMS no CAPRI!
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
 I $O(^AUTTSITE(0)) QUIT  ; RPMS no CAPRI!
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
 I $O(^AUTTSITE(0)) QUIT  ; RPMS no CAPRI!
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
 I '$$FIND1^DIC(3.2,,"QX","P-HFS/80/99999") QUIT  ; RPMS again
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
 I $O(^AUTTSITE(0)) QUIT  ; RPMS no CAPRI!
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
 ;  --- RPMS %ZISH enhancements unit tests ---
OPENRPMS ; @TEST Test RPMS OPEN^%ZISH (3 arg open)
 N POP
 N % S %=$$OPEN^%ZISH("/usr/include/","stdio.h","R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 D CHKEQ^%ut(%,0,"0 means success")
 U IO
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CHKTF^%ut(^TMP($J)>25)
 D CHKTF^%ut($D(^TMP($J,^TMP($J)-1)))
 K ^TMP($J)
 D CLOSE^%ZISH
 N %1 S %1=$$OPEN^%ZISH("/usr/include/","stdiolzkjalkjasdlfk.h","R")
 D CHKEQ^%ut(%1,1,"1 means failure")
 QUIT
 ;
DELRPMS ; @TEST Test RPMS DEL^%ZISH (reverse success, pass by value)
 I $$VERSION^%ZOSV(0)<6.1 QUIT  ; $ZCLOSE
 N POP
 D OPEN^%ZISH("/tmp/","sam-rpms-text.txt","W")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 W "BOO"
 D CLOSE^%ZISH
 D CHKEQ^%ut($$RETURN^%ZOSV("stat /tmp/sam-rpms-text.txt",1),0)
 N %1 S %1=$$DEL^%ZISH("/tmp/","sam-rpms-text.txt")
 D CHKEQ^%ut(%1,0)
 D CHKEQ^%ut($$RETURN^%ZOSV("stat /tmp/sam-rpms-text.txt",1),1)
 ;
 ; Try deleting non-sense RPMS style (triggers internal error trap which returns 1)
 N %2 S %2=$$DEL^%ZISH("/","pi-ka-boo-pikachu.txt")
 D CHKEQ^%ut(%2,1)
 QUIT
 ;
LISTRPMS ; @TEST Test LIST RPMS Version (2nd par is by value not by name)
 N PATH S PATH="/usr/include"
 N %RET
 N % S %=$$LIST^%ZISH(PATH,"std*",.%RET)
 N CNT,I
 S CNT=0,I=""
 F  S I=$O(%RET(I)) Q:I=""  S CNT=CNT+1
 D CHKTF^%ut(CNT'<3,1)
 D CHKEQ^%ut(%,0) ; Return 0 for success
 ;
 N PATH S PATH="/dsdfsadf/klasjdfasdf"
 N %RET
 N % S %=$$LIST^%ZISH(PATH,"*",.%RET)
 D CHKEQ^%ut(%,1) ; Return 1 for failure
 ;
 I $ZPARSE("$vista_home/r/")="" QUIT
 N %RET
 N % S %=$$LIST^%ZISH("$vista_home/r/","*",.%RET)
 N CNT,I
 S CNT=0,I=""
 F  S I=$O(%RET(I)) Q:I=""  S CNT=CNT+1
 D CHKTF^%ut(CNT>20000,4)
 D CHKEQ^%ut(%,0) ; Return 0 for success
 QUIT
 ;
SIZE ; @TEST $$SIZE^%ZISH
 N % S %=$$SIZE^%ZISH("/usr/include/","stdio.h")
 D CHKTF^%ut(%>1000)
 QUIT
 ;
MKDIR ; @TEST $$MKDIR^%ZISH
 N % S %=$$RETURN^%ZOSV("rm -r /tmp/foo/boo",1)
 D CHKTF^%ut(%=0)
 N % S %=$$MKDIR^%ZISH("/tmp/foo/boo")
 D CHKTF^%ut(%=0)
 N % S %=$$RETURN^%ZOSV("stat /tmp/foo/boo",1)
 D CHKTF^%ut(%=0)
 QUIT
 ;
WGETSYNC ; @TEST $$WGETSYNC^%ZISH on NDF DAT files
 N SEC1 S SEC1=$P($H,",",2)
 N % S %=$$WGETSYNC^%ZISH("foia-vista.osehra.org","Patches_By_Application/PSN-NATIONAL DRUG FILE (NDF)/PPS_DATS/","/tmp/foo/boo","*.DAT*")
 D CHKTF^%ut(%=0)
 N A,CURR S A("*")=""
 N % S %=$$LIST^%ZISH("/tmp/foo/boo","A","CURR")
 D CHKTF^%ut($D(CURR("PPS_0PRV_1NEW.DAT")))
 ; 
 ; Do it again. Should be faster.
 N SEC2 S SEC2=$P($H,",",2)
 N % S %=$$WGETSYNC^%ZISH("foia-vista.osehra.org","Patches_By_Application/PSN-NATIONAL DRUG FILE (NDF)/PPS_DATS/","/tmp/foo/boo","*.DAT*")
 N A,CURR S A("*")=""
 N % S %=$$LIST^%ZISH("/tmp/foo/boo","A","CURR")
 D CHKTF^%ut($D(CURR("PPS_0PRV_1NEW.DAT")))
 ;
 ; Remove a file and download again
 N SEC3 S SEC3=$P($H,",",2)
 N % S %=$$RETURN^%ZOSV("rm /tmp/foo/boo/PPS_2PRV_3NEW.DAT",1)
 D CHKTF^%ut(%=0)
 N % S %=$$WGETSYNC^%ZISH("foia-vista.osehra.org","Patches_By_Application/PSN-NATIONAL DRUG FILE (NDF)/PPS_DATS/","/tmp/foo/boo","*.DAT*")
 N A,CURR S A("*")=""
 N % S %=$$LIST^%ZISH("/tmp/foo/boo","A","CURR")
 D CHKTF^%ut($D(CURR("PPS_2PRV_3NEW.DAT")))
 ;
 D CHKTF^%ut((SEC3-SEC2)'>(SEC2-SEC1))
 QUIT
 ;
SEND ; @TEST Test SEND^%ZISH (NOOP)
 N % S %=$$SEND^%ZISH()
 D SUCCEED^%ut
 QUIT
 ;
SENDTO1 ; @TEST Test SENDTO1^%ZISH (NOOP)
 N % S %=$$SENDTO1^%ZISH()
 D SUCCEED^%ut
 QUIT
 ;
DF ; @TEST Test DF^%ZISH (Directory Format)
 N D S D="\var\db\vista"
 D DF^%ZISH(.D)
 D CHKEQ^%ut(D,"/var/db/vista/")
 QUIT
 ;
