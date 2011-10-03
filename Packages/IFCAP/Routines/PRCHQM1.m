PRCHQM1 ;WISC/KMB-MANUAL PRINT RFQ PROCESSING 3/26/96 ;7/23/99  16:33
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 W !!!,"Use this option to print the 90 column manual quotation form to a printer.",!
 K DIR S DIR(0)="SMB^A:ALL MANUALLY SOLICITED;I:INDIVIDUAL"
 S DIR("A",1)="Do you wish to print RFQs for All manually solicited or an"
 S DIR("A")="Individual vendor"
 S DIR("?",1)="All manually solicited vendors will print a RFQ form for each vendor"
 S DIR("?",2)="who has previously been selected for manual solicitation.  Individual"
 S DIR("?",3)="will enable you to print a manual RFQ for any single vendor, whether"
 S DIR("?",4)="or not he has previously been specified for manual solicitation."
 S DIR("?",5)="If the vendor has not been specified for solicitation earlier, he"
 S DIR("?")="will be added to the list of manually solicited vendors."
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) K DTOUT,DUOUT,DIRUT,DIROUT Q
 I Y="I" G SELECT
ASK S DIC="^PRC(444,",DIC("S")="I $P(^(0),""^"",8)>1",DIC(0)="AEMQZ"
 D ^DIC K DIC I Y<0 K DA,X,Y Q
 S DA=+Y
 S X=0,Y=0
 F  S X=$O(^PRC(444,DA,5,X)) Q:+X'=X  I $P($G(^PRC(444,DA,5,X,0)),U,2)="m" S Y=1 Q
 I 'Y W !!,"There are no vendors for Manual Solicitation!" K DA G ASK
A S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $E(IOST)'="P"!(IOM'>89) D ^%ZISC,EN^DDIOL("Device must be a printer supporting 90 characters per line.") G A
 I $D(IO("Q")) S ZTRTN="PROCESS^PRCHQM1",ZTSAVE("DA")="" D ^%ZTLOAD,HOME^%ZIS Q
 D PROCESS
 Q
PROCESS ;
 N X,Y,FOB,FOB1,FOB2,SB1,SB2,FOB1,FOB2,FOB3,FOB4,I,J,P,UPU,UPR,LOC,IP,FLG
 N SVEND,PPHONE,REF,LN,LDESC,QTY,ADATE,CBDATE,RDATE,SRC,PA,ZIP,ZIP1,LD
 N SRC,ISS,K,D0,BC1,BC2,BC3,BC4,BC5,BC6,RFQNUM,LDATE,FDES1,FDES2,FDES3,FDES4
 N PRCSUB,Z,C1,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,PAFAX,PRCEMAIL,VENPH,VENFAX
 K ^TMP($J) S D0=DA
 S SVEND=$P($G(^PRC(444,DA,5,0)),"^",4)
 S (FDES1,FDES2,FDES3,FDES4,BC1,BC2,BC3,BC4,BC5,BC6)=""
 S (J,P)=1,(PAFAX,PPHONE,SB1,FOB2)=" ",FOB1="x"
 S:$P($G(^PRC(444,DA,1)),"^")="O" FOB1=" ",FOB2="x"
 S RFQNUM=$P($G(^PRC(444,DA,0)),"^",1),RDATE=$P($G(^PRC(444,DA,0)),"^",2),CBDATE=$P($G(^PRC(444,DA,0)),"^",3)
 S REF=$P($G(^PRC(444,DA,0)),"^",9),PA=$P($G(^PRC(444,DA,0)),"^",4)
 I PA>0 D
 . N PRCX,DIC,DR,DA,DIQ,D0 K ^UTILITY("DIQ1",$J)
 . S DIC=200,DR=".01;.135;.136;.151",DA=PA,DIQ="PRCX",DIQ(0)="I" D EN^DIQ1
 . S PA=PRCX(200,DA,.01,"I"),PPHONE=PRCX(200,DA,.135,"I"),PAFAX=PRCX(200,DA,.136,"I"),PRCEMAIL=PRCX(200,DA,.151,"I") K ^UTILITY("DIQ1",$J)
 S IP=$P(RFQNUM,"-") I IP'="" S IP=$P($G(^PRC(411,IP,0)),"^",10)
 I IP'="" S ISS(5)=$P($G(^DIC(4,IP,0)),"^",2),ISS(1)=$P($G(^(0)),"^",8),ISS(6)=$P($G(^(1)),"^",4) F I=1:1:3 S ISS(I+1)=$P($G(^DIC(4,IP,1)),"^",I)
 S:$G(ISS(5))'="" ISS(5)=$P($G(^DIC(5,ISS(5),0)),"^",2)
 S Y=$P($G(^PRC(444,DA,1)),"^",3)
 I Y'="" D
 . N PRCX,PRCSHIP
 . S PRCSUB=$P(^PRC(444,DA,0),"^",10) S:PRCSUB="" PRCSUB=$P($P(^PRC(444,DA,0),"^"),"-")
 . S PRCSHIP=$G(^PRC(411,PRCSUB,1,Y,0)),FDES1=$P(PRCSHIP,"^")
 . S PRCX=$P(PRCSHIP,"^",5)_", "_$S($P(PRCSHIP,"^",6)]"":$P($G(^DIC(5,$P(PRCSHIP,"^",6),0)),"^",2),1:"")_"  "_$P(PRCSHIP,"^",7)
 . S FDES2=$P(PRCSHIP,"^",2) I FDES2="" S FDES2=PRCX Q
 . S FDES3=$P(PRCSHIP,"^",3) I FDES3="" S FDES3=PRCX Q
 . S FDES4=PRCX
 S SB1=$P($G(^PRC(444,DA,1)),"^",7),ADATE=$P($G(^(1)),"^",2) S:SB1="" SB2="x"
 ;
