IBJPC2 ;ALB/FA - IBJP HCSR Wards Parameter Screen ;17-JUL-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
EN ;EP
 ; Main entry point for IBJP HCSR PARAMETERS
 D EN^VALM("IBJP HCSR PARAMETERS")
 Q
 ;
HDR ;EP
 ; Header code
 S VALMHDR(1)="Only authorized persons may edit this data."
 Q
 ;
INIT ;EP
 ; Initialize variables and list array
 K ^TMP("IBJPC2",$J)
 D BLD
 Q
 ;
BLD ; Build screen array, no variables required for input
 N IBLN,IBTRKR62,TEXT
 S IBTRKR62=$G(^IBE(350.9,1,62))                ; IB*2.0*517 added line
 S IBLN=$$SETTEXT("",1,1)
 S TEXT="Health Care Services Review (HCSR) Parameters"
 S IBLN=$$SETTEXT(TEXT,IBLN,17,1)
 S TEXT=$J("CPAC Future Appointments Search: ",57)_$J($P(IBTRKR62,U,13),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("CPAC Future Admissions Search: ",57)_$J($P(IBTRKR62,U,2),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("CPAC Past Appointments Search: ",57)_$J($P(IBTRKR62,U,3),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("CPAC Past Admissions Search: ",57)_$J($P(IBTRKR62,U,4),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("TRICARE/CHAMPVA Future Appointments Search: ",57)_$J($P(IBTRKR62,U,5),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("TRICARE/CHAMPVA Future Admissions Search: ",57)_$J($P(IBTRKR62,U,6),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("TRICARE/CHAMPVA Past Appointments Search: ",57)_$J($P(IBTRKR62,U,7),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("TRICARE/CHAMPVA Past Admissions Search: ",57)_$J($P(IBTRKR62,U,8),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("Inquiry can be Triggered for Appointment: ",57)_$J($P(IBTRKR62,U,10),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("Inquiry can be Triggered for Admission: ",57)_$J($P(IBTRKR62,U,11),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("Days to wait to purge entry on HCSR Response: ",57)_$J($P(IBTRKR62,U,12),4)_" days"
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("Clinics Included In the Search: ",57)_$J(+$P($G(^IBE(350.9,1,63,0)),U,4),4)
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("Wards Included In the Search: ",57)_$J(+$P($G(^IBE(350.9,1,64,0)),U,4),4)
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("Insurance Companies Included In the Appointments Search: ",57)_$J(+$P($G(^IBE(350.9,1,65,0)),U,4),4)
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S TEXT=$J("Insurance Companies Included In the Admissions Search: ",57)_$J(+$P($G(^IBE(350.9,1,66,0)),U,4),4)
 S IBLN=$$SETTEXT(TEXT,IBLN,1)
 S (IBLN,VALMCNT)=IBLN-1
 Q
 ;
SETTEXT(TEXT,LN,COL,RV) ; Sets a line of text into the body of the template
 ; Input:   TEXT            - Text to be displayed
 ;          LN              - Body line to display text on
 ;          COL             - Column to begin display the text in
 ;          RV              - 1 - Set Video Control Characters. Null Otherwise
 ;          ^TMP("IBJPC2")  - Current global array of body display lines
 ; Output:  ^TMP("IBJPC2")  - Updated global array of body display lines
 ; Returns: LN              - Next body line after the one just set
 N IBY
 S IBY=" "_TEXT_" "
 D SET1(IBY,LN,COL,$L(IBY),$G(RV))
 S LN=LN+1
 Q LN
 ;
SET1(STR,LN,COL,WD,RV) ; Sets up TMP array with screen data
 ; Input:   STR             - Text to be set into the line of the body
 ;          LN              - Line of the body to be set
 ;          COL             - Column to begin displaying text in
 ;          WD              - Width of the text to be displayed
 ;          RV              - 1 - Set Video Control Characters. Null Otherwise
 ;          ^TMP("IBJPC2")  - Current global array of body display lines
 ; Output:  ^TMP("IBJPC2")  - Updated global array of body display lines
 N IBX
 S IBX=$G(^TMP("IBJPC2",$J,LN,0))
 S IBX=$$SETSTR^VALM1(STR,IBX,COL,WD)
 D SET^VALM10(LN,IBX)
 I $G(RV)'="" D CNTRL^VALM10(LN,COL,WD,IORVON,IORVOFF)
 Q
 ;
HELP ;EP
 ; Help code
 S X="?"
 D DISP^XQORM1
 W !!
 Q
 ;
OP ;EP
 ; Listman Protocol Action to Edit 'Other' HBCSR Site Parameters in node 62
 N DA,DR,DIE,DTOUT
 S DIE=350.9,DA=1
 S DR="62.1Inquiry can be Triggered for Appointment"
 S DR=DR_";62.11Inquiry can be Triggered for Admission"
 S DR=DR_";62.12Days to wait to purge entry on HCSR Response"
 S VALMBCK="R"                                  ; Refresh screen on return
 Q:'$$LOCK^IBJPC1(62)                           ; Lock node 62 for editing
 ;
 D FULL^VALM1
 D WARNMSG^IBJPC1                               ; Display warning message
 ;
 D ^DIE
 D UNLOCK^IBJPC1(62)
 Q
 ;
EXIT ;EP
 ; Exit code
 K ^TMP("IBJPC2",$J)
 D CLEAR^VALM1
 Q
 ;
EXPND ;EP
 ; Expand code
 Q
 ;
