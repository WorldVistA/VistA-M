XPDIN00B ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.7)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.7,7,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(9.7,7,21,0)
 ;;=^^2^2^2940426^^
 ;;^DD(9.7,7,21,1,0)
 ;;=This is the SETNAME that will be used to disable options and protocols during
 ;;^DD(9.7,7,21,2,0)
 ;;=the installation of this package.
 ;;^DD(9.7,7,"DT")
 ;;=2940426
 ;;^DD(9.7,8,0)
 ;;=DISABLE OPTION DELAY^NJ2,0^^0;10^K:+X'=X!(X>60)!(X<0)!(X?.E1"."1N.N) X
 ;;^DD(9.7,8,3)
 ;;=Enter the number of minutes to delay the install, between 0 and 60.
 ;;^DD(9.7,8,21,0)
 ;;=^^2^2^2941103^
 ;;^DD(9.7,8,21,1,0)
 ;;=Enter the number of minutes to wait after the Options and Protocols have
 ;;^DD(9.7,8,21,2,0)
 ;;=been disabled, but before the Routines have been installed.
 ;;^DD(9.7,8,"DT")
 ;;=2941103
 ;;^DD(9.7,9,0)
 ;;=INSTALLED BY^P200'^VA(200,^0;11^Q
 ;;^DD(9.7,9,21,0)
 ;;=^^1^1^2950213^
 ;;^DD(9.7,9,21,1,0)
 ;;=This is the person who installed this package.
 ;;^DD(9.7,9,"DT")
 ;;=2950213
 ;;^DD(9.7,11,0)
 ;;=INSTALL START TIME^D^^1;1^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.7,11,21,0)
 ;;=^^1^1^2940415^
 ;;^DD(9.7,11,21,1,0)
 ;;=This is the time the install started.
 ;;^DD(9.7,11,"DT")
 ;;=2931117
 ;;^DD(9.7,12,0)
 ;;=ROUTINE INSTALL TIME^D^^1;2^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.7,12,21,0)
 ;;=^^1^1^2940415^
 ;;^DD(9.7,12,21,1,0)
 ;;=This is the routine install completed time.
 ;;^DD(9.7,12,"DT")
 ;;=2931118
 ;;^DD(9.7,13,0)
 ;;=PRE-INIT CHECK POINTS^9.713^^INI;0
 ;;^DD(9.7,13,21,0)
 ;;=^^1^1^2940503^^
 ;;^DD(9.7,13,21,1,0)
 ;;=This contains all the check points needed for the Pre-Init routine.
 ;;^DD(9.7,14,0)
 ;;=FILE^9.714P^^4;0
 ;;^DD(9.7,14,21,0)
 ;;=^^1^1^2940415^
 ;;^DD(9.7,14,21,1,0)
 ;;=This contains the VA Fileman files that were installed by this package.
 ;;^DD(9.7,14,"DT")
 ;;=2931118
 ;;^DD(9.7,15,0)
 ;;=BUILD COMPONENTS^9.715P^^KRN;0
 ;;^DD(9.7,15,21,0)
 ;;=^^1^1^2940415^
 ;;^DD(9.7,15,21,1,0)
 ;;=This contains a list of the components of this package.
 ;;^DD(9.7,15,"DT")
 ;;=2940525
 ;;^DD(9.7,16,0)
 ;;=POST-INIT CHECK POINTS^9.716^^INIT;0
 ;;^DD(9.7,16,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.7,16,21,1,0)
 ;;=This contains all the check points needed for the Post-Init routine.
 ;;^DD(9.7,17,0)
 ;;=INSTALL COMPLETE TIME^D^^1;3^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.7,17,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.7,17,21,1,0)
 ;;=This is the time the install finished.
 ;;^DD(9.7,17,"DT")
 ;;=2940111
 ;;^DD(9.7,18,0)
 ;;=GLOBALS^9.718^^GLO;0
 ;;^DD(9.7,18,21,0)
 ;;=^^2^2^2950109^
 ;;^DD(9.7,18,21,1,0)
 ;;=This multiple contains a list of globals that were installed by
 ;;^DD(9.7,18,21,2,0)
 ;;=this package.
 ;;^DD(9.7,20,0)
 ;;=MESSAGES^9.702^^MES;0
 ;;^DD(9.7,20,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.7,20,21,1,0)
 ;;=This is where all messages about the install will be saved.
 ;;^DD(9.7,30,0)
 ;;=VOLUME SET^9.703^^VOL;0
 ;;^DD(9.7,30,21,0)
 ;;=^^2^2^2941017^^^^
 ;;^DD(9.7,30,21,1,0)
 ;;=This multiple contains the Volumes Sets that will be updated with the new
 ;;^DD(9.7,30,21,2,0)
 ;;=routines and compiled cross references, print and input templates.
 ;;^DD(9.7,30,"DT")
 ;;=2941017
 ;;^DD(9.7,40,0)
 ;;=ROUTINES^9.704A^^RTN;0
 ;;^DD(9.7,40,21,0)
 ;;=^^3^3^2941128^^
 ;;^DD(9.7,40,21,1,0)
 ;;=This multiple contains a list of all Routines that were installed for
 ;;^DD(9.7,40,21,2,0)
 ;;=this package.  It also includes routines that were generated during the
 ;;^DD(9.7,40,21,3,0)
 ;;=install.  The Routines came from calls to DIEZ, DIPZ, and DIKZ.
 ;;^DD(9.7,40,"DT")
 ;;=2941128
 ;;^DD(9.7,50,0)
 ;;=INSTALL ANSWERS^9.701^^QUES;0
 ;;^DD(9.7,50,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.7,50,21,1,0)
 ;;=This multiple contains the answers to all the install Questions.
 ;;^DD(9.701,0)
 ;;=INSTALL ANSWERS SUB-FIELD^^3^4
 ;;^DD(9.701,0,"DT")
 ;;=2931201
 ;;^DD(9.701,0,"IX","B",9.701,.01)
 ;;=
 ;;^DD(9.701,0,"NM","INSTALL ANSWERS")
 ;;=
 ;;^DD(9.701,0,"UP")
 ;;=9.7
 ;;^DD(9.701,.01,0)
 ;;=NAME^MF^^0;1^K:$L(X)>30!($L(X)<3) X
 ;;^DD(9.701,.01,1,0)
 ;;=^.1
 ;;^DD(9.701,.01,1,1,0)
 ;;=9.701^B
 ;;^DD(9.701,.01,1,1,1)
 ;;=S ^XPD(9.7,DA(1),"QUES","B",$E(X,1,30),DA)=""
 ;;^DD(9.701,.01,1,1,2)
 ;;=K ^XPD(9.7,DA(1),"QUES","B",$E(X,1,30),DA)
 ;;^DD(9.701,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(9.701,.01,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.701,.01,21,1,0)
 ;;=This is the subscript to the install question.
 ;;^DD(9.701,.01,"DT")
 ;;=2931122
 ;;^DD(9.701,1,0)
 ;;=PROMPT^F^^A;E1,240^K:$L(X)>240!($L(X)<1) X
 ;;^DD(9.701,1,3)
 ;;=Answer must be 1-240 characters in length.
 ;;^DD(9.701,1,21,0)
 ;;=^^2^2^2940503^^
 ;;^DD(9.701,1,21,1,0)
 ;;=This is the DIR(A) variable that was used to prompt the user for the
