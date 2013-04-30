IBDEI00I ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQ(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.3,0,"GL")
 ;;=^IBE(358.3,
 ;;^DIC("B","IMP/EXP SELECTION",358.3)
 ;;=
 ;;^DIC(358.3,"%D",0)
 ;;=^^4^4^2940217^
 ;;^DIC(358.3,"%D",1,0)
 ;;= 
 ;;^DIC(358.3,"%D",2,0)
 ;;=This file is nearly identical to file #357.3. It is used by the
 ;;^DIC(358.3,"%D",3,0)
 ;;=Import/Export Utility as a temporary staging area for data from that file
 ;;^DIC(358.3,"%D",4,0)
 ;;=that is being imported or exported.
 ;;^DD(358.3,0)
 ;;=FIELD^^3^15
 ;;^DD(358.3,0,"DDA")
 ;;=N
 ;;^DD(358.3,0,"DT")
 ;;=2961031
 ;;^DD(358.3,0,"ID",.03)
 ;;=S %I=Y,Y=$S('$D(^(0)):"",$D(^IBE(358.2,+$P(^(0),U,3),0))#2:$P(^(0),U,1),1:""),C=$P(^DD(358.2,.01,0),U,2) D Y^DIQ:Y]"" W "   ",Y,@("$E("_DIC_"%I,0),0)") S Y=%I K %I
 ;;^DD(358.3,0,"ID",.04)
 ;;=S %I=Y,Y=$S('$D(^(0)):"",$D(^IBE(358.4,+$P(^(0),U,4),0))#2:$P(^(0),U,1),1:""),C=$P(^DD(358.4,.01,0),U,2) D Y^DIQ:Y]"" W "   ",Y,@("$E("_DIC_"%I,0),0)") S Y=%I K %I
 ;;^DD(358.3,0,"IX","APO",358.3,.03)
 ;;=
 ;;^DD(358.3,0,"IX","APO1",358.3,.04)
 ;;=
 ;;^DD(358.3,0,"IX","APO2",358.3,.05)
 ;;=
 ;;^DD(358.3,0,"IX","B",358.3,.01)
 ;;=
 ;;^DD(358.3,0,"IX","C",358.3,.03)
 ;;=
 ;;^DD(358.3,0,"IX","D",358.3,.04)
 ;;=
 ;;^DD(358.3,0,"NM","IMP/EXP SELECTION")
 ;;=
 ;;^DD(358.3,0,"VRPK")
 ;;=IBD
 ;;^DD(358.3,.01,0)
 ;;=SELECTION ID^RF^^0;1^K:$L(X)>30!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(358.3,.01,1,0)
 ;;=^.1
 ;;^DD(358.3,.01,1,1,0)
 ;;=358.3^B
 ;;^DD(358.3,.01,1,1,1)
 ;;=S ^IBE(358.3,"B",$E(X,1,30),DA)=""
 ;;^DD(358.3,.01,1,1,2)
 ;;=K ^IBE(358.3,"B",$E(X,1,30),DA)
 ;;^DD(358.3,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(358.3,.01,21,0)
 ;;=^^2^2^2930309^
 ;;^DD(358.3,.01,21,1,0)
 ;;= 
 ;;^DD(358.3,.01,21,2,0)
 ;;=The ID passed by the package.
 ;;^DD(358.3,.01,"DT")
 ;;=2921119
