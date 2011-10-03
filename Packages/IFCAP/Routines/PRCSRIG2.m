PRCSRIG2 ;SF-ISC/LJP/KMB/BMM-GENERATE REQUESTS FROM REPETITIVE ITEM LIST FILE (CON'T) ; 3/25/05 3:05pm
V ;;5.1;IFCAP;**13,81,101**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;PRCSRI is the ordered item from the RIL.  PX(3) is
 ;the ordered item from the Item Master File. PRCSV1 is
 ;the vendor from the RIL. X2 is the vendor listed for
 ;the item from the Item Master File. PX(1) holds Item
 ;Master File data, PX(2) holds Vendor File data.
 ;
 ;2/16/05 BMM per PRC*5.1*81, added code in ITEMG1 to capture
 ;data from two new fields in files 410 and 410.3:
 ;DM Doc ID (410 #17, 410.3 #6) and Date Needed (410 #18, 410.3 #7)
 ;added variables PRCVDN, PRCVDTN in ITEMG
 ;
 ;3/9/05 BMM per PRC*5.1*81, added sub UPDAUD to update the DM Audit
 ;file when a 2237 is created.
 ;
ITEMG N STOP,PRCVDN,PRCVDTN S (PRCSRI,PRCSCS,STOP)="",(PRCSIT(1),K,BFLAG)=0
 S (PRCVDN,PRCVDTN)=""
 F PRCSRIM=0:1 S PRCSRI=$O(^TMP($J,410.3,PRCSRID0,1,"AC",PRCSV1,PRCSRI)) Q:PRCSRI=""  S PRCSIT=PRCSIT+1,PRCSIT(1)=PRCSIT(1)+1 D ITEMG1 D:STOP'=1 ITEMG3 Q:BFLAG  S STOP=""
 D:'BFLAG
 . D:$D(DA) ITEMG2 I $D(PRCSL),PRCSL L
 . D:IOSL-$Y<2 HOLD,HDRG W !!,"  Finished building request.",!,"This request contains ",PRCSIT(1)_$S(PRCSIT(1)=1:" item.",1:" items."),"  The total cost for this request is $",$J(PRCSCS,0,2),! S L="",$P(L,"-",IOM)="-" W L S L=""
 . S PRCSTC=PRCSTC+PRCSCS Q
 D:BFLAG
 . I (PRCSIT>0)  D
 . . S PRCSIT=PRCSIT-1
 . I (PRCSCT>0)  D
 . . S PRCSCT=PRCSCT-1
 Q
 ;
ITEMG1 S PX=^PRCS(410.3,PRCSRID0,1,PRCSRI,0),PX(3)=$P(PX,"^"),PX(1)=^PRC(441,PX(3),0),X2=$P(PX,"^",5),PX(2)=^PRC(440,X2,0),PRCVDN=$P(PX,"^",7),PRCVDTN=$P(PX,"^",8)
 ; If a discrepancy is found, set STOP=1, skip item
 I $D(PX(1)),$P(PX(1),"^",10)'?4N W !,"The budget object code for this item is not entered in the Item Master File.",!,"This item cannot be processed.",! S STOP=1
 I '$D(^PRC(441,PX(3),2,X2,0)) D:IOSL-$Y<2 HOLD,HDRG W !,$C(7),"WARNING!!! Item # ",PX(3)," is not available from ",$P(PRCSV1,";"),"  (",$P(PRCSV1,";",2),")",!,"This item cannot be processed.",! S PRCSIT=PRCSIT-1,PRCSIT(1)=PRCSIT(1)-1 S STOP=1
 Q
 ;
ITEMG3 I '$D(Z1)!'$D(Z2)  D DVERR Q
 I 'K S Z=Z1,X=Z2 D EN1^PRCSUT3 G:'X EX S X1=X D EN2^PRCSUT3 G:'$D(X1) EX L +^PRCS(410,DA):15 G:$T=0 EX
 D:IOSL-$Y<7 HOLD,HDRG
 I 'K W !,"A request with Transaction Number ",$P(Y(0),"^")," has been generated.",!!,"The vendor for this request is ",$P(PRCSV1,";"),"  (",$P(PRCSV1,";",2),")",!,"Now entering items for this request."
 ;PRC*5.1*81 update audit file for 2237 creation
 I 'K S PRCV2=$P(Y(0),"^",1)
 ;S K=K+1,X(3)=^PRC(441,PX(3),2,X2,0) I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),U,12)<1 S PRCSS=$S($P(PX(1),"^",10):$E($P(^PRCD(420.2,$P(PX(1),"^",10),0),"^"),1,30),1:"")
 ;
 ;For a Supply Fund Requests adding code to derive BOC from NSN
 S K=K+1
 S X(3)=^PRC(441,PX(3),2,X2,0)
 S ITNSN=$E($P($G(^PRC(441,+PX(3),0)),U,5),1,4)
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)) D
 . I $P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),U,12)'=2!($P(^(0),U,12)'=4) D
 . . S PRCSS=$S($P(PX(1),"^",10):$E($P(^PRCD(420.2,$P(PX(1),"^",10),0),"^"),1,30),1:"")
 . . Q
 . I $P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),U,12)=2!($P(^(0),U,12)=4) D
 . . S ITACCT=$$ACCT^PRCPUX1(ITNSN)
 . . S ITBOC=$S(ITACCT=1:2697,ITACCT=2:2698,ITACCT=3:2699,ITACCT=6:2699,ITACCT=8:2696,1:2699)
 . . S PRCSS=$E($P(^PRCD(420.2,ITBOC,0),U,1),1,30)
 . . Q
 . Q
 S:'$D(PRCSS) PRCSS="" S ^PRCS(410,DA,"IT",K,0)=K_"^"_$P(PX,"^",2)_"^"_$P(X(3),"^",7)_"^"_PRCSS_"^"_PX(3)_"^"_$P(X(3),"^",4)_"^"_$P(PX,"^",4),^PRCS(410,DA,"IT",K,1,0)="^^1^1^"_PRCSD1_"^^",^(1,0)=$P(PX(1),"^",2)
 ;PRC*5.1*81 add DM Doc ID, Date Needed to new line item
 ;
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 D
 . Q:'$D(^PRCV(414.02,"C",PRCSNO))
 . S ^PRCS(410,DA,"IT",K,4)=PRCVDN_"^"_PRCVDTN
 . D UPDAUD(PRCV2)
 S ^PRCS(410,DA,"IT","B",K,K)="",^PRCS(410,DA,"IT","AB",K,K)="" S:PRCSS ^PRCS(410,"AD",PRCSS,DA)=""
 S PRCSCS=PRCSCS+($P(PX,"^",2)*($P(PX,"^",4))) G EX2
 ;
