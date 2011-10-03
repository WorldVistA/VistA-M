OOPSUTL3 ;HINES/WAA-Utilities Routines ;3/24/98
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
CHECK(IEN,FORM) ; Checks to see if there was data enter for a form
 N ANS,I,LIST,FIELD
 S ANS=0
 I FORM="CA1" S LIST="130,176,138,139,140,175,146,148,150,156,157,158,159,160,161,162,163"
 ; Patch 8 - removed field 250 from list below
 I FORM="CA2" S LIST="230,237,242,243,244,245,246,247,248,249,251,252,258"
 F I=1:1 S FIELD=$P(LIST,",",I) Q:FIELD=""  D  Q:ANS
 .I $$GET1^DIQ(2260,IEN,FIELD,"I")'="" S ANS=1
 .Q
 Q ANS
PSDTCHK(DATE,NOYR,FLD) ;
 ; this functionality returns a valid date (the one passed in) if
 ; the current date (DT) minus the date passed in (DATE) is less than
 ; the value in NOYR. Specific checking also occurs if date pasted in
 ; is the DOB (field 6).
 ;
 ; Note:            DT must be defined to run 
 ; Input:  DATE   = external value of the date entered by user
 ;         NOYR   = # of years in past to check date entered in against
 ;          FLD   = field number of the field
 ; Output: VAL    = DATE passed in if valid (true)
 ;                  "" if not valid
 N VAL
 S VAL=DATE
 I '$G(IEN) S IEN=$G(DA)
 I DATE>0,(($E(DT,1,3)-$E(DATE,1,3))>NOYR) S VAL="" D
 . W !!?5,$$GET1^DID(2260,FLD,"","LABEL")_" cannot be more than "_NOYR_" years in the past.",!
 I VAL,IEN,FLD=6,$$GET1^DIQ(2260,IEN,4,"I") D
 . I DATE>$$GET1^DIQ(2260,IEN,4,"I") S VAL="" W !!?5,"DOB cannot be after "_$$GET1^DID(2260,4,"","LABEL"),!
 Q VAL
