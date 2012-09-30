PRSNRMM ;WOIFO-JAH - POC Record and Timecard Mismatches;07/31/09
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PPMM(PRSIEN,PPI,PG,STOP) ; report mismatches for a pay period
 N PRSD,MM
 S STOP=+$G(STOP)
 S PG=+$G(PG)
 D HDR(.STOP,1,PRSIEN,PPI,.PG)
 F PRSD=1:1:14 Q:STOP  D
 .  K MM
 .  D DAILYMM(.MM,PRSIEN,PPI,PRSD)
 .  Q:MM(0)'>0
 .  W !!,$P($G(^PRST(458,PPI,2)),U,PRSD)
 .  D DISPMM(.MM,.STOP,1,PRSIEN,PPI,PRSD)
 .  I (IOSL-4)<$Y D HDR(.STOP,1,PRSIEN,PPI,.PG)
 Q
DISPMM(MM,STOP,HDR,PRSIEN,PPI,PRSD) ; Display a single day of mismatches between
 ;                  a timecard and a POC record
 ; INPUT:
 ;   MM-(array by reference) call DAILYMM to get an array of 
 ;       mismatches to pass to this display routine
 ;   PPI-(required) pay period IEN
 ;   PRSD-(required) day number in pay period referenced in PPI
 ;   HDR-(optional) set to true if you want a header included
 ;
 ; OUTPUT:
 ;   STOP-reference variable returned as true if the user was
 ;        prompted to continue and responded with an '^' to quit
 ;
 N T1,T2,TT,P1,P2,PT,PTE,TTE,MISM,DASH
 I $G(STOP)'>0 S STOP=0
 I $G(HDR)'>0 S HDR=0
 S DASH=" -"
 S J=0
 F  S J=$O(MM(J)) Q:J'>0!STOP  D
 .  I (IOSL-4)<$Y D HDR(.STOP,HDR,PRSIEN,PPI,.PG)
 .  Q:STOP
 .  S MISM=$G(MM(J))
 .  S T1=$$ETIM($P(MISM,U))
 .  S T2=$$ETIM($P(MISM,U,2))
 .  S TT=$P(MISM,U,3)
 .  S TTE=$P(MISM,U,4)
 .  S P1=$$ETIM($P(MISM,U,5))
 .  S P2=$$ETIM($P(MISM,U,6))
 .  S PT=$P(MISM,U,7)
 .  S PTE=$P(MISM,U,8)
 .  W !,$J(T1,7),DASH,$J(T2,7),?19,TT,?24,TTE,?40,$J(P1,7),DASH,$J(P2,7),?60,PT,?64,PTE
 Q
HDR(STOP,HDR,PRSIEN,PPI,PG) ;
 I PG>0 S STOP=$$ASK^PRSLIB00()
 Q:STOP
 W @IOF,! S PG=PG+1
 I HDR D
 .  N PPE,PPBEG,PPEND,TITLE,TITLE2,PGE,RUNDATE
 .  S PPE=$P($G(^PRST(458,PPI,0)),U)
 .  S PPBEG=$P($G(^PRST(458,PPI,2)),U,1)
 .  S PPEND=$P($G(^PRST(458,PPI,2)),U,14)
 .  S TITLE="Mismatch Report Between ETA Timecard & Point of Care Record"
 .  S TITLE2="for Pay Period "_PPE_" ("_PPBEG_" - "_PPEND_")"
 .  W ?((IOM-$L(TITLE))\2),TITLE
 .  W !,?((IOM-$L(TITLE2))\2),TITLE2
 .  S PGE="Page "_PG
 .  I PG>0 W ?(IOM-$L(PGE)-2),PGE
 .  S RUNDATE="Run Date: "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 .  W !,?3,"Nurse: ",$P($G(^PRSPC(PRSIEN,0)),U)
 .  W ?(IOM-$L(RUNDATE)-3),RUNDATE
 .  W !!,?9,"ETA TIMECARD",?46,"POINT OF CARE RECORD"
 .  W !,?2,"=================================",?40,"==================================="
 Q
