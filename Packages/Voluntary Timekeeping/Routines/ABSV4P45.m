ABSV4P45 ;LKG/OI&T - VOLUNTARY TIMEKEEPING PKG DECOMMISSIONING ;12/10/20  10:35
V ;;4.0;VOLUNTARY TIMEKEEPING;**45**;JULY 6, 1994;Build 12
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;The Voluntary Timekeeping package is being retired. This routine will
 ;remove the Voluntary Timekeeping files and data
 ;
 ;
TASK ;task the file deletion
 ;
 N ZTRTN,ZTDESC,ZTIO,ZTDTH
 D MES^XPDUTL(" ")
 D MES^XPDUTL("A background job will be tasked to delete Voluntary Timekeeping")
 D MES^XPDUTL("files and data...")
 D MES^XPDUTL("A Mailman message will be generated and sent to the installer when")
 D MES^XPDUTL("the job is completed.")
 S ZTRTN="BEGDEL^ABSV4P45",ZTDESC="Voluntary Timekeeping Pkg File & Data Removal"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
BEGDEL ;background job entry point to remove all files and data
 ;
 N DIU,ABSVCNT,ABSVNODE,ABSVLOOP,ABSVTXT,ABSVFILE,ABSVFLG,ABSVSTART,ABSVEND,ABSVSTR
 S (ABSVCNT,ABSVFLG)=0,ABSVSTART=$$FMTE^XLFDT($$NOW^XLFDT,1)
 K ^TMP($J,"ABSV4P45")
 F ABSVLOOP=1:1 S ABSVTXT=$P($T(MSGTXT+ABSVLOOP),";;",2) Q:ABSVTXT="QUIT"  D LINE(ABSVTXT)  ;build beginning of mail message
 S DIU(0)="DT" ;flags to delete data and templates
 ;Loop through known Voluntary Timekeeping files
 F ABSVFILE=503330,503330.1,503330.2,503331,503332,503333,503334,503334.1,503335,503336,503337,503338,503338.1,503339,503339.1,503339.2,503339.3,503339.5,503339.9,503340,503340.1,503341,503342,503343,503344,503345,503346.1,503347 D
 .S DIU=$$ROOT^DILFD(ABSVFILE),ABSVNODE=$$CREF^DILF(DIU) ;set diu=file root and absvnode=closed file root
 .I '$$VFILE^DILFD(ABSVFILE) Q  ;verify file exists
 .D EN^DIU2  ;delete file and data in diu
 .;check if DD and data is removed
 .I '$D(@ABSVNODE),'$$VFILE^DILFD(ABSVFILE) D  Q  ;file successfully deleted
 ..S ABSVSTR=DIU_" successfully removed" D LINE(ABSVSTR) Q
 .S ABSVSTR=DIU_" was not successfully removed",ABSVFLG=1 D LINE(ABSVSTR)  ;fall through if file not deleted
 I ABSVFLG D
 .D LINE("")
 .S ABSVSTR="A file was not removed successfully. Please re-run the"
 .S ABSVSTR=ABSVSTR_" background job" D LINE(ABSVSTR)
 .S ABSVSTR="by entering this command at the programmer's prompt:" D LINE(ABSVSTR)
 .S ABSVSTR="   D BEGDEL^ABSV4P45" D LINE(ABSVSTR)
 D DELFX
 D DIRCHK  ;check if namespaced routines remain
 D LINE("")
 S ABSVSTART="Start Time: "_ABSVSTART D LINE(ABSVSTART)
 S ABSVEND=$$FMTE^XLFDT($$NOW^XLFDT,1)
 S ABSVEND="End Time:   "_ABSVEND D LINE(ABSVEND)
 D MAIL  ;send mail message
 K ^TMP($J,"ABSV4P45")
 Q
DELFX ;Delete functions in FUNC list
 N ABSVI,ABSVN
 F ABSVI=1:1 S ABSVN=$P($T(FUNC+ABSVI),";;",2) Q:ABSVN="**END**"  D
 . N ABSVDA,ABSVARR,ABSVERR S ABSVDA=$$FIND1^DIC(.5,"","BX",ABSVN) Q:ABSVDA'>0
 . S ABSVARR(.5,ABSVDA_",",.01)="@" D FILE^DIE("EK","ABSVARR","ABSVERR")
 Q
 ;
MSGTXT ;message into
 ;; The Voluntary Timekeeping pkg is being retired and all data and data
 ;; dictionaries will be removed from the system. This message shows a
 ;; list of files that were removed.
 ;;
 ;;QUIT
 Q
LINE(TEXT) ;add line to tmp global stored for mail message
 ;
 S ABSVCNT=ABSVCNT+1,^TMP($J,"ABSV4P45",ABSVCNT)=TEXT
 Q
 ;
DIRCHK ;checks ^ROUTINE global for files beginning with ABSV that were not removed
 ;
 N X,ABSVFND,ABSVSTR
 S ABSVFND=1
 S X="ABSU~" F  S X=$O(^ROUTINE(X)) Q:(X="")!($E(X,1,4)'="ABSV")  D
 .I X="ABSV4P45" Q
 .I ABSVFND D 
 ..D LINE("")
 ..S ABSVSTR="The following routines beginning with ABSV were found in the directory." D LINE(ABSVSTR)
 ..S ABSVSTR="They were not removed with patch ABSV*4*45 installation. You will need to" D LINE(ABSVSTR)
 ..S ABSVSTR="review these routines and delete them if necessary." D LINE(ABSVSTR)
 .D LINE(X) S ABSVFND=0
 Q
 ;
MAIL ;send message
 ;
 N XMDUZ,XMY,XMTEXT,XMSUB,DIFROM
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Voluntary Timekeeping Package Data & Data Dictionary Removal"
 S XMTEXT="^TMP($J,""ABSV4P45"","
 D ^XMD
 Q
 ;
FUNC ;List of Volunatary Timekeeping functions to be removed
 ;;ABSVAGE
 ;;ABSVM VOLREMARKS
 ;;ABSV DOLLAR
 ;;ABSVM FIX DATE
 ;;ABSVM NAME FAMILY
 ;;ABSVM NAME GIVEN
 ;;ABSVM NAME MIDDLE
 ;;ABSVM NAME SUFFIX
 ;;ABSVM SITE
 ;;**END**
