VADPT32 ;ALB/MRL/MJK - PATIENT VARIABLES [IN5], CONT.; 12 DEC 1988
 ;;5.3;Registration;;Aug 13, 1993
 ;Inpatient variables [Version 5.0 and above]
 ;
BLD ; build array of mvt in reverse order up one before E mvt
 K ^UTILITY("VADPTZ",$J,DFN) S (VANN,VAQ,VAZ,VACC)=0
 I "^4^5^"[("^"_$P(VAMV0,"^",2)_"^") D LODGER G BLDQ
 F I=0:0 S VAZ=$O(^DGPM("APMV",DFN,VAX("CA"),VAZ)),VAZ(1)=0 Q:VAQ!(VAZ'>0)  F I1=0:0 S VAZ(1)=$O(^DGPM("APMV",DFN,VAX("CA"),VAZ,VAZ(1))) Q:VAQ!(VAZ(1)'>0)  S VACC=VACC+1 D BA
BLDQ K VACC,VAQ,VAZ Q
 ;
BA ;Build Movement Array
 I VANN,VACC=(VANN+2) S VAQ=1 Q
 S:VAZ(1)=+E VANN=VACC S X=$S($D(^DGPM(+VAZ(1),0)):^(0),1:""),^UTILITY("VADPTZ",$J,DFN,VACC)=VAZ(1)_"||"_X Q
 ;
LODGER ;
 S VANN=1,X=^DGPM(E,0)
 I $P(X,"^",2)=5 S ^UTILITY("VADPTZ",$J,DFN,1)=E_"||"_X S:$D(^DGPM(+$P(X,"^",14),0)) ^UTILITY("VADPTZ",$J,DFN,2)=+$P(X,"^",14)_"||"_^(0)
 I $P(X,"^",2)=4 S:$D(^DGPM(+$P(X,"^",17),0)) ^UTILITY("VADPTZ",$J,DFN,1)=+$P(X,"^",17)_"||"_^(0),VANN=2 S ^UTILITY("VADPTZ",$J,DFN,VANN)=E_"||"_X
 Q
