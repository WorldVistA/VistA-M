QAQDATE ;HISC/JES,DAD-EXTRAPOLATE DATE FOR SORT/PRINTS ;10/15/92  12:45 ;
 ;;1.7;QM Integration Module;**3**;07/25/1995
 ;
 ;OPTIONAL INPUT VARIABLE
 ; QAQDATE = ['] Date range type ^ [ Date 1 ] ^ [ Date 2 ]
 ;
 ;OUTPUT VARIABLES
 ; QAQQUIT = 1 If exit out, else 0
 ; QAQNBEG = Beginning date (FM)
 ; QAQNEND = Ending date (FM)
 ; QAQENGD = Today in external format
 ; QAQ1HED = Mumps header code (X QAQ1HED)
 ; QAQ2HED = Date range chosen text
 ; QAQTART = Tab value to center QAQ2HED
 ; QAQRANG = From - To date range text
 ;
 S QA("DD")=^DD("DD"),QAQFRAME="^MONTHLY^QUARTERLY^SEMI-ANNUALLY^YEARLY^FISCAL YEARLY^USER SELECTABLE",QAQDATE=$G(QAQDATE)
RANGE ;
 I $P(QAQDATE,"^")["'" S QAQQUIT=0 D  G ABORT:QAQQUIT,QUIT
 . S X=$E($TR($P(QAQDATE,"^"),"'")),(X,WHEN)=$TR(X,"mqsfyu","MQSFYU")
 . I "^M^Q^S^Y^F^U^"'[("^"_X_"^") S QAQQUIT=1 Q
 . W !!,"Date range: ",X,$P($P(QAQFRAME,"^"_X,2),"^")
 . D MONTH:WHEN="M",QUART:(WHEN="Q")!(WHEN="S")
 . D YEAR:(WHEN="F")!(WHEN="Y"),USERSEL:WHEN="U"
 . Q
 W !!,"Monthly,  Quarterly,  Semi-Annually,  Yearly,  Fiscal Yearly,  User Selectable",!,"Select date range: ",$S($P(QAQDATE,"^")]"":$P(QAQDATE,"^")_"// ",1:"")
 R X:DTIME S:'$T X="^" I X="" S X=$P(QAQDATE,"^") W X
 G:(X="")!(X="^") ABORT
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I $F(QAQFRAME,"^"_X)'>0 W:$E(X)'="?" " ??",*7 W !!?5,"Enter the first few letters of one of the choices listed below." G RANGE
 W $P($P(QAQFRAME,"^"_X,2),"^") S WHEN=$E(X),QAQQUIT=0
 D MONTH:WHEN="M",QUART:(WHEN="Q")!(WHEN="S"),YEAR:(WHEN="F")!(WHEN="Y"),USERSEL:WHEN="U"
 I QAQQUIT S QAQDATE="" G RANGE
 E  G QUIT
MONTH ;
 S EOM("01")="31^JANUARY",EOM("02")="28^FEBRUARY",EOM("03")="31^MARCH",EOM("04")="30^APRIL",EOM("05")="31^MAY",EOM("06")="30^JUNE"
 S EOM("07")="31^JULY",EOM("08")="31^AUGUST",EOM("09")="30^SEPTEMBER",EOM(10)="31^OCTOBER",EOM(11)="30^NOVEMBER",EOM(12)="31^DECEMBER"
 K %DT S %DT="AE",%DT("A")="Enter Month and Year: " S:$P(QAQDATE,"^",2)]"" %DT("B")=$P(QAQDATE,"^",2) W ! D ^%DT I Y'>0 S QAQQUIT=1 Q
 I ('+$E(Y,4,5))!(+$E(Y,6,7)) W " ??",*7,!!,"Please enter a month and year",$S(+$E(Y,6,7):" only",1:"") G MONTH
 S MOE=$E(Y,4,5),QAQNEND=$E(Y,1,5)_$P(EOM(MOE),"^",1),X=1700+$E(Y,1,3) S:$E(Y,4,5)="02" QAQNEND=QAQNEND+((X#4=0)&((X#100)!(X#400=0)))
 S QAQNBEG=$E(QAQNEND,1,5)_"01",QAQ2HED="MONTH OF "_$P(EOM(MOE),"^",2)_" "_(1700+$E(Y,1,3))
 Q
QUART ;
 S SEMI=0 I WHEN="S" S SEMI=1 W !!,"Enter Quarter Period and FY you wish Semi-Annual range to end with"
 W !
ENTERQ W !,"Enter Quarter and Year: ",$S($P(QAQDATE,"^",2)]"":$P(QAQDATE,"^",2)_"// ",1:"") R QUART:DTIME S:'$T QUART="^" S:QUART="" QUART=$P(QAQDATE,"^",2) I (QUART="^")!(QUART="") S QAQQUIT=1 Q
 I (QUART'?1N1P2N)&(QUART'?1N1P4N) W:$E(QUART)'="?" " ??",*7 W !!,"Enter Quarter Period in this format: 2nd quarter 1988 would be 2-88, 2/88, 2 88",! G ENTERQ
 I ($E(QUART)>4)!($E(QUART)<1) W " ??",*7,!!,"Enter Quarter 1 to 4 only",! G ENTERQ
 S QU=$E(QUART),YR=$E(QUART,3,6) K %DT S X=YR D ^%DT S YR=$E(Y,1,3)
 S QUBEG(1)=YR-1_1001,QUBEG(2)=YR_"0101",QUBEG(3)=YR_"0401",QUBEG(4)=YR_"0701",QUEND(1)=YR-1_1231,QUEND(2)=YR_"0331",QUEND(3)=YR_"0630",QUEND(4)=YR_"0930",QUQUA(1)="FIRST",QUQUA(2)="SECOND",QUQUA(3)="THIRD",QUQUA(4)="FOURTH"
 S:SEMI SEBEG(1)=YR-1_"0701",SEBEG(2)=YR-1_1001,SEBEG(3)=YR_"0101",SEBEG(4)=YR_"0401"
 S QAQNBEG=QUBEG(QU),QAQNEND=QUEND(QU),QAQ2HED=QUQUA(QU)_" QUARTER FY "_(1700+YR) S:SEMI QAQNBEG=SEBEG(QU),QAQ2HED="SEMI-ANNUAL PERIOD ENDING "_QAQ2HED
 Q
YEAR ;
 S FY=$S(WHEN="F":1,1:0) W !!,"Enter ",$S(FY:"FISCAL ",1:""),"YEAR: ",$S($P(QAQDATE,"^",2)]"":$P(QAQDATE,"^",2)_"// ",1:"")
 R YR:DTIME S:'$T YR="^" S:YR="" YR=$P(QAQDATE,"^",2) I (YR="^")!(YR="") S QAQQUIT=1 Q
 I (YR'?2N)&(YR'?4N) W:$E(YR)'="?" " ??",*7 W !!,"Enter a 2 or 4 digit ",$S(FY:"fiscal ",1:""),"year" G YEAR
 K %DT S X=YR D ^%DT S YR=$E(Y,1,3)
 I FY S QAQNBEG=YR-1_1001,QAQNEND=YR_"0930",QAQ2HED="FISCAL YEAR "_(1700+YR)
 E  S QAQNBEG=YR_"0101",QAQNEND=YR_1231,QAQ2HED="YEAR "_(1700+YR)
 Q
USERSEL ;
 W !!,"Enter beginning and ending dates for the desired time period:",! K %DT S %DT="AEX",%DT("A")="Beginning Date: " S:$P(QAQDATE,"^",2)]"" %DT("B")=$P(QAQDATE,"^",2) D ^%DT I Y'>0 S QAQQUIT=1 Q
 S QAQNBEG=Y X QA("DD") S BEGIN=Y
 K %DT S %DT="AEX",%DT(0)=QAQNBEG,%DT("A")="Ending Date:    ",%DT("B")=$S($P(QAQDATE,"^",3)]"":$P(QAQDATE,"^",3),1:BEGIN) D ^%DT I Y'>0 S QAQQUIT=1 Q
 S QAQNEND=Y X QA("DD") S QAQ2HED="PERIOD FROM "_BEGIN_" TO "_Y
 Q
ABORT ;
 D K S QAQQUIT=1 G KILL
QUIT ;
 K %DT S %DT="",X="T" D ^%DT X QA("DD") S QAQENGD=Y,QAQ1HED="W !?65,QAQENGD",QAQTART=80-$L(QAQ2HED)/2,QAQRANG="Range selected: " S Y=QAQNBEG X QA("DD") S QAQRANG=QAQRANG_Y_" to " S Y=QAQNEND X QA("DD") S QAQRANG=QAQRANG_Y W !!,QAQRANG,!
KILL ;
 K %DT,BEGIN,EOM,FY,LP,MOE,MON,QA,QAQDATE,QAQFRAME,QU,QUART,QUBEG,QUEND,QUQUA,SEBEG,SEMI,WHEN,X,Y,YR
 Q
K ; *** ENTRY POINT TO CLEANUP RETURNED VARIABLES
 K QAQQUIT,QAQNBEG,QAQNEND,QAQENGD,QAQ1HED,QAQ2HED,QAQTART,QAQRANG
 Q
