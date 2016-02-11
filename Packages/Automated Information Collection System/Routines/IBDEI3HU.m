IBDEI3HU ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQ(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.4,0,"GL")
 ;;=^IBE(358.4,
 ;;^DIC("B","IMP/EXP SELECTION GROUP",358.4)
 ;;=
 ;;^DIC(358.4,"%D",0)
 ;;=^^4^4^2940217^
 ;;^DIC(358.4,"%D",1,0)
 ;;= 
 ;;^DIC(358.4,"%D",2,0)
 ;;=This file is nearly identical to file #357.4. It is used by the
 ;;^DIC(358.4,"%D",3,0)
 ;;=Import/Export Utility as a temporary staging area for data from that file
 ;;^DIC(358.4,"%D",4,0)
 ;;=that is being imported or exported.
 ;;^DD(358.4,0)
 ;;=FIELD^^.04^4
 ;;^DD(358.4,0,"DDA")
 ;;=N
 ;;^DD(358.4,0,"DT")
 ;;=2950717
 ;;^DD(358.4,0,"ID",.02)
 ;;=W "   ",$P(^(0),U,2)
 ;;^DD(358.4,0,"ID",.03)
 ;;=S %I=Y,Y=$S('$D(^(0)):"",$D(^IBE(358.2,+$P(^(0),U,3),0))#2:$P(^(0),U,1),1:""),C=$P(^DD(358.2,.01,0),U,2) D Y^DIQ:Y]"" W "   ",Y,@("$E("_DIC_"%I,0),0)") S Y=%I K %I
 ;;^DD(358.4,0,"IX","APO",358.4,.02)
 ;;=
 ;;^DD(358.4,0,"IX","APO1",358.4,.03)
 ;;=
 ;;^DD(358.4,0,"IX","B",358.4,.01)
 ;;=
 ;;^DD(358.4,0,"IX","D",358.4,.03)
 ;;=
 ;;^DD(358.4,0,"NM","IMP/EXP SELECTION GROUP")
 ;;=
 ;;^DD(358.4,0,"PT",358.3,.04)
 ;;=
 ;;^DD(358.4,0,"VRPK")
 ;;=IBD
 ;;^DD(358.4,.01,0)
 ;;=HEADER^RF^^0;1^K:$L(X)>40!($L(X)<1) X
 ;;^DD(358.4,.01,1,0)
 ;;=^.1
 ;;^DD(358.4,.01,1,1,0)
 ;;=358.4^B
 ;;^DD(358.4,.01,1,1,1)
 ;;=S ^IBE(358.4,"B",$E(X,1,30),DA)=""
 ;;^DD(358.4,.01,1,1,2)
 ;;=K ^IBE(358.4,"B",$E(X,1,30),DA)
 ;;^DD(358.4,.01,3)
 ;;=What text do you want to appear at the top of this group?
 ;;^DD(358.4,.01,21,0)
 ;;=^^2^2^2930604^^^^
 ;;^DD(358.4,.01,21,1,0)
 ;;= 
 ;;^DD(358.4,.01,21,2,0)
 ;;=The name given to a group of selections appearing on a selection list.
 ;;^DD(358.4,.01,"DEL",1,0)
 ;;=I '$G(IBLISTPR) W "...Selection Groups can only be deleted through the Encounter Form Utilities!"
 ;;^DD(358.4,.01,"DT")
 ;;=2930604
