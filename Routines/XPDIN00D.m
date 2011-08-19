XPDIN00D ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.7)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.713,1,0)
 ;;=COMPLETED TIME^D^^0;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.713,1,21,0)
 ;;=^^1^1^2940415^
 ;;^DD(9.713,1,21,1,0)
 ;;=This is the time the check point was completed.
 ;;^DD(9.713,1,"DT")
 ;;=2931118
 ;;^DD(9.713,2,0)
 ;;=CALLBACK^FX^^1;E1,245^K:$L(X)>60!($L(X)<2)!'(X?.1UP.7UN.E) X
 ;;^DD(9.713,2,3)
 ;;=Enter a [TAG^]ROUTINE
 ;;^DD(9.713,2,21,0)
 ;;=^^2^2^2940710^^^
 ;;^DD(9.713,2,21,1,0)
 ;;=This is a routine that will be run if this Check Point didn't complete
 ;;^DD(9.713,2,21,2,0)
 ;;=and the install process had to be restarted.
 ;;^DD(9.713,2,"DT")
 ;;=2940710
 ;;^DD(9.713,3,0)
 ;;=PARAMETERS^F^^2;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(9.713,3,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(9.713,3,21,0)
 ;;=^^1^1^2940503^^
 ;;^DD(9.713,3,21,1,0)
 ;;=This is optional parameters that may be need during a restart.
 ;;^DD(9.713,3,"DT")
 ;;=2940503
 ;;^DD(9.714,0)
 ;;=FILE SUB-FIELD^^2^3
 ;;^DD(9.714,0,"DT")
 ;;=2931118
 ;;^DD(9.714,0,"IX","B",9.714,.01)
 ;;=
 ;;^DD(9.714,0,"NM","FILE")
 ;;=
 ;;^DD(9.714,0,"UP")
 ;;=9.7
 ;;^DD(9.714,.01,0)
 ;;=FILE^MP1'X^DIC(^0;1^S DINUM=+X
 ;;^DD(9.714,.01,1,0)
 ;;=^.1
 ;;^DD(9.714,.01,1,1,0)
 ;;=9.714^B
 ;;^DD(9.714,.01,1,1,1)
 ;;=S ^XPD(9.7,DA(1),4,"B",$E(X,1,30),DA)=""
 ;;^DD(9.714,.01,1,1,2)
 ;;=K ^XPD(9.7,DA(1),4,"B",$E(X,1,30),DA)
 ;;^DD(9.714,.01,21,0)
 ;;=^^1^1^2940415^
 ;;^DD(9.714,.01,21,1,0)
 ;;=VA Fileman file that was installed by this package.
 ;;^DD(9.714,.01,"DT")
 ;;=2940215
 ;;^DD(9.714,1,0)
 ;;=DATA DICTIONARY TIME^D^^0;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.714,1,21,0)
 ;;=^^1^1^2940503^^
 ;;^DD(9.714,1,21,1,0)
 ;;=The time the Data Dictionary was installed at this site.
 ;;^DD(9.714,1,"DT")
 ;;=2931118
 ;;^DD(9.714,2,0)
 ;;=DATA TIME^D^^0;3^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.714,2,3)
 ;;=
 ;;^DD(9.714,2,21,0)
 ;;=^^1^1^2940503^^
 ;;^DD(9.714,2,21,1,0)
 ;;=The time the Data was installed at this site.
 ;;^DD(9.714,2,"DT")
 ;;=2931118
 ;;^DD(9.715,0)
 ;;=BUILD COMPONENTS SUB-FIELD^^2^3
 ;;^DD(9.715,0,"DT")
 ;;=2941212
 ;;^DD(9.715,0,"IX","AC",9.715,2)
 ;;=
 ;;^DD(9.715,0,"IX","B",9.715,.01)
 ;;=
 ;;^DD(9.715,0,"NM","BUILD COMPONENTS")
 ;;=
 ;;^DD(9.715,0,"UP")
 ;;=9.7
 ;;^DD(9.715,.01,0)
 ;;=BUILD COMPONENT^MP1'X^DIC(^0;1^S DINUM=+X
 ;;^DD(9.715,.01,1,0)
 ;;=^.1
 ;;^DD(9.715,.01,1,1,0)
 ;;=9.715^B
 ;;^DD(9.715,.01,1,1,1)
 ;;=S ^XPD(9.7,DA(1),"KRN","B",$E(X,1,30),DA)=""
 ;;^DD(9.715,.01,1,1,2)
 ;;=K ^XPD(9.7,DA(1),"KRN","B",$E(X,1,30),DA)
 ;;^DD(9.715,.01,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.715,.01,21,1,0)
 ;;=The name of a VA Fileman file that is a component of this package.
 ;;^DD(9.715,.01,"DT")
 ;;=2940525
 ;;^DD(9.715,1,0)
 ;;=DATA TIME^D^^0;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.715,1,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.715,1,21,1,0)
 ;;=This is the time the package component was installed.
 ;;^DD(9.715,1,"DT")
 ;;=2931118
 ;;^DD(9.715,2,0)
 ;;=INSTALL ORDER^NJ2,0^^0;3^K:+X'=X!(X>99)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(9.715,2,1,0)
 ;;=^.1
 ;;^DD(9.715,2,1,1,0)
 ;;=9.715^AC
 ;;^DD(9.715,2,1,1,1)
 ;;=S ^XPD(9.7,DA(1),"KRN","AC",$E(X,1,30),DA)=""
 ;;^DD(9.715,2,1,1,2)
 ;;=K ^XPD(9.7,DA(1),"KRN","AC",$E(X,1,30),DA)
 ;;^DD(9.715,2,1,1,"%D",0)
 ;;=^^2^2^2950103^
 ;;^DD(9.715,2,1,1,"%D",1,0)
 ;;=This x-ref is used in the Install File Print option. It is used to print the
 ;;^DD(9.715,2,1,1,"%D",2,0)
 ;;=components in the order in which they were installed.
 ;;^DD(9.715,2,1,1,"DT")
 ;;=2950103
 ;;^DD(9.715,2,3)
 ;;=Type a Number between 1 and 99, 0 Decimal Digits
 ;;^DD(9.715,2,21,0)
 ;;=^^1^1^2941212^
 ;;^DD(9.715,2,21,1,0)
 ;;=This is the order the Build Components were installed.
 ;;^DD(9.715,2,"DT")
 ;;=2950103
 ;;^DD(9.716,0)
 ;;=POST-INIT CHECK POINTS SUB-FIELD^^3^4
 ;;^DD(9.716,0,"DT")
 ;;=2940710
 ;;^DD(9.716,0,"IX","B",9.716,.01)
 ;;=
 ;;^DD(9.716,0,"NM","POST-INIT CHECK POINTS")
 ;;=
 ;;^DD(9.716,0,"UP")
 ;;=9.7
 ;;^DD(9.716,.01,0)
 ;;=POST-INIT CHECK POINTS^MF^^0;1^K:$L(X)>30!($L(X)<3)!'(X?1A.E) X
 ;;^DD(9.716,.01,1,0)
 ;;=^.1
 ;;^DD(9.716,.01,1,1,0)
 ;;=9.716^B
 ;;^DD(9.716,.01,1,1,1)
 ;;=S ^XPD(9.7,DA(1),"INIT","B",$E(X,1,30),DA)=""
 ;;^DD(9.716,.01,1,1,2)
 ;;=K ^XPD(9.7,DA(1),"INIT","B",$E(X,1,30),DA)
 ;;^DD(9.716,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(9.716,.01,21,0)
 ;;=^^3^3^2931119^^
 ;;^DD(9.716,.01,21,1,0)
 ;;=Enter the name of a Check Point that will be used by the Post-Init routine.
 ;;^DD(9.716,.01,21,2,0)
 ;;=The Check Point "COMPLETED" will be created by the Install process and
 ;;^DD(9.716,.01,21,3,0)
 ;;=updated when the Post-Init routine is finished.
 ;;^DD(9.716,.01,"DT")
 ;;=2940708
