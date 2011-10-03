PRC153P ;WOIFO/KCL - PRC*5.1*153 INSTALL UTILITIES ;2/24/2011
V ;;5.1;IFCAP;**153**;Oct 20, 2000;Build 10
 ;
 ;--------------------------------------------------
 ;Patch PRC*5.1*153: Environment, Pre-Install, and
 ;Post-Install entry points.
 ;--------------------------------------------------
 ;
ENV ;Main entry point for Environment check items
 ;
 ; Per KIDS documentation: During the environment check routine,
 ; use of direct WRITEs must be used for output messages.
 ;
 ;KIDS variable to indicate if install should abort
 ;if SET = 2, then abort entire installation
 S XPDABORT=""
 ;
 ;item 1 - check programmer variables
 W !!,">>> Check programmer variables..."
 D PROGCHK(.XPDABORT)
 Q:XPDABORT=2
 W "Successful"
 ;
 ;item 2 - check for Domain entry
 W !!,">>> Check for DOMAIN (#4.2) file entry..."
 D DOMCHK(.XPDABORT)
 Q:XPDABORT=2
 W "Successful"
 ;
 ;success
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items
 Q
 ;
 ;
POST ;Main entry point for Post-init items
 ;
 ; Supported IAs:
 ;  #10141 Allows use of supported Kernel call BMES^XPDUTL
 ;
 ;item 1 - add mail group member
 D BMES^XPDUTL(">>> Adding member to 'OLP' mail group...")
 D POST1
 ;
 ;item 2 - queue initial data extract
 N PRCOK
 D BMES^XPDUTL(">>> Queue job to perform data extract of 1358 transactions...")
 D OK(.PRCOK)     ;ok to run extract?
 I PRCOK D POST2  ;queue extract
 Q
 ;
 ;
PROGCHK(XPDABORT) ;Check for required programmer variables
 ;
 ; This procedure will determine if the users programmer variable are set up.
 ;
 ; Per KIDS documentation: During the environment check routine,
 ; use of direct WRITEs must be used for output messages.
 ;
 ;  Input: 
 ;   XPDABORT - KIDS var to indicate if install should
 ;              abort, passed by reference
 ;
 ; Output:
 ;   XPDABORT - if = 2, then abort entire installation
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 . W !!,"    **********"
 . W !,"      ERROR: Environment check failed!"
 . W !,"      Your programming variables are not set up properly. Once"
 . W !,"      your programming variables are set up correctly, re-install"
 . W !,"      this patch PRC*5.1*153."
 . W !,"    **********"
 . ;tell KIDS to abort the entire installation of the distribution
 . S XPDABORT=2
 Q
 ;
 ;
