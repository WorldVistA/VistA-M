PRCAP310 ;DRF/Albany - PRCA*4.5*310 POST INSTALL;09/10/15 2:10pm
 ;;4.5;Accounts Receivable;**310**;Mar 20, 1995;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for PRCA*4.5*310
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine ")
 ; AR CATEGORIES and REVENUE SOURCE CODES
 D ARCAT
 D REVSC
 D FUND
 D APPR
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine ")
 Q
 ;
 ;
ARCAT ;AR CATEGORY ENTRIES (430.2)
 N DA,DIC,DIE,DIK,DINUM,DLAYGO,DR,RCDATA,RCDINUM,X,Y
 D MES^XPDUTL("     -> Adding new AR CATEGORY entries to file 430.2 ...")
 S RCDINUM=45,(DIC,DIE)="^PRCA(430.2,",DIC(0)="L",DLAYGO=430.2
 ;  if the entry is in the file, delete it first to add fields uneditable
 I $D(^PRCA(430.2,RCDINUM,0)) S DIK="^PRCA(430.2,",DA=RCDINUM D ^DIK
 S DINUM=RCDINUM
 S X="FEE REIMB INS"
 ;  set the field values
 S DA=RCDINUM,DIC("DR")=""
 S DIC("DR")=DIC("DR")_"1///FR;"
 S DIC("DR")=DIC("DR")_"2///249;"
 S DIC("DR")=DIC("DR")_"3///1212;"
 S DIC("DR")=DIC("DR")_"4///;"
 S DIC("DR")=DIC("DR")_"5///T;"
 S DIC("DR")=DIC("DR")_"6///47;"
 S DIC("DR")=DIC("DR")_"7///2;"
 S DIC("DR")=DIC("DR")_"12///1;"
 S DIC("DR")=DIC("DR")_"9///0;"
 S DIC("DR")=DIC("DR")_"10///0;"
 S DIC("DR")=DIC("DR")_"11///0;"
 S DIC("DR")=DIC("DR")_"13///2;"
 D FILE^DICN
 D MES^XPDUTL("        AR CATEGORY completed.")
 Q
 ;
 ;
REVSC ;REVENUE SOURCE CODE entries in file #347.3
 N I,RSCDATA,DIC,Y,GBL,DA,X,DIE,DR
 D MES^XPDUTL("     -> Adding new REVENUE SOURCE CODE entries to file 347.3 ...")
 S GBL="^RC(347.3,"
 F I=1:1 D  Q:RSCDATA="END"
 . S RSCDATA=$P($T(NEWRSC+I),";",3,99)
 . Q:RSCDATA="END"
 . ; do a lookup and continue if exists.
 . S DIC=GBL,X=$P(RSCDATA,";") D ^DIC
 . I +Y>0 S DIK=GBL,DA=+Y D ^DIK
 . ; add entry
 . S X=$P(RSCDATA,";")
 . S DIC("DR")=".02///"_$P(RSCDATA,";",2)_";"
 . S DIC("DR")=DIC("DR")_".03///0;"
 . D FILE^DICN
 . I +Y=-1 D
 . . D MES^XPDUTL("        "_$P(RSCDATA,";")_" failed to add!")
 D MES^XPDUTL("        REVENUE SOURCE CODES completed.")
 Q
 ;
 ;
FUND ;PRCD FUND entry in 420.14
 N DA,DIC,DIK,DLAYGO,FUND,X,Y
 D MES^XPDUTL("     -> Adding new PRCD FUND entry to file 420.14 ...")
 S DIC="^PRCD(420.14,",DIC(0)="L",DLAYGO=420.14,FUND=528713
 ; if the entry is in the file, delete it first to add fields uneditable
 S X=FUND D ^DIC I +Y>0 S DA=+Y,DIK="^PRCD(420.14," D ^DIK
 ; add entry
 S X=FUND
 S DIC("DR")="1////MCCF-FEE-COLL FUND-3RD PARTY;"
 S DIC("DR")=DIC("DR")_"2///2016;"
 S DIC("DR")=DIC("DR")_"3///2016;"
 S DIC("DR")=DIC("DR")_"4.7///NET;"
 S DIC("DR")=DIC("DR")_"5///A;"
 S DIC("DR")=DIC("DR")_"4.5///N;"
 D FILE^DICN
 D MES^XPDUTL("        PRCD FUND completed.")
 Q
 ;
 ;
APPR ;PRCD FUND/APPROPRIATION CODE entry in 420.3
 N DA,DIC,DIE,DIK,DINUM,DLAYGO,DR,RCDATA,RCDINUM,X,Y
 D MES^XPDUTL("     -> Adding new PRCD FUND/APPROPRIATION CODE entry to file 420.3 ...")
 ;  install entries in file 420.3
 S FUND=528713,DIC="^PRCD(420.3,",DIC(0)="L",DLAYGO=420.3
 ;  if the entry is in the file, delete it first to add fields uneditable
 S X=FUND D ^DIC I +Y>0 S DA=+Y,DIK="^PRCD(420.3," D ^DIK
 ;  add entry
 S X=FUND
 S DIC("DR")="2////36_5287.13;"
 S DIC("DR")=DIC("DR")_"4///36_5287.13;"
 S DIC("DR")=DIC("DR")_"6///528713;"
 S DIC("DR")=DIC("DR")_"7///Y;"
 D FILE^DICN
 D MES^XPDUTL("        PRCD FUND/APPROPRIATION CODE completed.")
 Q
 ;
 ;
 ;Revenue Source Codes (RSC#)
NEWRSC ;SOURCE CODE;NAME
 ;;8F1Z;FEE BASIS INPATIENT
 ;;8F2Z;FEE BASIS OUTPATIENT
 ;;END