IDATA ;
 S ZIP=0 F  S ZIP=$O(^PRC(444,DA,2,ZIP)) Q:+ZIP=0  D
 .S LN=$P($G(^PRC(444,DA,2,ZIP,0)),"^"),QTY=$P($G(^(0)),"^",2),UPU=$P($G(^(0)),"^",3)
 .S:UPU'="" UPU=$P($G(^PRCD(420.5,UPU,0)),"^")
 .S UPR=""
 .S FLG=0,ZIP1=$P($G(^PRC(444,DA,2,ZIP,4,0)),"^",4) S:+ZIP1=0 ZIP1=1,FLG=1 F LD=1:1:ZIP1 D
 ..S LOC=$P($G(^PRC(444,DA,2,ZIP,4,LD,0)),"^",4),LDATE=$P($G(^(0)),"^",2) S:FLG=0 QTY=$P($G(^(0)),"^",3)
 ..S:LOC'="" LOC=$P(^PRCS(410.8,LOC,0),"^")
 ..I LDATE'="" S Y=LDATE D DD^%DT S LDATE=Y
 ..S ^TMP($J,LN,LD)=LN_"^"_LOC_"^"_QTY_"^"_UPU_"^"_UPR_"^"_LDATE_"^"_" "
 S Y=RDATE D DD^%DT S RDATE=Y
 S Y=ADATE D DD^%DT S ADATE=Y
 S Y=CBDATE D DD^%DT S CBDATE=Y
