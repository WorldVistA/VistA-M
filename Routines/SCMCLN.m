SCMCLN ;swo/oifobp temp clean up routine
 ;;5.3;Scheduling;**498**;8.13.1993;Build 23
 ;lets clean-up danglers in 404.43 PATIENT TEAM POSITION ASSIGNMENT
 ;1st run thru 404.43 and find the pointers to 404.42 PATIENT TEAM ASSIGNMENT
 ;pointer is piece one of 404.43
 N CNT1,CNT2,DA,DIK,DIR,V1,V2,V3,V4,ZNODE
 S (CNT1,CNT2)=0
 W !,"Checking for ""Ghost Entries"" in the PATIENT TEAM POSITION ASSIGNMENT FILE."
 W !,"This may take a moment.  You will be provided with a list showing corrupted"
 W !,"file entries.  To perform a clean-up accept the ""Yes"" prompt after the list"
 W !,"is displayed. Answer ""No"" to abort the clean-up.",!
 S V1=0 F  S V1=$O(^SCPT(404.43,V1)) Q:'V1  D
 . S CNT1=CNT1+1
 . S ZNODE=$G(^SCPT(404.43,V1,0))
 . S V2=$P(ZNODE,U) Q:V2=""
 . S V3=$G(^SCPT(404.42,V2,0)) I V3="" D LOG
 D SHOW Q:POP
 I $G(CNT2)<1 W !,"Nothing to clean up...." Q
 S DIR("?")="Answerng Yes will perform a clean-up of the ghost entries"
 S DIR("A")="Perform File Clean-Up"
 S DIR(0)="Y",DIR("B")="No" D ^DIR
 I Y D DEL
 D CLEAN
 Q
LOG ;build a list in ^TMP("SCMCLN",$J
 S ^TMP("SCMCLN",$J,V1)=""
 S CNT2=CNT2+1
 Q
SHOW ;see what we got
 S DIOEND="D FOOT^SCMCLN"
 S DIC="^SCPT(404.43,",L=0,BY="@.03",(FR,TO)="",FLDS="[CAPTIONED]"
 S BY(0)="^TMP(""SCMCLN"",$J,"
 S L(0)=1 D EN1^DIP
 Q
DEL ;delete the danglers
 ;check #404.48 -- PCMM HL7 EVENT FILE .07 field EVENT POINTER points to 404.43
 ;variable pointer, yeck!
 S DIK="^SCPT(404.43,"
 S V1=0 F  S V1=$O(^TMP("SCMCLN",$J,V1)) Q:'V1  D
 .S V4=""""_V1_";SCPT(404.43,"_""""
 .I $O(^SCPT(404.48,"AACXMIT",V4,"")) D  Q  ;
 .. S ^TMP("SCMCLN2",$J,V1)=""
 .. W !,"Pointer to HL7 EVENT file - the entry ("_V1_") was not deleted."
 .S DA=V1
 .D ^DIK
 W !,"Clean-up completed",!
 Q
CLEAN ;clean-up
 K ^TMP("SCMCLN",$J)
 K ^TMP("SCMCLN2",$J)
 Q
FOOT ;footer message
 W !,CNT1_" entries searched.  Ghost entries found:  "_CNT2
 Q
TEST ;
 S X=0 F  S X=$O(^SCPT(404.48,X)) Q:'X  D
 . Q:($P(^SCPT(404.48,X,0),U,7)'[404.43)
 . W ^SCPT(404.43,$P($P(^SCPT(404.48,X,0),U,7),";"),0),!
 . Q