ITEMG2 S ^PRCS(410,DA,"IT",0)="^"_"410.02AI"_"^"_K_"^"_K,%=$P(^PRCS(410.3,PRCSRID0,0),"^",3),$P(^PRCS(410,DA,0),"^",2)="O" S:% $P(^(0),"^",6)=%,^PRCS(410,"AO",%,DA)="" S $P(^PRCS(410,DA,0),"^",4)=$S($D(^PRC(440,"AC","S",X2)):5,1:3)
 S ^PRCS(410,DA,1)=PRCSD1_"^^"_"ST"_"^"_PRCSD(1),^(2)=PX(2),^PRCS(410,DA,3)=$P(^PRCS(410,DA,3),"^",1,2)_"^"_PRCSCC_"^"_X2_"^"_$S($D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)):$P(^(0),"^",10),1:"")
 S $P(^PRCS(410,DA,3),"^",11)=$P($$DATE^PRC0C(PRC("BBFY"),"E"),"^",7)
 S:PRC("ACC") $P(^PRCS(410,DA,3),"^",12)=$P(PRC("ACC"),"^",3)
 S ^PRCS(410,DA,4)=PRCSCS_"^"_PRCSD1_"^^^^^^"_PRCSCS,^(10)=K,^(7)=+PRC("PER")_"^"_$P(PRC("PER"),"^",3) S:'$D(^(11)) ^(11)=""
 S ^PRCS(410,"E",$E($P(PX(2),"^"),1,30),DA)="" S:PRCSCC ^PRCS(410,"AC",$E(PRCSCC,1,30),DA)=""
 I IO'=IO(0)!$D(ZTQUEUED) S $P(^PRCS(410,DA,11),U,3)=1,^PRCS(410,"F",PRC("SITE")_"-"_+PRC("CP")_"-"_$P($P(^PRCS(410,DA,0),U),"-",5),DA)="",^PRCS(410,"F1",$P($P(^PRCS(410,DA,0),U),"-",5)_"-"_PRC("SITE")_"-"_+PRC("CP"),DA)=""
 I IO'=IO(0)!$D(ZTQUEUED) S ^PRCS(410,"AQ",1,DA)="" L -^PRCS(410,DA) G END
 S PRC("QTR")=$P($P(^PRCS(410,DA,0),U),"-",3) D ASK^PRCSRIG1 L -^PRCS(410,DA)