DAILYMM(MM,PRSIEN,PPI,PRSD) ;
 ; INPUT:
 ;   PRSIEN: 450/451 IEN
 ;   PPI: 451/458 Pay Period IEN
 ;   PRSD: day 1-14 of pay period
 ; OUTPUT:
 ;   MM - mismatch array index 1..n for each mismatch
 ;   MM(0) = number of mismatches and zero for none
 ;   MM(0+n) = TC Seg start^TC Seg Stop^TT^POC seg start^POC seg stop^TT
 ;
 ;Loop through Timecard storing types of time in TD string and TD array
 ;
 N ND,TD
 S MM(0)=0
 D BLDTC(.TD,PRSIEN,PPI,PRSD,0)
 ;
 ; Loop through POC Record storing time in ND string and ND array
 ;
 D BLDPOC(.ND,PRSIEN,PPI,PRSD,0)
 I '$D(ND) S MM="-1^NO POC RECORD" Q
 ;
 ;  Strings will look like
 ;
 ;  TD="00000000000000000AAAAAAAAAAAAAAAAAA000000000000000000000..."
 ;  ND="00000000000000000AAAAAAAAAAAAAAAAAAWWWWWWWWWWWWWWWWWWW00..."
 ;
 ;
 ;  arrays will look like:
 ;
 ;   TD(0)=code^segment start^segment stop^ETA TT
 ;   TD(1)=code^segment start^segment stop^ETA TT
 ;   TD(3)=code^segment start^segment stop^ETA TT
 ;   TD(4)=code^segment start^segment stop^ETA TT
 ;   .....
 ;   TD(188)=code^segment start^segment stop^ETA TT
 ;   TD(189)=code^segment start^segment stop^ETA TT
 ;   TD(190)=code^segment start^segment stop^ETA TT
 ;
 ;   ND(0)=code^segment start^segment stop^POC TT
 ;   ND(1)=code^segment start^segment stop^POC TT
 ;   .....
 ;   ND(191)=code^segment start^segment stop^POC TT
 ;   ND(192)=code^segment start^segment stop^POC TT
 ;
 ;  If strings match there are no mismatches and we are done.
 ;
 I ND=TD Q
 ;
 ; traverse strings until first mismatched characters are found.
 ;  Once a mismatch is found determine the segments associated with
 ; each of the corresponding characters that mismatch.
 ;  This can easily be found because the ND and TD arrays have
 ; stored the start and stop of each segment in the node where
 ; corresponding to the position in the ND and TD strings.
 ;
 N TCBEG,TCEND,TCBEGI,TCENDI,POCTT,POCBEGI,POCENDI,POCBEG,POCEND
 N I,POCTT,POCTTE,TCTT,TCTTE
 F I=1:1:192 I $E(ND,I)'=$E(TD,I) D
 .  S MM(0)=MM(0)+1
 .  S TCTT=$P(TD(I),U,5)
 .  S TCTTE=$$TTE^PRSPSAPU(TCTT)
 .  I $P(TD(I),U,2)="Z" S TCTT="",TCTTE="Unposted Tour"
 .  S TCBEGI=+$P(TD(I),U,3)
 .  S TCENDI=+$P(TD(I),U,4)
 .  S POCTT=$P(ND(I),U,5)
 .  S POCTTE=$$TTE^PRSPSAPU(POCTT)
 .  S POCBEGI=+$P(ND(I),U,3)
 .  S POCENDI=+$P(ND(I),U,4)
 .  S TCBEG=+$G(TD(TCBEGI))
 .  S TCEND=+$G(TD(TCENDI+1))
 .  S POCBEG=+$G(ND(POCBEGI))
 .  S POCEND=+$G(ND(POCENDI+1))
 .;   Adjust end points of segment for clearer reporting when 
 .;   POC or ETA has no data at the point of mismatch
 .  I $E(TD,I)=0 D
 ..   I TCENDI>POCENDI S TCEND=+$G(ND(POCENDI+1))
 ..   I TCBEGI<POCBEGI S TCBEG=+$G(ND(POCBEGI))
 ..   S TCTTE="No Data"
 .  I $E(ND,I)=0 D
 ..   I POCENDI>TCENDI S POCEND=+$G(TD(TCENDI+1))
 ..   I POCBEGI<TCBEGI S POCBEG=+$G(TD(TCBEGI))
 ..   S POCTTE="No Data"
 .  S MM(+MM(0))=TCBEG_U_TCEND_U_TCTT_U_TCTTE_U_POCBEG_U_POCEND_U_POCTT_U_POCTTE
 .;  start the search back up at the end of the shorter segment
 .;  unless there is no time in the shorter segment
 .  I POCENDI=0 S I=TCENDI Q
 .  I TCENDI=0 S I=POCENDI Q
 .  I POCENDI>TCENDI D
 ..    S I=TCENDI
 .  E  D
 ..    S I=POCENDI
 Q
