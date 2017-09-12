IBYP520 ;ALB/CXW - IB*2.0*520 POST INIT: REVISED REASONABLE CHARGES V3.14; 02-21-2014
 ;;2.0;INTEGRATED BILLING;**520**;21-MAR-94;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ;
 N IBA,U S U="^"
 S IBA(1)="",IBA(2)="    Revised Reasonable Charges v3.14 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ; Inactivate RC charges with effective date 10/01/2013 in #363.2
 D CHGINA("")
 ; Delete RC v3.14 charges with effective date 01/01/2014 in #363.2 
 D PURGE
 S IBA(1)="",IBA(2)="    Revised Reasonable Charges v3.14 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
CHGINA(VERS) ; inactive charges from previous versions of Reasonable Charges
 ; VERS = version to begin inactivations with (1, 1.1, 1.2, ...)
 ; - Inactive date added is the first RC Version Inactive date after the effective date of the charge
 ; - if the charge already has an inactive date less than the Version Inactive Date then no change is made
 ;
 N IBA,IBI,IBX,IBSTART,IBENDATE,IBCS,IBCS0,IBBR0,IBXRF,IBITM,IBNEF,IBCI,IBCI0,IBCIEF,IBCIIA,IBNEWIA
 N DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,IBCNT S IBCNT=0
 ;
 S IBA(1)="      >> Inactivating Existing Reasonable Charges v3.13, Please Wait..." D MES^XPDUTL(.IBA) K IBA
 ;
 S IBSTART="" I $G(VERS)'="" S IBSTART=$$VERSDT^IBCRHBRV(VERS)
 S IBENDATE=$$VERSEND^IBCRHBRV
 ;
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,IBCS,0)) Q:IBCS0=""
 . S IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0)) I $E(IBBR0,1,3)'="RC " Q
 . ;
 . S IBXRF="AIVDTS"_IBCS
 . S IBITM=0 F  S IBITM=$O(^IBA(363.2,IBXRF,IBITM)) Q:'IBITM  D
 .. S IBNEF="" F  S IBNEF=$O(^IBA(363.2,IBXRF,IBITM,IBNEF)) Q:IBNEF=""  Q:-IBNEF<IBSTART  D
 ... ;
 ... S IBCI=0 F  S IBCI=$O(^IBA(363.2,IBXRF,IBITM,IBNEF,IBCI)) Q:'IBCI  D
 .... S IBCI0=$G(^IBA(363.2,IBCI,0)) Q:IBCI0=""
 .... S IBCIEF=$P(IBCI0,U,3),IBCIIA=$P(IBCI0,U,4),IBNEWIA=""
 .... ;
 .... F IBI=2:1 S IBX=+$P(IBENDATE,";",IBI) S IBNEWIA=IBX Q:'IBX  Q:IBCIEF'>IBX
 .... ;
 .... I 'IBNEWIA Q
 .... I +IBCIIA,IBCIIA'>IBNEWIA Q
 .... ;
 .... S DR=".04///"_+IBNEWIA,DIE="^IBA(363.2,",DA=+IBCI D ^DIE K DIE,DIC,DA,DR,X,Y S IBCNT=IBCNT+1
 ;
 S IBA(1)="         Done.  "_IBCNT_" existing charges inactivated",IBA(2)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
