XVVMI007 ; ; 04-JAN-2004
 ;;15.2;VICTORY PROG ENVIRONMENT;;Aug 27, 2019
 Q:'DIFQ(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(19200.114,0,"GL")
 ;;=^XVV(19200.114,
 ;;^DIC("B","VPE PROGRAMMER PARAMETER",19200.114)
 ;;=
 ;;^DD(19200.114,0)
 ;;=FIELD^^21^6
 ;;^DD(19200.114,0,"DT")
 ;;=2960115
 ;;^DD(19200.114,0,"ID","A1")
 ;;=W:$D(^("I")) ?35,$E(^("I"),1,245)
 ;;^DD(19200.114,0,"IX","B",19200.114,.01)
 ;;=
 ;;^DD(19200.114,0,"NM","VPE PROGRAMMER PARAMETER")
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,2)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,3)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,4)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,5)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,6)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,7)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,8)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,9)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,10)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,11)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,12)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,13)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,21)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,22)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,23)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,24)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,25)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,26)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,27)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,28)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,29)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,30)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,31)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,32)
 ;;=
 ;;^DD(19200.114,0,"PT",19200.113,33)
 ;;=
 ;;^DD(19200.114,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!($L(X)<1) X
 ;;^DD(19200.114,.01,1,0)
 ;;=^.1
 ;;^DD(19200.114,.01,1,1,0)
 ;;=19200.114^B
 ;;^DD(19200.114,.01,1,1,1)
 ;;=S ^XVV(19200.114,"B",$E(X,1,30),DA)=""
 ;;^DD(19200.114,.01,1,1,2)
 ;;=K ^XVV(19200.114,"B",$E(X,1,30),DA)
 ;;^DD(19200.114,.01,3)
 ;;=Use ~ for ^, and ' for " (1-30 characters).
 ;;^DD(19200.114,.01,"DT")
 ;;=2960114
 ;;^DD(19200.114,2,0)
 ;;=ACTIVE^S^n:NO;^0;2^Q
 ;;^DD(19200.114,2,3)
 ;;=Enter NO to deactivate this parameter.
 ;;^DD(19200.114,2,"DT")
 ;;=2960106
 ;;^DD(19200.114,15,0)
 ;;=IDENTIFIER^F^^I;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(19200.114,15,3)
 ;;=Enter text to help identify this parameter since some parameters have to be entered with the same name but different values.
 ;;^DD(19200.114,15,"DT")
 ;;=2960106
 ;;^DD(19200.114,16,0)
 ;;=DEFAULT^F^^D;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(19200.114,16,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(19200.114,16,"DT")
 ;;=2960108
 ;;^DD(19200.114,20,0)
 ;;=HELP TEXT^19200.124^^WP;0
 ;;^DD(19200.114,20,"DT")
 ;;=2960107
 ;;^DD(19200.114,21,0)
 ;;=EXTENDED HELP TEXT^19200.11421^^WP1;0
 ;;^DD(19200.11421,0)
 ;;=EXTENDED HELP TEXT SUB-FIELD^^.01^1
 ;;^DD(19200.11421,0,"DT")
 ;;=2960115
 ;;^DD(19200.11421,0,"NM","EXTENDED HELP TEXT")
 ;;=
 ;;^DD(19200.11421,0,"UP")
 ;;=19200.114
 ;;^DD(19200.11421,.01,0)
 ;;=EXTENDED HELP TEXT^W^^0;1^Q
 ;;^DD(19200.11421,.01,3)
 ;;=Text entered here will display when user hits "H".
 ;;^DD(19200.11421,.01,"DT")
 ;;=2960115
 ;;^DD(19200.124,0)
 ;;=HELP TEXT SUB-FIELD^^.01^1
 ;;^DD(19200.124,0,"DT")
 ;;=2960106
 ;;^DD(19200.124,0,"NM","HELP TEXT")
 ;;=
 ;;^DD(19200.124,0,"UP")
 ;;=19200.114
 ;;^DD(19200.124,.01,0)
 ;;=HELP TEXT^W^^0;1^Q
 ;;^DD(19200.124,.01,3)
 ;;=Enter text describing this parameter.
 ;;^DD(19200.124,.01,"DT")
 ;;=2960107
