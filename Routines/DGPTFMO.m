DGPTFMO ;ALB/JDS/ADL - DGPTF PRINT TEMPLATE ; 4/13/04 12:11pm
 ;;5.3;Registration;**195,397,510,590,594,606,683,729,664**;Aug 13, 1993;Build 15
 ;;ADL;Updated for CSV Project;;Mar 4, 2003
 ;FOR PTF REPORT CALLED FROM TEMPLATE DGPTF
EN K A,B,AD,ADA,DGDD,DGFC,HEAD,DGPTFE,DGST,DGN,T
 F I=0:0 S I=$O(^DGPT(D0,"M",I)) Q:I'>0  I $D(^(I,0)) S J=+$P(^(0),U,10) S:'J J=999999999 S:$D(T(J)) J=J+.01*I S T(J)=I
 F I=0:0 S I=$O(T(I)) Q:I'>0  S DGM=$S($D(^DGPT(D0,"M",T(I),0)):^(0),1:"") I DGM]"" D WRITE
 K T F I=0:0 S I=$O(^DGPT(D0,"S",I)) Q:I'>0  D SUR
 S DGOP1=$S($D(^DGPT(D0,"401P")):^("401P"),1:"") I DGOP1]"" D HEAD:$Y>(IOSL-10) G Q:'DN D PROC
 I $D(^DGPT(D0,"P")) D HEAD:$Y>(IOSL-10) G Q:'DN F I=0:0 S I=$O(^DGPT(D0,"P",I)) Q:I'>0  S DG601=^DGPT(D0,"P",I,0),Y=+DG601 D D^DGPTUTL W !!," Procedure Date: ",Y D 601
 S DGPT=$G(^DGPT(D0,70)) I DGPT]"" G Q:'DN D DXLS
 K %,DGL,DGM,DGPT,DGOP,DGOP1,DGF,DGP,DXLS,DGICD,L1,S1,T,J,K,DGPR,DGN,AGE,B,DA,DAM,DFN,DGST,DOB,DP,DRG,EXP,NO,P,PTF,DGPTFE,SD1,SEX,TAC,TRS,DGDS,DGTD,DGPROC,DG601,DGPTDAT
 W ! ;F I=$Y:1:IOSL-1 W !
 Q
WRITE D HEAD:$Y>(IOSL-12) G Q:'DN S Y=$P(DGM,U,10),DGL=+$P(DGM,U,2),DGL=$S($D(^DIC(42.4,DGL,0)):^(0),1:""),DGL=$P(DGL,U,1) D D^DGPTUTL
 W !!,"Movement Date: ",Y,?40,"Losing Specialty: ",$E(DGL,1,22),!,"Leave Days: ",$P(DGM,U,3),?40,"Pass Days: ",$P(DGM,U,4)
 W !,"Treated for SC condition: ",$S($P(DGM,U,18)=1:"Yes",1:"No")
 W:$P(DGM,U,31)'="" !,"Potentially Related to Combat: ",$S($P(DGM,U,31)="Y":"Yes",1:"No")
 W:$P(DGM,U,26)'="" !,"Treated for AO condition: ",$S($P(DGM,U,26)="Y":"Yes",1:"No")
 W:$P(DGM,U,27)'="" !,"Treated for IR condition: ",$S($P(DGM,U,27)="Y":"Yes",1:"No")
 W:$P(DGM,U,28)'="" !,"Treated for service in SW Asia: ",$S($P(DGM,U,28)="Y":"Yes",1:"No")
 W:$P(DGM,U,29)'="" !,"Treated for MST condition: ",$S($P(DGM,U,29)="Y":"Yes",$P(DGM,U,29)="N":"No",1:"Declined to answer") ; added 6/17/98 for MST enhancement
 W:$P(DGM,U,30)'="" !,"Treated for HEAD/NECK CA condition: ",$S($P(DGM,U,30)="Y":"Yes",1:"No")
 W:$P(DGM,U,32)'="" !,"Treated for SHAD Condition: ",$S($P(DGM,U,32)="Y":"Yes",1:"No")
 W:T(I)=1 !,"Discharge "
 S DGF="" F J=5:1:15 I J#10 S DGPTTMP=$$ICDDX^ICDCODE(+$P(DGM,U,J),$$GETDATE^ICDGTDRG(D0)),DGICD=$S(+DGPTTMP>0:$P(DGPTTMP,U,2,99),1:"") I DGICD]"" D 
 . W:DGF="" !!?13,"DX: " W $P(DGICD,U,3)_" ("_$P(DGICD,U)_")",!?17 S DGF=1
 ;-- display expanded codes 
 S DG300=$S($D(^DGPT(D0,"M",T(I),300)):^(300),1:"") I DG300]"" D HEAD:$Y>(IOSL-6) D PRN2^DGPTFM8 W !
 K DG300
 ;Display TRANSFER DRG with description
 Q:'$D(^DGPT(D0,"M",T(I),"P"))  S DGTD=+^("P") Q:'$D(^ICD(DGTD,0))  W !?3,"TRANSFER DRG: ",DGTD," - "
 N DXD,DGDX
 S DXD=$$DRGD^ICDGTDRG(DGTD,"DGDX",,$$GETDATE^ICDGTDRG(D0)),DGDS=0
 F  S DGDS=$O(DGDX(DGDS)) Q:'+DGDS  Q:DGDX(DGDS)=" "  W !,DGDX(DGDS)
 Q
