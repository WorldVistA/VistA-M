SCDXUTL5 ;ALB/ABR - RETRANSMIT CORRECTED HL7 UTILITY ; 10/25/96
 ;;5.3;Scheduling;**70**;AUG 13, 1993
 ;
EN ;
 N DA,DIE,DR,ENC,ENCNODE,II,SDDATE,SDDAY,SDEN,SDN,SDPATCH,X,X1,X2
 ;   +SDPATCH = date/time of patch install
 ;    SDDATE = last date run (starting point for today's run
 S SDPATCH=$G(^SD(404.91,1,"PATCH70")) Q:'SDPATCH
 S (SDDATE,X1)=$P(SDPATCH,U,2),X2=3
 Q:'SDDATE  ;update complete
 ;
 D C^%DTC ; find date + 3
 S $P(SDDATE,".",2)=9,SDDAY=$P(X,".") I SDDAY>DT S SDDAY=DT ; cannot be greater than today
 S SDEND=SDDAY+.9,SDSTA=SDDATE ; end date, start from date
 ;
 D DELTX
 D NOXMIT
 D SETFL
 I SDDATE,SDDAY<DT S $P(^SD(404.91,1,"PATCH70"),U,2)=SDDAY G ENQ
 D CLNDONE
ENQ Q
 ;
DELTX ; deleted encounters
 N SDEL
 S SDEL=0
 F  S SDEL=$O(^SD(409.73,"ADEL",SDEL)) Q:'SDEL  D
 . I +$G(^SD(409.74,SDEL,0))<SDDATE Q  ; quit if delete for already xmited enc.
 . S SDN=$O(^SD(409.73,"ADEL",SDEL,0))
 . ; clean out files, reset 0-nodes
 . D KILL("^SD(409.74,",SDEL)
 . D:SDN KILL("^SD(409.73,",SDN)
 Q
KILL(DIK,DA) ; cleans out deleted encounters
 D ^DIK
 Q
 ;
NOXMIT ; don't transmit encounters out of date range
 N SDX,SDX1
 S SDX=0
 F  S SDX=$O(^SD(409.73,"AACXMIT",SDX)) Q:'SDX  D
 . F SDX1=0:0 S SDX1=$O(^SD(409.73,"AACXMIT",SDX,SDX1)) Q:'SDX1  D
 ..; check if encounter beyond today's send range
 .. S SDEN=+$P($G(^SD(409.73,SDX1,0)),U,2) Q:'SDEN  I $G(^SCE(SDEN,0))>SDEND!('$G(^SCE(SDEN,0))) D
 ...S DIE="^SD(409.73,",DA=SDX1,DR=".04////0" D ^DIE
 Q
SETFL ; loop checks encounters transmitted up through date/time of patch installation
 F  S SDDATE=$O(^SCE("B",SDDATE)) Q:'SDDATE!(SDDATE>SDEND)  D
 . F SDEN=0:0 S SDEN=$O(^SCE("B",SDDATE,SDEN)) Q:'SDEN  S SDN=$O(^SD(409.73,"AENC",SDEN,0)) I SDN D
 .. ; quit if xmit date after patch install or already set to YES
 .. Q:($G(^SD(409.73,SDN,1))>SDPATCH)!$P($G(^(0)),U,4)
 .. S DIE="^SD(409.73,",DR=".04////1",DA=SDN D ^DIE
 Q
 ;
CLNDONE ; cleanup done
 ;update node and create bulletin
 S $P(^SD(404.91,1,"PATCH70"),U,2)=""
 ;
MSG N MSGTXT,XMB,XMTEXT,XMY,XMDUZ,XMDT,XMZ,DIFROM
 S XMB="SCDX AMBCARE TO NPCDB SUMMARY"
 ; recipients are same as for SCDX AMBCARE TO NPCDB SUMMARY bulletin
 ; and group at Albany IRMFO
 S XMY("G.ACRP MAINTENANCE@ISC-ALBANY")=""
 S XMB(1)="** HL7 TRANSMISSIONS UP-TO-DATE **" ;subject
 ; message text
 S MSGTXT(1)="Patch SD*5.3*70 began retransmitting Ambulatory Care Reporting Project"
 S MSGTXT(2)="(ACRP) data beginning with encounters on 10/1.  The retransmission of past"
 S MSGTXT(3)="workload is now complete.  The nightly background job will now resume"
 S MSGTXT(4)="normal operations."
 S XMTEXT="MSGTXT("
 ;
 D ^XMB
 Q
