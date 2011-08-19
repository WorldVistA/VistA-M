DIFROMSV ;SFISC/DCL-DIFROM SERVER UTILITY,PKG REV DATA ;08:40 AM  6 Sep 1994
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
PRD(DIFRFILE,DIFRPRD) ;Package Revision Data for File
EN ;FILE,DATA
 ;Used to install Package Data from Post-Installation Routine
 Q:$G(DIFRFILE)'>1
 Q:'$D(^DD(DIFRFILE))
 S ^DD(DIFRFILE,0,"VRRV")=$G(DIFRPRD)
 Q
