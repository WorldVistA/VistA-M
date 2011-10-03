PRSPUT3 ;WOIFO/MGD,JAH - PART TIME PHYSICIAN UTILITIES #1 ;03/23/07
 ;;4.0;PAID;**93,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Utilities for Part Time Physician patch PRS*4.0*93.
 ;
PTP(PRSIEN) ;Check for potential PTP (has a memo on file)
 ; input PRSIEN = employee IEN (file 450)
 ; result = 1 or 0, true (1) if employee has any memos on file
 Q $S($O(^PRST(458.7,"B",PRSIEN,0)):1,1:0)
 ;
 ;-----------------------------------------------------------------------
 ; Display PTP AL info
 ; Input: PRSIEN - IEN of PT Physician
 ;         ARRAY - Array where leave info is stored. (Optional) If not 
 ;                 specified, no array is created.
 ;         INDEX - Index to start array. (optional) set to 1 if not spec
 ; Output: 2 line summary-current AL bal, fut reqs and potential loss.
 ;-----------------------------------------------------------------------
AL(PRSIEN,ARRAY,INDEX) ;
 Q:'PRSIEN
 I $G(INDEX)="",($G(ARRAY)'="") D INDEX^PRSPUT1
 N AINC,ALBAL,ALTBL,APALHRS,EOLYD,LVG,TEXT,X,X1,X2,Y,MAYLOSE,LDPINV
 ;
 ; Max Carryover
 S MAXOVER=240
 ;
 ; current AL bal
 S ALBAL=$P($G(^PRSPC(PRSIEN,"ANNUAL")),U,3)
 ;
 ; last day of curr leave yr
 S EOLYD=$$GETLDOYR()
 ;
 ; last day proc from 459 & inverse
 S LDP=$P($G(^PRST(458,$O(^PRST(458,"AB",$O(^PRST(459,"AB",""),-1),0)),1)),U,14)
 S LDPINV=9999999-LDP
 ;
 ; future al approved (ranges from LastDayProcessed459-EndOfLeaveYear)
 ; This is an estimate since we count all hrs for reqs that begin in 
 ; the current yr but cross into next
 S APALHRS=$$GETAPALH(PRSIEN,LDPINV,EOLYD)
 ;
 ; accrual from last pp proc to EOY
 S ACCRUAL=$$GETACCRU(PRSIEN,EOLYD,LDP)
 ;
 ; potential loss
 S MAYLOSE=$$GETLOSE(APALHRS,ALBAL,ACCRUAL,MAXOVER)
 ;
 ; Display
 S TEXT=""
 D A1^PRSPUT1 ; Blank line
 S TEXT="AL Bal: "_$J(ALBAL,6,2)
 S $E(TEXT,17)="",TEXT=TEXT_"Approved future AL thru Leave Year: "
 S TEXT=TEXT_$J(APALHRS,6,2)
 S $E(TEXT,60)="",TEXT=TEXT_"Max carryover: "_MAXOVER
 D A1^PRSPUT1 ; Line #1
 S Y=EOLYD
 D DD^%DT
 S TEXT="Potential AL hours to be lost by "_Y_" excluding Approved AL: "
 S TEXT=TEXT_MAYLOSE
 D A1^PRSPUT1 ; Line #2
 K INDEX
 Q
 ;
GETACCRU(PRSIEN,EOLYD,LDP) ; Calculate AL accrucal from last day of 
 ; pp processed in 459 (LDP) to end of leave year (EOLYD)
 ;
 N CO,LVG,NH,DB,AINC,X1,X2,INC
 ;
 S C0=$G(^PRSPC(PRSIEN,0)),LVG=$P(C0,"^",15),NH=+$P(C0,"^",16)
 S DB=$P(C0,"^",10),AINC=""
 Q:LVG'?1N!("123"'[LVG) 0
 I LVG=1 D  ; Leave Group 1
 . S AINC=$S(DB=1:4,1:NH+AINC/20\1)
 I LVG=2 D  ; Leave Group 2
 . S AINC=$S(DB=1:6,1:NH+AINC/13\1)
 I LVG=3 D  ; Leave Group 3
 . S AINC=$S(DB=1:8,1:NH+AINC/10\1)
 S X1=EOLYD,X2=LDP
 D ^%DTC
 S INC=X+13\14*AINC
 Q INC
 ;
GETLOSE(APALHRS,ALBAL,ACCRUAL,MAXOVER) ; Calculate potential hours to be lost
 N ALTBL
 S ALTBL=ALBAL+ACCRUAL-MAXOVER-APALHRS
 Q $S(ALTBL<0:0,1:ALTBL)
 ;
GETLDOYR() ; Calculate last day of the last pp of current year (EOLY)
 N X,I,X1,X2,NEXTYR,PRSYRDT
 S PRSYRDT=$P($T(DAT^PRSAPPU),";;",2)
 F I=1:1 S NEXTYR=$P(PRSYRDT,",",I) Q:NEXTYR>DT!(NEXTYR="")
 I NEXTYR="" Q DT
 S X1=NEXTYR,X2=-1
 D C^%DTC
 Q X
 ;
GETAPALH(PRSIEN,PPPIN,EOLYD) ; Approved AL hrs
 ;
 N APALHRS,EOLYDINV,LREND,LRIEN,LRSTRT,LRDATA
 ;
 S APALHRS=0 ; COUNTER-APproved Annual Leave HouR
 S EOLYDINV=9999999-EOLYD
 ;
 ; use inverse dt to loop chrono from future requests to recent ones
 ; Quit when end date hits last proc pp. Don't include canceled & other
 ; leave type reqs from AD index.
 ;
 S LREND=0
 F  S LREND=$O(^PRST(458.1,"AD",PRSIEN,LREND)) Q:(LREND'>0)!(LREND>PPPIN)  D
 . S LRIEN=0
 . F  S LRIEN=$O(^PRST(458.1,"AD",PRSIEN,LREND,LRIEN)) Q:LRIEN'>0  D
 . . S LRSTRT=^PRST(458.1,"AD",PRSIEN,LREND,LRIEN)
 . . S LRSTRT=9999999-LRSTRT
 . . ;
 . . ; skip if lv doesn't start in range-last pp proc to EOLY
 . . Q:LRSTRT'<PPPIN!(LRSTRT'>EOLYDINV)
 . . ; skip if not AL or App
 . . S LRDATA=$G(^PRST(458.1,LRIEN,0))
 . . Q:$P(LRDATA,U,7)'="AL"!($P(LRDATA,U,9)'="A")
 . . S APALHRS=APALHRS+$P(LRDATA,U,15)
 Q APALHRS
 ;
 ;-----------------------------------------------------------------------
 ; Utility updates ESR Status and autopost any holidays
 ;
 ; Input:
 ;       PPI - The internal entry number of the PP
 ;    PRSIEN - The internal entry number of the PT Phy
 ;       DAY - (optional) If passed in the specific date (1-14) that
 ;               needs to be updated.  If a specific date is not
 ;               passed in all 14 days will be reviewed and updated
 ;               as necessary.
 ;
 ; HOL and PDT need to be set by calling ^PRSAPPH prior to making this
 ; call.
 ;
