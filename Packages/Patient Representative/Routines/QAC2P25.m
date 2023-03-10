QAC2P25 ;ADM/TXH - Patient Representative Package Decommission ;Aug 05, 2021@12:14
 ;;2.0;Patient Representative;**25**;Jul 25, 1995;Build 4
 ;
 ; The Patient Representative package is being retired. 
 ; This routine will remove the Patient Representative files and data.
 ;
 ; References to %ZTLOAD supported by ICR# 10063
 ; References to $$CREF^DILF supported by ICR# 2054
 ; References to $$ROOT^DILFD supported by ICR# 2055
 ; References to $$VFILE^DILFD supported by ICR# 2055
 ; References to EN^DIU2 supported by ICR# 10014
 ; References to $$FMTE^XLFDT supported by ICR #10103
 ; References to $$NOW^XLFDT supported by ICR #10103
 ; References to ^XMD supported by ICR # 10070
 ; References to BMES^XPDUTL supported by ICR# 10141
 ; References to MES^XPDUTL supported by ICR# 10141
 ;
 Q
 ;
TASK ;task the file deletion
 ;
 N ZTRTN,ZTDESC,ZTIO,ZTDTH
 D BMES^XPDUTL("* A background job will be tasked to delete all Patient ")
 D MES^XPDUTL("  Representative files and data.")
 D BMES^XPDUTL("* A Mailman message will be generated and sent to the ")
 D MES^XPDUTL("  installer when the job is completed.")
 D MES^XPDUTL(" ")
 S ZTRTN="BEGDEL^QAC2P25"
 S ZTDESC="Patient Representative Package File & Data Removal"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
BEGDEL ;background job entry point to remove all files and data
 ;
 N DIU,QACCNT,QACNODE,QACLOOP,QACTXT,QACFILE,QACFLG,QACSTART
 N QACEND,QACSTR
 S (QACCNT,QACFLG)=0,QACSTART=$$FMTE^XLFDT($$NOW^XLFDT,1)
 K ^TMP($J,"QACP25")
 ; build beginning of mail message
 F QACLOOP=1:1 S QACTXT=$P($T(MSGTXT+QACLOOP),";;",2) Q:QACTXT="QUIT"  D LINE(QACTXT)
 ; flags to delete data, subfile and templates
 S DIU(0)="DST"
 ; loop through known Patient Representative files 
 F QACFILE=745.1,745.2,745.3,745.4,745.5,745.55,745.6 D
 . ; set DIU=file root and QACNODE=closed file root
 . S DIU=$$ROOT^DILFD(QACFILE),QACNODE=$$CREF^DILF(DIU)
 . ; verify file exists
 . I '$$VFILE^DILFD(QACFILE) Q
 . ; delete file and data in DIU
 . D EN^DIU2
 . ; check if DD and data is removed
 . ; file successfully deleted
 . I '$D(@QACNODE),'$$VFILE^DILFD(QACFILE) D  Q
 . . S QACSTR=DIU_" successfully removed" D LINE(QACSTR) Q
 . ; fall through if file not deleted
 . S QACSTR=DIU_" was not successfully removed",QACFLG=1 D LINE(QACSTR)
 ;
 I QACFLG D
 . D LINE("")
 . S QACSTR="A file was not removed successfully. Please have your"
 . S QACSTR=QACSTR_" installer re-run the background job"
 . D LINE(QACSTR)
 . S QACSTR="by entering this command at the programmer's prompt"
 . D LINE(QACSTR)
 . S QACSTR="   D BEGDEL^QAC2P25"
 ;
 ; check if namespaced routines remain 
 D DIRCHK
 D LINE("")
 S QACSTART="Start Time: "_QACSTART D LINE(QACSTART)
 S QACEND=$$FMTE^XLFDT($$NOW^XLFDT,1)
 S QACEND="End Time:   "_QACEND D LINE(QACEND)
 ; send mail message
 D MAIL
 K ^TMP($J,"QACP25")
 Q
 ;
MSGTXT ;message into
 ;; The Patient Representative package is being retired and all data 
 ;; and data dictionary entries will be removed from the system. 
 ;; This message shows a list of files that were removed.
 ;;
 ;;QUIT
 Q
 ;
LINE(TEXT) ;add line to tmp global stored for mail message
 ;
 S QACCNT=QACCNT+1,^TMP($J,"QACP25",QACCNT)=TEXT
 Q
 ;
DIRCHK ;checks ^ROUTINE global for files beginning with QAC that 
 ; were not removed
 ;
 N X,QACFND,QACSTR
 S QACFND=1
 S X="QAB~" F  S X=$O(^ROUTINE(X)) Q:(X="")!($E(X,1,3)'="QAC")  D
 . I X="QAC2P25" Q
 . I QACFND D  ;only print header message once
 . . D LINE("")
 . . S QACSTR="The following routines beginning with QAC were found "
 . . S QACSTR=QACSTR_"in the directory."
 . . D LINE(QACSTR)
 . . S QACSTR="They were not removed with patch QAC*2.0*25 installation. "
 . . S QACSTR=QACSTR_"You will need to"
 . . D LINE(QACSTR)
 . . S QACSTR="review these routines and delete them if necessary."
 . . D LINE(QACSTR)
 . D LINE(X) S QACFND=0 ;turn off header message print
 Q
 ;
MAIL ;send message
 ;
 N XMDUZ,XMY,XMTEXT,XMSUB,DIFROM
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Patient Representative Package Data & Data Dictionary Removal"
 S XMTEXT="^TMP($J,""QACP25"","
 D ^XMD
 Q
