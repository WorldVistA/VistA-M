IBCNEQU ;DAOU/BHS - eIV REQUEST ELECTRONIC INSURANCE INQUIRY ;24-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; Must call from EN
 Q
 ;
EN ; Entry pt
 ; Init vars
 N DFN,X,POP,IBFASTXT,VALMCNT,VALMBG,VALMHDR,VALMBCK,IDUZ
 ;
EN1 I $G(IBFASTXT) G ENX
 S DFN=$$PAT I 'DFN G ENX
 D EN^VALM("IBCNE REQUEST INS INQUIRY LIST")
 G EN1
 ;
ENX ; EN exit pt
 Q
 ;
INIT ; -- set up initial variables
 S VALMCNT=0,VALMBG=1,IDUZ=DUZ
 K ^TMP("IBCNEQU",$J),^TMP("IBCNEQUX",$J)
 D HDR
 D BLD(DFN)
 ;
INITX ; INIT exit pt
 Q
 ;
HDR ; -- screen header for initial screen
 N VA,VAERR,%DT,II
 D PID^VADPT
 S VALMHDR(1)="Request Electronic Insurance Inquiry for Patient: "_$E($P($G(^DPT(DFN,0)),U),1,20)_" "_$E($G(^(0)),1)_VA("BID")
 S VALMHDR(2)=" "
 S VALMHDR(3)=" "
 S II=1
 I +$$BUFFER^IBCNBU1(DFN) S II=II+1,VALMHDR(II)="*** Patient has Insurance Buffer Records"
 I $P($G(^DPT(DFN,.35)),U)'="" S II=II+1,VALMHDR(II)="*** Date of Death: "_$$FMTE^XLFDT($P($G(^DPT(DFN,.35)),U)\1,"5Z")
 Q
 ;
HELP ; -- help code
 D FULL^VALM1
 W @IOF
 W !,"This screen lists all eligible (non-Medicaid) Insurance policies"
 W !,"for the patient.  Selecting an entry in this list creates an Insurance Buffer"
 W !,"entry with Source 'eIV' and Override Freshness Flag 'Yes'.  Setting this flag"
 W !,"is designed to force the eIV extract to attempt to create an insurance"
 W !,"inquiry based on this entry."
 W !!,"Entries with an asterisk (*) preceding the Insurance Co name already exist in"
 W !,"the Insurance Buffer with the exact same name, the exact same Group Number,"
 W !,"and the Override Freshness Flag set to 'Yes'.  Selecting an entry with an"
 W !,"asterisk (*) will create a duplicate entry in the Insurance Buffer file for"
 W !,"the patient."
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCNEQU",$J),^TMP("IBCNEQUX",$J)
 Q
 ;
PAT() ; Prompt user to select a patient
 ; Init vars
 N DIC,X,Y,DISYS,%H,%I,DUOUT,DTOUT
 ;
 W !
 ; Exclude non-Veterans
 S DIC(0)="AEQMN"
 S DIC("S")="I $G(^(""VET""))=""Y"",('$P($G(^(0)),U,21))",DIC="^DPT("
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y<1) Q ""
 ;
 Q +Y
 ;
