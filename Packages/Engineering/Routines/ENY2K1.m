ENY2K1 ;;(WIRMFO)/DH-Equipment Y2K Data Acq ;1.15.99
 ;;7.0;ENGINEERING;**51,55,61**;August 17, 1993
DATA ; ask user for Y2K fields
 ; loc var ESCAPE set to 1 for escape from procedure, otherwise undef
 N DA,J
 F J="CODE","DATE","COST","TECHI","TECHE","SHOPI","SHOPE","ACT","SOURCE","NOTE","CLASS","UTIL","REPDT" S ENY2K(J)=""
 S DIR(0)="6914,71",DIR("A")="Please select the Y2K CATEGORY",DIR("B")="CC"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("CODE")=$P(Y,U)
 S DIR(0)="6914,71.5",DIR("B")="LOCAL ASSESSMENT"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("SOURCE")=$P(Y,U)
 S DIR(0)="6914,81",DIR("B")="Medical device"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("CLASS")=$P(Y,U)
 I ENY2K("CLASS")="FS" D  Q:$G(ESCAPE)
 . S DIR(0)="6914,82O"
 . D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S ESCAPE=1 Q
 . S ENY2K("UTIL")=$P(Y,U)
 I ENY2K("CODE")="CC" D  Q
 . S DIR(0)="6914,72",DIR("A")="Enter ESTIMATED Y2K COMPLIANCE DATE"
 . D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S ESCAPE=1 Q
 . S ENY2K("DATE")=Y
 . S DIR(0)="6914,73",DIR("A")="Enter ESTIMATED Y2K COMPLIANCE COST"
 . D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S ESCAPE=1 Q
 . S ENY2K("COST")=Y
 . S DIR(0)="6914,75",DIR("A")="Technician responsible for Y2K upgrade"
 . D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S ESCAPE=1 Q
 . S ENY2K("TECHI")=+Y,ENY2K("TECHE")=$P(Y,U,2)
 . S DIC="^DIC(6922,",DIC(0)="AEQM",DIC("A")="Engineering Section responsible for Y2K upgrade: "
 . I $G(ENY2K("TECHI"))>0,$P(^ENG("EMP",ENY2K("TECHI"),0),U,10)>0 S DIC("B")=$$GET1^DIQ(6929,ENY2K("TECHI"),.3)
 . D ^DIC K DIC I $D(DTOUT)!($D(DUOUT)) S ESCAPE=1 Q
 . S ENY2K("SHOPI")=+Y,ENY2K("SHOPE")=$P(Y,U,2)
 . S DIR(0)="6914,80",DIR("A")="Notation to appear on Y2K worklist (80 char max)"
 . D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S ESCAPE=1 Q
 . S ENY2K("NOTE")=$P(Y,U)
 I ENY2K("CODE")="NC" D  Q
 . S DIR(0)="6914,76",DIR("A")="Enter the planned Y2K ACTION"
 . S DIR("?")="What do you plan to do with these non-compliant devices?"
 . D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S ESCAPE=1 Q
 . S ENY2K("ACT")=$P(Y,U)
 . I ENY2K("ACT")="REP" D  Q:$G(ESCAPE)
 .. S DIR(0)="6914,76.1O"
 .. D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S ESCAPE=1 Q
 .. S ENY2K("REPDT")=$P(Y,U)
 . S DIR(0)="6914,80",DIR("A")="Notation to be appended to equipment COMMENTS (80 char max)"
 . D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S ESCAPE=1 Q
 . S ENY2K("NOTE")=Y
 Q  ;  return control to ENY2K
 ;
UPDATE ;  update Y2K fields of conditionally compliant and non-compliant
 ;  equipment record(s)
 S DIE="^ENG(6914,",DR="71///^S X=ENY2K(""CODE"");71.5///^S X=ENY2K(""SOURCE"");81///^S X=ENY2K(""CLASS"")"
 I ENY2K("CLASS")="FS",$G(ENY2K("UTIL")) S DR=DR_";82///^S X=ENY2K(""UTIL"")"
 I ENY2K("CODE")="CC" D
 . I $G(ENY2K("DATE"))?7N S DR=DR_";72///^S X=ENY2K(""DATE"")"
 . I $G(ENY2K("COST")) S DR=DR_";73///^S X=ENY2K(""COST"")"
 . I $G(ENY2K("TECHI"))>0 S DR=DR_";75////"_ENY2K("TECHI")
 . E  S DR=DR_";75///^S X=""@"""
 . I $G(ENY2K("SHOPI"))>0 S DR=DR_";77////"_ENY2K("SHOPI")
 . E  S DR=DR_";77///^S X=""@"""
 . I $G(ENY2K("NOTE"))]"" S DR=DR_";80///^S X=ENY2K(""NOTE"")"
 I ENY2K("CODE")="NC" D
 . I $G(ENY2K("ACT"))]"" S DR=DR_";76///^S X=ENY2K(""ACT"")"
 . I $G(ENY2K("ACT"))="REP",$G(ENY2K("REPDT")) S DR=DR_";76.1///^S X=ENY2K(""REPDT"")"
 . I $G(ENY2K("NOTE"))]"" S DR=DR_";80///^S X=ENY2K(""NOTE"")"
 I ENY2K("CODE")="NA" D
 . S DR=DR_";72///^S X=""@"";73///^S X=""@"";74///^S X=""@"";75///^S X=""@"";76///^S X=""@"";77///^S X=""@"""
 S (DA,COUNT)=0 F  S DA=$O(^TMP($J,DA)) Q:'DA  D
 . L +^ENG(6914,DA):10 I '$T W !,"Equipment Entry #"_DA_" is being edited by another user. Try again later." Q
 . D ^DIE W:'(DA#10) "." S COUNT=COUNT+1
 . I $G(ENY2K("NOTE"))]"" D
 .. N ENX
 .. S ENX(1)=ENY2K("NOTE")_" (Y2K note)"
 .. D WP^DIE(6914,DA_",",40,"A","ENX") D MSG^DIALOG()
 . L -^ENG(6914,DA)
 W !,?10,COUNT_" equipment records were updated."
 Q
 ;ENY2K1
