IB20P598 ;ALB/MJF - UPDATE MCCR UTILITY /SPECIALTY ;9/22/17
 ;;2.0;INTEGRATED BILLING;**598**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
MAIN ;order of operators
 N U S U="^"
 D CREATE,POINT
 Q
 ;
CREATE ;Adds/fills records from RECORDS label to 399.1 file
 N DLAYGO,DIC,DIE,DA,DD,DO,DR,X,Y,IBCOUNT,IBREC,IBNAME,IBCODE,IBABBRE,IBBED,IBIEN
 D MES^XPDUTL("Adding new records to 399.1..")
 F IBCOUNT=1:1 S IBREC=$P($T(RECORDS+IBCOUNT),";;",2) Q:IBREC=""  D
 .;Breaking the record into vars
 .S IBNAME=$P(IBREC,U,1),IBCODE=$P(IBREC,U,2),IBABBRE=$P(IBREC,U,3),IBBED=$P(IBREC,U,4)
 .;check to see if the record exists before adding
 .I IBNAME="" Q 
 .S IBIEN=$O(^DGCR(399.1,"B",IBNAME,""))
 .I IBNAME=$$GET1^DIQ(399.1,IBIEN,.01) D MES^XPDUTL("It appears this record "_IBNAME_" already exists.") Q  ;Quit if this record has already been created
 .;Add the record to 399.1
 .K DD,DO S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=IBNAME D FILE^DICN K DIC,DLAYGO I Y<1 K X,Y Q
 .;Stuff the fields               02 code,         03 abbre,         12 bed
 .S DA=+Y,DIE="^DGCR(399.1,",DR=".02///"_IBCODE_";.03///"_IBABBRE_";.12///"_IBBED D ^DIE K DIE,DA,DR,X,Y
 .D MES^XPDUTL("Record "_IBNAME_" updated")
 Q
 ;
POINT ;Adjust pointers in relevant specialty records
 N DA,DIE,DR,X,Y,IBREC,IBCOUNT,IBNAME,IBIEN
 D MES^XPDUTL("Updating NH HOSPICE and HOSPICE FOR ACUTE CARE pointers..")
 ;Getting the relevant specialty records
 F IBCOUNT=1:1 S IBREC=$P($T(RECORDS+IBCOUNT),";;",2) Q:IBREC=""  D
 .;Piece out the name
 .S IBNAME=$P(IBREC,U,1)
 .I IBNAME="" Q
 .;Get the IEN
 .S IBIEN=$O(^DIC(42.4,"B",IBNAME,"")) I IBIEN="" Q
 .;Check the IEN for validation
 .I IBNAME'=$$GET1^DIQ(42.4,IBIEN,.01) D MES^XPDUTL("Record "_IBNAME_" couldn't be verified") Q  ; quit if this record cannot be verified
 .;Set the specialty record's pointers to the new MCCR fields
 .S DA=IBIEN,DIE="^DIC(42.4,",DR="5///"_IBNAME D ^DIE
 .K DIE,DA,DR,X,Y
 .D MES^XPDUTL(IBNAME_" pointer updated")
 Q
 ;
RECORDS ;records to be added name, code, abbreviation, bed
 ;;NH HOSPICE^10^NH HOSPICE^YES
 ;;HOSPICE FOR ACUTE CARE^1^HOSPICE GEN MED^YES
 ;
