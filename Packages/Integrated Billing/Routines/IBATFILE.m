IBATFILE ;LL/ELZ - TRANSFER PRICING FILLING  ; 22-JAN-1999
 ;;2.0;INTEGRATED BILLING;**115,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
PAT(DA,IBFAC,IBOVER) ; files patient in transfer pricing returns dfn
 Q:'$G(DA) 0
 I $D(^IBAT(351.6,DA,0)) Q DA
 N DO,DD,DIC,X,DINUM
 S DIC="^IBAT(351.6,",DIC(0)="",X=DA,DINUM=DA
 S DIC("DR")=".02///"_$$NOW^XLFDT_";.03////"_+$S($G(IBFAC):IBFAC,1:$$PPF^IBATUTL(DA))_";.04///1"_$S($D(IBOVER):";.1////"_+IBOVER,1:"")
 D FILE^DICN
 Q $S(Y>0:Y,1:0)
UPPPF(DA,PPF) ; updates a patient's enrolled facility
 I '$G(DA)!('$G(PPF))!('$D(^IBAT(351.6,DA))) Q
 N DIE,DR
 S DIE="^IBAT(351.6,",DR=".03////"_+PPF D ^DIE
 Q
ADM(DFN,IBADMDT,IBPREF,IBSOURCE) ; - files admissions
 ; IBADMDT=admission date, IBPREF=enrolled facility
 ; IBSOURCE=source (movement ien;DGPM(
 I '$G(DFN)!('$G(IBADMDT))!('$G(IBPREF))!($G(IBSOURCE)="") Q 0
 Q $$NEW(DFN,IBADMDT,IBPREF,IBSOURCE)
DIS(DA,IBDISDT,IBPTF,IBDISM) ; - files discharges
 ; DA=transaction ien in 351.61, IBDISDT=discharge date
 ; IBPTF=ptf pointer, IBDISM=discharge movement pointer
 I '$G(DA)!('$G(IBDISDT))!('$G(IBPTF))!('$G(IBDISM)) Q 0
 N DIE,DR
 S DIE="^IBAT(351.61,"
 S DR=".05////C;.1////"_IBDISDT_";1.07////"_IBPTF_";1.08////"_IBDISM
 L +^IBAT(351.61,DA):10 I '$T Q "0^Transaction Locked"
 D ^DIE L -^IBAT(351.61,DA)
 Q DA
DISC(DA) ; - deletes discharge data
 ; DA=transaction ien in 351.61
 N DIE,DR Q:'$G(DA) 0
 S DIE="^IBAT(351.61,"
 S DR=".05////E;.1///@;1.08///@"
 L +^IBAT(351.61,DA):10 I '$T Q "0^Transaction Locked"
 D ^DIE L -^IBAT(351.61,DA)
 Q DA
INPT(IBIEN,IBDRG,IBDRGA,IBLOS,IBHIGH,IBOUT,IBOUTR) ; - file remaining inpt
 ; IBIEN=transaction ien in 351.61, IBDRG=DRG pointer
 ; IBDRGA=DRG amount,IBLOS=inpatient LOS,IBHIGH=high trim days
 ; IBOUT=outlier days,IBOUTR=outlier rate
 I '$G(IBIEN)!('$G(IBLOS))!('$D(IBHIGH))!('$D(IBOUT)) Q 0
 N DIE,X,Y,DR
 S DIE="^IBAT(351.61,",DA=IBIEN
 S DR="1.03////"_IBLOS_";1.04////"_IBHIGH_";1.05////"_IBOUT
 S:$G(IBDRG) DR=DR_";1.01///"_IBDRG
 S:$G(IBDRGA) DR=DR_";1.02////"_IBDRGA
 S:$G(IBOUTR) DR=DR_";1.06////"_IBOUTR
 L +^IBAT(351.61,IBIEN):10 I '$T Q "0^Transaction Locked"
 D ^DIE,TOTAL^IBATCM(IBIEN) I $P($G(^IBAT(351.61,IBIEN,6)),"^",2) D
 . S DR=";.05////P;.13////"_DT D ^DIE
 L -^IBAT(351.61,IBIEN)
 Q IBIEN
OUT(DFN,IBEDT,IBPREF,IBSOURCE,IBPROC) ; - files outpatient data
 ; DFN=dfn for patient, IBEDT=event date, IBPREF=enrolled facility
 ; IBSOURCE=source (outpatient encounter ien;SCE(
 ; IBPROC=procedures (by ref in array)
 I '$G(DFN)!('$G(IBEDT))!('$G(IBPREF))!($G(IBSOURCE)="") Q 0
 N IBIEN,IBX,Y,IBPRICE
 S IBIEN=$$NEW(DFN,IBEDT,IBPREF,IBSOURCE) I 'IBIEN Q IBIEN
 L +^IBAT(351.61,IBIEN):10 I '$T Q "0^Transaction Locked"
 S IBIEN=$$PROC(IBIEN,.IBPROC,.IBPRICE) ; file procedures
 I IBIEN<1 L -^IBAT(351.61,IBIEN) Q "0^Unable to file procedures"
 S DIE="^IBAT(351.61,",DA=IBIEN
 S DR=".1////"_IBEDT_";.05////"_$S($G(IBPRICE):"C",1:"P;.13////"_DT)
 D ^DIE,TOTAL^IBATCM(IBIEN) L -^IBAT(351.61,IBIEN)
 Q IBIEN
UPDATE(IBIEN,IBPROC) ; -- updates procedures
 ; IBIEN=351.61 ien, IBPROC=procedures by ref like above
 Q:'$G(IBIEN) 0
 N IBX,IBPRICE,DIE,DA,DR,X,Y
 S IBIEN(0)=^IBAT(351.61,IBIEN,0),IBEDT=$P(IBIEN(0),"^",4)
 ; if approved, cancel and create a new one
 I $P(IBIEN(0),"^",5)="A" D  Q IBIEN
 . S IBIEN=$$CANC(IBIEN)
 . S IBIEN=$$OUT($P(IBIEN(0),"^",2),IBEDT,$P(IBIEN(0),"^",11),$P(IBIEN(0),"^",12),.IBPROC)
 L +^IBAT(351.61,IBIEN):10 I '$T Q "0^Transaction Locked"
 ; first clean out procedures there
 S IBX=0 F  S IBX=$O(^IBAT(351.61,IBIEN,3,IBX)) Q:IBX<1  S DIK="^IBAT(351.61,"_IBIEN_",3,",DA(1)=IBIEN,DA=IBX D ^DIK
 S IBIEN=$$PROC(IBIEN,.IBPROC,.IBPRICE) ; file procedures
 I IBIEN<1 L -^IBAT(351.61,IBIEN) Q "0^Unable to file procedures"
 S DIE="^IBAT(351.61,",DA=IBIEN
 S DR=".1////"_IBEDT_";.05////"_$S($G(IBPRICE):"C",1:"P;.13////"_DT)
 D ^DIE,TOTAL^IBATCM(IBIEN) L -^IBAT(351.61,IBIEN)
 Q IBIEN
RX(DFN,IBEDT,IBPREF,IBSOURCE,IBDRUG,IBQTY,IBCOST) ; - files pharmacy data
 ; DFN=dfn for patient, IBEDT=event date, IBPREF=enrolled facility
 ; IBSOURCE=source (prescription ien;PSRX(;refill #
 ; IBDRUG=ien from drug file
 ; IBQTY=quantity of drug, IBCOST=drug cost
 I '$G(DFN)!('$G(IBEDT))!('$G(IBPREF))!($G(IBSOURCE)="")!('$G(IBDRUG))!('$G(IBQTY)) Q 0
 N IBIEN
 S IBIEN=$$NEW(DFN,IBEDT,IBPREF,IBSOURCE) I 'IBIEN Q IBIEN
 S DIE="^IBAT(351.61,",DA=IBIEN
 S DR=".1////"_+IBEDT_";4.01////"_+IBDRUG_";4.02////"_+IBQTY_";.05////"_$S($G(IBCOST):"P;4.03////"_+IBCOST_";.13////"_DT,1:"C")
 L +^IBAT(351.61,IBIEN):10 I '$T Q "0^Transaction Locked"
 D ^DIE D:$G(IBCOST) TOTAL^IBATCM(IBIEN)
 L -^IBAT(351.61,IBIEN)
 Q IBIEN
 ;
RMPR(DFN,IBEDT,IBPREF,IBSOURCE,IBPROS,IBCOST) ; - files prost. data
 ; DFN=dfn for patient, IBEDT=event date, IBPREF=enrolled facility
 ; IBSOURCE=source (prost ien;RMPR(660,
 ; IBPROS=ien from file 661 - removed in 389 no longer valid
 ; IBCOST=item cost
 I '$G(DFN)!('$G(IBEDT))!('$G(IBPREF))!($G(IBSOURCE)="") Q 0
 N IBIEN
 S IBIEN=$$NEW(DFN,IBEDT,IBPREF,IBSOURCE) I 'IBIEN Q IBIEN
 S DIE="^IBAT(351.61,",DA=IBIEN
 S DR=".1////"_+IBEDT_";.05////"_$S($G(IBCOST):"P;4.05////"_+IBCOST_";.13////"_DT,1:"C")
 L +^IBAT(351.61,IBIEN):10 I '$T Q "0^Transaction Locked"
 D ^DIE D:$G(IBCOST) TOTAL^IBATCM(IBIEN)
 L -^IBAT(351.61,IBIEN)
 Q IBIEN
 ;
CANC(DA) ; - used to cancel any transaction
 N DIE,DR,X,Y Q:'$G(DA)
 S DIE="^IBAT(351.61,",DR=".05///X" D ^DIE
 Q
DEL(DA) ; - used to delete a transaction (only valid for inpatients or rx)
 N DIK,DR,X,Y,Z Q:'$G(DA)
 S Z=$G(^IBAT(351.61,DA,0)) Q:'Z
 Q:$P(Z,"^",12)["SCE("
 S DIK="^IBAT(351.61," D ^DIK
 Q
NEW(DFN,IBEDT,IBPREF,IBSOURCE) ; - creates new transaction and returns ien
 N IBIEN,IBSITE,DD,DO,DIC,X,Y,DINUM,DLAYGO,DIE,DA,DR
 S IBSITE=$$SITE^IBATUTL
 L +^IBAT(351.6,DFN):10 I '$T Q "0^Patient file Locked"
 L +^IBAT(351.61,0):10 I '$T Q "0^Transaction File Locked"
 S IBIEN=$P(^IBAT(351.61,0),"^",3)+1
 F IBIEN=IBIEN:1 Q:'$D(^IBAT(351.61,"B",IBSITE_IBIEN))
 S DIC="^IBAT(351.61,",DIC(0)="",X=IBSITE_IBIEN,DINUM=IBIEN,DLAYGO=351.61
 S DIC("DR")=".02////"_+DFN_";.03////"_+DT_";.04////"_+IBEDT_";.05////E;.09////"_+IBEDT_";.11////"_+IBPREF_";.12////^S X=IBSOURCE"
 D FILE^DICN I +Y<1 L -(^IBAT(351.61,0),^IBAT(351.6,DFN)) Q "0^Unable to add new transaction"
 S DIE="^IBAT(351.6,",DA=+DFN
 S DR=$S(IBSOURCE["DGPM":".05",IBSOURCE["SCE":".06",IBSOURCE["RMPR":".11",1:".07")_"////"_+IBEDT
 I $P(^IBAT(351.6,DFN,0),"^",+(DR*100))<IBEDT D ^DIE
 L -(^IBAT(351.61,0),^IBAT(351.6,DFN))
 Q IBIEN
PROC(IBIEN,IBPROC,IBPRICE) ; files procedures
 N X,Y
 S Y=1,IBX=0 F  S IBX=$O(IBPROC(IBX)) Q:IBX=""!(+Y<1)  D
 . N DIC,X,DA,DD,DO
 . S DIC="^IBAT(351.61,"_IBIEN_",3,",DIC(0)="L"
 . S X=IBX,DA(1)=IBIEN
 . ;S DIC("P")=$P(^DD(351.61,3,0),"^",2) ; no longer required with fm22
 . S DIC("DR")=".02////"_$P(IBPROC(IBX),"^")
 . I $P(IBPROC(IBX),"^",2) S DIC("DR")=DIC("DR")_";.03////"_$P(IBPROC(IBX),"^",2)
 . E  S IBPRICE=1
 . D FILE^DICN
 I +Y<1 L -^IBAT(351.61,IBIEN) Q "0^Unable to file procedures"
 Q IBIEN
DX(IBIEN,IBPTF) ; - files dx info
 Q IBIEN
 N IBX,Y S Y=1,IBX="" F  S IBX=$O(IBDX(IBX)) Q:IBX=""!(+Y<1)  D
 . N DD,DO,DIC,DINUM,X
 . S DIC="^IBAT(351.61,"_IBIEN_",2,",DIC(0)="",X=$P(IBDX(IBX),"^")
 . ;S DA(1)=IBIEN,DIC("P")=$P(^DD(351.61,2,0),"^",2) D FILE^DICN
 . ; no longer required with fm22
 . S DA(1)=IBIEN D FILE^DICN
 Q $S(+Y<1:"0^Unable to file diagnosis's",1:IBIEN)
 ;
INIT ; called to possibly initialize the 351.6 file if not done
 N IBS,ZTRTN,ZTDESC,ZTIO,ZTSK,X,Y
 ;
 Q:$O(^IBAT(351.6,0))  ; already populated
 ;
 ; is Transfer Pricing active or not for any
 S IBS=$G(^IBE(350.9,1,10))
 I '$P(IBS,"^",2),'$P(IBS,"^",3),'$P(IBS,"^",4),'$P(IBS,"^",5) Q
 ;
 ; queue off job
 W !!,"It appears you have never used Transfer Pricing before.  I need to populate",!,"the Transfer Pricing patient file.  Please select a date/time to do this.",!
 S ZTRTN="ADDTP^IBATFILE",ZTDESC="Initializing Transfer Pricing Patient File",ZTIO="" D ^%ZTLOAD
 I $G(ZTSK) W !,"Task Queued #",ZTSK
 ;
 Q
ADDTP ; Add Transfer Pricing patients to file #351.6
 ;
 N DFN,IBADM,IBDFN,IBPREF,IBADMDT,IBX
 ;
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .;
 .S IBDFN=$$TPP^IBATUTL(DFN)
 .Q:'IBDFN
 .;
 .; - see if they are admitted
 .S IBADM=$G(^DPT(DFN,.105))
 .I IBADM D
 ..S IBPREF=+$P($G(^IBAT(351.6,DFN,0)),"^",3)
 ..S IBADMDT=+$G(^DGPM(IBADM,0))
 ..S IBX=$$ADM(DFN,IBADMDT,IBPREF,IBADM_";DGPM(")
 ;
 Q
