IBFBWL4 ;ALB/PAW-IB BILLING Worklist History ;30-SEP-2015
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for IB BILLING WORKLIST HISTORY
 D EN^VALM("IB BILLING WORKLIST HISTORY")
 Q
 ;
HDR ; -- header code
 N IBSS,IBSSX,IBSSLE,IBSSLS
 S VALM("TITLE")=" Worklist History"
 S IBSSX=$$GET1^DIQ(2,DFN_",",.09,"I"),IBSSLE=$L(IBSSX),IBSSLS=6 I $E(IBSSX,IBSSLE)="P" S IBSSLS=5
 S IBSS=$E(IBNAME,1)_$E(IBSSX,IBSSLS,IBSSLE)
 S VALMHDR(2)=" PATIENT: "_IBNAME_" (ID: "_IBSS_")"
 Q
 ;
INIT ; -- init variables and list array
 ; input - ^TMP("IBFBWH",$J,IBA)=IBHDT^IBHLG^IBHUSR
 ; output - Worklist History Screen for one Patient / Auth
 N IBA,IBHDT,IBHLG,IBLN,IBRUR,IBRURT,IBUSR,LINE,VCNT
 S (VCNT,VALMCNT)=0
 S IBA=""
 F  S IBA=$O(^TMP("IBFBWH",$J,IBA)) Q:+IBA=0  D
 . S IBRURT=""
 . S IBLN=^TMP("IBFBWH",$J,IBA)
 . S IBHDT=$P(IBLN,U,1)
 . S IBHLG=$P($P(IBLN,U,2),"|")
 . I IBHLG["RUR-NextRevDt" S IBHLG=$P(IBHLG,"/",1,2)
 . S IBRUR=$P($P(IBLN,U,2),"|",2)
 . I IBRUR'="" D RUR
 . S IBUSR=$P(IBLN,U,3)
 . I IBUSR="" S IBUSR="SYSTEM"
 . E  S IBUSR=$$GET1^DIQ(200,IBUSR_",",.01)
 . S VCNT=VCNT+1
 . S LINE=$$SETL("",VCNT,"",1,4) ;line#
 . D BLD
 Q
 ;
RUR ; Determine RUR Reason Code
 S IBRURT=$S(IBRUR=1:"Pending Payer Action",IBRUR=2:"Addl Info Req - FR",IBRUR=3:"Auth Not Req - SC/SA",IBRUR=4:"AuthNotReq-PayerCont",1:"")
 Q:IBRURT'=""
 S IBRURT=$S(IBRUR=5:"Auth Not Required",IBRUR=6:"Auth Obtained",IBRUR=7:"Cont Stay Review",IBRUR=8:"Discharge Rev Req",1:"")
 Q:IBRURT'="" 
 S IBRURT=$S(IBRUR=9:"Part SC-Auth Worked",IBRUR=10:"PartStay/VisitAppd",IBRUR=11:"Auth Denied",1:"")
 Q:IBRURT'=""
 S IBRURT=$S(IBRUR=12:"AuthNotObt/NoROI/FR",IBRUR=13:"EOC SC/SA",IBRUR=14:"EOC Non SC/SA",1:"")
 Q:IBRURT'=""
 S IBRURT=$S(IBRUR=15:"NeedAddlInfo-RefToFR",IBRUR=16:"EOC R/T Legal",IBRUR=17:"EOCNotR/TLegal-NoOHI",1:"")
 Q:IBRURT'=""
 S IBRURT=$S(IBRUR=18:"EOCNotLegal-OHI SCSA",IBRUR=19:"EOCNotLeg-OHINonSCSA",1:"")
 Q
 ; 
BLD ; build data to display
 S LINE=$$SETL(LINE,IBHDT,"",5,8)
 S LINE=$$SETL(LINE,IBHLG,"",14,20)
 S LINE=$$SETL(LINE,IBRURT,"",35,20)
 S LINE=$$SETL(LINE,IBUSR,"",56,23)
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,LINE,VCNT)
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
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D ^%ZISC
 S VALMBCK="R" Q
 Q
