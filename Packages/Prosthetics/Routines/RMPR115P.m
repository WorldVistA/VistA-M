RMPR115P ;VMP/RB - DELETE FIELD# 19 FOR FILE #660 ;11/7/05
 ;;3.0;Prosthetics;**115**;06/20/05
 ;;
 ;1. Post install to delete in ^DIC(19,int#,20), Entry Action for menu RMPR CLERK 
 ;
FIX1 ;Null Entry Action field for menu RMPR CLERK
 S OIEN=0,SRCH="R"
 F  S SRCH=$O(^DIC(19,"B",SRCH)) I SRCH="RMPR CLERK" S OIEN=$O(^DIC(19,"B",SRCH,OIEN)) Q
 I OIEN D
 . S DR="20////@",DIE="^DIC(19,",DA=OIEN D ^DIE
 K OIEN,SRCH,DR,DIE,DA
 Q
