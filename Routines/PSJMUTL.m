PSJMUTL ;BIR/MV-UTLILITY USE FOR QUEUING...  ;25 Nov 98 / 9:13 AM
 ;;5.0; INPATIENT MEDICATIONS ;**8,21,31,160**;16 DEC 97;Build 12
 ; References to ^PS(52.7 supported by DBIA #2173
 ; Reference to ^ORRDI1 is supported by DBIA 4659
 ; Reference to ^XTMP("ORRDI" is supported by DBIA 4660
 ; Reference to ^GMRADPT supported by DBIA #10099
SELDEV() ;*** Ask for device type for report to output to ***
 K IOP,%ZIS,POP,IO("Q")
 S %ZIS("A")="Select output device: ",%ZIS("B")="",%ZIS="Q"
 D ^%ZIS S PSJSTOP=$S(POP:1,1:0) I POP W !,"** No device selected or Report printed **" D EXIT
 Q $G(PSJSTOP)
 ;
SETSORTQ(XDESC,XSAVE,ZTRTN)     ;Queue to sort.  D SETDEV^PSJMUTL(X,Y)
 N I,X
 K IO("Q"),ZTSAVE,ZTDTH,ZTSK
 S ZTDESC=XDESC,PSGIO=ION,ZTIO=""
 S PSGIODOC="" I $G(IO("DOC"))]"" S PSGIODOC=IO("DOC")
 F I=1:1  S X=$P(XSAVE,";",I) Q:X=""  S ZTSAVE(X)=""
 D ^%ZTLOAD
 Q
 ;
SETPRTQ(XDESC,XSAVE,ZTRTN)         ;Queue to printer.  D SETPRTQ^PSJMUTL(X,Y)
 N I,X
 S ZTIO=PSGIO,ZTDESC=XDESC,ZTDTH=$H,%ZIS="QN",IOP=PSGIO
 I $G(PSGIODOC)]"" S ZTIO=ZTIO_";"_PSGIODOC
 F I=1:1  S X=$P(XSAVE,";",I) Q:X=""  S ZTSAVE(X)=""
 D ^%ZIS,^%ZTLOAD
 Q
 ;
EXITDEV ;
 I $E(IOST)="C",('$G(PSJSTOP)) K DIR W ! S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR
 S:$D(ZTQUEUED) ZTREQ="@"
 S IOP="HOME" D ^%ZISC
 Q
 ;
PRTCHK(PGCT) ;
 I $E(IOST)="C",PGCT K DIR W ! S DIR(0)="E" D ^DIR S:'Y PSJSTOP=1
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZSTOP,PSJSTOP)=1
 I $G(PSJSTOP) W !!?20,"...Report stopped at user request..." K DIR S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR
 Q $G(PSJSTOP)
 ;
EXIT ;
 K %,%H,%I,%ZIS,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN
 W:$E(IOST)="C"&($Y) @IOF
 S:$D(ZTQUEUED) ZTREQ="@"
 S IOP="HOME" D ^%ZISC
 Q
ATS(REG,EXP,LN) ;
 ;*** Split allergies and adverse reactions from the allergy package.
 ;*** INPUT ***
 ;*** REG - the length the allergies and adv. reactions display on 1 pg.
 ;*** EXP - the length that will display on extra page.
 ;*** LN  - for MAR, allergies and reations are display on 1 line.
 ;        - for Profile, display allergies and reactions on separate ln.
 ;*** OUTPUT ***
 ;*** PSGALG - Allergies array.
 ;*** PSGADR - Adverse Reactions array.
 ;***** rlw - 1/16/96 added PSGVALG for verified allergies and PSGVADR for verified adverse reactions.
