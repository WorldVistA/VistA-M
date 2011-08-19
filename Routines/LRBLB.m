LRBLB ;AVAMC/REG/CRT - BLOOD BANK BAR CODE READER ; 12/5/00 11:16am
 ;;5.2;LAB SERVICE**247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
X S X=$E(X,LR,$L(X)),A=$E(X),B=$E(X,$L(X)) Q
W W ?32,"(Bar code)" Q
STRIP(X) ; Strip off any ISBT-128 barcode identifier characters
 S X=$TR(X,"=<>&%(","")
 Q X
 ;
U ;from LRBLDRR, LRBLJLG
 I $$ISBTUID(.X) Q
 S X=$$STRIP(X)
 D X I 'LR(3),X?7N S A=+$E(X,1,2),B=A\20,B=$E("FGKL",B),A=A#20+1,A=$E("CEFGHJKLMNPQRSTVWXYZ",A),A=B_A S X=A_$E(X,3,7)
 D W W ?45,"UNIT ID: ",X Q
 Q
A ;ABO/RH GROUPING
 N XX   ; used to preserve original value to redisplay if invalid
 D ISBTBG(X,.LRABO,.LRRH)
 I LRABO]"" D W,EN^DDIOL("ABO/Rh: "_LRABO_" "_LRRH,"","?47") Q
 S XX=$$STRIP(.X)
 D X I X?3N,$E(X,3)=0 S A=$T(@(+$E(X,1,2))),X=$P(A,";",3) I X="" K X W XX Q:'$D(X)  D W W ?46,"ABO/Rh: ",X S LRABO=$P(X," "),LRRH=$P(X," ",2) Q
 Q
P ;PRODUCT CODE
 I $$ISBTPC(.X) Q
 S X=$$STRIP(X)
 D X
 I X?7N&(A=0!(A=3))&(B=3) D
 .S X=$E(X,2,6),Y=0
 .D W,C
 E  W X
 Q
C N XX S XX=X K X S X=XX  ; need to remove leftover X subnodes!!
 F A=1:1 S Y=$O(^LAB(66,"D",X,Y)) Q:'Y  S X(A)=Y_"^"_^LAB(66,Y,0)
 I A=2 S W(4)=+X(1),P=$P(X(1),U,2),W(9)=$P(X(1),U,20),LRV=$P(X(1),U,11),LRJ=$P(X(1),U,26),X=P W !?24,P Q
 W ! S Y=0 F A=0:1 S Y=$O(X(Y)) Q:'Y  W !?2,Y,")",?5,$P(X(Y),U,2)
 I A=0 D  K X Q
 .W !!?28,"Product Code '",X,"' not found."
 .W !?28,"Please add to the Blood Product File"
H W !,"CHOOSE 1-",A,": " R X:DTIME I X=""!(X[U) K X Q
 I X<1!(X>A) W $C(7) G H
 S W(4)=+X(X),P=$P(X(X),U,2),W(9)=$P(X(X),U,20),LRV=$P(X(X),U,11),LRJ=$P(X(X),U,26),X=P W ?25,P Q
R ;FDA REG #
 D X I X?9N&(B=1)&(A=0!(A=1)) S X=$E(X,2,8) D W W !?2,"Registration number: ",X Q
 Q
D ;DATE CODE
 I $$ISBTED(.X) Q
 S X=$$STRIP(X)
 D X I X'?6N&(X'?8N) W X Q
 S %DT="" D ^%DT S W(6)=Y I Y<1 K X Q
 D D^LRU D W W ?44,"Exp date: ",Y Q
BAR ;TEST BAR CODE READER
 S LR="" W !!?28,"To use BAR CODE READER",!?15,"Pass reader wand over a GROUP-TYPE (ABO/Rh) label",! S X=$$READ("=>",25) Q:X=""!(X["^")  W " (bar code)"
 D ISBTBG(X,.LRABO,.LRRH) I LRABO]"" D  Q
 .S LR=1,LR(2)=""
 .W " ",LRABO," ",LRRH
 S X=$$STRIP(X)
 F A=1:1 S Y=$P($T(G+A),";",4) Q:Y=""  S X(1)=$F(X,Y) I X(1),$L(X)<X(1) S LR=$L(X)-3,LR(2)=$E(X,1,LR),LR=LR+1 Q
 I LR="" W $C(7),!!?28,"Not a GROUP-TYPE label",!?15,"Press <RETURN> key if BAR CODE READER is not used",! G BAR
 W " ",$P($T(G+A),";",3) K X Q
 ;
T ;from LRBLDRR1, LRBLJLG
 F A=1:1 S Y=$P($T(G+A),";",3) Q:Y=""  S:X=$E(Y,1,$L(X)) X(A)=Y
 I $D(X)'=11 K X D S Q
 K Y S Y=0 F A=1:1 S Y=$O(X(Y)) Q:'Y  S Y(A)=X(Y) K X(Y)
 I A=2 S LRABO=$P(Y(1)," ",1),LRRH=$P(Y(1)," ",2) W $E(Y(1),$L(X)+1,$L(Y(1))) Q
 W ! S Y=0 F A=0:1 S Y=$O(Y(Y)) Q:'Y  W !?2,Y,")",?5,Y(Y)
