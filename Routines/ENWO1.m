ENWO1 ;WCIOFO/DLM/DH/SAB-Process Work Order ;1/2/2001
 ;;7.0;ENGINEERING;**35,51,59,67**;Aug 17, 1993
ENT ;Edit work orders
 D WO^ENWOUTL S DA=+Y G:DA'>0 EXIT L +^ENG(6920,DA):5 I '$T W !!,"This work order is being edited by another user.  Please try again later.",*7,! G ENT
 I $D(^ENG(6920,DA,5)),$P(^(5),U,2)]"" D
 . W !,*7,"NOTE: This work order has already been closed out."
 . I '$D(^XUSEC("ENEDCLWO",DUZ)) W !,"Security key ENEDCLWO is needed to edit closed work orders." L -^ENG(6920,DA) S DA="" Q
 . S DIR(0)="Y",DIR("A")="Are you sure you want to edit this work order",DIR("B")="NO"
 . D ^DIR K DIR I Y'>0 L -^ENG(6920,DA) S DA="" Q
 . I $P($G(^ENG(6920,DA,3)),U,8)>0 D KILLHS^ENEQHS I $G(R)="^" S DA="" Q
 . S ENWOCLOD=$P(^ENG(6920,DA,5),U,2)
 . S $P(^ENG(6920,DA,5),U,2)="",$P(^ENG(6920,DA,4),U,3)=""
 . D TEST^ENWOCOMP
 . ; if PM work order then back out PM hours
 . I $E($P($G(^ENG(6920,DA,0)),U),1,3)="PM-" D
 . . N ENPMDT,PMTOT,X
 . . D PMHRS^ENEQPMR4 Q:'$D(PMTOT)
 . . S X=$P($P(^ENG(6920,DA,0),U),"-",2)
 . . F I=1:1:$L(X) S:$E(X,I)?1N ENPMDT=$G(ENPMDT)_$E(X,I)
 . . S ENPMDT=$E(ENPMDT,1,4)
 . . D UNPOST^ENBCPM8
 G:DA="" ENT
 S DIE="^ENG(6920,",DR=$S($D(^DIE("B","ENZWOEDIT")):"[ENZWOEDIT]",1:"[ENWOEDIT]")
 S ENDA=DA
 D ^DIE
 ; if PM work order closed then post PM hours
 I $G(DA),$E($P($G(^ENG(6920,DA,0)),U),1,3)="PM-",$P($G(^(5)),U,2)]"" D
 . N ENPMDT,PMTOT,X
 . D PMHRS^ENEQPMR4 Q:'$D(PMTOT)
 . S X=$P($P(^ENG(6920,DA,0),U),"-",2)
 . F I=1:1:$L(X) S:$E(X,I)?1N ENPMDT=$G(ENPMDT)_$E(X,I)
 . S ENPMDT=$E(ENPMDT,1,4)
 . D COUNT^ENBCPM8
 L -^ENG(6920,ENDA) K ENDA
 G ENT
 ;
CLSOUT ;Close work order
 D WO^ENWOUTL S DA=+Y I DA'>0 G EXIT
 I $E(^ENG(6920,DA,0),1,3)="Y2-" W !,*7,"Please use the Y2K Equipment Management Module to close Y2K work orders." G CLSOUT
 L +^ENG(6920,DA):5 I '$T W !!,"This work order is being edited by another user.  Please try again later.",*7 G CLSOUT
 I $D(^ENG(6920,DA,5)),$P(^(5),U,2)]"" D
 . W !,*7,"NOTE: This work order has already been closed out."
 . I $D(^XUSEC("ENEDCLWO",DUZ)) W !,"You may use the work order EDIT or DISPLAY option to edit this work order."
 . L -^ENG(6920,DA) S DA=""
 I DA="" G CLSOUT
 S DIE="^ENG(6920,",DR=""
 ; select template
 D
 . I $E(^ENG(6920,DA,0),1,3)="PM-" S DR=$S($D(^DIE("B","ENZPMCLOSE")):"[ENZPMCLOSE]",1:"[ENPMCLOSE]") Q
 . S X=$P($G(^ENG(6920,DA,2)),U)
 . I X>0,$P($G(^DIC(6922,X,0)),U,5) S DR=$S($D(^DIE("B","ENZWOBIOCLSE")):"[ENZWOBIOCLSE]",1:"[ENWOBIOCLSE]") Q
 . S DR=$S($D(^DIE("B","ENZWOCLOSE")):"[ENZWOCLOSE]",1:"[ENWOCLOSE]")
 S ENDA=DA
 D ^DIE
 ; if PM work order closed then post PM hours, update equip file
 I $D(DA),$E($P($G(^ENG(6920,DA,0)),U),1,3)="PM-",$P($G(^(5)),U,2)]"" D
 . N ENPMDT,PMTOT,X
 . D PMHRS^ENEQPMR4,PMINV^ENEQPMR4
 . Q:'$D(PMTOT)
 . S X=$P($P(^ENG(6920,DA,0),U),"-",2)
 . F I=1:1:$L(X) S:$E(X,I)?1N ENPMDT=$G(ENPMDT)_$E(X,I)
 . S ENPMDT=$E(ENPMDT,1,4)
 . D COUNT^ENBCPM8
 L -^ENG(6920,ENDA) K ENDA
 W !!
 G CLSOUT
 ;
