PSOEXREF ;BHAM/RTR - Cross references for External Interface File ; 03/20/96 09:45
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 ;
SDATE ;Set logic for Date/Time field
 S:$P($G(^PS(52.51,DA,0)),"^",11)&($P($G(^(0)),"^",4)) ^PS(52.51,"AS",X,$P(^PS(52.51,DA,0),"^",11),$P(^(0),"^",4),DA)=""
 Q
KDATE ;Kill logic for Date/Time field
 K:$P($G(^PS(52.51,DA,0)),"^",11)&($P($G(^(0)),"^",4)) ^PS(52.51,"AS",X,$P(^PS(52.51,DA,0),"^",11),$P(^(0),"^",4),DA)
 Q
SDIV ;Set logic for Division Field
 S:$P($G(^PS(52.51,DA,0)),"^",3)&($P($G(^(0)),"^",4)) ^PS(52.51,"AS",$P(^PS(52.51,DA,0),"^",3),X,$P(^(0),"^",4),DA)=""
 Q
KDIV ;Kill logic for Division field
 K:$P($G(^PS(52.51,DA,0)),"^",3)&($P($G(^(0)),"^",4)) ^PS(52.51,"AS",$P(^PS(52.51,DA,0),"^",3),X,$P(^(0),"^",4),DA)
 Q
SPER ;Set logic for person field
 S:$P($G(^PS(52.51,DA,0)),"^",3)&($P($G(^(0)),"^",11)) ^PS(52.51,"AS",$P(^PS(52.51,DA,0),"^",3),$P(^(0),"^",11),X,DA)=""
 Q
KPER ;Kill logic for person field
 K:$P($G(^PS(52.51,DA,0)),"^",3)&($P($G(^(0)),"^",11)) ^PS(52.51,"AS",$P(^PS(52.51,DA,0),"^",3),$P(^(0),"^",11),X,DA)
 Q
SMES ;Set Logic for Message ID
 S:$P($G(^PS(52.51,DA,0)),"^",11) ^PS(52.51,"AM",X,$P(^PS(52.51,DA,0),"^",11),DA)=""
 Q
KMES ;Kill Logic for Message ID
 K:$P($G(^PS(52.51,DA,0)),"^",11) ^PS(52.51,"AM",X,$P(^PS(52.51,DA,0),"^",11),DA)
 Q
SDIVM ;Set logic for Division (Message Server ID)
 S:$P($G(^PS(52.51,DA,1)),"^")'="" ^PS(52.51,"AM",$P(^PS(52.51,DA,1),"^"),X,DA)=""
 Q
KDIVM ;Kill logic for Division (Message Server ID)
 K:$P($G(^PS(52.51,DA,1)),"^")'="" ^PS(52.51,"AM",$P(^PS(52.51,DA,1),"^"),X,DA)
 Q
