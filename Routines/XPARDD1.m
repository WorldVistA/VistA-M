XPARDD1 ; SLC/KCM - DD Logic for Parameter Definition (8989.51);03:31 PM  22 Apr 1998 ;12/19/07  15:56
 ;;7.3;TOOLKIT;**26,110**;Apr 25, 1995;Build 11
 ;
ALLOW(FN) ; Screens allowable entities to variable ptrs in 8989.5,.01
 ; ** VPDD ** see which files 8989.5 can point to
 Q:'FN 0
 Q $D(^DD(8989.5,.01,"V","B",FN))>0
 ;
VALID01 ; -- Input transform for NAME (8989.51,.01), prevent duplicate names
 ; ( Need to figure out how to check for duplicates and have verify
 ;   fields still work )
 I $L(X)>30!($L(X)<3)!'(X'?1P.E) K X Q  ; Length 3-30
 I X'?1U1UN.E K X Q                     ; Must begin with namespace ;p110
 I $D(^XTV(8989.51,"B",X)) D  Q         ; No duplicates
 . K X D EN^DDIOL("Duplicate parameter names not allowed.")
 Q
AG ; -- AG cross reference, called from 8989.513,.01
 ;
 ; ^XTV(8989.51,PARAMETER,30,"AG",GLOBAL REFERENCE,DA)=""
 ;
 ; GLOBAL REFERENCE is the variable pointer reference to the file
 ; PARAMETER is the internal entry number of the parameter
 ;
AGS ; Set the AG cross-reference for the PARAMETER DEFINITION file
 N GREF
 D FILE^DID(X,"","GLOBAL NAME","GREF")
 S GREF=$P($G(GREF("GLOBAL NAME")),"^",2)
 I $L(GREF) S ^XTV(8989.51,DA(1),30,"AG",GREF,DA)=""
 Q
AGK ; Kill the AG cross-referenece for the PARAMETER DEFINITION file
 N GREF
 D FILE^DID(X,"","GLOBAL NAME","GREF")
 S GREF=$P($G(GREF("GLOBAL NAME")),"^",2)
 I $L(GREF) K ^XTV(8989.51,DA(1),30,"AG",GREF,DA)
 Q
UPPER(X) ; function used by "C" x-ref in .02 field
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
