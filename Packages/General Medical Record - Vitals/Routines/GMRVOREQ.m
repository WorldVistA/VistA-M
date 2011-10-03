GMRVOREQ ;HIRMFO/MD,FT-QUICK ORDER PROTOCOL CREATION ;11/11/96  11:02
 ;;4.0;Vitals/Measurements;**2**;Apr 25, 1997
EN1 ; ENTRY TO CREATE QUICK ORDER PROTOCOL
 S GMRVDEF="",GMRVOLD=0,DIC=101,DIC(0)="AEQS",D="C"
 S DIC("S")="S GMRV=$P(^(0),U) I ""^GMRVORCG^GMRVORPO^GMRVORCVP^GMRVORTPR^GMRVORTPR B/P^GMRVORADMIT V/M^GMRVORPULSE^GMRVORB/P^GMRVORWT^GMRVORTEMP^GMRVORRESP^GMRVORHT^GMRVORPR B/P^GMRVORPB/P^""[(""^""_GMRV_""^"")!(GMRV[""GMRVORQ"")"
 S DIC("A")="Select PROTOCOL to be added as a QUICK PROTOCOL: " D IX^DIC G QUIT:+Y'>0 S GMRVDA=+Y K GMRVPROT
 I $S($D(^ORD(101,+Y,0))&($P(^(0),U)["GMRVORQ"):1,1:0) S GMRVOLD=1,GMRVDEF=$P(^(20),"""",2) G DEF
ASK S X=$P($G(^ORD(101,+Y,0)),"^",2) W !!,$C(7),"DO YOU WANT TO ADD "_X_" AS A QUICK ORDER PROTOCOL" S %=1 D YN^DICN W:'% !?4,"ANSWER YES OR NO." G ASK:'%,EN1:%=2,QUIT:%=-1
 S %X="^ORD(101,"_+GMRVDA_",",%Y="GMRVPROT(" D %XY^%RCR
LOCK L +^GMRD(120.57,1,"Q0"):1
YNWAIT I '$T W !,$C(7),"SOMEONE ELSE IS ADDING QUICK ORDER PROTOCOLS,","WOULD YOU LIKE TO WAIT UNTIL THEY FINISH" S %=1 D YN^DICN W:'% !?4,"ANSWER YES OR NO." G YNWAIT:'%,LOCK:%=1,QUIT
 S GMRVPNUM=+$P($G(^GMRD(120.57,1,"Q0")),"^") F GMRVPNUM=GMRVPNUM:1 S GMRVPNAM="GMRVORQ"_GMRVPNUM Q:'$O(^ORD(101,"B",GMRVPNAM))
DEF D SETUP I GMROUT L -^GMRD(120.57,1,"Q0") G QUIT
 D:GMRVOLD=0 ADDNEW ;add a new entry to file 101
 D:GMRVOLD=1 UPDATE ;update an existing entry in file 101
 L -^GMRD(120.57,1,"Q0")
QUIT ;
 K %,%DT,%X,%Y,D,DA,DIC,DIE,DIK,DIR,DLAYGO,DR,DUOUT,GMROUT,GMRV,GMRVANSR,GMRVAS,GMRVDA,GMRVDEF,GMRVDEL,GMRVDF,GMRVOAS,GMRVOLD,GMRVORD,GMRVPNAM,GMRVPNUM,GMRVPROT,GMRVQUES,GMRVSTRT,GMRVX,GMRVY,OREA,ORTX,TEXT,X,Y,Z,ZX,ZY
 D ^%ZISC
 Q
SETUP ; ASK USERS WHETHER TO ASK QUESTION OR STUFF ANSWER
 ;
 ;    GMRVANSR=START^STOP^SCHEDULE^SPECIAL INSTRUCTIONS
 ;          WHERE "" MEANS ASK NO DEFAULT
 ;                VALUE MEANS ASK WITH DEFAULT OF VALUE
 ;                ~VALUE MEANS NO ASK STUFF VALUE
 ;
 W !!,"These are the Vital Measurement Quick Order Questions:",! F Y=1:1:4 W !,?3,Y_". ",$P($T(TEXT+Y),";",3)
 I GMRVOLD=1 S GMRVANSR=GMRVDEF
 S (GMRVDEL,GMROUT)=0,DIR("A")="Select the question(s) that require special action",DIR(0)="L^1:4",DIR("?")="Enter question selection(s)" D ^DIR I $D(DIRUT) S GMROUT=1 Q
 I GMRVOLD=0,Y'[3 W !!,$C(7),"An Admin. Schedule is required for Vital Measurement Quick Order Protocols!" G SETUP
 S GMRVX=0,(GMRVSTRT,GMRVY)="" K GMRVLIST
 F Z=1:1 Q:$P(Y,",",Z)=""  S GMRVLIST($P(Y,",",Z))=""
 S (GMRVCNT,Z)=0
 F  S Z=$O(GMRVLIST(Z)) Q:Z'>0  S GMRVCNT=GMRVCNT+1,$P(GMRVY,",",GMRVCNT)=Z
 K GMRVCNT,GMRVLIST
 F Z(0)=1:1 S Z=$P(GMRVY,",",Z(0)) Q:Z'>0  D ASKDEF Q:GMROUT  X $P($T(TEXT+Z),";",4) I $D(X),'+GMRVDEL S $P(GMRVANSR,"^",Z)=$S(+GMRVDEL:"",GMRVX=1:X,GMRVX=2:"~"_X,1:"") S:Z=1 GMRVSTRT=Y K GMRVX
 I 'GMROUT S OREA="S GMRVANSR="""_GMRVANSR_""",GMRVKWIK=1 D DATE^GMRVOREQ Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  D EN1^GMRVORE0"
 Q
DATE ; MAKE SURE THE DEFAULT ANSWERS ARE FM DATES
 ;
 I $P(GMRVANSR,U)'="" S Z=$P(GMRVANSR,U),X=$S(Z?1"~".E:$P(Z,"~",2,999),1:Z),%DT="T" D ^%DT S $P(GMRVANSR,U)=$E("~",Z["~")_Y
 I $P(GMRVANSR,U,2)'="" S Z=$P(GMRVANSR,U,2),X=$S(Z?1"~".E:$P(Z,"~",2,999),1:Z),%DT="T" D ^%DT S $P(GMRVANSR,U,2)=$E("~",Z["~")_Y
 Q
SCH ;ADD SCHEDULE
 S GMRVANSR=$S($D(GMRVANSR):GMRVANSR,1:""),ZY=$P(GMRVDEF,U,3),GMRVAS=$S(ZY'="":$P(ZY,"~",ZY["~"+1),1:$P(GMRVANSR,U,3)) D ADS^GMRVORC0
 Q
ASKDEF ;
 S GMRVQUES=$P($T(TEXT+Z),";",3) W !,"Choose one of the following:",!?5,"1. Ask "_GMRVQUES_"with a DEFAULT value",!,?5,"2. Automatically Enter "_GMRVQUES
 W !,"Select 1 or 2: " R GMRVX:DTIME I "^"[GMRVX S GMROUT=1 Q
ASK1 I GMRVX'=1&(GMRVX'=2) W !!?5,$C(7),"Enter '1' to ask question with default value.",!?11,"'2' to not ask the question and automatically enter the default.",! G ASKDEF
 I '(Z=3) S ZX=$P(GMRVDEF,U,Z) W !,"Enter default value: "_$S(ZX'="":$P(ZX,"~",ZX["~"+1)_"// ",1:"") R X:DTIME I '(Z>2),X["?" S %DT="ET",%DT(0)=$S(Z=1:"N",1:$P(GMRVSTRT,"~",GMRVSTRT["~"+1)) D HELP^%DTC
 G:X["?" ASK1 I X="^"!(X=""&($G(ZX)="")) S GMROUT=1
 I X="" S X=$P(ZX,"~",ZX["~"+1)
 I X="@" S GMRVDEL=1
 Q
TEXT ;
 ;;START/Date ;Q:X="@"  S %DT="ET",%DT(0)=DT D ^%DT I Y<1 K X D HELP^%DTC S Z(0)=Z(0)-1
 ;;STOP/Date ;Q:X="@"  S %DT="ET",%DT(0)=$P(GMRVSTRT,"~",GMRVSTRT["~"+1) K:'$L(%DT(0)) %DT(0) D ^%DT I Y<1 K X D HELP^%DTC S Z(0)=Z(0)-1
 ;;Administrative Schedule ;D SCH
 ;;Special Instructions ;Q:X="@"  I $L(X)<3!($L(X)>100) K X W *7,!,"Answer must be 3-100 characters in length" S Z(0)=Z(0)-1
 Q
 ;
UPDATE ; update existing entry
 S GMRVOAS=$P(^ORD(101,+GMRVDA,20),""",GMRVKWIK") ;get old Admin Schedule
 S GMRVOAS=$P(GMRVOAS,"^",3) S:GMRVOAS["~" GMRVOAS=$P(GMRVOAS,"~",2)
 S GMRVAS=$S($E($P(GMRVANSR,"^",3))="~":$E($P(GMRVANSR,"^",3),2,99),1:$P(GMRVANSR,"^",3)) ;get new Admin Schedule
 I GMRVAS]"",GMRVOAS'=GMRVAS W !!,"You changed the Administration Schedule to ",GMRVAS,!,"You should edit the ITEM TEXT.",!
IT0 ; item text
 K DIR S DIR(0)="101,1",(GMRVDIRB,DIR("B"))=$P(^ORD(101,+GMRVDA,0),U,2)
 D ^DIR
 Q:$D(DIRUT)
 I GMRVDIRB'=Y,$D(^ORD(101,"C",Y)) W !!,$C(7),"A Quick Order Protocol with an ITEM TEXT of ",!,Y," already exists.",!,"Please edit the ITEM TEXT value to make it unique.",!! G IT0
 S GMRVPROT("QUICK TEXT")=Y
 S DIE="^ORD(101,",DA=+GMRVDA,DR="1///"_GMRVPROT("QUICK TEXT")_";20////^S X=OREA" D ^DIE ;stuff item text and entry action
 Q
ADDNEW ; add new entry
 S GMRVPROT("QUICK TEXT")="QUICK "_$S($E($P(GMRVANSR,"^",3))="~":$E($P(GMRVANSR,"^",3),2,99),1:$P(GMRVANSR,"^",3))_" "_$S($P($G(GMRVPROT(0)),"^",2)'="":$P(GMRVPROT(0),"^",2),1:"")
 K DIR S DIR(0)="101,1",DIR("B")=GMRVPROT("QUICK TEXT") D ^DIR
 Q:$D(DIRUT)
 S GMRVPROT("QUICK TEXT")=Y
 I $D(^ORD(101,"C",GMRVPROT("QUICK TEXT"))) W !!,$C(7),"A Quick Order Protocol with an ITEM TEXT of ",!,GMRVPROT("QUICK TEXT")," already exists.",!,"Please edit the ITEM TEXT value to make it unique.",!! G ADDNEW
 S $P(GMRVPROT(0),"^",1,2)=GMRVPNAM_"^"_GMRVPROT("QUICK TEXT"),$P(GMRVPROT(0),"^",5)=DUZ,GMRVPROT(20)=OREA,$P(GMRVPROT(99),"^")=$H
 S DLAYGO=101,X=GMRVPNAM,DIC="^ORD(101,",DIC(0)="LQ" K DD D FILE^DICN G QUIT:+Y'>0 S %Y="^ORD(101,"_+Y_",",%X="GMRVPROT(" D %XY^%RCR S DA=+Y,DIK="^ORD(101," D IX1^DIK
 S $P(^GMRD(120.57,1,"Q0"),"^")=GMRVPNUM+1
 Q
