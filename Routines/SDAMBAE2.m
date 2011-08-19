SDAMBAE2 ;ALB/BOK - ADD/EDIT CON'T ;11/21/91  12:15 ;
 ;;5.3;Scheduling;**15,79,111,132**;Aug 13, 1993
 ;
APP ; -- screen on APPOINTMENT TYPE field in VISIT file CLINIC STOP multiple
 ;      Z - zeroth node of app type file - NAKED REFERENCE - ^SD(409.1,IFN,0)
 ;      P - pt ifn
 ;      E - pt's elig code
 ;      V - elig code is vet code
 ;
 N Z,P,E,V
 S Z=^(0),P=+$P(^SDV(DA(1),0),U,2),E=$S($D(^DPT(P,.36)):+^(.36),1:0),V=$S($D(^DIC(8,E,0)):$P(^(0),U,5),1:"")
 I '$P(Z,U,3),$S(V["Y":1,1:$P(Z,U,5)),$S('$P(Z,U,6):1,$D(^DPT(P,"E",$P(Z,U,6),0)):1,1:E=$P(Z,U,6))
 Q
