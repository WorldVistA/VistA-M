IBYP814 ;MNTVBB/DMR - IB*2.0*814 POST INIT: REASONABLE CHARGES V5.25 ; Dec 9, 2024@11:09
 ;;2.0;INTEGRATED BILLING;**814**;21-MAR-94;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ; Reference to BMES^XPDUTL in ICR #10141
 ; Reference to ^DIE in ICR #10018
 Q
 ;
POST ;
 ; Backup 363.2 Charge Item File
 N IB814FILES,IB814FILE,IB814NDE,IB814CNT
 S IB814FILE=""
 S IB814FILES="363.2"
 S IB814CNT=0
 ;F IB814CNT=1:1:$L(IB814FILES,"^") D
 ;. S IB814FILE=$P(IB814FILES,"^",IB814CNT)
 ;. D GLBBKUP
 ;. Q
 ; Begin Update
 N IBA,U S U="^"
 D BMSG("    Reasonable Charges v5.25 Post-Install .....")
 D CHGINA("") ; inactivate all RC charges in #363.2
 D BMSG("    Reasonable Charges v5.25 Post-Install Complete")
 Q
 ;
BMSG(IBA) ;
 D BMES^XPDUTL(IBA)
 Q
 ;
GLBBKUP  ; XTMP Backup of file(s)
 S IB814NDE="IB*2*814-CY25 Reasonable Charges Update (#363.2)"
 S ^XTMP("IB20P814",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^"_IB814NDE
 M ^XTMP("IB20P814",IB814FILE,$H)=^IBA(IB814FILE)
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
 D BMSG("      >> Inactivating Existing Reasonable Charges, Please Wait...")
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
 .... S DR=".04///"_+IBNEWIA,DIE="^IBA(363.2,",DA=+IBCI
 .... D ^DIE K DIE,DIC,DA,DR,X,Y S IBCNT=IBCNT+1
 ;
 D BMSG("         Done.  "_IBCNT_" existing charges inactivated")
 Q
 ;
