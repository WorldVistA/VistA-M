GMRC134P ;HSRM/PB/MBJ E- CCRA PRE INSTALL;APR 22, 2019
 ;;3.0;Consult Tracking;**134**;July 19, 2019;Build 20
 ;;Per VA directive 6402, this routine should not be modified.
 ;Pre install routine for patch GMRC*3.0*134.
 ;Sets the Auto Start FIELD (#4.5) in the HL LOGICAL LINK FILE to Enabled
 Q
EN ;
 N X,DIC,Y,X,GMRCIEN,GMRCFDA,GMRCMSG
 K DIC(0)
 S X="GMRCCCRA",DIC(0)="QEZ",DIC="^HLCS(870," D ^DIC
 Q:+$G(Y)'>0
 S GMRCIEN=+Y_","
 S GMRCFDA(870,GMRCIEN,4.5)=1
 D UPDATE^DIE("","GMRCFDA","GMRCIEN","GMRCMSG")
 K X,DIC,Y,GMRCIEN,GMRCFDA,GMRCMSG,Y,X,DIC(0)
 Q
