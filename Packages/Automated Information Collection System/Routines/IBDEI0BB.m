IBDEI0BB ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQ(358.93)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.93,0,"GL")
 ;;=^IBE(358.93,
 ;;^DIC("B","IMP/EXP MULTIPLE CHOICE FIELD",358.93)
 ;;=
 ;;^DIC(358.93,"%D",0)
 ;;=^^2^2^2951024^^^
 ;;^DIC(358.93,"%D",1,0)
 ;;=This file is used as a work space for the import/export utility of the
 ;;^DIC(358.93,"%D",2,0)
 ;;=encounter form utilities.
 ;;^DD(358.93,0)
 ;;=FIELD^^1^9
 ;;^DD(358.93,0,"DDA")
 ;;=N
 ;;^DD(358.93,0,"DT")
 ;;=2960119
 ;;^DD(358.93,0,"IX","A",358.931,.01)
 ;;=
 ;;^DD(358.93,0,"IX","A1",358.931,.02)
 ;;=
 ;;^DD(358.93,0,"IX","B",358.93,.01)
 ;;=
 ;;^DD(358.93,0,"IX","C",358.93,.08)
 ;;=
 ;;^DD(358.93,0,"NM","IMP/EXP MULTIPLE CHOICE FIELD")
 ;;=
 ;;^DD(358.93,0,"VRPK")
 ;;=IBD
 ;;^DD(358.93,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(358.93,.01,1,0)
 ;;=^.1
 ;;^DD(358.93,.01,1,1,0)
 ;;=358.93^B
 ;;^DD(358.93,.01,1,1,1)
 ;;=S ^IBE(358.93,"B",$E(X,1,30),DA)=""
 ;;^DD(358.93,.01,1,1,2)
 ;;=K ^IBE(358.93,"B",$E(X,1,30),DA)
 ;;^DD(358.93,.01,3)
 ;;=NAME MUST BE 3-30 CHARACTERS, NOT NUMERIC OR STARTING WITH PUNCTUATION
 ;;^DD(358.93,.01,21,0)
 ;;=^^2^2^2930623^^^^
 ;;^DD(358.93,.01,21,1,0)
 ;;= 
 ;;^DD(358.93,.01,21,2,0)
 ;;=The division the setup is for.
 ;;^DD(358.93,.01,"DT")
 ;;=2930518
