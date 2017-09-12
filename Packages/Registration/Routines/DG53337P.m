DG53337P ;BP-CIOFO/MM,RTK -2001 MEANS TEST THRESHOLDS ;11/4/99
 ;;5.3;Registration;**337**;Aug 13, 1993
 ;
 ; This routine will upload the 2001 means test thresholds onto your
 ; system.
 ;
EN ; enter values distributed by Roscoe Butler in VHA DIRECTIVE 2000-048,
 ; NEW MEANS TEST THRESHOLDS - 2001.
 ;
 N DA,DIE,DIC,DINUM,DR,I,X,Y
 D BMES^XPDUTL(">>>Means Test Thesholds for 2001 being installed...")
 I $D(^DG(43,1,"MT",3010000)) D  Q
 . D BMES^XPDUTL("   ...Thresholds already exist for 2001...nothing done.")
 ;
 K DO
 S DIC="^DG(43,1,""MT"","
 S DIC(0)="L"
 S DA(1)=1
 S (DINUM,X)=3010000
 D FILE^DICN
 S DA=+Y
 ;
 I +Y'=3010000 D  Q
 . D BMES^XPDUTL("   ...Problem encountered adding 2001 thresholds.  Please try")
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
 ;;2^23688^CAT A VET INCOME
 ;;3^4741^CAT A FIRST DEPENDENT INCOME
 ;;4^1586^CAT A INCOME PER DEPENDENT
 ;;8^50000^THRESHOLD PROPERTY
 ;;17^7450^CHILD INCOME EXCLUSION
 ;;QUIT
 Q
