MCDUPR ;WASH/DCB-Reporting of the duplicates ;5/16/96  15:39
 ;;2.3;Medicine;;09/13/1996
START ;
 N POP,%ZIS,ZTSAVE,ZTRTN,ZTDESC,ZTSK
 W @IOF
 K IO("Q") S %ZIS="MQ",%ZIS("B")="Q",%ZIS("A")="This report should be captured on a printer for documentation purposes!!  " D ^%ZIS I POP Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="MAIN^MCDUPR"
 . S ZTSAVE("^TMP($J,""DUP"",")=""
 . S ZTDESC="Removal of Duplication for Medicine"
 . D ^%ZTLOAD K ZTSK
 . Q
 D MAIN
 Q
MAIN ;
 U IO
 I $E(IOST,1,2)="C-" W @IOF
 I $D(^TMP($J,"DUP")) D RPT1,RPT2,^%ZISC
 Q
RPT1 ;Duplicate Static File Entries
 N PGE,CNT,MCNT S (CNT,MCNT)=0 D RPT1H,RPT1M,RPT1F Q
RPT2 ;Pointing to Duplicates
 N PGE,CNT,MCNT,SCNT,S1CNT S (CNT,MCNT,SCNT,S1CNT)=0 D RPT2H,RPT2MA,RPT2F Q
 ;----------------------------------------------
RPT1H ;Header for Duplicate Static File Entries
 N TEMP S TEMP="" S $P(TEMP,"-",80)=""
 W:$G(PGE) @IOF S PGE=$G(PGE)+1
 W "Report 1",?20,"Duplicate Static File Entries",?60,"Page: ",PGE,!
 W !,"STATIC",?8,"STATIC FILE",?35,"DUPLICATE ENTRY"
 W !,"FILE #",?8,"    NAME   ",?35,"IEN",?40,"KEY",!,TEMP,!
 Q 
RPT1M ;Duplicate Static File Entries Main
 N FILE,FILENAME,TMP,SIZE S SIZE=IOM-40
 S FILE="" F  S FILE=$O(^TMP($J,"DUP","F",FILE)) Q:FILE=""  D
 .S FILENAME=$$GET1^DID(FILE,"","","NAME"),MCNT=$G(MCNT)+1
 .S FILENAME=$E(FILENAME,1,26)
 .I ^TMP($J,"DUP","F",FILE)=0 W $$TST("RPT1H",1),FILE,?8,FILENAME,?35,"**** No Duplicates ****" Q
 .S TMP="" F  S TMP=$O(^TMP($J,"DUP","I",FILE,TMP)) Q:TMP=""  D RPT1A(FILE,TMP,FILENAME,SIZE)
 Q
RPT1A(FILE,TMP,FILENAME,SIZE) ;
 N LOOP,REC,REC2,TEMP,LINES,MULTI,TEXT,BEG,END
 S REC="" F  S REC=+$O(^TMP($J,"DUP","I",FILE,TMP,REC)) Q:REC=0  D
 .Q:'$D(^TMP($J,"DUP","I",FILE,TMP,REC,1))
 .Q:$P(^TMP($J,"DUP","I",FILE,TMP,REC,1),U,2)="*"
 .F LOOP=1:1 S REC2=$P($G(^TMP($J,"DUP","I",FILE,TMP,REC,1)),U,LOOP) Q:REC2="*"  D
 ..S TEMP=^TMP($J,"DUP","I",FILE,TMP,REC2,0),CNT=$G(CNT)+1
 ..S TEXT=TMP_TEMP
 ..W $$TST("RPT1H",1),FILE,?8,FILENAME,?35,REC2,?40,$E(TEXT,1,SIZE)
 ..I $L(TEXT)>SIZE D
 ...S LINES=$L(TEXT)\SIZE
 ...F MULTI=1:1:LINES D
 ....S BEG=SIZE*MULTI+1,END=BEG+SIZE S:END>$L(TEXT) END=$L(TEXT)
 ....W $$TST("RPT1H",1),?40,$E(TEXT,BEG,END)
 Q
RPT1F ;Duplicate Static File Entries
 N TEMP,DIR S TEMP="" S $P(TEMP,"-",80)=""
 W "FILES: ",$$TST("RPT1H",3),TEMP,!,"TOTALS",!,"FILES: ",MCNT,?35,"DUPLICATES: ",$G(CNT)
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR
 W @IOF
 Q
 ;-------------------------------------------------------------------
