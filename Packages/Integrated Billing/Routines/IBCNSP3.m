IBCNSP3 ;ALB/AAS - INSURANCE MANAGEMENT EDIT ;06-JUL-93
 ;;2.0;INTEGRATED BILLING;**28,52,85,251,371,497,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; AWC/20160104 - Modified tags AC,PPCOM,ADCOM and EDCOM to:
 ;  1. Accept the maximum of 245 characters in the patient policy comment field.
 ;  2. Put timeout code into to exit to previous menu upon a timeout.
 ;  3. Put in code to display an error if occurred and to exit to previous menu upon an error.
 ;  4. Added code to Not update user/date time if user just displayed comments.
 ;
 ;  Input:
 ;    IBDT   = date/time that comment was made
 ;    IBOUT  = return variable  0-don't exit menu,  1-exit menu
 ;    PLIEN  = ien of selected INSURANCE POLICY at ^DPT("_DFN_",.312,
 ;    IBPPOL = ien of INSURANCE policy record at 2.312 multiple
 ;    IBCDFN = ien of PATIENT record (file 2)
 ;
 ;  System wide variables:
 ;    DFN    = Internal number of an entry in the PATIENT File (#2)
 ;    DUZ    = Assumed to be the User Number; a positive number uniquely identifying the current user.
 ;
% G ^IBCNSM4
 ;
SAVEPT(DFN,DA) ; -- Save the global before editing
 K ^TMP($J,"IBCNSPT")
 S ^TMP($J,"IBCNSPT",2.312,DFN,+DA,0)=$G(^DPT(DFN,.312,+DA,0))
 S ^TMP($J,"IBCNSPT",2.312,DFN,+DA,1)=$G(^DPT(DFN,.312,+DA,1))
 S ^TMP($J,"IBCNSPT",2.312,DFN,+DA,2)=$G(^DPT(DFN,.312,+DA,2))
 S ^TMP($J,"IBCNSPT",2.312,DFN,+DA,3)=$G(^DPT(DFN,.312,+DA,3))
 S ^TMP($J,"IBCNSPT",2.312,DFN,+DA,4)=$G(^DPT(DFN,.312,+DA,4))
 S ^TMP($J,"IBCNSPT",2.312,DFN,+DA,5)=$G(^DPT(DFN,.312,+DA,5))
 S ^TMP($J,"IBCNSPT",2.312,DFN,+DA,7)=$G(^DPT(DFN,.312,+DA,7))    ; IB*2.0*497 (vd)
 Q
 ;
COMPPT(DFN,DA) ; -- Compare before editing with globals
 S IBDIF=0
 I $G(^DPT(DFN,.312,+DA,0))'=$G(^TMP($J,"IBCNSPT",2.312,DFN,+DA,0)) S IBDIF=1 G COMPPTQ
 I $G(^DPT(DFN,.312,+DA,1))'=$G(^TMP($J,"IBCNSPT",2.312,DFN,+DA,1)) S IBDIF=1 G COMPPTQ
 I $G(^DPT(DFN,.312,+DA,2))'=$G(^TMP($J,"IBCNSPT",2.312,DFN,+DA,2)) S IBDIF=1 G COMPPTQ
 I $G(^DPT(DFN,.312,+DA,3))'=$G(^TMP($J,"IBCNSPT",2.312,DFN,+DA,3)) S IBDIF=1 G COMPPTQ
 I $G(^DPT(DFN,.312,+DA,4))'=$G(^TMP($J,"IBCNSPT",2.312,DFN,+DA,4)) S IBDIF=1 G COMPPTQ
 I $G(^DPT(DFN,.312,+DA,5))'=$G(^TMP($J,"IBCNSPT",2.312,DFN,+DA,5)) S IBDIF=1 G COMPPTQ
 I $G(^DPT(DFN,.312,+DA,7))'=$G(^TMP($J,"IBCNSPT",2.312,DFN,+DA,7)) S IBDIF=1 G COMPPTQ    ; IB*2.0*497 (vd)
 ;
COMPPTQ I IBDIF D:'$D(IBCOVP) COVERED^IBCNSM31(DFN,$P($G(^DPT(DFN,.31)),"^",11))
 Q
 ;
UPDATPT(DFN,DA) ; -- enter date and user if editing has taken place
 N DR,DIE,DIC
 S DIE="^DPT("_DFN_",.312,",DA(1)=DFN
 S DR="1.05///NOW;1.06////"_DUZ
 D ^DIE
 Q
 ;
EM ; -- Employer for claims update
 D FULL^VALM1 W !!
 N IBDIF,DA,DR,DIC,DIE
 D SAVEPT(DFN,IBCDFN)
 D VARS
 L +^DPT(DFN,.312,+$P($G(IBPPOL),"^",4)):5 I '$T D LOCKED^IBTRCD1 G EMQ
 ;
 ;S DR="2.01;S:'$P($G(^DPT(DFN,.312,+$G(DA),2)),U) Y=""@999"";W !!,""*** If ROI applies, make sure current consent is signed! ***"",!;2.015;2.02;2.03;2.04;2.05;2.06;2.07;2.08;2.09;@999"
 ;
 S DR="2.1" D ^DIE K DIE,DR
 ;
 I +$P($G(^DPT(DFN,.312,+$G(DA),2)),U,10),$P($G(^DPT(DFN,.312,+$G(DA),2)),U,9)="" D EMPSET(DFN,$G(DA)) ; curr emp
 ;
 I +$P($G(^DPT(DFN,.312,+$G(DA),2)),U,10) D VARS S DR="2.015;2.11;2.12;2.01;W:+X !!,""*** If ROI applies, make sure current consent is signed! ***"",!!;2.02;2.03;2.04;2.05;2.06;2.07;2.08;@999" D ^DIE K DIE,DR
 ;
 ;I '$P($G(^DPT(DFN,.312,+$G(DA),2)),U) D VARS S DR="2.015///@;2.02///@;2.03///@;2.04///@;2.05///@;2.06///@;2.07///@;2.08///@" D ^DIE
 ;
 I '$P($G(^DPT(DFN,.312,+$G(DA),2)),U,10) D VARS S DR="2.01///@;2.015///@;2.02///@;2.03///@;2.04///@;2.05///@;2.06///@;2.07///@;2.08///@;2.11///@;2.12///@" D ^DIE
 ;
 D COMPPT(DFN,IBCDFN)
 I IBDIF D UPDATPT(DFN,IBCDFN),BLD^IBCNSP
 L -^DPT(DFN,.312,+$P($G(IBPPOL),"^",4))
EMQ S VALMBCK="R" Q
 ;
AC ; -- Add Comment
 D FULL^VALM1 W !!
 N IBDIF,DA,DR,DIE,DIC,X,Y,IBOUT,IBDEL
 S (IBOUT,IBDEL)=0
 ;
 D SAVEPT(DFN,IBCDFN),VARS
 L +^DPT(DFN,.312,+$P($G(IBPPOL),U,4)):5 I '$T D LOCKED^IBTRCD1 G ACQ
 ;
 ; -- get the patient policy comments
 D PPCOMM(+$P($G(IBPPOL),U,4),.IBOUT,.IBDEL) I IBOUT&('IBDEL) L -^DPT(DFN,.312,+$P($G(IBPPOL),U,4)) G ACQ  ; IB*2*528
 I 'IBDEL D COMPPT(DFN,IBCDFN) I IBDIF D UPDATPT(DFN,IBCDFN)
 L -^DPT(DFN,.312,+$P($G(IBPPOL),"^",4))
 ;
 W !!,"You may now enter comments about this Group Plan that pertains to all Patients"
 L +^IBA(355.3,+IBCPOL):5 I '$T D LOCKED^IBTRCD1 G ACQ
 ;
 S DIE="^IBA(355.3,",DA=IBCPOL,DR="11"
 D ^DIE
 ;
 D BLD^IBCNSP
 L -^IBA(355.3,+IBCPOL)
ACQ S VALMBCK="R" Q
 ;
PPCOMM(PLIEN,IBOUT,IBDEL) ; ib*2*528   record patient policy comments
 N IBDT,CMIEN
 ;comments do not exist for the user so add
 I '$O(^DPT(DFN,.312,PLIEN,13,"C",DUZ,"")) D ADCOM(PLIEN,.IBOUT) Q
 ; comments exist for the user, need to determine if for same day.  
 S IBDT=$O(^DPT(DFN,.312,PLIEN,13,"B",""),-1),CMIEN=$O(^DPT(DFN,.312,PLIEN,13,"B",IBDT,""),-1)
 ; comments exist for the user and they exist for the TODAY'S date so edit
 I $P(^DPT(DFN,.312,PLIEN,13,CMIEN,0),U,2)=DUZ,$P($P($G(^DPT(DFN,.312,PLIEN,13,CMIEN,0)),U),".")=DT D EDCOM(PLIEN,IBDT,.IBOUT,.IBDEL) Q
 ; user does not have comments for the current date so just add it
 D ADCOM(PLIEN,.IBOUT)
 Q
 ;
ADCOM(PLIEN,IBOUT) ; add new entry to the COMMENT - SUBSCRIBER POLICY multiple
 ; -- lock the "comment - subscriber policy" multiple so that previous comments can't be edited
 L +^DPT(DFN,.312,PLIEN,13):5 I '$T D LOCKED^IBTRCD1 S IBOUT=1 Q
 ;
 N Y,IBCOM,FDA,IENS,DUOUT,DTOUT,DIERR
 ;
 W !
 ;
 ; -- prompt user to enter comments
 S DIR("A")="Patient Policy Comment: ",DIR(0)="FAO^3:245"
 S DIR("?")="This response must have at least 3 characters and no more than 245 characters and must not contain an embedded '^' "
 D ^DIR I $D(DTOUT) S IBOUT=1 G ADQ
 S IBCOM=Y
 ;
 ; -- update the comment(s) in database
 I IBCOM]""&(IBCOM'[U) D
 . ;
 . ; -- populate the fda array with data
 . S IENS="+1,"_PLIEN_","_DFN_","
 . S FDA(2.342,IENS,.01)=$$NOW^XLFDT()
 . S FDA(2.342,IENS,.02)=DUZ
 . S FDA(2.342,IENS,.03)=IBCOM
 . ;
 . ; -- update the database using the fda array
 . D UPDATE^DIE(,"FDA") I $D(DIERR) D COMERR("Error occurred in ADCOM-IBCNSP3. Could NOT Update Subscriber Policy Comments...",.IBOUT)
 ;
 ; -- unlock the "comment - subscriber policy" multiple
ADQ L -^DPT(DFN,.312,PLIEN,13)
 Q
 ;
EDCOM(PLIEN,IBDT,IBOUT,IBDEL) ; edit the existing entry at 2.312,1.18 multiple
 N DA,DR,DIE,IBNM,DIRUT,DUOUT,DTOUT,IBTXT1,IBTXT2,DIERR
 ;
 ; -- set up system variables for editing comments
 S DA=$O(^DPT(DFN,.312,PLIEN,13,"BB",DUZ,IBDT,""),-1)
 S DIE="^DPT("_DFN_",.312,"_PLIEN_",13,"
 S DA(2)=DFN,DA(1)=PLIEN
 S DR=".03"
 ;
 ; -- retrieve the comments before editing
 S IBTXT1=$$GET1^DIQ(2.342,DA_","_PLIEN_","_DFN_",",.03,"E")
 I $D(DIERR) D COMERR("Error occurred in EDCOM-IBCNSP3. Could NOT Retrieve Subscriber Policy Comments...",.IBOUT) Q
 ;
 ; -- edit the latest comment made by the user
 D ^DIE I $D(DIRUT)!$D(DUOUT)!($D(DTOUT)) S IBOUT=1 Q
 ;
 ; -- determine if comments were deleted
 I $G(^DPT(DFN,.312,PLIEN,13,DA,1))']"" S DR=".01///@;.02///@" D ^DIE S IBDEL=1 Q
 ;
 ; -- retrieve the comments after editing.  Quit if no edits made to the comments
 S IBTXT2=$$GET1^DIQ(2.342,DA_","_PLIEN_","_DFN_",",.03,"E")
 I $D(DIERR) D COMERR("Error occurred in EDCOM-IBCNSP3. Could NOT Retrieve Subscriber Policy Comments after editing it...",.IBOUT) Q
 I IBTXT1=IBTXT2 Q
 ;
 ; -- get user name to update comment field
 S IBNM=$$GET1^DIQ(200,DUZ_",",.01,"E")
 I $D(DIERR) D COMERR("Error occurred in EDCOM-IBCNSP3. Could NOT Retrieve User Name to update comment field...",.IBOUT) Q
 ;
 ; -- determine if comments were removed; update date/time and user fields accordingly
 I $G(^DPT(DFN,.312,PLIEN,13,DA,1))]"" S DR=".01///"_$$NOW^XLFDT()_";.02///"_IBNM
 E  S DR=".01///@;.02///@"
 D ^DIE
 Q
 ;
COMERR(IBTXT,IBOUT) ; display error messages
 W !!,(IBTXT),!!
 S IBOUT=1
 D PAUSE^VALM1
 Q
 ;
BLS(X,Y) ; -- blank a section of lines
 N I
 F I=X:1:Y D BLANK^IBCNSP(.I)
 Q
 ;
VARS ; -- set vars for call to die for .312 node
 S DA(1)=DFN,DA=$P(IBPPOL,"^",4)
 S DIE="^DPT("_DA(1)_",.312,"
 Q
 ;
SAVE(IBCPOL) ; -- Save the global before editing
 K ^TMP($J,"IBCNSP")
 S ^TMP($J,"IBCNSP",355.3,+IBCPOL,0)=$G(^IBA(355.3,+IBCPOL,0))
 S ^TMP($J,"IBCNSP",355.3,+IBCPOL,1)=$G(^IBA(355.3,+IBCPOL,1))
 S ^TMP($J,"IBCNSP",355.3,+IBCPOL,2)=$G(^IBA(355.3,+IBCPOL,2))   ; IB*2.0*497 (vd)
 ;;Daou/EEN - adding BIN and PCN
 S ^TMP($J,"IBCNSP",355.3,+IBCPOL,6)=$G(^IBA(355.3,+IBCPOL,6))
 Q
 ;
COMP(IBCPOL) ; -- Compare before editing with globals
 S IBDIF=0
 I $G(^IBA(355.3,+IBCPOL,0))'=$G(^TMP($J,"IBCNSP",355.3,+IBCPOL,0)) S IBDIF=1 Q
 I $G(^IBA(355.3,+IBCPOL,1))'=$G(^TMP($J,"IBCNSP",355.3,+IBCPOL,1)) S IBDIF=1 Q
 I $G(^IBA(355.3,+IBCPOL,2))'=$G(^TMP($J,"IBCNSP",355.3,+IBCPOL,2)) S IBDIF=1 Q    ; IB*2.0*497 (vd)
 ;;Daou/EEN - adding BIN and PCN
 I $G(^IBA(355.3,+IBCPOL,6))'=$G(^TMP($J,"IBCNSP",355.3,+IBCPOL,6)) S IBDIF=1 Q
 Q
 ;
UPDATE(IBCPOL) ; -- Update last edited by
 N DA,DIC,DIE,DR,IBNM
 S DIE="^IBA(355.3,",DA=IBCPOL,DR="1.05///NOW;1.06////"_DUZ
 D ^DIE
 Q
 ;
RIDERS ; -- add/edit personal riders
 ;
 D FULL^VALM1
 N IBDIF,DA,DR,DIE,DIC,X,Y,IBCDFN,IBPRD,IBPRY
 S IBCDFN=$P(IBPPOL,"^",4)
 W ! D DISPR W !
 ;
R1 S DIC="^IBA(355.7,",DIC(0)="AEQML",DLAYGO=355.7
 S DIC("DR")=".02////"_DFN_";.03////"_IBCDFN
 S DIC("S")="I $P(^(0),U,2)=DFN,$P(^(0),U,3)=IBCDFN"
 I $D(IBPRD) S DIC("B")=IBPRD
 D ^DIC K DIC,IBPRD
 I +Y<1 G RIDERQ
 S IBPRY=+Y
 L +^IBA(355.7,IBPRY):5 I '$T D LOCKED^IBTRCD1 G RIDERQ
 S DIE="^IBA(355.7,",DA=+Y,DR=".01",DIDEL=355.7
 D ^DIE K DA,DR,DIE,DIC,DIDEL,DLAYGO
 L -^IBA(355.7,IBPRY)
 W ! G R1
RIDERQ S VALMBCK="R"
 Q
 ;
RD ; -- Add riders/ for multiple policies
 D FULL^VALM1
 N I,J,IBXX,VALMY
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .S IBPPOL=$G(^TMP("IBNSMDX",$J,$O(^TMP("IBNSM",$J,"IDX",IBXX,0))))
 .Q:IBPPOL=""
 .D RIDERS
 .Q
 D BLD^IBCNSM
 S VALMBCK="R"
 Q
 ;
DISPR ; -- Display riders
 N IBPR,I,J
 S I=0
 I '$G(IBCDFN)!('$G(DFN)) G DISPRQ
 W !,"Current Personal Riders: "
 F  S I=$O(^IBA(355.7,"APP",DFN,IBCDFN,I)) Q:'I  S J=$O(^(I,0)),IBPR=$G(^IBA(355.7,+J,0)) D
 .S IBPRD=$$EXPAND^IBTRE(355.7,.01,+IBPR)
 .W !?5,IBPRD
 I '$D(IBPRD) W !?5,"None Indicated"
DISPRQ Q
 ;
EMPSET(DFN,IBCPOL) ; insert patient or spouses current employer as ESGHP address if that employer sponsors this plan
 N IBWHOS,VAOA,DIR,IBE,IBEMPST,DR,X,Y
 I +$G(DFN) S IBWHOS=$P($G(^DPT(DFN,.312,+$G(IBCPOL),0)),U,6) S VAOA("A")=$S(IBWHOS="v":5,IBWHOS="s":6,1:"")
 I $G(VAOA("A"))'="" D OAD^VADPT I $G(VAOA(9))'="" D
 . ;
 . S DIR("A")="Current Employer "_VAOA(9)_" Sponsors this Plan",DIR("B")="No",DIR(0)="Y" W ! D ^DIR W ! Q:'Y  W "...."
 . D VARS S IBE=$S(IBWHOS="v":.311,1:.25),IBEMPST=$P($G(^DPT(DFN,IBE)),U,15)
 . ;
 . S DR="2.015///"_VAOA(9)_";2.02///"_VAOA(1)_";2.03///"_VAOA(2)_";2.04///"_VAOA(3)_";2.05///"_VAOA(4) D ^DIE
 . S DR="2.06////"_$P(VAOA(5),U,1)_";2.07////"_$P(VAOA(11),U,1)_";2.08///"_$E(VAOA(8),1,15)_";2.11////"_IBEMPST D ^DIE
 Q
 ;
