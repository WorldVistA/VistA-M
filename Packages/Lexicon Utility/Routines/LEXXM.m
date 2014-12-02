LEXXM ;ISL/KER - Convert Text to Mix Case ;04/21/2014
 ;;2.0;General Lexicon Utilities;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ^DIWP               ICR  10011
 ;    $$CODEN^ICDCODE     ICR   3990
 ;    $$ICDDX^ICDCODE     ICR   3990
 ;    $$ICDOP^ICDCODE     ICR   3990
 ;    ICDD^ICDCODE        ICR   3990
 ;    $$CPT^ICPTCOD       ICR   1995
 ;    CPTD^ICPTCOD        ICR   1995
 ;    $$MOD^ICPTMOD       ICR   1996
 ;    MODD^ICPTMOD        ICR   1996
 ;    $$DT^XLFDT          ICR  10103
 ;               
 Q
 ;                
 ; TXT                  General Text
 ;       Input    X     Text
 ;                L     Text Length (>19 & <80) (default $L(X))
 ;       Output   Y()   Mix case diagnosis
 ;               
 ; LEX                  Lexicon Text
 ;       Input    X     Lexicon IEN
 ;                L     Text Length (>19 & <80) (default $L(X))
 ;       Output   Y()   Mix case diagnosis
 ;               
 ; For the Entry Points ICDDX1, ICDDX2, ICDOP1, ICDOP2, ICPT1,
 ; ICPT2, MOD1, and MOD2 use:
 ;                   
 ;       Input    X     File IEN
 ;                V     Version date (default = TODAY)
 ;                L     Text Length (>19 & <80) (default $L(X))
 ;       Output   Y()   Mix case text
 ;                          
MIX(X) ; Mix Case any length
 N Y S X=$G(X) D FULL(X) S X=Y
 Q X
TXT(X,L) ; Convert Text to Mixed Case
 N LOW,LEN K LOW,Y S Y(1)=$$CASE($G(X)),LEN=+($G(L)) K:$G(LEN)'>19 LEN K:$G(LEN)'<80 LEN D FMT
 Q
FULL(X) ; Convert Text to Mixed Case
 N LOW,LEN K LOW,Y S Y=$E($$CASE($G(X)),1,240)
 Q
LEX(X,L) ; Convert Expression to Mixed Case
 K Y N I,IEN,VDT,LEN,LOW K LOW,Y S IEN=+($G(X)),LEN=+($G(L)) K:$G(LEN)'>19 LEN K:$G(LEN)'<80 LEN Q:+IEN'>0  Q:'$D(^LEX(757.01,+IEN,0))
 S Y(1)=$$EXP(X) D FMT
 Q
ICDDX1(X,V,L) ; Convert ICD Diagnosis to Mixed Case
 N CODE,IEN,VDT,LEN,ICDDX,LOW K LOW,Y S (CODE,IEN)=$G(X),VDT=$G(V),LEN=+($G(L)) K:$G(LEN)'>19 LEN K:$G(LEN)'<80 LEN S:VDT'?7N VDT=$$DT^XLFDT
 S IEN=$P($$CODEN^ICDCODE(IEN,80),"~",1),X="",ICDDX=$P($$ICDDX^ICDCODE(+IEN,VDT,,0),"^",4) Q:'$L(ICDDX)  S Y(1)=$$CASE(ICDDX) D FMT
 Q
ICDDX2(X,V,L) ; Convert ICD Diagnosis Description to Mixed Case
 N CODE,I,IEN,VDT,LEN,ND,LOW K LOW,Y S (CODE,IEN)=$G(X),VDT=$G(V),LEN=+($G(L)) K:$G(LEN)'>19 LEN K:$G(LEN)'<80 LEN S:VDT'?7N VDT=$$DT^XLFDT
 S IEN=$P($$CODEN^ICDCODE(IEN,80),"~",1),CODE=$P($$ICDDX^ICDCODE(+IEN,,0),"^",2) D ICDD^ICDCODE(CODE,"ND",VDT)
 K Y S I=0 F  S I=$O(ND(I)) Q:+I'>0  Q:$$TRIM($G(ND(I)))=""  S:I>1 LOW=1 S Y(I)=$$CASE($G(ND(I))) K LOW
 D FMT
 Q
