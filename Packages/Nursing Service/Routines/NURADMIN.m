NURADMIN ;HIRMFO/JH/MD-GENERIC ADMINISTRATION PRINT SELECTION ROUTINE ;10/25/90
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN ;
 Q:'$D(^DIC(213.9,1,"OFF"))  Q:$P(^DIC(213.9,1,"OFF"),"^",1)=1
 S T=$T(DISPL+ANS1)
ASK S (AN,NURQUEUE,NUROUT,NNOUT)=0,(SEL,ANS2)="",ENTR="CAT;POS" D EN1^NURSAUTL G:NUROUT Q
 I NURSZAP>6 D RNHN G:NNOUT Q
 I NURSZAP'>6,ANS1'=7,ANS1'=9,ANS1'=11 D LOCSER G:NNOUT Q
 W ! D A1 I NNOUT K NNOUT G Q
 K NNOUT Q
A1 ;
 S AN=ANS2+2 I $S(ANS1=2:1,ANS1=3:1,ANS1=4:1,1:0) S:SEL=2 AN=AN+2 S OPT="^NURA"_$P(T,";",AN) D @OPT G Q
 I ANS1=7 D:NURSZAP'>6 LOSER Q:NNOUT  S OPT=$S(SEL=1:"^NURA9G",1:"^NURA6G") D @OPT G Q
 I ANS1=9 D:NURSZAP'>6 LOINSER Q:NNOUT  S OPT=$S(SEL=1:"^NURA9I",SEL=2:"^NURA6I2",SEL=3:"^NURA6I1",1:"") D:OPT'="" @OPT G Q
 I ANS1=11 D:NURSZAP'>6 LOINSER Q:NNOUT  S OPT=$S(SEL=1:"^NURA9K",SEL=2:"^NURA6K2",SEL=3:"^NURA6K1",1:"") D:OPT'="" @OPT G Q
 S OPT=$P(ENTR,";",ANS2)_"^NURA"_$P(T,";",SEL+2) D @OPT
Q ;
 Q
LOINSER W !!,"By (1) Location (2) Service or (3) Individual:  " R SEL:DTIME I '$T!("^"[SEL) S NNOUT=1 Q
 I SEL'>0!(SEL>3) W !!,$C(7),"Select Sort Parameter by choosing '1','2' or '3'" G LOINSER
 Q
LOSER W !!,"By (1) Location or (2) Service:  " R SEL:DTIME I '$T!("^"[SEL) S NNOUT=1 Q
 I SEL'=1&(SEL'=2) W !!,$C(7),"Select sort parameter by choosing '1' or '2'" G LOSER
 Q
RNHN S SEL=1 Q:ANS1=7!(ANS1=9)!(ANS1=11)  W !!,"Sort by: ",!!,"(1) Service Category or (2) Service Position:  " R INX:DTIME I '$T!("^"[INX) S NNOUT=1 Q
 I INX'=1&(INX'=2) W !!,$C(7),"Select sort parameter by entering '1' or '2' ." G RNHN
 S ANS2=$S(INX=1:1,INX=2:2,1:"")
 Q
LOCSER W !!,"Sort by: ",!!,?5,"1.  Location and Service Category",!,?5,"2.  Location and Service Position",!,?5,"3.  Service and Service Category",!,?5,"4.  Service and Service Position ",!!,"Choose a sort parameter set between 1 and 4: "
 R INX:DTIME I '$T!("^"[INX) S NNOUT=1 Q
 I INX'=+INX!(+INX'>0)!(+INX>4) W !!,$C(7),"Select sort parameters by choosing a number between '1' and '4'." G LOCSER
 S SEL=$S(INX=1!(INX=2):1,INX=3!(INX=4):2,1:"")
 S ANS2=$S(INX=1!(INX=3):1,INX=2!(INX=4):2,1:"")
 Q
DISPL ;
 ;;9A1;6A1
 ;;9B1;9B2;6B1;6B2
 ;;9C1;9C2;6C1;6C2
 ;;9D1;9D2;6D1;6D2
 ;;9E1;6E1
 ;;9F1;6F1
 ;;9G;6G
 ;;9H1;6H1
 ;;9I;6I1;6I2
 ;;9J1;6J1
 ;;9K;6K2;6K1