BLD(DFN) ; Build list of all insurance for patient
 N IBCT,IBINS,IBDATA0,IBDATA1,IBDATA2,II,STR,IBINSIEN,IBINAME,IBHOLD
 N VNODT,X,POP,IBBUF,IBBUFNM,IBIEN,IBBUFDT,TMPNM,GRPNUM,SFANAME
 ;
 K ^TMP("IBCNEQU",$J),^TMP("IBCNEQUX",$J)
 ;
 S (IBCT,VALMCNT)=0
 ;
 ; Determine if buffer entries exist for this DFN and build array by name
 S IBIEN=0
 F  S IBIEN=$O(^IBA(355.33,"C",DFN,IBIEN)) Q:'IBIEN  D
 . S IBBUFDT=$G(^IBA(355.33,IBIEN,0))
 . ; Include E status and those with Override Freshness Flags = 1
 . I $P(IBBUFDT,U,4)'="E"!('$P(IBBUFDT,U,13)) Q
 . S IBBUFNM=$$TRIM^XLFSTR($P($G(^IBA(355.33,IBIEN,20)),U))
 . I IBBUFNM="" Q
 . S GRPNUM=$$TRIM^XLFSTR($P($G(^IBA(355.33,IBIEN,40)),U,3))
 . S IBBUF(IBBUFNM," "_GRPNUM)=""
 . Q
 ;
 ; Populate IBINS array with Patient Insurance records
 D ALL^IBCNS1(DFN,"IBINS")
 I $G(IBINS(0)) S II=0 F  S II=$O(IBINS(II)) Q:'II  D
 . S IBDATA0=$G(IBINS(II,0))
 . S IBDATA1=$G(IBINS(II,1))
 . S IBDATA2=$G(^IBA(355.3,+$P(IBDATA0,U,18),0))
 . S GRPNUM=$$TRIM^XLFSTR($P(IBDATA2,U,4))
 . S IBINSIEN=+$P(IBDATA0,U)
 . Q:'IBINSIEN!'$D(^DIC(36,IBINSIEN,0))
 . S IBINAME=$P($G(^DIC(36,IBINSIEN,0)),U)
 . S TMPNM=$$TRIM^XLFSTR(IBINAME)
 . ; Filter Ins Co's by name - currently filter Medicaid
 . I $$EXCLUDE^IBCNEUT4(TMPNM) Q
 . S IBCT=IBCT+1
 . S STR=""
 . S STR=$$SETFLD^VALM1(IBCT,STR,"NUMBER")
 . ; Update IBINAME if found in buffer already
 . S IBINAME=$S($D(IBBUF(TMPNM," "_GRPNUM)):"*",1:"")_IBINAME
 . S STR=$$SETFLD^VALM1(IBINAME,STR,"NAME")
 . S STR=$$SETFLD^VALM1($E($P(IBDATA0,U,2),1,14),STR,"POLICY")
 . S IBHOLD=$P(IBDATA0,U,6),STR=$$SETFLD^VALM1($S(IBHOLD="v":"SELF",IBHOLD="s":"SPOUSE",IBHOLD="o":"OTHER",1:"UNKNOWN"),STR,"HOLDER")
 . S STR=$$SETFLD^VALM1($E($$GRP^IBCNS($P(IBDATA0,U,18)),1,10),STR,"GROUP")
 . S STR=$$SETFLD^VALM1($$FMTE^XLFDT($P(IBDATA0,U,8),"5Z"),STR,"EFFDT")
 . S STR=$$SETFLD^VALM1($$FMTE^XLFDT($P(IBDATA0,U,4),"5Z"),STR,"EXPIRE")
 . S STR=$$SETFLD^VALM1($E($P($G(^IBE(355.1,+$P(IBDATA2,U,9),0)),U),1,8),STR,"TYPE")
 . S STR=$$SETFLD^VALM1($P($G(^IBE(355.1,+$P(IBDATA2,U,9),0)),U),STR,"TYPEPOL")
 . S STR=$$SETFLD^VALM1($E($P($G(^VA(200,+$P(IBDATA1,U,4),0)),U),1,15),STR,"VERIFIED BY")
 . S STR=$$SETFLD^VALM1($$FMTE^XLFDT($P(IBDATA1,U,3),"5Z"),STR,"VERIFIED ON")
 . S STR=$$SETFLD^VALM1($$YN($P(IBDATA2,U,6)),STR,"PRECERT")
 . S STR=$$SETFLD^VALM1($$YN($P(IBDATA2,U,5)),STR,"UR")
 . S STR=$$SETFLD^VALM1($$YN($P(IBDATA0,U,20)),STR,"COB")
 . D SET(STR)
 . Q
 ;
 I 'IBCT D
 . S VALMCNT=VALMCNT+1
 . S ^TMP("IBCNEQU",$J,VALMCNT,0)=" "
 . S VALMCNT=VALMCNT+1
 . S ^TMP("IBCNEQU",$J,VALMCNT,0)="      No eligible insurance policies found."
 . Q
 ;
 S VNODT=$P($G(^IBA(354,DFN,60)),U,1) I VNODT D
 . S VALMCNT=VALMCNT+1
 . S ^TMP("IBCNEQU",$J,VALMCNT,0)=" "
 . S VALMCNT=VALMCNT+1
 . S ^TMP("IBCNEQU",$J,VALMCNT,0)="      Verification of No Coverage "_$$FMTE^XLFDT(VNODT,"5Z")_"."
 . Q
 ;
BLDX ; BLD exit pt
 Q
 ;
SET(LINE) ; -- set arrays
 ; LINE - line of text to display
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCNEQU",$J,VALMCNT,0)=LINE
 S ^TMP("IBCNEQU",$J,"IDX",VALMCNT,IBCT)=""
 S ^TMP("IBCNEQUX",$J,IBCT)=VALMCNT_U_DFN_U_II_U_IBINAME_U_IBDATA0
 S ^TMP("IBCNEQUX",$J)=$G(^TMP("IBCNEQUX",$J))+1
 Q
 ;
YN(X) ; -- convert 1 or 0 to yes/no/unknown
 Q $S(X=0:"NO",X=1:"YES",1:"UNK")
 ;
