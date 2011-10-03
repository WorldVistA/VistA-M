IBCSC5C ;ALB/ARH - ADD/EDIT PRESCRIPTION FILLS (CONTINUED) ;3/4/94
 ;;2.0;INTEGRATED BILLING;**27,52,130,51,160,260,309,315,339,347,363,381,405**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
DEFAULT(IFN,IBRX) ; add default DX and CPT to a prescription bill
 ; if one is not in PSO.  If there is, use it instead.
 ; IFN = ien of bill entry
 N IBX,IBPAR1,IBDX,IBCPT,IBDT,IBBIL,IBDXIFN,IBCPTIFN,IBY,IB52,IBC,PDFN,LIST,NODE
 S IBDXIFN=0
 S IBPAR1=$G(^IBE(350.9,1,1)),IBDX=$P(IBPAR1,U,29),IBCPT=$P(IBPAR1,U,30)
 S IBBIL=$G(^DGCR(399,+$G(IFN),0)) Q:IBBIL=""
 S IBX=$S($G(IBRX):$P($G(^DGCR(399,IFN,"RC",+IBRX,0)),U,11),1:$O(^IBA(362.4,"C",IFN,0))) Q:'IBX
 S IB52=+$P($G(^IBA(362.4,IBX,0)),"^",5),IBY=0 Q:IB52=0
 S PDFN=$$FILE^IBRXUTL(IB52,2)
 S LIST="IBCSC5CARR"
 S NODE="ICD"
 D RX^PSO52API(PDFN,LIST,IB52,,NODE,,)
 I ^TMP($J,LIST,PDFN,IB52,"ICD",0)>0 D
 .S IBY=0 F  S IBY=$O(^TMP($J,LIST,PDFN,IB52,"ICD",IBY)) Q:IBY'>0  D
 ..S IBDX(IBY)=$$ICD^IBRXUTL1(PDFN,IB52,IBY,LIST)
 ..I 'IBDX(IBY) K IBDX(IBY)
 K ^TMP($J,LIST)
 I 'IBDX,'IBCPT,$D(IBDX)<10 Q
 S IBDT=$P($G(^IBA(362.4,+IBX,0)),U,3) Q:'IBDT
 ; add dx associated with rx if they are there.
 I $D(IBDX)>9 S (IBC,IBDX,IBY)=0 F  S IBY=$O(IBDX(IBY)) Q:'IBY  D
 . I $D(^IBA(362.3,"AIFN"_IFN,+IBDX(IBY))) Q
 . S IBC=IBC+1
 . S DIC="^IBA(362.3,",DIC(0)="L",DIC("DR")=".02////"_IFN_";.03////"_IBC,X=+IBDX(IBY),DLAYGO=362.3
 . K DD,DO D FILE^DICN K DIC,DA,DR,DD,DO,DLAYGO
 . S IBDXIFN(IBC)=+Y
 ; add default dx if none found on actual rx.
 I +IBDX,'$D(^IBA(362.3,"AIFN"_IFN,+IBDX)) S DIC="^IBA(362.3,",DIC(0)="L",DIC("DR")=".02////"_IFN,X=IBDX,DLAYGO=362.3 K DD,DO D FILE^DICN K DIC,DA,DR,DD,DO,DLAYGO S IBDXIFN=+Y
 I +IBCPT D  ;Check if the procedure is already present for the Rx
 . N Z,Z0,DUP
 . S (DUP,Z)=0 F  S Z=$O(^DGCR(399,IFN,"RC",Z)) Q:'Z  S Z0=$G(^(Z,0)) D  Q:DUP
 .. I $P(Z0,U,10)=3,$P(Z0,U,15),$P(Z0,U,11)=IBX S DUP=1
 . Q:DUP
 . I $P($G(^DGCR(399,IFN,0)),U,9)="" S DIE="^DGCR(399,",DA=IFN,DR=".09////5" D ^DIE K DIE,DIC,DA,DR
 . I '$D(^DGCR(399,IFN,"CP",0)) S DIC("P")=$$GETSPEC^IBEFUNC(399,304)
 . S DLAYGO=399,DIC("DR")="1////"_IBDT D
 . . I +IBDXIFN>0 S DIC("DR")=DIC("DR")_";10////"_IBDXIFN Q
 . . I $D(IBDXIFN)>9 F IBY=1:1:4 I $D(IBDXIFN(IBY)) S DIC("DR")=DIC("DR")_";"_(IBY+9)_"////"_IBDXIFN(IBY)
 . S DIC="^DGCR(399,"_IFN_",""CP"",",DIC(0)="L",DA(1)=IFN,X=IBCPT_";ICPT(" K DD,DO D FILE^DICN K DIC,DA,DD,DO,DR,DLAYGO
 . I +Y D
 .. N Z,IBZ
 .. S IBZ=+Y,Z=$S($G(IBREV):IBREV,1:$$FINDREV^IBCSC5A(IFN,3,+IBX))
 .. I Z S DR=".15////"_IBZ_";.06////"_IBCPT,DA=+Z,DA(1)=IFN,DIE="^DGCR(399,"_DA(1)_",""RC""," D ^DIE
 Q
 ;
