ORY315 ;SLC/JLC - POST INSTALL FOR OR 315 ;4/12/2011
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**315**;Dec 17,1997;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 Q
 ;
POST ;
 ;
 N A,MCNT,DIC,X,Y,LPKG
 K ^TMP($J,"ORY315")
 S ^TMP($J,"ORY315",1,0)="Attempting to add the two new order reasons of Obsolete Order"
 S ^TMP($J,"ORY315",2,0)="and purged order."
 S ^TMP($J,"ORY315",3,0)=" "
 S MCNT=3
 S DIC=9.4,DIC(0)="BO",X="LAB SERVICE" D ^DIC
 I Y=-1 S MCNT=MCNT+1,^TMP($J,"ORY315",MCNT,0)="Cannot determine the Lab package from file 9.4.",MCNT=MCNT+1,^TMP($J,"ORY315",MCNT,0)="Cannot add new reasons." D SEND Q
 S LPKG=$P(Y,"^")
 D CHECK("Obsolete Order",LPKG,.MCNT),CHECK("Purged Order",LPKG,.MCNT)
 D SEND Q
CHECK(ORREASON,ALPKG,CNT) ;
 N B,C,DIC,Y,ADD
 S ADD=1,B=0 F  S B=$O(^ORD(100.03,"B",ORREASON,B)) Q:'B  D
 . S C=$G(^ORD(100.03,B,0)) I C="" Q
 . I $P(C,"^",5)=ALPKG D
 .. S ADD=0,CNT=CNT+1,^TMP($J,"ORY315",CNT,0)=ORREASON_" is already on file for Lab"
 .. I $P(C,"^",4)=1 S CNT=CNT+1,^TMP($J,"ORY315",CNT,0)="but currently inactive."
 .. S CNT=CNT+1,^TMP($J,"ORY315",CNT,0)=" "
 I ADD D ADD(ORREASON,ALPKG,.CNT)
 Q
ADD(REASON,LP,ACNT) ;
 N A,A1,A2,ORNAT,ORC,ORS
 S ORNAT=$O(^ORD(100.02,"B","MAINTENANCE","")),ORC=$S(REASON["Obsolete":"LROBS",1:"LRPO"),ORS=$S(REASON["Obsolete":"LROBS",1:"POR")
 F  L +^ORD(100.03):$G(DILOCKTM,5) Q:$T  H 5
 S A=^ORD(100.03,0),A1=$P(A,"^",3)+1,A2=$P(A,"^",4)+1
 S ^ORD(100.03,A1,0)=REASON_"^^"_ORS_"^^"_LP_"^"_ORC_"^"_ORNAT_"^14^"
 S ^ORD(100.03,"B",REASON,A1)="",^ORD(100.03,"C",ORC,A1)=""
 S ^ORD(100.03,"D",$$UP^XLFSTR(REASON),A1)="",^ORD(100.03,"S",ORS,A1)=""
 S $P(^ORD(100.03,0),"^",3)=A1,$P(^(0),"^",4)=A2
 S ACNT=ACNT+1,^TMP($J,"ORY315",ACNT,0)=REASON_" successfully added.",ACNT=ACNT+1,^TMP($J,"ORY315",ACNT,0)=" "
 Q
SEND ;
 Q:'$D(^TMP($J,"ORY315"))
 N XMY,XMDUZ,XMSUB,XMTEXT
 S XMDUZ="CPRS REASON,ADD",XMY("G.LRJ LSRP TRACKING")="",XMSUB="RESULTS OF ATTEMPT TO ADD NEW REASONS",XMTEXT="^TMP("_$J_",""ORY315"","
 D ^XMD Q
