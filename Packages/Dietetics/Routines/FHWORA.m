FHWORA ; HISC/GJC - OE/RR Procedure Call (Assessments) ;11/6/97  15:35
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
FHWORADT(DFN) ; Pass back the Assessment Dates for a particular patient.
 ;----------------------------------------------------------------------
 ; Input : DFN -> the ien of the patient
 ; Output: -1^error text -> no assessments passed back with reason being
 ;                          error text
 ;         1 -> Assessments for our patient have been found.  Data will
 ;              stored in:
 ;              ^TMP($J,"FHADT",DFN,inv internal dt/time)=ext dt/time
 ;----------------------------------------------------------------------
 Q:'$L(DFN) "-1^patient data missing"
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q "-1^patient data missing"
 Q:'$D(^FHPT(FHDFN,0)) "-1^invalid patient (not in Dietetics Patient file)"
 Q:'+$O(^FHPT(FHDFN,"N",0)) "-1^No assessments on file"
 ;K ^TMP($J,"FHADT",DFN) N FH115A,I S I=6929298 ;7/1/2007
 ;K ^TMP($J,"FHADT",DFN) N FH115A,I S I=6929398 ;6/1/2007
 K ^TMP($J,"FHADT",DFN) N FH115A,I S I=6928998 ;10/1/2007
 F  S I=$O(^FHPT(FHDFN,"N",I)) Q:I'>0  D
 . S FH115A=$G(^FHPT(FHDFN,"N",I,0))
 . S ^TMP($J,"FHADT",DFN,I)=$$FMTE^XLFDT($P(FH115A,"^"),1)
 . Q
 Q $S($D(^TMP($J,"FHADT",DFN)):1,1:"-1^No assessments prior to 10/1/2007 on file")
 ;
