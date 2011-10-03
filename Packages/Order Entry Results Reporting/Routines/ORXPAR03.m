ORXPAR03 ; ; Dec 17, 1997@11:35:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;;
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
 G ^ORXPAR04
DATA ; parameter data
 ;;72,"VAL",5,0)
 ;;outpatient), discharge orders (if the patient is currently an inpatient).
 ;;72,"VAL",6,0)
 ;;The selected orders sheet will appear in the grid to the right.
 ;;73,"KEY")
 ;;ORWUH WHATSTHIS^lstOrdersWrite
 ;;73,"VAL")
 ;;-1
 ;;73,"VAL",1,0)
 ;;Write Orders
 ;;73,"VAL",2,0)
 ;; 
 ;;73,"VAL",3,0)
 ;;A list of categories for which orders may be written appears here.  To
 ;;73,"VAL",4,0)
 ;;write an order:
 ;;73,"VAL",5,0)
 ;; 
 ;;73,"VAL",6,0)
 ;;1)  Click on the category of order you wish to place.  (If you are unsure,
 ;;73,"VAL",7,0)
 ;;select 'Find...').
 ;;73,"VAL",8,0)
 ;; 
 ;;73,"VAL",9,0)
 ;;2)  A dialog will open allowing you to complete the order.
 ;;73,"VAL",10,0)
 ;; 
 ;;73,"VAL",11,0)
 ;;3)  You may continue selecting categories and placing orders until you
 ;;73,"VAL",12,0)
 ;;press 'Close'.
 ;;73,"VAL",13,0)
 ;; 
 ;;73,"VAL",14,0)
 ;;The orders will appear in the orders grid as they are placed.
 ;;74,"KEY")
 ;;ORWUH WHATSTHIS^lstProbPick
 ;;74,"VAL")
 ;;Problem Selection List
 ;;74,"VAL",1,0)
 ;;Add Problem
 ;;74,"VAL",2,0)
 ;; 
 ;;74,"VAL",3,0)
 ;;Common problems are listed here.  To add a new problem to the problem
 ;;74,"VAL",4,0)
 ;;list:
 ;;74,"VAL",5,0)
 ;; 
 ;;74,"VAL",6,0)
 ;;1)  Click on a problem in the 'Problem Selection List' list box.
 ;;74,"VAL",7,0)
 ;; 
 ;;74,"VAL",8,0)
 ;;2)  When the problem is selected, a dialog box will appear which allows
 ;;74,"VAL",9,0)
 ;;you to enter other information about the problem (date of onset,
 ;;74,"VAL",10,0)
 ;;acute/chronic, comments, etc.).
 ;;74,"VAL",11,0)
 ;; 
 ;;74,"VAL",12,0)
 ;;When finished, close the dialog box.  The problem will be shown on the
 ;;74,"VAL",13,0)
 ;;problem list.
 ;;75,"KEY")
 ;;ORWUH WHATSTHIS^lstRadList
 ;;75,"VAL")
 ;;-1
 ;;75,"VAL",1,0)
 ;;Radiology List
 ;;75,"VAL",2,0)
 ;; 
 ;;75,"VAL",3,0)
 ;;Pending and completed radiology procedures are listed here. To view the
 ;;75,"VAL",4,0)
 ;;text of the report, click on the procedure.
 ;;76,"KEY")
 ;;ORWUH WHATSTHIS^lstSpecList
 ;;76,"VAL")
 ;;-1
 ;;76,"VAL",1,0)
 ;;Specials List
 ;;76,"VAL",2,0)
 ;; 
 ;;76,"VAL",3,0)
 ;;Special tests and procedures are listed here (EKG's, Treadmill, etc.).
 ;;76,"VAL",4,0)
 ;;Click on the procedure to view the report.
 ;;77,"KEY")
 ;;ORWUH WHATSTHIS^lstSummList
 ;;77,"VAL")
 ;;-1
 ;;77,"VAL",1,0)
 ;;Summary List
 ;;77,"VAL",2,0)
 ;; 
 ;;77,"VAL",3,0)
 ;;A list of hospital discharge summaries and interim reports appears here.
 ;;77,"VAL",4,0)
 ;;To view the text of the summary, click on the title.
 ;;78,"KEY")
 ;;ORWUH WHATSTHIS^pnlPatient
 ;;78,"VAL")
 ;;-1
 ;;78,"VAL",1,0)
 ;;Patient Name
 ;;78,"VAL",2,0)
 ;; 
 ;;78,"VAL",3,0)
 ;;Click on the patient name to bring up a window of additional patient
 ;;78,"VAL",4,0)
 ;;demographics.
 ;;79,"KEY")
 ;;ORWUH WHATSTHIS^tabChart
 ;;79,"VAL")
 ;;-1
 ;;79,"VAL",1,0)
 ;;Chart Tabs
 ;;79,"VAL",2,0)
 ;; 
 ;;79,"VAL",3,0)
 ;;Selecting a tab opens the appropriate section of the chart.
 ;;87,"KEY")
 ;;ORB PROVIDER RECIPIENTS^LAB ORDER CANCELED
 ;;87,"VAL")
 ;;OT
 ;;88,"KEY")
 ;;ORB PROVIDER RECIPIENTS^CONSULT/REQUEST CANCEL/HOLD
 ;;88,"VAL")
 ;;O
 ;;89,"KEY")
 ;;ORB PROVIDER RECIPIENTS^CONSULT/REQUEST RESOLUTION
 ;;89,"VAL")
 ;;OAP
 ;;90,"KEY")
 ;;ORB PROVIDER RECIPIENTS^NPO DIET MORE THAN 72 HRS
 ;;90,"VAL")
 ;;O
 ;;91,"KEY")
 ;;ORB PROVIDER RECIPIENTS^ABNORMAL LAB RESULTS (ACTION)
 ;;91,"VAL")
 ;;OAPT
 ;;92,"KEY")
 ;;ORB PROVIDER RECIPIENTS^CRITICAL LAB RESULT (INFO)
 ;;92,"VAL")
 ;;OAPT
 ;;94,"KEY")
 ;;ORB PROVIDER RECIPIENTS^ADMISSION
 ;;94,"VAL")
 ;;APT
 ;;95,"KEY")
 ;;ORB PROVIDER RECIPIENTS^DECEASED PATIENT
 ;;95,"VAL")
 ;;APT
 ;;96,"KEY")
 ;;ORB PROVIDER RECIPIENTS^DISCHARGE
 ;;96,"VAL")
 ;;APT
 ;;97,"KEY")
 ;;ORB PROVIDER RECIPIENTS^TRANSFER FROM PSYCHIATRY
 ;;97,"VAL")
 ;;APT
 ;;98,"KEY")
 ;;ORB PROVIDER RECIPIENTS^UNSCHEDULED VISIT
 ;;98,"VAL")
 ;;APT
 ;;99,"KEY")
 ;;ORB PROVIDER RECIPIENTS^FLAGGED ORDERS
 ;;99,"VAL")
 ;;OAPT
 ;;100,"KEY")
 ;;ORB PROVIDER RECIPIENTS^ORDER REQUIRES CHART SIGNATURE
 ;;100,"VAL")
 ;;OAPT
 ;;101,"KEY")
 ;;ORB PROVIDER RECIPIENTS^SERVICE ORDER REQ CHART SIGN
 ;;101,"VAL")
 ;;OAPT
 ;;102,"KEY")
 ;;ORB PROVIDER RECIPIENTS^ORDER REQUIRES CO-SIGNATURE
 ;;102,"VAL")
 ;;OAPT
 ;;103,"KEY")
 ;;ORB PROVIDER RECIPIENTS^ORDER REQUIRES ELEC SIGNATURE
 ;;103,"VAL")
 ;;OAPT
 ;;105,"KEY")
 ;;ORB PROVIDER RECIPIENTS^ORDERER-FLAGGED RESULTS
 ;;105,"VAL")
 ;;O
 ;;106,"KEY")
 ;;ORB PROVIDER RECIPIENTS^STAT ORDER
 ;;106,"VAL")
 ;;T
 ;;107,"KEY")
 ;;ORB PROVIDER RECIPIENTS^STAT RESULTS
 ;;107,"VAL")
 ;;O
 ;;108,"KEY")
 ;;ORB PROVIDER RECIPIENTS^DNR EXPIRING
 ;;108,"VAL")
 ;;OAPT
 ;;109,"KEY")
 ;;ORB PROVIDER RECIPIENTS^NEW ORDER
 ;;109,"VAL")
 ;;T
 ;;110,"KEY")
 ;;ORB PROVIDER RECIPIENTS^MEDICATIONS EXPIRING
 ;;110,"VAL")
 ;;OAPT
 ;;111,"KEY")
 ;;ORB PROVIDER RECIPIENTS^UNVERIFIED MEDICATION ORDER
 ;;111,"VAL")
 ;;T
 ;;114,"KEY")
 ;;ORB PROVIDER RECIPIENTS^IMAGING RESULTS AMENDED
 ;;114,"VAL")
 ;;OAPT
 ;;115,"KEY")
 ;;ORB PROVIDER RECIPIENTS^ABNORMAL IMAGING RESULTS
 ;;115,"VAL")
 ;;OAPT
 ;;246,"KEY")
 ;;ORQQLR DATE RANGE OUTPT^1
 ;;246,"VAL")
 ;;30
 ;;265,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^10
 ;;265,"VAL")
 ;;M.A.S.
 ;;266,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^30
 ;;266,"VAL")
 ;;VITALS/MEASUREMENTS
 ;;267,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^40
 ;;267,"VAL")
 ;;NURSING
 ;;268,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^50
 ;;268,"VAL")
 ;;DIETETICS
 ;;269,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^60
 ;;269,"VAL")
 ;;IV MEDICATIONS
 ;;270,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^70
 ;;270,"VAL")
 ;;PHARMACY
 ;;271,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^80
 ;;271,"VAL")
 ;;IMAGING
 ;;272,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^90
 ;;272,"VAL")
 ;;CONSULTS
 ;;273,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^100
 ;;273,"VAL")
 ;;PROCEDURES
 ;;274,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^110
 ;;274,"VAL")
 ;;SURGERY
 ;;275,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^120
 ;;275,"VAL")
 ;;OTHER HOSPITAL SERVICES
 ;;276,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^35
 ;;276,"VAL")
 ;;ACTIVITY
 ;;283,"KEY")
 ;;ORWOR CATEGORY SEQUENCE^75
 ;;283,"VAL")
 ;;LABORATORY
 ;;303,"KEY")
 ;;ORQQCN DATE RANGE^1
 ;;303,"VAL")
 ;;730
 ;;304,"KEY")
 ;;ORB URGENCY^CONSULT/REQUEST CANCEL/HOLD
 ;;304,"VAL")
 ;;Moderate
 ;;305,"KEY")
 ;;ORB URGENCY^CONSULT/REQUEST RESOLUTION
 ;;305,"VAL")
 ;;Moderate
 ;;306,"KEY")
 ;;ORB URGENCY^NEW SERVICE CONSULT/REQUEST
 ;;306,"VAL")
 ;;Moderate
 ;;307,"KEY")
 ;;ORB URGENCY^NPO DIET MORE THAN 72 HRS
 ;;307,"VAL")
 ;;Moderate
 ;;308,"KEY")
 ;;ORB URGENCY^ABNORMAL LAB RESULTS (ACTION)
 ;;308,"VAL")
 ;;Moderate
 ;;309,"KEY")
 ;;ORB URGENCY^CRITICAL LAB RESULT (INFO)
