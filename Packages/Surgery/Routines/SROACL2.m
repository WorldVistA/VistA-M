SROACL2 ;BIR/SJA - CLINICAL DATA ; JULY 12, 2011
 ;;3.0;Surgery;**125,160,176,182,184,200**;24 Jun 93;Build 9
 D HDR^SROAUTL N SRQ
PRIOR W !,"Prior Heart Surgery:"
 W !!,"0. NONE                      4. OTHER",!,"1. CABG-ONLY                 5. CABG/OTHER",!,"2. VALVE-ONLY                6. UNKNOWN",!,"3. CABG/Valve"
 K DIR S DIR(0)="LOA^0:6",DIR("A")="Enter your choice(s) separated by commas  (0-6): "
 I $D(SRAO) S DIR("B")=$S($D(SRAO(X)):$P(SRAO(X),"^"),1:"")
 S DIR("?")="Enter applicable types of heart surgery performed."
 S DIR("??")="^D H485^SROACL2" D ^DIR K DIR
 I X="@" S DIR("A")="     SURE YOU WANT TO DELETE ",DIR(0)="Y" D ^DIR K DIR S:Y X="@" Q
 I X=""!(Y["^")!($D(DIRUT)) Q
 D CHECK G:SRQ PRIOR
 Q
H485 N SRH D HELP^DIE(130,"",485,"A","SRH")
 I $G(SRH("DIHELP")) F I=1:1:SRH("DIHELP") W !,?2,SRH("DIHELP",I)
 Q
CHECK N I,C S SRQ=0
 I Y["0",($TR(Y,",","")>0) S SRQ=1 W !,"Do not enter NONE if prior heart surgeries were performed.",! Q
 F I=1:1:$L(Y,",") S C=$P(Y,",",I) Q:C=""  W !?43,C," - " D
 .I "0123456"[C W $S(C=0:"NONE",C=1:"CABG-ONLY",C=2:"VALVE-ONLY",C=3:"CABG/VALVE",C=4:"OTHER",C=5:"CABG/OTHER",C=6:"UNKNOWN",1:"") Q
 S Y=$P(Y,",",1,$L(Y,",")-1)_"^485"
 Q
HWT ; retrieve height & weight from vital, called by sromen-start
 N SRVAL,SRN0,SRSD,SRED,SRHT,SRHTDT ;SR200: remove 1 year HT limit; update MEASUREMENT DATE (#200.1)
 S SRN0=$G(^SRF(SRTN,0)),DFN=$S($D(DFN):DFN,1:$P(SRN0,"^")),SRED=$P(SRN0,"^",9)
H I $P($G(^SRF(SRTN,206)),"^")="" S SRSD=0,SRVAL=$$HW^SROACL1(SRSD,SRED,"HT") D
  .I SRVAL'="" S SRHT=$P(SRVAL,U)+.5\1,$P(^SRF(SRTN,206),"^")=SRHT D
  ..S SRHTDT=$P(SRVAL,U,2) S $P(^SRF(SRTN,200.1),"^",7)=SRHTDT
W I $P($G(^SRF(SRTN,206)),"^",2)="" S SRSD=$$FMADD^XLFDT(SRED,-30),SRVAL=$$HW^SROACL1(SRSD,SRED,"WT") D
  .I SRVAL'="" S SRVAL=SRVAL+.5\1,$P(^SRF(SRTN,206),"^",2)=SRVAL
  Q
