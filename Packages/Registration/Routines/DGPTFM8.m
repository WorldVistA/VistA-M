DGPTFM8 ;ALB/MTC - PTF ADDITIONAL QUESTION DISPLAY FOR MAS SCREEN ; 25 APR 91
 ;;5.3;Registration;**729**;Aug 13, 1993;Build 59
 ;
 ; This routine has two entry points WD3 and SD3, called from
 ; DGPTFM. This entry points will display Additional PTF information
 ; on the <MAS> screen.
 ;
WD3 ;-- display infor for additional PTF questions by movement
 S DG300A="" I $D(M(J)),$D(^DGPT(PTF,"M",+M(J),300)) S DG300A=^(300)
 S DG300B="" I $D(M(J+1)),$D(^DGPT(PTF,"M",+M(J+1),300)) S DG300B=^(300)
 I DG300A']"",DG300B']"" G WD3Q
 S (DGCA,DGCB)=2
 D GETNUM^DGPTSCAN
 F DGI=0:0 S DGL=0,X=DGCA,DG300=DG300A D PRN1 S DGCA=X+1,DGL=1,X=DGCB,DG300=DG300B D PRN1 S DGCB=X+1 Q:(DGCA>DGFNUM)&(DGCB>DGFNUM)
WD3Q ;
 K DGFNUM,DGI,DG300,DG300A,DG300B,DGL,DGCA,DGCB
 Q
PRN1 ;-- display additional PTF question infomation
 I X=2,$P(DG300,U,2)]"" X:('DGL)!($X>40) "W !" W ?DGL*40+2,"Self Injury - "_$S($P(DG300,U,2)=1:"Attempted Suicide",$P(DG300,U,2)=2:"Accomplished Suicide",1:"Self Inflicted Injury") G PRNQ1
 S:X=2 X=3
 I X=3,$P(DG300,U,3)]"" X:('DGL)!($X>40) "W !" W ?DGL*40+2,"Legionnaire's - "_$S($P(DG300,U,3)=1:"Yes",1:"No") G PRNQ1
 S:X=3 X=4
 I X=4,$P(DG300,U,4)]"" X:('DGL)!($X>40) "W !" W ?DGL*40+2,"Substance - "_$S($D(^DIC(45.61,$P(DG300,U,4),0)):$P(^(0),U),1:"") G PRNQ1
 S:X=4 X=5
 S DGPSY=0 I "5,6,7"[X S X=7 F DGJ=5,6,7 I $P(DG300,U,DGJ)]"" S DGPSY=1 Q
 G PRNQ1:'DGPSY
 X:('DGL)!($X>40) "W !" W ?DGL*40+2,"Psy- CL:",+$P(DG300,U,5),?DGL*40+13," CR:",+$P(DG300,U,6),?DGL*40+21," HI:",+$P(DG300,U,7)
PRNQ1 ;
 K DGJ,DGPSY
 Q
SD3 ;-- tag for printing kidney donor source 
 ; call only by DGPTFM@SERV
 S DGL=0
 S DGSUR=J D:$D(S(DGSUR)) KID S DGL=1,DGSUR=J+1 D:$D(S(DGSUR)) KID
SD3Q K DGSUR,DGL
 Q
KID ;-- kidney transplant source
 W:('DGL)&($X>0) !
 I $D(^DGPT(PTF,"S",DGSUR,300)),$P(^(300),U)]"" W ?DGL*40+2,"Kidney - "_$S(+^(300)=1:"Live Donor",1:"Cadaver")
 Q
PRN2 ;-- display additional PTF question infomation
 I $P(DG300,U,2)]"" W !,"Self Injury - "_$S($P(DG300,U,2)=1:"Attempted Suicide",$P(DG300,U,2)=2:"Accomplished Suicide",1:"Self Inflicted Injury")
 I $P(DG300,U,3)]"" W !,"Legionnaire's - "_$S($P(DG300,U,3)=1:"Yes",1:"No")
 I $P(DG300,U,4)]"" W !,"Substance - "_$S($D(^DIC(45.61,$P(DG300,U,4),0)):$P(^(0),U),1:"")
 S DGPSY=0 F DGI=5,6,7 I $P(DG300,U,DGI)]"" S DGPSY=1 Q
 G PRNQ2:'DGPSY
 W !,"Psy - CL:",+$P(DG300,U,5),?12,"CR:",+$P(DG300,U,6),?19,"HI:",+$P(DG300,U,7)
PRNQ2 ;
 K DGI,DGPSY
 Q
PRN3 ;-- print kidney additional question
 I $P(DG300,U)]"" W !,"Kidney - "_$S(+DG300=1:"Live Donor",1:"Cadaver")
PRNQ3 ;
 Q
