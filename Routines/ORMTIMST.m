ORMTIMST ; JM/SLC-ISC - ORMTIME STATUS ROUTINES ;06/06/2006
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**253**;Dec 17, 1997
 ;
EN ; Pre-install environment check - will ORMTIME run in the next 5 minutes?
 ;
 D ENVCHECK(5)
 Q
 ;
RUNNING() ; Checks to see if ORMTIME is running
 L +^OR(100,"AE"):2 I $T L -^OR(100,"AE") Q 0
 Q 1
 ;
NEXTRUN() ; Number of minutes before the next scheduled run of ORMTIME. - returns in format MINUTES:SECONDS
 ;  If past scheduled time, but within the last 10 minutes, returns 0 (give TaskMan time to invoke it)
 ;  If -1, unable to determine value
 N RESULT,ORY,I,SCHDT,NOWDT,DIFFDT,MAX,DELAY,SEC,MIN,PASTDUE
 S MAX=9999999
 S RESULT=MAX
 S DELAY=10 ; Give Taskman 10 minutes to invoke ORMTIME
 S NOWDT=$$NOW^XLFDT
 S PASTDUE=$$FMADD^XLFDT(NOWDT,0,0,-DELAY,0)
 D OPTSTAT^XUTMOPT("ORMTIME RUN",.ORY)  ; get option schedule info IA# 1472
 F I=1:1:ORY D  Q:(RESULT=0)
 . S SCHDT=$P(ORY(I),U,2)  ; next scheduled ORMTIME run time
 . S DIFFDT=$$FMDIFF^XLFDT(SCHDT,NOWDT,2)
 . I DIFFDT<0 D  Q
 . . I SCHDT>PASTDUE S RESULT=0
 . I RESULT>DIFFDT S RESULT=DIFFDT
 I RESULT=MAX S RESULT=-1
 I RESULT>0 D
 . S SEC=RESULT#60,MIN=RESULT\60
 . I SEC<10 S SEC="0"_SEC
 . S RESULT=MIN_":"_SEC
 Q RESULT
 ;
ENVCHECK(MINUTES) ; Environment check to see if ORMTIME is running, or will run in the next few minutes
 ;
 I '+$G(XPDENV) Q  ; Don't evaluate during the global load - just when actually installing
 N KIDS
 S KIDS=1
 G ENVMAIN
 ;
ENVTEST(MINUTES) ; Run for testing purposes only
 N KIDS
 S KIDS=0
 ;
ENVMAIN ;
 N I,RUNNING,MSG,CHKSOON,SOON,COUNT,NEXT,STARTMSG
 D BOUT("Checking ORMTIME status...")
 S RUNNING=$$RUNNING
 S CHKSOON=1
 S MSG="ORMTIME is "
 I RUNNING S MSG=MSG_"running, waiting for it to finish..."
 E  S MSG=MSG_"not running."
 D BOUT(MSG)
 I RUNNING D
 . S (COUNT,CHKSOON)=0
 . F I=1:1:15 D  Q:'RUNNING
 . . S RUNNING=$$RUNNING
 . . I RUNNING S COUNT=COUNT+1 I COUNT>2 S COUNT=0 D OUT("   ORMTIME is still running...")
 . I 'RUNNING D
 . . H 2 ; Wait 2 seconds after the lock is released, to make sure ORMTIME is finished executing
 . . D OUT("ORMTIME is done.")
 I RUNNING D ABORT("ORMTIME is taking too long to run.") Q
 ;
 I CHKSOON D  Q:SOON
 . D BOUT("Checking ORMTIME Schedule...")
 . S NEXT=$$NEXTRUN
 . S SOON=1
 . I (NEXT<0)!(NEXT'<MINUTES) S SOON=0
 . S MSG="ORMTIME is "
 . I SOON D  I 1
 . . I NEXT<1 S STARTMSG="less than a minute."
 . . E  S STARTMSG=NEXT_" minutes."
 . E  S MSG=MSG_"not " S STARTMSG="the next "_MINUTES_":00 minutes."
 . S MSG=MSG_"scheduled to run in "_STARTMSG
 . D BOUT(MSG)
 . I SOON D ABORT("Too close to ORMTIME's scheduled start time.")
 D BOUT("Installation conditions are acceptable, continuing installation...")
 Q
 ;
ABORT(TXT) ; Send abort message
 D BOUT("***********************************")
 D OUT("*****  ABORTING INSTALLATION  *****")
 D OUT("***********************************")
 D OUT(TXT)
 D OUT("Try installation again after ORMTIME completes.")
 S XPDQUIT=2  ;abort installation but leave transport global in ^XTMP
 Q
 ;
OUT(TEXT) ; Send output - if run from install, send to MES^XPDUTL
 I KIDS D MES^XPDUTL(TEXT) I 1
 E  W TEXT,!
 Q
BOUT(TEXT) ; Send output - if run from install, send to BMES^XPDUTL
 I KIDS D BMES^XPDUTL(TEXT) I 1
 E  W !,TEXT,!
 Q
PRETEST ; test install
 N KIDS
 S KIDS=0
 G PREMAIN
 ;
PRECHECK ; Start install - make sure ORMTIME doesn't run while the installation takes place.
 N KIDS
 S KIDS=1
PREMAIN ;
 N COUNT
 S COUNT=0
 F  Q:'$$RUNNING  D
 .  I COUNT=0 D BOUT("ORMTIME is running.  Install waiting for ORMTIME to finished...")
 .  S COUNT=COUNT+1
 .  I COUNT>4 D OUT("   ORMTIME is still running...") S COUNT=1
 I COUNT>0 H 2 D BOUT("ORMTIME has finished running, continuing with install...")
 D BOUT("Starting ORMTIME update...")
 Q
