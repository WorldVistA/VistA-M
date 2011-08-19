IBCA1 ;ALB/MRL - DISPLAY UTILITIES  ;01 JUN 88 12:00
 ;;2.0;INTEGRATED BILLING;**109**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRA1
 ;
 Q:'$D(VADM)  S X="",$P(X,"=",81)="" W @IOF,!,VADM(1)_" ("_$P(VADM(2),"^",2)_")",?64,"DOB: ",$P(VADM(3),"^",2),!,X
 W !,"Rate Type",?14,":  ",$S($D(^DGCR(399.3,+IBIDS(.07),0)):$P(^(0),"^",1),1:"UNSPECIFIED-REQUIRED") S IBBT=IBIDS(.04)_IBIDS(.05)_IBIDS(.06)
 W !,"Event Date",?14,":  " S Y=IBIDS(.03) X:Y ^DD("DD") W $S($L(Y):Y,1:"UNSPECIFIED"),!,"Sensitive",?14,":  ",$S(IBIDS(155):"YES",IBIDS(155)=0:"NO",1:"NOT SPECIFIED")
 W !,"Responsible",?14,":  ",$S(IBIDS(.11)="p":"PATIENT",IBIDS(.11)="i":"INSURANCE CARRIER",1:"OTHER [INSTITUTION]") I "^i^o^"[("^"_IBIDS(.11)_"^") W "   (Specify ",$S(IBIDS(.11)="i":"CARRIER",1:"INSTITUTION")," on SCREEN 3)"
 W !!,"Loc of Care",?14,":  ",$$EXPAND^IBTRE(399,.04,IBIDS(.04))
 W !,"Event Source",?14,":  ",$S(IBIDS(.05)<3:"Inpatient",1:"Outpatient")
 W !,"Timeframe",?14,":  ",$$EXPAND^IBTRE(399,.06,IBIDS(.06))
 W !,?14,"   (Specify actual bill type fields on SCREENs 6/7)"
 W !!,"Bill From",?14,":  " S Y=IBIDS(151) X ^DD("DD") W Y,!,"Bill To",?14,":  " S Y=IBIDS(152) X ^DD("DD") W Y
 W ! I $E(IBBT,2)<3,$D(IBIDS(.08)) W !,"PTF Number",?14,":  ",IBIDS(.08)
 I $D(IBIDS(.17)) W !,"Initial Bill#",?14,":  ",$S($D(^DGCR(399,+IBIDS(.17),0)):$P(^(0),"^"),1:"Bill no longer exists")
 I $D(IBIDS(.15)) W !,"Copied Bill#",?14,":  ",$S($D(^DGCR(399,+IBIDS(.15),0)):$P(^(0),"^"),1:"Bill no longer exists")
 W ! D T
 I $D(IBCAN),IBCAN=2 Q
ASK S IBYN=0 W !!,"IS THE ABOVE INFORMATION CORRECT AS SHOWN" S %=1 D YN^DICN G ^IBCA:%=2,^IBCA2:%=1 I % D Q^IBCA2 G NREC^IBCA
 W !!?4,"YES - If this information is correct as shown and you wish to file the bill.",!?4,"NO  - If you wish to change this information prior to filing."
 W !?4,"'^' - Enter the up-arrow character to DELETE this Bill at this time." G ASK
TYPE S X3=$E(IBBT,I),X4=".0"_(I+3) W X3," - " I '$D(^DD(399,X4,0)) W "ZEROTH NODE UNSPECIFIED-CONTACT YOUR SYSTEMS MANAGER!"
 E  W $P($P($P(^DD(399,X4,0),"^",3),X3_":",2),";",1)
 K X3,X4 Q
T ;
 W !,"Please verify the above information for the bill you just entered.  Once this"
 W !,"information is accepted it will no longer be editable and you will be required"
 W !,"to CANCEL THE BILL if changes to this information are necessary."
 Q
