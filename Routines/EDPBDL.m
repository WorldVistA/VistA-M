EDPBDL ;SLC/KCM - Delete/Inactivate Config Entries
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
BED ; Delete Room/Area entries
 N AREA,IEN
 D SETAREA(.AREA) Q:'AREA
 W !,"EDIS Delete Room-Bed Tool",!
 W !,"This will delete or inactivate an entry from the TRACKING ROOM-BED file."
 W !,"This may take time, as it must search for usage of the Room-Bed entry."
 W !,"If the entry has been referenced, it will be inactivated."
 W !,"Otherwise the entry will be deleted.",!
 F  S IEN=$$LKBED(AREA) Q:'IEN  D DELBED(IEN)
 Q
LKBED(AREA) ; Lookup a bed
 N DIC,X,Y,DTOUT,DUOUT
 S DIC="^EDPB(231.8,",DIC(0)="AEMQ"
 S DIC("S")="I ($P(^(0),U,2)=DUZ(2)),($P(^(0),U,3)=AREA)"
 D ^DIC
 Q:+Y>0 +Y
 Q ""
 ;
DELBED(IEN) ; Delete bed if nothing references it, otherwise inactivate
 N NM,DA,DIE,DR,DIK,DTOUT,DUOUT
 S NM=$P($G(^EDPB(231.8,IEN,0)),U)
 I $$BEDUSED(IEN) D
 . S DA=IEN,DR=".01///Z"_NM_";.04///1",DIE="^EDPB(231.8,"
 . D ^DIE W !,NM," inactivated and renamed 'Z"_NM_"'.",!
 E  D
 . S DA=IEN,DIK="^EDPB(231.8," D ^DIK
 . W !,$S($D(^EDPB(231.8,DA,0)):" not",1:"")_" deleted.",!
 Q
BEDUSED(IEN) ; Return true if log entry references bed
 W !,"Searching for usages of ",$P(^EDPB(231.8,IEN,0),U)
 N I,FOUND,COUNT
 S I=0,FOUND=0,COUNT=0
 F  S I=$O(^EDP(230.1,I)) Q:'I  D  Q:FOUND
 . I $P($G(^EDP(230.1,I,3)),U,4)=IEN W "...found" S FOUND=1
 . S COUNT=COUNT+1 I COUNT#100=0 W "."
 Q FOUND
BOARD ; Delete Board entries
 Q
CODE ; Delete Selection entries
 N AREA,SET
 D SETAREA(.AREA) Q:'AREA
 W !,"EDIS Delete Selection Tool",!
 W !,"This will delete a locally defined selection from"
 W !,"an EDIS selection list.",!
 S SET=$$LKSEL(AREA) Q:'SET
 ;
 N DIC,X,Y,X0,NM,DTOUT,DUOUT
 S DIC="^EDPB(233.2,"_SET_",1,",DIC(0)="AEMQ"
 S DIC("W")="W $P(^(0),U,4)"
 D ^DIC
 Q:Y<1
 S X0=^EDPB(233.2,SET,1,+Y,0),NM=$P(^EDPB(233.1,+$P(X0,U,2),0),U)
 I $E(NM,1,3)="edp" W !,"Cannot delete nationally defined item." Q
 D DELCODE(SET,+Y)
 Q
LKSEL(AREA) ; Choose selection list for deletion
 N DIR,X,Y,DTOUT,DUOUT,DIRUT
 S DIR(0)="SABO^1:Status;2:Disposition;3:Delay Reason;4:Source"
 S DIR("A")="Selection List (1/2/3/4):"
 S DIR("A",1)="Choose the list you with to delete from -"
 S DIR("A",2)="1:  Status",DIR("A",3)="2:  Disposition"
 S DIR("A",4)="3:  Delay Reason",DIR("A",5)="4:  Source"
 D ^DIR
 Q:'Y ""
 ;
 N SETNM,IEN
 S SETNM=$S(1:".status",2:".disposition",3:".delay",4:".arrival",1:"")
 Q:SETNM="" ""
 S SETNM=$$STA^XUAF4(DUZ(2))_SETNM
 S IEN=$O(^EDPB(233.2,"B",SETNM,0))
 I 'IEN W !,"No locally defined selections found." Q ""
 Q IEN
 ;
DELCODE(SET,DA) ; Delete from inside selection multiple
 N DIK
 W !,$P(^EDPB(233.2,SET,1,DA,0),U,4)
 S DIK="^EDPB(233.2,"_SET_",1,",DA(1)=SET D ^DIK
 W "  ",$S($D(^EDPB(233.2,SET,1,DA,0)):" not",1:"")," deleted",!
 Q
 ;
SETAREA(AREA) ; Set to default area for institution in DUZ(2)
 S AREA=$O(^EDPB(231.9,"C",DUZ(2),0))
 I 'AREA W !,"No tracking area is configured."
 Q
