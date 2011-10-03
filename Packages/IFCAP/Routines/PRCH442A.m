PRCH442A ;WISC/KMB/CR/DXH/DGL-CREATE PURCHASE CARD ORDER FROM RIL ;4/13/00 1:32pm
 ;;5.1;IFCAP;**8,35,26,57,81,106**;Oct 20, 2000
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SETUP ; create 442 entry
 D ENPO^PRCHUTL
 ;
 ; PRC*5.1*81 - If this is a DynaMed RIL, double dare users who try to exit before all items on the RIL are transferred to purchase card orders
 I '$D(DA),'PRCVDYN S OUTRIL=1 W !,"Unable to create 442 entry. Try later." Q
 I '$D(DA) D  G SETUP:Y=0 S OUTRIL=1 Q
 . N DIR
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A",1)=" "
 . S DIR("A",2)="NOTE: This RIL Contains DynaMed Orders!!!"
 . S DIR("A",3)="-----------------------------------------"
 . S DIR("A",4)="You must enter a valid PURCHASE ORDER NUMBER to continue.  If no valid"
 . S DIR("A",5)="PURCHASE ORDER is entered, all items remaining on the RIL will be deleted."
 . S DIR("A",6)=" "
 . S DIR("A")="Do you want to exit and delete the RIL?"
 . S DIR("?")="Enter 'NO' or <return> to go back to the PURCHASE ORDER prompt"
 . D ^DIR Q:Y=0
 . S DIR("A")="Are you sure that you want to cancel ALL DynaMed Orders on this RIL?"
 . D ^DIR
 ;
 I '$G(^PRCS(410.3,XDA,0)) D  S OUTRIL=1 W !!,"Another user has deleted this RIL, Purchase Order will now be deleted.",!! Q
 . S DIK="^PRC(442,",DA=DA
 . D ^DIK
 N PRCHCPD,CP1
 S PDA=DA L +^PRC(442,PDA):15 Q:'$T
 S DIE="^PRC(442,",DR=".5////1"_";"_"1.4////"_APP D ^DIE ;LIT-0400-70331
 I $G(RLFLAG)'=1 S DR=".02///25"_";"_"48///P" D ^DIE
 I $G(RLFLAG)=1 S DR=".02///1"_";"_"47///Y"_";"_"48///D" D ^DIE
 S $P(^PRC(442,PDA,1),"^")=VENDOR,$P(^(0),"^",3)=FCP,$P(^(0),"^",5)=CCEN,$P(^(23),"^",7)=PRC("SST"),$P(^(23),"^",14)=VENDOR
 S DIE="^PRC(442,",DR=".03///"_SPEC_";"_".1////"_TDATE D ^DIE
 ;
 ; PRC*5.1*81 
 I PRCVDYN S DR="7///"_PRCVDATE_";"_"54///Y" D ^DIE ; save earliest Need By Date in RIL for vendor in PC order delivery date, force 'Requested Receipt?' to Yes
 ;
 ;BUT-0701-21784 & WAS-0498-22000
 S CP1=$P($P(^PRCS(410.3,XDA,0),U),"-",4)
 S ^PRC(442,"E",CP1,PDA)=""
 ;
 S $P(^PRC(442,PDA,1),"^",10)=DUZ,^PRC(442,"D",$E(VENDOR,1,30),PDA)=""
 I NCOST'=0 F II=1:1:CNNT D SETIT
 I NCOST'=0 S ^PRC(442,PDA,2,0)="^442.01IA^"_CNNT_"^"_CNNT
 S EE($J,PDA)=""
 ;
 N NCST,NLP,NCNT,NQTY,NSUB
LOOP S %=1 W !,"Edit request ",$P(^PRC(442,PDA,0),"^")
 D YN^DICN G:%=0 LOOP G:%=2 LQ
 S (PRCHPO,DA)=PDA,PRC("PER")=DUZ,X=1
 D ^PRCHNPO,LOOPA
 K PRC("PER"),X,PRCHPO
