IBTRV2 ;ALB/AAS - CLAIMS TRACKING -  REVIEW ACTIONS ;19-JUL-93
 ;;2.0;INTEGRATED BILLING ;**60,210,266**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G EN^IBTRV
 ;
DA(IBTRN) ; -- Add Diagnosis
 ; -- bld = non-zero means not from main tracking  entry.
 ;
 N IBETYP
 D FULL^VALM1
 I IBETYP=2 D
 .I $P(IBTRND,"^",4) D ASK^IBTUTL4(IBTRN,2)
 .I '$P(IBTRND,"^",4) W !!,"Can not add diagnosis to outpatient visits prior to Check-out.",! D PAUSE^VALM1
 I IBETYP=1 D EN^IBTRE3(IBTRN)
 I '$G(BLD) D DRG,BLD^IBTRV
 S VALMBCK="R"
 Q
 ;
PROC(IBTRN,IBETYP,BLD) ; -- Add Procedures
 ; -- bld = non-zero means not from main tracking  entry.
 ;
 I '$G(BLD) D FULL^VALM1
 I IBETYP=2 W !!,"Outpatient Procedures should be entered using Add/Edit action in",!,"Appointment Management.",! D PAUSE^VALM1
 I IBETYP=1 D EN^IBTRE4(IBTRN)
 I '$G(BLD) D BLD^IBTRV
 S VALMBCK="R"
 Q
PROV(IBTRN,IBETYP,BLD) ; -- Add Procedures
 ; -- bld = non-zero means not from main tracking  entry.
 ;
 I '$G(BLD) D FULL^VALM1
 I IBETYP=1 D EN^IBTRE5(IBTRN)
 I IBETYP=2,$P(IBTRND,"^",4) D ASK^IBTUTL4(IBTRN,1)
 I IBETYP=3 W !!,"Provider information for Prescriptions comes from the pharmacy package silly.",! D PAUSE^VALM1
 I IBETYP=4 W !!,"Provider information for Prosthetics comes from the prothetics package silly.",! D PAUSE^VALM1
 I '$G(BLD) D BLD^IBTRV
 S VALMBCK="R"
 Q
 ;
DRG(IBTRN) ; -- entry point to compute drg
 ;    generally called from ad or pr above caller does own rebuild
 N DIR,DA,DR,DIC,DIE,IBALOS,IBDRG,IBTRVD,DGPMCA,DX
 S DGPMCA=$P(^IBT(356,IBTRN,0),"^",5) Q:'DGPMCA
 ;
 ; -- can't compute drg if no primary(dxls) diagnosis
 S DX=$O(^IBT(356.9,"ATP",DGPMCA,1,0)) Q:'DX
 D DISPDRG(DGPMCA)
 ;
 S DIR("?")="Answer 'Yes' to compute and store a new interim drg, answer 'No' to quit."
 S DIR("A")="Ready to compute New Interim DRG",DIR("B")="NO",DIR(0)="Y" D ^DIR K DIR
 I Y=1 D
 .S IBDRG=$$COMDRG(IBTRN) Q:+IBDRG<1
 .W !!,"DRG computes to: ",IBDRG,"  -  ",$$DRGTD^IBACSV(IBDRG,$$TRNDATE^IBACSV(IBTRN))
 .;
 .S IBDA=$O(^IBT(356.93,"AMVD",DGPMCA,DT,0))
 .I +IBDA<1 D
 ..K DD,DO
 ..S X=IBDRG
 ..S DIC="^IBT(356.93,",DIC(0)="L",DLAYGO=356.93
 ..S DIC("DR")=".02////"_DGPMCA_";.03////"_DT
 ..D FILE^DICN K DIC S IBDA=+Y
 .I +IBDA<1 Q
 .;
 .L +^IBT(356.93,IBDA):5 I '$T D LOCKED^IBTRCD1 Q
 .S DIE="^IBT(356.93,",DA=IBDA
 .S DR=".01////^S X=IBDRG;.01;S IBALOS=$$ALOS^IBTRV2(IBDRG,DT);.04//^S X=IBALOS;.05//^S X=$$DAYREM^IBTRV2(DGPMCA,IBALOS)"
 .D ^DIE W !
 .L -^IBT(356.93,+IBDA)
 Q
 ;
