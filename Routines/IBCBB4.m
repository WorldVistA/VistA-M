IBCBB4 ;ALB/BGA - CONT OF MEDICARE EDIT CHECKS ;08/05/98
 ;;2.0;INTEGRATED BILLING;**51,137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified
 ;
 ; Admission Date
 ;   Required when type of bill 11x,18x, or 21x 
 ; If admit date>IBFDT then error
 I IBCTYP D  Q:IBQUIT
 . I (IBEVDT\1)>(IBFDT\1) S IBQUIT=$$IBER^IBCBB3(.IBER,125) Q:IBQUIT
 . I $P(IBEVDT,".",2)="",$P(IBNDU,U,20)="" D WARN^IBCBB11("Admit time is still the default of midnight - update to actual time")
 ;
 ; Type of Admission
 ;    required when bill type is 11x 
 I IBTOB12=11,'$P(IBNDU,U,8) S IBQUIT=$$IBER^IBCBB3(.IBER,126) Q:IBQUIT
 ;
 ; Source of Admission
 ;   If bill type 11x,12x,13x,14x,18x,83x
 I "^11^12^13^14^18^83^"[(U_IBTOB12_U),'$P(IBNDU,U,9) D
 . I '$$INPAT^IBCEF(IBIFN,1) D WARN^IBCBB11("No source of admission: '2 - CLINIC REFERRAL' will be used") Q  ; Outpatient default
 . S IBQUIT=$$IBER^IBCBB3(.IBER,127) Q:IBQUIT  ; Inpatient required
 ;
 ; Patient Status (discharge status)
 ;   required when bill type 11x,13x,18x,21x,32x,33x,81x,82x,83x
 I IBPATST="" D  Q:IBQUIT
 . Q:"^11^13^18^21^32^33^81^82^83^"'[(U_IBTOB12_U)
 . ;
 . I '$$INPAT^IBCEF(IBIFN,1),$$FT^IBCEF(IBIFN)=3 D  Q
 .. D WARN^IBCBB11("No discharge status: '01 - DISCHARGED TO HOME OR SELF CARE' will be used")
 .. S IBPATST="01"
 . ;
 . S IBQUIT=$$IBER^IBCBB3(.IBER,128)
 ; Check valid values for patient status
 I IBPATST'="",("^01^02^03^04^05^06^07^08^09^20^30^50^51^"'[(U_IBPATST_U)) S IBQUIT=$$IBER^IBCBB3(.IBER,131) Q:IBQUIT
 ;
 D ^IBCBB5
 Q
