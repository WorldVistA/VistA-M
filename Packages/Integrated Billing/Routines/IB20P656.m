IB20P656 ;/Albany - IB*2.0*656 POST INSTALL;07/25/19 2:10pm
 ;;2.0;Integrated Billing;**656**;Mar 20, 1995;Build 17
 ;Per VA Directive 6402, this routine should not be modified.
 ; Reference to ^DIC(49 supported by IA# 10093
 ; Reference to ^PRCA(430.2 supported by IA# 594
 Q
 ;
POSTINIT ;Post Install for IB*2.0*656
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*656 ")
 ; Adding AR CATEGORIES and REVENUE SOURCE CODES
 D UPDIB ; Update ^IBE fields
 D IBUPD
 D UPDACT
 D UPDDGFEE
 D DGSET
 D NEWCREAS
 D SRVUPD
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*656")
 Q
 ;
UPDIB   ; Update IBE field(s) 
 N IBSL2,IBSL2TXT
 N LOOP,LIEN,IBDATA
 N X,Y,DIE,DA,DR,DTOUT,DATA,IBDATAB
 F LOOP=1:1 S IBDATA=$T(IBSET+LOOP) Q:$P(IBDATA,";",3)="END"  D
 . ;Extract the new ACTION TYPE
 . Q:IBDATA=""    ;go to next entry if Category is not to be updated.
 . S LIEN=$O(^IBE(350.1,"B",$P(IBDATA,";",3),""))
 . S DR=""
 . S IBSL2TXT=$P(IBDATA,";",4)
 . S IBSL2="S IBDESC="_$C(34)_IBSL2TXT_$C(34)
 . S DR=DR_"20///"_IBSL2
 . S DIE="^IBE(350.1,",DA=LIEN
 . D ^DIE
 K DR   ;Clear update array before next use
 Q
 ; 
UPDDGFEE   ; Deactivate FEE Service Entry (inactivate flag to YES)
 ;DG FEE SERVICE (OPT) NEW
 ; LOOKUP - FEE SERVICE/OUTPATIENT
 ; LOGIC - S IBDESC="FEE OPT COPAYMENT"
 N DG,DGN,DGU,DGC,DR,LIEN
 S DGN="DG FEE SERVICE (OPT) NEW"
 S DGC="DG FEE SERVICE (OPT) CANCEL"
 S DGU="DG FEE SERVICE (OPT) UPDATE"
 F DG=DGC,DGU,DGN S LIEN=$O(^IBE(350.1,"B",DG,"")) D
 .S DR=".12////1;"
 .S:DG=DGN DR=DR_".08///FEE SERVICE/OUTPATIENT"  ; USER LOOKUP NAME
 .S DIE="^IBE(350.1,",DA=LIEN
 .D ^DIE
 Q
 ;
DGSET ; SET LOGIC 
 N DR,LIEN
 N IBSL2,IBSL2TXT
 S IBSL2TXT="FEE OPT COPAYMENT"
 S IBSL2="S IBDESC="_$C(34)_IBSL2TXT_$C(34)
 S LIEN=$O(^IBE(350.1,"B","DG FEE SERVICE (OPT) NEW",""))
 S DR="20///"_IBSL2
 S DIE="^IBE(350.1,",DA=LIEN
 D ^DIE
 K DR   ;Clear update array before next use
 S DR=""
 Q
 ;
IBUPD ; CC URGENT CARE Category
 N LOOP,LIEN,IBDATA,IBSERVIC
 N X,Y,DIE,DA,DR,DTOUT,DATA,IBDATAB
 ; 
 N IBSL2,IBSL2TXT
 N CANIEN,UPDIEN,SVCIEN,CHGIEN
 ;
 ;Get the MAS SERVICE IEN POINTER
 S IBSERVIC=$$GET1^DIQ(350.9,"1,",1.14,"I")
 ;
 S IBSL2TXT="CC URGENT OPT COPAY"
 S IBSL2="S IBDESC="_$C(34)_IBSL2TXT_$C(34)
 ;
 ; Grab all of the entries to update
 D MES^XPDUTL("     -> Adding new CC URGENT CARE Action Types (file 350.1).")
 S Y=-1
 F LOOP=1:1 S IBDATA=$T(IBDDAT+LOOP) Q:$P(IBDATA,";",3)="END"  D
 . S CHGIEN=$O(^PRCA(430.2,"B",$P(IBDATA,";",5),""))   ; CHARGE CATEGORY -> IEN (used as pointer)
 . ;Extract the new ACTION TYPE to be added.
 . ;Store in array for adding to the file (#350.1).
 . Q:IBDATA=""    ;go to next entry if Category is not to be updated.
 . ;
 . S LIEN=$O(^IBE(350.1,"B",$P(IBDATA,";",3),""))
 . ; File the update along with inactivate the ACTION TYPE
 . S DLAYGO=350.1,DIC="^IBE(350.1,",DIC(0)="L",X=$P(IBDATA,";",3)
 . I '+LIEN D FILE^DICN S LIEN=+Y K DIC,DINUM,DLAYGO
 . S DR=".02///"_$P(IBDATA,";",4)        ; ABBREVIATION
 . S DR=DR_";.03///"_$G(CHGIEN)          ; CHARGE CATEGORY
 . S DR=DR_";.04////"_IBSERVIC           ; SERVICE
 . S DR=DR_";.05///"_$P(IBDATA,";",7)    ; SEQ. #
 . S DR=DR_";.06///"_$P(IBDATA,";",8)    ; CANCEL ACTION TYPE
 . S DR=DR_";.07///"_$P(IBDATA,";",9)    ; UPDATE ACTION TYPE
 . S DR=DR_";.08///"_$P(IBDATA,";",10)   ; USER LOOKUP NAME
 . S DR=DR_";.09////"_$P(IBDATA,";",11)  ; NEW ACTION TYPE
 . S DR=DR_";.1///"_$P(IBDATA,";",12)    ; PLACE ON HOLD
 . S DR=DR_";.11///"_$P(IBDATA,";",13)   ; BILLING GROUP
 . S:$P(IBDATA,";",14)="IBSL2" DR=DR_";20////"_IBSL2   ;SET LOGIC
 . ;
 . S DIE="^IBE(350.1,",DA=LIEN
 . D ^DIE
 . ;<re-index new entry here>
 .S DA=LIEN,DIK="^IBE(350.1," D IX^DIK
 .S DR=""
 Q
 ;
 ;350.1,.01    3 NAME                   0;1 FREE TEXT (Required)
 ;350.1,.02    4 ABBREVIATION           0;2 FREE TEXT
 ;350.1,.03    5 CHARGE CATEGORY        0;3 POINTER TO ACCOUNTS RECEIVABLE CATEGORY FILE (#430.2)
 ;350.1,.04    6 SERVICE                0;4 POINTER TO DIC FILE (#49)
 ;350.1,.05    7 SEQUENCE NUMBER        0;5 SET
 ;350.1,.06    8 CANCELLATION ACTION TYPE 0;6 POINTER TO IB ACTION TYPE FILE (#350.1)
 ;350.1,.07    9 UPDATE ACTION TYPE     0;7 POINTER TO IB ACTION TYPE FILE (#350.1)
 ;350.1,.08   10 USER LOOKUP NAME       0;8 FREE TEXT
 ;350.1,.09   11 NEW ACTION TYPE        0;9 POINTER TO IB ACTION TYPE FILE (#350.1
 ;350.1,.1    12 PLACE ON HOLD          0;10 SET
 ;350.1,.11   13 BILLING GROUP          0;11 SET
 ;350.1,10    14 PARENT TRACE LOGIC     10;E1,245 MUMPS
 ;350.1,20    15 SET LOGIC              20;E1,245 MUMPS
 ;350.1,30    16 FULL PROFILE LOGIC     30;E1,245 MUMPS
 ;350.1,40    17 ELIGIBILITY LOGIC      40;E1,245 MUMPS
 ;
IBDDAT ; Fee Service to inactivate
 ;;CC URGENT CARE (OPT) CANCEL;CAN CCUC;CC URGENT CARE;BUSINESS OFFICE;CANCEL;CC URGENT CARE (OPT) CANCEL;CC URGENT CARE (OPT) UPDATE;;CC URGENT CARE (OPT) NEW;;OPT COPAY
 ;;CC URGENT CARE (OPT) UPDATE;UPD CCUC;CC URGENT CARE;BUSINESS OFFICE;UPDATE;CC URGENT CARE (OPT) CANCEL;CC URGENT CARE (OPT) UPDATE;;CC URGENT CARE (OPT) NEW;;OPT COPAY
 ;;CC URGENT CARE (OPT) NEW;CCUC CO;CC URGENT CARE;BUSINESS OFFICE;NEW;CC URGENT CARE (OPT) CANCEL;CC URGENT CARE (OPT) UPDATE;CC URGENT CARE;CC URGENT CARE (OPT) NEW;1;OPT COPAY;IBSL2
 ;;END
IBSET ; SET LOGIC 
 ;;CC (OPT) NEW;CC OPT COPAY
 ;;CHOICE (OPT) NEW;CHOICE OPT COPAY
 ;;CCN (OPT) NEW;CCN OPT COPAY
 ;;CC MTF (OPT) NEW;CC MTF OPT COPAY
 ;;END
UPDACT ; Update the Action Type Fields for the new Action Types
 ;
 N IBDATA,IBLOOP,IBIEN,IBACTNM
 N X,Y,DIE,DA,DR,DTOUT,DATA    ;^DIE variables
 D MES^XPDUTL("     -> Updating the Action Type Fields in file 350.1 ...")
 F IBLOOP=2:1 S IBDATA=$T(UPDDAT+IBLOOP) Q:IBDATA=" ;;END"  D
 . S IBACTNM=$P(IBDATA,";",3)   ;Name of the Action Type
 . ;Retrieve the IEN.
 . S IBIEN=$O(^IBE(350.1,"B",IBACTNM,""))
 . I IBIEN="" D MES^XPDUTL("          -> Action Type "_IBACTNM_" Is not in the Action Type file.") Q
 . ;File the update
 . S DR=".06///"_$P(IBDATA,";",4)_";"
 . S DR=DR_".07///"_$P(IBDATA,";",5)_";"
 . S DR=DR_".09///"_$P(IBDATA,";",6)
 . Q:DR=""
 . S DIE="^IBE(350.1,",DA=IBIEN
 . D ^DIE
 . K DR   ;Clear update array before next use
 D MES^XPDUTL("     -> Update completed ...")
 ;Clear the array
 Q
 ;
UPDDAT ;
 ;;Action Type;Cancellation Action;Update Action;New Action
 ;;CC URGENT CARE (OPT) CANCEL;CC URGENT CARE (OPT) CANCEL;CC URGENT CARE (OPT) UPDATE;CC URGENT CARE (OPT) NEW
 ;;CC URGENT CARE (OPT) UPDATE;CC URGENT CARE (OPT) CANCEL;CC URGENT CARE (OPT) UPDATE;CC URGENT CARE (OPT) NEW
 ;;CC URGENT CARE (OPT) NEW;CC URGENT CARE (OPT) CANCEL;CC URGENT CARE (OPT) UPDATE;CC URGENT CARE (OPT) NEW
 ;;END
NEWCREAS ; New Cancellation Reasons
 N LOOP,LIEN,IBDATA,IBCNNM
 N X,Y,DIE,DA,DR,DTOUT,DATA,IBDATAB
 ; 
 N CANIEN,UPDIEN,SVCIEN,CHGIEN
 ;
 ; Grab all of the entries to update
 D MES^XPDUTL("     -> Adding new Cancellation Reasons to the IB CHARGE REMOVE REASON file (350.3).")
 S Y=-1
 F LOOP=1:1 S IBDATA=$T(REASDAT+LOOP) Q:$P(IBDATA,";",3)="END"  D
 . S DR=""
 . ;Extract the new ACTION TYPE to be added.
 . ;Store in array for adding to the file (#350.1).
 . Q:IBDATA=""    ;go to next entry if Category is not to be updated.
 . ;
 . S IBCNNM=$P(IBDATA,";",3)
 . S LIEN=$O(^IBE(350.3,"B",IBCNNM,""))
 . ; File the update along with inactivate the ACTION TYPE
 . S DLAYGO=350.3,DIC="^IBE(350.3,",DIC(0)="L",X=IBCNNM
 . I '+LIEN D FILE^DICN S LIEN=+Y K DIC,DINUM,DLAYGO
 . S DR=".02////"_$P(IBDATA,";",4)   ; ABBREVIATION
 . S DR=DR_";.03////"_$P(IBDATA,";",5)  ; LIMIT
 . ;
 . S DIE="^IBE(350.3,",DA=LIEN
 . D ^DIE
 . ;<re-index new entry here>
 . S DA=LIEN,DIK="^IBE(350.3," D IX^DIK
 . K DR
 Q
 ;
 ;350.3,.01    3 NAME                   0;1 FREE TEXT (Required)
 ;350.3,.02    4 ABBREVIATION           0;2 FREE TEXT
 ;350.3,.03    5 LIMIT                  0;3 Code (3 - Generic)
 ;
REASDAT ; Fee Service to inactivate
 ;;UC - ENTERED IN ERROR;UCERROR;3
 ;;UC - CHANGE IN ELIGIBILITY;UCEC;3
 ;;END
 Q
 ;
SRVUPD ; Update the SERVICE/SECTION Pointer for any CC Action Type to either the MAS SERVICE POINTER IB Site Parameter
 ;       or to the PHARMACY Service (for RXs).
 ;
 N IBI,IBSTART,IBEND,IBSERVIC,IBSRV,IBDATA,IBPHARM,IBSTORE,IBERROR
 N X,Y,DIE,DA,DR,DTOUT,DATA
 ;
 ;Retrieve the first CC Action type IEN
 S IBSTART=$O(^IBE(350.1,"B","CHOICE (INPT) CANCEL",""))
 ;
 ;Retrieve the last Non Urgent Care CC Action Type
 S IBEND=$O(^IBE(350.1,"B","LTC CHOICE OPT RESPITE UPDATE",""))
 ;
 ;Get the MAS SERVICE IEN POINTER
 S IBSERVIC=$$GET1^DIQ(350.9,"1,",1.14,"I")
 ;
 ;Get the PHARMACY service IEN
 S IBERROR=""
 S IBPHARM=$$FIND1^DIC(49,,"X","PHARMACY","B",,"IBERROR")
 ;
 ;Loop through and update any entry that has a NULL Service to be the MAS SERVICE POINTER (1.14) in the IB SITE PARAMETER File (350.9)
 F IBI=IBSTART:1:IBEND D
 . S IBDATA=$G(^IBE(350.1,IBI,0)),IBSRV=$P(IBDATA,U,4)
 . S IBSTORE=$S($P(IBDATA,U,11)=5:IBPHARM,1:IBSERVIC)
 . S DR=".04////"_IBSTORE   ; Set the service
 . ;
 . S DIE="^IBE(350.1,",DA=IBI
 . D ^DIE
 . ;
 Q
