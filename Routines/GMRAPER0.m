GMRAPER0 ;HIRMFO/WAA-REACTIONS SELECT ROUTINE ;6/9/05  11:12
 ;;4.0;Adverse Reaction Tracking;**7,21,23**;Mar 29, 1996
EN1 ; ENTRY POINT TO SELECT SIGNS/SYMPTOMS
 K GMRARAD,GMRAROT,GMRARDL,GMRAROTD S GMRAR10(11)=GMRAOTH_"^OTHER SIGN/SYMPTOM"
LIST ; Display Signs/Symptoms
 W #
 I $O(GMRARPR(""))="" W !!,"No signs/symptoms have been specified.  Please add some now."
RELIST D DSPREAC
 ;This is to handle historical events
 I 'GMRAOUT,($O(GMRARPR(""))=""&($P(GMRAPA(0),U,6)="h")) G Q1
 ;This is to handle observed events
 I 'GMRAOUT,($O(GMRARPR(""))=""&($P(GMRAPA(0),U,6)="o")) W !!,$C(7),"SIGNS/SYMPTOMS MUST BE SPECIFIED.  THIS IS A REQUIRED RESPONSE." G RELIST
 G:'GMRAOUT LIST S:GMRAOUT GMRAOUT=2-GMRAOUT
Q1 ; Exit from program
 K %,DIC,GMADATE,GMRACTR,GMRADO,GMRAOK,GMRAPC,GMRAR10,GMRADATE,GMRAREAC,GMRARECN,GMRARPR,GMRAX,GMRAY,GMRARADD,GMRAROTT,X,Y
 Q
DSPREAC ; Display all the patient reactions
 I $O(GMRARPR(""))="" G NOREAC
 W !!,"The following is the list of reported signs/symptoms for this reaction:"
 ; GMRACHC(Y) is the reaction that the user can change
 S GMRAREAC="",GMRACTR=0 K GMRACHC
 F  S GMRAREAC=$O(GMRARPR(GMRAREAC)) Q:GMRAREAC=""  D
 .S GMRARECN=0 F  S GMRARECN=$O(GMRARPR(GMRAREAC,GMRARECN)) Q:GMRARECN'>0  D
 ..S Y=$$CHC,GMRACHC(Y,GMRAREAC,GMRARECN)=""
 ..S:Y GMRACHC(Y)=GMRARECN_U_GMRAREAC
 ..Q
 .Q
 ;v=reaction that this user did not enter
 I $D(GMRACHC(0)) D
 .W !!,"          These reactions were entered by another user:"
 .W !,"     Signs/Symptoms                                  " W:'$G(GMRANDT) "Date Observed"
 .W !,$$REPEAT^XLFSTR("-",75)
 .S X="" F  S X=$O(GMRACHC(0,X)) Q:X=""  S Y=0 F  S Y=$O(GMRACHC(0,X,Y)) Q:Y<1  D
 ..S GMRARECN=Y
 ..S GMRAREAC=X
 ..D:$G(GMRAPRP(GMRAREAC,GMRARECN))="" PRTREAC
 ..Q
 .W !
 .Q
 ;v===Reaction that this user entered
 S X=0 F  S X=$O(GMRACHC(X)) Q:X<1  D
 .S GMRARECN=$P(GMRACHC(X),U)
 .S GMRAREAC=$P(GMRACHC(X),U,2)
 .D:$G(GMRAPRP(GMRAREAC,GMRARECN))="" PRTREAC
 .Q
MANIL ;
 W !!,"Select Action (A)DD",$S(GMRACTR>0:", (D)ELETE ",1:" "),"OR <RET>: " R X:DTIME S:'$T X="^^" I "^^"[X S GMRAOUT=2-(X'="") Q
 S:X?1L X=$C($A(X)-32)
 I '(X="A"!(X="D")) W !?4,$C(7),"ENTER AN A TO ADD SIGNS/SYMPTOMS TO THIS LIST," W:GMRACTR !?10,"OR D TO DELETE SIGNS/SYMPTOMS FROM THIS LIST," W !?10,"OR <RET> TO ACCEPT THIS LIST OF SIGNS/SYMPTOMS." G MANIL
 I X="D" D DELREAC^GMRAPER1 Q
