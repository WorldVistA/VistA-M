DGMTAUD2 ;ALB/CAW,BRM - Means test audit delete ; 12/20/01 9:22am
 ;;5.3;Registration;**45,166,182,300,433**;Aug 13, 1993
 ;
DIS ;Display changes pertaining to a means test for a vet
 ;
LKP ;Vet lookup
 S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G:$D(DTOUT)!($D(DUOUT))!(+Y<0) KIL
 I '$O(^DGMT(408.31,"AD",DGMTYPT,+Y,0)) W !?5,$P(Y(0),U)," has no "_$P("means^copay^^LTC exemption","^",DGMTYPT)_" test on file." K DIC,Y G LKP
 S DFN=+Y,DGNAM=$P(Y(0),U) K DIC,Y
 ;
LKM ;Means test lookup
 S DIC("W")="W ?27,$P(""MEANS^COPAY^^LTC EXEMPTION"",""^"",DGMTYPT)_"" TEST "",?42,$S($G(^DGMT(408.31,+Y,""PRIM""))=1:"" **PRIMARY** "",1:""""),?60,$$SR^DGMTAUD1($G(^DGMT(408.31,+Y,0)),+Y)",DIC("S")="I $P(^(0),U,2)=DFN&($P(^(0),U,19)=DGMTYPT)"
 S DIC="^DGMT(408.31,",DIC(0)="EQZ",X=DFN,D="C" D IX^DIC K DIC I X["?" W !,"Enter appropriate corresponding number." G LKM
 I $D(DTOUT)!($D(DUOUT)) D KIL Q
 I +Y<0 G LKP
 S DGMTI=+Y,DGMTD=$P(Y(0),U) K DIC,Y
 S DGDASH="",$P(DGDASH,"=",79)="" D HDR^DGMTAUD1 I '$O(^DGMT(408.41,"AM",DGMTYPT,DFN,DGMTI,0)) W !?5,"There are no changes to the "_$P("means^copay^^LTC exemption","^",DGMTYPT)_" test.",! G KIL
 ;
 ;Loop thru xref;write data
 S DGMTAI=0 F  S DGMTAI=$O(^DGMT(408.41,"AM",DGMTYPT,DFN,DGMTI,DGMTAI)) Q:'DGMTAI  S DGMTAIZ=$G(^DGMT(408.41,DGMTAI,0)) I DGMTAIZ]"" D:IOSL'>($Y+4) CR G:$D(DTOUT)!($D(DUOUT)) KIL D
 .W !?2,$$D^DGMTAUD1($P(DGMTAIZ,U)),?23,$$C^DGMTAUD1($P(DGMTAIZ,U,2)),?57,$E($$U^DGMTAUD1($P(DGMTAIZ,U,7)),1,20)
 .I $P(DGMTAIZ,U,5,6)'="^" W !?23,"OLD STATUS VALUE:  ",$S($P(DGMTAIZ,U,5)']"":"<Nothing>",1:$P(DGMTAIZ,U,5)),!?23,"NEW STATUS VALUE:  ",$S($P(DGMTAIZ,U,6)']"":"<Nothing>",1:$P(DGMTAIZ,U,6))
 .I $P(DGMTAIZ,U,8,9)'="^" W !?23,"OLD SOURCE OF TEST:  ",$S($P(DGMTAIZ,U,8)']"":"<Nothing>",1:$P(DGMTAIZ,U,8)),!?23,"NEW SOURCE OF TEST:  ",$S($P(DGMTAIZ,U,9)']"":"<Nothing>",1:$P(DGMTAIZ,U,9))
 G LKP
 ;
KIL K D,DGDASH,DGMTAI,DGMTAIZ,DGMTD,DGMTI,DGMTYPT,DGNAM,DFN,DIC,DTOUT,DUOUT,X,Y
 Q
CR I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR W:'Y @IOF D:Y HDR^DGMTAUD1
 Q
