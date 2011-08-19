XPDIN008 ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.66,0,"IX","B",9.66,.01)
 ;;=
 ;;^DD(9.66,0,"NM","PACKAGE NAMESPACE OR PREFIX")
 ;;=
 ;;^DD(9.66,0,"UP")
 ;;=9.6
 ;;^DD(9.66,.01,0)
 ;;=PACKAGE NAMESPACE OR PREFIX^MF^^0;1^K:$L(X)>4!($L(X)<2) X
 ;;^DD(9.66,.01,1,0)
 ;;=^.1
 ;;^DD(9.66,.01,1,1,0)
 ;;=9.66^B
 ;;^DD(9.66,.01,1,1,1)
 ;;=S ^XPD(9.6,DA(1),"ABNS","B",$E(X,1,30),DA)=""
 ;;^DD(9.66,.01,1,1,2)
 ;;=K ^XPD(9.6,DA(1),"ABNS","B",$E(X,1,30),DA)
 ;;^DD(9.66,.01,3)
 ;;=This is (one of) the 2 to 4 character namespaces or prefixes associated with the test package
 ;;^DD(9.66,.01,21,0)
 ;;=^^1^1^2940307^
 ;;^DD(9.66,.01,21,1,0)
 ;;=This field identifies on of the alpha/beta package namespaces.
 ;;^DD(9.66,.01,"DT")
 ;;=2940307
 ;;^DD(9.66,1,0)
 ;;=EXCLUDE NAMESPACE OR PREFIX^9.661A^^1;0
 ;;^DD(9.66,1,21,0)
 ;;=^^5^5^2940502^^^
 ;;^DD(9.66,1,21,1,0)
 ;;=This multiple field is used to indicate any specific namespaces
 ;;^DD(9.66,1,21,2,0)
 ;;=or prefixes which begin with the current namespace or prefix
 ;;^DD(9.66,1,21,3,0)
 ;;=which should be excluded from analyses for the alpha/beta
 ;;^DD(9.66,1,21,4,0)
 ;;=package.  Generally those namespaces which are immediately
 ;;^DD(9.66,1,21,5,0)
 ;;=followed by the letter 'Z' are excluded.
 ;;^DD(9.661,0)
 ;;=EXCLUDE NAMESPACE OR PREFIX SUB-FIELD^^.01^1
 ;;^DD(9.661,0,"DT")
 ;;=2940307
 ;;^DD(9.661,0,"IX","B",9.661,.01)
 ;;=
 ;;^DD(9.661,0,"NM","EXCLUDE NAMESPACE OR PREFIX")
 ;;=
 ;;^DD(9.661,0,"UP")
 ;;=9.66
 ;;^DD(9.661,.01,0)
 ;;=EXCLUDE NAMESPACE OR PREFIX^MF^^0;1^K:$L(X)>4!($L(X)<2) X
 ;;^DD(9.661,.01,1,0)
 ;;=^.1
 ;;^DD(9.661,.01,1,1,0)
 ;;=9.661^B
 ;;^DD(9.661,.01,1,1,1)
 ;;=S ^XPD(9.6,DA(2),"ABNS",DA(1),1,"B",$E(X,1,30),DA)=""
 ;;^DD(9.661,.01,1,1,2)
 ;;=K ^XPD(9.6,DA(2),"ABNS",DA(1),1,"B",$E(X,1,30),DA)
 ;;^DD(9.661,.01,3)
 ;;=Answer must be 2-4 characters in length.
 ;;^DD(9.661,.01,21,0)
 ;;=^^4^4^2940307^
 ;;^DD(9.661,.01,21,1,0)
 ;;=This is a specific namespace or prefix which would normally be
 ;;^DD(9.661,.01,21,2,0)
 ;;=included as a part of the alpha/beta package based on the
 ;;^DD(9.661,.01,21,3,0)
 ;;=prefix specified for the package, but is be excluded from
 ;;^DD(9.661,.01,21,4,0)
 ;;=consideration as part of the alpha/beta package. 
 ;;^DD(9.661,.01,"DT")
 ;;=2940307
 ;;^DD(9.67,0)
 ;;=BUILD COMPONENTS SUB-FIELD^^10^2
 ;;^DD(9.67,0,"DT")
 ;;=2950330
 ;;^DD(9.67,0,"IX","B",9.67,.01)
 ;;=
 ;;^DD(9.67,0,"NM","BUILD COMPONENTS")
 ;;=
 ;;^DD(9.67,0,"UP")
 ;;=9.6
 ;;^DD(9.67,.01,0)
 ;;=BUILD COMPONENT^MP1'XI^DIC(^0;1^S DINUM=+X K:'$G(XPDNEWF) X,DINUM
 ;;^DD(9.67,.01,1,0)
 ;;=^.1
 ;;^DD(9.67,.01,1,1,0)
 ;;=9.67^B
 ;;^DD(9.67,.01,1,1,1)
 ;;=S ^XPD(9.6,DA(1),"KRN","B",$E(X,1,30),DA)=""
 ;;^DD(9.67,.01,1,1,2)
 ;;=K ^XPD(9.6,DA(1),"KRN","B",$E(X,1,30),DA)
 ;;^DD(9.67,.01,21,0)
 ;;=^^2^2^2940414^
 ;;^DD(9.67,.01,21,1,0)
 ;;=The name of a VA Fileman file that will be used as a component
 ;;^DD(9.67,.01,21,2,0)
 ;;=of a package.
 ;;^DD(9.67,.01,"DT")
 ;;=2940815
 ;;^DD(9.67,10,0)
 ;;=ENTRIES^9.68A^^NM;0
 ;;^DD(9.67,10,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.67,10,21,1,0)
 ;;=This multiple is a list of each record that is being sent for a component.
 ;;^DD(9.68,0)
 ;;=ENTRIES SUB-FIELD^^.04^4
 ;;^DD(9.68,0,"DT")
 ;;=2950330
 ;;^DD(9.68,0,"IX","B",9.68,.01)
 ;;=
 ;;^DD(9.68,0,"NM","ENTRIES")
 ;;=
 ;;^DD(9.68,0,"UP")
 ;;=9.67
 ;;^DD(9.68,.01,0)
 ;;=ENTRIES^MFX^^0;1^K:$L(X)>45!($L(X)<2) X I $D(X) D INPUTE^XPDET(.X)
 ;;^DD(9.68,.01,1,0)
 ;;=^.1
 ;;^DD(9.68,.01,1,1,0)
 ;;=9.68^B
 ;;^DD(9.68,.01,1,1,1)
 ;;=S ^XPD(9.6,DA(2),"KRN",DA(1),"NM","B",X,DA)=""
 ;;^DD(9.68,.01,1,1,2)
 ;;=K ^XPD(9.6,DA(2),"KRN",DA(1),"NM","B",X,DA)
 ;;^DD(9.68,.01,1,2,0)
 ;;=^^TRIGGER^9.68^.02
 ;;^DD(9.68,.01,1,2,1)
 ;;=X ^DD(9.68,.01,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^XPD(9.6,D0,"KRN",D1,"NM",D2,0)):^(0),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y X ^DD(9.68,.01,1,2,1.1) X ^DD(9.68,.01,1,2,1.4)
 ;;^DD(9.68,.01,1,2,1.1)
 ;;=S X=DIV S X=DIV,Y(1)=X S X="    FILE #",Y(2)=X S X=2,X=$P(Y(1),Y(2),X)
 ;;^DD(9.68,.01,1,2,1.3)
 ;;=K DIV S DIV=X,D0=DA(2),DIV(0)=D0,D1=DA(1),DIV(1)=D1,D2=DA,DIV(2)=D2 S Y(0)=X S Y(1)=$S($D(^XPD(9.6,D0,"KRN",D1,0)):^(0),1:"") S X=$P(Y(1),U,1),X=X S X=X<.44
 ;;^DD(9.68,.01,1,2,1.4)
 ;;=S DIH=$S($D(^XPD(9.6,DIV(0),"KRN",DIV(1),"NM",DIV(2),0)):^(0),1:""),DIV=X S $P(^(0),U,2)=DIV,DIH=9.68,DIG=.02 D ^DICR:$O(^DD(DIH,DIG,1,0))>0
 ;;^DD(9.68,.01,1,2,2)
 ;;=Q
 ;;^DD(9.68,.01,1,2,"%D",0)
 ;;=^^2^2^2950117^
 ;;^DD(9.68,.01,1,2,"%D",1,0)
 ;;=This trigger updates the FILE field, #.02, with the appropriate file number
 ;;^DD(9.68,.01,1,2,"%D",2,0)
 ;;=for this template. It is only triggered for Fileman template components.
 ;;^DD(9.68,.01,1,2,"CREATE CONDITION")
 ;;=INTERNAL(KERNEL FILES)<.44
