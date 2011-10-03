IBYPPL ;ALB/ARH - IB*2*307 POST INIT: CMAC 2005, INACTIVATE OLD CHARGES ; 06-JUN-2005
 ;;2.0;INTEGRATED BILLING;**307**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
POST ;
 N IBA S IBA(1)="",IBA(2)="    IB*2*307 CMAC 2005 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D CHGINA("CMAC",3050401) ; inactivate all CMAC charges effective before 04/01/05 in #363.2
 ;
 S IBA(1)="",IBA(2)="    IB*2*307 CMAC 2005 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
CHGINA(BRATE,NEXT) ; inactivate charges for a particular Billing Rate
 ; For procedure charges of requested Billing Rate, inactivate all charges effective before the date passed in.
 ; -  For each charge the inactive date used is one day before the procedures next charge effective date.
 ; -  If no date is passed in then the last charge is left active.
 ; -  If a date is passed in it is used as the default in case no 'next' date is found.
 ; BRATE - Billing Rate, any charges whose billing rate contain BRATE will be inactivated
 ; NEXT - if set, beginning effective date of charges that should not be inactivated
 ;
 N IBA,IBI,IBX,IBCS,IBCS0,IBBR0,IBXRF,IBITM,IBNEF,IBCI,IBCI0,IBCIEF,IBCIIA,IBNEWIA
 N DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,IBCNT S IBCNT=0 Q:$G(BRATE)=""  S NEXT=$G(NEXT) I NEXT'="",NEXT'?7N Q
 ;
 S IBA(1)="      >> Inactivating Existing "_BRATE_" Charges, Please Wait..." D MES^XPDUTL(.IBA) K IBA
 ;
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,IBCS,0)) Q:IBCS0=""
 . S IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0))
 . ;
 . I $P(IBBR0,U,1)'[BRATE Q
 . ;
 . S IBXRF="AIVDTS"_IBCS
 . S IBITM=0 F  S IBITM=$O(^IBA(363.2,IBXRF,IBITM)) Q:'IBITM  D
 .. S IBNEF="" F  S IBNEF=$O(^IBA(363.2,IBXRF,IBITM,IBNEF)) Q:IBNEF=""  D
 ... ;
 ... S IBCI=0 F  S IBCI=$O(^IBA(363.2,IBXRF,IBITM,IBNEF,IBCI)) Q:'IBCI  D
 .... S IBCI0=$G(^IBA(363.2,IBCI,0)) Q:IBCI0=""
 .... S IBCIEF=$P(IBCI0,U,3),IBCIIA=$P(IBCI0,U,4),IBNEWIA=""
 .... ;
 .... I +NEXT,IBCIEF'<NEXT Q
 .... ;
 .... S IBNEWIA=-$O(^IBA(363.2,IBXRF,IBITM,-IBCIEF),-1) I 'IBNEWIA S IBNEWIA=NEXT
 .... ;
 .... I 'IBNEWIA Q
 .... I +IBCIIA,IBCIIA'>IBNEWIA Q
 .... ;
 .... S IBNEWIA=$$FMADD^XLFDT(IBNEWIA,-1)
 .... ;
 .... S DR=".04////"_+IBNEWIA,DIE="^IBA(363.2,",DA=+IBCI D ^DIE K DIE,DIC,DA,DR,X,Y S IBCNT=IBCNT+1
 ;
 S IBA(1)="         Done.  "_IBCNT_" existing charges inactivated " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