PURGE ; delete all charges v3.14 with an effective date 01/01/2014
 N X,X1,X2,DA,DIK,IB11,IBA,IBBR0,IBBR,IBEFDT,IBCI,IBCNT,IBCNT2
 N IBCS,IBCS0,IBFN,IBITM,IBNEF,IBRG,IBXRF
 ; xtmp(ibyp520,0)=purge date^today date^patch #^total charge set deleted
 ; xtmp(ibyp520,csien)=name^"deleted"
 K ^XTMP("IBYP520")
 S DT=$$DT^XLFDT,X1=DT,X2=30 D C^%DTC
 S ^XTMP("IBYP520",0)=X_U_DT_U_"IB*2.0*520 POST-INIT"
 S IBA(1)="      >> Removing Existing Reasonable Charges v3.14, Please Wait..." D MES^XPDUTL(.IBA) K IBA
 S (IBCNT,IBCNT2)=0,IBEFDT=3140101
 ; find the charge item in the charge set 
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,IBCS,0)) Q:IBCS0=""
 . S IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0)) I $E(IBBR0,1,3)'="RC " Q
 . S IBXRF="AIVDTS"_IBCS
 . S IBITM=0 F  S IBITM=$O(^IBA(363.2,IBXRF,IBITM)) Q:'IBITM  D
 .. S IBNEF="" F  S IBNEF=$O(^IBA(363.2,IBXRF,IBITM,IBNEF)) Q:IBNEF=""  I IBNEF=-IBEFDT D
 ... S IBCI=0 F  S IBCI=$O(^IBA(363.2,IBXRF,IBITM,IBNEF,IBCI)) Q:'IBCI  D
 .... I $G(^IBA(363.2,+$G(IBCI),0))="" Q
 .... ; 
 .... ; delete the entry if exists in the file
 .... S DA=IBCI S DIK="^IBA(363.2," D ^DIK
 .... S IBCNT=IBCNT+1
 ... S:'$D(^XTMP("IBYP520",IBCS)) ^XTMP("IBYP520",IBCS)=$P(IBCS0,U,1)
 ;
 ; delete a charge set including all pointers created in rc 3.14 (*513) 
 S IBCS=0 F  S IBCS=$O(^XTMP("IBYP520",IBCS)) Q:'IBCS  D
 . ; quit if va cost (ien=2)
 . S IBCS0=$G(^IBE(363.1,+IBCS,0)),IBBR=+$P(IBCS0,U,2),IBBR0=$G(^IBE(363.3,+IBBR,0))
 . I '$P(IBBR0,U,4)!($P(IBBR0,U,5)=2) Q
 . I $E(IBBR0,1,2)'="RC" Q
 . ; quit if CS has associated charge item
 . ; quit if CS has pointed to awp CS in site parameter
 . I $O(^IBA(363.2,"AIVDTS"_+IBCS,""))'="" Q
 . I $P($G(^IBE(350.9,1,9)),U,12)=+IBCS Q
 . ;
 . ; remove from rate schedule
 . S IBFN=0 F  S IBFN=$O(^IBE(363,"C",+IBCS,IBFN)) Q:'IBFN  D
 .. S IB11="" F  S IB11=$O(^IBE(363,"C",+IBCS,IBFN,IB11)) Q:'IB11  D
 ... I +$G(^IBE(363,+IBFN,11,+IB11,0))=+IBCS S DA(1)=+IBFN,DA=+IB11,DIK="^IBE(363,"_DA(1)_",11," D ^DIK
 . ;
 . ; remove from special groups
 . S IBFN=0 F  S IBFN=$O(^IBE(363.32,IBFN)) Q:'IBFN  D
 .. S IB11=0 F  S IB11=$O(^IBE(363.32,IBFN,11,IB11)) Q:'IB11  D
 ... I +$P($G(^IBE(363.32,IBFN,11,IB11,0)),U,2)=+IBCS S DA(1)=+IBFN,DA=+IB11,DIK="^IBE(363.32,"_DA(1)_",11," D ^DIK
 . ;
 . ; remove region (or division) if not assigned to another charge set
 . S IBRG=$P($G(^IBE(363.1,+IBCS,0)),U,7)
 . I +IBRG S IBFN=0 F  S IBFN=$O(^IBE(363.1,IBFN)) Q:'IBFN  D
 .. I +IBFN'=+IBCS,$P($G(^IBE(363.1,+IBFN,0)),U,7)=IBRG S IBRG=0
 . I +IBRG S DA=+IBRG,DIK="^IBE(363.31," D ^DIK
 . ;
 . ; remove charge set
 . S DA=+IBCS,DIK="^IBE(363.1," D ^DIK
 . S $P(^XTMP("IBYP520",IBCS),U,2)="deleted"
 . S IBCNT2=IBCNT2+1
 S $P(^XTMP("IBYP520",0),U,4)=IBCNT2
 S IBCS=IBCNT2_" charge sets deleted"
 S IBA(1)="         Done.  "_IBCNT_" existing charges deleted and "_IBCS D MES^XPDUTL(.IBA) K IBA
 Q
 ;
