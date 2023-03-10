IBCNEHL7 ;AITC/DM - HL7 Process Incoming 271 Messages Continued;05-MAY-2018
 ;;2.0;INTEGRATED BILLING;**621,668**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine is used to process EICD associated entries.
 Q
 ;
SVEICD() ; Save EICD Identification Data into the EIV EICD TRACKING (#365.18) file.
 ; INPUT:  IBTRACK array indexed by SETID
 ;         RIEN Internal Entry Number of the IIV RESPONSE (#365) File.
 ;
 N CNT,IENS,RSUPDT,TQIEN,TRKIEN
 S TQIEN=$$GET1^DIQ(365,RIEN_",",.05,"I")  ;Transmission Queue IEN
 S TRKIEN=$O(^IBCN(365.18,"B",TQIEN,"")),IENS=TRKIEN_","
 S RSUPDT(365.18,IENS,.04)=IBTRACK(0,.04)
 S RSUPDT(365.18,IENS,.06)=IBTRACK(0,.06)
 S RSUPDT(365.18,IENS,.07)=IBTRACK(0,.07)
 D FILE^DIE("","RSUPDT","ERROR")
 S CNT=0 F  S CNT=$O(IBTRACK(CNT)) Q:'CNT  D
 . N IENS,RSUPDT,RSUPDT9IEN
 . S IENS="+"_CNT_","_TRKIEN_","
 . S RSUPDT(365.185,IENS,.01)=$G(IBTRACK(CNT,.01))
 . S RSUPDT(365.185,IENS,.02)=$G(IBTRACK(CNT,.02))
 . S RSUPDT(365.185,IENS,.03)=$G(IBTRACK(CNT,.03))
 . S RSUPDT(365.185,IENS,.04)=$G(IBTRACK(CNT,.04))
 . S RSUPDT(365.185,IENS,.05)=$G(IBTRACK(CNT,.05))
 . S RSUPDT(365.185,IENS,.06)=$G(IBTRACK(CNT,.06))
 . S RSUPDT(365.185,IENS,.07)=$G(IBTRACK(CNT,.07))
 . S RSUPDT(365.185,IENS,.08)=$G(IBTRACK(CNT,.08))
 . S RSUPDT(365.185,IENS,.09)=$G(IBTRACK(CNT,.09))
 . S RSUPDT(365.185,IENS,.1)=$G(IBTRACK(CNT,.1))
 . S RSUPDT(365.185,IENS,.11)=$G(IBTRACK(CNT,.11))
 . S RSUPDT(365.185,IENS,.12)=$G(IBTRACK(CNT,.12))
 . S RSUPDT(365.185,IENS,.13)=$G(IBTRACK(CNT,.13))
 . S RSUPDT(365.185,IENS,.14)=$G(IBTRACK(CNT,.14))
 . S RSUPDT(365.185,IENS,.15)=+$G(IBTRACK(CNT,.15))
 . D UPDATE^DIE("","RSUPDT","RSUPIEN","ERROR")
SVEICDQ ;
 Q TRKIEN
 ;
PROCTRK(TRKIEN) ; Process the EICD Tracking File entries.
 ; TRKIEN = EIV EICD TRACKING Identification IEN
 ;
 N DATA1,DATA2,DATA5,IBBUF,IBBUFIEN,IBCSIEN,IBDFN,IBERR,IBFDA,IBFMIEN
 N IBFRESH,IBIDIEN,IBINSDTA,IBMSG,IBPYRIEN,IBPYROK,IBSUBID,IBTQIEN,IBTQSTAT
 ; 
 S IBFRESH=$$FMADD^XLFDT(DT,-($$GET1^DIQ(350.9,"1,",51.01,"I"))) ; DT - "FRESHNESS DAYS"
 S IBTQSTAT=$$FIND1^DIC(365.14,,,"Ready to Transmit","B")
 S IBCSIEN=$$FIND1^DIC(355.12,,"X","CONTRACT SERVICES","C")
 S IBDFN=$$GET1^DIQ(365.18,TRKIEN_",",.05,"I") ; "EICD PATIENT"
 ; loop through any discovered insurance creating TQ/Buffer/Tracking entries 
 S IBIDIEN=0 F  S IBIDIEN=$O(^IBCN(365.18,TRKIEN,"INS-FND",IBIDIEN)) Q:'IBIDIEN  D
 . S IBFMIEN=IBIDIEN_","_TRKIEN_","
 . K IBINSDTA D GETS^DIQ(365.185,IBFMIEN,"*",,"IBINSDTA") ; grab selected fields (external)  
 . Q:'$D(IBINSDTA)  ; no data
 . ; see if PAYER VA ID is on file and active
 . S IBPYRIEN=0,IBPYROK=1
 . S:IBINSDTA(365.185,IBFMIEN,.01)="UNKNOWN" IBPYROK=0
 . S:IBPYROK IBPYRIEN=$$FIND1^DIC(365.12,,"X",IBINSDTA(365.185,IBFMIEN,.01),"C")
 . S:'IBPYRIEN IBPYROK=0
 . I IBPYROK D
 .. N PYRAPP
 .. ;IB*668/TAZ - Changed field names to enabled and Payer Application from IIV to EIV
 .. S PYRAPP=$$PYRAPP^IBCNEUT5("EIV",IBPYRIEN)
 .. I '$$GET1^DIQ(365.121,PYRAPP_","_IBPYRIEN_",",.02,"I") S IBPYROK=0 Q  ; "NATIONALLY ENABLED"
 .. I '$$GET1^DIQ(365.121,PYRAPP_","_IBPYRIEN_",",.03,"I") S IBPYROK=0 Q  ; "LOCALLY ENABLED"
 . I IBPYROK D  Q 
 .. S IBSUBID=IBINSDTA(365.185,IBFMIEN,.04)            ; SUBSCRIBER ID
 .. S:IBSUBID="" IBSUBID=IBINSDTA(365.185,IBFMIEN,.05) ; MEMBER ID
 .. ; SET prepare and file the TQ
 .. ; IBDFN:Patient IEN
 .. ; IBPYRIEN:Payer IEN
 .. ; IBTQSTAT:TQ STATUS IEN - Ready to Transmit
 .. ; IBSUBID:SUBSCRIBER ID (may be MEMBERID)
 .. ; IBFRESH:Freshness date
 .. ; IBINSDTA(365.185,IBFMIEN,.05):MEMBER ID  
 .. ; 4:EICD data extract (#4)
 .. ; V:Verification 
 .. ; DT:Todays date 
 .. ; IBCSIEN:Source of Information IEN - Contract Services
 .. ; IBIDIEN:IEN of the INS-FND multiple (discovered insurance) in #365.185
 .. S DATA1=IBDFN_U_IBPYRIEN_U_IBTQSTAT_U_""_U_IBSUBID_U_IBFRESH_U_""_U_IBINSDTA(365.185,IBFMIEN,.05)
 .. S DATA2=4_U_"V"_U_DT
 .. S DATA5=IBCSIEN_U_IBIDIEN
 .. S IBTQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2,,,DATA5) ; Sets in TQ
 .. I IBTQIEN="" Q  ; didn't file
 .. ; update the EIV EICD TRACKING (#365.185)
 .. K IBFDA,IBERR
 .. S IBFDA(365.185,IBFMIEN,1.01)=IBTQIEN ; EICD VER INQ TRANSMISSION
 .. S IBFDA(365.185,IBFMIEN,1.02)=DT      ; EICD VER INQ DATE CREATED
 .. D FILE^DIE(,"IBFDA","IBERR")
 .. I $G(IBERR("DIERR",1,"TEXT",1))'="" D  Q
 ... S IBMSG=""
 ... D MSG002^IBCNEMS1(.IBMSG,.IBERR,IBTQIEN)
 ... D MSG^IBCNEUT5($$MGRP^IBCNEUT5(),"eIV Problem: Error updating EIV EICD TRACKING (#365.185)","IBMSG(")
 .. ;Load and Send the HL7 Message
 .. S DATA1=$$PROCSEND^IBCNERTQ(IBTQIEN)
 .. K ^TMP("DIERR",$J) ; safety, cleanup
 .. Q  ; next insurance discovery 
 . ; Payer had issues, place an entry in the buffer for manual processing 
 . D
 .. ; we're forcing a new block so we can redefine DUZ safely
 .. N DUZ
 .. S DUZ=$$FIND1^DIC(200,,,"INTERFACE,IB EIV","B")
 .. K IBBUF
 .. ; Patient fields, name, dob and ssn will be populated automatically
 .. S IBBUF(.02)=DUZ  ; entered By
 .. S IBBUF(.12)=""   ; setting to Null for the Buffer Symbol 
 .. S IBBUF(.18)=$$FMTE^XLFDT(DT) ; Service Date
 .. S IBBUF(20.01)=IBINSDTA(365.185,IBFMIEN,.02) ; PAYER NAME, used to populate INSURANCE COMPANY NAME
 .. S IBBUF(60.01)=IBDFN ; Patient IEN
 .. S IBBUF(60.06)=$S(IBINSDTA(365.185,IBFMIEN,.15)="Y":"",1:"PATIENT") ; Patient relationship to Insured
 .. S IBBUF(60.08)=IBINSDTA(365.185,IBFMIEN,.07) ; INSURED DOB
 .. S IBBUF(60.13)=IBINSDTA(365.185,IBFMIEN,.08) ; INSURED SEX 
 .. S IBBUF(62.01)=IBINSDTA(365.185,IBFMIEN,.05) ; MEMBER/PATIENT ID
 .. S IBBUF(80.01)=$$GET1^DIQ(350.9,"1,",60.01,"E")  ; DEFAULT SERVICE TYPE CODE 1
 .. S IBBUF(90.02)=IBINSDTA(365.185,IBFMIEN,.03) ; GROUP NUMBER
 .. S IBBUF(90.03)=IBINSDTA(365.185,IBFMIEN,.04) ; SUBSCRIBER ID
 .. ; the following call in-turn, calls EDITSTF^IBCNBES which will make sure to file subscriber ID last, automatically
 .. S IBBUFIEN=$$ADDSTF^IBCNBES(IBCSIEN,IBDFN,.IBBUF)
 . Q  ; next insurance discovery
 ;
 Q
 ;
