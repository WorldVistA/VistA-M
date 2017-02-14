PSSDIUTL ;HP/MJE - Drug Interaction Utility ;09/22/11 5:00pm
 ;;1.0;PHARMACY DATA MANAGEMENT;**169,175,199**;9/30/97;Build 2
 ;Reference ^PSDRUG supported by DBIA 221
 ;Reference to XTID is supported DBIS 4631
 ;Reference to IN^PSSHRQ2 supported by DBIA 5369
CHKFDB ;ping FDB
 N BASE
 S BASE="PINGTST^"_$T(+0)
 K ^TMP($J,BASE),DRGLST
 S ^TMP($J,BASE,"IN","PING")=""
 D IN^PSSHRQ2(BASE)
 D:$G(^TMP($J,BASE,"OUT",0))'=0  Q:$G(^TMP($J,BASE,"OUT",0))'=0
 .S DIR(0)="E",DIR("A",1)="The FDB database is not available at this time!"
 .S DIR("A",2)="Reason: "_$P($G(^TMP($J,BASE,"OUT",0)),"^",2)
 .S DIR("A",4)="Please contact the National Service Desk."
 .S DIR("A",5)=""
 .S DIR("A")="Press Return to continue...",DIR("?")="Press Return to continue"
 .W ! D ^DIR K DIRUT,DUOUT,DIR,X,Y  W @IOF
 K ^TMP($J,BASE),BASE
 N NUM,MON,TEXTSTR S DRGLST=0,NUM=1,TEXTSTR="",PSSDGCK=1 N ID,ORTYP,NDF,DRUG,ON,PSONULN,PSONULN2 S $P(PSONULN,"-",60)="-",$P(PSONULN2,"=",60)="="
 K ^TMP($J)
