IBCNEUT7 ;DAOU/ALA - IIV MISC. UTILITIES ;14-OCT-2015
 ;;2.0;INTEGRATED BILLING;**184,549,579,582,601**;21-MAR-94;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program contains some general utilities or functions
 ; IB*2*601/DM XMITOK() Gate-keeper routine moved to IBCNETST
 ;
 Q
 ;
DEATH(DFN,DOD)   ;EP
 ; IB*2.0*549 added method
 ; Sets the INSURANCE EXPIRATION DATE (file 2.3121, field ) for all active
 ; insurances of the selected patient to be the date of death +1
 ; Input:   DFN     - IEN of the patient to term insurances for
 ;          DOD     - Internal date of death (file 2, field .351) of the patient
 N MTIME,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 S MTIME=$$NOW^XLFDT()                      ; Fileman date/time
 S ZTDTH=$$FMTH^XLFDT(MTIME)                ; Convert to $H format
 ;
 ; Set up the other TaskManager variables
 S ZTRTN="DEATH2^IBCNEUT7"
 S ZTDESC="eIV Auto Termination of Policies for deceased patients"
 S ZTIO=""
 S ZTSAVE("DFN")="",ZTSAVE("DOD")=""
 D ^%ZTLOAD ; Call TaskManager
 Q
 ;
DEATH2 ;EP from TaskMan
 ; IB*2.0*549 added method
 ; Sets the INSURANCE EXPIRATION DATE (file 2.3121, field ) for all active
 ; insurances of the selected patient to be the date of death +1
 ; IB*2.0*579 - Also sets the 'COVERED BY HEALTH INSURANCE' to 'N' (file 2, field .3192)
 ;              if it's not already set to 'N'
 ; Input:   DFN     - IEN of the patient to term insurances for
 ;          DOD     - Internal date of death (file 2, field .351) of the patient
 N EXPDT,DA,DEACT,DODX,FDA,HCOV,IBIEN                ; IB*2.0*579 - added DEACT,HCOV
 S DEACT=0                                           ; IB*2.0*579 - added line
 S DODX=$P($$FMADD^XLFDT(DOD,1),".",1)               ; Date of Death +1
 S IBIEN=0
 F  S IBIEN=$O(^DPT(DFN,.312,IBIEN)) Q:+IBIEN=0  D
 . S EXPDT=$$GET1^DIQ(2.312,IBIEN_","_DFN_",",3,"I") ; Policy Expiration Date
 . Q:EXPDT'=""                                       ; Policy has an expiration date
 . L +^DPT(DFN,.312,IBIEN):5
 . I '$T D  Q                                        ; Send email IB SUPERVISOR users
 . . N EDT,MLGRP,MSG,PNM,SSN,SUBJECT,XMY
 . . S SUBJECT="eIV: Policy Expiration for deceased patient"
 . . S MLGRP=$$MGRP^IBCNEUT5
 . . S PNM=$$GET1^DIQ(2,DFN,.01)
 . . S EDT=$$FMTE^XLFDT(DODX,"2DZ")
 . . S SSN=$$GET1^DIQ(2,DFN,.09),SSN=$E(SSN,6,9)
 . . S MSG(1)=PNM_" "_SSN_" was just marked as deceased. Action Needed:"
 . . S MSG(2)=" Update the patient's active policies and enter and expiration date of "_EDT_"."
 . . D GETPER("IB SUPERVISOR",.XMY)
 . . D MSG^IBCNEUT5(MLGRP,SUBJECT,"MSG(",,.XMY)
 . ;
 . ; Set Policy expiration date to be date of death +1
 . S DEACT=1                                        ; IB*2.0*579 - added line
 . K DA,FDA
 . S DA=IBIEN,DA(1)=DFN
 . S FDA(2.312,DA_","_DA(1)_",",1.05)=$$NOW^XLFDT() ; Date Last Edited
 . S FDA(2.312,DA_","_DA(1)_",",1.06)=.5            ; Last Edited By
 . S FDA(2.312,DA_","_DA(1)_",",3)=DODX             ; Date of Death +1
 . D FILE^DIE("","FDA")
 . L -^DPT(DFN,.312,IBIEN)
 ;
 ; IB*2.0*579 - added if statement below
 ; If any policies were expired and the Covered by Health Insurance flag is set to 'Y'.
 ; change it to 'N'
 I DEACT D
 . S HCOV=$$GET1^DIQ(2,DFN_",",.3192,"I")
 . Q:HCOV'="Y"                              ; Already set to 'N'
 . N IBSUPRES
 . S IBSUPRES=1
 . D COVERED^IBCNSM31(DFN,HCOV)             ; Set the Health Coverage flag to 'N'
 Q
 ;
