SDPST730 ;HSRM/PB CCRA PRE INSTALL;APR 22, 2019
 ;;5.3;Scheduling;**730**;APR 4, 2019;Build 8
 ;;Per VA directive 6402, this routine should not be modified.
 ;Pre install routine for patch SD*5.3*730.
 ;Sets the Auto Start FIELD (#4.5) in the HL LOGICAL LINK FILE to Enabled
 Q
EN ;
 N X,DIC,Y,X,SDIEN,SDFDA,SDMSG
 K DIC(0)
 S X="CCRA-NAK",DIC(0)="QEZ",DIC="^HLCS(870," D ^DIC
 Q:+$G(Y)'>0
 S SDIEN=+Y_","
 S SDFDA(870,SDIEN,4.5)=1
 D UPDATE^DIE("","SDFDA","SDIEN","SDMSG")
 K X,DIC,Y,SDIEN,SDFDA,SDMSG,Y,X,DIC(0)
 Q
