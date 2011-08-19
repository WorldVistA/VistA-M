BPSSCRCV ;BHAM ISC/SS - ECME SCREEN CHANGE VIEW ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ;1.04 HOURS/DAYS -- 'D' FOR DAYS; 'H' FOR HOURS; Use HOURS or DAYS to specify timeframe 
 ;1.05 TIMEFRAME -- NUMBER Depends on the value of the field "USR SCR HOURS/DAYS" this field will
 ;store the default number of HOURS from NOW or DAYS from TODAY to select claims to display 
 ;1.06 REJECTED/PAYABLE --'R' FOR REJECTS; 'P' FOR PAYABLES 'A' FOR ALL; Display Rejects or Payables or ALL claims 
 ;1.07 RELEASED/NOT RELEASED --'R' FOR RELEASED; 'N' FOR NON-RELEASED; 'A' FOR ALL; Display Released Rxs or Non-Released Rxs or ALL 
 ;1.08 CMOP/MAIL/WINDOW --'C' FOR CMOP; 'M' FOR MAIL;'W' FOR WINDOW;'A' FOR ALL; Display CMOP or Mail or Window or ALL Rxs 
 ;1.09 REALTIME/BACKBILL --'R' FOR REALTIME; 'B' FOR BACKBILLS; 'A' FOR ALL; Display RealTime Fills or Backbills or ALL 
 ;1.1 REJECT CODE/ALL --'R' FOR REJECT CODE; 'A' FOR ALL; Display Specific Reject Code or ALL Reject
 ;Codes 0 means ALL Reject Codes otherwise - Reject Code value 
 ;1.11 SPECIFIC/ALL INSURANCES --'I' FOR SPECIFIC INSURANCE(S);'A' FOR ALL; Display Specific Insurance Company(s) or All null - ALL otherwise - pointer to INSURANCE COMPANY file #36 
 ;1.12 SORT LIST --'T' FOR TRANSACTION DATE;'D' FOR DIVISION; 'I' FOR INSURANCE; 'C' FOR REJECT CODE; 
 ;'P' FOR PATIENT NAME -- 'N' FOR DRUG NAME; 'B' FOR BILL TYPE (BB/RT); 'L' FOR FILL LOCATION;
 ;'R' FOR RELEASED/NON-RELEASED -- 'A' FOR ACTIVE/DISCONTINUED; the field used to sort claims in the list 
 ;1.13 ALL ECME PHARMACY DIVISIONS --'D' FOR DIVISION; 'A' FOR ALL; 
 ;1.14 SELECTED INSURANCE -- Single, or multiple, insurance(s) to select claims for the User Screen, to store INSURANCE COMPANY pointer (#36) 
 ;1.15 SELECTED REJECTED CODE --POINTER TO BPS NCPDP REJECT CODES FILE (#9002313.93) Reject code selected by the user to filter claims.
 ;1.16 SELECTED USER -- POINTER TO NEW PERSON FILE (#200) Selected user for the user screen 
 ;1.17 SELECTED PATIENT -- POINTER TO PATIENT FILE (#2) Selected patient for the User Screen 
 ;1.18 SELECTED RX -- POINTER TO PRESCRIPTION FILE (#52) Selected RX 
 ;2    ECME PHARMACY DIVISION -- the list of POINTERs TO BPS PHARMACIES FILE (#9002313.56) separated by ";"
 ;should start and end with ";", example: ";4;5;"
 ;2.01 ELIGIBILITY TYPE --'V' FOR VETERAN;'T' FOR TRICARE;'A' FOR ALL; Display claims for specific Eligibility Type or ALL (BNT BPS*1.0*7)
 ;2.02 OPEN/CLOSED/ALL --'O' OPEN CLAIMS;'C' CLOSED CLAIMS;'A' FOR ALL; Display Open, Closed, or ALL claims (BNT BPS*1.0*7)
 ;2.03 SUBMISSION TYPE --'B' BILLING REQUESTS;'R' REVERSALS;'A' FOR ALL; Display specific submission type claims or ALL (BNT BPS*1.0*7)
 ;2.04 INSURANCES -- List of POINTERs to the INSURANCE COMPANY FILE (#36) separated by ";"
 ;should start and end with ";", example: ";4;5;"
 ;NOTE: use D ^XPAREDIT to add/edit values
 ;
 ;*****
 ;
CV ;
 D FULL^VALM1
 W @IOF
 K BPARR
 I +$G(DUZ)=0 D ERRMSG^BPSSCRCV("Unknown User") Q
 N BPDUZ7
 S BPDUZ7=+DUZ
 ;always get current profile from the file
 D READPROF^BPSSCRSL(.BPARR,BPDUZ7)
 D SAVEVIEW^BPSSCR01(.BPARR)
 ;edit current profile
 D EDITPROF(.BPARR,.BPDUZ7)
 ;ask user if need to save everything in USR PROFILE file 
 ;(except SORT LIST field)
 N BPSRT S BPSRT=BPARR(1.12)
 K BPARR(1.12)
 D ENDEDIT^BPSSCRSL(.BPARR,+BPDUZ7)
 S BPARR(1.12)=BPSRT
 D SAVEVIEW^BPSSCR01(.BPARR)
 S VALMBG=1
 D REDRAW^BPSSCRUD("Updating screen...")
 Q
 ;edit user profile for CHANGE VIEW
EDITPROF(BPARR,BPDUZ7) ;
 I +$G(DUZ)=0 D ERRMSG("Unknown User") Q
 N BP1,BPTF,BPQ,BPINP
 N BPRET
 N DIR,DR,DIE,DA
 ;get ONE/ALL USERS?
 ;EDITFLD(FILENO,FLDNO,RECIEN,CODESET,PRMTMSG,DFLTCODE)  ;
 S BPRET=$$DS^BPSSCRDS(.BPARR,+BPDUZ7) ;get divisions
 Q:BPRET=-2  ;quit due to timeout or ^
 Q:$$EDITFLD(2.01,+BPDUZ7,"S^V:VETERAN;T:TRICARE;A:ALL","Select Certain Eligibility Type or (A)ll","V",.BPARR)=-1
 S BPQ=0 F  D  Q:BPQ'=0
 . S BPINP=$$EDITFLD(1.01,+BPDUZ7,"S^U:ONE USER;A:ALL","Display One ECME (U)ser or (A)LL","ALL",.BPARR)
 . S:BPINP=-1 BPQ=-1 S:$P(BPINP,U,2)="A" BPQ=1 I BPQ'=0 Q
 . S BPINP=$$EDITFLD(1.16,+BPDUZ7,"P^VA(200,","Select User","",.BPARR)
 . S:BPINP=-1 BPQ=-1 S:$P(BPINP,U,2)'="" BPQ=1 I BPQ'=0 Q
 Q:BPQ=-1  ;quit due to timeout or ^
 S BPQ=0 F  D  Q:BPQ'=0
 . S BPINP=$$EDITFLD(1.02,+BPDUZ7,"S^P:ONE PATIENT;A:ALL","Display One (P)atient or (A)LL","ALL",.BPARR)
 . S:BPINP=-1 BPQ=-1 S:$P(BPINP,U,2)="A" BPQ=1 I BPQ'=0 Q
 . S BPINP=$$EDITFLD(1.17,+BPDUZ7,"P^DPT(","Select Patient","",.BPARR)
 . S:BPINP=-1 BPQ=-1 S:$P(BPINP,U,2)'="" BPQ=1 I BPQ'=0 Q
 Q:BPQ=-1  ;quit due to timeout or ^
 S BPQ=0 F  D  Q:BPQ'=0
 . S BPINP=$$EDITFLD(1.03,+BPDUZ7,"S^R:ONE RX;A:ALL","Display One (R)x or (A)LL","ALL",.BPARR)
 . S:BPINP=-1 BPQ=-1 S:$P(BPINP,U,2)="A" BPQ=1 I BPQ'=0 Q
 . S BPINP=$$EDITRX^BPSSCRPR(1.18,+BPDUZ7,"Select RX","",.BPARR)
 . S:BPINP=-1 BPQ=-1 S:$P(BPINP,U,2)'="" BPQ=1 I BPQ'=0 Q
 Q:BPQ=-1  ;quit due to timeout or ^
 S BPINP=$$EDITFLD(1.04,+BPDUZ7,"S^D:DAYS;H:HOURS","Activity Timeframe (H)ours or (D)ays","DAYS",.BPARR)
 I BPINP=-1 Q  ;quit due to timeout or ^
 S BPTF=$P(BPINP,U,2)
 Q:$$EDITFLD(1.05,+BPDUZ7,"N^1:999:0","Activity Timeframe Value",$S(BPTF="H":24,1:7),.BPARR)=-1
 Q:$$EDITFLD(2.02,+BPDUZ7,"S^O:OPEN CLAIMS;C:CLOSED CLAIMS;A:ALL","Select Open/Closed or All Claims","O",.BPARR)=-1
 Q:$$EDITFLD(2.03,+BPDUZ7,"S^B:BILLING REQUESTS;R:REVERSALS;A:ALL","Select Submission Type","A",.BPARR)=-1
 Q:$$EDITFLD(1.06,+BPDUZ7,"S^R:REJECTS;P:PAYABLES;A:ALL","Display (R)ejects or (P)ayables or (A)LL","REJECTS",.BPARR)=-1
 Q:$$EDITFLD(1.07,+BPDUZ7,"S^R:RELEASED;N:NON-RELEASED;A:ALL","Display (R)eleased Rxs or (N)on-Released Rxs or (A)LL","RELEASED",.BPARR)=-1
 Q:$$EDITFLD(1.08,+BPDUZ7,"S^C:CMOP;M:MAIL;W:WINDOW;A:ALL","Display (C)MOP or (M)ail or (W)indow or (A)LL","ALL",.BPARR)=-1
 Q:$$EDITFLD(1.09,+BPDUZ7,"S^R:REALTIME;B:BACKBILLS;A:ALL","Display (R)ealTime Fills or (B)ackbills or (A)LL","ALL",.BPARR)=-1
 S BPQ=0 F  D  Q:BPQ'=0
 . S BPINP=$$EDITFLD(1.1,+BPDUZ7,"S^R:REJECT CODE;A:ALL","Display Specific (R)eject Code or (A)LL","ALL",.BPARR)
 . S:BPINP=-1 BPQ=-1 S:$P(BPINP,U,2)="A" BPQ=1 I BPQ'=0 Q
 . S BPINP=$$EDITFLD(1.15,+BPDUZ7,"P^BPSF(9002313.93,","Select Reject Code","",.BPARR)
 . S:BPINP=-1 BPQ=-1 S:$P(BPINP,U,2)'="" BPQ=1 I BPQ'=0 Q
 Q:BPQ=-1  ;quit due to timeout or ^
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
 ;if data then use it, otherwise use data from parameter
 I $L($G(RETV))>0 S DFLTVAL=RETV E  S DFLTVAL=$G(DFLTVAL)
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
 N BPFLD,BP2
 S BPFLD=0
 F  S BPFLD=+$O(BPARRAY(BPFLD)) Q:+BPFLD=0  D
 . I $$SAVEPAR^BPSSCRSL(BPFLD,+BPDUZ7,$G(BPARRAY(BPFLD)))
 I $$SAVEPAR^BPSSCRSL(2,BPDUZ7,$G(BPARRAY("DIVS")))
 I $$SAVEPAR^BPSSCRSL(2.04,BPDUZ7,$G(BPARRAY("INS")))
 Q
