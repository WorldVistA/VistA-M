PSB3P68 ;BIRMINGHAM/GN - POST INSTALL FOR PSB3P68 ;2/23/12 4:38pm
 ;;3.0;BAR CODE MED ADMIN;**68**;Mar 2004;Build 26
 ;
 ; Init XPAR parameters DIV & SYS for PSB INJECTION SITE MAX HOURS
 ; and submit a background job to build two indexes AINJ & AINJOI
 ; for file 53.79.   
 ;
 ; Direct Programmer mode callable Tag's in this routine:
 ;  STATUS - shows user the current status of the background job
 ;  QUEUE  - allows user to manuall restart a previous Stopped or 
 ;           Errored job and it will resume with where it left off.
 ;
BEGIN ;
 N ENT,DV,T5,T10,T20,NAM,VAL
 S T5="",$P(T5," ",5)=" ",T10="",$P(T10," ",10)=" ",T20="",$P(T20," ",20)=" "
 S NAM="PSB INJECTION SITE MAX HOURS",VAL=72
 D INITSYS(NAM,VAL)
 D MES^XPDUTL("")
 D MES^XPDUTL("*** PSB*3*68 Post Install Running ***")
 D MES^XPDUTL("")
 D MES^XPDUTL(" Initialize BCMA parameter PSB INJECTION SITE MAX HOURS...")
 D MES^XPDUTL("")
 D MES^XPDUTL("   DIV"_T20_T10_"MAX HRS")
 D MES^XPDUTL("")
 D INITDIV(NAM,VAL,0)    ;before update
 D INITDIV(NAM,VAL,1)    ;after update
 D MES^XPDUTL("")
 H 2
 ;
QUEUE ;begin of queueing to background to run xref builder
 N DA,DIK,ENDTIME,QUIT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK,ZTQUEUED,ZTSAVE
 ;
 ; setup variables and submit Cross Ref builder to Taskman
 S ZTRTN=("JOB^PSB3P68")
 S ZTDESC="BCMA Injection Site Cross Ref Builder"
 S ZTDTH=$$NOW^XLFDT,ZTIO=""
 ;check if already running or completed.
 I $$CHKSTAT L -^XTMP($$NAMSPC) Q
 L -^XTMP($$NAMSPC)
 D ^%ZTLOAD
 S ZTDESC="BCMA Injection Site Cross Ref Builder"
 D MES^XPDUTL(""),MES^XPDUTL(" "_ZTDESC)
 I $G(ZTSK) D
 . D MES^XPDUTL(""),MES^XPDUTL(" This request queued as Task # "_ZTSK)
 . D MES^XPDUTL(""),MES^XPDUTL(" A Mailman message will be sent to you when the Cross Reference Builder")
 . D MES^XPDUTL(" completes.")
 . D MES^XPDUTL("")
 Q
 ;
