IBY399P ;ALB/ARH - IB*2*399 POST-INSTALL ; 2/27/09
 ;;2.0;INTEGRATED BILLING;**399**;21-MAR-94;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
POST ;
 N IBA S IBA="IB*2*399 Post-Install .....",IBA(3)="" D MSG(IBA) K IBA
 ;
 D RIDER ; add LTC rider (#355.6)
 D CV ;    add LTC coverage (#355.31)
 ;
 D FTF^IBY399P3 ;   add and convert FTFs (#355.13)
 ;
 D RNB^IBY399P1 ;   add and update RNBs (#356.8)
 ;
 D XREF ; index new AE xref (#362.5,.04)
 ;
 S IBA="IB*2*399 Post-Install Complete",IBA(3)="" D MSG(IBA) K IBA
 Q
 ;
 ;
RIDER ; add LONG TERM CARE Insurance Rider (#355.6)
 N IBA,IBNAME,DD,DO,DLAYGO,DIC,X,Y,IBDA,IBARR,IBX
 ;
 S IBNAME="LONG TERM CARE COVERAGE"
 I $O(^IBE(355.6,"B",IBNAME,0)) S IBA=">> "_IBNAME_" Insurance Rider (355.6) exists, no change" D MSG(IBA) Q
 ;
 K DD,DO S DLAYGO=355.6,DIC="^IBE(355.6,",DIC(0)="L",X=IBNAME D FILE^DICN K DIC S IBDA=+Y I Y<1 K X,Y Q
 ;
 S IBA=">> "_IBNAME_" Insurance Rider (#355.6) added" D MSG(IBA)
 Q
 ;
 ;
CV ; add LONG TERM CARE Coverage (#355.31)
 N IBA,IBNAME,IBRIDER,IBRDA,IBX,DD,DO,DLAYGO,DIC,X,Y,IBDA,DIE,DA,DR,IBFILE
 S IBFILE=" Plan Limitation Category (#355.31) "
 ;
 S IBNAME="LONG TERM CARE",IBRIDER="LONG TERM CARE COVERAGE"
 S IBRDA=$O(^IBE(355.6,"B",IBRIDER,0)) I 'IBRDA S IBA="=> "_IBNAME_IBFILE_"Not Added, Rider Missing" D MSG(IBA) Q
 ;
 I $O(^IBE(355.31,"B",IBNAME,0)) S IBA=">> "_IBNAME_IBFILE_"exists, no change" D MSG(IBA) Q
 ;
 K DD,DO S DLAYGO=355.31,DIC="^IBE(355.31,",DIC(0)="L",X=IBNAME D FILE^DICN K DIC S IBDA=+Y I Y<1 K X,Y Q
 ;
 S DIE="^IBE(355.31,",DA=+IBDA,DR=".02////Long Term Care coverage;.03////"_IBRDA D ^DIE K DIE,DA,DR,X,Y
 ;
 S IBA=">> "_IBNAME_IBFILE_"added" D MSG(IBA)
 ;
 Q
 ;
XREF ; re-index new AE cross reference on IB BILL/CLAIMS PROSTHETICS (#362.5), RECORD (.04)
 N DIK,DIC,X,Y D MSG(">> Indexing new 'AE' xref IB BILL/CLAIMS PROSTHETICS, RECORD (#362.5,.04)")
 S DIK="^IBA(362.5,",DIK(1)=".04^AE" D ENALL^DIK
 Q
 ;
MSG(IBA) ;
 N IBM S IBM(1)="     ",IBM(2)="     "_$G(IBA)
 D MES^XPDUTL(.IBM)
 Q
