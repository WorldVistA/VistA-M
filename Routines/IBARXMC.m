IBARXMC ;LL/ELZ-PHARMACY COPAY CAP FUNCTIONS ;26-APR-2001
 ;;2.0;INTEGRATED BILLING;**156,186,237**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
NEW(IBQ,IBC,IBD,IBB,IBN) ; used to compute new bills amount above cap
 ; DFN is assumed
 ; IBQ = quantity
 ; IBC = charge per item
 ; IBD = effective date
 ;   Return:
 ; IBB = Amount to bill
 ; IBN = Amount NOT to bill
 ;
 N IBA,IBA,IBZ,IBP,IBE,IBY,IBFD,IBTD
 ;
 S IBP=$$PRIORITY^IBARXMU(DFN)
 D CAP(IBD,IBP,.IBZ,.IBY,.IBFD,.IBTD)
 S IBA=$$BILLED(DFN,IBD,IBFD,IBTD),IBE=$P(IBA,"^",2)
 S IBB=IBQ*IBC
 S IBB=$S('IBZ:IBB,IBB+IBA>IBZ:$S(IBZ-IBA>0:IBZ-IBA,1:0),1:IBB) ; monthly
 I IBB,IBY S IBB=$S(IBB+IBE>IBY:$S(IBY-IBE>0:IBY-IBE,1:0),1:IBB) ; yearly
 S IBN=$S(IBQ*IBC=IBB:0,1:IBQ*IBC-IBB)
 ;
 Q
 ;
BILLED(DFN,IBD,IBFD,IBTD) ; returns about billed, format:  month^year
 ; IBD = transaction date, IBFD = from date, IBTD = to date
 N IBFY,IBX,IBM,IBY,IBZ
 F IBX="IBD","IBFD","IBTD" S @IBX=$E(@IBX,1,5)_"00"
 S IBX=+$O(^IBAM(354.7,DFN,1,"B",IBD,0))
 S IBM=+$P($G(^IBAM(354.7,DFN,1,IBX,0)),"^",2)
 S IBY=0,IBZ=IBFD-1 F  S IBZ=$O(^IBAM(354.7,DFN,1,"B",IBZ)) Q:IBZ<1!(IBZ>IBTD)  S IBX=$O(^IBAM(354.7,DFN,1,"B",IBZ,0)) I IBX S IBY=IBY+$P($G(^IBAM(354.7,DFN,1,IBX,0)),"^",2)
 Q IBM_"^"_IBY
 ;
CAP(IBD,IBP,IBM,IBY,IBF,IBT) ; returns the cap amount and dates
 ; IBD = date of transaction
 ; IBP = priority level of patient
 ;    return (by reference):
 ; IBM = monthly cap amount
 ; IBY = yearly cap amount
 ; IBF = from date for yearly cap determination
 ; IBT = to date for yearly cap determination
 N IBX,IBDT
 I $D(^IBAM(354.75,"AC",IBP,IBD)) S IBX=+$O(^(IBD,0)) G CAPC
 S IBDT=+$O(^IBAM(354.75,"AC",IBP,IBD),-1),IBX=+$O(^(IBDT,0))
CAPC ;
 S IBX=$G(^IBAM(354.75,IBX,0))
 I 'IBX!($P(IBX,"^",5)&(IBD>$P(IBX,"^",5))) S (IBM,IBY,IBF,IBT)=0 Q
 S IBM=$P(IBX,"^",3),IBY=$P(IBX,"^",4)
 S IBDT=$P($$FYCY^IBCU8(IBD),"^",$S($P(IBX,"^",6)="C":1,1:3),$S($P(IBX,"^",6)="C":2,1:4))
 S IBF=$S($P(IBDT,"^")>IBX:$P(IBDT,"^"),1:+IBX)
 S IBT=$S('$P(IBX,"^",5):$P(IBDT,"^",2),$P(IBDT,"^",2)<$P(IBX,"^",5):$P(IBDT,"^",2),1:$P(IBX,"^",5))
 ;
 Q
 ;
FLAG(DFN,IBD) ; flag account if at or above cap
 ; IBD = date of transaction (mo/year fm format)
 ; flag in account is set to:  2 = cap exceeded, some copays not billed
 ;                             1 = cap reached
 ;                             0 = below cap
 ;
 N IBC,IBB,IBZ,IBF,IBX,DIE,DR,DA,X,Y,IBFD,IBTD,IBY
 S IBX=+$O(^IBAM(354.7,DFN,1,"B",IBD,0)) Q:'IBX
 S IBZ=$G(^IBAM(354.7,DFN,1,IBX,0))
 D CAP(IBD+1,+$$PRIORITY^IBARXMU(DFN),.IBC,.IBY,.IBFD,.IBTD)
 S IBB=$$BILLED(DFN,IBD,IBFD,IBTD)
 S IBF=$S('IBC&('IBY):0,$P(IBZ,"^",4):2,IBC=+IBB:1,IBY=$P(IBB,"^",2):1,1:0)
 I IBF'=$P(IBZ,"^",3) S DIE="^IBAM(354.7,"_DFN_",1,",DA=IBX,DR=".03///^S X=IBF",DA(1)=DFN L +^IBAM(354.7,DFN):10 I $T D ^DIE L -^IBAM(354.7,DFN)
 Q
 ;
PARENT(X) ; returns the parent entry in 354.71 for a transaction
 Q +$P($G(^IBAM(354.71,X,0)),"^",10)
 ;
NET(X) ; returns net amount billed for a parent and its children
 ; X = ien from 354.71 (parent or child) output: billed ^ un-billed
 ;
 N Y,Z,B,N,P S P=$$PARENT(X),(Y,B,N)=0 F  S Y=$O(^IBAM(354.71,"AF",P,Y)) Q:Y<1  S Z=^IBAM(354.71,Y,0),B=B+$P(Z,"^",11),N=N+$P(Z,"^",12)
 Q B_"^"_N
 ;
CANCEL(DFN,IBDT) ; receives notification of a cancellation and determines
 ; if more need to be billed.  IBDT should be in fm format date to check
 ;
 N IBT,IBTFL,IBX,IBD,IBFD,IBTD,IBDTQ,IBBIL,IBS1,IBS2
 ;
 ; first determine if cap reached or quit
 ;Q:'$P($G(^IBAM(354.7,DFN,1,+$O(^IBAM(354.7,DFN,1,"B",IBDT,0)),0)),"^",3)
 ;
C1 ; get starting values
 S IBS=+$$SITE^IBARXMU
 S IBP=+$$PRIORITY^IBARXMU(DFN)
 D CAP(IBDT+1,IBP,.IBZ,.IBY,.IBFD,.IBTD)
 I ('IBY&('IBZ))!('IBFD)!('IBTD) Q
 S IBA=$$BILLED(DFN,IBDT+1,IBFD,IBTD),IBE=$P(IBA,"^",2)
 ;
 ; query (if any) other facilities to see what is there.
