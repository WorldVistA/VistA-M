RMPREOPS ;HINES-IO/HNC -POST INIT ;2-29-00
 ;;3.0;PROSTHETICS;**45**;Feb 09, 1996
 ;post init, set all to manual if no type
 ;set manual record
 S BC=0
 F  S BC=$O(^RMPR(668,BC)) Q:BC'>0  D
 .Q:$P(^RMPR(668,BC,0),U,8)
 .S $P(^RMPR(668,BC,0),U,8)=5
 ;set status open or closed
 S BC=0,STATUS=""
 F  S BC=$O(^RMPR(668,BC)) Q:BC'>0  D
 .S STATUS=$P(^RMPR(668,BC,0),U,10)
 .I STATUS'="" Q
 .S CLOSED=$P(^RMPR(668,BC,0),U,5)
 .S $P(^RMPR(668,BC,0),U,9)=CLOSED
 .I (CLOSED'="")&('$D(^RMPR(668,BC,4))) S ^RMPR(668,BC,4,0)="^668.012^1^1^"_DT_"^^"
 .I CLOSED'="" S $P(^RMPR(668,BC,0),U,10)="C"
 .I CLOSED="" S $P(^RMPR(668,BC,0),U,10)="O"
 .I (CLOSED'="")&('$D(^RMPR(668,BC,4,1))) S ^RMPR(668,BC,4,1,0)="Old suspense record, no completion note available."
 .S CLBY=$P(^RMPR(668,BC,0),U,6)
 .S $P(^RMPR(668,BC,0),U,12)=CLBY
 .K CLOSED,CLBY
 ;set E x-ref on Status field 14
 S DIK="^RMPR(668,"
 S DIK(1)="14^E"
 D ENALL^DIK
 Q
 ;
 ;END
