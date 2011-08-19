PRCFFMOM ;WOIFO/SJG/AS-ROUTINE TO PROCESS AMENDMENT OBLIGATIONS ;3/8/05
V ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCFSITE Q:'%  ; ask station
 D OUT1 ; kill variables
 ;
 ; prompt for signature (E-Sig code for amendment)
 S MESSAGE=""
 D ESIG^PRCUESIG(DUZ,.MESSAGE)
 I MESSAGE<1 D  G OUT1 ; exit if bad response
 . I (MESSAGE=0)!(MESSAGE=-3) W !,$C(7),"  SIGNATURE CODE FAILURE " R X:3 ;3 TRIES or NO SIG ON FILE
 . I (MESSAGE=-1)!(MESSAGE=-2) Q  ;ARROWED OUT or TIMED OUT
 ;
START ; get PO#
 K PRCFA
 K DIC("A")
 S D="E"
 S DIC=443.6
 S DIC("S")="I +^(0)=PRC(""SITE"") S FSO=$O(^PRC(443.6,""D"",+Y,0)) I FSO=26!(FSO=31)!(FSO=36)!(FSO=45)!(FSO=71)"
 S DIC("A")="Select Purchase Order Number: "
 S DIC(0)="AEQZ"
 D IX^DIC
 K DIC("S"),DIC("A")
 K FSO
 G:+Y<0 OUT1
 S FLG=0
 S PO=Y,PO(0)=Y(0)
 S PRCFA("PODA")=+Y
 S PRCFPODA=+Y
 I '$D(^PRC(443.6,+PO,6)) D NOA G OUT1 ; PO has no amendments
 I $P(^PRC(443.6,+PO,6,0),"^",4)<0 D NOA G OUT1 ; PO has no amendments
 I '$$VERIFY^PRCHES5(PRCFPODA) D MSG1 G OUT1 ; tampered PO
 ;
 ; get amendment #
AMEND S DIC="^PRC(443.6,"_+PO_",6,"
 S DIC("A")="Select AMENDMENT: "
 S DIC(0)="AEMNZQ"
 D ^DIC
 K DIC("A")
 G:Y<0 OUT1
 S PO(6)=Y(0)
 S PO(6,1)=^PRC(443.6,+PO,6,+Y,1)
 S PRCFA("AMEND#")=+Y
 S PRCFAA=+Y
 ;
DESC ; verify amendment is complete
 I $$CHKAMEN^PRCFFU(+PO,PRCFAA) W !,?15,"Return Amendment to A&MM.",! G START
 I $P($G(PO(6,1)),U,2)="" D  G START
 . W ! D EN^DDIOL("This amendment is still awaiting signature by A&MM!")
 . W !
 ;
 ; set up variables used in this option
 S PRCFA("RETRAN")=0
 S D0=+PO
 S D1=+Y
 S PRCHPO=PRCFPODA
 S PRCHAM=PRCFAA
 D ^PRCHSF3 ; sets up PRCH("AM") array
 D ^PRCHDAM ; display amendment info
 D DT442^PRCFFUD1(PRCFPODA,PO(0),443.6,PRCFA("AMEND#")) ; set up PRC array
RETRAN    ; Entry point for rebuild/transmit
 S PRCFA("MOD")="M^1^Modification Entry"
 ;
 ; check amendment record for availability
 L +^PRC(443.6,PRCFPODA):1
 I $T=0 D  G OUT1
 . W $C(7),!
 . D EN^DDIOL("This amendment is being obligated by another user!")
 ;
 I 'PRCFA("RETRAN"),$O(^PRC(443.6,PRCFPODA,6,PRCFAA,3,"AC",32,0)) N P2237 S P2237=$P(^PRC(443.6,PRCFPODA,0),U,12) I P2237>0 I '$$VERIFY^PRCSC2(P2237) D MSG1 G OUT1 ; tampered PO
 ;
 I PRCFA("RETRAN") D DT442^PRCFFUD1(PRCFPODA,PO(0),442,PRCFA("AMEND#"))
 ;
 I $G(PRCRGS)<1 D OVCOM^PRCFFU10 I PRCFA("OVCOM")=1!(PRCFA("OVCOM")=2) D POFAIL^PRCFFU10,MSG G OUT1
 ;
 S PCP=+$P(PO(0),U,3)
 S $P(PCP,U,2)=$S($D(^PRC(420,PRC("SITE"),1,+PCP,0)):$P(^(0),U,12),1:"")
APP W !
 D OKAM^PRCFFU I 'Y!($D(DIRUT)) G AMEND ; ask OK to amend?
 D SC^PRCFFUA1 ; display FCP, cost ctr, PO/Req#
 D CPBAL^PRCFFUA1 ; display cost & balances
 D GET^PRCFFUA1 ; display amended (BOC) info
 S FATAL=0
 D OK^PRCFFUA ; ask if above BOC info is correct
 S SAVEY=Y
 I Y D  S Y=SAVEY K SAVEY I FATAL=1 D MSG10^PRCFFUA3 G APP1
 . D GETBOC^PRCFFUA4
 . D CHKBOC^PRCFFUA4
 I 'Y!($D(DIRUT)) D  I FISCEDIT G RETRAN
 .S FISCEDIT=0
 .I $D(DIRUT) D MSG9^PRCFFUA3 Q
 .I 'Y D MSG8^PRCFFUA3,POAM^PRCFFUA Q
 .Q
 D KILL^PRCFFUA
