XTER1A ;ISC-SF.SEA/JLI - VA error reporting ;05/20/10  15:53
 ;;8.0;KERNEL;**63,112,120,431**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
TWO ;Print two of each error
 S XTNUM=2
ONE ;Print one of each error
 S:'$D(XTNUM) XTNUM=1
 S:'$D(XTNDATE) XTNDATE=$H-1 I '$D(ZTQUEUED) S XTNDAT1=$$HTFM^XLFDT(XTNDATE),XTNDAT2=XTNDAT1 G INT^XTER1A1
 K ^TMP($J,"XTER1A") D LISTN,LIST
EXIT K XTNUM,XTNDATE,XTERN,XTERX,X,N,N1,Y,C,XTOUT,Z,I,XTER1AX,XTER1AN,XTER1AN1,%XTZDAT,%XTZNUM,XTMES,XTDV1,XTMES,XTPRNT
 Q
LISTN ;Sort errors
 F XTERN=0:0 S XTERN=$O(^%ZTER(1,XTNDATE,1,XTERN)) Q:XTERN'>0  I $D(^(XTERN,"ZE")) S XTERX=$E(^("ZE"),1,30),X=^("ZE") D
 .S N1=0 F N=0:0 S N=$O(^TMP($J,"XTER1A",XTERX,N)) Q:N=""  S N1=N I ^(N)=X Q
 .I N="" S ^TMP($J,"XTER1A",XTERX,N1+1)=X,^(N1+1,"CNT")=1,^(1)=XTNDATE_U_XTERN
 .E  S ^("CNT")=^TMP($J,"XTER1A",XTERX,N,"CNT")+1 I ^("CNT")'>XTNUM S Y=^("CNT"),^(Y)=XTNDATE_U_XTERN
 .Q
 Q
LIST ;
 S XTERX="",C=0,XTOUT=0 K ^TMP($J,"XTER")
 ;List count of errors
 F  S XTERX=$O(^TMP($J,"XTER1A",XTERX)) Q:XTERX=""  F N=0:0 S N=$O(^TMP($J,"XTER1A",XTERX,N)) Q:N'>0  D
 .S X=^TMP($J,"XTER1A",XTERX,N) D ADD(""),ADD("") S Z=$J(^TMP($J,"XTER1A",XTERX,N,"CNT"),8)_"  "
 .F I=1:60 S Y=$E(X,I,I+59) Q:Y=""  D ADD(Z_Y) S Z="         "
 .Q
 ;List errors
 S XTER1AX="" F  S XTER1AX=$O(^TMP($J,"XTER1A",XTER1AX)) Q:XTER1AX=""  F XTER1AN=0:0 S XTER1AN=$O(^TMP($J,"XTER1A",XTER1AX,XTER1AN)) Q:XTER1AN'>0  D
 .F XTER1AN1=0:0 S XTER1AN1=$O(^TMP($J,"XTER1A",XTER1AX,XTER1AN,XTER1AN1)) Q:XTER1AN1'>0  S X=^(XTER1AN1) D
 ..D ADD("|PAGE|") S %XTZDAT=+X,%XTZNUM=$P(X,U,2),XTDV1=0 S XTMES=1 D WRT^XTER1
 D:IO=""&$D(^TMP($J,"XTER")) MESSG D:IO'="" WRITER
 K ^TMP($J,"XTER") S C=0 I IO'="" U IO D ^%ZISC
 Q
 ;
MESG ;Send to a Mail message
 N DWPK,DWLW,DIC K ^TMP($J,"XTER"),^TMP($J,"XTER1")
 W @IOF,!!,"Enter any comments to precede the error listing:"
 S DWPK=1,DWLW=75,DIC="^TMP($J,""XTER1"",",DIWESUB="Comments" D EN^DIWE
 S C=0 W ! F I=0:0 S I=$O(^TMP($J,"XTER1",I)) Q:I'>0  S C=I,^TMP($J,"XTER",I)=^TMP($J,"XTER1",I,0)
 S XTMES=1,XTDV1=0 D WRT^XTER1 D:C>0 MESSG
 S C=0,XTX="" K XTMES,^TMP($J,"XTER"),^TMP($J,"XTER1")
 G XTERR^XTER
 ;
PRNT ;Send to Printer
 K ^TMP($J,"XTER"),ZTIO,XTDV1
 S C=0,%ZIS="MQ" D ^%ZIS I POP D HOME^%ZIS G WRT^XTER1
 I $D(IO("Q")) D  S XTX="" G XTERR^XTER
 . K IO("Q") S ZTRTN="DQPRNT^XTER1A",ZTSAVE("%XTZDAT")="",ZTSAVE("%XTZNUM")="",ZTDESC="XTER1A-PRINT OF ERROR" D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
DQPRNT S XTPRNT=1,XTOUT=0 D WRT^XTER1 U IO D:C>0 WRITER
 K ^TMP($J,"XTER"),XTX,XTPRNT S C=0 D ^%ZISC I $D(ZTQUEUED) Q
 G XTERR^XTER
 ;
