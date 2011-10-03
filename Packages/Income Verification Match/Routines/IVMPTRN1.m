IVMPTRN1 ;ALB/MLI - Clock routine for testing only ; 04-MAY-93
 ;;2.0;INCOME VERIFICATION MATCH;**9**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
START ; start clock                              remove after v1
 D NOW^%DTC S IVMBEG=%
 K %
 Q
 ;
 ;
STOP ; stop clock, mail bulletin                remove after v1
 N X,Y ; from DTC call
 I '$G(IVMGTOT) G STOPQ
 D NOW^%DTC S IVMEND=%
 S IVMTEXT(1)="The IVM bulk transmission has completed successfully.",IVMTEXT(2)=" "
 S IVMTEXT(3)="Start Time:                   "_IVMBEG
 S IVMTEXT(4)="End Time:                     "_IVMEND
 S IVMTEXT(5)="Number of Transmissions:      "_IVMGTOT
 X ^%ZOSF("UCI")
 S XMTEXT="IVMTEXT(",XMSUB="IVM BULK TRANSMISSION HAS COMPLETED"
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
STOPQ K IVMGBEG,IVMEND,IVMGTOT
 K XMTEXT,IVMTEXT,XMSUB,XMDUZ,XMY
 Q
 ;
 ;
DELMT ; send delete mt transaction if pt no longer meets IVM criteria
 ;
 ; Input - DFN
 ;         IVMMTDT - date of means test
 ;
 N I,IVMIY,X
 S IVMIY=$$LYR^DGMTSCU1(IVMMTDT)
 F I=1:1:5,8:1:14 S $P(X,HLFS,I)=HLQ
 S ^TMP("HLS",$J,HLSDT,IVMCT)="ZMT"_HLFS_X
 D CLOSE(IVMIY,DFN,2,3) ; set flag to stop future transmissions
 Q
 ;
 ;
CLOSE(IVMIY,DFN,IVMCS,IVMCR) ; Close IVM case record for a patient
 ; Input:    DFN  --  Pointer to the patient in file #2
 ;         IVMIY  --  Income year of the closed case
 ;         IVMCS  --  Closure source [1=IVM | 2=DHCP]
 ;         IVMCR  --  Pointer to the closure reason in file #301.93
 ;
 N DA,DIE,DR,X,Y,EVENTS,STATUS
 I '$G(IVMIY)!'$G(DFN)!'$G(IVMCS)!'$G(IVMCR) G CLOSEQ
 S IVMDELMT=1 ; flag indicates deletion
 S DA=$O(^IVM(301.5,"APT",+DFN,+IVMIY,0))
 I $G(^IVM(301.5,+DA,0))']"" G CLOSEQ
 ;
 ;don't want closing a case to stop transmission of an enrollment event
 S STATUS=1
 I ($$STATUS^IVMPLOG(+DA,.EVENTS)=0),EVENTS("ENROLL")=1 S STATUS=0
 ;
 D NOW^%DTC S DR=".03////"_STATUS_";.04////1;1.01////"_IVMCR_";1.02////"_IVMCS_";1.03////"_%
 S DIE="^IVM(301.5," D ^DIE
CLOSEQ Q
 ;
 ;
PSEUDO ; strip P from pseudo SSNs before transmitting to IVM
 ;
 N X
 S X=IVMPID_$G(IVMPID(1))
 S $P(X,HLFS,20)=$E($P(X,HLFS,20),1,9) ; remove P
 K IVMPID S IVMPID=$E(X,1,245)
 I $L(X)>245 S IVMPID(1)=$E(X,246,999)
 Q