APP1 I FATAL=1 G:PRCFA("RETRAN")=0 START Q:PRCFA("RETRAN")=1
 I $D(^PRC(443.6,+PO,6)),$P(PO(6,1),"^",5)'="" D   I 'Y!($D(DIRUT)) G OUT1
 . W !
 . D OKAPP^PRCFFU ; amendment approved, ask 'continue?'
PRT W !
 D OKPRT^PRCFFU S:Y FLG=1 ; print amendment
 S PRCFA("AMEND#")=PRCFAA
 S PRCFA("BBFY")=$$BBFY^PRCFFU5(+PO)
 S PRCFA("IDES")="Purchase Order Amendment Obligation"
 S PRCFA("MP")=$P(PO(0),U,2)
 S PRCFA("PODA")=PRCFPODA
 S PRCFA("REF")=$P(PO(0),U)
 ; the following line commented out in PRC*5*179
 ; S PRCFA("SFC")=$P(PO(0),U,19)
 S PRCFA("SYS")="FMS"
 S PRCFA("TT")=$S(PRCFA("MP")=2:"SO",1:"MO")
 I $D(GECSDATA),$E($G(GECSDATA(2100.1,GECSDATA,.01,"E")),1,3)="AR-" S PRCFA("TT")="AR"
PRT1 I PRCFA("MP")=2&(PRCFA("TT")="SO") D  G:ACCEDIT=1 PRT1
 . W !
 . D EN^PRCFFU16(+PO)
PRT11 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 D  G PRT2
 . D RETRANM^PRCFFMO2
 . S Y=PRCFA("OBLDATE")
 S Y=$$DTOBL^PRCFFUD1(PRC("RBDT"),PRC("AMENDT"))
PRT2 D D^PRCFQ
 S %DT="AEX"
 S %DT("A")="Select Obligation Processing Date: "
 S %DT("B")=Y
 W !
 D ^%DT
 K %DT
 I Y<0 D MSG H 3 G OUT1
 S PRCFA("OBLDATE")=Y
 S EXIT=0
 D ENM^PRCFFMO2
 I EXIT D MSG,KILL^PRCFFMO2 H 3 G OUT1
 I PRC("RBDT")'<$P(^PRC(420,PRC("SITE"),0),"^",9),$P($$DATE^PRC0C(PRCFA("OBLDATE"),"I"),U,1,2)'=$P($$DATE^PRC0C(PRC("RBDT"),"I"),U,1,2) D MSG1^PRCFFUD G PRT11
 D GENDIQ^PRCFFU7(442,+PO,".1;.07;.03;17","IEN","")
