TIUABBVP ;BPOIFO/JLTP - Print Functions ;11/09/2015
 ;;1.0;TEXT INTEGRATION UTILITIES;**297**;JUN 20, 1997;Build 40
 ;
 ; External Reference DBIA#:
 ; -------------------------
 ; #10086 - %ZIS call (Supported)
 ; #10089 - %ZISC call (Supported) 
 ; #10063 - %ZTLOAD call (Supported)
 ; #999 - DD reference (Controlled Subscription)
 ; #10026 - DIR call (Supported)
 ; #10103 - XLFDT call (Supported)
 ; #10104 - XLFSTR call (Supported)
 ;
LA ; List All
 N INACT
 W ! D LI Q:'$D(INACT)
 D:$$DEV("DQ1^TIUABBVP","INACT","List of Unauthorized Abbreviations") DQ1
 Q
DQ1 ; List of Unauthorized Abbreviations
 U IO K ^TMP($J) N ABBV,ACT,CLS,DESC,DLINE,H1,H2,IFN,LINE,MCH,STOP,X,Y
 S (STOP,IFN)=0 F  S IFN=$O(^TIU(8927.9,IFN)) Q:'IFN  D
 .S X=^TIU(8927.9,IFN,0),ABBV=$P(X,U),CLS=$P(X,U,2),MCH=$P(X,U,3),ACT=$P(X,U,4),DESC=$P(X,U,5)
 .I ACT]"" S ^TMP($J,ACT,$$UP^XLFSTR(ABBV),IFN)=ABBV_U_CLS_U_MCH_U_DESC
 D P1("A","Active Unauthorized Abbreviations","No active entries on file.") D:'$G(STOP) PG
 I INACT,'$G(STOP) D P1("I","Inactive Unauthorized Abbreviations","No inactive entries on file.") D:'$G(STOP) PG
 K ^TMP($J) D ^%ZISC
 Q
P1(ACT,H1,NONE) ; Print one STATUS
 N ABBV,CLASS,EXACT,IFN,LINE,NOTE,REC,UABBV
 S $P(LINE,"-",IOM)="" D DHD
 I '$D(^TMP($J,ACT)) W !,NONE,!
 S UABBV="" F  S UABBV=$O(^TMP($J,ACT,UABBV)) Q:UABBV=""!($G(STOP))  D
 .S IFN=0 F  S IFN=$O(^TMP($J,ACT,UABBV,IFN)) Q:'IFN!($G(STOP))  S REC=^(IFN) D
 ..I $Y>(IOSL-5) D:$E(IOST)="C" PG Q:STOP  D DHD
 ..S ABBV=$P(REC,U),CLASS=$P(REC,U,2),EXACT=$P(REC,U,3),NOTE=$P(REC,U,4)
 ..W !,ABBV,?32,$$SET(CLASS,.02),?52,$$SET(EXACT,.03),!?3,"Note: ",NOTE
 ..W !,LINE
 Q
DHD ; Report Heading
 ;;Abbreviation                    Class               Exact Match
 N PRTTIM,DLINE,H2
 S $P(DLINE,"=",IOM)="",H2=$P($T(DHD+1),";;",2),PRTTIM=$$FMTE^XLFDT($$NOW^XLFDT,5)
 S PRTTIM=$P(PRTTIM,"@")_" @"_$P(PRTTIM,"@",2)
 W @IOF W !,$$CNTR(H1),!
 W $$CNTR("Printed: "_PRTTIM),!!,H2,!,DLINE
 Q
PG ; Stop for page break
 N X,Y
 I $E(IOST)="C" S DIR(0)="E" D ^DIR S STOP='Y W @IOF
 I $E(IOST)'="C" S STOP=0
 Q
CNTR(X) ; Center X based on IOM
 N LM,Y S LM=(IOM\2)-($L(X)\2),Y="",$P(Y," ",LM)=""
 Q Y_X
SET(INT,FLD) ; Get External Set-of-Codes Value
 N DD,I,P,VAL
 S DD=$P(^DD(8927.9,FLD,0),U,3),VAL=""
 F I=1:1 S P=$P(DD,";",I) Q:'$L(P)  I $P(P,":")=INT S VAL=$P(P,":",2) Q
 Q VAL
WR(X,LMARG,WIDTH) ; Word wrap
 N I,SIZ,Y
 S SIZ=WIDTH-LMARG-1,I=$L(X)
 F  Q:$L(X)<1  D:$L(X)>SIZ  W ?LMARG,X S X=$E(X,I+1,$L(X))
 .F I=SIZ:-1 Q:I<1  Q:$E(X,I)?1P
 .S:I<1 I=SIZ S Y=$E(X,1,I) W ?LMARG,Y,! S X=$E(X,I+1,$L(X))
 Q
LI ; Ask to List Inactive Abbreviations
 N DIR,DIRUT,X,Y
 S DIR(0)="Y",DIR("A")="Include inactive entries",DIR("B")="No"
 D ^DIR Q:$D(DIRUT)  S INACT=+Y
 Q
DEV(R,VARS,DESC) ; Device Selection
 N %ZIS,POP,ZTDESC,ZTRTN,ZTSAVE
 S %ZIS="QM" W !! D ^%ZIS Q:POP 0 Q:'$D(%ZIS("Q")) 1
 S ZTRTN=R,ZTSAVE(VARS)="",ZTDESC=DESC D ^%ZTLOAD,^%ZISC
 Q 0
