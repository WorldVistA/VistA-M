DGPMV300 ;ALB/MIR - EDITS FOR DATE/TIME ;12 NOV 89 @8
 ;;5.3;Registration;;Aug 13, 1993
EDITS ;date/time edits needed for both new and existing entries
 S DGI=$O(^DGPM("APMV",DFN,DGPMCA,0)),DGJ=$S($D(^DGPM(+$O(^(DGI,0)),0)):^(0),1:""),DGI=$S($D(^DGPM(+DGJ,0)):^(0),1:""),DGK=$P(DGI,"^",18)
 I DGK=1 S X1=+DGI,X2=4 D C^%DTC I DGPMY>X S DGPME="Must be less than 96 hours" Q
 I DGK=2 S X1=+DGI,X2=4 D C^%DTC I DGPMY'>X S DGPME="Must be more than 96 hours" Q
 ;discharge or transfer must be within 30 days of going to ASIH
 S K=0 I DGK=13!(DGK=43) S K=DGJ
 I DGK=44!(DGK=45) F I=0:0 S I=$O(^DGPM("APMV",DFN,DGPMCA,I)) Q:'I  S J=$O(^(I,0)) I $D(^DGPM(+J,0)),("^13^43^"[("^"_$P(^(0),"^",18)_"^")) S K=^(0) Q
 I K S X1=+K,X2=30 D C^%DTC I DGPMY>X S DGPME="Must be within 30 days of original transfer to ASIH" Q
 K DGI,DGJ,DGK,I,J,K Q
 ;
ASIHADM ;Check to make an ASIH admit remains within 30 days of it's discharge if appropriate
 I $S('$D(^DGPM(+$P(DGPMAN,"^",21),0)):1,$P(^(0),"^",18)=13:0,1:1) Q
 S DGX=$S($D(^DGPM(+$P(DGPMAN,"^",17),0)):^(0),1:"") I 'DGX Q
 S X1=+DGPMP,X2=30 D C^%DTC S DGX1=X
 S X1=DGPMY,X2=30 D C^%DTC S DGX2=X
 I DGX1>DGX,(DGX2'>DGX) S DGPME="Must remain more than 30 days from time of return from ASIH."
 I DGX1<DGX,(DGX2'<DGX) S DGPME="Must remain within 30 days of return from ASIH."
 K DGX,DGX1,DGX2 Q
