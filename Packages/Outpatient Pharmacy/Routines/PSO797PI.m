PSO797PI ;BIRM/KML - PSO*7*797 Post-install routine ;07/17/2025
 ;;7.0;OUTPATIENT PHARMACY;**797**;DEC 1997;Build 7
 ;
 ; No entry from top
 Q 
 ;
EN ; MAIN ENTRY POINT
 K ^TMP("PSO797PI",$J)
 N LINENUM,ERROR,ROUTINES
 S ERROR=0
 S LINENUM=0
 D UPD5IS03
 D MAIL("PSO*7*797 Installation is completed.")
 Q
 ;
UPD5IS03 ; Update IS03 description in ASAP 5.0 and 5.0Z
 ;
 N VER
 F VER="5.0","5.0Z" D
 . N VERIEN,ELIEN,SEGIEN,ASAPIENS,IS03,ISLINE,ISTEXT
 . S VERIEN=$$FIND1^DIC(58.4001,",1,","O",VER)
 . Q:'(VERIEN>0)
 . S ASAPIENS=","_VERIEN_",1,"
 . S SEGIEN=$$FIND1^DIC(58.40011,ASAPIENS,"O","IS")
 . Q:'SEGIEN
 . S ASAPIENS=","_SEGIEN_","_VERIEN_",1,"
 . S ELIEN=$$FIND1^DIC(58.400111,ASAPIENS,"O","IS03")
 . Q:'ELIEN
 . D FILEDESC(ELIEN,SEGIEN,VERIEN)
 Q
 ;
FILEDESC(ELIEN,SEGIEN,VERIEN) ; Update the DESCRIPTION field (#.07) of SPMP ASAP RECORD DEFINITION file (#58.4)
 ;
 N IS03DESC,ASAPIENS,IS03ERR
 Q:'ELIEN!'SEGIEN!'VERIEN
 ;
 S ASAPIENS=ELIEN_","_SEGIEN_","_VERIEN_",1,"
 S IS03=$$GET1^DIQ(58.400111,ASAPIENS,.07,"","IS03")
 Q:$G(IS03(1))'["Freetext message. Use of this field is defined by the PDMP."
 ;
 S IS03DESC(1)="Freetext message. Use of this field is defined by the PDMP. PDMPs may"
 S IS03DESC(2)="designate this field to hold the submission period date range of the file"
 S IS03DESC(3)="transmitted. When used to indicate the date range, it must be the first"
 S IS03DESC(4)="data text in the field and must be inserted using the following layout"
 S IS03DESC(5)="(where ""#"" and ""-"" are those literal characters):"
 S IS03DESC(6)="#CCYYMMDD#-#CCYYMMDD#"
 S IS03DESC(7)="For example, a pharmacy may be submitting records for the reporting period"
 S IS03DESC(8)="of February 5, 2023 through February 11, 2023 but only filled reportable"
 S IS03DESC(9)="prescriptions on February 5 and February 7. The full submission period"
 S IS03DESC(10)="date range would be reported in IS03 as #20230205#-#20230211# "
 S IS03DESC(11)="It is up to the PDMP to further define how to enter the submission date"
 S IS03DESC(12)="range for exceptional cases, such as for late submission records."
 S IS03DESC(13)="Note: IS03 can also be used to show the date range for Zero"
 S IS03DESC(14)="Reports."
 ;
 ; File description text
 D WP^DIE(58.400111,ASAPIENS,.07,,"IS03DESC","IS03ERR")
 I $G(IS03ERR("DIERR")) D  Q
 . D REPORT("Error encountered during update of IS03 in ASAP "_VER_".","COMPLETE",.LINENUM)
 . D REPORT("Error Code: "_$G(IS03ERR("DIERR",1)),"COMPLETE",.LINENUM)
 . D REPORT($G(IS03ERR("DIERR",1,"TEXT",1)),"COMPLETE",.LINENUM)
 . D REPORT("*","ERROR",.LINENUM)
 D REPORT("The IS03 Description in ASAP "_VER_" has been updated successfully.","COMPLETE",.LINENUM)
 Q
 ;
MAIL(XMSUB) ;Send mail message
 N X,XMTEXT,XMY,XMDUZ,XMMG,XMSTRIP,XMROU,XMYBLOB,XMZ,XMDUN
 S XMDUZ="PSO*7*797 Install"
 S XMTEXT="^TMP(""PSO797PI"",$J,"
 S XMY("G.PSO SPMP NOTIFICATIONS")=""
 S XMY(DUZ)=""
 N DIFROM D ^XMD
 Q
 ;
REPORT(TEXT,ACTION,LINE) ; Report progress/issues
 ; Input
 ;   TEXT - text to report to end-user
 ;   ACTION - what was being processed
 ;   LINE - line number for the mail message passed in by reference
 D:ACTION="ERROR" 2
 D:ACTION="COMPLETE" 1
 Q
1 D BMES^XPDUTL("     "_TEXT)
 S LINE=LINE+1
 S ^TMP("PSO797PI",$J,LINE)="     "_TEXT
 S LINE=LINE+1
 S ^TMP("PSO797PI",$J,LINE)=""
 Q
 ;
2 D BMES^XPDUTL("     "_TEXT_" Please contact product support.")
 S LINE=LINE+1
 S ^TMP("PSO797PI",$J,LINE)="  Please log a SNOW Ticket and refer to this message."
 S LINE=LINE+1
 S ^TMP("PSO797PI",$J,LINE)=""
 Q
