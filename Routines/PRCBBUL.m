PRCBBUL ;WISC@ALTOONA/CTB-BULLETIN FOR FUND DISTRIBUTION ; 07/07/93  2:26 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;CREATES A BULLETIN FOR TRANSACTION NUMBER (PRCB("TRDA") AND FORWARDS IT TO ALL USERS WHO ARE IDENTIFIED AS CONTROL POINT OFFICIALS OR CONTROL POINT CLERKS
 N CP,DA,DIC,DIWF,DIWL,DIWR,I,N,TRDA,UTIL,X,X2,XMDUZ,XMSUB,XMTEXT,XMY,Y
 S TRDA(0)=^PRCF(421,PRCB("TRDA"),0),TRDA(4)=$S($D(^(4)):^(4),1:""),CP=+$P(TRDA(0),"^",2) Q:CP=9999
 K UTIL,^UTILITY($J,"W")
 S UTIL(3,0)="",UTIL(4,0)="The following funding transaction has been released:",UTIL(5,0)=" "
 S UTIL(5.5,0)="Control Point: "_$P(TRDA(0),"^",2)
 I $P(TRDA(0),"^",4)]"" S Y=$P(TRDA(0),"^",5) D DD^%DT S UTIL(5.6,0)="TDA #: "_$P(TRDA(0),"^",4),$P(UTIL(5.6,0)," ",40)="TDA DATE: "_Y,UTIL(5.7,0)=" "
 S Y=$P(TRDA(0),"^",6) D DD^%DT S UTIL(6,0)="Transaction #: "_$P(TRDA(0),"^")_"     Transaction Date: "_Y
 S UTIL(8,0)=" ",$P(FILL," ",40)=""
 S X=$P(TRDA(0),"^",7) D COMMA^%DTC S UTIL(9,0)="1st Qtr Amt: $"_X,UTIL(9,0)=UTIL(9,0)_$P(FILL," ",$L(UTIL(9,0)),40)_"Type: "_$S($P(TRDA(4),"^",6)="R":"Recurring",1:"Non-Recurring")
 S X=$P(TRDA(0),"^",8) D COMMA^%DTC S UTIL(10,0)="2nd Qtr Amt: $"_X
 S X=$P(TRDA(0),"^",9) D COMMA^%DTC S UTIL(11,0)="3rd Qtr Amt: $"_X S X=$P(TRDA(4),"^",5) I X'=0 D COMMA^%DTC S UTIL(11,0)=UTIL(11,0)_$P(FILL," ",$L(UTIL(11,0)),40)_"Annualization: $"_X
 S X=$P(TRDA(0),"^",10) D COMMA^%DTC S UTIL(12,0)="4th Qtr Amt: $"_X
 S X=0 F I=7:1:10 S X=X+$P(TRDA(0),"^",I)
 S UTIL(13,0)="              ___________ "
 D COMMA^%DTC S UTIL(14,0)="  Total Amt: $"_X
 S UTIL(15,0)=" "
 S X="DESCRIPTION: ",N=0,DIWL=1,DIWF="I5",DIWR=70 D DIWP^PRCUTL($G(DA)) F I=1:1 S N=$O(^PRCF(421,PRCB("TRDA"),1,N)) Q:N=""  S X=^(N,0) D DIWP^PRCUTL($G(DA))
 F I=0:0 S I=$O(^UTILITY($J,"W",1,I)) Q:I=""  S:$D(^(I,0)) UTIL(I+16,0)=^(0)
 S PRC("CP")=CP D NAMES
 S:$D(XMY)<10 XMY(DUZ)="" S XMSUB="Funding Transaction #: "_$P(TRDA(0),"^"),XMDUZ=DUZ,XMTEXT="UTIL(" D ^XMD
 K DIW,DIWI,DIWT,DIWTC,DIWX,DN,ER,XMKK,XMLOCK,XMQF,XMR,XMT,XMZ,Z Q