LQ L -^PRC(442,PDA) Q
 ;
LOOPA Q:$G(^PRC(442,PDA,2,0))=""  S NCNT=$P($G(^PRC(442,PDA,2,0)),U,4) Q:NCNT=""  S NSUB=0 F NLP=1:1:NCNT D
 .S NQTY=$P($G(^PRC(442,PDA,2,NLP,0)),U,2),NCST=$P($G(^PRC(442,PDA,2,NLP,0)),U,9),NSUB=NSUB+(NQTY*NCST)
 S CNNT=NCNT,NCOST=NSUB Q
 ;
SETIT ;set item data on 442 record
 S ^PRC(442,PDA,2,II,0)=AA(II)
 I CNNT1'="" F J=1:1:CNNT1 S ^PRC(442,PDA,2,II,1,J,0)=$G(BB(II,J))
 S ^PRC(442,PDA,2,II,2)=CC(II)
 ;
 ; PRC*5.1*81
 I PRCVDYN D
 . N PRCV S PRCV=0
 . I $P(CC(II),"^",15)]"" S PRCV=$O(^PRCV(414.02,"B",$P(CC(II),"^",15),"")) ; get ien of DM DOC ID
 . I +PRCV=0 D  Q  ; if not in audit file update ^TMP to alert user
 . . S ^TMP($J,"PRCVHMSG",YDA,ITEM)=$P(CC(II),"^",15)_"^"_$P(^PRC(442,PDA,0),"^",1) Q  ; update msg to user to show DM, DOC ID & PO#
 . S $P(^PRCV(414.02,PRCV,0),"^",11)=$P(^PRC(442,PDA,0),"^",1) ; SET PO Number into Audit file
 ;
 S ^PRC(442,PDA,2,II,1,0)="^^"_CNNT1_"^"_CNNT1_"^"_TDATE_"^"
 S ^PRC(442,PDA,2,"B",II,II)="",^PRC(442,PDA,2,"C",II,II)=""
 S ^PRC(442,PDA,2,"AE",ITEM,II)="" S:BOC'="" ^PRC(442,PDA,2,"AH",+BOC,II,II)="",^PRC(442,PDA,2,"D",+BOC,II)=""
 I $G(PRCSIP) D
 . N DIC,DIE,DA,DLAYGO
 . S DIC="^PRC(442,"_PDA_",2,"_II_",5,",DA(1)=II,DA(2)=PDA,X=PRCSIP
 . S DIC(0)="L",DIC("P")=$P(^DD(442.01,47,0),U,2),DLAYGO=442
 . D FILE^DICN
 K DIE
 ;
 ; PRC*5.1*81 - delete items from RIL as they are moved to a PC order
 I PRCVDYN D
 . N DA,DIK
 . S DA=GG(II),DA(1)=YDA,DIK="^PRCS(410.3,"_DA(1)_",1,"
 . D ^DIK
 ;
 S PRCHCPD=TDATE,PRCHCV=VENDOR,(DA(1),PRCHCPO)=PDA,PRCHCCP=CP1,(PRCHCI,PRCHCII,X)=$P(AA(II),"^",5),DA=II
 I PRCHCI'="" D EN3^PRCHCRD S ^PRC(442,PDA,2,"AE",PRCHCII,II)=""
 K PRCHCCP,PRCHCPO,PRCHCV,PRCHCI,PRCHCII
 QUIT
 ;
INCOM1 S FLAG=0
INCOM2 S:$G(FLAG)="" FLAG=1
INCOM ;
 K ^TMP($J)
 N ZP,LABEL,PC1,PONUM,PODATE,STAT,PANAME,ADATE,Y,XXZ,EX,P,P1,P12,P2,P23,STR,TIMEDATE
 S:$G(FLAG)="" LABEL="INCOM" S:$G(FLAG)=0 LABEL="INCOM1" S:$G(FLAG)=1 LABEL="INCOM2"
 W @IOF
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(PRC("SITE"))="^"
 W !,"Please select a device for printing this report."
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTSAVE("*")="",ZTRTN="DETAIL^PRCH442A" D ^%ZTLOAD,^%ZISC K FLAG Q
 D DETAIL,^%ZISC K FLAG
 Q
 ;
