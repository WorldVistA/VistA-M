DGPTFIC ;ALB/JDS/ADL - PTF CODE SEARCH ;26 JAN 87 @0800 [7/12/04 2:53pm]
 ;;5.3;Registration;**510,559,599,669,704,744,832,850**; Aug 13, 1993;Build 171
 ;;ADL;;Update for CSV Project;;Mar 25, 2003
 ;
 ; CODEC^ICDEX     ICR 5747
 ;
 ;;Patch DG*5.3*832 notations are for additional checks to insure the
 ;;                 search includes looking at secondary diagnostic 
 ;;                 codes 10-13, in node ^DGPT(ien,71)
EN K DG1 S DIC="^ICD9("
 D CODESET^DGPTEXPR Q:CODESET<1
 G RANGE
E9 K DIC S DHD=DHD_"  Diagnostic Code Search"
 ;
F9 ;
 S DIS(0)="I $D(^DGPT(D0,0)),$P(^(0),U,11)=1 S DG2=0,L=1,D1=+$O(^DGPT(D0,""M"",0)) X DIS(""0AAA""),DIS(""0BBB""),DIS(""0A"") I DG2 S ^UTILITY($J,""DG"",0)=""D"""   ;;DG*832
 S DIS("0A")="F E=0:0 X DIS(""0AA"") S D1=$O(^DGPT(D0,""M"",D1)) Q:D1'>0"
 S DG9=$S('DGR:"I DG1[(U_$P(DG3,U,DGZD)_U)",1:"D EFFDATE^DGPTIC10(D0) S DG=$$ICDDATA^ICDXCODE(""DIAG"",+$P(DG3,U,DGZD),EFFDATE) I $P(DG,U,20)=DGTERMIE S DG4=$S(+DG>0&($P(DG,U,10)):$P(DG,U,2),1:"""")_""!"" I DG4]DG1&(DG6]DG4)")
 S XAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=$S(DGZD<11:DGZD-4,1:DGZD-5)_U_$P(DG3,U,10)_U_$P(DG3,U,DGZD)"
 S DIS("0AA")="I $D(^DGPT(D0,""M"",D1,0)) S DG3=^(0) F DGZD=5:1:15 "_DG9_" X XAA"
 S XAAA="D EFFDATE^DGPTIC10(D0) S DG2=DG2+1,$P(^UTILITY($J,""DG"",D0,""A""),U,DGZD)=$$CODEC^ICDEX(80,+$P(DG3,U,DGZD))"
 S XBBB="D EFFDATE^DGPTIC10(D0) S DG2=DG2+1,$P(^UTILITY($J,""DG"",D0,""A""),U,DGZD+24)=$$CODEC^ICDEX(80,+$P(DG3,U,DGZD))"  ;;DG*832
 S DIS("0AAA")="I $D(^DGPT(D0,70)) S DG3=^(70) F DGZD=10,16:1:24 "_DG9_" X XAAA"
 S DIS("0BBB")="I $D(^DGPT(D0,71)) S DG3=^(71) F DGZD=1:1:4 "_DG9_" X XBBB"   ;;DG*832
 S L=0
 ;
GO ;
 K DG9 W !,"Searching the PTF file  Select fields to sort by",! S DIC="^DGPT(",L=0
 S FLDS=$S($G(CODESET)=9:"[DGICD-9]",$G(CODESET)=10:"[DGICD-10]",1:"[DGICD]") D EN1^DIP
Q K DIS,DGZD,DGZJ,DINS,DXS,DTOUT,DG4,DGR,DIP,DP,%,DGZJJ,DGZT,DG1,DHD,I,J,DG2,DG3,DG5,DG6,DG7,DG8,DG9,D0,DJ,DTOT,FLDS,L,PROMPT,Z,X,DIC,X1,Y,XAA,XAAA,XAAAA,XBBB
 K CODESET,DGDAT,DGPTDAT,DGTERM,DGTERMIE,DGVDT,LEXQ,LEXVDT,EFFDATE,IMPDATE,DG
 Q
 ;
EN1 ;
 S DIC="^ICD0("
 D CODESET^DGPTEXPR Q:CODESET<1
 G RANGE
E0 K DIC S DHD=DHD_" Surgical Code Search"
F0 S DIS(0)="I $D(^DGPT(D0,0)),$P(^(0),U,11)=1 S DG2=0,L=1 X:$D(^DGPT(D0,""P"")) DIS(""0AAAA"") S D1=+$O(^DGPT(D0,""S"",0)) X DIS(""0AAA"") X DIS(""0A"") I DG2 S ^UTILITY($J,""DG"",0)=""P"""
 S DIS("0A")="F E=0:0 X DIS(""0AA"") S D1=$O(^DGPT(D0,""S"",D1)) Q:D1'>0"
 S DG9=$S('DGR:"I DG1[(U_$P(DG3,U,DGZD)_U)",1:"D EFFDATE^DGPTIC10(D0) S DG=$$ICDDATA^ICDXCODE(""PROC"",+$P(DG3,U,DGZD),EFFDATE) I $P(DG,U,15)=DGTERMIE S DG4=$S(+DG>0&($P(DG,U,10)):$P(DG,U,2),1:"""")_""!"" I DG4]DG1&(DG6]DG4)")
 S XAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=(DGZD-7)_U_$P(DG3,U,1)_U_$P(DG3,U,DGZD)"
 S DIS("0AA")="I $D(^DGPT(D0,""S"",D1,0)) S DG3=^(0) F DGZD=8:1:12 "_DG9_" X XAA"
 S XAAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=DGZD_U_U_$P(DG3,U,DGZD)"
 S DIS("0AAA")="I $D(^DGPT(D0,""401P"")) S DG3=^(""401P"") F DGZD=1:1:5 "_DG9_" X XAAA"
 S XAAAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=(DGZD-4)_U_$P(DG3,U,1)_U_$P(DG3,U,DGZD)"
 S DIS("0AAAA")="F D1=0:0 S D1=$O(^DGPT(D0,""P"",D1)) Q:D1'>0  I $D(^DGPT(D0,""P"",D1,0)) S DG3=^(0) F DGZD=5:1:9 "_DG9_" X XAAAA"
 S L=0
 G GO
 Q
 ;
OUT ; -- Output called from Print template DGICD
 S DGZJ=$X,DG2=$S(DGZT["ICD":"^ICD9(",1:"^ICD0("),DIO=1
 F I=0:0 S I=$O(^UTILITY($J,"DG",D0,I)) Q:I'>0  D
 . S J=^(I),Y=$P($P(J,U,2),".",1) X ^DD("DD")
 . W:I>1 !?DGZJ W DGZT_$P(J,U,1)_"  "_Y
 . W ?DGZJ+23,$P(@(DG2_"$P(J,U,3)"_",0)"),U,1)
 . I DG5 S DJ=$S($D(DJ):DJ,1:0)+1,DTOT=1
 ;
 Q:'$D(^UTILITY($J,"DG",D0,"A"))  S J=^("A") F I=10,16:1:28 S K=$P(J,U,I) I K]"" W !?DGZJ,$S(I=10:"PRINCIPAL DIAGNOSIS",1:"SECONDARY DIAG "_(I-15)),?DGZJ+23,K I DG5 S DJ=$S($D(DJ):DJ,1:0)+1,DTOT=1
 Q
HDRR ;
 N HDR,OLDHDR
 S OLDHDR="FOUND______DATE________CODE" ;L30
 I CODESYS=9 S HDR="FOUND______DATE________ICD-9 CODE"
 I CODESYS=10 S HDR="FOUND______DATE________ICD-10 CODE"
 ;
DHD S PROMPT="Then search for: ",DIC("S")=$S($G(DIC("S"))="":"I DG1'[(U_+Y_U)",1:DIC("S")_"&(DG1'[(U_+Y_U))")
 F I=0:0 D  Q:Y<1  S DG1=DG1_+Y_U Q:$L(DG1)>235
 . S Y=$$ICDLOOK(DGTERM,DGVDT,DIC("A")) Q:Y<1  S DG1=DG1_+Y_U Q:$L(DG1)>235
 S DHD="" F I=2:1 S DHD=DHD_$S(I'=2:",  ",1:"")_$P(@(DIC_"$P(DG1,U,I)"_",0)"),U,1) Q:'$P(DG1,U,I+1)  I $L(DHD)>200 S DHD=DHD_"....." Q
 ;
C W !,"Total by PTF record or ICD count: P// " S Z="^PTF record^ICD count" R X:DTIME G Q:X=U!'$T X:X="" "S X=""P"" W X" D IN^DGHELP G H:%=-1 S DG5=$S(X="I":1,1:0) Q
 ;
H W !!,"The search may have more than 1 match per PTF record",!,"Type 'P' to total only PTF records",!,"Type 'I' to total all matches",! G C
H1 W !!,"Type 'R' to specify a range of codes",!,"     'E' to specify a series of codes to match exactly",!
 ;
RANGE ;
 S DIC(0)="AMEQZ" K LEXVDT
 S DGTERM=$S(DIC[9&(CODESET=9):"ICD",DIC[9&(CODESET=10):"10D",DIC[0&(CODESET=9):"ICP",DIC[0&(CODESET=10):"10P",1:"")
 S DGTERMIE=$S(DIC[9&(CODESET=9):1,DIC[9&(CODESET=10):30,DIC[0&(CODESET=9):2,DIC[0&(CODESET=10):31,1:"")
 S DGVDT=$$IMPDATE^LEXU("10D")
 I CODESET=9 S DGVDT=DGVDT-30000
 I CODESET=10 S DGVDT=DGVDT+3 ; 3 days later
 W !,"Search by Range or Exact match: E// "
 S Z="^RANGE^EXACT MATCH" R X:DTIME
 G Q:X=U!'$T X:X="" "S X=""E"" W X" D IN^DGHELP G H1:%=-1 S DGR=$S(X="R":1,1:0)
 S DG7=$S(DIC[9:"Diagnosis",1:"Surgical") G E:'DGR
 S DIC("A")="Start with "_DG7_" code: "
 S Y=$$ICDLOOK(DGTERM,DGVDT,DIC("A")) G Q:Y'>0 S DG1=$P(Y,U,2)_" "
F ;
 S DIC("A")="Go to "_DG7_" code: " S Y=$$ICDLOOK(DGTERM,DGVDT,DIC("A")) G Q:+Y<1
 S DG6=$P(Y,U,2)_"! " I DG6']DG1 W !,"Must be after start code",! G F
 S DHD=DG1_" to "_$P(DG6,"!",1)_" "_DG7_" Code Search" D C G Q:'$D(X),@("F"_$E(DIC,5))
 Q
 ;
E ;
 S DIC("A")="Select "_DG7_" code: "
 S Y=$$ICDLOOK(DGTERM,DGVDT,DIC("A"))
 G Q:Y'>0 S DG1=U_+Y_U D DHD G Q:'$D(X),@("E"_$E(DIC,5))
 Q
ICDLOOK(TERM,EFFDATE,PROMPT) ; icd lookup
 ; called from DGPTFIC and DGPTDRG
 K X,Y,LEXVDT
 N DIC ;,EFFDATE,IMPDATE,TERM,DGTEMP
 I '$G(DGDAT) S DGDAT=DT
 I TERM="10D"!(TERM="ICD") D DIAG
 I TERM="10P"!(TERM="ICP") D PROC
 Q $G(Y)
 ;
DIAG ; Ask diagnosis
 N DGSAV,DIR
 ;
 I $G(PROMPT)'="" S DIR("A")=PROMPT
 ;1/16/2014 String must be at least 3 chars and up to 30 chars, 
 ;but API's truncate, so no need to reject over 30. ICD-9 has no listed upper boundary
 ;lower boundary needs to be 1 to allow for "?"
 I CODESET=10 S DIR(0)="FAO^1:",DIR("?")="^D D1^DGICDGT",DIR("??")="^D D2^DGICDGT"
 I CODESET=9 S DIR(0)="FAO^1:",DIR("?")="^D D19^DGICDGT",DIR("??")="^D D29^DGICDGT"
 D ^DIR
 S DGSAV=$G(Y)
 I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))!(Y="") S Y=-1 Q
 I CODESET=9 D ICDEN1^DGPTF5 ;maintain legacy search
 I CODESET=10 D LEX^DGICD
 I ($D(DUOUT))!($D(DIRUT)),DGSAV=$G(Y) G DIAG ;User entered an "^" during the search - start over.
 I $G(X)="",$G(Y)'=-1,$L($G(Y))=1,$L($G(DGSAV))=1 G DIAG ; If 1 character answer, repeat request
 I '$D(X),'$D(Y) G DIAG ;Invalid ICD-10 entry
 I $G(Y)<1,$G(X)=DGSAV G DIAG ; Invalid ICD-9 entry
 I $G(Y)>0 S X=+Y,Y=$$ICDDATA^ICDXCODE("DIAG",$G(X),EFFDATE)
 Q
 ;
PROC ; Ask Procedure
 N DGSAV,DIR,IMPDATE
 S IMPDATE=$$IMPDATE^LEXU(31)
 I $G(CODESET)="" S CODESET=$S(DT<$G(IMPDATE):9,1:10)
 I '$D(EFFDATE) S EFFDATE=$S(CODESET=10:IMPDATE+1,1:IMPDATE-1)
 ;
 S DIR(0)="FAO^1:12"
 I $G(PROMPT)'="" S DIR("A")=PROMPT
 I $G(CODESET)=10 S DIR("?")="^D P1^DGICDGT",DIR("??")="^D P2^DGICDGT"
 I $G(CODESET)=9 S DIR("?")="^D P19^DGICDGT",%=0
 D ^DIR
 S DGSAV=$G(Y)
 I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))!(Y="") S Y=-1 Q
 I CODESET=9 S Y=$$SEARCH^ICDSAPI("PROC",,"QEMZ",EFFDATE) D
 . I +$G(DGSAV)>0,$G(Y)<1,'+$G(X) K X,Y ; Original Search value was valid but ICDSAPI returned -1
 .Q
 I CODESET=10 D
 . I X["*" S X=$P(X,"*",1)_$P(X,"*",2)
 . D ASK^DGICP
 ;
 I '$D(X),'$D(Y) G PROC ;Invalid ICD-10 entry
 I $G(Y)<1,$G(X)=DGSAV G PROC ; Invalid ICD-9 entry
 I $G(Y)>0 S X=+Y,Y=$$ICDDATA^ICDXCODE("PROC",$G(X),EFFDATE)
 K LEXVDT
 ;
 Q Y
