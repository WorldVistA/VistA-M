IBY579PO ;ALB/FA - IB*2.0*579 POST-INSTALL ;27-OCT-2016
 ;;2.0;INTEGRATED BILLING;**579**;21-MAR-94;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;Entry point
 N IBXPD,XPDIDTOT
 S XPDIDTOT=1
 ;
 ; Update Covered by Health Insurance field (file 2, field .3192) for deceased patients
 S IBXPD=1
 D HCOV(IBXPD,XPDIDTOT)
 D DONE
 Q
 ;
HCOV(IBXPD,XPDIDTOT) ; Update Covered by Health Insurance field for deceased patients
 ; Input:   XBXPD       - Post Installation Step
 ;          XPDIDTOT    - Total # of Post Installation steps
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Update Covered By Health Insurance field for deceased patients.")
 ; 1 - For every patient in the patient file check if the patient is deceased field
 ;    (file 2, field .351)
 ; 2 - Quit if the patient is not deceased
 ; 3 - Quit if the Covered By Health Insurance field is already set to 'N'
 ; 3 - Quit if all of the patient's policies are not expired
 ; 4 - Change the Covered By Health Insurance field to 'N'
 ; 5 - Add this patient to a list of patients being modified
 ; 6 - Email the list of patients modified to xxx
 ;
 N MTIME,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 S MTIME=$$NOW^XLFDT()                      ; Fileman date/time
 S MTIME=$$FMADD^XLFDT(MTIME,0,4)           ; Set to queue 4 hours later
 S ZTDTH=$$FMTH^XLFDT(MTIME)                ; Convert to $H format
 ;
 ; Set up the other TaskManager variables
 S ZTRTN="HCOV2^IBY579PO"
 S ZTDESC="IB*2.0*579 Change 'Covered By Health Insurance' field for deceased patients"
 S ZTIO=""
 D ^%ZTLOAD ; Call TaskManager
 Q
 ;
