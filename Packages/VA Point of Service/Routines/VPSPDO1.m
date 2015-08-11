VPSPDO1 ;DALOI/KML,WOIFO/BT -  PDO OUTPUT DISPLAY - ALLERGIES ;11/20/11 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Oct 21, 2011;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;IA #10103 - supported use of XLFDT functions
 ;IA #10104 - supported use of XLFSTR function
 ;
 ; The VPSPDO* procedures produce 2 separate displays of the PDO output 
 ; which are the  PATIENT ENTERED ALLERGY MEDICATION REVIEW and the PATIENT FACILITATED ALLERGY MEDICATION REVIEW
 ; which can be invoked by CPRS TIU components and as an RPC to be called by Vetlink staff-facing interface 
 ; the GET procedure below determines which version of the PDO output to display
 ;
GET(PDO,VPSNUM,VPSTYP) ; RPC: VPS GET MRAR PDO
 ; INPUT
 ;   PDO    : the name of global array where each line of the MRAR output will be stored  (e.g., "^TMP(""VPSPDO1"",$J)"
 ;   VPSNUM : Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSTYP : Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ; OUTPUT
 ;   PDO    : the name of global array where each line of the MRAR output will be stored
 ;
 ;Store Displayed MRAR data into global array PDO
 S PDO=$NA(^TMP("VPSPDO1",$J))
 K @PDO
 S VPSNUM=$G(VPSNUM)
 S VPSTYP=$G(VPSTYP)
 N VPSDFN S VPSDFN=$$VALIDATE^VPSRPC1(VPSTYP,VPSNUM)
 I VPSDFN<1 S @PDO@(1,0)=$P(VPSDFN,U,2)
 I VPSDFN>0 D GETPDO(VPSDFN,PDO)
 Q
 ;
TIU(PTIEN,PDOARY) ;TIU DOCUMENT: |VPS MRAR PDO|
 ; TIU OBJECT : S X=$$TIU^VPSPDO1(DFN,"^TMP(""VPSPDO1"",$J)")
 ;
 ; INPUT
 ;   PTIEN  : PATIENT DFN
 ;   PDOARY : the name of global array where each line of the TIU will be stored
 ;
 ;Store Displayed MRAR data into global array where the name is assigned to PDOARY (eg: "^TMP(""VPSPDO1"",$J)")
 D GETPDO(PTIEN,PDOARY)
 Q "~@"_$NA(@PDOARY)
 ;
GETPDO(PTIEN,PDOARY) ;
 ; INPUT
 ;   PTIEN  : PATIENT DFN
 ;   PDOARY : the name of global array where each line of the TIU will be stored
 ;
 ; -- create VPS pdo object
 N PDOOREF S PDOOREF=$$NEW^VPSOBJ(PTIEN,PDOARY)
 ;
 ; -- initialize PDO object with date of Last Mrar and Staff flag
 Q:'$$INITPDO(PDOOREF)
 ;
 ; -- Okay to Invoke PDO ?
 Q:'$$OKINVK(PDOOREF)
 ; 
 ; -- date/time stamp the PDO FIRST INVOKED or PDO INVOKED DT field
 Q:'$$UPDINVK(PDOOREF,$$NOW^XLFDT())
 ;
 ; -- Generate PDO in temp global
 D START(PDOOREF)
 ;
 ; -- clean up PDO object
 D CLOSE^VPSOBJ(PDOOREF)
 Q
 ;
INITPDO(OREF) ; initialize PDO object with date of LAST MRAR, STAFF flag
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ; RETURN
 ;   1 if successfull otherwise 0
 ;
 ; -- validate patient MRAR
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 I 'PTIEN D SETERR^VPSOBJ(OREF,"Invalid Patient IEN") Q 0
 I '$D(^VPS(853.5,PTIEN)) D SETERR^VPSOBJ(OREF,"This patient has no MRAR data.") Q 0
 ;
 N LASTMRAR S LASTMRAR=$O(^VPS(853.5,PTIEN,"MRAR","B",""),-1)
 I 'LASTMRAR D SETERR^VPSOBJ(OREF,"This patient has no MRAR transaction.") Q 0
 ;
 ; -- set last mrar
 D SETLSTMR^VPSOBJ(OREF,LASTMRAR)
 ;
 ; -- If field .13 (Interface module = "S" then data comes from staff-facing interfacing otherwise from patient-facing (kiosk))
 N STAFF S STAFF=$S($$GET1^DIQ(853.51,LASTMRAR_","_PTIEN_",",.13,"I")="S":1,1:0)
 D SETSTAFF^VPSOBJ(OREF,STAFF)
 ;
 Q (LASTMRAR>0)
 ;
OKINVK(OREF) ;Okay to Invoke PDO ?
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ; RETURN
 ;   1 if successfull otherwise 0
 ;
 ; -- get the PDO invocable period
 N PERIOD S PERIOD=$$GETINVPR(OREF)
 Q:'PERIOD 0
 ;
 ; -- how old is the last mrar
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 N TRNDT S TRNDT=$$DT^XLFDT() ; IA #10103
 N AGE S AGE=$$FMDIFF^XLFDT(TRNDT,$P(LASTMRAR,"."),1)
 ;
 ; -- okay if the last mrar in the invocable period
 Q 1
 N OK S OK=(AGE'>PERIOD)
 I 'OK D SETERR^VPSOBJ(OREF,"The last MRAR for this patient is too old. Last MRAR Date = "_$$FMTE^XLFDT(LASTMRAR,5)_". PDO Invocable Period = "_PERIOD)
 Q OK
 ;
GETINVPR(OREF) ;get the PDO invocable period
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ; RETURN
 ;   PDO invocable period if successfull otherwise 0
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 ; -- Check make sure last mrar transaction contain either Kiosk Group or Clinic.
 ;    These values will be used to retrieve the invocable period in file 853
 N KIOSKGRP S KIOSKGRP=$$GET1^DIQ(853.51,LASTMRAR_","_PTIEN_",",.03,"I")
 N CLINIC S CLINIC=$$GET1^DIQ(853.51,LASTMRAR_","_PTIEN_",",.04,"I")
 N NOREQFLD S NOREQFLD=(KIOSKGRP="")&(CLINIC="")
 I NOREQFLD D SETERR^VPSOBJ(OREF,"The last MRAR for this patient has undefined Kiosk Group and undefined Clinic. Either Kiosk Group or Clinic must exist")
 Q:NOREQFLD 0
 ;
 ; -- Get invocable period based on Kiosk Group and/or CLinic
 N KGPER,KGTRXDT S KGPER=$$GETPER("D",KIOSKGRP,.KGTRXDT)
 N CLPER,CLTRXDT S CLPER=$$GETPER("C",CLINIC,.CLTRXDT)
 ;
 ; -- Get the period that was set last (most current)
 N PERIOD S PERIOD=$S(KGTRXDT>CLTRXDT:KGPER,1:CLPER)
 S:'PERIOD PERIOD=3 ; default is 3 days
 Q PERIOD
 ;
GETPER(IDX,VAL,PRMTRXDT) ;Get invocable period based on Kiosk Group and/or CLinic
 ; INPUT
 ;   IDX      : Index name to get the IEN of Kiosk Group or Clinic in File 853
 ;   VAL      : either the Kiosk group or the Clinic IEN
 ; OUTPUT
 ;   PRMTRXDT : The last transaction date in file 853 that contains Invocable period
 ; RETURN
 ;   Invocable Period
 ;
 S PRMTRXDT=0
 N PERIOD S PERIOD=0
 ; KDC 10/31/2014
 I IDX=""!(VAL="") Q PERIOD
 N PRMIEN S PRMIEN=$O(^VPS(853,IDX,VAL,0))
 Q:'PRMIEN PERIOD
 ;
 S PRMTRXDT=99999999
 F  S PRMTRXDT=$O(^VPS(853,PRMIEN,"PARAM",PRMTRXDT),-1) Q:'PRMTRXDT  D  Q:PERIOD
 . S PERIOD=$P($G(^VPS(853,PRMIEN,"PARAM",PRMTRXDT,1)),U)
 S:PRMTRXDT=99999999 PRMTRXDT=0
 Q PERIOD
 ;
UPDINVK(OREF,DTSTAMP) ;update the PDO FIRST INVOKED or PDO INVOKED DT field
 ; INPUT
 ;   OREF    : Object Reference for the VPS PDO object
 ;   DTSTAMP : Date/Time Stamp the PDO FIRST INVOKED or PDO INVOKED DT field
 ; RETURN
 ;   1 if successfull otherwise 0
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 ;
 ; -- Get First Invoked Date
 N FINVKDT S FINVKDT=$$GET1^DIQ(853.51,LASTMRAR_","_PTIEN_",",70,"I")
 ;
 ; -- if PDO FIRST INVOKED doesn't exist set it otherwise set the PDO NEXT INVOKED
 N VPSFDA,VPSERR
 I FINVKDT="" S VPSFDA(853.51,LASTMRAR_","_PTIEN_",",70)=DTSTAMP
 I FINVKDT'="" S VPSFDA(853.51,LASTMRAR_","_PTIEN_",",73)=DTSTAMP
 D FILE^DIE("","VPSFDA","VPSERR")
 Q:'$D(VPSERR) 1
 ;
 ; -- filing error
 N ERRNUM S ERRNUM=$O(VPSERR("DIERR",0))
 D SETERR^VPSOBJ(OREF,VPSERR("DIERR",ERRNUM,"TEXT",1))
 Q 0
 ;
START(OREF) ;allergy and medications section of the PDO output specifically for the PATIENT ENTERED ALLERGY MEDICATION REVIEW
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 ; -- Header lines
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 D HDR(OREF)
 ;
 ; -- Review conducted with lines
 D:STAFF CNDWTH(OREF)
 ;
 ; -- Allergies section
 D ADDCJ^VPSOBJ(OREF,"***   ALLERGIES   ***   ALLERGIES   ***")
 D ALRLOCAL(OREF) ; build local vista allergy
 D ALRREMTE(OREF) ; build remote (cdw) allergy
 D ADDALLER(OREF) ; build additional allergy
 D GETCH^VPSPDO2(OREF) ; build allergy changes since last mrar
 ;
 ; -- MEDICATIONS Section
 N MEDITMS ; array represents the list of medications - built by MEDS and used by MEDCHNG to display only the changes
 D MEDHDR^VPSPDO1M(OREF) ; build medication header section
 D MEDS^VPSPDO1M(OREF,.MEDITMS) ; build medication section
 D ADDMEDS^VPSPDO3M(OREF) ; build additional medication section
 D MEDCHNG^VPSPDO2M(OREF,.MEDITMS) ; build Medication Changes Since section
 Q
 ; 
HDR(OREF) ; produce TIU Note header lines
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 I 'STAFF D ADDLJ^VPSOBJ(OREF,"Patient Entered Allergy Medication Review : "_$$FMTE^XLFDT(LMRARDT))
 I STAFF D ADDLJ^VPSOBJ(OREF,"PATIENT FACILITATED ALLERGY MEDICATION REVIEW: "_$$FMTE^XLFDT(LMRARDT))
 D ADDUNDLN^VPSOBJ(OREF)
 Q
 ;
CNDWTH(OREF) ; produce Review conducted with lines
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 ; join conducted with items into a string
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 ;
 N STRING S STRING=""
 N CNDWTH S CNDWTH=0
 ;
 F  S CNDWTH=$O(^VPS(853.5,PTIEN,"MRAR",LASTMRAR,"MRARWITH",CNDWTH)) Q:'CNDWTH  D
 . S STRING=STRING_$$GET1^DIQ(853.5121,CNDWTH_","_LASTMRAR_","_PTIEN_",",.01,"E")_", "
 S:STRING'="" STRING=$E(STRING,1,$L(STRING)-2)
 ;
 ; display conducted with line
 D ADDLJ^VPSOBJ(OREF,"REVIEW CONDUCTED WITH: "_STRING)
 D ADDUNDLN^VPSOBJ(OREF)
 Q
 ;
ALRLOCAL(OREF) ;produce local allergy section
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 ;
 N BL F BL=1:1:2 D ADDBLANK^VPSOBJ(OREF)
 N LOCAL S LOCAL=$D(^VPS(853.5,PTIEN,"MRAR",LASTMRAR,"ALLERGY","LOCAL"))
 I LOCAL D
 . D ADDLJ^VPSOBJ(OREF,"Allergy Response Key")
 . D ADDLJ^VPSOBJ(OREF,"Y = Allergic")
 . D ADDLJ^VPSOBJ(OREF,"N = Not Allergic")
 . D ADDLJ^VPSOBJ(OREF,"? = Unsure")
 . D ADDLJ^VPSOBJ(OREF,"X = No Response (incomplete session/no answer)")
 . N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 . I STAFF D ADDLJ^VPSOBJ(OREF,">> indicates MARK FOR FOLLOW UP")
 . D ADDBLANK^VPSOBJ(OREF)
 . D ADDCJ^VPSOBJ(OREF,"Local Allergies")
 . D BLD(OREF,"LOCAL")
 I 'LOCAL D
 . D ADDCJ^VPSOBJ(OREF,"Local Allergies")
 . D ADDLJ^VPSOBJ(OREF,"Patient has NKDA at this VA.")
 Q
 ;
ALRREMTE(OREF) ; produce remote allergies section
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 ;
 D ADDBLANK^VPSOBJ(OREF)
 D ADDCJ^VPSOBJ(OREF,"Remote Allergies")
 N REMOTE S REMOTE=$D(^VPS(853.5,PTIEN,"MRAR",LASTMRAR,"ALLERGY","REMOTE"))
 I REMOTE D BLD(OREF,"REMOTE")
 I 'REMOTE D 
 . D ADDLJ^VPSOBJ(OREF,"Patient has NKDA at any remote VA.")
 . D ADDBLANK^VPSOBJ(OREF)
 Q
 ;
ADDALLER(OREF) ; build additional allergies section
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 ; 
 N ALLRADD S ALLRADD=$D(^VPS(853.5,PTIEN,"MRAR",LASTMRAR,"ALLERGYADD"))
 N REMOTE S REMOTE=$D(^VPS(853.5,PTIEN,"MRAR",LASTMRAR,"ALLERGY","REMOTE"))
 N NKDA S NKDA=($$GET1^DIQ(853.51,LASTMRAR_","_PTIEN_",",20,"I"))
 N DONTKNOW S DONTKNOW=$$GET1^DIQ(853.51,LASTMRAR_","_PTIEN,19)  ; patient could have also selected the structured response, "I don't know what my other allergies are". 
 D SETDKNW^VPSOBJ(OREF,DONTKNOW)
 ;
 I ALLRADD D BLDADD^VPSPDO2(OREF) ; build additional allergies section
 I STAFF,'ALLRADD,'REMOTE,NKDA D ADDLJ^VPSOBJ(OREF,"Patient has NKDA confirmed no additional allergies present.")
 Q
 ;
BLD(OREF,TYPE) ;  build local and remote allergy sections for Patient Entered allergy medication review note
 ; INPUT:
 ;   OREF : Object Reference for the VPS PDO object
 ;   TYPE : "LOCAL" or "REMOTE"
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 ;
 N HDR S HDR=0
 N NOALLER S NOALLER=1
 N ALRID,ALRIEN S (ALRID,ALRIEN)=0
 ;
 F  S ALRID=$O(^VPS(853.5,PTIEN,"MRAR",LASTMRAR,"ALLERGY",TYPE,ALRID)) Q:'ALRID  F  S ALRIEN=$O(^(ALRID,ALRIEN)) Q:'ALRIEN  D
 . ; initialze object with allergy name, patient response, station, mark for followup
 . Q:'$$ALLRFLD(OREF,TYPE,ALRIEN)  ; quit if allergy name is null (vecna needs to send a name)
 . ;
 . S NOALLER=0 ; indicate that there is allergy
 . D BLDALR(OREF,ALRIEN,TYPE) ; build the allergy array to be used in CHANGES SINCE algorithm
 . ;
 . I 'HDR S HDR=1 D ADALHDR(OREF,TYPE) ; Add header for allergy items (do only once)
 . D ADALFLDS(OREF,TYPE) ; add other allergy fields
 ;
 I NOALLER D
 . I TYPE="LOCAL" D ADDLJ^VPSOBJ(OREF,"Patient has NKDA at this VA.")
 . I TYPE'="LOCAL" D ADDLJ^VPSOBJ(OREF,"Patient has NKDA at any remote VA.")
 Q
 ; 
ALLRFLD(OREF,TYPE,ALRIEN) ; Initialize allergy name, patient response, station, mark for followup
 ; INPUT
 ;   OREF   : Object Reference for the VPS PDO object
 ;   TYPE   : Type of Allergy data(LOCAL VISTA /REMOTE - CDW)
 ;   ALRIEN : Allergy IEN
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 ;
 ; -- Initialize allergy name
 N ALLRNM
 I TYPE="LOCAL" D
 . S ALLRNM=$$GET1^DIQ(853.52,ALRIEN_","_LASTMRAR_","_PTIEN_",",.02,"I")
 . S ALLRNM=$$GET1^DIQ(120.8,ALLRNM_",",.02,"E") ; LOCAL ALLERGY ID
 I TYPE'="LOCAL" S ALLRNM=$$GET1^DIQ(853.52,ALRIEN_","_LASTMRAR_","_PTIEN_",",.05) ; REMOTE ALLERGY NAME
 Q:ALLRNM="" 0  ; quit if allergy name is null (vecna needs to send a name)
 D SETALRNM^VPSOBJ(OREF,ALLRNM)
 ;
 ; -- Initialize Patient Response
 N PATRESP S PATRESP=$$GET1^DIQ(853.52,ALRIEN_","_LASTMRAR_","_PTIEN_",",.06,"I") ; PATIENT RESPONSE which could be "YES", "NO", "NOT SURE", "NO RESPONSE"
 S PATRESP=$S(PATRESP="U":"?",1:PATRESP)
 D SETPATRP^VPSOBJ(OREF,PATRESP)
 ;
 ; -- Initialize Station
 N STATION S STATION=$$GET1^DIQ(853.52,ALRIEN_","_LASTMRAR_","_PTIEN_",",.09,"E")
 D SETSTATN^VPSOBJ(OREF,STATION)
 ;
 ; -- Initialize Mark for follow-up
 N MARKFOL S MARKFOL=""
 I STAFF S MARKFOL=$S($$GET1^DIQ(853.52,ALRIEN_","_LASTMRAR_","_PTIEN_",",16)]"":">>",1:"")  ; mark for follow-up for patient facilitated output
 D SETMKFOL^VPSOBJ(OREF,MARKFOL)
 Q 1
 ;
BLDALR(OREF,ALRIEN,TYPE) ; build the allergy array to be used in CHANGES SINCE algorithm
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;   ALRIEN   : Allergy IEN in File 853.52
 ;   TYPE     : Type of Allergy data(LOCAL VISTA /REMOTE - CDW)
 ;
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 N ALLRNM S ALLRNM=$$GETALRNM^VPSOBJ(OREF) ;Allergy Name must exist before calling this procedure, caller will validate
 ;
 N ALLRITMS,REACT
 S ALLRITMS(ALLRNM)=""
 N REACTIEN S REACTIEN=0
 ;
 F  S REACTIEN=$O(^VPS(853.5,PTIEN,"MRAR",LASTMRAR,"ALLERGY",ALRIEN,"REACTIONS",REACTIEN)) Q:'REACTIEN  D
 . S REACT(REACTIEN)=$$GETREACT(TYPE,REACTIEN,ALRIEN,LASTMRAR,PTIEN)_" " ; get reaction name
 . S ALLRITMS(ALLRNM,REACTIEN)=REACT(REACTIEN)
 ;
 I $D(ALLRITMS(ALLRNM)) D  ; pull reaction info for this allergy
 . N COL D GETFORMT^VPSOBJ(OREF,.COL)
 . N REACTLN D REACT^VPSPUTL1(STAFF,LASTMRAR,PTIEN,ALRIEN,.COL,.REACT,.REACTLN)
 . M ALLRITMS(ALLRNM,"REACTLN")=REACTLN
 . K REACTLN
 ; 
 D SETALLR^VPSOBJ(OREF,.ALLRITMS)
 K ALLRITMS
 Q
 ;
GETREACT(TYPE,REACTIEN,ALRIEN,LASTMRAR,PTIEN) ; get reaction name
 ; INPUT
 ;   TYPE     : Type of Allergy data(LOCAL VISTA /REMOTE - CDW)
 ;   REACTIEN : Allergy Reaction IEN in File 853.57
 ;   ALRIEN   : Allergy IEN in File 853.52
 ;   LASTMRAR : Date of Last MRAR
 ;   PTIEN    : Patient DFN
 ;
 N IENS S IENS=REACTIEN_","_ALRIEN_","_LASTMRAR_","_PTIEN_","
 N REACTNM S REACTNM=""
 I TYPE="LOCAL" S REACTNM=$$GET1^DIQ(853.57,IENS,.02,"E")
 I TYPE'="LOCAL" S REACTNM=$$GET1^DIQ(853.57,IENS,.04)
 Q REACTNM
 ;
ADALHDR(OREF,TYPE) ; Add header for allergy items (do only once)
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;   TYPE : Type of Allergy data(LOCAL VISTA /REMOTE - CDW)
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N VPSX S VPSX=""
 S VPSX=$$SETFLD^VPSPUTL1("",VPSX,COL("PATRESP"))
 S VPSX=$$SETFLD^VPSPUTL1("Name",VPSX,COL("ALLERNM"))
 S VPSX=$$SETFLD^VPSPUTL1("Reaction",VPSX,COL("REACTION"))
 I TYPE="REMOTE" S VPSX=$$SETFLD^VPSPUTL1("Site",VPSX,COL("SITE"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 Q
 ;
ADALFLDS(OREF,TYPE) ; add other allergy fields
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;   TYPE : Type of Allergy data(LOCAL VISTA /REMOTE - CDW)
 ;
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 N ALRNM S ALRNM=$$GETALRNM^VPSOBJ(OREF)
 N PATRESP S PATRESP=$$GETPATRP^VPSOBJ(OREF)
 N STATION S STATION=$$GETSTATN^VPSOBJ(OREF)
 N MARKFOL S MARKFOL=$$GETMKFOL^VPSOBJ(OREF)
 N ALLR D GETALLR^VPSOBJ(OREF,.ALLR)
 N REACTLN M REACTLN=ALLR(ALRNM,"REACTLN")
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 ;
 N VPSX S VPSX=""
 I STAFF S VPSX=$$SETFLD^VPSPUTL1(MARKFOL,VPSX,COL("FOLLOWUP")) ; include MARK FOR FOLLOW-UP indicator only for staff-facing output  
 I STAFF S VPSX=$$SETFLD^VPSPUTL1(PATRESP,VPSX,COL("PATRESP")) ; include patient structured response in both remote and local allergy sections for staff-facing output  
 I 'STAFF,TYPE="LOCAL" S VPSX=$$SETFLD^VPSPUTL1(PATRESP,VPSX,COL("PATRESP")) ; only include patient structured response for local allergy section for patient-facing output
 S VPSX=$$SETFLD^VPSPUTL1(ALRNM,VPSX,COL("ALLERNM"))
 S VPSX=$$SETFLD^VPSPUTL1($G(REACTLN(1)),VPSX,COL("REACTION"))
 I TYPE="REMOTE" S VPSX=$$SETFLD^VPSPUTL1(STATION,VPSX,COL("SITE"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 ;
 ; -- Add rest of reaction list
 N RSS S RSS=1
 S VPSX=""
 F  S RSS=$O(REACTLN(RSS)) Q:'RSS  D
 . S VPSX=$$SETFLD^VPSPUTL1(REACTLN(RSS),VPSX,COL("REACTION"))
 . D ADDPDO^VPSOBJ(OREF,VPSX)
 ;
 D ADDBLANK^VPSOBJ(OREF) ; add a blank line between allergy sets
 Q
 ;
 ; Health Summary entry point
HS ;
 N TARGET,I
 S TARGET="^TMP(""VPSPDO1"",$J)"
 S I=$$TIU(DFN,TARGET)
 S I=0
 F  S I=$O(@TARGET@(I)) Q:'I  W !,@TARGET@(I,0)
 W !!
 S GMTSQIT=""
 Q
