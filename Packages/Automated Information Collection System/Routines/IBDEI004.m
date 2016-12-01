IBDEI004 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQ(358.1)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.1,0,"GL")
 ;;=^IBE(358.1,
 ;;^DIC("B","IMP/EXP ENCOUNTER FORM BLOCK",358.1)
 ;;=
 ;;^DIC(358.1,"%",0)
 ;;=^1.005^^0
 ;;^DIC(358.1,"%D",0)
 ;;=^^4^4^2940217^
 ;;^DIC(358.1,"%D",1,0)
 ;;= 
 ;;^DIC(358.1,"%D",2,0)
 ;;=This file is nearly identical to file #357.1. It is used by the
 ;;^DIC(358.1,"%D",3,0)
 ;;=Import/Export Utility as a temporary staging area for data from that file
 ;;^DIC(358.1,"%D",4,0)
 ;;=that is being imported or exported.
 ;;^DD(358.1,0)
 ;;=FIELD^^1^12
 ;;^DD(358.1,0,"DDA")
 ;;=N
 ;;^DD(358.1,0,"DT")
 ;;=2930806
 ;;^DD(358.1,0,"ID",.02)
 ;;=W ""
 ;;^DD(358.1,0,"IX","B",358.1,.01)
 ;;=
 ;;^DD(358.1,0,"IX","C",358.1,.02)
 ;;=
 ;;^DD(358.1,0,"IX","D",358.1,.14)
 ;;=
 ;;^DD(358.1,0,"NM","IMP/EXP ENCOUNTER FORM BLOCK")
 ;;=
 ;;^DD(358.1,0,"PT",358.2,.02)
 ;;=
 ;;^DD(358.1,0,"PT",358.5,.02)
 ;;=
 ;;^DD(358.1,0,"PT",358.7,.06)
 ;;=
 ;;^DD(358.1,0,"PT",358.8,.02)
 ;;=
 ;;^DD(358.1,0,"PT",358.93,.08)
 ;;=
 ;;^DD(358.1,0,"VRPK")
 ;;=IBD
 ;;^DD(358.1,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(358.1,.01,1,0)
 ;;=^.1
 ;;^DD(358.1,.01,1,1,0)
 ;;=358.1^B
 ;;^DD(358.1,.01,1,1,1)
 ;;=S ^IBE(358.1,"B",$E(X,1,30),DA)=""
 ;;^DD(358.1,.01,1,1,2)
 ;;=K ^IBE(358.1,"B",$E(X,1,30),DA)
 ;;^DD(358.1,.01,3)
 ;;=NAME MUST BE 3-30 CHARACTERS, NOT NUMERIC OR STARTING WITH PUNCTUATION
 ;;^DD(358.1,.01,21,0)
 ;;=^^2^2^2930527^
 ;;^DD(358.1,.01,21,1,0)
 ;;= 
 ;;^DD(358.1,.01,21,2,0)
 ;;=The name of the block.
 ;;^DD(358.1,.01,"DEL",1,0)
 ;;=I '$G(IBLISTPR) W "...Encounter Form Blocks can only be deleted through the Encounter Form Utilities!"
