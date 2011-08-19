IBCNEUT5 ;DAOU/ALA - eIV MISC. UTILITIES ;20-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,284,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 NEW EXIST,IEN
 S EXIST=0
 S INSNAME=$$TRIM^XLFSTR(INSNAME)  ; trimmed
 I ('DFN)!(INSNAME="") G BFEXIT
 ;
 S IEN=0
 F  S IEN=$O(^IBA(355.33,"C",DFN,IEN)) Q:'IEN!EXIST  D
 .  ; Quit if status is NOT 'Entered'
 .  I $P($G(^IBA(355.33,IEN,0)),U,4)'="E" Q
 .  ; Quit if Ins Buffer Ins Co Name (trimmed) is NOT EQUAL to 
 .  ;  the Ins Co Name parameter (trimmed)
 .  I $$TRIM^XLFSTR($P($G(^IBA(355.33,IEN,20)),U))'=INSNAME Q
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
 ; This function will return 1 if any of the payer applications for 
 ; this payer (being passed in by the payer IEN) are NOT deactivated.
 ; This should not be confused with the other payer application fields
 ; such as national active or local active.  The deactivated field is
 ; the .11 field in the payer application multiple.
 ;
 ; This function is invoked by the FileMan data dictionary as a screen
 ; for the Payer field (#3.1) in the Insurance company file (#36).
 ;
 NEW APPIEN,ACTAPP,APPDATA
 S APPIEN=0,ACTAPP="",IEN=+$G(IEN)
 F  S APPIEN=$O(^IBE(365.12,IEN,1,APPIEN)) Q:'APPIEN  D  Q:ACTAPP
 . S APPDATA=$G(^IBE(365.12,IEN,1,APPIEN,0))
 . I $P(APPDATA,U,11) Q
 . I $P(APPDATA,U,12) Q
 . S ACTAPP=1
 . Q
 Q ACTAPP
 ;
ADDTQ(DFN,PAYER,SRVDT,FDAYS,ANYPAYER) ; Function  - Returns flag (0/1)
 ; 1 - TQ File entry can be added as the service date for the patient 
 ;     and payer >= MAX TQ service date + Freshness Days
 ;     If ANYPAYER is set, check for recent entries for this patient and
 ;     any payer
 ; 0 - otherwise
 ;
 ; Input:
 ;  DFN   - Patient DFN (File #2)
 ;  PAYER - Payer IEN (File #365.12)
 ;  SRVDT - Service dt for potential TQ entry
 ;  FDAYS - Freshness Days param (by extract type)
 ;  ANYPAYER - NUMERIC>0 if checking for any payer
 ;
 N ADDTQ,MAXDT
 ; 
 S ADDTQ=1
 I ($G(DFN)="")!($G(SRVDT)="")!($G(FDAYS)="") S ADDTQ=0 G ADDTQX
 I '$G(ANYPAYER),$G(PAYER)="" S ADDTQ=0 G ADDTQX
 ; MAX TQ Service Date
 S MAXDT=$$TQMAXSV(DFN,$G(PAYER),$G(ANYPAYER))
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
TQMAXSV(DFN,PAYER,ANYPAYER) ; Returns MAX(TQ Service Date) for Patient & Payer
 ; Input: 
 ;  DFN     - Patient DFN (2)
 ;  PAYER   - Payer IEN (365.12) (If no PAYER passed in, check them all)
 ;  ANYPAYER - NUMERIC>0 if checking for any payer
 ; Output:
 ;  TQMAXSV - MAX (most recent) service date from TQ entry for Patient &
 ;            Payer
 ;
 N TQMAXSV
 S TQMAXSV=""
 I $G(DFN)="" G TQMAXSVX
 I '$G(ANYPAYER) S TQMAXSV=$O(^IBCN(365.1,"AD",DFN,PAYER,""),-1) G TQMAXSVX
 ;
 N PIEN,LASTBYP
 S PIEN="" F  S PIEN=$O(^IBCN(365.1,"AD",DFN,PIEN)) Q:PIEN=""  D
 .S LASTBYP=$O(^IBCN(365.1,"AD",DFN,PIEN,""),-1)
 .Q:'LASTBYP   ; Just in case
 .I LASTBYP>TQMAXSV S TQMAXSV=LASTBYP
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
