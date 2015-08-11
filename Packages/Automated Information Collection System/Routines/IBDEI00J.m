IBDEI00J ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQ(358.2)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.2,0,"GL")
 ;;=^IBE(358.2,
 ;;^DIC("B","IMP/EXP SELECTION LIST",358.2)
 ;;=
 ;;^DIC(358.2,"%D",0)
 ;;=^^1^1^2940829^^^^
 ;;^DIC(358.2,"%D",1,0)
 ;;=Used by the import/export utility as a workspace.
 ;;^DIC(358.2,"%D",2,0)
 ;;= 
 ;;^DIC(358.2,"%D",3,0)
 ;;= 
 ;;^DIC(358.2,"%D",4,0)
 ;;= 
 ;;^DIC(358.2,"%D",5,0)
 ;;= 
 ;;^DIC(358.2,"%D",6,0)
 ;;= 
 ;;^DIC(358.2,"%D",7,0)
 ;;= 
 ;;^DIC(358.2,"%D",8,0)
 ;;=This file is nearly identical to file #357.2 . It is used by the
 ;;^DIC(358.2,"%D",9,0)
 ;;=Import/Export Utility as a temporary staging area for data from that file
 ;;^DIC(358.2,"%D",10,0)
 ;;=that is being imported or exported.
 ;;^DIC(358.2,"%D",11,0)
 ;;=provisions have been made to specify up to 4 columns per list.
 ;;^DD(358.2,0)
 ;;=FIELD^^2^19
 ;;^DD(358.2,0,"DDA")
 ;;=N
 ;;^DD(358.2,0,"DT")
 ;;=2960123
 ;;^DD(358.2,0,"ID",.02)
 ;;=W ""
 ;;^DD(358.2,0,"ID",.11)
 ;;=W ""
 ;;^DD(358.2,0,"IX","B",358.2,.01)
 ;;=
 ;;^DD(358.2,0,"IX","C",358.2,.02)
 ;;=
 ;;^DD(358.2,0,"NM","IMP/EXP SELECTION LIST")
 ;;=
 ;;^DD(358.2,0,"PT",358.3,.03)
 ;;=
 ;;^DD(358.2,0,"PT",358.4,.03)
 ;;=
 ;;^DD(358.2,0,"VRPK")
 ;;=IBD
 ;;^DD(358.2,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(358.2,.01,1,0)
 ;;=^.1
 ;;^DD(358.2,.01,1,1,0)
 ;;=358.2^B
 ;;^DD(358.2,.01,1,1,1)
 ;;=S ^IBE(358.2,"B",$E(X,1,30),DA)=""
 ;;^DD(358.2,.01,1,1,2)
 ;;=K ^IBE(358.2,"B",$E(X,1,30),DA)
 ;;^DD(358.2,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(358.2,.01,21,0)
 ;;=^^2^2^2930527^
 ;;^DD(358.2,.01,21,1,0)
 ;;= 
 ;;^DD(358.2,.01,21,2,0)
 ;;=The name of the list.
 ;;^DD(358.2,.01,"DEL",1,0)
 ;;=I '$G(IBLISTPR) W "...Selection Lists can only be deleted through the Encounter Form Utilities!"
 ;;^DD(358.2,.01,"DT")
 ;;=2921119