DAYREM(DGPM,LOS) ; -- Compute days remaining
 N IBX,DIFF S IBX=LOS
 S DIFF=$$FMDIFF^XLFDT(DT,+$G(^DGPM(DGPM,0))) S:DIFF<0 DIFF=-DIFF
 S IBX=LOS-DIFF
 I IBX<0 S IBX=0
 Q IBX\1
 ;
ALOS(X,Y) ; -- compute alos for drg for year
 ;    input x = pointer to drg file
 ;          y = date
 N IBDT,J
 S IBDT=0 F  S IBDT=$O(^IBE(356.5,"ADR",X,IBDT)) Q:'IBDT!(IBDT>Y)  D
 .S J=$O(^IBE(356.5,"ADR",X,IBDT,0))
 Q $P($G(^IBE(356.5,+$G(J),0)),"^",3)
 ;
COMDRG(IBTRN) ; -- compute drg from tracking file
 ;*********************************************************
 ; -- needed variable
 ;    SEX     = m or f
 ;    AGE     = whole number 0-120
 ;    ICDEXP  = patient died during this episode
 ;    ICDTRS  = patient transfered to acute care facility
 ;    ICDDMS  = patient had irregular discharge
 ;    ICDDX(  = diagnosis codes
 ;    ICDPRC( = procedure codes
 ;*********************************************************
 N SEX,ICDEXP,ICDTRS,ICDDMS,ICDDX,ICDPRC,DX,PR,I,J,IBCNT,ICDMDC,ICDDRG,ICDDATE
 S ICDDRG="",(ICDEXP,ICDTRS,ICDDMS,IBCNT)=0,DFN=$P(^IBT(356,IBTRN,0),"^",2)
 ;
 S SEX=$P($G(^DPT(DFN,0)),U,2)
 S AGE=$$FMDIFF^XLFDT(DT,$P($G(^DPT(DFN,0)),U,3))\365.25
 S DGPMA=$P(^IBT(356,IBTRN,0),"^",5) G:'DGPMA COMDRGQ
 ;
 S IBCNT=1,DX=0
 S ICDDX(1)=+$G(^IBT(356.9,+$O(^IBT(356.9,"ATP",DGPMA,+$O(^IBT(356.9,"ATP",DGPMA,0)),0)),0))
 F  S DX=$O(^IBT(356.9,"C",DGPMA,DX)) Q:'DX  S X=$G(^IBT(356.9,DX,0)) I $P(X,"^",4)=2 S IBCNT=IBCNT+1,ICDDX(IBCNT)=+X
 ;
 S IBCNT=0,J=""
 F  S J=$O(^IBT(356.91,"APP",DGPMA,J)) Q:'J  S PR="" F  S PR=$O(^IBT(356.91,"APP",DGPMA,J,PR)) Q:'PR  S IBCNT=IBCNT+1,ICDPRC(IBCNT)=+$G(^IBT(356.91,PR,0))
 ;
 I $D(ICDDX(1)) S ICDDATE=$$TRNDATE^IBACSV(IBTRN) D ^ICDDRG
COMDRGQ Q ICDDRG
 ;
DISPDRG(DGPMCA) ; -- Display drg's
 N I,J,IBDRG
 W !!,"Current Interim DRGs on File:"
 S I=0,IBCNT=0 F  S I=$O(^IBT(356.93,"AMVD",DGPMCA,I)) Q:'I  S J=0 F  S J=$O(^IBT(356.93,"AMVD",DGPMCA,I,J)) Q:'J  D
 .S IBDRG=$G(^IBT(356.93,J,0))
 .W !?5,$$DAT1^IBOUTL($P(IBDRG,"^",3)),?16,+IBDRG," - ",$$DRGTD^IBACSV(+IBDRG,$P(IBDRG,"^",3))
 .S IBCNT=IBCNT+1
 I IBCNT<1 W !?5,"None on file."
 W !
 Q