AG W !,"CHOOSE 1-",A,": " R X:DTIME I X=""!(X["^") K X Q
 I X<1!(X>A) W $C(7) G AG
 W " ",Y(X) S LRABO=$P(Y(X)," ",1),LRRH=$P(Y(X)," ",2) Q
S W !!,"Select from (NA=not applicable): " F A=1:1 W !?15,$P($T(G+A),";",3) Q:$T(G+A)=""
 Q
 ;
ISBTUID(LRBLIN) ; Check for and display valid ISBT-128 Unit Id
 ; Valid codes are prefixed by "="
 ;
 ; INPUT  : LRBLIN = input from Unit Id barcode label.
 ; OUTPUT : Boolean
 ;
 Q:$E(LRBLIN,1,2)'?1"="1(1A,1N) 0
 S LRBLIN=$E(LRBLIN,2,14)
 S LRBLIN=$$UP^XLFSTR(LRBLIN) ; make uppercase
 D W
 D EN^DDIOL("UNIT ID: "_LRBLIN,"","?46")
 Q 1
 ;
ISBTBG(IN,LRBLABO,LRBLRH) ; Check for ISBT-128 valid Blood Group
 ; and return ABO & Rh values
 ; Valid codes are prefixed by "=%"
 ;
 ; INPUT  : IN = input from Blood Group barcode label.
 ; OUTPUT : LRBLABO (passed by reference) = ABO value
 ;          LRBLRH  (passed by reference) = Rh value
 ;
 S (LRBLABO,LRBLRH)=""
 Q:$L(IN)'>3
 Q:$E(IN,1,2)'="=%"
 S IN=$E(IN,3,4)
 S LRABO=$S(90<IN&(IN<99):"O NEG",46<IN&(IN<55):"O POS",1<IN&(IN<10):"A NEG",57<IN&(IN<66):"A POS",12<IN&(IN<21):"B NEG",68<IN&(IN<77):"B POS",23<IN&(IN<32):"AB NEG",79<IN&(IN<88):"AB POS",1:"")
 Q:LRABO=""
 S LRBLRH=$P(LRBLABO," ",2)
 S LRBLABO=$P(LRBLABO," ")
 Q
 ;
ISBTPC(LRBLIN) ; Check for and display valid ISBT-128 Product Code
 ; Valid codes prefixed by "=<"
 ;
 ; INPUT  : LRBLIN = input from Product Code barcode label
 ; OUTPUT : Boolean
 ;
 Q:$E(LRBLIN,1,2)'="=<" 0
 S LRBLIN=$E(LRBLIN,3,$L(LRBLIN))
 S LRBLIN=$$UP^XLFSTR(LRBLIN)
 S Y=0
 S X=LRBLIN D W,C
 ;I A=0 D
 ;.D EN^DDIOL("Product Code not found.",,"!!?28")
 ;.D EN^DDIOL("Please add to the Blood Product File",,"!?28")
 Q 1
 ;
ISBTED(LRBLIN) ; Check for and display valid ISBT-128 Expiration Date
 ; Valid codes are prefixed by "&>"
 ;
 ; INPUT  : LRBLIN = input from Expiration Date barcode label
 ; OUTPUT : Boolean
 ;
 N X,Y
 ;
 Q:$E(LRBLIN,1,2)'="&>" 0
 S LRBLIN=$E(LRBLIN,3,$L(LRBLIN))
 S X=$$JULIAN(LRBLIN)
 Q:'X 0
 S (W(6),Y)=$P(X,".")_"."_$S($E(LRBLIN,7,10)]"":$E(LRBLIN,7,10),1:"2359")
 D D^LRU,W
 S LRBLIN=$E(Y,1,12)_"@"_$E(Y,14,18) ; Set LRBLIN to valid input
 D EN^DDIOL("Exp date: "_Y,"","?45")
 Q 1
 ;
JULIAN(LRBLJD) ;; Julian Date Conversion
 ;
 ; INPUT  : LRBLJD = Julian Date (format = CYYDDD)
 ;                   If C=9 then 19YY, else 2CYY
 ;                   DDD=number of days in year (eg 128 = MAY 8)
 ; OUTPUT : FileMan date or 0 if invalid
 ;
 N X,%H,%T,%Y,%
 ;
 ; Put year only into FileMan format
 S X=$S($E(LRBLJD)="9":1900,1:2000+($E(LRBLJD)*100))
 S X=X+$E(LRBLJD,2,3)
 S X=X-1700
 S X=X_"0101"
 ; Get $H value of Jan 1st
 D H^%DTC
 Q:'%H 0
 ; Add days to $H value
 S %H=%H+$E(LRBLJD,4,6)-1
 ; Put date back into FileMan format
 D YX^%DTC
 Q +X
 ;
READ(PROMPT,POS) ; This extrinsic function will be used to present a prompt that can receive input from a 
 ; scanner or manual data entry.  This function returns the entire value of the input.
 ;
 N X
 S:'$G(POS) POS=0
 W ?POS,PROMPT
 R X:DTIME
 W $C(13),$J("",79),$C(13),$J("",POS),PROMPT
 Q X
G ;;
51 ;;O POS;510
62 ;;A POS;620
73 ;;B POS;730
84 ;;AB POS;840
95 ;;O NEG;950
6 ;;A NEG;060
17 ;;B NEG;170
28 ;;AB NEG;280
55 ;;O;550
66 ;;A;660
77 ;;B;770
88 ;;AB;880
 ;;NA NA;
