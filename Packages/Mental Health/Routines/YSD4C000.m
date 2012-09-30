YSD4C000 ;DALISC/LJA - Environment Check/Setup ; [ 04/12/94  8:28 AM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
CHECKENV ;  Check out environment... Set up variables defining "what
 ;  has been done", for use by subsequent processes...
 ;  Called by YSD4DSM
 ;
 S YSD4OK=0
 ;
 ;  Have all three files been converted?
 S YSD4ALL=1
 F YSD4="MR CONVERSION COMPLETED","DR CONVERSION COMPLETED","GPN CONVERSION COMPLETED" D
 .  I $G(^YSD(627.99,"AS",YSD4))']"" S YSD4ALL=0
 I YSD4ALL D  QUIT  ;->
 .  W !!,"DSM conversion has already run!  Conversion has completed...",!!
 .  H 3
 ;
 S YSD4OK=1
 QUIT
 ;
OKCONT(POS) ;
 ;  Called by YSD4DSM
 S YSD4OK=0
 ;
 ;  Move to bottom of page if requested...
 I $G(POS) F I=1:1:POS  W !
 ;
 N DIR
 S DIR(0)="Y"
 S DIR("A")=$S($G(YSD4DIRA)']"":"OK to continue",1:YSD4DIRA) K YSD4DIRA
 S DIR("?")="Enter 'Y' to continue, or '^' or 'N' to stop ... "
 D ^DIR
 QUIT:+Y'=1  ;->
 S YSD4OK=1
 QUIT
 ;
EOR ;YSD4C000 - Environment Check/Setup ; [ 04/06/94  9:59 AM ]
