PRCAI170 ;WISC/RFJ-post init patch 170 ; 26 Jan 01
 ;;4.5;Accounts Receivable;**170**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PREINIT ;  start pre init, check to make sure entries can be added to 430.2
 N %,CURDATA,NEWDATA,RCERROR
 ;
 D BMES^XPDUTL(" >>  Starting the Pre-Initialization routine ...")
 D MES^XPDUTL("     -> Checking file 430.2 prior to adding new entries ...")
 ;
 ;  check 430.2 entries and verify the new ones can be added
 S RCERROR=0
 F %=33:1:39 S CURDATA=$G(^PRCA(430.2,%,0)) I CURDATA'="" S NEWDATA=$P($T(@%),";",3,99) I $P(CURDATA,"^")'=$P(NEWDATA,"^") S RCERROR=1
 ;
 ;  cannot install patch
 I RCERROR S XPDQUIT=1 D MES^XPDUTL("        WARNING: FILE 430.2 IS CORRUPT.  UNABLE TO INSTALL PATCH."),MES^XPDUTL("        PLEASE LOG A NOIS.")
 I 'RCERROR D MES^XPDUTL("        Everything is OK!")
 ;
 D MES^XPDUTL(" >>  End of the Pre-Initialization routine.")
 Q
 ;
 ;
POSTINIT ;  start post init
 N %,D,D0,DA,DI,DIC,DIE,DIK,DINUM,DLAYGO,DQ,DR,RCDATA,RCDINUM,X,Y
 ;
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine ...")
 D MES^XPDUTL("     -> Adding new AR Category entries to file 430.2 ...")
 ;
 ;  install entries in file 430.2
 F RCDINUM=33:1:39 D
 .   S RCDATA=$P($T(@RCDINUM),";",3,99)
 .   S (DIC,DIE)="^PRCA(430.2,",DIC(0)="L",DLAYGO=430.2
 .   ;
 .   ;  if the entry is in the file, delete it first to add fields uneditable
 .   I $D(^PRCA(430.2,RCDINUM,0)) S DIK="^PRCA(430.2,",DA=RCDINUM D ^DIK
 .   ;
 .   ;  add entry
 .   S DINUM=RCDINUM
 .   S X=$P(RCDATA,"^")
 .   D FILE^DICN
 .   ;
 .   ;  set the fields
 .   S DA=RCDINUM
 .   S DR="1///"_$P(RCDATA,"^",2)_";2////0;3///1319;5///P;"
 .   ;  category number (add this to activation patch)
 .   S DR=DR_"6////"_$P(RCDATA,"^",3)_";"
 .   S DR=DR_"7///2;9///1;10///1;11///1;12///1;13///2;"
 .   ;  paragraph notes
 .   S DR=DR_"14///30,40,55,80,85,50,60,65,70;"
 .   D ^DIE
 ;
 D MES^XPDUTL("        OK, I'm done!")
 D MES^XPDUTL(" >>  End of the Post-Initialization routine ...")
 Q
 ;
 ;
 ;;categoryname ^ abbreviation ^ category number
33 ;;ADULT DAY HEALTH CARE^AD^0
34 ;;DOMICILIARY^DO^0
35 ;;RESPITE CARE-INSTITUTIONAL^RC^0
36 ;;RESPITE CARE-NON-INSTITUTIONAL^RN^0
37 ;;GERIATRIC EVAL-INSTITUTIONAL^GE^0
38 ;;GERIATRIC EVAL-NON-INSTITUTION^GN^0
39 ;;NURSING HOME CARE-LTC^NL^0
 ;
 ;
 ;
 ;  comments for the patch to activate the ltc categories
 ;  create a post init that will set field 6 in file 430.2
 ;  which is the category number as it is shown below.
 ;;categoryname ^ abbreviation ^ category number
 ;;ADULT DAY HEALTH CARE^AD^40
 ;;DOMICILIARY^DO^41
 ;;RESPITE CARE-INSTITUTIONAL^RC^42
 ;;RESPITE CARE-NON-INSTITUTIONAL^RN^43
 ;;GERIATRIC EVAL-INSTITUTIONAL^GE^44
 ;;GERIATRIC EVAL-NON-INSTITUTION^GN^45
 ;;NURSING HOME CARE-LTC^NL^46
