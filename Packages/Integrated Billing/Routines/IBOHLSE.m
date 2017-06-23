IBOHLSE ;ALB/BAA - IB HELD CHARGES LIST MANAGER ;08-SEP-2015
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for HELD CHARGES EXPAND
 ; add code to do filters here
 ;
 D EN^VALM("IB HELD CHARGES EXPAND")
 Q
 ;
HDR ; -- header code
 ;
 S VALM("TITLE")=" Expanded Held Charges"
 S XQORM("B")="QUIT"
 Q
 ;
INIT ; -- init variables and list array
 ; input - none
 ; output ^TMP($J,"IBOHLSE")
 N DFN,CNT,NAME,IBIEN,REC,CLINIC,LST
 S REC=^TMP($J,"IBOHLSE")
 S DFN=$P(REC,U,1),CNT=$P(REC,U,2)
 S NAME=$P(REC,U,3),IBIEN=$P(REC,U,4)
 S LST=$P(REC,U,5),CLINIC=$P(REC,U,6)
 D BLD
 Q
 ;
BLD ; build data to display
 N CNT,SS,LINE,XX,RX,GMT,IB0,IB1,PATIEN,XX
 N EADAT,EAWHO,LUDAT,LUWHO
 S (CNT,VALMCNT)=0
 S IB0=^IB(IBIEN,0)
 S IB1=^IB(IBIEN,1)
 S SS=$$GET1^DIQ(2,DFN,.09)
 ;
 D FULL^VALM1
 D SET^VALM10(1,"PATIENT : "_NAME_" - "_SS,"")
 ;
 D SET^VALM10(2,"TYPE : "_$$GET1^DIQ(350.1,$P(IB0,U,3),.01),"")
 ;
 D SET^VALM10(3,"RESULTING FROM : "_$P(IB0,U,4),"")
 ;
 S LINE="",LINE=$$SETL(LINE,$$GET1^DIQ(350.21,$P(IB0,U,5),.01),"STATUS : ",1,38)
 S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(IB0,U,17),"2DZ"),"EVENT DATE : ",40,38)
 D SET^VALM10(4,LINE,"")
 ;
 S LINE="",LINE=$$SETL(LINE,$P(IB0,U,9),"PARENT : ",1,38)
 S LINE=$$SETL(LINE,$P(IB0,U,7),"CHARGE : ",40,38)
 D SET^VALM10(5,LINE,"")
 ;
 D SET^VALM10(6,"INSTITUTION : "_$$GET1^DIQ(4,$P(IB0,U,13),.01)_" : "_LST_" - "_CLINIC,"")
 ;
 D SET^VALM10(7,"BILLED : "_$$FMTE^XLFDT($P(IB0,U,14),"2DZ")_" - "_$$FMTE^XLFDT($P(IB0,U,15),"2DZ"),"")
 ;
 S LINE="",LINE=$$SETL(LINE,$$GET1^DIQ(4,$P(IB0,U,13),.01),"AR BILL # : ",1,38)
 S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(IB0,U,18),"2DZ"),"LAST BILLED : ",40,38)
 D SET^VALM10(8,LINE,"")
 ;
 D SET^VALM10(9,"IB COPAY TRANS # : "_$$GET1^DIQ(354.71,$P(IB0,U,19),.01),"")
 D SET^VALM10(10,"CLINIC STOP : "_$$GET1^DIQ(352.5,$P(IB0,U,20),.01),"")
 ;
 S GMT=$P(IB0,U,21)
 D SET^VALM10(11,"GMT RELATED : "_$S(GMT=1:"Yes",1:"No"),"")
 D SET^VALM10(12,"PFSS ACCT REF : "_$$GET1^DIQ(375,$P(IB0,U,22),.01),"")
 ;
 S EAWHO=$$GET1^DIQ(200,$P(IB1,U,1),.01)
 S EADAT=$$FMTE^XLFDT($P(IB1,U,2),"2DZ")
 D SET^VALM10(13,"ENTRY ADDED : "_EAWHO_"     "_EADAT,"")
 ;
 S LUWHO=$$GET1^DIQ(200,$P(IB1,U,3),.01)
 S LUDAT=$$FMTE^XLFDT($P(IB1,U,4),"2DZ")
 D SET^VALM10(14,"LAST UPDATED : "_LUWHO_"     "_LUDAT,"")
 ;
 D SET^VALM10(15,"CHAMPVA ADM DATE : "_$$FMTE^XLFDT($P(IB1,U,5),"2DZ"),"")
 D SET^VALM10(16,"ON HOLD DATE : "_$$FMTE^XLFDT($P(IB1,U,6),"2DZ"),"")
 D SET^VALM10(17,"HOLD-REVIEW DATE : "_$$FMTE^XLFDT($P(IB1,U,7),"2DZ"),"")
 S VALMBCK="R",VALMBG=1,VALMCNT=16
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 ;K ^TMP($J)
 D ^%ZISC
 I 
 S VALMBCK="R" Q
 Q
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ; Creates a line of data to be set into the body
 ; of the worklist
 ; Input: LINE - Current line being created
 ; DATA - Information to be added to the end of the current line
 ; LABEL - Label to describe the information being added
 ; COL - Column position in line to add information add
 ; LNG - Maximum length of data information to include on the line
 ; Returns: Line updated with added information
 ;S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 N NEW
 S NEW=LABEL_$E(DATA,1,LNG)
 S $E(LINE,COL)=NEW
 Q LINE