NAMES ;GENERATES XMY ARRAY FOR MESSAGES TO CONTROL POINT OFFICIALS AND CLERKS.  REQUIRES VARIABLES PRC("SITE") AND PRC("CP")
 N I,TMP,X
 K XMY F I=0:0 S I=$O(^PRC(420,+PRC("SITE"),1,+PRC("CP"),1,I)) Q:'I  I $D(^(I,0)) S X=^(0) D 
 .I $P(X,"^",3)["Y" S TMP(+X)=""
 .I '$D(TMP),12[$P(X,"^",2),$P(X,"^")]"" S XMY(+X)=""
 I $D(TMP) K XMY S %X="TMP(",%Y="XMY(" D %XY^%RCR
 Q
COMMIT ;report of committed transactions for 1-n control points
 ;this report was created for the Coatesville IFCAP testers
 W !!,"This report will generate a display of committed ",!,"transactions for one or more control points which you select",!!
START ;
 D EN1^PRCSUT Q:Y<0  I '$D(PRC("SITE")) W !,"This site is not entered in IFCAP." Q
 K ^TMP($J)
 Q:'$D(PRC("CP"))
 S PRC("CPP")=PRC("CP") W !!,"Enter control point at end of range.",!,"(For a range of 1-n, enter n. For one control point, enter that control point.)",!!
 D CP^PRCSUT
 K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS
 Q:POP  I $D(IO("Q")) S ZTRTN="PROCESS^PRCBBUL",ZTDESC="COMMITTED TRANSACTION LISTING",ZTSAVE("PRC*")="" D ^%ZTLOAD D ^%ZISC G START
 D PROCESS D ^%ZISC G START
PROCESS ;
 S PRCSZ=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_"0000"
 S RANGE=$P(PRC("CPP")," ")-1
 S N=0,STOP=0,P1=0,QTR=PRC("QTR"),RANGE1=PRC("CP")+1 D NOW^%DTC S Y=% D DD^%DT S RDATE=Y
 S TYPE(0)="",TYPE("O")="OBLIGATION",TYPE("A")="ADJUSTMENT",TYPE("C")="CEILING",TYPE("CA")="CANCELLED"
 W @IOF
 F  S PRCSZ=$O(^PRCS(410,"B",PRCSZ)) Q:$P(PRCSZ,"-",3)'=QTR  I $P(PRCSZ,"-",4)>RANGE,$P(PRCSZ,"-",4)<RANGE1  D
 .S PRCDA=$O(^PRCS(410,"B",PRCSZ,0)) Q:+PRCDA=0
 .S STR=$G(^PRCS(410,PRCDA,0)),STR4=$G(^PRCS(410,PRCDA,4)),STRING=$P($G(STR),"^")_"^"_$P($G(STR),"^",2)_"^"_$P($G(STR4),"^")_"^"_PRCDA
 .S N=N+1 S ^TMP($J,+$P($G(STR4),"^",2),N)=STRING
 S N=0 F  S N=$O(^TMP($J,N)) Q:N=""  D
 .Q:STOP=U  D:IOSL-$Y<8 HOLD1 Q:STOP=U
 .D:P1=0 HDR1 S Y=N D DD^%DT U IO W !,"DATE COMMITTED: ",?20,Y
 .S N1=0 F  S N1=$O(^TMP($J,N,N1)) Q:N1=""  D
 ..Q:STOP=U  D:IOSL-$Y<8 HOLD1 Q:STOP=U
 ..S STRING=^TMP($J,N,N1),TRANS=$P(STRING,"^"),TYP=$P(STRING,"^",2),COMM=$P(STRING,"^",3),D0=$P(STRING,"^",4)
 ..D STATUS^PRCSES S STATUS=$E(X,1,30)
 ..U IO W !,TRANS,?21,TYPE(TYP),?34,$J(COMM,8,2),?50,STATUS
 I P1=0 U IO W !!,"No transactions were found for this quarter.",!!
 U IO(0) W !!,"End of report" K X,RDATE,Y,%,L,P1,STOP,TYPE,PRCDA,STRING,COMM,STATUS,D0,PRCSZ,PRC("CPP"),RANGE,RANGE1,QTR,STR,STR4,N,N1,TRANS,TYP
 K ^TMP($J) Q
HOLD1 ;
 G HDR1:$D(ZTQUEUED),HDR1:IO'=IO(0)
 W !,"Press return to continue, uparrow (^) to exit: " R STOP:DTIME S:'$T STOP=U D:STOP'=U HDR1
 Q
HDR1 ;
 S P1=P1+1
 U IO W @IOF W "COMMITTED TRANSACTIONS LISTING",?45,RDATE,?70,"PAGE ",P1
 W !,?34,"COMMITTED",!,?21,"TRANSACTION",?34,"(ESTIMATED)",!,"TRANSACTION NUMBER",?21,"TYPE",?39,"COST",?50,"STATUS"
 S STOP1=STOP
 S L="",$P(L,"-",IOM)="-" W !,L S L="" Q
