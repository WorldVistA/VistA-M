PSOTPCLP ;BIRM/PDW-PRINT PATIENT LETTERS ;AUG 5,2003
 ;;7.0;OUTPATIENT PHARMACY;**145,227,233**;DEC 1997;Build 8
 Q
PRINT ; select options
 Q  ;placed out of order by patch PSO*7*227
 K ^TMP($J,"TPBLET"),TMP($J,"TPCLW")
 D EXIT ;INITIALIZE
 ;build INST to show incompleted Institutions
 K INST S DIVDA=0 F  S DIVDA=$O(^PS(52.92,DIVDA)) Q:DIVDA'>0  D
 . S INST(DIVDA)=$$GET1^DIQ(52.92,DIVDA,.01)
 S XX=$$INSTCHK^PSOTPCL I $G(PSOSTOP) Q
 K INST S DIVDA=0 F  S DIVDA=$O(^PS(52.92,DIVDA)) Q:DIVDA'>0  D
 . Q:$$CHKINST^PSOTPCL(DIVDA)
 . S INST(DIVDA)=$$GET1^DIQ(52.92,DIVDA,.01)
 K PARAM,PATLST
 K DIR S DIR(0)="SO^A:Print all letters that have not printed;P:Print letter by a patient or multiple patients;I:Print by institution (all, one, or a selection)" D ^DIR
 I Y="A" S PARAM("SORT")="I",PATLST="",PARAM("LP")="N" G DEVICE
 I Y="P" G PATIENT
 I Y="I" G DIVISION
 W !,"None Selected - Quitting",! H 3
 G EXIT
PATIENT ; print by patients
 S PARAM("SORT")="P",PARAM("LP")="B"
 D PATSEL ; build PATLST("patient name")=DFN
 G:($D(PATLST)<10) EXIT
 G DEVICE
DIVISION ;print by division
 K DIR S DIR(0)="SO^N:Letters NOT Printed;P:Letters Printed;B:Both"
 D ^DIR Q:"NPB"'[Y
 S PARAM("LP")=Y
 S PARAM("SORT")="I"
 K INST D SEL^PSOTPCL
 I ($D(INST)<10) W !,"No Selection Made - Quitting",! H 3 G EXIT
 G DEVICE
PATSEL ; Select one or more patients
 K PATLST
 S DIC="^PS(52.91,",DIC(0)="AEQM",DIC("W")="D DSPPAT^PSOTPCLP(+Y)"
 F  S DIC("W")="D DSPPAT^PSOTPCLP(+Y)" D ^DIC Q:Y'>0  S DFN=+Y,PTNM=$$GET1^DIQ(52.91,DFN,.01),PATLST(PTNM,DFN)="" D
 . ;test death date
 . S XX=$$GET1^DIQ(2,DFN,.351) I XX'="" D  Q
 .. W !!,"Sorry, ",PTNM," died ",XX,!
 .. K PATLST(PTNM,DFN) H 3
 . ;test expired date
 . S EXPDTI=$$GET1^DIQ(52.91,DFN,2,"I")
 . I EXPDTI,DT>EXPDTI D
 .. S EXPDT=$$GET1^DIQ(52.91,+DFN,2)
 .. W !,"Sorry, ",PTNM,"'s eligibility expired ",EXPDT,! K PATLST(PTNM,DFN)
 . ;check divisions required data
 . S DIVDA=$$GET1^DIQ(52.91,DFN,7,"I")
 . S XX=$$CHKINST^PSOTPCL(DIVDA) I XX D
 .. W !!,"Sorry, ",$$GET1^DIQ(52.91,DFN,7)," is missing required fields.",!!
 .. K PATLST(PTNM,DFN)
 ;
