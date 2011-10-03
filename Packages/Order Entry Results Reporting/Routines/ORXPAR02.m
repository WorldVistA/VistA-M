ORXPAR02 ; ; Dec 17, 1997@11:35:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;;
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
 G ^ORXPAR03
DATA ; parameter data
 ;;57,"VAL",2,0)
 ;;further details for any of the meds, click the name of the medication.
 ;;58,"KEY")
 ;;ORWUH WHATSTHIS^lstCNoK
 ;;58,"VAL")
 ;;-1
 ;;58,"VAL",1,0)
 ;;Next of Kin
 ;;58,"VAL",2,0)
 ;; 
 ;;58,"VAL",3,0)
 ;;This lists the name and address of the next of kin.
 ;;59,"KEY")
 ;;ORWUH WHATSTHIS^lstCNotif
 ;;59,"VAL")
 ;;-1
 ;;59,"VAL",1,0)
 ;;Notifications
 ;;59,"VAL",2,0)
 ;; 
 ;;59,"VAL",3,0)
 ;;A list of active notifications or alerts appears here.  To view the
 ;;59,"VAL",4,0)
 ;;notification in detail, and potentially take action on it:
 ;;59,"VAL",5,0)
 ;; 
 ;;59,"VAL",6,0)
 ;;1) Click on the notification to select it.
 ;;59,"VAL",7,0)
 ;; 
 ;;59,"VAL",8,0)
 ;;2)  Choose 'View | Details...' from the menu.
 ;;59,"VAL",9,0)
 ;; 
 ;;59,"VAL",10,0)
 ;;The window that appears depends on the notification selected.
 ;;60,"KEY")
 ;;ORWUH WHATSTHIS^lstCPostings
 ;;60,"VAL")
 ;;-1
 ;;60,"VAL",1,0)
 ;;Postings
 ;;60,"VAL",2,0)
 ;; 
 ;;60,"VAL",3,0)
 ;;A list of active crises/warning notes and directives appears here.  To see
 ;;60,"VAL",4,0)
 ;;the full text of the note:
 ;;60,"VAL",5,0)
 ;; 
 ;;60,"VAL",6,0)
 ;;1)  Click on the note to select it.
 ;;60,"VAL",7,0)
 ;; 
 ;;60,"VAL",8,0)
 ;;2)  Choose 'View | Details...' from the menu.
 ;;60,"VAL",9,0)
 ;; 
 ;;60,"VAL",10,0)
 ;;A window with the full text of the note will appear.
 ;;61,"KEY")
 ;;ORWUH WHATSTHIS^lstCProblems
 ;;61,"VAL")
 ;;-1
 ;;61,"VAL",1,0)
 ;;Problems
 ;;61,"VAL",2,0)
 ;; 
 ;;61,"VAL",3,0)
 ;;A thumbnail view of the problem list is presented here.  To  view a
 ;;61,"VAL",4,0)
 ;;problem in greater detail:
 ;;61,"VAL",5,0)
 ;; 
 ;;61,"VAL",6,0)
 ;;1)  Click on the problem to select it.
 ;;61,"VAL",7,0)
 ;; 
 ;;61,"VAL",8,0)
 ;;2) Choose 'View | Details...' from the menu.
 ;;61,"VAL",9,0)
 ;; 
 ;;61,"VAL",10,0)
 ;;A window containing detailed information about the selected problem will
 ;;61,"VAL",11,0)
 ;;appear.
 ;;62,"KEY")
 ;;ORWUH WHATSTHIS^lstCVisits
 ;;62,"VAL")
 ;;-1
 ;;62,"VAL",1,0)
 ;;Visits
 ;;62,"VAL",2,0)
 ;; 
 ;;62,"VAL",3,0)
 ;;A list of clinic visits and hospital admissions appears here.  To see the
 ;;62,"VAL",4,0)
 ;;progress note from a clinic visit or discharge summary from an admission:
 ;;62,"VAL",5,0)
 ;; 
 ;;62,"VAL",6,0)
 ;;1)  Click on the visit to select it.
 ;;62,"VAL",7,0)
 ;; 
 ;;62,"VAL",8,0)
 ;;2)  Choose 'View | Details...' from the menu.
 ;;62,"VAL",9,0)
 ;; 
 ;;62,"VAL",10,0)
 ;;A window with the note or summary will appear.
 ;;63,"KEY")
 ;;ORWUH WHATSTHIS^memCsltData
 ;;63,"VAL")
 ;;-1
 ;;63,"VAL",1,0)
 ;;Consult Report
 ;;63,"VAL",2,0)
 ;; 
 ;;63,"VAL",3,0)
 ;;The text of a consult report is listed here.
 ;;64,"KEY")
 ;;ORWUH WHATSTHIS^memNotesData
 ;;64,"VAL")
 ;;-1
 ;;64,"VAL",1,0)
 ;;Progress Note
 ;;64,"VAL",2,0)
 ;; 
 ;;64,"VAL",3,0)
 ;;Progress notes may be viewed and written here.  When writing progress
 ;;64,"VAL",4,0)
 ;;notes, you may use the 'Action' menu to:
 ;;64,"VAL",5,0)
 ;; 
 ;;64,"VAL",6,0)
 ;;1)  Link the note to a problem.
 ;;64,"VAL",7,0)
 ;; 
 ;;64,"VAL",8,0)
 ;;2)  Place orders.
 ;;64,"VAL",9,0)
 ;; 
 ;;64,"VAL",10,0)
 ;;3)  View recent lab results to include into the note.
 ;;64,"VAL",11,0)
 ;; 
 ;;64,"VAL",12,0)
 ;;The edit menu may be used to copy other places in the chart which many
 ;;64,"VAL",13,0)
 ;;then be pasted into a note.
 ;;65,"KEY")
 ;;ORWUH WHATSTHIS^memRadData
 ;;65,"VAL")
 ;;-1
 ;;65,"VAL",1,0)
 ;;Radiology Report
 ;;65,"VAL",2,0)
 ;; 
 ;;65,"VAL",3,0)
 ;;The text of a radiology report is listed here.
 ;;66,"KEY")
 ;;ORWUH WHATSTHIS^memSpecData
 ;;66,"VAL")
 ;;-1
 ;;66,"VAL",1,0)
 ;;Specials Report
 ;;66,"VAL",2,0)
 ;; 
 ;;66,"VAL",3,0)
 ;;The text of reports is displayed here.
 ;;67,"KEY")
 ;;ORWUH WHATSTHIS^memSummData
 ;;67,"VAL")
 ;;-1
 ;;67,"VAL",1,0)
 ;;Summary
 ;;67,"VAL",2,0)
 ;; 
 ;;67,"VAL",3,0)
 ;;The text of the selected discharge summary appears here.
 ;;68,"KEY")
 ;;ORWUH WHATSTHIS^lstCsltList
 ;;68,"VAL")
 ;;-1
 ;;68,"VAL",1,0)
 ;;Consult List
 ;;68,"VAL",2,0)
 ;; 
 ;;68,"VAL",3,0)
 ;;A list of pending and completed consults is listed here.  To view a
 ;;68,"VAL",4,0)
 ;;consult, click on the title.
 ;;69,"KEY")
 ;;ORWUH WHATSTHIS^outMedsSheet
 ;;69,"VAL")
 ;;-1
 ;;69,"VAL",1,0)
 ;;Med Profile
 ;;69,"VAL",2,0)
 ;; 
 ;;69,"VAL",3,0)
 ;;The selected item in this list determines what will be seen in the grid to
 ;;69,"VAL",4,0)
 ;;the right.  You may toggle between inpatient and outpatient medication
 ;;69,"VAL",5,0)
 ;;profiles.  'Scratch Pad' is a place were new med orders may be composed.
 ;;69,"VAL",6,0)
 ;;They will not be placed, however, until they are moved to an inpatient or
 ;;69,"VAL",7,0)
 ;;outpatient sheet.
 ;;70,"KEY")
 ;;ORWUH WHATSTHIS^lstMedsWrite
 ;;70,"VAL")
 ;;-1
 ;;70,"VAL",1,0)
 ;;Write Prescriptions
 ;;70,"VAL",2,0)
 ;; 
 ;;70,"VAL",3,0)
 ;;This list contains commonly prescribed medications or VA drug classes
 ;;70,"VAL",4,0)
 ;;(depending on your selected preference).  To write a new medication order:
 ;;70,"VAL",5,0)
 ;; 
 ;;70,"VAL",6,0)
 ;;1)  Click on a medication or 'other'.
 ;;70,"VAL",7,0)
 ;; 
 ;;70,"VAL",8,0)
 ;;2)  Upon selecting an item from the list, a dialog will appear that will
 ;;70,"VAL",9,0)
 ;;allow you to enter instructions for the medication.
 ;;70,"VAL",10,0)
 ;; 
 ;;70,"VAL",11,0)
 ;;When closing this dialog, the new medication will be placed on the current
 ;;70,"VAL",12,0)
 ;;medications grid.
 ;;71,"KEY")
 ;;ORWUH WHATSTHIS^lstNotesList
 ;;71,"VAL")
 ;;-1
 ;;71,"VAL",1,0)
 ;;Notes List
 ;;71,"VAL",2,0)
 ;; 
 ;;71,"VAL",3,0)
 ;;Titles of existing progress notes are listed here.  To view a progress
 ;;71,"VAL",4,0)
 ;;note, simply click on the title.  To write a new progress note:
 ;;71,"VAL",5,0)
 ;; 
 ;;71,"VAL",6,0)
 ;;1) Click on 'New Progress Note', at the very top of the list.
 ;;71,"VAL",7,0)
 ;; 
 ;;71,"VAL",8,0)
 ;;2)  When 'New Progress Note' is clicked, a list of boilerplates appears.
 ;;71,"VAL",9,0)
 ;;You may select a boilerplate or just begin typing.
 ;;71,"VAL",10,0)
 ;; 
 ;;71,"VAL",11,0)
 ;;3)  To sign the progress note, choose 'Action | Sign' from the menu.
 ;;71,"VAL",12,0)
 ;; 
 ;;71,"VAL",13,0)
 ;;The set of notes listed may be changed by choosing items from the 'View'
 ;;71,"VAL",14,0)
 ;;menu.
 ;;72,"KEY")
 ;;ORWUH WHATSTHIS^outOrdersSheet
 ;;72,"VAL")
 ;;-1
 ;;72,"VAL",1,0)
 ;;Order Sheet
 ;;72,"VAL",2,0)
 ;; 
 ;;72,"VAL",3,0)
 ;;A list of possible order's sheets appears here. You may choose from
 ;;72,"VAL",4,0)
 ;;current orders, admission orders (if the patient is currently an
