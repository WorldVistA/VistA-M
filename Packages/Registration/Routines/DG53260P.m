DG53260P ;BP-CIOFO/MM -2000 MEANS TEST THRESHOLDS ;11/4/99
 ;;5.3;Registration;**260**;Aug 13, 1993
 ;
 ; This routine will upload the 2000 means test thresholds onto your system.
 ;
EN ; enter values distributed by Roscoe Butler.  VHA Directive soon to be released.
 N DA,DIE,DIC,DINUM,DR,I,X,Y
 D BMES^XPDUTL(">>>Means Test Thesholds for 2000 being installed...")
 I $D(^DG(43,1,"MT",3000000)) D  Q
 . D BMES^XPDUTL("   ...Thresholds already exist for 2000...nothing done.")
 ;
 K DO
 S DIC="^DG(43,1,""MT"","
 S DIC(0)="L"
 S DA(1)=1
 S (DINUM,X)=3000000
 D FILE^DICN
 S DA=+Y
 ;
 I +Y'=3000000 D  Q
 . D BMES^XPDUTL("   ...Problem encountered adding 2000 thresholds.  Please try")
 . D MES^XPDUTL("      again or contact the CIO Field Office for assistance.")
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
 ;;2^22887^CAT A VET INCOME
 ;;3^4581^CAT A FIRST DEPENDENT INCOME
 ;;4^1532^CAT A INCOME PER DEPENDENT
 ;;8^50000^THRESHOLD PROPERTY
 ;;17^7200^CHILD INCOME EXCLUSION
 ;;QUIT
 Q
