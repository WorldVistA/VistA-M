GMRGXPST ;HISC/RM-POSTINITIALIZTION FOR GMR GENERATOR ;4/17/92
 ;;3.0;Text Generator;;Jan 24, 1996
EN1 ; ENTRY TO POSTINITIALIZAION
 D POST^GMRGXAGC
 G:'GMRGXVER DD W !!,"Re-indexing ""AKID"" xref for file 124.2..."
 K ^GMRD(124.2,"AKID")
 F DA(1)=0:0 S DA(1)=$O(^GMRD(124.2,DA(1))) Q:DA(1)'>0  W:'$R(100) "." F DA=0:0 S DA=$O(^GMRD(124.2,DA(1),1,DA)) Q:DA'>0  S NURS=$G(^GMRD(124.2,DA(1),1,DA,0)) I +NURS S ^GMRD(124.2,"AKID",+NURS,DA(1),+$P(NURS,"^",6),DA)=""
 W !!,"Updating Aggregate Term file entries..."
 S DIE="^GMRD(124.2,",DR="6///T" F DA=0:0 S DA=$O(^GMRD(124.2,DA)) Q:DA'>0  S NURS=$S($D(^GMRD(124.2,DA,0)):^(0),1:"") I $P(NURS,"^",3)="NURSC"!($P(NURS,"^",3)="ZZ"),'$L($P(NURS,"^",8)) D ^DIE W "."
DD W !!,"Setting field protection on appropriate fields..."
 S ^DD(124.11,1,9)="@" F X=124.2,124.25 F Y=7:1:10 S ^DD(X,Y,9)="@" ; FM does not automatically set the protection on these fields to '@'.
 S ^DD(124.31,4,8)="^" ; FM does not automatically set READ access.
 K GMRGXP,GMRGXVER
 Q
