BPSRPT4 ;BHAM ISC/BEE - ECME REPORTS (CONT) ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8,10,11,19,23**;JUN 2004;Build 44
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; Include Rxs - (R)ELEASED or (N)OT RELEASED or (A)LL
 ;
 ;    Input Variable -> DFLT = 3 NOT RELEASED
 ;                             2 RELEASED
 ;                             1 ALL
 ;                          
 ;    Return Value ->   3 = NOT RELEASED
 ;                      2 = RELEASED
 ;                      1 = ALL
 ;                      ^ = Exit
 ;
SELRLNRL(DFLT) N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT=$S($G(DFLT)=1:"ALL",$G(DFLT)=3:"NOT RELEASED",1:"RELEASED")
 S DIR(0)="S^R:RELEASED;N:NOT RELEASED;A:ALL"
 S DIR("A")="Include Rxs - (R)ELEASED or (N)OT RELEASED or (A)LL",DIR("B")=DFLT
 D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S Y="^"
 ;
 S Y=$S(Y="A":1,Y="R":2,Y="N":3,1:Y)
 ;
 Q Y
 ;
 ; Select to Include (S)pecific Reject Code or (A)ll
 ;                          
 ; Return Value ->   ptr = pointer to BPS NCPDP REJECT CODES (#9002313.93)
 ;  if more than 1 Reject Code is selected, a string of pointers seperated by commas is returned.
 ;            ptr,ptr,...= pointers to BPS NCPDP REJECT CODES (#9002313.93)
 ;                     0 = All Reject Codes
 ;                     ^ = Exit
 ;
SELREJCD() ;
 ; User input will be temporarily stored in BPS115AR for display to user 
 ; of selected REJECT CODES.
 ; 
 ; If 'S' is selected, at least one REJECT CODE must be selected. If no selection 
 ; was made the user will be re-prompted to select a reject code.
 ; 
 ; Upon completion of REJECT CODE(s) entry, values will be placed into a string 
 ; delimited by commas. e.g. BPARR("REJ")="50,60,"
 ; 
 ; BPSRCAR = array containing REJECT CODE information
 ; BPSRCAR(BPSRC)=BPSRCE
 ;  BPSRC = IEN from File #9002313.93 / BPSRCE = Reject Code Explanation  
 ;
 N BPSREJ,DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ; BPSREJ = 1^S - Specific Reject Code
 ;          1^A - ALL
 ;           -1 - if user entered "^"
 ;
 S BPSREJ=$$EDITFLD^BPSSCRCV(1.1,DUZ,"S^S:Specific Reject Code;A:ALL","Include (S)pecific Reject Code or (A)LL","ALL",.BPARR)
 ;
 ;If (A)LL was selected, return 0 (zero)
 I BPSREJ["A" Q 0
 ;If user entered "^" to exit, return "^"
 I BPSREJ=-1 Q "^"
 ;
BPSREJCD ;
 N BPARR,BPSCNT,BPSRC,BPSRCAR,BPSRCC,BPSRCE,BPSRCX
 N DFLTVAL,DIR0,PRMTMSG
 ;
 ;If (S)pecific Reject Code was selected, assign existing entry(s) into BPS115AR array.
 I $P(BPSREJ,U,2)="S" D
 . ;Prompt user to enter one or multiple Reject Codes
 . S BPSRC="" F  D  Q:BPSRC=-1
 . . S DIR0="P^BPSF(9002313.93,"
 . . S PRMTMSG="Select Reject Code"
 . . S DFLTVAL=""
 . . S BPSRC=$$PROMPT^BPSSCRCV(DIR0,PRMTMSG,DFLTVAL)
 . . ;
 . . ; If user didn't make a selection
 . . I BPSRC=-1 Q
 . . ;
 . . ; Get the Code and Explanation for the Reject Code selected
 . . S BPSRCC=$$GET1^DIQ(9002313.93,BPSRC,.01)
 . . S BPSRCE=$$GET1^DIQ(9002313.93,BPSRC,.02)
 . . ;
 . . ; If entry doesn't exist, add new entry into BPSRCAR array.
 . . I '$D(BPSRCAR(BPSRC)) S BPSRCAR(BPSRC)=BPSRCC_U_BPSRCE
 . . ;
 . . ; Display existing entry(s) to user.
 . . I $D(BPSRCAR) D
 . . . S BPSRC="" F  S BPSRC=$O(BPSRCAR(BPSRC)) Q:BPSRC=""  W !,?3,$P(BPSRCAR(BPSRC),U),?13,$P(BPSRCAR(BPSRC),U,2)
 . ;
 . ; If user selected (S)pecific Reject Code, return "^" in order for the user to return to the menu
 . I '$D(BPSRCAR) S BPARR("REJCD")="^" Q
 . ;
 . ; Loop through selected reject codes, set selected reject codes into BPARR("REJCD") delimited by comma. 
 . S BPARR("REJCD")=""
 . S BPSRC="" F  S BPSRC=$O(BPSRCAR(BPSRC)) Q:BPSRC=""  S BPARR("REJCD")=BPARR("REJCD")_BPSRC_","
 ;
SELRCX ;
 Q BPARR("REJCD")
 ;
 ; Include Auto(R)eversed or (A)LL
 ; 
 ;    Input Variable -> DFLT = 1 AutoReversed
 ;                             0 ALL
 ;                          
 ;    Return Value ->   1 = AutoReversed
 ;                      0 = ALL
 ;                      ^ = Exit
 ;
SELAUREV(DFLT) N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DFLT=$S($G(DFLT)=1:"AutoReversed",1:"ALL")
 S DIR(0)="S^R:AutoReversed;A:ALL"
 S DIR("A")="Include Auto(R)eversed or (A)LL",DIR("B")=DFLT
 D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S Y="^"
 ;
 S Y=$S(Y="A":0,Y="R":1,1:Y)
 ;
 Q Y
 ;
 ; Include A(C)cepted or (R)ejected or (A)LL
 ; 
 ;    Input Variable -> DFLT = 2 Accepted
 ;                             1 Rejected
 ;                             0 ALL
 ;                          
 ;    Return Value ->   2 = Accepted
 ;                      1 = Rejected
 ;                      0 = ALL
 ;                      ^ = Exit
 ;
SELACREJ(DFLT) N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DFLT=$S($G(DFLT)=2:"Accepted",$G(DFLT)=1:"Rejected",1:"ALL")
 S DIR(0)="S^C:Accepted;R:Rejected;A:ALL"
 S DIR("A")="Include A(C)cepted or (R)ejected or (A)LL",DIR("B")=DFLT
 D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S Y="^"
 ;
 S Y=$S(Y="C":2,Y="R":1,Y="A":0,1:Y)
 ;
 Q Y
 ;
 ; Select to Include (S)pecific Close Claim Reason or (A)ll
 ;
 ; Input Variable -> DFLT = 1 Specific CLAIMS TRACKING NON-BILLABLE REASONS
 ;                          0 All Reasons
 ;                          
 ; Return Value ->   ptr = pointer to CLAIMS TRACKING NON-BILLABLE REASONS (#356.8)
 ;                     0 = All Reasons
 ;                     ^ = Exit
 ;
SELCCRSN(DFLT) N DIC,DIR,DIRUT,DUOUT,RSN,X,Y
 ;
 S DFLT=$S($G(DFLT)=1:"Specific Close Claim Reason",1:"ALL")
 S DIR(0)="S^S:Specific Close Claim Reason;A:ALL"
 S DIR("A")="Include (S)pecific Close Claim Reason or (A)LL",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S RSN=$S(Y="S":1,Y="A":0,1:Y)
 ;
 ;Check for "^" or timeout
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S (RSN,Y)="^"
 ;
 ;If Specific Reject Code selected, ask prompt
 I $G(RSN)=1 D
 .;
 .;Prompt for entry
 .K X S DIC(0)="QEAM",DIC=356.8,DIC("A")="Select Close Claim Reason: "
 .W ! D ^DIC
 .;
 .;Check for "^", timeout, or blank entry
 .I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S (RSN,Y)="^" Q
 .;
 .;If valid entry, setup RSN
 .I +Y>0 S RSN=+Y
 ;
 Q RSN
 ; 
 ;Pull Selected BPS Pharmacies for Display
 ;
 ;  Input Variables: 
 ;  BPPHARM/BPPHARM(ptr) - Set to 0 for all pharmacies, if set to 1 array of internal
 ;                         pointers of selected pharmacies       
 ;                       - BPLEN = The length of the display field
 ;  Returned value -> List of selected BPS Pharmacies (possibly cut short)                 
 ; 
GETDIVS(BPLEN,BPPHARM) N BPDIV,BPSTR,BPQUIT
 I $G(BPPHARM)=0 S BPSTR="ALL"
 E  D
 .S BPDIV="",BPQUIT=0,BPSTR=""
 .F  S BPDIV=$O(BPPHARM(BPDIV)) Q:+BPDIV=0  D  Q:BPQUIT=1
 .. I $L(BPSTR_$$DIVNAME^BPSSCRDS(BPDIV))>(BPLEN-4) D  S BPQUIT=1 Q
 ... S BPSTR=$$LJ^BPSSCR02(BPSTR_",...",BPLEN)
 .. S BPSTR=BPSTR_$S(BPSTR]"":", ",1:"")_$$DIVNAME^BPSSCRDS(BPDIV)
 Q BPSTR
 ;
 ;Get the Reject Code
 ;
 ; Input variable -> 0 for All Reject Codes or
 ;                   lookup to BPS NCPDP REJECT CODES (#9002313.93)
 ; Returned value -> ALL or the selected Reject Code
 ; 
GETREJ(REJ) ;
 I REJ="0" S REJ="ALL"
 E  S REJ=$P($G(^BPSF(9002313.93,+REJ,0)),U,2)
 Q REJ
 ;
 ;Print Header 2 Line 1
 ;
 ; Input variable: BPRTYPE -> Report Type (1-7)
 ;
HEADLN1(BPRTYPE) ;
 I (",1,2,3,4,5,7,8,9,")[BPRTYPE W !,"PATIENT NAME",?27,"Pt.ID"
 I (BPRTYPE=1)!(BPRTYPE=4) D  Q
 . W ?35,"ELIG"
 . W ?40,"RX#"
 . W ?52,"REF/ECME#"
 . W ?73,"DATE"
 . W ?83,$J("$BILLED",10)
 . W ?102,$J("$INS RESPONSE",13)
 . W ?122,$J("$COLLECT",10)
 ;
 I BPRTYPE=2 D  Q
 . W ?35,"ELIG"
 . W ?40,"RX#"
 . W ?52,"REF/ECME#"
 . W ?73,"DATE"
 . W ?83,"RELEASED ON"
 . W ?96,"RX INFO"
 . W ?114,"COB"
 . W ?121,"OPEN/CLOSED"
 ;
 I BPRTYPE=3 D  Q
 . W ?35,"RX#"
 . W ?47,"REF/ECME#"
 . W ?68,"DATE"
 . W ?100,$J("$BILLED",10)
 . W ?119,$J("$INS RESPONSE",13)
 ;
 I BPRTYPE=5 D  Q
 . W ?35,"RX#"
 . W ?47,"REF/ECME#"
 . W ?65,"COMPLETED"
 . W ?83,"TRANS TYPE"
 . W ?100,"PAYER RESPONSE"
 . W ?125,"COB"
 ;
 I BPRTYPE=6 D  Q
 . W !,?33,$J("AMOUNT",17)
 . W ?51,$J("RETURNED",17)
 . W ?69,$J("RETURNED",17)
 . W ?87,$J("AMOUNT",17)
 ;
 I BPRTYPE=7 D  Q
 . W ?35,"ELIG"
 . W ?40,"RX#"
 . W ?52,"REF/ECME#"
 . W ?70,"RX INFO"
 . W ?89,"DRUG"
 . W ?118,"NDC"
 ;
 I (BPRTYPE=8) D  Q
 . W ?35,"RX#"
 . W ?47,"REF/ECME#"
 . W ?68,"DATE"
 . W ?78,$J("$BILLED",10)
 . W ?97,$J("$INS RESPONSE",13)
 . W ?122,$J("$COLLECT",10)
 ;
 I BPRTYPE=9 D  Q
 . W ?35,"ELIG"
 . W ?40,"RX#"
 . W ?52,"REF"
 . W ?64,"DATE"
 . W ?84,$J("$DRUG COST",10)
 Q
 ;
 ;Print Header 2 Line 2
 ;
 ; Input variable: BPRTYPE -> Report Type (1-9)
 ; 
HEADLN2(BPRTYPE) ;
 I (BPRTYPE=1)!(BPRTYPE=4) D  Q
 . W !,?4,"DRUG"
 . W ?36,"NDC"
 . I BPRTYPE=1 W ?47,"RELEASED ON"
 . W ?68,"RX INFO"
 . I BPRTYPE=4 W ?92,"COB"
 . I BPRTYPE=1 W ?120,"BILL#",?129,"COB"
 ;
 I BPRTYPE=2 D  Q
 . W !,?3,"CARDHOLD.ID"
 . W ?26,"GROUP ID"
 . W ?41,$J("$BILLED",10)
 . W ?54,"QTY"
 . W ?61,"NDC#"
 . W ?82,"PRESCRIBER ID"
 . W ?98,"NAME"
 ;
 I BPRTYPE=3 D  Q
 . W !,?4,"DRUG"
 . W ?43,"NDC"
 . W ?68,"RX INFO"
 . W ?88,"COB"
 ;
 I BPRTYPE=5 D  Q
 . W !,?4,"DRUG"
 . W ?32,"NDC"
 . W ?47,"RX INFO"
 . W ?69,"INSURANCE"
 . W ?112,"ELAP TIME IN SECONDS"
 ;
 I BPRTYPE=6 D  Q
 .W !,?1,"DATE"
 .W ?15,$J("#CLAIMS",17)
 .W ?33,$J("SUBMITTED",17)
 .W ?51,$J("REJECTED",17)
 .W ?69,$J("PAYABLE",17)
 .W ?87,$J("TO RECEIVE",17)
 .W ?115,$J("DIFFERENCE",17)
 ;
 I BPRTYPE=7 D  Q
 . W !,?3,"CARDHOLD.ID"
 . W ?27,"GROUP ID"
 . W ?46,"CLOSE DATE/TIME"
 . W ?65,"CLOSED BY"
 . W ?93,"CLOSE REASON"
 . W ?126,"COB"
 ;
 I BPRTYPE=8 D  Q
 . W !,?2,"DRUG"
 . W ?38,"RX INFO"
 . W ?54,"INS GROUP#"
 . W ?72,"INS GROUP NAME"
 . W ?125,"BILL#"
 ;
 I BPRTYPE=9 D  Q
 . W !,?4,"DRUG"
 . W ?36,"NDC"
 . W ?47,"RELEASED ON"
 . W ?62,"RX INFO"
 . W ?75,"NON-BILLABLE STATUS"
 Q
 ;
 ;Print Header 2 Line 3
 ;
 ; Input variable: BPRTYPE -> Report Type (1-7)
 ; 
HEADLN3(BPTYP) ;
 I BPTYP=4 D  Q
 . W !,?6,"RELEASED ON"
 . W ?22,"REVERSAL METHOD/RETURN STATUS/REASON"
 ;
 I BPTYP=8 D  Q
 . W !,?4,"$PROVIDER NETWORK"
 . W ?23,"$BRAND DRUG"
 . W ?38,"$NON-PREF FORM"
 . W ?56,"$BRAND NON-PREF FORM"
 . W ?81,"$COVERAGE GAP"
 . W ?96,"$HEALTH ASST"
 . W ?111,"$SPEND ACCT REMAINING"
 Q
 ;
SELEXCEL() ; - Returns whether to capture data for Excel report.
 ; Output: EXCEL = 1 - YES (capture data) / 0 - NO (DO NOT capture data)
 ;
 N EXCEL,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 I ",1,2,3,4,"[(","_BPRTYPE_",") D
 . W !!,"Data fields VA Ingredient Cost, VA Dispensing Fee, Ingredient Cost Paid,",!
 . W "Dispensing Fee Paid and Patient Responsibility (INS) will only be included",!
 . W "when the report is captured for an Excel document.  All additional data fields",!
 . W "may not be present for all reports."
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D HEXC^BPSRPT4"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q "^"
 K DIROUT,DTOUT,DUOUT,DIRUT
 S EXCEL=0 I Y S EXCEL=1
 ;
 ;Display Excel display message
 I EXCEL=1 D EXMSG
 ;
 Q EXCEL
 ;
HEXC ; - 'Do you want to capture data...' prompt
 W !!,"      Enter:  'Y'    -  To capture detail report data to transfer"
 W !,"                        to an Excel document"
 W !,"              '<CR>' -  To skip this option"
 W !,"              '^'    -  To quit this option"
 Q
 ;
 ;Display the message about capturing to an Excel file format
 ; 
EXMSG ;
 I (",2,")'[BPRTYPE D
 . W !!?5,"Before continuing, please set up your terminal to capture the"
 . W !?5,"detail report data. On some terminals, this can  be  done  by"
 . W !?5,"clicking  on the 'Tools' menu above, then click  on  'Capture"
 . W !?5,"Incoming  Data' to save to  Desktop. This  report  may take a"
 . W !?5,"while to run."
 . W !!?5,"Note: To avoid  undesired  wrapping of the data  saved to the"
 . W !?5,"      file, please enter '0;256;999' at the 'DEVICE:' prompt.",!
  E  D
 . W !!?5,"Before continuing, please set up your terminal to capture the"
 . W !?5,"detail report data and save the detail report data in a text file"
 . W !?5,"to a local drive. This report may take a while to run."
 . W !!?5,"Note: To avoid undesired wrapping of the data saved to the file,"
 . W !?5,"      please enter '0;256;99999' at the 'DEVICE:' prompt.",!
 Q
