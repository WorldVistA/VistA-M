PRCFD8H ;WISC/LEM-FMS PV2 thru PV5 SEGMENTS ;8/10/95  12:18
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PV2(CI,ACTION) ;BUILD 'PV2' SEGMENT
 N DA,DOCTYPE,SEG,VENDA,VENID S DOCTYPE="" K PRCTMP
 S DIC=421.5,(DA,CI)=+CI,DIQ="PRCTMP(",DIQ(0)="IE"
 S DR="3;6;8;11.5;13;61.9;71;72" D EN^DIQ1
 S DIC=440,(DA,VENDA)=+PRCTMP(421.5,CI,6,"I")
 S DR=".06;17.3;17.4;17.5;17.6;17.7;17.8;17.9;34;35" D EN^DIQ1
 K DIC,DIQ,DR
 S $P(SEG,U,1)="PV2" ; Segment ID
 S X=PRCTMP(421.5,CI,71,"I") S:X="" X=DT
 S $P(SEG,U,2)=$E(X,4,5) ; Transaction Month
 S $P(SEG,U,3)=$E(X,6,7) ; Transaction Day
 S $P(SEG,U,4)=$E(X,2,3) ; Transaction Year
 S X=PRCTMP(421.5,CI,72,"I")
 I X'=""  D  ; Accounting Period
 . S $P(SEG,U,5)=$P("04^05^06^07^08^09^10^11^12^01^02^03",U,$E(X,4,5))
 . S $P(SEG,U,6)=$E(100+$E(X,2,3)+$S($E(X,4,5)>9:1,1:0),2,3)
 S $P(SEG,U,9)=ACTION ; Document Action
 S $P(SEG,U,10)="01" ; Transaction Type
 ; Not required, per Dan Q. (AMS):
 ;S $P(SEG,U,11)=DOCTYPE ; Document Type
 S VENID=PRCTMP(440,VENDA,34,"I")
 I VENID="" S VENID="MISCN" I PRCTMP(440,VENDA,.06,"I") S VENID="MISCG"
 S $P(SEG,U,20)=VENID ; FMS Vendor ID
 S $P(SEG,U,21)=PRCTMP(440,VENDA,35,"I") ; Alt-Addr-Ind
 S $P(SEG,U,22)=$FN(PRCTMP(421.5,CI,13,"I")/100,"",2) ; Document Total
 I VENID="MISCN"!(VENID="MISCG") D
 . S $P(SEG,U,23)=$E(PRCTMP(421.5,CI,6,"E"),1,30) ; Vendor Name
 . S $P(SEG,U,24)=PRCTMP(440,VENDA,17.3,"I") ; Vendor Address Line 1
 . S $P(SEG,U,25)=PRCTMP(440,VENDA,17.4,"I") ; Vendor Address Line 2
 . S $P(SEG,U,26)=$E(PRCTMP(440,VENDA,17.7,"I"),1,19) ; Vendor City
 . S $P(SEG,U,27)=$P($G(^DIC(5,+PRCTMP(440,VENDA,17.8,"I"),0)),U,2)
 . S $P(SEG,U,28)=$TR(PRCTMP(440,VENDA,17.9,"I"),"-") ; Vendor Zip Code
 . Q
 S SEG=SEG_"^~" ; Segment Delimiter
 S ^TMP($J,"PRCPV",1)=SEG
 Q
PV3 ;BUILD 'PV3' SEGMENT
 N SEG,DA,PPT,PM,TC,TOT,CONT
 S DIC=421.5,DR="1;4;5;9;10;11.3",DA=+CI
 S DIQ="PRCTMP(",DIQ(0)="IE" D EN^DIQ1 K DR
 S DR=31,DR(421.531)="1;2;3;4"
 F DA(421.531)=1,2,3 D EN^DIQ1
 K DR,DA(421.531)
 S PATDA=+PRCTMP(421.5,+CI,5,"I") I PATDA S DIC=442,DR=".02",DA=PATDA D EN^DIQ1
 K DIC,DIQ,DR S DA=+CI
 S $P(SEG,U,1)="PV3" ; Segment ID
 S $P(SEG,U,9)=PRCF("TC") ; Transaction Code
 ; Not required, per Dan Q. (AMS):
 ;S $P(SEG,U,10)=PRCFTN ; Transaction Number
 S $P(SEG,U,14)=PRCTMP(421.5,+CI,1,"E") ; Invoice/Bill Number
 S $P(SEG,U,22)=PRCTMP(421.5,+CI,4,"I") ; Prompt Pay Type
 S:$P(SEG,U,22)="A" $P(SEG,U,22)=" "
 F I=1,2,3 I $D(PRCTMP(421.531,I)) D
 . ; Discount Percent:
 . N PCT,L S PCT=$TR($FN(PRCTMP(421.531,I,2,"I"),"",3),"."),L=$L(PCT)
 . I PCT?1"0"."0"!(PCT="NET") S (L,PCT)=""
 . S:L $P(SEG,U,I-1*3+23)=$E(PCT,1,L-3)_"."_$E(PCT,L-2,L)
 . S:PRCTMP(421.531,I,3,"I")]"" $P(SEG,U,I-1*3+24)=$FN(PRCTMP(421.531,I,3,"I"),"",2) ; Discount Amount
 . S:PCT!(+PRCTMP(421.531,I,3,"I")>0) $P(SEG,U,I-1*3+25)=+PRCTMP(421.531,I,4,"E") ; Discount Days
 . Q
 S ^TMP($J,"PRCPV",2)=SEG_"^~"
 Q
 ;
PV4 ;BUILD 'PV4' SEGMENT
 N SEG S SEG=""
 S $P(SEG,U,1)="PV4" ; Segment Identifier
 F I=1,2,3 I $G(PRCTMP(421.531,I,1,"I"))="P"!($G(PRCTMP(421.531,I,1,"I"))="X") D
 . S $P(SEG,U,I+3)=PRCTMP(421.531,I,4,"E") ; Prox/EOM Days
 . Q
 ;S $P(SEG,U,14)="~" ; Segment Delimiter
 S SEG=SEG_"^~" ; Segment Delimiter
 I SEG'="PV4^~" S ^TMP($J,"PRCPV",3)=SEG
 Q
PV5 ;BUILD 'PV5' SEGMENT
 N SEG S SEG=""
 S $P(SEG,U,1)="PV5" ; Segment Identifier
 ;S $P(SEG,U,4)="~" ; Segment Delimiter
 S $P(SEG,U,2)="~" ; Segment Delimiter
 I SEG'="PV5^~" S ^TMP($J,"PRCPV",4)=SEG
 Q
FAMT I 'X S X="" Q
 I X?.N1"."2N Q
 N L,Y,Z S L=$L(X),Y=$E(X,L-1,L)_"00",Z=$E(X,1,L-2),X=Z_"."_$E(Y,1,2)
 ;S X=$P(X,".")_$E($P(X,".",2)_"00",1,2) Q
 Q