GETPER(SECKEY,XMY) ;EP
 ; IB*2.0*549 Added method
 ; Returns a list of users with the specified security key
 ; Input: SECKEY - Security key to search for
 ; Output: XMY() - Array email addresses for users who have the specified key
 N XUSIEN,X
 S XUSIEN=0
 F  S XUSIEN=$O(^XUSEC(SECKEY,XUSIEN)) Q:'XUSIEN  D
 . ;
 . ; Don't return TERMINATED or DISUSERed users
 . S X=$$ACTIVE^XUSER(XUSIEN)
 . I X=""!($P(X,"^",1)=0) Q
 . ;
 . ; Put users emails into output array
 . S XMY(XUSIEN)=""
 Q
 ;
FTFIC(IBIEN,MDCALL) ;EP
 ; IB*2.0*549 added function
 ; Returns Timely Filing Timeframe text for a specified Insurance Company
 ; translate fields 36,.18 and 36,.19 to agreed upon displayed text for
 ; Insurance company Reports
 ; Input:   IBIEN   - IEN of the insurance company to get data from
 ;          MDCALL - 1 if being called from the Missing Data Report
 ;                   0 otherwise. Optional, defaults to 0
 ; Returns: Timely Filing Timeframe text for the specified Insurance Company
 ;          NOTE: If MDCALL=1 null Standard FTF Values and Qualifiers are 
 ;                as '###' instead of null or 'UNKNOWN' respectively
 N FTF,FTFV
 S:'$D(MDCALL) MDCALL=0
 Q:'$D(IBIEN) ""
 S FTF=$$GET1^DIQ(36,IBIEN_",",.18,"I")     ; Standard FTF IEN (file 355.13)
 S FTFV=$$GET1^DIQ(36,IBIEN_",",.19,"I")    ; Standard FTF Value
 Q $$FTFMAP(FTF,FTFV,MDCALL)
 ;
FTFGP(GIEN,MDCALL) ;EP
 ; IB*2.0*549 added function
 ; Returns Timely Filing Timeframe text for a specified Group Insurance Plan
 ; translate fields 355.3,.16 and 355.3,.17 to agreed upon displayed text for
 ; Insurance company Reports
 ; Input:   GIEN   - IEN of the group insurance plan to get data from
 ;          MDCALL - 1 if being called from the Missing Data Report
 ;                   0 otherwise. Optional, defaults to 0
 ; Returns: Timely Filing Timeframe text for the specified Group Insurance Plan
 ;          NOTE: If MDCALL=1 null Standard FTF Values and Qualifiers are 
 ;                as '###' instead of null or 'UNKNOWN' respectively
 N FTF,FTFV,XX,ZZ
 S:'$D(MDCALL) MDCALL=0
 Q:'$D(GIEN) ""
 S FTF=$$GET1^DIQ(355.3,GIEN_",",.16,"I")   ; Standard FTF IEN (file 355.13)
 S FTFV=$$GET1^DIQ(355.3,GIEN_",",.17,"I")  ; Standard FTF Value
 Q $$FTFMAP(FTF,FTFV,MDCALL)
 ;
