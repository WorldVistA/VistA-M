PSNPPIP ;BIR/DMA-WRT-print a medication instruction sheet ; 12 Apr 2007  8:38 AM
 ;;4.0; NATIONAL DRUG FILE;**3,7,30,62,84,141,181**; 30 Oct 98;Build 3
 ;
 ; Reference to ^PS(59.7 supported by IA #2613
 ; Reference to ^PSDRUG supported by IA #221
 ; Reference to ^ps(55 supported by IA #2191
 ;
PICK ;select a drug from file 50
 D DEFLT
 I $D(PSNDRUG) Q
 ;
 I '$D(^PS(50.621))!'$D(^PS(50.622)) W !,"Patient Medication Instruction Sheets data has not been installed",!! G PAUSE
 ;
 K DRG F  S DIC=50,DIC(0)="AEQMZ",DIC("S")="I $S('$G(^PSDRUG(+Y,""I"")):1,DT'>^(""I""):1,1:0)" D ^DIC K DIC Q:Y<0  D
 .I '$G(^PSDRUG(+Y,"ND")) W !,"Drug not matched to NDF" Q
 .;
 .S PSNGCN=""
 .S X=^PSDRUG(+Y,"ND"),X=$P($G(^PSNDF(50.68,+$P(X,"^",3),1)),"^",5) I 'X W !,"Sorry No PMI sheet available" Q
 .S DRG(+Y)=X
 I '$O(DRG(0)) G PAUSE
EN1 ; entry
 K DIR S DIR(0)="S^1:English;2:Spanish",DIR("A")="Select Language " S:$D(PSNLANG) DIR("B")=PSNLANG D ^DIR K DIR I $D(DIRUT) G PAUSE
 ;
 ;If PSNTYPE=2 then branch to English 50.621 at DOONE
 ;If PSNTYPE=5 then branch to Spanish 50.622 at DOONE
 S PSNTYPE=$S(Y=1:2,1:5)
 ;order in the file is 1=English, 2=Spanish
 ;
 S DIR(0)="N^1:100:0",DIR("A")="How many copies? ",DIR("B")=1 D ^DIR K DIR I $D(DIRUT) G PAUSE
 S NUM=Y
 K ZTSAVE S (ZTSAVE("PSNTYPE"),ZTSAVE("DRG("),ZTSAVE("NUM"),ZTSAVE("PSNDFN"),ZTSAVE("PSNTRADE"),ZTSAVE("PSRX"))="" S:$D(PSNPRTR) %ZIS("B")=PSNPRTR
 D EN^XUTMDEVQ("DOMORE^PSNPPIP","Print Medication Information Sheets",.ZTSAVE,.%ZIS) I 'POP G QUIT
 W !,"No device selected and no PMIS printed",!
PAUSE R !,"Press return to continue",X:10
QUIT K ^TMP($J,"W"),CNTI,CNTO,DIRUT,DRUG,DRG,IN,J,K,LIN0,LINE,LM,NAM,NUM,PG,POP,PSNGCN,PPIN1,PPIN2,PPIND,RM,QUIT,SPEC,TYP,PSNTYPE,X,Y,ZTDESC,ZTRTN,ZTSAVE,DEFLANG,DEFPRTR,PSNDEV,PSNLANG,PSNPRTR,I,N,L,LENGTH,PROD,P,PSNALPHA
 K PSNBND,PSNBOLD,PSNEMAP,PSNENG,PSNFLAG,PSNLAST,PSNORM,PSNSP D:'$D(PSODFN) KILL^%ZISS Q
 Q
 ;
 Q
 ;
DOMORE ;multiple
 S DRG=0 F  S DRG=$O(DRG(DRG)) Q:'DRG  S PSNGCN=DRG(DRG) D DOONE
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
DOONE ;Print one PMI sheet
 ;needs PSNTYPE=1-6 (English, etc.),NUM=# of copies
 ;DRG=IFN in file 50
 ;optional DFN=DFN for a particular patient
 ;
 N LINE,LIN0,CNTI,CNTO,X,IN,RM,LM,J,K,DRUG,SPEC,NAM
 S NUM=$G(NUM,1),PSNTYPE=$G(PSNTYPE,2)
 ;default is one copy of Standard English
 K ^TMP($J,"W")
 I $D(PSNDFN) S DFN=PSNDFN,NAM=$P(^DPT(DFN,0),"^") D DEM^VADPT
 S LM=3,RM=IOM-5,$P(LIN0," ",LM)="",LINE=LIN0  ;,SPEC("[]")="[] "
 ;Get drug name - 
 ;1.TRADE NAME from 52 if called from PSO
 ;2. VA PRINT NAME from 50.68
 ;3. GENERIC NAME from 50
 ;
 K DRUG I $G(PSNTRADE)'="" S DRUG=PSNTRADE
 I '$D(DRUG) S DRUG=$P(^PSDRUG(DRG,0),"^"),X=$G(^("ND")),J=+X,K=+$P(X,"^",3),X=$P($G(^PSNDF(50.68,K,1)),"^") I X]"" S DRUG=X
 ;
 ;NEW CODE Takes GCNSEQNO (PSNGCN) and finds the drug IEN in 
 ;the PMI MAP-English file (50.623)  That IEN points to the text
 ;in the PMIS-English file
 ;
 ;Select files based on whether user wants English or Spanish
 I PSNTYPE=2 S PSNFILE1=50.623    ;PMI-MAP ENGLISH file
 I PSNTYPE=2 S PSNFILE2=50.621    ;PMI-ENGLISH file
 I PSNTYPE=5 S PSNFILE1=50.624    ;PMI-MAP SPANISH file
 I PSNTYPE=5 S PSNFILE2=50.622    ;PMI-SPANISH file
 ;
  ; S PSNEMAP=0,PSNENG=""
  S PSNEMAP="",PSNENG=""
 I '$O(^PS(PSNFILE1,"B",PSNGCN,0)) I '$D(PSODFN) W @IOF W !,"Drug is not linked to a valid Medication Information Sheet for language selected" K PSNGCN,PSNDF,PSNPN Q
 I '$O(^PS(PSNFILE1,"B",PSNGCN,0)) I $D(PSODFN) S PSNPPI("MESSAGE")="Drug is not linked to a valid Medication Information Sheet for language selected",PSNFLAG=0 K PSNGCN,PSNDF,PSNPN W PSNPPI("MESSAGE"),! Q
 S PSNEMAP=$O(^PS(PSNFILE1,"B",PSNGCN,0)) D
 .I $P(^PS(PSNFILE1,PSNEMAP,0),U)=PSNGCN D
 ..S PSNENG=$P(^PS(PSNFILE1,PSNEMAP,0),U,2)  ;Drug D0 Eng/Span file
 I +PSNENG=0 W !,"No PMI sheet available" Q
 ;
 S CNTI=0,CNTO=1,PSNSP=""    ;NOTE  PSNSP is a blank line insert
 ;
IMP ;Important note about the drug of choice
 ;
 I $D(IOST(0)) S X="IOINHI;IOINORM;IOINLOW" D ENDR^%ZISS
 S PSNALPHA=""
 S PSNALPHA="Z" D TXT1
 ;
TITLE ;Title and phonic pronunciation
 ;
 I '$D(^PS(PSNFILE2,+PSNENG,"F")) D
 .S ^TMP($J,"W",CNTO)=$G(IOINHI)_^PS(PSNFILE2,+PSNENG,CNTI)
 .S CNTO=CNTO+1
 ; .S ^TMP($J,"W",CNTO)=PSNSP S CNTO=CNTO+1   ;Insert blank line
 ;
 I $D(^PS(PSNFILE2,+PSNENG,"F")) D
 .S ^TMP($J,"W",CNTO)=$G(IOINHI)_^PS(PSNFILE2,+PSNENG,CNTI)_" "_$G(IOINORM)_^PS(PSNFILE2,+PSNENG,"F",1,0) S CNTO=CNTO+1
 S ^TMP($J,"W",CNTO)=PSNSP S CNTO=CNTO+1   ;Insert blank line
 ;
 ;
BRAND ;Common Brand Name
 ;
 D ^PSNPPIP1
 ;
 F PSNALPHA="W","U","H","S","M","P","I","O","N","D","R" D:$D(^PS(PSNFILE2,+PSNENG,PSNALPHA)) TXT1
 D PRINT
 Q
 ;
TXT1 ;Text portion
 ;
 S J=0,N=1,LINE(N)="",PSNLAST=999
 S L=1,LINE(L)="",PSNBOLD="",PSNORM=""
 ;
 S PSNLAST=$O(^PS(PSNFILE2,+PSNENG,PSNALPHA,PSNLAST),-1)  ;Last subscripT
 ;
 F  S J=$O(^PS(PSNFILE2,+PSNENG,PSNALPHA,J)) Q:'J  D ONELN^PSNPPIP1 D
 .S LINE=^PS(PSNFILE2,+PSNENG,PSNALPHA,J,0)
 .I J=PSNLAST D  Q
 ..I (N-1)'=0 S LINE(L)=LINE(N-1)_" "_LINE                  ;Last lines
 ..I $L(LINE(L))>IOM D   ;S LINE(M)=$E(LINE(L),1,IOM) D
 ...F I=IOM:-1:1 I $E(LINE(L),I)[" " D  Q
 ....S ^TMP($J,"W",CNTO)=$E(LINE(L),1,I) S CNTO=CNTO+1
 ....S ^TMP($J,"W",CNTO)=$E(LINE(L),I+1,999)
 ....S CNTO=CNTO+1
 ..I $L(LINE(L))'>IOM D
 ...S ^TMP($J,"W",CNTO)=LINE(L) S CNTO=CNTO+1
 .I N>1 S LINE(N-1)=LINE(N-1)_" "_$E(LINE,1,A) D      ;Middle lines
 ..I $L(LINE(N-1))<IOM S A=IOM-$L(LINE(N-1)) Q
 ..D BRK
 ..S N=N+1,CNTO=CNTO+1
 .I N=1 S LINE(N)=LINE(N)_" "_LINE,P=LINE(N) D
 ..F I=1:1:$L(P) I $E(P,I)=":" D
 ...S PSNBOLD=$G(IOINHI)_$E(P,1,I-1),PSNORM=$G(IOINORM)_$E(P,I,999)     ;BOLD Section header
 ..S LINE(N)=PSNBOLD_PSNORM
 ..I $E(LINE(N),1)[" " S LINE(N)=$E(LINE(N),2,999)    ;Remove lead space
 ..S LENGTH=$L(LINE(N)),A=IOM-LENGTH
 ..S N=N+1
 ;
 S:$D(^PS(PSNFILE2,+PSNENG,PSNALPHA)) ^TMP($J,"W",CNTO)=PSNSP S:$D(^PS(PSNFILE2,+PSNENG,PSNALPHA)) CNTO=CNTO+1   ;Insert blank line
 Q
 ;
BRK ;Break line between words rather than within a word
 ;
 F I=IOM:-1:1 I $E(LINE(N-1),I)[" " D  Q
 .S ^TMP($J,"W",CNTO)=$E(LINE(N-1),1,I)
 .S LINE(N)=$E(LINE(N-1),I+1,999)_$E(LINE,A+1,999)
 .I $E(LINE(N),1)[" " S LINE(N)=$E(LINE(N),2,999)    ;Remove lead space
 .S LENGTH=$L(LINE(N)),A=IOM-LENGTH
 ;
 Q
 ;
PRINT ;
 S QUIT=0 F J=1:1:NUM Q:QUIT  S PG=1 D HEAD Q:QUIT  F K=1:1 Q:'$D(^TMP($J,"W",K))  W ^(K),! I $Y+4>IOSL D HEAD Q:QUIT
 Q
HEAD ;
 I PG>1,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S QUIT=1 Q
 W:$Y @IOF W !!,?70,$S(PSNTYPE<4:"Page ",1:"P"_$C(160)_"gina "),PG,!,LIN0,$S(PSNTYPE<4:"Medication instructions for ",1:"Informaci"_$C(162)_"n sobre su medicin a  "),DRUG S PG=PG+1
 I $D(NAM) W !!,?2,"Printed for: ",NAM,?60,$$HTE^XLFDT(+$H),!,?2,"Rx Number:   "_$G(PSRX)
 W !!! Q
 ;
 ;
DICS ;set DIC("S") to screen out inactives and entries in file 50
 ;that are not linked through NDF to a PMI sheet
 N QQQ S QQQ=$G(^PSDRUG(+Y,"ND")),QQQ=$P($G(^PSNDF(50.68,+$P(QQQ,"^",3),1)),"^",5) I QQQ,$D(PSNGCN),$S('$G(^PSDRUG(+Y,"I")):1,DT'>^("I"):1,1:0)
 S QQQ=$G(^PSDRUG(+Y,0))
 ;reset naked indicator
 Q
ENOP(PSNDRUG,PSNTRADE,PSRX,PSNDFN) ;
 ;
 ;  entry point from Outpatient Pharmacy
 ;  PSNDRUG = IFN from the DRUG file (50)  ** REQUIRED **
 ;  PSRX = IFN from the PRESCRIPTION file (52)  ** OPTIONAL **
 ;  PSNTRADE = Trade Name in printable format  ** OPTIONAL **
 ;  PSNDFN = Patient's DFN  ** OPTIONAL **
 ;
 ; This entry point returns the variable PSNFLAG, it will
 ; be equal to 1 if the information sheet can be printed or
 ; it will be equal to 0 if an information sheet cannot be
 ; printed.  If PSNFLAG=0, the variable PSNPPI("MESSAGE") will
 ; be returned containing a message stating why an information
 ; sheet could not be printed.
 ;
 K DRG,PSNPN
 S PSNFLAG=1,DRG=PSNDRUG,PSNDF=$G(^PSDRUG(PSNDRUG,"ND"))
 S PSNPN=$P(PSNDF,"^",3),PSNDF=+PSNDF
 I 'PSNDF S PSNPPI("MESSAGE")="This drug is not matched to the National Drug File; therefore, a Medication Information Sheet cannot be printed.",PSNFLAG=0  K PSNDF,DRG,PSNPN Q
LANGE S DEFLANG=$P($G(^PS(59.7,1,10)),"^",7) I DEFLANG]"" S PSNLANG=$S(DEFLANG=1:"English",1:"Spanish") S:PSNLANG="English" PSNTYPE=2 S:PSNLANG="Spanish" PSNTYPE=5
 S PSNGCN=$P($G(^PSNDF(50.68,PSNPN,1)),"^",5)
 ;
 I 'PSNGCN S PSNPPI("MESSAGE")="This drug is not linked to a Medication Information Sheet.",PSNFLAG=0 K PSNGCN,DRG,PSNDF,PSNPN Q
 I PSNFLAG S DRG(DRG)=PSNGCN D EN1
 K PSNDRUG,PSNTRADE,PSNDF,PSNPN,PSNGCN,DRG
 ;
 Q
DEFLT S DEFLANG=$P($G(^PS(59.7,1,10)),"^",7) I DEFLANG]"" S PSNLANG=$S(DEFLANG=1:"English",1:"Spanish")
 N A1 S A1=$$GET1^DIQ(55,$G(PSNDFN)_",",106.1,"I"),DEFLANG=$S(A1=2:"Spanish",A1=1:"English",1:DEFLANG)
 S DEFPRTR=$P($G(^PS(59.7,1,10)),"^",6) I DEFPRTR]"" S DIC="^%ZIS(1,",DA=DEFPRTR,DR=".01",DIQ="PSNDEV",DIQ(0)="E" D EN^DIQ1 S PSNPRTR=$G(PSNDEV(3.5,DA,.01,DIQ(0)))
 Q
