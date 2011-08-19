LRVER1 ;DALOI/FHS/JAH - LAB ROUTINE DATA VERIFICATION ;8/10/04
 ;;5.2;LAB SERVICE;**42,153,201,215,239,240,263,232,286,291**;Sep 27, 1994
 ;
VER ; from LRGVP
 N LRBEY
 S LRLLOC=0,LRCW=8,LROUTINE=$P(^LAB(69.9,1,3),U,2) I $D(^LRO(69,LRODT,1,LRSN,0)) S LRLLOC=$P(^(0),U,7) S:'$L(LRLLOC) LRLLOC=0 W !,$P(^LRO(69,LRODT,1,LRSN,1),U,6)
 S LRCDT=$S($D(^LRO(68,LRAA,1,LRAD,1,LRAN,3)):$P(^(3),U,1,2),1:$P(^(0),U,3)_U),LREAL=$P(LRCDT,U,2)
 S LRCDT=+LRCDT,LRSAMP=$S($D(^LRO(69,LRODT,1,LRSN,0)):$P(^(0),U,3),1:"")
 S LRIDT=$S($P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,5):$P(^(3),U,5),1:"")
 S:'LRIDT LRIDT=9999999-LRCDT
 D EXP
LD S LRSS="CH" ;ONLY WORKS FOR 'CH'
 S LRMETH=LRSS IF $D(^LR(LRDFN,LRSS,LRIDT,0)) S LRMETH=$P($P(^(0),U,8),";",1)
 W:$D(^LAB(62,+LRSAMP,0)) !,"Sample: ",$P(^(0),U)
 K ^TMP("LR",$J,"TMP"),LRORD,LRM
 D ^LRVER2
 K LRDL
 Q
 ;
 ;
EXP ; Get the list of tests for this ACC. from LRGVG1
 ; Do not process tests which have been "NP" (not performed).
 N I,N,IX,LRNLT,T1,X
 K LRTEST,LRNAME,LRSM60
 S LRALERT=LROUTINE,N=0,I=0,IX=+$G(^LRO(68,LRAA,1,LRAD,1,LRAN,5,1,0))
 F  S I=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,I)) Q:I<.5  D
 . S X=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,I,0))
 . I 'X Q
 . I $P(X,"^",6)="*Not Performed" Q
 . S N=N+1,LRTEST(N)=I,LRNLT=$S($P(X,"^",2)>50:$P(X,U,9),1:$P(X,"^"))
 . S LRTEST(N,"P")=LRNLT_U_$$NLT(LRNLT)
 . S LRAL=$P(X,U,2)#50
 . I LRAL S LRALERT=$S(LRAL<LRALERT:LRAL,1:LRALERT)
 ;
 S LRNTN=N
 F T1=1:1:N I $D(^LAB(60,+LRTEST(T1),0)) D
 . S LRTEST(T1)=LRTEST(T1)_U_^(0)
 . S LRNAME(T1)=$P(LRTEST(T1),U,2),LRNAME(T1,+LRTEST(T1))=""
 . S:$G(^(1,IX,3)) LRSM60(+$P(LRTEST(T1),";",2))=^(3)
 . D EX1
 K IX
 N X1,X
 S X=$P($H,","),X(1)=$P($H,",",2),I=0
 F  S I=$O(LRSM60(I)) Q:'I  S X1=X-LRSM60(I)_","_X(1),LRSM60(I)=9999999-$$HTFM^XLFDT(X1)
 Q
 ;
 ;
EX1 ; Expand the list of tests to edit.
 Q:'$D(LRTEST(T1))
 S X=LRTEST(T1),^TMP("LR",$J,"VTO",+X)=$P($P(X,U,6),";",2)
 S ^TMP("LR",$J,"VTO",+X,"P")=LRTEST(T1,"P"),S1=0,J=0
 D EX2
 K S1,J
 Q
 ;
EX2 ;
 S:'$D(LRCFL) LRCFL=""
 S LRSUB=$P(X,U,6)
 I $D(^LAB(60,+X,4)),$P(^(4),"^",2) S LRCFL=LRCFL_$P(^(4),"^",2)_U
 ;
 ; If atomic test then setup and quit
 I LRSUB'="" D  Q
 . S S2=$P(LRSUB,";",2)
 . D:'$D(^TMP("LR",$J,"TMP",S2)) ORD
 ;
 ; Explode panel tests
 ; Do not process tests which have been "NP" (not performed).
 S S1=S1+1,S1(S1)=X,S1(S1,1)=J
 S J=0
 F  S J=$O(^LAB(60,+S1(S1),2,J)) Q:J<1  D
 . S Y=+^(J,0),X=Y_U_^LAB(60,Y,0)
 . I $P($G(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),4,Y,0)),"^",6)="*Not Performed" Q
 . D EX2
 S X=S1(S1),J=S1(S1,1),S1=S1-1
 Q
 ;
 ;
ORD ;
 ; LRNX is set by caller
 S LRNX=+$G(LRNX)+1,LRORD(LRNX)=S2
 S LRBEY($P(LRTEST(T1),U,1),S2)=""   ; CIDC
 S ^TMP("LR",$J,"TMP",S2)=+X
 ; If panel being exploded then set parent("P" node)
 ;  to file #60 test being exploded
 I $G(LRTEST(T1,"P")) D
 . I +LRTEST(T1)=+LRTEST(T1,"P") S ^TMP("LR",$J,"TMP",S2,"P")=LRTEST(T1,"P")_"!"_$$RNLT(+X)
 . E  S ^TMP("LR",$J,"TMP",S2,"P")=+LRTEST(T1)_U_$$NLT(+LRTEST(T1))_"!"_$$RNLT(+X)
 ;
 I $P(X,U,18) D
 . S LRM(S2)=+X
 . S LRM(S2,"P")=$G(^TMP("LR",$J,"TMP",S2,"P"))
 . S LRMX(+X)=""
 Q
 ;
 ;
