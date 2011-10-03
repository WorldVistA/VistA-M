PRSPESR1 ;WOIFO/JAH - part time physicians ESR Edit ;11/04/04
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ESRFRM(PRSIEN,PPI,PRSD) ;Run ScreenMan Form PRSA ESR EDIT on file 458
 ;
 N TOD,TOD2,TOUR,STAT,GLOB,PRSN1,PRSN2,PRSN4,PRSN5,PRSN6,Y31,PRSDTE
 N MLALLOW,PRSML,PRSML2,DFN,Z,ZENT,DIE,DA,DDSFILE,STOP,Z
 ;
 S STAT=$$GETSTAT(PRSIEN,PPI,PRSD)
 S TOD=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),U,2)
 S TOD2=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),U,13)
 ; NODES THAT WE MAY EDIT IN THE FORM
 S PRSN1=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,1)) ; tour segmts
 S PRSN4=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,4)) ; 2nd tour
 S PRSN5=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,5)) ; esr wrk
 S PRSN6=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,6)) ; daily esr remrks
 ;
 ; get ALL TOUR SGMNTS + meal for display
 ;
 S Y31=$$GETTOUR^PRSPESR3(PRSIEN,PRSD,TOD,PRSN1,PRSN4)
 S PRSML=$P($G(^PRST(457.1,TOD,0)),U,3)
 S MLALLOW=60
 ;
 ; If second tour, have meal time handy
 I $G(TOD2)>0 D
 .  S PRSML2=$P($G(^PRST(457.1,TOD2,0)),U,3)
 .  S MLALLOW=120
 ;
 S PRSDTE=$P($G(^PRST(458,PPI,2)),U,PRSD)
 ;
 ; DFN needed for old call to lock record.
 S DFN=PRSIEN I '$$AVAILREC^PRSLIB00("TK",.GLOB,.STOP) Q
 ; ScreenMan
 S DDSFILE=458,DDSFILE(1)=458.02,DA(2)=PPI,DA(1)=PRSIEN,DA=PRSD
 S Z=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,5))
 ;
 ; allowed types of time for ESR 
 ; days off only allow RG
 S ZENT=$S(Y31="Day Off":"RG",1:"RG AL AA DL ML HX CP RL SL CB AD WP TV TR")
 S DR="[PRSP ESR POST]" D ^DDS
 ;
 ; remove blank rows from ESR
 S Z=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,5))
 S ^PRST(458,PPI,"E",PRSIEN,"D",PRSD,5)=$$BURP^PRSPESR2(Z)
 D:GLOB]"" UNLOCK^PRSLIB00(GLOB)
 Q
 ;
GETSTAT(PRSIEN,PPI,PRSD) ; func return status
 ; esr daily status (#146) 1:NOT STARTED;2:PENDING;3:RESUBMIT;
 ; 4:SIGNED;5:APPROVED;6:DAY OFF
 Q $P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,7)),"^",1)
 ;
ESRVALID ; Validate Daily ESR data
 ; called when PTP attempts to save ScrMn form PRSP ESR POST (F458)
 ; DDSERROR set to prevent save.
 ; DDSBR set takes user field
 ;
 ;  Z - combo: global time segs + form edits.
 ;
 ;  If data unchanged, skip validation and esig
 ;  But if status = Pend OR Resub, PTP may sign even if data unchanged.
 N STR,WARNING
 I $G(Z)'="",$G(Z)=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,5)),STAT'=2,STAT'=3 D  Q
 .  D MSG^DDSUTL("...No edits to save")
 ;
 ; If DDSERROR (bad user data), return to ScreenMan
 D CHKDATA
 Q:$G(DDSERROR)
 ;
 ; display warning if any are found but don't stop user from signing
 I $G(WARNING) D WARNMSG^PRSPESR3(STR)
 ;
 ; If user hits return at sign prompt, save as pending
 ; If user types "^" don't save changes
 ; If user signs, save.
 ;
 N X1
 D SIG^XUSESIG
 I X1="" D
 . N PRSMSG
 . S PRSMSG="CANCEL: ESR day changes were not saved."
 .  I $G(X)="^" D
 ..    S DDSERROR=1
 ..    D MSG^DDSUTL(PRSMSG)
 .  E  D
 ..    N DIE,DR,DA
 ..    S DA(2)=$G(PPI),DA(1)=$G(PRSIEN),DA=$G(PRSD)
 ..;  if status is resubmit and they didn't sign then leave it resubmit
 ..    I STAT=3 D
 ...     S DR="146///RESUBMIT;149///MANUAL POST"
 ...     S PRSMSG="RESUBMIT: changes saved w/out signature, but status remains Resubmit."
 ..    E  D
 ...     S DR="146///PENDING;149///MANUAL POST"
 ...     S PRSMSG="PENDING: ESR day changes saved w/out signature."
 ...     S STAT=2 ; form global var ESR DAILY STATUS gets PENDING
 ..    S DIE="^PRST(458,"_DA(2)_",""E"","_DA(1)_",""D"","
 ..    D ^DIE
 ..    K X ; reset X since it's saved to dataBse.
 ..    D MSG^DDSUTL(PRSMSG)
 E  D
 .; update ESR DAILY STATUS and ESR LAST SIGN METHOD
 .  N PRSFDA,IENS,STAMP
 .  S STAMP=$$NOW^XLFDT()
 .;
 .  S IENS=PRSD_","_PRSIEN_","_PPI_","
 .  S PRSFDA(458.02,IENS,146)=4
 .  S PRSFDA(458.02,IENS,147)=STAMP
 .  S PRSFDA(458.02,IENS,149)=1
 .  D FILE^DIE("","PRSFDA")
 .  D MSG^DIALOG()
 .;
 .  K X ; reset X, it's saved to database.
 .  S STAT=4 ; form global var ESR DAILY STATUS gets SIGNED
 .  D MSG^DDSUTL("SIGNED:  ESR data saved with signature.")
 Q
 ;
