PRSXP118 ;ALB/DWS-SET EXTRA HOLIDAY W/ PP OPEN ;12/07/2007
 ;;4.0;PAID;**118**;Sep 21, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
START ; Declare 12/24/2007 as a extra holiday for Christmas
 ;
 W !!,"Checking PP 07-25",!
 N DFN,DUP,HOL,NOW,PPI,TT,%
 S PPI=$O(^PRST(458,"B","07-25",0))
 I 'PPI D  Q
 .  W !,"Pay Period 07-25 not found in File 458."
 S HOL(3071224)=16 ; Set 12/24 into HOL array
 D NOW^%DTC S NOW=%
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 ;
 ; Quit if PP 07-26 is not opened.  The Open Next Pay Period option
 ; will automatically post their holiday.
 ; 
PP26 I '$D(^PRST(458,"B","07-26")) D  Q
 . W !,"PP 07-26 has not been opened yet.  Holiday In Lieu days will"
 . W !,"be posted to this Pay Period when it is opened.",!
 ;
 ; If the next pay period is already opened, loop through the 
 ; employees again with HOL(3071224)=2.  This is the 2nd date
 ; in the PDH variable.
 ;
 W !,"PP 07-26 is already open.  Running checks to see if any"
 W !,"employees needed to have their extra holiday posted in this"
 W !,"Pay Period.",!
 ;
 S HOL(3071224)=2 ; Set 12/24/2007 into HOL array
 S PPI=0,PPI=$O(^PRST(458,"B","07-26",PPI))
 I 'PPI D  Q
 . W !!,"The IEN for PP 07-26 was not found."
 . W !,"Contact EVS at 888-596-4357."
 ;
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 Q
