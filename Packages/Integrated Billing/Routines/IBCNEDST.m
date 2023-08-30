IBCNEDST ;ALB/YMG - HL7 Registration Message Statistics ; 07-MAR-2013
 ;;2.0;INTEGRATED BILLING;**497,506,549,595,659,664,668,702,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
GETSTAT2() ;EP
 ; IB*2.0*549 - Added method
 ; Get additional IB Site Parameter fields
 ; Input:   None
 ; Output:  A1^A2^A3^A4^A5 - Where:
 ;            A1 - 350.9, 51.27     - 270 MASTER SWITCH REALTIME
 ;            A2 - 350.9, 51.28     - 270 MASTER SWITCH NIGHTLY
 ;            A3 - 350.9, 51.15     - HL7 MAXIMUM NUMBER
 ;            A4 - 350.9002, .05    - MAXIMUM EXTRACT NUMBER (appt)
 ;            A5 - 350.9002, .05    - MAXIMUM EXTRACT NUMBER (buffer)
 ;            A6 - 350.9, 51.32     - MEDICARE FRESHNESS DAYS   ;/vd - IB*2*659
 ;
 N DATA,XX
 S DATA=$$GET1^DIQ(350.9,"1,",51.27,"I")            ; 270 Master Switch Realtime
 S $P(DATA,"^",2)=$$GET1^DIQ(350.9,"1,",51.28,"I")  ; 270 Master Switch Nightly
 S $P(DATA,"^",3)=$$GET1^DIQ(350.9,"1,",51.15,"I")  ; HL7 Maximum Number
 S XX=$O(^IBE(350.9,1,51.17,"B",2,""))              ; Find Appointment multiple
 S XX=$$GET1^DIQ(350.9002,XX_",1,",.05,"I")         ; Maximum Appointment Extract
 S $P(DATA,"^",4)=XX
 S XX=$O(^IBE(350.9,1,51.17,"B",1,""))              ; Find Buffer multiple
 S XX=$$GET1^DIQ(350.9002,XX_",1,",.05,"I")         ; Maximum Buffer Extract
 S $P(DATA,"^",5)=XX
 S $P(DATA,"^",6)=$$GET1^DIQ(350.9,"1,",51.32,"I") ; MEDICARE Freshness Days  ;/vd - IB*2*659
 Q DATA
 ;
