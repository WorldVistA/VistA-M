XVVMI004 ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQ(19200.113)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(19200.113,0,"GL")
 ;;=^XVV(19200.113,
 ;;^DIC("B","VPE PROGRAMMER CALL",19200.113)
 ;;=
 ;;^DD(19200.113,0)
 ;;=FIELD^^73^32
 ;;^DD(19200.113,0,"DT")
 ;;=2960107
 ;;^DD(19200.113,0,"ID","A1")
 ;;=W ?32,$P(^(0),U,5)
 ;;^DD(19200.113,0,"ID","A2")
 ;;=W:$D(^("RTN")) ?60,$E(^("RTN"),1,245)
 ;;^DD(19200.113,0,"IX","B",19200.113,.01)
 ;;=
 ;;^DD(19200.113,0,"IX","C",19200.113,3)
 ;;=
 ;;^DD(19200.113,0,"IX","D",19200.113,20)
 ;;=
 ;;^DD(19200.113,0,"NM","VPE PROGRAMMER CALL")
 ;;=
 ;;^DD(19200.113,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(19200.113,.01,1,0)
 ;;=^.1
 ;;^DD(19200.113,.01,1,1,0)
 ;;=19200.113^B
 ;;^DD(19200.113,.01,1,1,1)
 ;;=S ^XVV(19200.113,"B",$E(X,1,30),DA)=""
 ;;^DD(19200.113,.01,1,1,2)
 ;;=K ^XVV(19200.113,"B",$E(X,1,30),DA)
 ;;^DD(19200.113,.01,3)
 ;;=Enter name of a MUMPS programmer call (3-30 characters).
 ;;^DD(19200.113,.01,"DT")
 ;;=2960107
 ;;^DD(19200.113,2,0)
 ;;=ACTIVE^S^n:NO;^0;2^Q
 ;;^DD(19200.113,2,3)
 ;;=Enter NO to deactivate this call.
 ;;^DD(19200.113,2,"DT")
 ;;=2960107
 ;;^DD(19200.113,3,0)
 ;;=IDENTIFIER^F^^0;3^K:$L(X)>20!($L(X)<1) X
 ;;^DD(19200.113,3,1,0)
 ;;=^.1
 ;;^DD(19200.113,3,1,1,0)
 ;;=19200.113^C
 ;;^DD(19200.113,3,1,1,1)
 ;;=S ^XVV(19200.113,"C",$E(X,1,30),DA)=""
 ;;^DD(19200.113,3,1,1,2)
 ;;=K ^XVV(19200.113,"C",$E(X,1,30),DA)
 ;;^DD(19200.113,3,1,1,"DT")
 ;;=2960107
 ;;^DD(19200.113,3,3)
 ;;=This field is cross referenced and can be used for lookup (1-20 characters).
 ;;^DD(19200.113,3,"DT")
 ;;=2960107
 ;;^DD(19200.113,4,0)
 ;;=TYPE^S^p:PARAMETER;v:VARIABLE;^0;4^Q
 ;;^DD(19200.113,4,3)
 ;;=Does this call use parameters or does it rely on variables being set?
 ;;^DD(19200.113,4,"DT")
 ;;=2960107
 ;;^DD(19200.113,5,0)
 ;;=DESCRIPTION^F^^0;5^K:$L(X)>30!($L(X)<3) X
 ;;^DD(19200.113,5,3)
 ;;=Enter short description. It will appear when user types "?" (3-30 characters).
 ;;^DD(19200.113,5,"DT")
 ;;=2960107
 ;;^DD(19200.113,20,0)
 ;;=ROUTINE^F^^RTN;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(19200.113,20,1,0)
 ;;=^.1
 ;;^DD(19200.113,20,1,1,0)
 ;;=19200.113^D
 ;;^DD(19200.113,20,1,1,1)
 ;;=S ^XVV(19200.113,"D",$E(X,1,30),DA)=""
 ;;^DD(19200.113,20,1,1,2)
 ;;=K ^XVV(19200.113,"D",$E(X,1,30),DA)
 ;;^DD(19200.113,20,1,1,"DT")
 ;;=2960107
 ;;^DD(19200.113,20,3)
 ;;=Enter name of MUMPS routine.
 ;;^DD(19200.113,20,"DT")
 ;;=2960107
 ;;^DD(19200.113,21,0)
 ;;=PARAM 1^*P19200.114'^XVV(19200.114,^P;1^S DIC("S")="I $P(^(0),U,2)'=""n""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(19200.113,21,12)
 ;;=Screen inactive parameters.
 ;;^DD(19200.113,21,12.1)
 ;;=S DIC("S")="I $P(^(0),U,2)'=""n"""
 ;;^DD(19200.113,21,"DT")
 ;;=2960107
 ;;^DD(19200.113,22,0)
 ;;=PARAM 2^*P19200.114'^XVV(19200.114,^P;2^S DIC("S")="I $P(^(0),U,2)'=""n""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(19200.113,22,12)
 ;;=Screen inactive parameters.
 ;;^DD(19200.113,22,12.1)
 ;;=S DIC("S")="I $P(^(0),U,2)'=""n"""
 ;;^DD(19200.113,22,"DT")
 ;;=2960107
 ;;^DD(19200.113,23,0)
 ;;=PARAM 3^*P19200.114'^XVV(19200.114,^P;3^S DIC("S")="I $P(^(0),U,2)'=""n""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(19200.113,23,12)
 ;;=Screen inactive parameters.
 ;;^DD(19200.113,23,12.1)
 ;;=S DIC("S")="I $P(^(0),U,2)'=""n"""
 ;;^DD(19200.113,23,"DT")
 ;;=2960107
 ;;^DD(19200.113,24,0)
 ;;=PARAM 4^*P19200.114'^XVV(19200.114,^P;4^S DIC("S")="I $P(^(0),U,2)'=""n""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(19200.113,24,12)
 ;;=Screen inactive parameters.
 ;;^DD(19200.113,24,12.1)
 ;;=S DIC("S")="I $P(^(0),U,2)'=""n"""
 ;;^DD(19200.113,24,"DT")
 ;;=2960107
 ;;^DD(19200.113,25,0)
 ;;=PARAM 5^*P19200.114'^XVV(19200.114,^P;5^S DIC("S")="I $P(^(0),U,2)'=""n""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(19200.113,25,12)
 ;;=Screen inactive parameters.
 ;;^DD(19200.113,25,12.1)
 ;;=S DIC("S")="I $P(^(0),U,2)'=""n"""
 ;;^DD(19200.113,25,"DT")
 ;;=2960107
 ;;^DD(19200.113,26,0)
 ;;=PARAM 6^*P19200.114'^XVV(19200.114,^P;6^S DIC("S")="I $P(^(0),U,2)'=""n""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(19200.113,26,12)
 ;;=Screen inactive parameters.
 ;;^DD(19200.113,26,12.1)
 ;;=S DIC("S")="I $P(^(0),U,2)'=""n"""
 ;;^DD(19200.113,26,"DT")
 ;;=2960107
 ;;^DD(19200.113,27,0)
 ;;=PARAM 7^*P19200.114'^XVV(19200.114,^P;7^S DIC("S")="I $P(^(0),U,2)'=""n""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(19200.113,27,12)
 ;;=Screen inactive parameters.
 ;;^DD(19200.113,27,12.1)
 ;;=S DIC("S")="I $P(^(0),U,2)'=""n"""
 ;;^DD(19200.113,27,"DT")
 ;;=2960107
 ;;^DD(19200.113,28,0)
 ;;=PARAM 8^*P19200.114'^XVV(19200.114,^P;8^S DIC("S")="I $P(^(0),U,2)'=""n""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(19200.113,28,12)
 ;;=Screen inactive parameters.
