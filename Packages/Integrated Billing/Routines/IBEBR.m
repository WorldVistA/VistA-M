IBEBR ;ALB/AAS - Add/Edit IB ACTION CHARGE FILE ;3-MAR-92
 ;;2.0;INTEGRATED BILLING;**34,52,429,524,563**;21-MAR-94;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
% ; entry point
 D HOME^%ZIS W @IOF
EN W !!,?28,"Enter/Edit Billing Rates",!!
 S IBX="MAIN" D CHOOSE I $D(DIRUT)!('Y) G END
 I Y>0,Y<7 D @Y
 G EN
 Q
1 ;enter edit revenue code rates
 ;D EN1^IBCBR
 ;D ENR^IBEMTO ; bill MT OPT charges awaiting the new copay rate
 ;D END
 W !!,"  ******* This option is no longer active.",!,?10,"Please use the Enter/Edit Charge Master option.",!
 Q
 ;
2 ;enter per diem rate
 S IBX="PERDIEM" D CHOOSE Q:$D(DIRUT)
 D EFFDT,END
 G 2
 ;
3 ;enter medicare deductable
 S IBX="MEDIC",IBPD="MEDICARE DEDUCTIBLE" ;D CHOOSE Q:$D(DIRUT)
 D EFFDT,END Q:$G(Y)<1
 G 3
 ;
4 ;enter hcfa amb. surg. rates
 S IBX="HCFA" D CHOOSE Q:$D(DIRUT)
 D EFFDT,END
 G 4
 ;
5 ;enter rx copay rates
 N IBTIER
 S IBX="COPAY" D CHOOSE Q:$D(DIRUT)
 S IBTIER=$$TIER Q:$D(DIRUT)
 D EFFDT,END
 G 5
 ;
6 ;enter champva subsistence rates
 S IBX="CHMPVA" D CHOOSE Q:$D(DIRUT)
 D EFFDT,END
 G 6
 ;
CHOOSE S IBSEL=$P($T(@IBX),";;",2,99),IB=""
 F I=1:1 Q:$P($T(@IBX+I),";;",2,99)=""  S IB=IB_I_":"_$P($P($T(@IBX+I),";;",2,99),"^",$S($P($P($T(@IBX+1),";;",2,99),"^",5)="":1,1:5))_";"
 W !!,"CHOOSE FROM:"
 F I=1:1 S X=$P(IB,";",I) Q:'X  W !?4,+X,?20,$P(X,":",2)
 S DIR("?")="^D 1^IBEBRH",DIR("??")="^D 2^IBEBRH"
 W !! S DIR(0)="SOA^"_IB,DIR("A")="Select "_IBSEL_": " D ^DIR K DIR I $D(DIRUT) G CHOOSEQ
 S IBP=$P($T(@IBX+Y),";;",2,99) S IBPD=$P(IBP,"^",1) F I=2:1 Q:$P(IBP,"^",I)=""  S IBPD(I)=$P(IBP,"^",I)
CHOOSEQ Q
 ;
EFFDT S %DT="EX"
 R !!,"   Select Effective Date: ",X:DTIME Q:X=""  D:X["?" 3^IBEBRH I X=" ",$D(IBEFDT) S X=IBEFDT
 D ^%DT K %DT G:X["?" EFFDT Q:Y<1  S IBEFDT=+Y
 D FILE G EFFDT
 Q
 ;
FILE ;  -add new entries in 350.2 and edit
 S DLAYGO=350.2,X=IBPD,DIC="^IBE(350.2,",DIC(0)="ELMQ",DIC("S")=$S($G(IBTIER):"I $P(^(0),U,2)=IBEFDT,$P(^(0),U,7)=IBTIER",1:"I $P(^(0),U,2)=IBEFDT"),DIC("DR")=".02///"_IBEFDT D ^DIC K DIC G:+Y<0 FILEQ
 ;
 ;  -if a new entry
 S IBNEW=$P(Y,"^",3)
 K DR S DR="" S IBORIG=$O(^IBE(350.2,"B",IBPD,0)),IBLAST=$O(^IBE(350.2,"B",IBPD,+Y),-1) I IBNEW S DR=".02///"_IBEFDT_";.03///"_$P($G(^IBE(350.2,+IBORIG,0)),"^",3)_";" S:$G(IBTIER) DR=DR_".07///"_IBTIER_";"
 ;
 S DIE="^IBE(350.2,",DA=+Y,DR=DR_".04;.06;.05;" D ^DIE K DIE
 ;
 ;  -delete if no charge or not inactive
 S X=$G(^IBE(350.2,DA,0)) I '$P(X,"^",4)&('$P(X,"^",5)) W !!,*7,"Deleting - no charge, not inactive" S DIK="^IBE(350.2," D ^DIK Q
 ;
 ;  -set computed logic for new entry if needed
 S IB10=$G(^IBE(350.2,+IBORIG,10)) I IB10]"" S ^IBE(350.2,DA,10)=IB10
 ;  -set additional amount logic if needed (from last one)
 S IB20=$G(^IBE(350.2,+IBLAST,20)) I IB20]"" S ^IBE(350.2,DA,20)=IB20
 ;
 ;  -logic for rx3-rx6
 S IB=0,IB0=$G(^IBE(350.2,DA,0)) F  S IB=$O(IBPD(IB)) Q:'IB  D
 . S IBORIG=$O(^IBE(350.2,"B",IBPD(IB),0)),IBATYP=+$P($G(^IBE(350.2,+IBORIG,0)),"^",3)
 . I 'IBNEW S DA=$O(^IBE(350.2,"AIVDT",IBATYP,-IBEFDT,0)) Q:'DA
 . I IBNEW S X=IBPD(IB),DIC="^IBE(350.2,",DIC(0)="L" K DD,DO D FILE^DICN Q:Y<0  S DA=+Y
 . S DIE="^IBE(350.2,",DR=".02////"_IBEFDT_";.03////"_IBATYP_";.04////"_$P(IB0,"^",4)_";.05////"_$S($P(IB0,"^",5)]"":$P(IB0,"^",5),1:"@")_";.06////"_$S($P(IB0,"^",6)]"":$P(IB0,"^",6),1:"@")_";.07////"_IBTIER D ^DIE
 . I IB20]"" S ^IBE(350.2,DA,20)=IB20
 ;