RXDISP(DFN,DT1,DT2,ARRAY,POARR,RXARR,IBRXALL,NODISP) ; display all rx fills for a patient and date range
 ;RXARR (as defined by SET^IBCSC5A) passed by ref. only to check if rx-fill is on the bill, not necessary not changed
 ;returns: ARRAY(RX #, FILL DT) = RX IFN (52) ^ FILL IFN ^ DRUG ^ DAYS SUPPLY ^ QTY ^ NDC, pass by reference if desired
 ;         POARR(CNT)=RX # ^ FILL DT
 N PIFN,RIFN,IBX,IBY,DTE,DTR,RX,IBCNT,IBRX0,IBRX2,IBS,LIST,LIST2 K ARRAY,POARR S POARR=0,NODISP=+$G(NODISP)
 S IBCNT=0,DT1=$G(DT1)-.0001,DT2=$G(DT2) S:'DT2 DT2=9999999 Q:'$G(DFN)
 ;^PS(55,DFN,"P","A",EXPIRATION DATE, RX) is the best xref available for finding patient fills in a date range
 ;if RX expires/cancelled before start of bill then should not be applicable to bill
 S LIST="IBRXDISPARR"
 D PROF^PSO52API(DFN,LIST,DT1)
 S DTE=0 F  S DTE=$O(^TMP($J,LIST,"B",DTE)) Q:'DTE  D
 . S PIFN=0 F  S PIFN=$O(^TMP($J,LIST,"B",DTE,PIFN)) Q:'PIFN  D
 .. S IBRX0=$$RXZERO^IBRXUTL(DFN,PIFN),IBRX2=$$RXSEC^IBRXUTL(DFN,PIFN)
 .. ; original fill
 .. I +$G(IBRXALL) S DTR=$P(IBRX2,U,2) I DTR'<DT1,DTR'>DT2 D
 ... D DATA^IBRXUTL(+$P(IBRX0,U,6))
 ... S ARRAY($P(IBRX0,U,1),+DTR)=PIFN_U_0_U_$P(IBRX0,U,6)_U_$P(IBRX0,U,8)_U_$P(IBRX0,U,7)_U_$$GETNDC^PSONDCUT(PIFN,0)
 ... K ^TMP($J,"IBDRUG")
 ... Q
 .. ; refills
 .. S LIST2="IBDISPSUB"
 .. S NODE="R"
 .. D RX^PSO52API(DFN,LIST2,PIFN,,NODE,,)
 .. S RIFN=0 F  S RIFN=$O(^TMP($J,LIST2,DFN,PIFN,"RF",RIFN)) Q:RIFN'>0  D
 ... S IBY=$$ZEROSUB^IBRXUTL(DFN,PIFN,RIFN) Q:IBY=""
 ... Q:+IBY<DT1!(+IBY>DT2)
 ... D DATA^IBRXUTL(+$P(IBRX0,U,6))
 ... S ARRAY($P(IBRX0,U,1),+IBY)=PIFN_U_RIFN_U_$P(IBRX0,U,6)_U_$P(IBRX0,U,8)_U_$P(IBY,U,4)_U_$$GETNDC^PSONDCUT(PIFN,RIFN)
 ... K ^TMP($J,"IBDRUG")
 ... Q
 .. K ^TMP($J,LIST2)
 K ^TMP($J,LIST)
 ;
 S IBX="",IBS=0 F  S IBX=$O(ARRAY(IBX)) Q:IBX=""  S IBY=0 F  S IBY=$O(ARRAY(IBX,IBY)) Q:'IBY  D
 . S IBCNT=IBCNT+1,POARR(IBCNT)=$P(IBX,U,1)_"^"_+IBY,POARR=IBCNT I $D(RXARR(IBX,IBY)) S IBS=IBS+1
 S $P(POARR,U,2)=IBCNT-IBS
 ;
 Q:+NODISP
 W @IOF,?33,"PRESCRIPTIONS IN DATE RANGE",!,"===============================================================================",!
 S IBCNT=0 F  S IBCNT=$O(POARR(IBCNT)) Q:IBCNT=""  S RX=$P(POARR(IBCNT),U,1),DTR=$P(POARR(IBCNT),U,2) I RX'="",DTR'="" D
 . S IBS=$$RXSTAT^IBCU1($P(ARRAY(RX,DTR),U,3),$P(ARRAY(RX,DTR),U,1),DTR)
 . S IBY="" I $D(RXARR(RX,+DTR)) S IBY="*"
 . D ZERO^IBRXUTL(+$P(ARRAY(RX,DTR),U,3))
 . W !,$J(IBCNT,2),")",?5,IBY,?6,RX,?19,$E($G(^TMP($J,"IBDRUG",+$P(ARRAY(RX,DTR),U,3),.01)),1,25),?46,$$DATE(+DTR),?56,$P(IBS,U,1),?61,$P(IBS,U,2),?69,$P(IBS,U,3),?75,$$EXEMPT(+ARRAY(RX,DTR))
 . S IBY=$$RXDUP^IBCU3(RX,DTR,IBIFN) I +IBY W ?73,$P($G(^DGCR(399,+IBY,0)),U,1)
 . K ^TMP($J,"IBDRUG")
 Q
DATE(X) Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
NEWRX(IBX) ;
 Q:'$G(IBX)  N X,Y K IBLIST W !
NEWRX1 S DIR("?")="Enter the number preceding the RX Fills you want added to the bill. "_$$HTEXT
 S DIR("A")="SELECT NEW RX FILLS TO ADD THE BILL"
 S DIR(0)="LO^1:"_+IBX D ^DIR K DIR G:'Y!$D(DIRUT) NEWRXE
 S IBLIST=Y
 ;
 S DIR("A")="YOU HAVE SELECTED "_IBLIST_" TO BE ADDED TO THE BILL IS THIS CORRECT",DIR("B")="YES"
 S DIR(0)="YO" D ^DIR K DIR I $D(DIRUT) K IBLIST G NEWRXE
 I 'Y K IBLIST G NEWRX1
NEWRXE Q
 ;
ADDNEW(IBIFN,LIST,IBPR,IBPRO) ;
 Q:'LIST  N IBI,IBX,IBRX,IBDT,IBQ,IBY,IBPIFN,IBZ
 F IBI=1:1 S IBX=$P(LIST,",",IBI) Q:'IBX  I $D(IBPRO(IBX)) D
 . S IBRX=$P(IBPRO(IBX),U,1),IBDT=$P(IBPRO(IBX),U,2) Q:IBRX=""
 . S IBQ=0,IBY=$G(IBPR(IBRX,+IBDT)) Q:'IBY
 . S IBPIFN=0 F  S IBPIFN=$O(^IBA(362.4,"AIFN"_IBIFN,IBRX,IBPIFN)) Q:'IBPIFN  I $P($G(^IBA(362.4,IBPIFN,0)),U,3)=IBDT S IBQ=1 Q
 . I 'IBQ S IBZ=$G(IBPR(IBRX,IBDT)) I $$ADD^IBCSC5A(IBRX,IBIFN,IBDT,$P(IBZ,U,3),$P(IBZ,U,1),$P(IBZ,U,4,6),$P(IBZ,U,2)) W "."
 Q
 ;
HTEXT() ;
 N X S X="If an Rx fill has been assigned to another bill it will be displayed in the last column. [ORG=Original Fill, NR=Not Released, RTS=Returned to Stock, OTC=Over-the-Counter, INV=Investigational, SUP=Supply Item]"
 Q X
 ;
RXLINK(IBIFN,CPIEN) ; Function returns the ien of the Rx rev code the proc
 ; code is linked to or 0 if no link found.
 Q +$O(^DGCR(399,IBIFN,"RC","ACP",+CPIEN,0))
 ;
EXEMPT(RX) ; Used to look up exemption if any on rx, the return value
 ; will be only the first exemption reason found.
 N IBX,IBZ,IBS,IBR,PDFN,LIST,NODE,ICDCT
 S PDFN=$$FILE^IBRXUTL(RX,2)
 S LIST="IBRXARREX"
 S NODE="ICD"
 D RX^PSO52API(PDFN,LIST,RX,,NODE,,)
 S ICDCT=$G(^TMP($J,LIST,PDFN,RX,"ICD",0))
 S IBR="",(IBS,IBX)=0
 I ICDCT>0 D
 .S IBX=0 F  S IBX=$O(^TMP($J,LIST,PDFN,RX,"ICD",IBX)) Q:IBX'>0!(IBS)  D
 ..S IBZ=$$ICD^IBRXUTL1(PDFN,RX,IBX,LIST) F IBP=2:1:8 Q:IBS  I $P(IBZ,"^",IBP) S IBR=$P($T(EREASON+(IBP-1)),";",3),IBS=1
 K ^TMP($J,LIST)
 Q IBR
EREASON ;
 ;;AO
 ;;IR
 ;;SC
 ;;SWA
 ;;MST
 ;;HNC
 ;;CV
 ;;SHAD
 ;
