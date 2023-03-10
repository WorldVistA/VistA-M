XPARDD2 ; SLC/KCM - DD Logic for Parameter Template (8989.52)
 ;;7.3;TOOLKIT;**26,149**;Apr 25, 1995;Build 1
 ;
VALID01 ; -- Input transform for NAME (8989.52,.01), prevent duplicate names
 ; ( Need to figure out how to check for duplicates and have verify
 ;   fields still work ) Same logic as in XPARDD1
 I $L(X)>30!($L(X)<3)!'(X'?1P.E) K X Q  ; Length 3-30
 I X'?1U1UN.E K X Q                        ; Must begin with namespace ;p149
 I $D(^XTV(8989.52,"B",X)) D  Q         ; No duplicates
 . K X D EN^DDIOL("Duplicate template names not allowed.")
 Q
