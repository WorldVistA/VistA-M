DGPREP1 ;ALB/SCK - Program to Display Pre-Registration List Cont. 1 ; 12/9/03 3:22pm
 ;;5.3;Registration;**109,136,574**;Aug 13, 1993
 Q
EH ; Edit call log information
 ;   Variables
 ;     PTIFN - Patients IEN returned form the SELPAT procedure 
 ;
 N PTIFN,D,X,DA,DR
 S PTIFN=""
 D SELPAT
 Q:'$D(PTIFN)
 S DIC="^DGS(41.43,",DIC(0)="EQZ"
 S X=PTIFN,D="C"
 S DIC("A")="Select LOG ENTRY: "
 S DIC("S")="I $P(^(0),U,2)=PTIFN"
 ;
 D IX^DIC K DIC
 ;
 I Y>0 D
 . S DA=+Y
 . S DIE="^DGS(41.43,"
 . S DR="3;2///^S X=$P(^VA(200,DUZ,0),U)"
 . D ^DIE K DIE
 . I '$D(Y) D
 .. S DGPDFN=PTIFN
 .. D BLDHIST^DGPREP0
 .. S X=$$SETSTR^VALM1(^TMP("DGPRERG",$J,DGPCH,0),"",1,110)
 .. S X=$$SETFLD^VALM1(DGPTAT,X,"HIST")
 .. S ^TMP("DGPRERG",$J,DGPCH,0)=X
 S VALMBCK="R"
 Q
 ;
SELPAT ;  Select patient if no patient is passed in
 N VALMI,VALMAT,VALMY,X
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0),"S") S VALMI=0
 I '$D(VALMY) S VALMBCK="R" Q
 S DGPN1="",DGPCH=$O(VALMY(DGPN1))
 S PTIFN="",PTIFN=$O(^TMP("DGPRERG",$J,"DFN",DGPCH,PTIFN))
 Q
 ;
EDIT ;  Edit Patient Information
 ;  Variables
 ;   DGPDIV    - Division IEN from ^TMP
 ;   DGPSTMP   - Date/Time stamp from UPDLOG function
 ;   DGPIFN    - Patients IEN from ^TMP
 ;   DGPP1-3,5 - Local Var's for $O
 ;   DGPNEW    - 
 ;   DGPFLG    - Flag used to indicate a connect status of 'C'
 ;   DGPST     - Call status returned by SELST function
 ;   DGPDA     - IEN of Call log entry returned from UPDLOG function
 ;   DGPCH     - Entry in the VALMY, selected entries, array
 ;   
 N VALMI,VALMAT,VALMY,X,DGPN5,DGPDIV,DGPSTMP,DGPIFN,DGPP1,DGPP2,DGPP3,DGPNEW,DGPFLG
 ;
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0),"S") S VALMI=0
 I '$D(VALMY) S VALMBCK="R" Q
 S DGPN1="",DGPCH=$O(VALMY(DGPN1))
 S DGPIFN="",DGPIFN=$O(^TMP("DGPRERG",$J,"DFN",DGPCH,DGPIFN))
 S DGPDIV="",DGPDIV=$O(^TMP("DGPRERG",$J,"DIV",DGPCH,DGPDIV))
 S DGNEW=0,DGPFLG=0
 ;
 ; *** Check patient sensitivity before proceeding
 S DIC=2,DIC(0)="ENQ",X=DGPIFN D ^DIC K DIC
 Q:Y<0
 ;
 ; *** Check lock status before continuing
 S DGPN5="",DGPN5=$O(^DGS(41.42,"B",DGPIFN,DGPN5))
 I DGPN5]"" L +^DGS(41.42,DGPN5):2 I '$T W *7,!,"Another User is Editing this Patient" S VALMBCK="R" Q
 ;
 S (DA,DFN)=DGPIFN
 ;
 S DGPFLG=1
 S DGPSTMP=""
 D INITLE(.DGPSTMP)
 ;
 I DGPCH]""&(DGPFLG) D
 . S X=$$SETSTR^VALM1(^TMP("DGPRERG",$J,DGPCH,0),"",1,110)
 . ;S X=$$SETSTR^VALM1("*",X,8,1)
 . I $G(DGPSTMP)]"" S X=$$SETSTR^VALM1($$FMTE^XLFDT(DGPSTMP,"2D"),X,70,8)
 . S ^TMP("DGPRERG",$J,DGPCH,0)=X
 . S DIE="^DGS(41.42,",DA=DGPN5
 . S DR="4///Y" I DGPSTMP]"" S DR=DR_";3///^S X=DGPSTMP"
 . D ^DIE K DIE
 L -^DGS(41.42,DGPN5)
 K DGPENT,DGPN1,DGPCH,DGPLOC,DGPST,DGPN5,DGPFLG
 Q
 ;
