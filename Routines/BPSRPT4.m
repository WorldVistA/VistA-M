BPSRPT4 ;BHAM ISC/BEE - ECME REPORTS (CONT) ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ; Input Variable -> DFLT = 1 Specific Reject Code
 ;                          0 All Reject Codes
 ;                          
 ; Return Value ->   ptr = pointer to BPS NCPDP REJECT CODES (#9002313.93)
 ;                     0 = All Reject Codes
 ;                     ^ = Exit
 ;
SELREJCD(DFLT) N DIC,DIR,DIRUT,DUOUT,REJ,X,Y
 ;
 S DFLT=$S($G(DFLT)=1:"Specific Reject Code",1:"ALL")
 S DIR(0)="S^S:Specific Reject Code;A:ALL"
 S DIR("A")="Include (S)pecific Reject Code or (A)LL",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S REJ=$S(Y="S":1,Y="A":0,1:Y)
 ;
 ;Check for "^" or timeout
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S (REJ,Y)="^"
 ;
 ;If Specific Reject Code selected, ask prompt
 I $G(REJ)=1 D
 .;
 .;Prompt for entry
 .K X S DIC(0)="QEAM",DIC=9002313.93,DIC("A")="Select Reject Code: "
 .W ! D ^DIC
 .;
 .;Check for "^", timeout, or blank entry
 .I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S (REJ,Y)="^" Q
 .;
 .;If valid entry, setup REJ
 .I +Y>0 S REJ=+Y
 ;
 Q REJ
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
 I (",1,2,3,4,5,7,")[BPRTYPE W !,"PATIENT NAME",?27,"Pt.ID",?35,"RX#",?47,"REF/ECME#"
 I (BPRTYPE=1)!(BPRTYPE=4) D  Q
 . W ?68,"DATE"
 . W ?78,$J("$BILLED",10)
 . W ?97,$J("$INS RESPONSE",13)
 . W ?122,$J("$COLLECT",10)
 ;
 I BPRTYPE=2 D  Q
 . W ?68,"DATE"
 . W ?78,"RELEASED ON"
 . W ?91,"RX INFO"
 . W ?109,"RX COB"
 . W ?116,"OPEN/CLOSED"
 . W ?128,"ELIG"
 ;
 I BPRTYPE=3 D  Q
 . W ?68,"DATE"
 . W ?100,$J("$BILLED",10)
 . W ?119,$J("$INS RESPONSE",13)
 ;
 I BPRTYPE=5 D  Q
 . W ?60,"COMPLETED"
 . W ?78,"TRANS TYPE"
 . W ?95,"PAYER RESPONSE"
 . W ?120,"RX COB"
 ;
 I BPRTYPE=6 D  Q
 . W !,?33,$J("AMOUNT",17)
 . W ?51,$J("RETURNED",17)
 . W ?69,$J("RETURNED",17)
 . W ?87,$J("AMOUNT",17)
 ;
 I BPRTYPE=7 D  Q
 . W ?65,"RX INFO"
 . W ?87,"DRUG"
 . W ?121,"NDC"
 Q
 ;
 ;Print Header 2 Line 2
 ;
 ; Input variable: BPRTYPE -> Report Type (1-7)
 ; 
HEADLN2(BPRTYPE) ;
 I (BPRTYPE=1)!(BPRTYPE=4) D  Q
 . W !,?4,"DRUG"
 . W ?36,"NDC"
 . I BPRTYPE=1 W ?47,"RELEASED ON"
 . W ?68,"RX INFO"
 . I BPRTYPE=4 W ?92,"RX COB"
 . I BPRTYPE=1 W ?115,$J("BILL# RX COB",17)
 ;
 I BPRTYPE=2 D  Q
 . W !,?3,"CARDHOLD.ID"
 . W ?31,"GROUP ID"
 . W ?41,$J("$BILLED",10)
 . W ?54,"QTY"
 . W ?61,"NDC#"
 . W ?82,"DRUG"
 ;
 I BPRTYPE=3 D  Q
 . W !,?4,"DRUG"
 . W ?43,"NDC"
 . W ?68,"RX INFO"
 . W ?88,"RX COB"
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
 . W ?31,"GROUP ID"
 . W ?41,"CLOSE DATE/TIME"
 . W ?59,"CLOSED BY"
 . W ?87,"CLOSE REASON"
 . W ?121,"RX COB"
 Q
 ;
 ;Print Header 2 Line 3
 ;
 ; Input variable: BPRTYPE -> Report Type (1-7)
 ; 
HEADLN3(BPTYP) ;
 D:BPTYP=4
 . W !,?6,"RELEASED ON"
 . W ?22,"REVERSAL METHOD/RETURN STATUS/REASON"
 Q
 ;
SELEXCEL() ; - Returns whether to capture data for Excel report.
 ; Output: EXCEL = 1 - YES (capture data) / 0 - NO (DO NOT capture data)
 ;
 N EXCEL,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
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
 W !!?5,"Before continuing, please set up your terminal to capture the"
 W !?5,"detail report data. On some terminals, this can  be  done  by"
 W !?5,"clicking  on the 'Tools' menu above, then click  on  'Capture"
 W !?5,"Incoming  Data' to save to  Desktop. This  report  may take a"
 W !?5,"while to run."
 W !!?5,"Note: To avoid  undesired  wrapping of the data  saved to the"
 W !?5,"      file, please enter '0;256;999' at the 'DEVICE:' prompt.",!
 Q
