BPSOSU1 ;BHAM ISC/FCS/DRS/FLS/DLF - copied for ECME ;03/07/08  10:34
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;----------------------------------------------------------------------
 ;Standard Date Functions
 ;----------------------------------------------------------------------
 ;Standard Date PROMPT:
 ;
 ;Parameters:
 ;    PROMPT  = Text to be displayed before read
 ;    DFLT    = Default date (internal format)
 ;    OPT     = 1 - Answer optional       0 - Answer required
 ;    SDATE   = Minimum date (internal format or NOW and DT)
 ;    EDATE   = Maximum date (internal format or NOW and DT)
 ;    %DT     = E - Echo answer           R - Require time
 ;              S - Seconds returned      T - Time allowed but not req
 ;              X - Exact date req
 ;    TIMEOUT = Number of seconds
 ;
 ;Returns:
 ;    <null>  = No response             <^> - Up-arrow entered
 ;    <-1>    = Timeout occurred       <^^> - Two up-arrows entered
 ;    <date>  = Internal FM Date
 ;----------------------------------------------------------------------
 ; IHS/SD/lwj 8/5/02  NCPDP 5.1 changes
 ;  Subroutine FM3EXT cloned from FM2EXT - routine used to transfer
 ;  the dates.  Now that NCPDP 5.1 stores the field ID with all the
 ;  fields, we needed currently just want to skip transforming the
 ;  date for 5.1 type claims
 ;
 ;
 ;----------------------------------------------------------------------
DATE(PROMPT,DFLT,OPT,SDATE,EDATE,%DT,TIMEOUT) ;EP -
 ;
 N XDATA,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 Q:$G(PROMPT)="" ""
 ;
 S $P(DIR(0),"^",1)="DA"_$S(OPT=1:"O",1:"")
 S $P(XDATA,":",1)=SDATE
 S $P(XDATA,":",2)=EDATE
 S $P(XDATA,":",3)=%DT
 S $P(DIR(0),"^",2)=XDATA
 S DIR("A")=PROMPT
 S:$G(DFLT)'="" DIR("B")=$$FM2EXT(DFLT)
 S:+$G(TIMEOUT)>0 DIR("T")=TIMEOUT
 D ^DIR
 Q $S($G(DTOUT)=1:-1,$G(DIROUT)=1:"^^",$G(DUOUT)=1:"^",1:Y)
 ;----------------------------------------------------------------------
 ;Convert FileMan Date to External Date Format
 ;
 ;Parameters:    Y       - FileMan formatted date (YYYMMDD.HHMMSS)
 ;Returns:      Y       - External date
 ;----------------------------------------------------------------------
FM2EXT(Y) ;EP
 Q:$G(^DD("DD"))="" ""
 X ^DD("DD")
 Q $S($E(Y,1,3)?3A:Y,1:"")
 ;----------------------------------------------------------------------
 ;
