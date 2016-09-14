SDECRT2 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
CRSET(CLN,DATE,DFN,ORDER,SDSTART,SDSTOP) ;EP; process single chart request
 ; called by CRLOOP and by chart request software
 NEW HRCN,TERM,BSDMODE
 ;
 S HRCN=$$HRCN^SDECF2(DFN,+$$FAC^SDECU(CLN))  ;chart #
 S TERM=$$HRCNT^SDECF2(HRCN)                 ;terminal digit format
 I $$GET1^DIQ(9009020.2,+$$DIVC^SDECU(CLN),.18)="NO" D
 . S TERM=$$HRCND^SDECF2(HRCN)               ;use chart # per site param
 ;
 ;set chart request as first item for day-makes extra forms print
 ;too hard to find first cr for patient for day AND hopefully
 ;chart request not being made if patient already has appt
 ;
 S BSDMODE="CR"
 ;
 I ORDER="" D  Q  ;make sure all cr for date are printed
 . I $D(^TMP("SDRS",$J,$$GET1^DIQ(2,DFN,.01)," "_TERM,DFN,DATE)) D
 .. NEW I F I=.01:.01:.99 Q:'$D(^TMP("SDRS",$J,$$GET1^DIQ(2,DFN,.01)," "_TERM,DFN,(DATE+I)))
 .. D NMO^SDECRT0(DFN,(DATE_I),CLN,TERM,"",1)
 . E  D NMO^SDECRT0(DFN,DATE,CLN,TERM,"",1)
 ;
 I ORDER=1,SDSTART]"",SDSTART]$E(TERM,1,2) Q   ;before beginning
 I ORDER=1,SDSTOP]"",$E(TERM,1,2)]SDSTOP Q     ;after end
 I ORDER=4,SDSTART]"",SDSTART]$$GET1^DIQ(2,DFN,.01) Q   ;before beginning   ;IHS/ITSC/LJF 10/25/2004 PATCH 1003
 I ORDER=4,SDSTOP]"",$$GET1^DIQ(2,DFN,.01)]SDSTOP Q     ;after end of range ;IHS/ITSC/LJF 10/25/2004 PATCH 1003
 ;
 I ORDER=1 D TDO^SDECRT0(DFN,DATE,CLN,TERM,"",1) Q
 I ORDER=2 D CLO^SDECRT0(DFN,DATE,CLN,TERM,"",1) Q
 I ORDER=3 D PCO^SDECRT0(DFN,DATE,CLN,TERM,"",1) Q
 D NMO^SDECRT0(DFN,DATE,CLN,TERM,"",1) Q
 Q