SELECT ; User selects insurance from list to be reconfirmed
 N IBDATA,IBDPT,IBDA,DIR,X,Y,D0,DG,DIC,DISYS,DIW,IENS,IBERROR,IBIEN,IBSYM
 ;
 D FULL^VALM1
 S VALMBCK="R"
 ;
 I '$O(^TMP("IBCNEQUX",$J,0)) D  G SELECTX
 . W !!,"No Insurance policies to select."
 . S DIR(0)="E" D ^DIR K DIR
 . Q
 ;
 S (IBDPT,IBDA,IBERROR)=""
 S IBDATA=$$SEL
 S IBDPT=+$P(IBDATA,U)       ; Patient DFN
 S IBDA=+$P(IBDATA,U,2)      ; 2.312 ptr
 I +IBDPT,+IBDA D
 . S IBIEN=+$P(IBDATA,U,4)     ; Ins Co IEN (#36)
 . S IBSYM=+$$INSERROR^IBCNEUT3("I",IBIEN)
 . D PT^IBCNEBF(IBDPT,IBDA,IBSYM,1,1,.IBERROR)
 . ; Check for errors
 . I $G(IBERROR)'="" W !!,"Insurance Buffer entry could not be created due to error!  Please try again.",!
 . I $G(IBERROR)="" W !!,"Insurance Buffer entry created!",!
 . S DIR(0)="E" D ^DIR K DIR
 ;
 I $P(IBDATA,U,3)="~NO PAYER" D
 . W !!,"Payer missing. Identification inquiries not allowed."    ; IB*2*416
 . S DIR(0)="E" D ^DIR K DIR
 . Q
 ;
SELECTX ;
 S VALMBCK="R"
 Q
 ;
SEL() ; User selects insurance from list
 N IBSELN,DIR,X,Y,DIRUT,DUOUT
 ;
 S IBSELN=""
 ; Select entry to reconfirm
 S DIR(0)="NO^1:"_$G(^TMP("IBCNEQUX",$J))_":0"
 S DIR("A")="Select entry to request electronic inquiry"
 S DIR("?",1)="  Select an entry to initiate an insurance inquiry."
 S DIR("?",2)="  If entry contains an Insurance Co name, an Insurance"
 S DIR("?",3)="  Buffer entry will be created for nightly batch extract."
 S DIR("?")="  "
 D ^DIR K DIR
 I $D(DIRUT)!$D(DUOUT)!(Y<1) G SELX
 S IBSELN=$O(^TMP("IBCNEQU",$J,"IDX",Y,0))
 I IBSELN S IBSELN=$P($G(^TMP("IBCNEQUX",$J,IBSELN)),U,2,99)
 I $E($P(IBSELN,U,3))="*" W !!,"Selecting this entry will create a duplicate entry in the Insurance Buffer."
 ;
 W !
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to request an insurance inquiry"
 S DIR("B")="NO"
 S DIR("?",1)="  If yes, a request will be created for the nightly batch."
 D ^DIR K DIR
 I $D(DIRUT)!$D(DUOUT)!('Y) S IBSELN=""
 ;
SELX Q IBSELN
 ;
FASTEXIT ; Sets flag to indicate a quick exit from the option
 N DIR,DIRUT,X,Y
 S VALMBCK="Q"
 D FULL^VALM1
 S DIR(0)="Y",DIR("A")="Exit option entirely",DIR("B")="NO"
 D ^DIR
 I +Y S IBFASTXT=1
 Q
 ;
ADD() ;
 NEW PAYER,TQIEN,OK,STR,SRVICEDT,FRESHDT,DATA1,DATA2,TQIEN,FRESHDAY
 I '$D(^IBCN(365.1,"E",DFN)) Q 0  ; Does this pt have a TQ entry?
 S (TQIEN,OK)=""
 S PAYER=$$FIND1^DIC(365.12,,"X","~NO PAYER") ; Get payer IEN
 F  S TQIEN=$O(^IBCN(365.1,"E",DFN,TQIEN)) Q:'TQIEN!OK  D
 . S STR=$G(^IBCN(365.1,TQIEN,0))
 . ; If "~NO PAYER" & Transmitted
 . I $P(STR,U,3)=PAYER,$P(STR,U,4)=2 S OK=1 Q
 . ; If "~NO PAYER" & Ready to Transmit & override flag
 . I $P(STR,U,3)=PAYER,($P(STR,U,4)=1),($P(STR,U,14)=1) S OK=1 Q
 I 'OK Q 0
 Q 1
 ;
BLKTQ ;  Create a ~NO PAYER request for 'Search for All'
 Q    ; no longer allowed  IB*2*416
 NEW PAYER,SRVICEDT,FRESHDT,DATA1,DATA2,TQIEN,FRESHDAY
 S PAYER=$$FIND1^DIC(365.12,,"X","~NO PAYER")
 D NPINIT ; Update service date and freshness
 ; Update service dates for inquiries to be transmitted
 S DATA1=DFN_U_PAYER_U_1_U_""_U_""_U_FRESHDT
 S DATA2=4_U_"I"_U_SRVICEDT
 S TQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2,"",1)
 Q
 ;
BLKX Q
 ;
NPINIT ; Initialize variables for ~NO PAYER
 S SRVICEDT=DT
 S FRESHDAY=$P($G(^IBE(350.9,1,51)),U)
 S FRESHDT=$$FMADD^XLFDT(SRVICEDT,-FRESHDAY)
 ;
 ; Update service date and freshness date based on payer allowed
 Q
