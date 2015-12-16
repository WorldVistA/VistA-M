DGPTFMO ;ALB/JDS/ADL,HIOFO/FT - DGPTF PRINT TEMPLATE ;10/15/14 2:25pm
 ;;5.3;Registration;**195,397,510,590,594,606,683,729,664,850,884**;Aug 13, 1993;Build 31
 ;;ADL;Updated for CSV Project;;Mar 4, 2003
 ;
 ; ICDEX APIs - #5747
 ; ICDGTDRG APIs - #4052
 ; ICDXCODE APIs - #5699
 ;
EN ;called from print template DGPT CENSUS INQUIRY
 K A,B,AD,ADA,DGDD,DGDDPTR,DGLOOP,DGFC,HEAD,DGPTFE,DGST,DGN,T,T82,DGM82,EFFDATE,IMPDATE,DGPTDAT
 F DGLOOP=4:1:7 D  ;get the set of codes for fields 4,5,6, & 7 in 45.01 (401 data - Surgery)
 .K DGERROR,DGRESULT
 .S DGDDPTR(DGLOOP)=""
 .D FIELD^DID(45.01,DGLOOP,,"POINTER","DGRESULT","DGERROR")
 .I '$D(DGERROR) S DGDDPTR(DGLOOP)=$G(DGRESULT("POINTER"))
 K DGERROR,DGRESULT
 ;
 F I=0:0 S I=$O(^DGPT(D0,"M",I)) Q:I'>0  I $D(^(I,0)) S J=+$P(^(0),U,10) S:'J J=999999999 S:$D(T(J)) J=J+.01*I S T(J)=I
 F I=0:0 S I=$O(T(I)) Q:I'>0  S DGM=$S($D(^DGPT(D0,"M",T(I),0)):^(0),1:"") D:DGM]"" WRITE
 ;
 K T F I=0:0 S I=$O(^DGPT(D0,"S",I)) Q:I'>0  D SUR
 S DGOP1=$S($D(^DGPT(D0,"401P")):^("401P"),1:"")
 I DGOP1]"" D HEAD:$Y>(IOSL-10) G Q:'DN D PROC
 I $D(^DGPT(D0,"P")) D HEAD:$Y>(IOSL-10) G Q:'DN F I=0:0 S I=$O(^DGPT(D0,"P",I)) Q:I'>0  S DG601=^DGPT(D0,"P",I,0),Y=+DG601 D D^DGPTUTL W !!?5,"Procedure Date: ",Y,$$GETLABEL^DGPTIC10(EFFDATE,"P") D 601
 S DGPT=$G(^DGPT(D0,70)) I DGPT]"" G Q:'DN D DXLS
 K %,DGL,DGM,DGPT,DGOP,DGOP1,DGF,DGP,DXLS,DGICD,L1,S1,T,J,K,DGPR,DGN,AGE,B,DA,DAM,DFN,DGST,DOB,DP,DRG,EXP,NO,P,PTF,DGPTFE,SD1,SEX,TAC,TRS,DGDS,DGTD,DGPROC,DG601,DGPTDAT
 W !
 K T82,DGM82,DGMPOA,DGLOOP
 Q
WRITE D HEAD:$Y>(IOSL-12) G Q:'DN S Y=$P(DGM,U,10),DGL=+$P(DGM,U,2),DGL=$S($D(^DIC(42.4,DGL,0)):^(0),1:""),DGL=$P(DGL,U,1) D D^DGPTUTL
 ; ICD-10 CALLS
 D EFFDATE^DGPTIC10(D0)
 ;
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
 S DGF="",J=0 K DG501
 D PTFICD^DGPTFUT(501,D0,T(I),.DG501,1)
 F  S J=$O(DG501(J)) Q:'J  D
 . S DGMPOA=$P(DG501(J),U,2) ;get POA code
 . S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+$P(DG501(J),U,1),EFFDATE)
 . W:DGF="" !!?5,"DX: ",$$GETLABEL^DGPTIC10(EFFDATE,"D")
 . D WRITECOD^DGPTIC10("DIAG",+$P(DG501(J),U,1),EFFDATE,2,1,8)
 . I $P(DGPTTMP,U,20)=30 W:$X>73 !,"            " W " (POA=",$S(DGMPOA]"":DGMPOA,1:"''"),")"
 . W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"")
 . S DGF=1
 K DG501
 ;-- display expanded codes 
 S DG300=$S($D(^DGPT(D0,"M",T(I),300)):^(300),1:"") I DG300]"" D HEAD:$Y>(IOSL-6) D PRN2^DGPTFM8 W !
 K DG300
 ;Display TRANSFER DRG with description
 Q:'$D(^DGPT(D0,"M",T(I),"P"))  S DGTD=+^("P") Q:$P($$CODEC^ICDEX(80,DGTD),U,1)="-1"  W !?3,"TRANSFER DRG: ",DGTD," - "
 N DXD,DGDX
 S DXD=$$DRGD^ICDGTDRG(DGTD,"DGDX",,$$GETDATE^ICDGTDRG(D0)),DGDS=0
 F  S DGDS=$O(DGDX(DGDS)) Q:'+DGDS  Q:DGDX(DGDS)=" "  W !,DGDX(DGDS)
 Q
HEAD I $E(IOST,1)="C" W *7 R X:DTIME I X=U S DN=0 Q
 S DC=DC+1 W @IOF,! X:$D(^UTILITY($J,2)) ^(2) W ! F K=1:1:IOM W "_"
 W !,"("_$P(^DPT(+^DGPT(D0,0),0),U,1)_")",!
 Q
