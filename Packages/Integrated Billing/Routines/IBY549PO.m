IBY549PO ;ALB/VD - IB*2*549 POST-INSTALL ;21-APR-2015
 ;;2.0;INTEGRATED BILLING;**549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;Entry point
 N IBXPD,XPDIDTOT
 S XPDIDTOT=7
 ;
 ; Send site registration message to FSC
 S IBXPD=1
 D RMSG
 ;
 ; Req# 2.6.4.10
 ; Remove the IP Address if it exists in the IIV EC HL7 Logical Link.
 S IBXPD=2
 D IIVEC(IBXPD,XPDIDTOT)
 ;
 ; Req# 2.6.8.1
 ; Add a new Type of Coverage record in the ^IBE(355.2) file.
 S IBXPD=3
 D NEWCVTY(IBXPD,XPDIDTOT)
 ;
 ; Req# 2.6.8.2
 ; Add a new Type of Plan record in the ^IBE(355.1) file.
 S IBXPD=4
 D NEWPLTY(IBXPD,XPDIDTOT)
 ;
 ; Req# 2.6.2.2
 ; Update Policy expiration dates for deceased patients
 S IBXPD=5
 D POLCYUPD(IBXPD,XPDIDTOT)
 ;
 ; Req# 2.6.10.6
 ; Remove the contact field value
 S IBXPD=6
 D DELCONT(IBXPD,XPDIDTOT)
 ;
 ; Req# 2.6.10.21
 ; Set MESSAGES MAILGROUP field in Site parameters
 S IBXPD=7
 D MGROUP(IBXPD,XPDIDTOT)
 ;
 ; File a 'Y' for new Master Realtime and Nightly switches
 D FSWITCH
 D DONE
 Q
 ;
RMSG ; send site registration message to FSC
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Sending site registration message to FSC ... ")
 I '$$PROD^XUPROD(1) D  Q                   ; only sent reg. message from production account
 . D MES^XPDUTL(" N/A - Not a production account - No site registration message sent")
 D MES^XPDUTL("Sending site registration message to FSC ... ")
 D ^IBCNEHLM
 Q
 ;
IIVEC(IBXPD,XPDIDTOT) ; Remove the IP address if it exists in the IIV EC HL7
 ; Logical Link.
 ; Input:   XBXPD       - Post Installation Step
 ;          XPDIDTOT    - Total # of Post Installation steps
 N DA,DIE,DLAYGO,DR,IBPRD,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Remove the IP Address in 'IIV EC' HL7 Logical Link.")
 ;
 S IBPRD=$S($$PROD^XUPROD(1)=1:"P",1:"T")
 S DIC="^HLCS(870,",DLAYGO=870,DIC(0)="LS",X="IIV EC" D ^DIC
 ;
 ; For Test environments
 I IBPRD="T",Y'=-1 D
 . S DIE=DIC,DA=+Y,DR=".08///IIV.VITRIA-EDI-TEST.DOMAIN.EXT;400.01///@"
 . K DIC D ^DIE
 ;
 ; For Production environments, use the FSC PRD domain
 I IBPRD="P",Y'=-1 D
 . S DIE=DIC,DA=+Y,DR=".08///IIV.VITRIA-EDI.DOMAIN.EXT;400.01///@"
 . K DIC D ^DIE
 Q
 ;
MGROUP(IBXPD,XPDIDTOT) ; Set the MESSAGES MAILGROUP in site parameters if wrong value
 ; Input:   XBXPD       - Post Installation Step
 ;          XPDIDTOT    - Total # of Post Installation steps
 N XX
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Checking current MESSAGE MAILGROUP value ... ")
 S XX=$$GET1^DIQ(350.9,"1,",51.04,"E")
 I XX'="IBCNE EIV MESSAGE" D  Q
 . S XX=$O(^XMB(3.8,"B","IBCNE EIV MESSAGE",0))
 . ;
 . ; If the IBCNE EIV MESSAGE mail group doesn't exist, create and send a
 . ; message to InsuranceRapidResponse@domain.ext 
 . I XX="" D ADDMGRP
 . E  D MES^XPDUTL(" Mail group IBCNE EIV MESSAGE already exists")
 . ;
 . N DA,DIE,DR
 . D MES^XPDUTL(" Setting mail group to IBCNE EIV MESSAGE")
 . S XX=$O(^XMB(3.8,"B","IBCNE EIV MESSAGE",""))
 . S DIE=350.9,DA=1
 . S DR="51.04///"_XX
 . D ^DIE
 ;
 D MES^XPDUTL("MESSAGE MAILGROUP already set to IBCNE EIV MESSAGE - nothing done")
 Q
 ;
