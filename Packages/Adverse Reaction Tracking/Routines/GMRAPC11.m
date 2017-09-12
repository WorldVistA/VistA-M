GMRAPC11 ;SLC-JVS Preinstall for Patch GMAR*4*11 ;8/25/98  09:00
 ;;4.0;Adverse Reaction Tracking;**11**;Mar 29, 1996
 ;
 ;Package file update for patch GMRA*4*10
 ; The above patch was sent out without updating the package file
 ;
 ;
 Q
EN ;
 N GMRAIEN,GMRAY
 S GMRAIEN=$O(^DIC(9.4,"B","ADVERSE REACTION TRACKING",0))
 ;
 S ^TMP($J,"GMRAPC11",1)="See Description in the National Patch Module for Patch GMRA*4*10."
 S GMRAY="10 SEQ #10^"_DT_"^"_DUZ
 S GMRAY(1)="^TMP($J,""GMRAPC11"")"
 S DATA=$$PKGPAT^XPDIP(GMRAIEN,"4.0",.GMRAY)
 K ^TMP($J,"GMRAPC11")
 ;
 ;
 ;
 Q
