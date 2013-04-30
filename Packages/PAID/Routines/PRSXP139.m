PRSXP139 ;WOIFO/RRG-SET EXTRA HOLIDAY W/ PP OPEN ;12/24/2012
 ;;4.0;PAID;**139**;Sep 21, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
START ; Declare 12/24/2012 as an extra holiday for Christmas
 ;
 D BMES^XPDUTL("Checking PP 12-26")
 N DFN,DUP,HOL,NOW,PPI,TT,%
 S PPI=$O(^PRST(458,"B","12-26",0))
 I 'PPI D  Q
 .  D BMES^XPDUTL("Pay Period 12-26 not found in File 458.")
 S HOL(3121224)=9 ; Set 12/24/12 into HOL array
 D NOW^%DTC S NOW=%
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 ;
 ; Quit if PP 12-27 is not opened.  The Open Next Pay Period option
 ; will automatically post their holiday.
 ; 
PP27 ;
 I '$D(^PRST(458,"B","12-27")) D  Q
 . D BMES^XPDUTL("PP 12-27 has not been opened yet.  Holiday In Lieu days will be posted to this Pay Period when it is opened.")
 ;
 ; If the next pay period is already opened, loop through the 
 ; employees again with HOL(3121224)=-1.
 ;
 D BMES^XPDUTL("PP 12-27 is already open.  Running checks to see if any employees needed to have their extra holiday posted in this Pay Period.")
 ;
 S HOL(3121224)=-1 ; Set 12/24/2012 into HOL array
 S PPI=0,PPI=$O(^PRST(458,"B","12-27",PPI))
 I 'PPI D  Q
 . D BMES^XPDUTL("The IEN for PP 12-27 was not found.  Contact EVS at 888-596-4357.")
 ;
 S DFN=0
 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 . S TT="HX",DUP=0
 . D E^PRSAPPH
 Q
