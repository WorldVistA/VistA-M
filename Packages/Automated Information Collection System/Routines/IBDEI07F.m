IBDEI07F ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQ(358.5)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.5,0,"GL")
 ;;=^IBE(358.5,
 ;;^DIC("B","IMP/EXP DATA FIELD",358.5)
 ;;=
 ;;^DIC(358.5,"%D",0)
 ;;=^^1^1^2940829^^^^
 ;;^DIC(358.5,"%D",1,0)
 ;;=Used by the import/export utility as a workspace.
 ;;^DIC(358.5,"%D",2,0)
 ;;= 
 ;;^DIC(358.5,"%D",3,0)
 ;;= 
 ;;^DIC(358.5,"%D",4,0)
 ;;=This file is nearly identical to file #357.5. It is used by the
 ;;^DIC(358.5,"%D",5,0)
 ;;=Import/Export Utility as a temporary staging area for data from that file
 ;;^DIC(358.5,"%D",6,0)
 ;;=that is being imported or exported.
 ;;^DD(358.5,0)
 ;;=FIELD^^2^13
 ;;^DD(358.5,0,"DDA")
 ;;=N
 ;;^DD(358.5,0,"DT")
 ;;=2930730
 ;;^DD(358.5,0,"ID",.02)
 ;;=W ""
 ;;^DD(358.5,0,"ID",.03)
 ;;=W ""
 ;;^DD(358.5,0,"IX","B",358.5,.01)
 ;;=
 ;;^DD(358.5,0,"IX","C",358.5,.02)
 ;;=
 ;;^DD(358.5,0,"NM","IMP/EXP DATA FIELD")
 ;;=
 ;;^DD(358.5,0,"VRPK")
 ;;=IBD
 ;;^DD(358.5,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(358.5,.01,1,0)
 ;;=^.1
 ;;^DD(358.5,.01,1,1,0)
 ;;=358.5^B
 ;;^DD(358.5,.01,1,1,1)
 ;;=S ^IBE(358.5,"B",$E(X,1,30),DA)=""
 ;;^DD(358.5,.01,1,1,2)
 ;;=K ^IBE(358.5,"B",$E(X,1,30),DA)
 ;;^DD(358.5,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(358.5,.01,21,0)
 ;;=^^3^3^2930419^^^
 ;;^DD(358.5,.01,21,1,0)
 ;;= 
 ;;^DD(358.5,.01,21,2,0)
 ;;=The name is used to identify the field within a block. It can be anything
 ;;^DD(358.5,.01,21,3,0)
 ;;=the designer of a form wants it to be.
 ;;^DD(358.5,.01,"DT")
 ;;=2930419