CHKDATA ; called to validate screenman posting on ESR daily
 ;
 ; Z initialized to data that appears on the unedited form.
 ; when a field on ScreenMan form changes the appropriate piece
 ; of Z is updated in the post action change field in ScreenMan.
 ; so Z contains the original data for a day plus any changes that
 ; the user is trying to save.
 ;  each 5 pieces of z hold START, STOP, TYPE OF TIME, REMARKS, MEAL
 ;
 N T,K,ZS,NOTHING,MLP,DY2,MTOT,TWO,Z1,Z2,Y
 S ZS=""
 ;
 ; 2 day tour?
 S TWO=$P($G(^PRST(457.1,+TOD,0)),U,5)
 S DY2=TWO="Y"
 I TOD2,'DY2 S TWO=$P($G(^PRST(457.1,+TOD2,0)),U,5),DY2=TWO="Y"
 ;
 ;loop thru 5 columns, 7 time segments
 ; quit if we encounter an error
 F K=1:5:31 Q:$G(DDSERROR)  D
 .;
 .; if absolutely nothing on any segments in the row or just a zero
 .; in meal column then skip row.
 .;
 .  S NOTHING=(($P(Z,U,K)="")&($P(Z,U,K+1)="")&($P(Z,U,K+2)="")&($P(Z,U,K+3)="")&(($P(Z,U,K+4)="")!($P(Z,U,K+4)=0)))
 .  Q:NOTHING
 .;
 .;  missing start or stop
 .  I $P(Z,U,K)=""!($P(Z,U,K+1)="") D E8 S DDSERROR=1 Q
 .;
 .; 2nd day posting on 1 day tour (ALLOW RG POSTING ACROSS MID)
 .  S X=$P(Z,U,K)_U_$P(Z,U,K+1)
 .  D CNV^PRSATIM S Z1=$P(Y,U,1),Z2=$P(Y,U,2)
 .  D V0^PRSATP1
 .  I Z2>1440,TWO'="Y","RG OT CT SB ON UA"'[$P(Z,U,K+2) D  Q
 ..    D E4
 ..    S DDSERROR=1
 .;
 .; posted more than 48 hrs (2880 min)
 .  I Z2>2880 D E5 S DDSERROR=1 Q
 .;
 .; no type of time
 .  I $P(Z,U,K+2)="" D E9 S DDSERROR=1 Q
 .;
 .   I '(Z["HX"&("ON HW"[$P(Z,U,K+2))),'(Z["^ON"&(Z["OT")),'(Z["^ON"&(Z["CT")),$D(T(Z1)) S DDSERROR=1 D E3 Q
 .   I $P(Z,U,K+2)="HW",Z'["HX",'$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),U,12) S DDSERROR=1 D E7 Q
 .  I $P(Z,U,K+2)'="" S T(Z1,K)=Z2_U_$P(Z,U,K,K+3)
 ;
 ;  T: 1st subscript is start time (minutes from midnight)
 ;     2nd subsc is segment number on form (or in Z var)
 ;     piece 1 stop time in minutes from midnight. 
 ;   for 3 segment postings will look like the following:
 ;        T(945,1)=1140^03:45P^07:00P^RG^
 ;        T(1140,6)=1305^07:00P^09:45P^RG^
 ;        T(1320,11)=1380^10:00P^11:00P^RG
 I $G(DDSERROR) D HLP^DDSUTL(.STR) Q
 I '$D(T) Q
 ;
 ; segment overlap
 I Z'["HX",'(Z["^ON"&(Z["OT")),'(Z["^ON"&(Z["CT")) D
 .  S Z1=""
 .  F  S Z1=$O(T(Z1)) Q:Z1=""!($G(DDSERROR))  D
 ..   I Z1'<T(Z1,$O(T(Z1,0))) D
 ...     D E1
 ...     S DDSERROR=1
 ..   E  D
 ...    S Y=$O(T(Z1))
 ...    I Y,T(Z1,$O(T(Z1,0)))>Y S DDSERROR=1 D E2
 I $G(DDSERROR) D HLP^DDSUTL(.STR) Q
 ;
 ; leave outside time segments
 I $$VALIDLV^PRSPESR2(PRSN1,.T),$$VALIDLV^PRSPESR2(PRSN4,.T) S DDSERROR=1 D E14,HLP^DDSUTL(.STR) Q
 ;
 S Z1=$$GET^DDSVAL(DIE,.DA,145)
 ;
 ; make sure we have some txt in remarks field when required
 I Z1="" D
 .  F K=1:5:31 Q:$G(DDSERROR)  D
 ..   I $P(Z,U,K+2)="AA" D E6 S DDSERROR=1 Q
 ..   I $P(Z,U,K+2)="WP",$P(Z,U,K+3)=3 D E10 S DDSERROR=1 Q
 I $G(DDSERROR) D HLP^DDSUTL(.STR) Q
 ;
 ; check for too much total meal for whole day
 S MTOT=0
 F K=1:5:31 S MTOT=MTOT+$P(Z,U,K+4)
 I MTOT>MLALLOW D E15 S DDSERROR=1 D HLP^DDSUTL(.STR) Q
 ;
 ; check for too much meal on any segment
 F K=1:5:31 Q:$G(DDSERROR)  D
 .  S MLP=$P(Z,U,K+4)
 .  I MLP>0 D
 ..    N WORK S WORK=$$ELAPSE^PRSPESR2(MLP,$P(Z,U,K),$P(Z,U,K+1))
 ..    I $E(WORK,1,1)="-"!(WORK="00:00")!(WORK=0) D E17 S DDSERROR=1
 I $G(DDSERROR) D HLP^DDSUTL(.STR) Q
 ;
 ; check for comptime earned and used w/out remarks
 F K=1:5:31 Q:$G(DDSERROR)  D
 . I ($P(Z,U,K+2)="CT")&($P(Z,U,K+3)="") D E11 S DDSERROR=1
 I $G(DDSERROR) D HLP^DDSUTL(.STR) Q
 ;
 F K=1:5:31 Q:$G(DDSERROR)  D
 . I ($P(Z,U,K+2)="CU")&($P(Z,U,K+3)="") D E12 S DDSERROR=1
 I $G(DDSERROR) D HLP^DDSUTL(.STR) Q
 ;
 ;make sure compressed tours don't post credit hrs remarks.
 I $$COMPR^PRSATP1(PPI,DFN) D
 .  F K=1:5:31 Q:$G(DDSERROR)  D
 ..    I $$CTCH^PRSATP1(Z,K) D E13 S DDSERROR=1
 I $G(DDSERROR) D HLP^DDSUTL(.STR) Q
 Q
E1 S STR="A start time is not less than a stop time." Q
E2 S STR="End of one segment must not be greater than start of next." Q
E3 S STR="Duplicate start times encountered." Q
E4 S STR="Segment of second day encountered; no two-day tour specified." Q
E5 S STR="Segment of third day encountered." Q
E6 S STR="Remarks must be entered when AA is posted." Q
E7 S STR="HW can only be posted with HX or on a Holiday." Q
E8 S STR="Start or Stop Time not entered for a segment." Q
E9 S STR="Type of Time not entered for a segment." Q
E10 S STR="Remarks must be entered for WP due to AWOL." Q
E11 S STR="REMARKS CODE must be entered when CT is posted." Q
E12 S STR="REMARKS CODE must be entered when CU is posted." Q
E13 S STR="REMARKS CODE:  Compressed tours can't earn credit hours." Q
E14 S STR="Leave cannot be posted outside tour." Q
E15 S STR="Meal time cannot exceed "_MLALLOW_" minutes." Q
E16 S STR="Warning: A segment crosses midnight and a subsequent segment appears to be earlier in the day.  This is o.k. as long as all start times begin on the selected ESR day."
E17 S STR="Meal time must be less than time on the segment it is posted with." Q
 Q