NOREAC D ADREAC
 Q:'$D(GMRARPR)
 ;v---Ask the date then loop through the RPR array and put the date in 3
 Q:GMRAOUT
 S GMRAASK=0
 S GMADATE=$G(GMADATE)
 I GMADATE="",$G(GMRAODT)>0 S GMADATE=GMRAODT
 I '$G(GMRANDT) D DATE(.GMADATE,.GMRAASK) Q:GMRAOUT  D
 .N GMRAX
 .;Add the data to the new reaction unless it has a date
 .;Reaction from the reaction file 120.8
 .S GMRAX=0 F  S GMRAX=$O(GMRARAD(GMRAX)) Q:GMRAX<1  D
 ..I $P(GMRARAD(GMRAX),U,2)'=""!($D(GMRARADD("DONE",GMRAX))) Q  ;Date had been added to this reaction or reaction has already been processed.  Allows null entry
 ..S $P(GMRARAD(GMRAX),U,2)=GMADATE,GMRARADD("DONE",GMRAX)="" ;keeps track of entries edited so null dates aren't over written during same session
 ..S $P(GMRARPR($P(GMRARAD(GMRAX),U),GMRAX),U,3)=GMADATE
 ..Q
 .;Other Reaction
 .S GMRAX="" F  S GMRAX=$O(GMRAROT(GMRAX)) Q:GMRAX=""  D
 ..I $P(GMRAROT(GMRAX),U,2)'=""!($D(GMRAROTT("DONE",GMRAX))) Q  ;Date had been added to this reaction or sign has already been processed.
 ..S $P(GMRAROT(GMRAX),U,2)=GMADATE,GMRAROTT("DONE",GMRAX)="" ;entries processed will not be overwritten by other sign/symptoms during same editing session
 ..S $P(GMRARPR($P(GMRAROT(GMRAX),U),GMRAOTH),U,3)=GMADATE
 .Q
 K GMADATE ;Delete date associated with this sign/symptom
 Q
ADREAC ;This is the site parameter's top ten most common signs/symptoms
 I $G(ERR) W !!,"One or more entries you selected were inactive.  Please use option 11",!,"to find a similar term to replace the inactive sign/symptom you selected." K ERR ;23
 W !!,"The following are the top ten most common signs/symptoms:"
 F GMRAREAC=1:1:5 W !,$J(GMRAREAC,2),".",?4,$P(GMRAR10(GMRAREAC),U,2),?35,$J(GMRAREAC+6,2),".",?39,$P(GMRAR10(GMRAREAC+6),U,2)
 W !?1,"6.",?4,$P(GMRAR10(6),U,2)
RRD ;
 K DIR S DIR(0)="LOA^1:11"
 S DIR(0)=DIR(0)_"^I X[""."" W !,""DO NOT USE DECIMAL VALUES."",$C(7) K X Q"
 S DIR("A")="Enter from the list above :  "
 S DIR("?",1)="PLEASE ENTER THE NUMBERS OF THE SIGNS/SYMPTOMS YOU WOULD LIKE TO ADD."
 S DIR("?",2)="RANGES CAN BE SEPARATED BY A HYPHEN (-) AND GROUPS OF NUMBERS,"
 S DIR("?")="SEPARATED BY A COMMA (,)."
 D ^DIR K DIR
 S:$D(DTOUT) GMRAOUT=1
 S:$D(DUOUT) GMRAOUT=1
 Q:GMRAOUT!(Y="")
 S GMRADO=Y K Y,GMRAY
 S GMRAASK=0
 F Y=1:1:$L(GMRADO,",") S GMRAY=$P(GMRADO,",",Y) I +GMRAY D
 .I +GMRAY=11 D ADD Q  ;23 Handle request for "other" separately
 .I $L($T(SCREEN^XTID)) I $$SCREEN^XTID(120.83,.01,$P(GMRAR10(+GMRAY),U)_",") W !!,$P(GMRAR10(+GMRAY),U,2)," is inactive and may not be used." S ERR=1 Q  ;23
 .D ADD ;23
 I $G(ERR) G ADREAC ;23
 Q
CHC() ; Check reaction to see if user can see and edit this reaction
 I $P(GMRARPR(GMRAREAC,GMRARECN),U,2)=DUZ!'$L($P(GMRARPR(GMRAREAC,GMRARECN),U,2)),'$P(GMRAPA(0),U,12)!$D(^XUSEC("GMRA-ALLERGY VERIFY",DUZ)) S GMRACTR=GMRACTR+1 Q GMRACTR
 Q 0
