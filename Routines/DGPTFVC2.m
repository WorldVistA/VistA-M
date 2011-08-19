DGPTFVC2 ;ALB/MJK - Expanded PTF Close-Out Edits ; Jul 20 88
 ;;5.3;Registration;;Aug 13, 1993
 ;called from Q+2^DGPTFTR
 ; input : PTF
 ; output: DGERR   DGERR := 1  if record fails to pass a check
 ;                 DGERR := "" if record passes all checks
EN ;
 Q:'$D(PTF)
 ; -- count mvts
 S DGMAX=25,DGERR="" N C,DGM,I,Y
 F DGM=501,535 S Y=PTF D @DGM I C>DGMAX S DGERR=1 W !,DGM,"  There are '",C,"' ",DGM," movements but only '",DGMAX,"' can be sent to Austin."
 I DGERR W !,"     *** Contact PTF supervisor ***" G ENQ
 ; -- check proc/surg dates
 G ENQ:T1
 S DGDCDT=+$S($D(^DGPT(PTF,70)):^(70),1:"")
 F DGM="P","S" F I=0:0 S I=$O(^DGPT(PTF,DGM,I)) Q:'I  I $D(^(I,0)),+^(0)>DGDCDT S Y=^(0) D ERROR
ENQ K DGMAX,DGDCDT Q
 ;
ERROR ;
 S:'$D(^UTILITY("DG",$J,$S(DGM="P":601,1:401),I)) ^(I)="^" S X=^(I) S:X'["^1^" ^(I)=X_"1^"
 S DGERR=1,Y=+Y X ^DD("DD") W !,">>>> ",$S(DGM="P":"Procedure",1:"Surgery")," date/time of '",Y,"' is after the discharge date."
 ;
LINES ; -- count the number of lines to be xmited for PTF rec
 ; input : Y := ifn of ^DGPT
 ; output: X := line count
 ;
 N NODE,C S X=2
 D 501 S X=X+C D 535 S X=X+C F NODE="P","S" F %=0:0 S %=$O(^DGPT(Y,NODE,%)) Q:'%  I $D(^(%,0)),+^(0)'<T1,+^(0)'>T2 S X=X+1
 Q
 ;
501 ; -- count 501 mvts to xmit
 ; input : Y    := IFN
 ;         DGMTY := indicates entering from flag option [optional]
 ; output: C    := # of entries
 ;
 N Z,D S C=1 ; always one 501
 ; count & check if between date range & ok to xmit
 F %=1:0 S %=$O(^DGPT(Y,"M",%)) Q:'%  S C=C+1 I '$D(DGMTY),$D(^(%,0)) S Z=^(0),D=$P(Z,U,10) I D<T1!(D>T2)!($P(Z,U,17)="n") S C=C-1
 Q
 ;
535 ; -- count 535 mvts to xmit
 ; input : Y    := IFN
 ;         DGMTY := indicates entering from flag option [optional]
 ; output: C    := # of entries
 ;
 N Z,D S C=0
 ; count & check if between date range & ok to xmit & not a 501 on date
 F %=0:0 S %=$O(^DGPT(Y,535,%)) Q:'%  S C=C+1 I '$D(DGMTY),$D(^(%,0)) S Z=^(0),D=$P(Z,U,10) I 'D!(D<T1)!(D>T2)!($P(Z,U,17)="n")!($D(^DGPT(Y,"M","AM",+D))) S C=C-1
 Q
 ;
