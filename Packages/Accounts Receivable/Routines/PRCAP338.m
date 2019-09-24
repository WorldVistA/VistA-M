PRCAP338 ;SAB/Albany - PRCA*4.5*338 POST INSTALL;12/11/17 2:10pm
 ;;4.5;Accounts Receivable;**338**;Mar 20, 1995;Build 69
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for PRCA*4.5*338
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for PRCA*4.5*338 ")
 ; Adding AR CATEGORIES and REVENUE SOURCE CODES
 D ARCAT
 D ARCATUPD
 D CHRGUPD
 D FND714
 D APPR714
 D FNDR1
 D APPRR1
 D REVSC
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for PRCA*4.5*338")
 Q
 ;
ARCAT ;AR CATEGORY ENTRIES (430.2)
 N LOOP,FDA,FDAIEN,DATA,CHK
 ;
 D MES^XPDUTL("     -> Adding new AR CATEGORY entries to file 430.2 ...")
 ; Add new AR categories
 F LOOP=2:1:38 D
 . ;Clear the array
 . K FDA
 . ;Extract the new AR Category to be added.
 . S DATA=$T(ARDATA+LOOP)
 . ;Check to insure that the AR Category doesn't exist already
 . S CHK=""  ; Initialized the check variable
 . S CHK=$O(^PRCA(430.2,"B",$P(DATA,";",3),""))
 . Q:CHK'=""
 . ;Store in array for adding to the file (#430.2).
 . S FDA(430.2,"+1,",.01)=$P(DATA,";",3)   ;AR Category Name
 . S FDA(430.2,"+1,",1)=$P(DATA,";",4)     ;Abbreviation
 . S FDA(430.2,"+1,",2)=$P(DATA,";",5)     ;Segment
 . S FDA(430.2,"+1,",3)=$P(DATA,";",6)     ;GL #
 . S FDA(430.2,"+1,",5)=$P(DATA,";",7)     ;Type
 . S FDA(430.2,"+1,",6)=$P(DATA,";",8)     ;Category Number
 . S FDA(430.2,"+1,",7)=$P(DATA,";",9)     ;Receivable Code
 . S FDA(430.2,"+1,",9)=$P(DATA,";",10)    ;Charge Interest
 . S FDA(430.2,"+1,",10)=$P(DATA,";",11)   ;Charge Admin
 . S FDA(430.2,"+1,",11)=$P(DATA,";",12)   ;Charge Penalty
 . S FDA(430.2,"+1,",12)=$P(DATA,";",13)   ;Accrued
 . S FDA(430.2,"+1,",13)=$P(DATA,";",14)   ;Refund/Reimbursement
 . S FDA(430.2,"+1,",14)=$P(DATA,";",15)   ;Paragraph Codes
 . ;Add to the file.
 . D UPDATE^DIE(,"FDA","FDAIEN")
 . S FDAIEN=FDAIEN(1) K FDAIEN(1)
 D MES^XPDUTL("        New AR CATEGORIES added.")
 Q
 ;
ARDATA ; New AR Category data. (Internal data format)
 ;;Category Name;Abbreviation;AMIS Seg #;GL Number;Type;AR Cat #;Receivable Code;Interest;Admin;Penalty;Accrued;Refund;Paragraph Codes
 ;;CHOICE THIRD PARTY;C1;249;1212;T;50;2;0;0;0;1;2;
 ;;CC THIRD PARTY;C2;249;1212;T;51;2;0;0;0;1;2;
 ;;CCN THIRD PARTY;C3;249;1212;T;52;2;0;0;0;1;2;
 ;;CC MTF THIRD PARTY;C4;249;1212;T;53;2;0;0;0;1;2;
 ;;CHOICE NO-FAULT AUTO;C5;247;1212;T;54;2;0;0;0;1;2;
 ;;CHOICE TORT FEASOR;C6;0;1228;T;55;2;0;0;0;1;2;
 ;;CCN WORKERS' COMP;CD;246;1212;T;56;2;0;0;0;1;2;
 ;;CCN NO-FAULT AUTO;CB;247;1212;T;57;2;0;0;0;1;2;
 ;;CCN TORT FEASOR;CC;0;1228;T;58;2;0;0;0;1;2;
 ;;CC WORKERS' COMP;CA;246;1212;T;59;2;0;0;0;1;2;
 ;;CC NO-FAULT AUTO;C8;247;1212;T;60;2;0;0;0;1;2;
 ;;CC TORT FEASOR;C9;0;1228;T;61;2;0;0;0;1;2;
 ;;CHOICE WORKERS' COMP;C7;246;1212;T;62;2;0;0;0;1;2;
 ;;CHOICE INPT;CF;240;1221;P;63;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CHOICE RX CO-PAYMENT;CG;294;1212;P;64;2;1;1;0;1;2;25,40,55,80,85,50,60,65,70
 ;;CC INPT;CJ;240;1221;P;65;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CC RX CO-PAYMENT;CK;294;1212;P;66;2;1;1;0;1;2;25,40,55,80,85,50,60,65,70
 ;;CCN INPT;CO;240;1221;P;67;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CCN RX CO-PAYMENT;CQ;294;1212;P;68;2;1;1;0;1;2;25,40,55,80,85,50,60,65,70
 ;;CC MTF INPT;CX;240;1221;P;69;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CC MTF RX CO-PAYMENT;CY;294;1212;P;70;2;1;1;0;1;2;25,40,55,80,85,50,60,65,70
 ;;CC NURSING HOME CARE - LTC;CL;0;1319;P;71;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CC RESPITE CARE;CN;0;1319;P;72;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CCN NURSING HOME CARE - LTC;CR;0;1319;P;73;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CCN RESPITE CARE;CU;0;1319;P;74;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CHOICE NURSING HOME CARE - LTC;CH;0;1319;P;75;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CHOICE RESPITE CARE;CI;0;1319;P;76;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;TRICARE DES;T4;0;1311;T;77;2;0;0;0;0;2
 ;;TRICARE SCI;T5;0;1311;T;78;2;0;0;0;0;2
 ;;TRICARE TBI;T6;0;1311;T;79;2;0;0;0;0;2
 ;;TRICARE BLIND REHABILITATION;T7;0;1311;T;80;2;0;0;0;0;2
 ;;TRICARE DENTAL;T8;0;1311;T;81;2;0;0;0;0;2
 ;;TRICARE PHARMACY;T9;0;1311;T;82;2;0;0;0;0;2
 ;;CHOICE OPT;CZ;240;1221;P;83;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CC OPT;D1;240;1221;P;84;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CCN OPT;D2;240;1221;P;85;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;CC MTF OPT;D3;240;1221;P;86;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;END
 ;
ARCATUPD ; AR CATEGORY ENTRIES (430.2)
 N LOOP,LIEN,PRCAARY,PRCADATA,PRCAARCT
 N PRCADMC,PRCATOP,PRCACS
 N X,Y,DIE,DA,DR,DTOUT,DATA
 ;
 D MES^XPDUTL("     -> Adding data to the new AR CATEGORY (430.2) fields ...")
 ;Clear the array
 K PRCAARY
 ; Grab all of the entries to update
 F LOOP=2:1 S PRCADATA=$T(ARUPDDAT+LOOP) Q:PRCADATA=" ;;END"  D
 . ;Extract the new AR Category to be added.
 . S PRCAARCT=$P(PRCADATA,";",4)
 . ;Store in array for adding to the file (#430.2).
 . S PRCAARY(PRCAARCT)=$P(PRCADATA,";",5,7)
 ;
 ;Loop through all of the entries in the AC xref of the 430.2 file, and update using the built array
 F LOOP=1:1:86 D
 . S DATA=$G(PRCAARY(LOOP))
 . Q:DATA=""    ;go to next entry if Category is not to be updated.
 . S LIEN=$O(^PRCA(430.2,"AC",LOOP,""))
 . Q:LIEN=""
 . S PRCADMC=$P(DATA,";",1)
 . S PRCATOP=$P(DATA,";",2)
 . S PRCACS=$P(DATA,";",3)
 . ;
 . ; File the update
 . S DR="1.01////"_PRCADMC_";"
 . S DR=DR_"1.02////"_PRCATOP_";"
 . S DR=DR_"1.03////"_PRCACS_";"
 . Q:DR=""
 . S DIE="^PRCA(430.2,",DA=LIEN
 . D ^DIE
 . K DR   ;Clear update array before next use
 ;
 S DR=""
 D MES^XPDUTL("        Data added to the new AR CATEGORY (430.2) fields.")
 Q
 ;
ARUPDDAT ; Data for the new AR Category fields. (All categories will be updated)
 ;;Category Name;Category Num;DMC?;TOP?;CS?
 ;;ADULT DAY HEALTH CARE;40;1;2;3
 ;;C (MEANS TEST);24;1;2;3
 ;;CHAMPVA;36;0;0;0
 ;;CHAMPVA SUBSISTENCE;34;0;0;0
 ;;CHAMPVA THIRD PARTY;35;0;0;0
 ;;COMP & PEN PROCEEDS;8;0;0;0
 ;;CRIME OF PER.VIO.;27;0;0;0
 ;;CURRENT EMP.;14;0;1;0
 ;;CWT PROCEEDS;7;0;0;0
 ;;DOMICILIARY;41;1;2;3
 ;;EMERGENCY/HUMANITARIAN;25;0;1;0
 ;;EMERGENCY/HUMANITARIAN REIMB.;48;0;0;0
 ;;ENHANCED USE LEASE PROCEEDS;10;0;1;0
 ;;EX-EMPLOYEE;13;0;1;0
 ;;FEDERAL AGENCIES-REFUND;15;0;0;0
 ;;FEDERAL AGENCIES-REIMB.;16;0;0;0
 ;;FEE REIMB INS;47;0;0;0
 ;;GERIATRIC EVAL-INSTITUTIONAL;44;1;2;3
 ;;GERIATRIC EVAL-NON-INSTITUTION;45;1;2;3
 ;;HOSPITAL CARE (NSC);1;1;2;3
 ;;HOSPITAL CARE PER DIEM;32;1;2;3
 ;;INELIGIBLE HOSP.;20;0;1;0
 ;;INELIGIBLE HOSP. REIMB.;49;0;0;0
 ;;INTERAGENCY;19;0;0;0
 ;;MEDICARE;28;0;0;0
 ;;MILITARY;17;0;0;0
 ;;NO-FAULT AUTO ACC.;26;0;0;0
 ;;NURSING HOME CARE PER DIEM;31;1;2;3
 ;;NURSING HOME CARE(NSC);3;1;2;3
 ;;NURSING HOME CARE-LTC;46;1;2;3
 ;;NURSING HOME PROCEEDS;5;1;2;3
 ;;OUTPATIENT CARE(NSC);2;1;2;3
 ;;PARKING FEES;6;0;1;0
 ;;PREPAYMENT;33;0;0;0
 ;;REIMBURS.HEALTH INS;21;0;0;0
 ;;RESPITE CARE-INSTITUTIONAL;42;1;2;3
 ;;RESPITE CARE-NON-INSTITUTIONAL;43;1;2;3
 ;;RX CO-PAYMENT/NSC VET;30;1;2;3
 ;;RX CO-PAYMENT/SC VET;29;1;2;3
 ;;SHARING AGREEMENTS;18;0;1;0
 ;;TORT FEASOR;22;0;0;0
 ;;TRICARE;37;0;0;0
 ;;TRICARE PATIENT;38;1;2;3
 ;;TRICARE THIRD PARTY;39;0;0;0
 ;;VENDOR;11;0;1;0
 ;;WORKMAN'S COMP.;23;0;0;0
 ;;CHOICE THIRD PARTY;50;0;0;0
 ;;CC THIRD PARTY;51;0;0;0
 ;;CCN THIRD PARTY;52;0;0;0
 ;;CC MTF THIRD PARTY;53;0;0;0
 ;;CHOICE NO-FAULT AUTO;54;0;0;0
 ;;CHOICE TORT FEASOR;55;0;0;0
 ;;CCN WORKERS' COMP;56;0;0;0
 ;;CCN NO-FAULT AUTO;57;0;0;0
 ;;CCN TORT FEASOR;58;0;0;0
 ;;CC WORKERS' COMP;59;0;0;0
 ;;CC NO-FAULT AUTO;60;0;0;0
 ;;CC TORT FEASOR;61;0;0;0
 ;;CHOICE WORKERS' COMP;62;0;0;0
 ;;CHOICE C (MEANS TEST);63;1;2;3
 ;;CHOICE RX CO-PAYMENT;64;1;2;3
 ;;CC C (MEANS TEST);65;1;2;3
 ;;CC RX CO-PAYMENT;66;1;2;3
 ;;CCN C (MEANS TEST);67;1;2;3
 ;;CCN RX CO-PAYMENT;68;1;2;3
 ;;CC MTF C (MEANS TEST);69;1;2;3
 ;;CC MTF RX CO-PAYMENT;70;1;2;3
 ;;CC NURSING HOME CARE - LTC;71;1;2;3
 ;;CC RESPITE CARE;72;1;2;3
 ;;CCN NURSING HOME CARE - LTC;73;1;2;3
 ;;CCN RESPITE CARE;74;1;2;3
 ;;CHOICE NURSING HOME CARE - LTC;75;1;2;3
 ;;CHOICE RESPITE CARE;76;1;2;3
 ;;TRICARE DES;77;0;0;0
 ;;TRICARE SCI;78;0;0;0
 ;;TRICARE TBI;79;0;0;0
 ;;TRICARE BLIND REHABILITATION;80;0;0;0
 ;;TRICARE DENTAL;81;0;0;0
 ;;TRICARE PHARMACY;82;0;0;0
 ;;CHOICE OPT;83;1;2;3
 ;;CC OPT;84;1;2;3
 ;;CCN OPT;85;1;2;3
 ;;CC MTF OPT;86;1;2;3
 ;;END
 ;
CHRGUPD ; Update the charge flags
 N RCLOOP,RCIEN,RCDATA,RCINT,RCADMIN,RCPEN,RCCAT
 N X,Y,DIE,DA,DR,DTOUT
 ;
 D MES^XPDUTL("     -> Updating Charge flags in select AR CATEGORY (430.2) entries ...")
 ;Clear the array
 K PRCAARY
 ; Grab all of the entries to update
 F RCLOOP=1:1 S RCDATA=$T(CUPDDT+RCLOOP) Q:RCDATA=" ;;END"  D
 . S RCCAT=$P(RCDATA,";",4)
 . S RCIEN=$O(^PRCA(430.2,"AC",RCCAT,""))
 . Q:RCIEN=""
 . S RCINT=$P(RCDATA,";",5)
 . S RCADMIN=$P(RCDATA,";",6)
 . S RCPEN=$P(RCDATA,";",7)
 . ;
 . ; File the update
 . S DR="9////"_RCINT_";"
 . S DR=DR_"10////"_RCADMIN_";"
 . S DR=DR_"11////"_RCPEN_";"
 . Q:DR=""
 . S DIE="^PRCA(430.2,",DA=RCIEN
 . D ^DIE
 . K DR   ;Clear update array before next use
 ;
 S DR=""
 D MES^XPDUTL("        Charge Flags in select AR CATEGORY (430.2) entries.")
 Q
 ;
CUPDDT ; Charge flag update data
 ;;ADULT DAY HEALTH CARE;40;1;1;0
 ;;COMP & PEN PROCEEDS;8;0;0;0
 ;;CRIME OF PER.VIO.;27;0;0;0
 ;;CWT PROCEEDS;7;0;0;0
 ;;DOMICILIARY;41;1;1;0
 ;;GERIATRIC EVAL-INSTITUTIONAL;44;1;1;0
 ;;GERIATRIC EVAL-NON-INSTITUTION;45;1;1;0
 ;;NO-FAULT AUTO ACC.;26;0;0;0
 ;;NURSING HOME CARE-LTC;46;1;1;0
 ;;NURSING HOME PROCEEDS;5;0;0;0
 ;;RESPITE CARE-INSTITUTIONAL;42;1;1;0
 ;;RESPITE CARE-NON-INSTITUTIONAL;43;1;1;0
 ;;TORT FEASOR;22;0;0;0
 ;;END
ENV ;environment check
 S XPDABORT=""   ;Package level variable. Don't New
 D DBCHK(.XPDABORT) ;checks for fund existence
 I XPDABORT="" K XPDABORT
 Q
 ;
DBCHK(XPDABORT) ;checks for test/production account
 N RCMISS,RCIEN
 ;
 S RCMISS=0  ; Set the missing flag to False (No Funds missing)
 ;
 ; check to see if 0160R1 is properly defined
 S RCIEN=$O(^PRCD(420.3,"B","0160R1","")) S:'RCIEN RCMISS=1
 S RCIEN=$O(^PRCD(420.14,"B","0160R1","")) S:'RCIEN RCMISS=1
 ;
 ; If not defined properly (RCMISS=1) warn user and abort the installation.
 I RCMISS DO
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("The new 0160R1 fund has not been fully defined for this facility.")
 . D MES^XPDUTL("This facility is not yet ready for the installation of PRCA*4.5*338.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
 ;
FND714 ;PRCD FUND entry 528714 in 420.14
 N DA,DIC,DIK,DLAYGO,FUND,X,Y
 D MES^XPDUTL("     -> Adding new PRCD FUND entry 528714 to file 420.14 ...")
 S DIC="^PRCD(420.14,",DIC(0)="L",DLAYGO=420.14,FUND=528714
 ; if the entry is in the file, delete it first to add fields uneditable
 S X=FUND D ^DIC I +Y>0 S DA=+Y,DIK="^PRCD(420.14," D ^DIK
 ; add entry
 S X=FUND
 S DIC("DR")="1////MCCF-FEE-COLL FUND-1ST PARTY;"
 S DIC("DR")=DIC("DR")_"2///2018;"
 S DIC("DR")=DIC("DR")_"3///2018;"
 S DIC("DR")=DIC("DR")_"4.7///NET;"
 S DIC("DR")=DIC("DR")_"5///A;"
 S DIC("DR")=DIC("DR")_"4.5///N;"
 D FILE^DICN
 D MES^XPDUTL("        PRCD FUND completed.")
 Q
 ;
APPR714 ;PRCD FUND/APPROPRIATION CODE entry 528714 in 420.3
 N DA,DIC,DIE,DIK,DINUM,DLAYGO,DR,RCDATA,RCDINUM,X,Y
 D MES^XPDUTL("     -> Adding new PRCD FUND/APPROPRIATION CODE entry 528714 to file 420.3 ...")
 ;  install entries in file 420.3
 S FUND=528714,DIC="^PRCD(420.3,",DIC(0)="L",DLAYGO=420.3
 ;  if the entry is in the file, delete it first to add fields uneditable
 S X=FUND D ^DIC I +Y>0 S DA=+Y,DIK="^PRCD(420.3," D ^DIK
 ;  add entry
 S X=FUND
 S DIC("DR")="2////36_5287.14;"
 S DIC("DR")=DIC("DR")_"4///36_5287.14;"
 S DIC("DR")=DIC("DR")_"6///528714;"
 S DIC("DR")=DIC("DR")_"7///Y;"
 D FILE^DICN
 D MES^XPDUTL("        PRCD FUND/APPROPRIATION CODE completed.")
 Q
 ;
FNDR1 ;PRCD FUND entry 0160R1 into 420.14
 N DA,DIC,DIK,DLAYGO,FUND,X,Y
 D MES^XPDUTL("     -> Adding new PRCD FUND entry 0160R1 to file 420.14 ...")
 S DIC="^PRCD(420.14,",DIC(0)="L",DLAYGO=420.14,FUND="0160R1"
 ; if the entry is in the file, delete it first to add fields uneditable
 S X=FUND D ^DIC I +Y>0 S DA=+Y,DIK="^PRCD(420.14," D ^DIK
 ; add entry
 S X=FUND
 S DIC("DR")="1////MEDICAL SERVICE - LIM1;"
 S DIC("DR")=DIC("DR")_"2///2018;"
 S DIC("DR")=DIC("DR")_"3///2018;"
 S DIC("DR")=DIC("DR")_"4.7///NET;"
 S DIC("DR")=DIC("DR")_"5///A;"
 S DIC("DR")=DIC("DR")_"4.5///Y;"
 D FILE^DICN
 D MES^XPDUTL("        PRCD FUND completed.")
 Q
 ;
APPRR1 ;PRCD FUND/APPROPRIATION CODE entry 0160R1 into 420.3
 N DA,DIC,DIE,DIK,DINUM,DLAYGO,DR,RCDATA,RCDINUM,X,Y
 D MES^XPDUTL("     -> Adding new PRCD FUND/APPROPRIATION CODE entry 0160R1 to file 420.3 ...")
 ;  install entries in file 420.3
 S FUND="0160R1",DIC="^PRCD(420.3,",DIC(0)="L",DLAYGO=420.3
 ;  if the entry is in the file, delete it first to add fields uneditable
 S X=FUND D ^DIC I +Y>0 S DA=+Y,DIK="^PRCD(420.3," D ^DIK
 ;  add entry
 S X=FUND
 S DIC("DR")="2////36_0160;"
 S DIC("DR")=DIC("DR")_"4///36 0160;"
 S DIC("DR")=DIC("DR")_"6///0160R1;"
 D FILE^DICN
 D MES^XPDUTL("        PRCD FUND/APPROPRIATION CODE completed.")
 Q
 ;
REVSC ;REVENUE SOURCE CODE entries in file #347.3
 N RCLOOP,RSCDATA,DIC,Y,GBL,DA,X,DIE,DR
 D MES^XPDUTL("     -> Adding new REVENUE SOURCE CODE entries to file 347.3 ...")
 S GBL="^RC(347.3,"
 F RCLOOP=1:1 D  Q:RSCDATA="END"
 . S RSCDATA=$P($T(NEWRSC+RCLOOP),";",3,99)
 . Q:RSCDATA="END"
 . ; do a lookup and continue if exists.
 . S DIC=GBL,X=$P(RSCDATA,";",2) D ^DIC
 . I +Y>0 S DIK=GBL,DA=+Y D ^DIK
 . ; add entry
 . S X=$P(RSCDATA,";",2)
 . S DIC("DR")=".02///"_$P(RSCDATA,";")_";"
 . S DIC("DR")=DIC("DR")_".03///0;"
 . D FILE^DICN
 . I +Y=-1 D
 . . D MES^XPDUTL("        "_$P(RSCDATA,";")_" failed to add!")
 D MES^XPDUTL("        REVENUE SOURCE CODES completed.")
 ;
NEWRSC ;New Revenue Source Codes (RSC#)
 ;;DOD DISABILITY EVALUATION SYSTEM (DES);8085
 ;;DOD SPINAL CORD INPATIENT;8086
 ;;DOD SPINAL CORD OUTPATIENT;8087
 ;;DOD SPINAL CORD OTHER;8088
 ;;DOD TRAUMATIC BRAIN INJURY INPATIENT;8089
 ;;TRAUMATIC BRAIN INJURY OUTPATIENT;8090
 ;;TRAUMATIC BRAIN INJURY OTHER;8091
 ;;BLIND REHABILITATION INPATIENT;8092
 ;;BLIND REHABILITATION OUTPATIENT;8093
 ;;BLIND REHABILITATION OTHER;8094
 ;;TRICARE PHARMACY;8095
 ;;TRICARE ACTIVE DUTY DENTAL;8096
 ;;END
