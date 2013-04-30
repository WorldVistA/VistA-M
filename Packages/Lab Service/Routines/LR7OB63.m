LR7OB63 ;DALOI/JMC - Get Lab data from 63 ;05/10/11  13:51
 ;;5.2;LAB SERVICE;**121,187,286,372,406,350**;Sep 27, 1994;Build 230
 ;
63(CTR,LRDFN,SS,IVDT,CORRECT) ;Get data from file 63
 ; CTR=Counter
 ; LRDFN=Patient ID
 ; SS=Subscript for results 'CH'-Chem Tox 'MI'-Microbiology, etc.
 ; IVDT=Inverse D/T verified
 ; CORRECT=1 if a corrected result, 0 if not
 ; See ^LR7OB69 for description of LRX array
 I $G(CONTROL)="ZC" Q
 N IFN
 I SS'="",$L($T(@SS)) G @SS
 Q
 ;
 ;
CH ;Chem, Hem, Tox, Ria, Ser, etc.
 N I,LRX,PORDER,X0,Y1,Y2,Y3,Y4,Y5,Y6,Y12,Y14,Y15,Y16,Y17,Y18
 F I="LRPLS","LRPLS-ADDR" K ^TMP(I,$J)
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
 . S LRX=$$TSTRES^LRRPU(LRDFN,"CH",IVDT,IFN,Y1)
 . S Y2=$P(LRX,"^"),Y3=$P(LRX,"^",2),Y4=$P(LRX,"^",5),Y5=$$EN^LRLRRVF($P(LRX,"^",3),$P(LRX,"^",4))
 . I $P(LRX,"^",7) S Y14="T"
 . S Y2=$$TRIM^XLFSTR($$RESULT(Y1,Y2),"LR"," ")
 . S PORDER=$P($G(^LAB(60,Y1,.1)),"^",6),PORDER=$S(PORDER:PORDER,1:998+(IFN/10000000))
 . I $D(^TMP("LRX",$J,69,CTR,63,PORDER)) F PORDER=PORDER:.00000001 I '$D(^TMP("LRX",$J,69,CTR,63,PORDER)) Q
 . S ^TMP("LRX",$J,69,CTR,63,PORDER)=Y1_"^"_Y2_"^"_Y3_"^"_Y4_"^"_Y5_"^"_Y6_"^^^"_Y9_"^"_Y10_"^"_Y11_"^"_Y12_"^^"_Y14_"^"_Y15_"^"_Y16_"^"_Y17_"^"_Y18
 . D INTP
 . I $P(LRX,"^",6) S ^TMP("LRPLS",$J,"CH",IVDT,$P(LRX,"^",6),$P(^LAB(60,Y1,0),"^"))=""
 ;
 I '$D(GOTCOM(LRDFN,"CH",IVDT)) D
 . S GOTCOM(LRDFN,"CH",IVDT)="",IFN=0
 . F  S IFN=$O(^LR(LRDFN,"CH",IVDT,1,IFN)) Q:IFN<1  S ^TMP("LRX",$J,69,CTR,63,"N",IFN)=$P(^LR(LRDFN,"CH",IVDT,1,IFN,0),"^")
 . D ORDP($P($G(^LR(LRDFN,"CH",IVDT,0)),"^",10)) ; Display ordering provider
 . D RRDT($P(X0,"^",3)) ; Display report released date/time
 . I $G(LRPLSAVE) S LRPLSAVE(0)=CTR ; Save reference to which entry has comments
 ;
 ; List reporting/performing laboratories
 ; If save for calling routine then save LRIDT value for calling routine
 ;  otherwise print reporting/performing labs now
 I $D(LRPLSAVE) D
 . S LRPLSAVE("CH",IVDT)=""
 E  D
 . D PLS
 . F I="LRPLS","LRPLS-ADDR" K ^TMP(I,$J)
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
 N CTR1,XNODE,X0,Y1,Y2,Y3,Y4,Y5,Y6,Y15,Y18,Y19
 Q:'$D(^LR(LRDFN,"BB",+$G(IVDT),0))  S X0=^(0),Y6=$S(+$G(CORRECT):"C",$P(X0,"^",3):"F",1:""),Y19=$P(X0,"^",5),CTR1=0,Y18=";BB;"_IVDT
 ;There are other multiples for blood bank in file 63 that also need to be processed, this is just a start.
 I $G(SPECMEN),Y19'=SPECMEN Q
 S IFN=1
 F  S IFN=$O(^LR(LRDFN,"BB",IVDT,IFN)) Q:IFN<1  I $D(^(IFN))#2 S XNODE=^(IFN) F IFN1=1:1:$L(XNODE,"^") S X1=$P(XNODE,"^",IFN1) I $L(X1) D
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
 ;
 ;