DOMCHK(XPDABORT) ;Check for new DOMAIN (#4.2) file entry
 ;
 ; This procedure will determine if DOMAIN (#4.2) file entry was added
 ; per MailMan patch XM*999*175.
 ;
 ; Per KIDS documentation: During the environment check routine,
 ; use of direct WRITEs must be used for output messages.
 ;
 ; Supported IAs:
 ;  #3452 Allows use of supported FM call $$FIND1^DIC
 ;  #3779 Allows read with FM on the NAME (#.01) field in the DOMAIN (#4.2)
 ;        file to ensure that the domain Q-OLP.MED.VA.GOV exists
 ;
 ;  Input: 
 ;   XPDABORT - KIDS var to indicate if install should
 ;              abort, passed by reference
 ;
 ; Output:
 ;   XPDABORT - if = 2, then abort entire installation
 ;
 I '$$FIND1^DIC(4.2,"","MX","Q-OLP.MED.VA.GOV") D
 . W !!,"    **********"
 . W !,"      ERROR: Environment check failed!"
 . W !,"      The required DOMAIN (#4.2) file entry was not found"
 . W !,"      for 'Q-OLP.MED.VA.GOV'. Please refer to MailMan patch"
 . W !,"      XM*999*175 to create this new entry. After the DOMAIN"
 . W !,"      entry has been created, re-install this patch PRC*5.1*153."
 . W !,"    **********"
 . ;tell KIDS to abort the entire installation of the distribution
 . S XPDABORT=2
 Q
 ;
 ;
OK(PRCOK) ;Ok to queue initial data extract?
 ;
 ; This procedure will determine if it's ok to queue the initial
 ; data extract.
 ;
 ; Queuing will not be allowed if:
 ;   [Not a production system]
 ;     OR
 ;   [Job is already running]
 ;     OR
 ;   [Job has been run previously]
 ;
 ; Supported IAs:
 ;  #10141 Allows use of supported Kernel call BMES^XPDUTL and MES^XPDUTL
 ;   #4440 Allows use of supported Kernel call $$PROD^XUPROD
 ;   #2263 Allows use of supported Kernel call $$GET^XPAR
 ;
 ;  Input: 
 ;   PRCOK - ok to queue initial data extract?, passed by reference
 ;
 ; Output:
 ;   PRCOK - 1 if ok to queue, 0 if not ok
 ;
 N PRCTASK ;task #
 N PRCVAL  ;result of $$GET^XPAR function
 ;
 S PRCOK=1
 ;
 ;short circuit if not a production system
 I '$$PROD^XUPROD(1) D  Q
 . S PRCOK=0
 . D BMES^XPDUTL("    **********")
 . D MES^XPDUTL("      WARNING: This is not a production system.")
 . D MES^XPDUTL("      The job to perform an initial data extract of 1358")
 . D MES^XPDUTL("      transactions and transmit them to the Online")
 . D MES^XPDUTL("      Certification System will not be queued.")
 . D MES^XPDUTL("    **********")
 ;
 ;short circuit if job already running
 S PRCTASK=$G(^XTMP("PRC153P","TASK"))
 I +PRCTASK D  Q
 . I $$STATUS(PRCTASK)>0 D
 . . S PRCOK=0
 . . D BMES^XPDUTL("    **********")
 . . D MES^XPDUTL("      WARNING: Duplicate processes cannot be started.")
 . . D MES^XPDUTL("      The job to perform an initial data extract of 1358")
 . . D MES^XPDUTL("      transactions and transmit them to the Online")
 . . D MES^XPDUTL("      Certification System is already running.")
 . . D MES^XPDUTL("      The task number is "_PRCTASK)
 . . D MES^XPDUTL("    **********")
 ;
 ;short circuit if job has been run previously
 S PRCVAL=$$GET^XPAR("SYS","PRC OLCS 1358 EXTRACT",1,"E")
 I $G(PRCVAL)]"" D  Q
 . S PRCOK=0
 . D BMES^XPDUTL("    **********")
 . D MES^XPDUTL("      WARNING: The job has been run previously.")
 . D MES^XPDUTL("      The job to perform an initial data extract of 1358")
 . D MES^XPDUTL("      transactions and transmit them to the Online")
 . D MES^XPDUTL("      Certification System will not be queued.")
 . D MES^XPDUTL("      The job completed on "_PRCVAL)
 . D MES^XPDUTL("    **********")
 Q
 ;
 ;
POST1 ;Add member to OLP mail group
 ;
 ; This procedure adds the installer or Postmaster as a new member to
 ; the OLP mail group.  
 ;
 ; Supported IAs:
 ;  #10141 Allows use of supported Kernel call BMES^XPDUTL and MES^XPDUTL
 ;  #10067 Allows use of supported Mailman call CHK^XMA21
 ;   #1146 Allows use of supported Mailman call $$MG^XMBGRP
 ;   #2051 Allows use of supported FM call $$FIND1^DIC
 ;
 ;  Input: None
 ; Output: None
 ;
 N PRCDUZ ;installer DUZ, otherwise Postmaster
 N PRCIEN ;IEN of the mail group in the MAIL GROUP file (#3.8)
 N PRCMEM ;text used in success msg
 N PRCTXT ;array of text to put in description field of mail group
 N PRCXMY ;array of local users to add to the mail group
 ;
 ;short circuit if mail group does not exist
 S PRCIEN=$$FIND1^DIC(3.8,"","X","OLP","B")
 I 'PRCIEN D  Q
 . D BMES^XPDUTL("    **********")
 . D MES^XPDUTL("      ERROR: The OLP Mail Group does not exist!")
 . D MES^XPDUTL("")
 . D MES^XPDUTL("      Please enter a Remedy ticket for assistance.")
 . D MES^XPDUTL("    **********")
 ;
 S PRCDUZ=$S(+$G(DUZ)>0:DUZ,1:.5)
 S PRCXMY(PRCDUZ)=""
 S PRCMEM=$S(PRCDUZ=.5:"Postmaster",1:"Installer")
 S PRCTXT(0)="" ;required for $$MG^XMBGRP call, ignored if not creating mail group
 ;
 ;short circuit if installer is already a member
 N Y     ;IEN of the mail group in the MAIL GROUP file (#3.8)
 N XMDUZ ;DUZ of user to look for
 S XMDUZ=PRCDUZ
 S Y=PRCIEN
 D CHK^XMA21
 I $T D  Q
 . D BMES^XPDUTL("    **********")
 . D MES^XPDUTL("      WARNING: "_PRCMEM_" is already a member of the OLP mail")
 . D MES^XPDUTL("      group. No action required.")
 . D MES^XPDUTL("    **********")
 ;
 ;add mail group member (silent call to MailMan API)
 I $$MG^XMBGRP("OLP",0,PRCDUZ,0,.PRCXMY,.PRCTXT,1) D
 . D BMES^XPDUTL("    **********")
 . D MES^XPDUTL("      SUCCESS: "_PRCMEM_" successfully added as a member")
 . D MES^XPDUTL("      to the OLP Mail Group.")
 . D MES^XPDUTL("")
 . D MES^XPDUTL("      After the patch installation, please enter other members")
 . D MES^XPDUTL("      as appropriate.")
 . D MES^XPDUTL("    **********")
 E  D
 . D BMES^XPDUTL("    **********")
 . D MES^XPDUTL("      ERROR: No members could be added to the OLP Mail Group!")
 . D MES^XPDUTL("")
 . D MES^XPDUTL("      Please enter a Remedy ticket for assistance.")
 . D MES^XPDUTL("    **********")
 Q
 ;
 ;
POST2 ;Queue initial data extract
 ;
 ; This procedure is responsible for queuing the initial data extract.
 ; Upon queuing the job, the task number assigned will be placed in
 ; the ^XTMP global.
 ;
 ;  Input: None
 ; Output: None
 ;
 ; Supported IAs:
 ;  #10141 Allows use of supported Kernel call BMES^XPDUTL and MES^XPDUTL
 ;  #10103 Allows use of supported Kernel call $$FMADD^XLFDT
 ;  #10063 Allows use of supported Kernel call ^%ZTLOAD
 ;
 N ZTRTN  ;the API TaskMan will DO to start the task
 N ZTDESC ;task description
 N ZTSK   ;task number assigned to the task
 N ZTSAVE ;save input variables to the task 
 N ZTIO   ;(optional) I/O device the task should use
 N ZTDTH  ;(optional) start time when TaskMan should start the task
 ;
 K ^XTMP("PRC153P")
 S ZTRTN="EXTRACT^PRCFDO1"
 S ZTDESC="PRC*5.1*153 INITIAL EXTRACT OF 1358 TRANSACTIONS"
 S ZTIO=""
 S ZTSAVE("DUZ")=""
 S ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 ;success
 I $G(ZTSK) D
 . S ^XTMP("PRC153P",0)=$$FMADD^XLFDT(DT,3)_"^"_DT_"^"_"PRC*5.1*153 Initial extract 1358 transactions"
 . S ^XTMP("PRC153P","TASK")=ZTSK
 . D BMES^XPDUTL("    **********")
 . D MES^XPDUTL("      SUCCESS: Job was queued.")
 . D MES^XPDUTL("      The job to perform an initial data extract of 1358")
 . D MES^XPDUTL("      transactions and transmit them to the Online")
 . D MES^XPDUTL("      Certification System was successfully queued.")
 . D MES^XPDUTL("      The task number is "_ZTSK)
 . D MES^XPDUTL("    **********")
 ;failure
 I '$G(ZTSK) D
 . D BMES^XPDUTL("    **********")
 . D MES^XPDUTL("      ERROR: Job was not queued!")
 . D MES^XPDUTL("      The job to perform an initial data extract of 1358")
 . D MES^XPDUTL("      transactions and transmit them to the Online")
 . D MES^XPDUTL("      Certification System was not successfully queued.")
 . D MES^XPDUTL("      Please enter a Remedy ticket for assistance.")
 . D MES^XPDUTL("    **********")
 Q
 ;
 ;
STATUS(PRCTASK) ;Determine status of a task
 ;
 ; This procedure will determine the status of a task.
 ;
 ; Supported IAs:
 ;  #10063 Allows use of supported Kernel call STAT^%ZTLOAD
 ;
 ;  Input: 
 ;   PRCTASK - task number to lookup
 ;
 ; Output:
 ;   Function Value - Returns 1 if task has finished, 0 otherwise
 ;
 N ZTSK
 N RESULT
 S RESULT=0
 S ZTSK=+$G(PRCTASK)
 D STAT^%ZTLOAD
 ;
 D  ;drops out of DO block on failure
 . Q:ZTSK(0)=0  ;Undefined task
 . Q:ZTSK(1)=1  ;Active: Pending
 . Q:ZTSK(1)=2  ;Active: Running
 . Q:ZTSK(1)=4  ;Inactive: Available
 . Q:ZTSK(1)=5  ;Inactive: Interrupted
 . S RESULT=1
 Q RESULT
