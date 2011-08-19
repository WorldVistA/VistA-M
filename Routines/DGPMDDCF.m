DGPMDDCF ;ALB/MIR - COMPUTED FIELDS IN FILES 42,405.4 ; 29 MAY 90 @1400
 ;;5.3;Registration;;Aug 13, 1993
 ;called from computed fields in ward location and room-bed files
WIN ;is this ward location currently inactive?  (1=inactive, 0=active)
 ;input:      D0 = IFN of WARD LOCATION file
 ;        DGPMOS = date for which you would like to know.  leave
 ;                 undefined if desired date is today.
 ;output:      X = 1 if inactive (out-of-service), 0 otherwise
 ;                 (-1 if D0 not defined or date not valid)
 ;
 ; (called from record tracking package)
 N DGX,DGY S X=-1 Q:'$D(D0)  S DGY=$S($D(DGPMOS):DGPMOS,1:DT)
 S DGY=$P(DGY,".") I DGY'?7N G WINQ
 S DGX=+$O(^DIC(42,D0,"OOS","AINV",9999998.9-DGY)),DGX=$S($D(^DIC(42,D0,"OOS",+$O(^(+DGX,0)),0)):^(0),1:"")
 I '$P(DGX,U,6) S X=0 G WINQ
 I $P(DGX,U,6),'$P(DGX,U,4) S X=1 G WINQ
 I $P(DGX,U,6),$P(DGX,U,4)<DGY S X=0 G WINQ
 S X=1
WINQ Q
 ;
 ;
RIN ;inactive check for room-bed...same input/output as above except for room-bed file
 ;
 N DGX,DGY S X=-1 Q:'$D(D0)  S DGY=$S($D(DGPMOS):DGPMOS,1:DT)
 S DGY=$P(DGY,".") I DGY'?7N Q
 S DGX=9999998.9-DGY,DGX=$O(^DG(405.4,D0,"I","AINV",+DGX)),DGX=$O(^(+DGX,0)) S DGX=$S($D(^DG(405.4,D0,"I",+DGX,0)):$P(^(0),"^",4),1:-1)
 S X=$S(DGX=-1:0,'DGX:1,DGX<DGY:0,1:1)
 Q
BOS ;computed field in DIC(42...beds out of service
 ;input:     D0 = IFN of WARD LOCATION file
 ;       DGPMOS = date for which you want to compute number of beds
 ;                out-of-service.  Leave undefined if desired date is
 ;                today.
 ;output:     X = number of beds out-of-service for given ward.
 ;
 N DGC,DGY S X=-1 Q:'$D(D0)  S DGY=$S($D(DGPMOS):DGPMOS,1:DT)
 S DGY=$P(DGY,".") I DGY'?7N G BOSQ
 S DGX=+$O(^DIC(42,D0,"OOS","AINV",9999998.9-DGY)),DGX=$S($D(^DIC(42,D0,"OOS",+$O(^(+DGX,0)),0)):^(0),1:"")
 I '$P(DGX,U,11) S X=0 G BOSQ
 I $P(DGX,U,11),'$P(DGX,U,4) S X=$P(DGX,U,11) G BOSQ
 I $P(DGX,U,11),$P(DGX,U,4)<DGY S X=0 G BOSQ
 S X=$P(DGX,U,11)
BOSQ Q
 ;
AUTH ;computed field in DIC(42...authorized beds
 ;input:     D0 = IFN of WARD LOCATION file
 ;       DGPMOS = date for which you want number of auth beds.
 ;                today is assumed when not defined.
 ;output:     X = number of authorized beds
 N DGX S X=-1 Q:'$D(D0)  S DGY=$S($D(DGPMOS):DGPMOS,1:DT)
 S DGY=$P(DGY,".") I DGY'?7N G AUTHQ
 S DGX=$O(^DIC(42,D0,"AUTH","AINV",9999998.8-DGY)),DGX=$S($D(^DIC(42,D0,"AUTH",+$O(^(+DGX,0)),0)):^(0),1:"")
 S X=+$P(DGX,"^",2)
AUTHQ Q
 ;
OPER ;computed field in DIC(42...operating beds (auth - o-o-s)
 ;input:     D0 = IFN of WARD LOCATION file
 ;       DGPMOS = date for which you want number of operating beds.
 ;                DT used if not defined.
 N DGPMX,DGY S X=-1 Q:'$D(D0)  S DGY=$S($D(DGPMOS):DGPMOS,1:DT)
 S DGY=$P(DGY,".") I DGY'?7N G OPERQ
 D AUTH S DGPMX=$S(X=-1:0,1:X) D BOS S X=DGPMX-$S(X=-1:0,1:X)
OPERQ Q
