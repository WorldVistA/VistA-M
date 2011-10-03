ORWDBA10 ; SLC/GDU - Billing Awareness - Phase I [11/24/04 13:42]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195,261**;Dec 17, 1997
 ;Clinical Indicator Data Capture By Provider Parameter Module
 ;
 ;This program will enable or disable the CIDC functionality for all
 ;active providers. For the active providers without the CIDC parameter,
 ;this program will assign the CIDC parameter to them and enable or
 ;disable the CIDC functionality.
 ;
 ;The enabling or disabling of the CIDC functionality is based on the
 ;user selected value of an external variable passed to this program.
 ;
 ;External Variable:
 ;  CIDC        Clinical Indicator Data Capture
 ;              A value of E for enable CIDC functionality.
 ;              A value of D for disable CIDC functionality.
 ;              Set by user selection in ORWDBA6 and passed to this
 ;              program.
 ;Internal Variables:
 ;  CNT         Counter variable, used to build temporary global
 ;  DIR         Input array variable for ^DIR
 ;  DT          Standard Fileman/Kernel variable for current date
 ;              DT is set, not newed or killed
 ;  DTOUT       Timeout indicator, output variable of ^DIR
 ;  DUOUT       Up arrow indicator, output variable of ^DIR
 ;  OREM        Error Message, output variable for XPAR
 ;  IEN         Internal Entry Number
 ;  LIST        Input variable of XPAR where output ENVAL^XAR
 ;              will be stored
 ;  PTD         Provider Termination Date
 ;  VAL         Input variable of XPAR
 ;              A value of 1 will enable CIDC functionality
 ;              A value of 0 will disable CIDC functionality
 ;  X           Work variable
 ;  Y           Processed user selection, output variable of ^DIR
 ;External References
 ;  ^DIR        DBIA 10026
 ;  ADD^XPAR    DBIA 2263
 ;  ENVAL^XPAR  DBIA 2263
 ;
EN(CIDC) ;Entry point for this program
 N CNT,DIR,DTOUT,DUOUT,OREM,IEN,LIST,PTD,VAL,X,Y
 K ^TMP($J,"OR","CIDC")
 S DT=$$DT^XLFDT
 ;Get list of clinicians with the CIDC functionality parameter assigned
 ;to them.
 S OREM="",LIST="^TMP($J,""OR"",""CIDC"",""A"")"
 D ENVAL^XPAR(LIST,"OR BILLING AWARENESS BY USER",1,.OREM,1)
 ;Build list of active clinicians who do not have the CIDC functionality
 ;parameter not assigned to them.
 S IEN="",(CNT,^TMP($J,"OR","CIDC","U",0))=0
 F  S IEN=$O(^XUSEC("PROVIDER",IEN)) Q:IEN=""  D
 . ;Skip to next provider is CIDC parameter assigned
 . I $D(^TMP($J,"OR","CIDC","A",IEN_";VA(200,",1))=1 Q
 . ;Skip to next provider if DISUSER set to yes
 . I $$GET1^DIQ(200,IEN,7)="YES" Q
 . ;Get provider termination date, skip to next provider if this date is 
 . ;today's date or in the past.
 . S PTD=$$GET1^DIQ(200,IEN,9.2,"I")
 . I PTD'="",(PTD=DT)!(PTD<DT) Q
 . ;Add to list
 . S CNT=CNT+1
 . S ^TMP($J,"OR","CIDC","U",0)=CNT
 . S ^TMP($J,"OR","CIDC","U",CNT)=IEN_";VA(200,"
 ;Build and display user interface
 S DIR(0)="SX^;"_$P($T(OY),";",3)
 S DIR(0)=DIR(0)_$S(CIDC="E":$P($T(OYE),";",3),1:$P($T(OYD),";",3))_";"
 S DIR(0)=DIR(0)_$P($T(ON),";",3)
 S DIR(0)=DIR(0)_$S(CIDC="E":$P($T(ONE),";",3),1:$P($T(OND),";",3))
 S DIR("A",1)=$S(CIDC="E":$P($T(A2E),";",3),1:$P($T(A2D),";",3))
 S DIR("A",2)=$P($T(A3),";",3)
 S DIR("A")=$P($T(A4),";",3)
 S DIR("?",1)=$P($T(HY),";",3)
 S DIR("?",1)=DIR("?",1)_$S(CIDC="E":$P($T(HYE),";",3),1:$P($T(HYD),";",3))
 S DIR("?")=$P($T(HN),";",3)
 S DIR("?")=DIR("?")_$S(CIDC="E":$P($T(HNE),";",3),1:$P($T(HND),";",3))
 D SCRHDR,^DIR K DIR
 ;Process user's selection
 ;If the user selects no, times out, or enters "^" quit program
 I Y="NO"!($D(DTOUT))!($D(DUOUT)) W !!,$C(7),$P($T(CP),";",3) H 1 G EXIT
 ;Enable/disable CIDC parameter functionality.
 D SCRHDR
 W !!,$S(CIDC="E":$P($T(EP),";",3),1:$P($T(DP),";",3))
 S VAL=$S(CIDC="E":1,1:0)
 ;Enable/disable CIDC functionality for active providers with the parameter
 ;as per user selection
 S X="" F  S X=$O(^TMP($J,"OR","CIDC","A",X)) Q:X=""  D
 . W "."
 . D CHG^XPAR(X,"OR BILLING AWARENESS BY USER",1,VAL,.OREM)
 ;Assigning the CIDC parameter to active providers without it and enable/disable
 ;CIDC functionality as per user selection
 F X=1:1:^TMP($J,"OR","CIDC","U",0) D
 . W "."
 . D ADD^XPAR(^TMP($J,"OR","CIDC","U",X),"OR BILLING AWARENESS BY USER",1,VAL,.OREM)
 ;Alert the user the enabling/disabling CIDC functionality is done.
 S DIR("A")=$S(CIDC="E":$P($T(EC),";",3),1:$P($T(DC),";",3))
 S DIR(0)="E"
 D ^DIR K DIR
EXIT ;Exit point of this routine
 K ^TMP($J,"OR","CIDC")
 Q
 ;
SCRHDR ;Screen Header
 W:$D(IOF) @IOF
 W !,$P($T(SH),";",3)
 W !,$S(CIDC="E":$P($T(SHE),";",3),1:$P($T(SHD),";",3))
 Q
 ;Text for the user's interface
SH ;;Enable Clinical Indicator Data Capture By Provider Parameter Management
SHE ;;Enable Parameter For All Active Providers Option
SHD ;;Disable Parameter For All Active Providers Option
OY ;;YES:Enter YES to begin process to
ON ;;NO:Enter NO to cancel process to
OYE ;; enable CIDC
ONE ;; enable CIDC and quit
OYD ;; disable CIDC
OND ;; disable CIDC and quit
A1 ;;active providers do not have this parameter assigned to them.
A2E ;;You have selected to enable Clinical Indictor Data Capture
A2D ;;You have selected to disable Clinical Indicator Data Capture
A3 ;;for all active providers. This may take some time.
A4 ;;Are you sure you want to do this? (YES/NO - must be all cap)
HY ;;Enter YES to begin the
HN ;;Enter No or '^' to cancel the
HYE ;; enable CIDC process.
HNE ;; enable CIDC process and quit.
HYD ;; disable CIDC process.
HND ;; disable CIDC process and quit.
EP ;;Now enabling CIDC functionality.
EC ;;CIDC parameter functionality enabling complete.
DP ;;Now disabling CIDC functionality.
DC ;;CIDC parameter functionality disabling complete.
CP ;;Process cancelled!
