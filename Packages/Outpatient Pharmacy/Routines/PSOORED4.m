PSOORED4 ;BIR/SAB - Edit front door dosing ;07/13/00
 ;;7.0;OUTPATIENT PHARMACY;**46,91,78,99,111,117,133,159,148,251,391,372,416,313,437,282**;DEC 1997;Build 18
 ;External reference ^PS(51 supported by DBIA 2224
 ;External reference to PS(51.2 supported by DBIA 2226
 ;External reference to PS(51.1 supported by DBIA 2225
 ;called from psoornew
 ;
DOSE(PSORXED) ;
 I '$G(PSODRUG("IEN")) W !,"DRUG NAME REQUIRED!" D 2^PSOORNW1 I '$G(PSODRUG("IEN")) S VALMSG="No Dispense Drug Selected" Q
 K ROU,STRE,UNITN,PSODOSE M PSODOSE=PSORXED
 D KV K FIELD,DOSEOR,DUPD,X,Y,UNITS S ENT=1,OLENT=$G(PSORXED("ENT"))
ASK I $G(ORD) W !!,"Possible SIG: " D
 .;Coded only for outside orders with no Patient Instructions
 .I $O(SIG(""))="",$G(ORD),$P($G(^PS(52.41,ORD,"EXT")),"^")'="" D SIGS^PSOHCPRS
 .S INST=0 F  S INST=$O(SIG(INST)) Q:'INST  S MIG=SIG(INST) D
 ..F SG=1:1:$L(MIG," ") W:$X+$L($P(MIG," ",SG)_" ")>IOM !?14 W $P(MIG," ",SG)_" "
 K SG,INST,MIG
 S ROU="PSOORED4",II=ENT D ASK^PSOBKDED K ROU,II I $G(JUMP) K JUMP G JUMP
 G:$D(DIRUT) EXQ
 ;
 I $G(VERB)]"" S PSORXED("VERB",ENT)=VERB G DUPD
VER D VER^PSOOREDX I X[U,$L(X)>1 S FIELD="VER" G JUMP
 G:$D(DTOUT)!($D(DUOUT)) EXQ
 I X="@" K PSORXED("VERB",ENT),VERB G DUPD
 S:X'="" (PSORXED("VERB",ENT),VERB)=X
DUPD ;
 I $G(PSORXED("DOSE",ENT))'?.N&($G(PSORXED("DOSE",ENT))'?.N1".".N)!'DOSE("LD") K PSORXED("DOSE ORDERED",ENT),DUPD G NOU1
 D DUPD^PSOOREDX
 S DIR("B")=$S($G(PSORXED("DOSE ORDERED",ENT))]"":PSORXED("DOSE ORDERED",ENT),1:1) S:$E($G(DIR("B")),1)="." DIR("B")="0"_$G(DIR("B")) K:DIR("B")="" DIR("B")
 D ^DIR I X[U,$L(X)>1 S FIELD="DUPD" G JUMP
 G:$D(DTOUT)!($D(DUOUT)) EXQ
 I X="@"!(X=0) W !,"Dispense Units Per Dose is Required!!",! G DUPD
 D STR^PSOOREDX
NOU1 G:'$G(PSORXED("DOSE ORDERED",ENT)) RTE
 D CNON^PSOORED3
 N PSONDEF
 I $G(NOUN)]"" S PSORXED("NOUN",ENT)=NOUN
NOU D NOU^PSOOREDX I X[U,$L(X)>1 S FIELD="NOU" G JUMP
 G:$D(DTOUT)!($D(DUOUT)) EXQ
 I X="@" K PSORXED("NOUN",ENT),NOUN G RTE
 I X'="",$G(PSONDEF)="" S NOUN=X
 I X'="",$G(PSONDEF)'=X S NOUN=X
 S:X'="" PSORXED("NOUN",ENT)=X
 ;
RTE K JUMP S ROU="PSOORED4" D RTE^PSOBKDED K ROU
 I $G(JUMP) K JUMP G JUMP
 G:$D(DTOUT)!($D(DUOUT)) EXQ
 ;
SCH D SCH^PSOBKDED I X[U,$L(X)>1 S FIELD="SCH" G JUMP
 G:$D(DTOUT)!($D(DUOUT)) EXQ
 S SCH=Y D SCH^PSOSIG I $G(SCH)']"" G SCH
 S PSORXED("SCHEDULE",ENT)=SCH W " ("_SCHEX_")" K SCH,SCHEX,X,Y,PSOSCH
 S:PSORXED("ENT")<ENT PSORXED("ENT")=ENT
 ;
DUR D KV K EXP S DIR(0)="52.0113,4",DIR("A")="LIMITED DURATION (IN DAYS, HOURS OR MINUTES)"
 S DIR("B")=$S($G(PSORXED("DURATION",ENT))]"":PSORXED("DURATION",ENT),1:"") K:DIR("B")="" DIR("B")
 D ^DIR I X[U,$L(X)>1 S FIELD="DUR" G JUMP
 G:$D(DTOUT)!($D(DUOUT)) EXQ
 D DUR1^PSOOREDX
 ;
CON D CON^PSOOREDX I X[U,$L(X)>1 S FIELD="CON" G JUMP
 G:$D(DTOUT)!($D(DUOUT)) EXQ
 I X="@",$G(PSORXED("CONJUNCTION",ENT))="" W !,?10,"Invalid Entry - nothing to delete!!" G CON
 S:X'=""&(X'="@") PSORXED("CONJUNCTION",ENT)=Y
 I X="@",$D(PSORXED("CONJUNCTION",ENT)) D CON1^PSOOREDX G:$D(DIRUT) EXQ G:'Y CON N CKX S CKX=1 D UPD^PSOOREDX G CON
 ;
 N PSODLBD4 S PSOSAVX=X,PSODLBD4=1
 ;*437
 I '$$DUROK^PSOORED3(.PSORXED,ENT) D  G DUR
 . W !!,"Duration is required for the dosage entered prior to the THEN conjunction.",$C(7),!
 I $G(PSORXED("CONJUNCTION",ENT))]"" S PSOCKCON=1 D DCHK1^PSODOSUT G:$G(PSONEW("DFLG")) EX S ENT=ENT+1 K DIR G ASK
 E  K PSOCKCON D DCHK1^PSODOSUT I $D(DTOUT)!($D(DUOUT)) S PSORX("DFLG")=1,PSONEW("DFLG")=1 G EX  ;don't need to print the full summary, just the last sequence. 
 I PSOSAVX="",$G(PSORXED) K PSOCKCON,PSOEDDOS
 K PSOSAVX
 ;
 S X=$G(PSORXED("INS")) D SIG^PSOHELP S:$G(INS1)]"" PSORXED("SIG")=$E(INS1,2,9999999)
 D EN^PSOFSIG(.PSORXED),VERI I $G(CKX),'$G(PSOSIGFL) D MP1 K CKX
 I $G(PSOSIGFL)=1 D  I '$G(PSOSIGFL) Q
 .I $D(OR0),$P(OR0,"^",24)=1 S VALMSG="Digitally Signed Order - No such changes allowed." K PSORXED,PSOSIGFL M PSORXED=PSODOSE D EN^PSOFSIG(.PSORXED) D  Q
 ..I $D(PSOBDR) K PSODRUG M PSODRUG=PSOBDR K PSOBDR,PSOBDRG
 .S PSORXED("ENT")=ENT,SIGOK=1,VALMSG="This change will create a new prescription!",NCPDPFLG=1
 K QTYHLD S:$G(PSORXED("QTY")) QTYHLD=PSORXED("QTY") D QTY^PSOSIG(.PSORXED) I $G(PSORXED("QTY")) S QTY=1
 I $G(QTYHLD),'$G(PSORXED("QTY")) S PSORXED("QTY")=QTYHLD
 K QTYHLD
 I '$G(PSORXED("QTY")),$P(OR0,"^",10) S PSORXED("QTY")=$P(OR0,"^",10)
EX ;
 K PSOBDR,PSOBDRG,PSOSCH,DUPD,STRE,UNITN,SCH,VERB,NOUN,DOSEOR,RTE,DUR,X,Y,ENTS,PSODOSE,OLENT,FIELD,FLDNM,AR,NM,ENT,STRE,UNITN,PSODOSE,ERTE,ROU
KV K DTOUT,DUOUT,DIR,DIRUT
 Q
EXQ ;
 K PSORXED,PSOSIGFL M PSORXED=PSODOSE D EN^PSOFSIG(.PSORXED) D MP1
 I $D(PSOBDR) M PSODRUG=PSOBDR K PSOBDR,PSOBDRG
 G EX Q
MP1 D MP1^PSOOREDX
 Q
VERI ;checks for changes to dosing instructions
 S ENTS=0
 F I=0:0 S I=$O(PSORXED("DOSE",I)) Q:'I  S ENTS=$G(ENTS)+1
 I ENTS<OLENT!(ENTS>OLENT) S PSOSIGFL=1 Q
 F I=1:1:OLENT D
 .I +PSODOSE("DOSE",I)'=$G(PSORXED("DOSE",I)) S PSOSIGFL=1
 .I $G(PSODOSE("DURATION",I))]"" D
 ..S DURATION=$S($E(PSODOSE("DURATION",I),1)'?.N:$E(PSODOSE("DURATION",I),2,99)_$E(PSODOSE("DURATION",I),1),1:PSODOSE("DURATION",I))
 ..I +DURATION'=+$G(PSORXED("DURATION",I)) S PSOSIGFL=1
 .I $G(PSODOSE("CONJUNCTION",I))'=$G(PSORXED("CONJUNCTION",I)) S PSOSIGFL=1
 .I PSODOSE("ROUTE",I)'=$G(PSORXED("ROUTE",I)) S PSOSIGFL=1
 .I PSODOSE("SCHEDULE",I)'=$G(PSORXED("SCHEDULE",I)) S PSOSIGFL=1
 K DURATION Q
JUMP ;jump to fields
 I $L($E(X,2,99))<3 W !,"Field Name Must Be At Least 3 Characters in Length",! G @FIELD
 D FNM^PSOOREDX
 I FLDNM']"" K X,NM,FLDNM W !,"INVALID FIELD NAME.  PLEASE TRY AGAIN!",! G @FIELD
 F AR=1:1:PSORXED("ENT") W !,AR_". "_$P(FLDNM,"^",2)_": "_$S(NM="ROU"&($G(PSORXED($P(FLDNM,"^"),AR))):$P(^PS(51.2,PSORXED($P(FLDNM,"^"),AR),0),"^"),1:$G(PSORXED($P(FLDNM,"^"),AR))) S AR1=AR
 D KV S DIR("A",1)="* Indicates which fields will create a New Order",DIR("A")="Select Field to Edit by number",DIR(0)="NO^1:"_AR1 D ^DIR G:$D(DIRUT) @FIELD
 D JFN^PSOOREDX G:FLDNM="" @FIELD G @FLDNM
 G EX
 Q
HLP ;help text for med route
 D FULL^VALM1 W !,"Please enter how patient will use the medication!"
 S DIC=51.2,X="??",DIC(0)="M",DIC("S")="I $P(^PS(51.2,+Y,0),""^"",4)" D ^DIC K DIC,X,Y
 Q
SCHLP ;
 D FULL^VALM1 W !,"You can choose an entry from the Administration Schedule File (#51.1),",!,"Medication Instruction File (#51) or enter free text."
 W !,"The free text entry cannot contain more than 2 spaces or be greater than 20",!,"characters in length."
 W ! S DIR(0)="S^A:Administration Schedule File;M:Medication Instruction File;B:Both;F:Free Text",DIR("B")="Both"
 S DIR("A")="Do you want to list from" D ^DIR I Y="F"!($G(DIRUT)) K X,Y G X
 S LBL=Y G @LBL
A ;display 51.1 entries only
B K X,Y,DIC S X="??",DIC="^PS(51.1,",DIC(0)="QES",DIC("W")="D DICW^PSOORED4",D="APPSJ" W ! D IX^DIC
 K DIC,X I LBL="A"!($G(DTOUT)) K LBL G X
 I Y=-1!($G(DUOUT)) K DIR,DTOUT,DUOUT S DIR(0)="Y",DIR("B")="No",DIR("A")="Do you want to continue with the Medication Instruction File"
 D ^DIR I 'Y!($G(DTOUT)) K DIR,X,Y G X
M K X,Y,DIC S DIC=51,X="??",DIC(0)="M" D ^DIC K DIC,X,Y,DTOUT,DUOUT,LBL
 ;*282 Allow multi-word schedules
X S DIR("?")="^D SCHLP^PSOORED4",DIR("A")="Schedule: ",DIR(0)="FA^1:20^I X[""""""""!(X?.E1C.E)!($A(X)=45)!($L(X,"" "")>$S(X[""PRN"":4,1:3))!($L(X)>20)!($L(X)<1) K X"
 S DIR("B")=$S($D(PSOSCH)&('$D(PSORXED("SCHEDULE",ENT))):PSOSCH,$G(PSORXED("SCHEDULE",ENT))]"":PSORXED("SCHEDULE",ENT),1:"") K:DIR("B")="" DIR("B")
 Q
DICW ;
 S Z=$P(^PS(51.1,+Y,0),"^",5),Z=$S(Z="O":-1,Z="S":1,Z="R":-2,1:0) W:Z "  ",$S(Z>0:"SHIFT",Z=-2:"RANGE",1:"ONE-TIME")
 I Z'<0,$D(PSJW),$D(^(PSJPP'="PSJ"+1,PSJW,0)),$P(^(0),"^",Z+2)]"" W "  ",$P(^(0),"^",Z+2)
 ;Naked reference on DICW+2 is from DICW+1, ^PS(51.1,+Y,0)
 Q
