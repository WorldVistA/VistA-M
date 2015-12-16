VPRDRMIM ;SLC/MKB -- FIM extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; %DT                          10003
 ; DIQ                           2056
 ; RMIMRP                        4745
 ;
 ; ------------ Get FIM cases from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find patient's FIM cases
 N VPRSITE,VPRS,VPRN,VPRY,ADM,VPRITM,VPRCNT
 D PRM^RMIMRP(.VPRSITE) Q:'$O(VPRSITE(1))
 ;
 ; get one case
 I $G(IFN) D EN1(IFN,.VPRITM),XML(.VPRITM) G ENQ
 ;
 ; get all patient FIM cases
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999),VPRCNT=0
 S VPRS=1 F  S VPRS=$O(VPRSITE(VPRS)) Q:VPRS<1  D
 . S VPRN=DFN_U_VPRSITE(VPRS)
 . D LC^RMIMRP(.VPRY,VPRN) Q:VPRY(1)<1
 . S VPRN=1 F  S VPRN=$O(VPRY(VPRN)) Q:(VPRN<1)!(VPRCNT'<MAX)  D
 .. S ADM=$$DATE($P(VPRY(VPRN),U,4)) Q:ADM<BEG  Q:ADM>END
 .. K VPRITM D EN1(+VPRY(VPRN),.VPRITM),XML(.VPRITM)
 .. S VPRCNT=VPRCNT+1
ENQ ;done
 Q
 ;
EN1(ID,FIM) ; -- return a case in FIM("attribute")=value
 N VPRM,X,I,TYPE,MOTOR,COGNTV K FIM
 S ID=+$G(ID) Q:ID<1  ;invalid ien
 D GC^RMIMRP(.VPRM,ID)
 S FIM("id")=ID,FIM("name")="Functional Independence Measurement"
 S FIM("facility")=$P(VPRSITE(1),U,2)_U_$P(VPRSITE(1),U) ;local stn#^name
 S X=$G(VPRM(1)),FIM("case")=$P(X,U,2)
 S FIM("care")=$P(X,U,7),FIM("impairmentGroup")=$P(X,U,8)
 S FIM("onset")=$$DATE($P(X,U,9))
 S FIM("admitted")=$$DATE($P(X,U,10))
 S FIM("discharged")=$$DATE($P(X,U,11))
 S X=+$P(X,U,12) I X D
 . N Y S Y=$$INFO^VPRDTIU(X) Q:Y<1  ;draft or retracted
 . S FIM("document")=Y              ;ien^localTitle^natlTitle^VUID
 . S:$G(VPRTEXT) FIM("document","content")=$$TEXT^VPRDTIU(X)
 S X=$G(VPRM(3)) S:X FIM("admitClass")=+X
 S:$L($P(X,U,3)) FIM("interruptionCode")=$P(X,U,3)
 F I=4,6,8 I $P(X,U,I) S FIM("interruption",I)=$P(X,U,I,I+1)
 F I=5:1:9 I VPRM(I)'?1."^" D  ;has data
 . S TYPE=$S(I=5:"admission",I=6:"discharge",I=7:"interim",I=8:"follow up",1:"goals")
 . S X=VPRM(I),MOTOR=$$TOTAL(X,1,13) Q:'MOTOR  ;incomplete results
 . S COGNTV=$$TOTAL(X,14,18) Q:'COGNTV         ;incomplete results
 . S FIM("assessment",TYPE)=X
 . S FIM("assessment",TYPE,"motorScore")=MOTOR
 . S FIM("assessment",TYPE,"cognitiveScore")=COGNTV
 . S FIM("assessment",TYPE,"totalScore")=MOTOR+COGNTV
 Q
 ;
DATE(X) ; -- Return internal form of date X
 N %DT,Y
 S %DT="" D ^%DT S:Y<1 Y=X
 Q Y
 ;
TOTAL(NODE,P1,P2) ; -- Return total of scores, or "" if incomplete
 N SUM,I,X
 S SUM=0 F I=P1:1:P2 S X=$P(NODE,U,I) S:X SUM=SUM+X I X<1 S SUM="" Q
 Q SUM
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(FIM) ; -- Return FIM case as XML in @VPR@(I)
 N ATT,I,J,X,Y,NAMES,TEXT
 D ADD("<fim>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(FIM(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I ATT="assessment" D  S Y="" Q
 .. D ADD("<"_ATT_"s>")
 .. S I="" F  S I=$O(FIM(ATT,I)) Q:I=""  D
 ... S Y="<"_ATT_" type='"_I,J=""
 ... F  S J=$O(FIM(ATT,I,J)) Q:J=""  S Y=Y_"' "_J_"='"_FIM(ATT,I,J)
 ... S Y=Y_"' >" D ADD(Y)
 ... S X=FIM(ATT,I) D VAL(X),ADD("</"_ATT_">")
 .. D ADD("</"_ATT_"s>")
 . ;
 . I ATT?1"interruption"1N D  S Y="" Q
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(FIM(ATT,I)) Q:I<1  D
 ... S X=FIM(ATT,I),Y="<"_ATT_" transfer='"_$P(X,U)
 ... S:$P(X,U,2) Y=Y_"' return='"_$P(X,U,2)
 ... S Y=Y_"' >" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . ;
 . S X=$G(FIM(ATT)),Y="" Q:'$L(X)
 . I ATT="document" D  S Y="" Q
 .. S NAMES="id^localTitle^nationalTitle^vuid^Z",TEXT=$G(FIM(ATT,"content"))
 .. S Y="<"_ATT_" "_$$LOOP_$S($L(TEXT):">",1:"/>")
 .. D ADD(Y) Q:'$L(TEXT)
 .. S Y="<content xml:space='preserve'>" D ADD(Y)
 .. S I=0 F  S I=$O(@TEXT@(I)) Q:I<1  S Y=$$ESC^VPRD(@TEXT@(I)) D ADD(Y)
 .. D ADD("</content>"),ADD("</"_ATT_">")
 . ;
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</fim>")
 Q
 ;
VAL(X) ; -- add FIM measurement values
 N NAMES,Y S Y=""
 S NAMES="eat^groom^bath^dressUp^dressLo^toilet^bladder^bowel^transChair^transToilet^transTub^locomWalk^locomStair^comprehend^express^interact^problem^memory^walkMode^comprehendMode^expressMode^Z"
 S Y="<values "_$$LOOP_"/>"
 D ADD(Y)
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
