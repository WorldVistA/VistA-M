ENPL3 ;(WASH ISC)/LKG,SAB-MINOR/MINOR MISC PRIORITIZATION ;5/12/95
 ;;7.0;ENGINEERING;**11,23**;Aug 17, 1993
IN ;Calculation of VAMC Priority points by section and generating Total
 D A,B,C,D,E,F,G
 Q
A ; Citation Points
 N %Y,ENA,ENB,ENC,END,ENE,X,X1,X2,Y
 K ENF S ENA=0
AA S ENA=$O(^ENG("PROJ",ENDA,21,ENA)) G:ENA'?1.N AE
 S ENB=$G(^ENG("PROJ",ENDA,21,ENA,0)) G AA:'$P(ENB,U,8)
 ; base 6-yr limit on 1/15 of current year
 S X1=$E(DT,1,3)_"0115",X2=$P(ENB,U,3) D ^%DTC G:X>2190 AA
 S ENC=$P(ENB,U,4) G AA:ENC'?1.N,AA:$D(^OFM(7335.7,ENC,0))#10'=1
 S END=^OFM(7335.7,ENC,0),ENE=$P(END,U,8) G:'ENE AA
 S X=$P(ENB,U,3) D I
 S ENF(ENE)=$G(ENF(ENE))+1,ENF(ENE,ENF(ENE))=Y_U_$P(ENB,U,5)_U_$P(ENB,U,6)_"/"_$P(ENB,U,7)
 G AA
AE S ENF=$S($D(ENF(1))#10'=1:0,ENF(1)<3:ENF(1)*5,1:10)_U_$S($D(ENF(2))#10'=1:0,ENF(2)<3:ENF(2)*5,1:10)
 Q
B ; Space Points
 N ENA,ENB,ENC
 K ENG S ENG="0^Not Applicable"
 S ENB=$S($D(^ENG("PROJ",ENDA,0))#10:$P(^(0),U,6),1:"")
 G:",MI,MM,"'[(","_ENB_",") BE
 S ENA=$P($G(^ENG("PROJ",ENDA,18)),U,2) G BE:ENA'?1.N,BE:$D(^OFM(7336.3,ENA,0))#10'=1
 S ENC=^OFM(7336.3,ENA,0),ENG=$P(ENC,U,ENB="MM"+3)+0_U_$P(ENC,U)
BE ;
 Q
C ; Energy Points
 N ENA,ENB
 K ENH S ENH="0^Not Applicable"
 S ENB=$S($D(^ENG("PROJ",ENDA,0))#10:$P(^(0),U,6),1:"")
 G:",MI,MM,"'[(","_ENB_",") CE
 S ENA=$G(^ENG("PROJ",ENDA,15)) ; G:$P(ENA,U,17)'="Y" CE
 S ENA=+$P(ENA,U,11)
 S ENH=$S(ENA>5:"5^Above 5",ENA>4:"4^Between 4-5",ENA>3:"3^Between 3-4",ENA>2:"2^Between 2-3",ENA>1:"1^Below 2",1:"0^Not Applicable")
CE ;
 Q
D ; Category Points
 N ENA,ENB,ENC,END,ENE
 K ENI S ENI="0^Not Applicable"
 S ENB=$S($D(^ENG("PROJ",ENDA,0))#10:$P(^(0),U,6),1:"")
 G DE:",MI,MM,"'[(","_ENB_","),DE:$P($G(^ENG("PROJ",ENDA,18)),U,4)'="Y"
 S ENA=$P($G(^ENG("PROJ",ENDA,52)),U) G:ENA'?1.N DE
 G:'$D(^OFM(7336.8,ENA)) DE
 S ENE=$P($G(^OFM(7336.8,ENA,0)),U,1,4)
 S ENC=$P($G(^OFM(7336.8,ENA,1)),U,ENB="MM"+6)
 I $P(ENE,U)["SEISM" D
 . S END=+$P($G(^ENG("PROJ",ENDA,18)),U,3)
 . S ENC=$P(ENC,"/",END)
 S ENI=+ENC_U_$P(ENE,U,4)_$S($P(ENE,U)["SEISM":"  AREA CAT "_$P("I^II^III",U,END),1:"")
DE ;
 Q
E ; VAMC Priority Points
 N ENA,ENB,ENC
 K ENJ S ENJ="0^NOT a Priority"
 S ENB=$S($D(^ENG("PROJ",ENDA,0))#10:$P(^(0),U,6),1:"")
 G:",MI,MM,"'[(","_ENB_",") EE
 S ENA=$P($G(^ENG("PROJ",ENDA,15)),U,9) G:ENA="" EE
 I ENB="MI" S ENC=$S(1:0,ENA=1:10,ENA=2:5,1:0) G EA ; unknown
 S ENC=$S(1:0,ENA>0&(ENA<5):15-(ENA*3),1:0) ; unknown
EA S ENJ=ENC_U_"PRIORITY "_ENA
EE ;
 Q
F ; allowed Space, Energy, Category combination
 K ENK
 S ENK=$S(+ENG>0:+ENG_U_+ENH_"^0",1:"0^"_+ENH_"^"_+ENI)
FE ;
 Q
G ; VAMC & Factor Subtotal
 K ENX
 S ENX=ENF+$P(ENF,U,2)+ENK+$P(ENK,U,2)+$P(ENK,U,3)+ENJ
 Q
H N ENA,ENB,ENC,END S ENA="",ENB="",ENC="",END="" K ENL
HA S ENA=$O(^ENG("PROJ","AB",ENDA,ENA)) G:ENA="" HE
 S ENC=$G(^ENG("PROJ",ENA,0)),ENB=$P(ENC,U,6) G HA:",MA,MI,"'[(","_ENB_",")
 S END=$P($G(^ENG("PROJ",ENA,1)),U,3) G:END'?1.N HA
 G:'$P($G(^ENG(6925.2,END,0)),U,3) HA
 S ENL($P(ENC,U))=$P(ENC,U,3)_U_$S(ENB="MA":"MAJOR",1:"MINOR")
 G HA
HE Q
I I X'?1.N S Y="" Q
 S X=X+17000000,Y=$S($E(X,7)=0:" ",1:"")_+$E(X,7,8)_" "_$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,+$E(X,5,6))_" "_$E(X,1,4)
 Q
J S X="FY "_$S($D(^ENG("PROJ",ENDA,5))#10:$P(^(5),U,7),1:"XXXX")_" MINOR "
 S X=X_$P("DESIGN^MISCELLANEOUS",U,$P($G(^ENG("PROJ",ENDA,0)),U,6)="MM"+1)
 S X=X_" PRIORITIZATION SCORING SHEET"
 Q
K ;Entry point for computed expression to calculate VAMC Minor/Minor Misc.
 ;;Prioritization Methodology Score
 N ENF,ENG,ENH,ENI,ENJ,ENK,ENX,ENDA
 I $D(D0)#10'=1 S X="" G KE
 I ",MI,MM,"'[(","_$P($G(^ENG("PROJ",D0,0)),U,6)_",") S X="" G KE
 S ENDA=D0 D IN S X=ENX
KE Q
 ;ENPL3
