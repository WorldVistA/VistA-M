DIPKI008 ;VEN/TOAD-PACKAGE FILE INIT ; 30-MAR-1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.49,2,21,2,0)
 ;;=automatically when an INIT is installed for this package.
 ;;^DD(9.49,2,"DT")
 ;;=2840302
 ;;^DD(9.49,3,0)
 ;;=INSTALLED BY^P200'^VA(200,^0;4^Q
 ;;^DD(9.49,3,21,0)
 ;;=^^1^1^2940607^
 ;;^DD(9.49,3,21,1,0)
 ;;=This is the person who installed this version at this site.
 ;;^DD(9.49,3,"DT")
 ;;=2940607
 ;;^DD(9.49,41,0)
 ;;=DESCRIPTION OF ENHANCEMENTS^9.54^^1;0
 ;;^DD(9.49,41,21,0)
 ;;=^^2^2^2851008^^
 ;;^DD(9.49,41,21,1,0)
 ;;=This is a description of the enhancements being distributed with this
 ;;^DD(9.49,41,21,2,0)
 ;;=release.
 ;;^DD(9.49,51,0)
 ;;=*RELEASE NOTE^9.491^^R;0
 ;;^DD(9.49,51,21,0)
 ;;=^^2^2^2851009^^^^
 ;;^DD(9.49,51,21,1,0)
 ;;=These are the release notes which go along with this release of the
 ;;^DD(9.49,51,21,2,0)
 ;;=Package.
 ;;^DD(9.49,51,"DT")
 ;;=2940603
 ;;^DD(9.49,61,0)
 ;;=*INSTALLATION NOTES^9.4961^^I;0
 ;;^DD(9.49,61,"DT")
 ;;=2940603
 ;;^DD(9.49,62,0)
 ;;=*SYSTEM REQUIREMENTS^9.4962^^S;0
 ;;^DD(9.49,62,"DT")
 ;;=2940603
 ;;^DD(9.49,63,0)
 ;;=*PROGRAMMER NOTES^9.4963^^P;0
 ;;^DD(9.49,63,"DT")
 ;;=2940603
 ;;^DD(9.49,1105,0)
 ;;=PATCH APPLICATION HISTORY^9.4901^^PAH;0
 ;;^DD(9.4901,0)
 ;;=PATCH APPLICATION HISTORY SUB-FIELD^^1^4
 ;;^DD(9.4901,0,"DT")
 ;;=2940603
 ;;^DD(9.4901,0,"IX","B",9.4901,.01)
 ;;=
 ;;^DD(9.4901,0,"NM","PATCH APPLICATION HISTORY")
 ;;=
 ;;^DD(9.4901,0,"UP")
 ;;=9.49
 ;;^DD(9.4901,.01,0)
 ;;=PATCH APPLICATION HISTORY^MF^^0;1^K:$L(X)>15!($L(X)<8) X
 ;;^DD(9.4901,.01,1,0)
 ;;=^.1
 ;;^DD(9.4901,.01,1,1,0)
 ;;=9.4901^B
 ;;^DD(9.4901,.01,1,1,1)
 ;;=S ^DIC(9.4,DA(2),22,DA(1),"PAH","B",$E(X,1,30),DA)=""
 ;;^DD(9.4901,.01,1,1,2)
 ;;=K ^DIC(9.4,DA(2),22,DA(1),"PAH","B",$E(X,1,30),DA)
 ;;^DD(9.4901,.01,3)
 ;;=Answer must be 8-15 characters in length.
 ;;^DD(9.4901,.01,"DT")
 ;;=2890426
 ;;^DD(9.4901,.02,0)
 ;;=DATE APPLIED^D^^0;2^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.4901,.02,"DT")
 ;;=2890426
 ;;^DD(9.4901,.03,0)
 ;;=APPLIED BY^P200'^VA(200,^0;3^Q
 ;;^DD(9.4901,.03,"DT")
 ;;=2890426
 ;;^DD(9.4901,1,0)
 ;;=DESCRIPTION^9.49011^^1;0
 ;;^DD(9.4901,1,21,0)
 ;;=^^1^1^2940603^
 ;;^DD(9.4901,1,21,1,0)
 ;;=This is a description of the patch being distributed with this release.
 ;;^DD(9.49011,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(9.49011,0,"DT")
 ;;=2940603
 ;;^DD(9.49011,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(9.49011,0,"UP")
 ;;=9.4901
 ;;^DD(9.49011,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(9.49011,.01,"DT")
 ;;=2940603
 ;;^DD(9.491,0)
 ;;=*RELEASE NOTE SUB-FIELD^NL^2^4
 ;;^DD(9.491,0,"NM","*RELEASE NOTE")
 ;;=
 ;;^DD(9.491,0,"UP")
 ;;=9.49
 ;;^DD(9.491,.01,0)
 ;;=RELEASE NOTE^MF^^0;1^K:$L(X)>80!($L(X)<3) X
 ;;^DD(9.491,.01,3)
 ;;=Please enter a description (3-80 characters).
 ;;^DD(9.491,.01,21,0)
 ;;=^^1^1^2851008^^
 ;;^DD(9.491,.01,21,1,0)
 ;;=This is a description of a particular enhancement.
 ;;^DD(9.491,.01,"DT")
 ;;=2850123
 ;;^DD(9.491,.02,0)
 ;;=WHERE CHANGE OCCURRED^F^^0;2^K:$L(X)>80!($L(X)<3) X
 ;;^DD(9.491,.02,3)
 ;;=Routine(s), Field Name(s), and/or Data that has been changed (3-80 characters).
 ;;^DD(9.491,.02,21,0)
 ;;=^^1^1^2851009^^^^
 ;;^DD(9.491,.02,21,1,0)
 ;;=Routine, Field Name, or Data that has been changed.
 ;;^DD(9.491,.02,"DT")
 ;;=2850123
 ;;^DD(9.491,1,0)
 ;;=DESCRIPTION OF CHANGE^9.492^^1;0
 ;;^DD(9.491,1,21,0)
 ;;=^^1^1^2851008^^
 ;;^DD(9.491,1,21,1,0)
 ;;=This is a description of the improvements.
 ;;^DD(9.491,2,0)
 ;;=UPDATE^9.493^^2;0
 ;;^DD(9.491,2,21,0)
 ;;=^^2^2^2851009^^
 ;;^DD(9.491,2,21,1,0)
 ;;=Comments on the updates which have been made to this release of the
 ;;^DD(9.491,2,21,2,0)
 ;;=Package.
 ;;^DD(9.492,0)
 ;;=DESCRIPTION OF CHANGE SUB-FIELD^NL^.01^1
 ;;^DD(9.492,0,"NM","DESCRIPTION OF CHANGE")
 ;;=
 ;;^DD(9.492,0,"UP")
 ;;=9.491
 ;;^DD(9.492,.01,0)
 ;;=DESCRIPTION OF CHANGE^W^^0;1^Q
 ;;^DD(9.492,.01,21,0)
 ;;=^^1^1^2851008^^^^
 ;;^DD(9.492,.01,21,1,0)
 ;;=This is a description of the improvement.
 ;;^DD(9.492,.01,"DT")
 ;;=2850123
 ;;^DD(9.493,0)
 ;;=UPDATE SUB-FIELD^NL^.01^1
 ;;^DD(9.493,0,"NM","UPDATE")
 ;;=
 ;;^DD(9.493,0,"UP")
 ;;=9.491
 ;;^DD(9.493,.01,0)
 ;;=UPDATE^W^^0;1^Q
 ;;^DD(9.493,.01,21,0)
 ;;=^^1^1^2851008^
 ;;^DD(9.493,.01,21,1,0)
 ;;=This is a description of the update to the Package.
 ;;^DD(9.493,.01,"DT")
 ;;=2850123
 ;;^DD(9.495,0)
 ;;=*MENU SUB-FIELD^^.02^2
 ;;^DD(9.495,0,"DT")
 ;;=2890928
 ;;^DD(9.495,0,"IX","B",9.495,.01)
 ;;=
 ;;^DD(9.495,0,"NM","*MENU")
 ;;=
 ;;^DD(9.495,0,"UP")
 ;;=9.4
 ;;^DD(9.495,.01,0)
 ;;=MENU^MF^^0;1^K:$L(X)>30!($L(X)<1) X
 ;;^DD(9.495,.01,1,0)
 ;;=^.1
 ;;^DD(9.495,.01,1,1,0)
 ;;=9.495^B
 ;;^DD(9.495,.01,1,1,1)
 ;;=S ^DIC(9.4,DA(1),"M","B",$E(X,1,30),DA)=""
 ;;^DD(9.495,.01,1,1,2)
 ;;=K ^DIC(9.4,DA(1),"M","B",$E(X,1,30),DA)
 ;;^DD(9.495,.01,3)
 ;;=This is the name of a menu-type option outside this namespace.
 ;;^DD(9.495,.01,4)
 ;;=N DO,DIC S DIC="^DIC(19,",DIC(0)="QE",D="B",DIC("S")="I $P(^(0),U,4)=""M""" D DQ^DICQ
 ;;^DD(9.495,.01,21,0)
 ;;=^^4^4^2920513^^^^
 ;;^DD(9.495,.01,21,1,0)
 ;;=This is the name of an option NOT in this namespace.  This option
 ;;^DD(9.495,.01,21,2,0)
 ;;=must be a menu, but it may not exist on this system.  You are
 ;;^DD(9.495,.01,21,3,0)
 ;;=entering this menu name because you want to add an option in this
 ;;^DD(9.495,.01,21,4,0)
 ;;=package to a menu that is in another.
 ;;^DD(9.495,.01,"DT")
 ;;=2890928
 ;;^DD(9.495,.02,0)
 ;;=OPTION^R*P19'^DIC(19,^0;2^S DIC("S")="I $P($P(^DIC(19,Y,0),U),$P(^DIC(9.4,DA(1),0),U,2))=""""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(9.495,.02,12)
 ;;=Select an option in this namespace.
 ;;^DD(9.495,.02,12.1)
 ;;=S DIC("S")="I $P($P(^DIC(19,Y,0),U),$P(^DIC(9.4,DA(1),0),U,2))="""""
 ;;^DD(9.495,.02,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.495,.02,21,1,0)
 ;;=This is an option which you wish to add to a menu in another namespace.
 ;;^DD(9.495,.02,"DT")
 ;;=2890928
 ;;^DD(9.4961,0)
 ;;=*INSTALLATION NOTES SUB-FIELD^^.01^1
 ;;^DD(9.4961,0,"NM","*INSTALLATION NOTES")
 ;;=
 ;;^DD(9.4961,0,"UP")
 ;;=9.49
 ;;^DD(9.4961,.01,0)
 ;;=INSTALLATION NOTES^W^^0;1^Q
 ;;^DD(9.4961,.01,"DT")
 ;;=2890426
 ;;^DD(9.4962,0)
 ;;=*SYSTEM REQUIREMENTS SUB-FIELD^^.01^1
 ;;^DD(9.4962,0,"NM","*SYSTEM REQUIREMENTS")
 ;;=
 ;;^DD(9.4962,0,"UP")
 ;;=9.49
 ;;^DD(9.4962,.01,0)
 ;;=SYSTEM REQUIREMENTS^W^^0;1^Q
 ;;^DD(9.4962,.01,"DT")
 ;;=2890426
 ;;^DD(9.4963,0)
 ;;=*PROGRAMMER NOTES SUB-FIELD^^.01^1
 ;;^DD(9.4963,0,"NM","*PROGRAMMER NOTES")
 ;;=
 ;;^DD(9.4963,0,"UP")
 ;;=9.49
 ;;^DD(9.4963,.01,0)
 ;;=PROGRAMMER NOTES^W^^0;1^Q
 ;;^DD(9.4963,.01,"DT")
 ;;=2890426
 ;;^DD(9.54,0)
 ;;=DESCRIPTION OF ENHANCEMENTS SUB-FIELD^NL^.01^1
