IBCNP ;AITC/CKB - Insurance Verification of Pharmacy policy ;23-APR-2025
 ;;2.0;INTEGRATED BILLING;**822**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to file #2 in ICR #10035
 Q
 ;
PE ;  -- main entry point for Pharmacy Eligibility
 D FULL^VALM1
 D EN^VALM("IBCNP PHARMACY ELIG")
 S VALMBCK="R"
 Q
 ;
HDR ; -- header code
 N IBDOB,IBDOD,IBNAME
 S IBDOB=$$GET1^DIQ(2,DFN_",",.03,"I")   ;Date of Birth
 S IBNAME=$E($$GET1^DIQ(2,DFN_",",.01),1,20)
 ;
 S VALMHDR(1)="For: "_IBNAME_"  "_$P($$PT^IBEFUNC(DFN),U,2)_"  "_$$FMTE^XLFDT(IBDOB,"5DZ")
 ;
 S IBDOD=$$GET1^DIQ(2,DFN_",",.351,"I")  ;Date of Death
 I IBDOD'="" S VALMHDR(1)=VALMHDR(1)_"   DoD: "_$$FMTE^XLFDT(IBDOD,"5DZ")
 ;
 S VALMHDR(2)=$$GET1^DIQ(2.312,$P(IBPPOL,U,4)_","_DFN,.01)_" Insurance Company"
 Q
 ;
INIT ; -- init variables and list array
 ; Input: None
 ; Output:  ^TMP("IBCNBLE",$J) - Body lines to display
 K ^TMP("IBCNBLE",$J)
 N RSPIEN
 S VALMBCK="R",VALMBG=1,VALMCNT=0
 D BLD
 Q
 ;
BLD ; Build display of Pharmacy Eligibility data ^TMP("IBCNBLE",$J)
 ;Get the BPS REPONSE ien from field (#2.312,8.04) E1 DISPLAY ENTRY
 S RSPIEN=$$GET1^DIQ(2.312,+$P(IBPPOL,U,4)_","_DFN_",",8.04,"I")
 D EN1^IBCNBLE2(RSPIEN)    ; Display Pharmacy Eligibility
 Q
 ;
HELP ; -- help code
 N X S X="?"
 D DISP^XQORM1 W !!
 Q
 ;
EXIT ; - exit list manager screen
 K ^TMP("IBCNBLE",$J)
 D CLEAN^VALM10,CLEAR^VALM1
 S VALMBCK="R"
 Q
