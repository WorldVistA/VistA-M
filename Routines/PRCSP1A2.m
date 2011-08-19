PRCSP1A2 ;WISC/KMB-PPM STATUS OF TRANSACTIONS ; 7/10/01 2:16pm
 ;;5.1;IFCAP;**31**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N ARRAY,ENTRY,ENTRY1,TEST,P,P1,PP,A,B,D0,I,PRCZ,Z1,%
 D EN1^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0 S PRCZ=Z
 S (A,Z1,P1)=1,(P,PP)=0 D NOW^%DTC S Y=% D DD^%DT S YY=Y
 S P1=PRCZ F  S P1=$O(^PRCS(410,"B",P1)) Q:$P(P1,"-",1,4)'=PRCZ  D
 .S PP=$O(^PRCS(410,"B",P1,0)) Q:PP=""  I $P($G(^PRCS(410,PP,0)),"^",2)="O" S D0=PP D STATUS^PRCSES Q:X?.3N  D
 ..I (X["PPM")!(X["Sig.")!(X["Prop.")!(X["Imprest") S ARRAY(A)=PP_"^"_X,A=A+1
 I $G(ARRAY(1))="" W !!,"No transactions found.",!! G START
 S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="PROCESS^PRCSP1A2",ZTDESC="PPM STATUS OF TRANSACTIONS",ZTSAVE("YY")="",ZTSAVE("P")="",ZTSAVE("PRC*")="",ZTSAVE("ARRAY*")="",ZTSAVE("A")="",ZTSAVE("Z1")="" D ^%ZTLOAD G START
 D PROCESS,END G START
PROCESS ;
 U IO S B=A-1 D HDR F I=1:1:B D WRITE I IOSL-($Y#IOSL)<6 D HOLD Q:Z1[U
 D ^%ZISC Q
WRITE S PP=$P(ARRAY(I),"^"),TEST=$P(ARRAY(I),"^",2) D
 .W !,$P($G(^PRCS(410,PP,0)),"^"),?20,$P($G(^(4)),"^",5),?30,"$",$P($G(^(4)),"^") I $P($G(^(4)),"^",3)'="" W ?42,"$",$P($G(^(4)),"^",3)
 .S Y=$P($G(^PRCS(410,PP,1)),"^",4) X:Y ^DD("DD") W ?56,Y
 .S Y=$P($G(^PRCS(410,PP,4)),"^",4) X:Y ^DD("DD") W ?68,Y
 .S ENTRY=$P($G(^PRCS(410,PP,7)),"^"),ENTRY1=$P($G(^PRCS(410,PP,11)),"^",2)
 .W:ENTRY'="" !,$P($G(^VA(200,ENTRY,0)),"^")
 .W:ENTRY1'="" ?40,$P($G(^VA(200,ENTRY1,0)),"^")
 .W !,?30,$P(ARRAY(I),"^",2),!
 Q
 ;
END U IO(0) W !!,"END OF REPORT",!!
 K ARRAY
 Q
HOLD G HDR:IOSL'=24 W !,"Press return to continue, '^' to exit: " R Z1:10 S:'$T Z1=U  D:Z1'=U HDR Q
HDR S P=P+1 W @IOF,"PPM TRANSACTION STATUS REPORT - CP ",$P(PRC("CP")," "),?50,YY,?73," PAGE ",P,!
 W !,?20,"PO/OBL#",?30,"COMM.",?42,"OBLIG.",!,"2237#",?30,"(EST) COST",?42,"(ACT) COST",?56,"DATE REQ.",?68,"DATE OBL."
 W !,"REQUESTOR",?40,"ORIGINATOR OF REQUEST"
 W !,?30,"STATUS" S L="",$P(L,"-",IOM-1)="-" W !,L S L=" " Q
W2 ;
 W !,"You are not an authorized control point user.",!,"Contact your control point official." R XXZ:5 G EXIT
EXIT K %ZIS,L,POP,ZTDESC,ZTRTN,ZTSAVE,YY,Y,X,Z,XXZ,PRC Q
