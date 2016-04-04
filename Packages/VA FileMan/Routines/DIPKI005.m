DIPKI005 ;VEN/TOAD-PACKAGE FILE INIT ; 04-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.4901,.02,3)
 ;;=(No range limit on date)
 ;;^DD(9.4901,.02,"DT")
 ;;=3060905
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
 ;;^DD(9.54,0)
 ;;=DESCRIPTION OF ENHANCEMENTS SUB-FIELD^NL^.01^1
 ;;^DD(9.54,0,"NM","DESCRIPTION OF ENHANCEMENTS")
 ;;=
 ;;^DD(9.54,0,"UP")
 ;;=9.49
 ;;^DD(9.54,.01,0)
 ;;=DESCRIPTION OF ENHANCEMENTS^W^^0;1^Q
 ;;^DD(9.54,.01,21,0)
 ;;=^^2^2^2851008^^^^
 ;;^DD(9.54,.01,21,1,0)
 ;;=This is a description of the enhancements which are being distributed
 ;;^DD(9.54,.01,21,2,0)
 ;;=with this release.
 ;;^DD(9.54,.01,"DT")
 ;;=2840404
