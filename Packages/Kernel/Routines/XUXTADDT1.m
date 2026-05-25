XUXTADDT1 ;ESL/JAC/CM - UTL Date subroutines & extrinsics #1 ; 06/26/2020@9:30
 ;;8.0;KERNEL;**807**;Oct 16, 2024;Build 56;
 ;
 ;
 ; External API'S
 ;
 ; XUXTAD API's
CENTER(AXUXTADTEXT,AXUXTADLF,AXUXTADRM,AXUXTADRVIDEO) D CENTER^XUXTADPRT1($G(AXUXTADTEXT),$G(AXUXTADLF),$G(AXUXTADRM),$G(AXUXTADRVIDEO)) Q
 ;
 ; Helper/FileMan/ScreenMan API's
FMADD(AX,AD,AH,AM,AS) Q $$FMADD^XLFDT(AX,AD,AH,AM,AS)
FMDIFF(AX1,AX2,AX3) Q $$FMDIFF^XLFDT(AX1,AX2,AX3)
FMTE(AY,AF) Q $$FMTE^XLFDT(AY,AF)
FMTH(AX,AF) Q $$FMTH^XLFDT(AX,AF)
CNVDT D ^%DT Q
 ;
 ;-- Integration Control Registrations
 ; Reference to ^%DT in ICR #10003
 ; Reference to ^DD("DD" in ICR #10017
 ; Reference to $$FMADD^XLFDT in ICR #10103
 ; Reference to $$FMDIFF^XLFDT in ICR #10103
 ; Reference to $$FMTE^XLFDT in ICR #10103
 ; Reference to $$FMTH^XLFDT in ICR #10103
 ;
DATE(XUXTADDATE,XUXTADTIME,XUXTADSECS,XUXTADFORMAT) ; Returns the DATE in external format.
 ;-- Input:
 ;   DATE (required) date/time in FM format
 ;   XUXTADTIME (optional)  1 ; when time should also be returned ; 17 chars
 ;                    0 ; when date is to appear w/o time   ; 11 chars
 ;                        this is the default to save space
 ;   XUXTADSECS (optional)  1 ; include seconds on output ; Uses....20 chars
 ;                    0 ; do NOT include seconds on output
 ;   XUXTADFORMAT (optional)
 ;                    0 ; Default format of MMM DD YYYY HH:MM:SS
 ;                    1 ; Changes format to MM/DD/YY HH:MM:SS
 ;                        which is a space saver, especially when
 ;                        time and/or seconds are not returned
 ;-- Output format:
 ;   This will be in human readable external format, but will vary
 ;   depending if the optional XUXTADFORMAT input parameter is passed.
 ;   Examples are included below for clarity.
 ;
 NEW XUXTADVAL
 ;
 ; Set the default value of all the optional parameters
 ;
 S XUXTADFORMAT=$G(XUXTADFORMAT,0) ; Default date format of MMM DD YYYY HH:MM:SS
 S XUXTADTIME=$G(XUXTADTIME,0) ; Defaults to returning date w/o time
 S XUXTADSECS=$G(XUXTADSECS,0) ; Default to no seconds returned
 ;
 ; Set the appropriate date based upon the XUXTADFORMAT parameter
 ;
 I XUXTADFORMAT=0 D  ; default
 . S XUXTADDATE=$$FMTE(XUXTADDATE) ; yyymmdd.hhmmss to MMM dd, yyyy@hh:mm:ss
 I XUXTADFORMAT=1 D  ; Override default XUXTADFORMAT (with MM/DD/YY)
 . S XUXTADDATE=$$FMTE(XUXTADDATE,"2Z") ;yyymmdd.hhmmss to MM/DD/YY@hh:mm:ss
 ;
 S XUXTADDATE=$TR(XUXTADDATE,"@"," ") ;........................ See step 1 above
 S:XUXTADFORMAT=0&(XUXTADDATE[",") XUXTADDATE=$E(XUXTADDATE,1,6)_$E(XUXTADDATE,8,$L(XUXTADDATE)) ; step 2
 I XUXTADSECS=0 D  ; Optionally does not return seconds
 . S XUXTADDATE=$P(XUXTADDATE,":",1,2) ;............................ step 3 above
 ;
 SET XUXTADVAL=XUXTADDATE
 I XUXTADTIME=0 D  ; Strip off time from the date based upon XUXTADFORMAT
 . I XUXTADFORMAT=0 SET XUXTADVAL=$E(XUXTADVAL,1,11) ; Strip off time: MMM DD YYYY
 . I XUXTADFORMAT=1 SET XUXTADVAL=$E(XUXTADVAL,1,8) ;. Strip off time: MM/DD/YY
 QUIT XUXTADVAL ; DATE
 ;
DAYSAGO(XUXTADDATE) ; Returns: Date (in external mm/dd/yy format) and the
 ;             number of days which have passed, unless the
 ;             input XUXTADDATE variable is null, then <Empty> will be
 ;             returned.
 ;-- Input:
 ;   XUXTADDATE ; Required ; Date or date/time in internal FM format.
 ;     Note: The input parameter XUXTADDATE should be passed by VALUE
 ;           and not passed by REFERENCE.
 ;
 ;-- Output format:
 ;   mm/dd/yy (n days ago), where 'n' is the number of days ago.
 ;   If the number of days ago is 1 'n' will display as 'yesterday'
 ;   instead of an integer.  If the number of days ago is 0, then
 ;   'today' will show instead of an integer.  If the date is one
 ;   date in the future 'tomorrow' will show instead of an integer.
 ;   See the examples of these formats included below for
 ;   clarification.
 ;
 NEW XUXTADDAYS,XUXTADDATEX
 ;
 S XUXTADDATE=$P(XUXTADDATE,".")
 S XUXTADDATEX=$$FMTE(XUXTADDATE,"2Z") ; External format mm/dd/yy
 ;
 ; Account for a date that is yesterday or today
 I XUXTADDATE=DT SET XUXTADDATEX=XUXTADDATEX_" (today)" QUIT XUXTADDATEX
 I XUXTADDATE=$$FMADD(DT,-1) D  QUIT XUXTADDATEX ;
 . SET XUXTADDATEX=XUXTADDATEX_" (yesterday)"
 ;
 ; Account for a date that is in the future
 I XUXTADDATE=$$FMADD(DT,1) D  QUIT XUXTADDATEX ;
 . SET XUXTADDATEX=XUXTADDATEX_" (tomorrow)"
 I XUXTADDATE>$$FMADD(DT,1) D  QUIT XUXTADDATEX ;
 . S XUXTADDAYS=$$FMDIFF(DT,XUXTADDATE)*-1 ;Change negative to positive
 . SET XUXTADDATEX=XUXTADDATEX_" (in "_XUXTADDAYS_" days)"
 ;
 ; Account for a date that is in the past
 I XUXTADDATE D  Q XUXTADDATEX ; Concatenate number of days ago
 . SET XUXTADDATEX=XUXTADDATEX_" ("_$$FMDIFF(DT,XUXTADDATE)_" days ago)"
 ;
 ; Account for a date that is the null string
 I XUXTADDATE="" SET XUXTADDATE="<Empty>"
 QUIT XUXTADDATE ; XUXTADDAYSAGO
 ;
DTBEG(XUXTADDTBEG) ; Return: Beginning date for date range search loop.
 ;-- Input:
 ;   XUXTADDTBEG ; Required ;-- FM internal date (with or without time)
 ;
 ;-- Output format:
 ;   yyymmdd.hhmmss
 ;
 ;-- Intended use:
 ;   Use this call to initialize your date variable before $Ordering
 ;   through a date x-ref for screening records based upon a
 ;   date range.
 ;
 ;   The companion API for this entry point: $$DTEND^XUXTADDT1
 ;
 I XUXTADDTBEG="" QUIT ""
 I $P(XUXTADDTBEG,".",2) Q $$FMADD(XUXTADDTBEG,0,0,0,-1) ; 1 sec ago
 QUIT $$FMADD(XUXTADDTBEG,-1)_.24 ; Day before at midnight ; XUXTADDTBEG
 ;
DTEND(XUXTADDTEND) ; Return: Maximum ending date for date range search loop.
 ;-- Input:
 ;   XUXTADDTBEG ; Required ;-- FM internal date (with or without time)
 ;
 ;-- Output format:
 ;   yyymmdd.hhmmss
 ;
 ;-- Intended use:
 ;   Use this call to initialize your maximum date variable
 ;   (i.e. XUXTADDTMAX) before $Ordering through a date x-ref.
 ;   Q:XUXTADDATE=""!(XUXTADDATE>XUXTADDTMAX)
 ;
 ;   Note: When the input parameter XUXTADDTEND passes a time with the date
 ;         this utility will append 99 to the end of that internal
 ;         date format, because some data dictionary date fields do
 ;         not allow seconds on input and others do.
 ;
 ;   The companion API for this entry point: $$DTBEG^XUXTADDT1
 ;
 ;-- Examples:
 ;   S XUXTADDATE=$$DTEND^XUXTADDT1(DT) ;         Set XUXTADDATE = today @ midnight
 ;   S XUXTADDATE=$$DTEND^XUXTADDT1(3050604.24) ;     XUXTADDATE = 3050604.2499
 ;   S XUXTADDATE=$$DTEND^XUXTADDT1(3050604.06) ;     XUXTADDATE = 3051231.0699
 ;   S XUXTADDATE=$$DTEND^XUXTADDT1(3051231.235959) ; XUXTADDATE = 3051231.23595999
 ;
 I XUXTADDTEND="" QUIT ""
 ;
 ; When input XUXTADDTEND contains the time, append 99 to the end
 ; of this date because in case seconds are not allowed on input.
 ;
 I $P(XUXTADDTEND,".",2) QUIT XUXTADDTEND_"99"  ;-> End date/time = XUXTADDTMAX
 QUIT XUXTADDTEND_.24 ; End date at midnight ; XUXTADDTEND
 ;
DTSOK(XUXTADDTBEG,XUXTADDTEND) ; Extrinsic Return: 1 if end date => begin date.
 ;-- Input:
 ;   XUXTADDTBEG ; Required ; Internal FM begin date for date range
 ;   XUXTADDTEND ; Required ; Internal FM end   date for date range
 ;-- Output:
 ;   The extrinsic function returns a '1' if the date range is valid.
 ;   If the date range is invalid 'null' is returned and the user will
 ;   see the following error message displayed:
 ;                 Error:  From Date > To Date
 ;
 ;-- Intended use:
 ;   This call allows the developer to standardize the verification
 ;   of the beginning and ending dates received from a user when
 ;   a from - to date range is requested on input.  If the XUXTADDTEND
 ;   is less than the XUXTADDTBEG the user will receive the following
 ;   error message:
 ;                 Error:  From Date > To Date
 ;   At this point the developer can branch back to prompt the
 ;   user to try to enter the date range again.  This makes this
 ;   API call a good companion call to use after calls to the
 ;   $$DTBEG^XUXTADDT1 and $$XUXTADDTEND^XUXTADDT1 calls.
 ;
 NEW XUXTADVAL
 ;
 SET XUXTADVAL=1
 I XUXTADDTEND<XUXTADDTBEG D  ;
 . W $C(7)
 . D CENTER("Error:  From Date > To Date",2,80,1)
 . SET XUXTADVAL=""
 QUIT XUXTADVAL ; DTSOK
 ;
GETDT(XUXTADPROMPT,XUXTADTYPE,XUXTADDEFAULT,XUXTADRESTRICT) ; Prompt for date, & return array
 ;-- Input:
 ;
 ;   XUXTADPROMPT..: Optional, but I suggest passing it
 ;             for example: "Begin Date: "
 ;   XUXTADTYPE....: "B"=Returns XUXTADDTBEG(array)  ;--> Default; (See Returns)
 ;             "E"=Returns XUXTADDTEND(array)
 ;   XUXTADDEFAULT.: CB=Start-of-CalYr   CE=End-of-CalYr   T=Today
 ;             FB=Start-of-FY      FE=End-of-FY      -or- any date
 ;   XUXTADRESTRICT: Optional, any combination of the following is allowed:
 ;             F ; Future dates are assumed
 ;             P ; Past.. dates are assumed
 ;             R ; Requires time input
 ;             S ; Seconds should be returned
 ;
 ;   Note: The system variable DT is expected to be defined.
 ;
 ;-- Output (is in the format of an array, as follows):
 ;
 ;   XUXTADDTBEG("E")=External  -or-  XUXTADDTEND("E")  ; (See XUXTADTYPE)
 ;   XUXTADDTBEG("I")=Internal        XUXTADDTEND("I")
 ;   XUXTADDTBEG("$H")=$H             XUXTADDTEND("$H")
 ;   XUXTADQUIT ; 0 ; when a successful date was entered
 ;            1 ; if the user enters '^' to exit
 ;                or if DT (the system date) is undefined
 ;-- Note...: The external date or date/time is compressed, for example:
 ;                       mm/dd/yy -or- mm/dd/yy hh:mm (for printouts)
 ;          If XUXTADRESTRICT contains a 'S' seconds are included.
 ;
 NEW %DT,A1,DDH,DTOUT,DUOUT,X,Y
 ;
 S XUXTADQUIT=0
 ; Quit, if system date for today (DT) is not defined, return XUXTADQUIT=1
 I $L($G(DT))'=7 S XUXTADQUIT=1 Q
 ;
 ; Get the XUXTADDEFAULT date for presentation in the prompt
 S XUXTADDEFAULT=$G(XUXTADDEFAULT)
 I XUXTADDEFAULT="CB" S XUXTADDEFAULT=$E(DT,1,3)_"0101"
 I XUXTADDEFAULT="CE" S XUXTADDEFAULT=$E(DT,1,3)_"1231"
 I XUXTADDEFAULT="FB" S XUXTADDEFAULT=$E(DT,1,3)-$S($E(DT,4,5)<10:1,1:"")_"1001"
 I XUXTADDEFAULT="FE" S XUXTADDEFAULT=$E(DT,1,3)+$S($E(DT,4,5)>9:1,1:"")_"0930"
 I XUXTADDEFAULT="T" S XUXTADDEFAULT=DT
 ;
 ; Setup call to FM utility ^%DT to prompt for date
 ;
 S %DT("A")=$G(XUXTADPROMPT) ; Set date prompting text
 S %DT="AE" ; (A)sk (E)cho
 I $G(XUXTADRESTRICT)["F" S %DT=%DT_"F" ; (F)uture dates are assumed
 I $G(XUXTADRESTRICT)["P" D  ; (P)ast dates are assumed
 . S %DT=%DT_"P" ;... (P)ast dates are assumed
 . S %DT(0)="-"_DT ;.  Up to and including today
 I $G(XUXTADRESTRICT)["R" S %DT=%DT_"R" ; (R)equires time
 I %DT'["R" S %DT=%DT_"T" ;(T)ime allow but not required
 I %DT'["R",%DT'["S",%DT'["T" S %DT=%DT_"T" ;(T)ime allow but not required
 I $G(XUXTADRESTRICT)["S" S %DT=%DT_"S" ; (S)econds should be returned
 I XUXTADDEFAULT S Y=XUXTADDEFAULT X ^DD("DD") S %DT("B")=Y
 ;
 D ^%DT I Y<1 SET XUXTADQUIT=1 Q
 ;
 ; Populate either XUXTADDTBEG or XUXTADDTEND output array, depends on XUXTADTYPE
 I $G(XUXTADTYPE)'="E" S XUXTADTYPE="B" ; Set XUXTADTYPE default
 ;
 I XUXTADTYPE="B" D  ; Begin date
 . SET XUXTADDTBEG("I")=Y
 . SET XUXTADDTBEG("$H")=$$FMTH(XUXTADDTBEG("I"))
 . SET XUXTADDTBEG("E")=$$DATE(XUXTADDTBEG("I"),1,$S(%DT["S":1,1:0))
 . W "   ",XUXTADDTBEG("E") ; Echo date in external format
 ;
 I XUXTADTYPE="E" D  ; End   date
 . SET XUXTADDTEND("I")=Y
 . SET XUXTADDTEND("$H")=$$FMTH(XUXTADDTEND("I"))
 . SET XUXTADDTEND("E")=$$DATE(XUXTADDTEND("I"),1)
 . W "   ",XUXTADDTEND("E") ; Echo date in external format
 Q  ; GETDT
 ;
GETDTS(XUXTADDATETXT) ; Prompt user for date range
 ;-- Input:
 ;   XUXTADDATETXT ; Required ; Date field text
 ;
 ;-- Output:
 ;   XUXTADDTBEG=Begindate -1 second (time can be overridden by user input)
 ;   XUXTADDTEND=Enddate at midnight (time can be overridden by user input)
 ;   XUXTADDTBEG(array) - reference comments in GETDT^XUXTADDT1
 ;   XUXTADDTEND(array) - reference comments in GETDT^XUXTADDT1
 ;   XUXTADQUIT ; 0 ; when a successful date range was entered
 ;            1 ; if the user enters '^' to exit
 ;
 ;-- Intended use:
 ;   This utility is designed to make it very easy for the developer
 ;   to prompt for a data range, whether it be an admission date
 ;   range, an appointment date range, etc.  The output will be
 ;   returned in an array format in the format of an XUXTADDTBEG array
 ;   and the format of an XUXTADDTEND array.  The subscripts for the
 ;   output date arrays offer the following three date formats":
 ;
 ;     XUXTADDTBEG("E")   ; For (E)xternal human readable date format
 ;     XUXTADDTBEG("I")   ; For (I)nternal FM date format
 ;     XUXTADDTBEG("$H")  ; For horolog date format
 ;
 ;     XUXTADDTEND("E")   ; For (E)xternal human readable date format
 ;     XUXTADDTEND("I")   ; For (I)nternal FM date format
 ;     XUXTADDTEND("$H")  ; For horolog date format
 ;
GETDTS1 ; Branch to this label upon errors found below
 ;
 ; Refresh output
 SET XUXTADQUIT=0 ; End date might set XUXTADQUIT=1; then repeat Begin date
 KILL XUXTADDTBEG,XUXTADDTEND
 ;
 W !!,"Enter "_XUXTADDATETXT_" range"
 D GETDT("    Begin date: ","B") Q:XUXTADQUIT
 D GETDT("      End date: ","E") G:XUXTADQUIT GETDTS1
 I '$$DTSOK(XUXTADDTBEG("I"),XUXTADDTEND("I")) G GETDTS1
 ;
 SET XUXTADDTBEG=$$DTBEG(XUXTADDTBEG("I"))
 SET XUXTADDTEND=$$DTEND(XUXTADDTEND("I"))
 Q  ; GETDTS
 ;
 ;XUXTADDT1 ;ESL/JAC/cm - UTL Date subroutines & extrinsics #1 ; 06/26/2020  09:30