GETSTAT(MCAUTO) ; get statistical data
 ; Statistics are to match the eIV Statistical Report (^IBCNEPR8)
 ;   IB*664/DW Added parameter "MCAUTO" - this will be used to split out the count of
 ;             Medicare auto-updated responses from the all other eIV responses that
 ;             were auto updated. We now have two calculated totals.  Medicare and
 ;             not Medicare eIV responses that were auto-updated.
 ;
 ; returns the following string, delimited by "^":
 ;
 ;   piece 1  - Number of patients with potential secondary/tertiary insurance as identified by Medicare
 ;   piece 2  - Number of automatically updated patient insurance records processed yesterday only 
 ;   piece 3  - Number of 270 inquiries pending receipt of 271 responses
 ;   piece 4  - Number of queued 270 inquiries
 ;   piece 5  - Number of deferred 270 inquiries
 ;   piece 6  - Number of insurance companies with no National ID
 ;   piece 7  - Number of locally disabled payers
 ;   piece 8  - Number of Verified (*) buffer entries ; IB*737/DTG will be zero, not use '*' verified
 ;   piece 9  - Number of buffer entries indicated as having Active insurance (+)
 ;   piece 10 - Number of buffer entries indicated as having Inactive insurance (-)
 ;   piece 11 - Number of buffer entries indicated as policy status undetermined (#)
 ;   piece 12 - Number of buffer entries indicated as requiring correction before 270 can be sent (!)
 ;   piece 13 - Number of buffer entries awaiting processing
 ;   piece 14 - Number of buffer entries indicated as waiting for a 271 response (?)
 ;   piece 15 - Number of buffer entries entered by manual process with no further processing (blank)
 ;   piece 16 - Number of unlinked insurance companies
 ;
 N BUFINFO,PAYINFO,RESPINFO,STARTDTTM,TQINFO,STATS
 ;
 S STARTDTTM=$$FMADD^XLFDT($$NOW^XLFDT(),,-24) ; set to current date/time - 24 hours
 ; IB*664/DW Added parameter "MCAUTO" to line below
 S RESPINFO=$$RESPINFO(STARTDTTM,.MCAUTO) ; get data from file 365
 S TQINFO=$$TQINFO() ; get data from file 365.1
 S PAYINFO=$$PAYINFO() ; get data from file 36 & 365.12
 S BUFINFO=$$BUFINFO() ; get data from file 355.33
 S STATS=RESPINFO_U_TQINFO_U_$P(PAYINFO,U)_U_$P(PAYINFO,U,2)
 S STATS=STATS_U_BUFINFO_U_$P(PAYINFO,U,3)
 Q STATS
 ;
RESPINFO(DTTM,MCAUTO) ; get data from IIV Response file (file 365)
 ; DTTM - start date/time
 ; MCAUTO - total # of auto-updated eIV responses that ARE Medicare related
 ;  IB*664/DW Added parameter "MCAUTO"
 ;
 ; returns the following string, delimited by "^":
 ;   piece 1: number of patients with potential secondary/tertiary insurance as identified by Medicare
 ;   piece 2: Number of automatically updated patient insurance records processed yesterday only
 ;   piece 3: Number of 270 inquiries pending receipt of 271 responses
 ;
 ; also returns MCAUTO - # of eIV responses from the Medicare payer that were auto-updated
 ;
 N AUTOUPD,DATE,DFN,EBIEN,IEN,INSNAMES,INSTYPE,INQP,POLICY,PAYER,PAYERWNR,PYRNAME,SECINS,Z
 ; IB*2.0*702/DTG- start Added number of outgoing EICD (A1) 270 transactions.
 ;                      Number of outgoing EICD-triggered (A2) 270 transactions.
 ;                      Number of outgoing MBI Request 270 transactions.
 ;                      Number of incoming MBI positive responses that indicated as having returned the MBI (%).
 N IB1P,IB2D,IB3IEN,IBA1,IBA2,IB40,IBTQ,IBTYP,IBQRY,IBAT1,IBAT2,IBSID,IBMBI,IBMBS
 S (IB1P,IB2D,IB3IEN,IBA1,IBA2,IB40,IBAT1,IBAT2,IBMBI,IBMBS)=""
 S DSTATPA=$G(DSTATPA),DSTATI=$G(DSTATI)
 ; IB*2.0*702/DTG - end Added
 S SECINS=0
 S PAYERWNR=$P($G(^IBE(350.9,1,51)),U,25) ; get Medicare payer ien from IB site parameters
 ;
 ; IB*664/DW - Added 1st 3 parameters to PATINFO, changed from extrinsic function
 D PATINFO(.AUTOUPD,PAYERWNR,.MCAUTO) ; IB*2*595/DM rewrote PATINFO
 S DATE=DTTM-0.000001 F  S DATE=$O(^IBCN(365,"AD",DATE)) Q:DATE=""  D
 .;IB*2*595/DM next 4 lines no longer applicable
 .; if response received within the last 24 hrs, check if it auto-updated insurance policy
 .;S PAYER=0 F  S PAYER=$O(^IBCN(365,"AD",DATE,PAYER)) Q:PAYER=""  D
 .;.S DFN=0 F  S DFN=$O(^IBCN(365,"AD",DATE,PAYER,DFN)) Q:DFN=""  S AUTOUPD=AUTOUPD+$$PATINFO(DFN)
 .;.Q
 .I PAYERWNR,$D(^IBCN(365,"AD",DATE,PAYERWNR)) D
 ..S DFN=0 F  S DFN=$O(^IBCN(365,"AD",DATE,PAYERWNR,DFN)) Q:DFN=""  D
 ...; create array of ins. company names for this patient (active policies only)
 ...K INSNAMES S INSTYPE=0 F  S INSTYPE=$O(^DPT(DFN,.312,"B",INSTYPE)) Q:INSTYPE=""  D
 ....S POLICY=0 F  S POLICY=$O(^DPT(DFN,.312,"B",INSTYPE,POLICY)) Q:POLICY=""  D
 .....; skip policies that are not active
 .....I $$CHK^IBCNS1(^DPT(DFN,.312,POLICY,0),DT,1) S INSNAMES($$EXTERNAL^DILFD(2.312,.01,,INSTYPE))=""
 .....Q
 ....Q
 ...S IEN=0 F  S IEN=$O(^IBCN(365,"AD",DATE,PAYERWNR,DFN,IEN)) Q:IEN=""  D
 ....S Z="" F  S Z=$O(^IBCN(365,IEN,2,"B",Z)) Q:Z=""  D
 .....S EBIEN=$O(^IBCN(365,IEN,2,"B",Z,""))
 .....; make sure eligibility code is "R"
 .....I $$GET1^DIQ(365.02,EBIEN_","_IEN_",",.02)'="R" Q
 .....S PYRNAME=$E($P($G(^IBCN(365,IEN,2,EBIEN,3)),U,3),1,30) ; grab first 30 chars to compare to 36/.01
 .....I PYRNAME'="",'$D(INSNAMES(PYRNAME)) S SECINS=SECINS+1
 . ; IB*2.0*702/DTG- start Added number of outgoing EICD (A1) 270 transactions. number of outgoing EICD-triggered (A2) 270 transactions
 . ;                   number of outgoing MBI Request 270 transactions
 . I $G(DSTATI)=1 D  ;<
 . . S IB1P="" F  S IB1P=$O(^IBCN(365,"AD",DATE,IB1P)) Q:IB1P=""  S IB2D="" D  ;<
 . . . F  S IB2D=$O(^IBCN(365,"AD",DATE,IB1P,IB2D)) Q:IB2D=""  S IB3IEN="" D  ;<
 . . . . F  S IB3IEN=$O(^IBCN(365,"AD",DATE,IB1P,IB2D,IB3IEN)) Q:IB3IEN=""  D  ;<
 . . . . . S IENS=IB3IEN_"," K IB40 D GETS^DIQ(365,IENS,"13.02;.05;.1","IE","IB40")
 . . . . . I $G(IB40(365,IENS,.1,"I"))'="O" Q
 . . . . . S IBSID=$G(IB40(365,IENS,13.02,"I"))
 . . . . . S IBTQ=$G(IB40(365,IENS,.05,"I"))
 . . . . . S IBTYP=$$GET1^DIQ(365.1,IBTQ_",",.1,"I"),IBQRY=$$GET1^DIQ(365.1,IBTQ_",",.11,"I")
 . . . . . ; IBMBI - Number of incoming MBI positive responses that indicated as having returned the MBI (%)
 . . . . . I IBTYP=7&(IBSID'="") S IBMBI=$G(IBMBI)+1 Q
 ;
 I $G(DSTATI)=1 D  ;<
 . S DATE=DTTM-0.000001 F  S DATE=$O(^IBCN(365,"AE",DATE)) Q:DATE=""  D  ;<
 . . S IB3IEN="" F  S IB3IEN=$O(^IBCN(365,"AE",DATE,IB3IEN)) Q:IB3IEN=""  D  ;<
 . . . S IENS=IB3IEN_"," K IB40 D GETS^DIQ(365,IENS,"13.02;.05;.1","IE","IB40")
 . . . I $G(IB40(365,IENS,.1,"I"))'="O" Q
 . . . S IBSID=$G(IB40(365,IENS,13.02,"I"))
 . . . S IBTQ=$G(IB40(365,IENS,.05,"I"))
 . . . S IBTYP=$$GET1^DIQ(365.1,IBTQ_",",.1,"I"),IBQRY=$$GET1^DIQ(365.1,IBTQ_",",.11,"I")
 . . . ;  IBA1 - Number of outgoing EICD (A1) 270 transactions
 . . . ;  IBA2 - Number of outgoing EICD-triggered (A2) 270 transactions
 . . . ; IBMBS - Number of outgoing MBI Request 270 transactions
 . . . I IBTYP=7 S IBMBS=$G(IBMBS)+1 Q
 . . . I IBTYP=4 S:IBQRY="I" IBA1=$G(IBA1)+1 S:IBQRY="V" IBA2=$G(IBA2)+1
 . . ; IB*2.0*702/DTG - end Added
 ;
 ; IB*2.0*702/DTG - start Added
 I $G(DSTATI)=1 S DSTAT3=+$G(IBA1)_DSTATPA_+$G(IBA2)_DSTATPA_+$G(IBMBS)_DSTATPA_+$G(IBMBI)
 ; IB*2.0*702/DTG - end Added
 ;
 ; Number of 270 inquiries pending receipt of 271 responses
 S (INQP,IEN)=0 F  S IEN=$O(^IBCN(365,"AC",2,IEN)) Q:'IEN  D   ; Transmitted status = 2
 . S INQP=INQP+1
 Q SECINS_U_AUTOUPD_U_INQP
 ;
 ;PATINFO() was fully replace for IB*2*595/DM
 ;PATINFO(DFN) ; get data from pat. insurance multiple (file 2.312)
 ;; DFN - file 2 ien
 ;;
 ;; returns
 ;;   number of automatically updated patient insurance records for a given patient within last 24 hours
 ;;
 ;N AUTOUPD,INSTYPE,POLICY
 ;I 'DFN Q
 ;S AUTOUPD=0
 ;S INSTYPE=0 F  S INSTYPE=$O(^DPT(DFN,.312,"B",INSTYPE)) Q:INSTYPE=""  D
 ;.S POLICY=0 F  S POLICY=$O(^DPT(DFN,.312,"B",INSTYPE,POLICY)) Q:POLICY=""  D
 ;..; if DATE LAST VERIFIED is no more than one day old and EIV AUTO-UPDATE is set, increment auto-update counter
 ;..I +$P($G(^DPT(DFN,.312,POLICY,4)),U,4),$$FMDIFF^XLFDT(DT,+$P($G(^DPT(DFN,.312,POLICY,1)),U,3),1)<2 S AUTOUPD=AUTOUPD+1
 ;..Q
 ;.Q
 ;Q AUTOUPD
 ;;
PATINFO(IBAUTO,PAYERWNR,MCAUTO) ; IB*2*595/DM 
 ; compile an auto-update count for all patient policies from yesterday
 ; read all response records from yesterday via the "AUTO" cross reference 
 ; 
 ; PAYERWNR - ien of the current Medicare payer from file #350.9
 ; returns:
 ; IBAUTO - total count of auto-updated eIV responses that are not Medicare related
 ; MCAUTO - total count of auto-updated eIV responses that ARE Medicare related
 ; 
 ; IB*664/DW added 1st three parameters, added logic to split out Medicare auto-updates
 ;   
 N IBAUTOX,IBDATE,IBENDDT,IBIEN,IBPYRIEN,IBPATIEN,IBINSIEN
 S (IBAUTO,MCAUTO)=0
 S IBDATE=$$FMADD^XLFDT($$DT^XLFDT(),-2,23,59,59)
 S IBENDDT=$$FMADD^XLFDT($$DT^XLFDT(),-1,23,59,59)
 ;
 F  S IBDATE=$O(^IBCN(365,"AUTO",IBDATE)) Q:'IBDATE!(IBDATE>IBENDDT)  D
 .S IBPYRIEN=0 F  S IBPYRIEN=$O(^IBCN(365,"AUTO",IBDATE,IBPYRIEN)) Q:'IBPYRIEN  D
 ..S IBPATIEN=0 F  S IBPATIEN=$O(^IBCN(365,"AUTO",IBDATE,IBPYRIEN,IBPATIEN)) Q:'IBPATIEN  D
 ...S IBINSIEN=0 F  S IBINSIEN=$O(^IBCN(365,"AUTO",IBDATE,IBPYRIEN,IBPATIEN,IBINSIEN)) Q:'IBINSIEN  D
 ....; IB*2.0*664/DW Count Medicare auto-updates separately
 ....; IB*664        Added last 2 FOR-LOOPS, original counting was wrong)
 ....;S IBAUTO=IBAUTO+1
 ....S IBAUTOX=0 F  S IBAUTOX=$O(^IBCN(365,"AUTO",IBDATE,IBPYRIEN,IBPATIEN,IBINSIEN,IBAUTOX)) Q:'IBAUTOX  D
 .... .Q:IBAUTOX'=1   ;Auto updated records will be a "1" 
 .... .S IBIEN=0 F  S IBIEN=$O(^IBCN(365,"AUTO",IBDATE,IBPYRIEN,IBPATIEN,IBINSIEN,IBAUTOX,IBIEN)) Q:'IBIEN  D
 .... ..I IBPYRIEN=PAYERWNR S MCAUTO=MCAUTO+1 Q
 .... ..S IBAUTO=IBAUTO+1   ; non-Medicare responses
 Q
 ; 
TQINFO() ; get data from transmission queue (file 365.1)
 ; returns the following string, delimited by "^":
 ;   piece 1  - Number of queued 270 inquiries
 ;   piece 2  - Number of deferred 270 inquiries
 ;
 N INQD,INQQ,INQUIRY,INSTS,TQSTATUS
 S (INQD,INQQ)=0
 ;
 ; Queued inquiries (Ready to Transmit - 1/Retry - 6) and
 ; Deferred inquiries (Hold - 4)
 F INSTS=1,6,4 D
 .S INQUIRY=0 F  S INQUIRY=$O(^IBCN(365.1,"AC",INSTS,INQUIRY)) Q:'INQUIRY  D
 ..I INSTS'=4 S INQQ=INQQ+1 Q   ; counter for queued inquiries
 ..S INQD=INQD+1 ; counter for deferred inquiries
 ..Q
 .Q
 Q INQQ_U_INQD
 ;
PAYINFO() ; get data from payer (file 365.12) & insurance company (file #36)
 ; returns the following string, delimited by "^":
 ;   piece 1  - Number of insurance companies with no National ID
 ;   piece 2  - Number of locally disabled payers
 ;   piece 3  - Number of unlinked insurance companies
 ;
 N ACTIVE,APP,DATA,IDLIST,INSCO,INSTID,LOCDIS,NONATID,PAYER,PROFID,UNLINK
 S (LOCDIS,NONATID,UNLINK)=0
 ;
 ; Determine # of locally disabled payers
 ; loop through PAYER file
 S PAYER=0 F  S PAYER=$O(^IBE(365.12,PAYER)) Q:'PAYER  D
 .;I '$$ACTAPP^IBCNEUT5(PAYER) Q  ; no active payer applications
 .; Check for National ID
 .S DATA=^IBE(365.12,PAYER,0)
 .I $P(DATA,U,2)="" Q  ;Must have National ID
 .;
 .; Check for Locally Disabled
 .;IB*668/TAZ - Changed Payer Application from IIV to EIV
 .S APP=$$PYRAPP^IBCNEUT5("EIV",PAYER) I 'APP Q
 .S DATA=$G(^IBE(365.12,PAYER,1,APP,0))
 .I $P(DATA,U,2),'$P(DATA,U,3) S LOCDIS=LOCDIS+1 ; nationally active but locally disabled payers
 .Q
 ;
 ; Loop through INSURANCE COMPANY file for insurance companies not linked to a payer
 ; and insurance companies with No National ID 
 ; No National ID [defined by VA CBO as no EDI IDs fields (#36,3.02) & (#36,3.04) - 3/4/14]
 ; This is *Not* a check for the 'VA NATIONAL ID' associated with linked payer.
 ; 
 S INSCO=0 F  S INSCO=$O(^DIC(36,INSCO)) Q:'INSCO  D
 .S ACTIVE=$$ACTIVE^IBCNEUT4(INSCO) Q:'ACTIVE  I $$EXCLUDE^IBCNEUT4($P(ACTIVE,U,2)) Q  ; Exclude Medicaid, etc.
 .S PAYER=$P($G(^DIC(36,INSCO,3)),U,10)  ; associated payer
 .I 'PAYER S UNLINK=UNLINK+1             ; Not linked to a payer. Increment UNLINK
 .I ($$GET1^DIQ(36,INSCO_",",3.02)=""),($$GET1^DIQ(36,INSCO_",",3.04)="") S NONATID=NONATID+1
 .Q
 Q NONATID_U_LOCDIS_U_UNLINK
 ;
BUFINFO() ; get data from insurance buffer (file 355.33)
 ; DTTM - start date/time
 ;
 ; returns the following string, delimited by "^":
 ;   piece 1 - Number of Verified (*) buffer entries within last 24 hours ; IB*737/DTG stop use of '*' verified
 ;   piece 2 - Number of buffer entries indicated as having Active insurance (+) within last 24 hours
 ;   piece 3 - Number of buffer entries indicated as having Inactive insurance (-) within last 24 hours
 ;   piece 4 - Number of buffer entries indicated as policy status undetermined (#) within last 24 hours
 ;   piece 5 - Number of buffer entries indicated as requiring correction before 270 can be sent (!) within last 24 hours
 ;   piece 6 - Number of buffer entries awaiting processing within last 24 hours
 ;   piece 7 - Number of buffer entries indicated as waiting for a 271 response (?) within last 24 hours
 ;   piece 8 - Number of buffer entries entered by manual process with no further processing (blank) within last 24 hours 
 ;
 N ACTIVE,AMBIG,BUFF,DATE,ERROR,INACTIVE,MANUAL,PROCWAIT,RESPWAIT,STATUS,SYM,VERIFIED
 S (ACTIVE,AMBIG,ERROR,INACTIVE,MANUAL,PROCWAIT,RESPWAIT,VERIFIED)=0
 S DATE=0 F  S DATE=$O(^IBA(355.33,"AEST","E",DATE)) Q:DATE=""  D
 .S BUFF=0 F  S BUFF=$O(^IBA(355.33,"AEST","E",DATE,BUFF)) Q:BUFF=""  D
 ..S SYM=$$SYMBOL^IBCNBLL(BUFF)
 ..;I SYM="*" S VERIFIED=VERIFIED+1 Q  ; verified entries  ; IB*737/DTG stop use of '*' verified
 ..I SYM="+" S ACTIVE=ACTIVE+1 Q      ; active insurance
 ..I SYM="$" S ACTIVE=ACTIVE+1 Q      ; include "$" (Escalated entries) in with the active insurance  - IB*2.0*506 (vd)
 ..I SYM="-" S INACTIVE=INACTIVE+1 Q  ; inactive insurance
 ..I SYM="#" S AMBIG=AMBIG+1 Q        ; ambiguous response
 ..I SYM="!" S ERROR=ERROR+1 Q        ; entries requiring correction
 ..I SYM="?" S RESPWAIT=RESPWAIT+1 Q  ; awaiting response
 ..I SYM=" " S MANUAL=MANUAL+1        ; manually entered entries (no further processing)
 .S PROCWAIT=RESPWAIT+MANUAL          ; entries awaiting processing
 Q VERIFIED_U_ACTIVE_U_INACTIVE_U_AMBIG_U_ERROR_U_PROCWAIT_U_RESPWAIT_U_MANUAL
 ;
