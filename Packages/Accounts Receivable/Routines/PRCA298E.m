PRCA298E ; ALB/hrubovcak - ePayments Lockbox environment check ;Sep 29, 2014@17:10:44
 ;;4.5;Accounts Receivable;**298**;Jan 21, 2014;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; prerequisite patch check for PRCA*4.5*298
 ;
 D MES^XPDUTL("Checking for prerequisite patches "_$$FMTE^XLFDT($$NOW^XLFDT))
 N PRLN,PRMISS,PRPTCH,X,Y
 ; PRLN - counter
 ; PRMISS - missing patches
 ; PRPTCH - patch name
 ;
 F PRLN=1:1 S X=$P($T(PTCHLST+PRLN),";;",2) Q:X=""  D
 .S PRPTCH=X,Y=$$PATCH^XPDUTL(PRPTCH)
 .D MES^XPDUTL(PRPTCH_" "_$S(Y:"",1:"NOT")_" installed") Q:Y
 .S PRMISS(PRPTCH)=""
 ;
 ; exit if nothing missing
 I '$D(PRMISS) D MES^XPDUTL("All prerequisite patches found.") Q
 ;
 S XPDQUIT=1  ; flag to stop installation
 ;
 D MES^XPDUTL("The following must be installed before PRCA*4.5*298:")
 S X="" F  S X=$O(PRMISS(X)) Q:X=""  D MES^XPDUTL(X)
 D MES^XPDUTL(" "),MES^XPDUTL("Install aborted "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 Q
 ;
PTCHLST ; required patch list
 ;;BPS*1.0*11
 ;;IB*2.0*451
 ;;IB*2.0*452
 ;;IB*2.0*488
 ;;PRCA*4.5*208
 ;;PRCA*4.5*220
 ;;PRCA*4.5*222
 ;;PRCA*4.5*241
 ;;PRCA*4.5*249
 ;;PRCA*4.5*253
 ;;PRCA*4.5*261
 ;;PRCA*4.5*262
 ;;PRCA*4.5*269
 ;;PRCA*4.5*271
 ;;PRCA*4.5*276
 ;;PRCA*4.5*283
 ;;PRCA*4.5*284
 ;;PRCA*4.5*293
 ;;PRCA*4.5*296
 ;
