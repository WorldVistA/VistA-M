RAUTL9 ;HISC/FPT-Utility Routines ;4/9/97  10:08
 ;;5.0;Radiology/Nuclear Medicine;**13,27,51**;Mar 16, 1998
EN1 ; allow lower & uppercase response to REPORT STATUS field
 ; called from [RA REPORT EDIT] & [RA VERIFY REPORT ONLY]
 ;   "      "  routine UNVER+2^RARTE1
 ;
 N Y K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N RAMT S RAMT=0 ; RAMT=$S(Report status before edit="":0,1:1)
 D IARU
 I RATRUE=1 S DIR(0)="S^V:VERIFIED;R:RELEASED/NOT VERIFIED;PD:PROBLEM DRAFT;D:DRAFT"
 I RATRUE=0 S DIR(0)="S^V:VERIFIED;PD:PROBLEM DRAFT;D:DRAFT"
 S DIR("A")="REPORT STATUS"
 S:$P(^RARPT(D0,0),"^",5)="" RAMT=1
 S:$P(^RARPT(D0,0),"^",5)]"" DIR("B")=$P(^RARPT(D0,0),"^",5)
 S:RAMT DIR("B")="D" ; default to 'Draft' if missing report status
 D ^DIR K DIR,RATRUE
 I $D(DIRUT),(RAMT) D
 . S $P(^RARPT(D0,0),"^",5)="D" D ENSET^RAXREF(74,5,"D",D0)
 . ; set Report Status to 'Draft' if originally null, and user times out
 . ; or '^' out!  Make sure xrefs are set!
 . Q
 Q:$D(DIRUT)
 I $E(Y)="V",'$D(^XUSEC("RA VERIFY",DUZ)) W !!,*7,"You do not have the appropriate privileges to verify a report." G EN1
 S RASTATX=$E(Y) S:RASTATX="P" RASTATX="PD"
 Q
EN2 ; residents enter report status to pre-verify
 ; called from input templates [RA PRE-VERIFY REPORT EDIT] and [RA PRE-
 ; VERIFY REPORT ONLY]
 N Y K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N RAMT S RAMT=0 ; RAMT=$S(Report status before edit="":0,1:1)
 D IARU
 I RATRUE=1 S DIR(0)="S^R:RELEASED/NOT VERIFIED;PD:PROBLEM DRAFT;D:DRAFT"
 I RATRUE=0 S DIR(0)="S^PD:PROBLEM DRAFT;D:DRAFT"
 S DIR("A")="RESIDENT PRE-VERIFICATION REPORT STATUS"
 S:$P(^RARPT(D0,0),"^",5)="" RAMT=1
 S:$P(^RARPT(D0,0),"^",5)]"" DIR("B")=$P(^RARPT(D0,0),"^",5)
 S:RAMT DIR("B")="D" ; default to 'Draft' if missing report status
 D ^DIR K DIR,RATRUE
 I $D(DIRUT),(RAMT) D
 . S $P(^RARPT(D0,0),"^",5)="D" D ENSET^RAXREF(74,5,"D",D0)
 . ; set Report Status to 'Draft' if originally null, and user times out
 . ; or '^' out!  Make sure xrefs are set!
 . Q
 Q:$D(DIRUT)
 S RASTATX=$E(Y) S:RASTATX="P" RASTATX="PD"
 Q
EN3 ; residents pre-verify a report
 N Y K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 W ! S DIR(0)="Y",DIR("A")="WANT TO PRE-VERIFY THIS REPORT"
 S DIR("?")="Answer YES to mark this report as pre-verified. Your user ID number, electronic signature code and the current date/time will be stored in the pre-verification fields of this entry."
 D ^DIR K DIR
 W ! Q:$D(DIRUT)
 S RAYN=+Y
 Q
EN4 ; re-display report text question
 N Y K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y",DIR("A")="Want to View the Report Text again" D ^DIR K DIR
 W ! Q:$D(DIRUT)
 S RAYN=Y
 Q
