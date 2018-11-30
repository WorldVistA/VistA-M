PSOHELP ;BHAM ISC/SAB-outpatient utility routine ; 10/17/07 7:41am
 ;;7.0;OUTPATIENT PHARMACY;**3,23,29,48,46,117,131,222,268,206,276,282,444**;DEC 1997;Build 34
 ;External reference ^PS(51 supported by DBIA 2224
 ;External reference ^PSDRUG( supported by DBIA 221
 ;External reference ^PS(56 supported by DBIA 2229
 ;External reference ^PSNPPIP supported by DBIA 2261
 ;
XREF D XREF^PSOHELP3
 Q
SIG ;checks PI for RXs
 K VALMSG
 I $E(X)=" " D EN^DDIOL("Leading spaces should not entered in the Patient Instructions! ","","$C(7),!") S VALMSG="There are leading spaces in Patient Instructions!"
SIGONE K INS1 Q:$L(X)<1  F Z0=1:1:$L(X," ") G:Z0="" EN S Z1=$P(X," ",Z0) D  G:'$D(X) EN
 .I $L(Z1)>32 W $C(7),!?5,"MAX OF 32 CHARACTERS ALLOWED BETWEEN SPACES.",! K X Q
 .D:$D(X)&($G(Z1)]"")  S INS1=$G(INS1)_" "_Z1
 ..S Z1=$$UPPER^PSOSIG(Z1) ;*282 Provider Comments
 ..S Y=$O(^PS(51,"B",Z1,0)) Q:'Y!($P($G(^PS(51,+Y,0)),"^",4)>1)  S Z1=$P(^PS(51,Y,0),"^",2)
 ..I $G(^PS(51,+Y,9))]"" S Y=$P(X," ",Z0-1),Y=$E(Y,$L(Y)) S:Y>1 Z1=^(9)
EN K Z1,Z0
 Q
SSIG ;other lang. mods
 K VALMSG
 I $E(X)=" " D EN^DDIOL("Leading spaces should not entered in the Patient Instructions! ","","$C(7),!") S VALMSG="There are leading spaces in Patient Instructions!"
 K SINS1 Q:$L(X)<1  F Z0=1:1:$L(X," ") G:Z0="" EX S Z1=$P(X," ",Z0) D  G:'$D(X) EX
 .I $L(Z1)>32 W $C(7),!?5,"MAX OF 32 CHARACTERS ALLOWED BETWEEN SPACES.",! K X Q
 .D:$D(X)&($G(Z1)]"")  S SINS1=$G(SINS1)_" "_Z1
 ..S Z1=$$UPPER^PSOSIG(Z1) ;*282 Provider Comments
 ..S Y=$O(^PS(51,"B",Z1,0)) Q:'Y!($P($G(^PS(51,+Y,0)),"^",4)>1)  S Z1=$P(^PS(51,Y,0),"^",2)
 ..I $G(^PS(51,+Y,4))]"" S Z1=^PS(51,+Y,4) ;,Y=$P(X," ",Z0-1),Y=$E(Y,$L(Y)) S:Y>1 Z1=^(9)
EX K Z1,Z0
 Q
QTY ;Check quantity dispensed against inventory
 Q:'$G(PSODRUG("IEN"))
 S Z0=$S($G(PSODRUG("IEN"))]"":PSODRUG("IEN"),$G(PSXYES):$P(^PSRX(ZRX,0),"^",6),$D(^PSRX(DA,0)):+$P(^(0),"^",6),1:0)
 I $D(^PSDRUG("AQ",Z0)),(+X'=X) K X,Z0 Q
 S Z1=$S($D(^PSDRUG(Z0,660.1)):^(660.1),1:0)+(+X) D:X>Z1 EN^DDIOL("  Greater Than Current Inventory!","","$C(7)") K Z1
 S ZX=X,ZZ0=$G(D0),D0=Z0
 S Y(18,2)=$S($D(^PSDRUG(D0,660)):^(660),1:""),Y(18,1)=$S($D(^(660.1)):^(660.1),1:"")
 S X=$P(Y(18,1),"^",1),X=$S($P(Y(18,2),"^",5):X/$P(Y(18,2),"^",5),1:"*******")
 S X=$J(X,0,2)
 D:X<$S($D(^PSDRUG(Z0,660)):+^(660),1:1) EN^DDIOL("  Below Reorder Level.","","$C(7)") S X=ZX,D0=$G(ZZ0) K ZZ0,Z0,ZX
 Q
HELP ;qty help
 G:$G(PSOFDR) HLP
 S Z0=$S($G(PSODRUG("IEN"))]"":PSODRUG("IEN"),$G(PSXYES):$P(^PSRX(ZRX,0),"^",6),$D(^PSRX(DA,0)):$P(^PSRX(DA,0),"^",6),1:0)
