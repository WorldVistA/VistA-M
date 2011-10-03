SDOPC0 ;ALB/LDB - SEND BULLETIN IF DEP DATA FOR MT PT IS INCONSISTENT; 21 JUN 89@18:30 ;3/11/92  12:46
 ;;5.3;Scheduling;**20,42,132**;Aug 13, 1993
 ;
INPT ;Called from SDOPC1 to reset inpatient status
 I $D(^DPT(DFN,"S",SDVD1,0)),$P(^(0),U,2)="" S $P(^(0),U,2)="I"
 Q
