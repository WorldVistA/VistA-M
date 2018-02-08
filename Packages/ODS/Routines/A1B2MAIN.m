A1B2MAIN ;ALB/AAS - ODS store billing data ; 17-JAN-91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
 ;  -- main ods billing collection program
 ;  -- Called by PTF  (dgptfrel)   release to store billing data
 ;
 ;  -- input:    DGPTIFN := ifn of ptf record in ^DGPT
 ;
MAIN ;
 I $S('$D(DGPTIFN):1,'DGPTIFN:1,'$D(^DGPT(DGPTIFN,0)):1,$P(^(0),U,4):1,1:0) Q
 D ON^A1B2UTL G:'A1B2ODS END
 D FAC^A1B2UTL G:'A1B2FN END
 S A1B2PTF=DGPTIFN D ADM^A1B2MUT G:'A1B2ADM END
 I '$D(^A1B2(11500.2,+A1B2ADM,0)) G END
 S A1B2PTFC=$S('$P(^DGPT(DGPTIFN,0),"^",9):DT,'$D(^DGP(45.84,$P(^(0),"^",9),0)):DT,'$P(^(0),"^",2):DT,1:$P(^(0),"^",2))
 S DA=A1B2ADM,DIE="^A1B2(11500.2,",DR=".2////"_A1B2PTF_";.21////"_A1B2PTFC D ^DIE K DIE,DA,DR
SPC W !!,">>>> Storing Billable Specialties from PTF in ODS file. >>>>" D WAIT
 I $D(^A1B2(11500.61,"C",+A1B2ADM)) S A1B2FL=11500.61 D INACT
 D ^A1B2MSP ; file specialties and los in 11500.61
 W !!,">>>> Storing Surgeries and Procedures in ODS files. >>>>" D WAIT,PROC
 W !!,">>>> Storing Diagnoses in ODS files. >>>>" D WAIT,DIAG
 W !!,"You may now enter any additional costs related to this ODS admission.",! D COST
 G END
 ;
PROC ;  -- find procedures and surgeries in ptf and store in 11500.62
 ;  -- find surgeries
 I $D(^A1B2(11500.62,"C",+A1B2ADM)) S A1B2FL=11500.62 D INACT
 S A1B2EDT=0 F A1B2I=0:0 S A1B2EDT=$O(^DGPT(A1B2PTF,"S",A1B2EDT)) Q:'A1B2EDT  I $D(^DGPT(A1B2PTF,"S",A1B2EDT,0)) S A1B2X=^(0),A1B2PDT=+A1B2X F A1B2J=8:1:12 S A1B2DT=$P(A1B2X,"^",A1B2J) D:A1B2DT]"" PROC1
 ;  -- find procedures
 S A1B2EDT=0 F A1B2I=0:0 S A1B2EDT=$O(^DGPT(A1B2PTF,"P",A1B2EDT)) Q:'A1B2EDT  I $D(^DGPT(A1B2PTF,"P",A1B2EDT,0)) S A1B2X=^(0),A1B2PDT=+A1B2X F A1B2J=5:1:9 S A1B2DT=$P(A1B2X,"^",A1B2J) D:A1B2DT]"" PROC1
 Q
 ;
PROC1 ;  --set up to file procedures and surgeries
 S A1B2FL=11500.62
 D ADD^A1B2UTL
 S DA=+Y,DIE="^A1B2(11500.62,",DR="[A1B2 PROCEDURE STUFF]" D ^DIE
 Q
DIAG ;  -- find diagnosis in ptf and file in 11500.63
 I $D(^A1B2(11500.63,"C",+A1B2ADM)) S A1B2FL=11500.63 D INACT
 S A1B270=$S('$D(^DGPT(A1B2PTF,70)):"",1:^(70)) Q:A1B270=""
 ;  -- get dxls
 S A1B2DT=$P(A1B270,"^",10),A1B2DXLS=1 I A1B2DT]"" D DIAG1
 ;  -- get remaining diagnoses
 S A1B2DT="" F A1B2I=16:1:24 S A1B2DXLS="",A1B2DT=$P(A1B270,"^",A1B2I) I A1B2DT]"" D DIAG1
 K A1B270,A1B2DT,A1B2I
 Q
 ;
DIAG1 ;  -- set up to file
 S A1B2FL=11500.63
 D ADD^A1B2UTL
 S DA=+Y,DIE="^A1B2(11500.63,",DR="[A1B2 DIAGNOSIS STUFF]" D ^DIE
 Q
 ;
COST ;  -- input cost data
 D FAC^A1B2UTL
 I '$D(A1B2ADM) G END
 ;
COST1 S DIC("A")="Select COST DATE: ",DIC="^A1B2(11500.64,",DIC(0)="AEQLM" D DICDR1^A1B2MUT
 D ^DIC Q:Y<1  K DIC S DA=+Y
 S DIE="^A1B2(11500.64,",DR="[A1B2 ENTRY]" ;I '$P(Y,"^",3),$D(^A1B2(11500.64,DA,1)),+^(1)'=2
 D ^DIE
 W ! G COST1
 Q
 ;
END K A1B2DXLS,A1B2J,A1B2PDT,D0,C,A1B2X,A1B2FL,A1B2ADM1,A1B2ADM,A1B2PTF,A1B2PTFC,A1B2ODS,DIC,DIE,DA,DR,Y,X
 I '$D(A1B2NTY) K A1B2FN,A1B2FNME
 Q
WAIT ;
 W !,"..."
 W $P("HMMM^EXCUSE ME^SORRY","^",$R(3)+1),", ",$P("THIS MAY TAKE A FEW MOMENTS^LET ME PUT YOU ON 'HOLD' FOR A SECOND^HOLD ON^JUST A MOMENT PLEASE^I'M WORKING AS FAST AS I CAN^LET ME THINK ABOUT THAT A MOMENT","^",$R(6)+1)_"..."
 Q
 ;
INACT ;  -- inactivate existing entries prior to re-running
 S A1B2X=0,DR=".15////0;1.01////3",DIE=A1B2FL
 F A1B2I=0:0 S A1B2X=$O(^A1B2(A1B2FL,"C",+A1B2ADM,A1B2X)) Q:'A1B2X  S DA=A1B2X D ^DIE
 K A1B2FL,DIE,DA,DR Q
