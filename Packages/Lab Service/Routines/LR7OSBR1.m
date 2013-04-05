LR7OSBR1 ;slc/dcm - Silent BB rpt cont. ;8/11/97
 ;;5.2;LAB SERVICE;**121,201,228,230,292,387,412**;Sep 27, 1994;Build 1
 ;from LRBLPBR
 ;Reference to GETS^DIQ supported by IA #2056
EN ;
 N A,B,J,LRMD,LRI,X,X0
 S LR(2)=0,LRMD=$P(LR,"^",5)
 D H
 S LR("F")=1
 I $D(^LR(LRDFN,1.7)) D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(4,CCNT,"Antibodies identified: ") F LR(9)=0:0 S LR(9)=$O(^LR(LRDFN,1.7,LR(9))) Q:'LR(9)  D
 . I CCNT>(GIOM-15) D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"   ")
 . S ^TMP("LRC",$J,GCNT,0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,$P(^LAB(61.3,LR(9),0),"^")_"; ")
 I $O(^LR("AB",LRDFN,0)) D
 . D LINE^LR7OSUM4
 . S J=0
 . F  S J=$O(^LR("AB",LRDFN,J)) Q:'J  S A=0 F  S A=$O(^LR("AB",LRDFN,J,A)) Q:'A  D
 .. S LR(1.9)=$G(^LR(LRDFN,1.6,A,0))
 .. I LR(1.9)="" K ^LR("AB",LRDFN,J,A) Q
 .. S Y=+LR(1.9)
 .. D D^LRU
 .. D LN
 .. S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(0,CCNT,"TRANSFUSION REACTIONS WITH UNIT IDENTIFIED")_$$S^LR7OS(51,CCNT,"UNIT ID")_$$S^LR7OS(66,CCNT,"COMPONENT")
 .. D LN
 .. S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(0,CCNT,Y)_$$S^LR7OS(21,CCNT,$P($G(^LAB(65.4,J,0)),U))_$$S^LR7OS(51,CCNT,$P(LR(1.9),U,3))_$$S^LR7OS(69,CCNT,$P($G(^LAB(66,+$P(LR(1.9),U,2),0)),U,2))
 .. F B(1)=0:0 S B(1)=$O(^LR(LRDFN,1.6,A,1,B(1))) Q:'B(1)  S B(2)=^(B(1),0) D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(0,CCNT,B(2))
 I $O(^LR(LRDFN,1.9,0)) D
 . D LINE^LR7OSUM4
 . S A=0
 . F B=0:1 S A=$O(^LR(LRDFN,1.9,A)) Q:'A  S LR(1.9)=^(A,0) D
 .. I 'B D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(0,CCNT,"TRANSFUSION REACTIONS WITHOUT UNIT IDENTIFIED:")
 .. S Y=+LR(1.9)
 .. D D^LRU
 .. D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(0,CCNT,Y)_$$S^LR7OS(21,CCNT,$P($G(^LAB(65.4,+$P(LR(1.9),U,2),0)),U))
 .. F B=0:0 S B=$O(^LR(LRDFN,1.9,A,1,B)) Q:'B  S X0=^(B,0) D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(0,CCNT,X0)
 D LINE^LR7OSUM4
 I $D(LRN(2)) D C
 D DT
 S LRI=LRIN
 F A=1:1 S LRI=$O(^LR(LRDFN,LRSS,LRI)) Q:'LRI!(CT1>COUNT)!(LRI>LROUT)  S LR(5)=^(LRI,0) I $P(LR(5),"^",3) D
 . S T=+LR(5),CT1=CT1+1
 . D T,LN
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(4,CCNT,T)
 . D W
 Q
W ;
 S X=$G(^LR(LRDFN,LRSS,LRI,10)),LRN(10.3,3)=$P(X,"^",3)
 S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(21,CCNT,$J($P(X,"^"),2))
 S X=$G(^LR(LRDFN,LRSS,LRI,11)),LRN(11.3,3)=$P(X,"^",3),^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(24,CCNT,$P(X,"^"))
 S X=$G(^LR(LRDFN,LRSS,LRI,2)),LRN(2.91,3)=$P(X,"^",10)
 F H=1,4,6,9 S Y=$P(X,"^",H) S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS((30+$S(H=4:5,H=6:10,H=9:15,1:0)),CCNT,$S(Y="N":"Neg",Y="P":"Pos",H=9&(Y="I"):"Invalid",1:Y))
 S X=$G(^LR(LRDFN,LRSS,LRI,6)),Y=$P(X,"^"),^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(62,CCNT,$S(Y="N":"Neg",Y="P":"Pos",1:Y))
 F X=10.3,11.3,2.91 I LRN(X,3)]"" D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,LRN(X)_":"_LRN(X,3))
 S J=0 F  S J=$O(^LR(LRDFN,LRSS,LRI,"EA",J)) Q:'J  D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"ELUATE ANTIBODY: "_$S($D(^LAB(61.3,J,0)):$P(^(0),"^"),1:J))
 S J=0 F  S J=$O(^LR(LRDFN,LRSS,LRI,5,J)) Q:'J  D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"SERUM ANTIBODY IDENTIFIED: "_$S($D(^LAB(61.3,J,0)):$P(^(0),"^"),1:J))
 S J=0 F  S J=$O(^LR(LRDFN,LRSS,LRI,4,J)) Q:'J  S J(1)=^(J,0) D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,LRN(8)_":"_J(1))
 S J=0 F  S J=$O(^LR(LRDFN,LRSS,LRI,99,J)) Q:'J  S J(1)=^(J,0) D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(8,CCNT,J(1))
 Q