DETAIL ;
 S X=DT D NOW^%DTC,YX^%DTC S TIMEDATE=Y,CNT=0
 S ZP="" F  S ZP=$O(^PRC(442,"F",25,ZP)) Q:ZP=""  D
 .Q:$P($G(^PRC(442,ZP,7)),"^")=45
 .Q:$D(^PRC(442,ZP,11))
 .Q:$P($G(^PRC(442,ZP,12)),"^",2)'=""
 .S P1=$G(^PRC(442,ZP,0)),PONUM=$P(P1,"^")
 .I $D(PRC("SITE")) Q:$P(P1,"-")'=PRC("SITE")
 .S PC1=$P($G(^PRC(442,ZP,23)),"^",8) I PC1="" D DETAIL1
 .Q:PC1=""
 .I $G(FLAG)=0 Q:$P($G(^PRC(440.5,PC1,0)),"^",8)'=DUZ
 .I $G(FLAG)=1 I $P($G(^PRC(440.5,PC1,0)),"^",10)'=DUZ,$P($G(^PRC(440.5,PC1,0)),"^",9)'=DUZ Q
 .S P2=$G(^PRC(442,ZP,1)),PA=$P($G(^PRC(440.5,PC1,0)),"^",8) Q:PA=""
 .S PANAME=$P($G(^VA(200,PA,0)),"^") Q:PANAME=""
 .S Y=$P(P2,"^",15) D DD^%DT S PODATE=Y
 .S STAT=$P($G(^PRC(442,ZP,7)),"^") S:STAT'="" STAT=$P($G(^PRCD(442.3,STAT,0)),"^")
 .S Y=$P($G(^PRC(442,ZP,12)),"^",5) D DD^%DT S ADATE=Y
 .S ^TMP($J,ZP)=PONUM_"^"_PODATE_"^"_STAT_"^"_PANAME_"^"_ADATE,CNT=$G(CNT)+1
 D WRTE
 W:$D(^TMP($J)) !!!,?10,"Total number of orders found: "_CNT
 K ^TMP($J),CNT
 Q
 ;
DETAIL1 ;Get tally for the PC user and exclude the Approving Official.
 Q:$G(FLAG)=1
 ;if the PC Coordinator is asking for the report, get the orders.
 I $G(FLAG)="" D DETAIL2
 Q:$P($G(^PRC(442,ZP,12)),"^",4)'=DUZ!($G(FLAG)'=0)
 S PA=$P(^PRC(442,ZP,12),"^",4),PANAME=$P(^VA(200,PA,0),"^") Q:PANAME=""
 S Y=$P(^PRC(442,ZP,12),"^",5) D DD^%DT S ADATE=Y,PODATE=$P(Y,"@",1)
 S STAT=$P($G(^PRC(442,ZP,7)),"^") S:STAT'="" STAT=$P($G(^PRCD(442.3,STAT,0)),"^")
 S ^TMP($J,ZP)=PONUM_"^"_PODATE_"^"_STAT_"^"_PANAME_"^"_ADATE,CNT=$G(CNT)+1
 Q
 ;
DETAIL2 ;Get tally for the PC Coordinator.
 S PA=$P(^PRC(442,ZP,12),"^",4),PANAME=$P(^VA(200,PA,0),"^") Q:PANAME=""
 S Y=$P(^PRC(442,ZP,12),"^",5) D DD^%DT S ADATE=Y,PODATE=$P(Y,"@",1)
 S STAT=$P($G(^PRC(442,ZP,7)),"^") S:STAT'="" STAT=$P($G(^PRCD(442.3,STAT,0)),"^")
 S ^TMP($J,ZP)=PONUM_"^"_PODATE_"^"_STAT_"^"_PANAME_"^"_ADATE,CNT=$G(CNT)+1
 Q
 ;