LST I ($D(PATLST)<10) W !,"No Patients Selected - Quitting",! H 3 S PATLST="" Q
 W !!,"You have selected:",!
 S PATNM="" F I=1:1 S PATNM=$O(PATLST(PATNM)) Q:'$L(PATNM)  S DFN=0 F  S DFN=$O(PATLST(PATNM,DFN)) Q:DFN'>0  W !,PATNM D DSPPAT(DFN) I '(I#20) D  D ^DIR I X["^" Q
 .K DIR S DIR(0)="E",DIR("A")="<cr> - Continue ""^"" - Stop Display"
 ;
 W ! K DIR S DIR(0)="Y",DIR("A")="Is the above correct ",DIR("B")="YES" D ^DIR
 I 'Y G PATSEL
 Q
DSPPAT(DFN) ; Display Division and expire date
 N DIVNM,EXPDT,PRTDT
 S DIVNM=$$GET1^DIQ(52.91,DFN,7) W ?32,$E(DIVNM,1,15)
 S EXPDT=$$GET1^DIQ(52.91,DFN,2,"I")
 I EXPDT S EXPDT=$$FMTE^XLFDT(EXPDT,"2D") W ?50,"Inact ",EXPDT
 S PRTDT=$$GET1^DIQ(52.91,DFN,11,"I")
 I PRTDT S PRTDT=$$FMTE^XLFDT(PRTDT,"2D") W ?66,"Prt ",PRTDT
 Q
DEVICE ;
 W !,"Queueing is recommended",!
 S %ZIS="Q" D ^%ZIS
 Q:POP
 I $D(IO("Q")) D  K ZTSK G EXIT
 . S (PATLST,INST,PARAM)=""
 . S ZTRTN="DEQUE^PSOTPCLP",ZTDESC="TPB PRINT PATIENT LETTERS"
 . F XX="PATLST*","INST*","PARAM*" S ZTSAVE(XX)=""
 . ;W ! ZW ZTRTN,ZTDESC,PATLST,INST,PARAM,ZTSAVE
 . D ^%ZTLOAD
 . I $G(ZTSK) W !!,"Tasked with "_ZTSK
 ;  (code falls through if not queued)
DEQUE ; DEQUE/PRINT LETTERS
 K ^TMP($J,"TPBLET")
 I PARAM("SORT")="P" G SORTPAT
 S DIVDA=0 F  S DIVDA=$O(INST(DIVDA)) Q:DIVDA'>0  D
 . S DFN=0 F  S DFN=$O(^PS(52.91,"AC",DIVDA,DFN)) Q:DFN'>0  D
 .. S PTNM=$$GET1^DIQ(52.91,DFN,.01)
 .. S EXPDTI=$P(^PS(52.91,DFN,0),"^",3),LTPDTI=$P(^(0),"^",12)
 .. Q:EXPDTI
 .. Q:$L($$GET1^DIQ(2,DFN,.351))
 .. I PARAM("LP")="N",LTPDTI Q
 .. I PARAM("LP")="P",'LTPDTI Q
 .. S ^TMP($J,"TPBLET",DIVDA,PTNM,DFN)=""
 G PRTLET
SORTPAT ; sort by patient
 K ^TMP($J,"TPBLET")
 S PTNM="" F  S PTNM=$O(PATLST(PTNM)) Q:PTNM=""  D
 . S DFN=0 F  S DFN=$O(PATLST(PTNM,DFN)) Q:DFN'>0  D
 .. S DA0=^PS(52.91,DFN,0),EXPDTI=$P(DA0,"^",3),LTPDTI=$P(DA0,"^",12),DIVDA=$P(DA0,"^",8)
 .. Q:EXPDTI
 .. I PARAM("LP")="N",LTPDTI Q
 .. I PARAM("LP")="P",'LTPDTI Q
 .. S ^TMP($J,"TPBLET",DIVDA,PTNM,DFN)=""
 G PRTLET
 Q
