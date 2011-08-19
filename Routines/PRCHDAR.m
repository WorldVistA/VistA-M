PRCHDAR ;WISC/CR - DELINQUENT APPROVALS REPORT ; 1/19/99  14:47
 ;;5.1;IFCAP;**8**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 W !
START K ^TMP($J),^TMP("RECDATE")
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
 S DIC="^VA(200,",DIC("A")="START WITH CARD HOLDER: ",DIC(0)="AEMQ" D ^DIC K DIC Q:'$D(^VA(200,+Y))  S FPERSN=Y K Y
 S DIC="^VA(200,",DIC("A")="GO TO CARD HOLDER: ",DIC(0)="AEMQ" D ^DIC K DIC Q:'$D(^VA(200,+Y))  S SPERSN=Y K Y
 ;
 ; Get the last name of first and second card holder entered.
 S FPERSNL=$P($P(FPERSN,"^",2),",",1),SPERSNL=$P($P(SPERSN,"^",2),",",1)
 ;
 ; Get the first name of first and second card holder entered.
 S FPERSNF=$P(FPERSN,",",2),SPERSNF=$P(SPERSN,",",2)
 ;
 I FPERSNL]SPERSNL W !,$C(7),"Less than 'FROM' value.",! K FPERSN,SPERSN,Y G START
 I (FPERSNL=SPERSNL)&(FPERSNF]SPERSNF) W !,$C(7),"Less than 'FROM' value.",! K FPERSN,SPERSN,Y G START
 W !
 ;
DATE S DIR("A")="START WITH APPROVAL DATE",DIR("?")="Enter the first date for which you wish to see records."
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S FDATE=+Y W "   ",Y(0)
 S DIR("A")="GO TO APPROVAL DATE",DIR("?")="Enter the last date for which you want to see records."
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S EDATE=+Y W "   ",Y(0)
 I EDATE<FDATE W !,$C(7),"Less than 'FROM' value.",! K EDATE,FDATE G DATE
 W !!,$C(7),?5,"This report should be queued. It may be very large and"
 W !,?4,"take a long time to generate to the printer. We suggest you"
 W !,?4,"run it during off hours.",! H 2
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DETAIL^PRCHDAR",ZTSAVE("*")="" D ^%ZTLOAD,^%ZISC Q
 D DETAIL,^%ZISC
 Q
 ;
DETAIL ;
 D STAT
 D WRITE
CLEAN ;
 K ^TMP($J),^TMP("RECDATE"),APDATE,C1,C2,C3,CARDOFF,EDATE,EX,FDATE
 K FINALDEL,FPARTIAL,FPERSNF,FPERSN,FPERSNL,GETDATE,I,LINE1,OFFPT
 K OIEN,ORECD0,ORECD1,ORECD5,P,PARTIAL,PO,PRCHDUZ,RECAPP,RECDATE,RECREQ
 K SPERSNF,SPERSN,SPERSNL,TIMDATE,USER,USERFN,USERLN
 K X,X1,XXZ,Y,Z1,ZP
 Q
 ;
