XPDIN00E ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.7)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.716,1,0)
 ;;=COMPLETED TIME^D^^0;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.716,1,21,0)
 ;;=^^1^1^2940503^^
 ;;^DD(9.716,1,21,1,0)
 ;;=This is the time the check point was completed.
 ;;^DD(9.716,1,"DT")
 ;;=2931118
 ;;^DD(9.716,2,0)
 ;;=CALLBACK^FX^^1;E1,245^K:$L(X)>60!($L(X)<2)!'(X?.1UP.7UN.E) X
 ;;^DD(9.716,2,3)
 ;;=Enter a [TAG^]ROUTINE
 ;;^DD(9.716,2,21,0)
 ;;=^^2^2^2940710^^
 ;;^DD(9.716,2,21,1,0)
 ;;=This is a routine that will be run if this Check Point didn't complete
 ;;^DD(9.716,2,21,2,0)
 ;;=and the install process had to be restarted.
 ;;^DD(9.716,2,"DT")
 ;;=2940710
 ;;^DD(9.716,3,0)
 ;;=PARAMETERS^F^^2;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(9.716,3,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(9.716,3,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.716,3,21,1,0)
 ;;=This is optional parameters that may be need during a restart.
 ;;^DD(9.716,3,"DT")
 ;;=2940503
 ;;^DD(9.718,0)
 ;;=GLOBALS SUB-FIELD^^1^2
 ;;^DD(9.718,0,"DT")
 ;;=2950109
 ;;^DD(9.718,0,"IX","B",9.718,.01)
 ;;=
 ;;^DD(9.718,0,"NM","GLOBALS")
 ;;=
 ;;^DD(9.718,0,"UP")
 ;;=9.7
 ;;^DD(9.718,.01,0)
 ;;=GLOBALS^MF^^0;1^K:$L(X)>30!($L(X)<2) X
 ;;^DD(9.718,.01,1,0)
 ;;=^.1
 ;;^DD(9.718,.01,1,1,0)
 ;;=9.718^B
 ;;^DD(9.718,.01,1,1,1)
 ;;=S ^XPD(9.7,DA(1),"GLO","B",$E(X,1,30),DA)=""
 ;;^DD(9.718,.01,1,1,2)
 ;;=K ^XPD(9.7,DA(1),"GLO","B",$E(X,1,30),DA)
 ;;^DD(9.718,.01,3)
 ;;=Answer must be 2-30 characters in length.
 ;;^DD(9.718,.01,21,0)
 ;;=^^2^2^2950109^^
 ;;^DD(9.718,.01,21,1,0)
 ;;=The name of a Global or Global root that was installed by this
 ;;^DD(9.718,.01,21,2,0)
 ;;=package.
 ;;^DD(9.718,.01,"DT")
 ;;=2950109
 ;;^DD(9.718,1,0)
 ;;=COMPLETED TIME^D^^0;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.718,1,21,0)
 ;;=^^1^1^2950109^
 ;;^DD(9.718,1,21,1,0)
 ;;=This is the time the Global was installed.
 ;;^DD(9.718,1,"DT")
 ;;=2950109
