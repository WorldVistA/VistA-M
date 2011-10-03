SDCOU2 ;ALB/RMO - Utilities Cont. - Check Out;16 MAR 1993 1:00 pm
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
EXOE(E) ;Determine if Encounter is Exempt from Outpatient Classifications
 ; Input  -- E        Outpatient Encounter IEN
 ; Output -- 1=Yes and 0=No
 N E0,Y
 S E0=$G(^SCE(+E,0)) G EXOEQ:E0']""
 I $$EX(+$P(E0,"^",3),+E0) D
 .S Y=1
 .I $P(E0,"^",8)=1,$P($G(^SC(+$P(E0,"^",4),0)),"^",18),'$$EX(+$P(^(0),"^",18),+E0) S Y=0
EXOEQ Q +$G(Y)
 ;
EX(C,D) ;Determine if Clinic Stop Code is Exempt from Outpatient Classifications
 ; Input  -- C        Clinic Stop Code file IEN
 ;           D        Date/Time  (Optional- default today@2359)
 ; Output -- 1=Yes and 0=No
 N E,S,Y
 S D=$S($G(D)>0:D,1:DT) S:'$P(D,".",2) D=D_.2359
 S S=+$P($G(^DIC(40.7,+C,0)),"^",2)
 S E=+$O(^SD(409.45,"B",S,0))
 I $D(^SD(409.45,E,"E",+$O(^(+$O(^SD(409.45,E,"E","AID",-D)),0)),0)),$P($G(^(0)),"^",2) S Y=1
 Q +$G(Y)
