ORMTIME ; SLC/RJS - PROCESS TIME BASED EVENT ;9/29/99  09:35 [2/1/00 9:30am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**40,253,243**;Dec 17, 1997;Build 242
 ;
EN ; Main entry tag.
 ;
 N OCXPSDT,OCXZTSK,OCXERR,OCXORMTR,OCXSTDT,OCXLOCK,OCXPAR
 K ^TMP("OCXORMTIME",$J)
 S OCXLOCK=0
 S OCXORMTR="ORMTIME: Startup"
 S OCXSTDT=$$EDATE($$IDATE("NOW"))
 S ^TMP("OCXORMTIME",$J,"STATUS")="ORMTIME: Attempting to lock ^OR(100,""AE"") at "_OCXSTDT_"."
 L +^OR(100,"AE"):10
 I  D
 .S OCXLOCK=1
 .D SCAN
 .L -^OR(100,"AE")
 .K ^TMP("OCXORMTIME")
 .S OCXPAR=$$IDATE2("NOW")
 .D PUT^XPAR("SYS","ORM ORMTIME LAST RUN",1,OCXPAR,.OCXERR)
 S:'OCXLOCK ^TMP("OCXORMTIME",$J,"STATUS")="ORMTIME: Unable to lock ^OR(100,""AE"") at "_OCXSTDT_" attempt."
 Q
 ;
SCAN ; Call ORMTIM01 for order checking, etc.  ORMTIM02 for misc time based tasks
 ;
 D SCAN^ORMTIM01
 D MISC^ORMTIM02
 D TASK^ORTSKLPS
 Q
 ;
EDATE(Y) X ^DD("DD") S:(Y["@") Y=$P(Y,"@",1)_" at "_$P(Y,"@",2) Q Y
 ;
IDATE(X) N %DT,Y S %DT="F" D ^%DT Q Y
 ;
IDATE2(X) N %DT,Y S %DT="TF" D ^%DT Q Y
 ;
REQUEUE(ORMQT) ; Code formerly queued ORMTIME tasks in Taskman.
 ;
 ; (This tag kept for compatibility with outside calls.)
 ;
 Q
 ;
STATUS ; Check status of last ORMTIME run. 
 ;
 N ORMLAST
 ;
 ; Get date/time of last ORMTIME run:
 S ORMLAST=$$GET^XPAR("SYS","ORM ORMTIME LAST RUN",1,"I")
 S ORMLAST=$$EDATE(ORMLAST) ; Convert to external format for display.
 ;
 ; Present information to user:
 W !
 W !,"     ORMTIME last ran "_ORMLAST_"."
 W !
 ;
 Q
 ;
BULL ; Send a bulletin if ORMTIME's last run is greater than 24 hours.
 ;
 N DIC,ORMMSG,X,XMSUB,XMTEXT,XMY,XMZ,Y,ORMLAST
 ;
 ; Don't send bulletin if ORMTIME STATUS mail group does not exist:
 S DIC=3.8,DIC(0)="",X="ORMTIME STATUS"
 D ^DIC Q:(+Y<0)
 ;
 S ORMLAST=$$GET^XPAR("SYS","ORM ORMTIME LAST RUN",1,"I")
 I $$FMDIFF^XLFDT($$IDATE2("NOW"),ORMLAST,2)>86400  D
 .S XMY("G.ORMTIME STATUS")=""
 .S XMSUB=" ORMTIME Warning"
 .S ORMMSG(1,0)=" "
 .S ORMMSG(2,0)="    The ORMTIME process last ran more than 24 hours ago. "
 .S ORMMSG(3,0)=" "
 .S ORMMSG(4,0)=" The ORMTIME background job handles activating and expiring orders,"
 .S ORMMSG(5,0)=" some time based notifications, as well as purging of temporary CPRS"
 .S ORMMSG(6,0)=" data. It is important that it runs regularly."
 .S ORMMSG(7,0)=" "
 .S ORMMSG(8,0)="    Assure that the scheduled option, ORMTIME RUN, is correctly implemented."
 .S ORMMSG(9,0)=" "
 .S XMTEXT="ORMMSG("
 .D ^XMD
 Q
 ;
