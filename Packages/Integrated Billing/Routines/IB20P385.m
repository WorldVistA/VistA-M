IB20P385 ;OAK/ELZ - POST INIT ROUTINE FOR IB*2*385 ;5/15/2013
 ;;2.0;INTEGRATED BILLING;**385**;21-MAR-94;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ENV ;
 ; need to make sure we can find the CD entry for 354.1 before we can
 ; install.
 N DIC,X,Y
 S DIC="^IBE(354.2,",DIC(0)="",X="CATASTROPHICALLY DISABLED" D ^DIC
 I Y<1 W !,"CATASTROPHICALLY DISABLED entry in file 354.1 not found!!" S XPDQUIT=2
 Q
 ;
POST ;
 N IBA
 I $$INSTALDT^XPDUTL("IB*2.0*385") D MES("--> Patch previously installed, not running post-init again",1) Q
 D MES("--> Starting post-install",1)
 D CDFIX ; correct file 354.1 code field for CD patients
 ;D KIDSVFA ; clean up records since VFA start date and cancel charges
 D MES("--> Post-install complete",1)
 ;
 Q
 ;
CDFIX ; - need to find the CD entry in file 354.1 and update the code so it is
 ; a 2 digit code, going to use 70 since IB ignores that code if passed
 ; in by the DG package
 N DIC,X,Y,IBFDA
 D MES("--> Updating 354.2 CATASTROPHICALLY DISABLED entry",1)
 S DIC="^IBE(354.2,",DIC(0)="",X="CATASTROPHICALLY DISABLED" D ^DIC
 I Y<1 D MES("*** Cannot find CATASTROPHICALLY DISABLED ***") Q
 S IBFDA(354.2,+Y_",",.05)=70 D FILE^DIE(,"IBFDA")
 D MES("     - CATASTROPHICALLY DISABLED entry updated")
 Q
 ;
KIDSVFA ; - entry for KIDS doing the VFA clean-up to know to output status bar
 N IBKIDS
 S IBKIDS=1
 ;
VFA ; - clean up since VFA is effective in the past
 N IBCT,IBDT,IBE,IBOK,IBUP,IBZ354,DFN,DA,DR,DIE,IBDATE,IBFDA
 ;
 D MES("--> Cleaning up Patient Exemptions started",1)
 ;
 S IBCT=0
 ;
 S IBE=$O(^IBE(354.2,"B","NO INCOME DATA",0))
 I 'IBE S IBA(1)="***Cannot find Exemption Reason NO INCOME DATA***",IBA(2)="---------- Post install aborded!!! ----------" D MES(.IBA) Q
 ;
 ; -- already running, if not setup xtmp
 I $D(^XTMP("IB20P385",0)) S IBA(1)="Post-install may have already run or may be running now",IBA(2)="Quiting this post-install..." D MES(.IBA) Q
 S ^XTMP("IB20P385",0)=$$FMADD^XLFDT(DT,30)_"^"_DT
 ;
 ; -- setup status bar every 5%
 S XPDIDTOT=$P(^IBA(354,0),"^",4),IBUP=$P(XPDIDTOT/20,".")
 ;
 ; -- go through 354 to find NO INCOME records since 1/1/13
 S DFN=+$G(^XTMP("IB20P385","DFN")) F  S DFN=$O(^IBA(354,DFN)) Q:'DFN  D
 . ;
 . ; -- update status bar
 . S IBCT=IBCT+1 I '(IBCT#IBUP) X $S(IBKIDS:"D UPDATE^XPDID(IBCT)",1:"W "".""")
 . ;
 . S IBZ354=^IBA(354,DFN,0)
 . ;
 . ; quit if not a NO INCOME record active after 1/1/13
 . I $P(IBZ354,"^",3)<3130101!($P(IBZ354,"^",5)'=IBE) D DFN(DFN) Q
 . ;
 . ; look at previously active records to see if they were VFA-OK
 . S IBDT=$$LST^IBARXEU0(DFN,$P(IBZ354,"^",3)),IBOK=0
 . F  S IBDT=$$LST^IBARXEU0(DFN,$$FMADD^XLFDT(+IBDT,-1)) S IBOK=$$VFAOK^IBARXEU(IBDT) Q:IBDT<3120101!(IBOK&($P(IBDT,"^",5)'=IBE))
 . I 'IBOK!($P(IBDT,"^",5)=IBE) D DFN(DFN) Q
 . ;
 . ; set 354 to OK values
 . D UP354(DFN,+IBDT,$P(IBDT,"^",4),$P(IBDT,"^",5))
 . ;
 . ; clean up 354.1 entries
 . S IBDATE=-IBDT F  S IBDATE=$O(^IBA(354.1,"AIVDT",1,DFN,IBDATE),-1) Q:'IBDATE  D
 .. S DA=$O(^IBA(354.1,"AIVDT",1,DFN,IBDATE,0))
 .. S DIE="^IBA(354.1,",DR=".1////0" D ^DIE
 . ;
 . ; cancel copay bills if exempt
 . I '$P(IBDT,"^",4) D DFN(DFN) Q
 . D CANCEL(DFN,IBDT)
 . ;
 . D DFN(DFN)
 ;
 D MES("--> Cleaning up Patient Exemptions completed",1)
 ;
 Q
CANCEL(DFN,IBXX) ; cancel charges from date of last active exemption
 N IBBDT,IBEDT,X,Y,IBDATE,IBFOUND,IBNN,IBPARNT,IBPARDT,IBPARNT1,IBLAST
 N IBCRES,IBND,IBDUZ,IBATYP,IBSEQNO,IBIL,IBUNIT,IBCHRG,IBN,IBFAC,DA,DIE
 N DR,IBYCHK,DLAYGO,IBSITE,IBNOW,IBAFY,ERR,IBWHER,IBARCAN
 ;
 S IBBDT=$S(IBXX<3130101:3130101,1:+IBXX)
 S IBEDT=DT
 ;
 ; - quit if there are no charges to cancel
 S X=$O(^IB("APTDT",DFN,(IBBDT-.01))) I 'X!(X>(IBEDT+.9)) G CANCELQ
 ;
 ; - cancel the charges in billing
 S Y=1 D ARPARM^IBAUTL I Y<0 G CANCELQ
 ;
 S IBDATE=IBBDT-.0001,IBFOUND=0
 F  S IBDATE=$O(^IB("APTDT",DFN,IBDATE)) Q:'IBDATE!((IBEDT+.9)<IBDATE)  D
 . S IBNN=0 F  S IBNN=$O(^IB("APTDT",DFN,IBDATE,IBNN)) Q:'IBNN  D BILL^IBARXEU3
 ;
 ; - cancel bills in AR, if at least one charge was cancelled
 I IBFOUND S IBARCAN=1 D ARCAN^IBARXEU4(DFN,$P(IBXX,"^",4),IBBDT,IBEDT)
 ;
CANCELQ Q
 ;
MES(X,T) ; - display message
 X $S($G(T):"D BMES^XPDUTL(.X)",1:"D MES^XPDUTL(.X)")
 K X
 Q
 ;
RESTART ; - unadvertised entry to restart process from last XTMP patient
 N IBKIDS
 S IBKIDS=0
 K ^XTMP("IB20P385",0)
 D VFA
 Q
 ;
DFN(DFN) ; saves DFN into XTMP
 S ^XTMP("IB20P385","DFN")=DFN
 Q
 ;
UP354(DA,IBDT,IBSTAT,IBEXREA) ; -- calling out separate to update 354
 N DIE,DR
 S DIE="^IBA(354,"
 S DR="[IB CURRENT STATUS]"
 D ^DIE
 Q
