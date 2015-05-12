PRSXP144 ;ALB/BJR-SET EXTRA HOLIDAY W/ PP OPEN ;12/8/2014
 ;;4.0;PAID;**144**;Sep 21, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
START ; Declare 12/26/2014 as an extra holiday for Christmas
 ;
 D BMES^XPDUTL("Checking PP 14-25")
 N DFN,DUP,HOL,NOW,PPI,TT,%
 S PPI=$O(^PRST(458,"B","14-25",0))
 S HOL(3141226)=13 ; Set 12/26/14 into HOL array
 I 'PPI D  Q
 .  D BMES^XPDUTL("Pay Period 14-25 not found in File 458.")
 D NOW^%DTC S NOW=%
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 ;
 ; Quit if PP 14-26 is not opened.  The Open Next Pay Period option
 ; will automatically post their holiday.
 ; 
PP26 ;
 I '$D(^PRST(458,"B","14-26")) D  Q
 . D BMES^XPDUTL("PP 14-26 has not been opened yet.  Holiday In Lieu days will be posted to this Pay Period when it is opened.")
 ;
 ; If the next pay period is already opened, loop through the 
 ; employees again with HOL(3141226)=-1.
 ;
 D BMES^XPDUTL("PP 14-26 is already open.  Running checks to see if any employees needed to have their extra holiday posted in this Pay Period.")
 ;
 S HOL(3141226)=-5 ; Set 12/26/2014 into HOL array
 S PPI=0,PPI=$O(^PRST(458,"B","14-26",PPI))
 I 'PPI D  Q
 . D BMES^XPDUTL("The IEN for PP 14-26 was not found.  Contact NSD at 888-596-4357.")
 ;
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 Q
