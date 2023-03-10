IBCNEUT5 ;DAOU/ALA - eIV MISC. UTILITIES ; 20-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,284,271,416,621,602,668,702**;21-MAR-94;Build 53
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program contains some general utilities or functions
 ;
 Q
 ;
MSG(MGRP,XMSUB,XMTEXT,FROMFLAG,XMY) ;  Send a MailMan Message
 ;
 ;  Input Parameters
 ;   MGRP = Mailgroup Name (optional)
 ;   XMSUB = Subject Line (required)
 ;   XMTEXT = Message Text Array Name in open format:  "MSG(" (required)
 ;   FROMFLAG = Flag indicating from whom the message is sent (optional)
 ;         false/undefined:  from the specific, non-human eIV user
 ;                    true:  from the actual user (DUZ)
 ;   XMY = recipients array; pass by reference (optional)
 ;         The possible recipients are the sender, the Mail Group in the
 ;         first parameter, and anybody else already defined in the XMY 
 ;         array when this parameter is used.
 ;
 ; New MailMan variables and also some FileMan variables.  The FileMan
 ; variables are used and not cleaned up when sending to external
 ; internet addresses.
 NEW DIFROM,XMDUZ,XMDUN,XMZ,XMMG,XMSTRIP,XMROU,XMYBLOB
 NEW D0,D1,D2,DG,DIC,DICR,DISYS,DIW
 NEW TMPSUB,TMPTEXT,TMPY,XX
 ;
 I $G(FROMFLAG),$G(DUZ) S XMDUZ=DUZ
 E  S XMDUZ="eIV INTERFACE (IB)"
 I $G(MGRP)'="" S XMY("G."_MGRP)=""
 ; If no recipients are defined, send to postmaster
 I '$D(XMY) S XMY(.5)=""
 I $G(DUZ) S XMY(DUZ)=""
 ; Store off subject, array reference and array of recipients
 S TMPSUB=XMSUB,TMPTEXT=XMTEXT
 M TMPY=XMY
 D ^XMD
 ;
 ; Error logic
 ; If there's an error message and the message was not originally sent
 ; to the postmaster, then send a message to the postmaster with this
 ; error message.
 ;
 I $D(XMMG),'$D(TMPY(.5)) D
 . S XMY(.5)=""
 . S XMTEXT=TMPTEXT,XMSUB="MailMan Error"
 . ; Add XMMG error message as the first line of the message
 . S XX=999999
 . F  S XX=$O(@(XMTEXT_"XX)"),-1) Q:'XX  S @(XMTEXT_"XX+3)")=@(XMTEXT_"XX)")
 . S @(XMTEXT_"1)")="   MailMan Error:  "_XMMG
 . S @(XMTEXT_"2)")="Original Subject:  "_TMPSUB
 . S @(XMTEXT_"3)")="------Original Message------"
 . D ^XMD
 . Q
 Q
 ;
 ;
