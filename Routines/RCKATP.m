RCKATP ;ALB/CPM - ADJUST ACCOUNTS FOR KATRINA VETS ; 28-FEB-06
 ;;4.5;Accounts Receivable;**241,246**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
POST ; Queue PRCA*4.5*241 post-init job.
 ;
 D BMES^XPDUTL(">>> Queuing the post-initialization to run now...")
 S ZTDTH=$H,ZTRTN="EN^RCKATP",ZTIO=""
 S ZTDESC="RC - PATCH PRCA*4.5*241 POST INITIALIZATION"
 D ^%ZTLOAD
 I $D(ZTSK) D MES^XPDUTL(" >> Queued as task #"_ZTSK_".")
 I '$D(ZTSK) D MES^XPDUTL(" >> Unable to queue task - contact EVS.")
 K ZTDTH,ZTRTN,ZTDESC,ZTSK,ZTIO
 Q
 ;
 ;
EN ; Queued entry point to run the PRCA*4.5*241 post init.
 ;
 D EX ;                    exempt interest - return RCTOTAL
 ;
 S RCRES=$$CAN^IBAKAT() ;  cancel copay charges
 ;
 D BULL ;                  generate bulletin with results
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K RCTOTAL,RCRES
 Q
 ;
 ;
EX ; Entry point to exempt interest/admin charges
 ;
 ; - get all 'Katrina' vets based on interest/admin charges 
 K ^TMP("RCKATP",$J)
 S RCCOM(1)="INTEREST ADJUSTMENT FOR HURRICANE KATRINA VETERAN"
 S RCD=3050828.9
 F  S RCD=$O(^PRCA(433,"AT",13,RCD)) Q:'RCD!($P(RCD,".")>3060430)  D
 .S RCT=0 F  S RCT=$O(^PRCA(433,"AT",13,RCD,RCT)) Q:'RCT  D
 ..S RCB=+$P($G(^PRCA(433,RCT,0)),"^",2) Q:'RCB
 ..I '$P($G(^PRCA(430,RCB,0)),"^",12) Q
 ..S RCDPT=+$P($G(^PRCA(430,RCB,0)),"^",9)
 ..S RCDEB=$G(^RCD(340,RCDPT,0))
 ..Q:$P(RCDEB,"^")'["DPT"  Q:'RCDEB
 ..;Q:$$EMERES^PRCAUTL(+RCDEB)=""
 ..Q:$$EMGRES^DGUTL(+RCDEB)=""
 ..Q:$P(RCDEB,"^",8)  ;    vet has been already been processed
 ..;
 ..; - store the vet and bill
 ..S ^TMP("RCKATP",$J,RCDPT,RCB)=""
 ;
 ; - look for extra interest exemptions to create
 S RCTOTAL="0^0"
 S RCDEB=0 F  S RCDEB=$O(^TMP("RCKATP",$J,RCDEB)) Q:'RCDEB  D
 .;
 .; - initialize bucket and new patient flag
 .S (RCBUCK,RCNEWP)=0
 .S RCB=0 F  S RCB=$O(^TMP("RCKATP",$J,RCDEB,RCB)) Q:'RCB  D
 ..;
 ..; - review transactions to find interest added/exempted
 ..S RCCB=$$GETTRANS^RCDPBTLM(RCB),RCH=0,RCHOLD=""
 ..S RCDT=3050828.9 F  S RCDT=$O(RCLIST(RCDT)) Q:'RCDT  D
 ...S RCT=0 F  S RCT=$O(RCLIST(RCDT,RCT)) Q:'RCT  D
 ....S RCV=RCLIST(RCDT,RCT)
 ....;
 ....; - if transaction is an interest charge, save off amount
 ....I RCV["INTEREST/ADM. CHARGE",RCDT<3060501 S RCH=1 D  Q
 .....S $P(RCHOLD,"^")=$P(RCHOLD,"^")+$P(RCV,"^",3)
 .....S $P(RCHOLD,"^",2)=$P(RCHOLD,"^",2)+$P(RCV,"^",4)
 ....;
 ....; - if transaction is an interest exemption, save off (+) amount
 ....I RCV["EXEMPT INT/ADM. COST",RCH D  Q
 .....S $P(RCHOLD,"^",3)=$P(RCHOLD,"^",3)-$P(RCV,"^",3)
 .....S $P(RCHOLD,"^",4)=$P(RCHOLD,"^",4)-$P(RCV,"^",4)
 ..;
 ..; - get total amounts of interest added and exempted
 ..S RCINT=$P(RCHOLD,"^")+$P(RCHOLD,"^",2)
 ..S RCEXEM=$P(RCHOLD,"^",3)+$P(RCHOLD,"^",4)
 ..;
 ..; - quit if interest added less than or equal to exemptions
 ..S RCAPPLY=RCINT-RCEXEM
 ..Q:RCAPPLY'>0
 ..;
 ..; - get bill's interest balance
 ..S RCNEWP=1
 ..S X=$G(^PRCA(430,RCB,7)),RCINTB=$P(X,"^",2)+$P(X,"^",3)
 ..;
 ..; - if no balance, put in bucket and quit
 ..I 'RCINTB S RCBUCK=RCBUCK+RCAPPLY Q
 ..;
 ..; - adjust bucket and amount to apply
 ..S RCAMT=$S(RCAPPLY'<RCINTB:RCINTB,1:RCAPPLY)
 ..S RCBUCK=$S(RCAPPLY>RCINTB:RCBUCK+(RCAPPLY-RCINTB),1:RCBUCK)
 ..;
 ..; - will apply RCAMT - spread over admin then interest.
 ..S RCAPA=$S(RCAMT'<$P(X,"^",3):$P(X,"^",3),1:RCAMT)
 ..S RCAPI=RCAMT-RCAPA
 ..S RC=$$EXEMPT^RCBEUTR2(RCB,RCAPI_"^"_RCAPA,.RCCOM,0)
 ..;
 ..; - update total amount exempted
 ..S $P(RCTOTAL,"^",2)=$P(RCTOTAL,"^",2)+RCAMT
 .;
 .;
 .; - set debtor as having been processed
 .S $P(^RCD(340,RCDEB,0),"^",8)=1
 .;
 .; - if an amount is left in the bucket, process it,
 .;   update total exempted, and the number of vets exempted
 .I RCBUCK D
 ..D EN^RCKATPD($P($G(^RCD(340,RCDEB,0)),"^"),RCBUCK,RCCOM(1))
 ..S $P(RCTOTAL,"^",2)=$P(RCTOTAL,"^",2)+RCBUCK
 .I RCNEWP S $P(RCTOTAL,"^")=$P(RCTOTAL,"^")+1
 ;
 ;
 K ^TMP("RCKATP",$J)
 K RCD,RCT,RCB,RCDPT,RCDEB,RCBUCK,RCNEWP,RC,RCCB,RCH,RCHOLD,RCDT
 K RCLIST,RCV,RCINT,RCINTB,RCEXEM,RCAPPLY,RCAMT,RCAPA,RCAPI,RCCOM,X
 Q
 ;
 ;
CHK(DFN) ; Check to see if vet should have charges cancelled
 ;  Input:  DFN  --  Pointer to patient in file 2
 ; Output:    0  --  No, don't cancel charges
 ;            1  --  Yes, cancel charges
 N RCDEB,RCH
 S RCH=0
 ;I $$EMERES^PRCAUTL(DFN)="" G CHKQ
 I $$EMGRES^DGUTL(DFN)="" G CHKQ
 S RCDEB=$O(^RCD(340,"B",DFN_";DPT(",0))
 ;
 ; - if a Katrina vet is not in file #340, must look for held charges
 I 'RCDEB S RCH=1 G CHKQ
 ;
 ; - make sure charges have not yet been canceled
 I '$P($G(^RCD(340,RCDEB,0)),"^",9) S RCH=1
CHKQ Q RCH
 ;
 ;
TPP(RCTI,RCH) ; Identify decreases that are credits for third party payments
 ;  Input:  RCTI  --  Pointer to AR Transaction in file 433
 ;           RCH  --  Array of 'counted' transactions passed by reference
 ; Output:  RCRES --  1^2, where
 ;                      1 = total amount of credit adjustments
 ;                      2 = pointer to the affected bill in file #430
 ;
 N RCRES,RCB,RCAMT,RCT,RCTD,RCQ,RCI,RCS
 S RCRES="",RCAMT=0
 I '$G(RCTI) G TPPQ
 S RCB=+$P($G(^PRCA(433,RCTI,0)),"^",2) I 'RCB G TPPQ
 S RCAMT=0
 S RCT=RCTI F  S RCT=$O(^PRCA(433,"C",RCB,RCT)) Q:'RCT  D
 .Q:$D(RCH(RCB,RCT))  ;    transaction has been counted
 .S RCTD=$G(^PRCA(433,RCT,1))
 .Q:$P(RCTD,"^",2)'=35  ;  not a decrease
 .;
 .; - check for a potential 'Katrina decrease'
 .S RCQ=0,RCS="HURRICANE KATRINA VETERAN" D  Q:RCQ
 ..S RCI=0 F  S RCI=$O(^PRCA(433,RCT,7,RCI)) Q:'RCI  D  Q:RCQ
 ...I $G(^PRCA(433,RCT,7,RCI,0))[RCS S RCQ=1
 .;
 .; - increment the credit amount
 .S RCAMT=RCAMT+$P(RCTD,"^",5),RCH(RCB,RCT)=""
 ;
 S RCRES=RCAMT_"^"_RCB
TPPQ Q RCRES
 ;
 ;
DEC(RCBILL,RCAMT) ; Decrease a bill
 ;  Input:  RCBILL  --  Bill Number of a bill in file 430
 ;           RCAMT  --  Amount to decrease bill
 ; Output:  RCBUCK  --  Amount not decreased, to go to bucket
 ;
 N RCBUCK,RCMSG,RCT
 S RCBUCK=RCAMT
 S RCB=$O(^PRCA(430,"B",RCBILL,0))
 I RCB D
 .S RCMSG="CANCEL COPAYMENTS FOR HURRICANE KATRINA VETERAN"
 .D DEC^PRCASER1(RCB,.RCBUCK,DUZ,RCMSG,"",.RCT)
DECQ Q RCBUCK
 ;
 ;
FLAG(DFN) ; Flag veteran as having had copay charges cancelled
 ;  Input:  DFN  --  Pointer to patient in file 2
 ;
 N RCDEB
 S RCDEB=$O(^RCD(340,"B",DFN_";DPT(",0))
 I 'RCDEB D
 .S DIC="^RCD(340,",DIC(0)="QL",X=DFN_";DPT(",DLAYGO=340
 .K DD,DO D FILE^DICN K DIC,DLAYGO,DO,DD S RCDEB=+Y
 I RCDEB>0 S $P(^RCD(340,RCDEB,0),"^",9)=1
 Q
 ;
 ;
ADJ(DFN,RCAMT) ; Make final credit adjustments to the vet's account
 ;  Input:  DFN  --  Pointer to patient in file 2
 ;        RCAMT  --  Amount to decrease from account
 ;
 N RCDEBN,RCMSG
 S RCDEBN=DFN_";DPT("
 S RCMSG="CANCEL COPAYMENTS FOR HURRICANE KATRINA VETERAN"
 D EN^RCKATPD(RCDEBN,RCAMT,RCMSG)
 Q
 ;
 ;
BULL ; Send job completion bulletin
 N XMSUB,XMTEXT,XMY,XMDUZ,RCT,RCN
 S RCT(1)="The patch PRCA*4.5*241 post initialization has completed."
 S RCT(2)=" "
 S RCT(3)="Number of Veterans with Interest Exempted:  "_+RCTOTAL
 S RCT(4)="        Total Amount of Interest Exempted: $"_$J($P(RCTOTAL,"^",2),0,2)
 S RCT(5)=" "
 I RCRES="" S RCT(6)="*** Note: Copay Charges were not cancelled - contact EVS ***"
 I RCRES'="" D
 .S RCT(6)="Number of Veterans with Charges Cancelled:  "_+RCRES
 .S RCT(7)="        Total Amount of Charges Cancelled: $"_$J($P(RCRES,"^",2),0,2)
 .S RCT(8)="   Total Amount of Held Charges Cancelled: $"_$J($P(RCRES,"^",3),0,2)
 ;
 S XMSUB="Job Completion - PRCA*4.5*241 Post Initialization"
 S XMTEXT="RCT("
 S XMY("G.PRCA ADJUSTMENT TRANS")="",XMY(DUZ)=""
 S XMDUZ="ACCOUNTS RECEIVABLE"
 D ^XMD
 Q