WRTE ;
 U IO S (P,EX)=1
 I '$D(^TMP($J)) D HDR W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 S ZP="" F  S ZP=$O(^TMP($J,ZP)) Q:ZP=""  Q:EX="^"  D
 .D:P=1 HDR
 .W !,$P(^TMP($J,ZP),"^"),?21,$P(^TMP($J,ZP),"^",2),?40,$P(^TMP($J,ZP),"^",3),!,?10,$P(^TMP($J,ZP),"^",4),?40,$P(^TMP($J,ZP),"^",5),!
 .I (IOSL-$Y)<6 D HLD Q:EX="^"
 QUIT
 ;
C2237 ;cancel 2237 from PC order
 N I,N,T,X,ZX,PRCVIEN
 Q:'$D(DA)  S YDA=DA,PRCVIEN=DA,XDA=$P($G(^PRC(442,DA,23)),"^",23) Q:XDA=""  L +^PRCS(410,XDA):15 Q:'$T
 S PRC("CP")=$P($G(^PRC(442,YDA,0)),"^",3) Q:+PRC("CP")=""
 S T=$P(^PRCS(410,XDA,0),"^"),$P(^(11),"^",3)="",$P(^(0),"^",2)="CA",$P(^(5),"^")=0,$P(^(6),"^")=0 K ^PRCS(410,"F",+T_"-"_+PRC("CP")_"-"_$P(T,"-",5),XDA),^PRCS(410,"F1",$P(T,"-",5)_"-"_+T_"-"_+PRC("CP"),XDA),^PRCS(410,"AQ",1,XDA)
 K ZX I $D(^PRCS(410,XDA,4)) S ZX=^(4),X=$P(ZX,"^",8) F I=1,3,6,8 S $P(ZX,"^",I)=0
 I $D(ZX) S ^PRCS(410,XDA,4)=ZX K ZX
 I $D(^PRCS(410,XDA,12,0)) S N=0 F I=0:0 S N=$O(^PRCS(410,XDA,12,N)) Q:N'>0  S X=$P(^(N,0),"^",2) I X S DA(1)=XDA,DA=N D TRANK^PRCSEZZ S XDA=DA(1)
 D ERS410^PRC0G(XDA_"^C")
 L -^PRCS(410,XDA)
 I $D(^PRC(443,XDA,0)) S DA=XDA,DIK="^PRC(443," D ^DIK K DIK
 S DA=YDA
 ; PRC*5.1*81 - if site runs DynaMed, may need to build update txn
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 D DEL^PRCV442A(PRCVIEN)
 QUIT
 ;
RENUM ;  delete delivery order items from repetitive item list
 Q:$G(^PRCS(410.3,YDA,0))=""
 L +^PRCS(410.3,YDA):15 Q:'$T
 S IJ="" F  S IJ=$O(^PRCS(410.3,YDA,1,IJ)) Q:IJ=""  D
 .I $P($G(^PRCS(410.3,YDA,1,IJ,0)),"^",6)="O" S DA=IJ,DA(1)=YDA,DIK="^PRCS(410.3,"_DA(1)_",1," D ^DIK
 L -^PRCS(410.3,YDA)
 I $P($G(^PRCS(410.3,YDA,1,0)),"^",4)=0 W !,"This Repetitive Item List has no more items, and will be deleted." S DA=YDA,DIK="^PRCS(410.3," D ^DIK
 K DIK QUIT
 ;
HDR W @IOF
 W !,"INCOMPLETE PURCHASE CARD ORDERS REPORT",?45,TIMEDATE,?70,"PAGE ",P
 W !,"PURCHASE CARD ORDER",?21,"PO DATE",?40,"SUPPLY STATUS",!,?10,"BUYER",?40,"DATE PO ASSIGNED"
 W ! F I=1:1:8 W "----------"
 S P=P+1
 QUIT
 ;
HLD G HDR:$P(IOST,"-")="P" W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ="^" EX="^" S:'$T EX="^" D:EX'["^" HDR QUIT
