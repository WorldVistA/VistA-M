XU8P661 ;OAK/RD - Post install for patch XU*8*661
 ;;8.0;KERNEL;**661**;Jul 10, 1995;Build 29
 ;setup %ZOSF("TEST")
 D ONE^ZOSFONT("TEST")
 ;remove incorrect node that was set in patch 365
 K ^%ZOSF("GSEL;Select Globals")
 Q
