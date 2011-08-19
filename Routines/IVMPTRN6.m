IVMPTRN6 ;ALB/CPM - UPDATE BILLING TRANSMISSION FILE ; 13-JUN-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
UPDATE ; Roll through billing activity and update file #301.61 if necessary
 ;  Input:  the array ^TMP("IVMPTRN5",$J), which is built in
 ;          the routine IVMPTRN5 and fully described in the
 ;          routine IBAMTV4.
 ;
 S IVMREF="" F  S IVMREF=$O(^TMP("IVMPTRN5",$J,IVMREF)) Q:IVMREF=""  S IVMSTR=$G(^(IVMREF)) I IVMSTR D
 .;
 .; - if an uncancelled bill is not recorded, add it
 .S IVMTDA=$O(^IVM(301.61,"B",IVMREF,0)) I 'IVMTDA D  Q
 ..Q:$P(IVMSTR,"^",10)
 ..S IVMTDA=$$ADD^IVMUFNC3(IVMREF) Q:'IVMTDA
 ..D NOW^%DTC S $P(^IVM(301.61,IVMTDA,0),"^",2,11)=$P(IVMSTR,"^",1,10),$P(^(1),"^",3,4)=%_"^"_DUZ
 ..S DA=IVMTDA,DIK="^IVM(301.61," D IX1^DIK
 ..;
 ..; - trigger transmission
 ..I $P(IVMSTR,"^",3)>1,$P(IVMSTR,"^",11) Q  ; bill is on hold
 ..D TRANS(IVMTDA,1)
 .;
 .; - see if a transmission is not required
 .S IVMQ=0,IVMTN=$G(^IVM(301.61,IVMTDA,0)) Q:'IVMTN
 .I $P(IVMTN,"^",14) D  Q:IVMQ
 ..I $P(IVMTN,"^",10)!$P(IVMTN,"^",11) S IVMQ=1 Q
 ..I $P(IVMTN,"^",4)>1,'$P(IVMSTR,"^",10),$P(IVMTN,"^",8)=$P(IVMSTR,"^",7) S IVMQ=1 Q
 .;
 .; - if a billed charge was cancelled, zero out amt and queue trans.
 .I $P(IVMTN,"^",13),$P(IVMSTR,"^",10) D  Q
 ..S DA=IVMTDA,DIE="^IVM(301.61,",DR=".08////0;.11////1" D ^DIE K DA,DR,DIE
 ..D TRANS(IVMTDA,1)
 .;
 .; - if a held charge
 .I '$P(IVMTN,"^",13) D  Q:IVMQ
 ..;
 ..; - is still on hold, quit
 ..I $P(IVMSTR,"^",11) S IVMQ=1 Q
 ..;
 ..; - was cancelled, delete record
 ..I $P(IVMSTR,"^",10) S DA=IVMTDA,DIK="^IVM(301.61," D ^DIK K DA,DIK S IVMQ=1
 .;
 .; - is no longer on hold, update record and queue transmission
 .I '$P(IVMTN,"^",13),'$P(IVMSTR,"^",11) D
 ..S DR=".05////"_$P(IVMSTR,"^",4)_";.06////"_$P(IVMSTR,"^",5)_";.07////"_$P(IVMSTR,"^",6)_";.08////"_$P(IVMSTR,"^",7)
 ..S DA=IVMTDA,DIE="^IVM(301.61," D ^DIE K DA,DR,DIE
 ..D TRANS(IVMTDA,1)
 .;
 .; - if amts billed/collected, or status changes, update and queue
 .I +$P(IVMTN,"^",8)=+$P(IVMSTR,"^",7),+$P(IVMTN,"^",11)=+$P(IVMSTR,"^",10) D  Q:IVMQ
 ..I $P(IVMTN,"^",4)>1 S IVMQ=1 Q
 ..I +$P(IVMTN,"^",9)=+$P(IVMSTR,"^",8),+$P(IVMTN,"^",10)=+$P(IVMSTR,"^",9) S IVMQ=1 Q
 .;
 .S DR=".05////"_$P(IVMSTR,"^",4)_";.06////"_$P(IVMSTR,"^",5)_";.08////"_$P(IVMSTR,"^",7)
 .I $P(IVMTN,"^",4)=1 S DR=DR_$S($P(IVMSTR,"^",8):";.09////"_$P(IVMSTR,"^",8),1:"")_$S($P(IVMSTR,"^",9):";.1////"_$P(IVMSTR,"^",9),1:"")
 .I $P(IVMSTR,"^",10) S DR=DR_";.11////1"
 .S DA=IVMTDA,DIE="^IVM(301.61," D ^DIE K DA,DR,DIE
 .D TRANS(IVMTDA,1)
 ;
 K IVMREF,IVMSTR,IVMTDA,IVMQ,IVMTN,^TMP("IVMPTRN5",$J)
 Q
 ;
 ;
TRANS(DA,IVMF) ; Set bill to be transmitted
 ;  Input:    DA  --  Pointer to transmission record in #301.61
 ;          IVMF  --  Flag to queue transmission [1=Yes, 0=No]
 I '$G(DA) G TRANSQ
 N DR,DIE
 S DIE="^IVM(301.61,",DR=".12////"_+$G(IVMF)_";1.03///NOW;1.04////"_DUZ D ^DIE
TRANSQ Q
