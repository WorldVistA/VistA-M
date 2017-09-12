ENXHIPS ;WISC/SAB-POST INIT ;11/10/97
 ;;7.0;ENGINEERING;**28**;Aug 17, 1993
 N DA,DIK,ENDA,ENFYAE,ENFYCO,ENI,ENOPT,ENPN,ENY5
 D MES^XPDUTL("  Performing Post-Init...")
 ;
ENPARAM ; populate 6910 project tracking domain
 I $D(^DIC(6910,1)),$P($G(^DIC(6910,1,9)),U,2)="" D
 . S ENI=$$FIND1^DIC(4.2,"","","FORUM")
 . I ENI S $P(^DIC(6910,1,9),U,2)=ENI
 ;
PROJUPD ; loop through projects and update
 D MES^XPDUTL("    Setting Progress Report milestone dates with a month and year")
 D MES^XPDUTL("    but no day equal to the last day of the month")
 S ENDA=0 F  S ENDA=$O(^ENG("PROJ",ENDA)) Q:'ENDA  D
 . ; fix status value incorrectly populated by trigger
 . I $P($G(^ENG("PROJ",ENDA,1)),U,3)="COMPLETED PROJECT" S $P(^ENG("PROJ",ENDA,1),U,3)=16
 . ; Check/Fix 2 digit funding years
 . S ENFYAE=$P($G(^ENG("PROJ",ENDA,5)),U,7)
 . S ENFYCO=$P($G(^ENG("PROJ",ENDA,0)),U,7)
 . K DR S DR=""
 . I ENFYAE?2N S DR=DR_";3.45///^S X=19"_ENFYAE
 . I ENFYCO?2N S DR=DR_";3.5///^S X=19"_ENFYCO
 . I DR]"" S DR=$E(DR,2,999),DIE="^ENG(""PROJ"",",DA=ENDA D ^DIE K DR,DIE
 . ; Populate new MA/MI Contingency PCT field
 . I "^MA^MI^MM^"[(U_$P($G(^ENG("PROJ",ENDA,0)),U,6)_U) D
 . . S ENY(19)=$G(^ENG("PROJ",ENDA,19))
 . . I $P(ENY(19),U,8)]"",$P(ENY(19),U,12)="" S $P(^ENG("PROJ",ENDA,19),U,12)=$$GET1^DIQ(6925,ENDA,218)
 . ; Set Milestone Dates to End Of Month
 . D SETEOM(2,2,10)
 . D SETEOM(3,1,9)
 . D SETEOM(4,1,15)
 . D SETEOM(50,2,19)
 . D SETEOM(51,1,3)
 . D SETEOM(56,1,12)
 . D SETEOM(61,2,10)
 . D SETEOM(62,1,9)
 . D SETEOM(63,1,15)
 . D SETEOM(66,2,19)
 . D SETEOM(67,1,3)
 . D SETEOM(69,1,12)
 ;
 ; update applicable programs for project status
 S $P(^ENG(6925.2,8,0),U,5)="MA,MI,MM,NR,SL" ; a/e
 S $P(^ENG(6925.2,11,0),U,5)="MA,MI,MM,NR,SL" ; construction documents
 ;
 D MES^XPDUTL("  Completed Post-Init")
 Q
 ;
SETEOM(ENODE,ENPB,ENPE) ; Set Dates to End Of Month
 ; Input ENDA  - ien of project
 ;       ENODE - node which contains milestone dates
 ;       ENPB  - piece in ENODE to begin a range of milestones
 ;       ENPE  - piece in ENODE to end a range of milestones
 N ENI,ENW,ENY
 S ENY=$G(^ENG("PROJ",ENDA,ENODE)),ENW=0
 F ENI=ENPB:1:ENPE I $E($P(ENY,U,ENI),4,5)>0,$E($P(ENY,U,ENI),6,7)="00" S $P(ENY,U,ENI)=$$EOM^ENUTL($P(ENY,U,ENI)),ENW=1 ;W "."
 I ENW S ^ENG("PROJ",ENDA,ENODE)=ENY
 Q
 ;ENXHIPS
