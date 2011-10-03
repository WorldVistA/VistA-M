SCAPU1 ;ALB/REW - TEAM API UTILITIES ; 30 Jun 95
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
DTCHK2(SCDATES,ACTDT,INACTDT) ;given scdates array was it active?
 N SCBEGIN,SCEND,SCINCL
 D INIT^SCAPMCU1(1) ;set default array
 Q $$DTCHK(SCBEGIN,SCEND,SCINCL,ACTDT,.INACTDT)
 ;
DTCHK(BEGINDT,ENDDT,INCL,ACTDT,INACTDT) ; -- given activation/inactivation dates and begin & end dates and include flag was it active?
 ;Parameters:
 ;  BEGINDT - begining date
 ;  ENDDT   - ending date
 ;  INCL    - 1= must be active for whole period to get a 'yes'/0 o/w
 ;  ACTDT   - activation date for record
 ;  INACTDT - inactivation date for record 
 ;  returns: 1 = Active
 ;           0 = Inactive
 ;          -1 = Error
 ; 
 N OK
 S OK=-1
 G DTCHKQ:'$G(BEGINDT)!('$G(ENDDT))!('$G(ACTDT))
 S OK=0
 ; begin is after inactivation
 IF $G(INACTDT),BEGINDT>INACTDT G DTCHKQ
 ; end is before effective date
 IF ENDDT<ACTDT G DTCHKQ
 ; just need 1 day in range
 IF $G(INCL)=0 S OK=1 G DTCHKQ
 ; begin is not before effective date
 IF ACTDT>BEGINDT G DTCHKQ
 ; inactivation exists & isn't after end
 IF $G(INACTDT),INACTDT<ENDDT G DTCHKQ
 S OK=1
DTCHKQ Q OK
 ;
ERR(SEQ,ERNUM,PARMS,OUTPUT,SCER) ;-- process errors
 ;if no dialog entry 4040000 will be processed
 S ERNUM=$G(ERNUM,4040000)
 S:'$$GET1^DIQ(.84,$G(ERNUM)_",",.01) ERNUM=4040000
 IF SCER]"" D
 . S SEQ=SEQ+1
 . S SCER(SEQ)=ERNUM
 .D BLD^DIALOG(.ERNUM,.PARMS,.OUTPUT,.SCER)
 Q
 ;
OKARRAY(ARRAY,CHECK) ; see if input array says 'check' should be used
 ;  DOES NOT change any varriables - $$okarray(.xx,.yy) is safe...
 ;  if array is null OR undefined it is ok
 ;  if @array@(check) is defined it is ok
 ;  if @array@('exclude') is defined results switch
 ;  RETURNS: 1: Yes use/0: No don't
 Q $S('$L($G(CHECK)):1,'$L($G(ARRAY)):1,(ARRAY'?1A1.7AN):0,1:'(($D(@ARRAY@(CHECK))#2)=($D(@ARRAY@("EXCLUDE"))#2)))  ;changed to quit if check is not defined
 ;
OKUSRCL(USRARRAY,CHECK) ; see if input user class array says 'check' is ok
 N SCOK,SCU
 S SCOK=0
 IF '$L($G(CHECK))!('$L($G(USRARRAY))) S SCOK=1 G QTOKUSR
 IF (USRARRAY'?1A1.7AN)&(USRARRAY'?1"^"1A.E) G QTOKUSR
 S SCU=0
 IF $D(@USRARRAY@("EXCLUDE"))#2 D
 .S SCOK=1
 .F  S SCU=$O(@USRARRAY@(SCU)) Q:'SCU  S:(CHECK=SCU)!($$SUBCLASS^USRLM(CHECK,SCU)) SCOK=0
 ELSE  D
 .S SCOK=0
 .F  S SCU=$O(@USRARRAY@(SCU)) Q:'SCU  S:(CHECK=SCU)!($$SUBCLASS^USRLM(CHECK,SCU)) SCOK=1
 .
QTOKUSR Q SCOK