GETGMRA ;
 N GMRA,GMRAL,GMRANKA,GMRAOTH,LEN,X,Y,TYPE,NAME,SORT,ALG,VALG,ADR,VADR,ALGCT,VALGCT,ADRCT,VADRCT,VERIFIED
 K PSGADR,PSGALG,PSGVADR,PSGVALG
 S (VALGCT,ALGCT,VADRCT,ADRCT,PSGVALG,PSGALG,PSGVADR,PSGADR)=0,(PSGVALG(1),PSGALG(1),PSGVADR(1),PSGADR(1))=""
 S:'$G(DFN)&$G(PSGP) DFN=PSGP
 S:'$G(PSGP)&$G(DFN) PSGP=DFN
 S GMRA="0^0^111",DFN=PSGP D ^GMRADPT
 I $G(PSJWHERE)="PSJLMUTL" S PSJGMRAL=GMRAL Q:(GMRAL="")!(GMRAL=0)
 I GMRAL="" S:$E(IOST)="P" (PSGVALG,PSGALG,PSGVADR,PSGADR)=20,$P(PSGALG(1),"_",20)=" ",(PSGVALG(1),PSGADR(1),PSGVADR(1))=PSGALG(1) Q
 I GMRAL=0 S (PSGVALG,PSGALG)=3,(PSGALG(1),PSGVALG(1))="NKA" S:$E(IOST)="P" PSGADR=20,$P(PSGADR(1),"_",20)=" ",PSGVADR=20,PSGVADR(1)=PSGADR(1) Q
 ;
SORT ;*** Set up the allergies and adv. reactions arrays.
 F X=0:0 S X=$O(GMRAL(X)) Q:'X  S TYPE=$P(GMRAL(X),U,5),NAME=$P(GMRAL(X),U,2),VERIFIED=$P(GMRAL(X),U,4) D
 .S SORT=$P(GMRAL(X),U,7),SORT=$S(SORT="D":1,SORT="DF":2,SORT="DFO":3,SORT="DO":4,SORT="F":5,SORT="FO":6,1:7)
 .S:(TYPE=0)&(VERIFIED=1) PSGVALG=PSGVALG+$L(NAME),VALGCT=VALGCT+1,VALG(SORT_NAME)=""
 .S:(TYPE=0)&(VERIFIED=0) PSGALG=PSGALG+$L(NAME),ALGCT=ALGCT+1,ALG(SORT_NAME)=""
 .S:(TYPE>0)&(VERIFIED=0) PSGADR=PSGADR+$L(NAME),ADRCT=ADRCT+1,ADR(SORT_NAME)=""
 .S:(TYPE>0)&(VERIFIED=1) PSGVADR=PSGVADR+$L(NAME),VADRCT=VADRCT+1,VADR(SORT_NAME)=""
 ;
CALLEN ;*** Calculate the total length for allergy and adv.reaction arrays.
 S:VALGCT>1 PSGVALG=PSGVALG+((VALGCT-1)*2) S:$E(IOST)="P"&'PSGVALG PSGVALG=20,$P(PSGVALG(1),"_",20)=" "
 S:ALGCT>1 PSGALG=PSGALG+((ALGCT-1)*2) S:$E(IOST)="P"&'PSGALG PSGALG=20,$P(PSGALG(1),"_",20)=" "
 S:VADRCT>1 PSGVADR=PSGVADR+((VADRCT-1)*2) S:$E(IOST)="P"&'PSGVADR PSGVADR=20,$P(PSGVADR(1),"_",20)=" "
 S:ADRCT>1 PSGADR=PSGADR+((ADRCT-1)*2) S:$E(IOST)="P"&'PSGADR PSGADR=20,$P(PSGADR(1),"_",20)=" "
 S (VALGCT,ALGCT,VADRCT,ADRCT)=1
 S:LN=1 LEN=$S((PSGALG+PSGVALG+PSGADR+PSGVADR)>REG:EXP,1:REG)
 S:LN>1 LEN=$S($S(PSGALG>REG:1,PSGADR>REG:1,PSGVALG>REG:1,PSGVADR>REG:1,1:0):EXP,1:REG)
 ;