FM3EXT(Y) ;EP   IHS/SD/lwj 8/5/02 clone of FM2EXT- accommodates 5.1 type clms
 Q:$E(Y,1,1)["C" Y
 S Y=Y-17000000
 Q:$G(^DD("DD"))="" ""
 X ^DD("DD")
 Q $S($E(Y,1,3)?3A:Y,1:"")
 ;----------------------------------------------------------------------
 ;
FM2MDY(Y) ;EP
 Q:Y="" ""
 Q $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 ;----------------------------------------------------------------------
 ;Convert External Date to FileMan Date Format
 ;
 ;Parameters:   X       - External date
 ;Returns:      Y       - FileMan formatted date (YYYMMDD.HHMMSS)
 ;----------------------------------------------------------------------
EXT2FM(X) ;
 N %DT,Y
 Q:$G(X)="" ""
 D ^%DT
 Q Y
 ;----------------------------------------------------------------------
 ;Returns current Date/Time in FileMan date format
NOWFM() ;EP
 N %,%H,%I,X
 D NOW^%DTC
 Q %
NOWEXT() ;EP - External form of $$NOWFM
 N Y S Y=$$NOWFM X ^DD("DD") Q Y
 ;----------------------------------------------------------------------
 ;Takes a FileMan date and adds or subtracts days
 ;
 ;Parameters:   X1   - FileMan formatted date
 ;              X2   - Number of days (ECME = add, neg = subtract)
 ;Returns:      X    - Resulting FileMan formatted date
 ;----------------------------------------------------------------------
CDTFM(X1,X2) ;EP - BPSER*,BPSES02
 N X,%H
 Q:$G(X1)="" ""
 Q:$G(X2)="" ""
 D C^%DTC
 Q X
 ;----------------------------------------------------------------------
 ;Takes a FileMan date and returns 3-digit julian date
JULDATE(DT) ;
 N X,X1,X2,%H,%T,%Y
 Q:'(DT?7N) ""
 S X2=$E(DT,1,3)_"0101",X1=DT
 D ^%DTC
 S X=X+1
 Q $TR($J(X,3)," ","0")
 ;----------------------------------------------------------------------
 ;
 ;$$DTR(AA,AB,ADEF,BDEF,T) Input Beginning & Ending prompts, return
 ;                       "Begin date^End date" or 0 if unsuccessful.
 ;$$DTR() is okay - all args are optional
 ;$$DTP(AA,DEF) Input a prompt, return a single date "Internal^External"
 ;$$DTM(AA,DEF) Input a prompt, return month/year "Internal^External"
 ;--------------------------------------------------------------------
 ;
DTR(AA,AB,ADEF,BDEF,T) ;EP - GET THE DATE RANGE (beginning and ending dates)
 ; IN:
 ;    AA   = PROMPT for BEGINNING DATE
 ;    AB   = PROMPT for ENDING DATE
 ;    ADEF = DEFAULT date for BEGINNING DATE
 ;    BDEF = DEFAULT date for ENDING DATE
 ;    T    = whether TIME is allowed as entry, and if REQUIRED
 ;           (If T="T" then TIME is allowed; is REQ'd if T="R").
 ; OUT:
 ;    Beginning Date^Ending Date in 7digit FileMan format
 ;      If user enters "^" then out=0
 ;
 NEW %DT,X,Y,U,PROMPT,DEFAULT,BEGDT,ENDDT
 S U="^"
 ;
DTR1 ; -- Get beginning date
 S %DT="AE"_$G(T)
 I $D(AA) S PROMPT=AA
 E  S PROMPT="Enter the Beginning Date"_$S($G(T)]"":" @ Time",1:"")_": "
 S:$D(ADEF) DEFAULT=ADEF
 S BEGDT=$$DATE^BPSOSU1(PROMPT,$G(DEFAULT),1,1000101,3991231,%DT,$G(DTIME))
 I BEGDT<1 QUIT 0
 ;
 WRITE !
 S %DT="AE"_$G(T)
 I $D(AB) S PROMPT=AB
 E  S PROMPT="Enter the Ending Date"_$S($G(T)]"":" @ Time",1:"")_": "
 S:$D(BDEF) DEFAULT=BDEF
 S ENDDT=$$DATE^BPSOSU1(PROMPT,$G(DEFAULT),1,BEGDT,3991231,%DT,$G(DTIME))
 I ENDDT["^" Q 0  ;user wants out if "^"
 ; -- Ensure END date is not earlier than BEG date
 I ENDDT<BEGDT WRITE $C(7),!!,"Ending date must not be less than beginning date!",!! HANG 2 GOTO DTR1
 QUIT BEGDT_U_ENDDT
 ;--------------------------------------------------------------------
 ;
 ;
DTP(AA,DEF) ;EP - *** GET A SINGLE PAST DATE, TIME NOT ALLOWED ***
 ;
 ; IN:  AA  = PROMPT you want displayed to user
 ;      DEF = DEFAULT date
 ; OUT: FileMan Date^readable Date
 ;      If user enters "^" then OUT=0
 ;
 NEW %DT,Y,DATE
 S:'$D(U) U="^"
 I '$D(DT)#2 DO DT^DICRW ;get today's date
 S U="^"
 S %DT="AEPX" ;ask, echo, past dates assumed, exact date reqd
 S %DT("A")=$S($D(AA):AA,1:"What DATE: ")
 S:$D(DEF) %DT("B")=DEF
 DO ^%DT KILL %DT
 ; -- Q if no data
 I Y<1 QUIT 0  ;quit if date was invalid
 I $D(DTOUT) QUIT 0  ;quit if timeout occurred
 ; -- Define dates
 ; DATE("Y") is FM format date; DATE is MON DD,YEAR format.
 S DATE("Y")=Y XECUTE ^DD("DD") S DATE=Y
 QUIT DATE("Y")_U_DATE
 ;--------------------------------------------------------------------