HLP S Z0=+$G(PSODRUG("IEN"))  I $D(^PSDRUG("AQ",Z0)) D EN^DDIOL("This is a CMOP drug. The quantity may not contain alpha characters (i.e.; ML)","","!!") D EN^DDIOL("or more than two fractional decimal places (i.e.; .01).","","!") D  K Z0 Q
 .D EN^DDIOL("Enter a number between 0 and 99999999 inclusive. The total entry cannot","","!") D EN^DDIOL("exceed 11 characters.","","!")
 D EN^DDIOL("Enter a whole number between 0 and 99999999 inclusive.  Alpha characters are","","!!")
 D EN^DDIOL("not allowed, and the entry cannot exceed 11 characters, or contain more than","","!") D EN^DDIOL("two fractional decimal places (i.e.; .01).","","!")
 K Z0
 Q
ADD ;add/edited local drug/drug interactions
 W ! S DIC("A")="Select Drug Interaction: ",DIC(0)="AEMQL",DLAYGO=56
 S (DIC,DIE)="^PS(56,",DIC("S")="I '$P(^(0),""^"",5)" D ^DIC G:"^"[X QU G:Y<0 ADD S DA=+Y,DR="[PSO INTERACT]" L +^PS(56,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W !,"Entry is being edited by another user. Try Later!",! G ADD
 D ^DIE L:$G(DA) -^PS(56,DA) K DA G ADD
QU L -^PS(56,DA) K X,DIC,DIE,DA
 Q
CRI ;change drug interaction severity to critical from significant
 W ! S DIC("A")="Select Drug Interaction: ",DIC(0)="AEQM",(DIC,DIE)="^PS(56,",DIC("S")="I $P(^(0),""^"",4)=2" D ^DIC G:"^"[X QU G:Y<0 CRI S DA=+Y,DR=3
 L +^PS(56,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W !,"Entry is being edited by another user. Try Later!",! G CRI
 D ^DIE L -^PS(56,DA) K DA G CRI
 G QU
 Q
MAX S:$G(EXH) P(7)=$P(^PSRX(DA,0),"^",8),P(5)=$P(^(0),"^",6),P(2)=+$P(^(0),"^",3) S:P(2) PTST=$G(^PS(53,P(2),0)),PTDY=$P($G(^(0)),"^",3),PTRF=$P($G(^(0)),"^",4)
 S PSODEA=$P(^PSDRUG(P(5),0),"^",3),CS=0
 I $D(CLOZPAT) S MAX=$S(CLOZPAT=2&($P(^PSRX(DA,0),"^",8)=14):1,CLOZPAT=2&($P(^PSRX(DA,0),"^",8)=7):3,CLOZPAT=1&($P(^PSRX(DA,0),"^",8)=7):1,1:0),MIN=0 Q
 I PSODEA["A"&(PSODEA'["B")!(PSODEA["F")!(PSODEA[1)!(PSODEA[2) D EN^DDIOL("No refills allowed on "_$S(PSODEA["A":"this narcotic drug.",1:"this drug."),"","!") D EN^DDIOL(" ","","!") S $P(^PSRX(DA,0),"^",9)=0 K X,Y,PSODEA,CS,PTST Q
 ; Retrieving the Maximum Number of Refills allowed
 S MAX=$$MAXNUMRF^PSOUTIL(+$G(P(5)),+$G(P(7)),+$G(P(2)),.CLOZPAT)
 I $D(X) S MIN=0 I $D(DA) F REF=0:0 S REF=$O(^PSRX(DA,1,REF)) Q:'REF  I $D(^(REF,0)) S MIN=MIN+1
 I $G(EXH) D EN^DDIOL("Enter a number Between "_MIN_" AND "_MAX_".","","!?10") K P(2),P(5),P(7),MAX,MAX1,MIN,REF
 Q
 ;
REF S PSRF=X,P(7)=$P(^PSRX(DA,0),"^",8),P(5)=$P(^(0),"^",6),P(2)=+$P(^(0),"^",3) S:P(2) PTST=$G(^PS(53,P(2),0)) S PTDY=$P(^(0),"^",3),PTRF=$P(^(0),"^",4)
 D MAX Q:'$D(X)  I (+X'=X)!(X<0)!(X>MAX)!(X?.E1"."1N.N) D EN^DDIOL(" ** MAX REFILLS ALLOWED ARE "_MAX_" ** ","","$C(7)") K X
 I $D(X),X<MIN D EN^DDIOL(" ** PATIENT HAS ALREADY RECEIVED "_MIN_" REFILLS ** ","","$C(7)") K X
 D DAYS^PSOUTLA
 K PTDY,PTRF,MAX,DAYS,PSDAYS,PSODEA,PSOX,PSOX1,PSDY,PSDY1,DEA,CS,PTST,PSRF,MIN,REF,P(2),P(7),P(5),MAX1
 Q
PAT ;patient field screen in file 52
 N DIC,DIE S DFN=X D INP^VADPT,DEM^VADPT
 I $P(VADM(6),"^") D EN^DDIOL("PATIENT DIED "_$P(VADM(6),"^",2),"","$C(7),!?10") D EN^DDIOL(" ","","!") K X,DFN Q
 I $P(VAIN(4),"^") D EN^DDIOL("PATIENT IS AN INPATIENT ON WARD "_$P(VAIN(4),"^",2)_" !!","","$C(7),!?10") K DIR D DIR K VA,VADN,VAIN Q
 E  S X=DFN K DFN,DIRUT,DTOUT,DUOUT
 Q
DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="DO YOU WISH TO CONTINUE" D ^DIR K DIR
 K:'Y X S:Y X=DFN K DFN,DIRUT,DTOUT,DUOUT,VA,VADM,VAIN
 Q
BG ;prevents editing of display groups with patients from name to ticket
 S $P(^PS(59.3,DA,0),"^",2)=PDP W !,$C(7),"The display cannot be changed from NAME to TICKET when patients are",!,"already in the Display Group.  All patients must be purged and re-entered.",!,"Ticket numbers must be issued !!",! K Y,PDP
 Q
CLNAP ;quits action profile
 Q
PRMI ;prints medication instruction sheets.  select drug.
 S X="PSNPPIP" X ^%ZOSF("TEST") I '$T S VALMBCK="",VALMSG="Medication Instruction Sheets Not Installed!" Q
 I $G(PSODFN) N PSNDFN S PSNDFN=PSODFN
 W !! K PSNPPI("MESSAGE") D FULL^VALM1,^PSNPPIP S VALMBCK="R"
 I $G(PSNPPI("MESSAGE"))]"" D
 .K DIR W PSNPPI("MESSAGE"),! S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DIRUT,DIRUT,PSNPPI("MESSGAE")
 Q
PRMID ;prints medication instruction sheets.  pass in drug.
 N RX0,RXN  ;*276
 S RXN=$P($G(PSOLST(ORN)),"^",2) Q:RXN=""  ;*276
 I $T(ENOP^PSNPPIP)']"" S VALMBCK="",VALMSG="Medication Instruction Sheets Not Installed!" Q
 K PSNPPI("MESSAGE") D FULL^VALM1
 S RX0=$G(^PSRX(RXN,0))  ;*276
 W !! D ENOP^PSNPPIP($P(RX0,"^",6),$G(^PSRX(RXN,"TN")),$P(RX0,"^"),PSODFN)
 S VALMBCK="R" I $G(PSNPPI("MESSAGE"))]"" D
 .K DIR W PSNPPI("MESSAGE"),! S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DIRUT,DIRUT,PSNPPI("MESSGAE")
 Q