SELECT ;
 K:'$G(PSORXED) CLOZPAT
 K IT,DIC,X,Y,PSODRUG("TRADE NAME"),PSODRUG("NDC"),PSODRUG("DAW"),PSODRUG("BAD") S:$G(POERR)&($P($G(OR0),"^",9)) Y=$P(^PSDRUG($P(OR0,"^",9),0),"^")
 I $G(PSODRUG("IEN"))]"" S Y=PSODRUG("NAME"),PSONEW("OLD VAL")=PSODRUG("IEN")
 W !,"Drug "_NUM_": "_$S($G(Y)]"":Y_"// ",1:"") R X:$S($D(DTIME):DTIME,1:300) I '$T S DTOUT=1
 I X="",$G(Y)]"" S:Y X=Y S:'X X=$G(PSODRUG("IEN")) S:X X="`"_X
 I X="",DRGLST>1 W !!,"Now Processing Enhanced Order Checks!  Please wait...",! H 1 G FDBCALL
 I X="",DRGLST<2 W !!,"A minimum of 2 Drugs are required!",! G SELECT
 I X?1."?" W !!,"Answer with DRUG NUMBER, or GENERIC NAME, or VA PRODUCT NAME, or",!,"NATIONAL DRUG CLASS, or SYNONYM" G SELECT
 I $G(PSORXED),X["^" S PSORXED("DFLG")=1 W ! G SELECTX
 I X="^"!(X["^^")!($D(DTOUT)) W ! G SELECTX
 S DIC=50,DIC(0)="EMQZVT",DIC("T")="",D="B^C^VAPN^VAC"
 S DIC("S")="I $S('$D(^PSDRUG(+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0),$$GCN^PSSDIUTL(+Y),$$PKGFLG^PSSDIUTL($P($G(^PSDRUG(+Y,2)),""^"",3)),$D(^PSDRUG(""ASP"",+$G(^(2)),+Y))"
 D MIX^DIC1 K DIC,PKF2,D
 I $D(DTOUT) G SELECTX
 I $D(DUOUT) K DUOUT G SELECT
 I Y<0 G SELECT
 S:$G(PSONEW("OLD VAL"))=+Y&('$G(PSOEDIT)) PSODRG("QFLG")=1
 K PSOY S PSOY=Y,PSOY(0)=Y(0)
 I $P(PSOY(0),"^")="OTHER DRUG"!($P(PSOY(0),"^")="OUTSIDE DRUG") D TRADE
 G:Y<0 SELECT
 F DRGLSTI=0:0 S DRGLSTI=$O(DRGLST(DRGLSTI)) Q:'DRGLSTI  D
 .I DRGLSTI=+Y S DRGLSTF=1
 I $D(DRGLSTF) S NUM=DRGLST+1 K DRGLSTF W !!,"You have selected a duplicate drug please enter a different drug.." K DIR,DRGLSTI,Y S DIR(0)="E",DIR("A")="Press Return to Continue..." W ! D ^DIR K DIR G SELECT
 S DRGLST=$G(DRGLST)+1,DRGLST(+Y)=Y_"^"_DRGLST,NUM=NUM+1 G SELECT
SELECTX K DIC,X,Y,DTOUT,DUOUT,PSONEW("OLD VAL"),DRGLST
 Q
GCN(PSSIENID) ;Return 0 for not matched, 1 for matched with no GCNSEQNO, 1^1 for matched with a GCNSEQNO
 N PSSNDFID,PSSGCNPT,PSSGCNID
 S PSSNDFID=$P($G(^PSDRUG(PSSIENID,"ND")),"^"),PSSGCNPT=$P($G(^PSDRUG(PSSIENID,"ND")),"^",3)
 I 'PSSNDFID!('PSSGCNPT) Q 0
 S PSSGCNID=$$PROD0^PSNAPIS(PSSNDFID,PSSGCNPT)
 I $P(PSSGCNID,"^",7) Q PSSIENID_";"_PSSNDFID_";"_$P(PSSGCNID,"^",7)
 Q PSSIENID_";"_PSSNDFID
PKGFLG(PKF2) ;
 I $S(PKF2["O":1,1:0) Q 1
 I $S(PKF2["X":1,1:0) Q 1
 I $S(PKF2["U":1,1:0) Q 1
 I $S(PKF2["I":1,1:0) Q 1
 Q 0
TRADE ;
 K DIR,DIC,DA,X,Y
 S DIR(0)="52,6.5" S:$G(PSOTRN)]"" DIR("B")=$G(PSOTRN) D ^DIR K DIR,DIC
 I X="@" S Y=X K DIRUT
 I $D(DIRUT) S:$D(DUOUT)!$D(DTOUT)&('$D(PSORX("EDIT"))) PSONEW("DFLG")=1 G TRADEX
 S PSODRUG("TRADE NAME")=Y
TRADEX I $G(PSORXED("DFLG")),$D(DIRUT) S PSORXED("DFLG")=1
 K DIRUT,DTOUT,DUOUT,X,Y,DA,DR,DIE Q
FDBCALL S LIST="PSOPEPS",^TMP($J,LIST,"IN","DRUGDRUG")=""
 F I=0:0 S I=$O(DRGLST(I)) Q:'I  D
 .S DIEN=$P(DRGLST(I),"^"),DNM=$P(DRGLST(I),"^",2),ON="Z;"_$P(DRGLST(I),"^",3)_";PROSPECTIVE;"_$P(DRGLST(I),"^",3)
 .K ID,P1,P2 S ID=+$$GETVUID^XTID(50.68,,+$P($G(^PSDRUG(DIEN,"ND")),"^",3)_",")
 .S:ID=0 PSODRUG("IEN")=DIEN
 .S P1=$P($G(^PSDRUG(DIEN,"ND")),"^"),P2=$P($G(^("ND")),"^",3),X=$$PROD0^PSNAPIS(P1,P2)
 .S SEQN=$P(X,"^",7)
 .S ^TMP($J,LIST,"IN","PROSPECTIVE",ON)=SEQN_"^"_ID_"^"_DIEN_"^"_DNM K ID
 S ^TMP($J,LIST,"IN","THERAPY")=""
 D IN^PSSHRQ2(LIST)
 S THSW2=0
 I +$G(^TMP($J,LIST,"OUT",0))=1 D PROC
 I '$G(^TMP($J,LIST,"OUT",0)) W !,"No drug interactions or therapeutic duplication occurred." W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR G EXIT
 I +$G(^TMP($J,LIST,"OUT",0))=-1 W !,"Error: "_$P(^TMP($J,"PSOPEPS","OUT",0),"^",2),! G EXIT
 G:'$D(^TMP($J,"PSOPEPS","OUT","THERAPY")) RMON
 W !,PSONULN2 K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR W @IOF
RMON I $G(MON) D MON I $G(X)="" W ! D RMON
EXIT ;
 K DRGLST,DIC,X,Y,ID,ORTYP,DIEN,DNM,PSONULN,PSSDGCK,MON,^TMP($J),LIST,PSODRUG("IEN") Q
PROC ;
 I $D(PSODGCK) N PSONULN,PSONULN2,THSW2 S $P(PSONULN,"-",60)="-",$P(PSONULN2,"=",60)="=",THSW2=0
 W @IOF K ^UTILITY($J) I $O(^TMP($J,LIST,"OUT","EXCEPTIONS",""))]"" D EXC^PSODDPR5
 I '$D(^TMP($J,LIST,"OUT","DRUGDRUG"))&'$D(^TMP($J,LIST,"OUT","THERAPY",1)) W !,"No Order Check Warnings Found",! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR W @IOF
 I $D(PSODGCK),'$D(^TMP($J,LIST,"OUT","DRUGDRUG")),$D(^TMP($J,"PSOPEPS","OUT","THERAPY")) G DGCKTHER
 D DELDISC^PSSDIUTX I $D(^TMP($J,LIST,"OUT","DRUGDRUG")) W !,"*** DRUG INTERACTION(S) ***",!,PSONULN2,!
 N DRG,ON,CT,DRGI,PDRG,SEV,SEVH,STX,INT,CLI,PDRG S (ON,DRG,SV)="",CT=0,SEVH="Critical"
 F  S SV=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV)) Q:SV=""  F  S DRG=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG)) Q:DRG=""  D
 .F  S ON=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON)) Q:ON=""  F  S CT=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT)) Q:'CT  D DUP
 I $D(^TMP($J,LIST,"OUT","DRUGDRUG")) W !,PSONULN2 K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR ;(end of inter data)
