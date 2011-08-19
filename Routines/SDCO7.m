SDCO7 ;ALB/RMO - Miscellaneous Actions - Check Out; 14 APR 1993 10:00 am
 ;;5.3;Scheduling;**132,149,175,193**;Aug 13, 1993
 ;
CD ;Entry point for SDCO DATE CHANGE protocol
 ; Input  -- SDOE
 N DFN,SDCL,SDCOQUIT,SDDA,SDOE0,SDORG,SDT
 S VALMBCK=""
 ;
 ; -- if OLD encounter, quit
 IF '$$EDITOK^SDCO3($G(SDOE),1) G CDQ
 ;
 S SDOE0=$G(^SCE(+SDOE,0)),SDT=+^(0),DFN=+$P(SDOE0,"^",2),SDCL=+$P(SDOE0,"^",4),SDORG=+$P(SDOE0,"^",8),SDDA=+$P(SDOE0,"^",9)
 I SDORG'=1 W !!,*7,">>> Only appointments have a check out date to edit." D PAUSE^VALM1 G CDQ
 I '$P($G(^SC(SDCL,"S",SDT,1,SDDA,"C")),"^",3) W !!,*7,">>> No check out date for this appointment." D PAUSE^VALM1 G CDQ
 D DT^SDCO1(DFN,SDT,SDCL,SDDA,1,.SDCOQUIT)
 S VALMBCK="R"
CDQ Q
 ;
PD ;Entry point for SDCO PATIENT DEMOGRAPHICS protocol
 ; Input  -- SDOE
 S VALMBCK=""
 D FULL^VALM1
 W !!,VALMHDR(1),!
 D DEM^SDCOAM(+$P($G(^SCE(+SDOE,0)),"^",2))
 S VALMBCK="R"
PDQ Q
 ;
DC ;Entry point for SDCO DISCHARGE CLINIC protocol
 ; Input  -- SDOE
 N DFN,SDCLN,SDFN,SDOE0
 S VALMBCK=""
 S SDOE0=$G(^SCE(+SDOE,0)),SDFN=+$P(SDOE0,"^",2)
 S:$P(SDOE0,"^",4) SDCLN=+$P(SDOE0,"^",4)
 D FULL^VALM1
 W !!,VALMHDR(1),!
 D DIS^SDCOAM(SDFN,$G(SDCLN))
 S VALMBCK="R"
DCQ Q
 ;
GAF ;Entry point for SDCO GAF protocol
 ;Input -- SDOE
 S VALMBCK=""
 D FULL^VALM1
 W !!
 N DFN,SDCL,SDELIG
 S DFN=+$P($G(^SCE(+SDOE,0)),"^",2)
 S SDCL=+$P($G(^SCE(+SDOE,0)),"^",4)
 S SDATA=$G(^DPT(DFN,"S",SDT,0))
 S SDELIG=$$ELSTAT^SDUTL2(DFN)
 ;
 I '$$MHCLIN^SDUTL2(SDCL)!($$COLLAT^SDUTL2(SDELIG))!($P(SDATA,U,11)) D  S VALMBCK="R" Q
 . S DIR(0)="FAO"
 . S DIR("A",1)="A GAF Score is not applicable to this appointment!"
 . S DIR("A")="Press any key to continue"
 . D ^DIR K DIR
 ;
 N SDGSCR S SDGSCR=$$NEWGAF^SDUTL2(DFN)
 I +$P(SDGSCR,U,5)>0 W !,"Warning: Patient is deceased."
 I '+SDGSCR D
 . W !,"Current GAF: "_+$P(SDGSCR,U,2)
 . W $S($P(SDGSCR,U,3)>0:", from "_$$FMTE^XLFDT($P(SDGSCR,U,3),"D"),1:", Date Unavailable")
 ;
 D EN^SDGAF(DFN)
 D HDR^SDCO ; reset header after entering new GAF score
 S VALMBCK="R"
GAFQ Q
