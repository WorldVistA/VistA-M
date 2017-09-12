IBY371PO ;ALB/WCJ - Post Install for IB patch 371 ;17-APR-2007
 ;;2.0;INTEGRATED BILLING;**371**;21-MAR-94;Build 57
 ;
EN ;
 N XPDIDTOT S XPDIDTOT=5
 D RIT          ; 1. Recompile input templates
 D CUINS        ; 2. Clean up duplicate insurance address lines
 D MEDWNR       ; 3. Pre-populate Medicare WNR with professional payer ID 2U and station number
 D VCHELP       ; 4. Add help text to Value Codes and Deactivate some value codes.
 D NEWXREF      ; 5. Add NEW STYLE XREF to Value Code Subfile in 399.047
EX ;
 Q
 ;
RIT ; Recompile input templates for billing screens
 NEW X,Y,DMAX
 D BMES^XPDUTL(" STEP 1 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Recompiling Input Templates for Billing Screens 3 through 7 ....")
 S X="IBXSC3",Y=$$FIND1^DIC(.402,,"X","IB SCREEN3","B"),DMAX=8000
 I Y D EN^DIEZ
 S X="IBXSC4",Y=$$FIND1^DIC(.402,,"X","IB SCREEN4","B"),DMAX=8000
 I Y D EN^DIEZ
 S X="IBXSC5",Y=$$FIND1^DIC(.402,,"X","IB SCREEN5","B"),DMAX=8000
 I Y D EN^DIEZ
 S X="IBXSC6",Y=$$FIND1^DIC(.402,,"X","IB SCREEN6","B"),DMAX=8000
 I Y D EN^DIEZ
 S X="IBXSC7",Y=$$FIND1^DIC(.402,,"X","IB SCREEN7","B"),DMAX=8000
 I Y D EN^DIEZ
RITX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(1)
 Q
 ;
CUINS ; Clean up Insurance company address line duplicates
 ;
 D BMES^XPDUTL(" STEP 2 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing duplicate address lines in insurance company file")
 ;
 N INSCO,ADDLOC,I,FIELD,VALUE
 S INSCO=0 F  S INSCO=$O(^DIC(36,INSCO))  Q:'+INSCO  D
 . F ADDLOC=.11,.12,.14,.15,.16,.18 D
 .. N ADDRESS
 .. F I=1:1:3 D
 ... S FIELD=ADDLOC_I
 ... S ADDRESS(I)=$$UP^XLFSTR($$GET1^DIQ(36,INSCO,FIELD))
 ... D CLEAN^DILF
 .. ;
 .. I ADDRESS(3)]"",ADDRESS(3)=ADDRESS(2)!(ADDRESS(3)=ADDRESS(1)) D
 ... S VALUE="@",FIELD=ADDLOC_3
 ... D POPULATE(INSCO,FIELD,VALUE)
 ... S ADDRESS(3)=""
 .. ;
 .. I ADDRESS(2)]"",ADDRESS(2)=ADDRESS(1) D
 ... S FIELD=ADDLOC_2
 ... S VALUE=$S(ADDRESS(3)="":"@",1:ADDRESS(3))
 ... D POPULATE(INSCO,FIELD,VALUE)
 ;
CUINSX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(2)
 Q
 ;
POPULATE(INSCO,FLD,VAL) ;
 N X,Y,DA,DIE,DR
 S DA=INSCO
 S DIE=36
 S DR=FLD_"////"_VAL
 D ^DIE
 Q
 ;
MEDWNR ; Prepopulate Medicare WNR with professional payer ID 2U and station number
 ;
 D BMES^XPDUTL(" STEP 3 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Prepopulate Medicare WNR with professional payer ID")
 ;
 N INSCO,SITE
 S SITE="VA"_$P($$SITE^VASITE,U,3)
 S INSCO=0 F  S INSCO=$O(^DIC(36,"B","MEDICARE (WNR)",INSCO))  Q:'+INSCO  D
 . N X,Y,DA,DIE,DR
 . S DA=INSCO
 . S DIE=36
 . S DR="6.05////2U;6.06////"_SITE
 . D ^DIE
MEDWNRX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(3)
 Q
 ;
