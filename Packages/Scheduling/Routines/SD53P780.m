SD53P780 ;TMP/DRF - TMP POST INSTALL FOR PATCH SD*5.3*780;July 30, 2018
 ;;5.3;Scheduling;**780**;May 29, 2018;Build 17
 ;
 ;Post install routine for SD*5.3*780 to load existing non-clinic days and blocked hours that occur in the future.
 ;
POST ;Post install routines for SD*5.3*780
 N SC,SD,ST,SDCAN
 D NONCLIN
 D BLOCKED
 D BMES^XPDUTL("Rebuilding Menus....") D BLD D BMES^XPDUTL("Rebuilding menus complete.")
 Q
 ;
NONCLIN ;Send existing non-clinic days
 S SC=0 F  S SC=$O(^SC(SC)) Q:'SC  D
 . S SD=DT F  S SD=$O(^SC(SC,"ST",SD)) Q:'SD  D
 .. S ST=$G(^SC(SC,"ST",SD,1)) I ST'["[" D DAYS
 Q
 ;
BLOCKED ;Finding existing blocked hours
 S SC=0 F  S SC=$O(^SC(SC)) Q:'SC  D
 . S SD=DT F  S SD=$O(^SC(SC,"SDCAN",SD)) Q:'SD  D
 .. S SDCAN=$G(^SC(SC,"SDCAN",SD,0)) I SDCAN]"" D HOURS
 Q
 ;
DAYS ;Call HL7 builder
 D EN^SDTMPHLC(SC,SD_".0",1440,"C",$E(ST,10,99))
 Q
 ;
HOURS ;Sending existing blocked hours
 N SDSTRT,SDEND,SDLNGTH
 S SDSTRT=$P(SDCAN,"^",1),SDEND=$P(SDCAN,"^",2),SDEND=+($P(SDSTRT,".",1)_"."_SDEND)
 S SDLNGTH=$$FMDIFF^XLFDT(SDEND,SDSTRT,2)/60
 D EN^SDTMPHLC(SC,SDSTRT,SDLNGTH,"P","BLOCKED")
 Q
 ;
BLD ; Menu updates
 N ADDED
 S ADDED=$$DELETE^XPDMENU("SDSUP","SD TELE TOOLS")
 S ADDED=$$ADD^XPDMENU("SD TELE TOOLS","SD PROVIDER ADD/EDIT")
 S ADDED=$$ADD^XPDMENU("SDMGR","SD TELE TOOLS")
 Q
