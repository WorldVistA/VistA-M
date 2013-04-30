PRCESOE ;WISC/CLH/CTB/SJG/ASU - 1358 OBLIGATION ; 08/22/94  5:11 PM
V ;;5.1;IFCAP;**148,153,161**;Oct 20, 2000;Build 19
 ;Per VHA Directive 2004-038, this routine should not be modified.
 K PRC,PRCF,Y
 N PRCFSC,PRCREVSW S PRCFSC=1    ;PRC*5.1*148  ENTERED FROM 1358 OBLIGATE
 D OUT
 S PRCF("X")="AB"
 D ^PRCFSITE Q:'%
 D LOOKUP G:Y<0 OUT
 D K1A^PRCFFUZ
 S (OB,DA)=+Y ; ien for file 410
 S PRCFA("RETRAN")=0
SC ; Entry point for rebuild/retransmit
 D NODE^PRCS58OB(DA,.TRNODE) ; set file 410 values into TRNODE array
 S PRCFA("TRDA")=OB
 D SCREEN^PRCEOB1 W !
 D VENCONO^PRCFFU15(OB) ; display vendor & contract info, if exists
 ; PRC*5.1*148 start
 ; if Obligator is a requestor, violation to segregation of duties
 I $P($G(TRNODE(7)),"^",1)=DUZ D  G OUT
 . W !!,"You are the CP Clerk (Requestor) on this 1358 transaction."
 . W !,"Per Segregation of Duties, the CP Clerk (Requestor)"
 . W " is not permitted to "
 . W $S($G(PRCFSC):"Obligate",1:"Rebuild/Retransmit")," the 1358."
 . I $G(PRCFSC) Q
 . W ! D EN^DDIOL("  ** Press RETURN to continue **")
 . R X:DTIME Q
 ; if Obligator is a approver, violation to segregation of duties
 I $P($G(TRNODE(7)),"^",3)=DUZ D  G OUT
 . W !!,"You are the Approver on this 1358 transaction."
 . W !,"Per Segregation of Duties, the Approver is not permitted to "
 . W $S($G(PRCFSC):"Obligate",1:"Rebuild/Retransmit")," the 1358."
 . I $G(PRCFSC) Q
 . W ! D EN^DDIOL("  ** Press RETURN to continue **")
 . R X:DTIME Q
 ; PRC*5.1*148 end
 ;PRC*5.1*161 adds logic that will allow the user to display the 1358 for
 ;            compliance review prior to obligating
REV S PRC("CP")=$P(TRNODE(3),U,3),PRCREVSW=0
 W !!,"Would you like to review this request?"
 S %=2 D YN^DICN G REV:%=0 I %=1 D
 . S HLDZ=Z,HLDN=N,(N,PRCSZ)=DA,PRCSF=1,PRCREVSW=1 D PRF1^PRCSP1
 . S DA=PRCSZ,Z=HLDZ,N=HLDN
 . K HLDZ,HLDN,X,PRCSF,PRCSZ,PRC("CP"),RECORD,RECORD1,RECORD10,RECORD2,RECORD3,RECORD4
 . K %H,%I,DIW,DIWI,DIWT,DIWTC,DIWX,IOHG,IOPAR,IOUPAR,POP,N,Z
 I PRCREVSW=1 W !!,"Would you like continue obligating this 1358?" S %=1 D YN^DICN G OUT:%'=1
 S FLDCHK=0
 D EN^PRCFFU14(OB) ; edit auto accrual info
 I ACCEDIT=1 G SC
 I FLDCHK=1 D OUT G V
