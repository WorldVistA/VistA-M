IBDEI11K ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQ(358.91)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.91,0,"GL")
 ;;=^IBE(358.91,
 ;;^DIC("B","IMP/EXP MARKING AREA",358.91)
 ;;=
 ;;^DIC(358.91,"%D",0)
 ;;=^^4^4^2940217^
 ;;^DIC(358.91,"%D",1,0)
 ;;= 
 ;;^DIC(358.91,"%D",2,0)
 ;;=This file is nearly identical to file #357.91. It is used by the
 ;;^DIC(358.91,"%D",3,0)
 ;;=Import/Export Utility as a temporary staging area for data from that file
 ;;^DIC(358.91,"%D",4,0)
 ;;=that is being imported or exported.
 ;;^DD(358.91,0)
 ;;=FIELD^^.04^4
 ;;^DD(358.91,0,"DDA")
 ;;=N
 ;;^DD(358.91,0,"DT")
 ;;=2960123
 ;;^DD(358.91,0,"IX","B",358.91,.01)
 ;;=
 ;;^DD(358.91,0,"NM","IMP/EXP MARKING AREA")
 ;;=
 ;;^DD(358.91,0,"PT",358.22,.06)
 ;;=
 ;;^DD(358.91,0,"VRPK")
 ;;=IBD
 ;;^DD(358.91,.01,0)
 ;;=NAME^RFX^^0;1^K:$L(X)>30 X
 ;;^DD(358.91,.01,1,0)
 ;;=^.1
 ;;^DD(358.91,.01,1,1,0)
 ;;=358.91^B
 ;;^DD(358.91,.01,1,1,1)
 ;;=S ^IBE(358.91,"B",$E(X,1,30),DA)=""
 ;;^DD(358.91,.01,1,1,2)
 ;;=K ^IBE(358.91,"B",$E(X,1,30),DA)
 ;;^DD(358.91,.01,3)
 ;;=NAME MUST BE UNDER 31 CHARACTERS
 ;;^DD(358.91,.01,21,0)
 ;;=^^1^1^2930608^
 ;;^DD(358.91,.01,21,1,0)
 ;;=The name should describe the appearance of the marking area on the form.
