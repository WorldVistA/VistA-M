DG53110P ;ALB/MLI - 1997 MEANS TEST THRESHOLD UPDATE ROUTINE; 13 December 1996
 ;;5.3;Registration;**110**;Aug 13, 1993
 ;
 ; This routine will upload the 1997 means test thresholds onto your system.
 ;
EN ; enter values from directive 96-076
 N DA,DIE,DIC,DINUM,X,Y
 D BMES^XPDUTL(">>>Means Test Thesholds for 1997 being installed...")
 I $D(^DG(43,1,"MT",2970000)) D  Q
 . D BMES^XPDUTL("   ...Thresholds already exist for 1997...nothing done.")
 ;
 S DIC="^DG(43,1,""MT"",",DIC(0)="L"
 S (DINUM,X)=2970000
 D FILE^DICN
 S DA=+Y
 ;
 I +Y'=2970000 D  Q
 . D BMES^XPDUTL("   ...Problem encountered adding 1997 thresholds.  Please try")
 . D MES^XPDUTL("      again or contact your IRM Field Office for assistance.")
 ;
 D MES^XPDUTL("")
 S DIE=DIC,DR=""
 F I=1:1 S X=$P($T(DATA+I),";;",2) Q:X="QUIT"  D                ; build dr string
 . S DR=DR_+X_"////"_$P(X,"^",2)_";"
 . D MES^XPDUTL("   "_$P(X,"^",3)_" set to $"_$FN($P(X,"^",2),","))
 D ^DIE
 Q
 ;
 ;
DATA ; lines to stuff in values (field////value)
 ;;2^21610^CAT A VET INCOME
 ;;3^4325^CAT A FIRST DEPENDENT INCOME
 ;;4^1445^CAT A INCOME PER DEPENDENT
 ;;8^50000^THRESHOLD PROPERTY
 ;;17^6800^CHILD INCOME EXCLUSION
 ;;QUIT
