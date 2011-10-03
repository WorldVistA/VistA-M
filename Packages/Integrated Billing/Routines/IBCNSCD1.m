IBCNSCD1 ;ALB/CPM - DELETE INSURANCE COMPANY (CON'T) ; 02-FEB-95
 ;;2.0;INTEGRATED BILLING;**28,46,80**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; 
DQ ; Queued entry point for the final clean-up job.
 ;
 K ^TMP($J,"IBCNSCD")
 L +^IB("IBCNSCD"):5 E  G DDQ ;    another clean-up job got started
 S IBC=0 F  S IBC=$O(^DIC(36,"ADEL",IBC)) Q:'IBC  S ^TMP($J,"IBCNSCD",IBC)=$P($G(^DIC(36,IBC,5)),"^",2)
 I '$D(^TMP($J,"IBCNSCD")) G DDQ ; no companies to be deleted
 ;
 D NOW^%DTC S IBBDT=%
 ;
 ; - dispositions
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S IBC=0 F  S IBC=$O(^DPT(DFN,"DIS",IBC)) Q:'IBC  S IBCO=$P($G(^(IBC,2)),"^",6) I IBCO,$D(^TMP($J,"IBCNSCD",IBCO)) D
 .S $P(^DPT(DFN,"DIS",IBC,2),"^",6)=$G(^TMP($J,"IBCNSCD",IBCO))
 .S IBCT("DIS")=$G(IBCT("DIS"))+1
 .I $G(^TMP($J,"IBCNSCD",IBCO))="" S IBCT("DIS",DFN,IBC)=""
 ;
 ; - insurance companies
 S IBC=0 F  S IBC=$O(^DIC(36,IBC)) Q:'IBC  D
 .S IB0=$G(^DIC(36,IBC,0)),IB12=$G(^(.12)),IB13=$G(^(.13)),IB14=$G(^(.14)),IB16=$G(^(.16)),IB18=$G(^(.18))
 .K IBV
 .I $P(IB0,"^",16),$D(^TMP($J,"IBCNSCD",$P(IB0,"^",16))) S IBV(0)="16^"_^($P(IB0,"^",16))
 .I $P(IB12,"^",7),$D(^TMP($J,"IBCNSCD",$P(IB12,"^",7))) S IBV(.12)="7^"_^($P(IB12,"^",7))
 .I $P(IB13,"^",9),$D(^TMP($J,"IBCNSCD",$P(IB13,"^",9))) S IBV(.13)="9^"_^($P(IB13,"^",9))
 .I $P(IB14,"^",7),$D(^TMP($J,"IBCNSCD",$P(IB14,"^",7))) S IBV(.14)="7^"_^($P(IB14,"^",7))
 .I $P(IB16,"^",7),$D(^TMP($J,"IBCNSCD",$P(IB16,"^",7))) S IBV(.16)="7^"_^($P(IB16,"^",7))
 .I $P(IB18,"^",7),$D(^TMP($J,"IBCNSCD",$P(IB18,"^",7))) S IBV(.18)="7^"_^($P(IB18,"^",7))
 .Q:'$D(IBV)
 .;
 .; - delete or repoint
 .S IBX="" F  S IBX=$O(IBV(IBX)) Q:IBX=""  D
 ..S $P(^DIC(36,IBC,IBX),"^",+IBV(IBX))=$P(IBV(IBX),"^",2)
 ..S IBCT("INS",IBX)=$G(IBCT("INS",IBX))+1
 ..I $P(IBV(IBX),"^",2)="" S IBCT("INS",IBX,IBC)=""
 ;
 ; - insurance reviews
 S IBC=0 F  S IBC=$O(^IBT(356.2,IBC)) Q:'IBC  S IBCO=$P($G(^(IBC,0)),"^",8) I IBCO,$D(^TMP($J,"IBCNSCD",IBCO)) S IBCD=$G(^IBT(356.2,IBC,0)) D
 .S IBVAL=$G(^TMP($J,"IBCNSCD",IBCO)) I 'IBVAL S IBVAL="@"
 .S DA=IBC,DR=".08////"_IBVAL,DIE="^IBT(356.2," D ^DIE K DA,DIE,DR
 .S IBCT("IR")=$G(IBCT("IR"))+1
 .I IBVAL="@" S IBCT("IR",+$P(IBCD,"^",5),+IBCD)=""
 ;
 ; - bills
 S IBC=0 F  S IBC=$O(^DGCR(399,IBC)) Q:'IBC  S IBCNS=0 F  S IBCNS=$O(^DGCR(399,IBC,"AIC",IBCNS)) Q:'IBCNS  I $D(^TMP($J,"IBCNSCD",IBCNS)) S (IBREP,IBVAL)=$G(^(IBCNS)) D FIND
 ;
 ; - call AR to handle receivables
 S IBCTAR=0 D INS2^RCAMINS("^TMP($J,""IBCNSCD"")",.IBCTAR)
 ;
 D NOW^%DTC S IBEDT=%
 ;
 ; - mail results
 D MAIL^IBCNSCD2
 ;
 ; - finally, delete the companies
 S IBC=0 F  S IBC=$O(^TMP($J,"IBCNSCD",IBC)) Q:'IBC  S DA=IBC,DIK="^DIC(36,",DIDEL=36 D ^DIK
 ;
 ; - delete task number from #350.9
 S $P(^IBE(350.9,1,4),"^",8)=""
 ;
DDQ K IBC,IBCT,^TMP($J,"IBCNSCD")
 L -^IB("IBCNSCD")
 S ZTREQ="@"
 Q
 ;
 ;
FIND ; Find the carrier somewhere in the bill.
 ;   Required local variables are those described in CARR.
 S IB0=$G(^DGCR(399,IBC,0)),IBM=$G(^("M"))
 ;
 ; - look for the carrier
 I +IBM=IBCNS D CARR(1,"I1") ;            primary
 I $P(IBM,"^",2)=IBCNS D CARR(2,"I2") ;   secondary
 I $P(IBM,"^",3)=IBCNS D CARR(3,"I3") ;   tertiary
 ;
 ; - kill off the x-ref
 K ^DGCR(399,IBC,"AIC",IBCNS)
 Q
 ;
CARR(IBP,IBSUB) ; Update each carrier.
 ;  Input:   IBP  --  carrier [1:primary  2:secondary  3:tertiary]
 ;         IBSUB  --  updated subscript ["I1":prim  "I2":sec  "I3":tert]
 ;
 ;  The following local variables are also required to be defined:
 ;      IBCNS, IB0, IBM, IBC, IBREP, IBVAL
 ;
 S IBCNS1=+IBREP
 S $P(^DGCR(399,IBC,"M"),"^",IBP)=IBVAL
 I $G(^DGCR(399,IBC,IBSUB))]"" S $P(^(IBSUB),"^",1)=IBVAL
 I IBVAL="" D
 .S IBS=0
 .I $P(IB0,"^",2) S IBCNS1=+$G(^DPT($P(IB0,"^",2),.312,+$P(IBM,"^",IBP+11),0)) I IBCNS1 S IBS=1,$P(^DGCR(399,IBC,"M"),"^",IBP)=IBCNS1 S:$G(^(IBSUB))]"" $P(^(IBSUB),"^",1)=IBCNS1
 .I 'IBS S IBCT("BL",IBP,IBC)=""
 ;
 I IBCNS1 S ^DGCR(399,IBC,"AIC",IBCNS1)=""
 ;
 I IBCNS=+$G(^DGCR(399,IBC,"MP")) D
 .I $P(IB0,"^",2),+IBCNS K ^DGCR(399,"AE",$P(IB0,"^",2),IBCNS,IBC)
 .S $P(^DGCR(399,IBC,"MP"),U,1)=IBCNS1
 .I $P(IB0,"^",2),+IBCNS1 S ^DGCR(399,"AE",$P(IB0,"^",2),+IBCNS1,IBC)=""
 ;
 S IBCT("BL",IBP)=$G(IBCT("BL",IBP))+1
 Q
 ;
 ;
BILL(IBBILLN,IBCNS,IBREP) ; Callable Entry Point for Accounts Receivable
 ;  Input:     IBBILLN  --  Bill Number for bill to be repointed
 ;               IBCNS  --  Pointer to the insurance company in file #36
 ;                          that is being merged
 ;               IBREP  --  Pointer to the insurance company in file #36
 ;                          into which information is being merged
 ;
 N IBC,IBCT,IBVAL,IBCNS1,IB0,IBM
 I $G(IBBILLN)=""!'$G(IBCNS)!($G(IBREP)="") G BILLQ
 S IBC=$O(^DGCR(399,"B",IBBILLN,0)) I 'IBC G BILLQ
 S IBVAL=$S(IBREP:IBREP,1:"")
 D FIND
BILLQ Q