FTFMAP(FIEN,FTFV,MDCALL) ; Returns Timely Filing Text for the specified Standard FTF
 ; and Standard FTF Value
 ;IB*2.0*549 added function
 ; Input:   FIEN   - IEN of the Standard FTF (filer 355.13)
 ;          MDCALL - 1 if being called from the Missing Data Report
 ;                   0 otherwise. Optional, defaults to 0
 ; Output:  FTFV    - Standard FTF Value
 ; Returns: Timely Filing Timeframe text
 N FTF
 S:'$D(MDCALL) MDCALL=0
 I MDCALL,FTFV="" S FTFV="###"
 S FTF=$$GET1^DIQ(355.13,FIEN_",",.01)       ; Standard FTF name
 Q:FTF="" FTFV_" ("_$S(MDCALL:"###",1:"UNKNOWN")_")"
 Q:FTF="DAYS" FTFV_" (DYS)"
 Q:FTF="DAYS OF FOLLOWING YEAR" FTFV_" (DYS OF NEXT YR)"
 Q:FTF="DAYS PLUS ONE YEAR" FTFV_" (DYS_1 YR)"
 Q:FTF="END OF FOLLOWING YEAR" FTFV_" (END OF NEXT YR)"
 Q:FTF="MONTH(S)" FTFV_" (MOS)"
 Q:FTF="MONTHS OF FOLLOWING YEAR" FTFV_" (MOS OF NEXT YR)"
 Q:FTF="NO FILING TIME FRAME LIMIT" FTFV_" (N/A)"
 Q:FTF="YEAR(S)" FTFV_" (YRS)"
 Q FTFV_" ("_$S(MDCALL:"###",1:"UNKNOWN")_")"
 ;
RSTA(REC) ; Update status in Response File from Transmission Queue to
 ;         Communication Timeout
 ;  Input Parameters
 ;    REC = IEN from TQ file
 ;    -- Removed 10/29/02 --WCH = Which Record 'P'=Previous, 'C'=Current
 ;    -- if no Which Record passed, it will assume the current one
 ;
 N HIEN,RIEN
 S HIEN=0
 ; Loop thru HL7 messages associated with the IIV Inquiry
 F  S HIEN=$O(^IBCN(365.1,REC,2,HIEN)) Q:'HIEN  D
 .  ; Determine IIV Response associated with the HL7 message
 .  S RIEN=$P($G(^IBCN(365.1,REC,2,HIEN,0)),U,3) Q:'RIEN
 .  ; If IIV Response status is 'Response Received', don't update it
 .  I $P($G(^IBCN(365,RIEN,0)),U,6)=3 Q
 .  ; Update IIV Response status to 'Communication Timeout'
 .  D RSP^IBCNEUT2(RIEN,5)
 .  Q
 ;
 Q
 ;
TXT(TXT) ;Parse text for wrapping
 ;  Input Parameter
 ;   TXT = The array name
 ;
 I '$D(@(TXT)) Q
 ;
 K ^UTILITY($J,"W")
 ;
 ;  Define length of text string; left is 1 and right is 78
 S DIWF="",DIWL=1,DIWR=78
 ;
 ;  Format text into scratch file
 S CT=0
 F  S CT=$O(@(TXT)@(CT)) Q:'CT  D
 . S X=@TXT@(CT) D ^DIWP
 ;
 K @(TXT)
 ;
 ;  Reset formatted text back to array
 S CT=0
 F  S CT=$O(^UTILITY($J,"W",1,CT)) Q:'CT  D
 . S @(TXT)@(CT)=^UTILITY($J,"W",1,CT,0)
 ;
 K ^UTILITY($J,"W"),CT,DIWF,DIWL,DIWR,X,Z,DIW,DIWI,DIWT,DIWTC,DIWX,DN,I
 Q
 ;
ERRN(ARRAY) ;  Get the next FileMan error number from the array
 ;  Input
 ;    ARRAY = the array name, include "DIERR"
 ;  Output
 ;    IBEY = the next error number
 ;
 ;  Example call
 ;    S IERN=$$ERRN^IBCNEUT7("ERROR(""DIERR"")")
 ;
 NEW IBEY
 ;
 I '$D(@(ARRAY)) S @(ARRAY)=1 Q 1
 ;
 S IBEY=$P(@(ARRAY),U,1)
 S IBEY=IBEY+1,$P(@(ARRAY),U,1)=IBEY
 Q IBEY
 ;
MBICHK(BUFFIEN) ; See if the buffer entry is an MBI request
 ; return 1 if the provided buffer is an MBI request; otherwise, 0
 N IBINSNM
 S IBINSNM=$$GET1^DIQ(355.33,BUFFIEN_",","INSURANCE COMPANY NAME")
 I IBINSNM="" Q 0
 Q +($$GET1^DIQ(350.9,"1,","MBI PAYER")=IBINSNM)