ICDOP1(X,V,L) ; Convert ICD Procedure to Mixed Case
 N CODE,IEN,VDT,LEN,ICDOP,LOW K LOW,Y S (CODE,IEN)=$G(X),VDT=$G(V),LEN=+($G(L)) K:$G(LEN)'>19 LEN K:$G(LEN)'<80 LEN S:VDT'?7N VDT=$$DT^XLFDT
 S IEN=$P($$CODEN^ICDCODE(IEN,80.1),"~",1),X="",ICDOP=$P($$ICDOP^ICDCODE(+IEN,VDT,,0),"^",5) Q:'$L(ICDOP)  S Y(1)=$$CASE(ICDOP) D FMT
 Q
ICDOP2(X,V,L) ; Convert ICD Procedure Description to Mixed Case
 N CODE,I,IEN,VDT,LEN,ND,LOW K LOW,Y S (CODE,IEN)=$G(X),VDT=$G(V),LEN=+($G(L)) K:$G(LEN)'>19 LEN K:$G(LEN)'<80 LEN S:VDT'?7N VDT=$$DT^XLFDT
 S IEN=$P($$CODEN^ICDCODE(IEN,80.1),"~",1),CODE=$P($$ICDOP^ICDCODE(+IEN,VDT,,0),"^",2) D ICDD^ICDCODE(CODE,"ND",VDT)
 K Y S I=0 F  S I=$O(ND(I)) Q:+I'>0  Q:$$TRIM($G(ND(I)))=""  S:I>1 LOW=1 S Y(I)=$$CASE($G(ND(I))) K LOW
 D FMT
 Q
ICPT1(X,V,L) ; Convert CPT Procedure to Mixed Case
 N CODE,IEN,VDT,LEN,ICPT,LOW K LOW,Y S (CODE,IEN)=$G(X),VDT=$G(V),LEN=+($G(L)) K:$G(LEN)'>19 LEN K:$G(LEN)'<80 LEN S:VDT'?7N VDT=$$DT^XLFDT
 S X="",ICPT=$$CPT^ICPTCOD(+IEN,VDT),IEN=+ICPT,CODE=$P(ICPT,"^",2),ICPT=$P(ICPT,"^",3) Q:'$L(ICPT)  S Y(1)=$$CASE(ICPT) D FMT
 Q
ICPT2(X,V,L) ; Convert CPT Procedure Description to Mixed Case
 N CODE,I,IEN,VDT,LEN,ND,LOW K LOW,Y S (CODE,IEN)=$G(X),VDT=$G(V),LEN=+($G(L)) K:$G(LEN)'>19 LEN K:$G(LEN)'<80 LEN S:VDT'?7N VDT=$$DT^XLFDT
 S CODE=$P($$CPT^ICPTCOD(+IEN,VDT),"^",2) D CPTD^ICPTCOD(CODE,"ND",,VDT)
 K Y S I=0 F  S I=$O(ND(I)) Q:+I'>0  Q:$$TRIM($G(ND(I)))=""  S:I>1 LOW=1 S Y(I)=$$CASE($G(ND(I))) K LOW
 D FMT
 Q
MOD1(X,V,L) ; Convert CPT Modifier to Mixed Case
 N CODE,IEN,VDT,LEN,MOD,LOW K LOW,Y S (CODE,IEN)=$G(X),VDT=$G(V),LEN=+($G(L))
 K:$G(LEN)'>19 LEN K:$G(LEN)'<80 LEN S:VDT'?7N VDT=$$DT^XLFDT
 S X="",MOD=$$MOD^ICPTMOD(IEN,"I",VDT,1) S MOD=$P(MOD,"^",3) Q:'$L(MOD)  S Y(1)=$$CASE(MOD) D FMT
 Q
MOD2(X,V,L) ; Convert CPT Modifier Description to Mixed Case
 N CODE,I,IEN,VDT,LEN,ND,LOW K LOW,Y S (CODE,IEN)=$G(X),VDT=$G(V),LEN=+($G(L)) K:$G(LEN)'>19 LEN K:$G(LEN)'<80 LEN S:VDT'?7N VDT=$$DT^XLFDT
 S CODE=$P($$MOD^ICPTMOD(+IEN,"I",VDT,1),"^",2) D MODD^ICPTMOD(CODE,"ND",,VDT)
 K Y S I=0 F  S I=$O(ND(I)) Q:+I'>0  Q:$$TRIM($G(ND(I)))=""  S:I>1 LOW=1 S Y(I)=$$CASE($G(ND(I))) K LOW
 D FMT
 Q
 ;             