DGCKTHER I $D(^TMP($J,"PSOPEPS","OUT","THERAPY")) W @IOF W PSONULN2,!,"*** THERAPEUTIC DUPLICATION(S) ***",! D THER
 I $D(PSODGCK),'$D(^TMP($J,LIST,"OUT","DRUGDRUG")),$D(^TMP($J,"PSOPEPS","OUT","THERAPY")) K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." W ! D ^DIR K DIR W @IOF Q
DGCKMON I $D(PSODGCK),$D(^TMP($J,LIST,"OUT","DRUGDRUG")),$G(MON) D MON I $G(X)="" W ! D DGCKMON
 Q
THER ;
 S (THR,THR1,THR2,TCTR,TCLSTR)="" S TALWNUM=0 N TLN,TLN2 S $P(TLN,"=",60)="",$P(TLN2,"-",60)="" S THSW=0
 F  S THR=$O(^TMP($J,LIST,"OUT","THERAPY",THR)) Q:THR=""  D
 .S THR1="",TCLSTR=""
 .F  S THR1=$O(^TMP($J,LIST,"OUT","THERAPY",THR,THR1)) Q:THR1=""  D
 ..S TALWNUM=TALWNUM+$G(^TMP($J,LIST,"OUT","THERAPY",THR,THR1,"ALLOW"))
 ..S TCLSTR=TCLSTR_$G(^TMP($J,LIST,"OUT","THERAPY",THR,THR1,"CLASS"))
 ..S:+$O(^TMP($J,LIST,"OUT","THERAPY",THR,THR1))'=0 TCLSTR=TCLSTR_", "
 .I TALWNUM=0 I ($Y+8)>IOSL,$E(IOST)="C" D
 ..K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR W @IOF
 .W:THSW !,TLN2 S THSW=1
 .I TALWNUM=0 D
 ..F  S TCTR=$O(^TMP($J,LIST,"OUT","THERAPY",THR,"DRUGS",TCTR)) Q:TCTR=""  D
 ...W !,?12,"Drug Name: ",$$THOSTAT^PSSCKOS($P($G(^TMP($J,LIST,"OUT","THERAPY",THR,"DRUGS",TCTR)),U,3),THR,TCTR)
 ..W !,!,"Duplication Allowance: 0",!,?11,"Drug Class: "
 ..I $L(TCLSTR)>50 D
 ...K BSIG N BBSIG,BVAR,BVAR1,III,ZNT,NNN,BLIM
 ...S BBSIG=TCLSTR,(BVAR,BVAR1)="",III=1
 ...S ZNT=0 F NNN=1:1:$L(BBSIG) I $E(BBSIG,NNN)=" "!($L(BBSIG)=NNN) S ZNT=ZNT+1 D  I $L(BVAR)>50 S BSIG(III)=BLIM_" ",III=III+1,BVAR=BVAR1
 ....S BVAR1=$P(BBSIG," ",(ZNT)),BLIM=BVAR,BVAR=$S(BVAR="":BVAR1,1:BVAR_" "_BVAR1)
 ...I $G(BVAR)'="" S BSIG(III)=BVAR
 ...I $G(BSIG(1))=""!($G(BSIG(1))=" ") S BSIG(1)=$G(BSIG(2)) K BSIG(2)
 ..I $L(TCLSTR)>50 D
 ...S I=""
 ...F  S I=$O(BSIG(I)) Q:'I  D
 ....W:I=1 BSIG(I),! W:I>1 ?23,BSIG(I)
 ..E  D
 ...W TCLSTR
 .I TALWNUM>0 D
 ..S THR2="",TCLSTR=""
 ..F  S THR2=$O(^TMP($J,LIST,"OUT","THERAPY",THR,THR2)) Q:+THR2=0  D
 ...F  S TCTR=$O(^TMP($J,LIST,"OUT","THERAPY",THR,"DRUGS",TCTR)) Q:TCTR=""  D
 ....W !,?12,"Drug Name: ",$$THOSTAT^PSSCKOS($P($G(^TMP($J,LIST,"OUT","THERAPY",THR,"DRUGS",TCTR)),U,3),THR,TCTR)
 ...W !,!,"Duplication Allowance: ",$G(^TMP($J,LIST,"OUT","THERAPY",THR,THR2,"ALLOW"))
 ...K TCLSTR S TCLSTR=^TMP($J,LIST,"OUT","THERAPY",THR,THR2,"CLASS")
 ...W !,?11,"Drug Class: "
 ...I $L(TCLSTR)>50 D
 ....K BSIG N BBSIG,BVAR,BVAR1,III,ZNT,NNN,BLIM
 ....S BBSIG=TCLSTR,(BVAR,BVAR1)="",III=1
 ....S ZNT=0 F NNN=1:1:$L(BBSIG) I $E(BBSIG,NNN)=" "!($L(BBSIG)=NNN) S ZNT=ZNT+1 D  I $L(BVAR)>50 S BSIG(III)=BLIM_" ",III=III+1,BVAR=BVAR1
 .....S BVAR1=$P(BBSIG," ",(ZNT)),BLIM=BVAR,BVAR=$S(BVAR="":BVAR1,1:BVAR_" "_BVAR1)
 ....I $G(BVAR)'="" S BSIG(III)=BVAR
 ....I $G(BSIG(1))=""!($G(BSIG(1))=" ") S BSIG(1)=$G(BSIG(2)) K BSIG(2)
 ...I $L(TCLSTR)>50 D
 ....S I=""
 ....F  S I=$O(BSIG(I)) Q:'I  D
 .....I ($Y+6)>IOSL,$E(IOST)="C" D
 ......K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR W @IOF
 .....W:I=1 BSIG(I),! W:I>1 ?23,BSIG(I),!
 ...E  D
 ....W TCLSTR,!
 ...I ($Y+6)>IOSL,$E(IOST)="C" D
 ....K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR
 Q