VCHELP ;
 ;
 D BMES^XPDUTL(" STEP 4 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Add help text and obsolete date to value codes")
 ;
 N VC
 S VC("45",1)="Enter the hour when the accident occurred that caused"
 S VC("45",2)="the need for medical treatment. "
 S VC("45",3)=" "
 S VC("45",4)="Enter correct code."
 S VC("45",5)="00      12:00-12:59 (Midnight)"
 S VC("45",6)="01      01:00-01:59 AM"
 S VC("45",7)="02      02:00-02:59 AM"
 S VC("45",8)="03      03:00-03:59 AM"
 S VC("45",9)="04      04:00-04:59 AM"
 S VC("45",10)="05      05:00-05:59 AM"
 S VC("45",11)="06      06:00-06:59 AM"
 S VC("45",12)="07      07:00-07:59 AM"
 S VC("45",13)="08      08:00-08:59 AM"
 S VC("45",14)="09      09:00-09:59 AM"
 S VC("45",15)="10      10:00-10:59 AM"
 S VC("45",16)="11      11:00-11:59 AM"
 S VC("45",17)="12      12:00-12:59 (Noon)"
 S VC("45",18)="13      01:00-01:59 PM"
 S VC("45",19)="14      02:00-02:59 PM"
 S VC("45",20)="15      03:00-03:59 PM"
 S VC("45",21)="16      04:00-04:59 PM"
 S VC("45",22)="17      05:00-05:59 PM"
 S VC("45",23)="18      06:00-06:59 PM"
 S VC("45",24)="19      07:00-07:59 PM"
 S VC("45",25)="20      08:00-08:59 PM"
 S VC("45",26)="21      09:00-09:59 PM"
 S VC("45",27)="22      10:00-10:59 PM"
 S VC("45",28)="23      11:00-11:59 PM"
 S VC("45",29)="99      Unknown"
 S VC("24",1)="Medicaid-eligibility requirements to be determined at state level."
 S VC("37",1)="Enter the total number of pints of whole blood or"
 S VC("37",2)="units of packed red cells furnished to the patient."
 S VC("38",1)="Enter the total number of pints of whole blood or"
 S VC("38",2)="units of packed red cells furnished to the patient."
 S VC("46",1)="Enter the number of days determined by the QIO (medical"
 S VC("46",2)="necessity reviewer) as needed to arrange for post-discharge"
 S VC("46",3)="care."
 S VC("48",1)="Enter the most recent hemoglobin reading taken before"
 S VC("48",2)="the start of this billing period."
 S VC("48",3)="Enter it in the format XX.X."
 S VC("49",1)="Enter the most recent hematocrit reading taken before"
 S VC("49",2)="the start of this billing period."
 S VC("49",3)="Enter it in the format XX.X."
 S VC("50",1)="Enter the number of physical therapy visits provided"
 S VC("50",2)="from the onset of treatment by this billing provider"
 S VC("50",3)="through this billing period."
 S VC("51",1)="Enter the number of occupational therapy visits provided"
 S VC("51",2)="from the onset of treatment by this billing provider"
 S VC("51",3)="through this billing period."
 S VC("52",1)="Enter the number of speech therapy visits provided"
 S VC("52",2)="from the onset of treatment by this billing provider"
 S VC("52",3)="through this billing period."
 S VC("53",1)="Enter the number of cardiac rehabilitation visits provided"
 S VC("53",2)="from the onset of treatment by this billing provider"
 S VC("53",3)="through this billing period."
 S VC("56",1)="Enter the number of home visit hours of skilled"
 S VC("56",2)="nursing provided during the billing period. Do"
 S VC("56",3)="not include travel time. Enter whole hours."
 S VC("57",1)="Enter the number of home health aide hours of service"
 S VC("57",2)="provided during the billing period. Do"
 S VC("57",3)="not include travel time. Enter whole hours."
 S VC("58",1)="Enter arterial blood gas value at the beginning of "
 S VC("58",2)="each reporting period for oxygen therapy.  Code 58 "
 S VC("58",3)="or 59 required on the initial bill and the fourth "
 S VC("58",4)="month's bill. Enter the nearest whole number "
 S VC("58",5)="(Example: 56.5 is entered as 57.)"
 S VC("59",1)="Enter oxygen saturation value at the beginning of "
 S VC("59",2)="each reporting period for oxygen therapy.  Code 58 "
 S VC("59",3)="or 59 required on the initial bill and the fourth "
 S VC("59",4)="month's bill. Enter the nearest whole percent "
 S VC("59",5)="(Example: 93.5 is entered as 94.)"
 S VC("60",1)="Enter the MSA number in which the HHA branch is located "
 S VC("60",2)="when the MSA's branch location is different than the "
 S VC("60",3)="HHA's. "
 S VC("68",1)="Enter the number of units of EPO administered and/or"
 S VC("68",2)="supplied related to this billing period. Enter amount"
 S VC("68",3)="in whole units."
 S VC("39",1)="Enter the total number of pints of whole blood or"
 S VC("39",2)="units of packed red cells furnished to the patient."
 S VC("61",1)="Enter MSA or Core Based Statistical Area (CBSA)"
 S VC("61",2)="number (or rural state code) of the location"
 S VC("61",3)="where the home health or hospice service was "
 S VC("61",4)="delivered. Do not include travel time. Enter a "
 S VC("61",5)="whole number rounded to the nearest whole hour."
 S VC("67",1)="Enter the number of hours of peritoneal dialysis"
 S VC("67",2)="provided during the billing period.   "
 S VC("A0",1)="Enter the 5 digit ZIP Code of the location at which "
 S VC("A0",2)="the beneficiary is initially placed on board the"
 S VC("A0",3)="ambulance."
 ; defaults
 S VC("AMT",1)="Enter a monetary amount associated with this value code."
 S VC("AMT",2)="Enter it in the format of dollars and cents (00.00)."
 S VC("AMT",3)=" "
 S VC("AMT",4)="If you enter only dollars (00), the system will add on .00 cents."
 S VC("AMT",5)="Maximum length INCLUDING the cents, is 9 numbers."
 ;
 N DA,CODE,DAT,AMTFLG
 S DA=0 F  S DA=$O(^DGCR(399.1,DA)) Q:DA=""  D
 . N HLPTXT,FDA
 . S DAT=$G(^(DA,0))
 . Q:'$P(DAT,U,11)  ; not a value code
 . S CODE=$P(DAT,U,2)
 . Q:CODE=""
 . I ".E1.E2.E3.F1.F2.F3.G1.G2.G3."[("."_CODE_".") S FDA(399.1,DA_",",.26)=3070301
 . S AMTFLG=0
 . I '$D(VC(CODE)) S CODE="AMT",AMTFLG=1
 . M HLPTXT=VC(CODE)
 . S FDA(399.1,DA_",",1)="HLPTXT"
 . S FDA(399.1,DA_",",.19)=$S(AMTFLG:1,1:0)
 . S FDA="FDA"
 . D FILE^DIE("",FDA)
 ;
VCHELPX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(4)
 Q
 ;
NEWXREF ;
 ;
 D BMES^XPDUTL(" STEP 5 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding new style cross reference")
 ;
 N ZZWJXR,ZZWJRES,ZZWJOUT
 S ZZWJXR("FILE")=399.047
 S ZZWJXR("NAME")="AC"
 S ZZWJXR("TYPE")="MU"
 S ZZWJXR("USE")="A"
 S ZZWJXR("EXECUTION")="F"
 S ZZWJXR("ACTIVITY")=""
 S ZZWJXR("SHORT DESCR")="VALUE field clean up"
 S ZZWJXR("DESCR",1)="If the VALUE CODE field is modified, make sure the VALUE field associated"
 S ZZWJXR("DESCR",2)="with it is still VALID.  If not, delete the VALUE."
 S ZZWJXR("SET")="D REMOVE^IBCVC(.DA)"
 S ZZWJXR("KILL")="Q"
 S ZZWJXR("SET CONDITION")="S X=$$COND^IBCVC(.DA,X1(1),X2(1))"
 S ZZWJXR("VAL",1)=.01
 S ZZWJXR("VAL",1,"COLLATION")="F"
 D CREIXN^DDMOD(.ZZWJXR,"",.ZZWJRES,"ZZWJOUT")
 ;
NEWXREFX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(5)
 Q
