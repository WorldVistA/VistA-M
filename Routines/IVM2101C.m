IVM2101C ;ALB/CKN,GTS - FILED BY IVM FLAG CLEANUP ; 2/17/05 4:52pm
 ;;2.0;INCOME VERIFICATION MATCH;**101**; 21-OCT-94;Build 5
 Q
TEST ; Test Mode
 S MODE=0
 ;
EP ;
 N TXT
 ;Create bulletin message in install file.
 ;Quit if initial check fails.
 Q:$$CHECK()
 ;Queue task
 D QUETASK
 Q
NMSPC() ;
 Q "IVM*2*101"
 ;
CHECK() ;Initial Checking
 ; Output : 0 - Conversion not running or completed
 ;          1 - Task is running or completed
 ;
 N DONE,STAT,TASKNUM,NAMESPC
 S DONE=0
 S NAMESPC=$$NMSPC()
 I '$D(^XTMP(NAMESPC)) Q DONE
 I $G(^XTMP(NAMESPC,"CONFIG","COMPLETED"))=1 D  Q DONE
 . D DONEMSG
 . S DONE=1
 S TASKNUM=$G(^XTMP(NAMESPC,"CONFIG","TASK"))
 I TASKNUM'="" D
 . S STAT=$$ACTIVE(TASKNUM)
 . I STAT>0 D RUNMSG S DONE=1
 Q DONE
