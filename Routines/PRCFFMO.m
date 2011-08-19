PRCFFMO ;WISC/SJG-ROUTINE TO PROCESS OBLIGATIONS ;4/27/94  11:30
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S PRCF("X")="AS" D ^PRCFSITE ; ask station
 G:'% EXIT D EXIT
 K DIC("A") S D="C"
 S DIC("A")="Select Purchase Order Number: "
 S DIC("S")="I $D(^(7)),+^(0)=PRC(""SITE""),$D(^PRCD(442.3,+^(7),0)) S FSO=$P(^(0),U,3) I FSO>9,FSO<21"
 S DIC=442,DIC(0)="AEQZ"
 D IX^DIC K DIC("S"),DIC("A"),FSO
 G:+Y<0 EXIT
 S PO=Y,PO(0)=Y(0)
 S PRCFA("PODA")=+Y
 S PCP=+$P(PO(0),"^",3)
 S $P(PCP,"^",2)=$S($D(^PRC(420,PRC("SITE"),1,+PCP,0)):$P(^(0),"^",12),1:"")
 S PRCFA("RETRAN")=0
 ;
RETRAN ; Entry point for rebuild/retransmit
 S PRCFA("MOD")="E^0^Original Entry"
 L +^PRC(442,PRCFA("PODA")):1
 I $T=0 D  G EXIT
 . W $C(7),!
 . D EN^DDIOL("This Purchase Order/Requisition is being obligated by another user!")
 ;
 ; NOTE: a document cannot be returned to supply once it is obligated.
 ; Therefore the messages below pertain to documents not being rebuilt.
 ; Rebuilt documents will hit the message if someone modified a file
 ; through FileMan.  If the checks are here to catch errors in both
 ; cases, the message should be changed, otherwise the checks should
 ; be placed before the RETRAN tag.
 ;
 I +$P(PO(0),U,3)=0!('$D(^PRC(420,PRC("SITE"),1,+PCP,0))) D  G EXIT
 . W $C(7)
 . W "PURCHASE ORDER DOES NOT CONTAIN A CONTROL POINT.",!
 . W "UNABLE TO PROCESS - PLEASE RETURN TO SUPPLY FOR CORRECTION!"
 ;
 I $P(PO(0),U,5)="",$P(PCP,"^",2)<2 D  G EXIT
 . W $C(7),!
 . W "Purchase Order does not contain a Cost Center"
 . W !,"Unable to process - please return to supply for correction!"
 ;
 D DT442^PRCFFUD1(PRCFA("PODA"),PO(0))
 ;
 I +$P(PO(0),"^",16)=0 D  G V
 . ; S PRCFA("N/C")=1
 . W !
 . D NC
 . I 'Y!($D(DIRUT)) D MSG QUIT
 . I Y D NC2
 . D EXIT
 . Q
 ;
 I '$D(^PRC(442,PRCFA("PODA"),22)),$P(PCP,"^",2)="" D  G EXIT
 . W $C(7)
 . W !!,"Purchase Order does not contain any BOC data.",!
 . W "Unable to process - please return to supply for correction!"
 ;
SC ; Display Obligation Data
 I '$D(IOF)!('$D(IOM)) S IOP="HOME" D ^%ZIS K POP
 D SC^PRCFFUA1
 I $D(^PRC(442,PRCFA("PODA"),13)) W !! D ^PRCFAC0J
 W ! D OKAY^PRCFFU
 I $D(DIRUT) D MSG G EXIT
 I 'Y S FISCEDIT=0 D PO^PRCFFU12 I FISCEDIT G SC
 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P($P(PO(0),"^",3)," "),C1=1
 D ^PRCFFMO1
 L -^PRC(442,PRCFA("PODA"))
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=0 D EXIT G V
 D EXIT
 QUIT
EXIT ; 
 K %,AMT,C1,C,CSDA,D0,DA,DI,DIC,DEL,E,I,J,K,N1,N2,POP,PO,PODA,PRCFA,PRCFQ
 K PTYPE,T,T1,TIME,TRDA,Y,Z,Z5,ZX
 K PODATE,P,M0,GECSFMS
 Q
