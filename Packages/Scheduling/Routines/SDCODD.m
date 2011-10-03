SDCODD ;ALB/RMO - Data Dictionary Calls - Check Out;30 DEC 1992 9:00 am
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 ;
ACT(SDCTI,SDDT) ;Determine if Outpatient Classification Type is active
 ; Input  -- SDCTI    Outpatient Classification Type file IEN
 ;           SDDT     Date/Time  (Optional- default today@2359)
 ; Output -- 1=ACTIVE and 0=INACTIVE
 N Y
 S SDDT=$S($G(SDDT)>0:SDDT,1:DT) S:'$P(SDDT,".",2) SDDT=SDDT_.2359
 I $D(^SD(409.41,SDCTI,"E",+$O(^(+$O(^SD(409.41,SDCTI,"E","AID",-SDDT)),0)),0)),$P($G(^(0)),U,2) S Y=1
 Q +$G(Y)
 ;
VAL(SDCTI,Y) ;Determine External Value of Outpatient Classification
 ; Input  -- SDCTI    Outpatient Classification Type file IEN
 ;           Y        Internal Value
 ; Output -- External Value
 N SDCTYP
 S SDCTYP=$P($G(^SD(409.41,SDCTI,0)),U,3)
 I SDCTYP="Y",Y'="" S Y=$S(Y:"YES",1:"NO")
 I SDCTYP="S",Y'="" S Y=$P($P($G(^SD(409.41,SDCTI,2)),Y_":",2),";")
 Q Y
 ;