END K DA,PRCSDR,PRCSCQT,PRCSOCK,PRCSOCP,PRCSOCS,PRCST,PRCST1,PX,X2 Q
 ;
HDRG W @IOF,"GENERATE REQUESTS FROM REPETITIVE ITEM LIST FILE",?55,"DATE: ",PRCSD,!,"Requests Generated From Repetitive Item List Entry # ",PRCSNO,! S L="",$P(L,"-",IOM)="-" W L S L=""
 Q
 ;
HOLD Q:IO'=IO(0)!($D(ZTQUEUED))  W !,"Press return to continue: " R Z(1):DTIME Q
EX K PX,X,X1,X2,Z S PRCSCT=PRCSCT-1 W $C(7),!,"Could not create a request" Q
EX1 K X,X2 D KRL K PX Q
EX2 K PRCSS,Y D KRL K PX(3),X(3) Q
KRL Q
 ;
UPDAUD(PRCV2) ;per PRC*5.1*81, update DM Audit file (#414.02) when 2237 is created
 ;PRCV2 - 2237's .01 value
 ;PRCVDYN - DM Doc ID for each item
 ;PRCSRID0 - RIL IEN from above
 ;
 ;first check DM flag
 ;Q:$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1
 N PRCVA,PRCVAC,PRCVC,PRCVDI,PRCVDYN,PRCVI,PRCVIEN,PRCVFCP
 N PRCVFL,PRCVJ,PRCVST,PRCVTMP,XMB
 S (PRCVC,PRCVDYN,PRCVIEN)="",PRCVFL=0
 ;get #items for RIL in 414.02
 ;F PRCVI=0:1 S PRCVC=$O(^PRCV(414.02,"C",PRCSNO,PRCVC)) Q:PRCVC=""
 ;for each item, update entry in 414.02
 ;F PRCVJ=1:1:PRCVI Q:PRCVFL=1  D
 S PRCVJ=PRCSRI D
 . S PRCVDYN=$$GET1^DIQ(410.31,PRCVJ_","_PRCSRID0_",",6)
 . ;
 . I PRCVDYN="" D  Q
 . . ;DM Doc ID missing
 . . S PRCVTMP="PRCSRIG2",PRCVST=$P(PRCSNO,"-")
 . . S PRCVFCP=$P(PRCSNO,"-",4)
 . . S XMB(1)="creating a new 2237 record"
 . . S XMB(2)=" <missing>"
 . . S XMB(3)="DM doc ID value missing from line item in 2237"
 . . S ^TMP($J,"PRCSRIG2",1,0)=""
 . . S ^TMP($J,"PRCSRIG2",2,0)="2237 #: "_PRCV2
 . . S ^TMP($J,"PRCSRIG2",3,0)="Item #: "_PX(3)
 . . D DMERXMB^PRCVLIC(PRCVTMP,PRCVST,PRCVFCP)
 . ;
 . S PRCVIEN=$O(^PRCV(414.02,"B",PRCVDYN,0))
 . S PRCVA(414.02,PRCVIEN_",",7)=PRCV2
 . D FILE^DIE("","PRCVA")
 . I $D(^TMP("DIERR",$J)) D  Q
 . . ;error updating Audit file
 . . S PRCVTMP="PRCSRIG2",PRCVST=$P(PRCSNO,"-")
 . . S PRCVFCP=$P(PRCSNO,"-",4)
 . . S XMB(1)="updating the DynaMed IFCAP Interface Audit file (#414.02)"
 . . S XMB(2)=PRCVDYN
 . . S XMB(3)="unable to add update to Audit file entry"
 . . S ^TMP($J,"PRCSRIG2",1,0)=""
 . . S ^TMP($J,"PRCSRIG2",2,0)="2237 #: "_PRCV2
 . . S ^TMP($J,"PRCSRIG2",3,0)="Item #: "_PX(3)
 . . S ^TMP($J,"PRCSRIG2",4,0)="Error text: "_$G(^TMP("DIERR",$J,1,"TEXT",1))
 . . D DMERXMB^PRCVLIC(PRCVTMP,PRCVST,PRCVFCP)
 Q
DVERR D BLNKON
 W !,"There is an error with the default device defined in file 411.",!,"Please contact IRM before proceeding.",!
 D BLNKOFF
 S BFLAG=1
 Q
 ;
BLNKON ;if terminal-type exists turn-on blink
 D:$D(IOST(0))
 . S X="IOBON"
 . D ENDR^%ZISS
 . W IOBON
 Q
BLNKOFF ;if terminal-type exists turn-off blink
 D:$D(IOST(0))
 . S X="IOBOFF"
 . D ENDR^%ZISS
 . W IOBOFF
 Q
