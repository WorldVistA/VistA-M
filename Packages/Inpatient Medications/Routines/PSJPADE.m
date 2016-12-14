PSJPADE ;BIR/MHA PADE SYSTEM SET UP ;6/10/15
 ;;5.0;INPATIENT MEDICATIONS;**317**;16 DEC 97;Build 130
 ;Reference to ^DGPMDDCF supported by DBIA 1246
 ;Reference to ^DPT("CN" supported by DBIA 10035
 ;Reference to ^SC supported by DBIA 10040
 ;Reference to ^DIC(42 supported by DBIA 10039
 ;Reference to ^HLMA (#773) supported by DBIA 4738
 Q
PADE ;enter/edit PADE system setup
 W ! N PSJDIV,DA,DR S (DIC,DIE)="^PS(58.7,",DLAYGO=58.7,DIC(0)="AEQL"
 I $D(^XUSEC("PSJ PADE ADV",DUZ)) S DIC(0)="AEQ" K DLAYGO
 D ^DIC G:"^"[$E(X) PDX G:Y<1 PADE S DA=+Y,DR="[PSJ PADE SYSTEM]" W ! D ^DIE G PADE
PDX K DIE,DIC
 Q
 ;
PDSAR ;enter/edit SEND AREA
 W ! S (DIC,DIE)=58.71,DLAYGO=58.71,DIC(0)="AEQL" D ^DIC G:"^"[$E(X) PDARX G:Y<1 PDARX S DA=+Y,DR=".01" D ^DIE G PDSAR
PDARX K DIE,DIC
 Q
 ;
PDUSR ;PADE division setup
 N PSJAP,I,J,K,X,Y S (PSJAP,I)=0
 F  S I=$O(^PS(58.7,I)) Q:'I  S J=$$PDACT^PSJPDCLA(I)
 I 'PSJAP W !!,"PADE not setup - Quitting..." H 2 Q
 S (I,J)=0 F  S I=$O(PSJAP(I)) Q:'I  S J=J+1
 I J>1 D  Q:Y<0
 .W ! K DIC S DIC("A")="Select PADE: ",DIC=58.7,DIC(0)="AEMQ"
 .S DIC("S")="I '$P(^PS(58.7,+Y,0),U,4)&($P(^PS(58.7,+Y,0),U,4)<DT)"
 .D ^DIC I Y<0 K DIC Q
 .S K=+Y,I=0 F  S I=$O(PSJAP(I)) Q:'I  K:I'=K PSJAP(I)
 S Y=$O(PSJAP(0))
 W !!,"You are logged under PADE: "_$P($G(^PS(58.7,Y,0)),"^"),!
 N PSJDIV S DIE="^PS(58.7,",DA=+Y,DR="[PSJ PADE SYSTEM]"
 D ^DIE
 K DIE,DIC
 Q
BDCHK(QZ) ;CHECK IF BED IS OUT-OF-SERVICE
 N J S J=X N D0,X S D0=QZ D RIN^DGPMDDCF
 I X W !,"BED is marked as OUT-OF-SERVICE",! Q 1
 ;CHECK IF BED IS ASSIGNED TO ANOTHER GROUP
 S X=J,J=0,J=$O(^PS(58.7,DA(3),"DIV",DA(2),"BG","C",X,J))
 Q:'J 0
 S J=$G(^PS(58.7,DA(3),"DIV",DA(2),"BG",J,0))
 S:J="" J="UNKNOWN"
 W !,"Bed is already assigned to group "_J,!
 Q 1
 ;
CLCHK(QZ) ;CHECK IF CLINIC IS DEFINED IN ANOTHER GROUP
 I $P(^(0),U,3)'="C" Q 0
 I $P(^(0),U,15)'=$S($G(PSJDIV):PSJDIV,1:DA(2)) Q 0
 N J S J=$O(^PS(58.7,DA(3),"DIV",DA(2),"PCG","C",QZ,""))
 Q:'J 1
 S J=$G(^PS(58.7,DA(3),"DIV",DA(2),"PCG",J,0))
 S:J="" J="UNKNOWN"
 W !,$P(^SC(QZ,0),U)_" Clinic is already assigned to group "_J,!!
 Q 0
 ;
WGSEL(Q) ;CHECK IF ATLEAST ONE WARD IN THIS GROUP BELONGS TO THE SAME DIVISION
 N I,J,K S (I,K)=0
 I $P(^(0),U,2)="P" D
 .F  S I=$O(^PS(57.5,Q,1,I)) Q:'I!(K)  D
 .. S J=+^PS(57.5,Q,1,I,0) Q:'J
 .. N D0,X S D0=J D WIN^DGPMDDCF Q:X
 .. S J=+$P($G(^DIC(42,J,0)),"^",11) Q:'J
 .. I J=$S($G(PSJDIV):PSJDIV,1:DA) S K=1
 Q K
 ;
ORSEL() ;CHECK IF OR BELONGS TO THE SAME DIVISION
 N FF S FF=0
 I $P(^(0),U,15)=$S($G(PSJDIV):PSJDIV,1:DA(1))&($D(^SC("AC","OR",Y))) D
 .I '$P($G(^SC(Y,"I")),U)!(+$P($G(^SC(Y,"I")),U)'<DT) S FF=1
 Q FF
 ;
PDORD ;
 N PSJAP,PSJCLPD,PSJPDNM,I,J,K,L,X,Y,Z S (PSJAP,I)=0
 F  S I=$O(^PS(58.7,I)) Q:'I  S J=$$PDACT^PSJPDCLA(I)
 I 'PSJAP W !!,"PADE not setup - Quitting..." H 2 Q
SEL ;
 D ENCV^PSGSETU
 W !
 K DIR,DIRUT
 K PSJDIV,DIVI,DFN,RXO,PSJHLDFN,PDTYP,ALLC,SCL,SWD,WDN,PDCL,PDWD,NIV
 S DIR("?")="^D PDH^PSJPADE",DIR("A")="Select By",DIR("B")=$S($D(SEL):SEL,1:"PT")
 S DIR(0)="SMB^PT:PATIENT;WD:WARD;CL:CLINIC;E:EXIT"
 D ^DIR K DIR I $D(DIRUT)!(Y="E") K SEL,X,Y Q
 S SEL=Y
 G:SEL="PT" PT
 D:'$G(PSJCLPD) SELPD
 G:'$G(PSJCLPD) SEL
 W !!,"You are logged under PADE: "_PSJPDNM,!
DIV ;
 W ! K DIC S DIC=40.8,DIC(0)="AEMQ",DIC("A")="Select DIVISION: " D ^DIC K DIC
 G:Y<0 SEL
 S PSJDIV=+Y
 S DIVI=$G(^PS(58.7,PSJCLPD,"DIV",PSJDIV,0))
 I DIVI=""!($P(DIVI,"^",2)&($P(DIVI,"^",2)<DT)) W !,"This division is not setup for this PADE.",! G DIV
 I $P($G(^(2)),"^")'="Y" W !,"This division is not setup to send order messages.",! G DIV
 W !!,"You are logged under Division: "_$P(Y,"^",2),!!
 S NIV=$P(DIVI,"^",7)'="Y"
 G:SEL="CL" CL
WD ;
 I '$O(PDWD(0)) D WDARR
 R !,"Select a Ward or ^ALL for all Wards: ",X:DTIME
 G:"^"[X SEL
 I "^AL"'[$E(X,1,3) G SWD
 I '$D(^XUSEC("PSJ PADE MGR",DUZ)) W !!,"You must have the PSJ PADE MGR key to send all orders",! G WD
 N CNT,WDCNT,Z11 S Z11=0
 F  S Z11=$O(PDWD(Z11)) Q:'Z11  D
 . S WDN=$P(^DIC(42,Z11,0),"^")
 . I '$D(^DPT("CN",WDN)) W !,"No patient in WARD "_WDN
 . E  W !,"Sending ward "_WDN S WDCNT=0 D SDWD W:'$G(WDCNT) !,?2,"No patients with active orders for this ward"
 G SEL
 ;
SWD ;
 W ! K SWD,WDN K DIC S DIC="^DIC(42,",DIC(0)="QME"
 S DIC("S")="I $P(^(0),U,11)=PSJDIV"
 D ^DIC K DIC G:"^"[X SEL G:Y<0 WD
 S SWD=+Y,WDN=$P(Y,"^",2)
 I '$D(^DPT("CN",WDN)) W !!,"This ward has no patient",! G WD
 I '$D(PDWD(SWD)) W !!,"Ward is not setup for this PADE.",! G WD
 D SDWD
 K SWD,WDN
 G WD
 ;
PDH ;
 W !!,"Enter 'PT' to send orders by Patient"
 W !,"      'WD' to send orders by Ward"
 W !,"      'CL' to send orders by Clinic"
 W !,"   or 'E' or '^' to exit" W !
 Q
 ;
SELPD ;
 S (I,J)=0 F  S I=$O(PSJAP(I)) Q:'I  S J=J+1
 I J>1 D  Q:$D(DTOUT)!($D(DUOUT))  I X="" W !,"You must select a PADE" G SELPD
 .W ! S DIC("A")="Select PADE: ",DIC=58.7,DIC(0)="AEMQ"
 .S DIC("S")="I '$P(^PS(58.7,+Y,0),U,4)&($P(^PS(58.7,+Y,0),U,4)<DT)"
 .D ^DIC K DIC Q:Y<0
 .S PSJCLPD=+Y,I=0 F  S I=$O(PSJAP(I)) Q:'I  K:I'=PSJCLPD PSJAP(I)
 S PSJCLPD=$O(PSJAP(0)),PSJPDNM=$P($G(^PS(58.7,PSJCLPD,0)),"^")
 Q
PT ;
 K DFN
 D ENDPT^PSJP
 G:'$G(DFN) SEL
 D GETPTO
 K DFN G PT
 ;
GETPTO ;
 K ^TMP("PS",$J) S CNT=0 N PTN
 D OCL1^PSJORRE(DFN,"","",0)
 S PTN=$P($G(^DPT(DFN,0)),"^")_" ("_$E($P($G(^DPT(DFN,0)),"^",9),6,9)_")"
 I '$D(^TMP("PS",$J)) W:SEL="PT" !,"No Orders found for "_PTN,! Q
 S I=0 S I=$O(^TMP("PS",$J,I)) I 'I W:SEL="PT" !,"No Orders found for "_PTN,! Q
 N PDO,FP S I=0
 F  S I=$O(^TMP("PS",$J,I)) Q:'I  D
 .S J=^TMP("PS",$J,I,0),FP=$P(J,"^")
 .I (FP["U"!(FP["V")&($P(J,"^",9)="ACTIVE")) S PDO($P(FP,";"))="",CNT=CNT+1,WDCNT=1
 I '$O(PDO("")) W:SEL="PT" !,"No active IV/UD Orders found for "_PTN,! Q
 W !,?2,CNT_" Order(s) Queued for "_PTN,!
 S PDTYP="SN",PSJHLDFN=DFN
 S RXO=0 F  S RXO=$O(PDO(RXO)) Q:'RXO  D
 .D PDORD^PSJPDCLU
 Q
 ;
CL ;
 N ALL44 S ALL44=$P(DIVI,"^",3)="Y"
 I '$O(PDCL(0)) I 'ALL44 D CLARR
 K ALLC
 R !,"Select a Clinic or ^ALL for all Clinics: ",X:DTIME
 G:"^"[X SEL
 I "^AL"'[$E(X,1,3) G SCL
 I '$D(^XUSEC("PSJ PADE MGR",DUZ)) W !!,"You must have the PSJ PADE MGR key to send all orders",! G CL
 S ALLC=1 D SDCL
 G SEL
 ;
SCL ;
 W ! K SCL K DIC S DIC="^SC(",DIC(0)="QME"
 S DIC("S")="I $P(^(0),U,3)=""C"",$P(^(0),U,15)=PSJDIV"
 D ^DIC K DIC G:"^"[X SEL G:Y<0 CL
 S SCL=+Y
 I '$D(PDCL(SCL)),'ALL44 W !!,"Clinic is not setup for this PADE.",! G CL
 D SDCL
 K SCL
 G CL
 ;
SDCL ;
 W !,"Orders Queued to be sent to PADE",!
 N BDT S BDT=DT_".000001"
 F  S BDT=$O(^PS(55,"AUD",BDT)) Q:'BDT  D
 .S DFN=0 F  S DFN=$O(^PS(55,"AUD",BDT,DFN)) Q:'DFN  D
 .. S I=0 F  S I=$O(^PS(55,"AUD",BDT,DFN,I)) Q:'I  D
 ... S J=$G(^PS(55,DFN,5,I,0)) Q:$P(J,"^",9)'="A"
 ... S K=$G(^(8)) Q:'$P(K,"^",2)  S K=+K Q:'K
 ... I $G(SCL),K=$G(SCL) D SDO Q
 ... I $G(ALLC),$D(PDCL),$D(PDCL(K)) D SDO Q
 ... I $G(ALLC),ALL44,$P(^SC(K,0),U,15)=PSJDIV D SDO Q
 Q:NIV
SDCIV ;
 S L="V",BDT=DT_".000001"
 F  S BDT=$O(^PS(55,"AIV",BDT)) Q:'BDT  D
 .S DFN=0 F  S DFN=$O(^PS(55,"AIV",BDT,DFN)) Q:'DFN  D
 .. S I=0 F  S I=$O(^PS(55,"AIV",BDT,DFN,I)) Q:'I  D
 ... S J=$G(^PS(55,DFN,"IV",I,0)) Q:$P(J,"^",17)'="A"
 ... S K=+$G(^("DSS")) Q:'K
 ... I $G(SCL),K=$G(SCL) D SDO Q
 ... I $G(ALLC),$D(PDCL),$D(PDCL(K)) D SDO Q
 ... I $G(ALLC),ALL44,$P(^SC(K,0),U,15)=PSJDIV D SDO Q
 Q 
 ;
SDO ;
 S RXO=I_$S($G(L)="V":L,1:"U"),PDTYP="SN",PSJHLDFN=DFN
 D PDORD^PSJPDCLU
 Q
 ;
CLARR ;
 N Z S I=0
 F  S I=$O(^PS(58.7,PSJCLPD,"DIV",PSJDIV,"CL",I)) Q:'I  S PDCL(+^(I,0))=""
 S I=0
 F  S I=$O(^PS(58.7,PSJCLPD,"DIV",PSJDIV,"PCG",I)) Q:'I  D
 . S J=0 F  S J=$O(^PS(58.7,PSJCLPD,"DIV",PSJDIV,"PCG",I,1,J)) Q:'J  D
 .. S K=^(J,0) I '$D(PDCL(K)) S PDCL(K)=""
 S I=0
 F  S I=$O(^PS(58.7,PSJCLPD,"DIV",PSJDIV,"VCG",I)) Q:'I  S J=^(I,0) D
 . S Z=0 F  S Z=$O(^PS(57.8,+J,1,Z)) Q:'Z  D
 .. S K=^(Z,0) I '$D(PDCL(K)) S PDCL(K)=""
 S I=0,L=""
 F  S I=$O(^PS(58.7,PSJCLPD,"DIV",PSJDIV,"WCN",I)) Q:'I  S J=^(I,0) D
 . S (Y,Z)=$P(J,"^") F  S Z=$O(^SC("B",Z)) Q:Z=""!($E(Z,1,$L(Y))'=Y)  D
 .. S K=$O(^SC("B",Z,0)),L=$G(^SC(K,0)) Q:$P(L,"^",3)'="C"  Q:$P(L,"^",15)'=PSJDIV  D
 ... I '$D(PDCL(K)) S PDCL(K)=""
 Q
 ;
WDARR ;
 S I=0
 F  S I=$O(^PS(58.7,PSJCLPD,"DIV",PSJDIV,"WD","B",I)) Q:'I  S PDWD(I)=""
 S I=0
 F  S I=$O(^PS(58.7,PSJCLPD,"DIV",PSJDIV,"WG","B",I)) Q:'I  D
 . S J=0 F  S J=$O(^PS(57.5,I,1,J)) Q:'J  S K=(+^(J,0)) S:'$D(PDWD(K)) PDWD(K)=""
 Q
 ;
SDWD ;
 S DFN=0 F  S DFN=$O(^DPT("CN",WDN,DFN)) Q:'DFN  D
 .D GETPTO
 Q
 ;
LOG ;
 Q:'$O(PDL(0))
 N HLI
 I PSJSND>0 S PDL(3)=+PSJSND D
 .S HLI=$$FIND1^DIC(773,,"X",+PSJSND,"C")
 .S HLI=$$GET1^DIQ(773,HLI,.01,"I") S:HLI PDL(17)=HLI
 S:+PSJSND<1 PDL(13)=$P(PSJSND,"^",3)
 S DR="",LI=0
 F  S LI=$O(PDL(LI)) Q:'LI  S DR=DR_LI_"////"_PDL(LI)_";"
 K DD,DO,DIC
 D NOW^%DTC S DIC="^PS(58.72,",X=%,DIC(0)="",DIC("DR")=DR
 D FILE^DICN K DD,DO,Y,DIC,PDL
 Q
 ;
RXC ;
 N PSJDD,PSJDU,RXC,DOS,NDF
 S I=0 F  S I=$O(PS55(1,I)) Q:'I  D
 .S PSJDD=$P(PS55(1,I,0),"^"),PSJDU=$P(PS55(1,I,0),"^",2)
 .I $P(PS55(1,I,0),"^",3),$P(PS55(1,I,0),"^",3)'>DT Q
 .S SEG="RXC"_NFS_"A"
 .S $P(SEG,NFS,3)=PSJDD_NECH_$P($G(^PSDRUG(PSJDD,0)),"^")_NECH_"99PSD"
 .S DOS=$G(^PSDRUG(PSJDD,"DOS")),NDF=$G(^("ND"))
 .D:$P(DOS,"^")
 .. S $P(SEG,NFS,4)=$P(DOS,"^")*PSJDU_NFS_NECH_$P($G(^PS(50.607,$P(DOS,"^",2),0)),"^")
 .. S $P(SEG,NFS,6)=$P(DOS,"^")_NFS_NECH_$P($G(^PS(50.607,$P(DOS,"^",2),0)),"^")
 .I $P(DOS,"^")="",$P(NDF,"^",3) D
 .. S DOS=$P($$DFSU^PSNAPIS("",$P(NDF,"^",3)),"^",4,6)
 .. D:DOS
 ... S $P(SEG,NFS,4)=+DOS*PSJDU_NFS_NECH_$P(DOS,"^",3)
 ... S $P(SEG,NFS,6)=$P(DOS,"^")_NFS_NECH_$P(DOS,"^",3)
 .S SEQ=SEQ+1
 .S NSEG(SEQ)=SEG
 .D:$D(^XTMP("PADE")) DISP^PSJPDCLU
 Q
 ;
