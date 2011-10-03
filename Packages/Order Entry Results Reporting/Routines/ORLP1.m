ORLP1 ; SLC/DCM,CLA - Patient Lists, Store ; [1/3/01 1:37pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,63,90,98**;Dec 17, 1997
 ;
STOR ;called by ORLP0 - Store lists
 N %,DA,DIC,DIK,DIR,DLAYGO,DR,ORLIST,ORLN,I,J,X,Y
 W !!,"Store list for future reference"
 S %=1 D YN^DICN Q:%=-1
 I %=0 W !,"You may store the newly compiled list.  Answer YES or NO." G STOR
 Q:%=2
 ;
GETNAME ; Call DIR to get user entry for new list name:
 N ORTNAM
 S ORTNAM=""
 N ORNEWL   ; Flag used to indicate a new list (v. existing list).
 S ORNEWL=1 ; Begin w/assumption of a new list name.
 F  D  Q:$D(X)
 .S DIR(0)="FAO^3:30",DIR("A")="Enter a name for this list: "
 .D ^DIR
 .I '$D(X)!($D(DIRUT)) K DIRUT W "  List not permanently stored." Q
 .S (ORLN,ORTNAM)=X
 .S X=$G(X),DIC="^OR(100.21,"
 .D ^DIC
 I '$D(X)!(X="") Q
 I +Y>0 S ORLIST=+Y,ORLN=$P(Y,U,2) K DIC S Y=ORLIST S ORNEWL=0 ; List name already exists.
 ;
OVRWR ;
 N ORABORT ; Flag for aborting process.
 S ORABORT=0
 ;
 ; Check for problems with name entry:
 I 'ORNEWL D
 .I $$NAMCH(+ORLIST) S ORABORT=1
 I ORABORT G GETNAME
 ;
 ; Ask - overwrite if an existing team by that name already?:
 I 'ORNEWL D
 .I $O(^OR(100.21,+Y,10,0)) D  Q:%'=1  ; Any patients on list yet?
 ..F  D  Q:%
 ...W !,ORLN_" already has patients.  Do you want to overwrite it"
 ...S %=2 D YN^DICN
 ...I %=2!(%=-1) W !,"List ",ORLN," unchanged.",! S ORABORT=1 Q
 ...I '% W !,"Answer YES or NO, if you answer YES the list "_ORLN_" will be cleared,",!,"and this temporary list will overwrite it.",! Q
 .I ORABORT Q
 .L +^OR(100.21,+ORLIST)
 .I '$D(^OR(100.21,ORLIST,10,0))#2 S ^(0)="^100.2101AV^"
 .I '$D(^OR(100.21,ORLIST,1,0))#2 S ^(0)="^100.212PA^"
 .S I=0 F  S I=$O(^OR(100.21,ORLIST,10,I)) Q:'I  S DA=+I,DA(1)=+ORLIST,DIK="^OR(100.21,"_ORLIST_",10," D ^DIK
 .L -^OR(100.21,+ORLIST)
 I ORABORT G GETNAME
 ;
 ; If a new list name, write new team into OE/RR LIST file:
 I ORNEWL D
 .S DIC="^OR(100.21,",DLAYGO=100.21,DIC(0)="LEFQZ"
 .D ^DIC
 .I (Y<0!'$D(X)) S ORABORT=1 Q  ; User aborted or there was a problem.
 .S ORLIST=+Y
 I ORABORT K DIC Q
 ;
 ; Assure other required entries if necessary:
 I ORNEWL D
 .I $P($G(^OR(100.21,+ORLIST,1,0)),U,2)'="P" D
 ..S DIE="^OR(100.21,",DA=ORLIST,DR="1///^S X=""P"""
 ..D ^DIE
 ..K DIE,DA
 .I '$D(^OR(100.21,+ORLIST,1,DUZ)) S DA(1)=ORLIST,DIC="^OR(100.21,"_DA(1)_",1,",DIC(0)="LX",X="`"_DUZ D ^DIC K DIC
 ;
 ; Add selected patients to list (if any):
 L +^OR(100.21,+ORLIST)
 S ORI=0
 F  S ORI=$O(^XUTL("OR",$J,"ORLP",ORI)) Q:ORI<1  I $D(^(ORI,0)) S X=^(0),X="PT.`"_+$P(X,"^",3),DA(1)=ORLIST,DIC="^OR(100.21,"_ORLIST_",10,",DIC(0)="LX" D ^DIC
 K DIC,ORI
 L -^OR(100.21,ORLIST)
 W !!,"List has been stored."
 Q
 ;
MERG ;called by option ORLP MERG - merge patient lists
 D CLEAR^ORLP ;clear XUTL for merge
 D ASK^ORLP0(.X)
 I (X<0)!(X>1) Q
 S:'$D(ORCNT) ORCNT=0
 W @IOF,!,"Merging patients from two or more Personal and/or Team patient lists.",!
 S DIC="^OR(100.21,",DIC(0)="AEQM",DIC("S")="I ""PT""[$E($P(^(0),U,2))"
 F ORK=1:1 S ORCT=0,DIC("A")="Select LIST "_ORK_": " D P1^ORLP0 Q:ORY<1  I ORCNT>0 W !!,ORCT_" Patients added, "_ORCNT_" total"
 Q:$D(DTOUT)!($D(DUOUT))
 I 'ORCNT W !!,"List empty.",! D END^ORLP0 Q
 D PR2^ORLA1(OROPREF)
 W !!,"LIST PATIENTS MERGED"
 D LIST^ORLP0
 D STOR,END^ORLP0
 D BUILD^ORLA1 ;load XUTL with user's primary list
 K DIC,ORCEND,ORCLIN,ORCNT,ORCOLW,ORCSTRT,ORCT,ORDEF,ORK,ORPRIM,ORPROV,ORSPEC,ORTITLE,ORUPNM,ORUSSN,ORWARD,Y
 Q
 ;
DEL ;called by option ORLP DELETE - delete a list
 I '$D(ORLST) S DIC="^OR(100.21,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)'=""P""",DIC("A")="Select Team PATIENT LIST to delete: "
 I $D(ORLST) S DIC="^OR(100.21,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)=""P""&($D(^OR(100.21,""C"",DUZ,+Y)))",DIC("A")="Select Personal PATIENT LIST to delete: "
 D ^DIC
 K DIC
 I Y<1 Q
 S DLIST=Y
 ;
D2 ;
 S %=""
 I $$GET^XPAR("USR.`"_DUZ,"ORLP DEFAULT TEAM",1,"I")=+DLIST W !!,"This is your primary patient list, are you sure you want to remove it" S %=2 D YN^DICN
 I %=0 W !,"Answer YES if you really want to remove this list." G D2
 I %'="" Q:%'=1
 W !!,"WARNING - Deleting a patient list will disable access by providers who use the",!,"list as their preferred patient list."
 ;
D1 ;
 W !,"Are you ready to delete list ",$P(DLIST,"^",2)
 S %=2 D YN^DICN
 I %=0 W !,"Enter YES to delete the list, NO to quit." G D1
 Q:%'=1
 W !,"Processing........"
 L +^OR(100.21,+DLIST)
 S DA=+DLIST,DIK="^OR(100.21,"
 D ^DIK
 K DA,DIC,DIK
 ;
 ; Next 2 lines added by PKS, 2/8/2000:
 W !,"Searching for/removing Consults pointers to deleted team..."
 D CLNLIST^GMRCTU(+DLIST,0) ; Dump pointers to team in file 123.5.
 ;
 W !,"List deletion completed.",!
 L -^OR(100.21,+DLIST)
 K DLIST,ORLPDUZ,Y,XX,^TMP("ORLP",$J,"TLIST") ;KILL temporary list
 G DEL
 Q
 ;
CLEAR(X) ;called by option ORLP CLEAR - clear active list
 I '$D(^XUTL("OR",$J,"ORLP")) W !!,"No list currently defined" S X=1 Q
 F  D  Q:X
 . W !!,"Are you sure you want to clear the current pt selection list"
 . S %=2 D YN^DICN
 . I %=-1 S X=% Q
 . I %=0 W !!,"YES will clear the current pt selection list and leave you with a blank slate to work from." S X=0 Q
 . I %=1 K ^XUTL("OR",$J,"ORLP"),^("ORV"),^("ORU"),^("ORW") S:$D(ORCNT) ORCNT=0 W !!,"List cleared" S X=% Q
 . W !!,"Nothing done."
 . S X=2
 Q
 ;
NAMCH(ORTEAM) ; Check for name duplication, proper team type.
 ;
 ; Variables used:
 ;
 ;    ORTEAM = IEN of team in Team List file (^OR100.21).
 ;
 ; Check for name duplication and not a "Personal" type team:
 I $P($G(^OR(100.21,ORTEAM,0)),U,2)'="P" D  Q 1
 .W !,ORTNAM," name already used - can't overwrite.",!
 .K X,Y,ORLIST,ORLN
 ;
 ; Check for "Personal" type but not current user's team:
 ;    ("CREATOR" field was added later, so not used here.)
 ;    Is this user's DUZ in "USER" multiple?
 I '$D(^OR(100.21,"C",DUZ,ORTEAM)) D  Q 1
 .W !,ORTNAM," name exists, you are not a user - can't overwrite.",!
 .K X,Y,ORLIST,ORLN
 ;
 Q 0
 ;
OWNER ; Get input from CAC for list user/owner.
 ;
 ; Variables used herein:
 ;
 ;    DIR,X,Y = FM call variables.
 ;    ORYY    = NEW'd in calling routine (ORLP).
 ;    OROWNER = NEW'd in calling routine (ORLP).
 ;
 N DIR,X,Y
 ;
 ; Assign variables and get input from CAC for user/owner of list:
 S OROWNER="" ; Default.
 S DIR(0)="PAO^200,:AEMNQ"
 S DIR("A")="  Enter owner of this Personal type list: "
 S DIR("S")="I $D(X),$D(^VA(200,""AK.PROVIDER"",$P(^(0),U))),$$ACTIVE^XUSER(+Y)"
 S DIR("?")="Only owner you specify can edit list after creation."
 D ^DIR
 S OROWNER=Y
 K DIR,X,Y                             ; Clean up.
 I OROWNER<1 S OROWNER="" Q            ; No acceptable entry.
 S OROWNER=+OROWNER                    ; Selected user's DUZ.
 S $P(^OR(100.21,+ORYY,0),U,5)=OROWNER ; Assign CREATOR field.
 ;
 Q
 ;
