IBDEI2N5 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQ(358.8)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.8,0,"GL")
 ;;=^IBE(358.8,
 ;;^DIC("B","IMP/EXP TEXT AREA",358.8)
 ;;=
 ;;^DIC(358.8,"%D",0)
 ;;=^^3^3^2940217^
 ;;^DIC(358.8,"%D",1,0)
 ;;=This file is nearly identical to file #357.8. It is used by the
 ;;^DIC(358.8,"%D",2,0)
 ;;=Import/Export Utility as a temporary staging area for data from that file
 ;;^DIC(358.8,"%D",3,0)
 ;;=that is being imported or exported.
 ;;^DD(358.8,0)
 ;;=FIELD^^1^7
 ;;^DD(358.8,0,"DDA")
 ;;=N
 ;;^DD(358.8,0,"DT")
 ;;=2930802
 ;;^DD(358.8,0,"IX","B",358.8,.01)
 ;;=
 ;;^DD(358.8,0,"IX","C",358.8,.02)
 ;;=
 ;;^DD(358.8,0,"NM","IMP/EXP TEXT AREA")
 ;;=
 ;;^DD(358.8,0,"VRPK")
 ;;=IBD
 ;;^DD(358.8,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(358.8,.01,1,0)
 ;;=^.1
 ;;^DD(358.8,.01,1,1,0)
 ;;=358.8^B
 ;;^DD(358.8,.01,1,1,1)
 ;;=S ^IBE(358.8,"B",$E(X,1,30),DA)=""
 ;;^DD(358.8,.01,1,1,2)
 ;;=K ^IBE(358.8,"B",$E(X,1,30),DA)
 ;;^DD(358.8,.01,3)
 ;;=NAME MUST BE 3-30 CHARACTERS, NOT NUMERIC OR STARTING WITH PUNCTUATION
 ;;^DD(358.8,.01,21,0)
 ;;=^^2^2^2930528^
 ;;^DD(358.8,.01,21,1,0)
 ;;= 
 ;;^DD(358.8,.01,21,2,0)
 ;;=The name of the text area.
