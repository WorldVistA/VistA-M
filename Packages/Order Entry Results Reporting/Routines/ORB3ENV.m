ORB3ENV ; slc/CLA - OE/RR 3 Notifications/Order Check Environment Check Routine ;9/19/01  14:29
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**105**;Dec 17, 1997
EN ; main entry point
 D ORMTIME
 Q
ORMTIME ; determine if ORMTIME is running
 N I,J,STATUS,JOB,OK,LASTDT,NOWDT,DIFFDT,SCHDT,ORY,MSG
 S OK=0
 D BMES^XPDUTL("Checking to see if ORMTIME is running...")
 ;
 ;for loop that runs for 12 iterations (60 secs.) - quits if no lock
 F I=1:1:12 Q:OK=1  D
 .L +^OR(100,"AE"):5 I $T S OK=1 Q
 .I I=1 D BMES^XPDUTL("Pausing because ORMTIME is running...")
 .E  D MES^XPDUTL(".")
 ;
 I OK=1 LOCK  ;^OR(100,"AE"):0
 ;
 ;if ORMTIME is not currently running see if scheduled in near future:
 I OK=1 D
 .S LASTDT=$$GET^XPAR("SYS","ORM ORMTIME LAST RUN",1,"I")
 .;
 .D OPTSTAT^XUTMOPT("ORMTIME RUN",.ORY)  ;get option sch info IA# 1472
 .F J=1:1:ORY Q:OK=2  D
 ..S SCHDT=$P(ORY(J),U,2)  ;next scheduled ORMTIME run time
 ..S NOWDT=$$NOW^XLFDT
 ..S DIFFDT=$$FMDIFF^XLFDT(SCHDT,NOWDT,2)
 ..I DIFFDT>0,DIFFDT<300 S OK=2  ;if sched to run in less than 5 minutes
 ;
 I OK=1 D  ;ORMTIME not running
 .D BMES^XPDUTL("ORMTIME not running nor scheduled within 5 minutes. Okay to install.")
 ;
 I OK=0 D  ;ORMTIME still running
 .D BMES^XPDUTL("ORMTIME is still running...")
 .S JOB="",JOB=$O(^TMP("OCXORMTIME",JOB),-1)
 .I +$G(JOB)>0,$D(^TMP("OCXORMTIME",JOB,"STATUS")) D
 ..S STATUS=^TMP("OCXORMTIME",JOB,"STATUS")
 ..D MES^XPDUTL(STATUS)
 .D BMES^XPDUTL("*** ABORTING INSTALLATION *** - due to potential conflict with ORMTIME.")
 .D MES^XPDUTL("Try installation again after ORMTIME run completes.")
 .D MES^XPDUTL("(ORMTIME usually requires less than 10 mintues to run to completion.)")
 .S XPDQUIT=2  ;abort installation but leave transport global in ^XTMP
 ;
 I OK=2 D  ;ORMTIME scheduled to run before patch install completes
 .S MSG=$$FMTE^XLFDT(SCHDT)
 .S MSG="ORMTIME scheduled at: "_MSG_" and may impact patch installation."
 .D BMES^XPDUTL(MSG)
 .D BMES^XPDUTL("*** ABORTING INSTALLATION *** - due to potential conflict with ORMTIME.")
 .D MES^XPDUTL("Try installation again after ORMTIME run completes.")
 .D MES^XPDUTL("(ORMTIME usually requires less than 10 mintues to run to completion.)")
 .S XPDQUIT=2  ;abort installation but leave transport global in ^XTMP
 ;
 Q
