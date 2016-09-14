SDECRT ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
WISD(DFN,SDATE,BSDMODE,BSDDEV,BSDNHS) ;PEP; print routing slip for walkin/same day appt
 ; Check for DFN if user enters by Clinic, but does not select a Pt
 N DIR,DIV,ORDER,%ZIS
 N SDREP,SDSTART,SDX,Y
 I +$G(DFN)=0 Q
 ;
 N %DIS,DGPGM,VAR,VAR1,DEV,POP
 S SDX="ALL",ORDER="",SDREP=0,SDSTART="",DIV=$$DIV^SDECU
 ;
 S VAR="DIV^ORDER^SDX^SDATE^DFN^SDREP^SDSTART^BSDMODE^BSDNHS"
 S VAR1="DIV;ORDER;SDX;SDATE;DFN;SDREP;SDSTART;BSDMODE;BSDNHS"
 ;
 S DGPGM="SINGLE^SDECROUT"
 I $G(BSDDEV)]"" D ZIS^SDECF("F","SINGLE^BSDROUT","ROUTING SLIP",VAR1,BSDDEV) Q
 S DEV=$S(BSDMODE="CR":".05",1:".11")   ;default printer fields
 S BDGDEV=$$GET1^DIQ(9009020.2,$$DIV^SDECU,DEV)
 I BDGDEV="" K BDGDEV Q
 S %ZIS("A")="FILE ROOM PRINTER: " D ZIS^DGUTQ I POP D END^SDROUT1 Q
 D SINGLE
 Q
 ;
SINGLE ;EP; queued entry point for single routing slips
 ; called by WISD subroutine
 U IO K ^TMP("SDRS",$J)
 NEW BSDT,CLN,IEN,BSDMOD2
 ;
 ; find all appts for patient
 I BSDMODE="CR" S BSDMOD2="CR",BSDMODE=""
 S BSDT=SDATE\1
 F  S BSDT=$O(^DPT(DFN,"S",BSDT)) Q:'BSDT  Q:(BSDT\1>SDATE)  D
 . S CLN=+$G(^DPT(DFN,"S",BSDT,0)) Q:'CLN   ;clinic ien
 . S IEN=0 F  S IEN=$O(^SC(CLN,"S",BSDT,1,IEN)) Q:'IEN  Q:$P($G(^SC(CLN,"S",BSDT,1,IEN,0)),U)=DFN
 . Q:'IEN                                   ;appt ien in ^sc
 . D FIND^SDECRT0(CLN,BSDT,IEN,ORDER,BSDMODE,SDX,SDSTART,"",SDREP,SDATE)
 I $D(BSDMOD2) S BSDMODE=BSDMOD2
 ;
 ; if no future appts, set something so RS will print
 I '$D(^TMP("SDRS",$J)) S ^TMP("SDRS",$J,$$GET1^DIQ(2,DFN,.01),$$TERM(DFN),DFN)=""
 ;
 D PRINT^SDECRT1(ORDER,SDATE,SDX,SDSTART,"",SDREP)
 Q
 ;
TERM(PAT) ; returns chart # in terminal digit format
 NEW N,T
 S N=$$HRCN^SDECF2(PAT,$G(DUZ(2)))         ;chart #
 S T=$$HRCNT^SDECF2(N)                     ;terminal digit format
 I $$GET1^DIQ(9009020.2,+$$DIV^SDECU,.18)="NO" D
 . S T=$$HRCND^SDECF2(N)                   ;use chart # per site param
 Q T
