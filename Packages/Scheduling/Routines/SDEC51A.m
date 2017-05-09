SDEC51A ;ALB/SAT - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**658**;Aug 13, 1993;Build 23
 ;
 ;Reference is made to ICR's #4837 and #6185
 Q
 ;
FINDTXT(SDGMR,SDRPA,SDTXT) ;find text in word processing field
 ;INPUT:
 ; SDGMR - Pointer to REQUEST/CONSULTATION file
 ; SDRPA - Pointer to REQUEST PROCESSING ACTIVITY in REQUEST/CONSULTATION file
 ;RETURN:
 ; 1=Text Fount; 0=Not Found
 N SDI,SDJ,SDLINE,SDMSG,SDPREV,SDRET,SDTHIS,SDWP,X    ;alb/sat 651 add SDLINE
 S (SDTHIS,SDPREV)=""
 S SDRET=0
 S SDTXT=$G(SDTXT) S:SDTXT'="" SDTXT=$$UP^XLFSTR(SDTXT)  ;alb/sat 651
 K SDWP S X=$$GET1^DIQ(123.02,SDRPA_","_SDGMR_",",5,"","SDWP","SDMSG")   ;ICR 6185
 S SDI=0 F  S SDI=$O(SDWP(SDI)) Q:SDI=""  D  Q:SDRET=1
 .S SDTHIS=SDWP(SDI)
 .;alb/sat 651 begin modification
 .;I $$UP^XLFSTR(SDPREV_SDTHIS)[SDTXT S SDRET=1
 .S SDLINE=$$UP^XLFSTR(SDPREV_SDTHIS)
 .I SDTXT'="" S:SDLINE[SDTXT SDRET=1 Q
 .F SDJ=1:1 S SDTXT=$P($T(SDTXT+SDJ),";;",2) Q:SDTXT=""  D  Q:SDRET=1
 ..S:SDLINE[SDTXT SDRET=1
 .;alb/sat 651 end modification
 .S SDPREV=SDTHIS
 Q SDRET
 ;
 ;alb/sat 651
SDTXT  ;
 ;;CANCEL
 ;;NOSHOW
 ;;NO-SHOW
 ;;NO SHOW
 ;
 ;
PRIO(SDGMR) ;
 N CNT,F81,FED,PRIO,PRIO1,RET,SDED,SDI   ;alb/sat 658 added CNT, F81 and SDI
 ;alb/sat 658 start modification - if GMRC*3.0*81 has been installed/loaded at or before the file entry date/time, then always use the Earliest Date (Clinically Indicated Date)
 S F81=9999999
 S CNT=$$INSTALDT^XPDUTL("GMRC*3.0*81",.RET)
 I CNT>0 S F81=$O(RET(0))
 S SDED=$P($$GET1^DIQ(123,SDGMR_",",17,"I"),".",1)   ;earliest date  ;ICR 6185  ;alb/sat 658 moved this and next line up from under 'S PRIO=""'
 S FED=$P($$GET1^DIQ(123,SDGMR_",",.01,"I"),".",1)   ;file entry date  ;ICR 4837
 S PRIO=""
 I F81'>FED S PRIO=SDED G PRIOX
 ;alb/sat 658 end modification
 S PRIO1=$$GET1^DIQ(123,SDGMR_",",5)                 ;urgency text  ;ICR 4837
 I SDED="" S PRIO=PRIO1               ;2.6.17.2 - use URGENCY text if EARLIEST DATE is null
 I (PRIO=""),(FED="")!(SDED'=FED) S PRIO=SDED  ;2.6.17.1 - use EARLIEST DATE if not = FILE ENTRY DATE
 I (PRIO=""),((PRIO1["STAT")!(PRIO1["NEXT AVAILABLE")!(PRIO1["EMERGENCY")!(PRIO1["TODAY")) S PRIO=SDED  ;2.6.17.3
 S:PRIO="" PRIO=PRIO1  ;2.6.17.3
PRIOX Q PRIO   ;alb/sat 658 added PRIOX tag
 ;
SDCHED(DFN,SDACTDT,SDTSVC) ;look for appointment with stop code for REQUEST SERVICES
 ;INPUT:
 ; DFN     - patient ID pointer to PATIENT file
 ; SDACTDT - actual activity date in FM format
 ; SDTSVC  - request services ID pointer to REQUEST SERVICES file 123.5
 ;RETURN:
 ; 0 = no appointment found with matching stop code
 ; 1 = appointment found with matching stop code
 ;Q 1   ;do not check for match for now
 N SDCL,SDI,SDRET,SDSTP,SDSTPL
 S SDRET=0
 S SDTSVC=$G(SDTSVC)
 Q:SDTSVC="" 0
 S SDACTDT=$P($G(SDACTDT),".",1)
 I SDACTDT'?7N S SDACTDT=1410102   ;alb/sat 658 use valid FM range instead of 1000101
 S SDI=0 F  S SDI=$O(^GMR(123.5,SDTSVC,688,SDI)) Q:SDI'>0  D  Q:SDRET=1
 .S SDSTPL(+$P($G(^GMR(123.5,SDTSVC,688,SDI,0)),U,1))=""    ;ICR 4557
 S SDI=$$FMADD^XLFDT(SDACTDT,-2) F  S SDI=$O(^DPT(DFN,"S",SDI)) Q:SDI'>0  D
 .S SDCL=$$GET1^DIQ(2.98,SDI_","_DFN_",",.01,"I")
 .S SDSTP=$$GET1^DIQ(44,SDCL_",",8,"I")
 .I $$GET1^DIQ(2.98,SDI_","_DFN_",",15,"I")="",$D(SDSTPL(+SDSTP)) S SDRET=1   ;alb/sat 651
 Q SDRET