OKAY S PRCFA("IDES")="1358 Obligation"
 D OKAY^PRCFFU ; ask 'Is info correct?'
 I $D(DIRUT) D MSG H 3 G OUT
 S ESIGCHK=1
 S FISCEDIT=0
 I 'Y D 1358^PRCFFU13 ; edit cost center or boc?
 I 'ESIGCHK D MSG H 3 G OUT
 I FISCEDIT G SC
 S PRC("RBDT")=$P(TRNODE(0),U,11)
 S PCP=$P(TRNODE(0),"-",4)
 S PQT=$P(TRNODE(0),"-",3)
 D CPBAL^PRCFFMO1 ; display control point balance
 K PQT,PRCF("NOBAL")
 K PRCTMP
 I '$P(TRNODE(0),U,11) D
 . D ERS410^PRC0G(DA)
 . S TRNODE(0)=^PRCS(410,DA,0)
 S PRC("FY")=$P(TRNODE(0),"-",2)
 S PRC("QTR")=$P(TRNODE(0),"-",3)
 S PRC("CP")=$P(TRNODE(0),"-",4)
 I $G(PRCRGS)<1 D OVCOM1^PRCFFU10 I PRCFA("OVCOM")=1!(PRCFA("OVCOM")=2) D REQFAIL^PRCFFU10,MSG H 3 G OUT
 W ! D OKAY2^PRCFFU ; ask 'OK to continue?'
 I 'Y!($D(DTOUT)) D MSG H 3 G OUT
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=0 D  G:'$D(DA) OUT
 . K DA,X
 . S PRCHP("T")=21
 . S PRCHP("S")=4
 . S PRCHP("A")="1358 Obligation Number"
 . S PRCFA(1358)=""
 . D EN^PRCHPAT ; ask for obligation #, set up 442 record
 . K PRCFA(1358),PRCHP
 . I '$D(DA) D MSG3
 . Q
VAR I $D(PRCFA("RETRAN")),PRCFA("RETRAN") S DA=POIEN ; 442 ien
 D PAT^PRCH58OB(DA,.PODA,.PO,.PATNUM) ; set up parameterized variables
 N PRCFDEL,AMT,CS,DA,DIK,TIME,MOD
 S PRCFA("BBFY")=$TR($P(TRNODE(3),"^",11)," ")
 S PRCFA("MOD")="E^0^Original Entry"
 S PRCFA("MP")=$P(PO(0),U,2)
 S PRCFA("PATNUM")=$P($P(PO(0),"^"),"-",2)
 S PRCFA("PODA")=PODA
 S PRCFA("REF")=$P(PO(0),U)
 ; S PRCFA("SFC")=$P(PO(0),U,19)
 S PRCFA("SYS")="FMS"
 S PRCFA("TT")="SO"
VAR11 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 D  G VAR2
 . D RETRANO^PRCESOE2 ; put date in FMS transaction into PRCFA("OBLDATE")
 . S X=PRCFA("OBLDATE")
 S X=PRC("RBDT")
 I X<DT!'X D NOW^%DTC
VAR2 S Y=X D D^PRCFQ ; convert date to external format
 S %DT="AEX"
 S %DT("B")=Y
 S %DT("A")="Select Obligation Processing Date: "
 W ! D ^%DT K %DT
 I Y<0 D EXIT G OUT
 S PRCFA("OBLDATE")=Y
 S EXIT=0
 D ENO^PRCESOE2 ; processes PRCFA("OBLDATE"), gets accounting period
 I EXIT=1 D EXIT,KILL^PRCESOE2 G OUT
 I PRC("RBDT")'<$P(^PRC(420,PRC("SITE"),0),"^",9),$P($$DATE^PRC0C(PRCFA("OBLDATE"),"I"),U,1,2)'=$P($$DATE^PRC0C(PRC("RBDT"),"I"),U,1,2) D MSG1^PRCFFUD S X=PRC("RBDT") G VAR11
 ;
GO ; Prompt user for final go-ahead for the document creation
 D GO^PRCFFU ; ask 'Transmit?'
 I 'Y!($D(DIRUT)) G EXIT
 ;
ESIG ; Enter the Electronic Signature and away it goes!
 W !,"The Electronic Signature must now be entered to generate the "_PRCFA("TYPE")_" Document.",!
 D SIG^PRCFFU4
 I $D(PRCFA("SIGFAIL")) D  G EXIT
 . K PRCFA("SIGFAIL")
 . D MSG2(ESIGMSG)
 . Q
 ;
 D OB1^PRCS58OB(PRCFA("TRDA"),PODA) ; save 442 ien in file 410
 D COB^PRCH58OB(PODA,.TRNODE,.PO,PRCFA("TRDA"),X) ; stuff some values into 442
 D PODT^PRCS58OB(PRCFA("PODA"),PRCFA("OBLDATE")) ; save PRCFA("OBLDATE")  in file 442 as PO DATE
 S PRCFA("BBFY")=$$BBFY^PRCFFU5(PRCFA("PODA"))
 D GENDIQ^PRCFFU7(442,PRCFA("PODA"),".1;.07;.03;17","IEN","")
 D EDIT410^PRCFFUD(PRCFA("TRDA"),"O") ; updates running balance quarter & status in 410
 S PRC("CP")=+$P(PO(0),"^",3)
 ;
