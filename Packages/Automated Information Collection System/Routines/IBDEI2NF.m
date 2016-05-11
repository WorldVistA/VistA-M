IBDEI2NF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQ(358.99)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.99,0,"GL")
 ;;=^IBE(358.99,
 ;;^DIC("B","IMP/EXP AICS DATA ELEMENTS",358.99)
 ;;=
 ;;^DIC(358.99,"%D",0)
 ;;=^^1^1^2950914^^
 ;;^DIC(358.99,"%D",1,0)
 ;;=Used as a workspace for the import/export utility.
 ;;^DD(358.99,0)
 ;;=FIELD^^10.04^15
 ;;^DD(358.99,0,"DDA")
 ;;=N
 ;;^DD(358.99,0,"DT")
 ;;=2950928
 ;;^DD(358.99,0,"IX","B",358.99,.01)
 ;;=
 ;;^DD(358.99,0,"NM","IMP/EXP AICS DATA ELEMENTS")
 ;;=
 ;;^DD(358.99,0,"PT",357.6,13)
 ;;=
 ;;^DD(358.99,0,"PT",357.613,.01)
 ;;=
 ;;^DD(358.99,0,"PT",358.6,16.2)
 ;;=
 ;;^DD(358.99,0,"PT",358.6,16.6)
 ;;=
 ;;^DD(358.99,0,"PT",358.613,.01)
 ;;=
 ;;^DD(358.99,0,"VRPK")
 ;;=IBD
 ;;^DD(358.99,.01,0)
 ;;=DHCP DATA TYPE^RF^^0;1^K:$L(X)>30!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(358.99,.01,1,0)
 ;;=^.1
 ;;^DD(358.99,.01,1,1,0)
 ;;=358.99^B
 ;;^DD(358.99,.01,1,1,1)
 ;;=S ^IBE(358.99,"B",$E(X,1,30),DA)=""
 ;;^DD(358.99,.01,1,1,2)
 ;;=K ^IBE(358.99,"B",$E(X,1,30),DA)
 ;;^DD(358.99,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(358.99,.01,21,0)
 ;;=^^2^2^2950418^
 ;;^DD(358.99,.01,21,1,0)
 ;;=A type of data that is recognized as such within the framework of scanning
 ;;^DD(358.99,.01,21,2,0)
 ;;=DHCP forms and which requires its own Paper Keyboard description.
 ;;^DD(358.99,.01,"DT")
 ;;=2950418
