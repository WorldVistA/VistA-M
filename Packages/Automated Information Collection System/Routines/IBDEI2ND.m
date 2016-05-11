IBDEI2ND ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQ(358.98)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.98,0,"GL")
 ;;=^IBD(358.98,
 ;;^DIC("B","IMP/EXP AICS DATA QUALIFIERS",358.98)
 ;;=
 ;;^DIC(358.98,"%D",0)
 ;;=^^1^1^2950927^^^
 ;;^DIC(358.98,"%D",1,0)
 ;;=Used by the import/export utility of the encounter forms as a workspace.
 ;;^DD(358.98,0)
 ;;=FIELD^^.03^3
 ;;^DD(358.98,0,"DDA")
 ;;=N
 ;;^DD(358.98,0,"DT")
 ;;=2950717
 ;;^DD(358.98,0,"ID",.02)
 ;;=W "   ",$P(^(0),U,2)
 ;;^DD(358.98,0,"IX","B",358.98,.01)
 ;;=
 ;;^DD(358.98,0,"NM","IMP/EXP AICS DATA QUALIFIERS")
 ;;=
 ;;^DD(358.98,0,"PT",358.22,.09)
 ;;=
 ;;^DD(358.98,0,"PT",358.613,.01)
 ;;=
 ;;^DD(358.98,0,"PT",358.931,.09)
 ;;=
 ;;^DD(358.98,0,"VRPK")
 ;;=IBD
 ;;^DD(358.98,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(358.98,.01,1,0)
 ;;=^.1
 ;;^DD(358.98,.01,1,1,0)
 ;;=358.98^B
 ;;^DD(358.98,.01,1,1,1)
 ;;=S ^IBD(358.98,"B",$E(X,1,30),DA)=""
 ;;^DD(358.98,.01,1,1,2)
 ;;=K ^IBD(358.98,"B",$E(X,1,30),DA)
 ;;^DD(358.98,.01,3)
 ;;=NAME MUST BE 3-30 CHARACTERS, NOT NUMERIC OR STARTING WITH PUNCTUATION