EDIT ; Get budget/accounting elements
 N PARAM
 S PARAM=+$P(PO(0),U,3)_"^"_PRC("FY")_"^"_PRCFA("BBFY")
 S PRCFMO=$$ACC^PRC0C(PRC("SITE"),PARAM)
 S IDFLAG="I"
 S XRBLD=0
 I PRCFA("RETRAN")=1 D EN^PRCFFUB ; if selected transaction to rebuild is a 'X' decrease or cancel, set XRBLD=1, set to 2 if it is the 'E'
 ;
 ; determine the correct transaction type if this is not an MO document
 I PRCFA("TT")'="MO",XRBLD=0 D  I "^AR^SO^"'[("^"_$P(PRCFA("TT"),":",1)) D MSG,OUT1 Q
 . N PRCFATT S PRCFATT=PRCFA("TT")
 . D SOAR^PRC0E(PRCFA("PODA"),.PRCFATT,1) ; ask SO or AR, if appropriate
 . S PRCFA("TT")=PRCFATT K PRCFATT
 ;
 I PRCFA("RETRAN")=1,$P(PRCFA("GECS"),"^")="AR",PRCFA("TT")="AR" D
 . I $P(PRCFA("GECS"),"^",2)="E" S PRCFA("MOD")="E^0^Original Document"
 . I $P(PRCFA("GECS"),"^",2)="M" S PRCFA("MOD")="M^1^Modification Document"
 ;
 I PRCFA("TT")="AR",XRBLD=0 D  I "EM"'[X D MSG,OUT1 Q
 . S X="M"
 . I PRCFA("RETRAN")=1,$P(PRCFA("GECS"),"^",2)="E" S X="E"
 . D SC^PRC0A("",.Y,"Label document action as: ","AOM^E:Original Document;M:Modification Document",X)
 . I $E(Y)="E" S PRCFA("MOD")="E^0^Original Document"
 . I $E(Y)="M" S PRCFA("MOD")="M^1^Modification Document"
 . S X=$E(Y)
 . K Y
 ;
 ; check to see if transaction type or document type changed
 S X=0
 I XRBLD=0,$G(PRCFA("RETRAN"))=1,"^SO^AR"[("^"_$E(PRCFA("TT"),1,2)),$P(PRCFA("GECS"),"^",1,2)'=($E(PRCFA("TT"),1,2)_"^"_$E(PRCFA("MOD"))) D  I X="^" D MSG,PAUSE^PRCFFERU G OUT1
 . S PRCFA("SIS")=$$GETTXNS^PRCFFERT(PO,PRCFA("AMEND#"),2) ; get other txns for this amendment
 . S X=$$NEWCHK^PRCFFERT(PRCFA("TT"),$E(PRCFA("MOD"),1),PRCFA("SIS")) ; does selected txn exist?
 . I X=0 S PRCFA("RETRAN")=2 ; txn doesn't exist, create
 . I X'=0 S X=$$SWITCH^PRCFFERT(X,2,.GECSDATA) ; replace current GECSDATA values with values belonging to selected txn-- returns '^' if not switched
 ;
GO ; Prompt user for for final go-ahead for approval
 D GO^PRCFFU
 I 'Y!($D(DIRUT)) D MSG,OUT1 Q
ESIG W !,"The Electronic Signature must now be entered to generate the "_PRCFA("TYPE")_" Document.",!
 D SIG^PRCFFU4
 I $D(PRCFA("SIGFAIL")) K PRCFA("SIGFAIL") H 3 G OUT1
 S DA=PRCFA("PODA")
 D REMOVE^PRCHES14(PRCFA("PODA"),PRCFA("AMEND#"))
 S MESSAGE="" ; value not used but variable is needed by next call
 D ENCODE^PRCHES14(PRCFA("PODA"),PRCFA("AMEND#"),DUZ,.MESSAGE)
 ;
 D DT442^PRCFFUD1(PRCFA("PODA"),"",442,PRCFA("AMEND#"))
 S PRCOAMT=+^PRC(442,PRCFA("PODA"),0)
 S $P(PRCOAMT,"^",2)=+$P(^PRC(442,PRCFA("PODA"),0),"^",3)
 S $P(PRCOAMT,"^",3)=PRC("FYQDT")
 S $P(PRCOAMT,"^",5)=-$P(^PRC(442,PRCFA("PODA"),0),"^",$P(PRCFMO,"^",12)="N"+15)
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")>0 G TRANS1
TRANS W !!,"...copying amendment information back to Purchase Order file...",! D WAIT^DICD
 S ERFLAG=""
 S PRCFA("DLVDATE")=$P(^PRC(442,PRCFA("PODA"),0),"^",10)
 D CHECK^PRCHAMYA(PRCFA("PODA"),PRCFA("AMEND#"),.ERFLAG)
 I ERFLAG W !!,"...ERROR IN COPYING AMENDMENT INFORMATION BACK TO PURCHASE ORDER FILE..." G OUT1
TRANS1 D DT442^PRCFFUD1(PRCFA("PODA"),"",442,PRCFA("AMEND#"))
 ;  transmit amendment from IFCAP to DynaMed   **81**
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1)=1 D
 . ; No DynaMed interface if rebuild/retransmit
 . I $D(PRCFA("RETRAN")),PRCFA("RETRAN")>0 Q
 . D ENT^PRCVPOU(PRCFA("PODA"),PRCFA("AMEND#"))
 S PRCFA("OLDPODA")=PRCFA("PODA")
 S PRCFA("OLDREF")=PRCFA("REF")
 I PRCFA("RETRAN")>0 I XRBLD=1!(XRBLD=2) D GO^PRCFFUB H 3 Q  ; if rebuilding a 'dependent' transaction, finish work here
 D LIST^PRCFFU7(PRCFA("PODA"),PRCFA("AMEND#"))
 I $G(PRCFA("RETRAN"))<1 D AMEND^PRCFFUD ; create entry in 410
 I PRCFA("AUTHE") D FCP^PRCFFU11,PRINT G START
 I 'PRCFA("MOMREQ") D MSG^PRCFFU8 G PRINT ; skip FMS transmit,fiscal upadtes
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 D SETPO^PRCFFERT
 I $G(PRCFA("ACCEDIT"))=1 D TAG33^PRCFFU9
TRANS2 K PO
 D ^PRCFFM1M
 L -^PRC(443.6,PRCFA("PODA"))
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=0 D OUT1^PRCFFM1M G START
 QUIT
 ;
PRINT ; Print out copy of Purchase Order Amendment
 G:'FLG OUT1
 S PRCHQ="^PRCHPAM"
 S PRCHQ("DEST")="S8"
 S D0=PRCFA("PODA")
 S D1=PRCFA("AMEND#")
 D ^PRCHQUE
OUT1 K FATAL,FLG,%,%Y,DIC,I,J,K,P,PRCFA,PRCFAA,PRCFPODA,PRCFCHG,X,XRBLD,Y,Z
 Q
 ; Message processing
NOA D NOA^PRCFFM3M Q
MSG D MSG^PRCFFM3M Q
MSG1 D MSG1^PRCFFM3M Q