NLT(X) ;
 N Y
 S Y=$S($P($G(^LAM(+$G(^LAB(60,+X,64)),0)),U,2):$P(^(0),U,2),1:"")
 Q Y
 ;
 ;
RNLT(X) ;
 I 'X Q ""
 N Y
 S Y(1)=+$P($G(^LAB(60,X,64)),U,2)
 S Y=$S($P($G(^LAM(Y(1),0)),U,2):$P(^(0),U,2),1:"")
 I Y S $P(Y,"!",2)=$$LNC(Y,$G(LRCDEF),$G(LRSPEC))
 S $P(Y,"!",3)=$G(LRCDEF),$P(Y,"!",6)=X
 Q Y
 ;
 ;
LNC(LRNLT,LRCDEF,LRSPEC) ;reture the LOINC code for WKLD Code/Specimen
 ; Call with (nlt code,method suffix,test specimen)
 ; TA = Time Aspect
 N X,N,Y,LRSPECN,VAL,ERR,TA S X=""
 Q:'LRNLT X
 K LRMSGM
 S:$G(LRCDEF)="" LRCDEF="0000"
 I $P(LRCDEF,".",2) S LRCDEF=$P(LRCDEF,".",2)
 S LRCDEF=$S($P(LRNLT,".",2):$P(LRNLT,".",2),1:LRCDEF)
 I $L(LRCDEF)'=4 S LRCDEF=LRCDEF_$E("0000",$L(LRCDEF),($L(LRCDEF-4)))
 S LRCDEF=LRCDEF_" "
 S LRSPEC=+LRSPEC
 ;Get time aspect from 61
 S TA=$$GET1^DIQ(61,LRSPEC_",",.0961,"I")
 S LRSPECN=$S($D(^LAB(61,LRSPEC,0))#2:$$GET1^DIQ(61,LRSPEC_",",.01),1:"Unknown")
 S LRNLT=$P(LRNLT,".")_"."
 ;Check for WKLD CODE_LOAD/WORK LIST method suffix
 S VAL(1)=LRNLT_LRCDEF
 S N=$$FIND1^DIC(64,"","X",.VAL,"C","","ERR")
 ;Looking for specimen specific LOINC
 I N,LRSPEC D  I X D MSG(1) Q X
 . I TA S X=$$GET1^DIQ(64.02,TA_","_LRSPEC_","_N_",",4,"I") Q:X
 . S TA=$O(^LAM(N,5,LRSPEC,1,0)) ; get time aspect
 . I TA S X=$$GET1^DIQ(64.02,TA_","_LRSPEC_","_N_",",4,"I") Q:X
 ;Looking LOINC default
 I N S X=$$LDEF(N) I X D MSG(2) Q X
 I LRCDEF="0000 " Q ""
 ;Looking for WKLD CODE_GENERIC suffix
 K VAL
 S VAL(1)=LRNLT_"0000 "
 S N=$$FIND1^DIC(64,"","X",.VAL,"C","","ERR")
 I 'N Q ""
 ;Looking for WKLD CODE_GENERIC specimen specific LOINC
 I LRSPEC D  I X D MSG(3) Q X
 . I TA S X=$$GET1^DIQ(64.02,TA_","_LRSPEC_","_N_",",4,"I") Q:X
 . S TA=$O(^LAM(N,5,LRSPEC,1,0)) ; get time aspect
 . I TA S X=$$GET1^DIQ(64.02,TA_","_LRSPEC_","_N_",",4,"I") Q:X
 ;Looking for WKLD CODE_GENERIC default LOINC
 I 'X,N S X=$$LDEF(N) I X D MSG(4)
 I 'X S X=""
 Q X
 ;
 ;
LDEF(Y) ;Find the default LOINC code for WKLD CODE
 I 'Y Q ""
 S X=$$GET1^DIQ(64,Y_",",25,"I")
 I 'X S X=""
 Q X
 ;
 ;
TMPSB(LRSB) ; Get LOINC code from ^TMP("LR",$J,"TMP",LRSB,"P")
 S NODE=$G(^TMP("LR",$J,"TMP",LRSB,"P"))
 I 'NODE Q ""
 S $P(NODE,"!",3)=$$LNC($P(NODE,"!",2),$G(LRCDEF),$G(LRSPEC))
 S $P(NODE,"!",4)=$G(LRCDEF)
 Q $P(NODE,U,2)
 ;
 ;
MSG(VAL) ;Set output message
 Q:'$G(LRMSG)
 S LRMSGM="0-No LOINC Code Defined for "_LRNLT_LRCDEF
 N TANAME
 I $G(TA) S TANAME=$$GET1^DIQ(64.061,TA_",",.01,"E") ;TA Name
 I VAL=1 S LRMSGM="1-"_LRNLT_$E(LRCDEF,1,4)_" - "_LRSPECN
 I VAL=2 S LRMSGM="2-"_LRNLT_$E(LRCDEF,1,4)_" - Default LOINC"
 I VAL=3 S LRMSGM="3-"_LRNLT_"0000 - "_LRSPECN
 I VAL=4 S LRMSGM="4-"_LRNLT_"0000 - Default LOINC"
 I $G(TA) S LRMSGM=LRMSGM_" Time Aspect "_TANAME
 W:$G(LRDBUG) !,LRMSGM,!
 Q