ESRUPDT(PPI,PRSIEN,DAY) ;
 ;
 N END,HTOUR,IENS,MT,PRSFDA,START,STATUS,STOP,TOUR
 S DAY=$G(DAY,"")
 S START=$S(DAY:DAY,1:1)
 S END=$S(DAY:DAY,1:14)
 F DAY=START:1:END D
 . S TOUR=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,0)),U,2)
 . S STATUS=$S(TOUR>1:1,1:6)
 . S IENS=DAY_","_PRSIEN_","_PPI_","
 . K PRSFDA
 . S PRSFDA(458.02,IENS,146)=STATUS
 . I $D(HOL($P(PDT,U,DAY))) D
 . . S HTOUR=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,1))
 . . Q:HTOUR=""
 . . S MT=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,0)),U,2)
 . . S MT=$P($G(^PRST(457.1,MT,0)),U,3)
 . . F I=0:1:6 Q:$P(HTOUR,U,(3*I)+1)=""  D
 . . . S START=$P(HTOUR,U,(3*I)+1),STOP=$P(HTOUR,U,(3*I)+2)
 . . . S PRSFDA(458.02,IENS,110+(5*I))=START
 . . . S PRSFDA(458.02,IENS,111+(5*I))=STOP
 . . . S PRSFDA(458.02,IENS,112+(5*I))="HX"
 . . S PRSFDA(458.02,IENS,146)=4 ; ESR DAILY STATUS = SIGNED
 . . S PRSFDA(458.02,IENS,101)="" ; Reset timecard status to unposted.
 . . S PRSFDA(458.02,IENS,114)=MT ; Meal time for 1st segment
 . . S PRSFDA(458.02,IENS,147)=$$NOW^XLFDT() ; Date/Time stamp
 . . S PRSFDA(458.02,IENS,149)=4 ; ESR Signed by Holiday
 . D UPDATE^DIE("","PRSFDA","IENS"),MSG^DIALOG()
 Q
 ;
