ABSVTP ;VAMC ALTOONA/CTB_CLH - READ MASTER TAPE FROM AUSTIN ;4/4/00  8:48 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;**18**;JULY 6, 1994
 S X="!!I will be reading the tape/floppy disk distributed by the Austin DPC to load the Voluntary Service Master File." D MSG^ABSVQ
 D ^ABSVSITE I '% S X="The station number MUST be entered in the VOLUNTARY SERVICE SITE PARAMETER file.  Option Termiated with No Action*" D MSG^ABSVQ Q
 S DIR(0)="S^F:FLOPPY;T:9 TRACK TAPE",DIR("A")="Select Distribution Media Type" D ^DIR
 I $$DIR^ABSVU2 QUIT
 S MEDIA=Y
 S ABSVXA="Are you ready to down-load the Master File",ABSVXB="",%=1 D ^ABSVYN G:%'=1 OUT
 S ABSVXA="Is the "_$S(MEDIA="F":"floppy disk",1:"Tape")_" loaded and the drive on-line",ABSVXB="",%=1 D ^ABSVYN G:%'=1 OUT
 W !!,*7,"Use the following Parameters for reading this "_$S(MEDIA="F":"floppy disk",1:"Tape")
 W:MEDIA="T" !,?5,"DSM 11 and M11+  -  (""EBL"":158:1580)",!?5,"VAXDSM - (FORMAT=""EFL"":RECORDSIZE=158:BLOCKSIZE=1580)"
 W:MEDIA="F" !?5,"MSM - (""B:\VAVSLOAD.DAT"":""R"")",!
 ;READ TAPE SET ^TMP
 D ^%ZIS I POP D HOME^%ZIS QUIT
 S ABSVEOT=0,ABSVTAPE=IO,ABSVHOME=IO(0),ZY="",COUNT=0
LN S X="X^ABSVTP" S @^%ZOSF("TRAP") F I=1:1 D RD Q:'ABSVX  D A
 G EOT
OUT K %,ABSVXA,ABSVXB Q
A I MEDIA="F" S ZY=X D WR Q
 F J=1:1 Q:$L(X)=0  D
 . S NY=158-$L(ZY),ZY=ZY_$E(X,1,NY),X=$E(X,NY+1,2000)
 . I $L(ZY)=158 D WR
 . QUIT
 QUIT
WR S ^TMP("VOL1",$J,COUNT+1)=ZY,COUNT=COUNT+1 U ABSVHOME W !,"("_COUNT_") ",ZY S ZY=""
 Q
RD U ABSVTAPE R X:5  I '$T U ABSVHOME W !,"FATAL ERROR READING TAPE, PLEASE START OVER." K ^TMP("VOL1",$J) G H^XUS
 X ^%ZOSF("EOT") I Y S X=""
 S ABSVX=$S(X="":0,1:1)
 Q
EOT U ABSVHOME W !!,*7,"End of tape reached, will now rewind tape and build ^TMP.",!
 ;S X="X^ABSVTP" S @^%ZOSF("TRAP") U ABSVTAPE W @%MT("REW")
X ;S X="",@^%ZOSF("TRAP") S IOP=ABSVTAPE,ABSVEOT=1 D ^%ZIS
 D ^%ZISC S IOP="HOME" D ^%ZIS U IO K IOP
 S X="ERR^ZU" S @^%ZOSF("TRAP")
 G EN^ABSVTP1
