IBARXMB ;LL/ELZ - PHARMCAY COPAY CAP BILLING FUNCTIONS ;26-APR-2001
 ;;2.0;INTEGRATED BILLING;**156**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BILL(IBX,IBB) ; receives information to bill for amounts not previously billed
 ; to create bills for them on the local system, DFN is assumed
 ; IBX = the parent transaction number to bill, IBB = the amount to bill
 ;
 N IBY,IBZ,IB350,IBUPDATE,IBER,Y,IBL
 ;
 ; find bill number
 S IBY=+$O(^IBAM(354.71,"B",IBX,0)) Q:'IBY
 ;
 ; find last 354.71 entry for IBX
 S IBL=$O(^IBAM(354.71,"AF",IBY,":"),-1) I IBL S IBY=+IBL
 ;
 ; get info
 S IBZ=^IBAM(354.71,IBY,0),IB350=$G(^IB(+$P(IBZ,"^",4),0))
 ;
 ; is this already totally billed?
 Q:$P($$NET^IBARXMC(IBY),"^",2)'>0
 ;
 ; cancel old 354.71 entry
 S IBUPDATE=1 S IBER=$$CANCEL^IBARXMN(DFN,IBY,.IBER)
 ;
 ; cancel old 350 entry
 D:IB350 CAN(DFN,+$P(IBZ,"^",4))
 ;
 ; create updated one
 D ADDUP(IBY,IBB)
 ;
 Q
SEND(IBX,IBB) ; receives information to bill remotely for amounts not already
 ; billed.  Makes a call to the remote system to tell them to bill
 ; IBX = the parent transaction number to bill, IBB = the amount to bill
 ; ia #3144
 N IBICN,Y,DA,HLDOM,HLECH,HLFS,HLINSTN,HLNEXT,HLNODE,HLPARAM,HLQ,HLQUIT,PHONE,RPCIEN,IO,IOBS,IOCPU,IOF,IOHG,IOM,ION,IOPAR,IOUPAR,IOS,IOSL,IOST,IOT,IOXY,POP,IBD
 D
 . S IBICN=$$ICN^IBARXMU(DFN) Q:'IBICN
 . D DIRECT^XWB2HL7(.IBD,+IBX,"IBARXM TRANS BILL","",IBICN,IBX,IBB)
 Q
CAN(DFN,IBX,IBCRES) ; cancels charge to be updated
 ; IBX = ien from 350, IBCRES = charge cancel reason (optional)
 ;
 N IBZ,IBSERV,IBDUZ,IBSITE,IBFAC,IBLAST,IBPARNT,IBTYP,IBSEQNO,IBIL,IBLASTZ,IBUNIT,IBCHRG,IBNOS,IBTOTL,IBN,IBND
 ;
 S (IBND,IBZ)=$G(^IB(IBX,0)) Q:'IBZ
 ;
 S IBSERV=$$SERVICE(IBZ)
 D ARPARM^IBAUTL
 S:'$D(IBCRES) IBCRES=16
 ;
 D LAST^IBARX1 I IBLAST'=IBPARNT,$D(^IB(IBLAST,0)),$P(^IBE(350.1,$P(^IB(IBLAST,0),"^",3),0),"^",5)=2 Q  ; already cancelled
 ;
 ; cancel a charge with a status of HOLD
 I $P(IBZ,"^",5)=8 N DIE,DA,DR S DIE="^IB(",DA=IBX,DR=".05///10;.1///"_IBCRES D ^DIE Q
 ;
 S IBDUZ=DUZ
 S IBPARNT=$P(IBZ,"^",9) Q:'$D(^IB(IBPARNT,0))
 S IBATYP=$P(^IBE(350.1,$P(IBZ,"^",3),0),"^",6) ;cancellation action type
 S IBSEQNO=$P($G(^IBE(350.1,+IBATYP,0)),"^",5) Q:'IBSEQNO
 S IBIL=$P(IBZ,"^",11) Q:'IBIL  ; no bill exists
 S IBLASTZ=$G(^IB(+IBLAST,0))
 S IBUNIT=$S($P(IBLASTZ,"^",6):$P(IBLASTZ,"^",6),1:$P(IBZ,"^",6))
 S IBCHRG=$S($P(IBLASTZ,"^",7):$P(IBLASTZ,"^",7),1:$P(IBZ,"^",7))
 S IBTOTL=IBCHRG,IBWHER=2
 D ADD^IBAUTL I +Y<1 Q
 ;
 S $P(^IB(IBN,1),"^",1)=IBDUZ,$P(^IB(IBN,0),"^",2,13)=DFN_"^"_IBATYP_"^"_$P(IBND,"^",4)_"^2^"_IBUNIT_"^"_IBCHRG_"^"_$P(IBND,"^",8)_"^"_IBPARNT_"^"_IBCRES_"^"_IBIL_"^^"_IBFAC
 K ^IB("AC",1,IBN)
 D INDEX^IBARX1
 S IBNOS=IBN
 D ^IBAFIL
 Q
 ;
