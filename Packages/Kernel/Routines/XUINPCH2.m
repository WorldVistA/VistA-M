XUINPCH2 ;ISF/RWF - Post INIT for Person class file v2.; 3/10/03 1:40pm
 ;;8.0;KERNEL;**106,159,282**;Jul 10, 1995
 Q
PREXXX ;This is the pre-init
 ;Remove data from USC(8932.1)
 S ^USC="" K ^USC(8932.1)
 Q
 ;
POST G AUTO
AUTO ;Loop through and repoint the ones we can.
 N VA200,PC,R1,R2
 D BMES^XPDUTL("Now repointing entries with direct mappings.")
 D PINIT ;Build list
 F VA200=.9:0 S VA200=$O(^VA(200,VA200)) Q:VA200'>0  D
 . S PC=$O(^VA(200,VA200,"USC1","A"),-1) Q:PC'>0
 . S R1=^VA(200,VA200,"USC1",PC,0) Q:$P(R1,U,3)>0
 . S R1=+R1,R2=$G(^TMP($J,R1)) Q:R2=""
 . D REPOINT(VA200,PC,R1,R2)
 . Q
 Q
 ;
MANUAL ;Find person class entries need to ask about
 N DA,PC,R1,R2,VA200,DUOUT,LAST,XXX
 W !,"Now to re-map person class entries."
 D AINIT
 S DIR(0)="S^C:Continue;R:Recheck all",DIR("A")="Where do you want to start",DIR("B")="C"
 D ^DIR Q:$D(DIRUT)
 S LAST=.9 S:Y["C" LAST=$G(^XTMP("A4A7","LAST"),.9)
 F VA200=LAST:0 S VA200=$O(^VA(200,VA200)) Q:VA200'>0  I $$LOCK(VA200,1) D  D LOCK(VA200,0)
 . S PC=$O(^VA(200,VA200,"USC1","A"),-1) Q:PC'>0
 . S R1=^VA(200,VA200,"USC1",PC,0) Q:$P(R1,U,3)>0
 . I $P($$ACTIVE^XUSER(VA200),"^",2)="TERMINATED"  D  Q
 . . K XXX
 . . S XXX(200.05,PC_","_VA200_",",3)=DT
 . . D UPDATE^DIE("","XXX")
 . . W !,"Terminated User ("_$P(^VA(200,VA200,0),"^")_") has been automatically processed."
 . . Q
 . S R1=+R1,R2=$G(^TMP($J,R1)) Q:R2=""
 . S R2=$$ASK(R1,R2) I R2>0 D REPOINT(VA200,PC,R1,R2),MARK(VA200)
 . S:$D(DUOUT) VA200=9E10
 . Q
 W !,$S($D(DUOUT):"Come back soon to finish up.",1:"That's the end."),!
 Q
ASK(OLD,OFFER) ;Ask what to point to.
 N DIR,DIC,NEW K DUOUT
AK W !!,"User "_$P(^VA(200,VA200,0),U)," has the following person class:",!
 D SHOW(OLD)
 W !,"This has been discontinued.  Please select a new entry.",!
 W $P(OFFER,"A, ",2,9)
 S DIC="^USC(8932.1,",DIC(0)="AEMQ" D ^DIC S NEW=+Y
 I NEW>0 W !! D SHOW(NEW) S DIR(0)="Y",DIR("A")="Is this the one you want" D ^DIR
 Q:Y=1 NEW Q:$D(DUOUT)!(NEW=-1) 0
 G AK
 ;
LOCK(DA,%) ;Lock/Unlock user
 I '% L -^VA(200,DA,"USC1") Q
 I % L +^VA(200,DA,"USC1"):0 I '$T Q 0
 Q 1
RPOLD(DA1,DA,OLD,NEW) ;Don't use FM here.  Too many protections.
 N VA200,PC,R1,R2
 I $P(^VA(200,DA1,"USC1",DA,0),U)'=OLD Q
 K ^VA(200,DA1,"USC1","B",OLD,DA) S ^VA(200,DA1,"USC1","B",NEW,DA)=""
 S $P(^VA(200,DA1,"USC1",DA,0),U,1)=NEW
 Q
REPOINT(DA1,DA,OLD,NEW) ;Use FM so to fire X-ref's
 N VA200,PC,RX1,RX2,DUZ
 I $P(^VA(200,DA1,"USC1",DA,0),U)'=OLD Q
 S RX1(200.05,"+1,"_DA1_",",.01)=NEW L ^VA(200,DA1,"USC1"):30
 D UPDATE^DIE("S","RX1","RX2")
 Q
 ;
SHOW(DA) ;
 N X S X=$G(^USC(8932.1,DA,0))
 W $P(X,U,1) W:$P(X,U,2)]"" !,?3,$P(X,U,2) W:$P(X,U,3)]"" !,?6,$P(X,U,3)
 Q
PINIT ;Build swap array
 K ^TMP($J)
 F I=1:1:674 S X=$P(^USC(8932.1,I,0),U,8) I X["P" D
 . S J=$P(X,"P",2),^TMP($J,I)=J
 . Q
 Q
AINIT ;Build swap array for the Ask user
 K ^TMP($J)
 F I=1:1:674 S X=$P(^USC(8932.1,I,0),U,8) I X["A" D
 . S ^TMP($J,I)=X
 . Q
 Q
BUILD ;
 D AINIT S IEN=17,DA=0,DATE=2960101
 F  S DA=$O(^TMP($J,DA)) Q:DA'>0  D
 . S DATE=$$FMADD^XLFDT(DATE,2),ID=$O(^VA(200,IEN,"USC1",999),-1)
 . S $P(^VA(200,IEN,"USC1",ID,0),U,3)=DATE,^VA(200,IEN,"USC1",(ID+1),0)=DA_U_DATE
 . Q
 Q
MARK(Y) ;Set checkmark
 S ^XTMP("A4A7",0)=DT,^("LAST")=Y
 Q
 ;
CLEANUP ;Cleanup after done.
 ;D DEL^XPDMENU("XXX") ;no line found
 K ^XTMP("A4A7")
 ;S X="XUINPCH2" X "X ^%ZOSV(""DEL"") HALT"
 ;
