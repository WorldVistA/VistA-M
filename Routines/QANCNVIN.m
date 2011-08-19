QANCNVIN ;HISC/GJC-Incident Reporting Convert Incident Names ;2/16/93
VERSION ;;2.0;Incident Reporting;**18**;08/07/1992
 ;
 K DIR S DIR(0)="Y",DIR("B")="Yes"
 S DIR("A",1)="Do you wish to change incident name text which contains"
 S DIR("A")="a comma to a dash" D ^DIR K DIR
 I '+Y D KILL W !,$C(7),"Exiting..." Q
TEST ;Convert ", " to "-"
 W !?5,"CONVERTING OLD INCIDENT TEXT FROM QA(742.1) TO THE"
 W !?5,"NEW INCIDENT TEXT FOR VERSION 3.0 OF INCIDENT REPORTING.",!
 D WAIT^DICD W ! K ^TMP($J) S QANSUB=""
 F  S QANSUB=$O(^QA(742.1,"B",QANSUB)) Q:QANSUB=""  D
 . S QANIEN=+$O(^QA(742.1,"B",QANSUB,0)) Q:QANIEN'>0
 . S QANOTXT=$P($G(^QA(742.1,QANIEN,0)),U)
 . I QANOTXT["," D
 .. S QANNTXT=$$CONVERT^QANCNVIN(QANOTXT)
 .. S DIE="^QA(742.1,",DA=QANIEN,DR=".01///"_QANNTXT
 .. W !?5,"Converting old incident text: "_QANOTXT
 .. W !?5,"To new incident text: "_QANNTXT,!
 .. S QANFLAG=1 D ^DIE K DA,DIE,DR
 W !?5,$S(+$G(QANFLAG):"Conversion complete!",1:"Records need not be converted.")
 W !!,$C(7) K DIR S DIR(0)="Y",DIR("B")="Yes"
 S DIR("A")="Do you wish to delete this routine from the system"
 D ^DIR K DIR
 I +Y S X="QANCNVIN" X ^%ZOSF("DEL")
KILL ;Kill and quit
 K %,%Y,DA,DR,QANFLAG,QANIEN,QANNTXT,QANOTXT
 K QANSUB,X,X1,Y
 Q
CONVERT(X) ;Convert ', ' to '-'
 K X1
 F  S X1=$F(X,", ") Q:'X1  S X=$E(X,0,X1-3)_"-"_$E(X,X1,255)
 Q X
