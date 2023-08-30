IBCNEHL5 ;DALOI/KML - HL7 Process Incoming RPI Msgs (cont.) ; 1-APRIL-2013
 ;;2.0;INTEGRATED BILLING;**497,549,702,743**;21-MAR-94;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 Q  ; No direct calls
 ;
GZRF(ERROR,IBSEG,RIEN) ; Process Group level ZRF Reference identification segment (x12 loops 2100C and 2100D)
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N IENSTR,RSUPDT,QUAL,VALUE
 S IENSTR="+1,"_RIEN_","
 S RSUPDT(365.09,IENSTR,.01)=+$O(^IBCN(365,RIEN,9,"B",""),-1)+1  ; node 9 sequence #
 ; Reference id & qualifier
 S QUAL=$P($G(IBSEG(3)),HLCMP),VALUE=$G(IBSEG(4))
 I VALUE'="",QUAL'="" S RSUPDT(365.09,IENSTR,.02)=VALUE,RSUPDT(365.09,IENSTR,.03)=QUAL
 S RSUPDT(365.09,IENSTR,.04)=$G(IBSEG(5)) ; Description
 D CODECHK^IBCNEHLU(.RSUPDT)  ;check for new coded values
 D UPDATE^DIE("E","RSUPDT",,"ERROR")
 Q
 ;
ZMP(ERROR,IBSEG,RIEN) ; Process Military Personnel Information that comes from X12 271 MPI segment of the 2100C and 2100D loops 
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N IENSTR,RSUPDT,QUAL,VALUE
 S IENSTR=RIEN_","
 S RSUPDT(365,IENSTR,12.01)=$G(IBSEG(3))  ; information status code
 S RSUPDT(365,IENSTR,12.02)=$G(IBSEG(4))  ; employment status code
 S RSUPDT(365,IENSTR,12.03)=$G(IBSEG(5))  ; government service affiliation code
 S RSUPDT(365,IENSTR,12.04)=$G(IBSEG(6))  ; description
 S RSUPDT(365,IENSTR,12.05)=$G(IBSEG(7))  ; Military service rank code
 ;Date time period format qualifier and Date time period
 S QUAL=$P($G(IBSEG(8)),HLCMP),VALUE=$G(IBSEG(9))
 I VALUE'="",QUAL'="" S RSUPDT(365,IENSTR,12.06)=QUAL,RSUPDT(365,IENSTR,12.07)=VALUE
 D CODECHK^IBCNEHLU(.RSUPDT)  ;check for new coded values
 D UPDATE^DIE("E","RSUPDT",,"ERROR")
 Q
 ;
ROL(ERROR,IBSEG,RIEN) ; process group level Provider Information in the X12 271 PRV segment of X12 loops: 2100B, 2100C, 2100D
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N IENSTR,RSUPDT,QUAL,VALUE
 S IENSTR="+1,"_RIEN_","
 S RSUPDT(365.04,IENSTR,.01)=+$O(^IBCN(365,RIEN,10,"B",""),-1)+1  ; node 10 sequence #
 S RSUPDT(365.04,IENSTR,.02)=$P($G(IBSEG(4)),HLCMP)   ; provider code
 S RSUPDT(365.04,IENSTR,.03)=$P($G(IBSEG(5)),HLCMP)   ; reference ID
 D CODECHK^IBCNEHLU(.RSUPDT)  ;check for new coded values
 D UPDATE^DIE("E","RSUPDT",,"ERROR")
 Q
 ;
DG1(ERROR,IBSEG,RIEN) ; process DIAGNOSIS codes in the X12 271 HI segment of X12 loops: 2100C, 2100D
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N IENSTR,RSUPDT,DCODE
 S IENSTR="+1,"_RIEN_","
 S RSUPDT(365.01,IENSTR,.01)=+$O(^IBCN(365,RIEN,11,"B",""),-1)+1  ; node 11 sequence #
 S DCODE=$P($G(IBSEG(4)),HLCMP)
 S RSUPDT(365.01,IENSTR,.02)=$E(DCODE,1,3)_"."_$E(DCODE,4,99)  ; diagnosis code
 S RSUPDT(365.01,IENSTR,.03)=$P($G(IBSEG(4)),HLCMP,3)          ; diagnosis code qualifier
 S RSUPDT(365.01,IENSTR,.04)=$S($P($G(IBSEG(16)),HLCMP)=1:"P",1:"S")  ; primary or secondary diagnosis code
 I $D(RSUPDT) D UPDATE^DIE("E","RSUPDT",,"ERROR")
 Q
 ;