RPT2H ;Header for Pointing to Duplicates
 N TEMP S TEMP="" S $P(TEMP,"-",80)=""
 W:$G(PGE) @IOF S PGE=$G(PGE)+1
 W "Report 2",?20,"Pointing to Duplicates",?60,"Page: ",PGE,!
 W !,?56,"SUB",?64,"SUB"
 W !,"STATIC",?8,"OLD",?16,"NEW",?24,"FROM  ",?32,"MAIN",?40,"SUB",?48,"SUB",?56,"SUB",?64,"SUB"
 W !,"FILE #",?8,"IEN",?16,"IEN",?24,"FILE #",?32,"IEN ",?40,"FILE",?48,"IEN",?56,"FILE",?64,"IEN"
 W !,TEMP,!
 Q
RPT2MA ;Main Print for Pointing to Duplicates
 N FILE,TMP,TEMP,NIEN,OIEN,EX
 S FILE="" F  S FILE=$O(^TMP($J,"DUP","F",FILE)) Q:FILE=""  D
 .Q:^TMP($J,"DUP","F",FILE)=0
 .Q:'$D(^TMP($J,"DUP","J",FILE))
 .S CNT=$G(CNT)+1,TMP=""
 .F  S TMP=$O(^TMP($J,"DUP","J",FILE,TMP)) Q:TMP=""  D
 ..S TEMP=^TMP($J,"DUP","J",FILE,TMP,1),OIEN=^TMP($J,"DUP","J",FILE,TMP,"OLD"),NIEN=^TMP($J,"DUP","J",FILE,TMP,"NEW")
 ..S EX="D RPT2"_$P(TEMP,U)_"(FILE,TEMP,OIEN,NIEN)"
 ..X EX
 Q
RPT2M(SFILE,TEMP,OIEN,NIEN) ;Pointing to with a Main File
 N MAINFILE,MAINREC S (MAINFILE,MAINREC)=""
 D RPT2B(TEMP,.MAINFILE,.MAINREC)
 W $$TST("RPT2H",1),SFILE,?8,OIEN,?16,NIEN,?24,MAINFILE,?32,MAINREC,?40,"N/A"
 Q
RPT2S(SFILE,TEMP,OIEN,NIEN) ;Pointing to with Sub-File
 N MAINFILE,MAINREC,SUBFILE,SUBREC S (MAINFILE,MAINREC,SUBFILE,SUBREC)=""
 D RPT2B(TEMP,.MAINFILE,.MAINREC),RPT2C(TEMP,.SUBFILE,.SUBREC)
 W $$TST("RPT2H",1),SFILE,?8,OIEN,?16,NIEN,?24,MAINFILE,?32,MAINREC,?40,SUBFILE,?48,SUBREC
 Q
RPT2SS(SFILE,TEMP,OIEN,NIEN) ;Pointing to with sub-file within sub-file
 N MAINFILE,MAINREC,SUBFILE,SUBREC,SUBFILE1,SUBREC1 S (MAINFILE,MAINREC,SUBFILE,SUBREC)=""
 D RPT2B(TEMP,.MAINFILE,.MAINREC),RPT2C(TEMP,.SUBFILE,.SUBREC)
 S SUBFILE=$P(TEMP,U,6),SUBREC=$P(TEMP,U,7)
 S SUBFILE1=$P(TEMP,U,10),SUBREC1=$P(TEMP,U,11)
 W $$TST("RPT2H",1),SFILE,?8,OIEN,?16,NIEN,?24,MAINFILE,?32,MAINREC,?40,SUBFILE1,?48,SUBREC1,?56,SUBFILE,?64,SUBREC S S1CNT=$G(S1CNT)+1
 Q
RPT2B(TEMP,MFILE,MREC) ;Get main file and main record
 S MFILE=$P(TEMP,U,2),MREC=$P(TEMP,U,3),MCNT=$G(MCNT)+1
 Q
RPT2C(TEMP,SFILE,SREC) ;Get Sub-file and sub-record
 S SFILE=$P(TEMP,U,6),SREC=$P(TEMP,U,7),SCNT=$G(SCNT)+1
 Q
RPT2F ;Footer for Pointing to Duplicates
 N TEMP,DIR S TEMP="" S $P(TEMP,"-",80)=""
 W $$TST("RPT2H",3),TEMP
 W !,"TOTALS:",!,?2,$G(CNT),?24,$G(MCNT),?40,$G(SCNT),?56,$G(S1CNT)
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR
 W @IOF
 Q
TST(RTN,SKIP) ;Checks $Y and does formfeed if needed and skips the new lines
 N LINE,DIR
 I ($Y+SKIP+$S($E(IOST,1,2)="C-":2,1:4))>IOSL D
 .I $E(IOST,1,2)="C-" S DIR(0)="E",DIR("A")="Press RETURN to continue: " D ^DIR
 .D @RTN S SKIP=1
 F LINE=1:1:SKIP W !
 Q ""
