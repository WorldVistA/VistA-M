ENEQMED2 ;WISC/SAB-Multiple Equipment Edit, continued ;9/24/97
 ;;7.0;ENGINEERING;**35,39,45**;Aug 17, 1993
UPD ; update equipment
 S DIR(0)="Y",DIR("A")="OK to update the "_ENC("SEL")_" selected items"
 D ^DIR K DIR G:$D(DIRUT)!'Y EXIT
 ;
 S ENDA=0 F  S ENDA=$O(^TMP($J,"ENSEL",ENDA)) Q:'ENDA  D
 . ; lock individual item when not locking as batch; skip if unable 
 . I 'ENLOCK("BATCH") L +^ENG(6914,ENDA):1 I '$T D  Q
 . . S ^TMP($J,"ENLCK",ENDA)="" ; put skipped equipment on list
 . S ENFLD=0 F  S ENFLD=$O(^TMP($J,"ENFLD",ENFLD)) Q:'ENFLD  D
 . . S ENFLDN=$$GET1^DID(6914,ENFLD,"","LABEL")
 . . S ENVALI=$P(^TMP($J,"ENFLD",ENFLD),U)
 . . I ENFLD=30 D  Q  ; pm data
 . . . ; delete old PM data (if any)
 . . . S ENDAPM=0 F  S ENDAPM=$O(^ENG(6914,ENDA,4,ENDAPM)) Q:'ENDAPM  D
 . . . . K DA S DA(1)=ENDA,DA=ENDAPM,DIK="^ENG(6914,"_ENDA_",4,"
 . . . . D ^DIK K DIK
 . . . ; move new PM data via %RCR
 . . . S ENDAT=$G(^TMP($J,"ENFLD",30)) Q:'ENDAT
 . . . S %X="^ENG(6914,"_ENDAT_",4,",%Y="^ENG(6914,"_ENDA_",4,"
 . . . D %XY^%RCR
 . . . ; reindex PM data
 . . . S ENDAPM=0 F  S ENDAPM=$O(^ENG(6914,ENDA,ENDAPM)) Q:'ENDAPM  D
 . . . . K DA S DA(1)=ENDA,DA=ENDAPM,DIK="^ENG(6914,"_ENDA_",4,"
 . . . . D IX1^DIK K DIK
 . . I ENFLD=40 D  Q  ; comments
 . . . D WP^DIE(6914,ENDA_",",40,"A","^TMP($J,""ENCOM"")","ENERR()")
 . . I ENFLD=70 D  Q  ; spex
 . . . D WP^DIE(6914,ENDA_",",70,"A","^TMP($J,""ENSPEX"")","ENERR()")
 . . I ENVALI']"" S ENVALI=$P($G(^TMP($J,"ENFLD",ENFLD,ENDA)),U)
 . . I ENVALI']"" Q
 . . I ENFLD=2,ENVALI=ENDA Q  ; can't be it's own parent
 . . S DA=ENDA,DIE=6914,DR=ENFLD_$S(ENVALI]"":"////^S X=ENVALI",1:"")
 . . D ^DIE K DIE
 . ; did both life expectency and CSN get updated?
 . I $D(^TMP($J,"ENFLD",15)),$D(^TMP($J,"ENFLD",18)) D
 . . ; must redo life expectancy because CSN trigger overwrote
 . . S ENVALI=$P(^TMP($J,"ENFLD",15),U)
 . . I ENVALI']"" Q
 . . S DA=ENDA,DIE=6914,DR="15////^S X=ENVALI"
 . . D ^DIE K DIE
 . ; unlock individual item when not locking as batch
 . I 'ENLOCK("BATCH") L -^ENG(6914,ENDA)
 . W "."
 I $D(^TMP($J,"ENLCK")) D
 . W $C(7),!!,"Warning: Some of the selected equipment could not be"
 . W !,"updated because it was being being edited by another process."
 . W !,"These equipment items will need to be edited to make the"
 . W !,"desired changes. Print the report for more information.",!
 . S DIR("B")="YES"
 S DIR(0)="Y",DIR("A")="Would you like a list of modified equipment"
 D ^DIR K DIR G:$D(DIRUT)!'Y EXIT
 D EN^ENEQMED3
EXIT ;
 ; delete dummy record created for PM data (if any)
 I $G(ENDAT)>90000000000 D
 . ; delete responsible shops to clean up AB x-ref
 . S ENDAPM=0 F  S ENDAPM=$O(^ENG(6914,ENDAT,4,ENDAPM)) Q:'ENDAPM  D
 . . K DA S DA(1)=ENDAT,DA=ENDAPM,DIK="^ENG(6914,"_ENDAT_",4,"
 . . D ^DIK K DIK
 . ; delete renamining data (wasn't created via FileMan so don't use now)
 . K ^ENG(6914,ENDAT)
 . L -^ENG(6914,ENDAT)
 ; unlock selected equipment (if any)
 I $G(ENLOCK("BATCH")) D
 . S ENDA=0
 . F  S ENDA=$O(^TMP($J,"ENSEL",ENDA)) Q:'ENDA  L -^ENG(6914,ENDA)
 ; clean up variables
 K ^TMP($J)
 K %X,%Y,DA,DIC,DIQ,DIWESUB,DR,DUOUT,DTOUT,DIRUT,DIROUT,X,Y
 K ENA,ENASK,ENC,ENCAT,ENCATI,ENDA,ENDAPM,ENDAT,ENDX,ENEDNX
 K ENFA,ENFLD,ENFLDN,ENGOT,ENI,ENL,ENLOCK,ENMAN,ENMANI
 K ENMOD,ENNX,ENPO,ENVALE,ENVALI,ENX,ENXP
 Q
 ;ENEQMED2