SUR ;
 D HEAD:$Y>(IOSL-7) G Q:'DN S S1=^DGPT(D0,"S",I,0),Y=+S1 D D^DGPTUTL W !!,"   Date of Surg: ",Y,?45,"Chief Surg: "
 S L=";"_DGDDPTR(4),L1=";"_$P(S1,U,4)_":" W $P($P(L,L1,2),";",1)
 W !,"    Anesth Tech: " S L=";"_DGDDPTR(6),L1=";"_$P(S1,U,6)_":" W $P($P(L,L1,2),";",1),?45,"First Asst: "
 S L=";"_DGDDPTR(5),L1=";"_$P(S1,U,5)_":" W $P($P(L,L1,2),";",1)
 W !,"  Source of pay: " S L=";"_DGDDPTR(7),L1=";"_$P(S1,U,7)_":" W $P($P(L,L1,2),";",1)
 W ?46,"Surg spec: ",$S($D(^DIC(45.3,+$P(S1,U,3),0)):$P(^(0),U,2),1:"")
 W !!,?5,"Surg/pro: ",$$GETLABEL^DGPTIC10(EFFDATE,"P"),!?7
 S K=0 K DG401
 D PTFICD^DGPTFUT(401,D0,I,.DG401,1)
 F  S K=$O(DG401(K)) Q:'K  D
 . S L=$P(DG401(K),U,1),DGPTTMP=""
 . I L'="" S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",+L,EFFDATE) D
 .. D WRITECOD^DGPTIC10("PROC",+L,EFFDATE,2,1,8)
 .. W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"")
 K DG401
 ;-- display expanded codes
 S DG300=$S($D(^DGPT(D0,"S",I,300)):^(300),1:"") I DG300]"" D PRN3^DGPTFM8
 K DG300
 Q
PROC ;
 S DGF="" F I=1:1:5 D:$P(DGOP1,U,I)'=""
 . S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",+$P(DGOP1,U,I),EFFDATE)
 . W:'DGF !!?5,"Procedure: ",$$GETLABEL^DGPTIC10(EFFDATE,"P") S DGF=1
 . D WRITECOD^DGPTIC10("PROC",+$P(DGOP1,U,I),EFFDATE,2,1,8)
 . W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"")
 Q
601 ;print the procedures/dates from the 601 procedure multiple (eff. 10/1/87)
 K DG601 S J=0
 D PTFICD^DGPTFUT(601,D0,I,.DG601,1)
 F  S J=$O(DG601(J)) Q:'J  D
 . S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",+$P(DG601(J),U,1),EFFDATE)
 . D WRITECOD^DGPTIC10("PROC",+$P(DG601(J),U,1),EFFDATE,2,1,8)
 . W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"")
 K DG601
 Q
DXLS D HEAD:$Y>(IOSL-16)
 S DGPOA1=$P($G(^DGPT(D0,82)),U,1) ;POA for principal DX
 I +$P(DGPT,U,10) D
 . S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+$P(DGPT,U,10),EFFDATE),DXLS=$S(+DGPTTMP>0:$P(DGPTTMP,U,2,99),1:"")
 . W !!?5,"PRINCIPAL DIAGNOSIS: ",$$GETLABEL^DGPTIC10(EFFDATE,"D")
 . D WRITECOD^DGPTIC10("DIAG",+$P(DGPT,U,10),EFFDATE,2,1,8)
 . W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"")
 . Q:$P(DGPTTMP,U,20)'=30  ;not an ICD10 DX
 . W " ["_$S(DGPOA1]"":DGPOA1,1:" ")_"]" ;show POA value
 ;
 I +$P(DGPT,U,11) D
 . S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+$P(DGPT,U,11),EFFDATE)
 . D WRITECOD^DGPTIC10("DIAG",+$P(DGPT,U,11),EFFDATE,2,1,8)
 . W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"")
 . Q:$P(DGPTTMP,U,20)'=30  ;not an ICD10 DX
 . W " ["_$S(DGPOA1]"":DGPOA1,1:" ")_"]" ;show POA value. there shouldn't be one for old records
 K DG701,DGPOA1 S K=0
 D PTFICD^DGPTFUT(701,D0,,.DG701,1)
 F  S K=$O(DG701(K)) Q:'K  D:$P(DG701(K),U,1)>0 DSP
 K DG701
 ;-- display expanded code information
 S DG300=$S($D(^DGPT(D0,300)):^(300),1:"") D:DG300]"" PRN2^DGPTFM8 K DG300
 D EN2^DGPTF4 ;calls ^DGPTFD to get DX/OP codes and then calls DGPTICD to calculate & store DRG value in PTF CLOSE OUT (#45.84) file.
 Q
Q Q
Q1 K ^UTILITY(U,$J),DG1
 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))," " W:Y#100 $J(Y#100\1,2),"," W Y\10000+1700 W:Y#1 "  ",$E(Y_0,9,10),":",$E(Y_"000",11,12)
 Q
DSP ;
 S J=$$ICDDATA^ICDXCODE("DIAG",+$P(DG701(K),U,1),EFFDATE) D
 . D WRITECOD^DGPTIC10("DIAG",+$P(DG701(K),U,1),EFFDATE,2,1,8)
 . W $S(+J<1!('$P(J,U,10)):"*",1:"")
 . Q:$P(J,U,20)'=30  ;not an ICD-10 DX
 . W " ["_$S($P(DG701(K),U,2)]"":$P(DG701(K),U,2),1:" ")_"]"
 Q
