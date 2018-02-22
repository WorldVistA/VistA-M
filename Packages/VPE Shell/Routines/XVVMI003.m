XVVMI003 ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQ(19200.112)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(19200.112,0,"GL")
 ;;=^XVV(19200.112,
 ;;^DIC("B","VPE RTN VERSIONING",19200.112)
 ;;=
 ;;^DIC(19200.112,"%D",0)
 ;;=^^3^3^3001204^
 ;;^DIC(19200.112,"%D",1,0)
 ;;=This file stores versions of routines being edited. It allows programmers,
 ;;^DIC(19200.112,"%D",2,0)
 ;;=who use VPE's routine editor, to restore previous versions of any routine
 ;;^DIC(19200.112,"%D",3,0)
 ;;=edited.
 ;;^DD(19200.112,0)
 ;;=FIELD^^4^5
 ;;^DD(19200.112,0,"DT")
 ;;=3001123
 ;;^DD(19200.112,0,"IX","AC1",19200.112,.01)
 ;;=
 ;;^DD(19200.112,0,"IX","AC2",19200.112,2)
 ;;=
 ;;^DD(19200.112,0,"IX","B",19200.112,.01)
 ;;=
 ;;^DD(19200.112,0,"IX","UNIQ",19200.112,.01)
 ;;=
 ;;^DD(19200.112,0,"NM","VPE RTN VERSIONING")
 ;;=
 ;;^DD(19200.112,.01,0)
 ;;=ROUTINE^RFX^^0;1^D KEY1^XVEMRLX
 ;;^DD(19200.112,.01,1,0)
 ;;=^.1
 ;;^DD(19200.112,.01,1,1,0)
 ;;=19200.112^B
 ;;^DD(19200.112,.01,1,1,1)
 ;;=S ^XVV(19200.112,"B",$E(X,1,30),DA)=""
 ;;^DD(19200.112,.01,1,1,2)
 ;;=K ^XVV(19200.112,"B",$E(X,1,30),DA)
 ;;^DD(19200.112,.01,1,2,0)
 ;;=19200.112^AC1^MUMPS
 ;;^DD(19200.112,.01,1,2,1)
 ;;=D SET1^XVEMRLX
 ;;^DD(19200.112,.01,1,2,2)
 ;;=D KILL1^XVEMRLX
 ;;^DD(19200.112,.01,1,2,"%D",0)
 ;;=^^1^1^3001115^
 ;;^DD(19200.112,.01,1,2,"%D",1,0)
 ;;=This xref prevents duplicate entries for ROUTINE & VERSION fields.
 ;;^DD(19200.112,.01,1,2,"DT")
 ;;=3001115
 ;;^DD(19200.112,.01,1,3,0)
 ;;=19200.112^UNIQ^MUMPS
 ;;^DD(19200.112,.01,1,3,1)
 ;;=I '$D(^XVV(19200.112,"UNIQ",X)) S ^XVV(19200.112,"UNIQ",X,DA)=""
 ;;^DD(19200.112,.01,1,3,2)
 ;;=D KILLUNIQ^XVEMRLX
 ;;^DD(19200.112,.01,1,3,"%D",0)
 ;;=^^1^1^3001118^^^^
 ;;^DD(19200.112,.01,1,3,"%D",1,0)
 ;;=This xref allows DIC lookups for unique routine names.
 ;;^DD(19200.112,.01,1,3,"DT")
 ;;=3001118
 ;;^DD(19200.112,.01,3)
 ;;=Enter name of a Mumps routine.
 ;;^DD(19200.112,.01,"DT")
 ;;=3001118
 ;;^DD(19200.112,2,0)
 ;;=VERSION^RNJ5,0X^^0;2^D KEY2^XVEMRLX
 ;;^DD(19200.112,2,1,0)
 ;;=^.1
 ;;^DD(19200.112,2,1,1,0)
 ;;=19200.112^AC2^MUMPS
 ;;^DD(19200.112,2,1,1,1)
 ;;=D SET2^XVEMRLX
 ;;^DD(19200.112,2,1,1,2)
 ;;=D KILL2^XVEMRLX
 ;;^DD(19200.112,2,1,1,"%D",0)
 ;;=^^1^1^3001116^^
 ;;^DD(19200.112,2,1,1,"%D",1,0)
 ;;=This xref prevents duplicates on the ROUTINE & VERSION fields.
 ;;^DD(19200.112,2,1,1,"DT")
 ;;=3001115
 ;;^DD(19200.112,2,3)
 ;;=Enter version number for this routine (1-99999).
 ;;^DD(19200.112,2,"DT")
 ;;=3001115
 ;;^DD(19200.112,3,0)
 ;;=DESCRIPTION^F^^0;3^K:$L(X)>60!($L(X)<1) X
 ;;^DD(19200.112,3,3)
 ;;=Enter a description that will help you decide which version to restore (1-60 characters).
 ;;^DD(19200.112,3,"DT")
 ;;=3001118
 ;;^DD(19200.112,4,0)
 ;;=DATE^D^^0;4^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(19200.112,4,3)
 ;;=Enter the date this version was created or last updated.
 ;;^DD(19200.112,4,"DT")
 ;;=3001123
 ;;^DD(19200.112,20,0)
 ;;=TEXT^19200.1121^^WP;0
 ;;^DD(19200.1121,0)
 ;;=TEXT SUB-FIELD^^.01^1
 ;;^DD(19200.1121,0,"DT")
 ;;=3001115
 ;;^DD(19200.1121,0,"NM","TEXT")
 ;;=
 ;;^DD(19200.1121,0,"UP")
 ;;=19200.112
 ;;^DD(19200.1121,.01,0)
 ;;=TEXT^W^^0;1^Q
 ;;^DD(19200.1121,.01,3)
 ;;=Enter the routine's text.
 ;;^DD(19200.1121,.01,"DT")
 ;;=3001115
