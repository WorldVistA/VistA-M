PSJORMA1 ;BIR/MV-COLLECT MAR DATA FOR U/D AND INPATIENT MED PENDINGS. ; 10 Mar 98 / 8:50 AM
 ;;5.0; INPATIENT MEDICATIONS ;**2**;16 DEC 97
BLANK(LEN) ;
 NEW X
 S $P(X," ",LEN)=" "
 Q $G(X)
 ;
TXT(TXT,LEN)   ;
 ;* Input: TXT = TXT string
 ;*        LEN = format length
 ;* Output: MARX array.
 ;*
 NEW OLD D SPLIT
 S X=0,X1=1,Y="" F  S X=$O(OLD(X)) Q:'X  D
 . I $L(Y_OLD(X))>LEN S MARX(X1)=Y,X1=X1+1,Y=""
 . S Y=Y_OLD(X)
 S:Y]"" MARX(X1)=Y
 S MARX=X1
 Q
 ;
SPLIT ;* Split a word string into individual words.
 ;* Output: OLD(X)
 ;*
 NEW BSD,NEW,X,X1,Y
 S OLD(1)=TXT Q:$L(TXT)<LEN
 F BSD=" ","/","-" S:'$O(OLD(0)) OLD(1)=TXT D:TXT[BSD DELIM(BSD)
 I '$O(OLD(1)),($L(TXT)>LEN) D LEN(1,TXT) K OLD D
 . F X=0:0 S X=$O(NEW(X)) Q:'X  S OLD(X)=NEW(X)
 Q
LEN(X1,OLD) ;* Wrap word around if it doesn't fit the display lenght.
 NEW X
 Q:$L(OLD)'>LEN
 S X=$E(OLD,1,($L(OLD)-1)) I X["/"!(X["-") Q
 I $L(OLD)>LEN F X=1:1 S NEW(X1)=$E(OLD,((LEN*X)-LEN+1),(LEN*X)),X1=X1+1 Q:($L(OLD)'>(LEN*X))
 Q
DELIM(BSD) ;* BSD=" ","/","-"
 K NEW
 S X=0,X1=0 F  S X=$O(OLD(X)) Q:'X  F Y=1:1:$L(OLD(X),BSD) D
 . S X1=X1+1
 . S NEW(X1)=$P(OLD(X),BSD,Y)
 . I $L(OLD(X),BSD)>1,(Y<$L(OLD(X),BSD)) S NEW(X1)=NEW(X1)_BSD
 . D LEN(.X1,NEW(X1))
 K OLD F X=0:0 S X=$O(NEW(X)) Q:'X  S OLD(X)=NEW(X)
 Q
 ;
MARLB(LEN)         ;
 ;;;LEN=LENGHT
 NEW L,X,TXT K MARLB,DRUGNAME
 S L=1
 ;I ON["P",(PSGLRN["___") S MARLB(L)=PSGLOD_" | P E N D I N G"
 I ON["P",+NODE(4) S MARLB(L)=PSGLOD_" | P E N D I N G"
 E  S MARLB(L)=PSGLOD_" |"_PSGLSD_" |"_PSGLFD
 S MARLB(L)=$$SETSTR^VALM1("("_PSGLBS5_")",MARLB(L),36,7)
 S L=L+1
 D DRGDISP^PSJLMUT1(DFN,PSGORD,LEN,39,.DRUGNAME,0)
 F X=0:0 S X=$O(DRUGNAME(X)) Q:'X  S MARLB(L)=DRUGNAME(X)_$S(X=1:$$BLANK(41-$L(DRUGNAME(X)))_PSGLST,1:""),L=L+1
 D TXT^PSGMUTL(PSGLSI,LEN)
 S X=0 F  S X=$O(MARX(X)) Q:'X  S MARLB(L)=MARX(X),L=L+1
 K MARX
 S X=$E("WS",1,PSGLWS*2)_$S(PSGLSM:$E("HSM",PSGLSM,3),1:"")_$E("NF",1,PSGLNF*2)
 I TS<L,(X=""),($L(MARLB(L-1))<24),(L=6) S L=L-1 D
 . S X=MARLB(L)_$$BLANK(23-$L(MARLB(L)))_"RPH: "_$S(PSGLRPH]""&(PSGLRPH'="0"):PSGLRPH,1:"_____")
 . S X=X_$$BLANK(33-$L(X))_"RN: "_$S(PSGLRN]""&(PSGLRN'="0"):PSGLRN,1:"_____")
 . S MARLB(L)=X
 E  D
 . I L#5>0 F L=L:1:5 S MARLB(L)=""
 .; S:L=4 MARLB(4)="",L=5
 . S X=$E("WS",1,PSGLWS*2)
 . S X=X_$$BLANK(4-$L(X))_$S(PSGLSM:$E("HSM",PSGLSM,3),1:"")
 . S X=X_$$BLANK(8-$L(X))_$E("NF",1,PSGLNF*2)
 . S X=X_$$BLANK(23-$L(X))_"RPH: "_$S(PSGLRPH]""&(PSGLRPH'="0"):PSGLRPH,1:"____")
 . S X=X_$$BLANK(33-$L(X))_"RN: "_$S(PSGLRN]""&(PSGLRN'="0"):PSGLRN,1:"_____")
 . S MARLB(L)=X
 S MARLB=L
 I MARLB>5!($G(TS)>5) D MARLB2
 Q
 ;
MARLB2 ;Slit array into 2 labels.
 ;TS array must be defined. (TS^PSGMAR3(ADMIN TIMES))
 NEW INIT,X,Y
 S INIT=MARLB(MARLB),Y=5
 F X=5:1:MARLB S X(X)=MARLB(X)
 F X=5:1:($S(MARLB>TS:MARLB,1:TS)-1) D
 . I (X#5)=0 S MARLB(X)="See next label for continuation" Q
 . I Y<(MARLB) S MARLB(X)=X(Y),Y=Y+1 Q
 . S MARLB(X)=""
 S X=X+1 F Y=Y:1:MARLB-1 S MARLB(X)=$G(X(Y)),X=X+1
 F X=X:0 Q:(X#5)=0  S MARLB(X)="",X=X+1
 S MARLB(X)=INIT,MARLB=X
 Q
 N X F X=5:1:MARLB S X(X+1)=MARLB(X)
 S MARLB(5)="See next label for continuation"
 F X=7:1:MARLB S MARLB(X)=X(X)
 F X=X+1:1:11 S MARLB(X)=""
 S MARLB(10)=X(MARLB+1)
 S MARLB=10
 Q
 ;
