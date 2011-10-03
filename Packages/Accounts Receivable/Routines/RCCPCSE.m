RCCPCSE ;WASH-ISC@ALTOONA,PA/LDB - CCPC Statements Errors;5/30/96  10:20 AM ;10/16/96  8:42 AM
V ;;4.5;Accounts Receivable;**34**;Mar 20, 1995;
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 K ^TMP($J)
 N ADD,DIR,DIRUT,ERR,ERROR,HDR,LINE,LN,PG,POP,PT,X,X1,Y,%ZIS,Z,ZTRTN,ZTDESC
 I '$O(^RCPS(349.2,"AD","E",0)) W !,"THERE ARE NO CCPC STATEMENT ERRORS" Q
 E  W !,"CCPC STATEMENTS ERROR REPORT"
 D HOME^%ZIS S %ZIS="QN" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .S ZTRTN="SORT^RCCPCSE",ZTDESC="CCPC PATIENT STATEMENT ERROR REPORT"
 .D ^%ZTLOAD
SORT S (LN,PT)=0 F  S PT=$O(^RCPS(349.2,"AD","E",PT)) Q:'PT  I $G(^RCPS(349.2,+PT,5))]"" D
 .S HDR="CCPC PATIENT STATEMENT ERROR REPORT",LINE="",$P(LINE,"=",IOM)="",PG=1
 .S ERR=$G(^RCPS(349.2,+PT,5))
 .S ^TMP($J,"ERR",PT)=$P(^RCPS(349.2,+PT,0),"^",3)_"^"_$P(^(0),"^",2)
 .S ADD=$G(^RCPS(349.2,+PT,1))
 .F X=1:1:6 S ADD(X)=$P(ADD,"^",X),^TMP($J,"ERR",PT,1+X)=ADD(X)
 .F X=1:5 S X1=X+4,ERROR=$E(ERR,X,X1) Q:ERROR=""  D
 ..S ^TMP($J,"ERR",PT,X+10)=ERROR,ERROR=$O(^RCPSE(349.7,"B",$E(ERROR,1,5),"")),ERROR=$P($G(^RCPSE(349.7,+ERROR,0)),"^",4),^TMP($J,"ERR",PT,X+10)=^TMP($J,"ERR",PT,X+10)_"^"_ERROR
 ;
 K ADD
 W:IOST?1"C-".E @IOF W !,?25,HDR,?75,PG,!,LINE
PRNT K DIRUT S PT=0 F  S PT=$O(^TMP($J,"ERR",PT)) Q:'PT  Q:$D(DIRUT)  D
 .I ($Y+12)>IOSL D
 ..I IOST?1"C-".E S DIR(0)="E" D ^DIR Q:$D(DIRUT)
 ..W @IOF,HDR,?75,PG S PG=PG+1
 .Q:$D(DIRUT)  W !!,$E($P(^TMP($J,"ERR",+PT),"^"),1,25),?37,"ERROR CODES",!,$P(^(PT),"^",2),?37,$E(LINE,1,11)
 .F X=2:1:4 S:$G(^TMP($J,"ERR",PT,X))]"" ADD(X)=^(X)
 .S ADD(5)=$G(^TMP($J,"ERR",PT,5))_", "_$G(^(6))_" "_$G(^(7))
 .S X=7 F  S X=$O(^TMP($J,"ERR",PT,X)) Q:'X  S ERR(X-1)=^(X)
 .S (Z,Y)=0 F  D  Q:Y=""&(Z="")
 ..W !
 ..I Z'="" S Z=$O(ADD(Z)) I Z'="",(ADD(Z)]"") W ADD(Z)
 ..I Y'="" S Y=$O(ERR(Y)) I Y'="" W ?30,$P(ERR(Y),"^"),?40,$P(ERR(Y),"^",2)
 .W !,LINE
 K ^TMP($J)
 Q