BFEXIST(DFN,INSNAME) ; Function returns 1 if an Entered Ins Buffer File 
 ; entry exists with the same DFN and INSNAME, otherwise it returns a 0
 ;
 ; DFN - Patient DFN
 ; INSNAME - Insurance Company Name File 36 - Field .01
 ;
 NEW BUFFNAME,EXIST,IEN ; IB*2.0*602
 S EXIST=0
 S INSNAME=$$UP^XLFSTR(INSNAME),INSNAME=$$TRIM^XLFSTR(INSNAME)  ; trimmed *IB*2.0*602
 I ('DFN)!(INSNAME="") G BFEXIT
 ;
 S IEN=0
 F  S IEN=$O(^IBA(355.33,"C",DFN,IEN)) Q:'IEN!EXIST  D
 .  ; Quit if status is NOT 'Entered'
 .  I $P($G(^IBA(355.33,IEN,0)),U,4)'="E" Q
 .  ; Quit if Ins Buffer Ins Co Name (trimmed) is NOT EQUAL to 
 .  ;  the Ins Co Name parameter (trimmed)
 .  ; IB*2.0*602 in case the input template for that field changes in the future (TRIM & UP)
 .  S BUFFNAME=$$TRIM^XLFSTR($P($G(^IBA(355.33,IEN,20)),U))
 .  I $$UP^XLFSTR(BUFFNAME)'=INSNAME Q
 .  ; Match found
 .  S EXIST=1
 .  Q
BFEXIT ;
 Q EXIST
 ;
 ;
MGRP() ; Get the Mail Group for the eIV Interface - IB Site Parameters (51.04)
 Q $$GET1^DIQ(350.9,"1,",51.04,"E")
 ;
 ;
PYRAPP(APP,PAYERIEN) ; Get the Payer Application multiple IEN
 ; based on the payer application name and payer ien.
 ;
 NEW MIEN,APPIEN,DISYS
 S MIEN=""
 S APPIEN=$$FIND1^DIC(365.13,,"X",APP,"B")
 I 'APPIEN G PYRAPPX
 I '$G(PAYERIEN) G PYRAPPX
 S MIEN=$O(^IBE(365.12,PAYERIEN,1,"B",APPIEN,""))
PYRAPPX ;
 Q MIEN
 ;
 ;
ACTAPP(IEN) ; Active payer applications
 ;IB*668/TAZ - Changed Active to Enabled.  Changed location of DEACTIVATED?
 ; This function will return 1 if any of the payer applications for 
 ; this payer (being passed in by the payer IEN) are NOT deactivated.
 ; This should not be confused with the other payer application fields
 ; such as national enabled or local enabled  The deactivated field is
 ; the .07 field at the payer level.
 ;
 ; This function is invoked by the FileMan data dictionary as a screen
 ; for the Payer field (#3.1) in the Insurance company file (#36).
 ;
 ;IB*2.0*668/TAZ - The utility will now call the new PYRDEACT utility.  The 
 ;                 logic in the new utility returns 1 if the Payer is deactivated
 ;                 and 0 if is activated.  This is the opposite of this utility; 
 ;                 therefore we need to flip the logic and check for NOT Deactivated.
 Q '$$PYRDEACT^IBCNINSU(IEN)
 ;
 ;NEW APPIEN,ACTAPP,APPDATA
 ;S APPIEN=0,ACTAPP="",IEN=+$G(IEN)
 ;F  S APPIEN=$O(^IBE(365.12,IEN,1,APPIEN)) Q:'APPIEN  D  Q:ACTAPP
 ;. S APPDATA=$G(^IBE(365.12,IEN,1,APPIEN,0))
 ;. I $P(APPDATA,U,11) Q
 ;. I $P(APPDATA,U,12) Q
 ;. S ACTAPP=1
 ;. Q
 ;Q ACTAPP
 ;
ADDTQ(DFN,PAYER,SRVDT,FDAYS,EICDEXT) ; Function  - Returns flag (0/1)
 ; 1 - TQ File entry can be added as the service date for the patient 
 ;     and payer >= MAX TQ service date + Freshness Days
 ; 0 - otherwise
 ;
 ; Input:
 ;  DFN   - Patient DFN (File #2)
 ;  PAYER - Payer IEN (File #365.12)
 ;  SRVDT - Service dt for potential TQ entry
 ;  FDAYS - Freshness Days param (by extract type)
 ;  EICDEXT - 1 OR 0 (Is this from the EICD extract?) ;IB*2.0*621 - Renamed parameter to EICD extract
 ;
 N ADDTQ,MAXDT
 ; 
 S ADDTQ=1
 I ($G(DFN)="")!($G(SRVDT)="")!($G(FDAYS)="") S ADDTQ=0 G ADDTQX
 I ($G(EICDEXT)="")!($G(PAYER)="") S ADDTQ=0 G ADDTQX
 ;
 ; MAX TQ Service Date
 S MAXDT=$$TQMAXSV(DFN,$G(PAYER),$G(EICDEXT))
 I MAXDT="" G ADDTQX
 ; If Service Date < Max Service Date + Freshness Days, do not add
 I SRVDT'>$$FMADD^XLFDT(MAXDT,FDAYS) S ADDTQ=0
 ;
ADDTQX ; ADDTQ exit pt
 Q ADDTQ
 ;
TQUPDSV(DFN,PAYER,SRVDT) ; Update service dates & freshness dates for TQ
 ; entries awaiting transmission
 ;
 N SVDT,STS,ERACT,CSRVDT,CSPAN,SPAN,DA,HL7IEN,RIEN
 ;
 I ($G(DFN)="")!($G(PAYER)="")!($G(SRVDT)="") G TQUPDSVX
 ;
 ; Loop thru all inquiries to be transmitted to update the service date
 ; Statuses:  Ready to Transmit(1), Hold(4) and Retry(6)
 S SVDT=""
 F  S SVDT=$O(^IBCN(365.1,"AD",DFN,PAYER,SVDT)) Q:'SVDT  D
 . S DA=0
 . F  S DA=$O(^IBCN(365.1,"AD",DFN,PAYER,SVDT,DA)) Q:'DA  D
 .. ; TQ Status
 .. S STS=$P($G(^IBCN(365.1,DA,0)),U,4)
 .. ; Check to see if record is still scheduled to be transmitted.
 .. ; If so, update the service date if the new service date and current
 .. ; service date are both in the past or future and the new service
 .. ; date is closer to Today.  Also, if the current service date is in
 .. ; the future and the new service date is in the past, update with the
 .. ; new service date.
 .. ; If not Ready to Transmit(1), Hold(4) and Retry(6), quit
 .. I STS'=1,STS'=4,STS'=6 Q
 .. ; If Hold and last Response returned Error Action - Please resubmit
 .. ; Original Transaction (P) - do not update
 .. I STS=4 S ERACT="" D  I ERACT="P" Q
 .. . ; Last msg sent
 .. . S HL7IEN=$O(^IBCN(365.1,DA,2," "),-1) Q:'HL7IEN
 .. . ; Assoc eIV Response IEN
 .. . S RIEN=$P($G(^IBCN(365.1,DA,2,HL7IEN,0)),U,3) Q:'RIEN
 .. . ; Error Action IEN (365.018)
 .. . S ERACT=$P($G(^IBCN(365,RIEN,1)),U,15) Q:'ERACT
 .. . S ERACT=$P($G(^IBE(365.018,ERACT,0)),U,1)
 .. ;
 .. ; Current service date for TQ entry
 .. S CSRVDT=$P($G(^IBCN(365.1,DA,0)),U,12)
 .. ; If current service date is today (DT), do not update
 .. I CSRVDT=DT Q
 .. ; If new service date is in the future and current service date is in
 .. ; the past, do not update
 .. I SRVDT>DT,CSRVDT<DT Q
 .. ; If new service date is today, update
 .. I SRVDT=DT D SAVETQ^IBCNEUT2(DA,SRVDT),SAVFRSH(DA,+$$FMDIFF^XLFDT(SRVDT,CSRVDT,1)) Q
 .. ; If both current and new service dates are in the past or future,
 .. ; only update, when new service date is closer to today (DT).
 .. I ((CSRVDT<DT)&(SRVDT<DT))!((CSRVDT>DT)&(SRVDT>DT)) D  Q
 .. . S CSPAN=$$FMDIFF^XLFDT(CSRVDT,DT,1),SPAN=$$FMDIFF^XLFDT(SRVDT,DT,1)
 .. . I CSPAN<0 S CSPAN=-CSPAN
 .. . I SPAN<0 S SPAN=-SPAN
 .. . I SPAN<CSPAN D SAVETQ^IBCNEUT2(DA,SRVDT),SAVFRSH(DA,+$$FMDIFF^XLFDT(SRVDT,CSRVDT,1))
 .. ; If new service date is in the past and current service date is in
 .. ; the future, update
 .. I SRVDT<CSRVDT D SAVETQ^IBCNEUT2(DA,SRVDT),SAVFRSH(DA,+$$FMDIFF^XLFDT(SRVDT,CSRVDT,1)) Q
 .. Q
TQUPDSVX ; TQUPDSV exit pt
 Q
 ;
TQMAXSV(DFN,PAYER,EICDEXT) ; Returns MAX(TQ Service Date) for Patient & Payer
 ; Input: 
 ;  DFN     - Patient DFN (2)
 ;  PAYER   - Payer IEN (365.12)
 ;  EICDEXT - 1 OR 0 (Is this from the EICD extract?)
 ;
 ; Output:
 ;  TQMAXSV - MAX (most recent) service date from TQ entry for Patient &
 ;            Payer
 ;
 ; IB*621 reworked this function to ignore TQ entries with statuses of
 ;  "Response Received" for EICD for which the Response indicated a "Clearinghouse Timeout"
 N TQMAXSV
 S TQMAXSV=""
 ;IB*668/TAZ - Added check for PAYER and quit if null
 I $G(DFN)=""!'$G(PAYER) G TQMAXSVX
 ;
 N ERTXT,IBSKIP,IBTQS,IENS,LASTBYP,STATLIST,TQIEN
 ; This is the list of statuses that are to be ignored for EICD extract only
 ;   3=Response Received
 S STATLIST=",3,"
 ;
 S LASTBYP=""
 F  S LASTBYP=$O(^IBCN(365.1,"AD",DFN,PAYER,LASTBYP)) Q:LASTBYP=""  D
 . S TQIEN=""
 . F  S TQIEN=$O(^IBCN(365.1,"AD",DFN,PAYER,LASTBYP,TQIEN)) Q:TQIEN=""  D
 .. S IBSKIP=0
 .. I EICDEXT D  Q:IBSKIP
 .. . S IBTQS=+$$GET1^DIQ(365.1,TQIEN_",",.04,"I")    ; TQ Transmission Status 
 .. . I IBTQS,'($F(STATLIST,","_IBTQS_",")) Q
 .. . S IENS="1,"_TQIEN_",",RIEN=$$GET1^DIQ(365.16,IENS,.03,"I")
 .. . S ERTXT=$$GET1^DIQ(365,RIEN_",",4.01) I $$UP^XLFSTR(ERTXT)["TIMEOUT" S IBSKIP=1 ; keep looking
 .. I LASTBYP>TQMAXSV S TQMAXSV=LASTBYP
 ;
TQMAXSVX ; TQMAXSV exit pt
 Q TQMAXSV
 ;
SAVFRSH(TQIEN,DTDIFF) ; Update TQ freshness date based on service date diff
 ;
 N DIE,DA,FDT,DR,D,D0,DI,DIC,DQ,X
 I $G(TQIEN)="" Q
 S FDT=$P($G(^IBCN(365.1,TQIEN,0)),U,17)
 ; Note - will only update if FDT > 0.
 S FDT=$$FMADD^XLFDT(FDT,+DTDIFF)
 S DIE="^IBCN(365.1,",DA=TQIEN,DR=".17////"_FDT
 D ^DIE
 Q
 ;
EPAT(MSG) ; Check for qualified patient for EICD Identification
 ;INPUT:
 ;  MSG      -  Error Message used in IBCNEQU1
 ;
 N OK
 S OK=0
 I +$$GET1^DIQ(2,DFN_",",.6,"I") G EPATX  ;Test Patient?
 I (+$$GET1^DIQ(2,DFN_",",2001,"I")>FRESHDT) S:$D(MSG) MSG=2 G EPATX  ;Too soon
 I +$$GET1^DIQ(2,DFN_",",.351,"I") G EPATX  ;Patient Deceased
 I $$GET1^DIQ(2,DFN_",",.115)="" G EPATX  ;State cannot be null
 I $$GET1^DIQ(2,DFN_",",.116)="" G EPATX  ;Zip Code cannot be null
 ;
 S OK=1
EPATX ; Exit
 Q OK
 ;
EPAYR() ; Check EICD Payer
 ;IB*702/TAZ Moved Payer checks from IBCNEDE4 to EPAYR^IBCNEUT5 (this is a new tag)
 N IENS,OK,PAYER,PIEN
 S OK=0
 ;
 S PIEN=+$$GET1^DIQ(350.9,"1,",51.31,"I") ; EICD PAYER
 I 'PIEN G EPAYRX
 ;
 D PAYER^IBCNINSU(PIEN,"EIV",,"I",.PAYER)
 S IENS=$O(PAYER(365.121,"")) I IENS']"" G EPAYRX  ; No EIV Data for this Payer
 I '$G(PAYER(365.121,IENS,.02,"I")) G EPAYRX ; Not "NATIONALLY ENABLED"
 I '$G(PAYER(365.121,IENS,.03,"I")) G EPAYRX ; Not "LOCALLY ENABLED"
 ;
 S OK=PIEN
 ;
EPAYRX ; Exit
 Q OK
 ;
EACTPOL() ; Check for active policy for EICD Identification
 N EINS,IBACTV,IBEFF,IBEXP,IBIDX,IBINCO,IBINSNM,IBPLAN,IBTOP,IBTOPIEN,IBWK1,IBWK2
 ;
 ; gather the non-active insurance company names
 ; we will strip all blanks from the names, so dashes ('-') are treated properly for a compare 
 F IBIDX=2:1 S IBINCO=$P($T(NAINSCO+IBIDX),";;",2) Q:IBINCO=""  S IBINSNM($TR(IBINCO," ",""))=""
 ;
 ; gather the non-active type of plan iens
 F IBIDX=2:1 S IBPLAN=$P($T(NATPLANS+IBIDX),";;",2) Q:IBPLAN=""  D
 . S IBTOP=+$$FIND1^DIC(355.1,,"BQX",IBPLAN) Q:'IBTOP
 . S IBTOPIEN(IBTOP)=""
 ;
 ; skip any patient with "active" insurance 
 S IBACTV=0
 S IBIDX=0 ; check policies for "active" insurance 
 F  S IBIDX=$O(^DPT(DFN,.312,IBIDX)) Q:'IBIDX  D  I IBACTV Q
 . S EINS=IBIDX_","_DFN_","
 . S IBEFF=+$$GET1^DIQ(2.312,EINS,8,"I") I 'IBEFF Q  ; No effective date 
 . S IBEXP=+$$GET1^DIQ(2.312,EINS,3,"I") I IBEXP,(IBEXP<(DT)) Q  ; expired
 . ; 
 . ; Check for Non-active Insurance companies
 . S INSNM=$TR($$GET1^DIQ(2.312,EINS,.01,"E")," ","") ; insurance company name
 . I INSNM="" Q  ; bad pointer to INSURANCE COMPANY File (#36)
 . I $D(IBINSNM(INSNM)) Q
 . ;
 . ; Check for Non-active Type of Plan
 . S IBPLAN=$$GET1^DIQ(2.312,EINS,.18,"I")   ; group plan ien 
 . S IBTOP=$$GET1^DIQ(355.3,IBPLAN_",",.09,"I") ; type of plan ien
 . I IBTOP'="",$D(IBTOPIEN(IBTOP)) Q
 . ; 
 . ; Insurance is considered active at this point 
 . S IBACTV=1 Q  ; active 
EACTPOLX ; Exit
 Q IBACTV
 ;
NAINSCO ; Non-active Insurance companies
 ;
 ;;MEDICARE (WNR)
 ;;VACAA-WNR  
 ;;CAMP LEJEUNE - WNR
 ;;IVF - WNR
 ;;VHA DIRECTIVE 1029 WNR
 ;
NATPLANS ; Non-active Type of Plans
 ;
 ;;ACCIDENT AND HEALTH INSURANCE
 ;;AUTOMOBILE
 ;;AVIATION TRIP INSURANCE
 ;;CATASTROPHIC INSURANCE
 ;;CHAMPVA
 ;;COINSURANCE
 ;;DENTAL INSURANCE
 ;;DUAL COVERAGE
 ;;INCOME PROTECTION (INDEMNITY)
 ;;KEY-MAN HEALTH INSURANCE
 ;;LABS, PROCEDURES, X-RAY, ETC. (ONLY)
 ;;MEDI-CAL
 ;;MEDICAID
 ;;MEDICARE (M)
 ;;MEDICARE/MEDICAID (MEDI-CAL)
 ;;MENTAL HEALTH
 ;;NO-FAULT INSURANCE
 ;;PRESCRIPTION
 ;;QUALIFIED IMPAIRMENT INSURANCE
 ;;SPECIAL CLASS INSURANCE
 ;;SPECIAL RISK INSURANCE
 ;;SPECIFIED DISEASE INSURANCE
 ;;Substance abuse only
 ;;TORT FEASOR
 ;;TRICARE
 ;;TRICARE SUPPLEMENTAL
 ;;VA SPECIAL CLASS
 ;;VISION
 ;;WORKERS' COMPENSATION INSURANCE
 ;
 Q
 ;
