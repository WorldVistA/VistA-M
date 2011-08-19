PRCSP1 ;WISC/SAW/KMB-C P ACTIVITY PRINTS ;05/05/98 1400
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
OTR ;OBL TRANS
 D EN3^PRCSUT G W1:'$D(PRC("SITE")),EXIT:Y<0
 S DIC="^PRCS(410,",DIC(0)="AEQ",D="D",DIC("A")="Select PURCHASE ORDER/OBLIGATION NO: "
 S DIC("S")="I $D(^(4)),$P(^(4),U,5)]"""",$D(^(3)),+^(3)=+PRC(""CP""),$P(^(0),U,5)=PRC(""SITE""),$P(^(0),""^"",2)=""O"" I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 D ^PRCSDIC G EXIT:Y<0 S PRCSX=$P(^PRCS(410,+Y,4),U,5) K DIC("S"),DIC("A")
 S %=1,%A="Would you like to include 'Comments'" D ^PRCFYN G OTR:(%'["1")&(%'["2")
 S FLDS=$S(%=2:"[PRCSOTR]",1:"[PRCSOTR1]"),DHD="OBLIGATION STATUS REPORT",BY="24;S1",(FR,TO)=PRCSX D S K PRC("CP") I $D(^PRC(442,"B",PRC("SITE")_PRCSX)) S D0=$O(^(PRCSX,0)) D POS1^PRCSP1B K PRCSX G OTR
 K PRCSX G OTR
TS ;CPC/CPO TRANS STATUS
 S PRCSST=1 ;   Don't prompt for substation
 K PRC("CP") ;  Delete control point default
 D EN3^PRCSUT K PRCSST
 N PRCSX1,PRCSX2
 S DIC="^PRCS(410,",DIC(0)="AEMQ"
 I $D(PRC("CP"))#10=1 S DIC("S")="I $G(^(3))]"""",+$P(^(3),U,1)=+PRC(""CP"")"
 ;I $D(PRC("CP"))#10=1 S DIC("S")="I $G(^(3))]"""",$P(^(3),U,1)=PRC(""CP"")"
 E  S DIC("S")="S PRCSX1=$P(^(0),""^"",5),PRCSX2=$S($D(^(3)):$P(^(3),""^""),1:"""") I $D(^PRC(420,""A"",DUZ,+PRCSX1,+PRCSX2))"
 D ^PRCSDIC K PRCSX1,PRCSX2 G EXIT:Y<0 K DIC("S") S DA=+Y D DEV G EXIT:POP I $D(IO("Q")) S ZTRTN="^PRCSP13",ZTSAVE("DA")="" D ^%ZTLOAD,EXIT G TS
 D ^PRCSP13,W2 G TS
TSS ;REQ TRANS STATUS
 N X3 S X3="H" D W3
 S DIC="^PRCS(410,",DIC(0)="AEQ",DIC("A")="Select TRANSACTION NUMBER: ",DIC("S")="I $P(^(0),""^"",3)'="""",$D(^PRCS(410,""H"",$P(^(0),""^"",3),+Y)),^(+Y)=DUZ!(^(+Y)="""")",D="H"
 D ^PRCSDIC G EXIT:Y<0 K DIC("S"),DIC("A") S DA=+Y D DEV G EXIT:POP I $D(IO("Q")) S ZTRTN="^PRCSP13",ZTSAVE("DA")="" D ^%ZTLOAD,EXIT G TSS
 D ^PRCSP13,W2 G TSS
PRNT ;
 N X3 S X3=0 D W3 S DIC="^PRCS(410,",DIC(0)="AEQ",DIC("A")="Select TRANSACTION: ",D="H",DIC("S")="I $P(^(0),U,3)'="""",$D(^PRCS(410,""H"",$P(^(0),U,3),+Y)),^(+Y)=DUZ!(^(+Y)="""")"
 D ^PRCSDIC G EXIT:Y<0 K DIC("A"),DIC("S")
 S DA=+Y,PRC("SITE")=+$P(^PRCS(410,DA,0),"^",5),PRC("CP")=$P(^(3),"^"),PFLAG=1 G PRF2
CPOQR ;CP OFFICIAL'S QTRLY REPORT
 D EN^PRCSUT G W1:'$D(PRC("SITE")),EXIT:Y<0 S PRCSAZ=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 S DIOEND="I $D(PRCS(1)),$D(PRCS(2)) W !,""TOTAL COMMITTED, NOT OBLIGATED: $"",$J(PRCS(2)-PRCS(1),0,2) K DIOEND"
 S FLDS="[PRCSCPOQR]",DHD="CONTROL POINT QUARTERLY REPORT - "_PRC("CP"),BY="@.01",FR=PRCSAZ_"-0001",TO=PRCSAZ_"-9999" D S
 N REPORT2 S REPORT2=1 D T2^PRCSAPP1
 K PRC("CP"),PRCS(1),PRCS(2),PRCSAZ G CPOQR
ALLCP ;PRINT REQUEST FROM ANY CP
 ;
 D NSCRN^PRCSUT G W1:'$D(PRC("SITE")),EXIT:Y<0
 S DISONLY=1 G PRF0
PRF ;PRINT REQUEST FORM
 ;
 D EN3^PRCSUT G W1:'$D(PRC("SITE")),EXIT:Y<0
PRF0 S DIC="^PRCS(410,",DIC(0)="AEMQ",DIC("S")="I $D(^(3)),+^(3)=+PRC(""CP""),$P(^(0),U,5)=PRC(""SITE""),$P(^(0),U,2)=""O""" D ^PRCSDIC G EXIT:Y<0 K DIC("S") S DA=+Y
PRF1 ;
 N PFLAG,PRCSQ,TRNODE,CET S PFLAG=0
