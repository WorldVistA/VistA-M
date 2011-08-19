XPDIN00C ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.7)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.701,1,21,2,0)
 ;;=Install Question.
 ;;^DD(9.701,1,"DT")
 ;;=2931201
 ;;^DD(9.701,2,0)
 ;;=EXTERNAL ANSWER^F^^B;E1,200^K:$L(X)>200!($L(X)<1) X
 ;;^DD(9.701,2,3)
 ;;=Answer must be 1-200 characters in length.
 ;;^DD(9.701,2,21,0)
 ;;=^^1^1^2940503^^
 ;;^DD(9.701,2,21,1,0)
 ;;=This is the external format of the Install Question answer.
 ;;^DD(9.701,2,"DT")
 ;;=2931201
 ;;^DD(9.701,3,0)
 ;;=ANSWER^F^^1;E1,200^K:$L(X)>200!($L(X)<1) X
 ;;^DD(9.701,3,3)
 ;;=Answer must be 1-200 characters in length.
 ;;^DD(9.701,3,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.701,3,21,1,0)
 ;;=This is the internal format of the Install Question answer.
 ;;^DD(9.701,3,"DT")
 ;;=2931201
 ;;^DD(9.702,0)
 ;;=MESSAGES SUB-FIELD^^.01^1
 ;;^DD(9.702,0,"DT")
 ;;=2931129
 ;;^DD(9.702,0,"NM","MESSAGES")
 ;;=
 ;;^DD(9.702,0,"UP")
 ;;=9.7
 ;;^DD(9.702,.01,0)
 ;;=MESSAGES^WL^^0;1^Q
 ;;^DD(9.702,.01,"DT")
 ;;=2931129
 ;;^DD(9.703,0)
 ;;=VOLUME SET SUB-FIELD^^4^5
 ;;^DD(9.703,0,"DT")
 ;;=2941014
 ;;^DD(9.703,0,"IX","B",9.703,.01)
 ;;=
 ;;^DD(9.703,0,"NM","VOLUME SET")
 ;;=
 ;;^DD(9.703,0,"UP")
 ;;=9.7
 ;;^DD(9.703,.01,0)
 ;;=VOLUME SET^MFX^^0;1^K:$L(X)>30!($L(X)<3) X D VOLE^XPDET(.X)
 ;;^DD(9.703,.01,1,0)
 ;;=^.1
 ;;^DD(9.703,.01,1,1,0)
 ;;=9.703^B
 ;;^DD(9.703,.01,1,1,1)
 ;;=S ^XPD(9.7,DA(1),"VOL","B",$E(X,1,30),DA)=""
 ;;^DD(9.703,.01,1,1,2)
 ;;=K ^XPD(9.7,DA(1),"VOL","B",$E(X,1,30),DA)
 ;;^DD(9.703,.01,3)
 ;;=Enter a Compute Server or Print Server type VOLUME SET
 ;;^DD(9.703,.01,4)
 ;;=D VOLH^XPDET
 ;;^DD(9.703,.01,21,0)
 ;;=^^3^3^2941017^^^^
 ;;^DD(9.703,.01,21,1,0)
 ;;=Enter the name of the VOLUME SET that you want updated when this package is
 ;;^DD(9.703,.01,21,2,0)
 ;;=installed. The VOLUME SET must be a Compute or Print Server, as defined in
 ;;^DD(9.703,.01,21,3,0)
 ;;=the VOLUME SET file, #14.5.
 ;;^DD(9.703,.01,"DT")
 ;;=2941017
 ;;^DD(9.703,1,0)
 ;;=COMPLETED TIME^D^^0;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.703,1,21,0)
 ;;=^^1^1^2941014^
 ;;^DD(9.703,1,21,1,0)
 ;;=This is the time the update to the VOLUME SET was completed. 
 ;;^DD(9.703,1,"DT")
 ;;=2941014
 ;;^DD(9.703,2,0)
 ;;=START TIME^D^^0;3^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.703,2,3)
 ;;=
 ;;^DD(9.703,2,21,0)
 ;;=^^1^1^2941014^
 ;;^DD(9.703,2,21,1,0)
 ;;=This is the time the update to the VOLUME SET was started.
 ;;^DD(9.703,2,"DT")
 ;;=2941014
 ;;^DD(9.703,3,0)
 ;;=QUEUED TASK NUMBER^NJ8,0^^0;4^K:+X'=X!(X>99999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(9.703,3,3)
 ;;=Type a Number between 1 and 99999999, 0 Decimal Digits
 ;;^DD(9.703,3,21,0)
 ;;=^^1^1^2941014^
 ;;^DD(9.703,3,21,1,0)
 ;;=This is the Task number for the job that is updating the VOLUME SET.
 ;;^DD(9.703,3,"DT")
 ;;=2941014
 ;;^DD(9.703,4,0)
 ;;=LAST UPDATE^F^^1;1^K:$L(X)>30!($L(X)<3) X
 ;;^DD(9.703,4,3)
 ;;=Must be $H format
 ;;^DD(9.703,4,21,0)
 ;;=^^2^2^2941014^
 ;;^DD(9.703,4,21,1,0)
 ;;=This is the $H value from the job that is updating the VOLUME SET. It should
 ;;^DD(9.703,4,21,2,0)
 ;;=be updated every 60 seconds.
 ;;^DD(9.703,4,"DT")
 ;;=2941014
 ;;^DD(9.704,0)
 ;;=ROUTINES SUB-FIELD^^.01^1
 ;;^DD(9.704,0,"DT")
 ;;=2950314
 ;;^DD(9.704,0,"IX","B",9.704,.01)
 ;;=
 ;;^DD(9.704,0,"NM","ROUTINES")
 ;;=
 ;;^DD(9.704,0,"UP")
 ;;=9.7
 ;;^DD(9.704,.01,0)
 ;;=ROUTINES^MF^^0;1^K:$L(X)>8!($L(X)<3) X
 ;;^DD(9.704,.01,1,0)
 ;;=^.1
 ;;^DD(9.704,.01,1,1,0)
 ;;=9.704^B
 ;;^DD(9.704,.01,1,1,1)
 ;;=S ^XPD(9.7,DA(1),"RTN","B",$E(X,1,30),DA)=""
 ;;^DD(9.704,.01,1,1,2)
 ;;=K ^XPD(9.7,DA(1),"RTN","B",$E(X,1,30),DA)
 ;;^DD(9.704,.01,3)
 ;;=Answer must be 3-8 characters in length.
 ;;^DD(9.704,.01,21,0)
 ;;=^^1^1^2941128^^
 ;;^DD(9.704,.01,21,1,0)
 ;;=This is the name of a Routine that is part of this Package.
 ;;^DD(9.704,.01,"DT")
 ;;=2941128
 ;;^DD(9.713,0)
 ;;=PRE-INIT CHECK POINTS SUB-FIELD^^3^4
 ;;^DD(9.713,0,"DT")
 ;;=2940710
 ;;^DD(9.713,0,"IX","B",9.713,.01)
 ;;=
 ;;^DD(9.713,0,"NM","PRE-INIT CHECK POINTS")
 ;;=
 ;;^DD(9.713,0,"UP")
 ;;=9.7
 ;;^DD(9.713,.01,0)
 ;;=PRE-INIT CHECK POINTS^MF^^0;1^K:$L(X)>30!($L(X)<3)!'(X?1A.E) X
 ;;^DD(9.713,.01,1,0)
 ;;=^.1
 ;;^DD(9.713,.01,1,1,0)
 ;;=9.713^B
 ;;^DD(9.713,.01,1,1,1)
 ;;=S ^XPD(9.7,DA(1),"INI","B",$E(X,1,30),DA)=""
 ;;^DD(9.713,.01,1,1,2)
 ;;=K ^XPD(9.7,DA(1),"INI","B",$E(X,1,30),DA)
 ;;^DD(9.713,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(9.713,.01,21,0)
 ;;=^^3^3^2931119^
 ;;^DD(9.713,.01,21,1,0)
 ;;=Enter the name of a Check Point that will be used by the Pre-Init routine.
 ;;^DD(9.713,.01,21,2,0)
 ;;=The Check Point "COMPLETED" will be created by the Install process and
 ;;^DD(9.713,.01,21,3,0)
 ;;=updated when the Pre-Init routine is finished.
 ;;^DD(9.713,.01,"DT")
 ;;=2940708
