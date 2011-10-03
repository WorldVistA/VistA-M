SDV53PP ;alb/mjk - SD Pre-Init Driver for v5.3 ; 3/26/93
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
EN ; -- main entry point
 D SCE
ENQ Q
 ;
SCE ; -- check if new global is set up
 G SCEQ:$D(^SCE)
 D LINE^DGVPP
 W !,"The new ^SCE global must be defined using %GLOMAN before the install can start!",!,"Please refer to the Install Guide for details.",*7
 D LINE^DGVPP
 K DIFQ
SCEQ Q
 ;
 ;
