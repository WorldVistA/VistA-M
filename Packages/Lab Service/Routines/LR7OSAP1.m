LR7OSAP1 ;slc/dcm/wty/kll - Silent AP rpt cont. ;3/28/2002
 ;;5.2;LAB SERVICE;**121,227,230,259,317,315**;Sep 27, 1994;Build 25
 Q:'$D(^XUSEC("LRLAB",DUZ))
 D LN
 S $P(LR("%"),"-",GIOM)="",^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,LR("%"))
 D LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"SNOMED/ICD codes:")
 S C=0
 F  S C=$O(^LR(LRDFN,LRSS,LRI,2,C)) Q:'C  S T=+^(C,0),T=^LAB(61,T,0) D
 . D LN
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"T-"_$P(T,"^",2)_": "),X=$P(T,"^")
 . D:LR(69.2,.05) C^LRUA
 . S ^(0)=^TMP("LRC",$J,GCNT,0)_X
 . D M
 D LINE^LR7OSUM4
 N LRX
 S C=0
 F  S C=$O(^LR(LRDFN,LRSS,LRI,3,C)) Q:'C  S LRX=+^(C,0) D
 . S LRX=$$ICDDX^ICDCODE(LRX,,,1)
 . I +LRX=-1 Q
 . D LN
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"ICD code: "_$P(LRX,"^",2))
 . S X=$P(LRX,"^",4)
 . D:LR(69.2,.05) C^LRUA
 . S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(20,CCNT,X)
 Q
M ;
 S B=0
 F  S B=$O(^LR(LRDFN,LRSS,LRI,2,C,2,B)) Q:'B  S M=+^(B,0),M=$G(^LAB(61.1,M,0)) I $L(M) D
 . D LN
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(5,CCNT,"M-"_$P(M,"^",2)_": "),X=$P(M,"^")
 . D:LR(69.2,.05) C^LRUA
 . S ^(0)=^TMP("LRC",$J,GCNT,0)_X
 . D EX
 F B=1.4,3.3,4.5 S F=0 F  S F=$O(^LR(LRDFN,LRSS,LRI,2,C,$P(B,"."),F)) Q:'F  D A
 Q
A ;
 S M=+^LR(LRDFN,LRSS,LRI,2,C,$P(B,"."),F,0),E="61."_$P(B,".",2),M=^LAB(E,M,0)
 D LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(5,CCNT,$S(B=1.4:"D-",B=3.3:"F-",B=4.5:"P-",1:"")_$P(M,"^",2)),X=$P(M,"^")
 D:LR(69.2,.05) C^LRUA
 S ^(0)=^TMP("LRC",$J,GCNT,0)_": "_X
 Q
EX ;
 S G=0
 F  S G=$O(^LR(LRDFN,LRSS,LRI,2,C,2,B,1,G)) Q:'G  S E=+^(G,0),E=$G(^LAB(61.2,E,0)) I $L(E) D
 . D LN
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(10,CCNT,"E-"_$P(E,"^",2)_": "),X=$P(E,"^")
 . D:LR(69.2,.05) C^LRUA
 . S ^(0)=^TMP("LRC",$J,GCNT,0)_X
 Q
LN ;Increment the counter
 S GCNT=GCNT+1,CCNT=1
 Q
MOD ;Modified report stuff
 N A,B
 D LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(28,CCNT,"*+* MODIFIED REPORT *+*")
 D LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"(Last modified: ")
 S B=0
 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,LR(0),A)) Q:'A  S B=A
 Q:'$D(^LR(LRDFN,LRSS,LRI,LR(0),B,0))  S A=^(0),Y=+A,A=$P(A,"^",2),A=$P($G(^VA(200,A,0),A),"^")
 D D^LRU
 S ^(0)=^TMP("LRC",$J,GCNT,0)_Y_" typed by "_A_")"
 D:$D(LRQ(9)) M1
 Q
