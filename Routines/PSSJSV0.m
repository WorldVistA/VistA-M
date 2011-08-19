PSSJSV0 ;BIR/CML3,WRT-SCHEDULE VALIDATION CONT. ; 08/21/97 8:26
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
 ;
ENPSJI ; inquire for Inpatient Meds
 S PSJPP="PSJ"
 ;
ENI ; inquire
 R !!,"Select STANDARD SCHEDULE: ",X:DTIME W:'$T $C(7) I "^"[X!'$T K X,PSJPP Q
 I X?1."?" W !!?2,"Enter a standard schedule to view the information pertaining to that schedule."
 K DIC S DIC("W")="S Z=$P(^(0),""^"",5) W ""  "",$S(Z=""O"":""(ONE-TIME)"",Z=""R"":""(RANGE)"",Z=""S"":$P(^(0),""^"",6),$P(^(0),""^"",2)]"""":$P(^(0),""^"",2),$P(^(0),""^"",3):$P(^(0),""^"",3)_"" minutes"",1:"""") K Z"
 S DIC="^PS(51.1,",DIC(0)="EQSZ",D="AP"_PSJPP D IX^DIC K DIC G:Y'>0 ENI
 S X=$P(Y(0),"^",5) W !!?2,"Schedule: ",$P(Y(0),"^"),?58,"Type: ",$S("C"[X:"CONTINUOUS",X="D":"DAY OF THE WEEK",X="O":"ONE-TIME",X="S":"SHIFT",X="R":"RANGE",1:X) G:"C"'[X&(X'="S") ENI
 I "C"[X,$P(Y(0),"^",2)]"" W !?2,"Standard Admin Times: ",$P(Y(0),"^",2) W:$P(Y(0),U,7) !?2,"Max Days for Orders: ",$P(Y(0),U,7)
 E  I "C"[X,$P(Y(0),"^",3) W !?2,"Frequency (in minutes): ",$P(Y(0),"^",3)
 I X="S",$P(Y(0),"^",5)]"" W !,"Standard Shifts: ",$P(Y(0),"^",5)
 I $O(^PS(51.1,+Y,PSJPP'="PSJ"+1,0))
 I  F Q=0:0 S Q=$O(^PS(51.1,+Y,PSJPP'="PSJ"+1,Q)) Q:'Q  I $D(^(Q,0)) S Z=^(0) W !!?2,"Location: ",$S('$D(^SC(Q,0)):Q_";SC(",$P(^(0),"^")]"":$P(^(0),"^"),1:Q_";SC("),!?2,$S(X="S":"Shift: ",1:"Admin Times: "),$P(Z,"^",X="S"+2)
 K Q,Y,Z G ENI
 ;
ENSVH ; show help
 I X="?" W !?5,"Enter a schedule for this order."
 I X?2."?" F Q=1:1:8 W !?3,$P($T(SCHT+Q),";",3) I Q=3,X="??" Q
 W:X="??" !?3,"..."
 I  R !,"(Press RETURN to continue.) ",Q:DTIME W:'$T $C(7) S:'$T Q="^" Q:Q="^"
 S DIC="^PS(51.1,",DIC(0)="E",DIC("S")="I $P(^(0),""^"",4)="""_PSJPP_"""",DIC("W")="D DICW^PSSJSV0"
 D ^DIC K DIC Q
 ;
SCHT ;
 ;;  This is the frequency that the action of the order is to take place over
 ;;the life of the order.  The schedule may have various forms, such as 'ONCE',
 ;;'STAT', 'DAILY', 'Q8H', 'QOD', 'Q5XD', and 'MO-WE-FR@09'.
 ;;  Please note that unexact schedules, such as 'Q4-6H' may not produce the
 ;;desired results.
 ;;  Also, when entering a schedule involving days of the week, you need not
 ;;enter the entire name of each day, but you must enter at least the first two
 ;;letters of each day.
 ;
DICW ;
 ; PSSJEEU CALLS THIS-IT LOOKS AT FILE 51.1
 S Z=$P(^(0),"^",5),Z=$S(Z="O":-1,Z="S":1,Z="R":-2,1:0) W:Z "  ",$S(Z>0:"SHIFT",Z=-2:"RANGE",1:"ONE-TIME") I Z'<0,$D(PSJW),$D(^(PSJPP'="PSJ"+1,PSJW,0)),$P(^(0),"^",Z+2)]"" W "  ",$P(^(0),"^",Z+2) Q
 W "  ",$P(^PS(51.1,+Y,0),"^",Z*4+2) Q
 ;
ENSTH ; executable help for type of schedule
 W !!?2,"The TYPE OF SCHEDULE determines how the schedule will be processed."
 W !!?2,"A CONTINUOUS schedule is one in which an action is to take place on a regular",!,"basis, such as 'three times a day' or 'once every two days'."
 W !?2,"A DAY OF THE WEEK schedule is one in which the action is to take place only",!,"on specific days of the week.  This type of schedule should have admin times",!,"entered with it.  If not, the start time of the order is used as the"
 W " admin",!,"time.  Whenever this type is chosen, the name of the schedule must be in the",!,"form of 'MO-WE-FR'." G:$S('$D(PSJPP):1,PSJPP="":1,1:PSJPP="PSJ") HOT
 W !?2,"A DAY OF THE WEEK-RANGE schedule is one in which the action to take place",!,"only on specific days of the week, but at no specific time of day (no admin",!,"times).  Whenever this type is chosen, the name of the schedule must be in "
 W "the",!,"form of 'MO-WE-FR'."
HOT W !?2,"A ONE-TIME schedule is one in which the action is to take place once only",!,"at a specific date and time." I $S('$D(PSJPP):1,PSJPP="":1,1:PSJPP="PSJ") Q
 W !?2,"A RANGE schedule is one in which the action will take place within a given",!,"date range."
 W !?2,"A SHIFT schedule is one in which the action will take place within a given",!,"range of times of day." Q
