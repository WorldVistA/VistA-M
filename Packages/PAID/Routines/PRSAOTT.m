PRSAOTT ;WCIOFO/JAH/PLT- 8B CODES ARRAY.  COMPARE OT (8B-vs-APPROVED). ;11/29/2006
 ;;4.0;PAID;**37,43,54,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Function & subroutine Index for this routine.
 ;
 ; APOTWEEK(PAYPRD,WEEKID,EMP450).....return all approved OT in a week.
 ; ARRAY8B(RECORD)...............Build employee 8B array for payperiod.
 ; CODES(WEEK)........return string of valid time codes for week 1,2,3.
 ; GET8BCDS(TT8B).................return timecode portion of 8B string.
 ; GET8BOT(EMPIEN,WEEK,TT8B)..........return all OT in an 8b string.
 ; GETOTS(PP,EI,T8,WK,.O8,.OA)......Get overtimes (tt8b & approved).
 ; OTREQ(REC).................returns true if Request is type Overtime.
 ; OTAPPR(REC)...................returns true if a Request is Approved.
 ; WEEKRNG(PPE,WEEK,FIRST,LAST)........1st & last FM days in a pp week.
 ; WARNSUP(PPE,EI,E8B,WK,OTERR,O8,OA)... check ot's for a week & warn.
 Q
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
GETOTS(PP,EI,T8,WK,O8,OA) ;Get overtimes (tt8b & approved)
 ; Sample call:
 ;   D GETOTS("98-05",1255,TT8BSTRING,1,.O8,.OA)
 ;   where TT8BSTRING might be =
 ;   "658229548868WIL   8B268380A106 AN320NA060DA030NR300SE080CD000790"
 ;
 ; subroutine returns overtime from request file & TT8B string for
 ; week specified in parameter 4
 ;
 ;  Input:  PP - Pay period in format YY-PP.
 ;          EI - Employees ien from file 450.
 ;          T8   - Entire 8B record.  Stored in
 ;                   ^PRST(458,PP,"E",EI,5).
 ;  Output: O8 - TT8B overtime calculated
 ;          OA - approved overtime in request fiLE
 ;
 S (OA,O8)=0
 Q:((WK'=1)&(WK'=2))
 ;
 S O8=$$GET8BOT^PRSAOTT(EI,WK,T8) ;    get all OT from 8b string
 S OA=$$APOTWEEK^PRSAOTT(PP,WK,EI) ;      get approved overtime
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
WARNSUP(PPE,EI,E8B,WK,OTERR,O8,OA) ;Gets overtime from request
 ; file & TT8B string & displays warning if 8B string has more
 ; OT than approved requests.
 ;
 ;Input: PPE - (P)ay (P)eriod (E)xternal in format YY-PP.
 ;       EI  - (E)mployees (I)nternal entry # from file 450.
 ;       E8B - (E)ntire (8B) record.  Stored in ^PRST(458,PP,"E",EI,5).
 ;       WK - week number 1 or 2 of pay period.
 ;Output: Warning message to screen.
 ;Local: OA - (O)vertime (A)pproved  from requests file.
 ;       O8 - (O)vertime totaled from (8)b string.
 ;
 S (OA,O8,OTERR)=0
 ; Compare week of approved ot requests to 8B OT.
 S O8=$$GET8BOT(EI,WK,E8B) ;   get all OT from 8b string
 S OA=$$APOTWEEK(PPE,WK,EI) ;     get approved overtime
 I OA<O8 D DISPLAY(EI,O8,OA,WK) S OTERR=1 ; Display warning if calc>apprv
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
DISPLAY(IEN,OT8B,OTRQ,WK) ;Output warning message.  8b ot > approved ot.
 ;
 ;  Input:  IEN - employees 450 ien.
 ;          OT8B - employees total overtime calculated from 8b string.
 ;          OTRQ - employees total approved OT request's from 458.2
 ;          WK   - week 1 or 2 of payperiod.
 ;
 W !,?3,"WARNING: Week ",WK," -Overtime being paid (",OT8B,") is more than approved (",OTRQ,")."
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
GET8BOT(EMPIEN,WEEK,TT8B) ;
 ;  Output:  Function returns total hrs of overtime that is coded
 ;           into  TT8B string for either week (1) or (2).
 ;  Input:   EMPIEN - internal entry # of employee to check 8B overtime
 ;           WEEK   - week (1) or (2) of pay period to check 8B overtime.
 ;           TT8B   - full 8B string stub & values.
 ;
 N PPIEN,TT8BOT,OTCODES,CODE,OTTOTAL,OTTMP
 S OTTOTAL=0
 ;
 ; get time coded portion of 8B string
 ;
 S TT8B=$$GET8BCDS(TT8B)
 Q:$L(TT8B)<2 OTTOTAL ;    Aint no coded OT if there aint no codes.
 ;
 ; create array of codes & values for this 8b string.
 D ARRAY8B(TT8B)
 ;
 ; create string with all overtime codes.
 S OTCODES=$S(WEEK=1:"^DA^DB^DC^OA^OB^OC^OK^",1:"^DE^DF^DG^OE^OF^OG^OS^")
 ; Only count total regular hours @ OT rate when not a firefighter
 ; with premium pay code "R" or "C". These firefighters get RA/RE from
 ; their scheduled tour and do not need to have overtime requests. *54
 I "^R^C^"'[(U_$P($G(^PRSPC(EMPIEN,"PREMIUM")),U,6)_U) D
 . S OTCODES=OTCODES_$S(WEEK=1:"RA^RB^RC^",1:"RE^RF^RG^")
 ;
 ; loop thru employees 8b array to see if they have any of
 ; overtime codes & add any of them up.
 ;
 S CODE=""
 F  S CODE=$O(TT8B(WEEK,CODE)) Q:CODE=""  D
 .  I OTCODES[("^"_CODE_"^") D
 ..   S OTTMP=TT8B(WEEK,CODE)
 ..   S OTTOTAL=OTTOTAL+$E(OTTMP,1,2)+($E(OTTMP,3)*.25)
 Q OTTOTAL
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
 ;
APOTWEEK(PAYPRD,WEEKID,EMP450) ;
 ;Function returns approved overtime totals for a week.
 ;Input:  PPE,PAYPRD   - pay period of concern. YY-PP
 ;        WEEKID   - week (1) or week (2) of pay period
 ;        EMP450   - employees internal entry number in file 450.
 ;Output: TOTALOT  - total hrs of overtime for a week
 ;
 ;local vars:  D1 - 1st day of payperiod-returned by NX^PRSAPPU
 ;             OTREC - a record containing 1 overtime request.
 ;             START,STOP - 1st & last FM days of week (Sun,Sat)
 ;
 ; quit returning 0 if anything is missing.
 Q:$G(PAYPRD)=""!$G(WEEKID)=""!$G(EMP450)="" 0
 ;
 ; Loop thru OT/CT requests file x-ref on requested work date &
 ; add up all employees approved OT requests within week.
 ;
 N D1,PPE,TOTALOT,START,STOP,OTREC
 S TOTALOT=0
 D WEEKRNG(PAYPRD,WEEKID,.START,.STOP)
 S D1=START-.1
 F  S D1=$O(^PRST(458.2,"AD",EMP450,D1)) Q:D1>STOP!(D1="")  D
 .  S OTREC=""
 .  F  S OTREC=$O(^PRST(458.2,"AD",EMP450,D1,OTREC)) Q:OTREC=""  D
 ..    I $$OTREQ(OTREC),$$OTAPPR(OTREC) D
 ...     S TOTALOT=TOTALOT+$P($G(^PRST(458.2,OTREC,0)),"^",6)
 Q TOTALOT
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
OTREQ(REC) ;Function returns true if Request is type Overtime.
 Q:$G(REC)="" 0
 Q $P($G(^PRST(458.2,REC,0)),"^",5)="OT"
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
OTAPPR(REC) ;Function returns true if a Request is Approved.
 Q:$G(REC)="" 0
 Q "AS"[$P($G(^PRST(458.2,REC,0)),"^",8)
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
WEEKRNG(PPE,WEEK,FIRST,LAST) ;
 ;
 ; Routine takes a pay period & a week number & returns
 ; 1st & last FileMan days of specified week.
 ;  Input:  PPE - pay period in format YY-PP.
 ;          WEEK - week (1) or (2).
 ;  Output: .FIRST - first day of specified week-FM format
 ;          .LAST  - last day of specified week-FM format
 N D1,X1,X2,PPD1
 D NX^PRSAPPU S PPD1=D1
 I WEEK=1 D
 . S (FIRST,X1)=PPD1,X2=6 D C^%DTC S LAST=X
 E  D
 . S X1=PPD1,X2=7 D C^%DTC S FIRST=X
 . S X1=PPD1,X2=13 D C^%DTC S LAST=X
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
GET8BCDS(TT8B) ; GET 8B time CoDeS
 ;  Input:   Full 8b record as stored on node 5 of employee record
 ;           in time & attendance file.
 ;  Output:  Function returns section of 8b record with pay 
 ;           codes & values.
 ;
 ;  i.e. return last portion of 8b record  ----- <<AN280AL120CD00040>>
 ; ^PRST(458,,"E",,5)=658226944741FLI 8B256280A112 AN280AL120CD00040
 ;
 ;  Input:   FULL 8B RECORD
 ;
 Q $E(TT8B,33,$L(TT8B))
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
ARRAY8B(RECORD) ; Build employee 8B array.
 ; calls to this routine are responsible for cleaning up TT8B( array.
 ;
 ; Build a TT8B array which contains ONLY codes & values 
 ; that are in employees 8B record.
 ;
 ; Input:  RECORD - last portion of 8B array with codes & values.
 ;                  e.g. <<AN280AL120CD00040>> (see GET8BCDS^PRSAOTT)
 ;
 ; Output: array subscripted by time code & set equal to value.
 ;   e.g.     TT8B(1,"AN")=010
 ;            TT8B(1,"DA")=020
 ;            TT8B(1,"NA")=020
 ;            TT8B(2,"SL")=080
 ;            TT8B(3,"CD")=000130
 ;
 K TT8B S TT8B(0)=0
 Q:$G(RECORD)=""
 N EOR,TYPE,VALUE,LOOP,WK
 S EOR=0
 F  D  Q:EOR=1
 .  S TYPE=$E(RECORD,1,2)
 .;  I TYPE="CD" S VALUE=$E(RECORD,3,$L(RECORD)) S EOR=1
 .;
 .;traverse record to next code so LOOP gets len of curr code value
 .;
 .  F LOOP=3:1:$L(RECORD) Q:$E(RECORD,LOOP)?1U
 .  S:LOOP=$L(RECORD) EOR=1
 .  S VALUE=$S(EOR=1:$E(RECORD,3,LOOP),1:$E(RECORD,3,LOOP-1))
 .  S:EOR=0 RECORD=$E(RECORD,LOOP,$L(RECORD))
 .;
 .;Put code into corresponding week of TT8B array.
 .;
 .  S WK=$S($F($$CODES(1),TYPE):1,$F($$CODES(2),TYPE):2,$F($$CODES(3),TYPE):3,1:"unknown")
 .  S TT8B(WK,TYPE)=VALUE,TT8B(0)=TT8B(0)+1
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
CODES(WEEK) ;
 ; 8b string can contain any number of codes.  Some of codes
 ; are strictly for types of time in week 1 & some are for week 2.
 ; There are also pay period codes that are independant from weeks.
 ;
 ; This function returns a string of codes for specified 
 ; week (1) or (2)  -OR- (3)---8b codes independant of week.
 ;
 ;  Input:  WEEK - week (1) (2) of pay period. 
 ;
 Q:$G(WEEK)="" 0
 Q:WEEK=1 "AN SK WD NO AU RT CE CU UN NA NB SP SA SB SC DA DB DC TF OA OB OC YA OK OM RA RB RC HA HB HC PT PA ON YD HD VC EA EB TA TC FA FC AD NT RS ND SR SD"
 ;
 Q:WEEK=2 "AL SL WP NP AB RL CT CO US NR NS SQ SE SF SG DE DF DG TG OE OF OG YE OS OU RE RF RG HL HM HN PH PB CL YH HO VS EC ED TB TD FB FD AF NH RN NU SS SH"
 ;
 Q:WEEK=3 "NL DW IN TL LU LN LD DT TO LA ML CA PC CY RR FF FE CD"
 Q 0
