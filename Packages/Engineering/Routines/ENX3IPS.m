ENX3IPS ;WIRMFO/DH-POST-INIT ;2.23.98
 ;;7.0;ENGINEERING;**48**;Aug 17, 1993
 ;
 I $$PATCH^XPDUTL("EN*7.0*48") D BMES^XPDUTL("Post-initialization has already been done.") Q  ;No need to do this more than once!
 N DA,NEWID
 D BMES^XPDUTL("Converting equipment maintenance histories")
 S DA=0 F  S DA=$O(^ENG(6914,DA)) Q:'DA  S DA(1)=0 F  S DA(1)=$O(^ENG(6914,DA,6,DA(1))) Q:'DA(1)  D
 . W:'(DA#20) "."
 . I $E(^ENG(6914,DA,6,DA(1),0))=0 D  Q
 . . S ENRN=(9999999-(3_$E(^ENG(6914,DA,6,DA(1),0),1,6)))*10
 . . S ^ENG(6914,DA,6,ENRN,0)=3_^ENG(6914,DA,6,DA(1),0)
 . . K ^ENG(6914,DA,6,DA(1)) ;no x-refs
 . S ^ENG(6914,DA,6,DA(1),0)=2_^ENG(6914,DA,6,DA(1),0)
 ;
 D BMES^XPDUTL("Converting Accident Report LOCAL ENGINEERING #s ...")
 S DIE="^ENG(""FSA"",",DA=0 F  S DA=$O(^ENG("FSA",DA)) Q:'DA  D
 . W:'(DA#20) "."
 . S NEWID="19"_$P($G(^ENG("FSA",DA,0)),U)
 . I NEWID?8N S DR=".01///^S X=NEWID" D ^DIE
 ;  now increment length of LOCAL ENGINEERING #
 S DA(1)=$O(^ENG(6910.9,"B","ENFSA1",0)) Q:'DA(1)
 S DA=$O(^ENG(6910.9,DA(1),1,"B","LOCAL ENGINEERING #(R)",0)) Q:'DA
 S DIE="^ENG(6910.9,"_DA(1)_",1,",DR=".03///^S X=8" D ^DIE
 ;
BERS D BMES^XPDUTL("Converting BERS Survey File (#6916)")
 N NEWID,FY
 S DIE="^ENGS(6916,",DA=0 F  S DA=$O(^ENGS(6916,DA)) Q:'DA  D
 . Q:$P(^ENGS(6916,DA,0),U)["-"
 . S NEWID="19"_$E($P(^ENGS(6916,DA,0),U),1,2)_"-"_$E($P(^(0),U),3,5)
 . S DR=".01///^S X=NEWID" D ^DIE
 . S FY=$P(^ENGS(6916,DA,0),U,4) I FY?2N S DR="4///^S X=""19""_FY" D ^DIE
 . W "."
 Q
 ;ENX3IPS