HCOV2 ;EP
 ; Called from Task Manager
 N CURSIZE,DFN,DOD,EMAIL,EXPDT,HCOV,HCOVN,IIEN,LNCTR,MAXSIZE,MLGRP,MSG,NPAT,NOTEXP
 N PNM,SSN,SUBJECT,XMY,XX,YY
 K ^TMP($J,"PATLIST"),^TMP($J,"ERRLIST")
 S DFN=0
 F  D  Q:'+DFN
 . S DFN=$O(^DPT(DFN))
 . Q:'+DFN
 . S DOD=$$GET1^DIQ(2,DFN_",",.351,"I")     ; Date of Death
 . Q:DOD=""                                 ; Patient is not Deceased
 . S HCOV=$$GET1^DIQ(2,DFN_",",.3192,"I")   ; Covered By Health Insurance flag
 . Q:HCOV=""!(HCOV="N")!(HCOV="U")          ; Covered By Health Insurance already 'N' or "U"
 . S IIEN=0,NOTEXP=0
 . F  D  Q:'+IIEN  Q:NOTEXP
 . . S IIEN=$O(^DPT(DFN,.312,IIEN))
 . . Q:'+IIEN
 . . S EXPDT=$$GET1^DIQ(2.312,IIEN_","_DFN_",",3,"I")   ; Policy Expiration Date
 . . Q:EXPDT'=""                                        ; Policy has an expiration date
 . . S NOTEXP=1
 . Q:NOTEXP                                 ; Not all plans are expired
 . D CHGCOV(DFN,HCOV)                       ; Set the Health Coverage flag to 'N'
 . Q:$D(^TMP($J,"ERRLIST",DFN))             ; On error list
 . S HCOVN=$$GET1^DIQ(2,DFN_",",.3192,"I")  ; New Covered By Health Insurance flag
 . Q:HCOVN="Y"                              ; Deceased patient with coverage, skip
 . S ^TMP($J,"PATLIST",DFN)=""              ; Add Patient to list
 ;
 I '$D(^TMP($J,"PATLIST")),'$D(^TMP($J,"ERRLIST")) Q  ; No patients to update
 ;
 ; Get array of users with the 'IB SUPERVISOR' security key
 D GETPER^IBCNEUT7("IB SUPERVISOR",.XMY)
 ;
 ; Begin email set up
 S MAXSIZE=300000,CURSIZE=0,LNCTR=0
 S MLGRP=$$MGRP^IBCNEUT5
 S SUBJECT="eIV: Change Covered By Health Insurance field for deceased patient - Post Install Task"
 ;
 ; First add any patients that had filing errors
 I $D(^TMP($J,"ERRLIST")) D
 . S LNCTR=LNCTR+1
 . S XX(1)="The following patients will need to be manually updated by removing and "
 . S XX(2)="re-entering the policy expiration date for one of the patient's policies "
 . S XX(3)="so that the 'Covered By Health Insurance' field will be corrected:"
 . S YY=$L(XX(1))+$L(XX(2))+$L(XX(3))
 . ;
 . ; Is the mail message getting too big?
 . I (CURSIZE+YY)>MAXSIZE D
 . . D MSG^IBCNEUT5(MLGRP,SUBJECT,"MSG(",,.XMY)
 . . K MSG
 . . S CURSIZE=0,LNCTR=1
 . ;
 . S MSG(LNCTR)=XX(1),CURSIZE=CURSIZE+$L(XX(1)),LNCTR=LNCTR+1
 . S MSG(LNCTR)=XX(2),CURSIZE=CURSIZE+$L(XX(2)),LNCTR=LNCTR+1
 . S MSG(LNCTR)=XX(3),CURSIZE=CURSIZE+$L(XX(3))
 . S DFN=""
 . F  D  Q:DFN=""
 . . S DFN=$O(^TMP($J,"ERRLIST",DFN))
 . . Q:DFN=""
 . . S PNM=$$GET1^DIQ(2,DFN,.01)
 . . S SSN=$$GET1^DIQ(2,DFN,.09),SSN=$E(SSN,6,9)
 . . S NPAT="      "_PNM_"  "_SSN
 . . ;
 . . ; Is the mail message getting too big?
 . . I CURSIZE+$L(NPAT)>MAXSIZE D
 . . . D MSG^IBCNEUT5(MLGRP,SUBJECT,"MSG(",,.XMY)
 . . . K MSG
 . . . S LNCTR=3,MSG(1)=XX(1),MSG(2)=XX(2),MSG(3)=XX(3),CURSIZE=YY
 . . S LNCTR=LNCTR+1
 . . S MSG(LNCTR)=NPAT
 . . S CURSIZE=CURSIZE+$L(NPAT)
 . S LNCTR=LNCTR+1,MSG(LNCTR)="",LNCTR=LNCTR+1,MSG(LNCTR)=""
 ;
 ; Next add the patients whose Covered By Health Insurance flag was set to 'N'
 S LNCTR=LNCTR+1
 S MSG(LNCTR)="The 'Covered By Health Insurance' field for the following deceased"
 S CURSIZE=CURSIZE+$L(MSG(LNCTR))
 S LNCTR=LNCTR+1
 S MSG(LNCTR)="patients was automatically set to 'NO':"
 S CURSIZE=CURSIZE+$L(MSG(LNCTR))
 S DFN=""
 F  D  Q:DFN=""
 . S DFN=$O(^TMP($J,"PATLIST",DFN))
 . Q:DFN=""
 . S PNM=$$GET1^DIQ(2,DFN,.01)
 . S SSN=$$GET1^DIQ(2,DFN,.09),SSN=$E(SSN,6,9)
 . S NPAT="      "_PNM_"  "_SSN
 . ;
 . ; Is the mail message getting too big?
 . I CURSIZE+$L(NPAT)>MAXSIZE D
 . . D MSG^IBCNEUT5(MLGRP,SUBJECT,"MSG(",,.XMY)
 . . K MSG
 . . S CURSIZE=0,LNCTR=2
 . . S MSG(1)="The Covered By Health Insurance field for the following deceased"
 . . S CURSIZE=CURSIZE+$L(MSG(1))
 . . S MSG(2)="was automatically set to 'N'"
 . . S CURSIZE=CURSIZE+$L(MSG(2))
 . S LNCTR=LNCTR+1
 . S MSG(LNCTR)=NPAT
 . S CURSIZE=CURSIZE+$L(NPAT)
 ;
 D MSG^IBCNEUT5(MLGRP,SUBJECT,"MSG(",,.XMY)
 K ^TMP($J,"PATLIST"),^TMP($J,"ERRLIST")
 Q
 ;
CHGCOV(DFN,HCOV) ; Update the Covered By Health Insurance field
 ; Input:   DFN                 - IEN of the patient being updated
 ;          HCOV                - Current value of Covered By Health Insurance field
 ;          ^TMP($J,"ERRLIST")  - Current array of update errors
 ; Output:  ^TMP($J,"ERRLIST")  - Updated array of update errors
 N DA,FDA,IBERR,IBSUPRES
 N $ESTACK,$ETRAP
 S $ETRAP="D COVERR^IBY579PO"
 S IBSUPRES=1
 D COVERED^IBCNSM31(DFN,HCOV)             ; Set the Health Coverage flag to 'N'
 Q
 ;
COVERR ; Called when an error occurs changing the Covered By Health Insurance field
 ; deceased patients.  Note:  This usually occurs because of a known FileMan error and a
 ; collision of a post-filing routine updating file 2.312 with a nightly KPAS
 ; extract doing inquiries into the 2.312 file at the same time.
 ;
 ; If an error occurs, this method will add the patient where the error occurred
 ; onto the error list for manual processing and move on to the next patient.
 ; Input:   DFN                 - IIEN of the patient that was being worked 
 ;                                when the error occurred
 ;          ^TMP($J,"ERRLIST")  - Current array of patients that had filing 
 ;                                errors
 ; Output:  ^TMP($J,"ERRLIST") - Updated array of patients that had filing errors
 S ^TMP($J,"ERRLIST",DFN)=""                ; Log collision error
 S $ECODE=""                                ; Ignore error and continue
 Q
 ;
DONE ; Displays the 'Done' message and finishes the progress bar
 ; Input: IBXPD - Post-Installation step being performed
 D MES^XPDUTL(" Done.")
 Q
 ;
