SOW3P65 ;ADM/DBE - Social Work Package Decommission ;5/9/19
 ;;3.0;Social Work;**65**;27 Apr 93;Build 2
 ;
 ;The Social Work package is being retired. This routine will remove
 ;the Social Work files and data
 ;
 Q
 ;
TASK ;task the file deletion
 ;
 N ZTRTN,ZTDESC,ZTIO,ZTDTH
 D MES^XPDUTL(" ")
 D MES^XPDUTL("A background job will be tasked to delete all Social Work files and data.")
 D MES^XPDUTL("A Mailman message will be generated and sent to the installer when the job")
 D MES^XPDUTL("is completed.")
 S ZTRTN="BEGDEL^SOW3P65",ZTDESC="Social Work Package File & Data Removal"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
BEGDEL ;background job entry point to remove all files and data
 ;
 N DIU,SOWCNT,SOWNODE,SOWLOOP,SOWTXT,SOWFILE,SOWFLG,SOWSTART,SOWEND,SOWSTR
 S (SOWCNT,SOWFLG)=0,SOWSTART=$$FMTE^XLFDT($$NOW^XLFDT,1)
 K ^TMP($J,"SOWP65")
 F SOWLOOP=1:1 S SOWTXT=$P($T(MSGTXT+SOWLOOP),";;",2) Q:SOWTXT="QUIT"  D LINE(SOWTXT)  ;build beginning of mail message
 S DIU(0)="DST" ;flags to delete data, subfile and templates
 F SOWFILE=650,650.1,651:1:653,655,655.2:.001:655.203,656 D  ;loop through known social work files
 .S DIU=$$ROOT^DILFD(SOWFILE),SOWNODE=$$CREF^DILF(DIU) ;set diu=file root and sownode=closed file root
 .I '$$VFILE^DILFD(SOWFILE) Q  ;verify file exists
 .D EN^DIU2  ;delete file and data in diu
 .;check if DD and data is removed
 .I '$D(@SOWNODE),'$$VFILE^DILFD(SOWFILE) D  Q  ;file successfully deleted
 ..S SOWSTR=DIU_" successfully removed" D LINE(SOWSTR) Q
 .S SOWSTR=DIU_" was not successfully removed",SOWFLG=1 D LINE(SOWSTR)  ;fall through if file not deleted
 I SOWFLG D
 .D LINE("")
 .S SOWSTR="A file was not removed successfully. Please have your IRM re-run"
 .S SOWSTR=SOWSTR_" the background job" D LINE(SOWSTR)
 .S SOWSTR="by entering this command at the programmer's prompt" D LINE(SOWSTR)
 .S SOWSTR="   D BEGDEL^SOW3P65"
 D DIRCHK  ;check if namespaced routines remain
 D LINE("")
 S SOWSTART="Start Time: "_SOWSTART D LINE(SOWSTART)
 S SOWEND=$$FMTE^XLFDT($$NOW^XLFDT,1)
 S SOWEND="End Time:   "_SOWEND D LINE(SOWEND)
 D MAIL  ;send mail message
 K ^TMP($J,"SOWP65")
 Q
 ;
MSGTXT ;message into
 ;; The Social Work package is being retired and all data and data
 ;; dictionary entries will be removed from the system. This 
 ;; message shows a list of files that were removed.
 ;;
 ;;QUIT
 Q
LINE(TEXT) ;add line to tmp global stored for mail message
 ;
 S SOWCNT=SOWCNT+1,^TMP($J,"SOWP65",SOWCNT)=TEXT
 Q
 ;
DIRCHK ;checks ^ROUTINE global for files beginning with SOW that were not removed
 ;
 N X,SOWFND,SOWSTR
 S SOWFND=1
 S X="SOV~" F  S X=$O(^ROUTINE(X)) Q:(X="")!($E(X,1,3)'="SOW")  D
 .I X="SOW3P65" Q
 .I SOWFND D  ;only print header message once
 ..D LINE("")
 ..S SOWSTR="The following routines beginning with SOW were found in the directory." D LINE(SOWSTR)
 ..S SOWSTR="They were not removed with patch SOW*3.0*65 installation. You will need to" D LINE(SOWSTR)
 ..S SOWSTR="review these routines and delete them if necessary." D LINE(SOWSTR)
 .D LINE(X) S SOWFND=0 ;turn off header message print
 Q
 ;
MAIL ;send message
 ;
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Social Work Package Data & Data Dictionary Removal"
 S XMTEXT="^TMP($J,""SOWP65"","
 D ^XMD
 Q
