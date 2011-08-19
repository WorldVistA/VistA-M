ORXPAR01 ; ; Dec 17, 1997@11:35:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;;
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
 G ^ORXPAR02
DATA ; parameter data
 ;;3,"KEY")
 ;;ORXP TEST SINGLE PARAM^1
 ;;3,"VAL")
 ;;50
 ;;11,"KEY")
 ;;ORWUH WHATSTHIS^pnlPostings
 ;;11,"VAL")
 ;;-1
 ;;11,"VAL",1,0)
 ;;Postings
 ;;11,"VAL",2,0)
 ;; 
 ;;11,"VAL",3,0)
 ;;This button provides access to patient postings.  The single letter
 ;;11,"VAL",4,0)
 ;;abbreviation for each type of posting appears on the button, if such a
 ;;11,"VAL",5,0)
 ;;posting exists.
 ;;12,"KEY")
 ;;ORB PROCESSING FLAG^LAB RESULTS
 ;;12,"VAL")
 ;;Disabled
 ;;13,"KEY")
 ;;ORB PROCESSING FLAG^ORDER REQUIRES CHART SIGNATURE
 ;;13,"VAL")
 ;;Mandatory
 ;;14,"KEY")
 ;;ORB PROCESSING FLAG^FLAGGED ORDERS
 ;;14,"VAL")
 ;;Enabled
 ;;16,"KEY")
 ;;ORB PROCESSING FLAG^ORDER REQUIRES ELEC SIGNATURE
 ;;16,"VAL")
 ;;Mandatory
 ;;18,"KEY")
 ;;ORB PROCESSING FLAG^ABNORMAL LAB RESULTS (ACTION)
 ;;18,"VAL")
 ;;Disabled
 ;;22,"KEY")
 ;;ORB PROCESSING FLAG^ADMISSION
 ;;22,"VAL")
 ;;Enabled
 ;;23,"KEY")
 ;;ORB PROCESSING FLAG^UNSCHEDULED VISIT
 ;;23,"VAL")
 ;;Enabled
 ;;24,"KEY")
 ;;ORB PROCESSING FLAG^DECEASED PATIENT
 ;;24,"VAL")
 ;;Enabled
 ;;25,"KEY")
 ;;ORB PROCESSING FLAG^IMAGING PATIENT EXAMINED
 ;;25,"VAL")
 ;;Enabled
 ;;26,"KEY")
 ;;ORB PROCESSING FLAG^IMAGING RESULTS
 ;;26,"VAL")
 ;;Enabled
 ;;27,"KEY")
 ;;ORB PROCESSING FLAG^CONSULT/REQUEST RESOLUTION
 ;;27,"VAL")
 ;;Enabled
 ;;28,"KEY")
 ;;ORB PROCESSING FLAG^CRITICAL LAB RESULT (INFO)
 ;;28,"VAL")
 ;;Mandatory
 ;;29,"KEY")
 ;;ORB PROCESSING FLAG^ABNORMAL IMAGING RESULTS
 ;;29,"VAL")
 ;;Mandatory
 ;;30,"KEY")
 ;;ORB PROCESSING FLAG^IMAGING REQUEST CANCEL/HELD
 ;;30,"VAL")
 ;;Enabled
 ;;31,"KEY")
 ;;ORB PROCESSING FLAG^NEW SERVICE CONSULT/REQUEST
 ;;31,"VAL")
 ;;Enabled
 ;;32,"KEY")
 ;;ORB PROCESSING FLAG^SERVICE ORDER REQ CHART SIGN
 ;;32,"VAL")
 ;;Mandatory
 ;;33,"KEY")
 ;;ORB PROCESSING FLAG^CONSULT/REQUEST CANCEL/HOLD
 ;;33,"VAL")
 ;;Enabled
 ;;34,"KEY")
 ;;ORB PROCESSING FLAG^NPO DIET MORE THAN 72 HRS
 ;;34,"VAL")
 ;;Disabled
 ;;35,"KEY")
 ;;ORB PROCESSING FLAG^SITE-FLAGGED RESULTS
 ;;35,"VAL")
 ;;Disabled
 ;;36,"KEY")
 ;;ORB PROCESSING FLAG^ORDERER-FLAGGED RESULTS
 ;;36,"VAL")
 ;;Disabled
 ;;38,"KEY")
 ;;ORB PROCESSING FLAG^DISCHARGE
 ;;38,"VAL")
 ;;Disabled
 ;;39,"KEY")
 ;;ORB PROCESSING FLAG^TRANSFER FROM PSYCHIATRY
 ;;39,"VAL")
 ;;Disabled
 ;;40,"KEY")
 ;;ORB PROCESSING FLAG^ORDER REQUIRES CO-SIGNATURE
 ;;40,"VAL")
 ;;Disabled
 ;;42,"KEY")
 ;;ORB PROCESSING FLAG^SITE-FLAGGED ORDER
 ;;42,"VAL")
 ;;Disabled
 ;;43,"KEY")
 ;;ORB PROCESSING FLAG^LAB ORDER CANCELED
 ;;43,"VAL")
 ;;Disabled
 ;;44,"KEY")
 ;;ORB PROCESSING FLAG^STAT ORDER
 ;;44,"VAL")
 ;;Disabled
 ;;45,"KEY")
 ;;ORB PROCESSING FLAG^STAT RESULTS
 ;;45,"VAL")
 ;;Disabled
 ;;46,"KEY")
 ;;ORB PROCESSING FLAG^DNR EXPIRING
 ;;46,"VAL")
 ;;Disabled
 ;;47,"KEY")
 ;;ORB PROCESSING FLAG^FREE TEXT
 ;;47,"VAL")
 ;;Disabled
 ;;48,"KEY")
 ;;ORB PROCESSING FLAG^MEDICATIONS EXPIRING
 ;;48,"VAL")
 ;;Disabled
 ;;49,"KEY")
 ;;ORB PROCESSING FLAG^UNVERIFIED MEDICATION ORDER
 ;;49,"VAL")
 ;;Disabled
 ;;50,"KEY")
 ;;ORB PROCESSING FLAG^NEW ORDER
 ;;50,"VAL")
 ;;Disabled
 ;;51,"KEY")
 ;;ORWUH WHATSTHIS^memLabsData
 ;;51,"VAL")
 ;;-1
 ;;51,"VAL",1,0)
 ;;Labs
 ;;51,"VAL",2,0)
 ;; 
 ;;51,"VAL",3,0)
 ;;Lab results are listed in spreadsheet format.  To look for specific tests,
 ;;51,"VAL",4,0)
 ;;or customize the report, use the 'View' menu.
 ;;52,"KEY")
 ;;ORWUH WHATSTHIS^grdMedsData
 ;;52,"VAL")
 ;;-1
 ;;52,"VAL",1,0)
 ;;Medications List
 ;;52,"VAL",2,0)
 ;; 
 ;;52,"VAL",3,0)
 ;;Current medications appear here.  To change a medication:
 ;;52,"VAL",4,0)
 ;; 
 ;;52,"VAL",5,0)
 ;;1)  Click on the medication to select it.
 ;;52,"VAL",6,0)
 ;; 
 ;;52,"VAL",7,0)
 ;;2)  Choose an action from the 'Action' menu, such as 'Change' or
 ;;52,"VAL",8,0)
 ;;'Discontinue'.
 ;;52,"VAL",9,0)
 ;; 
 ;;52,"VAL",10,0)
 ;;3)  A dialog will appear, allowing you to complete the change.You may
 ;;52,"VAL",11,0)
 ;;change the presentation of the medications by selecting items from the
 ;;52,"VAL",12,0)
 ;;'View' menu.
 ;;52,"VAL",13,0)
 ;; 
 ;;52,"VAL",14,0)
 ;;You may change the presentation of the medications by selecting items from
 ;;52,"VAL",15,0)
 ;;the 'View' menu.
 ;;53,"KEY")
 ;;ORWUH WHATSTHIS^grdOrdersData
 ;;53,"VAL")
 ;;-1
 ;;53,"VAL",1,0)
 ;;Orders List
 ;;53,"VAL",2,0)
 ;; 
 ;;53,"VAL",3,0)
 ;;A list of orders appears  here.  To change an order:
 ;;53,"VAL",4,0)
 ;; 
 ;;53,"VAL",5,0)
 ;;1)  Click on the order to select it.
 ;;53,"VAL",6,0)
 ;; 
 ;;53,"VAL",7,0)
 ;;2)  Choose an action from the 'Action' menu, such as 'Change' or
 ;;53,"VAL",8,0)
 ;;'Discontinue'.
 ;;53,"VAL",9,0)
 ;; 
 ;;53,"VAL",10,0)
 ;;3)  A dialog will appear, allowing you to complete the change.
 ;;53,"VAL",11,0)
 ;; 
 ;;53,"VAL",12,0)
 ;;You may change the presentation of the orders by selecting items from the
 ;;53,"VAL",13,0)
 ;;'View' menu.
 ;;54,"KEY")
 ;;ORWUH WHATSTHIS^grdProbData
 ;;54,"VAL")
 ;;-1
 ;;54,"VAL",1,0)
 ;;Problem List
 ;;54,"VAL",2,0)
 ;; 
 ;;54,"VAL",3,0)
 ;;The problem list appears here.  To change a problem on the problem list:
 ;;54,"VAL",4,0)
 ;; 
 ;;54,"VAL",5,0)
 ;;1)  Click on the problem to select it.
 ;;54,"VAL",6,0)
 ;; 
 ;;54,"VAL",7,0)
 ;;2)  Choose an action from the 'Action' menu, such as 'Remove' or
 ;;54,"VAL",8,0)
 ;;'Inactivate'.
 ;;54,"VAL",9,0)
 ;; 
 ;;54,"VAL",10,0)
 ;;You may change the presentation of the problem list by selecting items
 ;;54,"VAL",11,0)
 ;;from the 'View' menu.
 ;;55,"KEY")
 ;;ORWUH WHATSTHIS^lstCAllergies
 ;;55,"VAL")
 ;;-1
 ;;55,"VAL",1,0)
 ;;Allergies
 ;;55,"VAL",2,0)
 ;; 
 ;;55,"VAL",3,0)
 ;;Known allergies are listed here.  To see more information about the
 ;;55,"VAL",4,0)
 ;;allergy:
 ;;55,"VAL",5,0)
 ;; 
 ;;55,"VAL",6,0)
 ;;1)  Click on the allergy to select it.
 ;;55,"VAL",7,0)
 ;; 
 ;;55,"VAL",8,0)
 ;;2)  Choose 'View | Details...' from the menu.
 ;;55,"VAL",9,0)
 ;; 
 ;;55,"VAL",10,0)
 ;;A window with additional information about the allergy will appear.
 ;;56,"KEY")
 ;;ORWUH WHATSTHIS^lstCLabs
 ;;56,"VAL")
 ;;-1
 ;;56,"VAL",1,0)
 ;;Lab Tests
 ;;56,"VAL",2,0)
 ;; 
 ;;56,"VAL",3,0)
 ;;Recently ordered lab tests appear in this list.  To see results from these
 ;;56,"VAL",4,0)
 ;;lab tests:
 ;;56,"VAL",5,0)
 ;; 
 ;;56,"VAL",6,0)
 ;;1)  Click on a lab test to select it.
 ;;56,"VAL",7,0)
 ;; 
 ;;56,"VAL",8,0)
 ;;2)  Choose 'View | Details...' from the menu.
 ;;56,"VAL",9,0)
 ;; 
 ;;56,"VAL",10,0)
 ;;A window with results from the selected lab test will appear.
 ;;57,"KEY")
 ;;ORWUH WHATSTHIS^frmCover.lstMeds
 ;;57,"VAL")
 ;;Active Medications
 ;;57,"VAL",1,0)
 ;;A brief view of currently active medications is listed here.  To see