PRTREAC ;
 N GMRAPDAT
 I X=1 D
 .W !!,"     Signs/Symptoms                                  " W:'$G(GMRANDT) "Date Observed"
 .W !,$$REPEAT^XLFSTR("-",75)
 .Q
 W !?1,$S(X:$J(X,2),1:""),?5,$E($P(GMRARPR(GMRAREAC,GMRARECN),U),1,45)
 S GMRAPDAT=$S($P(GMRARPR(GMRAREAC,GMRARECN),U,3)'="":$P(GMRARPR(GMRAREAC,GMRARECN),U,3),$G(GMRADATE)>0:GMADATE,1:"")
 I '$G(GMRANDT) W ?53 W:GMRAPDAT'="" $$FMTE^XLFDT(GMRAPDAT,1)
 Q
ADD ;
 N Y
 I GMRAY=11 D  Q
 .F  D  Q:+Y<0
 ..S DIC=120.83,DIC(0)="AEMQ",DIC("S")="I $P(^(0),U)'=""OTHER REACTION"",$S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(120.83,.01,Y_"",""),1:1)" D ^DIC
 ..I +Y>0 D SETT
 S Y=GMRAR10(GMRAY) D SETT
 Q
SETT ;
 Q:'$L(Y)
 S GMRAREAC=$P(Y,U,2),GMRARECN=$P(Y,U) K GMRARDL(GMRARECN)
 S:'$D(GMRARPR(GMRAREAC,GMRARECN)) GMRARAD(GMRARECN)=GMRAREAC,GMRARPR(GMRAREAC,GMRARECN)=GMRAREAC
 Q
STRIN ;This will handle a string input
 W !!,"Enter OTHER SIGN/SYMPTOM: " R X:DTIME S:'$T X="^^" I "^^"[X S:X="^^"!(X=U) GMRAOUT=1 Q
 S DIC="^GMRD(120.83,",DIC("S")="I $P(^(0),U)'=""OTHER REACTION"",$S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(120.83,.01,Y_"",""),1:1)",DIC(0)="EM",D="B^D",GMRAREAC=X K DTOUT,DUOUT D MIX^DIC1 K DIC G:X?1"?".E STRIN ;21,23
 I +Y'>0 S:$D(DTOUT)!$D(DUOUT) GMRAOUT=1 Q:GMRAOUT  D ADDG Q:GMRAOUT  G STRIN:%=2,ASKAN
YNOK W !,$P(Y,U,2)_" OK " S %=1 D YN^DICN I '% W !?4,$C(7),"ANSWER YES IF THE DATA ABOVE IS CORRECT, ELSE ANSWER NO." G YNOK
 I %=-1 S GMRAOUT=1 Q
 I %=2 S X=GMRAREAC G STRIN:X=$P(Y,U,2) D ADDG Q:GMRAOUT  G STRIN:%=2,ASKAN
 D SETT
ASKAN ;
 W !,"Would you like to add another sign/symptom" S %=2 D YN^DICN I '% W !?4,$C(7),"ANSWER YES TO ADD ANOTHER SIGN/SYMPTOM, ELSE ANSWER NO." G ASKAN
 S:%=-1 GMRAOUT=1 Q:%=2!GMRAOUT
 G STRIN
 Q
ADDG ;
 I $L(X)<3!($L(X)>30) W " ??",$C(7) S %=2 Q
 W !,X," is not in the Sign/Symptoms file." S %=2 D:$L($T(NTRTMSG^HDISVAP)) NTRTMSG^HDISVAP() Q  ;
 S:%=-1 GMRAOUT=1
 I %=1 N % I 'GMRAOUT S:'$D(GMRARPR(X,GMRAOTH)) GMRAROT(X)=X,GMRARPR(X,GMRAOTH)=X K GMRAROTD(X)
 Q
DATE(DATE,ASK) ; Enter the date for a reaction
 Q:ASK
 N %DT,X,Y
 S DATE=$G(DATE,""),%DT="AEPT",%DT("A")="Date(Time Optional) of appearance of Sign/Symptom(s): "
 S:$P(GMRAPA(0),U,6)="o" %DT("B")=$S(DATE="":"NOW",1:$$FMTE^XLFDT(DATE,1))
 S %DT(0)="-NOW" D ^%DT  I "^^"[X S GMRAOUT=$L(X) Q
 S DATE=Y,ASK=1
 Q
