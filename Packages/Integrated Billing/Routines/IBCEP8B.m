IBCEP8B ;ALB/CJS - Functions for NON-VA PROVIDER cont'd ;06-06-08
 ;;2.0;INTEGRATED BILLING;**391,432,476,488,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
BLD(IBNPRV) ; Build/Rebuild display
 N IBLCT,IBCT,IBLST,IBPRI,IBIEN,Z,Z1,Z2,IB1
 N IBFBTGL,IBFBOK ;IB*2.0*476
 K @VALMAR
 ;S (IBLCT,IBCT)=0,Z=$G(^IBA(355.93,IBNPRV,0))
 S (IBLCT,IBCT)=0,Z=$G(^IBA(355.93,IBNPRV,0)),IB1=$G(^IBA(355.93,IBNPRV,1))
 ;
 ;  Moved IBCT & NAME into each section as the tabbing is different for each type  IB*2*488
 ;S IBCT=IBCT+1
 ;S Z1=$J("Name: ",15)_$P(Z,U) D SET1(.IBLCT,Z1,IBCT)
 ;
 I $P(Z,U,2)=2 D                 ; Individual provider (not a facility)
 . S IBCT=IBCT+1
 . S Z1=$J("Name: ",15)_$P(Z,U) D SET1(.IBLCT,Z1,IBCT)
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
 . ;IB*2.0*476 - BEGIN added prompt to allow OPTION FB PAID TO IB to make updates or not
 . S IBCT=IBCT+1
 . S Z1=" " D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S IBFBTGL=$$FBTGLGET^IBCEP8C1(IBNPRV)  ;RETURNS 0,1 OR ""
 . S IBFBOK="YES"
 . S:IBFBTGL=0 IBFBOK="NO"
 . S Z1=$J("Allow future updates by FEE BASIS automatic interface? : ",50)_IBFBOK
 . D SET1(.IBLCT,Z1,IBCT)
 ;E  D
 I $P(Z,U,2)'=2 D
 .;IB*2.0*476 - END added prompt to allow OPTION FB PAID TO IB to make updates or not
 . S IBCT=IBCT+1
 . S Z1=$J("Name: ",19)_$P(Z,U) D SET1(.IBLCT,Z1,IBCT)
 . ;;
 . ;; Begin IB*2.0*488 -RBN
 . ;;
 . N XX,BADADD,BADZIP,MSG
 . S MSG="     "
 . S (BADADD,BADZIP)=0
 . S XX=$P(Z,U,5)
 . I $L(XX)>30!($L(XX)<1) S BADADD=1
 . S BADADD=$$BADADD(XX)
 . S XX=$P(Z,U,8)
 . I $L(XX)>10!($L(XX)<9)!'((XX?9N)!(XX?5N1"-"4N))!($E(XX,$L(XX)-3,$L(XX))="0000") S BADZIP=1
 . ;;
 . ;; End IB*2.0*488
 . ;;
 . S IBCT=IBCT+1
 . S Z1=$J("Address: ",19)_$P(Z,U,5) D SET1(.IBLCT,Z1,IBCT)
 . I $P(Z,U,10) D
 .. S IBCT=IBCT+1
 .. S Z1=$J("",19)_$P(Z,U,10)  ; This is the street2 of the address - NOT displayed
 . S IBCT=IBCT+1
 . S Z1=$J("",19)_$P(Z,U,6)_$S($P(Z,U,6)'="":", ",1:"")_$S($P(Z,U,7):$$EXTERNAL^DILFD(355.93,.07,"",$P(Z,U,7))_"  ",1:"")_$P(Z,U,8)
 . D SET1(.IBLCT,Z1,IBCT)
 . ;;
 . ;; Begin IB*2.0*488 - RBN
 . ;;
 . I BADADD S MSG=MSG_"Address cannot be a PO BOX"
 . I BADZIP S MSG=$S(MSG'="     ":MSG_" & ",1:MSG) S MSG=MSG_"ZIP must be 9-10 digits not ending in 0000"
 . I BADADD!BADZIP D
 . . S IBCT=IBCT+1
 . . S Z1=" "
 . . D SET1(.IBLCT,Z1,IBCT)
 . . S IBCT=IBCT+1
 . . D SET1(.IBLCT,MSG,IBCT)
 . . S IBCT=IBCT+1
 . . S Z1=" "
 . . D SET1(.IBLCT,Z1,IBCT)
 . ;;
 . ;; End IB*2.0*488
 . ;;
 . ; start contact changes here
 . S IBCT=IBCT+1
 . S Z1=$J("P&C Contact Name: ",19)_$P(IB1,U,1) D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S Z1=$J("P&C Contact Phone: ",19)_$P(IB1,U,2)_"  "_$P(IB1,U,3) D SET1(.IBLCT,Z1,IBCT)
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
 . S Z1=$J("Sole Proprietor: ",30)_$S($P(Z,U,18):$$GET1^DIQ(355.93,$P(Z,U,18),.01),1:"NO")
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
 . ;IB*2.0*476 - BEGIN added prompt to allow OPTION FB PAID TO IB to make updates or not
 . S IBCT=IBCT+1
 . S Z1=" " D SET1(.IBLCT,Z1,IBCT)
 . S IBCT=IBCT+1
 . S IBFBTGL=$$FBTGLGET^IBCEP8C1(IBNPRV)  ;RETURNS 1,0 OR ""
 . S IBFBOK="YES"
 . S:IBFBTGL=0 IBFBOK="NO"
 . S Z1=$J("Allow future updates by FEE BASIS automatic interface? : ",60)_IBFBOK
 . D SET1(.IBLCT,Z1,IBCT)
 . ;IB*2.0*476 - END added prompt to allow OPTION FB PAID TO IB to make updates or not
 K VALMBG,VALMCNT
 S VALMBG=1,VALMCNT=IBLCT
 Q
 ;
SET1(IBLCT,TEXT,IBCT) ;
 S IBLCT=IBLCT+1 D SET^VALM10(IBLCT,TEXT,$G(IBCT))
 Q
 ;
 ; This checks for a post office box.  baa *488*
 ; Called by the input transform for file 355.93 field .05 Street Address.
 ;
BADADD(XX) ;
 N NOK,BADADD
 S NOK=0
 S XX=$$UP^XLFSTR(XX) ;make lower case upper
 I XX[" BOX #" S NOK=1
 I XX?.E1"BOX"." "."#"." "1N.E S NOK=1
 S XX=$$STRIP^XLFSTR(XX,". ") ; strip out punctuation
 I XX="BOX" S NOK=1
 I XX="BOX#" S NOK=1
 I XX="PO" S NOK=1
 I XX="POB" S NOK=1
 I XX="POBOX" S NOK=1
 I XX="POSTALBOX" S NOK=1
 Q NOK