FVEND ;
 ;
 I $G(PRCOPTN)'="ONE" F K=1:1:SVEND D SVEND^PRCHQM3 I '$D(FLAG) D ^PRCHQM2,REP^PRCHQM4,VET^PRCHQM3,ADMCERT^PRCHQM4(DA,P) W !?28,"--LAST PAGE--"
 I $G(PRCOPTN)="ONE" D
 . N FILE,VEN,KK,VEN440
 . S KK=$P(PRCVEN,";"),FILE=$P(PRCVEN,";",2),VEN=@("^"_FILE_KK_",0)")
 . S VENPH=$S(FILE[440:$P(VEN,U,10),FILE[444.1:$P(VEN,U,6),1:"")
 . I FILE[440 F I=1:1:8 S SRC(I)=$P(VEN,"^",I)
 . I FILE[444.1 S SRC(1)=$P(VEN,"^"),VEN(1)=$G(^PRC(444.1,KK,1)) F I=1:1:7 S SRC(I+1)=$P(VEN(1),"^",I)
 . S:SRC(7)'="" SRC(7)=$P($G(^DIC(5,SRC(7),0)),"^",2)
 . I FILE[444.1 S VENFAX=$P($G(VEN),"^",7)
 . I FILE[440 S VEN440=$G(@("^"_FILE_KK_",10)")),VENFAX=$P(VEN440,"^",6)
 . D ^PRCHQM2,REP^PRCHQM4,VET^PRCHQM3,ADMCERT^PRCHQM4(DA,P)
 . W !?28,"--LAST PAGE--"
 . I '$D(^PRC(444,PRCDA,5,"B",PRCVEN)) D
 . . N DD,DO,DIC,DA,DIE,DR
 . . S X=PRCVEN,DIC="^PRC(444,PRCDA,5,",DIC(0)="LX",DLAYGO=444.01
 . . S DIC("P")=$P(^DD(444,20,0),U,2),DA(1)=PRCDA
 . . D FILE^DICN K DIC,DLAYGO
 . . Q:+Y<1
 . . S DIE="^PRC(444,PRCDA,5,",DA(1)=PRCDA,DA=+Y,DR="1////m"
 . . D ^DIE
 I $P($G(^PRC(444,DA,9)),U)="" D
 . N X,Y,%,%H,%I D NOW^%DTC
 . S $P(^PRC(444,DA,9),U)=%
 K ^TMP($J),DA,FLAG,PRCVEN I $D(ZTQUEUED) S ZTREQ="@" K PRCOPTN,PRCDA
 D ^%ZISC
 Q
SELECT ;Entry point for Print Single RFQ
 K DIR,DA,DIC
 S DIC="^PRC(444,",DIC("S")="I $P(^(0),U,8)=2",DIC(0)="AEMQZ"
 D ^DIC K DIC I Y<1 K DA,X,Y,DTOUT,DUOUT Q
 S PRCDA=+Y
VSELECT ;Vendor select
 K DIR,DA S DIR(0)="444.01,.01",DIR("A")="Enter an existing Vendor or RETURN"
 S DIR("?")="^D HELP^PRCHQM1" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) G EX
 S:Y>0 PRCVEN=Y
 I Y<1 D  G:$G(PRCOUT) EX
 . K DIC,DA S DIC="^PRC(444.1,",DIC(0)="AELMQ",DLAYGO=444.1
 . S DIC("A")="Enter the Vendor's Name: "
 . D ^DIC K DIC,DLAYGO
 . I Y<1 W !,"The vendor was NOT added to the RFQ VENDOR File!" S PRCOUT=1 Q
 . S DA=+Y,PRCVEN=DA
 . L +^PRC(444.1,PRCVEN):3 E  W !,"This vendor entry is in use, please try later!" S PRCOUT=1 Q
 . S DIE="^PRC(444.1,",DR=".01;18.3;38;4.8;5;46;1R;2;3;4;4.2R;4.4R;4.6"
 . D ^DIE K DIE,DR,DA L -^PRC(444.1,PRCVEN)
 . S PRCVEN=PRCVEN_";PRC(444.1,"
 K DA S DA=PRCDA,PRCOPTN="ONE"
DEVICE S %ZIS("A")="Device to Print RFQ: ",%ZIS("B")="",%ZIS="MQ" D ^%ZIS
 G:POP EX
 I $E(IOST)'="P"!(IOM'>89) D ^%ZISC,EN^DDIOL("Device must be a printer supporting 90 characters per line.") G DEVICE
 I $D(IO("Q")) S ZTRTN="PROCESS^PRCHQM1",ZTSAVE("DA")="",ZTSAVE("PRCVEN")="",ZTSAVE("PRCOPTN")="",ZTSAVE("PRCDA")="" D ^%ZTLOAD,HOME^%ZIS K ZTSK G EX
 D PROCESS
EX K PRCX,PRCDA,PRCVEN,DA,PRCOPTN,PRCOUT,POP,DIC,DIE,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 Q
HELP ;Help for DIR lookup of vendor
 N PRCA,PRCX,PRCJ,X,Y,Z,PRCTMP S $P(PRCA," ",81)=""
 S PRCTMP(1)="The current Solicited Vendors for this RFQ are: "
 S PRCX=0,PRCJ=1
 F  S PRCX=$O(^PRC(444,PRCDA,5,PRCX)) Q:+PRCX'=PRCX  D
 . Q:'$D(^PRC(444,PRCDA,5,PRCX,0))  S X=^(0)
 . S Y=$P(X,U),Y=$P($G(@("^"_$P(Y,";",2)_$P(Y,";")_",0)")),U)
 . S Z=$P(";EDI;MANUAL",";",$F("em",$P(X,U,2)))
 . S PRCJ=PRCJ+1,PRCTMP(PRCJ)="    "_Y_$E(PRCA,$L(Y)+1,50)_Z
 S PRCJ=PRCJ+1,PRCTMP(PRCJ)=""
 S PRCJ=PRCJ+1,PRCTMP(PRCJ)="First check that the Vendor in not already on file in the VENDOR file (#440)"
 S PRCJ=PRCJ+1,PRCTMP(PRCJ)="  or the RFQ VENDOR file (#444.1).  By entering RETURN, you will be"
 S PRCJ=PRCJ+1,PRCTMP(PRCJ)="  given an opportunity to add a new vendor to the RFQ VENDOR file."
 S PRCJ=PRCJ+1,PRCTMP(PRCJ)=""
 D EN^DDIOL(.PRCTMP)
 Q
