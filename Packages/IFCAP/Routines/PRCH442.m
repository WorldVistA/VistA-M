PRCH442 ;WISC/KMB/DL/DXH - CREATE PURCHASE CARD ORDER FROM RIL ;12.1.99
 ;;5.1;IFCAP;**13,81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;  entry point for delivery orders
S1 N RLFLAG S RLFLAG=1
S2 ;  entry point for purchase card orders
 N RPUSE,SS,FSC,AA,BB,CC,EE,FF,CP,FCP,IB,J,ITEM,UCOST,MAX,PMULT,VSTOCK,VENDOR,VENDOR1,NDC,CONT,UOP,CONV,SKU,SPEC,APP,QTY,ORDTOT,PDA,CTT,CNNT,NCOST,COSTTOT,REQCT
 N HM,CCDA,II,PP,IB,IJ,CTT,CTR,OUTRL,SERV,TDATE,CNNT1,ZS,ZS0,XDA,YDA,WHSE,COMMENT,PRCS,PRCVDYN,PRCKILL,GG
 W ! S DIC="^PRCS(410.3,",DIC(0)="AEMQ",DIC("S")="S PRC(""SITE"")=+^(0),PRC(""CP"")=$P(^(0),""-"",4),$P(^(0),U,5)="""" I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))" D ^DIC K DIC("S") Q:Y'>0
 K DIC S (YDA,XDA,DA)=+Y
 S:'$D(PRC("SST")) PRC("SST")="" S DIC("B")=PRC("SST") I $D(^PRC(411,"UP",+PRC("SITE"))) S DIC="^PRC(411,",DIC(0)="AEQZS",DIC("A")="Select SUBSTATION: ",DIC("S")="I $E($G(^PRC(411,+Y,0)),1,3)=PRC(""SITE"")" D ^DIC I Y>0 S PRC("SST")=+Y
 K DIC Q:Y'>0
 I '$D(PRC("PARAM")) S PRC("PARAM")=$$NODE^PRC0B("^PRC(411,PRC(""SITE""),",0)
 S COMMENT="purchase card",WHSE=+$O(^PRC(440,"AC","S",0)) S:$G(RLFLAG)=1 COMMENT="delivery"
 ; introducing prcsip as package-wide
 S OUTRL=0,PRCSIP=$P(^PRCS(410.3,XDA,0),U,3)
 S CTT=$P($G(^PRCS(410.3,XDA,1,0)),"^",4) I +CTT=0 W !,"There are no items on this repetitive item list." Q
 ;
 ;See NOIS MON-0399-51726
 KILL ^TMP($J)
 S IB=0,PRCVDYN=0
 ;
 ; PRC*5.1*81 set flag (PRCVDYN) for DynaMed RIL
 I $O(^PRCV(414.02,"C",$P(^PRCS(410.3,XDA,0),"^",1),0))]"" S PRCVDYN=1
 ;
 F  S IB=$O(^PRCS(410.3,XDA,1,IB)) Q:'IB  D  ;
 . S FF=$G(^PRCS(410.3,XDA,1,IB,0))
 . S ^TMP($J,410.3,XDA,1,"AC",$P(FF,"^",3)_";"_$P(FF,"^",5),IB)=""
 ;
 W !,"This repetitive item list has the following vendors:",!
 ;
 S HM=""
 F  S HM=$O(^TMP($J,410.3,XDA,1,"AC",HM)) Q:HM=""  D
 . W !,$P(HM,";"),?40,"NUMBER: ",$P(HM,";",2)
 ;
 W !
 S ZS=$P(^PRCS(410.3,XDA,0),"^"),PRC("SITE")=$P(ZS,"-"),CP=+$P(ZS,"-",4),CCEN=$P(ZS,"-",5)
 D FY
 S SPEC=$P($G(^PRC(420,PRC("SITE"),1,CP,0)),"^",12),(FCP,PRC("CP"))=$P($G(^PRC(420,PRC("SITE"),1,CP,0)),"^"),SERV=$P($G(^(0)),"^",10)
 S PRC("BBFY")=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP")),APP=$P($$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY")),"^",11)
PROCESS ;
 ; get item data from repetitive item list
 S VENDOR1=0,(REQCT,COSTTOT,IB)=0
 F  S VENDOR1=$O(^TMP($J,410.3,XDA,1,"AC",VENDOR1)) Q:VENDOR1=""  D PROCESS1
 W !!!,"Total number of requests generated: ",REQCT,!,"Total cost of all requests: $",$J(COSTTOT,0,2)
 Q:REQCT=0
 W !,"Generating ",COMMENT," orders...."
 I $D(EE($J)) S PP="",RPUSE=1 F  S PP=$O(EE($J,PP)) Q:PP=""  S DA=PP D
 .K CCDA D ^PRCH410
 .I $G(CCDA)'="" W !,"Request ",$P(^PRCS(410,CCDA,0),"^")," created.",!
 ;
 ; PRC*5.1*81 if DynaMed RIL and trouble with item, save RIL# to ^TMP
 I PRCVDYN,$O(^TMP($J,"PRCVHMSG","")) S ^TMP($J,"PRCVHMSG",YDA)=$P(^PRCS(410.3,YDA,0),"^",1)
 ;
 D RENUM^PRCH442A
SLIST S PRCKILL=0 I 'PRCVDYN D
 . I $G(^PRCS(410.3,YDA,0))'="" S %=2 W !,"Do you wish to re-use this list" D YN^DICN G:%=0 SLIST I %=2 S PRCKILL=1
 ;
 ; PRC*5.1*81 - send DynaMed a cancel txn for any items not moved to a PC
 I PRCVDYN D
 . I +$O(^PRCS(410.3,YDA,1,0))>0 D EN^PRCVRCA(YDA)
 ;
 I PRCVDYN!PRCKILL S DA=YDA,DIK="^PRCS(410.3," D ^DIK K DIK
 ;
 ; PRC*5.1*81 - send message to user of problems found
 I PRCVDYN,$O(^TMP($J,"PRCVHMSG","")) D DYNAMSG
 ;
 W !,"End of processing."
 K RLFLAG,PRCHPC,PRCS,^TMP($J) QUIT
 ;
PROCESS1 ;
 N PRCVDATE
 S NCOST=0,CNNT=0,PRCVDATE=""
 S IB=$O(^TMP($J,410.3,XDA,1,"AC",VENDOR1,0)),VENDOR=$P($G(^PRCS(410.3,XDA,1,IB,0)),"^",5)
 I VENDOR="" Q
 I VENDOR=WHSE,$G(SPEC)'=2 Q
 I OUTRL=1 Q
 S IB=0 F  S IB=$O(^TMP($J,410.3,XDA,1,"AC",VENDOR1,IB)) Q:IB=""  D ITEM Q:OUTRL
 Q:CNNT=0
 K PDA D SETUP^PRCH442A
 I '$D(PDA) Q
 S REQCT=REQCT+1,COSTTOT=COSTTOT+NCOST
 W !,"Request ",$P($G(^PRC(442,PDA,0)),"^")," has been created."
 W !,"The vendor for this request is: ",$P(VENDOR1,";"),"  "
 W "(",$P(VENDOR1,";",2),")"
 W !,"Total cost of request: $",$J(NCOST,0,2),!,"Total items on ",COMMENT," request: ",CNNT
 QUIT
ITEM ;
 S SS=$G(^PRCS(410.3,XDA,1,IB,0))
 I $G(RLFLAG)=1,$P(SS,"^",6)'="Y" Q
 S ITEM=$P(SS,"^"),QTY=$P(SS,"^",2),EST=$P(SS,"^",4)
 I '$D(^PRC(441,+ITEM,2,+VENDOR,0)) Q
 S ZS0=$G(^PRC(441,ITEM,2,VENDOR,0))
 S ZS=$G(^PRC(441,ITEM,0)),NSN=$P(ZS,"^",5),BOC=$P(ZS,"^",10),FSC=$P(ZS,"^",3)
 I SPEC=2 S BOC=$$ACCT^PRCPUX1($E($$NSN^PRCPUX1(ITEM),1,4)) S BOC=$S(BOC=1:2697,BOC=1:2698,BOC=8:2696,1:2699)
 I BOC'="" S BOC=$P($G(^PRCD(420.2,BOC,0)),"^"),BOC=$E(BOC,1,30)
 S SKU=$P($G(^PRC(441,ITEM,3)),"^",8)
 S UCOST=$P(ZS0,"^",2),CONT=$P(ZS0,"^",3),VSTOCK=$P(ZS0,"^",4),NDC=$P(ZS0,"^",5),UOP=$P(ZS0,"^",7),PMULT=$P(ZS0,"^",8),MAX=$P(ZS0,"^",9),CONV=$P(ZS0,"^",10)
 S:CONT'="" CONT=$P($G(^PRC(440,+VENDOR,4,CONT,0)),"^")
 S CNNT=CNNT+1
 S AA(CNNT)=CNNT_"^"_QTY_"^"_UOP_"^"_BOC_"^"_ITEM_"^"_VSTOCK_"^"_UCOST_"^^"_UCOST_"^^^"_PMULT_"^"_NSN_"^"_MAX_"^"_NDC_"^"_SKU_"^"_CONV
 ; enter item description from file
 S CNNT1=$P($G(^PRC(441,ITEM,1,0)),"^",4)
 I CNNT1'="" F J=1:1:CNNT1 S BB(CNNT,J)=$G(^PRC(441,ITEM,1,J,0))
 S TOTAL=QTY*UCOST,CC(CNNT)=TOTAL_"^"_CONT_"^"_FSC,NCOST=NCOST+TOTAL
 ;
 ; PRC*5.1*81 - save DM DOC ID and earliest DATE NEEDED BY, set any problems into ^TMP
 I PRCVDYN D
 . S $P(CC(CNNT),"^",15)=$P(^PRCS(410.3,XDA,1,IB,0),"^",7) ; DM DOC ID
 . I $P(CC(CNNT),"^",15)']"" S ^TMP($J,"PRCVHMSG",XDA,ITEM)="<missing>" ; no DOCID
 . I $P(SS,"^",8)>0,$P(SS,"^",8)<PRCVDATE S PRCVDATE=$P(SS,"^",8)
 . I PRCVDATE="" S PRCVDATE=$P(SS,"^",8)
 ;
 I $P(SS,"^",6)="Y" S $P(^PRCS(410.3,XDA,1,IB,0),"^",6)="O"
 S GG(CNNT)=IB
 QUIT
 ;
FY D NOW^%DTC S TDATE=X,SDATE=$$FMADD^XLFDT(TDATE,10),(FY,PRC("FY"))=$E(X,2,3),QTR=$E(X,4,5),PRC("QTR")=$P("2^2^2^3^3^3^4^4^4^1^1^1","^",+QTR)
 I PRC("QTR")=1 S FY=$E(100+FY+1,2,3),PRC("FY")=FY
 QUIT
 ;
DYNAMSG ; PRC*5.1*81 - Build message to user of items not in audit file
 N I,XMB,PRCDATA,PRCNT,PRCVI,PRCVIEN,PRCRIL
 S PRCVIEN=$O(^TMP($J,"PRCVHMSG",0)) Q:+PRCVIEN=0
 S PRCRIL=^TMP($J,"PRCVHMSG",PRCVIEN)
 S XMB(1)=" generating PC orders from RIL# "_PRCRIL
 S XMB(2)=" <SEE BELOW>"
 S XMB(3)=" unable to enter PO# for item in audit file (#414.02)"
 S PRCVI=0,PRCNT=0
 F  S PRCVI=$O(^TMP($J,"PRCVHMSG",PRCVIEN,PRCVI)) Q:+PRCVI=0  D
 . S PRCDATA=$G(^TMP($J,"PRCVHMSG",PRCVIEN,PRCVI))
 . F I=1,2 I $P(PRCDATA,"^",I)']"" S $P(PRCDATA,"^",I)="<missing>"
 . S PRCNT=PRCNT+1
 . S ^TMP($J,"PRCV442M",PRCNT)="ITEM# "_PRCVI_" placed on PO# "_$P(PRCDATA,"^",2)_" has DM DOC ID# "_$P(PRCDATA,"^",1)
 D DMERXMB^PRCVLIC("PRCV442M",+PRCRIL,$P(PRCRIL,"-",4))
 Q
