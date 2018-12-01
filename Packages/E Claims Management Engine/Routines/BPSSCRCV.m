BPSSCRCV ;BHAM ISC/SS - ECME SCREEN CHANGE VIEW ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,11,14,20,22,23**;JUN 2004;Build 44
 ;;Per VA Directive 6402, this routine should not be modified.
 ;USER SCREEN
 Q
 ;****
 ;This software is using PARAMETER TOOLS (see XT*7.3*26) to store user's settings:
 ;PARAMETER DEFINITION NAME="BPS USRSCR" (file #8989.51, IA# 2263)
 ;ENTITY is "USR" , i.e. IEN in ^VA(200  -- see definition for "BPS USRSCR"
 ;INSTANCEs are as follows:
 ;1.01 ONE/ALL USERS --'U' ONE USER, 'A' ALL; Display claims for ONE or ALL users 
 ;1.02 ONE/ALL PATIENTS --'P' FOR ONE PATIENT; 'A' FOR ALL; Display claims for ONE/ALL PATIENTS 
 ;1.03 ONE/ALL RX --'R' FOR ONE RX; 'A' FOR ALL; Display claims for ONE or ALL RX 
 ;1.031 DATE RANGE/TIMEFRAME -- 'D' FOR DATE RANGE; 'T' FOR TIMEFRAME;
 ;1.032 ACTIVITY BEGINNING DATE - Beginning Date of the Date Range
 ;1.033 ACTIVITY ENDING DATE - Ending Date of the Date Range 
 ;1.04 HOURS/DAYS -- 'D' FOR DAYS; 'H' FOR HOURS; Use HOURS or DAYS to specify timeframe 
 ;1.05 TIMEFRAME -- NUMBER Depends on the value of the field "USR SCR HOURS/DAYS" this field will
 ;store the default number of HOURS from NOW or DAYS from TODAY to select claims to display 
 ;1.06 REJECTED/PAYABLE --'R' FOR REJECTS; 'P' FOR PAYABLES; 'U' FOR UNSTRANDED; 'A' FOR ALL; Display Rejects or Payables or Unstranded or ALL claims 
 ;1.07 RELEASED/NOT RELEASED --'R' FOR RELEASED; 'N' FOR NON-RELEASED; 'A' FOR ALL; Display Released Rxs or Non-Released Rxs or ALL 
 ;1.08 CMOP/MAIL/WINDOW --'C' FOR CMOP; 'M' FOR MAIL;'W' FOR WINDOW;'A' FOR ALL; Display CMOP or Mail or Window or ALL Rxs 
 ;1.09 REALTIME/BACKBILL --'R' FOR REALTIME; 'B' FOR BACKBILLS; 'P' FOR PRO Option; 'S' FOR ECME User Screen Resubmits;
 ;      'A' FOR ALL; Display RealTime, Backbills, PRO Option, Resubmission, or ALL
 ;1.1 REJECT CODE/ALL --'R' FOR REJECT CODE; 'A' FOR ALL; Display Specific Reject Code or ALL Reject
 ;Codes 0 means ALL Reject Codes otherwise - Reject Code value 
 ;1.11 SPECIFIC/ALL INSURANCES --'I' FOR SPECIFIC INSURANCE(S);'A' FOR ALL; Display Specific Insurance Company(s) or All null - ALL otherwise - pointer to INSURANCE COMPANY file #36 
 ;1.12 SORT LIST --'T' FOR TRANSACTION DATE;'D' FOR DIVISION; 'I' FOR INSURANCE; 'C' FOR REJECT CODE; 
 ;'P' FOR PATIENT NAME -- 'N' FOR DRUG NAME; 'B' FOR BILL TYPE (BB/P2/RT/RS); 'L' FOR FILL LOCATION;
 ;'R' FOR RELEASED/NON-RELEASED -- 'A' FOR ACTIVE/DISCONTINUED; the field used to sort claims in the list 
 ;1.13 ALL ECME PHARMACY DIVISIONS --'D' FOR DIVISION; 'A' FOR ALL; 
 ;1.14 SELECTED INSURANCE -- Single, or multiple, insurance(s) to select claims for the User Screen, to store INSURANCE COMPANY pointer (#36) 
 ;1.15 SELECTED REJECTED CODE --POINTER TO BPS NCPDP REJECT CODES FILE (#9002313.93) Reject code selected by the user to filter claims.
 ;1.16 SELECTED USER -- POINTER TO NEW PERSON FILE (#200) Selected user for the user screen 
 ;1.17 SELECTED PATIENT -- POINTER TO PATIENT FILE (#2) Selected patient for the User Screen 
 ;1.18 SELECTED RX -- POINTER TO PRESCRIPTION FILE (#52) Selected RX 
 ;1.19 NON-BILLABLE TRI/CVA ENTRIES OPEN/CLOSED/ALL -- 'O' Open; 'C' Closed; 'A' All
 ;2    ECME PHARMACY DIVISION -- the list of POINTERs TO BPS PHARMACIES FILE (#9002313.56) separated by ";"
 ;should start and end with ";", example: ";4;5;"
 ;2.01 ELIGIBILITY TYPE --'V' FOR VETERAN;'T' FOR TRICARE;'C' FOR CHAMPVA;'A' FOR ALL; Display claims for specific Eligibility Type or ALL (BNT BPS*1.0*7)
 ;2.02 OPEN/CLOSED/ALL --'O' OPEN CLAIMS;'C' CLOSED CLAIMS;'A' FOR ALL; Display Open, Closed, or ALL claims (BNT BPS*1.0*7)
 ;2.03 SUBMISSION TYPE --'B' BILLING REQUESTS;'R' REVERSALS;'A' FOR ALL; Display specific submission type claims or ALL (BNT BPS*1.0*7)
 ;2.04 INSURANCES -- List of POINTERs to the INSURANCE COMPANY FILE (#36) separated by ";"
 ;should start and end with ";", example: ";4;5;"
 ;NOTE: use D ^XPAREDIT to add/edit values
 ;
 ;*****
 ;
CV ;
 N BPSRESCV,BPSTMPCV,DIR,Y
 D FULL^VALM1
 W @IOF
 S BPSTMPCV=$G(BPARR("TEMPCV"))   ; Define Temp View Flag before BPARR is killed
 K BPARR
 I +$G(DUZ)=0 D ERRMSG^BPSSCRCV("Unknown User") Q
 N BPDUZ7
 S BPDUZ7=+DUZ
 ;always get current profile from the file
 D READPROF^BPSSCRSL(.BPARR,BPDUZ7)
 ; BPARR("1.13") is the parameter for Pharmacy Division. 
 ; If BPARR("1.13") is defined, the user has a preferred view defined.
 I ($G(BPSTMPCV)=1)&($G(BPARR("1.13"))'="") D
 . S DIR(0)="Y"
 . S DIR("A")="Restore your Preferred View and exit Change View (Y/N)"
 . D ^DIR
 . S BPSRESCV=Y
 I $G(BPSRESCV)=1 G CV1     ; User replied YES - restore to preferred view.
 D SAVEVIEW^BPSSCR01(.BPARR)
 ;edit current profile
 D EDITPROF(.BPARR,.BPDUZ7)
 ;ask user if need to save everything in USR PROFILE file 
 ;(except SORT LIST field)
 N BPSRT S BPSRT=BPARR(1.12)
 K BPARR(1.12)
 D ENDEDIT^BPSSCRSL(.BPARR,+BPDUZ7)
 S BPARR(1.12)=BPSRT
CV1 ;
 D SAVEVIEW^BPSSCR01(.BPARR)
 S VALMBG=1
 D REDRAW^BPSSCRUD("Updating screen...")
 Q
 ;edit user profile for CHANGE VIEW
EDITPROF(BPARR,BPDUZ7) ;
 I +$G(DUZ)=0 D ERRMSG("Unknown User") Q
 N BP1,BPACT,BPTF,BPQ,BPINP
 N BPRET
 N DIR,DR,DIE,DA
 N BPS106,BPS106STR,BPS108,BPS108STR,BPS109,BPS109STR,BPS115,BPS115AR,BPS115NM,BPS115X
 N BPS116,BPS116AR,BPS116NM,BPS116X,BPS117,BPS117AR,BPS117NM,BPS117X,BPS118,BPS118AR,BPS118X
 N BPS201,BPS201STR,BPSCNT,BPSDRUG,BPSERR,BPSRXD,BPSRXN,BPSSEL,BPSX,BPSDAYS,BPSTMPDT
 ;get ONE/ALL USERS?
 ;EDITFLD(FILENO,FLDNO,RECIEN,CODESET,PRMTMSG,DFLTCODE)  ;
 ;
BPS113 ; FIELD 1.13 - Division
 S BPRET=$$DS^BPSSCRDS(.BPARR,+BPDUZ7) ;get divisions
 Q:BPRET=-2  ;quit due to timeout or ^
 ; If (D)ivision option was selected but no Divisons entered, set BPARR(1.13)to "A"
 ; and re-prompt current question.
 I ($G(BPARR(1.13))="D")&(($G(BPARR("DIVS"))="")!($G(BPARR("DIVS"))=";")) S BPARR(1.13)="A" G BPS113
 ;
 I $$BPS201^BPSSCRV1(.BPARR)=0 Q
 I $$BPS101^BPSSCRV1(.BPARR)=0 Q
 I $$BPS102^BPSSCRV1(.BPARR)=0 Q
 I BPARR(1.02)="A" S BPSTMPDT="" D DTERNG   ; If ALL patients, verify date range is not over 180 days
 I $$BPS103^BPSSCRV1(.BPARR)=0 Q
 ;
DATETIME ; Display by Date Range or Timeframe
 ; Prompt the user to select Display Activity Date Range or Timeframe.
 S BPINP=$$ACTTYP()
 Q:BPINP=-1      ;quit due to timeout or ^
 ;
 S BPACT=BPINP
 S BPQ=0
 ;
 S BPSDAYS=180
 I BPARR(1.02)="P" S BPSDAYS=366
 ;
 ; If Date Range was selected, prompt for Activity Beginning and Ending Date.
 I BPACT="D" D
 . ; Clear out Timeframe parameters.
 . S (BPARR(1.04),BPARR(1.05))=""
 . ;
 . S BPINP=$$BEGDATE()
 . I BPINP=-1 S BPQ=-1 Q
 . S BPINP=$$ENDDATE()
 . I BPINP=-1 S BPQ=-1 Q
 ;
 I BPQ=-1 D  G DATETIME  ; Date Range selected, but no dates entered
 . W !!,"Beginning and Ending Dates are required for Date Range"
 . ; Don't allow user to exit out without making valid selections.
 . ; If user selects Date Range but no valid dates default to Timeframe and 7 days.
 . S BPARR(1.031)="T",BPARR(1.04)="D",BPARR(1.05)=7
 ;
 ; If Timeframe was selected, prompt for Days or Hours and Activity Timeframe Value.
 I BPACT="T" D
 . ; Clear out Date Range Parameters.
 . S (BPARR(1.032),BPARR(1.033))=""
 . ;
 . S BPINP=$$EDITFLD(1.04,+BPDUZ7,"S^D:DAYS;H:HOURS","Activity Timeframe (H)ours or (D)ays","DAYS",.BPARR)
 . I BPINP=-1 S BPQ=-1 Q
 . S BPTF=$P(BPINP,U,2)
 . S BPINP=$$EDITFLD(1.05,+BPDUZ7,"N^1:"_BPSDAYS_":0","Activity Timeframe Value",$S(BPTF="H":24,1:7),.BPARR)
 . I BPINP=-1 S BPQ=-1 Q
 Q:BPQ=-1         ;quit due to timeout or ^
 ;
 Q:$$EDITFLD(2.02,+BPDUZ7,"S^O:OPEN CLAIMS;C:CLOSED CLAIMS;A:ALL","Select Open/Closed or All Claims","O",.BPARR)=-1
 Q:$$EDITFLD(1.19,+BPDUZ7,"S^O:Open Non-Billable Entries;C:Closed Non-Billable Entries;A:ALL","Display (O)pen or (C)losed or (A)ll Non-Billable Entries","A",.BPARR)=-1
 Q:$$EDITFLD(2.03,+BPDUZ7,"S^B:BILLING REQUESTS;R:REVERSALS;A:ALL","Select Submission Type","A",.BPARR)=-1
 I $$BPS106^BPSSCRV2(.BPARR)=0 Q
 Q:$$EDITFLD(1.07,+BPDUZ7,"S^R:RELEASED;N:NON-RELEASED;A:ALL","Display (R)eleased Rxs or (N)on-Released Rxs or (A)LL","RELEASED",.BPARR)=-1
 I $$BPS108^BPSSCRV2(.BPARR)=0 Q
 I $$BPS109^BPSSCRV2(.BPARR)=0 Q
 I $$BPS110^BPSSCRV2(.BPARR)=0 Q
 ;
 Q:$$INSURSEL^BPSSCRCU(.BPARR,+BPDUZ7)=-1
 Q
 ;
ERRMSG(BPMSG) ;
 W !,"***",BPMSG,"***",!
 D PAUSE^VALM1
 Q
 ;/**
 ;FLDNO - PARAMETERS INSTANCE
 ;RECIEN - User DUZ
 ;DIR0 - like DIR(0) node for ^DIR - i.e. field type, etc
 ;PRMTMSG - user prompt
 ;DFLTVAL - pass the default value for the case if there is no value in database
 ;BPARRAY - array to store and change values in profile
 ;returns:
 ;as return value:
 ; "1^value" - if selected
 ; "-1" if timeout or uparrow
 ;via BPARRAY
 ; BPARRAY(filedno)=value
EDITFLD(FLDNO,RECIEN,DIR0,PRMTMSG,DFLTVAL,BPARRAY) ;*/
 N DIR,RETV,RETARR
 N RECIENS,FDA,LCK,ERRARR
 S RETV=$$GETPARAM^BPSSCRSL(FLDNO,RECIEN)
 I FLDNO=1.17 S RETV=$P($G(^DPT(+RETV,0)),U)
 ;Use the External Code from File #9002313.93 as the default value to display to user.
 I FLDNO=1.15 S RETV=$P($G(^BPSF(9002313.93,+RETV,0)),U)
 ;if data then use it, otherwise use data from parameter
 I $L($G(RETV))>0&($G(BPSERR)'=1) S DFLTVAL=RETV E  S DFLTVAL=$G(DFLTVAL)
 ;prompt the user
 S RETV=$$PROMPT(DIR0,PRMTMSG,DFLTVAL)
 Q:RETV<0 -1
 ;save it in the database
 S BPARRAY(FLDNO)=RETV
 Q "1^"_RETV
 ;
 ;
FILEIT(FILENO,FLDNO,RECIEN,NEWVAL) ;
 N RECIENS
 S RECIENS=RECIEN_","
 S FDA(FILENO,RECIENS,FLDNO)=NEWVAL
 L +^BPS(FILENO,RECIEN,1):10 S LCK=$T I 'LCK Q "0^"_NEWVAL_"^LOCKED"  ;quit
 D FILE^DIE("","FDA","ERRARR")
 I LCK L -^BPS(FILENO,RECIEN,1)
 I $D(ERRARR) Q "0^"_NEWVAL_"^"_ERRARR("DIERR",1,"TEXT",1)
 Q "1^"_NEWVAL
 ;
 ;prompts for selection
 ;returns selection
 ;OR -1 when timeout and uparrow
PROMPT(ZERONODE,PRMTMSG,DFLTVAL) ;
 N Y,DUOUT,DTOUT,BPQUIT,DIROUT
 S BPQUIT=0
 I $E(ZERONODE,1,1)="P" D
 . N DIC
 . S DIC="^"_$P(ZERONODE,U,2)
 . S DIC(0)="AEMNQ"
 . S:$L($G(DFLTVAL))>0 DIC("B")=DFLTVAL
 . S DIC("A")=PRMTMSG_": "
 . D ^DIC
 . I (Y=-1)!$D(DUOUT)!$D(DTOUT) S BPQUIT=1
 E  D
 . N DIR
 . S DIR(0)=ZERONODE
 . S DIR("A")=PRMTMSG
 . S:$L($G(DFLTVAL))>0 DIR("B")=DFLTVAL
 . ;
 . ; display some extra text for FLDNO=1.19   (BPS*1*20)
 . I $G(FLDNO)=1.19 D
 .. S DIR("A",1)="    Please note this question only applies to"
 .. S DIR("A",2)="    TRICARE or CHAMPVA Non-Billable Entries."
 .. S DIR("A",3)=" "
 .. Q
 . ;
 . D ^DIR
 . I (Y=-1)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) S BPQUIT=1
 I BPQUIT=1 Q -1
 Q $P(Y,U)
 ;
GETFLD(FILENO,FLDNO,RECIEN) ;
 N RETV,RETARR
 N RECIENS
 S RECIENS=RECIEN_","
 ; first try to get the value from file
 D GETS^DIQ(FILENO,RECIENS,FLDNO,"E","RETARR")
 S RETV=$G(RETARR(FILENO,RECIENS,FLDNO,"E"))
 Q $G(RETV)
 ;
 ;save all profile array to file
 ;BPARRAY - arrays with pointers to 9002313.56
 ;BPDUZ7 - DUZ
FILEALL(BPARRAY,BPDUZ7) ;
 ;BPS*14 - RRA changed API, because previously it was re-writing Division
 ;and Insurance parameter regardless if it was modified and had a value
 ;ticket 337299
 N BPFLD,BP2
 S BPFLD=0
 F  S BPFLD=$O(BPARRAY(BPFLD)) Q:$G(BPFLD)=""  D
 . I BPFLD="DIVS" I $$SAVEPAR^BPSSCRSL(2,BPDUZ7,$G(BPARRAY("DIVS")))
 . I BPFLD="INS" I $$SAVEPAR^BPSSCRSL(2.04,BPDUZ7,$G(BPARRAY("INS")))
 . Q:+BPFLD=0  I $$SAVEPAR^BPSSCRSL(BPFLD,+BPDUZ7,$G(BPARRAY(BPFLD)))
 Q
 ;
ACTTYP() ; Prompt the user to select Display Activity Date Range or Timeframe.
 ; The user is required to select D or T and there is no default value.
 ; 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RETV,X,Y
 S RETV=$$GETPARAM^BPSSCRSL(1.031,+BPDUZ7)
 S DIR(0)="S^D:Date Range;T:Timeframe"
 S DIR("A")="Display Activity (D)ate Range or (T)imeframe"
 S DIR("B")="T"
 I RETV'="" S DIR("B")=RETV
 S DIR("?",1)="Date Range will allow a user to specify an activity beginning and ending date."
 S DIR("?")="Timeframe will allow a user to specify the activity by days or hours."
 D ^DIR
 ;
 ;quit due to timeout or ^
 I $D(DIRUT) Q -1
 ;
 S BPARR(1.031)=Y
 Q BPARR(1.031)
 ;
BEGDATE() ; Enter Activity Beginning Date when Date Range is selected
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RETV,X,Y
 S RETV=$$GETPARAM^BPSSCRSL(1.032,+BPDUZ7)
 I $G(BPSTMPDT)=1 S RETV="T-7"
BEGDATE1 ;
 S DIR(0)="D"
 S DIR("A")="Activity Beginning Date"
 I RETV'="" S DIR("B")=$$FMTE^XLFDT(RETV,"D")
 S DIR("?")="Enter a date which is less than or equal to "_$$FMTE^XLFDT($$NOW^XLFDT(),"D")
 D ^DIR
 ;
 ;quit due to timeout or ^
 I $D(DIRUT) Q -1
 ;
 I Y>$$NOW^XLFDT() W !,"Enter a date less than or equal to "_$$FMTE^XLFDT($$NOW^XLFDT(),"D"),! G BEGDATE1
 ;
 W "  (",Y(0),")"
 S BPARR(1.032)=Y
 Q BPARR(1.032)
 ;
ENDDATE() ; Enter Activity Ending Date when Date Range is selected
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RETV,X,Y
 S RETV=$$GETPARAM^BPSSCRSL(1.033,+BPDUZ7)
 I $G(BPSTMPDT)=1 S RETV="T"
ENDDATE1 ;
 S DIR(0)="D"
 S DIR("A")="Activity Ending Date"
 I RETV'="" S DIR("B")=$$FMTE^XLFDT(RETV,"D")
 S DIR("?")="Enter a date which is no more than "_BPSDAYS_" days after the Beginning Date."
 D ^DIR
 ;
 ;quit due to timeout or ^
 I $D(DIRUT) Q -1
 ; 
 I Y<BPARR(1.032) W !!,"Ending Date precedes Beginning Date.",! G ENDDATE1
 ;
 I $$FMDIFF^XLFDT(Y,BPARR(1.032))>BPSDAYS D  G ENDDATE1
 . W !!,"Date range exceeds "_BPSDAYS_" day limit.  Select an Ending Date no more"
 . W !,"than "_BPSDAYS_" days after the Beginning Date.",!
 ;
 W "  (",Y(0),")"
 S BPARR(1.033)=Y
 Q BPARR(1.033)
 ;
DTERNG ; Date Range Check
 ; If ALL patients selected, verify the user preferred time frame
 ; is not outside of the allowable range. If time frame is outside
 ; of the allowable range, update range to the past 7 days.
 N BPS1031,BPS1032,BPS1033,BPS104,BPS105,BPSDAYS
 S BPS1031=$$GETPARAM^BPSSCRSL(1.031,+BPDUZ7)
 S BPS1032=$$GETPARAM^BPSSCRSL(1.032,+BPDUZ7)
 S BPS1033=$$GETPARAM^BPSSCRSL(1.033,+BPDUZ7)
 S BPS104=$$GETPARAM^BPSSCRSL(1.04,+BPDUZ7)
 S BPS105=$$GETPARAM^BPSSCRSL(1.05,+BPDUZ7)
 I ((BPS1031="T")&(BPS105>180))!((BPS1031="D")&($$FMDIFF^XLFDT(BPS1033,BPS1032)>180)) D
 . S BPARR(1.031)="T"
 . S BPARR(1.032)=""
 . S BPARR(1.033)=""
 . S BPARR(1.04)="D"
 . S BPARR(1.05)=7
 . I BPS1031="T" S BPSDAYS=BPS105
 . I BPS1031="D" S BPSDAYS=$$FMDIFF^XLFDT(BPS1033,BPS1032)
 . W !!,"Date range exceeds 180 day limit which is not allowed when all patients"
 . W !,"are selected.  The window of time has changed from "_BPSDAYS_" days to the"
 . W !,"last 7 days."
 . S BPSTMPDT=1
 Q
