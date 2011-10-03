DVBHQUP ;ALB/JLU  This routine is used for the upload option. ; 3/9/06 4:16pm
 ;;4.0;HINQ;**12,49,56**;03/25/92 
A D A^DVBHUTIL
B W !
B1 R !,"Do you want to examine the Suspense file by 'P'atient or 'A'll  P// ",K1:DTIME G:'$T KA1 D P:"Pp"[K1!(K1=""),L:"Aa"[$E(K1_1)
 G:DVBOUT="^" KA1
 I K1="?"!(K1'="^") W !!,*7,?15,"Answer with capital A or P <RET> also for P",!! G B1
KA1 D KA1^DVBHQEDT Q
KA D KA^DVBHQEDT
 Q
P S K1="^" K DVBDIQ D P1 I Y<0 S DVBOUT="^" Q
 N DVBQT,DVBTMP1,DVBTMP2
 S DIE="^DPT(",(DA,DFN)=+Y,DR="[DVBHINQ UPDATE]",DVBJ2=0 D TEM^DVBHIQR
 I '$D(DVBERCS) D CHKID^DVBHQD1
 I $G(DVBQT) D  G P
 . S DVBTMP1=$G(DVBNOALR)
 . S DVBTMP2=$G(DVBJ2)
 . S DVBNOALR=";4///a;5////"_DUZ_";6///N",DVBJ2=1 D FILE
 . S DVBNOALR=DVBTMP1
 . S DVBJ2=DVBTMP2
 D ^DIE:'$D(DVBERCS) K DIE,DR,DA
 D C I DVBOUT'="^" G P
 Q
L S ANS="",K1="^"
 I '$D(^DVB(395.5,"AC","N")) W !!,"No patients to be updated." H 3 Q
 F K2=0:0 S K2=$O(^DVB(395.5,"AC","N",K2)) Q:'K2!(DVBOUT="^")  D
 . I $D(^DVB(395.5,K2,"RS",0)),$P(^DVB(395.5,K2,0),U,5)'="Y",$P(^(0),U,5)'="I" D
 . . S DIE="^DPT(",(DA,DFN)=K2,DR="[DVBHINQ UPDATE]",DVBJ2=0 D TEM^DVBHIQR
 . . N DVBQT,DVBTMP1,DVBTMP2
 . . S DVBQT=1
 . . I '$D(DVBERCS) D CHKID^DVBHQD1 I DVBQT D  Q
 . . . S DVBTMP1=$G(DVBNOALR)
 . . . S DVBTMP2=$G(DVBJ2)
 . . . S DVBNOALR=";4///a;5////"_DUZ_";6///N",DVBJ2=1 D FILE
 . . . S DVBNOALR=DVBTMP1
 . . . S DVBJ2=DVBTMP2
 . . D ^DIE:'$D(DVBERCS) D C,KA Q:DVBOUT="^"
 Q
C ;SETS UPDATED? FIELD, RUNS INCONSIS. CHECKER.
 Q:DVBOUT["^"  S DVB=DFN,DVBLP=2,DVBMM=1,DVBMM2=1 D QB^DVBHQZ6
 Q:'DVBJ2  I DVBJ2 S $P(^DVB(395.5,DFN,0),U,5)="Y" S DGEDCN=1 D ^DGRPC I 1
 E  S $P(^DVB(395.5,DFN,0),U,5)="N"
 D FILE K DVBDIQ Q
 ;
 ;I '$D(^DVB(395.7,DFN,0)) K DIC,DD,DO S DIC(0)="LQ",DIC="^DVB(395.7,",DIC("DR")="1////"_DUZ_";2///"_"N",(X,DINUM)=DFN D FILE^DICN I 1
 ;E  S DIE="^DVB(395.7,",DA=DFN,DR="1////"_DUZ_";2///"_"N" D ^DIE
 ;
FILE I '$D(^DVB(395.7,DFN,0)) DO
 .K DIC,DD,DO S DIC(0)="LQ",DIC="^DVB(395.7,"
 .S DIC("DR")="1////"_DUZ_";2///"_"N"_$S($D(DVBNOALR):DVBNOALR,1:"")
 .S (X,DINUM)=DFN D FILE^DICN
 E  DO
 .K DIC S (DIC,DIE)="^DVB(395.7,",DA=DFN
 .S DR="1////"_DUZ_";2///"_"N"_$S($D(DVBNOALR):DVBNOALR,1:"")
 .I 'DVBJ2,$D(DVBNOALR),DVBNOALR]"" S DR=$E(DVBNOALR,2,99)
 .L +^DVB(395.7,DFN):3 I $T D ^DIE
 .L -^DVB(395.7,DFN)
 K DIC,DIE,DA,DR Q
 ;
 ;ENRTY PT FOR PRINT OPTION
PT W @$S('$D(IOF):"#",IOF="":"#",1:IOF),!!!!!!!!!!
PT1 R "Do you want a print out of a (S)ingle patient or (A)ll of the patients?  S// ",DVBJA:DTIME G:'$T KA1 D S:DVBJA="S"!(DVBJA=""),T:DVBJA="A"
 I DVBJA="?"!(DVBJA'="^") W !!,*7,?15,"Answer with a capital A or S or <RET> for S",!! G PT1
 D KA1 Q
S D P1 I Y<0 S DVBJA="^" Q
 S (DFN,D0,ZTSAVE("D0"),ZTSAVE("DFN"))=+Y,ZTRTN="S1^DVBHQUP" D RP I $D(IO("Q"))!POP S DVBJA="^" Q
S1 U IO D TEM^DVBHIQR,^DVBHCG:'$D(DVBERCS) I '$D(ZTSK) X ^%ZIS("C")
 S DVBJA="^" Q
T S DVBJA="^",ZTRTN="RP1^DVBHQUP"
 W !!,?6,"Select one of the following:",!!,?11,"1   Updated",!,?11,"2   NOT  Updated",!,?11,"3   Both",!,"How would you like your print sorted?  Updated//"
 R Y:DTIME Q:Y="^"!('$T)
 S (ZTSAVE("DVBY"),DVBY)=$S(Y=1!(Y="")!(Y["U"):1,Y=2!(Y["N"):2,Y=3!(Y["B"):3,1:"")
 I DVBY="" W !!,*7,"Answer with a code from the list." G T
 D CT Q
 ;
AU ;ENTRY POINT FOR DISPLAY OF AUDIT.
 W @$S('$D(IOF):"#",IOF="":"#",1:IOF),!!!!!
AU1 W !!,?6,"Select one of the following:",!!,?11,"1   Patient",!,?11,"2   User",!,?11,"3   Date/Time",!,"By which would you like the sort to begin? : Patient//"
 R Y:DTIME Q:Y="^"!('$T)
 S (FLDS,BY)=$S(Y=1!(Y="")!(Y["P"):"[DVBHINQ AUDIT/PAT]",Y=2!(Y["U"):"[DVBHINQ AUDIT/USER]",Y=3!(Y["D"):"[DVBHINQ AUDIT/DT]",1:"")
 I BY="" W !!,*7,"Answer with a code from the above list." G AU1
 S L=0,DIC="^DVB(395.7,",(FR,TO)="" D EN1^DIP Q
 ;
P1 W ! D KA S DIC="^DVB(395.5,",DIC(0)="AEMZQ",DIC("S")="I ($P(^(0),U,4)=""N""),($D(^(""RS"",0)))",DIC("A")="Select Patient from ""HINQ Suspense file"":" D ^DIC K DIC Q
 ;
RP S %IS="MQ" D ^%ZIS Q:POP  I $D(IO("Q")) S ZTDESC="This is a job for the HINQ report.",ZTIO=ION D ^%ZTLOAD X ^%ZIS("C") Q
 Q:DVBJA=""!(DVBJA="S")
RP1 S DVB8="" U IO F D0=0:0 S (D0,DFN)=$O(^DVB(395.5,"AC","N",D0)) Q:'D0  S DVBJ1=$S((DVBY=1)&($P(^DVB(395.5,D0,0),U,5)="Y"):1,(DVBY=2)&($P(^(0),U,5)'="Y"):1,DVBY=3:1,1:0) D:DVBJ1 TEM^DVBHIQR,^DVBHCG:'$D(DVBERCS) Q:DVB8["^"  D KA
 I '$D(ZTSK) X ^%ZIS("C")
 Q
 ;
CT S DVB1=0 F DVB=0:0 S DVB1=$O(^DVB(395.5,"AC","N",DVB1)) Q:'DVB1  S DVB=$S(DVBY=1&($P(^DVB(395.5,DVB1,0),U,5)="Y"):DVB+1,DVBY=2&($P(^(0),U,5)'="Y"):DVB+1,DVBY=3:DVB+1,1:DVB)
 I 'DVB W !,"There are no patients at this time for this print." Q
CT1 W !!,"There are ",DVB," patients for this report, do you wish to continue" S %=1 D YN^DICN Q:%=2!(%<0)  I '% W !,"A YES answer will continue on with the report, answer with Y or N" G CT1
 D RP Q
LSTR ;lists the SC disabilities in the ReviewPatient vs. HINQ data 
 ;option, [DVB HUPLOAD-PRINT]
 ;called from print template [DVBHINQ PAT-HINQ COMP]
 N DVBIEN
 K DVBERR
 D GETS^DIQ(2,DFN_",",".302;.3014;.3721*","EI","DVBDIQ","DVBERR")
 W "-Comb. SC%: "_+DVBDIQ(2,DFN_",",.302,"E")_"  "
 W "Eff. Date Comb. Eval.: "_DVBDIQ(2,DFN_",",.3014,"E")
 I $P($G(^DPT(DFN,.372,0)),U,3)>0 D LABELS^DVBHS3
 S LP=""
 I $D(DVBDIQ(2.04)) F  S LP=$O(DVBDIQ(2.04,LP)) Q:'LP  D
 . I ($Y+5)>IOSL,$E(IOST,1,2)="C-" D PAUSE^DVBHS3
 . W !,$E(DVBDIQ(2.04,LP,.01,"E"),1,40),?42,DVBDIQ(2.04,LP,2,"E")
 . W ?50,$G(DVBDIQ(2.04,LP,4,"I")),?55,$G(DVBDIQ(2.04,LP,5,"E"))
 . W ?68,$G(DVBDIQ(2.04,LP,6,"E"))
 Q
 N DVBFR,DVBLAST,DVBX,QUIT
 S DVBFR=""
 S DVBLAST=$O(^DPT(DFN,.372,""),-1)
 I $G(DVBLAST)']"" Q
 F DVBX=0:0 D LOOP I $G(QUIT)=1!(DVBFR(2)>DVBLAST) K QUIT Q
 Q
LOOP ;
 D LIST
 N DVBCT
 F DVBCT=0:0  S DVBCT=$O(DVBARR("DILIST",DVBCT)) Q:'DVBCT!(DVBCT>19)  D
 . W !?36,$P(DVBARR("DILIST",DVBCT,0),U,2),?68,$P(DVBARR("DILIST",DVBCT,0),U,4),?74,$P(DVBARR("DILIST",DVBCT,0),U,5)
 D PAUSE^DVBHS3
 Q
LIST ;
 D LIST^DIC(2.04,","_DFN_",",".01;2;3","P",20,.DVBFR,,,,,"DVBARR",)
 I $G(DVBFR(2))'>0 S QUIT=1
 Q 
