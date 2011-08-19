PRCHRPT ;WIRMFO/RSD/REW,RHD-PRINT OPTIONS ;11/13/00 4:27pm
 ;;5.1;IFCAP;**7**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ST S PRCF("X")="SP"
 D ^PRCFSITE
 Q
 ;
PO S PRCHP("S")="$P(^(0),U,2)<10!($P(^(0),U,2)=25)"
 I $G(PRCHPC) S PRCHP("S")="$P(^(0),U,2)=25" ; <<< Patch 72
 I $G(PRCHDELV) S PRCHP("S")="$P($G(^(23)),U,11)=""D"""
 S PRCHP("A")="P.O./REQ.NO.: "
 D EN3^PRCHPAT
 I $D(PRCHPO),$D(^PRC(442,+PRCHPO,0)),$P(^(0),U,2)=8 S PRCHNRQ=1
 Q
 ;
EN ;REPRINTS ON A&MM PRINTER
 D ST
 ;
EN0 Q:'$D(PRC("PARAM"))
 D PO
 Q:'$D(PRCHPO)
 I X<10 I '$G(PRCHPC) W " ??  Incorrect Status for this option",$C(7) G EN0
 S (DEFPNT,%ZIS("B"))=$S($G(PRCHPC):"",1:$O(^PRC(411,+PRC("SITE"),2,"AC","S8",0)))
 N IOP,PL