PRTLET ; pull DIVDAs and DFNs from ^TMP($J,"TPBLET",
 D LOADTMP^PSOTPCLW ; load letter body into TMP
 K DIVCNT
 S DIVDA=0 F  S DIVDA=$O(^TMP($J,"TPBLET",DIVDA)) Q:DIVDA'>0  D
 . S XX=$$CHKINST^PSOTPCL(DIVDA) I XX S DIVCNT(DIVDA)=0 Q
 . D DIV ;GETDIV(DIVDA) ;load institution/parent data for print
 . S PTNM="" F  S PTNM=$O(^TMP($J,"TPBLET",DIVDA,PTNM)) Q:PTNM=""  D
 .. S DFN=0
 .. F  S DFN=$O(^TMP($J,"TPBLET",DIVDA,PTNM,DFN)) Q:DFN'>0  D
 ... S DIVCNT(DIVDA)=$G(DIVCNT(DIVDA))+1
 ... D LETTER(DFN)
 ... S $P(^PS(52.91,DFN,0),U,12)=DT ;set print date
 ; summary of printing
 S Y=DT D D^DIQ S SRDT=Y
 W @IOF,!!,?10,"SUMMARY of TPB LETTER PRINTING   ",SRDT
 W !!
 I '$D(DIVCNT) W !!,"NO DATA TO PRINT",!! G EXIT
 S DIVDA=0 F  S DIVDA=$O(DIVCNT(DIVDA)) Q:DIVDA'>0  D
 . W !,?5,$$GET1^DIQ(52.92,DIVDA,.01),?40,DIVCNT(DIVDA)
 W !
 G EXIT
 ;
LETTER(DFN) ; print letter , division variables information must be present
 U IO
 D GETPAT(DFN)
 I EXPDT,EXPDT'>DT Q  ; patient inactive on printing date
 D HEADER
 F LN=1:1 Q:'$D(^TMP($J,"TPCLW","P1",LN))  W !,^(LN)
 W ?30,"PHARMACY SERVICE",!,?30,DIVNM
 I $L(MADD1) D  I 1
 . W !,?30,MADD1
 . W:$L(MADD2) !,?30,MADD2
 . W !,?30,MCITY,", ",MSTATE,"  ",MZIP
 E  W !,?30,ADD1 D
 . W:$L(ADD2) !,?30,ADD2
 . W !,?30,CITY,", ",STATE,"  ",ZIP
 F LN=1:1 Q:'$D(^TMP($J,"TPCLW","P2",LN))  W !,^(LN)
 W " ",PHN1 W:$L(PHN2) ", or ",PHN2 W ".",!
 F LN=1:1 Q:'$D(^TMP($J,"TPCLW","P3",LN))  W:LN>1 ! W ^(LN)
 W !!!!,?4,SIG1 W:$L(SIG2) !,?4,SIG2 W:$L(SIG3) !,?4,SIG3
 W !
 Q
GETPAT(DFN) ;GET PATIENT DATA
 K PTNM,EXPDT,SRANAME,TITLE,SRNM,PTSTATE,VADM,VAPA
 S PTNM=$$GET1^DIQ(52.91,DFN,.01),EXPDT=$$GET1^DIQ(52.91,DFN,2,"I")
 ;I EXPDT,DT'>EXPDT Q
 D DEM^VADPT,ADD^VADPT
 S PTLNM=$P(PTNM,","),PTXNM=$P(PTNM,",")
 S SRANAME=$P(VADM(1),"^"),X=$P(SRANAME,","),Y=$E(X)_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S TITLE=$S($P(VADM(5),"^")="F":"Ms. ",1:"Mr. "),SRANAME=TITLE_Y
 S Y=DT D D^DIQ S SRDT=Y
 S SEX=$P(VADM(5),"^")
 S SRNM=$P(VADM(1),",",2)_" "_$P(VADM(1),",")
 S PADD1=$G(VAPA(1)),PADD2=$G(VAPA(2)),PADD3=$G(VAPA(3))
 S PCITY=$G(VAPA(4)),PTSTATE=$P($G(VAPA(5)),U,2),PZIP=$G(VAPA(6))
 N PSOBADR,PSOTEMP
 S PSOBADR=$$BADADR^DGUTL3(DFN) I PSOBADR S PSOTEMP=$$CHKTEMP^PSOBAI(DFN) D
 .I 'PSOTEMP S PADD1="** BAD ADDRESS INDICATED **",PADD2="",PADD3="",PCITY="",PSTATE="",PZIP=""
CCADD ; Get Confidential Correspondence Address if one is active
 ; and has the category "all other".
 ;
 ; See if CC address exists
 I '$G(VAPA(12)) Q
 ; code to check the CC category in the variable array VAPA(22)
 ; check catagories
 S XX=0 F CC=1,2,5 I $P($G(VAPA(22,CC)),U,3)="Y" S XX=1
 Q:'XX
 S SRCCADD=1
 S:$G(VAPA(17)) PTSTATE=$P(^DIC(5,$P(VAPA(17),"^"),0),"^",2)
 S PADD1=$G(VAPA(13)),PADD2=$G(VAPA(14)),PADD3=$G(VAPA(15))
 S PCITY=$G(VAPA(16)),PTSTAT=$P(VAPA(17),U,2),PZIP=$P(VAPA(18),U,2)
 Q
HEADER ; print letter header
 U IO
 W @IOF
 W !!,?(80-$L(DIVNM))\2,DIVNM
 W !,?(80-$L(ADD1))\2,ADD1
 W:$L(ADD2) !,?(80-$L(ADD2))\2,ADD2
 S XX=CITY_", "_STATE_" "_ZIP
 W !,?(80-$L(XX))\2,XX
 F Y=$Y:1:10 W !
 W !,?4,SRNM,?65,SRDT,!,?4,PADD1 I PADD2'="" W !,?4,PADD2 I PADD3'="" W !,?4,VAPA(3)
 W:PCITY'="" !,?4,PCITY_", "_PTSTATE_" "_PZIP W !!!
 Q
DIV D GETDIV(DIVDA)
 I $L(PARDIV) S DIVDA2=$$GET1^DIQ(52.92,DIVDA,.02,"I") D GETDIV(DIVDA2)
 Q
GETDIV(DIVDA) ; GET DIVISIONAL DATA
 K DIVNM,PARDIV,PHN1,PHN2,ADD1,ADD2,CITY,ZIP,STATE,MADD1,MADD2,MCITY,MZIP,SIG1,SIG2,SIG3
 ;
 F FLDX="DIVNM^.01","PARDIV^.02","PHN1^.03","PHN2^.04","ADD1^.05","ADD2^.06","CITY^.07","ZIP^.08","STATE^.09" D GET1(52.92,DIVDA,FLDX)
 ;
 F FLDX="MADD1^1.01","MADD2^1.02","MCITY^1.03","MSTATE^1.04","MZIP^1.05","SIG1^2.01","SIG2^2.02","SIG3^2.03" D GET1(52.92,DIVDA,FLDX)
 ;
 Q
GET1(FILE,FLIEN,FLDX) ; "Variable^FLD" load variable = FILE,FLD
 N VAR S VAR=$P(FLDX,"^"),FLD=$P(FLDX,"^",2),@VAR=$$GET1^DIQ(FILE,FLIEN,FLD)
 Q
EXIT ;
 D ^%ZISC
 I $G(ZTSK) D KILL^%ZTLOAD
 K ADD1,ADD2,CHK,CITY,DIV,DIVCNT,DIVDA,DIVDA2,DIVNM,DIVX
 K EXPDT,EXPDTI,FAC,FDA,FLD,FLDX,FILE,FLD,FLDX,FLIEN
 K I,INST,LN,LOCDA,LTPDTI,MADD1,MADD2,MCITY,MZIP,PAR,PARAM
 K PARDIV,PATLST,PATNM,PHN1,PHN2,POP,PRTDT,PSOSTOP,PTLNM,PTNM
 K PTSTATE,PTXNM,SEX,SIG1,SIG2,SIG3,SRNAME,SRDT,STATE,TITLE
 K VADM,VAPA,VAR,XFLD,XX,YFLD,YY,ZIP,ZTDESC
 K ^TMP($J,"TPBLET"),^TMP($J,"TPCLW")
 Q
LOAD K PATLST S DFN=0 F  S DFN=$O(^PS(52.91,DFN)) Q:DFN'>0  S PATLST($$GET1^DIQ(52.91,DFN,.01))=DFN
 Q