C2 S IBT=$$TFL^IBARXMU(DFN,.IBTFL)
 I IBT W:'$D(ZTQUEUED) !,"This patient is being seen at other VA treating facilities. I need to make",!,"sure there are no Rx fills that have not been billed elsewhere." S IBX=0 F  S IBX=$O(IBTFL(IBX)) Q:IBX<1  D
 . I '$D(ZTQUEUED) U IO W !,"Now sending queries to ",$P(IBTFL(IBX),"^",2)," ..."
 . S IBDTQ=IBFD F  D  S IBDTQ=$$NEXTMO(IBDTQ) Q:IBDTQ>IBTD
 .. D UQUERY^IBARXMU(DFN,$E(IBDTQ,1,5)_"00",+IBTFL(IBX),.IBD)
 .. I $P(IBD(0),"^")=-1!(-1=+IBD) K IBD Q
 .. S X=1 F  S X=$O(IBD(X)) Q:X<1  S IBD=$$ADD^IBARXMN(DFN,IBD(X))
 .. K IBD
 I '$D(ZTQUEUED) U IO
 ;
C3 K ^TMP("IBD",$J)
 ; now lets see if there are some unbilled that can be billed.
 S IBDTQ=IBFD F  D  S IBDTQ=$$NEXTMO(IBDTQ) Q:IBDTQ>IBTD
 . S IBX=0 F  S IBX=$O(^IBAM(354.71,"AD",DFN,$E(IBDTQ,1,5)_"00",IBX)) Q:IBX<1  D
 .. N IBZ S IBZ=^IBAM(354.71,IBX,0)
 .. ;
 .. ; check, am I the parent and still have some unbilled
 .. I $P(IBZ,"^",10)'=IBX!('$P($$NET(IBX),"^",2)) Q
 .. ;
 .. ; ^TMP("IBD",$J format(date of transaction,date/time entry added,ien)
 .. S ^TMP("IBD",$J,$P(IBZ,"^",3),$P(IBZ,"^",15),IBX)=IBZ
 ;
 I '$D(^TMP("IBD",$J)) W:'$D(ZTQUEUED) !,"No un-billed transactions exist" Q
 ;
 ; how much more can we bill
C4 S IBB=$S('IBZ&('IBY):9999999,IBZ&((IBZ-IBA)<(IBY-IBE)):IBZ-IBA,1:IBY-IBE)
 ;
 ; we now have to bill some of the unbilled ones
 S IBS1=0 F  S IBS1=$O(^TMP("IBD",$J,IBS1)) Q:IBS1<1  S IBS2=0 F  S IBS2=$O(^TMP("IBD",$J,IBS1,IBS2)) Q:IBS2<1  S IBX=0 F  S IBX=$O(^TMP("IBD",$J,IBS1,IBS2,IBX)) Q:IBX<1  D
 . S IBZ=^TMP("IBD",$J,IBS1,IBS2,IBX)
 . ;