ORDP(LRPROV) ; Display ordering provider in comment
 N LRY,CNT
 S LRY=$$NAME^XUSER(LRPROV,"G")
 S CNT=$O(^TMP("LRX",$J,69,CTR,63,"N",""),-1)+1
 S ^TMP("LRX",$J,69,CTR,63,"N",CNT)=" ",CNT=CNT+1
 S ^TMP("LRX",$J,69,CTR,63,"N",CNT)="Ordering Provider: "_LRY
 Q
 ;
 ;
PLS ; List reporting and performing laboratories
 ; If multiple performing labs then list tests associated with each lab.
 ;
 N CNT,LINE,LLEN,LRPLS,LRX,MPLS,PLS,TESTNAME,X
 ;
 S CNT=$O(^TMP("LRX",$J,69,CTR,63,"N",""),-1)+1
 ;
 ; Reporting Laboratory
 I $$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")#2 D
 . S LRX=+$G(^LR(LRDFN,"CH",IVDT,"RF"))
 . I LRX<1 Q
 . S LINE=$$PLSADDR^LR7OSUM2(LRX)
 . S ^TMP("LRX",$J,69,CTR,63,"N",CNT)=" ",CNT=CNT+1
 . S ^TMP("LRX",$J,69,CTR,63,"N",CNT)="Reporting Lab: "_$P(LINE,"^"),CNT=CNT+1
 . S ^TMP("LRX",$J,69,CTR,63,"N",CNT)="               "_$P(LINE,"^",2),CNT=CNT+1
 ;
 S PLS=$O(^TMP("LRPLS",$J,"CH",IVDT,0)),MPLS=0
 I $O(^TMP("LRPLS",$J,"CH",IVDT,PLS)) S MPLS=1 ; multiple performing labs
 S LRPLS=0
 F  S LRPLS=$O(^TMP("LRPLS",$J,"CH",IVDT,LRPLS)) Q:LRPLS<1  D
 . S ^TMP("LRX",$J,69,CTR,63,"N",CNT)=" ",CNT=CNT+1
 . I MPLS D
 . . S TESTNAME="",LINE="For test(s): ",LLEN=13
 . . F  S TESTNAME=$O(^TMP("LRPLS",$J,"CH",IVDT,LRPLS,TESTNAME)) Q:TESTNAME=""  D
 . . . S X=$L(TESTNAME)
 . . . I (LLEN+X)>240 S ^TMP("LRX",$J,69,CTR,63,"N",CNT)=LINE,CNT=CNT+1,LINE="",LLEN=0
 . . . S LINE=LINE_$S(LLEN>13:", ",1:"")_TESTNAME,LLEN=LLEN+X+$S(LLEN>13:2,1:0)
 . . I LINE'="" S ^TMP("LRX",$J,69,CTR,63,"N",CNT)=LINE,CNT=CNT+1
 . S LINE=$$PLSADDR^LR7OSUM2(LRPLS)
 . S ^TMP("LRX",$J,69,CTR,63,"N",CNT)="Performing Lab: "_$P(LINE,"^"),CNT=CNT+1
 . S ^TMP("LRX",$J,69,CTR,63,"N",CNT)="                "_$P(LINE,"^",2),CNT=CNT+1
 ;
 S ^TMP("LRX",$J,69,CTR,63,"N",CNT)=" "
 ;
 K ^TMP("LRPLS",$J,"CH",IVDT)
 Q
 ;
 ;
RRDT(LRDT) ; Display report released date/time
 N LRY,CNT
 I LRDT S LRY=$$FMTE^XLFDT(LRDT,"M")
 E  S LRY=""
 S CNT=$O(^TMP("LRX",$J,69,CTR,63,"N",""),-1)+1
 S ^TMP("LRX",$J,69,CTR,63,"N",CNT)="Report Released Date/Time: "_LRY
 Q
 ;
 ;
INTP ; Check and add any file #60 interpretation
 ;
 N INTP,SPEC
 S SPEC=$P(^LR(LRDFN,"CH",IVDT,0),"^",5)
 I SPEC,Y1,$D(^LAB(60,Y1,1,SPEC,1,0)) D
 . S INTP=0
 . F  S INTP=+$O(^LAB(60,Y1,1,SPEC,1,INTP)) Q:INTP<1  S ^TMP("LRX",$J,69,CTR,63,PORDER,INTP)=^(INTP,0)
 ;
 Q
