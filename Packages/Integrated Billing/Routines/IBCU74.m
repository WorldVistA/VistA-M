IBCU74 ;OAK/ELZ - INTERCEPT SCREEN INPUT OF PROCEDURE CODES (CONT) ;6-JAN-04
 ;;2.0;INTEGRATED BILLING;**228,260,339**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
DATA(IBP) ; this is used to add data when new procedures are added for
 ; inpatient cases
 N IBX,IBY,IB1,IB2,IBC,DO,X,DIC,DIE,DA,DR,IB9,Y,IBQ,IBDR,IBZ,IBS
 S DR="" I '$P(IBP,"^",2)!('DGPROCDT) Q
 S IB1=0 F  S IB1=$O(^UTILITY($J,"IB",IB1)) Q:IB1<1!(DR)  I $P($G(^UTILITY($J,"IB",IB1,1)),"^",2)=DGPROCDT D
 . S IB2=0 F  S IB2=$O(^UTILITY($J,"IB",IB1,IB2)) Q:IB2<1!(DR)  S IBY=$G(^UTILITY($J,"IB",IB1,IB2)) I +IBY=+$P(IBP,"^",2) D  Q
 .. F IBX=6:1:9 I $P(IBY,"^",IBX) D
 ... F IBC=1:1:4 Q:'$D(^IBA(362.3,"AO",IBIFN,IBC))
 ... I $D(^IBA(362.3,"AO",IBIFN,IBC)) Q
 ... S IB9=$$ICD9^IBACSV($P(IBY,"^",IBX),DGPROCDT)
 ... W !?10,"Adding associated dx: ",$P(IB9,"^"),"  ",$P(IB9,"^",3)
 ... ; first check to see if dx on bill already
 ... S Y=$O(^IBA(362.3,"AIFN"_IBIFN,$P(IBY,"^",IBX),0))
 ... I 'Y S DIC="^IBA(362.3,",DIC(0)="",X=$P(IBY,"^",IBX),DIC("DR")=".02////^S X=IBIFN;.03////^S X=IBC" D FILE^DICN Q:Y<1
 ... ;need to find what field is not occupied starting with 10
 ... S IBZ=10 F IBS=1:1 Q:$P(DR,";",IBS)=""  I $P(DR,";",IBS)[IBZ_"////" S IBZ=IBZ+1
 ... S DR=DR_IBZ_"////"_(+Y)_";"
 .. I $P(IBY,"^",13) W !!?10,"Associating Provider: ",$P($G(^VA(200,$P(IBY,"^",13),0)),"^") D  S DR=DR_"18////"_$P(IBY,"^",13)_";"
 ... ;
 ... ; as requested by users, need to update the last look up value for
 ... ; the provider
 ... N DIC,X,DR,Y S DIC="^VA(200,",DIC(0)="INOS",X="`"_$P(IBY,"^",13)
 ... D ^DIC
 ... ;
 .. I $P(IBY,"^",14) W !?10,"Assigning Location: ",$P($G(^SC($P(IBY,"^",14),0)),"^") S DR=DR_"6////"_$P(IBY,"^",14)_";"_$S($P($G(^SC($P(IBY,"^",14),0)),"^",15):"5////"_$P(^(0),"^",15)_";",1:"")
 .. I $L(DR) S DIE="^DGCR(399,"_IBIFN_",""CP"",",DA(1)=IBIFN,DA=+IBP,IBDR=DR D ^DIE
 .. S IBC=0 F IBX=11,12 I $P(IBY,"^",IBX) S IB9=$$MOD^ICPTMOD($P(IBY,"^",IBX),"I") W !?10,"Adding Modifier: ",$P(IB9,"^",2)," - ",$P(IB9,"^",3) D
 ... S IBC=IBC+1,DIC="^DGCR(399,"_IBIFN_",""CP"","_(+IBP)_",""MOD"",",DA(1)=+IBP,DA(2)=IBIFN,X=IBC,DIC("DR")=".02////"_$P(IBY,"^",IBX),DIC(0)="" D FILE^DICN
 .. ;
 .. ; need to check for quantity >1 then duplicate entry
 .. I $P(IBY,"^",10)>1 W !!?10,"Duplicating Procedure for Quantity of ",$P(IBY,"^",10) F IBQ=1:1:$P(IBY,"^",10)-1 D
 ... K DO S DIC="^DGCR(399,"_IBIFN_",""CP"",",DIC(0)="",X=(+IBY)_";ICPT(",DA(1)=IBIFN,DIC("DR")="1////"_DGPROCDT_";"_$G(IBDR) D FILE^DICN S IBCP=+Y
 ... S IBC=0 F IBX=11,12 I $P(IBY,"^",IBX) S IB9=$$MOD^ICPTMOD($P(IBY,"^",IBX),"I"),IBC=IBC+1,DIC="^DGCR(399,"_IBIFN_",""CP"","_IBCP_",""MOD"",",DA(1)=IBCP,DA(2)=IBIFN,X=IBC,DIC("DR")=".02////"_$P(IBY,"^",IBX),DIC(0)="" D FILE^DICN
 .. K IBDR
 Q
 ;
SROMIN(IBIFN,IBPROCP) ; will ask as user to select anesthesia to populate into
 ; the minutes of a bill
 N IBSR,DFN,IBFDT,IBTDT,IBSRC,IBSRSDT,IBSREDT,IBC,IBSRDAT,IBSRMIN,DR,DA
 N DIE,X,Y,IBP,DIR
 K ^TMP("SRANES",$J),^TMP("IBSRDAT",$J)
 ;
 S DFN=$P($G(^DGCR(399,+$G(IBIFN),0)),"^",2)
 S IBFDT=+$G(^DGCR(399,IBIFN,"U")),IBTDT=$P($G(^("U")),"^",2)
 I 'DFN!('IBFDT)!('IBTDT) G SROMINQ
 ;
 S IBSR=$$ANESTIME^SROANEST(DFN,IBFDT,IBTDT) I IBSR<1 G SROMINQ
 ;
 W !!,"The following surgical/anesthesia times were found:",!
 S (IBC,IBSRC)=0 F  S IBSRC=$O(^TMP("SRANES",$J,IBSRC)) Q:IBSRC<1  S IBSRSDT=0 F  S IBSRSDT=$O(^TMP("SRANES",$J,IBSRC,IBSRSDT)) Q:'IBSRSDT  S IBSREDT=0 F  S IBSREDT=$O(^TMP("SRANES",$J,IBSRC,IBSRSDT,IBSREDT)) Q:'IBSREDT  D
 . ;
 . S IBC=IBC+1
 . S IBSRDAT=^TMP("SRANES",$J,IBSRC,IBSRSDT,IBSREDT)
 . S ^TMP("IBSRDAT",$J,IBC)=IBSRDAT
 . W !,$J(IBC,4)," Case #",IBSRC,?20,$$FMTE^XLFDT(IBSRSDT,2),?35,$$FMTE^XLFDT(IBSREDT,2),?50,$P(IBSRDAT,"^",2),?60
 . F IBP=4:1:11 I $P(IBSRDAT,"^",IBP) W:$X>61 "," W $P($T(EXEMPT+(IBP-3)),";",3)
 ;
 S DIR(0)="LO^1:"_IBC_":0" D ^DIR G:'Y SROMINQ
 ;
 S IBSRMIN=0 F IBP=1:1 Q:'$P(Y,",",IBP)  S IBSRMIN=IBSRMIN+$P(^TMP("IBSRDAT",$J,$P(Y,",",IBP)),"^",2)
 S DIE="^DGCR(399,"_IBIFN_",""CP"",",DR="15///"_IBSRMIN,DA=IBPROCP,DA(1)=IBIFN D ^DIE
 ;
SROMINQ K ^TMP("SRANES",$J),^TMP("IBSRDAT",$J)
 Q
 ;
 ;
OBSHOUR(DFN,EVNTDT) ; Get Observation Hours (for Procedures whose charge requires Hours)
 ; display Observation Discharges 72 hours before date (procedure date)
 ; allow user to input exact observation date times, using the last observation admission/discharge as default
 ; based on the date/times entered by the user calculate the total hours
 ; Input:  DFN = Patient ifn,   EVNTDT = Procedure Date
 ; Output: returns total hours with 1 decimal digit selected/input or ""
 ;
 N IBBEG,IBEND,IBDATE,IBPTF,IBPTF0,IBPTF70,IBDSPLT,IBADMDT,IBDSCDT,IBDSH,DIR,X,Y,DIRUT,DTOUT,DUOUT,IBHOURS
 S (IBDSH,IBHOURS,IBADMDT,IBDSCDT)="" I '$G(DFN) G OBSHOURQ
 S EVNTDT=$S(+$G(EVNTDT):EVNTDT,1:DT)\1,IBBEG=$$FMADD^XLFDT(EVNTDT,-3)+.0001,IBEND=EVNTDT+.2359
 ;
 W !!,?6,"Inpatient Observation Discharges 72 hours before "_$$FMTE^XLFDT(EVNTDT,2),":"
 S IBDATE=IBBEG F  S IBDATE=$O(^DGPT("ADS",IBDATE)) Q:'IBDATE  Q:IBDATE>IBEND  D
 . S IBPTF=0 F  S IBPTF=$O(^DGPT("ADS",IBDATE,IBPTF)) Q:'IBPTF  D
 .. S IBPTF0=$G(^DGPT(IBPTF,0)) Q:+IBPTF0'=DFN  S IBPTF70=$G(^DGPT(IBPTF,70))
 .. ;
 .. S IBDSPLT=+$P(IBPTF70,U,2) I ",18,23,24,36,41,65,94,"'[(","_IBDSPLT_",") Q
 .. ;
 .. S IBDSPLT=$G(^DIC(42.4,IBDSPLT,0)),IBADMDT=$E(+$P(IBPTF0,U,2),1,12),IBDSCDT=$E(+IBPTF70,1,12)
 .. ;
 .. S IBDSH=$$FMDIFF^XLFDT(IBDSCDT,IBADMDT,2)/60/60
 .. ;
 .. W !,?6,$P(IBDSPLT,U,1),?39,$$FMTE^XLFDT(IBADMDT,2),?55,$$FMTE^XLFDT(IBDSCDT,2),?72,"(",$J(IBDSH,"",1),")"
 I 'IBDSH W " None found"
 ;
 W !!,?6,"Observation Start/Stop Times are optional, used only to calculate Hours:"
 S DIR("A")="      Enter Observation Start Date/Time: " I +IBADMDT S DIR("B")=$$FMTE^XLFDT(IBADMDT,2)
 S DIR(0)="DAO^::XR" D ^DIR S IBADMDT=+Y I ('Y)!($D(DIRUT)) G OBSHOURQ
 ;
 S DIR("A")="      Enter Observation Stop Date/Time: " I IBDSCDT>IBADMDT S DIR("B")=$$FMTE^XLFDT(IBDSCDT,2)
 S DIR(0)="DAO^"_IBADMDT_"::XR" D ^DIR S IBDSCDT=+Y I ('Y)!($D(DIRUT)) G OBSHOURQ
 ;
 S IBHOURS=$J($$FMDIFF^XLFDT(IBDSCDT,IBADMDT,2)/60/60,"",1) W "     (",IBHOURS,")",!
 ;
OBSHOURQ Q IBHOURS
 ;
 ;
EXEMPT ; exemption reasons to display
 ;;SC
 ;;CV
 ;;AO
 ;;IR
 ;;SWA
 ;;MST
 ;;HNC
 ;;SHAD