JOB ; Entry point for taskman
 L +^XTMP($$NAMSPC):10 I '$T D  Q   ;quit if can't get a lock
 . S ^XTMP($$NAMSPC,0,"STATUS")="NO LOCK GAINED"_U_$$NOW^XLFDT
 . S ^TMP($$NAMSPC,$J,"MSG",1)=""
 . S ^TMP($$NAMSPC,$J,"MSG",2)=" Builder did not run, could not lock file."
 . D MAIL(ZTDESC)
 ;
 N PCT,RECS,TLRECS,IEN,ZTSTOP,NAMSPC,BEGTIME,PURGDT,STAT
 S NAMSPC=$$NAMSPC
 S ZTDESC=$G(ZTDESC,"PSB3P68")
 S ^XTMP(NAMSPC,0,"RECS TOTL")=$P($G(^PSB(53.79,0)),U,4)
 ;
 ;setup XTMP according to stds.
 S BEGTIME=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGTIME,30)
 S ^XTMP(NAMSPC,0)=PURGDT_U_BEGTIME_U_ZTDESC
 S ^XTMP(NAMSPC,0,"TASKID")=$G(ZTSK,"DIRECT")
 S:'$D(^XTMP(NAMSPC,0,"INITIAL TIME")) ^XTMP(NAMSPC,0,"INITIAL TIME")=$$NOW^XLFDT
 ;get last run data
 D GETLAST
 I STAT]"",STAT'["COMPLETED" D
 . S ^TMP($$NAMSPC,$J,"MSG",1)=""
 . S ^TMP($$NAMSPC,$J,"MSG",2)=" Cross Reference Builder Resuming with IEN "_IEN
 . S PCT=100-((RECS/TLRECS)*100\1)
 . S ^TMP($$NAMSPC,$J,"MSG",3)=" Job has "_PCT_"% remaining to complete."
 . D MAIL(ZTDESC)
 . S ^XTMP(NAMSPC,0,"RESTART")="RESTARTED: "_$$NOW^XLFDT
 ;
 ;init begin time, if not there, and status & stop time fields
 S ^XTMP(NAMSPC,0,"STATUS")="RUNNING since"_U_$$NOW^XLFDT
 S ^XTMP(NAMSPC,0,"RECS TOTL")=TLRECS
 ;
 ;start/restart cleanups
 S ZTSTOP=0
 F  S IEN=$O(^PSB(53.79,IEN),-1) Q:'IEN  D  Q:ZTSTOP
 . S DIK="^PSB(53.79,",DIK(1)=".01^AINJ^AINJOI"
 . S DA=IEN D EN1^DIK
 . S RECS=RECS+1
 . ;update and check for stop request after every 2000 processed recs
 . I RECS#2000=0 D
 . . S:$$S^%ZTLOAD ZTSTOP=1           ;Systems person asked to stop
 . . S ^XTMP(NAMSPC,0,"RECS DONE")=RECS
 . . S ^XTMP(NAMSPC,0,"LAST IEN")=IEN
 S ^XTMP(NAMSPC,0,"RECS DONE")=RECS
 S ^XTMP(NAMSPC,0,"LAST IEN")=IEN
 ;
 ;set proper Exit status
 I ZTSTOP D
 . S ^XTMP(NAMSPC,0,"STATUS")="STOPPED"_U_$$NOW^XLFDT
 E  D
 . S ^XTMP(NAMSPC,0,"STATUS")="COMPLETED"_U_$$NOW^XLFDT
 ;
 N LIN
 S LIN=0
 K ^TMP(NAMSPC,$J)
 ;get last run data
 D GETLAST
 ;build mailman text for message
 S LIN=LIN+1,^TMP(NAMSPC,$J,"MSG",LIN)=ZTDESC_" Status: "_STAT_" "_$$FMTE^XLFDT(ENDTIME)
 S LIN=LIN+1,^TMP(NAMSPC,$J,"MSG",LIN)=""
 S LIN=LIN+1,^TMP(NAMSPC,$J,"MSG",LIN)=$J("Total Records in file:",30)_$J($FN(TLRECS,","),15)
 S LIN=LIN+1,^TMP(NAMSPC,$J,"MSG",LIN)=$J("Records processed:",30)_$J($FN(RECS,","),15)
 I STAT'["COMPLETED" D
 . S LIN=LIN+1,^TMP(NAMSPC,$J,"MSG",LIN)=""
 . S LIN=LIN+1,^TMP(NAMSPC,$J,"MSG",LIN)=$J("Reading file backwards",29)
 . S LIN=LIN+1,^TMP(NAMSPC,$J,"MSG",LIN)=$J("Last IEN processed:",30)_$J(IEN,15)
 . S PCT=(RECS/TLRECS)*100\1
 I STAT["COMPLETED" D
 . S PCT=100
 . S LIN=LIN+1,^TMP(NAMSPC,$J,"MSG",LIN)=$J("Total elapsed time:",30)_$J($$FMDIFF^XLFDT(ENDTIME,BEGTIME,3),15)
 S LIN=LIN+1,^TMP(NAMSPC,$J,"MSG",LIN)=$J("Percent complete:",30)_$J(PCT,14)_"%"
 ;send the message
 D MAIL(ZTDESC)
 L -^XTMP(NAMSPC)
 K ^TMP(NAMSPC,$J)
 Q
 ; 
GETLAST ;get last run info  
 S IEN=+$G(^XTMP(NAMSPC,0,"LAST IEN"))             ;last ien
 S:IEN=0 IEN=999999999
 S STAT=$P($G(^XTMP(NAMSPC,0,"STATUS")),U)         ;status
 S RECS=+$G(^XTMP(NAMSPC,0,"RECS DONE"))           ;recs processed
 S TLRECS=+$G(^XTMP(NAMSPC,0,"RECS TOTL"))         ;tot recs in file
 S BEGTIME=$G(^XTMP(NAMSPC,0,"INITIAL TIME"))      ;initial begin time
 S ENDTIME=$P($G(^XTMP(NAMSPC,0,"STATUS")),U,2)    ;end time
 Q
 ;
INITSYS(NAM,VAL) ; Init the SYSTEM value
 ; Input: NAM = param name
 ;        VAL = num of hours
 ;
 D EN^XPAR("SYS",NAM,1,VAL)
 Q
 ;
INITDIV(NAM,VAL,UPD) ; Init DIVISION value
 ; Input: NAM = param name
 ;        VAL = num of hours
 ;        UPD = 1 to update, else list curr values only
 ;
 N FOUND S FOUND=0
 D:'UPD MES^XPDUTL(" Before update")
 D:UPD MES^XPDUTL(" After update")
 D MES^XPDUTL("")
 ;loop thru all medical divisions and only update those that use BCMA
 F DV=0:0 S DV=$O(^DG(40.8,"AD",DV)) Q:'DV  D
 . S ENT=DV_";DIC(4,"
 . Q:'$$GET^XPAR(ENT,"PSB ONLINE")
 . S FOUND=1
 . I UPD,+$$GET^XPAR(ENT,NAM,,"E")=0 D EN^XPAR(ENT,NAM,1,VAL)
 . D MES^XPDUTL("   "_$E($P(^DIC(4,+ENT,0),U)_T20,1,25)_T10_$$GET^XPAR(ENT,NAM,,"E"))
 D:'FOUND MES^XPDUTL(T5_"** NO DIVISIONS FOUND WITH BCMA ONLINE **")
 D:'FOUND MES^XPDUTL("   ** NO DIVISIONS FOUND WITH BCMA ONLINE **")
 D MES^XPDUTL("")
 Q
 ;
MAIL(HTEXT) ; send the mail message
 N XMY,XMDUZ,XMSUB,XMTEXT
 S XMY(DUZ)="",XMDUZ="PSB3P68 Post Install"
 S XMSUB=HTEXT_" Results"
 S XMTEXT="^TMP("""_$$NAMSPC_""",$J,""MSG"","
 D ^XMD
 K ^TMP($$NAMSPC)
 Q
 ;
CHKSTAT() ;check if job is running
 N Y,DUOUT,DTOUT,QUIT
 S NAMSPC=$$NAMSPC
 S STAT=$G(^XTMP(NAMSPC,0,"STATUS"))
 S QUIT=0
 L +^XTMP(NAMSPC):3
 I '$T D  H 2 Q 1
 . D MES^XPDUTL("*** WARNING ***"),MES^XPDUTL("")
 . D MES^XPDUTL(NAMSPC_" Cross Reference Builder is already RUNNING ")
 . D MES^XPDUTL(" from a previous install and can't be run now.")
 . D MES^XPDUTL("")
 I STAT["COMPLETED" D  H 2 Q 1
 . D MES^XPDUTL("*** WARNING ***"),MES^XPDUTL("")
 . D MES^XPDUTL(NAMSPC_" Cross Reference Builder was "_STAT)
 . D MES^XPDUTL(" by a previous install and can't run again.")
 . D MES^XPDUTL("")
 Q QUIT
 ;
STATUS ;Display status of this job
 ;check lock status
 N STAT,TIME,JOB,RECS,TLRESC,PCT,RUNNING
 L +^XTMP($$NAMSPC):3
 I '$T S RUNNING=1
 E  S RUNNING=0
 L -^XTMP($$NAMSPC)
 S STAT=$P(^XTMP($$NAMSPC,0,"STATUS"),U)
 S TIME=$P(^XTMP($$NAMSPC,0,"STATUS"),U,2)
 S JOB=$P(^XTMP($$NAMSPC,0),U,3)
 S RECS=+^XTMP($$NAMSPC,0,"RECS DONE")
 S TLRECS=+^XTMP($$NAMSPC,0,"RECS TOTL")
 S PCT=(RECS/TLRECS)*100\1
 I 'RUNNING,STAT["RUNNING" D  Q
 . W !!,JOB,!,"Has errored and quit abruptly.  Please restart Post Install",!
 . W !,"  at Programmers prompt '>' type 'D QUEUE^PSB3P68' and press Enter.",!!
 W !!,JOB,!,"Status: ",STAT,"   ",$$FMTE^XLFDT(TIME)
 W !,PCT,"% complete",!!
 Q
 ;
NAMSPC() ;
 Q "PSB3P68"
