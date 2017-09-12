PRSXP94 ; WIOFO/MGD-SET EXTRA HOLIDAY W/ PP OPEN ;06/08/04
 ;;4.0;PAID;**94**;Sep 21, 1995
 ;
 Q
 ;
START ; Declare 6/11 as a memorial day for President Reagan's Funeral
 ;
 W !!,"Checking PP 04-11",!
 N DFN,DUP,HOL,NOW,PPI,TT,%
 S PPI=$O(^PRST(458,"B","04-11",0))
 I 'PPI D  Q
 .  W !,"PayPeriod 04-11 not found in File 458."
 S HOL(3040611)=13 ; Set 6/11 into HOL array
 D NOW^%DTC S NOW=%
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 ;
 ; Quit if PP 04-12 is not opened.  The Open Next Pay Period option
 ; will automatically post their holiday.
 ; 
PP12 I '$D(^PRST(458,"B","04-12")) D  Q
 . W !,"PP 04-12 has not been opened yet.  Holiday In Lieu days will"
 . W !,"be posted to this Pay Period when it is opened.",!
 ;
 ; I the next pay period is already opened, loop through the 
 ; employees again with HOL(3040611)=-5.  This is the 5th date
 ; in the PDH variable.
 ;
 W !,"PP 04-12 is already open.  Running checks to see if any"
 W !,"employees needed to have their extra holiday posted in this"
 W !,"Pay Period.",!
 ;
 S HOL(3040611)=-5 ; Set 6/11 into HOL array
 S PPI=0,PPI=$O(^PRST(458,"B","04-12",PPI))
 I 'PPI D  Q
 . W !!,"The IEN for PP 04-12 was not found."
 . W !,"Contact EVS at 888-596-4357."
 ;
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 Q
