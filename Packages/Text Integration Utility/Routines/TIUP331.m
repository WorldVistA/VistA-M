TIUP331 ;SPFO/AJB - iMedConsent Web ;May 01, 2020@10:06:37
 ;;1.0;TEXT INTEGRATION UTILITIES;**331**;Jun 20, 1997;Build 6
 ;
 ; $$FIND1^DIC     ICR#2051          UPDATE^DIE     ICR#2053
 ; $$PATCH^XPDUTL  ICR#10141         MES^XPDUTL     ICR#10141
 Q
POST ;
 N CL,DC,DOC,INSTERR,SCR,TIUFPRIV S TIUFPRIV=1
 ; find progress notes class
 S SCR="I $P(^(0),U,4)=""CL""" ; screen for the class
 S CL=$$LU(8925.1,"PROGRESS NOTES","X",SCR) I '+CL D  Q
 . D MES^XPDUTL(""),MES^XPDUTL("Installation Error:  PROGRESS NOTES Class not found")
 ; check document class, install if needed
 S SCR="I $P(^(0),U,4)=""DC""" ; screen for the document class
 S DC=$$LU(8925.1,"IMEDCONSENT WEB","X",SCR) I +DC D MES^XPDUTL("iMedConsent Web Document Class found.")
 I '+DC S DC=$$CRDD^TIUCRDD("IMEDCONSENT WEB","DC",11,CL) I +DC D MES^XPDUTL("Installation of Document Class IMEDCONSENT WEB complete.")
 I '+DC D  Q  ; failed to create document class
 . D MES^XPDUTL($P(DC,U,2))
 ; install document titles
 N DATA,I F I=1:1 S DATA=$P($T(TITLES+I),";;",2) Q:DATA=""  D
 . N EST,LT ; enterprise standard title, local title
 . S SCR="I $P(^(0),U,4)=""DOC""" ; screen for the document title
 . ; check if title already installed
 . S LT=$$LU(8925.1,$P(DATA,U),"X",SCR) I +LT D MES^XPDUTL("Local title "_$P(DATA,U)_" already installed.") Q
 . ; get enterprise standard title
 . S EST=$$LU(8926.1,$P(DATA,U,2),"X")
 . I '+EST D  S EST=""
 . . D MES^XPDUTL("Installation Warning:  Enterprise Standard Title ["_$P(DATA,U,2)_"] not found.")
 . ; install local title
 . S LT=$$CRDD^TIUCRDD($P(DATA,U),"DOC",11,DC,EST) I '+LT D  Q
 . . D MES^XPDUTL($P(LT,U,2))
 . D MES^XPDUTL("Installation of local title "_$P(DATA,U)_" complete.")
 Q
LU(FILE,NAME,FLAGS,SCREEN,INDEXES) ;
 Q $$FIND1^DIC(FILE,"",$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN),"ERR")
TITLES ;
 ;;ADMINISTRATIVE IMED^ADMINISTRATIVE NOTE
 ;;CONSENT CLINICAL IMED^CONSENT
 ;;CONSENT CLINICAL SCANNED^CONSENT
 ;;CONSENT-RELEASE OF INFORMATION^ADMINISTRATIVE NOTE
 ;;CONSENT-RESEARCH IMED^RESEARCH CONSENT
 ;;CONSENT-TRANSFER IMED^ADMINISTRATIVE NOTE
 ;;DIAGRAMS AND PICTURES IMED^DIAGRAM
 ;;DISCHARGE INSTRUCTIONS IMED^EDUCATION NOTE
 ;;FDA REMS FORM IMED^RISK ASSESSMENT SCREENING PROGRESS NOTE
 ;;LEAVING AGAINST MEDICAL ADVICE IMED^AMA NOTE
 ;;PATIENT AGREEMENT IMED^AGREEMENT
 ;;PATIENT EDUCATION IMED^EDUCATION NOTE
 ;;PATIENT INSTRUCTIONS IMED^EDUCATION NOTE
 ;;PATIENT SCREENING IMED^RISK ASSESSMENT SCREENING NOTE
 ;;