EQHIV ;EQUIPMENT HIST
 Q  ;Obsolete entry point
 ;
EQHI ;  Equipment work order history, by entry number
 S DIC("S")="I $D(^(3))" D GETEQ^ENUTL G:Y'>0 EXIT S ENDA=+Y
 D NOW^%DTC S ENSTMPL="ENWOHIST"_%
 W !,"Compiling SORT TEMPLATE ["_ENSTMPL_"]",!
 K DD,DO S DIC="^DIBT(",DIC(0)="X",X=ENSTMPL D FILE^DICN S DA=+Y
 I DA'>0 W !,"Process ABORTED.",*7 G EXIT
 S ENSTMPL(0)=DA
 S DIE="^DIBT(",DR="2///^S X=DT;4///^S X=6920;5///^S X=DUZ;15///^S X=""EQUIPMENT ID# EQUALS ""_ENDA" D ^DIE
 F I=0:0 S I=$O(^ENG(6920,"G",ENDA,I)) Q:I'>0  S ^DIBT(DA,1,I)="" W "."
 I '$D(^DIBT(DA,1)) W !!,"No work orders found.  Nothing to report.",*7,! S DIK="^DIBT(" D ^DIK K DIK G EQHI
 S DIC="^ENG(6914,",DA=ENDA,DIQ="ENEQ",DIQ(0)="E",DR=".01;1;4;5;53"
 D EN^DIQ1 K DA,DIC,DIQ,DR
 S I=0,ENCRIT="" F  S I=$O(^ENG(6914,ENDA,4,I)) Q:'I  D
 . S J=$P($G(^ENG(6914,ENDA,4,I,0)),U,4) I J>ENCRIT S ENCRIT=J
 D DEV^ENLIB G:POP EXIT
 S IOP=ION,L="0",DIC="^ENG(6920,",FLDS=$S($D(^DIPT("B","ENZ EQ HIST")):"[ENZ EQ HIST]",1:"[EN EQ HIST]"),BY="["_ENSTMPL_"]",FR="@"
 I $D(IO("Q")) D  K ZTSK D HOME^%ZIS G EXIT
 . S ZTIO=IOP,ZTRTN="DQHI^ENWO1",ZTDESC="Equipment History from Work Order Module"
 . S ZTSAVE("IOP")="",ZTSAVE("EN*")="",ZTSAVE("DIC")=""
 . S ZTSAVE("FLDS")="",ZTSAVE("BY")="",ZTSAVE("FR")="",ZTSAVE("L")=""
 . D ^%ZTLOAD
 S DIOEND="I IOST[""C-"" R !!,""Press <RETURN> to continue"",X:DTIME"
DQHI ;
 D EN1^DIP
 S DIK="^DIBT(",DA=ENSTMPL(0) D ^DIK K DIK
 G:'$D(ZTQUEUED) EQHI
 G EXIT
DSY ;Screen display work order
 G EDIT^ENWOD
 ;
DEL ; Delete open work order
 W !
 K DA
 S DIC("S")="I $P($G(^(5)),U,2)=""""" D WO^ENWOUTL K DIC
 S DA=+Y G:DA'>0 EXIT
 L +^ENG(6920,DA):5 I '$T W !!,"This work order is being edited by another user and can't be deleted.",$C(7),! G DEL
 S DIR(0)="Y",DIR("A")="Delete work order "_$P($G(^ENG(6920,DA,0)),U)
 D ^DIR K DIR I $D(DIRUT) G EXIT
 I 'Y G DEL
 S DIK="^ENG(6920," D ^DIK K DIK
 W !,"  The work order has been deleted."
 G DEL
 ;
INIT K DIC("S") S DIC="^DIC(6922,",DIC(0)="AEQM" D ^DIC S ENSHKEY=+Y Q
EXIT K %IS,DIC,DIE,DA,Y,DR,N,I,J,K,O,S,X,Y,Z,ENWO
 K ENSTMPL,L,FLDS,BY,FR,TO,ENVANO,IOP,ENDA,ENEQ,ENCRIT
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;ENWO1
