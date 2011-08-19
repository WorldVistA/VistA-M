PRCFFMO1 ;WISC/SJG-CONTINUATION OF OBLIGATION PROCESSING ;4/24/96  8:54 AM
V ;;5.1;IFCAP;**58,79**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;DISPLAY CONTROL POINT OFFICIALS BALANCES
 W !!,"Net Cost of Order: ",?30,"$",$J($P(PO(0),U,16),10,2)
 D CPBAL
 I $D(PRCF("NOBAL")) K PRCF("NOBAL")
V1 I $P(PRC("PARAM"),"^",17)="Y" D
 . W !!,"Fiscal Status of Funds for Control Point"
 . W !!,"Status of Funds Balance: "
 . W ?30,"$",$J($P(^PRC(420,PRC("SITE"),1,+$P(PO(0),U,3),0),U,7),10,2)
 . W !,"Estimated Balance:"
 . W ?30,"$",$J($P(^(0),U,8),10,2)
 I $G(PRCRGS)<1 D OVCOM^PRCFFU10 I PRCFA("OVCOM")=1!(PRCFA("OVCOM")=2) D POFAIL^PRCFFU10,MSG H 3 G OUT3
 S PRCFA("IDES")="Purchase Order Obligation"
 W ! D OKAY2^PRCFFU ; ask 'OK to continue?'
 I 'Y!($D(DIRUT)) D MSG H 3 G OUT3
VAR S P("DELDATE")=$P(PO(0),U,10)
 S P("PODATE")=DT
 I $P(^PRC(442,PRCFA("PODA"),1),"^",15)'="" S P("PODATE")=$P(^(1),"^",15)
 S PRCFA("MOD")="E^0^Original Entry"
 S PRCFA("MP")=$P(PO(0),U,2)
 S PRCFA("REF")=$P(PO(0),"^")
 S PRCFA("SFC")=$P(PO(0),U,19)
 S PRCFA("SYS")="FMS"
 S PRCFA("TT")=$S(PRCFA("MP")=2:"SO",1:"MO")
 W !
 I $D(PRCFA("RETRAN")),'PRCFA("RETRAN") D REVIEW^PRCFFU I Y N D0 S D0=PRCFA("PODA") D ^PRCHDP1
VAR1 I PRCFA("MP")=2,PRCFA("TT")'="MO" D  G:ACCEDIT=1 VAR1
 .  W !
 . D EN^PRCFFU16(+PO)
 . D MSG6^PRCFFU16
VAR11 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 D  G VAR2
 . D RETRANO^PRCFFMO2 S Y=PRCFA("OBLDATE")
 S Y=$$DTOBL^PRCFFUD1(PRC("RBDT"),PRC("PODT"))
VAR2 D D^PRCFQ
 S %DT="AEX"
 S %DT("A")="Select Obligation Processing Date: "
 S %DT("B")=Y
 W ! D ^%DT K %DT
 I Y<0 D MSG H 3 D OUT3 Q
 S PRCFA("OBLDATE")=Y
 S EXIT=0
 D ENO^PRCFFMO2
 I EXIT D MSG,KILL^PRCFFMO2 H 3 D OUT3 Q
 I PRC("RBDT")'<$P(^PRC(420,PRC("SITE"),0),"^",9),$P($$DATE^PRC0C(PRCFA("OBLDATE"),"I"),U,1,2)'=$P($$DATE^PRC0C(PRC("RBDT"),"I"),U,1,2) D MSG1^PRCFFUD G VAR11
 S PRCFA("SC")=""
 Q:'$D(^PRC(442,+PO,1))
 S PRCFA("SC")=$S($D(^PRC(440,$P(^PRC(442,+PO,1),U,1),2)):$P(^(2),U,4),1:"")
 I PRCFA("SC")="",$P(^PRC(442,PRCFA("PODA"),1),"^",7)'="" S PRCFA("SC")=$P(^PRCD(420.8,$P(^PRC(442,PRCFA("PODA"),1),"^",7),0),"^",3)
 S PRCFA("BBFY")=$$BBFY^PRCFFU5(PRCFA("PODA"))
 D GENDIQ^PRCFFU7(442,PRCFA("PODA"),".1;.07;.03;17","IEN","")
 ;
EDIT ; Check fund/year dictionary for required FMS fields
 D EDIT^PRCFFU ; sets up PRCFMO array based upon required fields
 ;
GO ; Prompt user for final go-ahead for the document creation
 D GO^PRCFFU I 'Y!($D(DIRUT)) D MSG,OUT3 H 3 Q
 ;
ESIG ; Enter the Electronic Signature and away it goes!
 W !,"The Electronic Signature must now be entered to generate the "_PRCFA("TYPE")_" Document.",!
 D SIG^PRCFFU4
 I $D(PRCFA("SIGFAIL")) K PRCFA("SIGFAIL") D MSG1(ESIGMSG),OUT3 H 3 Q
 ;
 I $G(PRCTMP(442,+PO,.07,"I"))="" D NEW410^PRCFFUD
 D PO^PRCFFUD
 S IDFLAG="I" ; flag to indicate $ increase to FMS
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 D
 . D SETPO^PRCFFERT ; rebuild txn
 ;