ACTIVE(TASK) ;Checks if task is running or not
 ;  input   --   The taskman ID
 ;  output  --   1=The task is running
 ;               0=The task is not running
 ;
 N ZTSK,STAT,Y
 S STAT=0,ZTSK=+TASK
 D STAT^%ZTLOAD
 S Y=ZTSK(1)
 I Y=0 S STAT=-1
 I ",1,2,"[(","_Y_",") S STAT=1
 I ",3,5,"[(","_Y_",") S STAT=0
 Q STAT
 ;
QUETASK ;Queue the Task
 N TXT,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTDTH,NAMESPC
 S NAMESPC=$$NMSPC()
 S ZTRTN="EP1^IVM2101C",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC=NAMESPC_" - FILED BY IVM FLAG CLEANUP"
 ; Create XTMP array
 S X1=DT,X2=120 D C^%DTC
 S ^XTMP(NAMESPC,0)=X_"^"_$$DT^XLFDT_"^"_NAMESPC_" FIX FILED BY IVM ERROR"
 D ^%ZTLOAD S ^XTMP(NAMESPC,"CONFIG","TASK")=ZTSK
 S TXT(1)="Task: "_ZTSK_" Queued."
 D BMES^XPDUTL(.TXT)
 Q
EP1 ;Entry Point
 N XIEN,XIYR,EIEN,XRELIEN,XDGMT,AMTIEN,SOURCE,FIVM,NAMESPC
 N X,X1,X2,TOT,CNT,ZTSTOP
 S ZTSTOP=0
 S NAMESPC=$$NMSPC()
 S XIEN=+$G(^XTMP(NAMESPC,"CONFIG","CURRENT IEN"))
 ; Update XTMP array 0 node purge date.
 S X1=DT,X2=120 D C^%DTC
 S ^XTMP(NAMESPC,0)=X_"^"_$$DT^XLFDT_"^"_NAMESPC_" FIX FILED BY IVM ERROR"
 ;Store start date
 I '$D(^XTMP(NAMESPC,"CONFIG","START DATE")) S ^XTMP(NAMESPC,"CONFIG","START DATE")=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 S TOT=+$G(^XTMP(NAMESPC,"CONFIG","TOTAL PROCESSED"))
 S CNT=+$G(^XTMP(NAMESPC,"CONFIG","TOTAL FOUND"))
 ;Loop through 408.12 file - get Veteran IEN
 F  S XIEN=$O(^DGPR(408.12,"B",XIEN)) Q:+XIEN=0!(ZTSTOP)  D
 . S TOT=TOT+1  ;Processed records counter
 . S ^XTMP(NAMESPC,"CONFIG","TOTAL PROCESSED")=TOT
 . S ^XTMP(NAMESPC,"CONFIG","CURRENT IEN")=XIEN
 . I (TOT#1000=0),$$S^%ZTLOAD S ZTSTOP=1  ;Check for stop request
 . S XRELIEN=0
 . ;Get 408.12 iens for each Veteran
 . F  S XRELIEN=$O(^DGPR(408.12,"B",XIEN,XRELIEN)) Q:XRELIEN=""  D
 . . S EIEN=0
 . . F  S EIEN=$O(^DGPR(408.12,XRELIEN,"E",EIEN)) Q:EIEN=""  D
 . . . ;Get Filed By IVM flag
 . . . S FIVM=$P($G(^DGPR(408.12,XRELIEN,"E",EIEN,0)),"^",3)
 . . . I FIVM="" Q  ;Quit if flag is not set
 . . . ; Get Annual Means test ien for FILED BY IVM flag
 . . . S AMTIEN=$P($G(^DGPR(408.12,XRELIEN,"E",EIEN,0)),"^",4)
 . . . Q:AMTIEN=""  ;Quit if Annual MT IEN is not set.
 . . . S XIYR=$P($G(^DGMT(408.31,AMTIEN,0)),"^")  ;Income Year
 . . . I XIYR<3040000 Q  ;Quit if income year is less than 2004
 . . . ;Get source of MT
 . . . S SOURCE=$P($G(^DGMT(408.31,AMTIEN,0)),"^",23)
 . . . ;If SOURCE OF INCOME TEST is VAMC or OTHER FACILITY
 . . . I (FIVM=1),((SOURCE=1)!(SOURCE=4)) D
 . . . . S SOURCE=SOURCE_"^"_$P($G(^DG(408.34,SOURCE,0)),"^",1)
 . . . . S CNT=CNT+1,^XTMP(NAMESPC,"CONFIG","TOTAL FOUND")=CNT
 . . . . S ^XTMP(NAMESPC,CNT,"PATIENT IEN")=XIEN
 . . . . S ^XTMP(NAMESPC,CNT,"ANNUAL MT IEN")=AMTIEN
 . . . . S ^XTMP(NAMESPC,CNT,"PATIENT RELATION IEN")=XRELIEN
 . . . . S ^XTMP(NAMESPC,CNT,"SOURCE OF INCOME TEST")=SOURCE
 . . . . S ^XTMP(NAMESPC,CNT,"PREVIOUS FILED BY IVM")=FIVM_"^YES"
 . . . . ;Reset FILED BY IVM field to NULL
 . . . . S $P(^DGPR(408.12,XRELIEN,"E",EIEN,0),"^",3)=""
 S ^XTMP(NAMESPC,"CONFIG","STOP DATE")=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 I ZTSTOP D  Q
 . D ABORTMSG
 S ^XTMP(NAMESPC,"CONFIG","COMPLETED")=1
 D COMPMSG
 Q
 ;
DONEMSG ;Send message that process is already Completed.
 N MSG,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB=NAMESPC_" - FILED BY IVM FLAG CLEANUP already completed"
 S XMDUZ=NAMESPC_" INSTALLATION PROCESS"
 S (XMY(.5),XMY(DUZ))="",XMTEXT="MSG("
 S MSG(1)="FILED BY IVM FLAG CLEANUP process was completed in previous run."
 D ^XMD
 D BMES^XPDUTL(.MSG)
 Q
RUNMSG ;Send message that process is currently running.
 N NAMESPC,MSG,XMDUZ,XMSUB,XMTEXT,XMY
 S NAMESPC=$$NMSPC()
 S XMSUB=NAMESPC_" - FILED BY IVM FLAG CLEANUP running"
 S XMDUZ=NAMESPC_" INSTALLATION PROCESS"
 S (XMY(.5),XMY(DUZ))="",XMTEXT="MSG("
 S MSG(1)="TASK: "_TASKNUM_" is currently running FILED BY IVM FLAG CLEANUP"
 S MSG(2)="process. Duplicate process cannot be started."
 D ^XMD
 D BMES^XPDUTL(.MSG)
 Q
ABORTMSG ;Send message for stop request.
 N MSG,XMDUX,XMSUB,XMTEXT,XMY
 S XMSUB=NAMESPC_" - FILED BY IVM FLAG CLEANUP stopped"
 S XMDUZ=NAMESPC_" INSTALLATION PROCESS"
 S (XMY(.5),XMY(DUZ))="",XMTEXT="MSG("
 S MSG(1)="TASK: "_$G(^XTMP(NAMESPC,"CONFIG","TASK"))_" FILED BY IVM FLAG CLEANUP"
 S MSG(2)=""
 S MSG(3)="FILED BY IVM error cleanup process was requested to stop"
 S MSG(4)="by the user. Please restart the process by using the following"
 S MSG(5)="command at the programmer prompt:"
 S MSG(6)="D EP^IVM2101C"
 D ^XMD
 Q
COMPMSG ;Send message for completed Task.
 N MSG,XMDUX,XMSUB,XMTEXT,XMY
 S XMSUB=NAMESPC_" - FILED BY IVM FLAG CLEANUP completed"
 S XMDUZ=NAMESPC_" INSTALLATION PROCESS"
 S (XMY(.5),XMY(DUZ))="",XMTEXT="MSG("
 S MSG(1)="TASK: "_$G(^XTMP(NAMESPC,"CONFIG","TASK"))_" FILED BY IVM FLAG CLEANUP"
 S MSG(2)=""
 S MSG(3)="FILED BY IVM error cleanup process has completed.  Review the"
 S MSG(4)="following ^XTMP global for details on the Patient Relation file (408.12)"
 S MSG(5)="records converted: ^XTMP("""_NAMESPC_""","
 S MSG(6)=""
 S MSG(7)="This global will be deleted in no more than 120 days from the date"
 S MSG(8)="of this message."
 D ^XMD
 Q
