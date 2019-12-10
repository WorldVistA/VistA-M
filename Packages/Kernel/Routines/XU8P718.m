XU8P718 ;OAK/RSD - Post install for patch XU*8*718 ;09/29/09  15:35
 ;;8.0;KERNEL;**718**;Jul 10, 1995;Build 5
 ;setup %ZOSF("TEST")
 D ONE^ZOSFONT("TEST")
 ;remove incorrect node that was set in patch 365
 K ^%ZOSF("GSEL;Select Globals")
 Q
