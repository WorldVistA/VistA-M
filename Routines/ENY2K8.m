ENY2K8 ;(WIRMFO)/DH-Equipment Y2K Report (Overwrite?) ;5.7.98
 ;;7.0;ENGINEERING;**51**;August 17, 1993
OVERWRT ;  ask user what to do with existing entries
 W !!,"Of these "_COUNT_" equipment records, "_COUNT("PRE")_" already have a Y2K CATEGORY."
 I COUNT("FC") W !,?10,COUNT("FC")_" are FULLY COMPLIANT."
 I COUNT("NC") W !,?10,COUNT("NC")_" are NON-COMPLIANT."
 I COUNT("CC") W !,?10,COUNT("CC")_" are CONDITIONALLY COMPLIANT."
 I COUNT("NA") W !,?10,COUNT("NA")_" are NOT APPLICABLE."
 W ! S DIR(0)="Y",DIR("A")="Do you want to OVERWRITE these existing equipment records",DIR("B")="NO"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 D:'Y
 . F J="FC","NC","CC","NA" S DA=0 F  S DA=$O(^TMP($J,J,DA)) Q:'DA  K ^TMP($J,DA)
 . F J="FC","NC","CC","NA" K ^TMP($J,J)
 I '$D(^TMP($J)) S ESCAPE=1
 Q
 ;ENY2K8
