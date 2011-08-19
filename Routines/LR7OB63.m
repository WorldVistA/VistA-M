LR7OB63 ; DALOI/dcm - Get Lab data from 63 ;8/11/97
 ;;5.2;LAB SERVICE;**121,187,286,372,406**;Sep 27, 1994;Build 1
 ;
63(CTR,LRDFN,SS,IVDT,CORRECT) ;Get data from file 63
 ;CTR=Counter
 ;LRDFN=Patient ID
 ;SS=Subscript for results 'CH'-Chem Tox 'MI'-Microbiology, etc.
 ;IVDT=Inverse D/T verified
 ;CORRECT=1 if a corrected result, 0 if not
 ;See ^LR7OB69 for description of LRX array
 I $G(CONTROL)="ZC" Q
 N IFN
 I $L(SS),$L($T(@SS)) G @SS
 Q
 ;
 ;
CH ;Chem, Hem, Tox, Ria, Ser, etc.
 N LRX,X0,Y1,Y2,Y3,Y4,Y5,Y6,Y12,Y14,Y15,Y16,Y17,Y18
 Q:'$D(^LR(LRDFN,"CH",+$G(IVDT),0))  S X0=^(0)
 S Y6=$S(+$G(CORRECT):"C",$P(X0,"^",3):"F",1:"")
 S Y16=$P(X0,"^",6)
 S Y17=$$ORD^LR7OR2(LRDFN,IVDT),Y18=";CH;"_IVDT
 ;
 I '$D(SEX) N SEX S SEX=$P($G(@("^"_$P(LRDPF,"^",2)_+DFN_",0)")),"^",2)
 ;
 I '$D(DOB)!'$D(AGE) N AGE,DOB D
 . S DOB=$P($G(@("^"_$P(LRDPF,"^",2)_+DFN_",0)")),"^",3)
 . S AGE=$S($D(DT)&(DOB?7N):DT-DOB\10000,1:"??")
 ;
 S IFN=1
 F  S IFN=$O(^LR(LRDFN,"CH",IVDT,IFN)) Q:IFN<1  S X=^(IFN) I $D(TSTY(IFN))!($D(BYPASS)),$S('$D(LRSB):1,$D(LRSB(IFN)):1,1:0) D
 . I $D(LRSB(IFN)),$D(LRSA(IFN)),'$D(LRSA(IFN,2)),'$D(LRSA(IFN,3)) Q  ;Only re-transmit changed results
 . S Y1=IFN,Y1=$O(^LAB(60,"C","CH;"_Y1_";1",0)),Y2=$P(X,"^"),Y3=$P(X,"^",2),Y12=$P(X,"^",4)
 . S:Y2="pending" Y6="P" ;Set result status to P for pending results
 . Q:"IN"[$P(^LAB(60,Y1,0),"^",3)  S Y15=$P($G(^LAB(60,Y1,.1)),"^")
 . S (Y9,Y10,Y11,Y14)=""
 . I $P($G(^LAB(60,Y1,64)),"^") S Y9=$P(^(64),"^"),Y9=$P(^LAM(Y9,0),"^",2),Y10=$P(^(0),"^"),Y11="99NLT"
 . ;D UNIT(Y1,$P(X0,"^",5),SEX,DOB,AGE)
 . S LRX=$$TSTRES^LRRPU(LRDFN,"CH",IVDT,IFN,Y1)
 . S Y2=$P(LRX,"^"),Y3=$P(LRX,"^",2),Y4=$P(LRX,"^",5),Y5=$$EN^LRLRRVF($P(LRX,"^",3),$P(LRX,"^",4))
 . I $P(LRX,"^",7) S Y14="T"
 . S Y2=$$TRIM^XLFSTR($$RESULT(Y1,Y2),"LR"," ")
 . S ^TMP("LRX",$J,69,CTR,63,IFN)=Y1_"^"_Y2_"^"_Y3_"^"_Y4_"^"_Y5_"^"_Y6_"^^^"_Y9_"^"_Y10_"^"_Y11_"^"_Y12_"^^"_Y14_"^"_Y15_"^"_Y16_"^"_Y17_"^"_Y18
 ;
 I $D(GOTCOM(LRDFN,"CH",IVDT)) Q
 S GOTCOM(LRDFN,"CH",IVDT)="",IFN=0
 F  S IFN=$O(^LR(LRDFN,"CH",IVDT,1,IFN)) Q:IFN<1  S ^TMP("LRX",$J,69,CTR,63,"N",IFN)=$P(^LR(LRDFN,"CH",IVDT,1,IFN,0),"^")
 ;
 Q
 ;
 ;
MI ;Microbiology
 D MI^LR7OB63A()
 Q
 ;
 ;
BB ;Blood bank
 D BB1()
 Q
 ;
 ;
BB1(SPECMEN) ;Blood bank
 ;SPECMEN=ptr to 61, to specify specimen (optional)
 N X0,Y1,Y2,Y3,Y4,Y5,Y6,Y15,Y18,Y19,CTR1
 Q:'$D(^LR(LRDFN,"BB",+$G(IVDT),0))  S X0=^(0),Y6=$S(+$G(CORRECT):"C",$P(X0,"^",3):"F",1:""),Y19=$P(X0,"^",5),CTR1=0,Y18=";BB;"_IVDT
 ;There are other multiples for blood bank in file 63 that also need to be processed, this is just a start.
 I $G(SPECMEN),Y19'=SPECMEN Q
 S IFN=1 F  S IFN=$O(^LR(LRDFN,"BB",IVDT,IFN)) Q:IFN<1  I $D(^(IFN))#2 S XNODE=^(IFN) F IFN1=1:1:$L(XNODE,"^") S X1=$P(XNODE,"^",IFN1) I $L(X1) D
 . S X=$$NODEPIK(63.01,IFN,IFN1,X1) ;X=field^data
 . I $L($P(X,"^")) S CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=X_"^^^^"_Y6_"^^^^^^^^^"_X_"^^^"_Y18_"^"_Y19
 I $D(^LR(LRDFN,"BB",IVDT,99)) S Y1="Specimen Comment: " S IFN=0 F  S IFN=$O(^LR(LRDFN,"BB",IVDT,99,IFN)) Q:IFN<1  S Y2=^(IFN,0),^TMP("LRX",$J,69,CTR,63,"N",IFN)=Y1_"^"_Y2
 Q
 ;
 ;
EM ;Electron Microscopy
 D SS^LR7OB63C("EM")
 Q
 ;
 ;
SP ;Surgical Pathology
 D SS^LR7OB63C("SP")
 Q
 ;
 ;
CY ;Cytology
 D SS^LR7OB63C("CY")
 Q
 ;
 ;
AU ;Autopsy
 D AU^LR7OB63D
 Q
 ;
 ;
NODEPIK(FILE,NODE,PIECE,DATA) ;Set field name and data into X
 N Z,Y,Y1,Y2
 S Z=$O(^DD(FILE,"GL",NODE,PIECE,0)),X=""
 I Z S Y=^DD(FILE,Z,0),Y1=$P(Y,"^"),Y2=DATA S:$P(Y,"^",2)["S" Y2=$$SET(FILE,Z,Y2) S:$P(Y,"^",2)["P"!($P(Y,"^",2)["V") Y2=$$POINTER(FILE,Z,Y2) S X=Y1_"^"_Y2
 Q X
 ;
 ;
UNIT(X,SPEC,SEX,DOB,AGE) ;Find units and ref range
 ;X=Result
 ;SPEC=Specimen ptr
 ;SEX=Patient sex
 ;DOB=Patient Date of birth
 ;AGE=Patient age
 ;Output: Y4=Units, Y5=Ref Range, Y14=T or "" (If T, range is theraputic)
 N LO,HI
 S (Y4,Y5,Y14)=""
 Q:'$D(^LAB(60,+X,1,+SPEC,0))  S X=^(0) ;No units/ranges defined
 S Y4=$P(X,"^",7)
 S @("LO="_$S($L($P(X,"^",2)):$P(X,"^",2),$L($P(X,"^",11)):$P(X,"^",11),1:""""""))
 S @("HI="_$S($L($P(X,"^",3)):$P(X,"^",3),$L($P(X,"^",12)):$P(X,"^",12),1:""""""))
 S Y5=$S($L(HI):LO_"-"_HI,1:LO)
 S Y14=$S('$L($P(X,"^",2))&$L($P(X,"^",11)):"T",1:"")
 Q
 ;
 ;
RESULT(TEST,RESULT) ;Convert result to external format
 ;TEST=Test ptr to file 60
 ;RESULT=Test result
 N X,X1,LRCW
 S LRCW="",X1=$P($G(^LAB(60,TEST,.1)),"^",3),X1=$S($L(X1):X1,1:"$J(X,8)"),X=RESULT,@("X="_X1)
 Q X
 ;
 ;
STRIP(TEXT) ;Strips white space from text
 N I,X
 S X="" F I=1:1:$L(TEXT," ") S:$A($P(TEXT," ",I))>0 X=X_$P(TEXT," ",I)
 Q X
 ;
 ;
SET(FILE,FIELD,RESULT) ;Interpret set of codes
 S X=$P(^DD(FILE,FIELD,0),"^",3),X=$P($P(";"_X,";"_RESULT_":",2),";")
 Q X
 ;
 ;
POINTER(FILE,FIELD,RESULT) ;Interpret pointer values
 N X
 S X=$P(^DD(FILE,FIELD,0),"^",2)
 I X["V" S X1=@("^"_$P(RESULT,";",2)_+RESULT_",0)")
 I X'["V" S X1=$P(@("^"_$P(^DD(FILE,FIELD,0),"^",3)_RESULT_",0)"),"^")
 Q X1
