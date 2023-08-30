IBCNEQU ;DAOU/BHS - eIV REQUEST ELECTRONIC INSURANCE INQUIRY ; 24-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416,438,497,582,601,631,668,702,732,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; Must call from EN
 ;
 ; IB*737/TAZ - Remove References to ~NO PAYER
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
 K ^TMP("IBCNEQU",$J),^TMP("IBCNEQUX",$J),^TMP("IBCNEQUDTS",$J)
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
 W !,"When requesting an Electronic Insurance Inquiry..." ; IB*2*601/DM
 W !,"This screen lists all eligible (non-Medicaid) Insurance policies for the"
 W !,"patient. Selecting an entry here creates an Insurance Buffer entry with Source"
 W !,"'eIV' and Override Freshness Flag 'Yes'. Setting this flag is designed to force"
 W !,"the eIV extract to attempt to create an insurance inquiry based on this entry."
 W !!,"Entries with an asterisk (*) preceding the Insurance Co name already exist in"
 W !,"the Insurance Buffer with the exact same name, the exact same Group Number,"
 W !,"and the Override Freshness Flag set to 'Yes'."
 ; IB*2*601/DM
 W !!,"When requesting a MBI lookup..."
 W !,"Policies will be listed as described above for electronic insurance inquiry;"
 W !,"however, no special 'checks' will be made. The MBI request will be initiated "
 W !,"immediately, regardless of policies above and resulting buffer entry will have"
 W !,"source 'Medicare'."
 ; IB*2*702/TAZ - Added following lines
 W !!,"When initiating an EICD Request..."
 W !,"An EICD request will be initiated if the following conditions are met:"
 W !," - The patient does not have active insurance on file."
 W !," - The patient does not have an eligibility exclusion."
 W !," - There have been no other recent EICD requests."
 W !
 ;
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
 . ; Include E status only
 . I $P(IBBUFDT,U,4)'="E" Q
 . S IBBUFNM=$$TRIM^XLFSTR($P($G(^IBA(355.33,IBIEN,20)),U))
 . I IBBUFNM="" Q
 . ;S GRPNUM=$$TRIM^XLFSTR($P($G(^IBA(355.33,IBIEN,40)),U,3))
 . S GRPNUM=$$TRIM^XLFSTR($P($G(^IBA(355.33,IBIEN,90)),U,2))  ; ib*2*497  get group number from it's new location
 . S IBBUF(IBBUFNM," "_GRPNUM)=""
 . Q
 ;
 ; Populate IBINS array with Patient Insurance records
 D ALL^IBCNS1(DFN,"IBINS")
 I $G(IBINS(0)) S II=0 F  S II=$O(IBINS(II)) Q:'II  D
 . S IBDATA0=$G(IBINS(II,0))
 . S IBDATA1=$G(IBINS(II,1))
 . S IBDATA2=$G(^IBA(355.3,+$P(IBDATA0,U,18),0))
 . S GRPNUM=$$TRIM^XLFSTR($P($G(^IBA(355.3,+$P(IBDATA0,U,18),2)),U,2))  ; ib*2*497  get group number from it's new location
 . ;S GRPNUM=$$TRIM^XLFSTR($P(GRPNUM,U,2))
 . ;S GRPNUM=$$TRIM^XLFSTR($P(IBDATA2,U,4))
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
 N IBDATA,IBDPT,IBDA,DIR,X,Y,D0,DG,DIC,DISYS,DIW,IENS,IBELIGDT,IBERROR,IBIEN,IBSYM
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
 S IBDATA=$$SEL()
 S IBDPT=+$P(IBDATA,U)       ; Patient DFN
 S IBDA=+$P(IBDATA,U,2)      ; 2.312 ptr
 I +IBDPT,+IBDA D
 . S IBIEN=+$P(IBDATA,U,4)     ; Ins Co IEN (#36)
 . S IBSYM=$P($$INSERROR^IBCNEUT3("I",IBIEN),"^",1)
 . S ^TMP("IBCNEQUDTS",$J)=1
 . D PT^IBCNEBF(IBDPT,IBDA,IBSYM,1,1,.IBERROR)
 . ; Check for errors
 . I $G(IBERROR)'="" W !!,"Insurance Buffer entry could not be created due to error!  Please try again.",!
 . I $G(IBERROR)="" W !!,"Insurance Buffer entry created!",!
 . S DIR(0)="E" D ^DIR K DIR
 . K ^TMP("IBCNEQUDTS",$J)
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
 I $E($P(IBSELN,U,3))="*" W ! D  S IBSELN="" G SELX
 .S DIR(0)="EA"
 .S DIR("A",1)=""
 .S DIR("A",2)="Selected policy has an existing buffer entry."
 .S DIR("A",3)="You must first process the existing buffer entry."
 .S DIR("A")="Press RETURN to continue " D ^DIR K DIR W !
 .Q
 ;
 ; Get service type code
 D STC
 I X="^" S IBSELN="" G SELX  ; '^' entered thus backup a level & re-ask Insurance question
 ; Get eligibility date
 S IBELIGDT=$$ELIGDT() I 'IBELIGDT S IBSELN="" G SELX
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
STC ; Ask for service type code to send
 ; IB*582/HN - Modified Default Service Type Code to pull from the MCCF Billing Parameters File (350.9,60.01)
 N DIR,X,Y
 ; IBEISTC used as STC variable
 S IBEISTC=""
 S DIR(0)="PAO^365.013:EMZ",DIR("A")="Enter Service Type Code: "
 S DIR("B")=$$GET1^DIQ(350.9,1_",",60.01,"E")
 S DIR("??")="^D HELPSTC2^IBCNEQU"
STCEN ; Intital and re-enterant tag upon error
 D ^DIR Q:X="^"
 ; Check to verify code is active, if not, display error and ask again
 I $P($G(Y(0)),U,3)'="" W !,"Code selected is not an active code - please select another code.",! G STCEN
 ; If valid STC entered, set IBEISTC to be STC IEN. If no code entered, default to service code 30
 ;S IBEISTC=$S(+Y>0:$P(Y,U,1),1:$O(^IBE(365.013,"B",30,"")))
 ; If valid STC entered, set IBEISTC to be STCIEN.
 S IBEISTC=$P(Y,U,1)
 Q
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
HELPSTC2 ; Text to display in response to '??' entry
 N DIR
 D FULL^VALM1
 W @IOF
 ;IB*732/DTG start - change help text to reflect code is dictionary driven
 W !,"Enter the single SERVICE TYPE CODE to be sent with inquiry or press"
 W !,"'ENTER' to send default service type code. The default service type"
 W !,"code may auto-update. All other service types will not auto-update."
 ;IB*732/DTG end - change help text to reflect code is dictionary driven
 Q
 ;
ELIGDT() ; Prompt user for eligibility date
 N DIR,X,Y,DIRUT,DUOUT,STARTDT,ENDDT,ELIGDT
 S ELIGDT=""
 D DT^DILF(,"T-12M",.STARTDT) ; start date within the last 12 months
 ; allow end date up to the end of the current month
 S ENDDT=$$SCH^XLFDT("1M(L@1A)",DT)\1 ; ICR#10103 this call returns the last day of the current month at 1 AM.  If not time was sent, it would actually return the next to last day at 2400 hours.
 S DIR(0)="DA^"_STARTDT_":"_ENDDT_":"_"EX",DIR("A")="Enter Eligibility Date: ",DIR("B")="TODAY"
 S DIR("?",1)="Select an eligibility date to be sent in the inquiry."
 S DIR("?")="Date must be within the last 12 months or up to the end of the current month."
 D ^DIR
 I $D(DIRUT)!$D(DUOUT)!('Y) G ELIGDTX
 S ELIGDT=Y
ELIGDTX ; 
 Q ELIGDT
 ;
MBIREQ ; User requested a MBI lookup request
 ;/vd-IB*2*668 - Added the variable APIEN
 N APIEN,DIR,X,Y,DIRUT,DUOUT
 N IBMBIPYR,IBBUF,IBFDA
 ;
 D FULL^VALM1
 S VALMBCK="R"
 K DIR
 ;
 ; see if the MBI PAYER site parameter has been populated 
 S IBMBIPYR=+$$GET1^DIQ(350.9,"1,","MBI PAYER","I")
 I 'IBMBIPYR D  G MBIREQX
 . W !!," The required MBI Payer site parameter is not populated; try again later",!
 . S DIR(0)="E" D ^DIR K DIR
 ;
 S APIEN=$$PYRAPP^IBCNEUT5("EIV",IBMBIPYR)   ;/vd-IB*2*668
 ;/vd-IB*2*668 - Replaced the following 2 lines of code to remove a hardcoded value.
 ;I '($$GET1^DIQ(365.121,"1,"_IBMBIPYR_",",.02,"I")) D  G MBIREQX
 ;. W !!," The MBI Payer is not nationally active; try again later",!
 I '($$GET1^DIQ(365.121,APIEN_","_IBMBIPYR_",",.02,"I")) D  G MBIREQX
 . W !!," The MBI Payer is not NATIONALLY Enabled; try again later",!
 . S DIR(0)="E" D ^DIR K DIR
 ;
 ;/vd-IB*2*668 - Replaced the following 2 lines of code to remove a hardcoded value.
 ;I '($$GET1^DIQ(365.121,"1,"_IBMBIPYR_",",.03,"I")) D  G MBIREQX
 ;. W !!," The MBI Payer LOCAL ACTIVE field is set to 'NO'; it must be 'YES' to proceed",!
 I '($$GET1^DIQ(365.121,APIEN_","_IBMBIPYR_",",.03,"I")) D  G MBIREQX
 . W !!," The MBI Payer is not LOCALLY Enabled; try again later",!
 . S DIR(0)="E" D ^DIR K DIR
 ;
 D DEM^VADPT ; ; ICR#10061
 I ($P(VADM(2),U)="")!($P(VADM(3),U)="") D  G MBIREQX
 . W !!," SSN and DOB are required fields, they must be populated in order to proceed",!
 . S DIR(0)="E" D ^DIR K DIR
 ; 
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to request this Patient's Medicare Beneficiary ID"
 S DIR("B")="YES"
 S DIR("?",1)="  If yes, a MBI request will be initiated immediately."
 S DIR("?")="  If no, the MBI request will be cancelled."
 D ^DIR K DIR
 I $D(DIRUT)!$D(DUOUT)!('Y) G MBIREQX
 ;
 ;write a buffer entry 
 ;the real time process will set the patient relationship to self automatically
 ;patient fields, name, dob and ssn will be populated automatically
 K IBBUF
 S IBBUF(.02)=DUZ  ; Entered By
 S IBBUF(.12)=$P($$PAYER^IBCNEUT4(IBMBIPYR),U) ; Buffer Symbol 
 S IBBUF(20.01)=$$GET1^DIQ(350.9,"1,","MBI PAYER","E")
 S IBBUF(60.01)=DFN ; Patient IEN
 S IBBUF(90.03)="MBIrequest" ; MBI placeholder for subscriber ID
 S IBBUF(91.01)=VADM(1) ; patient (subscriber) name 
 ; the following call in-turn, calls EDITSTF^IBCNBES which will make sure to file subscriber ID last, automatically
 S IBFDA=$$ADDSTF^IBCNBES($$FIND1^DIC(355.12,,,"MEDICARE","C"),DFN,.IBBUF)
 ;
 W !!,"The MBI request was successful, check the buffer for results.",!
 S DIR(0)="E" D ^DIR K DIR
 S VALMBCK="Q"
 Q
MBIREQX ;
 S VALMBCK="R"
 Q
 ;