FHWORASM(DFN,FHADTX) ; Store Assessment data so it can be displayed
 ;----------------------------------------------------------------------
 ; Input : DFN    -> ien of the patient
 ;         FHADTX -> Assessment Date (external format)
 ; Output: -1^error text, error text will be failure reason
 ;         1, no error data to be stored in:
 ;         ^TMP($J,"FHASM",DFN,seq #)="lines of text"
 ;----------------------------------------------------------------------
 Q:'$L(DFN) "-1^patient data missing"
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q "-1^patient data missing"
 Q:'$L(FHADTX) "-1^patient assessment date missing"
 Q:+FHADTX=FHADTX "-1^expecting the external format for a date/time"
 Q:'$D(^FHPT(FHDFN,0)) "-1^invalid patient (not in Dietetics Patient file)"
 N FHADTI,FHADTINV D DT^DILF("T",FHADTX,.FHADTI)
 Q:FHADTI=-1 "-1^invalid assessment date"
 S FHADTINV=(9999999-FHADTI)
 Q:'$D(^FHPT(FHDFN,"N",FHADTINV,0)) "-1^No assessments on file for this date/time"
 K ^TMP($J,"FHASM",DFN)
 N ACIR,ACIRP,ADT,AGE,AMP,BFAMA,BFAMAP,BMI,BMIP,CCIR,CCIRP,CNT,DTP,DWGT
 N FHAPPER,FHASMNT,FHLAB,FHUNIT,FLD,FRM,HGP,HGT,I,IBW,KCAL,N,NAM,NB,PRO
 N RC,SCA,SCAP,SEX,STR,STR1,TAB,TSF,TSFP,UWGT,WGP,WGT,X,X1,X2,X3,XD,Y,Z
 S CNT=0
 ; Note: '^FH(119.9,1' is the Dietetics Site Parameter file!
 S FHUNIT=$P($G(^FH(119.9,1,3)),"^") ; Eng. or Metric units of measure
 S FHASMNT(0)=$G(^FHPT(FHDFN,"N",FHADTINV,0))
 F I=1:1:22 S @$P("ADT SEX AGE HGT HGP WGT WGP DWGT UWGT IBW FRM AMP X X X KCAL PRO FLD RC XD BMI BMIP"," ",I)=$P(FHASMNT(0),"^",I)
 S SIGN=$P(FHASMNT(0),U,23) S:SIGN'="" SIGN1="Entered by: "_$P($P(^VA(200,SIGN,0),U),",",2)_" "_$P($P(^VA(200,SIGN,0),U),",") K SIGN
 S NAM=$P(^DPT(DFN,0),"^"),NB=$P(FHASMNT(0),"^",25)
 S SEX=$S(SEX="M":"Male",SEX="F":"Female",1:"")
 S FHASMNT(1)=$G(^FHPT(FHDFN,"N",FHADTINV,1))
 F I=1:1:10 S @$P("TSF TSFP SCA SCAP ACIR ACIRP CCIR CCIRP BFAMA BFAMAP"," ",I)=$P(FHASMNT(1),"^",I)
 S FHAPPER=$G(^FHPT(FHDFN,"N",FHADTINV,2)),I=0
 F  S I=$O(^FHPT(FHDFN,"N",FHADTINV,"L",I)) Q:I'>0  S FHLAB(I)=$G(^(I,0))
 D SETUP^FHWORA1
 Q $S($D(^TMP($J,"FHASM",DFN)):1,1:"-1^No assessments on file for this date/time")
 ;
CNT(X) ; Increment our subscript
 S X=X+1 S CNT=X
 Q CNT
 ;
COMMENT ; Display the Nutritional Assessment comments.
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=" "
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))="Comments"
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=" "
 Q:'+$O(^FHPT(FHDFN,"N",FHADTINV,"X",0))  ; quit if no comments
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,FHI,X
 S DIWF="",DIWL=1,DIWR=79 K ^UTILITY($J,"W",DIWL) S FHI=0
 F  S FHI=$O(^FHPT(FHDFN,"N",FHADTINV,"X",FHI)) Q:FHI'>0  D
 . S X=$G(^FHPT(FHDFN,"N",FHADTINV,"X",FHI,0)) D ^DIWP
 . Q
 S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  D
 . S ^TMP($J,"FHASM",DFN,$$CNT(CNT))=$G(^UTILITY($J,"W",DIWL,I,0))
 . Q
 K ^UTILITY($J,"W",DIWL)
 Q
 ;
LAB(I) ; Display lab data for our patient.
 S X1=$P(FHLAB(I),"^",7) Q:X1=""  S DTP=X1\1 D DTP^FH
 S:'X3 ^TMP($J,"FHASM",DFN,$$CNT(CNT))=" " ; initial linefeed
 S X3=X3+1 ; lab data found? $S(X3>0:"Yes",1:"No")
 K STR S $P(STR," ",81)="",TAB=5
 S $E(STR,(TAB+1),(TAB+$L($P(FHLAB(I),"^"))))=$P(FHLAB(I),"^")
 S TAB=27
 S $E(STR,(TAB+1),(TAB+$L($P(FHLAB(I),"^",6))))=$P(FHLAB(I),"^",6)
 S TAB=40
 S $E(STR,(TAB+1),(TAB+$L($P(FHLAB(I),"^",4))))=$P(FHLAB(I),"^",4)
 S TAB=51
 S $E(STR,(TAB+1),(TAB+$L($P(FHLAB(I),"^",5))))=$P(FHLAB(I),"^",5)
 S TAB=65,$E(STR,(TAB+1),(TAB+$L(DTP)))=DTP
 S ^TMP($J,"FHASM",DFN,$$CNT(CNT))=STR
 Q
 ;
TRUNC(I) ; Set each node to no more than eighty (80) chars in length.
 N A,B,C S A=$L(I(0)),B=A\80
 F C=1:1:B S ^TMP($J,"FHASM",DFN,$$CNT(CNT))=$E(I(0),$S(C=1:1,1:((C-1)*80)),((C*80)-1))
 S ^TMP($J,"FHASM",DFN,$$CNT(CNT))=$E(I(0),(((80*B)+1)-1),A)
 Q
