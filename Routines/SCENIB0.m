SCENIB0 ; ALB/SCK - INCOMPLETE ENCOUNTER EXPANDED ERROR LIST VIEW ; 21-MAY-1997
 ;;5.3;Scheduling;**66**;AUG 13, 1993
 ;
EN ; -- main entry point for SCENI INCOMPLETE ENC EXPANDED
 D EN^VALM("SCENI INCOMPLETE ENC EXPANDED")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=SDHDR1
 S VALMHDR(2)=SDHDR2
 Q
 ;
INIT ; -- init variables and list array
 ; Variables
 ;     SDCNT
 ;     SDLINE
 ;     SDN1
 ;
 N SDCNT,SDLINE,SDN1
 ;
 K ^TMP("SCENI EXP",$J)
 D CLEAN^VALM10
 ;
 S (SDN1,SDN2,SDLINE,VALMCNT)=0
 F  S SDN1=$O(^TMP("SCENI ERR",$J,"IDX",SDN1)) Q:'SDN1  D
 . F  S SDN2=$O(^TMP("SCENI ERR",$J,"IDX",SDN1,SDN2)) Q:'SDN2  D
 .. D BLD(SDN1,$G(^TMP("SCENI ERR",$J,"IDX",SDN1,SDN2)))
 ;
 I '$D(^TMP("SCENI EXP",$J)) D
 . S ^TMP("SCENI EXP",$J,1,0)=" "
 . S ^TMP("SCENI EXP",$J,2,0)="No Information Found"
 . S VALMCNT=2
 Q
 ;
BLD(SDIDX,SDPTR) ;  Build LM display 
 ;   Variables
 ;       SCX
 ;       SCEN1
 ;      
 N SCX,SCEN1,DA
 ;
 D SET(^TMP("SCENI ERR",$J,SDIDX,0)),SET(" ")
 S DIC=409.76,DIC(0)="M",X=$P(SDPTR,U,2)
 D ^DIC
 S DA=+Y
 S DR="21",DIQ="SCEN1"
 D EN^DIQ1
 S SCX=""
 F  S SCX=$O(SCEN1(409.76,DA,DR,SCX)) Q:'SCX  D SET(SCEN1(409.76,DA,DR,SCX))
 D SET(" ")
 K DIC,DR,DIQ
 Q
 ;
SET(X) ;  Sets string X into ^TMP global for display
 S VALMCNT=VALMCNT+1
 S ^TMP("SCENI EXP",$J,VALMCNT,0)=X
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("SCENI EXP")
 Q
