IBCEP8B ;ALB/CJS - Functions for NON-VA PROVIDER cont'd ;06-06-08
 ;;2.0;INTEGRATED BILLING;**391**;21-MAR-94;Build 39
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
BLD(IBNPRV) ; Build/Rebuild display
 N IBLCT,IBCT,IBLST,IBPRI,IBIEN,Z,Z1,Z2
 K @VALMAR
 S (IBLCT,IBCT)=0,Z=$G(^IBA(355.93,IBNPRV,0))
 S IBCT=IBCT+1
 S Z1=$J("Name: ",15)_$P(Z,U) D SET1(.IBLCT,Z1,IBCT)
 I $P(Z,U,2)=2 D
 . S IBCT=IBCT+1
 . S Z1=$J("Type: ",15)_$S($P(Z,U,2)=2:"INDIVIDUAL PROVIDER",1:"OUTSIDE OR OTHER VA FACILITY") D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S Z1=$J("Credentials: ",15)_$P(Z,U,3) D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S Z1=$J("Specialty: ",15)_$P(Z,U,4) D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S Z1=$J("NPI: ",15)_$$NPIGET^IBCEP81(IBNPRV) D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S IBPRI=$$TAXGET^IBCEP81(IBNPRV,.IBLST)
 . S Z1=$J("Taxonomy Code: ",15)_$P(IBPRI,U)
 . I $D(IBLST) S Z1=Z1_" ("_$S($P(IBLST(IBLST),U,3)=1:"Primary",1:"Secondary")_")"
 . D SET1(.IBLCT,Z1,IBCT)
 . S IBIEN=""
 . F  S IBIEN=$O(IBLST(IBIEN)) Q:IBIEN=""  D
 .. I IBIEN=IBLST Q
 .. S IBCT=IBCT+1
 .. S Z1=$J("",15)_$P(IBLST(IBIEN),U)_" ("_$S($P(IBLST(IBIEN),U,3)=1:"Primary",1:"Secondary")_")"
 .. D SET1(.IBLCT,Z1,IBCT)
 E  D
 . S IBCT=IBCT+1
 . S Z1=$J("Address: ",15)_$P(Z,U,5) D SET1(.IBLCT,Z1,IBCT)
 . I $P(Z,U,10) D
 .. S IBCT=IBCT+1
 .. S Z1=$J("",15)_$P(Z,U,10)
 . S IBCT=IBCT+1
 . S Z1=$J("",15)_$P(Z,U,6)_$S($P(Z,U,6)'="":", ",1:"")_$S($P(Z,U,7):$$EXTERNAL^DILFD(355.93,.07,"",$P(Z,U,7))_"  ",1:"")_$P(Z,U,8)
 . D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S Z1=" " D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S Z1=$J("Type of Facility: ",30)_$$EXTERNAL^DILFD(355.93,.11,,$P(Z,U,11))
 . D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S Z1=$J("Primary ID: ",30)_$P(Z,U,9)
 . D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S Z1=$J("ID Qualifier: ",30)_$$GET1^DIQ(355.97,$P(Z,U,13),.03) I $P(Z,U,13)]"" S Z1=Z1_" - "_$$GET1^DIQ(355.97,$P(Z,U,13),.01)
 . D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S Z1=$J("Mammography Certification #: ",30)_$P(Z,U,15)
 . D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S Z1=$J("NPI: ",30)_$$NPIGET^IBCEP81(IBNPRV) D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S IBPRI=$$TAXGET^IBCEP81(IBNPRV,.IBLST)
 . S Z1=$J("Taxonomy Code: ",30)_$P(IBPRI,U)
 . I $D(IBLST) S Z1=Z1_" ("_$S($P(IBLST(IBLST),U,3)=1:"Primary",1:"Secondary")_")"
 . D SET1(.IBLCT,Z1,IBCT)
 . S IBIEN=""
 . F  S IBIEN=$O(IBLST(IBIEN)) Q:IBIEN=""  D
 .. I IBIEN=IBLST Q
 .. S IBCT=IBCT+1
 .. S Z1=$J("",30)_$P(IBLST(IBIEN),U)_" ("_$S($P(IBLST(IBIEN),U,3)=1:"Primary",1:"Secondary")_")"
 .. D SET1(.IBLCT,Z1,IBCT)
 K VALMBG,VALMCNT
 S VALMBG=1,VALMCNT=IBLCT
 Q
 ;
SET1(IBLCT,TEXT,IBCT) ;
 S IBLCT=IBLCT+1 D SET^VALM10(IBLCT,TEXT,$G(IBCT))
 Q
