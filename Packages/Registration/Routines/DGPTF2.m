DGPTF2 ;ALB/JDS,HIOFO/FT,WIOFO/PMK - PTF CORRECTIONS ;3/19/2015 3:43 pm
 ;;5.3;Registration;**37,342,643,861,850,884**;Aug 13, 1993;Build 31
 ;
 ; XUSEC APIs - 10076
 ; %ZOSF APIs - 10096
 ; %ZIS APIs - 10086
 ; %ZISC APIs - 10089
 ;
EN ;This code allows the user to edit some PTF record fields.
 ;The transmission building code builds each segment (e.g., 101) and validates the data in that segment string.
 ;Some errors are flagged and noted in the ^UTILITY("DG",$J) global. This global identifies the fields the user can edit.
 ;For each segment (e.g., 101), the string of fields that can be edited are in the DGL variable.
 ;The DGL value is determined by the value of the DGPTFMT variable which is either 1, 2, or 3.
 ;DGPTFMT is set in the calling routine(s).
 ;DGPTFMT=3 means the site is using ICD10 codes/record format.
 ;DGPTFMT=2 means the site is using ICD9 codes/record format.
 ;DGPTFMT=1 means the site is using something prior to ICD9 codes/record format
 ;
 I DGPTFMT'=1,DGPTFMT'=2,DGPTFMT'=3 Q  ; not valid parameter value - pmk 3/19/2015
 Q:'$D(^UTILITY("DG",$J))  ;^UTILITY is set in DGPTR1, DGPTRI1, DGPTFTR1, DGPTFVC2
 S Q=0,DG2=""
 F DG9=101,401,501,701,601,"HEADER" D @DG9 F I1=0:0 S I1=$O(^UTILITY("DG",$J,DG9,I1)) Q:I1'>0!(Q)  S DG45="",DGJ=^(I1) F J=2:1 S K=$P(DGJ,U,J) Q:'K  D SET Q:Q  I '$P(DGJ,U,J+1) D @($S(DG9=401!(DG9=501)!(DG9=601):"D5",1:"DO1")) Q:Q
 ;
Q D DO:'Q
 K DG9,I1,DR,DG45,DG2,DGJ,Q,M,L,^UTILITY("DG",$J)
 Q
SET ;
 S L=$P(DGL,U,K) I DGPTFE!('$P(L,"*",3)) S M="DG"_$P(L,"*",2) I @M'[($P(L,"*",1)_";") S @M=@M_$P(L,"*",1)_";"
 Q
 ; -- DGL sets
101 ;
 I DGPTFMT<2 S DGL=".01*2^20*45^21.1;21.2*45^22*45^.526*2^.05*2^.02*2^.03*2^23*45^.32103;.32102;.3212*2^.115;.117;.1112*2^10*45"
 ;the following DGL set can be used when DGPTFMT=2 or 3
 I DGPTFMT>1 S DGL=".01*2^20*45^21.1;21.2*45^22*45^.526*2^.05*2^.02*2^.03*2^.323*2^.32101;.32103;.3212;.32102;.3213*2^.115;.117;.1112*2^10*45"
 Q
701 ;
 I DGPTFMT<3 S DGL="70*45*1^71*45*1^72*45*1^73*45^74*45^75*45^76.1;76.2*45^77*45^.06*2^78*45^79*45"
 I DGPTFMT=3 S DGL="70*45*1^71*45*1^72*45*1^73*45^74*45^75*45^76.1;76.2*45^77*45^.06*2^78*45^79;82.01*45"
 Q
401 ;
 I DGPTFMT<3 S DGL=".01*45^3*45^4*45^5*45^6*45^7*45^8:12*45"
 I DGPTFMT=3 S DGL=".01*45^3*45^4*45^5*45^6*45^7*45^8:32*45"
 Q
501 ;
 I DGPTFMT<2 S DGL="10*45*1^2*45*1^3*45^4*45^57.4*2^5:9*45^72.1*45*1"
 I DGPTFMT=2 S DGL="10*45*1^2*45*1^2*45*1^3*45^4*45^57.4*2^5:9*45^^^^72.1*45*1"
 I DGPTFMT=3 S DGL="10*45*1^2*45*1^2*45*1^3*45^4*45^57.4*2^5:9;11:15;81.01:81.15*45^^^^72.1*45*1"
 ;OR
 ;I DGPTFMT=3 S DGL="10*45*1^2*45*1^???*45*1^3*45*1^4*45*1^57.4*2^5:9;11:15;81.01:81.15*45^^^^72.1*45"
 Q
601 ;
 I DGPTFMT<3 S DGL=".01*45^1*45^^^4:9*45"
 I DGPTFMT=3 S DGL=".01*45^1*45^^^4:28*45"
 Q
HEADER ;
 S DGL=".09*2^2*45*1^3*45*1"
 Q
 ;
DO ;
 I DG2]"" W !!,"Editing patient information:" S DIE="^DPT(",DR=DG2,DA=+^DGPT(PTF,0) D ^DIE
 W !!,"Exiting the correction process." H 2
 Q
DO1 ;
 I DG45]"" W !!,"Editing PTF information:" S DIE="^DGPT(",DR=DG45,DA=PTF D DIE
 Q
