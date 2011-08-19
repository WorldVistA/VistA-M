SDOEUT ;ALB/MJK - ACRP Misc APIs For An Encounter ;8/12/96
 ;;5.3;Scheduling;**131,132,211**;Aug 13, 1993
 ;
VIEN(SDOE) ; -- get visit ien from valid encounter
 Q +$P($G(^SCE(SDOE,0)),U,5)
 ;
OLD(SDOE) ; -- use old data?
 ;
 ; -- is this a 'new' encounter (since PCE)
 IF $$DATE^SCDXUTL(+$G(^SCE(+SDOE,0))) Q 0
 ;
 ; -- has old data has been converted
 IF $$CONV(.SDOE) Q 0
 ;
 Q 1
 ;
CONV(SDOE) ; -- has old encounter been converted
 ;
 ; -- has encounter been processd by conversion?
 IF $P($G(^SCE(+SDOE,"CNV")),U,4) Q 1
 ;
 Q 0
 ;
POST ; -- post error action logic
 ;W !,"Error:",!
 ;ZW DIPI ZW DIPE
 Q
 ;