MEMCPP(MIEN) ; Memo Certified PP
 ; This utility determine the last certified PP and the number of
 ; certified PPs for a given memo.
 ; input
 ;   MIEN - internal entry number of a memo in file 458.7
 ; returns a string value
 ;   = last certified PP (external value)^number of certified PPs
 ;   example "05-01^3"
 ;
 N LASTPP,MPPIEN,PPC,PRSX
 I '$G(MIEN) Q "^"
 ;
 S LASTPP="" ; last PP
 S PPC=0 ; pp counter
 ; loop thru PPs in memo
 S MPPIEN=0 F  S MPPIEN=$O(^PRST(458.7,MIEN,9,MPPIEN)) Q:'MPPIEN  D
 . S PRSX=$G(^PRST(458.7,MIEN,9,MPPIEN,0))
 . Q:$P(PRSX,U,2)=""  ; REG HOURS is null so PP never certified
 . S LASTPP=$P(PRSX,U,1)
 . S PPC=PPC+1
 ;
 Q LASTPP_"^"_PPC
 ;
PP8BAMT(PPAMT,PPI,PRSIEN) ; array TIMEAMTS passed by reference
 ; subscripted w/ types of time CODE and type of time activity 
 ; from PRS8VW2 table.  This routine sets each node of TIMEAMTS array
 ; to the total hours (week one and two) in the pp 
 ; for that type of time activity.
 ;
 ; SAMPLE CALL:
 ; S TAMTS("WP","Leave Without Pay")="" D PP8BTOT(.TAMTS,PPI,PRSIEN)
 ;
 ; SAMPLE RETURN ARRAY
 ; TAMTS("WP","Leave Without Pay")=12.5
 ;
 N TT,STR8B,TC,TA,WK1CD,WK2CD,AMT1,AMT2
 S STR8B=$$GET8B(PPI,PRSIEN)
 S TC=""
 F  S TC=$O(PPAMT(TC)) Q:TC=""  D
 .  S TA=""
 .  F  S TA=$O(PPAMT(TC,TA)) Q:TA=""  D
 ..    S WK1CD=$$WKTT(TC,TA,1)
 ..    S WK2CD=$$WKTT(TC,TA,2)
 ..    S AMT1=$$EXTR8BT(STR8B,WK1CD)
 ..    S AMT2=$$EXTR8BT(STR8B,WK2CD)
 ..    S PPAMT(TC,TA)=AMT1+AMT2
 Q
