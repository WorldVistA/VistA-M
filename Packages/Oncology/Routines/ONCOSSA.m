ONCOSSA ;WASH ISC/SRR,MLH-SURVIVAL ANALYSIS ;11/5/93  15:14
 ;;2.11;ONCOLOGY;**11,13,22**;Mar 07, 1995
 ;ONCOS - used to force responses to setup prompts:
 ;("F") = file name
 ;("T") = sort template
 ;("D") = duration field name^time unit letter^interval letter
 ;        e.g., "MOS FU^M^Y" for months followup, life table in years
 ;("S") = status expression
 ;("G") = number of groups^expression
 ;("G",n) = field number^title for nth group^expression, e.g., VAL(7)=0
 ;("L") = ] "P" for plots, "Y" to skip yes prompts
 ;("I") = IOP variable for %ZIS
PRINT ;entry point for qued report (%ZTLOAD)
 S U="^",%=0
 D GETFILE^ONCOSINP:'$D(ONCOS("FI")) G EX:$G(Y)<0 S FIL=ONCOS("FI"),FNUM=+FIL,GBL=U_$P(FIL,U,3)
 S FNUM=+ONCOS("FI") D GETTEMPL^ONCOSINP G:$G(Y)<0 EX S HEADER=$P(Y,U,2),TEMPL=+Y
 K ^TMP($J),IO("Q") D GET^ONCOSSA1 G:$G(Y)<0 EX ;get specs
 K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S ONCOLST="COND^COND(^FIL^FLDDAT(^FNUM^GBL^GRPEXP^HEADER^I^J^LEN^LENEXP^MAXTIME^MORTEXP^N^NGRPS^NM^ONCOS(^PLOT^TEMPL^VAL" D TASK G EX
 U IO D PRT D ^%ZISC K %ZIS,IOP G EX
PRT S (D0,NMORT,NDROP,NPG)=0,XCRT=$S(IOST?1"C".E:1,1:0) D:XCRT WAIT^DICD
 F N=1:1 S D0=$S(TEMPL:$O(^DIBT(TEMPL,1,D0)),1:$O(@(GBL_"D0)"))) Q:D0'?1N.N  D CTCASE
 S %DT="T",X="NOW" D ^%DT X ^DD("DD")
 S X=$P(@(GBL_"0)"),U,1)_$S(TEMPL:" Template "_HEADER,1:"")_" "
 S HEADER=X_U_$P(Y,"@",1)_"  "_$P(Y,"@",2)
 I NDROP W !!,$P(HEADER,U,1),?IOM-30,$P(HEADER,U,2) W !!,"Cases dropped:  ",NDROP,! D  I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y G EX
 .W !,"PATIENT",?30,"REASON FOR BEING DROPPED"
 .W !,"--------------------------",?30,"----------------------------"
 .S DROPD0=0 F  S DROPD0=$O(DROP(DROPD0)) Q:DROPD0'>0  D
 ..W !,$$GET1^DIQ(165.5,DROPD0,.025),"  ",$$GET1^DIQ(165.5,DROPD0,.02),?30,$P(DROP(DROPD0),U,1),?51,$P(DROP(DROPD0),U,2)
 S HEADER=HEADER_"    Page "
 S Y=0 F GRP=1:1:NGRPS S (CASES(GRP),INT(GRP))=0
 F GRP=0:0 S:GRP INTS(GRP)=Y S GRP=$O(^TMP($J,"LT",GRP)) Q:GRP=""  D SLOOP
 D PRINT^ONCOSSA3,PLOT^ONCOSSA4:PLOT,TOF^ONCOSSA3
EX K ^TMP($J)
 K CASES,COND,D0,FLDDAT,FNUM,GBL,GRP,GRPEXP,HEADER,INTS,LEN,LENEXP
 K MAXTIME,MORTEXP,N,NDROP,NGRPS,NMORT,NPG,NTOT,ONCOS,PLOT,POP,TEMPL
 K X,XCRT,Y,Z,DROP,DROPD0,DROPRSN
 Q
 ;
CTCASE ;count case
 N FLDNUM,GRP,IGRP,MORT,SLEN,VAL,DROPRSN
 S DROPRSN=""
 W:XCRT&(N#100=1) "." Q:'$D(@(GBL_"D0)"))  S FLDNUM=0
 F IGRP=1:1 S FLDNUM=$O(FLDDAT(FLDNUM)) Q:FLDNUM=""  D GETFLD S VAL(FLDNUM)=Y
 S @("MORT="_MORTEXP),@("SLEN="_LENEXP)
 I COND S @("GRP="_GRPEXP)
 E  S GRP=0 F IGRP=1:1:NGRPS I @COND(IGRP) S GRP=IGRP Q
 I GRP=0 D  G:DROPRSN'="" DROP
 .I $D(VAL(38.5)) S VAL=VAL(38.5),DROPRSN="STAGE GROUPING-AJCC^"_$S(VAL=0:0,VAL="U":"Unk/Uns",VAL="NA":"NA",1:VAL) Q
 .I $D(VAL(43)) S VAL=VAL(43),DROPRSN="TREATMENT^"_VAL
 I SLEN'=0 S SLEN=+SLEN I SLEN=0 S GRP=0,DROPRSN=$P($G(ONCOS("D")),U,1)_"^0"
DROP I GRP<1!(GRP>NGRPS) S NDROP=NDROP+1 S DROP(D0)=DROPRSN Q
 S:SLEN>MAXTIME SLEN=MAXTIME,MORT=0
 S:'$D(^TMP($J,"LT",GRP,SLEN\+LEN,MORT)) ^(MORT)=0 S ^(MORT)=^(MORT)+1
 I PLOT S:'$D(^TMP($J,"KM",GRP,SLEN,MORT)) ^(MORT)=0 S ^(MORT)=^(MORT)+1
 Q
 ;
GETFLD ;get field
 ;in:  D0,GBL,FLDNUM,FLDDAT
 ;out: Y
 S Y="",X=FLDDAT(FLDNUM)
 I +X,$D(@(GBL_"D0,$P(X,U,2))")) S Y=$P(^($P(X,U,2)),U,$P(X,U,3))
 I '(+X) X $P(X,U,2,99) S Y=X
 Q
 ;
SLOOP ;loop through data & sum totals
 S X=-1 F  S X=$O(^TMP($J,"LT",GRP,X)) Q:X=""  S Y=X D
 .I $D(^TMP($J,"LT",GRP,X,0)) S CASES(GRP)=CASES(GRP)+^(0)
 .I $D(^TMP($J,"LT",GRP,X,1)) S CASES(GRP)=CASES(GRP)+^(1),NMORT=NMORT+^(1)
 Q
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRT^ONCOSSA",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="ONCOLOGY STATISTICAL REPORT"
 F V2=1:1 S V1=$P(ONCOLST,"^",V2) Q:V1=""  S ZTSAVE(V1)=""
 S ZTSAVE("^TMP($J,")=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K V1,V2,ONCOLST,ZTSK Q
