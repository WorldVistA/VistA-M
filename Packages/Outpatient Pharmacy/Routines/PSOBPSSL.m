PSOBPSSL ;ALB/EWL - ePharmacy Site Parameters Definition ;03/20/2013
 ;;7.0;OUTPATIENT PHARMACY;**421,427**;DEC 1997;Build 21
 ;
 ; This routine is called from PSOBPSSP from the DP - Display Site Parameters 
 ; action item.  That is the only way this routine should be entered.
 ;
 ; ICR Calls 
 ;   ICR  Type       Description
 ; -----  ---------  ---------------------------
 ; n/a
 ;
 ; Other Calls
 ; ----------------
 ; DIV^PSOBPSSP
 Q
EN ; Entry point for PSO EPHARM PARAMS LIST List Manager screen
 ;
 ; PSODIV is the IEN of the initially selected division. Set by ^PSOLSET.
 ;     Normally not used, only used if this routine is called directly.
 ; PSODIVS is an array which will contain the divisions to be listed
 ; PSODIVS will be formatted as follows:
 ;     The root - PSODIVS will either be a null or contain "ALL"
 ;     PSODIVS(#) - the # is the ien in file 52.86
 ;          PSODIVS(#) - value --> IEN^SiteName - IEN from file 52.86
 ;
 N PSODIV,PSODIVS
 ;
 ; Launch the list manager screen
 D EN^VALM("PSO EPHARM SITE PARAMS LIST")
 G EXIT
 ;
HDR ; -- header code -- PSO EPHARM SITE PARAMS LIST
 S VALMHDR(1)=$$SITES(.PSODIVS)
 S VALMHDR(1)="Pharmacy Division"_$S(VALMHDR(1)[", ":"s: ",1:": ")_VALMHDR(1)
 I $L(VALMHDR(1))>80 S $E(VALMHDR(1),78,999)="..."
 S VALMHDR(2)="Site parameter settings for one or more Pharmacy Divisions"
 Q
 ;
INIT ; -- init variables and list array -- PSO EPHARM SITE PARAMS LIST
 ; PSODIVS is an array which will contain the divisions to be listed (see EN tag)
 ; LINECT - keeps track of the line count in the display list
 ; IEN - IEN of file 52.86 (Site Parameters)
 ; LMARRAY - List Manager Array Name
 N LMARRAY,IEN,LINECT
 ;
 ; Initialize the Line Counter
 S LINECT=0
 ;
 ; Get list of sites to display
 W ! D SITEPICK(.PSODIVS)
 ;
 ; Quit if no sites selected
 I ('$D(PSODIVS))!($G(PSODIVS)="^") S VALMQUIT=1 Q
 D CLEAN^VALM10
 ;
 ; This is the List Manager Array
 S LMARRAY=$NA(^TMP("PSOBPSSL",$J)) K @LMARRAY
 ;
 ; Process if one or more but not "ALL" sites have been selected
 I $G(PSODIVS)'="ALL" D
 . S IEN=0 F  S IEN=$O(PSODIVS(IEN)) Q:'IEN  D GETDATA(IEN,LMARRAY,.LINECT)
 ;
 ; Process if "ALL" sites have been selected
 I $G(PSODIVS)="ALL" D
 . S IEN=0 F  S IEN=$O(^PS(52.86,IEN)) Q:'IEN  D GETDATA(IEN,LMARRAY,.LINECT)
 S VALMCNT=LINECT
 Q
HELP ; -- help code -- PSO EPHARM MULTI SITE PARAMS
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXPND ; -- expand code
 Q
 ;
EXIT ; -- exit code
 K PSODIVS,^TMP("PSOBPSSL",$J)
 Q
 ;
SITEPICK(DIVS) ; Get the list of sites to display
 ; Cloned from SEL^PSOREJU1 with changes for Site Parameter List
 ;
 ; Input Parameter
 ; DIVS - is passed by reference and will hold the set of divisions to process
 ;
 ; Local Variables
 ; QT - used to control when to exit 
 N QT
 ;
 ; Variables used by ^DIC
 N DIC,DTOUT,DUOUT,Y,X
 ;
 ; Instructional message
 W !!,"You may select a single or multiple Divisions,"
 W !,"or enter ^ALL to select all Divisions.",!
 ;
 ; Select the divisions to display from 52.86
 K DIVS S DIC="^PS(52.86,",DIC(0)="QEZAM"
 S DIC("A")="Select a Division to display: "
 F  D ^DIC Q:X=""  D  Q:$G(QT)
 . I $$UP^XLFSTR(X)="^ALL" K DIVS S DIVS="ALL",QT=1 Q
 . I $G(DTOUT)!$G(DUOUT) K DIVS S DIVS="^",QT=1 Q
 . W "   ",$P(Y,"^",2),$S($D(DIVS(+Y)):"       (already selected)",1:"")
 . W ! S DIVS(+Y)="",DIC("A")="ANOTHER ONE: " K DIC("B")
 Q
 ;
SITES(DIVS) ; - Returns the list of selected Pharmacy Divisions
 N SITE,SITES,NAME,PSITE S SITES=""
 ; DIVS - array identifying the sites being processed.
 ; SITE - individual PS site numbers IN FILE 52.86
 ; NAME - division name from file 4
 ; SITES - comma delimited site names
 ;
 ; Create a string of ^ delimited division names.
 I '$D(DIVS) Q ""
 I $G(DIVS)="ALL" Q "ALL"
 ;
 ; Create a string of ^ delimited division names.
 S SITE=0,SITES="" F  S SITE=$O(DIVS(SITE)) Q:'SITE  D
 . S NAME=$$GET1^DIQ(52.86,SITE_",",.01,"E")
 . S DIVS(SITE)=SITE_U_NAME
 . S SITES=SITES_$S(SITES]"":", ",1:"")_NAME
 Q SITES
 ;
GETDATA(IEN,DATA,NXTLINE) ; Adds and formats data from one Pharmacy Division
 ; This may be called multiple times when displaying multiple divisions
 ; This is called by PSOBPSSP
 ;
 ; INPUT PARAMETERS
 ; IEN - Site IEN from 52.86
 ; DATA - List Manager Array name
 ; NXTLINE - output parameter - returns line counter/number of lines in list
 ;
 ; check parameters
 I '$G(IEN) Q 0 ; No parent division passed
 I $L($G(DATA))<1 Q 0 ; No array passed to the routine
 I '$D(NXTLINE) Q 0 ; No line number passed must be >= 0
 ;
 ; LOCAL VARIABLES
 ; PSOI - IEN/LOOP CONTROL while looping through array
 ; GETS - Temp array for GETS^DIQ results
 ; WLSTDAYS - Days to remain on worklist
 ; AUTOSEND - Auto send - yes/no
 ; REJEXPL - Reject code explanations text
 ; THRESHLD - Threshold amount for fill prevention reject codes
 ; GETS - array for output from LIST^DIC and processed codes
 ; IORVON & IORVOFF are Kernel Video Variables used for List Manager formatting
 ;
 N PSOI,GETS,WLSTDAYS,PAUSE,CODE,AUTOSEND,REJEXPL,THRESHLD,SITE
 ;
 ; Get the high level site parameters
 S SITE=$$GET1^DIQ(52.86,IEN_",",.01)
 ; Site header
 I NXTLINE'=0 S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)=""
 S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)="Pharmacy Division: "_$G(SITE)
 D CNTRL^VALM10(NXTLINE,1,80,IORVON,IORVOFF)
 ;
 ; Display General Parameters
 S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)="  General Parameters"
 D CNTRL^VALM10(NXTLINE,3,18,IOUON,IOUOFF)
 ;
 ; Get the site worklist days
 S WLSTDAYS=$$GET1^DIQ(52.86,IEN_",",4)
 S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)="  Reject Worklist Days: "_$G(WLSTDAYS)
 ;
 ; Get the ePharmacy Response Pause
 S PAUSE=$$GET1^DIQ(52.86,IEN_",",6)
 S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)="  ePharmacy Response Pause: "_$G(PAUSE)
 ;
 ; Process the site transfer reject codes
 ;
 ; create header for transfer reject code section
 S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)=""
 S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)="  Transfer Reject Codes"
 D CNTRL^VALM10(NXTLINE,3,21,IOUON,IOUOFF)
 ;
 ; Get the transfer reject codes
 K GETS D LIST^DIC(52.8651,","_IEN_",","@;.01IE;1",,,,,,,,"GETS")
 ;
 ; create sub-header for transfer reject code section
 I $D(GETS) D
 . S NXTLINE=NXTLINE+1
 . S @DATA@(NXTLINE,0)="  Code  Description                                                   Auto-Send"
 . S NXTLINE=NXTLINE+1
 . S @DATA@(NXTLINE,0)="  ----  ------------------------------------------------------------  ---------"
 . ;
 . ; Sort the output by external code
 . S PSOI=0
 . F  S PSOI=$O(GETS("DILIST","ID",PSOI)) Q:PSOI=""  D
 . . ; Parse output from LIST^DIC and add to local array GETS as follows:
 . . ;      GETS({external code})={external AUTO SEND}^{internal code}
 . . S GETS(" "_GETS("DILIST","ID",PSOI,.01,"E"))=GETS("DILIST","ID",PSOI,1)_U_GETS("DILIST","ID",PSOI,.01,"I")
 . . Q
 . ; Kill the part of GETS no longer needed - from LIST^DIC
 . K GETS("DILIST")
 . ;
 . ; process the transfer reject code body
 . S PSOI="" F  S PSOI=$O(GETS(PSOI)) Q:PSOI=""  D
 . . S CODE=PSOI,AUTOSEND=$P(GETS(PSOI),U,1)
 . . ; Get reject explanation
 . . S REJEXPL=$$GET1^DIQ(9002313.93,$P(GETS(PSOI),U,2)_",",.02)
 . . ; Build the next list line
 . . S NXTLINE=NXTLINE+1,$E(@DATA@(NXTLINE,0),3,6)=$J(CODE,4)
 . . S $E(@DATA@(NXTLINE,0),9,68)=$E(REJEXPL,1,60)
 . . S $E(@DATA@(NXTLINE,0),77,79)=$S(AUTOSEND="YES":"YES",1:" NO")
 . Q
 ;
 ; process for no transfer reject codes
 I '$D(GETS) S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)="  No transfer reject codes for this Pharmacy Division."
 ;
 ; Process the Reject Resolution Required Codes
 ;
 ; create header for the Reject Resolution Required Codes
 S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)=""
 S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)="  Reject Resolution Required Codes"
 D CNTRL^VALM10(NXTLINE,3,32,IOUON,IOUOFF)
 ;
 ; Get the transfer reject codes
 K GETS D LIST^DIC(52.865,","_IEN_",","@;.01IE;.02",,,,,,,,"GETS")
 ;
 ; create sub-header for the Reject Resolution Required Codes
 I $D(GETS) D
 . S NXTLINE=NXTLINE+1
 . S @DATA@(NXTLINE,0)="  Code  Description                                                   Threshold"
 . S NXTLINE=NXTLINE+1
 . S @DATA@(NXTLINE,0)="  ----  ------------------------------------------------------------  ---------"
 . ;
 . ; Sort the output by external code
 . S PSOI=0
 . F  S PSOI=$O(GETS("DILIST","ID",PSOI)) Q:PSOI=""  D
 . . ; Parse output from LIST^DIC and add to local array GETS as follows:
 . . ;      GETS({external code})={external DOLLAR THRESHOLD}^{internal code}
 . . S GETS(" "_GETS("DILIST","ID",PSOI,.01,"E"))=GETS("DILIST","ID",PSOI,.02)_U_GETS("DILIST","ID",PSOI,.01,"I")
 . . Q
 . ; Kill the part of GETS no longer needed - from LIST^DIC
 . K GETS("DILIST")
 . ;
 . ; process the Reject Resolution Required code body
 . S PSOI="" F  S PSOI=$O(GETS(PSOI)) Q:PSOI=""  D
 . . S CODE=PSOI,THRESHLD=$P(GETS(PSOI),U,1)
 . . ; Get reject explanation
 . . S REJEXPL=$$GET1^DIQ(9002313.93,$P(GETS(PSOI),U,2)_",",.02)
 . . ;
 . . ; Build the next list line
 . . S NXTLINE=NXTLINE+1,$E(@DATA@(NXTLINE,0),3,6)=$J(CODE,4)
 . . S $E(@DATA@(NXTLINE,0),9,68)=$E(REJEXPL,1,60)
 . . S THRESHLD=+THRESHLD,THRESHLD=$J("$"_$FN(THRESHLD,",",0),10)
 . . S $E(@DATA@(NXTLINE,0),70,79)=THRESHLD
 . Q
 ;
 ; process for no Reject Resolution Required Codes
 I '$D(GETS) S NXTLINE=NXTLINE+1,@DATA@(NXTLINE,0)="  No Reject Resolution Required Codes for this Pharmacy Division."
 Q
 ;
TRCMSG ; Transfer Reject Informational Message (called by PSOBPSSP, which was too big)
 W !!,"All transfer rejects will automatically be placed on the Third Party Payer"
 W !,"Rejects - Worklist if the reject code is defined in the site parameter file"
 W !,"and the AUTO SEND parameter is set to yes. The OPECC must manually transfer"
 W !,"the reject if the reject code is defined in the site parameter file"
 W !,"and the AUTO SEND parameter is set to no. (To be used when Pharmacy can"
 W !,"possibly correct a locally filled Rx.)"
 Q
 ;
RRRMSG ; Reject Resolution Required Informational Message (called by PSOBPSSP, which was too big)
 W !!,"All Reject Resolution Required reject codes will automatically be placed"
 W !,"on the Third Party Payer Rejects - Worklist. This parameter applies to"
 W !,"rejects for original unreleased fills only. Prescriptions will not be filled"
 W !,"until the rejects identified by the Reject Resolution parameter are resolved."
 Q
