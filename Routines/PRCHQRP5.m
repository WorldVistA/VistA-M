PRCHQRP5 ;WISC/KMB-2237 TRACKING REPORT ;10/6/96  08:53
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N RFQLINE,X,P,PDATE,XXZ,Z,Z1,STR,XI,ODA,RDA,ITEMNO,COUNT,Y,RFQ,RFQNUM,IMF,PONUM,OLINE,NREC,NLINE,I,LNR
 N Q,OREC,PHONE,PA,L,STR,RDATA,SORT,DA,DIRUT,DIROUT,DTOUT,DUOUT,II,POP
 ;
 W @IOF D EN3^PRCSUT Q:'$D(PRC("SITE"))  Q:Y<0
 S DIC="^PRCS(410,",DIC(0)="AEMQZ",DIC("A")="Select 2237 transaction number: "
 S DIC("S")="I +^(0),$P($G(^(0)),""^"",4)'=1,$D(^(3)),+^(3)=+$P(PRC(""CP""),"" ""),$P(^(0),""^"",5)=PRC(""SITE"")"
 D ^DIC K DIC Q:Y<0  S DA=+Y
 I '$O(^PRC(444,"C",DA,0)) W !,"No RFQ has been created for this 2237.",! H 2 G START
 S DIR(0)="SM^1:Destination;2:Original 2237 line item"
 S DIR("?",1)="Enter 1 to sort by destination (PO, RFQ, new 2237)",DIR("?")="or 2 to sort by original 2237 line number"
 D ^DIR Q:$D(DIRUT)  S SORT=Y K DIR
 W @IOF S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="PROCESS^PRCHQRP5",ZTSAVE("SORT")="",ZTSAVE("DA")="",ZTSAVE("DUZ")="" D ^%ZTLOAD,^%ZISC G START
 D PROCESS,^%ZISC H 2 W @IOF G START
PROCESS ;
 S P=1,I=0
 D NOW^%DTC S Y=X D DD^%DT S PDATE=Y
 S RFQ=0 F  S RFQ=$O(^PRC(444,"C",DA,RFQ)) Q:RFQ=""  D
 .S OREC=$P($G(^PRCS(410,DA,0)),"^")
 .S RFQNUM=$P($G(^PRC(444,RFQ,0)),"^")
 .S RFQLINE=0 F  S RFQLINE=$O(^PRC(444,"C",DA,RFQ,RFQLINE)) Q:RFQLINE=""  D
 ..S (PONUM,NREC)=""
 ..S PA=$P($G(^PRC(444,RFQ,0)),"^",4) S:$G(PA)'="" PHONE=$P($G(^VA(200,PA,.13)),"^",5)
 ..S:$G(PA)'="" PA=$P($G(^VA(200,PA,0)),"^")
 ..S IMF=$P($G(^PRC(444,RFQ,2,RFQLINE,0)),"^")
 ..S OLINE=$P($G(^(3)),"^",2),NREC=$P($G(^(3)),"^",6)
 ..I NREC'="" S NREC=$P($G(^PRCS(410,NREC,0)),"^"),PONUM=$P($G(^PRCS(410,NREC,4)),"^",5)
 ..S RDATA=OREC_"^"_OLINE_"^"_IMF_"^"_PA_"^"_PHONE
 ..I SORT=1 F I=PONUM,RFQNUM,NREC I $G(I)'="" S STR(I,OLINE)=RDATA
 ..I SORT=2 S STR(OLINE)=OREC_"^"_OLINE_"^"_IMF_"^"_RFQNUM_" LINE # "_RFQLINE
