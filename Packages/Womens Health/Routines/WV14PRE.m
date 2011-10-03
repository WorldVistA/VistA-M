WV14PRE ;HCIOFO/FT-WV*1*14 PRE-INSTALL/Transfer Sexual Trauma Data to DG MST Module ;3/19/01  13:25
 ;;1.0;WOMEN'S HEALTH;**14**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; #1157 - $$DELETE^XPDMENU   (supported)
 ;
REMOVE ; Remove [WV ADD TO MST] option from File Maintenance Menu
 N WVFLAG,WVMENU,WVOPTION
 S WVMENU="WV MENU-FILE MAINTENANCE"
 S WVOPTION="WV ADD TO MST"
 S WVFLAG=$$DELETE^XPDMENU(WVMENU,WVOPTION)
 Q
