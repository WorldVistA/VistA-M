DGMTHL1 ;ALB/CJM/TDM - Hardship Determinations - Build List Area;13 JUN 1997 08:00 am ; 8/29/02 4:50pm
 ;;5.3;Registration;**182,456,536**;08/13/93;Build 3
 ;
EN(DGARY,HARDSHIP,DGCNT) ;Entry point to build list area
 ; Input;
 ;   DGARY    Global array subscript
 ;   HARDSHIP - hardship array (pass by reference)
 ; Output -- DGCNT    Number of lines in the list
 ;
 N DGLINE
 S DGLINE=1,DGCNT=0
 D SET(DGARY,.HARDSHIP,.DGLINE,.DGCNT)
 Q
 ;
SET(DGARY,HARDSHIP,DGLINE,DGCNT) ;
 ;Description: Writes hardship
 ; Input  -- DGARY    Global array subscript
 ;           HARDSHIP    Hardship array
 ;           DGLINE   Line number
 ; Output -- DGCNT    Number of lines in the list
 N DGSTART,LINE
 ;
 S DGSTART=DGLINE ; starting line number
 D SET^DGENL1(DGARY,DGLINE,"Hardship",21,IORVON,IORVOFF,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Current Means Test Status:   ",31)_$$EXT^DGMTH("CURRENT STATUS",HARDSHIP("CURRENT STATUS")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Income Year:   ",31)_$S(HARDSHIP("YEAR"):$$EXT^DGMTH("YEAR",HARDSHIP("YEAR")),1:""),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Means Test Date:   ",31)_$$EXT^DGMTH("TEST DATE",HARDSHIP("TEST DATE")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 I (HARDSHIP("AGREE")'="") D SET^DGENL1(DGARY,DGLINE,$J("Agreed To Pay Deductible:   ",31)_$$EXT^DGMTH("AGREE",HARDSHIP("AGREE")),1,,,,,,.DGCNT) S DGLINE=DGLINE+1
 ;
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Hardship?:   ",31)_$$EXT^DGMTH("HARDSHIP?",HARDSHIP("HARDSHIP?")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Hardship Effective Date:   ",31)_$$EXT^DGMTH("EFFECTIVE",HARDSHIP("EFFECTIVE")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Review Date:   ",31)_$$EXT^DGMTH("REVIEW",HARDSHIP("REVIEW")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Site Granting Hardship:   ",31)_$$EXT^DGMTH("SITE",HARDSHIP("SITE")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Approved By:   ",31)_$$EXT^DGMTH("BY",HARDSHIP("BY")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Hardship Reason:   ",31)_$$EXT^DGMTH("REASON",HARDSHIP("REASON")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+2
 ;
 D SET^DGENL1(DGARY,DGLINE,$J("Date Category Last Changed:   ",31)_$$EXT^DGMTH("DT/TM CTGRY CHNGD",HARDSHIP("DT/TM CTGRY CHNGD")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Category Last Changed By:   ",31)_$$EXT^DGMTH("CTGRY CHNGD BY",HARDSHIP("CTGRY CHNGD BY")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 I $D(^DGMT(408.31,HARDSHIP("MTIEN"),"C")) D
 .N LINE
 .D SET^DGENL1(DGARY,DGLINE,"COMMENTS:",1,$G(IOINHI),$G(IOINORM),,,,.DGCNT)
 .S DGLINE=DGLINE+1
 .S LINE=0
 .F  S LINE=$O(^DGMT(408.31,HARDSHIP("MTIEN"),"C",LINE)) Q:'LINE  D
 ..D SET^DGENL1(DGARY,DGLINE,$G(^DGMT(408.31,HARDSHIP("MTIEN"),"C",LINE,0)),1,,,,,,.DGCNT)
 ..S DGLINE=DGLINE+1
 Q
 ;
CHKADD(HARDSHIP) ;
 ;Determines whether granting a hardship is appropriate
 ;Input:
 ;  HARDSHIP - hardship array (pass by reference)
 ;Output:
 ;  Function Value - 1 if the hardship can be granted, 0 otherwise   
 ;
 N CODE
 S CODE=""
 S CODE=$$GETCODE^DGMTH(HARDSHIP("CURRENT STATUS"))
 I CODE'="C",CODE'="P",CODE'="G" Q 0
 Q 1
 ;
ADD(HARDSHIP) ;
 ;Add hardship protocol.
 ;
 ;Input:
 ;  HARDSHIP - hardship array, pass by reference
 ;Output:
 ;  HARDSHIP - hardship array (pass by reference)
 ;
 N CODE,ERROR
 I $G(DUZ)'>1 W !,"YOUR DUZ IS NOT DEFINED!" D PAUSE^VALM1 S VALMBCK="R" Q
 S CODE=""
 S CODE=$$GETCODE^DGMTH(HARDSHIP("CURRENT STATUS"))
 I CODE'="C",CODE'="P",CODE'="G" W !,"PATIENT NOT CURRENTLY RESPONSIBLE FOR COPAYMENT CHARGES!" D PAUSE^VALM1 Q
 S HARDSHIP("EFFECTIVE")=DT
 S HARDSHIP("SITE")=$$GETSITE^DGMTU4(.DUZ)
 I HARDSHIP("TEST STATUS")="" S HARDSHIP("TEST STATUS")=HARDSHIP("CURRENT STATUS")
 ;S HARDSHIP("CURRENT STATUS")=$$GETSTAT^DGMTH("A",1)
 S HARDSHIP("BY")=DUZ
 S HARDSHIP("CTGRY CHNGD BY")=DUZ
 S HARDSHIP("DT/TM CTGRY CHNGD")=$$NOW^XLFDT
 S HARDSHIP("HARDSHIP?")=1
 D
 .I '$$GETSTAT(.HARDSHIP) Q
 .I '$$GETEFF(.HARDSHIP) Q
 .I '$$GETREV(.HARDSHIP) Q
 .I '$$GETREAS(.HARDSHIP) Q
 .D PRIOR(.HARDSHIP)
 .I $$STORE^DGMTH(.HARDSHIP,.ERROR) D
 ..N EVENTS
 ..S EVENTS("IVM")=1
 ..I $$LOG^IVMPLOG(HARDSHIP("DFN"),HARDSHIP("YEAR"),.EVENTS)
 .E  W !,$G(ERROR) D PAUSE^VALM1
 .D AFTER(.HARDSHIP)
 D INIT^DGMTHL
 S VALMBCK="R"
 Q
 ;
EDIT(HARDSHIP) ;
 ;Add hardship protocol.
 ;
 ;Input:
 ;  HARDSHIP - hardship array, pass by reference
 ;Output:
 ;  HARDSHIP - hardship array (pass by reference)
 ;
 N ERROR
 D
 .I '$$GETSTAT(.HARDSHIP,1) Q
 .I '$$GETEFF(.HARDSHIP) Q
 .I '$$GETREV(.HARDSHIP) Q
 .I '$$GETREAS(.HARDSHIP) Q
 .D PRIOR(.HARDSHIP)
 .I $$STORE^DGMTH(.HARDSHIP,.ERROR) D
 ..N EVENTS
 ..S EVENTS("IVM")=1
 ..I $$LOG^IVMPLOG(HARDSHIP("DFN"),HARDSHIP("YEAR"),.EVENTS)
 .E  W !,$G(ERROR) D PAUSE^VALM1
 .D AFTER(.HARDSHIP)
 D INIT^DGMTHL
 S VALMBCK="R"
 Q
 ;
CHKDEL(HARDSHIP) ;
 ;Checks whether the hardship can be deleted.
 ;Input:
 ;  HARDSHIP - hardship array (pass by reference)
 I (HARDSHIP("HARDSHIP?")="1"),(HARDSHIP("BY")!((+HARDSHIP("SITE")=+$$GETSITE^DGMTU4($G(DUZ))))) Q 1
 Q 0
DELETE(HARDSHIP) ;
 ;Deletes the hardship.
 ;
 ;Input:
 ;  HARDSHIP - hardship array (pass by reference)
 ;
 N ERROR
 I $$RUSURE,'$$DELETE^DGMTH(.HARDSHIP,1,.ERROR) W !,"AN ERROR OCCURRED - "_$G(ERROR) D PAUSE^VALM1
 D INIT^DGMTHL
 S VALMBCK="R"
 Q
 ;
GETSTAT(HARDSHIP,EDITFLG) ;
 ;Asks the user to enter the means test status.
 ;
 ;Input:
 ;  HARDSHIP - hardship array (pass by reference)
 ;  EDITFLG  - Edit Flag: 1=Edit
 ;Output:
 ;  HARDSHIP("CURRENT STATUS")
 ;
 N DIR,FLTRSTAT
 S FLTRSTAT=$$GETCODE^DGMTH($S($G(EDITFLG):HARDSHIP("TEST STATUS"),1:HARDSHIP("CURRENT STATUS")))
 S DIR(0)="Pr^408.32:EMZ"
 S DIR("S")="I $P(^(0),U,19)=1"
 I "CP"[FLTRSTAT S DIR("S")=DIR("S")_",""AG""[$P(^(0),U,2)"
 I FLTRSTAT="G" S DIR("S")=DIR("S")_",""A""[$P(^(0),U,2)"
 S DIR("A")="Means Test Status"
 S DIR("B")=$$EXT^DGMTH("CURRENT STATUS",HARDSHIP("CURRENT STATUS"))
 D FULL^VALM1
 D ^DIR
 I $D(DIRUT) Q 0
 I Y<1 Q 0
 S HARDSHIP("CURRENT STATUS")=+Y
 ; Don't reset agreed to pay if mt copay req/GMT copay req/pend adj
 S:"^C^G^P^"'[(U_$P($G(^DG(408.32,+Y,0)),U,2)_U) HARDSHIP("AGREE")=""
 S VALMBCK="R"
 Q 1
 ;
GETEFF(HARDSHIP) ;
 ;Asks the user to enter the effective date.  Returns 1 on success, 0 on failure
 ;
 ;Input:
 ;  HARDSHIP - hardship array (pass by reference)
 ;Output:
 ;  HARDSHIP("EFFECTIVE")
 ;
 N DIR
 S DIR(0)="D^"_HARDSHIP("TEST DATE")_":"_DT_":EX"
 S DIR("A")="Hardship Effective Date"
 S DIR("B")=$$FMTE^XLFDT($S(HARDSHIP("EFFECTIVE"):HARDSHIP("EFFECTIVE"),1:HARDSHIP("TEST DATE")),"1D")
 D ^DIR
 I $D(DIRUT) Q 0
 I Y<1 Q 0
 S HARDSHIP("EFFECTIVE")=Y
 Q 1
GETREV(HARDSHIP) ;
 ;Asks the user to enter the review date.  Returns 1 on success, 0 on failure
 ;
 ;Input:
 ;  HARDSHIP - hardship array (pass by reference)
 ;Output:
 ;  HARDSHIP("REVIEW")
 ;
 N RET,STOP,X,Y
 S (STOP,RET)=0
 S DIR(0)="DO^::EX"
 S DIR("A")="Hardship Review Date"
 I HARDSHIP("REVIEW") S DIR("B")=$$FMTE^XLFDT(HARDSHIP("REVIEW"),"1D")
 S DIR("?")="Enter a future date if you wish to conduct a review."
 F  D  Q:STOP
 .N DIR
 .S DIR(0)="DO^::EX"
 .S DIR("A")="Hardship Review Date"
 .I HARDSHIP("REVIEW") S DIR("B")=$$FMTE^XLFDT(HARDSHIP("REVIEW"),"1D")
 .S DIR("?")="Enter a future date if you wish to conduct a review."
 .D ^DIR
 .I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S STOP=1,RET=0 Q
 .I X="@" S Y="",STOP=1,RET=1 Q
 .I Y=-1 S STOP=1,RET=0 Q
 .I Y<DT W !,DIR("?") Q
 .S (STOP,RET)=1
 S:RET HARDSHIP("REVIEW")=Y
 Q RET
 ;
GETREAS(HARDSHIP) ;
 ;Asks the user to enter the hardship reason.
 ;
 ;Input:
 ;  HARDSHIP - hardship array (pass by reference)
 ;Output
 ;  HARDSHIP("REASON")
 ;
 N DIR
 S DIR(0)="FO^3:80"
 S DIR("A")="Hardship Reason"
 S DIR("B")=$G(HARDSHIP("REASON")) K:DIR("B")="" DIR("B")
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 0
 S HARDSHIP("REASON")=Y
 Q 1
 ;
PRIOR(HARDSHIP) ;set up for means test event driver
 S DFN=HARDSHIP("DFN")
 S DGMTI=HARDSHIP("MTIEN")
 S DGMTS=HARDSHIP("CURRENT STATUS")
 S DGMTACT="CAT"
 S DGMTYPT=1
 D PRIOR^DGMTEVT
 Q
AFTER(HARDSHIP) ;calls means test event driver
 D AFTER^DGMTEVT
 S DGMTINF=0
 D EN^DGMTEVT
 K DGMTA,DGMTACT,DGMTDT,DGMTI,DGMTINF,DGMTP,DGMTS,DGMTYPT,I,J,Y
 Q
COMMENTS(HARDSHIP) ;
 ;Edit Comments protocol.
 ;
 ;Input:
 ;  HARDSHIP - hardship array, pass by reference
 ;Output:
 ;  none
 ;
 N DA,DIE,DR
 I $G(DUZ)'>1 W !,"YOUR DUZ IS NOT DEFINED!" D PAUSE^VALM1 S VALMBCK="R" Q
 D FULL^VALM1
 I $G(HARDSHIP("MTIEN")) S DR="50",DA=HARDSHIP("MTIEN"),DIE=408.31 D ^DIE
 D INIT^DGMTHL
 I VALMCNT<15 S VALMBG=1
 S VALMBCK="R"
 Q
 ;
RUSURE() ;
 ;Description: Asks user 'Are you sure?'
 ;Input: none
 ;Output: Function Value returns 0 or 1
 ;
 N DIR
 S DIR(0)="Y"
 S DIR("A")="Are you sure that the hardship should be deleted"
 S DIR("B")="NO"
 D ^DIR
 Q:$D(DIRUT) 0
 Q Y