EBFILE(DFN,IEN312,RIEN,AFLG) ;EP
 ; File eligibility/benefit data from file 365 into file 2.312
 ; IB*2.0*549 moved method from IBCNEHL1 because of routine size limitations
 ; Input:   DFN     - Internal Patient IEN
 ;          IEN312  - Insurance multiple #
 ;          RIEN    - file 365 ien
 ;          AFLG    - 1 if called from autoupdate
 ;                    0 if called from ins. buffer process entry
 ; Returns: "" on success, ERFLG on failure. Also called from ACCEPT^IBCNBAR
 ;          for manual processing of ins. buffer entry.
 ;
 ;
 N DA,DIK,DATA,DATA1,EBIENS,ERFLG,ERROR,GIEN,GSKIP,IENROOT,IENS,IENSTR,TYPE,TYPE1,Z,Z1,Z2
 ; delete existing EB data
 S DIK="^DPT("_DFN_",.312,"_IEN312_",6,",DA(2)=DFN,DA(1)=IEN312
 S DA=0 F  S DA=$O(^DPT(DFN,.312,IEN312,6,DA)) Q:DA=""!(DA?1.A)  D ^DIK
 ;
 ; /IB*2.0*506 Beginning
 ; File the new Requested Service Date field (file #2.312,8.01) from the file #365,1.1 field,
 ; if the Service Date is not present, then use the Eligibility Date which would be from the file #365,1.11 field
 ; ALSO, file the new Requested Service Type field (file #2.312,8.02) from the file #365.02,.04 field.
 N DIE,DR,NODE0,RSRVDT,RSTYPE,TQIEN
 S TQIEN=$P($G(^IBCN(365,RIEN,0)),U,5),NODE0=$G(^IBCN(365.1,TQIEN,0))
 S RSTYPE=$P(NODE0,U,20),RSRVDT=$P($G(^IBCN(365,RIEN,1)),U,10)
 I RSRVDT="" S RSRVDT=$P(NODE0,U,12)
 S DIE="^DPT("_DFN_",.312,",DA(1)=DFN,DA=IEN312
 ;
 ; IB*2.0*549 - File the pointer to the IIV RESPONSE (file 365)
 D UPDT365(RIEN,IEN312_","_DFN_",")
 S DR="8.01///"_RSRVDT_";8.02///"_RSTYPE_";8.03///"_RIEN
 D ^DIE
 ; /IB*2.0*506 End
 ;
 ; file new EB data
 S IENSTR=IEN312_","_DFN_","
 S GIEN=+$P($G(^DPT(DFN,.312,IEN312,0)),U,18)
 S Z="" F  S Z=$O(^IBCN(365,RIEN,2,"B",Z)) Q:Z=""!$G(ERFLG)  D
 .S EBIENS=$O(^IBCN(365,RIEN,2,"B",Z,""))_","_RIEN_","
 .; if filing Medicare Part A/B data, make sure we only file the correct EB group
 .S GSKIP=0 I GIEN>0 D
 ..S TYPE=$$GET1^DIQ(365.02,EBIENS,.05)
 ..S TYPE1=$P($G(^IBA(355.3,GIEN,0)),U,14)
 ..I TYPE="MA",TYPE1="B" S GSKIP=1
 ..I TYPE="MB",TYPE1="A" S GSKIP=1
 ..Q
 .I GSKIP Q  ; wrong Medicare Part A/B EB group - skip it
 .D GETS^DIQ(365.02,EBIENS,"**",,"DATA","ERROR") I $D(ERROR) D:AFLG WARN^IBCNEHL3 Q
 .; make sure we have data to file
 .I '$D(DATA(365.02)) Q
 .S IENS="+1,"_IENSTR,Z1=$O(DATA(365.02,"")) M DATA1(2.322,IENS)=DATA(365.02,Z1)
 .D UPDATE^DIE("E","DATA1","IENROOT","ERROR") I $D(ERROR) D:AFLG WARN^IBCNEHL3 Q
 .S IENS="+1,"_IENROOT(1)_","_IENSTR K DATA1,IENROOT
 .S Z2="" F  S Z2=$O(DATA(365.26,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3226,IENS)=DATA(365.26,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.27,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3227,IENS)=DATA(365.27,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.28,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3228,IENS)=DATA(365.28,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.29,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3229,IENS)=DATA(365.29,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.291,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.32291,IENS)=DATA(365.291,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.292,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.32292,IENS)=DATA(365.292,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .K DATA
 .Q
 Q $G(ERFLG)
 ;
UPDT365(RIEN,IEN312)    ; Sets the DO NOT PURGE flag in file 365
 ; Input:   RIEN        - IEN of the entry in file 365 to be set
 ;          IEN312      - IENS of the Insurance multiple entry
 ; IB*2.0*549 added method
 N DA,DIE,DR,XX
 S XX=$$GET1^DIQ(2.312,IEN312,8.03,"I")     ; Get current file 365 pointer
 I XX'="" D                                 ; Remove the DO NOT PURGE flag
 . S DIE=365,DA=XX
 . S DR=".11///0"
 . D ^DIE
 ;
 ; Set the DO NOT PURGE Flag
 S DIE=365,DA=RIEN
 S DR=".11///1"
 D ^DIE
 Q
 ;
 ; IB*702/DTG - moved AUTOFIL from IBCNEHL1 for SAC space size.
AUTOFIL(DFN,IEN312,ISSUB) ;Finish processing the response message - file directly into patient insurance
 ;
 N BUFF,DATA,ERROR,IENS,MIL,OKAY,PREL,RDATA0,RDATA1,RDATA5,RDATA13,RSTYPE,TQN,TSTAMP,XX  ;IB*2*497 (vd)
 N IBARR,IBIFN ;IB*702/DTG need for auto eiv user name
 ;
 S TSTAMP=$$NOW^XLFDT(),IENS=IEN312_","_DFN_","
 S RDATA0=$G(^IBCN(365,RIEN,0)),RDATA1=$G(^IBCN(365,RIEN,1)),RDATA5=$G(^IBCN(365,RIEN,5))
 S RDATA13=$G(^IBCN(365,RIEN,13))     ;IB*2*497 (vd)
 S TQN=$P(RDATA0,U,5),RSTYPE=$P(RDATA0,U,10)
 ;\Beginning IB*2*549 - Modified the following lines
 S XX=$$GET1^DIQ(2.312,IENS,7.01,"I")
 I ISSUB,XX="" S DATA(2.312,IENS,7.01)=$P(RDATA13,U)  ;Name
 S XX=$$GET1^DIQ(2.312,IENS,3.01,"I")
 I XX="" S DATA(2.312,IENS,3.01)=$P(RDATA1,U,2)       ;DOB
 S XX=$$GET1^DIQ(2.312,IENS,3.05,"I")
 I XX="" S DATA(2.312,IENS,3.05)=$P(RDATA1,U,3)       ;SSN
 S XX=$$GET1^DIQ(2.312,IENS,6,"I")
 I ISSUB,XX="" S DATA(2.312,IENS,6)=$P(RDATA1,U,8)    ;Whose insurance
 ;pt. relationship (365,8.01) IB*2*497 code from 365,8.01 needs evaluation & possible conversion
 S PREL=$$GET1^DIQ(365,RIEN,8.01)
 S XX=$$GET1^DIQ(2.312,IENS,4.03,"I")
 I ISSUB,XX="",PREL'="" D
 . S DATA(2.312,IENS,4.03)=$$PREL^IBCNEHLU(2.312,4.03,PREL)
 ;\End of IB*2*549 changes.
 ;
 ;Moved the setting of fields 1.03 through 1.06 plus 1.09
 ; persist the original Source of Information
 ;note: external values are used to populate DATA
 I $$GET1^DIQ(2.312,IENS,1.09,"I")="" D
 . S XX=$$GET1^DIQ(365.1,TQN_",1,",3.02)
 . I XX="" S XX="eIV"
 . S DATA(2.312,IENS,1.09)=XX
 ;
 ;Set Subscriber address Fields if none of the fields are currently defined
 ;\Beginning IB*2*549 - Modified the following lines
 S XX=$$GET1^DIQ(2.312,IENS,3.06,"I")      ;Current Ins Street Line 1
 I XX="" D
 . S XX=$$GET1^DIQ(2.312,IENS,3.07,"I")    ;Current Ins Street Line 2
 . Q:XX'=""
 . S XX=$$GET1^DIQ(2.312,IENS,3.08,"I")    ;Current Ins City
 . Q:XX'=""
 . S XX=$$GET1^DIQ(2.312,IENS,3.09,"I")    ;Current Ins State
 . Q:XX'=""
 . S XX=$$GET1^DIQ(2.312,IENS,3.1,"I")     ;Current Ins Zip
 . Q:XX'=""
 . S XX=$$GET1^DIQ(2.312,IENS,3.13,"I")    ;Current Ins Country
 . Q:XX'=""
 . S XX=$$GET1^DIQ(2.312,IENS,3.14,"I")    ;Current Ins Country Subdivision
 . Q:XX'=""
 . S DATA(2.312,IENS,3.06)=$P(RDATA5,U)    ;Street line 1
 . S DATA(2.312,IENS,3.07)=$P(RDATA5,U,2)  ;Street line 2
 . S DATA(2.312,IENS,3.08)=$P(RDATA5,U,3)  ;City
 . S DATA(2.312,IENS,3.09)=$P(RDATA5,U,4)  ;State
 . S DATA(2.312,IENS,3.1)=$P(RDATA5,U,5)   ;Zip
 . S DATA(2.312,IENS,3.13)=$P(RDATA5,U,6)  ;Country
 . S DATA(2.312,IENS,3.14)=$P(RDATA5,U,7)  ;Country subdivision
 ;\End of IB*2*549 changes.
 ;
 L +^DPT(DFN,.312,IEN312):15 I '$T D LCKERR^IBCNEHL3 D FIL^IBCNEHL1 Q
 I $D(DATA) D FILE^DIE("ET","DATA","ERROR") ; make sure DATA has data  
 I $D(ERROR) D WARN^IBCNEHL3 K ERROR D FIL^IBCNEHL1 G AUTOFILX
 K DATA
 S DATA(2.312,IENS,1.03)=TSTAMP                ;Date last verified
 S DATA(2.312,IENS,1.04)=IBEIVUSR    ;Last verified by ;IB*702/DTG - use variable for user name (auto update user)
 S DATA(2.312,IENS,1.05)=TSTAMP                ;Date last edited
 S DATA(2.312,IENS,1.06)=IBEIVUSR    ;Last edited by   ;IB*702/DTG - use variable for user name (auto update user)
 D FILE^DIE("ET","DATA","ERROR")
 I $D(ERROR) D WARN^IBCNEHL3 G AUTOFILX
 ; set the insurance record IEN in the IIV Response file
 ;to track which policy was updated based on the response
 D UPDIREC^IBCNEHL3(RIEN,IEN312)
 ; set the EIV AUTO-UPDATE in the response file to signal auto-update
 K DATA
 S DATA(365,RIEN_",",.13)="YES"
 D FILE^DIE("ET","DATA")
 ;
 ;IB*2*497 file data at 2.312, 9, 10 & 11 subfiles; if error is produced update buffer entry & then quit processing
 S ERFLG=$$GRPFILE^IBCNEHL1(DFN,IEN312,RIEN,1)
 I $G(ERFLG) G AUTOFILX
 ;
 ;file new EB data
 S ERFLG=$$EBFILE^IBCNEHL1(DFN,IEN312,RIEN,1)
 I $G(ERFLG) G AUTOFILX  ;bail out if something went wrong during filing of EB data
 ;
 ;update insurance record ien in transmission queue
 D UPDIREC^IBCNEHL3(RIEN,IEN312)
 ;
 ;For an original response, set the Transmission Queue Status to 'Response Received' &
 ;update remaining retries to comm failure (5)
 ;IB*743/CKB - called earlier when saving the MSA segment 
 ;I $G(RSTYPE)="O" D SST^IBCNEUT2(TQN,3),RSTA^IBCNEUT7(TQN)
 ;
 ;File Auto Updated policy in INTERFACILITY INSURANCE UPDATE File (#365.19)
 ; IBCNBAR added a field the param list when calling LOC^IBCNIUF. For consistency we added a 'null'.
 D LOC^IBCNIUF(DFN,$$GET1^DIQ(2.312,IEN312_","_DFN_",",.01,"I"),IEN312,$$GET1^DIQ(365,RIEN_",",.13,"I"),"",$$GET1^DIQ(365.1,TQN_",",3.02,"E"),"")
 ;
 ;Get the buffer entry from the IIV RESPONSE File (#365)
 S BUFF=+$P($G(^IBCN(365,RIEN,0)),U,4)
 ;
 ;IB*743/TAZ - If there is a Buffer entry associated with the Response and it is already processed,
 ;  DO NOT touch/update files #355.33 or #355.36
 I BUFF,$$GET1^DIQ(355.33,BUFF,.04,"I")'="E" G AUTOFILX
 ;
 ;Update the buffer status to ACCEPTED, then call DELDATA^IBCNBED so only the stub remains                                                    
 I BUFF D
 . D STATUS^IBCNBEE(BUFF,"A",0,0,0) ;update status to accepted
 . ;IB*702/DTG - save auto update user to buffer
 . S IBIFN=BUFF_"," K IBARR
 . S IBARR(355.33,IBIFN,.06)=$G(IBEIVUSR)
 . D FILE^DIE("E","IBARR")          ;file with the 'E' allows for external input, name vs ien
 . D DELDATA^IBCNBED(BUFF)          ;delete buffer's insurance/patient data
 . ;
 ; File data to #355.36 file.
 N BUFF,ERROR,FDA,WE
 S WE=$$GET1^DIQ(365.1,TQN_",",.1,"I")
 S BUFF=$$GET1^DIQ(365,RIEN_",",.04,"I")
 S FDA(355.36,"+1,",.01)=$$NOW^XLFDT    ;Date Processed
 S FDA(355.36,"+1,",.02)=$S("^5^6^"[(U_WE_U):3,"^1^2^"[(U_WE_U):1,1:"")   ;"WE" Should never be 4 or 7 at this point
 S FDA(355.36,"+1,",.03)=$$GET1^DIQ(365.1,TQN_",",3.02,"I")   ;Source of Information
 S FDA(355.36,"+1,",.04)=$$GET1^DIQ(365,RIEN_",",.13,"I")     ;EIV Auto-Update
 S FDA(355.36,"+1,",.05)=TQN            ;EIV Inquiry
 S FDA(355.36,"+1,",.06)=RIEN           ;EIV Response
 S FDA(355.36,"+1,",.07)=BUFF           ;Buffer
 S FDA(355.36,"+1,",.08)=WE             ;Source of Request (Which Extract)
 D UPDATE^DIE("","FDA",,"ERROR")
 I $D(ERROR) D
 . D MSG003^IBCNEMS1(.IBMSG,.ERROR,TQN,RIEN,BUFF)
 . D MSG^IBCNEUT5($$MGRP^IBCNEUT5(),"eIV Problem: Error writing to the CREATION TO PROCESSING TRACKING File (#355.36)","IBMSG(")
 ;
AUTOFILX ;
 L -^DPT(DFN,.312,IEN312)
 Q
