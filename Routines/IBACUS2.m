IBACUS2 ;ALB/CPM - TRICARE FISCAL INTERMEDIARY RX CLAIMS ;02-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,91,51,240,341,347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
BILL(IBKEY,IBCHTRN) ; Create the TRICARE claim for the Fiscal Intermediary.
 ;  Input:    IBKEY  --  1 ; 2, where
 ;                         1 = Pointer to the prescription in file #52
 ;                         2 = Pointer to the refill in file #52.1, or
 ;                             0 for the original fill
 ;          IBCHTRN  --  Pointer to the transaction entry in file #351.5
 ;
 N IBQUERY
 S IBY=1 K IBDRX
 I '$G(IBKEY) G BILLQ
 I $$FILE^IBRXUTL(+IBKEY,.01)="" G BILLQ
 S IBAMT=$P($G(^IBA(351.5,+IBCHTRN,2)),"^",5) ;  FI portion of charge
 I 'IBAMT G BILLQ
 ;
 ; - derive minimal variables
 I '$$CHECK^IBECEAU(0) S IBY="-1^IB009" G BILLQ
 S IBSERV=$P($G(^IBE(350.1,1,0)),"^",4)
 I '$$SERV^IBARX1(IBSERV) S IBY="-1^IB003" G BILLQ
 ;
 ; - establish a stub claim/receivable
 D SET^IBR I IBY<0 G BILLQ
 ;
 ; - set up the following variables for claim establishment:
 ;      .01  BILL #
 ;      .17  ORIG CLAIM
 ;      .2   AUTO?
 ;      .02  DFN
 ;      .06  TIMEFRAME
 ;      .07  RATE TYPE
 ;      .18  SC AT TIME?
 ;      .04  LOCATION (WILL NEED DIVISION THAT DISPENSED)
 ;      .05  BILL CLASSIF  (3)
 ;      .03  EVT DATE (FILL DATE)
 ;      151  BILL FROM
 ;      152  BILL TO
 K IB
 S (IB(.02),DFN,IBDFN)=$$FILE^IBRXUTL(+IBKEY,2)
 I 'DFN S IBY="-1^IB002" G BILLQ
 S IB(.07)=$O(^DGCR(399.3,"B","TRICARE",0))
 I 'IB(.07) S IBY="-1^IB059" G BILLQ
 I $$TRANS^PSOCPTRI(+IBKEY,+$P(IBKEY,";",2),.IBDRX)<0 S IBY="-1^IB010" G BILLQ
 ;
 S IBIFN=PRCASV("ARREC")
 S IB(.01)=$P(PRCASV("ARBIL"),"-",2)
 S IB(.17)=""
 S IB(.2)=0
 S IB(.06)=1
 S IB(.18)=$$SC^IBCU3(DFN)
 S IB(.04)=1 ;  how can I get Division?  RON...
 S IB(.05)=3
 S (IB(.03),IB(151),IB(152))=IBDRX("FDT")
 ;
 ; - set 362.4 node to rx#^p50^days sup^fill date^qty^ndc
 S IB(362.4,+IBKEY,1)=IBDRX("RX#")_"^"_$$FILE^IBRXUTL(+IBKEY,6)_"^"_IBDRX("SUP")_"^"_IBDRX("FDT")_"^"_IBDRX("QTY")_"^"_IBDRX("NDC")
 ;
 ; - call the autobiller module to create the claim with a default
 ;   diagnosis and procedure for prescriptions
 D EN^IBCD3(.IBQUERY)
 D CLOSE^IBSDU(.IBQUERY)
 ;
 ; - add the payor (fiscal intermediary) to the claim
 S IBCDFN=$$CUS^IBACUS(DFN)
 I 'IBCDFN S IBY="-1^IB054" G BILLQ
 S IBINS=+$G(^DPT(DFN,.312,IBCDFN,0))
 S DIE="^DGCR(399,",DA=IBIFN,DR="112////"_IBCDFN
 D ^DIE K DA,DR,DIE,DGRVRCAL
 ;
 ; - add charge to the claim
 S IBRVCD=$P($G(^DIC(36,IBINS,0)),"^",15) ;                                      rx refill rev code
 I IBRVCD="" S IBRVCD=$P($G(^IBE(363.1,+$P($G(^IBE(350.9,1,9)),U,12),0)),U,5) ;  CS def rev code
 I IBRVCD="" S X=250 ;                                                           gen'l rx rev code
 ;
 S IBBS=$P($G(^IBE(363.1,+$P($G(^IBE(350.9,1,9)),U,12),0)),U,6) ;                CS def bedsection
 S IBUNITS=1 ;                                    one unit
 S IBCPT=$P($G(^IBE(350.9,1,1)),"^",30) ;         def rx refill cpt
 S IBDIV="" ;                                     division
 S IBAA=0 ;                                       not auto calc charges
 S IBTYPE=3 ;                                     rx type
 S IBITEM="" ;                                    charge item link
 ;
 ;
 S X=$$ADDRC^IBCRBF(IBIFN,IBRVCD,IBBS,IBAMT,IBUNITS,IBCPT,IBDIV,IBAA,IBTYPE,IBITEM)
 I X<0 S IBY="-1^^Unable to add Revenue Code charge to claim." G BILLQ
 ;
 ; - update the authorize/print fields
 S DIE="^DGCR(399,",DA=IBIFN,DR="9////1" D ^DIE K DA,DR,DIE
 S DIE="^DGCR(399,",DA=IBIFN,DR="12////"_DT D ^DIE K DA,DR,DIE
 ;
 ; - pass the claim to AR
 D GVAR^IBCBB,ARRAY^IBCBB1,^PRCASVC6,REL^PRCASVC:PRCASV("OKAY")
 I 'PRCASV("OKAY") S IBY="-1^^Unable to establish receivable in AR." G BILLQ
 ;
 ; - update the rx transaction file (#351.5)
 S DA=IBCHTRN,DIE="^IBA(351.5,",DR=".09////"_IBIFN D ^DIE K DA,DIE,DR
 ;
 ; - update the AR status to Active
 S PRCASV("STATUS")=16
 D STATUS^PRCASVC1
 ;
BILLQ I IBY<0 D ERRMSG^IBACVA2(1,2)
 K IBRVCD,IBBS,IBUNITS,IBCPT,IBDIV,IBAA,IBTYPE,IBITEM,IBAMT
 K IBSERV,IBFAC,IBSITE,IBDRX,IB,IBCDFN,IBINS,IBIDS,IBIFN,IBDFN
 K PRCASV,PRCAERR
 Q
 ;
 ;
CANC(IBCHTRN) ; Cancel the claim to the Fiscal Intermediary.
 ;  Input:  IBCHTRN  --  Pointer to the transaction entry in file #351.5
 ;
 S IBIFN=+$P($G(^IBA(351.5,IBCHTRN,0)),"^",9)
 I 'IBIFN G CANCQ
 F I=0,"S" S IB(I)=$G(^DGCR(399,IBIFN,I))
 I IB(0)="" G CANCQ
 I +$P(IB("S"),U,16),$P(IB("S"),U,17)]"" G CANCQ
 ;
 S DA=IBIFN,DR="16////1;19////PRESCRIPTION REVERSED",DIE="^DGCR(399,"
 D ^DIE K DA,DIE,DR
 ;
 ; - decrease out the receivable in AR
 S DFN=+$P(IB(0),"^",2)
 S IB("U1")=$G(^DGCR(399,IBIFN,"U1"))
 S IBIL=$P($G(^PRCA(430,IBIFN,0)),"^")
 S IBCHG=$S(IB("U1")']"":0,$P(IB("U1"),"^",1)]"":$P(IB("U1"),"^",1),1:0)
 S IBCRES="TRICARE PRESCRIPTION REVERSED"
 ;
 S X="21^"_IBCHG_"^"_IBIL_"^"_$S('DUZ:.5,1:DUZ)_"^"_DT_"^"_IBCRES ; *341
 D ^PRCASER1
 I Y<0 S IBY=Y D BULL
 ;
CANCQ K DFN,IBIFN,IB,IBIL,IBCHG,IBCRES,IBY,X,Y
 Q
 ;
 ;
BULL ; Generate a bulletin if there is an error in canceling the claim.
 K IBT S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - ERROR ENCOUNTERED"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 S XMY(DUZ)=""
 S IBGRP=$P($G(^XMB(3.8,+$P($G(^IBE(350.9,1,1)),"^",7),0)),"^")
 I IBGRP]"" S XMY("G."_IBGRP_"@"_^XMB("NETNAME"))=""
 ;
 S IBT(1)="An error occurred while cancelling the Pharmacy claim to the TRICARE"
 S IBT(2)="fiscal intermediary for the following patient:"
 S IBT(3)=" " S IBC=3
 S IBDUZ=DUZ D PAT^IBAERR1
 S IBC=IBC+1,IBT(IBC)="   Bill #: "_IBIL
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="The following error was encountered:"
 S IBC=IBC+1,IBT(IBC)=" "
 D ERR^IBAERR1
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="Please review the circumstances surrounding this error and decrease"
 S IBC=IBC+1,IBT(IBC)="out this receivable in Accounts Receivable if necessary."
 ;
 D ^XMD
 K IBC,IBDUZ,IBT,IBPT,IBGRP,XMDUZ,XMTEXT,XMSUB,XMY
 Q
