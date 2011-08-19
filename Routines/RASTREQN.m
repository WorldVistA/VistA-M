RASTREQN ;HIRMFO/GJC-Status Requirement check for Radiopharms ;11/18/97  15:13
 ;;5.0;Radiology/Nuclear Medicine;**40,65**;Mar 16, 1998;Build 8
 ;
 ;supported IA #10104 reference to UP^XLFSTR and REPEAT^XLFSTR
 ;Supported IA #2056 refernce to GETS^DIQ
 ;
 ; *** 'RASTREQN' is called from routine: 'RASTREQ' ***
EN1(RADIO,RAJ) ; Check if all the required radiopharmaceutical data has
 ; been entered for this particular Examination Status.
 ; *=*=*= Kills 'X' if the status cannot be updated =*=*=*
 ; Input: 'RADIO' -> .5 node of the examination status (Radiopharms req)
 ;        'RAJ'   -> 0 node of the examination
 ;
 ; NOTE: RAMES1 is set in RASTREQ^RASTREQ subroutine.  Only the 'Status
 ; Tracking Of Exams' option displays which required fields are not
 ; populated for the next available Exam Status.
 ;
 ;----------------------------------------------------------------------
 ; Determine if 'Radiopharmaceutical' is required
 ; RAPRI defined in [RA STATUS CHANGE] & [RA EXAM EDIT]
 ;
 Q:"N"[$P(RADIO,"^")  ; Rpharms & Dosages NOT Req'd (either 'no' or null)
 N RAPROC S RAPROC(0)=$G(^RAMIS(71,+$P(RAJ,"^",2),0))
 Q:$P(RAPROC(0),"^",2)=1  ; Never ask Rpharms & Dosages
 ;----------------------------------------------------------------------
 N RA702 S RA702=+$P(RAJ,"^",28) ; ien in NUC MED EXAM DATA (70.2) file
 N RA7021,RACNT,RAI,RAMES2,RAREQ,RAZ S RAI=0
 I 'RA702,($P(RADIO,"^")="Y") D  Q
 . K X S RAZ="Radiopharmaceutical" X:$D(RAMES1) RAMES1
 . Q
 F  S RAI=$O(^RADPTN(RA702,"NUC",RAI)) Q:RAI'>0  D
 . S RA7021=$G(^RADPTN(RA702,"NUC",RAI,0)),RACNT=0
 . S RAMES2="W:$G(K)=$P($G(^RA(72,+$G(RANXT72),0)),U,3)&('$D(ZTQUEUED)#2) !,""Radiopharmaceutical: "",$$EN1^RAPSAPI(+$P(RA7021,""^""),.01)"
 . I $P(RADIO,"^")="Y",($P(RA7021,"^")=""!($P(RA7021,"^",7)="")) D
 .. K X S RACNT=RACNT+1 X:$D(RAMES1)&(RACNT=1) RAMES2
 .. I $P(RA7021,"^")="" S RAZ="Radiopharmaceutical" X:$D(RAMES1) RAMES1
 .. I $P(RA7021,"^",7)="" S RAZ="Dosage" X:$D(RAMES1) RAMES1
 .. Q
 . I $P(RADIO,"^",3)="Y",($P(RA7021,"^",4)="") D
 .. S RACNT=RACNT+1 X:$D(RAMES1)&(RACNT=1) RAMES2
 .. S RAZ="Activity Drawn" X:$D(RAMES1) RAMES1 K X
 .. Q
 . I $P(RADIO,"^",4)="Y",($P(RA7021,"^",5)=""!($P(RA7021,"^",6)="")) D
 .. K X S RACNT=RACNT+1 X:$D(RAMES1)&(RACNT=1) RAMES2
 .. I $P(RA7021,"^",5)="" S RAZ="Date/Time Drawn" X:$D(RAMES1) RAMES1
 .. I $P(RA7021,"^",6)="" S RAZ="Person Who Measured Dose" X:$D(RAMES1) RAMES1
 .. Q
 . I $P(RADIO,"^",5)="Y",($P(RA7021,"^",8)=""!($P(RA7021,"^",9)="")) D
 .. K X S RACNT=RACNT+1 X:$D(RAMES1)&(RACNT=1) RAMES2
 .. I $P(RA7021,"^",8)="" S RAZ="Date/Time Dose Administered" X:$D(RAMES1) RAMES1
 .. I $P(RA7021,"^",9)="" S RAZ="Person Who Administered Dose" X:$D(RAMES1) RAMES1
 .. Q
 . I $P(RADIO,"^",7)="Y",($P(RA7021,"^",11)=""!($P(RA7021,"^",12)="")) D
 .. K X S RACNT=RACNT+1 X:$D(RAMES1)&(RACNT=1) RAMES2
 .. I $P(RA7021,"^",11)="" S RAZ="Route Of Administration" X:$D(RAMES1) RAMES1
 .. I $P(RA7021,"^",12)="" S RAZ="Site Of Administration" X:$D(RAMES1) RAMES1
 .. Q
 . I $P(RADIO,"^",8)="Y",($P(RA7021,"^",13)="") D
 .. S RACNT=RACNT+1 X:$D(RAMES1)&(RACNT=1) RAMES2
 .. S RAZ="Lot No." X:$D(RAMES1) RAMES1 K X
 .. Q
 . I $P(RADIO,"^",9)="Y",($P(RA7021,"^",14)=""!($P(RA7021,"^",15)="")) D
 .. K X S RACNT=RACNT+1 X:$D(RAMES1)&(RACNT=1) RAMES2
 .. I $P(RA7021,"^",14)="" S RAZ="Volume" X:$D(RAMES1) RAMES1
 .. I $P(RA7021,"^",15)="" S RAZ="Form" X:$D(RAMES1) RAMES1
 .. Q
 . Q
 Q
NORADIO(RAPRI,RANXT72) ; This function will determine if Rpharm
 ; fields from the 'Nuc Med Exam Data' file [ ^RADPTN( ] will be asked.
 ; Input : 'RANXT72' -> .6 node of the 'Next' Exam Status
 ;       : 'RAPRI'   -> IEN of the procedure for this exam
 ; Output: '1' bypass Rpharm questions, else (0) ask
 Q:$TR($$UP^XLFSTR(RANXT72(.6)),"^","")="" 1 ; null or '^'s
 ; ------------------- Variable Definitions ----------------------------
 ; 'RAPROC(2)': ask Rpharm & Dosages parameter for this procedure
 ;----------------------------------------------------------------------
 N RAPROC S RAPROC(2)=$P($G(^RAMIS(71,RAPRI,0)),"^",2)
 ;----------------------------------------------------------------------
 ; *  following conditions apply for descendants exams & single exams  *
 ; *  Number 1: Suppress Rpharm = 1 even if 'Rpharms/Dose' Req'd       *
 ; *  Number 2: Suppress Rpharm = null or 0, 'Rpharm/Dose' not req'd   *
 Q:RAPROC(2)=1 1
 Q:"N"[$P(RANXT72(.6),"^") 1
 ;----------------------------------------------------------------------
 Q 0 ; ask Rpharm & Dosage fields
DISDEF(RADA) ; Display Radiopharmaceutical default data
 ; called from input templs: [RASTATUS CHANGE] and [RA EXAM EDIT]
 ; Input: RADA -> ien of the Nuc Med Exam Data record
 Q:'$O(^RADPTN(RADA,"NUC",0))  ; Radiopharms missing, no data
 N RADARY,RADEUC,RAFLDS,RAIENS,RAOPUT,X,Y W !
 S RAIENS="" D GETS^DIQ(70.2,RADA_",","**","NE","RADARY")
 F  S RAIENS=$O(RADARY(70.21,RAIENS)) Q:RAIENS=""  D
 . Q:$P(RAIENS,",",2)=""  ; top-level of the file
 . S (RADEUC,RAFLDS)=0
 . F  S RAFLDS=$O(RADARY(70.21,RAIENS,RAFLDS)) Q:RAFLDS'>0  D  Q:$D(DIRUT)
 .. I RAFLDS=.01 D
 ... S RADEUC=0 W !,$G(RADARY(70.21,RAIENS,RAFLDS,"E"))
 ... W !,$$REPEAT^XLFSTR("-",$L($G(RADARY(70.21,RAIENS,RAFLDS,"E")))),!
 ... Q
 .. E  D
 ... S RADEUC=RADEUC+1
 ... S RAOPUT=$$TRAN(RAFLDS)_$G(RADARY(70.21,RAIENS,RAFLDS,"E"))_$S(RAFLDS=2:" mCi",RAFLDS=4:" mCi",RAFLDS=7:" mCi",1:"")
 ... W:RADEUC=1 $E(RAOPUT,1,38) W:RADEUC=2 ?39,$E(RAOPUT,1,39)
 ... Q
 .. W:RADEUC'=2&($O(RADARY(70.21,RAIENS,RAFLDS))="") !
 .. W:RADEUC=2 ! S:RADEUC=2 RADEUC=0
 .. Q
 . Q
 Q
TRAN(X) ; Translate field name to a shorter length.
 Q:X=2 "Dose (MD Override): " Q:X=3 "Prescriber: "
 Q:X=4 "Activity Drawn: " Q:X=5 "Drawn: " Q:X=6 "Measured By: "
 Q:X=7 "Dose Adm'd: " Q:X=8 "Date Adm'd: " Q:X=9 "Adm'd By: "
 Q:X=10 "Witness: " Q:X=11 "Route: " Q:X=12 "Site: "
 Q:X=12.5 "Site Text: " Q:X=13 "Lot #: " Q:X=14 "Volume: "
 Q:X=15 "Form: "
VALDOS(RALOW,RAHI,X,RABACKTO,RAGOTO,RALASTAG,RAWARN) ;validate drawn/dose
 ; Called from [RA STATUS CHANGE] and [RA EXAM EDIT] input templates.
 ; Validate the value for either :
 ;      ACTIVITY DRAWN (fld 4, DD: 70.21)
 ;      DOSE           (fld 7, DD: 70.21)
 ; If there are limits on the Dosage, validate.  
 ; If validate fails, ask user if the invalid value is to be accepted.
 ;   If yes, proceed.
 ;   If no,  re-ask DOSE.  
 ; Input: RAHI     = Upper limit on dosage
 ;        RALOW    = Lower limit on dosage
 ;        X        = Value user input
 ;        RABACKTO = Previous Line tag to loop back to if need re-ask
 ;        RAGOTO   = Default linetag to proceed to if within range
 ;        RALASTAG = Last linetag in this edit template if early out
 ;        RAWARN   = display/not the warning msg -- 0=no, 1=yes
 ;
 ; Output: RAY     = linetag to proceed to after exiting this check
 ;
 N RAY,RAYN S RAY="" I X']"" S RAY=RAGOTO G KVAL
 S:RALOW=""&(RAHI="") RAY=RAGOTO
 S:RALOW]""&(RAHI="")&(X'<RALOW) RAY=RAGOTO
 S:RALOW=""&(RAHI]"")&(X'>RAHI) RAY=RAGOTO
 S:RALOW]""&(RAHI]"")&(X'<RALOW)&(X'>RAHI) RAY=RAGOTO
 I RAY="" D
 . F  D  Q:RAY]""
 .. I $O(^RA(79,RAMDIV,"RWARN",0)) D:RAWARN
 ... N I S I=0
 ... F  S I=$O(^RA(79,RAMDIV,"RWARN",I)) Q:I'>0  W !,$G(^(I,0))
 ... Q
 .. E  D:RAWARN
 ... W !,"This dose requires a written, dated and signed directive by"
 ... W !,"a physician."
 ... Q
 .. W !!?3,"Are you sure (Y/N)?: N//" R RAYN:DTIME
 .. I '$T!(RAYN["^") S RAY=RALASTAG Q
 .. S RAYN=$S(RAYN']"":"N",1:$$UP^XLFSTR($E(RAYN)))
 .. S RAY=$S(RAYN="N":RABACKTO,RAYN="Y":RAGOTO,1:"")
 .. I RAY="" W !!?3,"Enter 'Yes' if this value is acceptable, or 'No' if this field is to be",!?3,"re-edited.",$C(7)
 .. Q
 . Q
KVAL K RABACKTO,RAGOTO,RALASTAG,RAWARN
 Q RAY