NMCHK(NA) ; Checks format for name fields
 ;
 ;   Input -   NA      = value entered (X) for name
 ;  Output - VALID     = 1 if format valid
 ;                       0 if format not valid
 ;
 N VALID,LN
 S VALID=1
 I (NA?1P.E)!(NA'?1U.ANP)!(NA'[",") S VALID=0
 I $TR(NA,"~`!@#$%^&*()_+=|}{[]\:;'?><./","")'=NA S VALID=0
 S LN=$P(NA,",") I (LN[" ")!($L(LN)=0) S VALID=0
 I $P(NA,",",2)="" S VALID=0
 Q VALID
NMERR ; Error message to print if error on name check and doing input
 W !,"Enter the person's name, using the format LASTNAME,FIRSTNAME."
 W !,"Suffixes such as Sr, Jr, III can only be entered as a FIRSTNAME."
 W !,"There must be a LAST NAME and FIRST NAME separated by a comma."
 W !,"Spaces in the last name are not allowed and the only "
 W !,"punctuation allowed is a hyphen (-) or comma (,).",!
 Q
WIT() ; Check if Witness name exists that other witness fields have data
 ;
 N ARR,I,J,LAST,STR,VALID,WIT,VCHAR
 S VALID=1,VCHAR=1
 S WIT=$O(^OOPS(2260,IEN,"CA1W",0))
 I '$G(WIT) Q VALID
 S LAST=$P($G(^OOPS(2260,IEN,"CA1W",0)),U,3)
 F I=WIT:1:LAST I $G(^OOPS(2260,IEN,"CA1W",I,0))'="" D
 . S STR=^OOPS(2260,IEN,"CA1W",I,0)
 . F J=2:1:6 I $P($G(STR),U,J)="" S VALID=0,ARR($P(STR,U,1),J)=""
 . F J=2:1:3 I $P($G(STR),U,J)'=$TR($P($G(STR),U,J),"~`@#$%^*_|\}{[]><","") S VCHAR=0
 . I $P($G(STR),U,6) D
 .. I ($$GET1^DIQ(2260,IEN,4,"I")\1)>$P(STR,U,6) S VALID=0
 I 'VALID,$D(ARR) D
 . W !,"  Witness Data is incomplete for the following Witnesses, enter missing data."
 . S I="" F  S I=$O(ARR(I)) Q:I=""  W !?7,I," is missing the" D
 .. S J="" F  S J=$O(ARR(I,J)) Q:J=""  W !?9,$$GET1^DID(2260.0125,J-1,"","LABEL")
 I 'VALID D
 . I $P(STR,U,6) W !,"  Date of Witness Signature cannot be prior to DATE/TIME OF OCCURRENCE."
 I 'VCHAR W !,"  Address or City contains invalid characters:",!?7,"(~,`,@,#,$,%,*,_,|,\,},{,[,],>,or <).  Please Edit"
 Q VALID_U_VCHAR
REG(IEN,FIELD) ; Regular work schedule
 N DIR,Y
 N ANS,ANSS,LINE
 S (ANSS,ANS)=""
 I FIELD=140 S ANSS=$P($G(^OOPS(2260,IEN,"CA1F")),U,11)
 I FIELD=244 S ANSS=$P($G(^OOPS(2260,IEN,"CA2I")),U,8)
 I ANSS'="" D
 .W !,"  YOU LAST SELECTED: "
 .N I,DAY
 .F I=1:1 S DAY=$P(ANSS,",",I) Q:DAY=""  D
 .. I DAY=1 W !,"                  1) SUNDAY"
 .. I DAY=2 W !,"                  2) MONDAY"
 .. I DAY=3 W !,"                  3) TUESDAY"
 .. I DAY=4 W !,"                  4) WEDNESDAY"
 .. I DAY=5 W !,"                  5) THURSDAY"
 .. I DAY=6 W !,"                  6) FRIDAY"
 .. I DAY=7 W !,"                  7) SATURDAY"
 ..Q
 .W !
 .Q
 W !
 S LINE=" "_$S(FIELD=140:"20",FIELD=244:"22",1:"")_". REGULAR WORK SCHEDULE:"
 W !,LINE
 W !,"                  1) SUNDAY"
 W !,"                  2) MONDAY"
 W !,"                  3) TUESDAY"
 W !,"                  4) WEDNESDAY"
 W !,"                  5) THURSDAY"
 W !,"                  6) FRIDAY"
 W !,"                  7) SATURDAY"
 W !
 S DIR(0)="LAO^1:7"
 S DIR("A")="SELECT THE DAYS OF THE WEEK: "
 S DIR("?")="This response must be a list or range, e.g., 1,3,5 or 2-4,8."
 S DIR("?",1)="ENTER THE NUMBER OF THE DAY/S OF THE WEEK WORKED"
 S DIR("?",2)="   1-3,6,7 WOULD BE:      "
 S DIR("?",3)="   SUNDAY THRU TUESDAY, FRIDAY AND SATURDAY."
 D ^DIR
 I $D(Y(0))  D
 .S ANS=Y
 .I FIELD=140 S $P(^OOPS(2260,IEN,"CA1F"),U,11)=ANS
 .I FIELD=244 S $P(^OOPS(2260,IEN,"CA2I"),U,8)=ANS
 .Q
 Q
TI ;TIME INPUT TRANS FORM
 S X=$TR(X,"adimnop","ADIMNOP")
 I X?1"12".A S X=$S(X="12M":"MID",X="12N":"NOON",1:X)
 I X?1.A S X=$S(X["MID":2400,X["NOON":1200,1:"")
 S:$E(X,$L(X))="M" X=$E(X,1,$L(X)-1) S X1=$E(X,$L(X)) I X1?1U,"AP"'[X1 G ERR
 S X1=$P(X,":",2) I X1'="",X1'?2N1.2U G ERR
 I X'?4N,$S($L(+X)<3:+X,1:+X\100)>12 G ERR
 S X=$P(X,":",1)_$P(X,":",2),X1=X
 G:X?4N A I X'?1.4N1.2U G ERR
 S:X<13 X=X*100 I X1["A" G:X>1259 ERR S X=$S(X=1200:2400,X>1159:X-1200,1:X)
 E  I X<1200,X1["P"!(X<600) S X=X+1200 I X<1300 G ERR
A I X>2400!('X&(X'="0000"))!(X#100>59) G ERR
 S X1=+X I 'X1!(X1=1200)!(X1=2400) S X=$S(X1=1200:"NOON",1:"MID") G DNE
 S X1=$S(X1>1259:X1-1200,1:X1),X1=$E("000",0,4-$L(X1))_X1_$S(X=2400:"A",X>1159:"P",1:"A")
 I "00^15^30^45"'[$E(X1,3,4) G ERR
 S X=$E(X1,1,2)_":"_$E(X1,3,5)
DNE K X1 Q
ERR K X,X1 Q
CNV ; Convert Start/Stop to minutes
 ; X=start_"^"_stop  Output: Y=start(min)_"^"_stop(min)
 S CNX=X,X=$P(CNX,"^",1),Y=0 D MIL S Y=Y\100*60+(Y#100),$P(CNX,"^",1)=Y
 S X=$P(CNX,"^",2),Y=1 D MIL S Y=Y\100*60+(Y#100)
 S Y=$P(CNX,"^",1)_"^"_Y K CNX Q
MIL ; Convert from AM/PM to 2400
 ; X=time Y: 0=Mid=0,1=Mid=2400 Output: Y=time in 2400
 I X="MID"!(X="NOON") S Y=$S(X="NOON":1200,Y:2400,1:0) Q
 S Y=$P(X,":",1)_$P(X,":",2),Y=+Y Q:X["A"
 S:Y<1200 Y=Y+1200 Q
HLP ; Time Help
 W !?5,"Time may be entered as 8A or 8a, 8:00A, 8:15A, 8:15AM or military"
 W !?5,"time: 0800, 1300; or MID or 12M for midnight; NOON or 12N for noon."
 W !?5,"Time must be in quarter hours; e.g., 8A or 8:15A or 8:30A or 8:45A.",!
 Q
DC(OPDT) ; Convert Date to YYYYMMDD
 ;
 ; Input:  OPDT = Date to be converted
 ; Output: COPDT = Converted Date 
 S COPDT=""
 S:OPDT]"" COPDT=OPDT+17000000\1
 Q COPDT
HM(TIME) ;Convert Regular Hrs. From Time and Regular Hrs To Time
 ;        to HHMM (HOUR AND MINUTE)
 ;
 ; Input:   TIME = Time converted to military time(21:00P), Noon and Mid
 ; Output:  OTIME= Formatted time in HHMM
 ;
 S OTIME=$S(TIME="MID":2400,TIME="NOON":1200,1:TIME)
 I $E(TIME,$L(TIME))="A" S OTIME=$TR($E(TIME,1,5),":")
 I $E(TIME,$L(TIME))="P" D 
 . S OTIME=$TR($E(TIME,1,5),":")
 . I OTIME<1200 S OTIME=OTIME+1200
 Q OTIME
