XVVMI002 ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQ(19200.111)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(19200.111,0,"GL")
 ;;=^XVV(19200.111,
 ;;^DIC("B","VPE PERSON",19200.111)
 ;;=
 ;;^DIC(19200.111,"%D",0)
 ;;=^^1^1^3001204^
 ;;^DIC(19200.111,"%D",1,0)
 ;;=This file associates a person name with a VPE ID.
 ;;^DD(19200.111,0)
 ;;=FIELD^^4^4
 ;;^DD(19200.111,0,"DT")
 ;;=3001130
 ;;^DD(19200.111,0,"ID","A1")
 ;;=W ?40,$P(^(0),U,2)
 ;;^DD(19200.111,0,"IX","B",19200.111,.01)
 ;;=
 ;;^DD(19200.111,0,"IX","C",19200.111,2)
 ;;=
 ;;^DD(19200.111,0,"IX","ID",19200.111,3)
 ;;=
 ;;^DD(19200.111,0,"NM","VPE PERSON")
 ;;=
 ;;^DD(19200.111,0,"PT",19200.11,13)
 ;;=
 ;;^DD(19200.111,.01,0)
 ;;=NAME^RFX^^0;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)<3!($L(X)>30)!(X'?1U.UP1","1U.UP) X
 ;;^DD(19200.111,.01,1,0)
 ;;=^.1
 ;;^DD(19200.111,.01,1,1,0)
 ;;=19200.111^B
 ;;^DD(19200.111,.01,1,1,1)
 ;;=S ^XVV(19200.111,"B",$E(X,1,30),DA)=""
 ;;^DD(19200.111,.01,1,1,2)
 ;;=K ^XVV(19200.111,"B",$E(X,1,30),DA)
 ;;^DD(19200.111,.01,3)
 ;;=Enter names of programmers who will be signing routines out of the Routine Library (Last,First MI...3-30 characters).
 ;;^DD(19200.111,.01,"DT")
 ;;=2951225
 ;;^DD(19200.111,2,0)
 ;;=INITIALS^F^^0;2^K:$L(X)>5!($L(X)<1) X
 ;;^DD(19200.111,2,1,0)
 ;;=^.1
 ;;^DD(19200.111,2,1,1,0)
 ;;=19200.111^C
 ;;^DD(19200.111,2,1,1,1)
 ;;=S ^XVV(19200.111,"C",$E(X,1,30),DA)=""
 ;;^DD(19200.111,2,1,1,2)
 ;;=K ^XVV(19200.111,"C",$E(X,1,30),DA)
 ;;^DD(19200.111,2,1,1,"DT")
 ;;=2951225
 ;;^DD(19200.111,2,3)
 ;;=Enter you initials (1-5 characters). This will help in displays where your name takes up too much space.
 ;;^DD(19200.111,2,"DT")
 ;;=3001130
 ;;^DD(19200.111,3,0)
 ;;=VPE ID^NJ9,2^^0;3^K:+X'=X!(X>999999)!(X<.1)!(X?.E1"."3N.N) X
 ;;^DD(19200.111,3,1,0)
 ;;=^.1
 ;;^DD(19200.111,3,1,1,0)
 ;;=19200.111^ID
 ;;^DD(19200.111,3,1,1,1)
 ;;=S ^XVV(19200.111,"ID",$E(X,1,30),DA)=""
 ;;^DD(19200.111,3,1,1,2)
 ;;=K ^XVV(19200.111,"ID",$E(X,1,30),DA)
 ;;^DD(19200.111,3,1,1,"DT")
 ;;=2970515
 ;;^DD(19200.111,3,3)
 ;;=Enter this person's VPE ID number (from .1 to 999999, 2 decimal digits). Your VPE ID is stored in variable XVV("ID").
 ;;^DD(19200.111,3,21,0)
 ;;=^^2^2^2970515^
 ;;^DD(19200.111,3,21,1,0)
 ;;= The VPE ID number is used to identify who signed out
 ;;^DD(19200.111,3,21,2,0)
 ;;= routines in the Routine Library package (..LBRY).
 ;;^DD(19200.111,3,"DT")
 ;;=2971017
 ;;^DD(19200.111,4,0)
 ;;=ROUTINE VERSIONING PROMPT^S^y:YES;n:NO;^0;4^Q
 ;;^DD(19200.111,4,3)
 ;;=Enter NO if you want the routine editor to create versions in the background with no user prompts.
 ;;^DD(19200.111,4,"DT")
 ;;=3001130