INITLE(DGPY) ; Initialize for Load/Edit
 ;   Variables
 ;     Input:
 ;        DGPY - Null value
 ;
 ;     Returns:
 ;        DGPY - Returns the date/time stamp entered into ^DGS(41.41,.
 ;
 ;     Local:
 ;        DGPRFLG - This flag is used by the Patient Load/Edit routines
 ;                  to indicate they were called by preregistration
 ;        DGPLOC  - Flag used by DG10 to indicate preselection of a patient
 ;
 N DGPRFLG
 S (DGPRFLG,DGPLOC)=1
 W !!
 D ^DG10
 Q:$G(DGPFLG)&($G(DGRPOUT))
 ;
 S DGPST=$$SELST
 I DGPST']"" S VALMBCK="R" Q
 ;
 I DGPST'="L" D
 . S DGPDA=$$UPDLOG(DGPIFN,DGPST,DGPDIV) Q:DGPDA'>0
 . I '$G(DGMODE),$P($G(^DGS(41.43,DGPDA,0)),U,4)]"" D
 .. S X=$$SETSTR^VALM1(^TMP("DGPRERG",$J,DGPCH,0),"",1,110)
 .. S DGPP1=$E(X,1,34),DGPP2=$E(X,35,38),DGPP3=$E(X,39,110)
 .. S DGPP2=$P(^DGS(41.43,DGPDA,0),U,4)_DGPP2
 .. S X=DGPP1_$E(DGPP2,1,4)_DGPP3
 .. S ^TMP("DGPRERG",$J,DGPCH,0)=X
 ;
 W !
 S DIR(0)="YA",DIR("A")="Date/Time stamp this patient? ",DIR("B")="YES"
 D ^DIR K DIR
 W !
 I Y D
 . K DD,DO
 . S DGPY=$$NOW^XLFDT
 . S DIC="^DGS(41.41,",DIC(0)="EQZ",X=DFN
 . S DIC("DR")="1///^S X=DGPY;2////^S X=DUZ"
 . D FILE^DICN
 . K DIC
 ;
 Q
STAT ; Display call history
 K PTIFN D SELPAT
 I $D(PTIFN) D
 . D EN^DGPREP2
 K PTIFN
 Q
 ;
SELST() ;  Function to select status for call log
 ;   Returns:
 ;       Status code as a SOC
 ;
 K DIRUT
 N DIR
 W !!
 S DIR(0)="41.43,3"
 S DIR("A")="STATUS OF CALL",DIR("B")="CONNECTED"
 S DIR("?",1)="Enter the status of the current call from the list below."
 S DIR("?")="Entries must be in uppercase, and match on of these codes."
 D ^DIR K DIR
 Q $G(Y)
 ;
UPDLOG(DFN,DGPS,DGPDV) ;  Update PRE-REGISTRATION CALL LOG File, #41.43
 ;
 ;  Variables
 ;    Input:
 ;       DFN   - The IEN of the patient being called
 ;       DGPS  - Status of the call attempt
 ;       DGPDV - Division IEN (used for sorting)
 ;
 ;    Returns:
 ;        The IEN of the CALL LOG, File #41.43, entry that was added. 
 ;        0 is returned if the user ^'s out.
 ;
 K DD,DO
 S DIC="^DGS(41.43,"
 S DIC(0)="L"
 S X=$$NOW^XLFDT
 D FILE^DICN
 I Y<0 W *7,"Problem adding to file - PRE-REGISTRATION CALL LOG"
 I Y'<0 D
 . S DIE="^DGS(41.43,"
 . S DR="1////^S X=DFN;2////^S X=DUZ;3///^S X=DGPS;5////^S X=$S(+DGPDV>0:DGPDV,1:"""")"
 . S DA=+Y
 . D ^DIE K DIE
 . I $D(Y) D 
 .. S DIK="^DGS(41.43," D ^DIK K DIK
 Q +$G(DA)
 ;
DIREDT ;  Direct edit of a patient in the PRE-REGISTRATION CALL LIST, bypassing the call list.
 ;
 ;  Variables
 ;    DFN    - Patients IEN, set for Load/Edit
 ;    DGPDIV - Division IEN from File #41.42
 ;    DGPST  - Call Status
 ;    DGPIDX - Call List IEN, File #41.42
 ;    DGPFLG - Flag for direct patient edit, used for setting 'called' status
 ;    DGPSTMP - Date/time stamp
 ;
 N DFN,DGPDIV,DGPST,DGPIDX,DGPFLG,DGNEW,DGPXX,DGPSTMP,DGPX,DGPIFN,DGMODE
 N DGRPOUT
 ;
 K DTOUT,DUOUT,DIC
 S DIC=2,DIC(0)="AEQZM"
 S DIC("A")="Select Patient to Preregister: "
 S DIC("?")="Select a patient whose preregistration information you want to edit."
 D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT))!(Y<0) Q
 ;
 S (DFN,DGPIFN)=+Y,DGPIDX=""
 I $D(^DGS(41.42,"B",DFN)) D  Q:$G(DGPX)
 . S DGPIDX=$O(^DGS(41.42,"B",DFN,DGPIDX))
 . S DGPDIV=$P($G(^DGS(41.42,DGPIDX,0)),U,2)
 . I DGPIDX]"" L +^DGS(41.42,DGPIDX):2 I '$T W *7,!,"Another user is editing this patient." S DGPX=1
 ;
 S DGNEW=0,DGPFLG=1,DGPSTMP="",DGMODE=1
 ;
 ;  ** Since this is a direct call for a patient, and the particular appt. is not known, set DGPDIV to primary medical center division.
 I $G(DGPDIV)']"" D
 . S DGPDIV=$$PRIM^VASITE
 ;
 D INITLE(.DGPSTMP)
 ;
 I $G(DGRPOUT) G UNLCK
 ;
 I $G(DGPFLG),DGPIDX]"" D
 . S DA=DGPIDX
 . S DIE="^DGS(41.42,"
 . S DR="4///Y" I DGPSTMP]"" S DR=DR_";3///^S X=DGPSTMP"
 . D ^DIE K DIE
 ;
UNLCK I $G(DGPIDX)]"" L -^DGS(41.42,DGPIDX)
 Q
