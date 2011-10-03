ONCOSCT ;Hines OIFO/GWB,RTK - CROSS TABULATE ;9/3/93
 ;;2.11;ONCOLOGY;**23,30,43**;Mar 07, 1995
IN ;DIRECT CALL set ONCOS("D")=1
 ;in:  ^DIBT,^DIPT
 ;ONCOS - used to force responses to setup prompts
 ;("F") = file number
 ;("T") = search template
 ;("R") = row field name^cutpoints, e.g., "AGE^10:20:30:40"
 ;("C") = column field name^cutpoints
 ;("P") = 1 to print total per cents, 0 to skip prompt
 ;("Y") = yes prompts
 ;("I") = IOP variable for %ZIS
 ;("H") = HEADER (if defined, not asked for in ONCOSCINP)
 ;("D") = Direct Program call, not entered at Print
 ;do: ^ONCOSINP,^ONCOSCT*,WAIT^DICD,^%DT,^%ZIS
 S ONCOS("D")=1 W !,"ONCOLOGY Version 2 - Cross-tabs",! ;S:'$D(DTIME) DTIME=1000
PRINT ;entry point for queued report (%ZTLOAD)
 S:$D(ONCOION) ION=ONCOION S:$D(ONCOIOM) IOM=ONCOIOM
 W !! S (ROWDEF,TEMPL)=-1,UNK="~",XCRT=$S($G(IOST)?1"C".E:1,1:0),%=0 D GETFILE^ONCOSINP:'$D(ONCOS("FI"))
 S FNUM=+ONCOS("FI") I '$D(ONCOS("T")) D GETTEMPL^ONCOSINP G EX:'Y S ONCOS("T")=Y G EN
 I ONCOS("T")'["^" D GETTEMPL^ONCOSINP G EX:Y<0 S ONCOS("T")=Y
EN S ONCOEX=0,TEMPL=ONCOS("T"),TEMPL=$S(TEMPL="ALL":TEMPL,1:+TEMPL),HEAD=$G(ONCOS("H")),HEADER=$S(HEAD="":$P(ONCOS("T"),U,2),1:HEAD)
 S FNUM=+ONCOS("FI"),GLO="^"_$P(ONCOS("FI"),U,3) D SETUP^ONCOSCT1 G EX:ROWDD=""!(ONCOEX)
 G CON:$D(ONCOS("TK")) I '$D(ONCOS("AF")) S ONCOS("AF")=1
 K IO("Q") S %ZIS="Q",%ZIS("A")="     Select device to Print Cross Tabs: " D ^%ZIS I POP S ONCOUT="" G EX
 I '$D(IO("Q")) D TSK^ONCOSCT G EX
 S ZTRTN="TSK^ONCOSCT",ZTDESC=HEADER
 S ZTSAVE("ONCOS*")=""
 S ZTSAVE("TEMPL")="",ZTSAVE("XCRT")="",ZTSAVE("UNK")=""
 S ZTSAVE("COLCUTS")="",ZTSAVE("ROWCUTS")=""
 S ZTSAVE("COLDD")="",ZTSAVE("ROWDD")=""
 S ZTSAVE("PCT")="",ZTSAVE("HEADER")=""
 D ^%ZTLOAD G EX
 ;
TSK ;Task for internal direct calling of ONCOSCT, not from another task.
 K ^TMP($J) S ONCOEX=0 S:'$D(ONCOS("AF")) ONCOS("AF")=1
 S XCRT=$S($G(IOST)?1"C".E:1,1:0)
 D WAIT^DICD:XCRT
CON W ! S %DT="T",X="NOW" D ^%DT X ^DD("DD") S GBL="^"_$P(ONCOS("FI"),U,3)
 S HEADER=HEADER_U_$P(Y,"@",1)_"  "_$P(Y,"@",2),(D0,NPG,TOT)=0
TEM I TEMPL'="ALL" S D0=0 F N=1:1 S D0=$O(^DIBT(TEMPL,1,D0)) G OUT:D0'>0 D CTCASE
 F N=1:1 S D0=$O(@(GBL_"D0)")) Q:D0'>0  D CTCASE
OUT ;OUTPUT
 S ONCOEX=0 D OUTPUT^ONCOSCT2 G EX:ONCOEX G EX:'$D(ONCOS("TK"))
KIL ;Entry point to kill all variables at EXCEPT 'ONCOS' ARRAY
 K ^TMP($J)
 K COLCUTS,COLDD,COLPIECE,COLS,COLSUB,D0,FNUM
 K GLB,GLO,HEAD,HEADER,N,NPG,PCT,POP,B,C,F,XX,Y,Z
 K ROWCUTS,ROWS,ROWDD,ROWPIECE,ROWSUB,TEMPL,TOT,UNK,X,XCRT
 K %,%DT,%K,%T,%ZISOS,HEAD,OF
 Q
 ;
EX ;Complete Exit
 D KIL K ONCOS K:$D(ONCOS("D")) ONCOEX D ^%ZISC Q
CTCASE ;count case
 ;in:  COLCUTS,COLDD,COLPIECE,COLSUB,D0,GBL,N,ONCOS,TOT
 ;     ROWCUTS,ROWDD,ROWPIECE,ROWSUB,UNK,XCRT
 ;out: ^TMP($J,"CELL"),TOT
 N R,C
 S:COLDD]"" X=$P(COLDD,U,4),COLPIECE=$P(X,";",2),COLSUB=+X
 S X=$P(ROWDD,U,4),ROWPIECE=$P(X,";",2),ROWSUB=+X
 W:XCRT&(N#100=1) "." Q:'$D(@(GBL_"D0)"))  S TOT=TOT+1,(R,C)=UNK
 I $P(ROWDD,U,2)'["C" S:$D(@(GBL_"D0,ROWSUB)"))#10=1 R=$P(@(GBL_"D0,ROWSUB)"),U,ROWPIECE)
 E  X $P(ROWDD,U,5,99) S Y=X D:$P(ROWDD,U,2)["D" DD^%DT S X=Y S R=X
 I COLDD="" S C=1 G CT1
 I $P(COLDD,U,2)'["C" S:$D(@(GBL_"D0,COLSUB)"))#10=1 C=$P(@(GBL_"D0,COLSUB)"),U,COLPIECE)
 E  X $P(COLDD,U,5,99) S Y=X D:$P(COLDD,U,2)["D" DD^%DT S X=Y S C=X
CT1 I C="" S C=UNK
 E  I COLCUTS]"" S X=C F C=1:1:$L(COLCUTS,":") I X'>$P(COLCUTS,":",C) Q
 I R="" S R=UNK
 E  I ROWCUTS]"" S X=R F R=1:1:$L(ROWCUTS,":") I X'>$P(ROWCUTS,":",R) Q
TT I '$D(^TMP($J,"CELL",R,C)) S ^TMP($J,"CELL",R,C)=1 Q
 S ^(C)=^TMP($J,"CELL",R,C)+1
 Q
