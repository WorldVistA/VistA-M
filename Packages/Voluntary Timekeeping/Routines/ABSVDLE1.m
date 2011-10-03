ABSVDLE1 ;EAP ALTOONA VOLUNTARY DONATIONS UTILITY PROGRAM  ; 26 Sep 2001  2:04 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;**25,26**;JULY 6, 1994
NOTE W !,"You will have to either update the DONATIONS file #503340"
 W !,"OR enter this data manually which DOES NOT record it in the DONATIONS file."
 W !
 Q
STATE ;
 S ABSVPENN=$P(ABSVZN1,U,5) I ABSVPENN>"" I $D(^DIC(5,ABSVPENN,0)) S ABSVPENN=$P(^DIC(5,ABSVPENN,0),U,2)
 Q
HEADER ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 W !,"****        *******                                        "
 W !," ****      *********" W "      DEPARTMENT OF VETERAN AFFAIRS "
 W !,"  ****    ***    ****" W "     TEMPORARY RECEIPT FOR FUNDS "
 W !,"   *******************" W "    ",ABSVSTAT
 W !,"    *******        ****                                    "
 W !,"     *****          ****                                   "
 W !
 Q
WARN W !,?5,"******************************************************************"
 W !,?5,"* If you don't know the Donation Tracking Number, hit '?' for    *"
 W !,?5,"* help OR hit the ENTER key and you will have a chance to enter  *"
 W !,?5,"* the information manually. All Temporary Receipt Info is logged *"
 W !,?5,"* in file #503344 IF ENTERED MANUALLY.  It is NOT recorded in     *"
 W !,?5,"* the Donations File #503340 if entered manually!                 *"
 W !,?5,"******************************************************************"
 W !
 Q
WARN2 W !!,?5,"**************************************************"
 W !,?5,"*  WARNING: Information entered manually IS NOT  *"
 W !,?5,"*  recorded in the DONATIONS FILE (#503340).     *"
 W !,?5,"*  It is recorded in File #503344!               *"
 W !,?5,"**************************************************"
 W !!,"NOW USING MANUAL ENTRY METHOD (hit ^ to exit)"
 Q
YESNO ;;YES/NO PROCESSOR UTILITY
 ;;OPTIONAL VARIABLE %A WHICH EQUALS QUESTION TEXT
 ;;RETURNS % : 1=YES, 2=NO, 3=^, 4=ANYTHING ELSE ASK AGAIN.
ASKIT S:'$D(%A) %A="Do you want to continue"
 S %B="Enter 'Yes' or 'No'.  Enter '^' to Quit."
 W !,%A_"? (Y/N) // " R ANS:$S($D(DTIME):DTIME,1:300) I (ANS["?")!(ANS="") W *7,!,%B G ASKIT
 I ANS["^" S %=3 Q
 S ANS=$E(ANS,1) S %=$S(ANS="Y":1,ANS="y":1,ANS="N":2,ANS="n":2,1:4) I ANS=4 G ASKIT
 K ANS,%A,%B Q
CONV ;;DATE CONVERTER BLACK BOX.  ** FORMAT 11/04/90 **
 ;;NEEDS VARIABLE NEWDATE WHICH MUST BE FORMAT 2900411 (S NEWDATE=DT)
CONVERT Q:'$D(NEWDATE)
 S:NEWDATE'="" NEWDATE=$E(NEWDATE,4,5)_"/"_$E(NEWDATE,6,7)_"/"_$E(NEWDATE,2,3)
 Q
DOLL ;;;;;;;;;;DOLLAR CONVERTER;;;;;;;;;;;;;;;;;;;;;;;;
 I ABSVDOLA="" Q
 I $E(ABSVDOLA)'="$" S ABSVDOLA="$"_ABSVDOLA
 I ABSVDOLA'["." S ABSVDOLA=ABSVDOLA_".00"
 Q
NAMEFLIP ;;;;;;;;;SWITCHES NAME FROM SMITH,JOE TO JOE SMITH;;;;;;;
 ;;;;MUST HAVE VARIABLE NAME DEFINED AS INPUT IN FORM
 ;;;;SMITH, JOHN A.  WITH COMMA AS DELIMITER;;;;;;;;;;;;;
 Q:'$D(NAME)
 I NAME'["," Q
 S ONE=$P(NAME,",",2) S TWO=$P(NAME,",",1) S NAME=ONE_" "_TWO
 K ONE,TWO
 Q
END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Q