BLDPOC(ND,PRSIEN,PPI,PRSD,ACTIVITY) ; Build string and array from POC day
 ; initialize ND
 ; INPUT:
 ;   PRSIEN: 450 IEN
 ;   PPI:  458/451 IEN
 ;   PRSD: Pay period day number 1-14
 ;   ACTIVITY: flag set to true if you want to have only portions
 ;             of the array with activity to be returned.
 ;   ND: activity string and array
 ;
 N I,POCD,J,CC,SET,T1,T2,TT,SEG
 F I=1:1:192 S $E(ND,I)=0
 F I=1:1:193 S ND(I)=+$$POSTIM(I,1)
 D L1^PRSNRUT1(.POCD,PPI,PRSIEN,PRSD)
 S SEG=0
 F  S SEG=$O(POCD(SEG)) Q:SEG'>0  D
 .  S T1=$$TIMEPOS($P(POCD(SEG),U,9),1)
 .  S T2=$$TIMEPOS($P(POCD(SEG),U,10),0)
 .  S TT=$P(POCD(SEG),U,4)
 .  S CC=$$CONVERT(TT)
 .  F J=T1:1:T2 Q:J>192  S $P(ND(J),U,2,5)=CC_U_T1_U_T2_U_TT,$E(ND,J)=CC
 ; loop through activity again to update all the start and stop
 ; times for each segment, this will give segment start and stops
 ; to periods where there is no data
 ;
 N LQH,NEWSTART,QH,NEWEND
 S LQH=0,NEWSTART=1
 F I=1:1:192 D
 .  S QH=$E(ND,I)
 .  I LQH'=QH S NEWSTART=I,LQH=QH
 .  S $P(ND(I),U,3)=NEWSTART
 ;
 S LQH=0,NEWEND=192
 F I=192:-1:1 D
 .  S QH=$E(ND,I)
 .  I LQH'=QH S NEWEND=I,LQH=QH
 .  S $P(ND(I),U,4)=NEWEND
 ;
 ;
 ; If activity is true remove all nodes with no activity
 ;
 I ACTIVITY D
 . F I=1:1:193 I $P($G(ND(I)),U,2)="" K ND(I)
 . S ND=0
 ;
 Q
