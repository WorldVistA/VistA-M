ABSVLS ;VAMC ALTOONA/CTB_CLH - MANAGE VOL LOG-IN TERMINAL ;4/4/00  8:46 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;**3,13,15,18**;JULY 6, 1994
START ;START LOG-IN TERMINAL
 D ^ABSVSITE G OUT:'%
 K ^ABS("ABSVKILL",ABSV("SITE"))
 D HOME^%ZIS
 S ABSV("HOME_TERMINAL")=ION
 I $P(ABSV("PARAM"),"^",12)=1 F  D GETPRINT Q:OK!(POP)
 I POP G OUT
 S %ZIS("A")="Select Volunteer Log-in DEVICE: "
 S ZTRTN="^ABSVL",ZTDESC="Boot Volunteer Log-in Terminal",ZTSAVE("DUZ*")="",ZTSAVE("ABSV*")="",ZTSAVE("DTIME")="" D ^ABSVQ
OUT K ABSV,OK,POP D HOME^%ZIS
 QUIT
GETPRINT ;GET MEAL PRINTER
 S OK=1
 S %ZIS="NQ",%ZIS("A")="Select Meal Ticket DEVICE: ",%ZIS("B")=""
 D ^%ZIS I POP D HOME^%ZIS QUIT
 I ABSV("HOME_TERMINAL")=ION S X="You may not print meal tickets to your terminal.*" D MSG^ABSVQ S OK=0 QUIT
 S ABSV("MEAL_PRINTER")=ION,OK=1 D HOME^%ZIS
 QUIT
STOP ;STOP PROGRAM RUNNING BINGO BOARD
 I '$D(ABSV("SITE")) D ^ABSVSITE Q:'%
 W ! S ABSVXA="Do you want to stop all Auto Log-in Terminals for station "_ABSV("SITE"),ABSVXB="",%=1 D ^ABSVYN
 I %<0 S MSG="  <Option Terminated - No Further Action Taken.*" D MSG^ABSVQ QUIT
 I %=1 W !!!,*7,"      Volunteer Log-in Program will halt in 2 minutes." S ^ABS("ABSVKILL",ABSV("SITE"),"ALL")="" G XFER
 D HOME^%ZIS
 S ABSV("HOME_TERMINAL")=ION
 F  S %ZIS("A")="Select Device You Wish to Stop: ",%ZIS("B")="",%ZIS="N" D  I $D(STOP) K STOP QUIT
 . D ^%ZIS I POP!(ABSV("HOME_TERMINAL")=ION) S STOP="" QUIT
 . S ^ABS("ABSVKILL",ABSV("SITE"),IO)="" D ^%ZISC S %ZIS("A")="Select Another Device: "
 D ^%ZISC
XFER S ABSVXA="Do you want to transfer entries from Temporary Log to Daily Time File now",ABSVXB="",%=2 D ^ABSVYN I %'=1 K Z,ZZI,DA G OUT
 S ABSVXA="Are you sure",ABSVXB="",%=1 D ^ABSVYN I %'=1 K Z,ZZI,DA G OUT
 D ^ABSVNIT1
 K Z,ZZI,DA,ABSV D OUT Q
HALT() ;
 I $D(^ABS("ABSVKILL",$G(ABSV("SITE")),"ALL")) QUIT 1
 I $D(^ABS("ABSVKILL",$G(ABSV("SITE")),IO)) QUIT 1
 QUIT 0
