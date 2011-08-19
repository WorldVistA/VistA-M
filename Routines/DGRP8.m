DGRP8 ;ALB/MIR - FAMILY DEMOGRAPHIC SCREEN DISPLAY ; 12 FEB 92
 ;;5.3;Registration;**45,54,487**;Aug 13, 1993
 ;
 ; Screen to display current spouse and dependents
 ;
EN I $D(DVBGUI) G ENQ ; IF CALLED BY CAPRI, SKIP SCREEN 8
 ;
 ; Start display
 N DGMTYPT,DGMTCP,DGXR,DGSCR8
 S DGSCR8=1 D EN^DGDEP
 ;
ENQ S X=132 X ^%ZOSF("RM")
 N I,X F I=9:1 S X=$E(DGRPVV,I) Q:'X
 S DGRPANN="^"_I
 G JUMP^DGRPP ; jumps to next 'on' screen
