DG53486P ;ALB/PHH - 2003 MEANS TEST THRESHOLDS ;12/11/02
 ;;5.3;Registration;**486**;Aug 13, 1993
 ;
 ; This routine will upload the 2003 means test thresholds onto your
 ; system.
 ;
EN ; enter values distributed by Roscoe Butler in VHA DIRECTIVE 2002-082,
 ; NEW MEANS TEST THRESHOLDS - 2003.
 ;
 N DA,DIE,DIC,DINUM,DR,I,X,Y,EXST
 S EXST=0
 D BMES^XPDUTL(">>>Means Test Thresholds for 2003 being installed...")
 I $D(^DG(43,1,"MT",3030000)) D
 .D BMES^XPDUTL(" ...Entry exists for income year 2002, entry being deleted")
 .D MES^XPDUTL("     and replaced with nationally released thresholds.")
 .S DIK="^DG(43,1,""MT"",",DA=3030000,DA(1)=1
 .D ^DIK,IX1^DIK
 .K DA,D0,DIK
 K DO
 S DIC="^DG(43,1,""MT"","
 S DIC(0)="L"
 S DA(1)=1
 S (DINUM,X)=3030000
 D FILE^DICN
 S DA=+Y
 ;
 I +Y'=3030000 D  Q
 . D BMES^XPDUTL("   ...Problem encountered adding 2003 thresholds.  Please try")
 . D MES^XPDUTL("      again or contact the CIO Field Office for assistance.")
 ;
 D MES^XPDUTL("")
 S DIE=DIC,DR=""
 F I=1:1 S X=$P($T(DATA+I),";;",2) Q:X="QUIT"  D   ; build dr string
 . S DR=DR_+X_"////"_$P(X,"^",2)_";"
 . D MES^XPDUTL("   "_$P(X,"^",3)_" set to $"_$FN($P(X,"^",2),","))
 D ^DIE
 Q
 ;
 ;
DATA ; lines to stuff in values (field////value)
 ;;2^24644^CAT A VET INCOME
 ;;3^4932^CAT A FIRST DEPENDENT INCOME
 ;;4^1653^CAT A INCOME PER DEPENDENT
 ;;8^80000^THRESHOLD PROPERTY
 ;;17^7800^CHILD INCOME EXCLUSION
 ;;QUIT
 Q