STAT ; Get appropriate records from file # 440.6
 S ZP="" F  S ZP=$O(^PRCH(440.6,"PO",ZP)) Q:ZP=""  D
 .S Z1=$G(^PRC(442,ZP,0)),PO=$P(Z1,"^",1) Q:PO=""
 .I $D(PRC("SITE")) Q:$P(Z1,"-",1)'=PRC("SITE")
 .;
 .; Get the receiving required code and the IEN of the Oracle record.
 .S RECREQ=$P($G(^PRC(442,ZP,23)),"^",15)
 .S OIEN="" F  S OIEN=$O(^PRCH(440.6,"PO",ZP,OIEN)) Q:OIEN=""  D
 ..S ORECD0=$G(^PRCH(440.6,OIEN,0))
 ..S ORECD1=$G(^PRCH(440.6,OIEN,1))
 ..S ORECD5=$G(^PRCH(440.6,OIEN,5))
 ..S PRCHDUZ=+$P(ORECD1,"^",5),USER=$P($G(^VA(200,PRCHDUZ,0)),"^"),USERLN=$P(USER,",",1),USERFN=$P(USER,",",2)
 ..S OFFPT=+$P(ORECD5,"^",7),CARDOFF=$P($G(^VA(200,OFFPT,0)),"^") I CARDOFF="" S CARDOFF="OFFICIAL NOT ASSIGNED"
 ..Q:(USER="")!(OFFPT="")
 ..;
 ..; Check that user found is within range specified at the beginning.
 ..I (FPERSNL]USERLN) Q
 ..I (USERLN]SPERSNL) Q
 ..I (USERLN=SPERSNL)&(USERFN]SPERSNF) Q
 ..;
 ..; Ignore orders not reconciled, without final charge, and not fully
 ..; received.
 ..Q:$P(ORECD0,"^",16)'["R"
 ..Q:$P(ORECD1,"^",4)'["Y"
 ..Q:$P(ORECD1,"^",3)'["Y"
 ..;
 ..; RECAPP=reconciliation interval, CARDOFF=card official.
 ..; APDATE=approval date by official.
 ..; RECDATE=reconciliation date by card holder.
 ..;
 ..S RECDATE=$P(ORECD1,"^",6) Q:RECDATE=""
 ..S APDATE=$P(ORECD5,"^",6) Q:APDATE=""
 ..Q:APDATE<FDATE
 ..Q:APDATE>EDATE
 ..Q:APDATE=RECDATE
 ..;
 ..; Check if receiving is required and date/time of last partial delivery.
 ..I RECREQ["Y" D
 ...S PARTIAL=+$P($G(^PRC(442,ZP,11,0)),"^",3)
 ...I PARTIAL>0 S FPARTIAL=$G(^PRC(442,ZP,11,PARTIAL,0))
 ...S GETDATE=$P($G(FPARTIAL),"^",1),FINALDEL=$P($G(FPARTIAL),"^",9)
 ...I FINALDEL["F"&(GETDATE]"")&(GETDATE>RECDATE) S RECDATE=GETDATE
 ..;
 ..Q:RECDATE>EDATE
 ..S X=RECDATE,X1=APDATE D ^XUWORKDY S RECAPP=X
 ..S Y=RECDATE D DD^%DT S RECDATE=Y I RECDATE["@" S ^TMP("RECDATE",$J)=1
 ..S Y=APDATE D DD^%DT S APDATE=Y
 ..;
 ..; Get those orders with more than 15 days elapsed from date of final
 ..; reconciliation by the card holder to approval by the approving official.
 ..;
 ..I RECAPP>15 D
 ...S ^TMP($J,USER,OFFPT,ZP)=USER_"^"_PO_"^"_RECDATE_"^"_APDATE_"^"_RECAPP_"^"_CARDOFF
 Q
 ;
WRITE ; Let's print out what we have.
 ;
 S X=DT D NOW^%DTC,YX^%DTC S TIMDATE=Y
 U IO S U="^",(EX,P)=1
 I '$D(^TMP($J)) S C1="" D HEADER W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 ;
 S C1="" F  S C1=$O(^TMP($J,C1)) Q:C1=""  Q:EX[U  D
 .D HEADER
 .S C2="" F  S C2=$O(^TMP($J,C1,C2)) Q:C2=""  Q:EX[U  D
 ..S C3="" F  S C3=$O(^TMP($J,C1,C2,C3)) Q:C3=""  Q:EX[U  D
 ...S LINE1=^TMP($J,C1,C2,C3) D
 ....W $P(LINE1,"^",2),?14,$E($P(LINE1,"^",3),1,18),?34,$P(LINE1,"^",4),?52,$P(LINE1,"^",5),?59,$E($P(LINE1,"^",6),1,21),!
 ....I (IOSL-$Y)<2 D HOLD
 .I $E(IOST,1,2)'="P-",EX'[U W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ[U EX=U S:'$T EX=U W !
 I $G(^TMP("RECDATE",$J))=1 W !?2,"'@' - This symbol indicates the final Date/Time of receipt",!,?8,"of the PC order by the user or the Warehouse if applicable.",!
 Q
 ;
HOLD G HEADER:$E(IOST,1,2)="P-"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ[U EX=U S:'$T EX=U D:EX'=U HEADER
 Q
 ;
HEADER ;
 W @IOF
 W !,"DELINQUENT APPROVALS EXCEPTION LISTING",?45,TIMDATE,?69,"PAGE ",P,!
 W !,"PURCHASE",?14,"FINAL RECONCILE",?34,"APPROVAL",?47,"RECON TO",!
 W "ORDER",?14,"DATE",?34,"DATE",?47,"APPR INTER",?59,"CARD OFFICIAL"
 ;
 W ! F I=1:1:10 W "--------"
 W !
 W !,?10,"CARD HOLDER: ",C1,!
 S P=P+1
 Q
