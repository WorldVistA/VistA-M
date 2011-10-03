SDOPC4 ;ALB/BOK - OPC GENERATION CONT., MT CALCULATIONS ;3/27/92  12:33
 ;;5.3;Scheduling;**5,22,26,132**;Aug 13, 1993
 ;
DOM(DFN,DT,SDMT,SDEP,SDINP) ;Function
 ;INPUT:    DFN = Internal Entry Number of Patient file
 ;           DT = Date of visit
 ;        SDINP = Inpatint flag, 0=no (Optional)  (**Reference**)
 ;         SDMT = Means Test Indicator  (**Reference**)
 ;        SDMTD = Means Test Dependants  (**Reference**)
 N DG1,DGT
 S DGT=DT D ^DGINPW I DG1 S:$D(SDINP) SDINP=1 I $P(^DG(43,1,0),U,21),$D(^DIC(42,+DG1,0)),$P(^(0),U,3)="D" S:$D(SDINP) SDINP=0 S SDMT="X0",SDEP="XX"
 K DG1 Q
 ;
