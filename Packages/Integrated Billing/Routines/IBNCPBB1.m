IBNCPBB1 ;ALB/BDB - CONTINUATION OF ECME BACKBILLING ;24-JUN-2003
 ;;2.0;INTEGRATED BILLING;**384,550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
PROCESS ;
 N RES,IBY,IBD,IBRX,IBFIL,IBERR,IBBIL,IBPAT,IBDRUG,IBINS,IBDT,IBQ
 S IBERR=0
 S IBY=0 F  S IBY=$O(IBSEL(IBY)) Q:'IBY  D
 . S IBD=$G(@IBREF@(IBY)) Q:IBD=""
 . S IBRX=$P(IBD,U),IBFIL=+$P(IBD,U,3),IBBIL=$P(IBD,U,6)
 . W !,"Submitting Rx# ",$P(IBD,U,2) W:IBFIL "Refill# ",IBFIL W:'IBFIL " (original fill)" W " ..."
 . I IBBIL,'$P($G(^DGCR(399,IBBIL,"S")),U,16) D  S IBERR=IBERR+1 Q
 .. W !," *** Rx# ",$P(IBD,U,2)," was previously billed."
 .. W !," Please cancel the Bill No ",$P($G(^DGCR(399,IBBIL,0)),U)," before submitting the claim"
 . ; Sensitive Diagnosis Drug/ROI Check
 . S IBDRUG=$P(IBD,U,5)
 . I $$SENS^IBNCPDR(IBDRUG) D  Q:'IBQ
 .. S IBPAT=$$FILE^IBRXUTL(IBRX,2)
 .. S IBDT=$P(IBD,U,4)
 .. I '$$INSUR^IBBAPI(IBPAT,IBDT,"P",.IBANY,1) S IBQ=1 Q
 .. S IBINS=+$G(IBANY("IBBAPI","INSUR",1,1))
 .. S IBQ=$$ROICHK^IBNCPDR4(IBPAT,IBDRUG,IBINS,IBDT) D:IBQ ROICLN^IBNCPDR4("",IBRX,IBFIL)
 .. I 'IBQ S IBERR=IBERR+1
 . S RES=$$SUBMIT^IBNCPDPU(IBRX,IBFIL) W "  ",$S(+RES=0:"Sent through ECME",1:"Not sent")
 . I +RES'=0 W !?5,"*** ECME returned status: ",$$STAT^IBNCPBB(RES) S IBERR=IBERR+1
 I 'IBERR W !!,"The selected Rx(s) have been submitted to ECME",!,"for electronic billing"
 Q
 ;
 ;IBNCPBB1
