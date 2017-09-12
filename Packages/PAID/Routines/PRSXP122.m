PRSXP122 ;WOIFO/DWA-SET EXTRA HOLIDAY W/ PP OPEN ;12/10/2008
 ;;4.0;PAID;**122**;Sep 21, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
START ; Declare 12/26/2008 as an extra holiday for Christmas
 ;
 D BMES^XPDUTL("Checking PP 08-25")
 N DFN,DUP,HOL,NOW,PPI,TT,%
 S PPI=$O(^PRST(458,"B","08-25",0))
 I 'PPI D  Q
 .  D BMES^XPDUTL("Pay Period 08-25 not found in File 458.")
 S HOL(3081226)=20 ; Set 12/26/08 into HOL array
 D NOW^%DTC S NOW=%
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 ;
 ; Quit if PP 08-26 is not opened.  The Open Next Pay Period option
 ; will automatically post their holiday.
 ; 
PP26 ;
 I '$D(^PRST(458,"B","08-26")) D  Q
 . D BMES^XPDUTL("PP 08-26 has not been opened yet.  Holiday In Lieu days will be posted to this Pay Period when it is opened.")
 ;
 ; If the next pay period is already opened, loop through the 
 ; employees again with HOL(3081226)=6.  This is the 6th date
 ; in the PDH variable.
 ;
 D BMES^XPDUTL("PP 08-26 is already open.  Running checks to see if any employees needed to have their extra holiday posted in this Pay Period.")
 ;
 S HOL(3081226)=6 ; Set 12/26/2008 into HOL array
 S PPI=0,PPI=$O(^PRST(458,"B","08-26",PPI))
 I 'PPI D  Q
 . D BMES^XPDUTL("The IEN for PP 08-26 was not found.  Contact EVS at 888-596-4357.")
 ;
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 Q
