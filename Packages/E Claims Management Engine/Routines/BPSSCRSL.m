BPSSCRSL ;BHAM ISC/SS - ECME SCREEN SORT LIST ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;USER SCREEN
 ;
 ;This software is using PARAMETER TOOLS (see XT*7.3*26) to store user's settings:
 ;PARAMETER DEFINITION NAME="BPS USRSCR" (file #8989.51, IA# 2263)
 ;ENTITY is "USR" , i.e. IEN in ^VA(200  -- see definition for "BPS USRSCR"
 ;INSTANCEs are as follows:
 ;1.01 ONE/ALL USERS --'U' ONE USER, 'A' ALL; Display claims for ONE or ALL users 
 ;1.02 ONE/ALL PATIENTS --'P' FOR ONE PATIENT; 'A' FOR ALL; Display claims for ONE/ALL PATIENTS 
 ;1.03 ONE/ALL RX --'R' FOR ONE RX; 'A' FOR ALL; Display claims for ONE or ALL RX 
 ;1.04 HOURS/DAYS -- 'D' FOR DAYS; 'H' FOR HOURS; Use HOURS or DAYS to specify timeframe 
 ;1.05 TIMEFRAME -- NUMBER Depends on the value of the field "USR SCR HOURS/DAYS" this field will
 ;store the default number of HOURS from NOW or DAYS from TODAY to select claims to display 
 ;1.06 REJECTED/PAYABLE --'R' FOR REJECTS; 'P' FOR PAYABLES; 'U' FOR UNSTRANDED; 'A' FOR ALL; Display Rejects or Payables or Unstranded or ALL claims 
 ;1.07 RELEASED/NOT RELEASED --'R' FOR RELEASED; 'N' FOR NON-RELEASED; 'A' FOR ALL; Display Released Rxs or Non-Released Rxs or ALL 
 ;1.08 CMOP/MAIL/WINDOW --'C' FOR CMOP; 'M' FOR MAIL;'W' FOR WINDOW;'A' FOR ALL; Display CMOP or Mail or Window or ALL Rxs 
 ;1.09 REALTIME/BACKBILL --'R' FOR REALTIME; 'B' FOR BACKBILLS; 'A' FOR ALL; Display RealTime Fills or Backbills or ALL 
 ;1.1 REJECT CODE/ALL --'R' FOR REJECT CODE; 'A' FOR ALL; Display Specific Reject Code or ALL Reject
 ;Codes 0 means ALL Reject Codes otherwise - Reject Code value 
 ;1.11 SPECIFIC/ALL INSURANCES --'I' FOR SPECIFIC INSURANCE(S);'A' FOR ALL; Display Specific Insurance Company(s) or All null - ALL otherwise - pointer to INSURANCE COMPANY file #36 
 ;1.12 SORT LIST --'T' FOR TRANSACTION DATE;'D' FOR DIVISION; 'I' FOR INSURANCE; 'C' FOR REJECT CODE; 
 ;'P' FOR PATIENT NAME -- 'N' FOR DRUG NAME; 'B' FOR BILL TYPE (BB/P2/RT); 'L' FOR FILL LOCATION;
 ;'R' FOR RELEASED/NON-RELEASED -- 'A' FOR ACTIVE/DISCONTINUED; the field used to sort claims in the list 
 ;1.13 ALL ECME PHARMACY DIVISIONS --'D' FOR DIVISION; 'A' FOR ALL; 
 ;1.14 SELECTED INSURANCE -- Single, or multiple, insurance(s) to select claims for the User Screen, to store INSURANCE COMPANY pointer (#36) 
 ;1.15 SELECTED REJECTED CODE --POINTER TO BPS NCPDP REJECT CODES FILE (#9002313.93) Reject code selected by the user to filter claims.
 ;1.16 SELECTED USER -- POINTER TO NEW PERSON FILE (#200) Selected user for the user screen 
 ;1.17 SELECTED PATIENT -- POINTER TO PATIENT FILE (#2) Selected patient for the User Screen 
 ;1.18 SELECTED RX -- POINTER TO PRESCRIPTION FILE (#52) Selected RX 
 ;2    ECME PHARMACY DIVISION -- the list of POINTERs TO BPS PHARMACIES FILE (#9002313.56) separated by "^"
 ;2.01 ELIGIBILITY TYPE --'V' FOR VETERAN;'T' FOR TRICARE;'C' FOR CHAMPVA;'A' FOR ALL; Display claims for specific Eligibility Type or ALL 
 ;2.02 OPEN/CLOSED/ALL --'O' OPEN CLAIMS;'C' CLOSED CLAIMS;'A' FOR ALL; Display Open, Closed, or ALL claims 
 ;2.03 SUBMISSION TYPE --'B' BILLING REQUESTS;'R' REVERSALS;'A' FOR ALL; Display specific submission type claims or ALL 
 ;2.04 INSURANCES -- List of POINTERs to the INSURANCE COMPANY FILE (#36) separated by ";"
 ;should start and end with ";", example: ";4;5;"
 ;
 ;NOTE: use D ^XPAREDIT to add/edit values
 ;
 ;*****
SL ;
 D FULL^VALM1
 W @IOF
 K BPARR
 I +$G(DUZ)=0 D ERRMSG^BPSSCRCV("Unknown User") Q
 N BPDUZ7
 S BPDUZ7=+DUZ
 ;always get current profile from the file
 ;D READPRFP(.BPARR,+DUZ)
 D READPROF(.BPARR,+BPDUZ7)
 D SAVEVIEW^BPSSCR01(.BPARR)
 ;edit current profile
 D EDITPROF(.BPARR,.BPDUZ7)
 D SAVEVIEW^BPSSCR01(.BPARR)
 ;save it if necessary only for SORT LIST field
 ;(so we used a separate array for this and save it only)
 N BPSRT S BPSRT(1.12)=BPARR(1.12)
 D ENDEDIT(.BPSRT,+BPDUZ7)
 D SAVEVIEW^BPSSCR01(.BPARR)
 ;redraw screen
 D REDRAW^BPSSCRUD("Updating screen...")
 Q
 ;
 ;input:
 ;BPARRAY - array that all settings:  
 ;   in the form BPARRAY(instance in "BPS USRSCR" parameter tool entry) = value
 ;BPDUZ7 - DUZ
EDITPROF(BPARR,BPDUZ7) ;
 N BP1
 N BPRET
 N BPSTR
 S BPSTR="S^T:TRANSACTION DATE;D:DIVISION;I:INSURANCE;C:REJECT CODE;P:PATIENT NAME;N:DRUG NAME;B:BILL TYPE (BB/P2/RT);L:FILL LOCATION;R:RELEASED/NON-RELEASED;A:ACTIVE/DISCONTINUED"
 I $$EDITFLD^BPSSCRCV(1.12,+BPDUZ7,BPSTR,"ENTER SORT TYPE","TRANSACTION DATE",.BPARR)=-1 S BPDUZ7=0 Q
 Q
 ;
 ;input:
 ;BPARRAY - array that all settings:  
 ;in the form BPARRAY(instance in "BPS USRSCR" parameter tool entry) = value
 ;BPDUZ7 - DUZ
 ;
ENDEDIT(BPARRAY,BPDUZ7) ;
 I $$PROMPT^BPSSCRCV("S^Y:YES;N:NO","DO YOU WANT TO SAVE THIS VIEW AS YOUR PREFERRED VIEW (Y/N)?","")="Y" D
 . D FILEALL^BPSSCRCV(.BPARRAY,BPDUZ7)
 Q
 ;read profile information (used in other routines as well)
 ;input:
 ;BPDUZ7 - DUZ
 ;input/output:
 ;BPARRAY - to return back profile information, as reference
 ;see description in the top of the routine
READPROF(BPARRAY,BPDUZ7) ;
 N RETV,RETARR,BPFLDNO,BPDIV,BP1
 N RECIENS
 S RECIENS=BPDUZ7_","
 F BPFLDNO=1.01,1.02,1.03,1.04,1.05,1.06,1.07,1.08,1.09,1.1,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,2.01,2.02,2.03,2.04 D
 . S RETV=$$GETPARAM(BPFLDNO,+BPDUZ7)
 . S BPARRAY(BPFLDNO)=RETV
 I BPARRAY(1.13)="D" D
 . S BPARRAY("DIVS")=$$GETPARAM(2,+BPDUZ7)
 I BPARRAY(1.11)="I" D
 . S BPARRAY("INS")=$$GETPARAM(2.04,+BPDUZ7)
 Q
 ;
SORTTYPE(BPSTYPE) ;
 Q:(BPSTYPE="T") "Transaction Date"
 Q:(BPSTYPE="D") "ECME division"
 Q:(BPSTYPE="I") "Insurance"
 Q:(BPSTYPE="C") "Reject Code"
 Q:(BPSTYPE="P") "Patient Name"
 Q:(BPSTYPE="N") "Drug Name"
 Q:(BPSTYPE="B") "Claim's Origin (BB/P2/RT)"
 Q:(BPSTYPE="L") "Fill Location"
 Q:(BPSTYPE="R") "Released/Non-released"
 Q:(BPSTYPE="A") "Active/Discontinued"
 Q ""
 ;
 ;
GETPARAM(BPFLDNO,BPDUZ) ;
 Q $$GET^XPAR(BPDUZ_";VA(200,","BPS USRSCR",BPFLDNO,"I")
 ;
 ;save value of the parameter
SAVEPAR(BPFLDNO,BPDUZ,BPVAL) ;
 D EN^XPAR(BPDUZ_";VA(200,","BPS USRSCR",BPFLDNO,BPVAL,.BPERR)
 I BPERR'="0" W !,BPERR,! Q 0
 Q 1
 ;
