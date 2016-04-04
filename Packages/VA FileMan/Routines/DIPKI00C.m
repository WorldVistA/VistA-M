DIPKI00C ;VEN/TOAD-PACKAGE FILE INIT ; 22-DEC-1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
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