D5 ;
 G D5Q:DG45=""
 S DIE="^DGPT(PTF,"_$S(DG9=601:"""P""",DG9=401:"""S""",1:"""M""")_",",DA(1)=PTF,DA=I1,DR=DG45
 I $G(@(DIE_DA_",0)"))="" G D5Q
 S Y=$G(@(DIE_DA_",0)")),Y=$P(Y,U,$S(DG9=601!(DG9=401):1,1:10)) D D^DGPTUTL
 W !!,"Editing ",$S(DG9=601:"Procedure",DG9=401:"Surgery",1:"Movement")," of ",Y D DIE
D5Q Q
 ;
DIE D ^DIE
D Q:'$D(Y)
D1 K DR W !,"Do you want to stop correcting" S %=1 D YN^DICN
 I %=1!(%=-1) S Q=1 Q
 I %=0 W !?10,"Enter 'YES' or '^' to stop making corrections",!?10,"and   'NO'         to continue making corrections" G D1
 Q
PRINT ;
 W !,"Want to print error log " S %=2 D YN^DICN G PRINT:%'>0 Q:%=2
 K IOP D ^%ZIS Q:IO']""  S Y=DT X ^DD("DD") W @IOF W !!,"Error log for PTF record ",PTF,"  "_$P(^DPT(DFN,0),U,1)_"  ",Y,!! S DGERR=-1,J=PTF D LOG^DGPTFTR D ^%ZISC
 S IOP="" D ^%ZIS K IOP I $L(DGVO_DGVI)>4 S X=132 X ^%ZOSF("RM")
 Q
CLS ;called from DGPTF4
 I $D(^DGM("PT",DFN)) W !!,"Not all messages have been cleared up for this patient--cannot close.",*7,*7 S DGPTF=DFN,X="??" K DGALL D HELP^DGPTMSGD K DGPTF G EN1:'$D(DGALL) K DGALL
 W !,"Performing edit checks..."
 ;-- init for Austin Edits
 K ^TMP("AEDIT",$J),^TMP("AERROR",$J) S DGACNT=0
 ;
 S Y=1 D RTY^DGPTUTL
 S J=PTF,DGERR=-1 D LOG^DGPTFTR K DGLOGIC D LO^DGUTL K T1,T2 I DGERR>0 K DGERR H 4 D DGPTF2 G EN1
 ;
 ;-- new Austin edit checks
 D ^DGPTAE I DGERR>0 K DGERR D DGPTF2 G EN1
 ;
 K DGERR S DR=$S($P(^DGPT(PTF,0),U,7):"",1:";7////"_DUZ_";8///T"),DA=PTF,DIE="^DGPT(",DP=45 D ^DIE K DR
 S DIC(0)="LN",(DINUM,X)=PTF,DIC="^DGP(45.84," K DD,DO D FILE^DICN K DINUM,DO,DIC
 I Y>0 S DA=+Y,DR="2///NOW;3////"_DUZ,DIE="^DGP(45.84," D ^DIE K DR
 K DIE,DIC
 I '$D(^DGP(45.84,PTF)) W !,"Cannot close without proper fileman access",*7 D HANG^DGPTUTL G EN1
 F I=0,.11,.52,.321,.32,.36,57,.3 S:$D(^DPT(DFN,I)) ^DGP(45.84,PTF,$S(I=0:10,1:I))=^DPT(DFN,I)
 S $P(^DGP(45.84,PTF,0),U,6)=DRG
 W !,"****** PTF CLOSED OUT ******" D HANG^DGPTUTL
 ;DG*5.3*861 Added DGRELKEY variable to hold the value for DGREL that is killed in ^EASECU21
 I '$G(DGREL) S DGREL=$S($D(^XUSEC("DG PTFREL",DUZ)):1,1:0)
 I $G(DGREL) S (DGN,DGST)=1 G EN1
 K DGRTY,DGRTY0 G Q^DGPTF
EN1 K DGRTY,DGRTY0 G EN1^DGPTF4
