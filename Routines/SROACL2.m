SROACL2 ;BIR/SJA - CLINICAL DATA ;05/17/04
 ;;3.0; Surgery ;**125,160**;24 Jun 93;Build 7
 D HDR^SROAUTL N SRQ
PRIOR W !,"Prior heart surgeries:"
 W !!,"0. None                      3. CABG/Valve",!,"1. CABG-only                 4. Other",!,"2. Valve-only                5. CABG/Other",!
 K DIR S DIR(0)="LOA^0:5",DIR("A")="Enter your choice(s) separated by commas  (0-5): ",DIR("B")=$S($D(SRAO(15)):$P(SRAO(15),"^"),1:"")
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
 I Y["0",(Y["1"!(Y["2")!(Y["3")!(Y["4")!(Y["5")) S SRQ=1 W !,"Do not enter NONE if prior heart surgeries were performed.",! Q
 F I=1:1:$L(Y,",") S C=$P(Y,",",I) Q:C=""  W !?43,C," - " D
 .I "012345"[C W $S(C=1:"CABG-only",C=2:"Valve-only",C=3:"CABG/Valve",C=4:"Other",C=0:"None",C=5:"CABG/Other",1:"") Q
 S (SRAO(15),Y)=$P(Y,",",1,$L(Y,",")-1)_"^485"
 Q