HEAD I $E(IOST,1)="C" W *7 R X:DTIME I X=U S DN=0 Q
 S DC=DC+1 W @IOF,! X:$D(^UTILITY($J,2)) ^(2) W ! F K=1:1:IOM W "_"
 W !,"("_$P(^DPT(+^DGPT(D0,0),0),U,1)_")",!
 Q
SUR D HEAD:$Y>(IOSL-7) G Q:'DN S S1=^DGPT(D0,"S",I,0),Y=+S1 D D^DGPTUTL W !!,"   Date of Surg: ",Y,?45,"Chief Surg: " S L=";"_$P(^DD(45.01,4,0),U,3),L1=";"_$P(S1,U,4)_":" W $P($P(L,L1,2),";",1)
 W !,"    Anesth Tech: " S L=";"_$P(^DD(45.01,6,0),U,3),L1=";"_$P(S1,U,6)_":" W $P($P(L,L1,2),";",1),?45,"First Asst: " S L=";"_$P(^DD(45.01,5,0),U,3),L1=";"_$P(S1,U,5)_":" W $P($P(L,L1,2),";",1)
 W !,"  Source of pay: " S L=";"_$P(^DD(45.01,7,0),U,3),L1=";"_$P(S1,U,7)_":" W $P($P(L,L1,2),";",1)
 W ?46,"Surg spec: ",$S($D(^DIC(45.3,+$P(S1,U,3),0)):$P(^(0),U,2),1:"")
 W !!,?7,"Surg/pro: " F K=1:1:5 S L=$P(S1,U,K+7) I L'="" S DGPTTMP=$$ICDOP^ICDCODE(+L,$$GETDATE^ICDGTDRG(D0)) W $S(+DGPTTMP>0:$P(DGPTTMP,U,5)_" ("_$P(DGPTTMP,U,2)_")",1:"**********-"_L),!?17
 ;-- display expanded codes
 S DG300=$S($D(^DGPT(D0,"S",I,300)):^(300),1:"") I DG300]"" D PRN3^DGPTFM8
 K DG300
 Q
PROC S DGF="" F I=1:1:5 S DGPTTMP=$$ICDOP^ICDCODE(+$P(DGOP1,U,I),$$GETDATE^ICDGTDRG(D0)),DGOP=$S(DGPTTMP>0:$P(DGPTTMP,U,2,99),1:"") I DGOP D 
 . W:'DGF !!?6,"Procedure: " W $P(DGOP,U,4)_" ("_$P(DGOP,U)_")",!?17 S DGF=1
 Q
601 ;print the procedures/dates from the 601 procedure multiple (eff. 10/1/87)
 F J=5:1:9 S DGPTTMP=$$ICDOP^ICDCODE(+$P(DG601,U,J),$$GETDATE^ICDGTDRG(D0)),DGPROC=$S(+DGPTTMP>0:$P(DGPTTMP,U,2,99),1:"") I DGPROC W !?17,$P(DGPROC,U,4)_" ("_$P(DGPROC,U)_")"
 Q
DXLS D HEAD:$Y>(IOSL-16) S DGPTDAT=$$GETDATE^ICDGTDRG(D0)
 S DGPTTMP=$$ICDDX^ICDCODE(+$P(DGPT,U,10),DGPTDAT),DXLS=$S(+DGPTTMP>0:$P(DGPTTMP,U,2,99),1:"") I DXLS]"" W !!?11,"PRINCIPAL DIAGNOSIS: ",$P(DXLS,U,3)_" ("_$P(DXLS,U)_")"
 I 'DXLS S DGPTTMP=$$ICDDX^ICDCODE(+$P(DGPT,U,11),DGPTDAT),DGP=$S(+DGPTTMP>0:$P(DGPTTMP,U,2,99),1:"") I DGP]"" W !!," Principal Diag: ",$P(DGP,U,3)_" ("_$P(DGP,U)_")"
 S K=DGPT F I=16:1:24 D DSP
 S K=$G(^DGPT(D0,71)) F I=1:1:4 D DSP
 ;-- display expanded code information
 S DG300=$S($D(^DGPT(D0,300)):^(300),1:"") D:DG300]"" PRN2^DGPTFM8 K DG300
 D EN2^DGPTF4 Q
Q Q
Q1 K ^UTILITY(U,$J),DG1 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))," " W:Y#100 $J(Y#100\1,2),"," W Y\10000+1700 W:Y#1 "  ",$E(Y_0,9,10),":",$E(Y_"000",11,12)
 Q
DSP S J=$$ICDDX^ICDCODE(+$P(K,U,I),DGPTDAT) I J&$P(J,U,10) D
 .I I#2 W ?40,$P(J,U,4)_"("_$P(J,U,2)_")" Q
 .W !,$P(J,U,4)_"("_$P(J,U,2)_")"
 Q
