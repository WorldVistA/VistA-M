IBCNEHL5A ;AITC/CKB - HL7 Process Incoming RPI Msgs (Cont.) ; 10-JAN-2025
 ;;2.0;INTEGRATED BILLING;**806,822**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; No direct calls allowed
 ;
LOAD(RIEN) ; Load Medicare policy as a new policy on patient record
 ; RIEN - IEN OF THE EIV REPONSE IN FILE #365
 ; 
 ; Only allowed to load Medicare (WNR) policies if the patient has no
 ; history of any MEDICARE (WNR) on file in #2.312 and if the patient has
 ; no other policies on file that meet a specific criteria and if the MEDICARE
 ; policy is active according to the Medicare payer's 271 eIV response
 ; 
 ; Returns 1 if at least 1 policy was loaded; otherwise, returns a zero
 ;
 ; ** DEVELOPER: This tag purposely locks the patient's insurance subfile as we don't want
 ;               anything loading insurance to the patient's record while we are evaluating.
 ;               This checks if the patient's record meets the requirements to allow Medicare
 ;               Part A and B to be loaded automatically to the patient's record.
 ;
 N ACTIVE,CONTINUE,DFN,ELIG,GRPNUM,IBNEW,IENS,INSRIEN,MWNRIEN,MWNRTYP,MWNRA,MWNRB
 N PIEN,POLCT,POLEFF,POLICY,POLTERM,RDATA0,SOI,TQN
 ;
 K ACTIVE,LOAD,POLICY
 S (LOAD,MWNRTYP,POLCT)=0,(MWNRA,MWNRB)=""
 S RDATA0=$G(^IBCN(365,RIEN,0))
 S PIEN=$P(RDATA0,U,3)
 S TQN=$P(RDATA0,U,5)
 I TQN'="" S SOI=$$GET1^DIQ(365.1,TQN_",",3.02,"I")
 ; If SOI is null, hardcoded it to '5' for eIV - SOI should never be null, this is a safety valve 
 I SOI="" S SOI=5
 S MWNRIEN=$P($G(^IBE(350.9,1,51)),U,25)
 I PIEN=MWNRIEN S MWNRTYP=$$ISMCR^IBCNEHLU(RIEN)
 I 'MWNRTYP G XLOAD  ; Did not load policy as a new policy to patient record
 ;
 S DFN=$P(RDATA0,U,2),CONTINUE=1
 L +^DPT(DFN,.312):90 I '$T S CONTINUE=0 G XLOAD  ;LOCK ins subfile
 ;
 S INSRIEN=0 F  S INSRIEN=$O(^DPT(DFN,.312,INSRIEN)) Q:'INSRIEN!('CONTINUE)  D
 . S IENS=INSRIEN_","_DFN
 . ; If external name of (#2.312,.01)="MEDICARE (WNR)" S CONTINUE=0 Q
 . I $$GET1^DIQ(2.312,IENS,.01)="MEDICARE (WNR)" S CONTINUE=0 Q
 . S POLEFF=$$GET1^DIQ(2.312,IENS,8,"I")
 . S POLTERM=$$GET1^DIQ(2.312,IENS,3,"I")
 . I POLEFF>DT S CONTINUE=0 Q
 . I POLEFF="",((POLTERM="")!(POLTERM>DT)) S CONTINUE=0 Q
 . ; Regardless if expiration is null, today, future or bad date
 . I (POLTERM="")!(POLTERM>(DT-1))!($$VALIDDT^IBCNINSU(POLTERM)=-1) S CONTINUE=0 Q
 . ; Bad POLEFF and POLTERM is bad,null, today or future
 . I ($$VALIDDT^IBCNINSU(POLEFF)=-1),(POLTERM'<DT) S CONTINUE=0 Q
 ;
 I 'CONTINUE G XLOAD  ; Existing policies on file doesn't allow us to add this policy to patient record
 ;
 ;Get list of insurance identified in the EB loops of the 271 payer response
 D EBSUMMARY^IBCNEUT2(DFN,RIEN,SOI,.POLICY)
 ;
 I '$O(POLICY(0)) G XLOAD           ;IB*822 - if none was returned on payer response (safety valve)
 I $D(POLICY(1,"Unknown")) G XLOAD  ;if none was returned on payer response (safety valve)
 I $G(POLICY("OHI"))=1 G XLOAD      ;Indicates Other potential insurance indicated on payer response
 ;If the Medicare Policy in the Response is missing the Effective Date, don't load ANY Medicare policies
 I $G(POLICY("MISSING_EFFDT"))=1 G XLOAD
 ;
 ;Loop through list of insurance (.POLICY) and keep only ACTIVE policies (according to the payer's response)
 ; Only add 'Active' policies to the ACTIVE array - ACTIVE(GRPNUM)=DFN_U_GRPNUM_U_EFFDT_U_SOI_U_ELIG
 S POLCT="" F  S POLCT=$O(POLICY(POLCT)) Q:POLCT=""  D
 . S GRPNUM="" F  S GRPNUM=$O(POLICY(POLCT,GRPNUM)) Q:GRPNUM=""  D
 . . I $TR(GRPNUM,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")'["MEDICARE" Q
 . . S ELIG=$P(POLICY(POLCT,GRPNUM),U,5)   ; ELIG='Inactive' or 'Active Coverage'
 . . I $TR(ELIG,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")["INACTIVE" Q
 . . S ACTIVE(GRPNUM)=POLICY(POLCT,GRPNUM)
 ;
 ;Loop through the ACTIVE policies, determine what policy(s) can be added to the patient record
 ;     GRPNUM ='Medicare Part A' or 'Medicare Part B'
 S GRPNUM="" F  S GRPNUM=$O(ACTIVE(GRPNUM)) Q:GRPNUM=""  D
 . N IBCDFN,IBCOVP,IBCPOL,IBCDFN,IBEVTACT,IBEVTP0,IBEVTP1,IBEVTP2,IBEVTP3,IBEVTP7,IBNEW
 . ; Note: SAVEMWR calls BEFORE^IBCNSEVT
 . S LOAD=$$SAVEMWR(RIEN)
 . ;
 . ;Check to see if patient is 'COVERED BY HEALTH INSURANCE?' regardless of what LOAD is set to.
 . ; It is possible that a policy could have been partially loaded (LOAD=0) and should be evaluated.
 . S IBCOVP=$$GET1^DIQ(2,DFN_",",.3192,"I")           ;COVERED BY INSURANCE?
 . S IBCPOL=$$GET1^DIQ(2.312,IBCDFN_","_DFN,.18,"I")  ;GROUP PLAN
 . D COVERED^IBCNSM31(DFN,IBCOVP) ;this code updates field (#2,.3192)
 . ;
 . ;IBCNSEVT calls the protocol IBCN NEW INSURANCE EVENTS which in turn calls the following
 . ; protocols: IBCN INSURANCE BULLETIN, IVM INSURANCE EVENT and VPR IBCN EVENTS
 . ; Note: the protocol IBCN INSURANCE BULLETIN deletes field NO VERIFICATION DATE (#354,60)
 . I $G(IBCDFN)>0 D AFTER^IBCNSEVT,^IBCNSEVT
 . Q
 ;
XLOAD ;
 D MWRUNLOCK   ; unlock ins subfile
 Q LOAD
 ;
 ;--------------------------------------------------
 ;
SAVEMWR(RIEN) ;autoload of Medicare policy(s)
 ; The logic in this tag is from AUTOFIL^IBCNEHL5, with minor modifications for Medicare autoload
 ;
 ;INPUT:
 ;   RIEN - IEN of file #365 IIV RESPONSE 
 ;
 ;    DFN - IEN in file #2
 ; IEN312 - IEN in file #2.312
 ;  EFFDT - Effective Date of Policy (in FileMan format)
 ;    SOI - Source of Information
 ;
 N ADDFLG,DATA,DFN,DOBCMT,EFFDT,ERFLG,ERROR,IBAUUSR,IBEIVUSR,IBFLDS,IBIFN,IBINS,IBGRP,IBMSG,IENS,IEN312
 N MGRP,PTLOAD,SOI,TQN
 ;
 S PTLOAD=1
 I (RIEN="") S PTLOAD=0 G SAVEMWRX
 S MGRP=$$MGRP^IBCNEUT5()
 ;
 N RDATA0,RDATA1,RDATA4,RDATA5,RDATA12,RDATA13
 S DFN=$P(ACTIVE(GRPNUM),U)
 S EFFDT=$P(ACTIVE(GRPNUM),U,3)
 S SOI=$P(ACTIVE(GRPNUM),U,4)
 S ADDFLG=365
 ; Required fields needed to save the policy 
 I ($G(DFN)="")!($G(GRPNUM)="")!($G(EFFDT)="")!($G(SOI)="") S PTLOAD=0 G SAVEMWRX
 ; Get data from the eIV Response
 S RDATA0=$G(^IBCN(365,RIEN,0)),RDATA1=$G(^IBCN(365,RIEN,1))
 S RDATA4=$G(^IBCN(365,RIEN,4)),RDATA5=$G(^IBCN(365,RIEN,5))
 S RDATA12=$G(^IBCN(365,RIEN,12)),RDATA13=$G(^IBCN(365,RIEN,13))
 S TQN=$P(RDATA0,U,5)
 ; Get other required data
 S (IBINS,IBGRP,IBAUUSR,IBEIVUSR)=""
 S IBINS=$O(^DIC(36,"B","MEDICARE (WNR)",""))
 ;find the Medicare Group Plan - Part A or Part B. There could be more than 1 Part A or Part B
 I IBINS'="" D GETGRP
 S IBAUUSR=$O(^VA(200,"B","AUTOUPDATE,IBEIV",""))
 S IBEIVUSR=$O(^VA(200,"B","INTERFACE,IB EIV",""))
 I (IBINS="")!(IBGRP="")!(IBAUUSR="")!(IBEIVUSR="") S PTLOAD=0 G SAVEMWRX
 ;
 ; --Medicare Required fields--
 ; Add a new patient policy
 K DA,DD,DIC,DO,X,Y
 S DIC("DR")=".01///"_IBINS_";.18///"_IBGRP_";1.01///NOW;1.02///"_IBEIVUSR_";1.05///NOW"
 S DA(1)=DFN,DIC="^DPT("_DFN_",.312,",DIC(0)="L",X=IBINS
 D FILE^DICN S (IEN312,IBCDFN)=+Y,IBNEW=1
 D BEFORE^IBCNSEVT    ;this sets variables that will be used in COVERED
 S IENS=IEN312_","_DFN_","
 ;
 K DATA
 S DATA(2.312,IENS,.2)=1    ;'1' for PRIMARY
 S DATA(2.312,IENS,4.03)=18 ;'18' for SELF
 S DATA(2.312,IENS,1.09)=SOI             ;SOURCE OF INFORMATION (from 270 Inquiry)
 S DATA(2.312,IENS,7.02)=$P(RDATA13,U,2) ;SUBSCRIBER ID
 ;IB*822/CKB - added PATIENT ID (same as the SUBSCRIBER ID)
 S DATA(2.312,IENS,5.01)=$P(RDATA13,U,2) ;PATIENT ID
 S DATA(2.312,IENS,8)=EFFDT              ;EFFECTIVE DATE
 ; --Medicare - Optional fields on 271 Payer Response--
 S DATA(2.312,IENS,6)="v"                ;WHOSE INSURANCE - 'v' for VETERAN
 S DATA(2.312,IENS,7.01)=$P(RDATA13,U)   ;NAME OF INSURED
 ;IB*822/CKB - added STOP POLICY FROM BILLING
 S DATA(2.312,IENS,3.04)=1               ;STOP POLICY FROM BILLING - '1' for YES
 ;
 ; Get DOB from 271 Payer Response, if null pull from the PATIENT file
 N PRDOB S PRDOB=$P(RDATA1,U,2)
 S DATA(2.312,IENS,3.01)=$S(PRDOB'="":PRDOB,1:$$GET1^DIQ(2,DFN_",",.03))
 ;
 ; if DOB from 271 Payer Response DOESN'T match the DOB on the PATIENT file, then store
 ;  the DOB from the 271 and add a patient policy comment indicating there is a difference
 I PRDOB'="" I PRDOB'=$$GET1^DIQ(2,DFN_",",.03,"I") D
 . S DATA(2.312,IENS,3.01)=PRDOB
 . S DOBCMT="The DOB on the Patient record is "_$$GET1^DIQ(2,DFN_",",.03)_". The DOB on the eIV Payer Response, which was saved to the insurance record, is "_$$FMTE^XLFDT(PRDOB,5)_"."
 . D ADDCOM(DFN,IEN312,DOBCMT)
 ;
 ; Get SEX from 271 Payer Response, if null pull from the PATIENT file
 S DATA(2.312,IENS,3.12)=$S($P(RDATA1,U,4)'="":$P(RDATA1,U,4),1:$$GET1^DIQ(2,DFN_",",.02))
 ;
 ; Get Address from 271 Payer Response - the Response MUST contain Address Line 1,
 ;  City, State, Zip. Otherwise pull from PATIENT file
 I ($P(RDATA5,U)="")!($P(RDATA5,U,3)="")!($P(RDATA5,U,4)="")!($P(RDATA5,U,5)="") S ADDFLG=2
 I ADDFLG=365 D
 . S DATA(2.312,IENS,3.06)=$P(RDATA5,U)   ;Street line 1
 . S DATA(2.312,IENS,3.08)=$P(RDATA5,U,3) ;City
 . S DATA(2.312,IENS,3.09)=$P(RDATA5,U,4) ;State
 . S DATA(2.312,IENS,3.1)=$P(RDATA5,U,5)  ;Zip
 . ;IB*822/CKB - added the following fields. Note these are NOT required fields
 . S DATA(2.312,IENS,3.07)=$P(RDATA5,U,2) ;Street 2
 . S DATA(2.312,IENS,3.13)=$P(RDATA5,U,6) ;Country 
 I ADDFLG=2 D
 . S DATA(2.312,IENS,3.06)=$$GET1^DIQ(2,DFN_",",.111) ;Street line 1
 . S DATA(2.312,IENS,3.08)=$$GET1^DIQ(2,DFN_",",.114) ;City
 . S DATA(2.312,IENS,3.09)=$$GET1^DIQ(2,DFN_",",.115) ;State
 . S DATA(2.312,IENS,3.1)=$$GET1^DIQ(2,DFN_",",.116)  ;Zip
 . ;IB*822/CKB - added the following fields. Note these are NOT required fields
 . S DATA(2.312,IENS,3.07)=$$GET1^DIQ(2,DFN_",",.112)  ;Street 2
 . S DATA(2.312,IENS,3.13)=$$GET1^DIQ(2,DFN_",",.1173) ;Country
 ;
 ; --Medicare - other fields from 271 Payer Response--
 N XX
 ;IB*822/CKB - changed RDATA4 & RDATA5 and moved the setting of Street 2 & Country above 
 S XX=$P(RDATA5,U,9)
 I XX'="" S DATA(2.312,IENS,3.14)=XX       ;Country subdivision
 S XX=$P(RDATA12,U)
 I XX'="" S DATA(2.312,IENS,12.01)=XX      ;Military Info Status Code
 S XX=$P(RDATA12,U,7)
 I XX'="" S DATA(2.312,IENS,12.07)=XX      ;Date Time Period
 ;
 I $D(DATA) D FILE^DIE("","DATA","ERROR")
 I $D(ERROR) D WARN^IBCNEHL3 K ERROR D FIL^IBCNEHL1 S PTLOAD=0 G SAVEMWRX
 K DATA
 S DATA(2.312,IENS,1.03)=$$NOW^XLFDT       ;DATE LAST VERIFIED
 S DATA(2.312,IENS,1.04)=IBAUUSR           ;VERIFIED BY - AUTOUPDATE,IBEIV
 S DATA(2.312,IENS,1.06)=IBAUUSR           ;LAST EDITED BY - AUTOUPDATE,IBEIV
 D FILE^DIE("","DATA","ERROR")
 I $D(ERROR) D WARN^IBCNEHL3 Q
 ;
 ; Set the insurance record IEN in the IIV Response file to track
 ; which policy was updated based on the response
 D UPDIREC^IBCNEHL3(RIEN,IEN312)
 ;
 ; Set the EIV AUTO-LOAD field (#.16) in the response file #365 to '1' for "YES" to indicate auto load occurred 
 K DATA
 S DATA(365,RIEN_",",.16)=1
 D FILE^DIE("","DATA")
 ;
 ; File data at 2.312, 9, 10 & 11 subfiles; if error is produced update buffer entry & then quit processing
 S ERFLG=$$GRPFILE^IBCNEHL1(DFN,IEN312,RIEN,1)
 I $G(ERFLG) Q
 ;
 ; File new EB data
 S ERFLG=$$EBFILE^IBCNEHL1(DFN,IEN312,RIEN,1)
 I $G(ERFLG) Q   ;bail out if something went wrong during filing of EB data
 ;
 ; File Auto Updated policy in INTERFACILITY INSURANCE UPDATE File (#365.19)
 ; IBCNBAR added a field the param list when calling LOC^IBCNIUF. For consistency we added a 'null'.
 D LOC^IBCNIUF(DFN,$$GET1^DIQ(2.312,IEN312_","_DFN_",",.01,"I"),IEN312,$$GET1^DIQ(365,RIEN_",",.13,"I"),"",$$GET1^DIQ(365.1,TQN_",",3.02,"E"),"")
 ;
 ; Get the buffer entry from the IIV RESPONSE File (#365)
 S BUFF=+$P($G(^IBCN(365,RIEN,0)),U,4)
 ;
 ; If there is a Buffer entry associated with the Response and it is already processed,
 ; DO NOT touch/update files #355.33 or #355.36
 I BUFF,$$GET1^DIQ(355.33,BUFF,.04,"I")'="E" S PTLOAD=0 G SAVEMWRX
 ;
 ; Update the buffer status to ACCEPTED, then call DELDATA^IBCNBED so only the stub remains 
 I BUFF D
 . D STATUS^IBCNBEE(BUFF,"A",0,0,1) ;update status to accepted
 . ;save auto update user to buffer
 . S IBIFN=BUFF_"," K IBARR
 . S IBARR(355.33,IBIFN,.06)=$G(IBEIVUSR)
 . D FILE^DIE("","IBARR")
 . D DELDATA^IBCNBED(BUFF) ;delete buffer's insurance/patient data
 ;
 ; File data to #355.36 file.
 N BUFF,ERROR,FDA,WE
 S WE=$$GET1^DIQ(365.1,TQN_",",.1,"I")
 S BUFF=$$GET1^DIQ(365,RIEN_",",.04,"I")
 S FDA(355.36,"+1,",.01)=$$NOW^XLFDT ;Date Processed
 S FDA(355.36,"+1,",.02)=$S("^6^"[(U_WE_U):3,"^1^"[(U_WE_U):1,1:"") ;"WE" can only be a 1 or a 6 at this point
 S FDA(355.36,"+1,",.03)=$$GET1^DIQ(365.1,TQN_",",3.02,"I") ;Source of Information
 S FDA(355.36,"+1,",.05)=TQN            ;EIV Inquiry
 S FDA(355.36,"+1,",.06)=RIEN           ;EIV Response
 S FDA(355.36,"+1,",.07)=BUFF           ;Buffer
 S FDA(355.36,"+1,",.08)=WE             ;Source of Request (Which Extract)
 S FDA(355.36,"+1,",.09)=$$GET1^DIQ(365,RIEN_",",.16,"I") ;EIV Auto-load
 D UPDATE^DIE("","FDA",,"ERROR")
 I $D(ERROR) D
 . D MSG003^IBCNEMS1(.IBMSG,.ERROR,TQN,RIEN,BUFF)
 . D MSG^IBCNEUT5($$MGRP^IBCNEUT5(),"eIV Problem: Error writing to the CREATION TO PROCESSING TRACKING File (#355.36)","IBMSG(")
 ;
SAVEMWRX ;
 Q PTLOAD
 ;
MWRUNLOCK ;unlock ins subfile
 L -^DPT(DFN,.312)
 Q 
 ;
GETGRP  ;find the Medicare Group Plan - Part A or Part B
 N FOUND,GIEN
 S FOUND=0
 S GIEN="" F  S GIEN=$O(^IBA(355.3,"B",IBINS,GIEN)) Q:(GIEN="")!(FOUND=1)  D
 . I $G(^IBA(355.3,GIEN,0))="" Q
 . I $P(^IBA(355.3,GIEN,0),U,3)=$S(GRPNUM="Medicare Part A":"PART A",1:"PART B") S FOUND=1,IBGRP=GIEN
 Q
 ;
ADDCOM(IBDFN,IBPOLDA,IBPOLCOM) ;
 ; Add new patient policy comment (2.312, 1.18) Multiple #2.342
 N CIEN,FDA
 ;
 ;To keep the Patient Policy Comment trigger from looping and creating two entries
 ; we need to set DUZ to the INTERFACE,IB EIV user (IBEIVUSR)
 I +$G(IBEIVUSR)'=0 N DUZ S DUZ=$G(IBEIVUSR)
 ;
 ; -- populate FDA array
 S CIEN="+1"_","_IBPOLDA_","_IBDFN_","
 S FDA(2.342,CIEN,.01)=$$NOW^XLFDT()
 S FDA(2.342,CIEN,.02)=DUZ
 S FDA(2.342,CIEN,.03)=IBPOLCOM
 ; -- add comments
 D UPDATE^DIE(,"FDA")
 Q