WRITE ;
 I '$D(STR) W !,"No data was available for your sort criteria" H 2 Q
 U IO S (P,Z1)=1 D HDR
 S Q="" F  S Q=$O(STR(Q)) Q:(Z1[U)!(Q="")  D
 .I IOSL-($Y#IOSL)<6 D HOLD Q:Z1[U  D HDR
 .I SORT=2 W !,$P(STR(Q),"^"),?20,$P(STR(Q),"^",2),?28,$P(STR(Q),"^",3),?35,$P(STR(Q),"^",4),?60,$P(STR(Q),"^",5)
 .I SORT=1 W !,?10,Q S L="" F  S L=$O(STR(Q,L)) Q:L=""  W !,$P(STR(Q,L),"^"),?20,$P(STR(Q,L),"^",2),?28,$P(STR(Q,L),"^",3),?35,$P(STR(Q,L),"^",4),?60,$P(STR(Q,L),"^",5)
 QUIT
HDR ;
 W @IOF W !,"2237 TRACKING REPORT",?40,PDATE,?60,"PAGE ",P,!
 I SORT=1 W !,?10,"DESTINATION",!,"ORIGINAL 2237",?20,"LINE #",?28,"IMF #",?35,"PURCHASING AGENT",?60,"PA PHONE",!
 I SORT=2 W !,"ORIGINAL 2237",?20,"LINE #",?28,"IMF #",?35,"DESTINATION DESCRIPTION",!
 ;
 F II=1:1:8 W "----------"
 S P=P+1 Q
HOLD G HDR:$D(ZTQUEUED) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:'$T Z1=U D:Z1'=U HDR Q
NOTIFY ;       notify users that RFQ quotes are due
 N %,X,Y,COUNT,STR,XXZ,PDATE,TDATE,SDA,PA,RNUM,I,Z1,ZIP,P,PRCI
 Q:'$D(DUZ)  S I=1,COUNT=0
 D NOW^%DTC S (Y,TDATE)=$P(%,".") D DD^%DT S PDATE=Y
 S ZIP="" F  S ZIP=$O(^PRC(444,"QD",ZIP)) Q:ZIP=""  D
 .Q:ZIP'=TDATE
 .S SDA="" F  S SDA=$O(^PRC(444,"QD",ZIP,SDA)) Q:SDA=""  D
 ..Q:$P($G(^PRC(444,SDA,0)),"^",4)'=DUZ  S PA=$P($G(^VA(200,DUZ,0)),"^")
 ..S COUNT=COUNT+1,RNUM=$P($G(^PRC(444,SDA,0)),"^"),STR(COUNT)=RNUM_"^"_PA
 I $D(STR),$D(FLAG) W !,"You have ",COUNT," RFQ(s) which have quotations due today",!,"Use the RFQs Due Report to review them." K FLAG QUIT
 I $D(FLAG) K FLAG QUIT
 I '$D(STR) W !,"There are no RFQs with quotes due today." QUIT
 W !,"Use this option to create a report of RFQs which require quotations.",!
 W ! S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="QUOTES^PRCHQRP5",ZTSAVE("PDATE")="",ZTSAVE("COUNT")="",ZTSAVE("STR(")="" D ^%ZTLOAD,HOME^%ZIS K ZTSK QUIT
 D QUOTES QUIT
QUOTES ;
 S XXZ=""
 U IO S (P,Z1)=1 D HDR1
 F PRCI=1:1:COUNT D  Q:XXZ["^"
 . I PRCL+3>IOSL D HOLD1 Q:XXZ["^"
 .W !,?20,$P(STR(PRCI),"^"),?45,$P(STR(PRCI),"^",2) S PRCL=PRCL+1
 I $E(IOST,1,2)="C-"&'$D(ZTQUEUED) R !,"Enter RETURN to continue ",XXZ:DTIME
 K XXZ,P,Z1,STR,PRCI,PRCL
 S:$D(ZTQUEUED) ZTREQ="@" D ^%ZISC
 QUIT
HOLD1 I $E(IOST,1,2)="C-"&'$D(ZTQUEUED) W !,"Enter RETURN to continue or '^' to exit: " R XXZ:DTIME Q:XXZ["^"
HDR1 ;
 W @IOF
 W !,"RFQ WITH QUOTATIONS DUE REPORT",?40,PDATE,?70,"PAGE ",P,!
 W !,?20,"RFQ REFERENCE",?45,"PURCHASING AGENT"
 S P=P+1,PRCL=4 W ! F I=1:1:8 W "----------"
 QUIT
