IBDEI08K ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQ(358.94)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.94,0,"GL")
 ;;=^IBE(358.94,
 ;;^DIC("B","IMP/EXP HAND PRINT FIELD",358.94)
 ;;=
 ;;^DIC(358.94,"%D",0)
 ;;=^^1^1^2950927^^
 ;;^DIC(358.94,"%D",1,0)
 ;;=Used by the Import/Export utility as a workspace.
 ;;^DD(358.94,0)
 ;;=FIELD^^.1^8
 ;;^DD(358.94,0,"DT")
 ;;=2950728
 ;;^DD(358.94,0,"IX","B",358.94,.01)
 ;;=
 ;;^DD(358.94,0,"IX","C",358.94,.08)
 ;;=
 ;;^DD(358.94,0,"NM","IMP/EXP HAND PRINT FIELD")
 ;;=
 ;;^DD(358.94,0,"VRPK")
 ;;=AUTOMATED INFO COLLECTION SYS
 ;;^DD(358.94,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(358.94,.01,1,0)
 ;;=^.1
 ;;^DD(358.94,.01,1,1,0)
 ;;=358.94^B
 ;;^DD(358.94,.01,1,1,1)
 ;;=S ^IBE(358.94,"B",$E(X,1,30),DA)=""
 ;;^DD(358.94,.01,1,1,2)
 ;;=K ^IBE(358.94,"B",$E(X,1,30),DA)
 ;;^DD(358.94,.01,3)
 ;;=NAME MUST BE 3-30 CHARACTERS, NOT NUMERIC OR STARTING WITH PUNCTUATION
 ;;^DD(358.94,.01,21,0)
 ;;=^^3^3^2950725^
 ;;^DD(358.94,.01,21,1,0)
 ;;= 
 ;;^DD(358.94,.01,21,2,0)
 ;;= 
 ;;^DD(358.94,.01,21,3,0)
 ;;=The name of the field. 
 ;;^DD(358.94,.01,"DT")
 ;;=2930518