PRF2 S PRCSQ=$P(^PRCS(410,DA,0),U,4) S TRNODE(0)="",CET=0 D NODE^PRCS58OB(DA,.TRNODE)
PRF3 ;
 N PRNTALL
 S PRNTALL=0
 I PRCSQ=1 G PRF5 ;DON'T ASK 2237 QUESTION IF THIS IS A 1358 . . . 
 N %
PRF4 ;
 S %=1 W !,"Print administrative certification page of 2237"
 D YN^DICN
 I %=1 S PRNTALL=1
 I %=0 W !,"Enter NO to not print administrative certifications,",!," justifications, and data on last page of the 2237",! G PRF4
 I %'=1 S PRNTALL=0
 I '$D(^PRCS(410,DA,"IT",0)) W !!,"Items have not been entered for this request.",!,"Requests without items are not printed." H 2 G EXIT
PRF5 I '$D(DISONLY) D DEV G EXIT:POP G PRFPRN
 S IOP="" D ^%ZIS
 ;
PRFPRN ;
 N PRCPRIB S PRCPRIB=DA
 I $D(IO("Q")) K IO("Q") S ZTRTN=$S(PRCSQ=1:"^PRCE58P2",PRCSQ=5:"DQ^PRCPRIB0",1:"^PRCSP12"),ZTSAVE("PRNTALL")="",ZTSAVE("DA")="",ZTSAVE("PRC*")="",ZTSAVE("TRNODE*")="" D ^%ZTLOAD,HOME^%ZIS
 I  G:$D(PRCSF) EXIT D W2 G:$D(DISONLY) ALLCP G:PFLAG=1 PRNT G PRF
 I $E(IOST)="P" S F=$S(PRCSQ=1:"^PRCE58P2",PRCSQ=5:"DQ^PRCPRIB0",1:"^PRCSP12") D @F D ^%ZISC G:$D(PRCSF) EXIT D W2 G:$D(DISONLY) ALLCP G:PFLAG=1 PRNT G PRF
 D:PRCSQ=5 DQ^PRCPRIB0 D:PRCSQ=1 ^PRCE58P0 D:PRCSQ'=1&(PRCSQ'=5) ^PRCSD12 W:$Y>0 @IOF G:$D(PRCSF) EXIT D W2 G:$D(DISONLY) ALLCP G:PFLAG=1 PRNT G PRF
 ;
EN1 S DIC="^PRCS(410,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),""^"",2)=""O"",$D(^(7)),$P(^(7),""^"",6)'=""""",DIC("A")="Select TRANSACTION NUMBER: " D ^PRCSDIC G EXIT:Y<0 S PRCSF=1,DA=+Y D PRF1 K DIC,PRCSF G EN1
S S L=0,DIC="^PRCS(410," D EN1^DIP K IOP,PRCSPOP Q
DEV K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q
W3 W !!,"For the transaction number, use an uppercase alpha as the first character,",!,"and then 2-16 uppercase or numeric characters, as in ADP1.",! Q
W2 W !!,"Enter information for another report or an uparrow to return to the menu.",! Q
W1 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W I (IO=IO(0))&('$D(ZTQUEUED)) W !!,"Press return to continue:  " R X:DTIME
 I (IO'=IO(0))!($D(ZTQUEUED)) D ^%ZISC
EXIT K %,%DT,%ZIS,BY,C2,C3,D,DA,DHD,DIC,PRCS,FLDS,FR,I,L,N,TO,X,Y,ZTRTN,ZTSAVE,DISONLY,F
 Q
