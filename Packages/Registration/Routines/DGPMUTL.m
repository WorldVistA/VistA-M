DGPMUTL ;ALB/MJK - SELECT PATIENT MOVEMENT FOR PATIENT ; 3/24/90 1PM ;
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN ; -- sets DIC and DIC(0) before calling DFN (*** FOR MAS USE ONLY ***)
 ;    input: DFN
 ;           All desired DIC variables except DIC and DIC(0)
 ;   output: Y, X, DTOUT, DUOUT as defined by FM documentation for ^DIC
 ;
 S DIC="^DGPM(",DIC(0)="QES" D DFN
 Q
 ;
DFN ; -- select mvt for DFN patient            (*** FOR MAS USE ONLY ***)
 ;    input: DFN
 ;           All desired DIC variables
 ;   output: Y, X, DTOUT, DUOUT as defined by FM documentation for ^DIC
 ;
 S Y=-1,X="" G DFNQ:'$D(^DPT(DFN,0)) S X=^(0)
 W !,$S($D(DIC("A")):DIC("A"),1:"Select Movement for "_$P(X,"^")_": ") I $D(DIC("B")) W DIC("B")_"// "
 R X:DTIME I '$T S DTOUT="",Y=-1,X="" G DFNQ
 I X="",$D(DIC("B")) S X=DIC("B")
 I "^"[X S Y=-1 S:X="^" DUOUT="" G DFNQ
 I $E(X)["?" D DIC G DFN
 I X'=" ",$E(X)'="`" S %DT="ETP" D ^%DT K %DT G DFNQ:$D(DTOUT),DFN:+Y<0 S X=Y
 D DIC G DFNQ:$D(DTOUT),DFN:+Y<0
DFNQ K D Q
 ;
DIC ;
 F %="A","M","N" S:DIC(0)[% DIC(0)=$P(DIC(0),%)_$P(DIC(0),%,2)
 S D="ADFN"_DFN D IX^DIC
 Q
 ;
WARD ; -- determine ward at discharge
 ;     o  called by WARD AT DISCHARGE(c) field in pt mvt file
 ; input: D0 := d/c ifn of pat. mvt. file
 ;output:  X := ward name
 ;
 S X="" N IDT,MVT,CA,DFN,M
 G WARDQ:'$D(^DGPM(D0,0)) S M=^(0) G WARDQ:$P(M,U,2)'=3
 S CA=+$P(M,U,14),DFN=+$P(M,U,3)
 F IDT=0:0 S IDT=$O(^DGPM("APMV",DFN,CA,IDT)) Q:'IDT  F MVT=0:0 S MVT=$O(^DGPM("APMV",DFN,CA,IDT,MVT)) Q:'MVT  I $D(^DGPM(MVT,0)) S M=^(0) I "^13^43^44^45^"'[(U_$P(M,U,18)_U),$D(^DIC(42,+$P(M,U,6),0)) S X=$P(^(0),U) G WARDQ
WARDQ Q
 ;
PTF(DGPTF) ; -- determine ward at discharge
 ;     o  called by WARD AT DISCHARGE(c) field in PTF file
 ; input: DGPTF := ifn of ptf file
 ;output:     X := ward name
 ;
 N D0
 S D0=+$P($G(^DGPM(+$O(^DGPM("APTF",DGPTF,0)),0)),U,17)
 D WARD
 Q
