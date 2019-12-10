TIUPR327 ;;HSRM-PB/LB - CCRA PRE INSTALL;APR 22, 2019
 ;;1.0;TIU;**327**;JUL 18, 2019;Build 37
 ;;Per VA directive 6402, this routine should not be modified.
 ;Pre install routine for patch TIU*1.0*327.
 ;Sets the Auto Start FIELD (#4.5) in the HL LOGICAL LINK FILE to Enabled
 Q
EN ;
 N DIC,Y,X,SDIEN,SDFDA,SDMSG
 K DIC(0)
 S X="TIUCCRA",DIC(0)="QEZ",DIC="^HLCS(870," D ^DIC
 Q:+$G(Y)'>0
 S SDIEN=+Y_","
 S SDFDA(870,SDIEN,4.5)=1
 D UPDATE^DIE("","SDFDA","SDIEN","SDMSG")
 K DIC,X,Y,SDIEN,SDFDA,SDMSG,DIC(0)
 Q
