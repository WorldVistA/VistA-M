DG53211P ;ALB/SEK - 1999 MEANS TEST THRESHOLD UPDATE ROUTINE; 17 November 1998
 ;;5.3;Registration;**211**;Aug 13, 1993
 ;
 ; This routine will upload the 1999 means test thresholds onto your system.
 ;
EN ; enter values distributed by Roscoe Butler.  VHA Directive soon to be released.
 N DA,DIE,DIC,DINUM,DR,I,X,Y
 D BMES^XPDUTL(">>>Means Test Thesholds for 1999 being installed...")
 I $D(^DG(43,1,"MT",2990000)) D  Q
 . D BMES^XPDUTL("   ...Thresholds already exist for 1999...nothing done.")
 ;
 S DIC="^DG(43,1,""MT"",",DIC(0)="L"
 S DIC("P")=$P(^DD(43,250,0),U,2),DA(1)=1
 S (DINUM,X)=2990000
 D FILE^DICN
 S DA=+Y
 ;
 I +Y'=2990000 D  Q
 . D BMES^XPDUTL("   ...Problem encountered adding 1999 thresholds.  Please try")
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
 ;;2^22351^CAT A VET INCOME
 ;;3^4473^CAT A FIRST DEPENDENT INCOME
 ;;4^1496^CAT A INCOME PER DEPENDENT
 ;;8^50000^THRESHOLD PROPERTY
 ;;17^7050^CHILD INCOME EXCLUSION
 ;;QUIT
