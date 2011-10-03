IBCBB7 ;ALB/BGA - CONT. OF MEDICARE EDIT CHECKS ;09/10/98
 ;;2.0;INTEGRATED BILLING;**51,137,240**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Revenue Codes
 ;
 ; rev codes must be between 100 AND 999
 I $O(IBREV1(100),-1)>0!($O(IBREV1(999))>0) S IBQUIT=$$IBER^IBCBB3(.IBER,184) Q:IBQUIT
 N IBRATYP
 ;
 ; ibrev1(rev cd,seq #)=Rev code^ptr cpt^unit chg^units^total^tot unc^^^mod ptrs
 ; 3 subsection edits
 ;
 D F^IBCEF("N-BILL RATE TYPE","IBZ",,IBIFN)
 ; Don't apply some edits unless specific rate types
 S IBZ=$P($G(^DGCR(399.3,+IBZ,0)),U)
 S IBRATYP=$S(IBZ="":1,IBZ["TRICARE"!(IBZ["CHAMPVA")!(IBZ["SHARING")!(IBZ["REIMBURS"):1,1:0)
 S IBREVC=0 F  S IBREVC=$O(IBREV1(IBREVC)) Q:IBREVC=""  D  Q:IBQUIT
 . S IBI=0
 . F  S IBI=$O(IBREV1(IBREVC,IBI)) Q:'IBI  D  Q:IBQUIT
 . . ;
 . . S IBREVD=IBREV1(IBREVC,IBI),IBREVC12=$E(IBREVC,1,2),IBBCPT=$P(IBREVD,U,2)
 . . ;
 . . ; No charge associated with rev code
 . . I '$P(IBREVD,U,3),IBREVC12'=18 S IBQUIT=$$IBER^IBCBB3(.IBER,185) Q:IBQUIT
 . . ;
 . . ; Charges cannot be negative dollar amounts
 . . I $P(IBREVD,U,5)<0 S IBQUIT=$$IBER^IBCBB3(.IBER,213) Q:IBQUIT
 . . ;
 . . ; Non Covered charges cannot be a negative amount
 . . ;     and must not be > total charge
 . . I $P(IBREVD,U,6)>$P(IBREVD,U,5)!($P(IBREVD,U,6)<0) S IBQUIT=$$IBER^IBCBB3(.IBER,214) Q:IBQUIT
 . . ;
 . . ; =====
 . . ; Accommodation revenue code edits
 . . I IBREV1(IBREVC)="AC" D  Q
 . . . N IBBSEC
 . . . ; dup Rev accom cds must have diff rates and bedsections
 . . . S IBBSEC=$P($G(^DGCR(399,IBIFN,"RC",+$P(IBREVD,U,8),0)),U,5)
 . . . I $O(IBREV1(IBREVC,1)) D  Q:IBQUIT
 . . . . I IBI=1 K IBREVDUP S IBREVDUP(+$P(IBREVD,U,3)_" "_IBBSEC)=""
 . . . . I IBI>1,$D(IBREVDUP(+$P(IBREVD,U,3)_" "_IBBSEC)) S IBQUIT=$$IBER^IBCBB3(.IBER,186)
 . . . ; Total Line charges for accom rev codes can not be < 0
 . . . I IBREVC>99,IBREVC<220,IBREVTOT("AC")<0 S IBQUIT=$$IBER^IBCBB3(.IBER,211)
 . . . ; For accom rev codes, detail charge for revc=18x must be 0
 . . . I IBREVC12=18,$P(IBREV1(IBREVC,IBI),U,3) S IBQUIT=$$IBER^IBCBB3(.IBER,212)
 . . ;
 . . ; =====
 . . ; Inpatient Ancillary only Rev Codes edit 60-4
 . . I IBREV1(IBREVC)="AI" D  Q
 . . . ; Cannot have dup anc REV codes except 24X
 . . . N IBMOD
 . . . S IBMOD=$P(IBREVD,U,9)
 . . . ;I IBRATYP,IBI>1,IBREVC12'=24 S IBQUIT=$$IBER^IBCBB3(.IBER,188)
 . . . ;
 . . . ;HCPCS code is required for rev code 636 and TOB 13X, 14X, 83X
 . . . I IBREVC=636,IBBCPT="",(IBTOB12=13!(IBTOB12=14)!(IBTOB12=83)) S IBQUIT=$$IBER^IBCBB3(.IBER,191)
 . . . ;
 . . ; =====
 . . ; OUTPATIENT ANCILLARY only Rev Codes edit rec 61-04
 . . I IBREV1(IBREVC)="AO" D  Q
 . . . ;
 . . . ; Rev codes with different HCPCS codes can be duplicated
 . . . I $$FT^IBCEF(IBIFN)=3,$O(IBREV1(IBREVC,1))  D  Q:IBQUIT
 . . . . N IBMOD
 . . . . S IBMOD=$P(IBREVD,U,9)
 . . . . I IBI=1 K IBREVDUP S IBREVDUP(IBBCPT_" "_IBMOD)=""
 . . . . I '$$ISRX^IBCEF1(IBIFN),IBI>1,$D(IBREVDUP(IBBCPT_" "_IBMOD)),IBER'["IB192;" S IBQUIT=$$IBER^IBCBB3(.IBER,192)
 . . . ;
 . . . ; Rev Code 49x can not be entered with 36x and 37x
 . . . I IBREVC12=49,$O(IBREV1(380),-1)'<360 S IBQUIT=$$IBER^IBCBB3(.IBER,195) Q:IBQUIT
 . . . ;
 . . . ; If Rev=42x & billtype=83x!13x req occ cds 11&35 and val code 50
 . . . ;I IBREVC12=42,(IBTOB12=83!(IBTOB12=13)) D  Q:IBQUIT
 . . . ;. I '$D(IBVALCD(50))!'$D(IBOCCD(11))!'$D(IBOCCD(35)) S IBQUIT=$$IBER^IBCBB3(.IBER,196)
 . . . ;
 . . . ; If Rev=43x & billtype=83x!13x req occ cds 11&44 and val code 51
 . . . ;I IBREVC12=43,(IBTOB12=83!(IBTOB12=13)) D
 . . . ;. I '$D(IBVALCD(51))!'$D(IBOCCD(11))!'$D(IBOCCD(44)) S IBQUIT=$$IBER^IBCBB3(.IBER,197)
 . . . ;
 . . . ; If Rev=44x & billtype=83x!13x req occ cds 11&45 and val code 52
 . . . ;I IBREVC12=44,(IBTOB12=83!(IBTOB12=13)) D
 . . . ;. I '$D(IBVALCD(52))!'$D(IBOCCD(11))!'$D(IBOCCD(45)) S IBQUIT=$$IBER^IBCBB3(.IBER,198)
 . . . ;
 . . . ; If Rev=943 & billtype=83x!13x req occ cds 11&46 and val code 53
 . . . ;I IBREVC=943,(IBTOB12=83!IBTOB12=13) D
 . . . ;. I '$D(IBVALCD(53))!('$D(IBOCCD(11)))!('$D(IBOCCD(46))) S IBQUIT=$$IBER^IBCBB3(.IBER,199)
 . . . ;
 . . . ; If Rev=403 & bill type=14x!23x and service date >= 01-01-91
 . . . ;   require only HCPCS codes 76092 and no other rev codes
 . . . I IBREVC=403,IBFDT'<2910101,(IBTOB12=14!(IBTOB12=23)) D
 . . . . I $O(IBREV1(403))!$O(IBREV1(403),-1)!(IBBCPT'=76092) S IBQUIT=$$IBER^IBCBB3(.IBER,194) Q
 . . . ;
 . . . ; If Rev=401 & bill type=13x!14x!23x!71x allow only HCPSCS codes
 . . . ;   76090 or 78091
 . . . ;I IBREVC=401,(IBTOB12=13!(IBTOB12=14)!(IBTOB12=23)!(IBTOB12=71)),IBBCPT'="",IBBCPT'=76090,IBBCPT'=78091 S IBQUIT=$$IBER^IBCBB3(.IBER,201)
 . . . ;
 . . . ; Rev code cannot equal 227 or 29x
 . . . ;I IBREVC=227!(IBREVC12=29) S IBQUIT=$$IBER^IBCBB3(.IBER,202)
 . . . D REVC^IBCBB7A(IBREVD,IBREVC,IBBCPT,IBREVC12,.IBER)
 Q:IBQUIT
 ;
 D ^IBCBB8
 Q