WRITER ;Write global
 F %=0:0 S %=$O(^TMP($J,"XTER",%)) Q:%'>0  W:((IOSL-$Y)'>4&$G(XTPRNT)) @IOF S %1=$S($D(^(%))=1:^(%),1:^(%,0)) D
 .I $E(%1,1,6)="|PAGE|" W @IOF S %1=$E(%1,7,$L(%1)) Q:%1=""
 .I $E(%1,1,4)="@IOF" W @IOF S %1=$E(%1,5,$L(%1)) Q:%1=""
 .F  Q:%1=""  W !,$E(%1,1,IOM) S %1=$E(%1,IOM+1,$L(%1))
 K %,%1
 Q
MESSG ;Global to Message
 S XMY(DUZ)="",XMDUZ=.5 I '$D(ZTQUEUED) K XMY,XMDUZ
 S XMTEXT="^TMP($J,""XTER"",",XMSUB="ERROR - "_$E(%XTZE,1,40) F  Q:XMSUB'[U  S XMSUB=$P(XMSUB,U)_"~U~"_$P(XMSUB,U,2,99)
 D ^XMD K XMY,XMTEXT,XMSUB
 Q
 ;
ADD(STR) ;Add STR to TMP global
 S C=C+1,^TMP($J,"XTER",C)=STR
 Q
 ;
MORE Q:$G(XTMES)  N DIR,DTOUT,DIRUT,DUOUT
 S XTOUT=0,XTX="" D WRITER K ^TMP($J,"XTER") S C=0
 I '$D(ZTQUEUED),'$G(XTPRNT),$G(IOST)["C-" D
 . S:($D(X)#2) XTMORE=X S DIR(0)="FO^0:50",DIR("A")="     Enter '^' to quit listing, <RETURN> to continue..."
 . D ^DIR K DIR S:$D(DTOUT) X="^" S XTX=X S:$D(XTMORE) X=XTMORE K XTMORE
 I $D(XTX),$E(XTX)="^" S XTOUT=1 Q
 I $G(XTPRNT) W @IOF
 Q
 ;
LST S X=" ",XTQ="" N XTXT,XBLNK S $P(XBLNK," ",80)=" "
T1 S X=$O(^%ZTER(1,%XTZDAT,1,X),-1) R XTQ:0 Q:XTQ'=""  G T2:X'>0,T1:'($D(^(X,"ZE"))#2) S XTP=^("ZE"),XTS=""
 F  S XTS=$O(^TMP($J,"XTERSCR",XTS)) Q:XTS=""  I XTP[XTS,XTD S XTD=XTD+1 G T1
 ;
 I '(X#20) S %XTERRX=X D MORE Q:XTOUT  Q:XTX>0  D T3 S X=%XTERRX
 I ^%ZTER(1,%XTZDAT,1,X,"ZE")["," S %XTERR=$P($P(^("ZE"),",",4),"-",4),%XTERR=$P($P(^("ZE"),",",2),"-",3)_$S(%XTERR="":"",1:"(")_%XTERR_$S(%XTERR="":"",1:")") S XTXT=$J(X,3)_")  "_"<"_%XTERR_">"_$P(^("ZE"),",",1)_" "
 I ^%ZTER(1,%XTZDAT,1,X,"ZE")'["," S XTXT=$J(X,3)_")  "_^("ZE")
 S %XTZNUM=X,%="" I $D(^%ZTER(1,%XTZDAT,1,%XTZNUM,"H")) S %H=^("H") D YMD^%DTC S %=$P(%,".",2)_"000000",%=$E(%,1,2)_":"_$E(%,3,4)_":"_$E(%,5,6)
 S X=%XTZNUM S XTXT=$S($L(XTXT)>38:XTXT,1:$E(XTXT_XBLNK,1,38))_%
 S XTXT=XTXT_"  "_$P($S('$D(^%ZTER(1,%XTZDAT,1,X,"J")):"",1:^("J")),U,4)_"  "_$J($P($S('$D(^("J")):"",1:^("J")),U,5),7)_"  "_$P($S('$D(^("I")):"",1:^("I")),U)
 S XTXT=$S($L(XTXT)>51:XTXT,1:$E(XTXT_XBLNK,1,51))_$P(XTP,"\",7)
 S XTXT=$S($L(XTXT)>59:XTXT,1:$E(XTXT_XBLNK,1,60))_$P(XTP,"\",3) S XTXT=$S($L(XTXT)>65:XTXT,1:$E(XTXT_XBLNK,1,65))_$P(XTP,"\",4) W !,$E(XTXT,1,79) G T1
T2 I XTD W !!,$S(XTD-1:XTD-1,1:"No")," screened error",$S(XTD-1>1:"s",1:""),!
 D MORE
 Q
T3 W !!,?11,"$ZE",?41,"Time",?49,"UCI,VOL",?61,"$J",?69,"$I",!
 Q
INTRACT ;
 G INTRACT^XTER1A1