ADDMGRP ; Create the IBCNE EIV MESSAGE mail group with no users
 N MGDESC,MGNM,MSG,SUBJECT,XMY
 S MGNM="IBCNE EIV MESSAGE"
 S MGDESC(1)="This mail group will be used to deliver notifications for"
 S MGDESC(2)="the Insurance Verification process."
 I $$MG^XMBGRP(MGNM,0,$G(DUZ),0,,.MGDESC,1) D
 . D MES^XPDUTL("     Mail Group "_MGNM_" was successfully created.")
 . ;
 . ; Notify the VA eInsurance Rapid Response Group
 . S XMY("InsuranceRapidResponse@domain.ext")=""
 . S MSG(1)="The Mail Group IBCNE EIV MESSAGE was created"
 . S SUBJECT="Mail Group IBCNE EIV MESSAGE created"
 . D MSG^IBCNEUT5(,SUBJECT,"MSG(",,.XMY)
 E  D
 . D MES^XPDUTL("     ERROR: Mail Group "_MGNM_" was not created!")
 . D MES^XPDUTL("     Please enter a support ticket for assistance.")
 Q
 ;
FSWITCH ; File 'YES' values for new realtime switches
 N DA,DIE,DR,DTOUT,XX
 S XX=$$GET1^DIQ(350.9,"1,",51.27,"I")
 ;
 ; If null set to "YES"
 I XX="" D
 . S DIE=350.9,DA=1,DR="51.27///Y"
 . D ^DIE
 ;
 S XX=$$GET1^DIQ(350.9,"1,",51.28,"I")
 ;
 ; If null set to "YES"
 I XX="" D
 . S DIE=350.9,DA=1,DR="51.28///Y"
 . D ^DIE
 Q
 ;
