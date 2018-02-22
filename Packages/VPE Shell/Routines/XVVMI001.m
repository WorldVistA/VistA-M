XVVMI001 ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQ(19200.11)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(19200.11,0,"GL")
 ;;=^XVV(19200.11,
 ;;^DIC("B","VPE RTN LBRY",19200.11)
 ;;=
 ;;^DIC(19200.11,"%D",0)
 ;;=^^4^4^3001204^
 ;;^DIC(19200.11,"%D",1,0)
 ;;=This file stores the names of routines checked out by programmers.
 ;;^DIC(19200.11,"%D",2,0)
 ;;=When other programmers go to edit a routine on this list, using
 ;;^DIC(19200.11,"%D",3,0)
 ;;=VPE's routine editor, they get a message notifying them that another
 ;;^DIC(19200.11,"%D",4,0)
 ;;=programmer has checked out this routine.
 ;;^DD(19200.11,0)
 ;;=FIELD^^13^4
 ;;^DD(19200.11,0,"DT")
 ;;=2960202
 ;;^DD(19200.11,0,"ID","A1")
 ;;=S %I=Y,Y=$S('$D(^(0)):"",$D(^XVV(19200.111,+$P(^(0),U,13),0))#2:$P(^(0),U,1),1:""),C=$P(^DD(19200.111,.01,0),U,2) D Y^DIQ:Y]"" W ?15,Y,@("$E("_DIC_"%I,0),0)") S Y=%I K %I
 ;;^DD(19200.11,0,"ID","A2")
 ;;=S %I=Y,Y=$S('$D(^(0)):"",$D(^DIC(9.4,+$P(^(0),U,4),0))#2:$P(^(0),U,1),1:""),C=$P(^DD(9.4,.01,0),U,2) D Y^DIQ:Y]"" W ?45,Y,@("$E("_DIC_"%I,0),0)") S Y=%I K %I
 ;;^DD(19200.11,0,"IX","B",19200.11,.01)
 ;;=
 ;;^DD(19200.11,0,"NM","VPE RTN LBRY")
 ;;=
 ;;^DD(19200.11,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>8!($L(X)<1)!'(X?1E1.7AN) X
 ;;^DD(19200.11,.01,1,0)
 ;;=^.1^^-1
 ;;^DD(19200.11,.01,1,1,0)
 ;;=19200.11^B
 ;;^DD(19200.11,.01,1,1,1)
 ;;=S ^XVV(19200.11,"B",$E(X,1,30),DA)=""
 ;;^DD(19200.11,.01,1,1,2)
 ;;=K ^XVV(19200.11,"B",$E(X,1,30),DA)
 ;;^DD(19200.11,.01,3)
 ;;=Enter name of mumps routine you wish to sign out (1-8 characters).
 ;;^DD(19200.11,.01,"DT")
 ;;=2951225
 ;;^DD(19200.11,4,0)
 ;;=IDENTIFIER^F^^0;4^K:$L(X)>30!($L(X)<1) X
 ;;^DD(19200.11,4,3)
 ;;=Enter word or phrase to group your programmers for easy selection (1-30 characters).
 ;;^DD(19200.11,4,"DT")
 ;;=2960202
 ;;^DD(19200.11,12,0)
 ;;=DATE SIGNED OUT^D^^0;12^S %DT="ET" D ^%DT S X=Y K:Y<1 X
 ;;^DD(19200.11,12,3)
 ;;=Enter data & time routine was signed out.
 ;;^DD(19200.11,12,"DT")
 ;;=2951224
 ;;^DD(19200.11,13,0)
 ;;=SIGNED OUT BY^P19200.111'^XVV(19200.111,^0;13^Q
 ;;^DD(19200.11,13,3)
 ;;=Enter name of programmer who signed out this routine.
 ;;^DD(19200.11,13,"DT")
 ;;=2951225