EXP(X) ; Get Case for Expression            X = IEN in 757.01
 N IEN,IEN,TXT,IN S IEN=$G(X),(TXT,IN)=$G(^LEX(757.01,+IEN,0)) Q:'$L(TXT)  K PAR S (TXT,X)=$$CASE(TXT) S:'$L(X) X=IN
 Q X
CASE(X) ; Get Case for String                X = String of Text
 K PAR N C,CHR,CT,LEXIN,LEXCTL,LEXCHR,I,L,PH,REM,STO,STR,TRL,TXT,W,WD,UIN,OIN,LEXPRE,LEXORG,LEXNXT,LEXUSE
 S OIN=$$TRIM($G(X)) S (UIN,STR)=$$UP(OIN) Q:'$L(STR) X  S STR=$$SW1(STR),L=$L(STR),PAR(0)=0,(LEXIN,PAR("T",1))=STR
 S TRL="" F  Q:$E(STR,$L(STR))'?1P  S TRL=$E(STR,$L(STR))_TRL,STR=$E(STR,1,($L(STR)-1))
 S PAR("TRL")=$G(TRL) S I=0 F  Q:I>L  Q:'$L(STR)  D  Q:'$L(STR)
 . S I=I+1 I I=$L(STR) D  Q
 . . S CT=$O(PAR(" "),-1)+1 S (STO,PAR(CT))=STR,PAR(0)=CT,STR=""
 . . S PH=$G(PAR((CT-1),"C"))_$G(PAR(CT))_$G(PAR(CT,"C")),PAR(CT,"A")=PH
 . . S LEXIN=$G(PAR("T",1)),LEXCTL=$G(PAR(CT,"A")),LEXCHR=$G(PAR(CT,"C"))
 . . F W=1:1:$L(STO," ") D
 . . . N NWD S WD=$P(STO," ",W),LEXORG=$G(PAR(CT,"W",(+($G(W))-1))),LEXPRE=$$UP(LEXORG)
 . . . S LEXNXT="",NWD=$$GETC(WD),PAR(CT,"W",W)=NWD
 . S C=$E(STR,I)
 . I C?1P&(C'=" ") D
 . . S:C="(" C=" (" S:C="[" C=" [" S:C="&" C=" &"
 . . N REM,STO S CT=$O(PAR(" "),-1)+1,(STO,PAR(CT))=$E(STR,1,(I-1)),PAR(0)=CT
 . . S PH=$G(PAR(CT-1,"C"))_$G(PAR(CT))_$G(PAR(CT,"C")),PAR(CT,"A")=PH
 . . S LEXIN=$G(PAR("T",1)),LEXCTL=$G(PAR(CT,"A")),LEXCHR=C
 . . F W=1:1:$L(STO," ") D
 . . . N NWD S WD=$P(STO," ",W),LEXPRE=$$UP($G(PAR(CT,"W",(+($G(W))-1))))
 . . . S NWD=$$GETC(WD),PAR(CT,"W",W)=NWD
 . . S (REM,STR)=$E(STR,I+1,$L(STR)),I=0
 . . F  Q:$E(STR,1)'=" "  S C=C_" " S (REM,STR)=$E(STR,2,$L(STR))
 . . S PAR(CT,"C")=C
 S TXT="",CT=0 F  S CT=$O(PAR(CT)) Q:+CT'>0  D
 . N STR,TR S STR="",TR=$G(PAR(CT,"C")),W=0 F  S W=$O(PAR(CT,"W",W)) Q:+W'>0  S STR=STR_" "_$G(PAR(CT,"W",W))
 . S STR=$$TRIM(STR)_TR,PAR(CT,"B")=STR
 . S TXT=TXT_STR K PAR(CT)
 S TXT=TXT_$G(PAR("TRL")),X=$$SW3(TXT) K PAR F CHR="-","+" D
 . I UIN[(" "_CHR),X[CHR,X'[(" "_CHR) D
 . . N TXT S TXT=$P(X,CHR,1) F I=2:1 Q:'$L($P(X,CHR,I))  S TXT=TXT_(" "_CHR)_$P(X,CHR,I)
 . . S X=TXT
 S X=$$FN(X),X=$$DBL(X) F CHR="~","!","@","#","$","^","&","*","_","-","+","=","|","\",";",":",",","." S X=$$TM(X,CHR)
 Q X
GETC(X) ; Set to Mixed/lower/UPPER case
 N LEXTAG,LEXRTN,LEXLEN,Y Q:$L($G(X))'>0 X  S X=$$UP($G(X)),Y="",LEXLEN=$L(X) S:LEXLEN>12 LEXLEN=12
 S LEXUSE=$$UP($$USE),LEXNXT=$$TP($$TM($P($G(UIN),LEXUSE,2,299)))
 S LEXTAG="T"_$L(X),LEXRTN="LEXXM"_$L(X)
 S:$L($G(X))>9 LEXTAG="TM" S:$L($G(X))>5 LEXRTN="LEXXM6" S LEXRTN=LEXTAG_"^"_LEXRTN D @LEXRTN I $L(Y) S X=$$SW2(Y) Q X
 S X=$$MX(X)
 Q X
 ;             
SW1(X) ; Switch Text (before setting case)
 S X=$$SW1^LEXXMM($G(X)) Q X
SW2(X) ; Switch Text (after setting case)
 S X=$$SW2^LEXXMM($G(X)) Q X
SW3(X) ; Switch Text (after assembling string)
 S X=$$SW3^LEXXMM($G(X)) Q X
EW(X) ; Display Word Usage
 D EW^LEXXMM($G(X)) Q
 ;             
USE(X) ; Used
 N STR,SEG,CUR S STR="",SEG=0 F  S SEG=$O(PAR(SEG)) Q:+SEG'>0  D
 . N WC S WC=0  F  S WC=$O(PAR(SEG,"W",WC)) Q:+WC'>0  D
 . . N WD S WD=$$UP($G(PAR(SEG,"W",WC)))
 . . S:$E(STR,$L(STR))?1A!($E(STR,$L(STR))?1N) STR=$G(STR)_" "_WD
 . . S:$E(STR,$L(STR))'?1A&($E(STR,$L(STR))'?1N) STR=$G(STR)_WD
 . S:$L($G(PAR(SEG,"C"))) STR=STR_$G(PAR(SEG,"C"))
 S CUR=$G(WD) I $L(CUR) D
 . S:$E(STR,$L(STR))?1A!($E(STR,$L(STR))?1N) STR=$G(STR)_" "_CUR
 . S:$E(STR,$L(STR))'?1A&($E(STR,$L(STR))'?1N) STR=$G(STR)_CUR
 S X=$$TM(STR)
 Q X
 ;WD="COMPLICATED"
 Q X
FMT ; Format Line Length - needs Y() and LEN
 Q:$O(Y(0))'>0  Q:+($G(LEN))'>0  Q:+($G(LEN))'>19  Q:+($G(LEN))>79  N I,J,X,D,DIW,DIWF,DIWL,DIWI,DIWR,DIWT,DIWTC,DIWX,DN,Z,L
 K ^UTILITY($J,"W") S DIWL=0,DIWF="C"_+($G(LEN)) F J=0:0 S J=$O(Y(J)) Q:'J  S X=Y(J) D ^DIWP
 K Y F J=0:0 S J=$O(^UTILITY($J,"W",0,J)) Q:'J  S Y(J)=$$TRIM($G(^UTILITY($J,"W",0,J,0)))
 K ^UTILITY($J,"W")
 Q
FN(X) ; Footnote Removed
 S X=$G(X) Q:X'[")" X  N ORG,FIR,LAS,TRM,L,NUM,OUT,REP,WTH S (OUT,ORG)=X,L=$L(X,")"),FIR=$P(X,")",1,(L-1))_")",LAS=$P(X,")",L),TRM=$$TRIM(LAS),X=ORG I TRM=LAS,$E(LAS,1)?1N,+LAS=LAS S OUT=FIR
 F NUM=1:1:9 S REP=")"_NUM_" ",WTH=") " I OUT[REP S OUT=$$SWAP^LEXXMM(OUT,REP,WTH)
 S X=OUT
 Q X
LO(X) ; Lower Case
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
UP(X) ; Upper Case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
MX(X) ; Mixed Case
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
LD(X) ; Leading Character
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(X,2,$L(X))
TRIM(X) ; Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
TP(X) ; Trim Punctuation
 S X=$G(X) Q:'$L(X) X  F  Q:$E(X,1)'?1P  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'?1P  S X=$E(X,1,($L(X)-1))
 Q X
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X),Y=$G(Y) Q:$L(Y)&(X'[Y) X  S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
DBL(X) ; Double Spaces
 S X=$G(X) F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,299)
 S X=$$TRIM(X)
 Q X
