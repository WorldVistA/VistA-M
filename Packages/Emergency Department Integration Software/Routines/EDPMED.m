EDPMED ;SLC/MKB - EDIS medication utilities ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
OEL(Y,DFN,ORDER,IDT) ; -- Return ^TMP("PS",$J) data
 ;  in Y("attribute")=value
 K ^TMP("PS",$J) D OEL^PSOORRL(DFN,ORDER)
 N X0,X,XC,FAC,SEQ,SUB
 S X0=$G(^TMP("LRRR",$J,DFN,"CH",IDT,SEQ))
 S Y("subscript")=SUB,Y("accession")=SUB_";"_IDT
 S Y("collected")=$$FMTHL7^XLFDT(9999999-IDT)
 S Y("testID")=+X0,Y("testName")=$P($G(^LAB(60,+X0,0)),U),X=+$P($G(^(.1)),U,6)
 S Y("printOrder")=$S(X:+X,1:SEQ/1000000)
 S:$L($P(X0,U,2)) Y("result")=$P(X0,U,2)
 S:$L($P(X0,U,4)) Y("units")=$P(X0,U,4)
 S:$L($P(X0,U,3)) Y("deviation")=$P(X0,U,3)
 S X=$P(X0,U,5) I $L(X),X["-" S Y("low")=$P(X,"-"),Y("high")=$P(X,"-",2)
 S Y("printName")=$P(X0,U,15)
 S Y("number")=$P(X0,U,16)
 S X=+$P(X0,U,19) D  ;sample & specimen
 . N SPC,CS,LRDFN
 . S:X<1 LRDFN=+$G(^DPT(DFN,"LR")),X=+$P($G(^LR(LRDFN,SUB,IDT,0)),U,5)
 . S SPC=$G(^LAB(61,X,0)) Q:'$L(SPC)
 . S Y("specimen")=$P(SPC,U),CS=+$P(SPC,U,6)
 . S:CS Y("sample")=$P($G(^LAB(62,CS,0)),U)
 S X=+$P(X0,U,17),XC=$Q(^LRO(69,"C",X))
 I $P(XC,",",1,3)=("^LRO(69,""C"","_X) D  ;get Lab Order info
 . N LRO,LR3
 . S LRO=$G(^LRO(69,+$P(XC,",",4),1,+$P(XC,",",5),0)),LR3=$G(^(3))
 . ;S X=+$P(LRO,U,6) S:X Y("provider")=X_U_$P($G(^VA(200,X,0)),U)
 . S X=+$P(LRO,U,11) S:X Y("order")=X
 . S X=$P(LR3,U,2) S:X Y("resultedTS")=$$FMTHL7^XLFDT(X)
 S FAC=$$SITE^VASITE S:FAC Y("stnNum")=$P(FAC,U,3),Y("stnName")=$P(FAC,U,2)
 I $D(^TMP("LRRR",$J,DFN,SUB,IDT,"N")) D  ;M Y("comment")=^("N")
 . N I S I=1,X=$G(^TMP("LRRR",$J,DFN,SUB,IDT,"N",I))
 . F  S I=$O(^TMP("LRRR",$J,DFN,SUB,IDT,"N",I)) Q:I<1  S X=X_$C(13,10)_^(I)
 . S Y("comment")=X
 Q