STACK ; Create entry in GECS Stack File
 D STACK^PRCFFU(0) ; build CTL,DOC segs, (0) means generate no batch#
 ;
SEGS ; Create entry into TMP($J, for remaining segments
 K ^TMP($J,"PRCMO")
 N FMSINT S FMSINT=+PO,FMSMOD=$P(PRCFA("MOD"),U,1)
 D NEW^PRCFFU1(FMSINT,PRCFA("TT"),FMSMOD) ; create remaining segs
 ;
 ; Transfer nodes from TMP($J, into GECS stack file
 N LOOP S LOOP=0 F  S LOOP=$O(^TMP($J,"PRCMO",GECSFMS("DA"),LOOP)) Q:'LOOP  D SETCS^GECSSTAA(GECSFMS("DA"),^(LOOP))
 K ^TMP($J,"PRCMO")
 ;
TRANS ; Mark the document as queued for transmission
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 N P2 S P2=+PO,$P(P2,"/",5)=$P($G(PRCFA("ACCPD")),U),$P(P2,"/",6)=PRCFA("OBLDATE")
 D SETPARAM^GECSSDCT(GECSFMS("DA"),P2)
 ;
POOBL ; Enter Obligation Data into Purchase Order record
 I '$D(POESIG) I $D(PRCFA("PODA")),+PRCFA("PODA")>0 S POESIG=1
 N FMSDOCT S FMSDOCT=$P(PRCFA("REF"),"-",2)
 D EN7^PRCFFU41(PRCFA("TT"),FMSMOD,PRCFA("OBLDATE"),FMSDOCT) ; log txn
 ;
 ; continue processing if this is not a rebuild
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN") D OUT3 Q
 ;
FISCST ; Post to Fiscal Status of Funds Tracker
 I $P(PRC("PARAM"),U,17)["Y" D FISC^PRCFFU4
 ;
PHA ; Generate PHA transaction
 S PRCOPODA=PRCFA("PODA") W ! D WAIT^DICD W !!,"...now generating the PHA transaction"
 S FILE=442 S PRCHPO=PRCFA("PODA") D CHECK^PRCHSWCH K FILE
 D:'$G(PRCHOBL) NEW^PRCOEDI W !
 ; PRC*5.1*79: let the user know that a message is going out, except for
 ; Requisitions.
 D:$D(^PRC(442,PRCHPO,25)) EN^DDIOL("...now generating the FPDS message for the AAC","","!"),EN^DDIOL(" ")
 ;
 K PRCOPODA,IO("Q")
 ;
NC I $D(PRCFA("PODA")) D ^PRCFAC02
 ; Generate FPDS HL7 message for the AAC, PRC*5.1*79
 I $P(^PRC(442,PRCHPO,0),U,15)>0,$D(^PRC(442,PRCHPO,25)) D AAC^PRCHAAC
 ; End of changes for PRC*5.1*79
 Q
 ;
OUT3 K %,AMT,C1,C,CSDA,D0,DA,DI,DIC,DEL,E,I,J,K,N1,N2,PCP,PO,PODA,PRCQ,PTYPE,T,T1,TIME,TRDA,Y,Z,Z5,ZX
 Q
MSG W !! S X="No further processing is being taken on this obligation." D EN^DDIOL(X) Q
 Q
MSG1(MSG) S:'$D(ROUTINE) ROUTINE="PRCUESIG"
 W !!,$$ERROR^PRCFFU13(ROUTINE,MSG)
 D MSG Q
OUT W !,"No data posted to Control Point Files",$C(7) R X:3 Q
 Q
CPBAL N A,B
 ;
 ; **Add call to OBLDAT^PRCFFUD1 as part of PRC*5.1*58
 S A=$$DATE^PRC0C($$OBLDAT^PRCFFUD1(PRC("RBDT"),$G(PRC("AMENDT"))),"I")
 K OBLDAT
 ; **End PRC*5.1*58
 ;
 S B=$P(A,"^",2)
 S A=$E(A,3,4)
 S:'$D(PQT) PQT=PRC("QTR")
 S X=$G(^PRC(420,PRC("SITE"),1,+PCP,4,A,0))
 I X="" W !! S X="No Control Point balances available at this time." D EN^DDIOL(X) S PRCF("NOBAL")="" Q
 S PRCS("C")=$P(X,"^",B+1)
 S PRCS("O")=$P(X,"^",B+5)
 W !!,"Control Point Balances"
 W !!,"Uncommitted Balance: "
 W ?30,"$"_$J(PRCS("C"),10,2)
 W !,"Unobligated Balance: "
 W ?30,"$"_$J(PRCS("O"),10,2)
 W !,"Committed, Not Obligated: "
 W ?30,"$"_$J((PRCS("O")-PRCS("C")),10,2)
 K PRCS
 Q
