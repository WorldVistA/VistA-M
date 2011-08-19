VDEFKIDS ;BPOIFO/JG - VDEF Patch Pre & Post Install ; 19 Dec 2005  3:06 PM
 ;;1.0;VDEF;**3**;Dec 28, 2004
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; IA: 10063 - $$ASKSTOP^%ZTLOAD
 ;     10063 - RTN^%ZTLOAD
 ;     10103 - $$FMADD^XLFDT
 ;
PREIN ; This program will suspend all VDEF Request Queues and stop
 ; the VDEF Monitor tasks for the install of this patch.
 ; It is run as the KIDS Environment Check Routine because
 ; if it is run as a Pre-Install routine, all the programs
 ; in the build are already loaded which may cause
 ; EDITED error trap errors.
 ;
 I $G(XPDNM)'?1"VDEF*".E W !,"Must be run as a KIDS Environment Check." S XPDABORT=1 Q
 ;
 ; Check for XU*8.0*339 patch
 I '$L($T(JOB^%ZTLOAD)) W !,"XU*8.0*339 required for installation of this patch." S XPDABORT=1 Q
 ;
 ; Quit if loading a distribution, continue if installing.
 Q:$G(XPDENV)'=1
 W !!,"Suspending Request Queues and stopping associated TaskMan jobs"
 NEW QUEUE,STAT,TMTASKC,TMTASKF,VDEFIDT,X,VDEFUP
 S VDEFIDT=$$FMADD^XLFDT(DT,2)
 K ^XTMP("VDEFP1") S ^XTMP("VDEFP1",0)=VDEFIDT_"^"_DT
 ;
 ; Suspend running Request Queues
 S QUEUE=0 F  S QUEUE=$O(^VDEFHL7(579.3,QUEUE)) Q:'QUEUE  D
 . S STAT=$$GET1^DIQ(579.3,QUEUE_",",.09,"I") I STAT="R" D
 .. ; Suspend the request queue
 .. S VDEFUP(579.3,QUEUE_",",.09)="S" D FILE^DIE("","VDEFUP")
 .. ;
 .. ; Stop the current & future TaskMan tasks
 .. ; Wait up to 5 seconds for tasks to stop then delete them
 .. ; anyway since that means the process probably died.
 .. S TMTASKF=$$GET1^DIQ(579.3,QUEUE_",",.08,"I") ; Future
 .. I TMTASKF'="" D
 ... N ZTSK S ZTSK=TMTASKF S X=$$ASKSTOP^%ZTLOAD(ZTSK)
 ... N I F I=1:1:5 D STAT^%ZTLOAD Q:ZTSK(1)=0!(ZTSK(1)>2)  H 1
 ... K I D KILL^%ZTLOAD
 .. S TMTASKC=$$GET1^DIQ(579.3,QUEUE_",",.11,"I") ; Current
 .. I TMTASKC'=""&(TMTASKC'=TMTASKF) D
 ... N ZTSK S ZTSK=TMTASKC S X=$$ASKSTOP^%ZTLOAD(ZTSK)
 ... N I F I=1:1:5 D STAT^%ZTLOAD Q:ZTSK(1)=0!(ZTSK(1)>2)  H 1
 ... K I D KILL^%ZTLOAD
 .. S ^XTMP("VDEFP1",QUEUE)=""
 ;
 ; Stop the checked out request monitor
 W !!,"Stopping the MONITOR^VDEFCONT task"
 S ZTSK=$$GET1^DIQ(579.5,"1,",.06)
 I ZTSK'="" D
 . S X=$$ASKSTOP^%ZTLOAD(ZTSK)
 . N I F I=1:1:5 D STAT^%ZTLOAD Q:ZTSK(1)=0!(ZTSK(1)>2)  H 1
 . K I D KILL^%ZTLOAD
 ;
 ; Stop the Request Queue process monitor
 W !!,"Stopping the MONITOR^VDEFMON task"
 N TASK D RTN^%ZTLOAD("VDEFMON","TASK")
 S ZTSK=$O(TASK(0)) I ZTSK D
 . S X=$$ASKSTOP^%ZTLOAD(ZTSK)
 . N I F I=1:1:5 D STAT^%ZTLOAD Q:ZTSK(1)=0!(ZTSK(1)>2)  H 1
 . K I D KILL^%ZTLOAD
 ;
 ; Allow enough time for the VMS processes to quit.
 W !!,"Waiting for processes to quit " N I F I=1:1:5 W ". " H 1
 K I
 Q
 ;
 ;
POSTIN ; This program will restart suspended Request Queues start the VDEF
 ; monitor processes after the KIDS install.
 ;
 I $G(XPDNM)'?1"VDEF*".E W !,"Must be run as a KIDS Environment Check." S XPDABORT=1 Q
 ;
 ; Don't start VDEF processes on test and Legacy systems
 I '$$PROD^XUPROD(1) D BMES^XPDUTL("VDEF is not started on test systems.") Q
 D BMES^XPDUTL("Starting the Request Queues and associated Tasks")
 ;
 ; For each Request Queue defined, change the status to
 ; 'Running' and start the Request Queue process for the queue.
 NEW QUEUE,STAT,VDEFUP,I,QUENAM
 S QUEUE=0 F  S QUEUE=$O(^XTMP("VDEFP1",QUEUE)) Q:'QUEUE  D
 . S QUENAM=$P(^VDEFHL7(579.3,QUEUE,0),U)
 . S STAT=$$GET1^DIQ(579.3,QUEUE_",",.09,"I") I STAT="S" D
 .. S VDEFUP(579.3,QUEUE_",",.09)="R" D FILE^DIE("","VDEFUP")
 .. F I=1:1:5 S STAT=$$GET1^DIQ(579.3,QUEUE_",",.09,"I") Q:STAT="R"  H 1
 .. I STAT="R" D REQ^VDEFCONT(QUEUE)
 .. E  D BMES^XPDUTL("**** VDEF '"_QUENAM_"' QUEUE DID NOT START. START IT FROM VDEF CONFIG MENU.")
 K ^XTMP("VDEFP1")
 ;
 ; Restart the Checked Out monitor process.
 D BMES^XPDUTL("Starting the MONITOR^VDEFCONT task")
 D MONCHKO^VDEFCONT
 ;
 ; Restart the Request Queue process monitor.
 D BMES^XPDUTL("Starting the MONITOR^VDEFMON task")
 D START1^VDEFMON
 Q
