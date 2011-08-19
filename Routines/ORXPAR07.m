ORXPAR07 ; ; Dec 17, 1997@11:35:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;;
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
 G ^ORXPAR08
DATA ; parameter data
 ;;885,"VAL",26,0)
 ;;any time during a session by this method. The defined filters remain in 
 ;;885,"VAL",27,0)
 ;;effect for the duration of the session or until changed again. To quickly
 ;;885,"VAL",28,0)
 ;;return to the user's default or preferred view, Click the Preferred View
 ;;885,"VAL",29,0)
 ;;button.
 ;;886,"KEY")
 ;;ORWUH WHATSTHIS^wgProbData
 ;;886,"VAL")
 ;;Patient Problem List
 ;;886,"VAL",1,0)
 ;;Patient Problem List
 ;;886,"VAL",2,0)
 ;; 
 ;;886,"VAL",3,0)
 ;;This grid displays the current patient's problems. It may be 
 ;;886,"VAL",4,0)
 ;;filtered to display All problems, Active Problems, Inactive Problems
 ;;886,"VAL",5,0)
 ;;or Removed problems by selecting the appropriate item from the 
 ;;886,"VAL",6,0)
 ;;View menu. The ability to use certain display filters may be 
 ;;886,"VAL",7,0)
 ;;restricted for some users.
 ;;886,"VAL",8,0)
 ;; 
 ;;886,"VAL",9,0)
 ;;The actions Change (or Edit), Inactivate, Verify, Annotate, Remove 
 ;;886,"VAL",10,0)
 ;;and Restore may be selected from the upper Action menu. They are also 
 ;;886,"VAL",11,0)
 ;;available via a popup menu that appears with a right mouse button click. 
 ;;886,"VAL",12,0)
 ;;As is the case for display filters, some actions are restricted for
 ;;886,"VAL",13,0)
 ;;certain users. If an action is restricted, the user will not be able to
 ;;886,"VAL",14,0)
 ;;select it.
 ;;886,"VAL",15,0)
 ;; 
 ;;886,"VAL",16,0)
 ;;NOTE: A PROBLEM MUST BE SELECTED BEFORE ANY ACTIONS ARE AVAILABLE. 
 ;;886,"VAL",17,0)
 ;;If you select the Action Menu, or right click and find all options grayed, 
 ;;886,"VAL",18,0)
 ;;then you have not selected a problem to act on. Select a problem from the 
 ;;886,"VAL",19,0)
 ;;list by clicking on it.
 ;;886,"VAL",20,0)
 ;; 
 ;;886,"VAL",21,0)
 ;;As a convenience, you may double click on a problem in the list to Change 
 ;;886,"VAL",22,0)
 ;;(Edit) it.
 ;;886,"VAL",23,0)
 ;; 
 ;;886,"VAL",24,0)
 ;;The Change, Annotate, Remove and Restore options cause a form to appear on 
 ;;886,"VAL",25,0)
 ;;the right. Use the form to further characterize and describe the problem.
 ;;886,"VAL",26,0)
 ;; 
 ;;886,"VAL",27,0)
 ;;The inactivate action will either cause a list item to disappear (this
 ;;886,"VAL",28,0)
 ;;will happen in the case that the display filter is set to Active only) or
 ;;886,"VAL",29,0)
 ;;an 'I' indicating its new status will appear next to it on the list.
 ;;886,"VAL",30,0)
 ;; 
 ;;886,"VAL",31,0)
 ;;The Verify action will cause the unverified indicator ('u') to be removed 
 ;;886,"VAL",32,0)
 ;;from the line.
 ;;887,"KEY")
 ;;ORWUH WHATSTHIS^lstCatPick
 ;;887,"VAL")
 ;;Problem Category Selection
 ;;887,"VAL",1,0)
 ;;Problem Category Selection 
 ;;887,"VAL",2,0)
 ;; 
 ;;887,"VAL",3,0)
 ;;Problem ctegories are comprised of one or more related problems. Typically
 ;;887,"VAL",4,0)
 ;;they are defined for a particular user or department.
 ;;887,"VAL",5,0)
 ;; 
 ;;887,"VAL",6,0)
 ;;Select a category from the list by clicking on it. This action will cause
 ;;887,"VAL",7,0)
 ;;the constituent problems to appear in the Problem Selection List below.
 ;;887,"VAL",8,0)
 ;;Individual problems from the Problem Selection List may be selected for
 ;;887,"VAL",9,0)
 ;;addition to the patient's list.
 ;;893,"KEY")
 ;;ORB PROCESSING FLAG^IMAGING RESULTS AMENDED
 ;;893,"VAL")
 ;;Disabled
 ;;895,"KEY")
 ;;ORB PROCESSING FLAG^STAT IMAGING REQUEST
 ;;895,"VAL")
 ;;Disabled
 ;;896,"KEY")
 ;;ORB PROCESSING FLAG^URGENT IMAGING REQUEST
 ;;896,"VAL")
 ;;Disabled
 ;;900,"KEY")
 ;;ORK PROCESSING FLAG^LAB ORDER FREQ RESTRICTIONS
 ;;900,"VAL")
 ;;Enabled
 ;;901,"KEY")
 ;;ORK CLINICAL DANGER LEVEL^LAB ORDER FREQ RESTRICTIONS
 ;;901,"VAL")
 ;;Moderate
 ;;945,"KEY")
 ;;ORQQLR DATE RANGE INPT^1
 ;;945,"VAL")
 ;;2
 ;;946,"KEY")
 ;;ORPF LAST ORDER PURGED^1
 ;;946,"VAL")
 ;;
 ;;949,"KEY")
 ;;ORQQPX SEARCH ITEMS^1
 ;;949,"VAL")
 ;;VA-INFLUENZA VACCINE
 ;;950,"KEY")
 ;;ORQQPX SEARCH ITEMS^2
 ;;950,"VAL")
 ;;VA-PNEUMOVAX
 ;;951,"KEY")
 ;;ORQQPX SEARCH ITEMS^3
 ;;951,"VAL")
 ;;VA-BREAST EXAM
 ;;952,"KEY")
 ;;ORQQPX SEARCH ITEMS^4
 ;;952,"VAL")
 ;;VA-DIGITAL RECTAL (PROSTATE) EXAM
 ;;953,"KEY")
 ;;ORQQPX SEARCH ITEMS^5
 ;;953,"VAL")
 ;;VA-MAMMOGRAM
 ;;954,"KEY")
 ;;ORQQPX SEARCH ITEMS^6
 ;;954,"VAL")
 ;;VA-FLEXISIGMOIDOSCOPY
 ;;955,"KEY")
 ;;ORQQPX SEARCH ITEMS^7
 ;;955,"VAL")
 ;;VA-PAP SMEAR
 ;;956,"KEY")
 ;;ORQQPX SEARCH ITEMS^8
 ;;956,"VAL")
 ;;VA-TOBACCO EDUCATION
 ;;957,"KEY")
 ;;ORQQPX SEARCH ITEMS^9
 ;;957,"VAL")
 ;;VA-BREAST SELF EXAM EDUCATION
 ;;958,"KEY")
 ;;ORQQPX SEARCH ITEMS^10
 ;;958,"VAL")
 ;;VA-ADVANCED DIRECTIVES EDUCATION
 ;;1000,"KEY")
 ;;ORB DELETE MECHANISM^IMAGING RESULTS AMENDED
 ;;1000,"VAL")
 ;;Individual Recipient
 ;;1003,"KEY")
 ;;ORB PROVIDER RECIPIENTS^FOOD/DRUG INTERACTION
 ;;1003,"VAL")
 ;;
 ;;1005,"KEY")
 ;;ORB URGENCY^IMAGING RESULTS AMENDED
 ;;1005,"VAL")
 ;;Moderate
 ;;1007,"KEY")
 ;;ORB URGENCY^STAT IMAGING REQUEST
 ;;1007,"VAL")
 ;;Moderate
 ;;1008,"KEY")
 ;;ORB URGENCY^URGENT IMAGING REQUEST
 ;;1008,"VAL")
 ;;Moderate
 ;;1009,"KEY")
 ;;ORK CLINICAL DANGER LEVEL^GLUCOPHAGE-CONTRAST MEDIA
 ;;1009,"VAL")
 ;;High
 ;;1011,"KEY")
 ;;ORK CLINICAL DANGER LEVEL^ERROR MESSAGE
 ;;1011,"VAL")
 ;;Low
 ;;1012,"KEY")
 ;;ORK PROCESSING FLAG^ERROR MESSAGE
 ;;1012,"VAL")
 ;;Enabled
 ;;1015,"KEY")
 ;;ORB ARCHIVE PERIOD^ABNORMAL IMAGING RESULTS
 ;;1015,"VAL")
 ;;30
 ;;1016,"KEY")
 ;;ORB ARCHIVE PERIOD^ABNORMAL LAB RESULTS (ACTION)
 ;;1016,"VAL")
 ;;30
 ;;1017,"KEY")
 ;;ORB ARCHIVE PERIOD^ADMISSION
 ;;1017,"VAL")
 ;;30
 ;;1018,"KEY")
 ;;ORB ARCHIVE PERIOD^CONSULT/REQUEST CANCEL/HOLD
 ;;1018,"VAL")
 ;;30
 ;;1019,"KEY")
 ;;ORB ARCHIVE PERIOD^CONSULT/REQUEST RESOLUTION
 ;;1019,"VAL")
 ;;30
 ;;1021,"KEY")
 ;;ORB ARCHIVE PERIOD^CRITICAL LAB RESULT (INFO)
 ;;1021,"VAL")
 ;;30
 ;;1022,"KEY")
 ;;ORB ARCHIVE PERIOD^DECEASED PATIENT
 ;;1022,"VAL")
 ;;30
 ;;1023,"KEY")
 ;;ORB ARCHIVE PERIOD^DISCHARGE
 ;;1023,"VAL")
 ;;30
 ;;1024,"KEY")
 ;;ORB ARCHIVE PERIOD^DNR EXPIRING
 ;;1024,"VAL")
 ;;30
 ;;1025,"KEY")
 ;;ORB ARCHIVE PERIOD^ERROR MESSAGE
 ;;1025,"VAL")
 ;;30
 ;;1026,"KEY")
 ;;ORB ARCHIVE PERIOD^FLAGGED ORDERS
 ;;1026,"VAL")
 ;;30
 ;;1027,"KEY")
 ;;ORB ARCHIVE PERIOD^FOOD/DRUG INTERACTION
 ;;1027,"VAL")
 ;;30
 ;;1028,"KEY")
 ;;ORB ARCHIVE PERIOD^FREE TEXT
 ;;1028,"VAL")
 ;;30
 ;;1030,"KEY")
 ;;ORB ARCHIVE PERIOD^IMAGING PATIENT EXAMINED
 ;;1030,"VAL")
 ;;30
 ;;1031,"KEY")
 ;;ORB ARCHIVE PERIOD^IMAGING REQUEST CANCEL/HELD
 ;;1031,"VAL")
 ;;30
 ;;1032,"KEY")
 ;;ORB ARCHIVE PERIOD^IMAGING RESULTS
 ;;1032,"VAL")
 ;;30