NEWPLTY(IBXPD,XPDIDTOT) ; Add a new code to the TYPE OF PLAN TABLE (#355.1)
 ; for VA SPECIAL CLASS
 ; Input:   XBXPD       - Post Installation Step
 ;          XPDIDTOT    - Total # of Post Installation steps
 N IBDATA,IBDESC,IBERR,IBIEN
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Add a new VA SPECIAL CLASS code to the TYPE OF PLAN TABLE")
 I $D(^IBE(355.1,"D","VA SP CL")) D   Q
 . D BMES^XPDUTL("*** NEW 'VA SP CL' CODE NOT ADDED TO TYPE OF PLAN TABLE...ALREADY EXISTS ***")
 ;
 ; Set up WP Arrays
 S IBDESC("WP",1)="Pseudo plan - DO NOT BILL"
 ;
 ; Set up File Nodes
 S IBDATA(.01)="VA SPECIAL CLASS"
 S IBDATA(.02)="VA SP CL"
 S IBDATA(.03)="12"
 S IBDATA(10)=$NA(IBDESC("WP"))
 S IBIEN=$$ADD^IBDFDBS(355.1,,.IBDATA,.IBERR)
 I IBERR D  Q
 . D BMES^XPDUTL("*** ERROR ADDING 'VSC' CODE TO THE TYPE OF PLAN TABLE (#355.1) ***")
 Q
 ;
NEWCVTY(IBXPD,XPDIDTOT) ; Add a new code to the TYPE OF COVERAGE TABLE (#355.2)
 ; for VA SPECIAL CLASS
 ; Input:   XBXPD       - Post Installation Step
 ;          XPDIDTOT    - Total # of Post Installation steps
 N IBDATA,IBDESC,IBERR,IBIEN
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Add a new VA SPECIAL CLASS code to the TYPE OF COVERAGE TABLE")
 I $D(^IBE(355.2,"C","VA SP CL")) D  Q
 . D BMES^XPDUTL("*** NEW 'VA SP CL' CODE NOT ADDED TO TYPE OF COVERAGE TABLE...ALREADY EXISTS ***")
 ;
 ; Set up WP Arrays
 S IBDESC("WP",1)="Pseudo type of coverage - DO NOT USE"
 ;
 ; Set up File Nodes
 S IBDATA(.01)="VA SPECIAL CLASS"
 S IBDATA(.02)="VA SP CL"
 S IBDATA(10)=$NA(IBDESC("WP"))
 S IBIEN=$$ADD^IBDFDBS(355.2,,.IBDATA,.IBERR)
 I IBERR D  Q
 . D BMES^XPDUTL("*** ERROR ADDING 'VA SP CL' CODE TO THE TYPE OF COVERAGE TABLE (#355.2) ***")
 Q
 ;
DELCONT(IBXPD,XPDIDTOT) ; Remove the contact field value
 ; Input:   XBXPD       - Post Installation Step
 ;          XPDIDTOT    - Total # of Post Installation steps
 ;
 N FDA,DA,IBERR
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing Contact Person from eIV Site Parameters.")
 S DA=1
 S FDA(350.9,"1,",51.16)="@"
 D FILE^DIE("","FDA","IBERR")
 Q
 ;
POLCYUPD(IBXPD,XPDIDTOT) ; Update Policy Expiration Dates for deceased patients
 ; Input:   XBXPD       - Post Installation Step
 ;          XPDIDTOT    - Total # of Post Installation steps
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Update Policy Expiration Dates for deceased patients.")
 ; 1 - For every patient in the patient file check if the patient is deceased field
 ;    (file 2, field .351)
 ; 2 - Quit if the patient is not deceased
 ; 3 - Quit if the policy expiration is non-null
 ; 4 - Change the policy expiration date to (Date of Death +1)
 ; 5 - Add this patient and policy to a list of patient/policies  being modified
 ; 6 - Email the list of patient/policies modified to xxx
 ;
 N MTIME,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 S MTIME=$$NOW^XLFDT()                      ; Fileman date/time
 S MTIME=$$FMADD^XLFDT(MTIME,0,4)           ; Set to queue 4 hours later
 S ZTDTH=$$FMTH^XLFDT(MTIME)                ; Convert to $H format
 ;
 ; Set up the other TaskManager variables
 S ZTRTN="POLCUP2^IBY549PO"
 S ZTDESC="IB*2.8*549 Auto Termination of Policies for deceased patients"
 S ZTIO=""
 D ^%ZTLOAD ; Call TaskManager
 Q
 ;
POLCUP2 ;EP
 ; Called from Task Manager
 N CURSIZE,DFN,DOD,EMAIL,EXPDT,IIEN,LNCTR,MAXSIZE,MLGRP,MSG,NPAT
 N PNM,SSN,SUBJECT,XMY,XX
 K ^TMP($J,"PATLIST"),^TMP($J,"ERRLIST")
 S DFN=0
 F  D  Q:'+DFN
 . S DFN=$O(^DPT(DFN))
 . Q:'+DFN
 . S DOD=$$GET1^DIQ(2,DFN_",",.351,"I")     ; Date of Death
 . Q:DOD=""                                 ; Patient is not Deceased
 . S IIEN=0
 . F  D  Q:'+IIEN
 . . S IIEN=$O(^DPT(DFN,.312,IIEN))
 . . Q:'+IIEN
 . . S EXPDT=$$GET1^DIQ(2.312,IIEN_","_DFN_",",3,"I")   ; Policy Expiration Date
 . . Q:EXPDT'=""                                    ; Policy has an expiration date
 . . D UPDTEDT(DFN,IIEN,DOD)                        ; Update the expiration date
 . . Q:$D(^TMP($J,"ERRLIST",DFN,IIEN))              ; On error list
 . . S ^TMP($J,"PATLIST",DFN,IIEN)=""               ; Add Patient Policy to list
 Q:'$D(^TMP($J,"PATLIST"))                          ; No patients to update
 ;
 ; Get array of users with the 'IB SUPERVISOR' security key
 D GETPER^IBCNEUT7("IB SUPERVISOR",.XMY)
 ;
 ; Begin email set up
 S MAXSIZE=300000,CURSIZE=0,LNCTR=0
 S MLGRP=$$MGRP^IBCNEUT5
 S SUBJECT="eIV: Policy Expiration for deceased patient - Post Install Task"
 ;
 ; First add any patients that had filing errors
 I $D(^TMP($J,"ERRLIST")) D
 . S LNCTR=LNCTR+1
 . S XX="The following patients will need to be manually updated: "
 . ;
 . ; Is the mail message getting too big?
 . I CURSIZE+$L(XX)>MAXSIZE D
 . . D MSG^IBCNEUT5(MLGRP,SUBJECT,"MSG(",,.XMY)
 . . K MSG
 . . S CURSIZE=0,LNCTR=1
 . ;
 . S MSG(LNCTR)=XX,CURSIZE=CURSIZE+$L(XX)
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
 . . . S LNCTR=1,MSG(1)=XX,CURSIZE=$L(XX)
 . . S LNCTR=LNCTR+1
 . . S MSG(LNCTR)=NPAT
 . . S CURSIZE=CURSIZE+$L(NPAT)
 . S LNCTR=LNCTR+1,MSG(LNCTR)="",LNCTR=LNCTR+1,MSG(LNCTR)=""
 ;
 ; Next add the patients who were updated to the email
 S LNCTR=LNCTR+1
 S MSG(LNCTR)="The policy expiration dates of active policies for the following deceased"
 S CURSIZE=CURSIZE+$L(MSG(LNCTR))
 S LNCTR=LNCTR+1
 S MSG(LNCTR)="patients were updated to be the patient's date of death+1:"
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
 . . S MSG(1)="The policy expiration dates of active policies for the following deceased"
 . . S CURSIZE=CURSIZE+$L(MSG(1))
 . . S MSG(2)="patients were updated to be the patient's date of death+1:"
 . . S CURSIZE=CURSIZE+$L(MSG(2))
 . S LNCTR=LNCTR+1
 . S MSG(LNCTR)=NPAT
 . S CURSIZE=CURSIZE+$L(NPAT)
 ;
 D MSG^IBCNEUT5(MLGRP,SUBJECT,"MSG(",,.XMY)
 K ^TMP($J,"PATLIST"),^TMP($J,"ERRLIST")
 Q
 ;
UPDTEDT(DFN,IIEN,DOD) ; Update the Expiration for the specified patient policy
 ; Input:   DFN                 - IEN of the patient whose policy is being
 ;                                updated
 ;          IIEN                - IEN of the patient policy multiple being
 ;                                updated
 ;          DOD                 - Internal Date of Death of the specified
 ;                                patient
 ;          ^TMP($J,"ERRLIST")  - Current array of Patient Policy update errors
 ; Output:  ^TMP($J,"ERRLIST")  - Updated array of Patient Policy update errors
 N DA,FDA,IBERR
 N $ESTACK,$ETRAP
 S $ETRAP="D POLERR^IBY549PO"
 S DA=IIEN,DA(1)=DFN
 S FDA(2.312,DA_","_DA(1)_",",1.05)=$$NOW^XLFDT()               ; Date Last Edited
 S FDA(2.312,DA_","_DA(1)_",",1.06)=.5                          ; Last Edited By
 S FDA(2.312,DA_","_DA(1)_",",3)=$P($$FMADD^XLFDT(DOD,1),".",1) ; Date of Death +1
 N A,D,X,Y
 D FILE^DIE("","FDA","IBERR")
 I $D(IBERR) D
 . S ^TMP($J,"ERRLIST",DFN,IIEN)=""
 Q
 ;
POLERR ; Called when an error occurs terminating active policies for deceased
 ; patients.  Note:  This usually occurs because of a known fileman error and a
 ; collision of a post-filing routine updating file 2.312 with a nightly KPAS
 ; extract doing inquiries into the 2.312 file at the same time.
 ;
 ; If an error occurs, this method will add the patient where the error occured
 ; onto the error list for manual processing and move on to the next patient.
 ; Input:   DFN                 - IIEN of the patient that was being worked 
 ;                                when the error occured
 ;          ^TMP($J,"ERRLIST")  - Current array of patients that had filing 
 ;                                errors
 ;          IIEN                - IEN of the patient policy multiple being 
 ;                                updated when the error occured
 ; Output:  ^TMP($J,"ERRLIST") - Updated array of patients that had filing errors
 S ^TMP($J,"ERRLIST",DFN,IIEN)=""           ; Log collision error
 S $ECODE=""                                ; Ignore error and continue
 Q
 ;
DONE ; Displays the 'Done' message and finishes the progress bar
 ; Input: IBXPD - Post-Installation step being performed
 D MES^XPDUTL(" Done.")
 Q
 ;
