PRSAOTTR ;WCIOFO/JAH-LIST OVERTIME REQUESTS-8/18/98
 ;;4.0;PAID;**43**;Sep 21, 1995
HDR ;
 S VALMHDR(1)="PP "_PRSRPPE_" Week "_PRSRWK_" Overtime Requests for "_PRSRNM
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
OTRQVW ;OVERTIME REQUESTS VIEW
 ; -- main entry point for PRSA VIEW OT REQ which is called by 
 ; the PRSA VIEW OT REQ protocol on the PRSA OVERTIME WARNINGS
 ; List Template protocol menu.
 S PRSOUT=0
 ;
 K ^TMP("PRSAOTR",$J)
 N PRSRREC,PRSRIEN
 ;
 ;ask user to select an overtime warning. The requests on file
 ;associated with that warning will be displayed
 ;
 D PICKWARN
 ;
 Q:PRSOUT
 ;
 ; Call to List Manager to run PRSA OT VIEW REQ template
 D EN^VALM("PRSA VIEW OT REQ")
 S VALMBCK="R"
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
PICKWARN ;procedure asks for one entry on ot warnings list
 ;        and gets the warnings data from the ot warnings file.
 ;
 ;allow selection of only one (1) of the items on the list.
 ;call returns VALMY() array subscripted by list item number.
 D EN^VALM2("","S")
 ;
 S PRSRREC="",PRSRREC=$O(VALMY(0))
 I $G(PRSRREC) D
 .  ;Get ien for 458.6 that matches the list item.
 .  S PRSRIEN=$G(^TMP("PRSAOTW",$J,PRSRREC)) ; Selected ot warn list num
 .  S PRSRREC=$G(^PRST(458.6,PRSRIEN,0)) ; Data on ot warnings list item
 .  S PRSRPPI=$P(PRSRREC,U,3) ;                  Pay period ien
 .  S PRSRPPE=$P($G(^PRST(458,PRSRPPI,0)),U) ;   External pp format
 .  S PRSREMP=$P(PRSRREC,U,2) ;                  Employee 450 ien
 .  S PRSRWK=$P(PRSRREC,U,4) ;                   Week 1 or 2 of pp
 .  S PRSRNM=$P($G(^PRSPC(PRSREMP,0)),U) ;       External emp name
 E  S PRSOUT=1
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
INIT(PPI,PPE,WK,EMP) ;BUILD LIST OF OT REQUESTS FOR EMPLOYEE
 ;Input:  PPI,PPE   - pay period of concern. internal and external YY-PP
 ;        WK   - week (1) or week (2) of pay period
 ;        EMP   - employees internal entry number in file 450.
 ;
 ;local vars:  D1 - 1st day of payperiod-returned by NX^PRSAPPU
 ;             OTREC - a record containing 1 overtime request.
 ;             START,STOP - 1st & last FM days of week (Sun,Sat)
 ;
 ; quit returning 0 if anything is missing.
 Q:$G(PPE)=""!$G(WK)=""!$G(EMP)="" 0
 ;
 ; Loop thru OT/CT requests file x-ref on requested work date &
 ; add employees OT requests within week to the list array.
 ;
 N D1,TOTALOT,START,STOP,OTREC,REQCNT
 ;
 ;get start and stop FM days for one week of the pay period.
 D WEEKRNG^PRSAOTT(PPE,WK,.START,.STOP)
 S (REQCNT,TOTALOT,VALMCNT)=0
 S D1=START-.1
 F  S D1=$O(^PRST(458.2,"AD",EMP,D1)) Q:D1>STOP!(D1="")  D
 .  S OTREC=""
 .  F  S OTREC=$O(^PRST(458.2,"AD",EMP,D1,OTREC)) Q:OTREC=""  D
 ..    I $$OTREQ^PRSAOTT(OTREC) D
 ...     S REQCNT=REQCNT+1
 ...     D LISITEM(OTREC,REQCNT,.TOTALOT)
 I REQCNT=0 D
 .  D SET^VALM10(1,"            NO REQUESTS FOUND")
 .  S VALMCNT=1
 D SET^VALM10(REQCNT+VALMCNT+1,"----------------------------------------------")
 D SET^VALM10(REQCNT+VALMCNT+2,"Current requested overtime total: "_TOTALOT_" hrs.")
 ;
 ; set list manager counter of number of items in list including
 ; lines containing requests, total, and ----'s
 ;
 S VALMCNT=REQCNT+2+VALMCNT
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
LISITEM(IEN,COUNT,OTTOTAL) ;ADD A SINGLE ITEM TO VIEW OT REQ LIST
 N PRSSTAT,PRSHRS,PRSRQDT,OTREC,X
 ;
 ;Get data from OT requests file to build one (1) line in the
 ;list of one employee's ot requests for the week.
 ;
 S OTREC=$G(^PRST(458.2,IEN,0)) ;            Ot/ct/ch requests file rec
 S PRSRQDT=$P(OTREC,U,3) ;                   Requested work date
 S PRSRQDT=$E($$FDATE^VALM1(PRSRQDT),1,12) ; External date
 S PRSHRS=$P(OTREC,U,6) ;                    # of hours requested
 ;                                           Status of requests
 S PRSSTAT=$$EXTERNAL^DILFD(458.2,10,,$P(OTREC,U,8),)
 ;S PRSTL=$P(OTREC,U,9)
 ;
 ;Build one line (X) for list manager with an ot request.
 ; 3rd parameter is name of field on List Template
 ;
 S X=$$SETFLD^VALM1(COUNT,"","NUMBER")
 S X=$$SETFLD^VALM1(PRSHRS,X,"HRSREQ")
 S X=$$SETFLD^VALM1(PRSSTAT,X,"STATUS")
 S X=$$SETFLD^VALM1(PRSRQDT,X,"WORKDATE")
 ;
 ;add line built in X to the list 
 ;
 D SET^VALM10(COUNT,X,COUNT)
 ;
 ;add OT hrs from this line to total OT requests for this list
 ;
 S OTTOTAL=PRSHRS+OTTOTAL
 ;
 ; save the ien of the record in the list global for easier
 ; reference to the acutal data.
 ;
 S ^TMP("PRSAOTR",$J,COUNT)=OTREC
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
