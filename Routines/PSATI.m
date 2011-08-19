PSATI ;BIR/LTL-Single Drug Match ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**8,18,23,21**; 10/24/97
 ;This routine enters/edits links with the ITEM MASTER file.
 ;
 ;References to $$DESCR^PRCPUX1 are covered by IA #259
 ;References to $$VENNAME^PRCPUX1 are covered by IA #259
 ;References to ^PRC( are covered by IA #214
 ;References to ^PSDRUG( are covered by IA #2095
 ;
 N PSAIT,DTOUT,DUOUT,DIE,D0,D1,DA,DIC,DIR,DLAYGO,DR,DIRUT
START D DT^DICRW
 ;For call by ^PSAENT & ^PSAUNL 
 I $G(PSAIT) S DIC(0)="Q",X=PSAIT W !!,$P($G(^PSDRUG(+PSAIT,0)),U),!!
 ;LOOK UP DRUG
LOOK S:'$D(DIC(0)) DIC(0)="AEMQ" S DIC=50,DIC("S")="I $S('$D(^(""I"")):1,+^(""I"")>DT:1,1:0)" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<0) QUIT S (PSADRUG,PSAIT)=$P(Y,U)
DIS I $O(^PSDRUG(+PSADRUG,441,0)) W !,"This drug is currently linked to the following item(s):",!!  S PSAIM=0 F  S PSAIM=$O(^PSDRUG(PSADRUG,441,PSAIM)) Q:PSAIM="B"  S PSAI=$P(^PSDRUG(PSADRUG,441,PSAIM,0),U) D:$$DESCR^PRCPUX1(0,PSAI)]""
 .W !,PSAI_"  "_$$DESCR^PRCPUX1(0,PSAI)_"  ",$$VENNAME^PRCPUX1($P($G(^PRC(441,+PSAI,0)),U,4)_"PRC(440"),!
QUES1 I $D(PSAI) S DIR(0)="Y",DIR("A")="Would you like to alter the link(s)",DIR("B")="No" D ^DIR K DIR G:Y<1&('$D(PSALOC)) AGAIN G:Y<1 QUIT
 W !!,"Current potential ITEM MASTER file links based on NDC or FSN are:",!!
 ;Attempt match by NDC between #50/#441
NDC I $P($G(^PSDRUG(PSADRUG,2)),U,4)]"" S PSANDC=$P(^(2),U,4),PSAI=$$ITEM^PSAUTL(PSANDC) W "DRUG file NDC:  "_PSANDC
 I $D(PSAI),$D(PSANDC),PSAI W ?40,"ITEM NUMBER:  "_PSAI,!!,"DESC:  "_$$DESCR^PRCPUX1(0,PSAI),! W:$G(^PRC(441,+PSAI,3)) !?60,"* Inactive item" D:$O(^PRC(441,"F",PSANDC,PSAI))
MORE .S PSAZ=1,PSAI(PSAZ)=PSAI F  S PSAI(PSAZ)=$O(^PRC(441,"F",PSANDC,PSAI(PSAZ))) Q:PSAI(PSAZ)=""  W !?40,"ITEM NUMBER:  "_PSAI(PSAZ),!!,"DESC:  ",$$DESCR^PRCPUX1(0,PSAI(PSAZ)) W:$G(^PRC(441,+PSAI(PSAZ),3)) !?60,"* Inactive item"
 ;Attempt match between FSN (#50) and NSN (#441)
FSN I '$G(PSAI),$P(^PSDRUG(PSADRUG,0),U,6)]"" S PSAFSN=$P(^(0),U,6) D:$D(^PRC(441,"BB",PSAFSN))
 .S PSAI=$O(^PRC(441,"BB",PSAFSN,"")) W "  NO NDC MATCH IN ITEM MASTER file.",!!,"DRUG file FSN:  "_PSAFSN,?40,"ITEM NUMBER:  "_PSAI,!!,"DESC:  ",$$DESCR^PRCPUX1(0,PSAI),!
FAIL S:'$D(PSAI) PSAI="" W:PSAI']"" !!,"No NDC or FSN match in the ITEM MASTER file.",!
 ;S:'$D(^PSDRUG(+PSADRUG,441,0)) ^(0)="^50.0441P^^" ;Removed by SQA recommendation (PSA*3*18)
