ORBINPTR ;SLC/TC - Input transforms for OE/RR Notifications ;10/30/12  08:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**348**;Dec 17, 1997;Build 14
 ;
 ;
VALNUM(X) ; Called by input transform of ^DD(100.9,.001,0), Number field
 N VALID,LSTREC S VALID=1,LSTREC=$P($G(^ORD(100.9,0)),U,3)
 I $G(DIUTIL)="VERIFY FIELDS" Q VALID
 I DUZ(0)'="@" S VALID=0 Q VALID  ; No access to create notifications
 I X<10101 S VALID=0 Q VALID  ;Numbers 1-9999 are reserved for National notifications
 I $L(X)=5 D
 . N LSTNUM,EXPNUM
 . S LSTNUM=$S($L(LSTREC)=5&($E(LSTREC,1,3)=+$$SITE^VASITE):$E(LSTREC,4,5),1:"")
 . S EXPNUM=$S('$L(LSTNUM):(+$$SITE^VASITE)_"01",1:(LSTREC+1))
 . I ($E(X,1,3)'=(+$$SITE^VASITE))&($E(X,4,5)'=(LSTNUM+1)) D
 . . S VALID=0 D EN^DDIOL("Invalid number scheme. Expecting number "_EXPNUM_".")
 Q VALID