C5 . ; determine how much to bill (if any)
 . S IBA=$$NET(IBX)
 . S IBBIL=$S(IBB>$P(IBA,"^",2):$P(IBA,"^",2),1:IBB)
 . I 'IBBIL S IBS1=9999999999 Q
 . S IBB=IBB-IBBIL
 . ;
 . D @($S(IBS=+IBZ:"BILL",1:"SEND")_"^IBARXMB($P(IBZ,""^""),IBBIL)")
 K ^TMP("IBD",$J)
 Q
 ;
NEXTMO(DATE) ; returns first date of next month
 N X S X="",DATE=$G(DATE)\1 I DATE'?7N G NEXTMOQ
 S X=$S($E(DATE,4,5)<12:$E(DATE,1,5)+1_"01",1:$E(DATE,1,3)+1_"0101")
NEXTMOQ Q X
 ;
QCAN(DFN,IBCAP,IBSAVXMC) ; queue off job to look for back billing in the background
 N ZTRTN,ZTDTH,ZTIO,ZTDESC,ZTSK,ZTSAVE,Y,IBTAG
 ;
 S ZTRTN="DQCAN^IBARXMC",ZTDESC="IB Back Billing of Rx Copay Charges"
 S ZTDTH=$$FMTH^XLFDT($$FMADD^XLFDT($$NOW^XLFDT,"","",10))
 S (ZTSAVE("DFN"),ZTSAVE("IBCAP("),ZTSAVE("IBSAVXMC("),ZTIO)="" D ^%ZTLOAD
 ;
 I ZTSK<1 S IBTAG=3,Y="^^Error when trying to queue back billing job." D BULL^IBAERR
 ;
 Q
 ;
DQCAN ; entry point for queued back billing job
 N IBD,IBL,IBPAT,IBREF,IBSSN,IBTAG,Y
 ;
 ; try to get a lock
 S IBL=0 F X=1:1:10 L +^IBAM(354.7,"APAT",DFN):10 H:'$T 600 I $T S IBL=1 Q
 I 'IBL D  Q
 .S IBTAG=3
 .S IBPAT=$P($G(^DPT(DFN,0)),"^",1) I IBPAT="" S IBPAT=DFN
 .S IBSSN=$P($G(^DPT(DFN,0)),"^",9) I IBSSN="" S IBSSN="????"
 .S (X,IBREF)=""
 .F  S X=$O(IBSAVXMC(X)) Q:X=""  D
 ..I IBREF'="" S IBREF=IBREF_", "_$P(IBSAVXMC(X),"^",1)
 ..I IBREF="" S IBREF=$P(IBSAVXMC(X),"^",1)
 .S Y="^^Unable to lock the IB PATIENT COPAY ACCOUNT (#354.7) file for back billing job related to "_IBPAT_" ("_IBSSN_") and IB reference number(s): "_IBREF_"."
 .D ^IBAERR Q
 ;
 ; do query/back billing
 S IBD=0 F  S IBD=$O(IBCAP(IBD)) Q:IBD<1  D CANCEL(DFN,IBD)
 ;
 ; remove lock
 L -^IBAM(354.7,"APAT",DFN)
 ;
 Q