BLDTC(TD,PRSIEN,PPI,PRSD,ACTIVITY) ; Build string and array from Time Card day
 ; initialize TD
 ;  INPUT:  standard PRSIEN, PPI, PRSD
 ;          ACTIVITY-(optional) flag set to true if return array
 ;                   should only contain nodes with activity
 ;  OUTPUT:
 ;   TD (string) with 192 characters representing each 15 minutes of
 ;      the day
 ;   if ACTIVITY parameter true then TD string will be set as follows:
 ;        TD = timecard posting status ^ tour of duty IEN
 ;
 ;   TD(1..192)--array with nodes of activity for each 15 min.
 ;
 N I,J,CC,SET,TS,TE,TOUR,T1,T2,TT,TC,TOD,TODD,TCD,X,Y,POSTED,DAYOFF,SEG,NEWSTART,NEWEND,LQH,POC,QH
 F I=1:1:193 S TD(I)=+$$POSTIM(I,1)
 D LOADTOD^PRSPLVU(PPI,PRSIEN,PRSD,.TOD,.TODD)
 D LOADTC^PRSPLVU(PPI,PRSIEN,PRSD,.TCD)
 ;
 ; Check for no time posted on the timecard
 N X0,PSTAT
 S X0=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0))
 ;
 ; posting status--(T)imekeeper, (P)ayroll, (X)mitted
 S PSTAT=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,10)),U,1)
 ;
 ; tour of duty (1=day off, 3,4=intermittent)
 S TC=$P(X0,U,2)
 S POSTED=1
 I "1 3 4"'[TC,PSTAT="" S (PSTAT,POSTED)=0 ;  - no posting to tour
 ;
 F I=1:1:192 S $E(TD,I)=0
 ;
 S SEG=0
 F  S SEG=$O(TOD(SEG)) Q:SEG'>0  D
 .  S TT=$P(TOD(SEG),U,3)
 .  I TT="RG" S TT="WI"
 .  S CC=$$CONVERT(TT)
 .  S POC=$$CNVTTPOC(TT)
 .  I 'POSTED S CC="Z"
 .  S T1=$P(TOD(SEG),U,4)
 .  S X=T1,Y=0 D MIL^PRSATIM S T1=Y
 .  S T2=$P(TOD(SEG),U,5)
 .  S X=T2,Y=1 D MIL^PRSATIM S T2=Y
 .  ; if the start time is earlier than the stop time then it
 .  ; must be a time on a second day of a two day tour
 .  I T1>T2 S T2=T2+2400
 .  S TOUR(T1)=T2
 .  S T1=$$TIMEPOS(T1,1)
 .  S T2=$$TIMEPOS(T2,0)
 .  F J=T1:1:T2 Q:J>192  S $P(TD(J),U,2,6)=CC_U_T1_U_T2_U_TT_U_POC,$E(TD,J)=CC
 ;
 ; place posted exceptions
 ;
 S SEG=0
 F  S SEG=$O(TCD(SEG)) Q:SEG'>0  D
 .  S TT=$P(TCD(SEG),U,3)
 .  S T1=$P(TCD(SEG),U,4)
 .  S X=T1,Y=0 D MIL^PRSATIM S T1=Y
 .  S T2=$P(TCD(SEG),U,5)
 .  S X=T2,Y=1 D MIL^PRSATIM S T2=Y
 .  ; try to place exceptions on the correct day
 .  S T1=$$PLACEX(T1,T2,.TOUR)
 .  ; if the start time is earlier than the stop time then it
 .  ; must be a time on a second day of a two day tour
 .  I T1>T2 S T2=T2+2400
 .  S T1=$$TIMEPOS(T1,1)
 .  S T2=$$TIMEPOS(T2,0)
 .  S CC=$$CONVERT(TT)
 .  S POC=$$CNVTTPOC(TT)
 .  F J=T1:1:T2 Q:J>192  S $P(TD(J),U,2,6)=CC_U_T1_U_T2_U_TT_U_POC,$E(TD,J)=CC
 ;
 ; place meal
 ;TODD(1)="3090917^3090918.08^30^2"
 N LEN,LONGSEG,MEAL,EN,STPOS,ENPOS,MIDPOS,MLOC,ST
 I +$P($G(TODD(1)),U,3)>0 D
 .S MEAL=0
 .F  S MEAL=$O(TODD(MEAL)) Q:MEAL'>0  D
 ..   S LEN=$P(TODD(MEAL),U,3)
 ..   S LONGSEG=$P(TODD(MEAL),U,4)
 ..;;;;;; start of longest tour segment
 ..   S ST=$P(TOD(MEAL_"-"_LONGSEG),U,4)
 ..   S X=ST,Y=0 D MIL^PRSATIM S ST=Y
 ..;;;;;; end of longest tour segment
 ..   S EN=$P(TOD(MEAL_"-"_LONGSEG),U,5)
 ..   S X=EN,Y=1 D MIL^PRSATIM S EN=Y
 ..;
 ..   I ST>EN S EN=EN+2400
 ..;;;;;;
 ..   S STPOS=$$TIMEPOS(ST,1)
 ..   S ENPOS=$$TIMEPOS(EN,0)
 ..   S MIDPOS=STPOS+((ENPOS-STPOS)\2)
 ..;;;;;;; get starting location of the segment where this midway falls
 ..   S MLOC=$P(TD(MIDPOS),U,3)
 ..   S $P(TD(MLOC),U,7)=LEN
 ; loop through activity again to update all the start and stop
 ; times for each segment, since exceptions that overwrote the tour
 ; will change the start and stops for subsections of tour
 ;
 S LQH=0,NEWSTART=1
 F I=1:1:192 D
 .  S QH=$E(TD,I)
 .  I LQH'=QH S NEWSTART=I,LQH=QH
 .  S $P(TD(I),U,3)=NEWSTART
 ;
 S LQH=0,NEWEND=192
 F I=192:-1:1 D
 .  S QH=$E(TD,I)
 .  I LQH'=QH S NEWEND=I,LQH=QH
 .  S $P(TD(I),U,4)=NEWEND
 ;
 ; If activity is true remove all nodes with no activity
 ;
 I ACTIVITY D
 . F I=1:1:193 I $P($G(TD(I)),U,2)="" K TD(I)
 . S TD=PSTAT_U_TC
 ;
 Q
 ;
