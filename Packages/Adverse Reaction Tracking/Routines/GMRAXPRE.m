GMRAXPRE ;HIRMFO/RM-PREINIT ROUTINE FOR A/AR TRACKING ;12/14/95  14:31
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
EN1 ; Main entry to pre-installation routine for ADVERSE REACTION TRACKING.
 S DT=$$DT^XLFDT ; supported reference, new SAC
 S GMRAVER=+$$VERSION^XPDUTL("GMRA")
 I GMRAVER D IXKILL
 Q
IXKILL ; Kill off "ANKA" cross-reference from .01 field.
 ;** DBIA #1450
 N GMRAIX
 S GMRAIX=0 F  S GMRAIX=$O(^DD(120.8,.01,1,GMRAIX)) Q:GMRAIX'>0  D
 .  I $P($G(^DD(120.8,.01,1,GMRAIX,0)),"^",2)="ANKA01" D
 .  .  K ^DD(120.8,.01,1,GMRAIX),^DD(120.8,0,"IX","ANKA01",120.8,.01)
 .  .  Q
 .  Q
 Q
