DGPTFIC ;ALB/JDS/ADL - PTF CODE SEARCH ; 26 JAN 87 @0800 [7/12/04 2:53pm]
 ;;5.3;Registration;**510,559,599,669,704,744**; Aug 13, 1993;Build 5
 ;;ADL;;Update for CSV Project;;Mar 25, 2003
EN K DG1 S DIC="^ICD9("   ;;S DIC("S")="I $$ISVALID^ICDGTDRG(+Y,DGDAT,9)" G RANGE
   G RANGE
E9 K DIC S DHD=DHD_"  Diagnostic Code Search"
F9 S DIS(0)="I $D(^DGPT(D0,0)),$P(^(0),U,11)=1 S DG2=0,L=1,D1=+$O(^DGPT(D0,""M"",0)) X DIS(""0AAA""),DIS(""0A"") I DG2 S ^UTILITY($J,""DG"",0)=""D""",DIS("0A")="F E=0:0 X DIS(""0AA"") S D1=$O(^DGPT(D0,""M"",D1)) Q:D1'>0"
 S DG9=$S('DGR:"I DG1[(U_$P(DG3,U,DGZD)_U)",1:"S DG=$$ICDDX^ICDCODE(+$P(DG3,U,DGZD),$$GETDATE^ICDGTDRG(D0)) S DG4=$S(+DG>0&($P(DG,U,10)):$P(DG,U,2),1:"""")_""!"" I DG4]DG1&(DG6]DG4)")
 S XAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=$S(DGZD<11:DGZD-4,1:DGZD-5)_U_$P(DG3,U,10)_U_$P(DG3,U,DGZD)"
 S DIS("0AA")="I $D(^DGPT(D0,""M"",D1,0)) S DG3=^(0) F DGZD=5:1:15 "_DG9_" X XAA"
 S XAAA="S DG2=DG2+1,$P(^UTILITY($J,""DG"",D0,""A""),U,DGZD)=$P($$ICDDX^ICDCODE(+$P(DG3,U,DGZD),$$GETDATE^ICDGTDRG(D0)),U,2)"
 S DIS("0AAA")="I $D(^DGPT(D0,70)) S DG3=^(70) F DGZD=10,16:1:24 "_DG9_" X XAAA"
 S L=0
GO K DG9 W !,"Searching the PTF file  Select fields to sort by",! S DIC="^DGPT(",FLDS="[DGICD]",L=0 D EN1^DIP
Q K DIS,DGZD,DGZJ,DINS,DXS,DTOUT,DG4,DGR,DIP,DP,%,DGZJJ,DGZT,DG1,DHD,I,J,DG2,DG3,DG5,DG6,DG7,DG8,DG9,D0,DJ,DTOT,FLDS,L,PROMPT,Z,X,DIC,X1,Y,XAA,XAAA,XAAAA Q
EN1 ;
 S DIC="^ICD0("   ;;S DIC("S")="I $$ISVALID^ICDGTDRG(+Y,DGDAT,0)" G RANGE
 G RANGE
E0 K DIC S DHD=DHD_" Surgical Code Search"
F0 S DIS(0)="I $D(^DGPT(D0,0)),$P(^(0),U,11)=1 S DG2=0,L=1 X:$D(^DGPT(D0,""P"")) DIS(""0AAAA"") S D1=+$O(^DGPT(D0,""S"",0)) X DIS(""0AAA"") X DIS(""0A"") I DG2 S ^UTILITY($J,""DG"",0)=""P"""
 S DIS("0A")="F E=0:0 X DIS(""0AA"") S D1=$O(^DGPT(D0,""S"",D1)) Q:D1'>0"
 S DG9=$S('DGR:"I DG1[(U_$P(DG3,U,DGZD)_U)",1:"S DG=$$ICDOP^ICDCODE(+$P(DG3,U,DGZD),$$GETDATE^ICDGTDRG(D0)) S DG4=$S(+DG>0&($P(DG,U,10)):$P(DG,U,2),1:"""")_""!"" I DG4]DG1&(DG6]DG4)")
 S XAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=(DGZD-7)_U_$P(DG3,U,1)_U_$P(DG3,U,DGZD)"
 S DIS("0AA")="I $D(^DGPT(D0,""S"",D1,0)) S DG3=^(0) F DGZD=8:1:12 "_DG9_" X XAA"
 S XAAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=DGZD_U_U_$P(DG3,U,DGZD)"
 S DIS("0AAA")="I $D(^DGPT(D0,""401P"")) S DG3=^(""401P"") F DGZD=1:1:5 "_DG9_" X XAAA"
 S XAAAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=(DGZD-4)_U_$P(DG3,U,1)_U_$P(DG3,U,DGZD)"
 S DIS("0AAAA")="F D1=0:0 S D1=$O(^DGPT(D0,""P"",D1)) Q:D1'>0  I $D(^DGPT(D0,""P"",D1,0)) S DG3=^(0) F DGZD=5:1:9 "_DG9_" X XAAAA"
 S L=0
 G GO
 Q
OUT S DGZJ=$X,DG2=$S(DGZT["ICD":"^ICD9(",1:"^ICD0("),DIO=1
 F I=0:0 S I=$O(^UTILITY($J,"DG",D0,I)) Q:I'>0  S J=^(I),Y=$P($P(J,U,2),".",1) X ^DD("DD") W:I>1 !?DGZJ W DGZT_$P(J,U,1)_"  "_Y W ?DGZJ+23,$P(@(DG2_"$P(J,U,3)"_",0)"),U,1) I DG5 S DJ=$S($D(DJ):DJ,1:0)+1,DTOT=1
 Q:'$D(^UTILITY($J,"DG",D0,"A"))  S J=^("A") F I=10,16:1:24 S K=$P(J,U,I) I K]"" W !?DGZJ,$S(I=10:"PRINCIPAL DIAGNOSIS",1:"ICD "_(I-14)),?DGZJ+23,K I DG5 S DJ=$S($D(DJ):DJ,1:0)+1,DTOT=1
 Q
DHD S PROMPT="Then search for: ",DIC("S")=$S($G(DIC("S"))="":"I DG1'[(U_+Y_U)",1:DIC("S")_"&(DG1'[(U_+Y_U))")
 I DG7="Diagnosis" F I=0:0 D ICDEN1^DGPTF5 Q:X=""  S X="`"_+Y D ^DIC Q:Y'>0  S DG1=DG1_+Y_U Q:$L(DG1)>235
 E  F I=0:0 D ^DIC Q:Y'>0  S DG1=DG1_+Y_U Q:$L(DG1)>235
 S DHD="" F I=2:1 S DHD=DHD_$S(I'=2:",  ",1:"")_$P(@(DIC_"$P(DG1,U,I)"_",0)"),U,1) Q:'$P(DG1,U,I+1)  I $L(DHD)>200 S DHD=DHD_"....." Q
C W !,"Total by PTF record or ICD count: P// " S Z="^PTF record^ICD count" R X:DTIME G Q:X=U!'$T X:X="" "S X=""P"" W X" D IN^DGHELP G H:%=-1 S DG5=$S(X="I":1,1:0) Q
H W !!,"The search may have more than 1 match per PTF record",!,"Type 'P' to total only PTF records",!,"Type 'I' to total all matches",! G C
H1 W !!,"Type 'R' to specify a range of codes",!,"     'E' to specify a series of codes to match exactly",!
RANGE S DIC(0)="AMEQZ" W !,"Search by Range or Exact match: E// " S Z="^RANGE^EXACT MATCH" R X:DTIME G Q:X=U!'$T X:X="" "S X=""E"" W X" D IN^DGHELP G H1:%=-1 S DGR=$S(X="R":1,1:0)
 S DG7=$S(DIC[9:"Diagnosis",1:"Surgical") G E:'DGR
 S DIC("A")="Start with "_DG7_" code: "
 ;I DG7="Diagnosis" S DIC(0)="XMQZ",PROMPT="Start with "_DG7_" code: " D ICDEN1^DGPTF5 Q:X=""  S X="`"_+Y D ^DIC G Q:Y'>0 S DG1=$P(Y(0),U,1)_" "
 ;E  S DIC("A")="Start with "_DG7_" code: " D ^DIC G Q:Y'>0 S DG1=$P(Y(0),U,1)_" "
 D ^DIC G Q:Y'>0 S DG1=$P(Y(0),U,1)_" "
F ;I DG7="Diagnosis" S PROMPT="Go to "_DG7_" code: " D ICDEN1^DGPTF5 Q:X=""  S X="`"_+Y D ^DIC G Q:Y'>0 S DG6=$P(Y(0),U,1)_"! " I DG6']DG1 W !,"Must be after start code",! G F
 ;E  S DIC("A")="Go to "_DG7_" code: " D ^DIC G Q:Y'>0 S DG6=$P(Y(0),U,1)_"! " I DG6']DG1 W !,"Must be after start code",! G F
 S DIC("A")="Go to "_DG7_" code: " D ^DIC G Q:Y'>0 S DG6=$P(Y(0),U,1)_"! " I DG6']DG1 W !,"Must be after start code",! G F
 S DHD=DG1_" to "_$P(DG6,"!",1)_" "_DG7_" Code Search" D C G Q:'$D(X),@("F"_$E(DIC,5))
 Q
E ;I DG7="Diagnosis" S DIC(0)="XMQZ",PROMPT="Enter "_DG7_" Code to search for: " D ICDEN1^DGPTF5 Q:X=""  S X="`"_+Y D ^DIC G Q:Y'>0 S DG1=U_+Y_U D DHD G Q:'$D(X),@("E"_$E(DIC,5))
 ;E  S PROMPT="Enter "_DG7_" Code to search for: " D ^DIC G Q:Y'>0 S DG1=U_+Y_U D DHD G Q:'$D(X),@("E"_$E(DIC,5))
 D ^DIC G Q:Y'>0 S DG1=U_+Y_U D DHD G Q:'$D(X),@("E"_$E(DIC,5))
