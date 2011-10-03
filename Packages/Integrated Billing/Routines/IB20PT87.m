IB20PT87 ;ALB/CPM - EXPORT ROUTINE 'DGRPDB' ; 14-FEB-94
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
DGRPDB ;ALB/AAS - VIEW ONLY SCREEN TO DETERMINE BILLING ELIGIBILITY ; 20 DEC 90 1:30 pm
 ;;5.3;Registration;**26**;Aug 13, 1993
 ;
% S:'$D(DGQUIT) DGQUIT=0
 G:DGQUIT END S DIC="^DPT(",DIC(0)="AEQMN" D ^DIC G:+Y<1 END S DFN=+Y D EN
 G %
 ;
EN ;entry with DFN defined.
 Q:'$D(DFN)  D HOME^%ZIS,2^VADPT,HDR
 D MT,AOIR,ELIG,DIS
 S C=$S($D(^DPT(DFN,.312,0)):$P(^(0),"^",4),1:0),C=C+6
 D:($Y>(IOSL-C)) PAUSE,HDR:'DGQUIT Q:DGQUIT  D INS,PAUSE
 Q
 ;
ELIG ;eligibility code(s)
 W !!," Primary Elig. Code: ",$P(VAEL(1),"^",2),"  --  ",$S(VAEL(8)']"":"NOT VERIFIED",1:$P(VAEL(8),"^",2))
 I VAEL(8)]"" S Y=$S($D(^DPT(DFN,.361)):$P(^(.361),"^",2),1:"") W "  " D DT^DIQ
 W !,"Other Elig. Code(s): " I $D(VAEL(1))>9 S I1=0 F I=0:0 S I=$O(VAEL(1,I)) Q:'I  S I1=I1+1 W:I1>1 !?21 W $P(VAEL(1,I),"^",2)
 E  W "NO ADDITIONAL ELIGIBILITIES IDENTIFIED"
 Q
 ;
DIS ;rated disabilities
 ;
 ;  This is called from the FEE and MCCR package!!!
 ;
 ;  Input:  DFN as IEN of PATIENT file
 ;          VAEL array (if no passed, it is set) of eligibility info
 ;
 I '$D(VAEL) D ELIG^VADPT S DGKVAR=1
 W:'+VAEL(3) !!,"  Service Connected: NO" W:+VAEL(3) !!,"         SC Percent: ",$P(VAEL(3),"^",2)_"%"
 W !," Rated Disabilities: " I 'VAEL(4),$S('$D(^DG(391,+VAEL(6),0)):1,$P(^(0),"^",2):0,1:1) W "NOT A VETERAN" G DISQ
 S I3=0 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  S I1=^(I,0),I2=$S($D(^DIC(31,+I1,0)):$P(^(0),"^",1)_" ("_+$P(I1,"^",2)_"%-"_$S($P(I1,"^",3):"SC",$P(I1,"^",3)']"":"not specified",1:"NSC")_")",1:""),I3=I3+1 W:I3>1 !?21 W I2
 W:'I3 "NONE STATED"
DISQ I $D(DGKVAR) D KVAR^VADPT K DGKVAR
 K I,I1,I2,I3
 Q
 ;
INS ;insurance information
 ;
 ;  This is called form the FEE package!!!
 ;
 ;  Input:  DFN as IEN of PATIENT file
 ;
 Q:'$D(DFN)
 W !!,"    Health Insurance: " S Z=$S($D(^DPT(DFN,.31)):$P(^(.31),"^",11),1:"") W $S(Z="Y":"YES",Z="N":"NO",Z="U":"UNKNOWN",1:"NOT ANSWERED")
 D DISP^IBCNSP2
INSQ K I,I1,DGX,Z
 Q
 ;
IN W !?3,$S($D(^DIC(36,+$P(DGX,"^",1),0)):$E($P(^(0),"^",1),1,25),1:"UNKNOWN"),?30,$S($P(DGX,"^",2)]"":$P(DGX,"^",2),1:"UNKNOWN"),?52,$S($P(DGX,"^",3)]"":$P(DGX,"^",3),1:"UNKNOWN")
 W ?71,$S($P(DGX,"^",6)="v":"APPLICANT",$P(DGX,"^",6)="s":"SPOUSE",$P(DGX,"^",6)="o":"OTHER",1:"UNKNOWN")
 Q
 ;
AOIR ;Agent Orange/ionizing radiation
 S DGX=$S($D(^DPT(DFN,.321)):^(.321),1:"")
 F I=2,3 S X=$P(DGX,"^",I) W:I=2 !,"           A/O Exp.: " W:I=3 "ION Rad.: " W $S(X="Y":"YES",X="N":"NO",X="U":"UNKNOWN",1:"NOT ANSWERED"),"   "
 S X=$G(^DPT(DFN,.38)),X1=$P(X,"^",1) W "Medicaid Elig: ",$S(X1="":"NOT ANSWERED",'X1:"NO",1:"YES") I ($X+15)'>IOM W " - " S Y=$P(X,"^",2) D D^DIQ W $P(Y,"@")
 Q
 ;
PAUSE F J=1:1 Q:($Y>(IOSL-3))  W !
 S DGX1="" I $E(IOST,1,2)["C-" N DIR S DIR(0)="E" D ^DIR S DGQUIT='Y
 Q
 ;
HDR ;Screen Header
 W @IOF I $P(VAEL(6),"^",2)]"" S DGTYPE=$P(VAEL(6),"^",2)
 W $P(VADM(1),"^",1),?32,VA("PID"),?47,$P(VADM(3),"^",2) S X=$S($D(DGTYPE):$P(DGTYPE,"^",1),1:"PATIENT TYPE UNKNOWN"),X1=79-$L(X) W ?X1,X
 S X="",$P(X,"=",80)="" W !,X Q
 Q
 ;
MT I '$O(^DGMT(408.31,"AD",1,DFN,0)) W !,"  Means Test Status:  NOT IN MEANS TEST FILE" Q
 D DIS^DGMTU(DFN)
 Q
 ;
END D KVAR^VADPT
 K A,C,I,I1,I2,I3,J,DIC,DIR,DFN,DGA1,DGMT,DGMTL,DGMTLA,DGX,DGX1,DGT,DGTYPE,DGQUIT,DGMTLL,X,X1,VAROOT,VA,Y,Z
 Q