EXIST ; Checks if word processing data exists called from [RA REPORT EDIT]
 ; and [RA PRE-VERIFY REPORT EDIT] templates.
 I RANODE="H",(($D(DTOUT))!($D(DUOUT))) D  Q
 . D CHRSTOR
 I RANODE="R",(($D(DTOUT))!($D(DUOUT))) Q
 I RANODE="I",(($D(DTOUT))!($D(DUOUT))) Q
 I +$O(^RARPT(DA,RANODE,0)) D  Q
 . N CNT,X,X1,X2,X3,X4,RAWPFLG S (RAWPFLG,X)=0
 . F  S X=$O(^RARPT(DA,RANODE,X)) Q:X'>0  D  Q:RAWPFLG
 .. S (CNT,X2)=0
 .. S X1=$G(^RARPT(DA,RANODE,X,0)) Q:X1']""
 .. S X2=$L(X1)
 .. F X3=1:1:X2 D  Q:RAWPFLG
 ... S X4=$E(X1,X3) S:X4?1AN CNT=CNT+1
 ... S:X4'?1AN&(CNT>0) CNT=0
 ... S:CNT=2 RAWPFLG=1
 ... Q
 .. Q
 . I 'RAWPFLG D
 .. S Y=$S(RANODE="H":"@1",RANODE="R":"@2",1:"@3")
 .. W " ?? Invalid "
 .. W $S(RANODE="H":"Clinical History",RANODE="R":"Report",1:"Impression")
 .. W " text.",$C(7)
 .. K ^RARPT(DA,RANODE) ; Clear out bad WP
 .. Q
 . I RANODE="H",('RAWPFLG) D CHRSTOR
 . Q
 Q
CHRSTOR ; Restores original data to the Clinical History field in the
 ; Rad/Nuc Med Reports File.  Global: ^RARPT(  File #: 74
 ; Set ^RARPT('DA',"H") array to value in ^TMP($J,"RA Clin Hist")
 N %X,%Y,Y
 S %X="^TMP($J,""RA Clin Hist"",",%Y="^RARPT("_DA_",""H"","
 D %XY^%RCR K ^TMP($J,"RA Clin Hist")
 Q
CHSAVE ; Checks if word processing data exists called from [RA REPORT EDIT]
 ; and [RA PRE-VERIFY REPORT EDIT] templates.  For the 'Clinical History'
 ; field.
 ; Save off existing text in a ^TMP global.
 K ^TMP($J,"RA Clin Hist") N %X,%Y
 S %X="^RARPT("_DA_",""H"",",%Y="^TMP($J,""RA Clin Hist"","
 D %XY^%RCR
 Q
CHPRINT ; Prints text from the 'Clinical History' field in file 70
 ; from [RA REPORT EDIT] template.  Added with patch RA*5*27 - bnt
 ;
 N DIR,DTOUT,DUOUT
 D EN^DDIOL("CLINICAL HISTORY:")
 S DIWL=1,DIWF="|WC75",RAV=0 K ^UTILITY($J,"W")
 F  S RAV=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAV)) Q:RAV'>0  D
 . S X=^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAV,0)
 . D ^DIWP
 D ^DIWW S X=""
 Q
OUTTEXT(X,DIWF,DIWL,DIWR,RAFMAT,RALFF,RATFF) ; Output generic text using DIWP
 ;INPUT VARIABLES:
 ; 'X'      --> Text to be formatted    'DIWF'  -->  Format control data
 ; 'DIWL'   --> Left margin             'DIWR'  -->  Right margin
 ; 'RAFMAT' --> Tabs for columns        'RALFF' -->  Leading line feed
 ; 'RATFF'  --> Trailing line feed
 N DIW,DIWI,DIWT,DIWTC,DIWX,RALFMAT,RATFMAT,Y,Z
 Q:X']""  S RAFMAT=+$G(RAFMAT)
 S RALFF=$TR($G(RALFF),$G(RALFF),"!")
 S RATFF=$TR($G(RATFF),$G(RATFF),"!")
 S RALFMAT=RALFF_"?"_RAFMAT,RATFMAT=RATFF
 K ^UTILITY($J,"W",DIWL) D ^DIWP
 S Y=0 F  S Y=$O(^UTILITY($J,"W",DIWL,Y)) Q:Y'>0  D
 . S Y(0)=$G(^UTILITY($J,"W",DIWL,Y,0)) W @RALFMAT,Y(0)
 . S Z=$O(^UTILITY($J,"W",DIWL,Y))
 . W:RATFMAT]""&(Z>0) @RATFF
 . Q
 K ^UTILITY($J,"W")
 Q
STOPCHK ; does user want to stop task?
 I $$S^%ZTLOAD D
 . S ZTSTOP=1 K ZTREQ
 . W !?10,"*** OUTPUT STOPPED AT USER'S REQUEST ***"
 . W !?10,"Option Name: ",$S($P($G(XQY0),"^")]"":$P($G(XQY0),"^"),1:"Unknown")
 . W !?10,"Option Menu Text: ",$S($P($G(XQY0),"^",2)]"":$P($G(XQY0),"^",2),1:"Unknown")
 . W !?10,"Task #: ",$S(+$G(ZTSK)>0:+$G(ZTSK),1:"Unknown")
 . Q
 Q
UPDTPNT(RAIEN) ; Remove the possibility of broken pointers when a report
 ; is deleted from the Rad/Nuc Med Reports file (74).  This checks the
 ; following files: Report Batches file (74.2) and the
 ; Report Distribution file (74.4)
 N A,B,DA,DIK
 I $D(^RABTCH(74.2,"D",RAIEN)) D
 . S A=0 F  S A=$O(^RABTCH(74.2,"D",RAIEN,A)) Q:A'>0  D
 .. S B=0 F  S B=$O(^RABTCH(74.2,"D",RAIEN,A,B)) Q:B'>0  D
 ... S DA=B,DA(1)=A,DIK="^RABTCH(74.2,"_DA(1)_",""R"","
 ... D ^DIK K DA,DIK
 ... Q
 .. Q
 . Q
 I $D(^RABTCH(74.4,"B",RAIEN)) D
 . S A=0 F  S A=$O(^RABTCH(74.4,"B",RAIEN,A)) Q:A'>0  D
 .. S DA=A,DIK="^RABTCH(74.4," D ^DIK K DA,DIK
 .. Q
 . Q
 Q
IARU ; Imaging Location allows released/unverified
 S RATRUE=$S($P(^RA(79.1,+$P(^RADPT(RADFN,"DT",RADTI,0),U,4),0),U,17)="Y":1,1:0)
 Q
