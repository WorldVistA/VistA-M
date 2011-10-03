SDCI ;SF/GFT,MAN/GRR - CHECK-IN/UNSCHEDULED APPOINTMENT ; 20 SEP 84  8:20 am
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
PT ;
 N DFN,SDT,SC,SDT,SDDQ,SDD
 W !! S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC K DIC G PTQ:Y<0
 S DFN=+Y,SDT=DT,SDD=0
 F  S SDT=$O(^DPT(DFN,"S",SDT)) Q:$P(SDT,".")-DT  S X=$G(^(SDT,0)) I $P(X,U,2)'["C",$P(X,U,2)'["N"!($P(X,U,2)="NT") S SC=+X D
 .S SDDA=0 F  S SDDA=+$O(^SC(SC,"S",SDT,1,SDDA)) Q:'$D(^(SDDA,0))  I DFN=+^(0) D  Q
 ..W !!,"Appointment at "_$E(SDT_"000",9,12)_" on ",$$FDATE^VALM1(SDT)," in "_$P(^SC(SC,0),U)
 ..D ONE^SDAM2(DFN,SC,SDT,SDDA,1,"") S SDD=SDD+1
 ;
 W:'SDD *7,!,"This patient has no appointments scheduled today."
 W ! S DIR("A")="Do you want to add a new 'unscheduled' appointment'",DIR(0)="Y"
 D ^DIR K DIR G PTQ:Y'=1
 S SDY=$$CL^SDAMWI(DFN)
PTQ Q
