DGYKPT ;ALB/REW - DG Post-Init Driver for 10/1 Maintenance Patch ; 6/14/94
 ;;5.3;Registration;**31**;Aug 13, 1993
 ;
EN ; -- main entry point
 D HOME^%ZIS
 D LINE^DGVPP,EN^DGYKCEN ; New entry to PTF CENSUS DATE File (#45.86)
 D LINE^DGVPP,EN^DGYKREL ; Religion File (#13) Update
 D LINE^DGVPP
 D ENDTIME
ENQ Q
 ;
 ;
ENDTIME ; -get stop time
 D NOW^%DTC S DGEDT=$H W !!,">>> Initialization Complete at " S Y=% D DT^DIQ
 I $D(DGBDT) D
 .S DGDAY=+DGEDT-(+DGBDT)*86400 ;additional seconds of over midnight
 .S X=DGDAY+$P(DGEDT,",",2)-$P(DGBDT,",",2) W !,"    Elapse time for initialization was: ",X\3600," Hours,  ",X\60-(X\3600*60)," Minutes,  ",X#60," Seconds"
 K DGBDT,DGEDT,DGDAY,X
 D MSG Q
 ;
MSG ; -- print message at end
 W !!,?2,"Remember to recompile the DG701 Input Template using ^DIEZ on all systems."
 Q