FILEQ K IB10,DIC,DIE,DR,DA,IBNEW,IBORIG,DIK Q
 ;
TIER() ; -for Rx rates, prompt for tier
 N DIR
 S DIR(0)="350.2,.07" D ^DIR
 Q +Y
END ;Kill vars
 K I,X,Y,IBNOD,IBPD,DIR,DIC,DIE,DIK,DA,DR,DA,IB10,IBORIG,IB,IB0,IBP,IBEFDT,IBSEL,IBX,IBRUN,IB20,IBLAST,IBTIER
 Q
 ;
 ;;
COPAY ;;Co-pay Type
NSC ;;RX1^RX3^RX4^^NSC RX CO-PAY (RX1)
SC ;;RX2^RX5^RX6^^SC RX CO-PAY (RX2)
FSNSC ;;FEE SERV RX1^FEE SERV RX3^FEE SERV RX4^^FEE SERV NSC RX CO-PAY (RX1)
 ;;
PERDIEM ;;Per Diem
 ;;INPT PER DIEM
 ;;NHCU PER DIEM
 ;;FEE SERV INPT PER DIEM
 ;;
HCFA ;;HCFA Amb. Surg. Rate
 ;;MEDICARE 1^^^^AMB SURG RATE 1
 ;;MEDICARE 2^^^^AMB SURG RATE 2
 ;;MEDICARE 3^^^^AMB SURG RATE 3
 ;;MEDICARE 4^^^^AMB SURG RATE 4
 ;;MEDICARE 5^^^^AMB SURG RATE 5
 ;;MEDICARE 6^^^^AMB SURG RATE 6
 ;;MEDICARE 7^^^^AMB SURG RATE 7
 ;;MEDICARE 8^^^^AMB SURG RATE 8
 ;;MEDICARE 9^^^^AMB SURG RATE 9
 ;;
CHMPVA ;;CHAMPVA Rate Type
 ;;CHAMPVA PER DIEM
 ;;CHAMPVA SUBSISTENCE LIMIT
 ;;
MEDIC ;;Medicare Deductible
 ;;MEDICARE DEDUCTIBLE
 ;;
MAIN ;;Billing Rate Type
 ;;REVENUE CODE RATES
 ;;PER DIEM RATES
 ;;MEDICARE DEDUCTIBLE
 ;;HCFA AMB. SURG. RATES
 ;;RX CO-PAYMENT
 ;;CHAMPVA SUBSISTENCE RATES
