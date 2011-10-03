PRCESOM ;WISC/SJG/ASU - CONTINUATION OF 1358 ADJUST OBLIAGTION PRCEADJ1 ;4/27/94  2:13 PM
V ;;5.1;IFCAP;**148,153**;Oct 20, 2000;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
 N TI,PRCFASYS,IOINLOW,IOINHI,IOINORM,DIR,AMT,OLDTT,CS,HASH,DIE,DR,LAUTH,LBAL,TAUTH,TBAL,DLAYGO
 D SCREEN
 S PRC("CP")=$P(TRNODE(0),"-",4)
 S PRC("RBDT")=$P(TRNODE(0),U,11)
 I $G(PRCRGS)<1 D OVCOM1^PRCFFU10 I PRCFA("OVCOM")=1!(PRCFA("OVCOM")=2) D REQFAIL^PRCFFU10,MSG G OUT
 ; PRC*5.1*148 start
 ; if Obligator is a requestor, violation to segregation of duties
 I $P($G(TRNODE(7)),"^",1)=DUZ D  S Y=0 D MSG G OUT
 . W !!,"You are the CP Clerk (Requestor) on this 1358 transaction."
 . W !,"Per Segregation of Duties, the CP Clerk (Requestor)"
 . W " is not permitted to "
 . W $S($G(PRCFA("RETRAN")):"Rebuild/Retransmit",1:"Obligate")," the 1358."
 . I '$G(PRCFA("RETRAN")) Q
 . W ! D EN^DDIOL("  ** Press RETURN to continue **")
 . R X:DTIME Q
 ; if Obligator is a approver, violation to segregation of duties
 I $P($G(TRNODE(7)),"^",3)=DUZ D  S Y=0 D MSG G OUT
 . W !!,"You are the Approver on this 1358 transaction."
 . W !,"Per Segregation of Duties, the Approver is not permitted to "
 . W $S($G(PRCFA("RETRAN")):"Rebuild/Retransmit",1:"Obligate")," the 1358."
 . I '$G(PRCFA("RETRAN")) Q
 . W ! D EN^DDIOL("  ** Press RETURN to continue **")
 . R X:DTIME Q
 ; PRC*5.1*148 end
 ;
 D OKAY2^PRCFFU ; ask 'OK to continue?'
 I 'Y!($D(DIRUT)) D MSG G OUT
 S AMT=$P(TRNODE(4),U,8)
K F I=7,9 S AMT(I)=$P(TRNODE(3),"^",I) S:AMT(I)<0 AMT(I)=-AMT(I) S AMT(I)=AMT(I)*100
 S PRC("CP")=$P(TRNODE(0),"-",4)
 S PRCFA("BBFY")=$$BBFY^PRCFFU5(+PO)
 S PRCFA("MOD")="M^1^Modification Entry"
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1,$P(PRCFA("GECS"),"^",2)="E" S PRCFA("MOD")="E^0^Original Document"
 S PRCFA("MP")=$P(PO(0),U,2)
 S PRCFA("PATNUM")=$P($P(PO(0),U),"-",2)
 S PRCFA("PODA")=PODA
 S PRCFA("REF")=$P(PO(0),U)
 ; S PRCFA("SFC")=$P(PO(0),U,19)
 S PRCFA("SYS")="FMS"
 S PRCFA("TT")="SO"
 I $D(GECSDATA),$G(GECSDATA(2100.1,GECSDATA,.01,"E"))[("AR-") S PRCFA("TT")="AR"
EDIT ; 
 I $G(PRCFA("ACCEDIT"))=1 D TAG33^PRCFFU9 ; sets PRCFA("PPT") & PRCFA("MOMREQ")
 I $G(PRCFA("RETRAN"))=1 D TAG33^PRCFFU9 ; sets PRCFA("PPT") & PRCFA("MOMREQ")
 ;
 ; Compare adjustment to original 1358
 N RETURN,ERFLAG,IDFLAG,TYPE
 S RETURN=$$COMP^PRCFFU6(PRC442,PRC410,.RETURN)
 S ERFLAG=$P(RETURN,U,1)
 S IDFLAG=$P(RETURN,U,2)
 S TYPE=$P(RETURN,U,2)
 I ERFLAG D  Q 
 . W !!,"  Cannot continue...one or more of the following fields have changed..."
 . N LOOP S LOOP=""
 . F  S LOOP=$O(PRCFA("CHG",LOOP)) Q:LOOP=""  I PRCFA("CHG",LOOP)]"" W !,?5,PRCFA("CHG",LOOP)
 . K PRCFA("CHG")
 . W !!,"  Please be sure that the VENDOR, FUND CONTROL POINT, BOC, and COST CENTER",!,"  fields are the same as the original 1358 obligation!"
 . D MSG
 . D EN^DDIOL("  ** Press RETURN to continue **")
 . R X:DTIME
 . D OUT
 . Q
 ;