SETARRAY ;*** Concatenate allergies and adv. reaction together into display len.
 S (X,Y)="" F  S X=$O(VALG(X)) Q:X=""  S:LEN'>($L(Y)+$L(X)+1) PSGVALG(VALGCT)=Y_",",Y="",VALGCT=VALGCT+1 S:Y]"" Y=Y_", " S Y=Y_$E(X,2,$L(X))
 S:$G(PSGVALG(VALGCT))="" PSGVALG(VALGCT)=Y
 S (X,Y)="" F  S X=$O(ALG(X)) Q:X=""  S:LEN'>($L(Y)+$L(X)+1) PSGALG(ALGCT)=Y_",",Y="",ALGCT=ALGCT+1 S:Y]"" Y=Y_", " S Y=Y_$E(X,2,$L(X))
 S:$G(PSGALG(ALGCT))="" PSGALG(ALGCT)=Y
 S (X,Y)="" F  S X=$O(ADR(X)) Q:X=""  S:LEN'>($L(Y)+$L(X)+1) PSGADR(ADRCT)=Y_",",Y="",ADRCT=ADRCT+1 S:Y]"" Y=Y_", " S Y=Y_$E(X,2,$L(X))
 S:$G(PSGADR(ADRCT))="" PSGADR(ADRCT)=Y
 S (X,Y)="" F  S X=$O(VADR(X)) Q:X=""  S:LEN'>($L(Y)+$L(X)+1) PSGVADR(VADRCT)=Y_",",Y="",VADRCT=VADRCT+1 S:Y]"" Y=Y_", " S Y=Y_$E(X,2,$L(X))
 S:$G(PSGVADR(VADRCT))="" PSGVADR(VADRCT)=Y
 Q
 ;
NAMENEED(DRGX,LEN,NEED)  ;*** Return the number of lines needed.
 ;*
 ;* DRG - AD/SOL     LEN - Drug name length   NEED - line needed
 ;*
 S NEED=0
 F X=0:0 S X=$O(DRG(DRGX,X)) Q:'X  D NAME^PSIVUTL(DRG(DRGX,X),LEN,.NAME,1) S NEED=NEED+$S($G(NAME(2))]"":2,1:1) I DRGX="SOL",$P(^PS(52.7,+DRG(DRGX,X),0),U,4)]"" S NEED=NEED+1
 Q
RAD ;
 I $T(HAVEHDR^ORRDI1)']"" Q
 I '$$HAVEHDR^ORRDI1 Q
 S PSGRALG=1,PSGRALG(1)="No remote data available"
 I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) G REMOTE2
 I $T(GET^ORRDI1)]"" D GET^ORRDI1(DFN,"ART") D
 . N S1,REAC,A,FILE,LEN K ^TMP($J,"PSJART")
 . S S1=0,LEN=57,PSGRALG=1,PSGRALG(1)="" F  S S1=$O(^XTMP("ORRDI","ART",DFN,S1)) Q:'S1  D
 .. S A=$G(^XTMP("ORRDI","ART",DFN,S1,"REACTANT",0)),REAC=$P(A,"^",2),FILE=$P($P(A,"^",3),"99VA",2)
 .. I FILE'=50.6,FILE'=120.82,FILE'=50.605,FILE'=50.416 Q
 .. S ^TMP($J,"PSJART",REAC)=""
 . S REAC="" F  S REAC=$O(^TMP($J,"PSJART",REAC)) Q:REAC=""  D
 .. I $L(PSGRALG(PSGRALG))+$L(REAC)<LEN S PSGRALG(PSGRALG)=PSGRALG(PSGRALG)_REAC_", " Q
 .. S PSGRALG=PSGRALG+1,PSGRALG(PSGRALG)="                "_REAC_", ",LEN=77
 . S A=$L(PSGRALG(PSGRALG)) I $E(PSGRALG(PSGRALG),A-1,A)=", " S PSGRALG(PSGRALG)=$E(PSGRALG(PSGRALG),1,A-2)
REMOTE2 ;
 S ^TMP("PSJALL",$J,PSJLN,0)="              Remote: "_$G(PSGRALG(1)),PSJLN=PSJLN+1
 F I=2:1:PSGRALG S ^TMP("PSJALL",$J,PSJLN,0)=PSGRALG(I),PSJLN=PSJLN+1
 Q 