PLACEX(T1,T2,TOUR) ;
 ;
 N TS,TE,NEWT1,TEMPT1
 ;need to make two passes on the tour array as there may be more than one tour
 ;and need to make sure that the exception doesn't fit within any tour before adjusting
 S NEWT1=""
 S TS=""
 F  S TS=$O(TOUR(TS)) Q:TS=""  D  Q:NEWT1'=""
 . S TE=TOUR(TS)
 . I T1'<TS D  Q:NEWT1'=""
 .. ; this time segment falls within the tour, so fits
 .. I T1'>TE S NEWT1=T1 Q
 .. ; this time segment starts no more than 4 hours after tour, then probably fits
 .. I $$TIMEDIF(TE,T1)'>240 S NEWT1=T1 Q
 . I T1<TS D  Q:NEWT1'=""
 .. ; this time segment starts no more than 4 hours before tour, then probably fits
 .. I $$TIMEDIF(T1,TS)'>240 S NEWT1=T1 Q
 ;
 I NEWT1'="" Q NEWT1
 ;
 ; looks like we have a segment that should be starting in day two
 ; but need to see if that fits
 S TEMPT1=T1+2400
 S TS=""
 F  S TS=$O(TOUR(TS)) Q:TS=""  D  Q:NEWT1'=""
 . S TE=TOUR(TS)
 . I TEMPT1'<TS D  Q:NEWT1'=""
 .. ; this time segment falls within the tour, so fits
 .. I TEMPT1'>TE S NEWT1=TEMPT1 Q
 .. ; this time segment starts no more than 4 hours after tour, then probably fits
 .. I $$TIMEDIF(TE,TEMPT1)'>240 S NEWT1=TEMPT1 Q
 ;
 ;if we didn't find it earlier, then just leave it as the originally entered time
 ;and if that is wrong, user will need to adjust it
 I NEWT1="" S NEWT1=T1
 ;
 Q NEWT1
 ;
TIMEDIF(TIME1,TIME2) ;
 ;
 ;SUBTRACT TIME1 FROM TIME2
 ;RETURN TIME DIFFERENCE IN MINUTES
 N HOUR,MIN,DIFF,MIN1,MIN2
 S MIN=TIME1#100,HOUR=TIME1\100,MIN1=HOUR*60+MIN
 S MIN=TIME2#100,HOUR=TIME2\100,MIN2=HOUR*60+MIN
 S DIFF=MIN2-MIN1
 Q DIFF
 ;
CNVTTPOC(TT) ; convert an ETA type of time to POC time
 N TC,POC,CODEPOS
 S POC="AA^AA^AD^AL^CB^CU^DL^RL^RS^HX^ML^SL^WP^NL^NP^WI^TR^TV^WO^WO^WO^WO^HW^^^^"
 S TC="AA^CP^AD^AL^CB^CU^DL^RL^RS^HX^ML^SL^WP^NL^NP^WI^TR^TV^WO^OT^CT^RG^HW^UN^ON^SB^"
 S CODEPOS=$FIND(TC,TT)
 Q $P(POC,U,CODEPOS/3)
 ;
