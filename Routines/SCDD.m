SCDD ;ALB/RMO - Data Dictionary Calls ;02 DEC 1994 9:00 am [ 12/02/94  1:39 PM ]
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;
ACTSTOP(SCSCI,SCDT) ;Determine if Stop Code is Active
 ; Input  -- SCSCI    Stop Code file IEN
 ;           SCDT     Date/Time  (Optional- default today@2359)
 ; Output -- 1=ACTIVE and 0=INACTIVE
 N Y
 S SCDT=$S($G(SCDT)>0:SCDT,1:DT) S:'$P(SCDT,".",2) SCDT=SCDT_.2359
 I $D(^DIC(40.7,SCSCI,"E",+$O(^(+$O(^DIC(40.7,SCSCI,"E","AID",-SCDT)),0)),0)),$P($G(^(0)),U,2) S Y=1
 Q +$G(Y)
 ;
VALTIME(X) ;Validate Time Format
 ; Input  -- X        Time
 ; Output -- 1=VALID and 0=INVALID
 N Y
 S Y=1
 I $L(X)>4!($L(X)<4)!('X?4N&(X<1700)&(X>1700)&(X#100<60)) S Y=0
 Q +$G(Y)
 ;
