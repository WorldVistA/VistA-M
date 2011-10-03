IBCSCH2 ;ALB/DLS - Continuation of routine IBCSCH ;12 JUN 2007
 ;;2.0;INTEGRATED BILLING;**374**;21-MAR-94;Build 16
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
DISPPRV(IBIFN) ; Display provider information: interactive - user selects provider
 N DIC,DA,X,Y,IBI,IBJ,IBW,IBPRV,IBPX,IBDT,IBARR,IBNPISTR,IBNPI,IBPRVTAX,IBTAXFLG
 N IBPRVDAT,IBTAXID,IBTAXEFF,IBTAXTRM,IBTAXX12
 W !!,"This is a display of provider specific information."
 D SPECIFIC^IBCEU5(IBIFN)
 S IBDT=+$G(^DGCR(399,+$G(IBIFN),"U")) I 'IBDT S IBDT=DT
 ;
 F IBI=1:1 W ! S DIC("A")="Select PROVIDER NAME: ",DIC="^VA(200,",DIC(0)="AEQM" D ^DIC Q:Y'>0  D
 . S IBPRV=Y
 . W !!,$TR($J(" ",IOM)," ","-")
 . S IBPX=$$ESBLOCK^XUSESIG1(+IBPRV)
 . W !," Signature Name: ",$P(IBPX,U,1)
 . W !,"Signature Title: ",$P(IBPX,U,3)
 . W !,"         Degree: ",$P(IBPX,U,2)
 . ;
 . ; PRXM/DLS - Patch 374. Adding NPI to Signature information.
 . S IBNPISTR=$$NPI^XUSNPI("Individual_ID",+IBPRV)                               ; Get NPI information.
 . S IBNPI=$P(IBNPISTR,U)                                                        ; Get NPI.
 . W !,"            NPI: ",$S(IBNPI>0:IBNPI,1:"")                                ; Write NPI.
 . ;
 . S IBPX=$$PRVLIC^IBCU1(+IBPRV,IBDT,.IBARR)                                     ; Get License Info.
 . W !!,"     License(s): " D
 . . I IBPX'>0 W "None Active on ",$$FMTE^XLFDT(IBDT,2) Q
 . . S IBJ=0,IBW=0 F  S IBJ=$O(IBARR(IBJ)) Q:'IBJ  D
 . . . S IBPX=IBARR(IBJ),IBPX=$P($G(^DIC(5,+IBPX,0)),U,2)_": "_$P(IBPX,U,2)
 . . . I (IBW+$L(IBPX))>61 W !,?17 S IBW=0
 . . . W IBPX,"  " S IBW=IBW+$L(IBPX)+2
 . ;
 . ; PRXM/DLS - Display Person Class/Taxonomy Information.
 . S IBTAXFLG=0                                                                  ; Init to 0, set to 1 if Person Class info found.
 . S IBPRVTAX=0                                                                  ; Loop through prov's Person Class entries.
 . F  S IBPRVTAX=$O(^VA(200,+IBPRV,"USC1",IBPRVTAX)) Q:'IBPRVTAX  D
 . . ; Get Basic Information
 . . S IBTAXID=$$GET1^DIQ(200.05,IBPRVTAX_","_+IBPRV_",",.01,"I") Q:IBTAXID=""   ; Person Class IEN.
 . . S IBTAXEFF=$$GET1^DIQ(200.05,IBPRVTAX_","_+IBPRV_",",2,"I")                 ; Person Class Eff Date.
 . . S IBTAXTRM=$$GET1^DIQ(200.05,IBPRVTAX_","_+IBPRV_",",3,"I") ;I IBTAXTRM=""   ; Person Class Term Date.
 . . I IBTAXTRM="" S IBTAXTRM=9999999
 . . ; See if claim beginning service date falls within Eff date range. If so, proceed.
 . . I (IBTAXEFF'>IBDT),(IBTAXTRM>IBDT) D
 . . . S IBTAXFLG=1                                                              ; A Person Class found, set flag to 1.
 . . . ; Get Detailed Information and Display.
 . . . S IBPX=$$IEN2DATA^XUA4A72(IBTAXID)                                        ; Person Class Details.
 . . . S IBTAXX12=$$GET1^DIQ(8932.1,IBTAXID_",",6)                               ; Get X12 Code.
 . . . W !
 . . . W !,"   Person Class: ",$P(IBPX,U,6)                                      ; Display Person Class Name.
 . . . W !,"  PROVIDER TYPE: ",$P(IBPX,U)                                        ; Display Provider Type.
 . . . W !," CLASSIFICATION: ",$P(IBPX,U,2)                                      ; Display Classification.
 . . . W !," SPECIALIZATION: ",$P(IBPX,U,3)                                      ; Display Specialization.
 . . . W !,"       TAXONOMY: ",IBTAXX12,$S(IBTAXX12'="":" ("_IBTAXID_")",1:"")   ; Display X12 Code and Internal Code (IEN).
 . . . W !,"      EFFECTIVE: ",$$FMTE^XLFDT(IBTAXEFF,2)                          ; Display EFF Date.
 . . . I IBTAXTRM'=9999999 W " - ",$$FMTE^XLFDT(IBTAXTRM,2)                      ; Display TRM Date, if it exists.
 . ; If no Person Class entries exists for this Provider, notate it.
 . I 'IBTAXFLG W !!,"   Person Class: None Active on ",$$FMTE^XLFDT(IBDT,2)
 . S IBPX=$$PRVTYP^IBCRU6(+IBPRV,+IBDT)
 . W !!,"RC Provider Group: ",$S(+IBPX:$P(IBPX,U,3)_", "_$P(IBPX,U,5)_"%",1:"None")
 . W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
DISPNVA(IBIFN) ; Display Non-VA individual provider information.
 N IBDT,IBI,IBNVFLG,IBNVID,IBNVTX,IBNVTX2,IBNVTXID,IBNVSL,X,Y,DIC,DA,IBTAXX12,IBPX
 S IBDT=+$G(^DGCR(399,+$G(IBIFN),"U")) I 'IBDT S IBDT=DT
 ; Select Non-VA Provider
 F IBI=1:1 W ! S DIC("A")="Select NON-VA PROVIDER NAME: ",DIC="^IBA(355.93,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)=2" D ^DIC Q:Y'>0  D
 . S IBNVID=+Y W !!,$TR($J(" ",IOM)," ","-")
 . W !," Signature Name: ",$$GET1^DIQ(355.93,IBNVID_",",.01)
 . W !,"            NPI: ",$$GET1^DIQ(355.93,IBNVID_",",41.01)
 . W !
 . S IBNVSL=$$GET1^DIQ(355.93,IBNVID_",",.12)                                        ; Get and Display License info.
 . W !,"     License(s): ",$S(IBNVSL'="":IBNVSL,1:"None Active on "_$$FMTE^XLFDT(IBDT,2))
 . W !
 . S IBNVTX=""
 . S IBNVFLG=0
 . F  S IBNVTX=$O(^IBA(355.93,IBNVID,"TAXONOMY","D",IBNVTX),-1) Q:IBNVTX=""  D       ; Loop through prov's Person Class X-Ref.
 . . S IBNVTX2=""
 . . F  S IBNVTX2=$O(^IBA(355.93,IBNVID,"TAXONOMY","D",IBNVTX,IBNVTX2)) Q:'IBNVTX2  D
 . . . I $$GET1^DIQ(355.9342,IBNVTX2_","_IBNVID_",",.03,"I")="A" D                   ; Proceed if the Person Class is Active.
 . . . . S IBNVFLG=1
 . . . . S IBNVTXID=$$GET1^DIQ(355.9342,IBNVTX2_","_IBNVID_",",.01,"I")
 . . . . ; Get Detailed Information and Display.
 . . . . S IBPX=$$IEN2DATA^XUA4A72(IBNVTXID)                                         ; Person Class Details.
 . . . . S IBTAXX12=$$GET1^DIQ(8932.1,IBNVTXID_",",6)                                ; Get X12 Code.
 . . . . W !,"   Person Class: ",$P(IBPX,U,6)                                        ; Display Person Class Name.
 . . . . W $S($G(IBNVTX)=1:" (Primary)",1:" (Secondary)")
 . . . . W !,"  PROVIDER TYPE: ",$P(IBPX,U)                                          ; Display Provider Type.
 . . . . W !," CLASSIFICATION: ",$P(IBPX,U,2)                                        ; Display Classification.
 . . . . W !," SPECIALIZATION: ",$P(IBPX,U,3)                                        ; Display Specialization.
 . . . . W !,"       TAXONOMY: ",IBTAXX12,$S(IBTAXX12'="":" ("_IBNVTXID_")",1:""),!  ; Display X12 Code and Internal Code (IEN).
 . I 'IBNVFLG W !,"   Person Class: None Active on ",$$FMTE^XLFDT(IBDT,2),!
 . W $TR($J(" ",IOM)," ","-"),!
 Q