DUP ;
 N PDRGN,DRGN S PDRGN="",DRGN=""
 I ($Y+8)>IOSL,$E(IOST)="C" D
 .K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR W @IOF
 I $O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"PMON",0)) S MON=1
 S PDRG=$P(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT),"^",4)
 S CLI=$G(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"CLIN"))
 S SEV=$G(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"SEV"))
 S:SEVH'=SEV PSONULN="",$P(PSONULN,"=",60)="="
 I ($Y+6)>IOSL,$E(IOST)="C" D
 .K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR
 W:THSW2 PSONULN,! S THSW2=1
 SET PDRGN=$$POSTAT^PSSCKOS(DRG,PDRG,SV,ON,CT),DRGN=$$OSTAT^PSSCKOS(DRG,ON)
 W "***"_SEV_"*** Drug Interaction with ",!,DRGN_" and" W:SEV="Critical" !,PDRGN,!! W:SEV="Significant" !,PDRGN,!!
 S:SEVH'=SEV PSONULN="",$P(PSONULN,"-",60)="-"
 S SEVH=SEV
 I $L(CLI)>70 D
 .K BSIG N BBSIG,BVAR,BVAR1,III,ZNT,NNN,BLIM
 .S BBSIG=CLI,(BVAR,BVAR1)="",III=1
 .S ZNT=0 F NNN=1:1:$L(BBSIG) I $E(BBSIG,NNN)=" "!($L(BBSIG)=NNN) S ZNT=ZNT+1 D  I $L(BVAR)>70 S BSIG(III)=BLIM_" ",III=III+1,BVAR=BVAR1
 ..S BVAR1=$P(BBSIG," ",(ZNT)),BLIM=BVAR,BVAR=$S(BVAR="":BVAR1,1:BVAR_" "_BVAR1)
 .I $G(BVAR)'="" S BSIG(III)=BVAR
 .I $G(BSIG(1))=""!($G(BSIG(1))=" ") S BSIG(1)=$G(BSIG(2)) K BSIG(2)
 I $L(CLI)>70 D
 .S I=""
 .F  S I=$O(BSIG(I)) Q:'I  D
 ..W BSIG(I),!
 E  D
 .W CLI,!
 K BSIG,BBSIG,BVAR,BVAR1,III,ZNT,NNN,BLIM
 Q
