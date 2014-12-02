FBCSV1 ;WOIFO/SS - UTILITIES FOR CODE SET VERSIONING ;4/7/2003
 ;;3.5;FEE BASIS;**55,77,94,139**;JAN 30, 1995;Build 127
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; References to API $$ICDOP^ICDEX supported by ICR 5747
 ; References to API $$ICDDX^ICDEX supported by ICR 5747
 ;
 ;wrapper for DRG^ICDGTDRG
 ;to use instead of direct read of ^ICD(
 ;FBIEN - ien of #80.2
 ;FBDATE - date of service (optional)
 ;returns (#.01) NAME of #80.2 or "" if invalid/error
ICD(FBIEN,FBDATE) ;
 N FBRET
 S FBRET=$$DRG^ICDGTDRG($G(FBIEN),$S(+$G(FBDATE)=0:"",1:FBDATE))
 Q:+FBRET<0 ""
 Q $P(FBRET,"^",1)
 ;
 ;wrapper for ICDOP^ICDCODE
 ;to use instead of direct read of ^ICD0(
 ;FBIEN - ien of #80.1
 ;FBDATE - date of service (optional)
 ;returns (#.01) NAME of #80.1 or "" if invalid/error
ICD0(FBIEN,FBDATE) ;
 N FBRET
 ;JAS - 4/2/13 - Patch 139 (ICD-10 Project) Modified next line.
 S FBRET=$$ICDOP^ICDEX($G(FBIEN),$S(+$G(FBDATE)=0:"",1:FBDATE),"","I")
 Q:+FBRET<0 ""
 Q $P(FBRET,"^",2)
 ;
 ;wrapper for ICDDX^ICDCODE
 ;to use instead of direct read of ^ICD9(
 ;FBIEN - ien of #80
 ;FBDATE - date of service (optional)
 ;returns (#.01) NAME of #80 or "" if invalid/error
ICD9(FBIEN,FBDATE) ;
 N FBRET
 ; DEM;139 ICD-10 Project - Replaced call to $$ICDDX^ICDCODE with
 ;                          call to $$ICDDX^ICDEX.  
 S FBRET=$$ICDDX^ICDEX($G(FBIEN),$S(+$G(FBDATE)=0:"",1:FBDATE),"","I")
 Q:+FBRET<0 ""
 Q $P(FBRET,"^",2)
 ;
 ;wrapper for ICDDX^ICDCODE with piece #
 ;to use instead of direct read of ^ICD9(
 ;FBIEN - ien of #80
 ;FBPC - piece #
 ;FBDATE (optional) - date of service
 ;returns piece # FBPC of #80 or "" if invalid/error
ICD9P(FBIEN,FBPC,FBDATE) ; Will need to check calls to this tag for FBPC value as it may need to change - DRP 12/22/2011
 N FBRET
 ;JAS - 4/2/13 - Patch 139 (ICD-10 Project) Modified next line.
 S FBRET=$$ICDDX^ICDEX($G(FBIEN),$S(+$G(FBDATE)=0:"",1:FBDATE),"","I")
 Q:+FBRET<0 ""
 Q $P(FBRET,"^",FBPC+1)
 ;
 ;extended wrapper for ICDDX^ICDCODE
 ;to use instead of direct read of ^ICD9(
 ;FBIEN - ien of #80
 ;FBPC - piece #
 ;FBEXTR - $E parameter
 ;FBDATE (optional) - date of service
 ;returns piece #FBPC and (#.01) NAME of #80 and or "" if invalid/error
ICD9EX(FBIEN,FBPC,FBEXTR,FBDATE) ; Will need to check calls to this tag for FBPC value as it may need to change - DRP 12/22/2011
 N FBRET
 ;JAS - 4/2/13 - Patch 139 (ICD-10 Project) Modified next line.
 S FBRET=$$ICDDX^ICDEX($G(FBIEN),$S(+$G(FBDATE)=0:"",1:FBDATE),"","I")
 Q:+FBRET<0 ""
 Q $E($P(FBRET,"^",FBPC+1),1,FBEXTR)_" ("_$P(FBRET,"^",2)_")"
 ;
 ;get FROM date from INVOICE file
FRDTINV(FBDA) ;
 N FBRETDT
 S FBRETDT=$P($$B9DISCHG^FBAAV5(FBDA),"^",1) ; Discharge Date
 I FBRETDT="" S FBRETDT=$P($G(^FBAAI(FBDA,0)),"^",7) ; Treatment To DT
 I FBRETDT="" S FBRETDT=$P($G(^FBAAI(FBDA,0)),"^",6) ; Treatment Fr DT
 Q FBRETDT
 ;
 ;FB*3.5*139-ICD10 REMEDIATION-jlg- obtain FROM date from Unclaimed funds file (162.7)
FRDTUC(FBDA) ;
 N FBRETDT
 S FBRETDT=$P($G(^FB583(FBDA,0)),"^",6) ; Treatment To DT/Discharge Date
 S:FBRETDT="" FBRETDT=$P($G(^FB583(FBDA,0)),"^",5) ; Treatment Fr DT
 Q FBRETDT
 ;
 ;if FBCODE="" returns FBNUM spaces
 ;otherwise returns FBCODE
SPACES(FBCODE,FBNUM) ;
 I $L(FBCODE)=0 S $P(FBCODE," ",FBNUM)=" "
 Q FBCODE
 ;
 ;EVALUATE (sometimes can be used instead of "$S")
 ;if FBCODE="" returns FBRETV
 ;otherwise returns FBCODE
EV(FBCODE,FBRETV) ;
 Q:$L(FBCODE)=0 FBRETV
 Q FBCODE
 ;
 ;converts a date to fileman format
DT2FMDT(FBDAT) ;
 N X,Y
 S X=$$TRIM^XLFSTR(FBDAT)
 D ^%DT
 Q +Y
 ;
 ;wrapper for ICDDX^ICDCODE
 ;to use in prompts (and input templates)of file #162.5 to screen out 
 ;  inactive/invalid codes
 ;FBICD9 - ien of #80
 ;FBINV - ien of the current #162.5 record
 ;FBDATE - (optional) date of service
 ;returns 0 if code is active, otherwise - nonzero value
INPICD9(FBICD9,FBINV,FBDATE) ;
 N FBRET
 ; FB*3.5*139 Restored original line of code that was incorrectly modified in FB*3.5*94
 I '$G(FBDATE) S FBDATE=$$FRDTINV(+$G(FBINV))
 ;JAS - 4/2/13 - Patch 139 (ICD-10 Project) Modified next line.
 S FBRET=$$ICDDX^ICDEX($G(FBICD9),$S(+$G(FBDATE)=0:"",1:FBDATE),"","I")
 I +FBRET<0 W " Invalid Code " Q 2
 I $P(FBRET,"^",10)=0 W !," Code is inactive" W:$G(FBDATE)>0 " on "_$$FMTE^XLFDT(FBDATE) Q 1
 Q 0
 ;
 ;wrapper for ICDOP^ICDCODE
 ;checks if code is active on the date of service and
 ;if active returns CODE NUMBER
 ;is inactive returns "" and prints message "ICD O/P Code inactive ..."
 ;is invalid/local returns "" and prints message "Invalid ICD O/P Code"
CHKICD0(FBIEN,FBDATE) ;
 N FBRET
 ;JAS - 4/2/13 - Patch 139 (ICD-10 Project) Modified next line.
 S FBRET=$$ICDOP^ICDEX($G(FBIEN),$S(+$G(FBDATE)=0:"",1:FBDATE),"","I")
 I +FBRET<0 W " Invalid ICD O/P Code " Q ""
 I $P(FBRET,"^",10)=0 D  Q ""
 . W !," ICD O/P Code "_$P(FBRET,"^",2)_" inactive"
 . W:$G(FBDATE) " on date of service (",$$FMTE^XLFDT(FBDATE),")"
 Q $P(FBRET,"^",2)
 ;
 ;wrapper for ICDOP^ICDCODE
 ;to use in prompts (and input templates)of file #162.5 to screen out 
 ;  inactive/invalid codes
 ;FBICD0 - ien of #80.1
 ;FBINV - ien of the current #162.5 record
 ;FBDATE - (optional) date of service
 ;returns 0 if code is active, otherwise - nonzero value
INPICD0(FBICD0,FBINV,FBDATE) ;
 N FBRET
 ; FB*3.5*139 Restored original line of code that was incorrectly modified in FB*3.5*94
 I '$G(FBDATE) S FBDATE=$$FRDTINV(+$G(FBINV))
 ;JAS - 4/2/13 - Patch 139 (ICD-10 Project) Modified next line.
 S FBRET=$$ICDOP^ICDEX($G(FBICD0),$S(+$G(FBDATE)=0:"",1:FBDATE),"","I")
 I +FBRET<0 W " Invalid Code " Q 2
 I $P(FBRET,"^",10)=0 W !," Code is inactive" W:$G(FBDATE)>0 " on "_$$FMTE^XLFDT(FBDATE) Q 1
 Q 0
 ;
 ;wrapper for DRG^ICDGTDRG
 ;to use in prompts (and input templates)of file #162.5 to screen out 
 ;  inactive/invalid codes
 ;FBICD - ien of #80.2
 ;FBINV - ien of the current #162.5 record
 ;FBDATE - (optional) date of service
 ;returns 0 if code is active, otherwise - nonzero value
INPICD(FBICD,FBINV,FBDATE) ;
 N FBRET
 ; FB*3.5*139 Restored original line of code that was incorrectly modified in FB*3.5*94
 I '$G(FBDATE) S FBDATE=$$FRDTINV(+$G(FBINV))
 S FBRET=$$DRG^ICDGTDRG($G(FBICD),$S(+$G(FBDATE)=0:"",1:FBDATE))
 I +FBRET<0 W " Invalid Code " Q 2
 I $P(FBRET,"^",14)=0 W !," Code is inactive" W:$G(FBDATE)>0 " on "_$$FMTE^XLFDT(FBDATE) Q 1
 Q 0
 ;
 ;wrapper for ICDDX^ICDCODE
 ;checks if code is inactive on the date of service and 
 ;if active returns CODE NUMBER
 ;is inactive returns "" and prints message "ICD Dx Code inactive ..."
 ;is invalid/local returns "" and prints message "Invalid ICD Dx Code"
CHKICD9(FBIEN,FBDATE) ;
 N FBRET
 ;JAS - 4/2/13 - Patch 139 (ICD-10 Project) Modified next line.
 S FBRET=$$ICDDX^ICDEX($G(FBIEN),$S(+$G(FBDATE)=0:"",1:FBDATE),"","I")
 I +FBRET<0 W " Invalid ICD Dx Code " Q ""
 I $P(FBRET,"^",10)=0 D  Q ""
 . W !," ICD Dx Code "_$P(FBRET,"^",2)_" inactive"
 . W:$G(FBDATE) " on date of service (",$$FMTE^XLFDT(FBDATE),")"
 ;JAS - 7/18/14 - Patch 139 (ICD-10 Project) Added next section for Pending ICD-10 codes.
 I $P(FBRET,"^",10)=1,$P(FBRET,"^",17)>FBDATE D  Q ""
 . W !," ICD Dx Code "_$P(FBRET,"^",2)_" invalid"
 . W:$G(FBDATE) " on date of service (",$$FMTE^XLFDT(FBDATE),")"
 Q $P(FBRET,"^",2)
 ;
 ;
 ;convert date as a string like "MMDDYYYY" into FM date like "YYYMMDD"
STR2FBDT(FBDTSTR) ;
 N X,Y S X=FBDTSTR D ^%DT
 Q:Y=-1 ""
 Q Y\1
 ;
IMPDATE(CSYS) ; Return the implementation date for a coding system
 Q $$IMPDATE^LEXU($G(CSYS))
 ;
 ;FBCSV1
