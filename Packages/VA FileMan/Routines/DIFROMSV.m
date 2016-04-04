DIFROMSV ;SFISC/DCL-DIFROM SERVER UTILITY,PKG REV DATA ;08:40 AM  6 Sep 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
PRD(DIFRFILE,DIFRPRD) ;Package Revision Data for File
EN ;FILE,DATA
 ;Used to install Package Data from Post-Installation Routine
 Q:$G(DIFRFILE)'>1
 Q:'$D(^DD(DIFRFILE))
 S ^DD(DIFRFILE,0,"VRRV")=$G(DIFRPRD)
 Q