MON ;
 I '$G(DUOUT) W ! K DIR S DIR("A")="Display Professional Interaction Monograph",DIR("B")="NO",DIR(0)="Y",DIR("?")="Enter Y if you would like to see the Monograph." D ^DIR W !
 I X="^"!(X["^^")!($D(DTOUT)) Q
 K SEL,DIR,DTOUT,DUOUT,DIRUT Q:Y=0
 S MONT=1,SEL=1 K Y D BLD Q:$G(SEL)=0
 K IOP,%ZIS,POP S %ZIS="QM" W ! D ^%ZIS
 I POP K SEL,DIR,DTOUT,DUOUT,DIRUT,MONT W !,"NOTHING PRINTED" G MON
 I $D(IO("Q")) D  Q
 .S ZTRTN="OUT^PSOIDPRE",ZTDESC="Monograph Report of Drug Interactions",ZTSAVE("MONT")=""
 .S ZTSAVE("PSONULN")="",ZTSAVE("LIST")="",ZTSAVE("^TMP($J,LIST,""OUT"",""DRUGDRUG"",")="",ZTSAVE("^TMP($J,""PSOMONP"",")=""
 .D ^%ZTLOAD,^%ZISC W !,"Monograph Queued to Print!",! S:$D(ZTQUEUED) ZTREQ="Q"
 D OUT,^%ZISC
 W ! G:Y'=0 MON
 Q
OUT ;print monograph
 N DRG,ON,CT,DRGI,PDRG,SEV,STX,INT,CLI,PDRG,RNG,QX
 D:MONT=1 PROF D:MONT=2 CON D:MONT=3 PROF
 Q
BLD ;
 K SEL,X,Y,DRG,ON,CT,RNG,^TMP($J,"PSOMON"),^TMP($J,"PSOMONP") S (DRG,ON,SV)="",CT=0
 F  S SV=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV)) Q:SV=""  F  S DRG=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG)) Q:DRG=""  F  S ON=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON)) Q:ON=""  D
 .F  S CT=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT)) Q:'CT  I $O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"PMON",0)) D
 ..S RNG=$G(RNG)+1
 ..S ^TMP($J,"PSOMON",RNG,DRG)=DRG_"^"_ON_"^"_CT_"^"_$P(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT),"^",4)_"^"_$G(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"SEV"))
 I '$D(^TMP($J,"PSOMON",2)) S Y=1 G ONEMONO
 K DIR S IND=0,DRG=""
 ;F  S IND=$O(^TMP($J,"PSOMON",IND)) Q:'IND  F  S DRG=$O(^TMP($J,"PSOMON",IND,DRG)) Q:DRG=""  S DIR("A",IND)=IND_". "_DRG_" and "_$P(^TMP($J,"PSOMON",IND,DRG),"^",4) S DIR("A",IND+1)=""
 F  S IND=$O(^TMP($J,"PSOMON",IND)) Q:'IND  F  S DRG=$O(^TMP($J,"PSOMON",IND,DRG)) Q:DRG=""  D
 .I ($Y+6)>IOSL,$E(IOST)="C" D
 ..W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR W @IOF
 .W !,IND_". "_DRG_" and "_$P(^TMP($J,"PSOMON",IND,DRG),"^",4)
 W ! S DIR("A")="Select Monograph for printing by number",DIR(0)="LO^1:"_RNG D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT))!(X="^")!(X="") S SEL=0 Q
