IBYQNS ;ALB/ARH - POST INIT FOR COB INSURANCE PATCH ; 5/1/97
 ;;2.0;INTEGRATED BILLING;**85**;21-MAR-94
 ;
POST ;
 D RIDER ; add dental rider
 D CV ;    add dental and mental health coverage (cv)
 D TOP ;   inactivate Type of Plans
 D MES^XPDUTL("  ")
 Q
 ;
RIDER ; add Dental Insurance Rider (355.6)
 N IBNAME,DD,DO,DLAYGO,DIC,X,Y,IBDA,IBARR,IBX
 D MES^XPDUTL("  ")
 ;
 S IBNAME="DENTAL COVERAGE"
 I $O(^IBE(355.6,"B",IBNAME,0)) S IBX="   - "_IBNAME_" Insurance Rider (355.6) already exists, no change" D MES^XPDUTL(IBX) Q
 ;
 K DD,DO S DLAYGO=355.6,DIC="^IBE(355.6,",DIC(0)="L",X=IBNAME D FILE^DICN K DIC I Y<1 K X,Y Q
 S IBDA=+Y
 ;
 S IBX="   * "_IBNAME_" Insurance Rider (355.6) added" D MES^XPDUTL(IBX)
 Q
 ;
 ;
CV ; add Dental and Mental Health Coverage (355.31)
 N IBNAME,IBRIDER,IBRDA,IBX,DD,DO,DLAYGO,DIC,X,Y,IBDA,DIE,DA,DR,IBFILE
 D MES^XPDUTL("  ")
 S IBFILE=" Plan Limitation Category (355.31) "
 ;
DNTL S IBNAME="DENTAL",IBRIDER="DENTAL COVERAGE"
 S IBRDA=$O(^IBE(355.6,"B",IBRIDER,0)) I 'IBRDA S IBX="   - "_IBNAME_IBFILE_"Not Added, Rider Missing" D MES^XPDUTL(IBX) G MH
 ;
 I $O(^IBE(355.31,"B",IBNAME,0)) S IBX="   - "_IBNAME_IBFILE_"already exists, no change" D MES^XPDUTL(IBX) G MH
 ;
 K DD,DO S DLAYGO=355.31,DIC="^IBE(355.31,",DIC(0)="L",X=IBNAME D FILE^DICN K DIC I Y<1 K X,Y Q
 S IBDA=+Y
 ;
 S DIE="^IBE(355.31,",DA=+IBDA,DR=".02////Dental coverage;.03////"_IBRDA D ^DIE K DIE,DA,DR,X,Y
 ;
 S IBX="   * "_IBNAME_IBFILE_"added" D MES^XPDUTL(IBX)
 ;
 ;
MH S IBNAME="MENTAL HEALTH",IBRIDER="MENTAL HEALTH COVERAGE"
 S IBRDA=$O(^IBE(355.6,"B",IBRIDER,0)) I 'IBRDA S IBX="   - "_IBNAME_IBFILE_"Not Added, Rider Missing" D MES^XPDUTL(IBX) Q
 ;
 I $O(^IBE(355.31,"B",IBNAME,0)) S IBX="   - "_IBNAME_IBFILE_"already exists, no change" D MES^XPDUTL(IBX) Q
 ;
 K DD,DO S DLAYGO=355.31,DIC="^IBE(355.31,",DIC(0)="L",X=IBNAME D FILE^DICN K DIC I Y<1 K X,Y Q
 S IBDA=+Y
 ;
 S DIE="^IBE(355.31,",DA=+IBDA,DR=".02////Mental health coverage;.03////"_IBRDA D ^DIE K DIE,DA,DR,X,Y
 ;
 S IBX="   * "_IBNAME_IBFILE_"added" D MES^XPDUTL(IBX)
 ;
 Q
 ;
 ;
TOP ; inactivate Type of Plans (355.1)
 N IBNAME,IBTOPFN,IBTOPEN,IBI,IBX,DD,DO,DLAYGO,DIC,X,Y,IBDA,DIE,DA,DR
 D MES^XPDUTL("  ")
 ;
 F IBI=1:1 S IBNAME=$P($T(TOPF+IBI),";;",2) Q:+IBNAME!(IBNAME="")  D
 . ;
 . S IBTOPFN=$O(^IBE(355.1,"B",$E(IBNAME,1,30),0))
 . I 'IBTOPFN S IBX="   - "_IBNAME_" Type of Plan (355.1) not defined, no change" D MES^XPDUTL(IBX) Q
 . ;
 . S IBTOPEN=$G(^IBE(355.1,IBTOPFN,0))
 . I IBTOPEN="" S IBX="   - "_IBNAME_" Type of Plan (355.1) not found, no change" D MES^XPDUTL(IBX) Q
 . ;
 . I +$P(IBTOPEN,U,4) S IBX="   - "_IBNAME_" Type of Plan (355.1) inactive, no change" D MES^XPDUTL(IBX) Q
 . ;
 . ;
 . S DIE="^IBE(355.1,",DA=+IBTOPFN,DR=".04////1" D ^DIE K DIE,DA,DR,X,Y
 . S IBX="   * "_IBNAME_" Type of Plan (355.1) Inactivated" D MES^XPDUTL(IBX)
 Q
 ;
TOPF ;
 ;;AVIATION TRIP INSURANCE
 ;;BLUE CROSS/BLUE SHIELD
 ;;COINSURANCE
 ;;DUAL COVERAGE
 ;;HOSPITAL-MEDICAL INSURANCE
 ;;KEY-MAN HEALTH INSURANCE
 ;;MAJOR MEDICAL EXPENSE INSURANCE
 ;;QUALIFIED IMPAIRMENT INSURANCE
 ;;REGULAR MEDICAL EXPENSE INSURANCE
 ;;
