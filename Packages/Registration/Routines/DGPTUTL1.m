DGPTUTL1 ;ALB/MJK - PTF Utility ;2/1/05 2:20pm
 ;;5.3;Registration;**33,45,54,517,635,817**;Aug 13, 1993;Build 4
 ;
FLAG ; -- select PTF rec to update xmit flags
 S DGMAX=25
 W ! S DIC="^DGPT(",DIC(0)="AEMQ",DIC("S")="I '$P(^(0),U,6),$P(^(0),U,11)=1 D CHK^DGPTUTL1 I $D(DGMTY)>9"
 D ^DIC K DIC G FLAGQ:+Y<0 S (Y,PTF)=+Y D CHK
 F DGMTY=501,535 I $D(DGMTY(DGMTY)) D UP Q:$D(DGOUT)
FLAGQ K DGMAX,DGT,DGADM,DGX,DGA1,DGA,DGMTY,C,DGOUT Q
 ;
UP ; -- select mvt and update xmit flag
 ;I DGMTY=501 S DIC="^DGPT("_PTF_",""M"",",DIC("S")="I Y'=1,'$D(^(""P""))"
 I DGMTY=501 S DIC="^DGPT("_PTF_",""M"",",DIC("S")="I Y'=1"
 I DGMTY=535 S DIC="^DGPT("_PTF_",535,",DIC("S")="I Y'=1"
 W ! S DIC(0)="AEMQ" D ^DIC S DIE=DIC K DIC
 K DGOUT I X["^" S DGOUT=""
 I +Y<0 G UPQ
 S DA=+Y,DR=17 D ^DIE K DE,DQ G UP
UPQ K DIE,DR Q
 ;
CHK ;
 N T1,T2,C K DGMTY S T1=0,T2=9999999
 F DGMTY=501,535 D 501^DGPTFVC2:DGMTY=501,535^DGPTFVC2:DGMTY=535 S:C>DGMAX DGMTY(DGMTY)=""
 Q
 ;
INCOME ;-- load ptf income information
 ;   Use discharge date if available; else use current date/time
 D NOW^%DTC
 S X=$S($D(^DGPT(PTF,70)):+^(70),1:%),DGX=$S($D(^DGPT(PTF,101)):^(101),1:"")
 D INC
 G INQ:Y=$P(DGX,U,7)
 S DIE="^DGPT(",DA=PTF,DR="101.07////"_Y
 D ^DIE
INQ ;
 K DGX,DGINCM,DIE,DA,DR,DGI,DG30,DG362,DGT,%
 Q
 ;
INC ;-- load income information  Input:X date,Output:Y-income
 N DGINCM,DGI,DG30,DG362,DGT,DGX
 I '$D(X) S Y="" G INCQ
 S Y=+$P($$INCOME^VAFMON(DFN,X),".")
 I Y<0 S Y=0
INCQ Q
 ;
CHQUES ;-- This function will deterime if the patient has any of the following
 ;   indicated : AO, IR and EC. If so the array DGEXQ will contain
 ;     DGEXQ(1)="" - AO
 ;     DGEXQ(2)="" - IR
 ;     DGEXQ(3)="" - EC
 ;   Otherwise they will be undefined.
 K DGEXQ
 S DGEXQ(1)="",DGEXQ(2)="",DGEXQ(3)=""
 Q
 ;
SETTRAN ;-- set transmission if error DGOUT=1, will return XMZ
 K DGXMZ
 S DGOUTX=0
 S Y=$S($P(DGD,".",2)=99:DGSD,1:DGD) X ^DD("DD")
 S XMSUB=Y_"  "_$P(DGRTY0,U)_" TRANSMISSION ",XMDUZ=.5
 D GET^XMA2
 I $D(XMZ),XMZ>0 S DGXMZ=XMZ K XMZ G SETQ
 W !!,"*** ERROR *** Unable to create Mail Message #... Try again later."
 S DGOUTX=1
SETQ ;
 Q
 ;
KVAR ; -- clean up for l/e
 K DA,DFN,A,B,I,ANS,DIE,DR,%,%DT,DGPR,DGREL,DGST,DIC,HEAD,J,K,L,M,MT,NU,PTF,DGPTFE,Y,DGZM0,DGZS0,DOB,L1,PT,SEX,AGE,CC,DAM,DOB,DXLS,EXP,NOR,NO,DRG,DRGCAL,DGZSUR,S1,SUR,M1,MOV,P,P1
 K DGDX,DGER,DGI,DGINFO,DGLOS,DGNXD,DGP,DGPAS,DGPSV,DGTLOS,DGTY,DIS2,DGJUMP,DGPRD,DGPC,DGDRGNM,DGMOVM,DR,DGQWK,ST1,DGX,DQ,TY,DGRTY,DGRTY0,DGPTFMT,DG,DGA1,DGDC,DGNEXT,RC,DP,POP,DGICD0,DGPROCD,DGPROCI,DGPROCM,DGVAR,DGAD
 K TAC,TRS,SD,PD,MDC,NDR,NSD,OR,ORG,T,DGZDIAG,DGZPRO,DGZSER,J1,I1,L2,L3,L4,L5,L6,PM,DGFC,S,M2,PROC,SU,ST,NL,DGDD,SD1,D,DFN,DFN1,DFN2,D0,P2,S2,X,DGNUM,DGN,DGERR,DGVI,DGVO,Z,Z1,DGZ,DGADM,DGNODE,^UTILITY($J),DGCFL
 K DGPM2X,DGPMDA,DGPMDCD,DGPMVI,DGAMY,VAERR,VAIP,DGPTSCRN,DGREC,DGHOLD,DG300,DG300A,DG300B,DG701,DGBPC,DGPTIT,DGMOV,DGSUR
 K M3,DGLAST,DGMVT
 Q
 ;
ELIG ; shows eligibility and disabilities
 D ELIG^VADPT W #,!,"Eligibility: "_$P(VAEL(1),"^",2)_$S(+VAEL(3):"     SC%: "_$P(VAEL(3),"^",2),1:"")
 W !,"Disabilities: " F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  S I1=$S($D(^DPT(DFN,.372,I,0)):^(0),1:"") D:+I1
 .S PSDIS=$S($P($G(^DIC(31,+I1,0)),"^")]""&($P($G(^(0)),"^",4)']""):$P(^(0),"^"),$P($G(^DIC(31,+I1,0)),"^",4)]"":$P(^(0),"^",4),1:""),PSCNT=$P(I1,"^",2)
 .W:$L(PSDIS_"-"_PSCNT_"% ("_$S($P(I1,"^",3):"SC",1:"NSC")_"), ")+$X>80 !,?15
 .W $S($G(PSDIS)]"":PSDIS_"-",1:"")_PSCNT_"% ("_$S($P(I1,"^",3):"SC",1:"NSC")_"), "
 .I $Y>22 W !,"PRESS RETURN TO CONTINUE:" R X:DTIME W #
 Q
DATE ;EDIT CPT DATE/TIME TO BE AFTER ADMISSION DATE BUT BEFORE DISCHARGE
 I X<$P(^DGPT(DA(1),0),U,2) W !,"Not before admission" K X Q
 I $G(^(70)),X>^(70) W !,"Not after discharge" K X Q
 S I=0 F  S I=$O(^DGPT(PTF,"C",I)) Q:I'>0  I X=+^(I,0) W !,"Cannot change to existing CPT date/time entry" K X Q
 Q
SETABX ;SET AB CROSSREFERENCE IN FILE 45
 G KILLABX:$P($G(^DGPT(DA(1),"C",DA,0)),U,7)
 N BOOL S (DGCPT,BOOL)=0
 F  S DGCPT=$O(^DGCPT(46,"C",DA(1),DGCPT)) Q:'DGCPT  D  Q:BOOL
 .S BOOL='$G(^DGCPT(46,DGCPT,9))
 I 'BOOL K ^DGPT("AB",$E(X,1,30),DA(1),DA)
 S ^DGPT("AB",$E(X,1,30),DA(1),DA)="" Q
KILLABX ;KILL AB CROSSREFERENCE IN FILE 45
 G SETABX:'$P($G(^DGPT(DA(1),"C",DA,0)),U,7)
 K ^DGPT("AB",$E(X,1,30),DA(1),DA) Q
DISP F I=1:1:$P(DGZPRF,U,3) D
 .S Y=+DGZPRF(I) D D^DGPTUTL W !,I,?5,Y
 Q
HELP W !,"Enter '^' to stop display and edit of data,"
 W !,"'^N' to jump to screen #N (appears in upper right of screen as"
 W " <N>),",!,"a number to jump to that number 801 screen,"
 W " ?? to list the 801 screens,"
 W !,"<RET> to continue on to next screen or A-B to edit:"
 W !?10,"A-Professional service information",!,?10,"B-Procedure codes",!,"You may also enter any combination of the above, separated by commas (ex:A,B)",! Q
CPT ;DISPLAY CPT CODES AND MODIFIERS
 S CPT=+DGZPRF(J,K),N=$$CPT^ICPTCOD(CPT,$$GETDATE^ICDGTDRG(PTF)),N=$S(N>0:$P(N,U,2,99),1:"")
 W $P(N,U),"  ",$P(N,U,2)
 F I=1,2 S MOD=$P(DGZPRF(J,K),U,I+1) D MOD:MOD
 W !,?7,"Quantity: ",$P(DGZPRF(J,K),U,14) K I,MOD,N Q
MOD S N=$$MOD^ICPTMOD(MOD,"I",$$GETDATE^ICDGTDRG(PTF)) W !,?7,"CPT Modifier ",I,":",$P(N,U,2)," ",$P(N,U,3)
 Q
