PRCOER1 ;WISC/DJM-EDI REPORTS USING LIST MANAGER ; [8/31/98 2:26pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
REPORTS ;  COME HERE TO ENTER THE REPORTS GENERATOR.
 ;
 N DIR,X,Y,LIST,Q1,Q2,PRCA,PRCB,PRCSA,I,PRCPOS,PRCLST,PRCBLST
 N POSI,POS,PRCC,%DT,DTOUT,START,END,FIRST,LAST,A
 D CLEAR^VALM1
 ;
R0 S LIST=""
 D LF
 S DIR("A")="Select PHA, RFQ or All: "
 S DIR("?")="^D WRONG^PRCOER1()"
 S DIR(0)="FAO^1:30"
 D ^DIR K DIR
 G R4:$D(DUOUT),R4:$D(DTOUT)
 I X="" D  G R4:X["^",R0
 . D LF
 . D PAUSE
 . D LF
 I X["-" G R2
 I X["," G R3
 I $L(X)>3 D WRONG(X) D PAUSE G R4:X["^",R0
 ;
R1 ; IS THIS ONE OF THE CORRECT INPUTS?
 S Y=""
 D CHECK(X,.Y)
 I Y>3,Y<7 D WRONG(X),PAUSE G R0
 I Y>0 S LIST=Y_"," G DATE
 D WRONG(X)
 D PAUSE
 G R4:X["^",R0
 ;
R2 K Q1,Q2
 S PRCA=$P(X,"-",1)
 S PRCB=$P(X,"-",2)
 I PRCA["," D  G:LIST["0" P2 G R2B
 .  S PRCSA=X
 .  S X=PRCA
 .  D P3
 .  S X=PRCSA
 .  I LIST["0" Q
 .  S I=1
 .  F  S:$P(LIST,",",I)]"" PRCPOS=$P(LIST,",",I) Q:$P(LIST,",",I)=""  S I=I+1
 .  S Q1=$E(LIST,PRCPOS)
 .  S PRCLST=LIST
 .  Q
 S Y=""
 D CHECK(PRCA,.Y)
 I Y>3,Y<7 D WRONG(X),PAUSE G R0
 I $G(Q1)="" S PRCLST=Y
 S Q1=Y
R2B S PRCBLST=PRCB
 I PRCB["," D  G:LIST["0" P2 G R2C
 .  S PRCSA=X
 .  S X=PRCB
 .  D P3
 .  S X=PRCSA
 .  I LIST["0" Q
 .  S Q2=$P(LIST,",")
 .  S PRCBLST=LIST
 .  Q
 D CHECK(PRCB,.Y)
 I Y>3,Y<7 D WRONG(X),PAUSE G R0
 I $G(Q2)="" S PRCBLST=Y
 S Q2=Y
 I Q1=0 D WRONG(PRCA) G P2
 I Q2=0 D WRONG(PRCB) G P2
 ;
R2C I $G(PRCLST)[7!($G(PRCBLST)[7) S LIST=7_"," G DATE
 S LIST=""
 I Q1>Q2 F I=Q2:1:Q1 S LIST=LIST_I_","
 I Q2>Q1 F I=Q1:1:Q2 S LIST=LIST_I_","
 S:$G(PRCLST)]"" LIST=LIST_PRCLST
 S:$G(PRCBLST)]"" LIST=LIST_PRCBLST
 F I=1:1 S POSI=$P(LIST,",",I) Q:POSI=""  S POS(POSI)=POSI
 S LIST=""
 F I=1:1:3 S:$G(POS(I))]"" LIST=LIST_POS(I)_","
 K POS
 G DATE
 ;
P2 D PAUSE
 G R4:X["^",R0
P3 S LIST=""
 F I=1:1 S PRCC=$P(X,",",I) Q:PRCC=""  D  Q:"70"[LIST
 .  S Y=""
 .  D CHECK(PRCC,.Y)
 .  I Y>3,Y<7 D WRONG(X) S LIST=0 Q
 .  I Y=0 D WRONG(PRCC) S LIST=0 Q
 .  I Y=7 S LIST=7_"," Q
 .  S LIST=LIST_Y_","
 .  Q
 Q
 ;
R3 D P3
 I LIST'["0" G DATE
 D PAUSE
 G R4:X["^",R0
 ;
R4 S VALMBCK="R"
 S VALMBG=1
 Q
 ;
DATE D RT  ; prompt user for from and to date range
 I $S('$G(PRCOBEG):1,'$G(PRCOSTOP):1,1:0) G RT1
 I LIST="" G P2
 G ^PRCOER3
 ;
IT ; SELECT ACCEPTED, REJECTED OR INCOMMING TRANSACTIONS WITH PROBLEMS.
 Q
 ;
RT1 D:$G(X)'="^" PAUSE
 G R4:X["^",R0
 ;
PO ; FIND OUT IF USER WANTS TO DISPLAY 'POA' RECORDS
 Q
 ;
WRONG(X) ; COME HERE IF THE USER'S INPUT IS WRONG.
 S A(1)=$S($G(X)]"":X_" ?? "_$C(7),1:"")
 S A(2)="  "
 S A(3)="Enter a selection, more than one selection separated with a ','"
 S A(4)="a range of selections seperated with a '-' or exclude an entry with a '."
 S A(5)="  "
 D EN^DDIOL(.A)
 Q
 ;
CHECK(X,Y) ;  COME HERE TO SEE IF INPUT IS ONE OF THE CORRECT ENTRIES.
 ;
 ;  RETURN A NUMBER THAT REPRESENTS THE INPUT.
 ;
 ;      PHA      1
 ;      RFQ      2
 ;      TXT      3
 ;      ACT      4
 ;      PRJ      5
 ;      POA      6
 ;      ALL      7
 ;     WRONG     0
 ;
 ;  THE RETURNED VALUE OF "0" MEANS THAT THE USER DID NOT ENTER ANY
 ;  CORRECT ENTRY.
 ;
 S X=$S(X["P":"PHA",X["R":"RFQ",X["A":"ALL",1:X)
 S Y=$S(X="PHA":1,X="RFQ":2,X="TXT":3,X="ACT":4,X="PRJ":5,X="POA":6,X="ALL":7,1:0)
 Q
 ;
RT ; Ask user from date.  Must be less than "NOW".
 ; returns PRCOBEG
 N AA
 K PRCOBEG,PRCOSTOP
 D LF
 D NOW^%DTC
 S AA=$E(X,1,3)-1
 S Y=AA_$E(X,4,7)
 D DD^%DT
 S DIR(0)="D^:-NOW:AET"
 S DIR("A")="Enter the DATE/TIME CREATED starting date"
 S DIR("B")=Y
 D ^DIR K DIR
 Q:$D(DIRUT)
 S PRCOBEG=$S(Y[".":Y,1:Y_".000001")
 ;
RT0 ; Ask user end date.  Date must be > BEG date and less
 ; than "NOW".
 ; returns PRCOSTOP
 Q:'$G(PRCOBEG)
 S DIR(0)="D^"_PRCOBEG_":-NOW:AET"
 S DIR("A")="Enter the DATE/TIME CREATED ending date"
 S DIR("B")="NOW"
 D LF
 D ^DIR K DIR
 Q:$D(DIRUT)
 S PRCOSTOP=Y
 I PRCOSTOP'["." D  ;if no time entered by user
 .  ;
 .  ; set end date to "NOW" if end date is "TODAY".
 .  ;
 .  I PRCOSTOP=$G(DT) S PRCOSTOP=$$NOW^XLFDT Q
 .  S PRCOSTOP=PRCOSTOP_".235959"  ;attach time for end of day
 ;
 K DUOUT,DIRUT,DTOUT
 Q
 ;
PAUSE ; Come here to allow user to read screen before continuing.
 N DIR,DIRUT,DUOUT,DTOUT
 S DIR(0)="E"
 D ^DIR
 Q
LF ; Line feed
 D EN^DDIOL("","","!")
 Q
