IBJPI ;DAOU/BHS - IBJP eIV SITE PARAMETERS SCREEN ;14-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,316,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eIV - Electronic Insurance Verification Interface parameters
 ;
EN ; main entry pt for IBJP IIV SITE PARAMS
 N POP,X,CTRLCOL,VALMHDR,VALMCNT,%DT
 D EN^VALM("IBJP IIV SITE PARAMETERS")
 Q
 ;
HDR ; header 
 S VALMHDR(1)="Only authorized persons may edit this data."
 Q
 ;
INIT ; init vars & list array
 K ^TMP($J,"IBJPI")
 ; Kills data and video control arrays with active list
 D CLEAN^VALM10
 D BLD
 Q
 ;
HELP ; help
 D FULL^VALM1
 W @IOF
 W !,"This screen displays all of the eIV Site Parameters used to manage the"
 W !,"eIV application used for electronic Insurance Verification."
 W !!,"The General Parameters section concerns overall parameters for"
 W !,"monitoring the interface and controlling eIV communication between"
 W !,"VistA and the EC located in Austin."
 W !!,"The Batch Extracts section concerns extract-specific parameters"
 W !,"including active/inactive status and selection criteria."
 D PAUSE^VALM1
 W @IOF
 S VALMBCK="R"
 Q
 ;
EXIT ; exit
 K ^TMP($J,"IBJPI")
 D CLEAN^VALM10
 Q
 ;
BLD ; build screen array
 N IBLN,IBCOL,IBWID,IBIIV,IBIIVB,IBIEN,CT,IBEX1,IBEX2,IBEX,IEN
 N IBST,IBDATA,DISYS,X,STATUS,AIEN,ADATA
 ;
 S (IBLN,VALMCNT)=0,IBCOL=3,IBIIV=$G(^IBE(350.9,1,51))
 ; -- Gen Params
 S IBWID=49
 S IBLN=$$SETN("General Parameters",IBLN,IBCOL,1,)
 S IBLN=$$SET("Days between electronic re-verification checks:  ",$P(IBIIV,U,1),IBLN,IBWID)
 S IBLN=$$SET("Send daily statistical report via MailMan:  ",$S($P(IBIIV,U,2):"YES",$P(IBIIV,U,2)=0:"NO",1:""),IBLN,IBWID)
 I $P(IBIIV,U,2) S IBLN=$$SET("Time of day for daily statistical report:  ",$P(IBIIV,U,3),IBLN,IBWID)
 S IBLN=$$SET("Mail Group for eIV messages:  ",$$MGRP^IBCNEUT5,IBLN,IBWID)
 S IBLN=$$SET("HL7 Response Processing Method:  ",$S($P(IBIIV,U,13)="B":"BATCH",$P(IBIIV,U,13)="I":"IMMEDIATE",1:""),IBLN,IBWID)
 I $P(IBIIV,U,13)="B" D
 . S IBLN=$$SET("HL7 Batch Start Time:  ",$P(IBIIV,U,14),IBLN,IBWID)
 . S IBLN=$$SET("HL7 Batch Stop Time:  ",$P(IBIIV,U,19),IBLN,IBWID)
 . Q
 ;
 S IBLN=$$SET("Contact Person:  ",$S($P(IBIIV,U,16)'="":$$GET1^DIQ(200,$P(IBIIV,U,16)_",",.01,"E"),1:""),IBLN,IBWID)
 S IBLN=$$SET("Send MailMan message if communication problem:  ",$S($P(IBIIV,U,20):"YES",$P(IBIIV,U,20)=0:"NO",1:""),IBLN,IBWID)
 ;
 ; Skip lines in between sections
 S IBLN=$$SET("","",IBLN,0)
 ;
 ; -- Batch Extracts
 S IBWID=43
 S IBLN=$$SETN("Batch Extracts",IBLN,IBCOL,1,)
 S IBLN=$$SET("Extract               Selection  Maximum # to","",IBLN,IBWID)
 S IBLN=$$SETN(" Name          On/Off  Criteria   Extract/Day",IBLN,IBCOL+1,,1)
 ;S IBLN=$$SETN(" Extract Name      On/Off      Selection Criteria",IBLN,IBCOL+1,,1)
 ; Loop thru extracts
 S IEN=0 F  S IEN=$O(^IBE(350.9,1,51.17,IEN)) Q:'IEN  D
 . S IBIIVB=$G(^IBE(350.9,1,51.17,IEN,0))
 . S IBEX=+$P(IBIIVB,U,1)  ; Type
 . I '$F(".1.2.3.","."_IBEX_".") Q
 . S IBST=$$FO^IBCNEUT1($S($P(IBIIVB,U,1)'="":$$GET1^DIQ(350.9002,$P(IBIIVB,U,1)_",1,",.01,"E"),1:""),14)
 . S IBST=IBST_$$FO^IBCNEUT1($S(+$P(IBIIVB,U,2):"ON",1:"OFF"),8)
 . S IBEX1=$S(+$P(IBIIVB,U,3)'=0:+$P(IBIIVB,U,3),1:$P(IBIIVB,U,3))
 . S IBEX2=$S(+$P(IBIIVB,U,4)'=0:+$P(IBIIVB,U,4),1:$P(IBIIVB,U,4))
 . S IBST=IBST_$$FO^IBCNEUT1($S(IBEX=1:"n/a",IBEX=2:IBEX1,IBEX=3:IBEX1_"/"_IBEX2,1:"ERROR"),11)
 . S IBST=IBST_$$FO^IBCNEUT1($S(+$P(IBIIVB,U,5):+$P(IBIIVB,U,5),1:$P(IBIIVB,U,5)),14)
 . S IBLN=$$SET(IBST,"",IBLN,IBWID)
 . Q
 ;S IBLN=$$SET("","",IBLN,0)
 S VALMCNT=IBLN
 Q
 ;
SET(TTL,DATA,LN,WID) ;
 ; TTL = caption for field
 ; DATA = field value
 ; LN = current line #
 ; WID = right justify width
 N IBY
 ; update line ct
 S LN=LN+1
 ; offset line by 3 spaces
 S IBY="   "_$J(TTL,WID)_DATA D SET1(IBY,LN,0,$L(IBY))
 Q LN
 ;
SETN(TTL,LN,COL,RV,UN) ;
 ; TTL = caption for field
 ; LN = current line #
 ; COL = column at which to start video attribute
 ; RV = 0/1 flag for reverse video
 ; UN = 0/1 flag for underline
 N IBY
 ; update line ct
 S LN=LN+1
 ; offset line by 2 spaces
 S IBY="  "_TTL D SET1(IBY,LN,COL,$L(TTL),$G(RV),$G(UN))
 Q LN
 ;
SET1(STR,LN,COL,WD,RV,UN) ; Set up ^TMP array with screen data
 ; STR = line text
 ; LN = current line #
 ; COL = column at which to start video attribute
 ; WD = width of video attribute
 ; RV = 0/1 flag for reverse video
 ; UN = 0/1 flag for underline
 D SET^VALM10(LN,STR)
 I $G(RV)'="" D CNTRL^VALM10(LN,COL,WD,IORVON,IORVOFF)
 I $G(UN)'="" D CNTRL^VALM10(LN,COL,WD-1,IOUON,IOUOFF)
 Q
 ;
