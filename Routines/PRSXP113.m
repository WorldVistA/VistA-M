PRSXP113 ;ALB/DWS-SET EXTRA HOLIDAY W/ PP OPEN ;12/28/2006
 ;;4.0;PAID;**113**;Sep 21, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
START ; Declare 01/02/2007 as a memorial day for President Ford's Funeral
 ;
 W !!,"Checking PP 06-26",!
 N DFN,DUP,HOL,NOW,PPI,TT,%
 S PPI=$O(^PRST(458,"B","06-26",0))
 I 'PPI D  Q
 .  W !,"Pay Period 06-26 not found in File 458."
 S HOL(3070102)=10 ; Set 01/02 into HOL array
 D NOW^%DTC S NOW=%
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 ;
 ; Quit if PP 07-01 is not opened.  The Open Next Pay Period option
 ; will automatically post their holiday.
 ; 
PP01 I '$D(^PRST(458,"B","07-01")) D  Q
 . W !,"PP 07-01 has not been opened yet.  Holiday In Lieu days will"
 . W !,"be posted to this Pay Period when it is opened.",!
 ;
 ; If the next pay period is already opened, loop through the 
 ; employees again with HOL(3070102)=-2.  This is the 2nd date
 ; in the PDH variable.
 ;
 W !,"PP 07-01 is already open.  Running checks to see if any"
 W !,"employees needed to have their extra holiday posted in this"
 W !,"Pay Period.",!
 ;
 S HOL(3070102)=-2 ; Set 01/02/2007 into HOL array
 S PPI=0,PPI=$O(^PRST(458,"B","07-01",PPI))
 I 'PPI D  Q
 . W !!,"The IEN for PP 07-01 was not found."
 . W !,"Contact EVS at 888-596-4357."
 ;
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 Q
