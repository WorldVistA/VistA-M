IBCNEHL5 ;DALOI/KML - HL7 Process Incoming RPI Msgs (cont.) ;1-APRIL-2013
 ;;2.0;INTEGRATED BILLING;**497,549**;21-MAR-94;Build 54
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
ZMP(ERROR,IBSEG,RIEN) ; Process Military Personnel Information that comes from X12 271 MPI segment of the 2100C and 2100D  loops 
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N IENSTR,RSUPDT,QUAL,VALUE
 S IENSTR=RIEN_","
 S RSUPDT(365,IENSTR,12.01)=$G(IBSEG(3)) ; information status code
 S RSUPDT(365,IENSTR,12.02)=$G(IBSEG(4))  ;employment status code
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
 S RSUPDT(365.04,IENSTR,.02)=$P($G(IBSEG(4)),HLCMP)  ; provider code
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
 S RSUPDT(365.01,IENSTR,.03)=$P($G(IBSEG(4)),HLCMP,3) ; diagnosis code qualifier
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
