SDAMBAE3 ;ALB/BOK/MJK - ADD/EDIT CON'T ;7/8/91  12:18 ;
 ;;5.3;Scheduling;**18,29,40,111,132,556**;Aug 13, 1993;Build 3
 ;
DUP ; -- inp transform to check for duplicate CPTs in ^DD(409.51,21:25,0)
 ;    variable '%' is passed and defined as the piece beinging edited
 ;
 F C=0:0 S C=$O(^SDV("AP",DA(1),C)) Q:'C  I $D(^SDV(DA(1),"CS",C,"PR")) S Y=^("PR") F I=1:1:5 I $S(C'=DA:1,1:I'=%),$P(Y,U,I)=X D DUPMES G DUPQ
DUPQ K C Q
 ;
DUPMES ;
 N SDX S SDX=$$CPT^ICPTCOD(X)
 W !?2,*7,"WARNING: '",$P(SDX,U,3),"' has already been entered for this",!?11,"patient on this VISIT DATE(Entry #",C,").",!!?11,"Procedure will be added again."
 K SDX
 Q
 ;
SCREEN ; -- screen logic for 409.51 proc fields
 ;  finds status for effective date DA(1)
 I $P($$CPT^ICPTCOD(Y,$P(DA(1),".")),U,7)
 Q
 ;
ID ; -- DIC("W") logic for amb proc look-ups
 N SDICPT,SDICPT1,SDIX
 S SDICPT1=$$CPT^ICPTCOD(Y,D)
 Q:SDICPT1<0
 W ?4,$P(SDICPT1,U,3)
 I '$P(SDICPT1,U,7) W !?10,"** INACTIVE **"
 ;
 ;  print code description
 S SDICPT=$$CPTD^ICPTCOD(Y,"SDICPT") F SDIX=1:1:SDICPT W !?10,SDICPT(SDIX)
 ;  set $TEST
 W !?9 I +$$CPT^ICPTCOD(Y)>0
 Q
