ORXPAR06 ; ; Dec 17, 1997@11:35:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;;
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
 G ^ORXPAR07
DATA ; parameter data
 ;;786,"VAL")
 ;;OR GXOXGN VENTILATOR
 ;;787,"KEY")
 ;;ORWD PTCARE RESP INPT^1
 ;;787,"VAL")
 ;;OR GXRESP TCDB
 ;;788,"KEY")
 ;;ORWD PTCARE RESP INPT^2
 ;;788,"VAL")
 ;;OR GXRESP CHEST PT
 ;;789,"KEY")
 ;;ORWD PTCARE RESP INPT^3
 ;;789,"VAL")
 ;;OR GXRESP SUCTION
 ;;790,"KEY")
 ;;ORWD PTCARE RESP INPT^4
 ;;790,"VAL")
 ;;OR GXRESP TRACH CARE
 ;;791,"KEY")
 ;;ORWD PTCARE SKIN INPT^1
 ;;791,"VAL")
 ;;OR GXSKIN COLD PACKS
 ;;792,"KEY")
 ;;ORWD PTCARE SKIN INPT^2
 ;;792,"VAL")
 ;;OR GXSKIN WARM PACKS
 ;;793,"KEY")
 ;;ORWD PTCARE SKIN INPT^3
 ;;793,"VAL")
 ;;OR GXSKIN WARM SOAKS
 ;;794,"KEY")
 ;;ORWD PTCARE SKIN INPT^4
 ;;794,"VAL")
 ;;OR GXSKIN AIR MATTRESS
 ;;795,"KEY")
 ;;ORWD PTCARE SKIN INPT^5
 ;;795,"VAL")
 ;;OR GXSKIN WATER MATTRESS
 ;;796,"KEY")
 ;;ORWD PTCARE SKIN INPT^6
 ;;796,"VAL")
 ;;OR GXSKIN SHEEPSKIN
 ;;797,"KEY")
 ;;ORWD PTCARE TUBES INPT^1
 ;;797,"VAL")
 ;;OR GXTUBE COLOSTOMY
 ;;798,"KEY")
 ;;ORWD PTCARE TUBES INPT^2
 ;;798,"VAL")
 ;;OR GXTUBE INDWELLING URINARY CATH
 ;;799,"KEY")
 ;;ORWD PTCARE TUBES INPT^3
 ;;799,"VAL")
 ;;OR GXTUBE HEMOVAC
 ;;800,"KEY")
 ;;ORWD PTCARE TUBES INPT^4
 ;;800,"VAL")
 ;;OR GXTUBE ILEOSTOMY
 ;;801,"KEY")
 ;;ORWD PTCARE TUBES INPT^5
 ;;801,"VAL")
 ;;OR GXTUBE JACKSON PRATT
 ;;802,"KEY")
 ;;ORWD PTCARE TUBES INPT^6
 ;;802,"VAL")
 ;;OR GXTUBE NASOGASTRIC
 ;;803,"KEY")
 ;;ORWD PTCARE TUBES INPT^7
 ;;803,"VAL")
 ;;OR GXTUBE PENROSE
 ;;804,"KEY")
 ;;ORWD PTCARE TUBES INPT^8
 ;;804,"VAL")
 ;;OR GXTUBE RECTAL TUBE
 ;;805,"KEY")
 ;;ORWD PTCARE TUBES INPT^9
 ;;805,"VAL")
 ;;OR GXTUBE UROSTOMY
 ;;830,"KEY")
 ;;ORLP DEFAULT LIST ORDER^1
 ;;830,"VAL")
 ;;Alphabetic
 ;;876,"KEY")
 ;;ORWUH WHATSTHIS^MYSTUFF
 ;;876,"VAL")
 ;;-1
 ;;877,"KEY")
 ;;ORK PROCESSING FLAG^GLUCOPHAGE-CONTRAST MEDIA
 ;;877,"VAL")
 ;;Enabled
 ;;881,"KEY")
 ;;ORWUH WHATSTHIS^ 
 ;;881,"VAL")
 ;;Problem Category Selection List
 ;;881,"VAL",1,0)
 ;;Each elemement on the list represents a category of problems. The list is typically personalized for the user or user's department. Select a particular category by clicking on it. Selection of a Category will cause a list of the individual
 ;;881,"VAL",2,0)
 ;;problems comprising the category to display in the Problem Selection List Below.
 ;;882,"KEY")
 ;;ORWUH WHATSTHIS^edProbEnt
 ;;882,"VAL")
 ;;Free Text Problem Entry
 ;;882,"VAL",1,0)
 ;;Free Text Problem Entry
 ;;882,"VAL",2,0)
 ;; 
 ;;882,"VAL",3,0)
 ;;Enter the description for a problem to add to the patient's problem list. 
 ;;882,"VAL",4,0)
 ;;After entering the text, press 'Enter'. A dialog box will appear on the 
 ;;882,"VAL",5,0)
 ;;right, which allows further description, staging, and characterization
 ;;882,"VAL",6,0)
 ;;of the problem.
 ;;883,"KEY")
 ;;ORWUH WHATSTHIS^bbOtherProb
 ;;883,"VAL")
 ;;Problem Selection from Clinical Lexicon
 ;;883,"VAL",1,0)
 ;;Problem Selection from Clinical Lexicon
 ;;883,"VAL",2,0)
 ;; 
 ;;883,"VAL",3,0)
 ;;Clicking this button will cause a dialog box to appear. Enter a problem
 ;;883,"VAL",4,0)
 ;;description or partial description into the edit box. Press 'Enter' or
 ;;883,"VAL",5,0)
 ;;click on the 'Search' button after the text has been entered.
 ;;883,"VAL",6,0)
 ;; 
 ;;883,"VAL",7,0)
 ;;A list of descriptions consistent with the text entered will be returned 
 ;;883,"VAL",8,0)
 ;;from a search of the lexicon. Select the coded description from the list 
 ;;883,"VAL",9,0)
 ;;that best matches the text entry by clicking on it. If none of the list 
 ;;883,"VAL",10,0)
 ;;items are an acceptable replacement for the text entered, the text entered
 ;;883,"VAL",11,0)
 ;;may be retained as the problem description. Simply press 'Enter' without
 ;;883,"VAL",12,0)
 ;;selection from the list in that case.
 ;;883,"VAL",13,0)
 ;; 
 ;;883,"VAL",14,0)
 ;;Keep in mind, that searches of the Clinical Lexicon can consume a great 
 ;;883,"VAL",15,0)
 ;;deal of time and resource, so it is best to keep the searches as narrow 
 ;;883,"VAL",16,0)
 ;;as possible.
 ;;884,"KEY")
 ;;ORWUH WHATSTHIS^cbxRespProv
 ;;884,"VAL")
 ;;Change Responsible Provider
 ;;884,"VAL",1,0)
 ;;Change Responsible Provider
 ;;884,"VAL",2,0)
 ;; 
 ;;884,"VAL",3,0)
 ;;The responsible provider for a problem may be changed from the default 
 ;;884,"VAL",4,0)
 ;;value. Enter a new provider name or partial name into the combo box. 
 ;;884,"VAL",5,0)
 ;;Pressing the 'Enter' key will cause a search of the provider table to 
 ;;884,"VAL",6,0)
 ;;commence. 
 ;;884,"VAL",7,0)
 ;; 
 ;;884,"VAL",8,0)
 ;;A list of providers matching the text input will be returned. Select one
 ;;884,"VAL",9,0)
 ;;of the providers from the list by clicking on the appropriate list item.
 ;;884,"VAL",10,0)
 ;; 
 ;;884,"VAL",11,0)
 ;;NOTE: Certain users may be restricted fromperforming this activity.
 ;;885,"KEY")
 ;;ORWUH WHATSTHIS^bbVuFilt
 ;;885,"VAL")
 ;;Set View Filters
 ;;885,"VAL",1,0)
 ;;Set View Filters
 ;;885,"VAL",2,0)
 ;; 
 ;;885,"VAL",3,0)
 ;;Clicking this button will cause a dialog box to appear. The dialog allows 
 ;;885,"VAL",4,0)
 ;;the user to filter a patient's problem list by patient type, location
 ;;885,"VAL",5,0)
 ;;and/or by provider. 
 ;;885,"VAL",6,0)
 ;; 
 ;;885,"VAL",7,0)
 ;;Click the appropriate radio button to confine the list to Out-Patient
 ;;885,"VAL",8,0)
 ;;visits or In-Patient visits. Click 'Both' to view problems for all visit
 ;;885,"VAL",9,0)
 ;;types. 
 ;;885,"VAL",10,0)
 ;; 
 ;;885,"VAL",11,0)
 ;;Select a provider from the drop down list to view problems for a single
 ;;885,"VAL",12,0)
 ;;provider, or  select  'All' to view problems for all providers. 
 ;;885,"VAL",13,0)
 ;; 
 ;;885,"VAL",14,0)
 ;;The list box on the left will display a list of all of the patient's clinics 
 ;;885,"VAL",15,0)
 ;;if the out-patient view was selected, or a list of hospital service names
 ;;885,"VAL",16,0)
 ;;if the in-patient view was selected. Viewing problems for specific 
 ;;885,"VAL",17,0)
 ;;clinics/services is accomplished by highlighting an entry in the left side
 ;;885,"VAL",18,0)
 ;;list box, and clicking the '>' button. This action will cause the clinic
 ;;885,"VAL",19,0)
 ;;or service from the left to appear in the listbox on the right. The '>>'
 ;;885,"VAL",20,0)
 ;;button will move all items from the left to the right.
 ;;885,"VAL",21,0)
 ;; 
 ;;885,"VAL",22,0)
 ;;To remove clinics/services from viewing, highlight the item on the right
 ;;885,"VAL",23,0)
 ;;and click the '<' button or use the '<<' button to remove them all.
 ;;885,"VAL",24,0)
 ;; 
 ;;885,"VAL",25,0)
 ;;The user's default view filters are used initially, but may be changed at 