CONVERT(TT) ; Convert a type of time code to a comparison code
 ;                                            COMPARISON
 ; ETA                   POC                   STRINGS
 ; CODE ETA DX          CODE    POC DX         CODE
 ; ==== ===============  =====   ===========    =====
 ; AA   Auth Abs           AA    Auth Abs         A
 ; CP   Cont of Pay        AA    Auth Abs         A
 ; AD   Adoption           AD    Adoption         D
 ; AL   Annual Leave       AL    Annual Leave     L
 ; CB   Fam Care Bereav    CB    Fam Care Bereav  B
 ; CU   Comp/Cred Used     CU    Comp/Cred Used   U
 ; DL   Donor Leave        DL    Donor Leave      d
 ; RL   Restored AL        RL    Restored AL      R
 ; RS   Recess             RS    Recess           r
 ; HX   Holiday Excused    HX    Holiday Excused  h
 ; ML   Military Leave     ML    Military Leave   M
 ; SL   Sick Leave         SL    Sick Leave       S
 ; WP   Leave w/o Pay      WP    Leave w/o Pay    W
 ; NL   Non-Pay AL         NL    Non-Pay AL       n
 ; NP   Non-Pay            NP    Non-Pay          N
 ;      Tour Time (posted) WI    Work in tour     W
 ; TR   Train (in tour)    TR    Work in Tour     W
 ; TV   Travel (in tour)   TV    Work in Tour     W
 ; OT   Overtime           WO    Work out of tour w
 ; CT   Comp/Cred Earn     WO    Work out of tour w
 ; RG   Reg Sched          WO    Work out of tour w
 ; HW   Hol Work (in tour) HW                     H
 ; UN   Unavailable      Not reported          Ignored
 ; ON   On-Call          Not reported          Ignored
 ; SB   Standby          Not reported          Ignored
 ;
 N TC,CC,CODEPOS
 S CC="AADLBUdRrhMSWnNWWWwwwwH000"
 S TC="AA^CP^AD^AL^CB^CU^DL^RL^RS^HX^ML^SL^WP^NL^NP^WI^TR^TV^WO^OT^CT^RG^HW^UN^ON^SB^"
 S CODEPOS=$FIND(TC,TT)
 Q $E(CC,CODEPOS/3)
 ;
TIMEPOS(MT,SORE) ; Convert MILTIME to positional int. where 1 represents
 ; the period from Mid-12:15, 2 - 12:15-12:30, and so on, with 96 
 ; representing the period from 11:45pm to mid.
 ;
 ;  INPUT:
 ;      MT: military time from 0 to 4800 (2 day clock)
 ;      SORE-flag 0 for start time 1 for end time (required)
 ;  OUTPUT:
 ;      integer value specifying the position in a string
 ;      where each position represents a 15 minute increment of the day
 ; 0=1
 ; 15=2
 ; 30=3
 ; ...
 ; 300=13
 ; 315=14
 ; ...
 ; 1000=50
 ; ...
 ; 1100=55
 ;
 Q ((MT\100)*4)+((("."_$P(MT/100,".",2))*100)/15)+$G(SORE)
 ;
POSTIM(I,BORE) ; convert the positional integer time to military time
 ;  INPUT: BORE-0=START, 1=END, flag specifies if this is a 
 ;           start time or end time
 N MINS
 S I=I-$G(BORE)
 S MINS=I#4*15 I 'MINS S MINS="00"
 Q (I\4)_MINS
 ;
 ;
ETIM(MIL) ; Convert a military time to a standard time
 ;
 N T,H,M
 I (MIL#2400)=0 Q "MID"
 I (MIL#1200)=0 Q "NOON"
 S T=MIL/100 S H=$P(T,".",1),M=$P(T,".",2)
 I (H#12)=0 Q "12"_":"_M_$S(H=12:"PM",H=24:"AM",1:"PM")
 S M=$S($L(M)=0:"00",$L(M)=1:M_"0",1:M)
 I (MIL<1200) Q H_":"_M_"AM"
 I MIL>1200,MIL<2400 Q H-12_":"_M_"PM"
 I MIL>2400,MIL<3600 Q H-24_":"_M_"AM"
 I MIL>3600 Q H-36_":"_M_"PM"
 Q -1
