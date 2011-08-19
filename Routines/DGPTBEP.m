DGPTBEP ;ALB/BOK - PURGE DRG BREAKEVEN DATA ; 26 MAR 87
 ;;5.3;Registration;**158**;Aug 13, 1993
 D LO^DGUTL
START R !,"Purge BREAKEVEN data for Fiscal Year: ",DGFY:DTIME Q:DGFY["^"!('$T)!(DGFY']"")
 I DGFY'?2N W !?2,"Enter Fiscal Year as 86 for FY 86." G START
 S DGFY2K=$$DGY2K^DGPTOD0(DGFY) ; y2k compatible
 I $E(DGFY2K,1,3)'<$E(DT,1,3) W !?2,*7,"Fiscal Year must be a PREVIOUS year." G START
 ;
 W !!?2,"If the BREAKEVEN data for Fiscal Year `",DGFY," is deleted then"
 W !?2,"the PTF DRG outputs CAN NOT be run for this time frame.",!
SURE W !?2,"Are you sure you want to purge Fiscal Year `",DGFY," BREAKEVEN data? "
 S %=2 D YN^DICN G QUIT:%=2!(%=-1)
 I %=0 W !?4,"Answer 'YES' to purge data or 'NO' not to purge data.",! G SURE
 ;
 S DGFY=$$FMTE^XLFDT(DGFY2K)_0,DGFYQ=DGFY+4
KIL F I=0:0 S I=$O(^ICD(I)) Q:I'>0  W "." F K=DGFY:0 S K=$O(^ICD(I,"BE",K)) Q:K'>0!(K>DGFYQ)  S DA(1)=I,DA=K,DIK="^ICD("_DA(1)_",""BE""," D ^DIK K DIK,DA
QUIT K DGFY,DGFYQ,DGFY2K,I,K,X Q