MODSR ;Modified Supplementary Report Audit Info
 N LRTEXT,LRSP1,LRSP2,LRFILE,LRIENS,LRR1,LRR2
 S LRFILE=$S(LRSS="CY":63.9072,LRSS="SP":63.8172,LRSS="EM":63.2072,1:"")
 Q:LRFILE=""
 D LN
 S LRTEXT="SUPPLEMENTARY REPORT HAS BEEN ADDED/MODIFIED"
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(14,CCNT,"*+* "_LRTEXT_" *+*")
 D LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"(Added/Last modified: ")
 S LRIENS=C_","_LRI_","_LRDFN_","
 S LRSP1=0
 F  S LRSP1=$O(^LR(LRDFN,LRSS,LRI,1.2,C,2,LRSP1)) Q:'LRSP1  D
 .S LRSP2=LRSP1
 Q:'$D(^LR(LRDFN,LRSS,LRI,1.2,C,2,LRSP2,0))
 S LRS2=^(0),Y=+LRS2,LRS2A=$P(LRS2,"^",2),LRSGN=" typed by "
 ;If supp rpt is released, display 'signed by' instead of 'typed by'
 I $P(LRS2,"^",3) S Y=$P(LRS2,"^",4),LRS2A=$P(LRS2,"^",3),LRSGN=" signed by "
 D D^LRU
 S LRS2A=$S($D(^VA(200,LRS2A,0)):$P(^(0),"^"),1:LRS2A)
 S LRR1=Y,LRR2=LRS2A
 S ^(0)=^TMP("LRC",$J,GCNT,0)_LRR1_LRSGN_LRR2_")"
 ;If RELEASED SUPP REPORT MODIFIED set to 1, display "NOT VERIFIED"
 I $P(^LR(LRDFN,LRSS,LRI,1.2,C,0),"^",3)=1 D
 .D LN
 .S LRTEXT="NOT VERIFIED"
 .S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(25,CCNT,"**-* "_LRTEXT_" *-**")
 Q
M1 ;
 S A=0
 F  S A=$O(^LR(LRDFN,LRSS,LRI,LR(0),A)) Q:'A  S LRT=^(A,0),Y=+LRT,X=$P(LRT,"^",2),X=$P($G(^VA(200,X,0),X),"^") D
 . D D^LRU,LN
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"Date modified:"_Y_" typed by "_X)
 . D F
 S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(13,CCNT,"==========Text below appears on final report==========")
 Q
 ;
F ;
 S B=0
 F  S B=$O(^LR(LRDFN,LRSS,LRI,LR(0),A,1,B)) Q:'B  S LRT=^(B,0),X=LRT D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,X)
 Q
WRAP(ROOT,FMT) ;Wrap text
 I '$L($G(ROOT)) Q ""
 S:'$G(FMT) FMT=79
 N X,LRI,LRTX,LRINDX
 S LRINDX=0,LRI=0
 F  S LRI=$O(@ROOT@(LRI)) Q:LRI'>0  D
 . S X=$S($L($G(@ROOT@(LRI))):@ROOT@(LRI),$L($G(@ROOT@(LRI,0))):@ROOT@(LRI,0),1:""),LRINDX=LRINDX+1
 . S X=$$FMT(FMT,.LRINDX,X)
 S LRI=0
 F  S LRI=$O(LRTX(LRI)) Q:'LRI  D LN^LR7OSAP S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,LRTX(LRI))
 Q
FMT(LENGTH,INDEX,TEXT) ;Format text
 N X,Y,J
 S Y=1
 S:'$D(LRTX(INDEX)) LRTX(INDEX)=""
 S X=$L(TEXT)+$L(LRTX(INDEX))+1
 I X<255 S TEXT=$S($L(LRTX(INDEX)):LRTX(INDEX)_" "_TEXT,1:TEXT)
 I X'<255 S INDEX=INDEX+1,LRTX(INDEX)=""
 S LRTX(INDEX)=""
 F J=1:1 S X=$P(TEXT," ",J) Q:J>$L(TEXT," ")  D
 . Q:'$L(X)
 . I ($L(X)+$L(LRTX(INDEX)))>LENGTH S Y=1,INDEX=INDEX+1,LRTX(INDEX)=""
 . S LRTX(INDEX)=$S(Y:X,1:LRTX(INDEX)_" "_X),Y=0
 S LRTX(INDEX)=$$STRIP(LRTX(INDEX))
 Q INDEX
STRIP(TEXT) ; Strips white space from text
 N LRI,LRX
 S LRX="" F LRI=1:1:$L(TEXT," ") S:$A($P(TEXT," ",LRI))>0 LRX=LRX_$S(LRI=1:"",1:" ")_$P(TEXT," ",LRI)
 S TEXT=LRX
 Q TEXT