R S %ZIS="Q"
 S %ZIS("A")="Print on what Device: "
 D ^%ZIS
 I POP>0 D ^%ZISC,QK G EN0
 S:'$D(PL) PL=DEFPNT
 S PRCHIO=DEFPNT
 S NOZTDTH=""
 S PRCHQ=1
 S D0=PRCHPO
 S PRCHQ("DEST")=PL
 S X=$S($P(PRC("PARAM"),U,11)=1:1,1:2)
 S PRCHQ=$S(X=2:"^PRCHFPNT",1:"^PRCHPNT")
 S PRCHREPR=1
 I $G(ION)["MESSAGE" S:0 ZTIO=ION_";"_IOST D:0 ^%ZISC D MESS D K G EN0
 I PRCHQ="^PRCHPNT",'$D(^PRC(411,+PRC("SITE"),2,"AC","S9")) D W G EN
 I $G(IO("Q"))="" D  G EN0
 .  U IO
 .  D @PRCHQ
 .  D ^%ZISC
 .  D K
 .  Q
 S PRCHQ("DEST")=ION
 D ^%ZISC,^PRCHQUE,K
 G EN0
 ;
EN1 ;REPRINTS PO IN FISCAL
 D ST
 ;
EN10 D PO Q:'$D(PRCHPO)  I X<10 W " ??  Incorrect Status for this option",$C(7) G EN10
 I X'=10,X'=28,X'=33 W !,$C(7)," Please note the STATUS of this Order--it has already been obligated.",! S %A="Are you sure you want to re-print it ",%=2 D ^PRCFYN Q:%=-1  G:%'=1 EN10
 S D0=PRCHPO,PRCHQ="^PRCHFPNT",PRCHREPR=1,PRCHQ("DEST")="F" D ^PRCHQUE,K
 G EN10
 ;
EN2 ;REPRINT AMENDMENT
 D ST
EN20 D PO Q:'$D(PRCHPO)  S D0=PRCHPO I '$D(^PRC(442,D0,6,"B")) W !?2,$C(7),"No Amendments for this Order" G EN20
 ;
EN21 R !?5,"Amendment number: ",X:DTIME G EN20:X=""!(X["^"),EN2H:$E(X)="?"!('$D(^PRC(442,D0,6,"B",X)))
 S D1=X,PRCHQ="^PRCHPAM",PRCHREPR=1 D ^PRCHQUE,K
 G EN20
 ;
EN2H W !?5,"Enter an amendment number.  Choose from: " S X=0 F I=0:1 S X=$O(^PRC(442,D0,6,"B",X)) Q:'X  W:I "," W X
 G EN21
 ;
EN3 ;DISPLAY P.O.
 D ST
EN30 D PO Q:'$D(PRCHPO)
 I X<10 W $C(7)," >>> Status makes this record non-specifiable here."
 S D0=PRCHPO D ^PRCHDP1,K
 G EN30
 ;
EN4 ;PRINT PO FOR RECEIVING
 D ST
EN40 D PO Q:'$D(PRCHPO)  I X<10!(X>51) W " ??  Incorrect Status for this option",$C(7) G EN40 ; was > 40, changed per DUB-0397-32163
 S Y=0 I $D(^PRC(442,DA,11,0)) S DIC="^PRC(442,DA,11,",DIC(0)="NEAZ",DIC("A")="RECEIVING REPORT DATE: " D ^DIC
 S PRCHFPT=$S(Y>0:+Y,1:0),D0=PRCHPO,PRCHQ="^PRCHFPNT",PRCHQ("DEST")="R" D ^PRCHQUE
 D K G EN40
 ;
EN5 ;FCP BALANCE
 D ST
EN50 Q:'$D(PRC("SITE"))  I '$D(^PRC(420,PRC("SITE"),1,0)) W !,"No Control Points exists for this station.",$C(7) K PRC Q
 S DIC="^PRC(420,"_PRC("SITE")_",1,",DIC(0)="AEMNQZ",DIC("A")="Select CONTROL POINT: " D ^DIC K DIC Q:Y<0  S PRC("CP")=$P($P(Y(0),U,1)," ",1),C1=1
 S %DT="AEP",%DT("B")="TODAY",%DT("A")="BALANCE AS OF DATE: " D ^%DT K %DT Q:Y<0
 S PRC("QTR")=$P("2^2^2^3^3^3^4^4^4^1^1^1","^",$E(Y,4,5)),PRC("FY")=$E(100+$E(Y,2,3)+$E(Y,4),2,3) S (Z,PRCSZ)=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_PRC("CP")
 D QUE^PRCSP1A K C1,DIC,PRC,Z
 G EN50
 ;
EN6 ;PRINT SF18 QUOTATION FOR BID
 D ST G EN60^PRCHRPT7
 ;
EN7 ;PRINT/DISPLAY 2237
 S DIC="^PRCS(410,",DIC(0)="AEMQZ",DIC("A")="2237 REFERENCE NUMBER: ",DIC("S")="I $P(^(0),U,4)'=1,$P(^(0),U,2)=""O""!($P(^(0),U,2)=""CA"")"
 D ^PRCSDIC K DIC Q:Y<0  S D0=+Y,PRC("SITE")=+Y(0) W ! D ^PRCHDR K D0 W !!
 G EN7
 ;
EN8 ;DISPLAY ITEM INFORMATION
 W ! S DIC="^PRC(441,",DIC(0)="AEMQ" D ^DIC K DIC Q:Y<0  S DA=+Y,DIQ(0)="C",DIC="^PRC(441," D EN^DIQ K DIC,DIQ,DA,D0
 G EN8
 ;
QK N DEFPNT
K K DEFPNT,ZTSK,ZTSAVE,ZTDTH,ZTRTN,PRCHREPR,PRCHNRQ,OK,PL,PRCHQ
 K X,Y,I
 Q
 ;
W W $C(7),!!,"You are set up to print the P.O.'s on preprinted forms, but you have not",!,"defined printer 'S9    SUPPLY 2139' on the Site Paramater File.",!
 W "This printer MUST be defined to print the second and subsequent pages.",!,"of the Purchase Order."
 Q
 ;
X W $C(7),!!,"Your printer selection is not defined in the site parameter file."
 Q
 ;
MESS ;Put message into report
 N XMDUZ,XMN,AA S XMDUZ=DUZ,XMN=0
 D DES^XMA21 Q:$S($O(XMY(""))="":1,$E($G(X))["^":1,1:0)
 W ! S AA=X D ENTS S XMSUB=X S X=AA
 I X="" S ZTRTN="ZTSK^PRCHRPT",ZTSAVE("XMY(")="",ZTSAVE("D0")="",ZTSAVE("U")="",ZTSAVE("PRCHQ(""DEST"")")="",ZTSAVE("XMSUB")="",ZTDTH=$H
 I  S ZTSAVE("PRC(""SITE"")")="" D ^%ZTLOAD
 ;
CLN K XMY,XMN,XMDUZ,XMSUB
 G K
 ;
ZTSK ;
 I '$D(XMDUZ),$D(DUZ),DUZ S XMDUZ=DUZ
 I 'XMDUZ S XMDUZ=.5
 D ^PRCHFPNT W:'$D(ZTQUEUED) !
 Q
ENTS ;ASK SUBJECT
S I $D(XMSUB) S Y=XMSUB
 W !,"Subject: " G F:'$D(XMSUB) S I=XMSUB
 I I["~U~" S I=$$DECODEUP^XMCU1(I)
 I $L(I) W I,"//"
F R X:DTIME S:'$T X="^" S:X="" X=$S($D(XMSUB):XMSUB,1:"^") S Y=X
 Q:Y=U  S (X,Y)=$$ENT^XMGAPI0(Y,1) G S:+X S (X,Y)=$P(X,U,2)
 Q
