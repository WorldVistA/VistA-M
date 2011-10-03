DGPTTRIM ;ALB/JDS - SET UP DRG INFO ; 26 AUG 84  14:16
 ;;5.3;Registration;**158,606**;Aug 13, 1993
 ;
 W !!,"SET UP DRG VALUES FOR FISCAL YEARS",!!
FY R !,"Fiscal year to set up data for: ",DGFY:DTIME G Q:DGFY=""!(DGFY["^") I DGFY'?2N W !!,"Enter the fiscal year as 'NN' (ex: '84' for fiscal year 1984).",*7,*7,! G FY
 S DGFY2K=$$DGY2K^DGPTOD0(DGFY)
ASK ;W !! S DIC="^ICD(",DIC(0)="AEQMZ" D ^DIC G Q:Y'>0 S DGDRG=^ICD(+Y,0)
 W !! S DIC="^ICD(",DIC(0)="AEQMZ" D ^DIC G Q:Y'>0 S DGDRG=$$DRG^ICDGTDRG(+Y)
 W !!,"**National DRG Values - not editable**",!?5,$J("WWU: ",16),$P(DGDRG,U,2),!?5,$J("Low Trim Days: ",16),$P(DGDRG,U,3),!?5,$J("High Trim Days: ",16),$P(DGDRG,U,4),!?5,$J("ALOS: ",16),$P(DGDRG,U,8),!!
 S DA=+Y,DR="20///"_DGFY,DR(2,80.22)="6;7",DIE=DIC D ^DIE S:'$D(Y) ^ICD("AFY",DGFY2K)="" G ASK
Q K DA,DGDRG,DGFY,DIC,DIE,DR,Y Q