DT I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 D  G DT1
 . D RETRANM^PRCESOE2 ; get account & obligation processing dates
 . S Y=PRCFA("OBLDATE")
 S Y=PRC("RBDT") I Y<DT!'Y D NOW^%DTC S Y=X
DT1 D D^PRCFQ ; convert date to external format
 S %DT="AEX"
 S %DT("A")="Select Obligation Processing Date: "
 S %DT("B")=Y
 W ! D ^%DT
 K %DT
 I Y<0 D MSG,OUT H 3 Q
 S PRCFA("OBLDATE")=Y
 S EXIT=0
 D ENM^PRCESOE2
 I EXIT D  H 3 Q
 . D MSG
 . D OUT
 . D KILL^PRCESOE2
 I PRC("RBDT")'<$P(^PRC(420,PRC("SITE"),0),"^",9),$P($$DATE^PRC0C(PRCFA("OBLDATE"),"I"),U,1,2)'=$P($$DATE^PRC0C(PRC("RBDT"),"I"),U,1,2) D MSG1^PRCFFUD G DT
 D GENDIQ^PRCFFU7(442,+PO,".1;.07;.03;17","IEN","")
 ;
 D  I "^SO^AR^"'[("^"_$P(PRCFA("TT"),":",1)) D MSG S Y=1 G OUT
 . N PRCFATT S PRCFATT=PRCFA("TT")
 . D SOAR^PRC0E(PRCFA("PODA"),.PRCFATT,1) ; ask SO or AR, if appropriate
 . S PRCFA("TT")=PRCFATT K PRCFATT
 ;
 I PRCFA("TT")="AR" D  I "EM"'[X D MSG S Y=1 G OUT
 . N Y
 . D SC^PRC0A("",.Y,"Label document action as: ","AOM^E:Original Entry;M:Modification Entry","M")
 . I $E(Y)="E" S PRCFA("MOD")="E^0^Original Entry"
 . I $E(Y)="M" S PRCFA("MOD")="M^1^Modification Entry"
 . S X=$E(Y)
 . K Y
 S X=0
 I $G(PRCFA("RETRAN"))=1,"^SO^AR"[("^"_$E(PRCFA("TT"),1,2)),$P(PRCFA("GECS"),"^",1,2)'=($E(PRCFA("TT"),1,2)_"^"_$E(PRCFA("MOD"))) D  I X="^" D MSG,PAUSE^PRCFFERU S Y=1 G OUT
 . S PRCFA("SIS")=$$GETTXNS^PRCFFERT(PO,PRC410,21) ; get other FMS txns for this adjustment
 . S X=$$NEWCHK^PRCFFERT(PRCFA("TT"),$E(PRCFA("MOD")),PRCFA("SIS")) ; if selected txn exists, X will be DOCID
 . I X=0 S PRCFA("RETRAN")=2 ; selected txn doesn't exist, create
 . I X'=0 S X=$$SWITCH^PRCFFERT(X,21,.GECSDATA) ; is selected txn available?
 ;
GO ; Prompt use for final go-ahead for the document creation
 D GO^PRCFFU
 I 'Y!($D(DIRUT)) D MSG,OUT Q
 ;
ESIG ; Enter the Electronic Signature and away it goes!
 W !,"The Electronic Signature must now be entered to generate the "_PRCFA("TYPE")_" Document.",!
 D SIG^PRCFFU4
 I $D(PRCFA("SIGFAIL")) K PRCFA("SIGFAIL") H 3 D MSG,OUT Q
 ;
 ; Check fund/year dictionary for FMS required fields
 D EDIT^PRCFFU ; sets up PRCFMO array for req'd fields
 ;
 D EDIT410^PRCFFUD(OB,"O") ; edit running balance qtr & status in 410
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 D SET1358^PRCFFERT ; do rebuild
 ;
STACK ; Create entry in GECS Stack File
 D STACK^PRCFFU(1) ; CTL,BAT,DOC segments, (1) creates batch# for FMS doc
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")>0 G SEGS
 ;
UPDATE ; Update records in 442 and 410
 W !!,"...updating obligation balances....please hold...",!!
 D POADJ^PRCH58OB(.PO,PODA,.TRNODE,AMT)
 D POADJ^PRCS58OB(.PRC,PODA,TRDA,AMT)
 D:AMT>0 BULC^PRCH58(PODA)
 D UPDATE^PRCFFU6(PRC442,PRC410) ; update node 22 of file 442
 ;
SEGS ; Use TMP($J to store remaining segments to be built
 K ^TMP($J,"PRCMO")
 N FMSINT S FMSINT=+PO
 S FMSMOD=$P(PRCFA("MOD"),U,1)
 D NEW^PRCFFU1(FMSINT,PRCFA("TT"),FMSMOD) ; build segments
 ;
 ; Transfer nodes from TMP($J, into GECS Stack File
 N LOOP S LOOP=0
 F  S LOOP=$O(^TMP($J,"PRCMO",GECSFMS("DA"),LOOP)) Q:'LOOP  D SETCS^GECSSTAA(GECSFMS("DA"),^(LOOP))
 K ^TMP($J,"PRCMO")
 ;
TRANS ; Mark the document as queued for transmission
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 N P2 S P2=+PO
 S $P(P2,"/",4)=+TRDA
 S $P(P2,"/",5)=$P(PRCFA("ACCPD"),U)
 S $P(P2,"/",6)=PRCFA("OBLDATE")
 D SETPARAM^GECSSDCT(GECSFMS("DA"),P2) ; save P2 as node 26 of 2100.1
 ;
POBAL ; Enter Obligation Data into Purchase Order Record
 ; Log transaction into node 10 of file 442
 D EN7^PRCFFU41(PRCFA("TT"),FMSMOD,PODATE,PRCFA("PATNUM"))
 ;
 ; Continue processing if this is not a rebuild
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")>0 G OUT
Z S (X,Z)=$P(PO(0),U)
 S %=1
 D EN1^PRCSUT3
 S DLAYGO=424
 S DIC="^PRC(424,"
 S DIC(0)="L"
 D FILE^DICN
 I Y<0 W !,"ERROR IN CREATING 424 RECORD",$C(7),!! Q
 ;
 S DIE="^PRC(424,"
 S DA(1358)=+Y
 D NOW^%DTC
 S TI=%
 S DA=DA(1358)
 S DR=".02///^S X=PODA;.03///^S X=""A"";.06///^S X=$P(TRNODE(4),U,8);.07///^S X=TI;.08////^S X=DUZ;1.1////^S X=""ADJUSTMENT OBLIGATION"";.15////^S X=TRDA"
 D ^DIE W "...adjustment completed..."
 ;
 ;Generate 1358 transaction message to OLCS. Messages will be generated
 ;upon obligation of a new 1358 or an adjustment. Messages will not be
 ;sent for a rebuild or retransmission to FMS. (PRC*5.1*153)
 I $G(PRCFA("RETRAN"))=0 D OLCSMSG^PRCFDO
 ;
 G OUT
 Q
 ;
SCREEN ;COMPARISON SCREEN
 N CEILING,LAUTH,TAUTH,TBAL,LBAL,IOINHI,IOINLOW,IOINORM
 D HILO^PRCFQ
 S CEILING=$P(PO(8),U)
 W @IOF,IOINLOW,"Adjustment Transaction # ",IOINHI,$P(TRNODE(0),"^")
 W IOINLOW,"     1358 # ",IOINHI,$P(PO(0),"^")
 W !!,IOINLOW,"Current amount obligated on 1358: ",IOINHI,"  $ ",$FN(CEILING,"P,",2)
 S TBAL=$P(PO(8),U,3)
 S TAUTH=CEILING-TBAL
 W !!,IOINLOW," Total Authorizations: ",IOINHI," $ ",$J($FN(TAUTH,"P,",2),12)
 S LBAL=$P(PO(8),U,2),LAUTH=CEILING-LBAL
 W ?40,IOINLOW," Total Liquidations: ",IOINHI," $ ",$J($FN(LAUTH,",P",2),12)
 W !,IOINLOW,"Authorization Balance: ",IOINHI," $ ",$J($FN(TBAL,"P,",2),12)
 W ?40,IOINLOW,"Liquidation Balance: ",IOINHI," $ ",$J($FN(LBAL,"P,",2),12),!!
 W IOINLOW,"Amount of Adjustment: ",IOINHI,$J($P(TRNODE(4),"^",8),0,2),!!,IOINORM
 Q
MSG W !
 S X="No further processing is being taken on this 1358 adjustment obligation.  It has NOT been obligated.*"
 D MSG^PRCFQ
 Q
OUT K DIRUT,DTOUT,DUOUT,DIROUT
 QUIT
