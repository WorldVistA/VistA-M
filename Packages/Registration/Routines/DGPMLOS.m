DGPMLOS ;ALB/MIR - DETERMINE LOS FOR ADMISSION EPISODE; 8 FEB 90
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;INPUT:  DGPMIFN = IFN of admission movement for which you want LOS to
 ;                  be calculated.
 ;OUTPUT:       X = TOTAL ELAPSED TIME_"^"_TIME ON ABSENCE_"^"_TIME ON PASS_"^"_TIME ASIH_"^"_ACTUAL LENGTH OF STAY
 ;
 N A,D,DFN,DGE,DGS,I,X1,X2 S (LOP,LOA,LOAS)=0
 I $S('$D(DGPMIFN):1,'$D(^DGPM(+DGPMIFN,0)):1,$P(^(0),"^",2)'=1:1,1:0) S X="0^0^0^0^0" G Q
 D NOW^%DTC S X=^DGPM(+DGPMIFN,0),DFN=$P(^(0),"^",3),(X2,A)=+X,D=$S($D(^DGPM(+$P(X,"^",17),0)):+^(0),1:""),(X1,D)=$S('D:%,D>%:%,1:D)
 D ^%DTC S LOS=$S(X:X,1:1) ;LOS = elapsed time between admission and discharge (or NOW)
 F I=A:0 S I=$O(^DGPM("APCA",DFN,DGPMIFN,I)) Q:'I  S DGS=$O(^(I,0)) I $D(^DGPM(+DGS,0)) S DGS=^(0) I "^1^2^3^13^43^44^45^"[("^"_$P(DGS,"^",18)_"^") S X2=+DGS,DGS=$P(DGS,"^",18) D ABS Q:'I
 S X=LOS_"^"_LOA_"^"_LOP_"^"_LOAS_"^"_(LOS-LOA-LOAS)
Q K LOS,LOA,LOP,LOAS Q
ABS ;if patient was out on absence, find return
 ;DGS = mvt type at start of absence
 ;DGE = mvt type at end of absence
 S X1=0 F I=I:0 S I=$O(^DGPM("APCA",DFN,DGPMIFN,I)) Q:'I  S DGE=$O(^(I,0)) I $D(^DGPM(+DGE,0)) S DGE=^(0) I "^14^22^23^24^"[("^"_$P(DGE,"^",18)_"^") S X1=+DGE,DGE=$P(DGE,"^",18) Q
 I 'X1 S X1=D ;if no return from absence, use discharge or NOW
 D ^%DTC S X=$S(X:X,1:1) I DGS=1,$S('$D(DGE):1,DGE'=25:1,1:0) S LOP=LOP+X Q  ;if TO AA <96, but not FROM AA<96, count as absence, not pass
 I "^1^2^3^25^26^"[("^"_DGS_"^") S LOA=LOA+X Q
 S LOAS=LOAS+X Q
 ;
EN ;Entry point for computed fields in 405
 Q:$P(^DGPM(D0,0),U,2)'=1  S DGPMIFN=D0 D DGPMLOS
 Q