NC ; Prompt for 'NO CHARGE' orders
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A",1)="This order appears to be a 'NO CHARGE' order.  Do you still need to take"
 S DIR("A")="any action on this order"
 S DIR("?")="Enter 'YES' or 'Y' or 'RETURN' to continue processing."
 S DIR("?",1)="Enter 'NO' or 'N' or '^' to exit this option."
 S DIR("??")="^D NC1^PRCFFMO" D ^DIR K DIR
 Q
NC1 ; Additional help for N/C 
 K MSG S MSG(1)="When processing continues on this 'NO CHARGE' order, the Electronic Signature"
 S MSG(2)="will be applied and the Fund Control Point balance will be updated."
 S MSG(3)="There will be no FMS document generated.",MSG(4)="  "
 S MSG(5)="If exiting, there will be no further action taken on this order."
 W !! D EN^DDIOL(.MSG) K MSG
 Q
NC2 ; Processing for N/C
 S %=1 W ! D SIG^PRCFFU4 I $D(PRCFA("SIGFAIL")) K PRCFA("SIGFAIL") S %=-1 D MSG1^PRCFFMO1(ESIGMSG) H 3 Q
 S PRCFA("BBFY")=$$BBFY^PRCFFU5(+PO)
 D GENDIQ^PRCFFU7(442,+PO,".1;.07;.03;17","IEN","")
 S PRCFA("OBLDATE")=$$DTOBL^PRCFFUD1(PRC("RBDT"),PRC("PODT"))
 D EDIT^PRCFFU ; set up PRCFMO array based upon fund/year required fields table
 D VAR ; continues set up of PRCFA array
 S FMSMOD=$P(PRCFA("MOD"),U)
 D POOBL^PRCFFMO1
 W ! D MSG1
 I $G(PRCTMP(442,+PO,.07,"I"))="" D NEW410^PRCFFUD
 D PO^PRCFFUD
 Q
MSG W !! S X="No further processing is being taken on this obligation."
 D EN^DDIOL(X) H 3
 Q
MSG1 D EN^DDIOL("...no FMS Document has been generated...") W !
 Q
SUPP ; Entry point for FMS Documents for Supply Fund Special Control Point
 ; Called from PRCHNPO4
 S DIC("S")="I +^(0)=PRC(""SITE"")"
 S DIC=442,DIC(0)="NZ",X=PRCHPO
 D ^DIC K DIC G:+Y<0 EXIT
 S PO(0)=Y(0),PO=Y
 S PRCFA("PODA")=+Y
 S PCP=+$P(PO(0),"^",3)
 S $P(PCP,"^",2)=$S($D(^PRC(420,PRC("SITE"),1,+PCP,0)):$P(^(0),"^",12),1:"")
 D DT442^PRCFFUD1(PRCFA("PODA"),PO(0))
 S PRCFA("OBLDATE")=$$DTOBL^PRCFFUD1(PRC("RBDT"),PRC("PODT"))
 D ENSFO^PRCFFMO2
 S PRCFA("BBFY")=$$BBFY^PRCFFU5(+PO)
 D GENDIQ^PRCFFU7(442,+PO,".1;.07;.03;17","IEN","")
 S IDFLAG="I"
 S PARAM1="^"_PRC("SITE")_"^"_+PCP_"^"_PRC("FY")_"^"_PRCFA("BBFY")
 D DOCREQ^PRC0C(PARAM1,"SPE","PRCFMO")
 S PRCFMO("G/N")=$P(PRCFMO,U,12)
 D VAR
 I +$P(PO(0),U,16)=0 D
 . S FMSMOD=$P(PRCFA("MOD"),U)
 . D POOBL^PRCFFMO1
 . D MSG1
 I $G(PRCTMP(442,+PO,.07,"I"))="" D NEW410^PRCFFUD
 D PO^PRCFFUD
 I +$P(PO(0),U,16)=0 W ! D EXIT QUIT
 D STACK^PRCFFMO1,EXIT
 QUIT
VAR ; Set up variables
 S PRCFA("IDES")="Purchase Order"
 S PRCFA("MOD")="E^0^Original Entry"
 S PRCFA("MP")=$P(PO(0),U,2)
 S PRCFA("REF")=$P(PO(0),U)
 ; S PRCFA("SFC")=$P(PO(0),U,19)
 S PRCFA("SYS")="FMS"
 S PRCFA("TT")=$S(PRCFA("MP")=2:"SO",1:"MO")
 Q