GET8B(PPI,PRSIEN) ; get 8b from 5 node unless corrected timecard 
 ;                 has been done then we need to recompute 8B
 N S8B
 I $$CORRECT(PPI,PRSIEN) D
 .  N DFN,PY,VAL
 .; new variables used BY callers to this API because the decomp
 .;  kills everything in its path.
 .  N QT,PP,%,C0,CNT,CT,D,DAY,HDR,I,K,MEAL,SSN,ST,TT,TYP,X,X1,Y,Y1,Z,ML,Z0,Z1
 .  S DFN=PRSIEN
 .  S PY=PPI
 .  D ONE^PRS8
 .  S S8B=$E($G(VAL),33,999)
 E  D
 .  S S8B=$E($G(^PRST(458,PPI,"E",PRSIEN,5)),33,999)
 Q S8B
CORRECT(PPI,PRSIEN) ; return true if any corrected timecards exist for 
 ;this emp's pp that were approved by the final level supr apprl
 N CORRECT,STATUS,TCD
 S CORRECT=0
 Q:($G(PPI)'>0)!($G(PRSIEN)'>0)
 S TCD=0
 F  S TCD=$O(^PRST(458,PPI,"E",PRSIEN,"X",TCD)) Q:TCD'>0!(CORRECT)  D
 .  S STATUS=$P($G(^PRST(458,PPI,"E",PRSIEN,"X",TCD,0)),U,5)
 .  I STATUS="P"!(STATUS="S") S CORRECT=1
 Q CORRECT
EXTR8BT(S,T) ; EXTRACT THE 8B TYPE OF TIME FROM THE STUB AND RETURN THE 
 ; AMOUNT OF TIME FROM WEEK ONE AND TWO FOR THIS TYPE OF TIME
 ; INPUT: S-8B STUB
 ;        T-TYPE OF TIME TO FIND ^ LENGTH OF DATA IN 8B
 N AMT,LEN,POS,QH,HRS
 S AMT="0.0"
 S POS=$F(S,$P(T,U))
 I POS D
 .  S LEN=$P(T,U,2)
 .  S AMT=$E(S,POS,POS-1+LEN)
 .  S HRS=+$E(AMT,1,LEN-1)
 .  S QH=+$E(AMT,LEN,LEN)
 .  S QH=$S(QH=1:".25",QH=2:".5",QH=3:".75",1:".0")
 .  S AMT=HRS_QH
 Q AMT
 ;
WKTT(T,TA,WK) ; GET 8B STRING TIMECODE FOR WEEK ONE OR TWO AND LENGTH OF 
 ; THE DATA IN THE 8B STRING
 ;  Input:
 ;    T- type of time code from file 457.3
 ;    TA-time activity from the table in PRS8VW2 (e.g. Leave Without Pay)
 ;    WK-1 or 2 for the desired timecode week
 ;
 S WK=$S($G(WK)=2:2,1:1)
 Q:$G(T)=""
 N TCH1,TTEXT,CHKLN,I,FOUND,E,TTABLE,CHUNK,TABLEI,WKTTCODE
 S FOUND=0
 ;
 S TCH1=$E(T,1,1)
 D E2^PRS8VW
 S CHKLN=$P($T(@(TCH1)+0^PRS8VW2),";;",2)
 F I=1:1:$L(CHKLN,"^") D  Q:FOUND
 .  S CHUNK=$P(CHKLN,U,I)
 .  S TABLEI=$P(CHUNK,":",2)
 .  S WKTTCODE=TCH1_$P(CHUNK,":")
 .  S TTABLE=$P($T(TYP+TABLEI^PRS8VW2),";;",2)
 .  I TTABLE=TA,$F(E(WK),WKTTCODE) D
 ..   S FOUND=1
 ..;  When found in PRS8VW2 table return code and length
 ..   S WKTTCODE=WKTTCODE_U_$P(CHUNK,":",3)
 I 'FOUND S WKTTCODE=0
 Q WKTTCODE