ONEMONO F G=1:1:$L(Y) Q:$P(Y,",",G)=""  S DRG=$O(^TMP($J,"PSOMON",$P(Y,",",G),"")),^TMP($J,"PSOMONP",$P(Y,",",G),0)=^TMP($J,"PSOMON",$P(Y,",",G),DRG)
 K ^TMP($J,"PSOMON")
 Q
 ;
NEWPG ;new page form feed
 N DIR
 S DIR(0)="E",DIR("A")="Press Return to Continue or ""^"" to Exit"
 D ^DIR Q:($D(DUOUT)!($D(DTOUT)))
 W @IOF,$S($G(MONT)=2:"Consumer",1:"Professional")_" Monograph",!!,"Drug Interaction with ",!,DRG_" and "_PDRG,!!
 Q
 ;
FORMAT ; WATCH OUT WITH CHANGES HERE!!!
 K BSIG,XX N BBSIG,BVAR,BVAR1,III,ZNT,NNN,BLIM
 I $L(TEXTSTR)'>70 D
 . W ?5,TEXTSTR,!
 I $L(TEXTSTR)>70 D
 .S BBSIG=TEXTSTR,(BVAR,BVAR1)="",III=1
 .S ZNT=0 F NNN=1:1:$L(BBSIG) I $E(BBSIG,NNN)=" "!($L(BBSIG)=NNN) S ZNT=ZNT+1 D  I $L(BVAR)>70 S BSIG(III)=BLIM_" ",III=III+1,BVAR=BVAR1
 ..S BVAR1=$P(BBSIG," ",(ZNT)),BLIM=BVAR,BVAR=$S(BVAR="":BVAR1,1:BVAR_" "_BVAR1)
 .I $G(BVAR)'="" S BSIG(III)=BVAR
 .I $G(BSIG(1))=""!($G(BSIG(1))=" ") S BSIG(1)=$G(BSIG(2)) K BSIG(2)
 F XX=0:0 S XX=$O(BSIG(XX)) Q:'XX  D  Q:($D(DUOUT)!($D(DTOUT)))
 . I $Y+6>IOSL,$E(IOST)="C" D NEWPG Q:($D(DUOUT)!($D(DTOUT)))
 . W ?5,BSIG(XX),!
 K BSIG,BBSIG,BVAR,BVAR1,III,ZNT,NNN,BLIM S TEXTSTR=""
 Q
