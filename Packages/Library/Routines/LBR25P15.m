LBR25P15 ;ADM/DBE - Library Package Decommission ;12/21/17
 ;;2.5;Library;**15**;Mar 11, 1996;Build 10
 ;
 ;The Library package is being retired. This routine will remove
 ;the Library files and data
 ;
 Q
 ;
TASK ;task the file deletion
 ;
 N ZTRTN,ZTDESC,ZTIO,ZTDTH
 D MES^XPDUTL(" ")
 D MES^XPDUTL("A background job will be tasked to delete all Library files and data...")
 D MES^XPDUTL("A Mailman message will be generated and sent to the installer when the job")
 D MES^XPDUTL("is completed.")
 S ZTRTN="BEGDEL^LBR25P15",ZTDESC="Library Package File & Data Removal"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
BEGDEL ;background job entry point to remove all files and data
 ;
 N DIU,LBRCNT,LBRNODE,LBRLOOP,LBRTXT,LBRFILE,LBRFLG,LBRSTART,LBREND,LBRSTR
 S (LBRCNT,LBRFLG)=0,LBRSTART=$$FMTE^XLFDT($$NOW^XLFDT,1)
 K ^TMP($J,"LBRP15")
 F LBRLOOP=1:1 S LBRTXT=$P($T(MSGTXT+LBRLOOP),";;",2) Q:LBRTXT="QUIT"  D LINE(LBRTXT)  ;build beginning of mail message
 S DIU(0)="DST" ;flags to delete data, subfile and templates
 F LBRFILE=680:.1:680.9,681,681.1,682,682.1,686,686.11:.01:686.14 D  ;loop through known library files
 .S DIU=$$ROOT^DILFD(LBRFILE),LBRNODE=$$CREF^DILF(DIU) ;set diu=file root and lbrnode=closed file root
 .I '$$VFILE^DILFD(LBRFILE) Q  ;verify file exists
 .D EN^DIU2  ;delete file and data in diu
 .;check if DD and data is removed
 .I '$D(@LBRNODE),'$$VFILE^DILFD(LBRFILE) D  Q  ;file successfully deleted
 ..S LBRSTR=DIU_" successfully removed" D LINE(LBRSTR) Q
 .S LBRSTR=DIU_" was not successfully removed",LBRFLG=1 D LINE(LBRSTR)  ;fall through if file not deleted
 I LBRFLG D
 .D LINE("")
 .S LBRSTR="A file was not removed successfully. Please have your IRM re-run"
 .S LBRSTR=LBRSTR_" the background job" D LINE(LBRSTR)
 .S LBRSTR="by entering this command at the programmer's prompt" D LINE(LBRSTR)
 .S LBRSTR="   D BEGDEL^LBR25P15"
 D DIRCHK  ;check if namespaced routines remain
 D LINE("")
 S LBRSTART="Start Time: "_LBRSTART D LINE(LBRSTART)
 S LBREND=$$FMTE^XLFDT($$NOW^XLFDT,1)
 S LBREND="End Time:   "_LBREND D LINE(LBREND)
 D MAIL  ;send mail message
 K ^TMP($J,"LBRP15")
 Q
 ;
MSGTXT ;message into
 ;; The Library package is being retired and all data and data dictionary
 ;; will be removed from the system. This message shows a list of
 ;; files that were removed.
 ;;
 ;;QUIT
 Q
LINE(TEXT) ;add line to tmp global stored for mail message
 ;
 S LBRCNT=LBRCNT+1,^TMP($J,"LBRP15",LBRCNT)=TEXT
 Q
 ;
DIRCHK ;checks ^ROUTINE global for files beginning with LBR that were not removed
 ;
 N X,LBRFND,LBRSTR
 S LBRFND=1
 S X="LBQ~" F  S X=$O(^ROUTINE(X)) Q:(X="")!($E(X,1,3)'="LBR")  D
 .I X="LBR25P15" Q
 .I LBRFND D 
 ..D LINE("")
 ..S LBRSTR="The following routines beginning with LBR were found in the directory." D LINE(LBRSTR)
 ..S LBRSTR="They were not removed with patch LBR*2.5*15 installation. You will need to" D LINE(LBRSTR)
 ..S LBRSTR="review these routines and delete them if necessary." D LINE(LBRSTR)
 .D LINE(X) S LBRFND=0
 Q
 ;
MAIL ;send message
 ;
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Library Package Data & Data Dictionary Removal"
 S XMTEXT="^TMP($J,""LBRP15"","
 D ^XMD
 Q