CON S DIE="^PSDRUG(",DA=PSADRUG,DR="441//^S X=$G(PSAI)" D ^DIE K DIE I $D(Y)!($D(DTOUT)) S DIRUT=1 G QUIT
 I '$D(^PSDRUG(PSADRUG,"ND")) W !!,"No NDF link, can't help.",!  G AGAIN
 I $P(^PSDRUG(PSADRUG,"ND"),U)']"" W !!,"No NDF link, can't help.",!  K DUOUT G AGAIN
 ;Check for package size or type = OTHER
 I $P($G(^PSDRUG(+PSADRUG,"ND")),U,4)=2058 W !!,"No matching PACKAGE SIZE in the National Drug File." G AGAIN
 I $P($G(^PSDRUG(+PSADRUG,"ND")),U,5)=623 W !!,"No matching PACKAGE TYPE in the National Drug file." G AGAIN
NDF ;Offer NDF path
 W !!,"This drug is linked to the NATIONAL DRUG file.",!!,"There may be an NDC there that will link to the ITEM MASTER file.",!
 S DIR(0)="Y",DIR("A")="Would you like to check",DIR("B")="No" D ^DIR K DIR G:$D(DIRUT)!(Y<1) AGAIN
 ;
 ;DAVE B (PSA*3*18) Old NDF globals no longer used.
 S PSAVP=$P($G(^PSDRUG(PSADRUG,"ND")),"^",3) I $G(PSAVP)="" W !,"Sorry, there is no entry in the PSNDF VA PRODUCT NAME, cannot find match.",! G AGAIN
 ;Call PSNAPIS
 S X=$$CIRN2^PSNAPIS("",PSAVP,.PSANDF)
 S PSX="" F  S PSX=$O(PSANDF(PSX)) Q:PSX=""  K PSA D  Q:Y<1  D BINGO
 .I PSX'["-" S PSAOLD=$G(PSANDC),PSANDC=PSX D PSANDC1^PSAHELP S PSA=PSANDCX K PSANDCX I $G(PSAOLD)'="" S PSANDC=PSAOLD K PSAOLD
 .I $G(PSA)="" S PSA=PSX
 .W !,"Going to check NDC #"_PSA,! S DIR(0)="Y",DIR("A")="OK",DIR("B")="No" D ^DIR K DIR Q:$D(DIRUT)!(Y<1)
AGAIN K PSA,PSAD,PSADO,PSADRUG,PSAF,PSAFSN,PSANDC,PSANDF,PSAI,PSAIM,PSAIQ,PSAIQT,PSAIAC,PSAILC,PSAINV,PSAINVN,PSAP,PSAPB,PSAS,PSAT,PSATB,PSAU,PSAV,PSAZ,X,Y
 Q:$D(PSAS)!($D(PSALOC))  W ! S DIR(0)="Y",DIR("A")="Another drug",DIR("B")="Yes" D ^DIR K DIR I Y>0 K PSAIT,PSAI G START
QUIT N:'$G(PSAIT(1)) PSAIT,Y K PSA,PSAI,PSAD,PSADO,PSADRUG,PSAF,PSAFSN,PSANDC,PSANDF,PSAI,PSAIM,PSAIQ,PSAIQT,PSAIAC,PSAILC,PSAINV,PSAINVN,PSAP,PSAPB,PSAS,PSAT,PSATB,PSAU,PSAV,PSAZ,X,Y Q
BINGO S PSAI=$O(^PRC(441,"F",PSA,""))
 Q:$O(^PSDRUG("AB",+PSAI,0))
 W !!,"DRUG file:  "_$P(^PSDRUG(PSADRUG,0),U),!!,"Item #:  "_PSAI,"  Desc:  ",$$DESCR^PRCPUX1(0,PSAI),! D
 .S DIR(0)="Y",DIR("A")="OK to link",DIR("B")="Yes",DIR("?")="If yes, I'll perform the link" D ^DIR K DIR K:(Y=0) Y Q:($G(Y)<1)
 .S DIE=50,DA=PSADRUG,DR="441///^S X=""`""_PSAI" D ^DIE W " linked."
 Q
