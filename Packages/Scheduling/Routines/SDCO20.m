SDCO20 ;ALB/RMO - Process One Classification - Check Out;30 DEC 1992 1:10 pm
 ;;5.3;Scheduling;**20**;Aug 13, 1993
 ;
ONE(SDCTI,SDATA,SDOE,SDCOQUIT) ;Process One Classification
 ; Input  -- SDCTI    Outpatient Classification Type IEN
 ;           SDATA    Null or 409.42 IEN^Internal Value^1=n/a^1=unedt
 ;           SDOE     Outpatient Encounter file IEN
 ; Output -- SDCOQUIT User entered '^' or timeout
 N SDCT0,SDVAL
 S SDCT0=$G(^SD(409.41,SDCTI,0)) G ONEQ:SDCT0']""
 I SDATA,$P(SDATA,"^",3) D  G ONEQ
 .W !,*7,">>> ",$P(SDCT0,"^",6)," is no longer applicable..."
 .S DA=+SDATA,DIK="^SDD(409.42," D ^DIK
 .W "deleted."
 I SDATA,$P(SDATA,"^",4) D  G ONEQ
 .W !,$P(SDCT0,"^",6),": ",$$VAL^SDCODD(SDCTI,$P(SDATA,"^",2)),"  <Uneditable>"
 S SDVAL=$$VAL(SDCTI,SDCT0,SDATA)
 I SDVAL="^" S SDCOQUIT="" D  G ONEQ
 .I $P(SDCT0,"^",5),$P(SDATA,"^",2)="",$P($G(^SCE(SDOE,0)),"^",7) D COMDT^SDCODEL(SDOE,1)
 D FILE(+SDATA,SDVAL)
ONEQ Q
 ;
VAL(SDCTI,SDCT0,SDATA) ;Get Outpatient Classification
 N DIR,Y
 I SDCTI=3,$P($G(^SCE(+SDOE,0)),"^",10)=2 D  G VALQ
 .S Y=1
 .W !,">>> Updating treatment for SC condition to 'Yes'..."
REASK S DIR("A")=$S($P(SDCT0,"^",2)]"":$P(SDCT0,"^",2),1:$P(SDCT0,"^"))
 I $P(SDATA,"^",2)]""!($P(SDCT0,"^",4)]"") S DIR("B")=$S($P(SDATA,"^",2)]"":$$VAL^SDCODD(SDCTI,$P(SDATA,"^",2)),1:$P(SDCT0,"^",4))
 S DIR(0)=$P(SDCT0,"^",3)_"O"
 I $D(^SD(409.41,SDCTI,2)) S DIR(0)=DIR(0)_"^"_^(2)
 I SDCTI=3 S DIR("?")="^D SC^SDCO23(DFN)"
 D ^DIR
 I $P(SDCT0,"^",5),'$D(DTOUT),$P(SDATA,"^",2)="",Y=""!(Y["^"&('$P($G(^DG(43,1,"SCLR")),"^",24))) D  G REASK
 .W !,*7,"This is a required response." W:Y["^" "  An '^' is not allowed."
 .K DIRUT,DUOUT
 I $D(DIRUT) S Y="^"
VALQ K DIRUT,DTOUT,DUOUT
 Q $G(Y)
 ;
FILE(SDCNI,SDCNV) ;File Outpatient Classification
 ; Input  -- SDCNI    Outpatient Classification IEN
 ;           SDCNV    Outpatient Classification Value
 ; Output -- File Outpatient Classification
 N DA,DIE,DR,X
 I $G(SDCNI)'>0 S SDCNI=$$NEW(SDCTI,SDOE) G FILEQ:SDCNI<0
 S DA=SDCNI,DIE="^SDD(409.42,",DR=".03////^S X=SDCNV" D ^DIE
FILEQ Q
 ;
NEW(SDCTI,SDOE) ;Add a New Outpatient Classification
 ; Input  -- SDCTI    Appointment Outpatient Type file IEN
 ;           SDOE     Outpatient Encounter file IEN
 ; Output -- Outpatient Classification file IEN
 N DA,DD,DIC,DIK,DINUM,DLAYGO,DO,SDCNI,X,Y
 S X=SDCTI,(DIC,DIK)="^SDD(409.42,",DIC(0)="L",DLAYGO=409.42
 D FILE^DICN S SDCNI=+Y
 I SDCNI>0 L +^SDD(409.42,SDCNI) S $P(^SDD(409.42,SDCNI,0),"^",2)=SDOE,DA=SDCNI D IX1^DIK L -^SDD(409.42,SDCNI)
NEWQ Q SDCNI