ADDUP(IBX,IBB) ; add updated transaction, assumes DFN
 ; IBX = example ien from 354.71 to bill, IBB = amount to bill
 ;
 N IBZ,IBSEQNO,IBDESC,IBCHRG,IBNOCH,IBAM,IBATYP,IBPARNT,IBN,IBDUZ,IBFAC,IBNOS,Y
 ;
 S IBZ=^IBAM(354.71,IBX,0),IBDUZ=$P(IBZ,"^",14)
 D ARPARM^IBAUTL
 ;
 ; check exemption status
 I +$$RXEXMT^IBARXEU0(DFN,$P(IBZ,"^",3)) Q
 ;
 S IBATYP=$P(IBZ,"^",18),IBATYP=$P($G(^IBE(350.1,+IBATYP,0)),"^",7)
 S IBSEQNO=$P($G(^IBE(350.1,+IBATYP,0)),"^",5) Q:'IBSEQNO
 S IBDESC=$P(IBZ,"^",9)
 ;
 S IBCHRG=IBB+$P(IBZ,"^",11),IBNOCH=$P(IBZ,"^",8)-IBCHRG
 ;
 S IBAM=$$ADD^IBARXMN(DFN,"^^"_$P(IBZ,"^",3)_"^^P^"_$P(IBZ,"^",6,9)_"^"_$P(IBZ,"^")_"^"_IBCHRG_"^"_IBNOCH_"^"_(+$P($$SITE^IBARXMU,"^",3)),IBATYP) I IBAM<1 Q
 ;
 D ADD^IBAUTL
 S IBPARNT=$S($P(IBZ,"^",4):$P(IBZ,"^",4),1:IBN)
 S $P(^IB(IBN,1),"^",1)=IBDUZ,$P(^IB(IBN,0),"^",2,13)=DFN_"^"_IBATYP_"^"_$P(IBZ,"^",6)_"^2^"_$P(IBZ,"^",7)_"^"_IBCHRG_"^"_IBDESC_"^"_IBPARNT_"^^^^"_IBFAC,$P(^(0),"^",19)=IBAM
 K IBPARNT,^IB("AC",1,IBN)
 D INDEX^IBARX1
 S IBNOS=IBN_"^"_$G(IBNOS)
 D ^IBAFIL
 ;
 ; call pso to let them know I have billed
 ; check for pso part not installed
 ; ia #3462
 I $L($T(^PSOCPIB)) S Y(1)=$$NOW^XLFDT_"^"_DUZ_"^"_(+$P($P(IBZ,"^",6),":",2))_"^"_(+$P($P(IBZ,"^",6),":",3))_"^"_$S(IBNOCH:"P",1:"F")_"^"_IBN D ^PSOCPIB
 ;
 ;
 Q
 ;
SERVICE(IBZ) ; returns service pointer
 ; IBZ = zero node from 350
 Q $P($G(^IBE(350.1,+$P(IBZ,"^",3),0)),"^",4)
 ;