EDIT ; Check fund/year dictionary for required FMS fields
 D EDIT^PRCFFU ; sets up PRCFMO array to use in building LIN segment
 ;
 S IDFLAG="I" ; flag to FMS indicating a dollar increase
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 D SET1358^PRCFFERT ; do rebuild
 ;
STACK ; Create entry in GECS Stack File
 D STACK^PRCFFU(0) ; set up CTL,DOC segs of code sheet, (0) means no batch#
 ;
SEGS ; Create entry in TMP($J, for remaining segments
 K ^TMP($J,"PRCMO")
 N FMSINT S FMSINT=+PO
 S FMSMOD=$P(PRCFA("MOD"),U,1)
 D NEW^PRCFFU1(FMSINT,PRCFA("TT"),FMSMOD) ; builds remaining segs
 ;
 ; Transfers remaining segs from TMP($J, into GECS Stack File
 N LOOP S LOOP=0
 F  S LOOP=$O(^TMP($J,"PRCMO",GECSFMS("DA"),LOOP)) Q:'LOOP  D SETCS^GECSSTAA(GECSFMS("DA"),^(LOOP))
 K ^TMP($J,"PRCMO")
 ;
TRANS ; Mark the FMS transaction document as queued for transmission
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 N P2 S P2=+PO
 S $P(P2,"/",3)=+OB
 S $P(P2,"/",5)=$P(PRCFA("ACCPD"),U)
 S $P(P2,"/",6)=PRCFA("OBLDATE")
 D SETPARAM^GECSSDCT(GECSFMS("DA"),P2)
 ;
POBAL ; Enter Obligation Data into Purchase Order Record
 ;
 ; add FMS document info to node 10 of file 442
 D EN7^PRCFFU41(PRCFA("TT"),FMSMOD,PRCFA("OBLDATE"),PRCFA("PATNUM"))
 ;
 ; create daily record in file 424
 D POST G OUT:'%
 ;
 ; continue processing if this is not a rebuild
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN") D OUT Q
 S X=100
 S DA=PRCFA("PODA")
 D ENF^PRCHSTAT
 S AMT=$P(PO(0),U,7)+$S(+$P(PO(0),U,9)'=0:$P(PO(0),U,9),1:"")
 D NOW^PRCFQ
 S TIME=X
 S X=$P(TRNODE(4),"^",8) ; file 410 transaction amount
 S DA=PRCFA("TRDA") ; file 410 ien
 D TRANK^PRCSES
 S DEL=$S('$D(DEL):"",1:DEL)
 D CS^PRCS58OB(OB,AMT,TIME,PATNUM,PODA,DEL,X,.PRC)
 W !!,"...updating 1358 Obligation balances...",!
 S ^PRC(442,PODA,8)=AMT_"^0^0"
 S X=AMT D TRANS1^PRCSES
 S X=AMT D  W !! G V
 . D TRANS^PRCSES
 . D BULLET^PRCEFIS1
 . ;Generate 1358 transaction message to OLCS. Messages will be generated
 . ;upon obligation of a new 1358 or an adjustment. Messages will not be
 . ;sent for a rebuild or retransmission to FMS.(PRC*5.1*153)
 . I $D(PRCFA("RETRAN")),'PRCFA("RETRAN") D OLCSMSG^PRCFDO
 . D OUT
 ;
OUT D K1B^PRCFFUZ
 D K1C^PRCFFUZ
 Q
 ;
EXIT I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=0 D MSG1,KILL^PRCH58OB(PODA)
 E  D MSG
 Q
 ;
KILL D KILL^PRCH58OB(PODA) G OUT
 ;
LOOKUP ; Lookup 1358 transaction which is pending fiscal action.
 D LOOKUP^PRCESOE1
 Q
 ;
POST ; Post data in file 424
 I $D(PRCFA("RETRAN")),'PRCFA("RETRAN") D POST^PRCESOE1
 Q
 ;
 ; Message processing
MSG D MSG^PRCESOE1 Q
MSG1 D MSG1^PRCESOE1 Q
MSG2(MSG) D MSG2^PRCESOE1(MSG) Q
MSG3 D MSG3^PRCESOE1 Q
