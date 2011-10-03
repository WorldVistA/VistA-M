LR7OR4 ;slc/dcm - Get Lab TEST Info ;8/11/97
 ;;5.2;LAB SERVICE;**256,356**;Sep 27, 1994;Build 8
 ;Entry points:  EN
GET(TEST) ;Get TEST ifn
 I '$D(TEST) Q ""
 I TEST'?1N.N S TEST=$O(^LAB(60,"B",TEST,0)) Q:'TEST ""
 I TEST?1N.N Q:'$D(^LAB(60,TEST)) ""
 Q TEST
ONE(Y,TEST) ;Gets parameters for one test
 N CNT
 Q:'$L($G(TEST))
 S CNT=0,TEST=+TEST
 D EN
 Q
ALL(Y,TESTS) ;Gets Lab Test ordering parameters from file 60
 ;TEST=Lab TEST (can be either name or internal #)
 N I,CNT
 Q:'$O(TESTS(0))
 S (I,CNT)=0
 F  S I=$O(TESTS(I)) Q:'I  S TEST=+TESTS(I) D EN S CNT=CNT+1,Y(CNT)="---------------------"
 Q
EN Q:'$D(TEST)
 N X0
 S TEST=$$GET(TEST) Q:'TEST
 S X0=^LAB(60,TEST,0),CNT=CNT+1,Y(CNT)=$P(X0,"^",1)
 I $L($P(X0,"^",11)) S Y(CNT)=Y(CNT)_"   $"_$J($P(X0,"^",11),4,2)
 D URG
 D GCOM
 I $P(X0,"^",8),$O(^LAB(60,TEST,3,0)) S X=$G(^($O(^(0)),0)),CNT=CNT+1,Y(CNT)="Unique collection sample: "_$$SAMP(+X) ;$P($G(^LAB(62,+X,0)),"^")
 I $P(X0,"^",9) S I=0 F  S I=$O(^LAB(60,TEST,3,I)) Q:I<1  S X=+^(I,0) I X=$P(X0,"^",9) S CNT=CNT+1,Y(CNT)="Lab collect sample: "_$$SAMP(X) Q  ;$P($G(^LAB(62,X,0)),"^") Q
 ;I $O(^LAB(60,TEST,3,0)) S X=$G(^($O(^(0)),0)),CNT=CNT+1,Y(CNT)="Default collection sample: "_$P($G(^LAB(62,+X,0)),"^")
 D COLL,SUB
 Q
COLL ;Get Collection Sample-Specimen data
 N I,J,X,SAMP,SPEC,CHK
 S I=0
 F  S I=$O(^LAB(60,TEST,3,I)) Q:I<1  S X=^(I,0) D
 . S CNT=CNT+1,Y(CNT)="Collection sample: "_$$SAMP(X,$P(X0,"^",19))
 . I $L($P(X,"^",2)) S CNT=CNT+1,Y(CNT)="     Form name/number: "_$P(X,"^",2)
 . I $L($P(X,"^",4)) S CNT=CNT+1,Y(CNT)="     Minimum volume (in mls): "_$P(X,"^",4)
 . I $L($P(X,"^",5)) S CNT=CNT+1,Y(CNT)="     Maximum order frequency: "_$P(X,"^",5)
 . I $L($P(X,"^",7)) S CNT=CNT+1,Y(CNT)="     Maximum daily order frequency: "_$P(X,"^",7)
 . I $O(^LAB(60,TEST,3,I,1,0)) S CNT=CNT+1,Y(CNT)="     Collection sample instructions: " D
 .. S J=0 F  S J=$O(^LAB(60,TEST,3,I,1,J)) Q:J<1  S CNT=CNT+1,Y(CNT)="          "_^(J,0)
 ;. I $O(^LAB(60,TEST,3,I,2,0)) S CNT=CNT+1,Y(CNT)="     Collection sample LAB processing instructions: " D
 ;.. S J=0 F  S J=$O(^LAB(60,TEST,3,I,2,J)) Q:J<1  S CNT=CNT+1,Y(CNT)="          "_^(J,0)
 S I=0
 F  S I=$O(^LAB(60,TEST,1,I)) Q:I<1  S X=^(I,0) D
 . S CNT=CNT+1,Y(CNT)="Site/Specimen: "_$P($G(^LAB(61,+X,0)),"^")
 . I $L($P(X,"^",2,3))>1 D CRRV("Reference range",$P(X,"^",2,3))
 . I $L($P(X,"^",11,12))>1 D CRRV("Therapeutic range",$P(X,"^",11,12))
 . I $L($P(X,"^",4,5))>1 D CRRV("Critical",$P(X,"^",4,5))
 . I $L($P(X,"^",7)) S CNT=CNT+1,Y(CNT)="     Units: "_$P(X,"^",7)
 . I $O(^LAB(60,TEST,1,I,1,0)) S CNT=CNT+1,Y(CNT)="     Interpretation: "
 . S J=0 F  S J=$O(^LAB(60,TEST,1,I,1,J)) Q:'J  S X=^(J,0),CNT=CNT+1,Y(CNT)="          "_X
 Q
URG ;Get Urgency params for TEST
 N I,X,URG
 I $P(X0,"^",18) S CNT=CNT+1,Y(CNT)="Default urgency: "_$P($G(^LAB(62.05,+$P(X0,"^",18),0)),"^")
 I $P(X0,"^",16) S CNT=CNT+1,Y(CNT)="Highest urgency allowed: "_$P($G(^LAB(62.05,+$P(X0,"^",16),0)),"^")
 Q
SAMP(X,REQ) ;Build Collection Sample data
 ;X=zero node from ^LAB(60,TEST,3,ifn,0) or ptr to 62
 ;REQ=Required comment from $P(^LAB(60,TEST,0),"^",19)
 N X0,Y1
 Q:'$D(^LAB(62,+X,0)) "" S X0=^(0)
 ;S REQ=$S($P(X,"^",6):$P(X,"^",6),$G(REQ):REQ,1:""),REQ=$S(REQ:$P($G(^LAB(62.07,REQ,0)),"^"),1:"")
 ;S Y1=+X_"^"_$P(X0,"^")_"^"_$P(X0,"^",2)_"^"_$P(X0,"^",3)_"^"_$P(X,"^",5)_"^"_$P(X,"^",7)_"^"_$P(X0,"^",7)_"^"_REQ
 S Y1=$P(X0,"^")_"  "_$P(X0,"^",3)
 Q Y1
GCOM ;Get General Ward & Lab Instructions
 ;TEST=ptr to TEST in file 60
 N I
 S I=0
 I $O(^LAB(60,+$G(TEST),6,0)) S CNT=CNT+1,Y(CNT)="General instructions: "
 F  S I=$O(^LAB(60,TEST,6,I)) Q:'I  S CNT=CNT+1,Y(CNT)="     "_^(I,0)
 S I=0
 ;I $O(^LAB(60,+$G(TEST),7,0)) S CNT=CNT+1,Y(CNT)="General LAB processing instructions: "
 ;F  S I=$O(^LAB(60,TEST,7,I)) Q:'I  S CNT=CNT+1,Y(CNT)="     "_^(I,0)
 Q
SUB ;Tests in panel
 N I
 S I=0
 I $O(^LAB(60,+$G(TEST),2,0)) S I=0,CNT=CNT+1,Y(CNT)="Tests included in panel: "
 F  S I=$O(^LAB(60,TEST,2,I)) Q:'I  S X=^(I,0),CNT=CNT+1,Y(CNT)="     "_$P($G(^LAB(60,+X,0)),"^")
 Q
 ;Added to support LR*5.2*356, PSI-06-025
CRRV(RT,RV) ;Convert Referance Range Values - convert embedded M code into a more readable format
 ;Variables passed in:
 ;RT - Refereance range Text
 ;RV - Refereance range Value
 ;       1st piece holds low value
 ;       2nd piece holds high value
 ;Routine variables
 ;Y() - The return array with the lab test information
 ;CNT - The counter variable used to create nodes in the Y array variable
 ;Local variables
 ;SP5 - 5 embedded spaces for output alinement
 ;SP10 - 10 embedded spaces for output alinement
 ;X - Work variable
 N SP5,SP10,X
 S SP5="     ",SP10=SP5_SP5,X=""
 I RV'["$S(" D  Q
 . I $L($P(RV,"^")),'$L($P(RV,"^",2)),$P(RV,"^")?.ANP S CNT=CNT+1,Y(CNT)=SP5_RT_$S($P(RV,"^")?.N:" low : "_$TR($P(RV,"^"),""""),1:"  : "_$TR($P(RV,"^"),"""")) Q
 . I '$L($P(RV,"^")),$L($P(RV,"^",2)),$P(RV,"^",2)?.ANP S CNT=CNT+1,Y(CNT)=SP5_RT_$S($P(RV,"^",2)?.N:" high : "_$TR($P(RV,"^",2),""""),1:" : "_$TR($P(RV,"^",2),"""")) Q
 . I $L($P(RV,"^")) S CNT=CNT+1,Y(CNT)=SP5_RT_" low  : "_$TR($P(RV,"^"),"""")
 . I $L($P(RV,"^",2)) S CNT=CNT+1,Y(CNT)=SP5_RT_" high : "_$TR($P(RV,"^",2),"""")
 . ;I $L($P(RV,"^")) S CNT=CNT+1,Y(CNT)=SP5_RT_$S($P(RV,"^")?.AP:" : "_$TR($P(RV,"^"),""""),1:" low  : "_$TR($P(RV,"^"),""""))
 . ;I $L($P(RV,"^",2)) S CNT=CNT+1,Y(CNT)=SP5_RT_$S($P(RV,"^",2)?.AP:" : "_$TR($P(RV,"^",2),""""),1:" high : "_$TR($P(RV,"^",2),""""))
 I RV["SEX" D  Q
 . I RV["AGE" S CNT=CNT+1,Y(CNT)=SP5_RT_" - Age and sex dependent range values, please contact lab for specifics." Q
 . S CNT=CNT+1,Y(CNT)=SP5_RT
 . I $L($$GSV($P(RV,"^"),"M")) S CNT=CNT+1,Y(CNT)=SP10_"Male "_$S($$GSV($P(RV,"^"),"M")?.AP:": "_$TR($$GSV($P(RV,"^"),"M"),""""),1:"low  : "_$TR($$GSV($P(RV,"^"),"M"),""""))
 . I $L($$GSV($P(RV,"^",2),"M")) S CNT=CNT+1,Y(CNT)=SP10_"Male "_$S($$GSV($P(RV,"^",2),"M")?.AP:$TR($$GSV($P(RV,"^",2),"M"),""""),1:"high : "_$TR($$GSV($P(RV,"^",2),"M"),""""))
 . I $L($$GSV($P(RV,"^"),"F")) S CNT=CNT+1,Y(CNT)=SP10_"Female "_$S($$GSV($P(RV,"^"),"F")?.AP:": "_$TR($$GSV($P(RV,"^"),"F"),""""),1:"low  : "_$TR($$GSV($P(RV,"^"),"F"),""""))
 . I $L($$GSV($P(RV,"^",2),"F")) S CNT=CNT+1,Y(CNT)=SP10_"Female "_$S($$GSV($P(RV,"^",2),"F")?.AP:$TR($$GSV($P(RV,"^",2),"F"),""""),1:"high : "_$TR($$GSV($P(RV,"^",2),"F"),""""))
 I RV["AGE" D  Q
 . S CNT=CNT+1,Y(CNT)=SP5_RT
 . I $L($P(RV,"^")) D FAVO($P(RV,"^"),"low")
 . I $L($P(RV,"^",2)) D FAVO($P(RV,"^",2),"high")
GSV(X,SEX) ;Get Sex Value
 ;Variables passed in:
 ;X - Work variable low/high range value
 ;SEX - Patient's sex
 ;Subroutine variables:
 ;X1 - Return value variable with the resolved low/high value
 N X1
 S @("X1="_$S($L(X):X,1:""""""))
 Q X1
FAVO(X,HL) ;Format Age Value Output
 ;Variables passed in:
 ;X - Work variable with low/high range value
 ;HL - This will be for either a low or high reference range
 ;Subroutine variables:
 ;AT0 - Common text for output
 ;AT1 - Embedded M code tested for 
 ;AT2 - Text description for embedded M code for output
 ;IO  - Counter to piece the low/high range value
 ;I1  - Counter to reformat the embedded M code
 ;SP10 - 10 embedded spaces for output alinement
 ;X0,X1,X2  - Work variables used in converting the low/high range value
 N AT0,AT1,AT2,I0,I1,SP10,X0,X1,X2
 S AT0="If Age is "
 S AT1="",AT1(1)="AGE<",AT1(2)="AGE>",AT1(3)="AGE'<",AT1(4)="AGE'>",AT1(5)="AGE="
 S AT2="",AT2(1)="less than ",AT2(2)="greater than "
 S AT2(3)="not less than ",AT2(4)="not greater than ",AT2(5)="equal to "
 S SP10="          "
 S X0=$E(X,4,$L(X)-1),(X1,X2)=""
 F I0=1:1 S X1=$P(X0,",",I0) Q:X1=""  D
 . I $P(X1,":")=1 S X2=SP10_"Default "_HL_": "_$P(X1,":",2),CNT=CNT+1,Y(CNT)=$TR(X2,"""")
 . E  D
 . . F I1=1:1:5 I $P(X1,":")[AT1(I1) S X2=SP10_AT0_AT2(I1)_$E($P(X1,":"),$L(AT1(I1))+1,$L($P(X1,":")))_" the "_HL_" is "_$P(X1,":",2),CNT=CNT+1,Y(CNT)=$TR(X2,"""")
 Q
