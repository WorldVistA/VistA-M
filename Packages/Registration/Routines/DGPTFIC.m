DGPTFIC ;ALB/JDS/ADL,HIOFO/FT - PTF CODE SEARCH ;4/21/2015 4:14pm
 ;;5.3;Registration;**510,559,599,669,704,744,832,850,884**;Aug 13, 1993;Build 31
 ;;ADL;;Update for CSV Project;;Mar 25, 2003
 ;
 ; LEXU APIs - #5679
 ; ICDEX APISs - #5747
 ; ICDSAPI APIs - #5757
 ; ICDXCODE APIs - #5699
 ;
 ;;Patch DG*5.3*832 notations are for additional checks to insure the
 ;;                 search includes looking at secondary diagnostic 
 ;;                 codes 10-13, in node ^DGPT(ien,71)
EN ;Diagnostic Code PTF Record Search [DG PTF ICD DIAGNOSTIC SEARCH]
 K DG1 S DIC="^ICD9("
 D CODESET^DGPTEXPR Q:CODESET<1
 G RANGE
E9 K DIC S DHD=DHD_"  Diagnostic Code Search"
 ;
F9 ; search ^DGPT for the DX codes
 S DIS(0)="I $D(^DGPT(D0,0)),$P(^(0),U,11)=1 S DG2=0,L=1,D1=+$O(^DGPT(D0,""M"",0)) X DIS(""0AAA""),DIS(""0A"") I DG2 S ^UTILITY($J,""DG"",0)=""D"""   ;;DG*832
 S DIS("0A")="F E=0:0 X DIS(""0AA"") S D1=$O(^DGPT(D0,""M"",D1)) Q:D1'>0"
 S DG9=$S('DGR:"I DG1[(U_DGIEN_U)",1:"D EFFDATE^DGPTIC10(D0) S DG=$$ICDDATA^ICDXCODE(""DIAG"",+DGIEN,EFFDATE) I $P(DG,U,20)=DGTERMIE S DG4=$S(+DG>0&($P(DG,U,10)):$P(DG,U,2),1:"""")_""!"" I DG4]DG1&(DG6]DG4)")
 S XAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=DGZD_U_DG3DT_U_DGIEN"
 S DIS("0AA")="I $D(^DGPT(D0,""M"",D1,0)) D 501^DGPTFIC F DGZD=1:1:25 S DGIEN=$P(DG3,U,DGZD) "_DG9_" X XAA"
 S XAAA="D EFFDATE^DGPTIC10(D0) S DG2=DG2+1,$P(^UTILITY($J,""DG"",D0,""A""),U,DGZD)=$$CODEC^ICDEX(80,+DGIEN)"
 S DIS("0AAA")="I $D(^DGPT(D0,70)) D 701^DGPTFIC F DGZD=1:1:25 S DGIEN=$P(DG3,U,DGZD) "_DG9_" X XAAA"
 S L=0
 ;
GO ;
 K DG9 W !,"Searching the PTF file  Select fields to sort by",! S DIC="^DGPT(",L=0
 S FLDS=$S($G(CODESET)=9:"[DGICD-9]",$G(CODESET)=10:"[DGICD-10]",1:"[DGICD]") D EN1^DIP
Q ; kill variables
 K DIS,DGZD,DGZJ,DINS,DXS,DTOUT,DG4,DGR,DIP,DP,%,DGZJJ,DGZT,DG1,DHD,I,J,DG2,DG3,DG3DT,DG5,DG6,DG7,DG8,DG9,D0,DJ,DTOT,FLDS,L,PROMPT,Z,X,DIC,X1,Y,XAA,XAAA,XAAAA
 K CODESET,DGDAT,DGPTDAT,DGTERM,DGTERMIE,DGVDT,LEXQ,LEXVDT,EFFDATE,IMPDATE,DG,DGIEN
 Q
 ;
EN1 ;Surgical Code PTF Record Search [DG PTF ICD SURGICAL SEARCH]
 S DIC="^ICD0("
 D CODESET^DGPTEXPR Q:CODESET<1
 G RANGE
E0 K DIC S DHD=DHD_" Surgical Code Search"
F0 ; search ^DGPT for the procedure codes
 S DIS(0)="I $D(^DGPT(D0,0)),$P(^(0),U,11)=1 S DG2=0,L=1 X:$D(^DGPT(D0,""P"")) DIS(""0AAAA"") S D1=+$O(^DGPT(D0,""S"",0)) X DIS(""0AAA"") X DIS(""0A"") I DG2 S ^UTILITY($J,""DG"",0)=""P"""
 S DIS("0A")="F E=0:0 X DIS(""0AA"") S D1=$O(^DGPT(D0,""S"",D1)) Q:D1'>0"
 S DG9=$S('DGR:"I DG1[(U_+DGIEN_U)",1:"D EFFDATE^DGPTIC10(D0) S DG=$$ICDDATA^ICDXCODE(""PROC"",+DGIEN,EFFDATE) I $P(DG,U,15)=DGTERMIE S DG4=$S(+DG>0&($P(DG,U,10)):$P(DG,U,2),1:"""")_""!"" I DG4]DG1&(DG6]DG4)")
 S XAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=DGZD_U_DG3DT_U_DGIEN"
 S DIS("0AA")="I $D(^DGPT(D0,""S"",D1,0)) D 401^DGPTFIC F DGZD=1:1:25 S DGIEN=$P(DG3,U,DGZD) "_DG9_" X XAA"
 S XAAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=DGZD_U_U_DGIEN"
 S DIS("0AAA")="I $D(^DGPT(D0,""401P"")) S DG3=^(""401P"") F DGZD=1:1:5 S DGIEN=$P(DG3,U,DGZD) "_DG9_" X XAAA"
 S XAAAA="S DG2=DG2+1,^UTILITY($J,""DG"",D0,DG2)=DGZD_U_DG3DT_U_DGIEN"
 S DIS("0AAAA")="F D1=0:0 S D1=$O(^DGPT(D0,""P"",D1)) Q:D1'>0  I $D(^DGPT(D0,""P"",D1,0)) D 601^DGPTFIC F DGZD=1:1:25 S DGIEN=$P(DG3,U,DGZD) "_DG9_" X XAAAA"
 S L=0
 G GO
 Q
OUT ; -- Output called from Print templates DGICD and DGICD-10
 S DGZJ=$X,DG2=$S(DGZT["ICD":"^ICD9(",1:"^ICD0("),DIO=1
 F I=0:0 S I=$O(^UTILITY($J,"DG",D0,I)) Q:I'>0  D
 . S J=^(I),Y=$P($P(J,U,2),".",1) X ^DD("DD") ;^(I) references global in line above 
 . W:I>1 !?DGZJ W DGZT_$P(J,U,1)_"  "_Y
 . W ?DGZJ+23,$P(@(DG2_"$P(J,U,3)"_",0)"),U,1)
 . I DG5 S DJ=$S($D(DJ):DJ,1:0)+1,DTOT=1
 ;
 Q:'$D(^UTILITY($J,"DG",D0,"A"))  S J=^("A")
 F I=1:1:25 S K=$P(J,U,I) I K]"" W !?DGZJ,$S(I=1:"PRINCIPAL DIAGNOSIS",1:"SECONDARY DIAG "_I),?DGZJ+23,K I DG5 S DJ=$S($D(DJ):DJ,1:0)+1,DTOT=1
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
 N DIC,DGDAT ;,EFFDATE,IMPDATE,TERM,DGTEMP
 S DGDAT=$S(EFFDATE'="":EFFDATE,1:DT)
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
 . Q
 I CODESET=10 D
 . I X["*" S X=$P(X,"*",1)_$P(X,"*",2)
 . D ASK^DGICP
 ;
 I '$D(X),'$D(Y) G PROC ;Invalid ICD entry
 I $G(Y)<1,$G(X)=DGSAV G PROC ; Invalid ICD-9 entry
 I $G(Y)>0 S X=+Y,Y=$$ICDDATA^ICDXCODE("PROC",$G(X),EFFDATE)
 K LEXVDT
 Q Y
 ;
401 ; Build 25 piece string with OPERATION codes
 N DG401
 S DG401=$G(^DGPT(D0,"S",D1,0)),DG3=$$STR401^DGPTFUT(D0,D1),DG3DT=$P(DG401,U,1)
 Q
501 ; Build 25 piece string with MOVEMENT codes
 N DG501
 S DG501=$G(^DGPT(D0,"M",D1,0)),DG3=$$STR501^DGPTFUT(D0,D1),DG3DT=$P(DG501,U,10)
 Q
601 ; Build 25 piece string with PROCEDURE codes
 N DG601
 S DG601=$G(^DGPT(D0,"P",D1,0)),DG3=$$STR601^DGPTFUT(D0,D1),DG3DT=$P(DG601,U,1)
 Q
701 ; Build 25 piece string with DIAGNOSTIC codes
 S DG3=$$STR701^DGPTFUT(D0)
 Q
