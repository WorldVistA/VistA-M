TIUEC112 ; SLC/AJB Environment Check for TIU*1*112;07/31/2003 11:30
 ;;1.0;Text Integration Utilities;**112**;Jun 20, 1997
ECHK ;
 N TMP
 D
 .N DC,LINE S LINE=0
 .F  S LINE=LINE+1,DC=$P($T(TITLES+LINE),";;",2) Q:DC="EOM"  D
 ..N DIC,X,Y
 ..S DIC="8925.1",DIC(0)="X"
 ..S X=DC
 ..D ^DIC
 ..I +Y>0,$P(^TIU(8925.1,+Y,0),U,13)'=1 S TMP(LINE)=$$GET1^DIQ(8925.1,+Y,.01)_" ("_$$GET1^DIQ(8925.1,+Y,.04)_") is not a NATIONAL STANDARD entry."
 I $D(TMP) D
 .D MES^XPDUTL("The following entries in the TIU DOCUMENT DEFINITION FILE conflict with")
 .D MES^XPDUTL("the DOCUMENT CLASSES and TITLES needed for this installation."),MES^XPDUTL(" ")
 .S TMP="" F  S TMP=$O(TMP(TMP)) Q:TMP=""  D MES^XPDUTL(TMP(TMP))
 I  D BMES^XPDUTL("Please rename the entries before restarting the installation of this patch.") S XPDABORT=2 Q
 D BMES^XPDUTL("The environment check has completed successfully.")
 Q
TITLES ;
 ;;SURGICAL REPORTS
 ;;OPERATION REPORTS
 ;;OPERATION REPORT
 ;;NURSE INTRAOPERATIVE REPORTS
 ;;NURSE INTRAOPERATIVE REPORT
 ;;ANESTHESIA REPORTS
 ;;ANESTHESIA REPORT
 ;;PROCEDURE REPORT (NON-O.R.)
 ;;PROCEDURE REPORT
 ;;EOM
 Q