T ;
 ;S T=T_"000",T=$$FMTE^XLFDT($P(T,"."),"5Z")_$S(T[".":" "_$E(T,9,10)_":"_$E(T,11,12),1:"")
 S T=$$FMTE^XLFDT(T,"5Z")
 Q
C ;
 S A=0 F B=1:1 S A=$O(^LRD(65,"AP",LRDFN,A)) Q:'A  D N
 I B=1 D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"No UNITS assigned/xmatched")
 D LINE^LR7OSUM4
 S A=0 F B=0:1 S A=$O(^LR(LRDFN,1.8,A)) Q:'A  S F=^(A,0) I $P(F,"^",3)>(9999999-LROUT),$P(F,"^",3)<(9999999-LRIN) D:'B R D L
 I 'B D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"No component requests")
 Q
N ;
 I B=1 D LINE^LR7OSUM4,LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(6,CCNT,"Unit assigned/xmatched:")_$$S^LR7OS(46,CCNT,"Exp date")_$$S^LR7OS(64,CCNT,"Loc")
 I '$D(^LRD(65,A,0)) K ^LRD(65,"AP",LRDFN,A) Q
 S F=^LRD(65,A,0),L=$O(^(3,0)) I L S L=$P(^(L,0),"^",4)
 E  D LOCAT
 I $P(F,"^",5)<(9999999-LROUT)!($P(F,"^",5)>(9999999-LRIN)) Q
 S M=^LAB(66,$P(F,"^",4),0)
 D LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,$J(B,2)_")")_$$S^LR7OS(6,CCNT,$P(F,"^"))_$$S^LR7OS(17,CCNT,$E($P(M,"^"),1,19))_$$S^LR7OS(38,CCNT,$P(F,"^",7)_" "_$P(F,"^",8))
 S Y=$P(F,"^",6)
 D D^LRU
 D:'(L]"") LOCAT
 S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(45,CCNT,Y)_$$S^LR7OS(64,CCNT,L)
 Q
LOCAT ;Determine the Institution (file 4) where the unit resides if no
 ;location is listed in 65.03,.04
 S L=$P(^LRD(65,A,0),"^",16)
 I L]"" K LERROR D GETS^DIQ(4,L,.01,,"L","LERROR") D
  . I L]"",L'=-1 S L="BB-"_$G(L(4,L_",",.01))
  . K L(4) Q
 ;S L=$P(^DIC(4,L,0),"^") ;Convert to FileMan reference
 I L=""!((L=-1)!($D(LERROR))) S L="???????????"
 Q
L ;
 I '$D(^LAB(66,+F,0)) L +^LR(LRDFN,1.8):360 G:'$T L K ^LR(LRDFN,1.8,+F) S X=^LR(LRDFN,1.8,0),X(1)=$O(^LR(LRDFN,1.8,0)),^LR(LRDFN,1.8,0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)="":"",1:($P(X,"^",4)-1)) L -^LR(LRDFN,1.8) Q
 S T=$P(F,"^",3)
 D T,LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,$E($P(^LAB(66,+F,0),"^"),1,25))_$$S^LR7OS(26,CCNT,$J($P(F,"^",4),3))_$$S^LR7OS(32,CCNT,T)
 S T=$P(F,"^",5)
 D T
 S ^TMP("LRC",$J,GCNT,0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(49,CCNT,T)_$$S^LR7OS(65,CCNT,$E($P(F,"^",9),1,10))_$$S^LR7OS(77,CCNT,$S($P(F,"^",8)="":"",$D(^VA(200,$P(F,"^",8),0)):$P(^(0),"^",2),1:$P(F,"^",8)))
 Q
H ;
 D LN
 S X=GIOM/2-(10/2+5),^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(X,CCNT,"---- BLOOD BANK ----")
 S:'$D(^TMP("LRH",$J,"BLOOD BANK")) ^("BLOOD BANK")=GCNT
 D LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"ABO Rh: "_$J($P(LR,"^",3),2)_" "_$P(LR,"^",4))
 Q
DT ;
 D LINE^LR7OSUM4,LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(30,CCNT,"|---")_$$S^LR7OS(39,CCNT,"AHG(direct)")_$$S^LR7OS(55,CCNT,"---|")_$$S^LR7OS(62,CCNT,"|-AHG(indirect)-|")
 D LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(4,CCNT,"Date/time")_$$S^LR7OS(20,CCNT,"ABO")_$$S^LR7OS(24,CCNT,"Rh")_$$S^LR7OS(30,CCNT,"POLY")_$$S^LR7OS(35,CCNT,"IgG")_$$S^LR7OS(40,CCNT,"C3")
 S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(45,CCNT,"Interpretation")_$$S^LR7OS(62,CCNT,"(Antibody screen)")
 D LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(4,CCNT,"---------")_$$S^LR7OS(20,CCNT,"---")_$$S^LR7OS(24,CCNT,"--")_$$S^LR7OS(30,CCNT,"----")_$$S^LR7OS(35,CCNT,"---")
 S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(40,CCNT,"---")_$$S^LR7OS(45,CCNT,"--------------")_$$S^LR7OS(62,CCNT,"-----------------")
 Q
H3 ;
 D H,LINE^LR7OSUM4,LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(6,CCNT,"Unit assigned/xmatched:")_$$S^LR7OS(46,CCNT,"Exp date")_$$S^LR7OS(64,CCNT,"Loc")
 Q
R ;
 D LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"Component requests")_$$S^LR7OS(26,CCNT,"Units")_$$S^LR7OS(32,CCNT,"Request date")_$$S^LR7OS(49,CCNT,"Date wanted")_$$S^LR7OS(65,CCNT,"Requestor")_$$S^LR7OS(77,CCNT,"By")
 Q
LN ;
 S GCNT=GCNT+1,CCNT=1
 Q
