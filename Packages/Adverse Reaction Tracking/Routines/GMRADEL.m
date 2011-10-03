GMRADEL ;HIRMFO/WAA-PATIENT DELETE REACTION ;11/14/06  13:18
 ;;4.0;Adverse Reaction Tracking;**36**;Mar 29, 1996;Build 9
 ;
 ; Is this data Correct question:  
 ;Single Reaction:
 ;  user    |
 ; reponse  | action taken
 ;-------------------------------------------------------------
 ;   Yes    | Data is Sign off
 ;          |
 ;   No     | User is asked if they wish to delete the entry
 ; ^,timeout|---------------------------------------------------
 ;          | response | action taken
 ;          |---------------------------------------------------
 ;          |   yes    | the entry is deleted
 ;          | ^,timeout|
 ;          |          |
 ;          |   no     | the entry is not deletes and a alert trigered
 ;          |---------------------------------------------------
 ;
 ;Multiple Reaction:
 ;  user    |
 ; reponse  | action taken
 ;-------------------------------------------------------------
 ; select   | Selected reaction will be signed
 ;reactions |
 ;          |
 ;reactions | all User is asked if they wish to delete the entry
 ;NOT       |---------------------------------------------------
 ;selected  | response | action taken
 ; OR       |---------------------------------------------------
 ;^,timeout |   yes    | the entries is deleted
 ;          | ^,timeout|
 ;          |          |
 ;          |   no     | the entries is not deletes and a alert trigered
 ;          |---------------------------------------------------
 ;
 ;Note: Only one entry point will be needed.....
DEL ; Main Entry point
 N DIR,GMRACNT,GMRAPCT
 D DELPRT  ; No reaction to be deleted
 S DIR(0)="YA",DIR("B")="YES"
 S DIR("?")="PLEASE ENTER 'Y' TO DELETE THE CAUSATIVE AGENT"_$S(GMRACNT>1:"S",1:"")_" 'N' NOT TO DELETE THE DATA"
 S DIR("??")="^D PRINT^GMRASIGN",DIR("A")="Do you wish to delete "_$S(GMRACNT>1:"these",1:"this")_" Causative Agent"_$S(GMRACNT>1:"s",1:"")_"? " D ^DIR
 I $D(DIRUT) S Y=1,GMRAOUT=1
 S GMRAPCT=Y
 Q:'GMRAPCT  ; User did not want to delete the entry(s)
 ; User want to delete the data
 D DELETE
 Q
DELETE ; Deleting the data
 N X
 ;W !,"One moment please deleting data..."
 S X=0 F  S X=$O(^TMP($J,"GMRASF",X)) Q:X<1  D
 .N GMRAPA
 .S GMRAPA=$O(^TMP($J,"GMRASF",X,0)) ; find 120.8 data
 .S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 .I '$G(^TMP($J,"GMRASF",X,GMRAPA)) D EIE Q  ;36 Existing records are marked entered in error rather than being deleted
 .N GMRAPA1
 .S GMRAPA1=0
 .; find 120.85 data
 .F  S GMRAPA1=$O(^GMR(120.85,"C",GMRAPA,GMRAPA1)) Q:GMRAPA1<1  D
 ..S GMRAPA1(0)=$G(^GMR(120.85,GMRAPA1,0))
 ..I GMRAPA1(0)="" K ^GMR(120.85,"C",GMRAPA,GMRAPA1) Q 
 ..D  ; delete 120.85 data
 ...N DIK,DA
 ...S DIK="^GMR(120.85,",DA=GMRAPA1 D ^DIK
 ...D UNLOCK^GMRAUTL(120.85,GMRAPA1) ; Unlocking the data 120.85
 ...;W "." ;36
 ...Q
 ..Q
 .D  ; delete 120.8 data
 ..N DIK,DA
 ..S DIK="^GMR(120.8,",DA=GMRAPA D ^DIK
 ..D UNLOCK^GMRAUTL(120.8,GMRAPA) ; Unlocking the data 120.8
 ..;W "." ;36
 ..Q
 .S X=$O(^TMP($J,"GMRASF","B",GMRAPA,0))
 .K ^TMP($J,"GMRASF",X,GMRAPA),^TMP($J,"GMRASF","B",GMRAPA,X)
 .Q
 Q
DELPRT ; List all the reaction not signed
 N X,GMRAPA
 W @IOF
 S (GMRACNT,X)=0
 F  S X=$O(^TMP($J,"GMRASF",X)) Q:X<1  D
 .S GMRAPA=$O(^TMP($J,"GMRASF",X,0))
 .S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 .W !,$P(GMRAPA(0),U,2)
 .S GMRACNT=GMRACNT+1
 .Q
 Q
 ;
EIE ;Section added in patch 36, will mark existing records entered in error
 N GMRADFN,ALDATA,SUB
 S GMRADFN=$P(GMRAPA(0),U)
 S ALDATA("GMRAERRDT")=$$NOW^XLFDT,ALDATA("GMRAERRBY")=$G(DUZ,.5)
 D EIE^GMRAGUI1(GMRAPA,GMRADFN,"ALDATA")
 S SUB=$O(^TMP($J,"GMRASF","B",GMRAPA,0))
 K ^TMP($J,"GMRASF",SUB,GMRAPA),^TMP($J,"GMRASF","B",GMRAPA,SUB) ;Delete entry as it's been taken care of
 Q