PROF ;
 F I=0:0 S I=$O(^TMP($J,"PSOMONP",I)) Q:'I  S DRG=$P(^TMP($J,"PSOMONP",I,0),"^"),ON=$P(^(0),"^",2),CT=$P(^(0),"^",3),PDRG=$P(^(0),"^",4),SEV=$E($P(^(0),"^",5),1,1) D  Q:$D(DUOUT)!($D(DTOUT))
 .U IO W @IOF,!,PSONULN,!,"Professional Monograph",!!,"Drug Interaction with ",!,DRG_" and "_PDRG,!!
 .F QX=0:0 S QX=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SEV,DRG,ON,CT,"PMON",QX)) Q:'QX  D  Q:($D(DUOUT)!($D(DTOUT)))
 ..I $Y+6>IOSL,$E(IOST)="C" D NEWPG Q:($D(DUOUT)!($D(DTOUT)))
 ..S TEXTSTR=^TMP($J,LIST,"OUT","DRUGDRUG",SEV,DRG,ON,CT,"PMON",QX,0) D FORMAT
 ..I ($Y+6)>IOSL,$E(IOST)="C" W !
 Q:($D(DUOUT)!($D(DTOUT)))
 K DTOUT,DUOUT
 D:MONT=3
 .U IO W @IOF,!,PSONULN,!,"Consumer Monograph",!!,"Drug Interaction with ",!,DRG_" and "_PDRG,!
 .F QX=0:0 S QX=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SEV,DRG,ON,CT,"CMON",QX)) Q:'QX  D  Q:($D(DUOUT)!($D(DTOUT)))
 ..I $Y+6>IOSL,$E(IOST)="C" D NEWPG Q:($D(DUOUT)!($D(DTOUT)))
 ..W !?5,^TMP($J,LIST,"OUT","DRUGDRUG",SEV,DRG,ON,CT,"CMON",QX,0)
 W !,PSONULN,!
 K DTOUT,DUOUT I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR,DTOUT,DUOUT
 Q
CON F I=0:0 S I=$O(^TMP($J,"PSOMONP",I)) Q:'I  S DRG=$P(^TMP($J,"PSOMONP",I,0),"^"),ON=$P(^(0),"^",2),CT=$P(^(0),"^",3),PDRG=$P(^(0),"^",4),SEV=$P(^(0),"^",5) D  Q:$D(DUOUT)!($D(DTOUT))
 .U IO W @IOF,!,"Consumer Monograph",!,PSONULN,!!,"Drug Interaction with ",!,DRG_" and "_PDRG,!!
 .F QX=0:0 S QX=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SEV,DRG,ON,CT,"CMON",QX)) Q:'QX  D  Q:($D(DUOUT)!($D(DTOUT)))
 ..I $Y+6>IOSL,$E(IOST)="C" D NEWPG Q:($D(DUOUT)!($D(DTOUT)))
 ..W !?5,^TMP($J,LIST,"OUT","DRUGDRUG",DRG,ON,CT,"CMON",QX,0)
 I '$G(DUOUT) W !,PSONULN,!
 K DTOUT,DUOUT I $E(IOST)="C" K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR,DTOUT,DUOUT
 Q
