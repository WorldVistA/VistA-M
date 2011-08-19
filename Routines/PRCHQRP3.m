PRCHQRP3 ;WISC/KMB-DISPLAY LINE ITEM QUOTE REPORT ;8/8/96  10:14
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;Entry for Line Report
 W @IOF S DIC="^PRC(444,",DIC("S")="I $P(^(0),""^"",8)>1"
 S DIC(0)="AEMQZ" D ^DIC K DIC I Y<0 K DTOUT,DUOUT,Y,PRCDA Q
 S PRCDA=+Y
 ;
 W ! S %ZIS="MQ" D ^%ZIS I POP K PRCDA,Y Q
 I $D(IO("Q")) S ZTRTN="PROCESS^PRCHQRP3",ZTSAVE("PRCDA")="",ZTSAVE("DUZ")="" D ^%ZTLOAD,^%ZISC K ZTSK,PRCDA G START
 D PROCESS,^%ZISC G START
PROCESS ;
 N Z1,UOP,VEN,QTY,FOB,UPRICE,COST,I,P
 N Y,ITEM,JJ,ID,L,PPRICE,SUB,ZIP1,ZIP2,ZIP3,ZIP4,ZIP5
 N Q1,Q2,Q3,Q4,REF,KK,J,ID,SIZE,VENDOR,FILE,FLAG
 S ZIP1=$P($G(^PRC(444,PRCDA,0)),"^"),ZIP2=$P($G(^(0)),"^",3),ZIP3=$P($G(^(8,0)),"^",4)
 S ZIP5=$P($G(^PRC(444,PRCDA,0)),"^",12) S:ZIP5'="" ZIP5=$P($G(^VA(200,ZIP5,0)),"^")
 S ZIP4=$P($G(^PRC(444,PRCDA,2,0)),"^",4)
 S Y=ZIP2 D DD^%DT S ZIP2=Y
 D VENDOR^PRCHQRP4,RFQLOAD,ITEM,WRITE K PRCDA,^TMP($J) S:$D(ZTQUEUED) ZTREQ="@"
 QUIT
WRITE ;
 U IO S (P,Z1)=1,U="^"
 D HDR
 I '$D(^TMP($J,"PRT")) W !!," ** No Quote Data **"
 S Q1=0 F  S Q1=$O(^TMP($J,"PRT",Q1)) Q:Q1=""  D  Q:Z1[U
 . I IOSL-$Y<6 D HDR Q:Z1[U
 .W !!,?10,"LINE ITEM # ",Q1 I $D(SUB(Q1)) W ?40,"LAST PRICE ",SUB(Q1)
 .W ! S (Q2,Q3)=0 F  S Q2=$O(^TMP($J,"PRT",Q1,Q2)) Q:Q2=""  D  Q:Z1[U
 ..F  S Q3=$O(^TMP($J,"PRT",Q1,Q2,Q3)) Q:Q3=""  D  Q:Z1[U
 ...S Q4="" F  S Q4=$O(^TMP($J,"PRT",Q1,Q2,Q3,Q4)) Q:Q4=""  D  Q:Z1[U
 ....I IOSL-$Y<4 D HDR Q:Z1[U
 ....W !,$E($P(^TMP($J,"PRT",Q1,Q2,Q3,Q4),"^"),1,23),?25,$P(^TMP($J,"PRT",Q1,Q2,Q3,Q4),"^",2),?35,$P(^TMP($J,"PRT",Q1,Q2,Q3,Q4),"^",3),?40,$P(^TMP($J,"PRT",Q1,Q2,Q3,Q4),"^",4)
 ....W ?45,$J($FN($P(^TMP($J,"PRT",Q1,Q2,Q3,Q4),"^",5),"",2),10),?58,$J($FN($P(^TMP($J,"PRT",Q1,Q2,Q3,Q4),"^",8),"",2),10),?70,$P(^TMP($J,"PRT",Q1,Q2,Q3,Q4),"^",6),?75,$P(^TMP($J,"PRT",Q1,Q2,Q3,Q4),"^",7)
 ....W:IOM>120 ?90,$P(^TMP($J,"PRT",Q1,Q2,Q3,Q4),"^",9)
 ....W:IOM'>80&($P(^TMP($J,"PRT",Q1,Q2,Q3,Q4),"^",9)]"") !?10,$P(^(Q4),"^",9)
 I Z1'[U,IOSL-$Y<14 R:$E(IOST,1,2)="C-"&'$D(ZTQUEUED) !,"Enter RETURN to continue or '^' to exit: ",Z1:DTIME W @IOF
 D:Z1'[U LEGEND^PRCHQRP4
 I Z1'[U,$E(IOST,1,2)="C-",'$D(ZTQUEUED) R !,"Enter RETURN to continue",Z1:DTIME
 Q
HDR ;
 I $E(IOST,1,2)="C-",P>1,'$D(ZTQUEUED) R !,"Enter RETURN to continue or '^' to exit: ",Z1:DTIME Q:Z1["^"
 W @IOF
 W !,"RFQ #",ZIP1,?60,"PAGE ",P,!,"Quotations Due Date: ",ZIP2,!,"Number of Quotes: ",ZIP3,!,"Number of Items on RFQ: ",ZIP4,!,"Point of Contact: ",ZIP5,!
 W !,?25,"Size",?40,"Unit of",?50,"Unit",?60,"Extended"
 W !,"Vendor" W:IOM'>80 ?10,"Flags" W ?25,"Status",?35,"Qty",?40,"Issue",?50,"Price",?60,"Price",?70,"FOB",?75,"#MSGS" W:IOM>120 ?90,"Flags" W !
 F I=1:1:$S(IOM>120:12,1:8) W "----------"
 S P=P+1 QUIT
ITEM ;
 K ^TMP($J,"PRT") S I=0
 F  S I=$O(^PRC(444,PRCDA,8,I)) Q:+I'=I  D
 .S SIZE=""
 .S ID=$P($G(^PRC(444,PRCDA,8,I,0)),"^") Q:ID=""
 .S KK=$P(ID,";"),FILE=$P(ID,";",2),REF="^"_FILE_KK_",0)"
 . I FILE["PRC(440" S SIZE=$P($G(^PRC(440,KK,2)),U,3)
 . I FILE["PRC(444.1" S SIZE=$P($G(^PRC(444.1,KK,0)),U,5)
 . S SIZE=$P("SMALL^LARGE",U,SIZE)
 .S VEN=@REF,VEN=$P(VEN,"^") S:VEN="" VEN=0
 .S JJ=0 S:FILE[440 JJ=$P($G(^PRC(440,KK,7)),"^",12) S:FILE[444.1 JJ=$P($G(^PRC(444.1,KK,0)),"^",2) S:JJ="" JJ=0
 . S J=0 F  S J=$O(^PRC(444,PRCDA,8,I,3,J)) Q:+J'=J  D
 ..S FLAG=""
 ..S ITEM=$P($G(^PRC(444,PRCDA,8,I,3,J,0)),"^") Q:ITEM=""
 ..S QTY=$P($G(^PRC(444,PRCDA,8,I,3,J,0)),"^",2),UOP=$P($G(^(0)),"^",3)
 ..S FOB=$P($G(^PRC(444,PRCDA,8,I,3,J,0)),"^",10)
 ..S:FOB="" FOB=$P($G(^PRC(444,PRCDA,8,I,1)),"^")
 ..S UPRICE=$P($G(^PRC(444,PRCDA,8,I,3,J,1)),"^",3),COST=$P($G(^(1)),"^",7)
 ..I UOP'="" S UOP=$P($G(^PRCD(420.5,UOP,0)),"^",2)
 ..S:COST="" COST=0 S:ITEM="" ITEM=0
 .. I FOB'=^TMP($J,"RFQ","FOB") S FLAG=FLAG_$S(FLAG]"":",",1:"")_"F"
 .. I QTY'=$G(^TMP($J,"RFQ","ITEM",ITEM,"QUANTITY")) S FLAG=FLAG_$S(FLAG]"":",",1:"")_"Q"
 .. I UOP'=$G(^TMP($J,"RFQ","ITEM",ITEM,"UNIT")) S FLAG=FLAG_$S(FLAG]"":",",1:"")_"U"
 .. I $P($G(^PRC(444,PRCDA,8,I,0)),"^",4)>^TMP($J,"RFQ","QUOTE DUE") S FLAG=FLAG_$S(FLAG]"":",",1:"")_"DT"
 .. I ^TMP($J,"RFQ","SET ASIDE"),SIZE'="SMALL" S FLAG=FLAG_$S(FLAG]"":",",1:"")_"S"
 .. I $P($G(^PRC(444,PRCDA,8,I,3,0)),"^",4)'=^TMP($J,"RFQ","NBR ITEMS") S FLAG=FLAG_$S(FLAG]"":",",1:"")_"LI"
 .. I $P($G(^PRC(444,PRCDA,8,I,3,J,1)),"^",6)]""!($P($G(^PRC(444,PRCDA,8,I,0)),"^",7)]"") S FLAG=FLAG_$S(FLAG]"":",",1:"")_"C"
 .. S X=$G(^PRC(444,PRCDA,8,I,3,J,0))
 .. I $P(X,"^",9)'=$G(^TMP($J,"RFQ","ITEM",ITEM,"MFG PART")) S FLAG=FLAG_$S(FLAG]"":",",1:"")_"M"
 .. I $P(X,"^",4)]"" S FLAG=FLAG_$S(FLAG]"":",",1:"")_"V"
 .. I $P(X,"^",6)'=$G(^TMP($J,"RFQ","ITEM",ITEM,"NSN")) S FLAG=FLAG_$S(FLAG]"":",",1:"")_"NSN"
 .. I $P(X,"^",8)'=$G(^TMP($J,"RFQ","ITEM",ITEM,"NDC")) S FLAG=FLAG_$S(FLAG]"":",",1:"")_"NDC"
 ..S ^TMP($J,"PRT",ITEM,+COST,VEN,I)=VEN_"^"_SIZE_"^"_QTY_"^"_UOP_"^"_UPRICE_"^"_FOB_"^"_$G(VENDOR(JJ))_"^"_(+COST)_"^"_FLAG
 S L=0
 F  S L=$O(^PRC(444,PRCDA,2,L)) Q:+L'=L  D
 . S ITEM=$P($G(^PRC(444,PRCDA,2,L,0)),U) Q:ITEM=""  S PPRICE=$P($G(^PRC(444,PRCDA,2,L,1)),"^",5) S:PPRICE'="" SUB(ITEM)=PPRICE
 QUIT
RFQLOAD ;Load RFQ information to compare with quote
 K ^TMP($J,"RFQ") N X,L
 S ^TMP($J,"RFQ","FOB")=$P($G(^PRC(444,PRCDA,1)),"^")
 S ^TMP($J,"RFQ","QUOTE DUE")=$P($G(^PRC(444,PRCDA,0)),"^",3)
 S ^TMP($J,"RFQ","SET ASIDE")=$P($G(^PRC(444,PRCDA,1)),"^",7)
 S ^TMP($J,"RFQ","NBR ITEMS")=$P($G(^PRC(444,PRCDA,2,0)),"^",4)
 S I=0
 F  S I=$O(^PRC(444,PRCDA,2,I)) Q:+I'=I  D
 . S X=$G(^PRC(444,PRCDA,2,I,0)) Q:X=""
 . S L=$P(X,"^")
 . S ^TMP($J,"RFQ","ITEM",L,"QUANTITY")=$P(X,"^",2)
 . S ^TMP($J,"RFQ","ITEM",L,"UNIT")=$S($P(X,"^",3)]"":$P($G(^PRCD(420.5,$P(X,"^",3),0)),"^",2),1:"")
 . S ^TMP($J,"RFQ","ITEM",L,"NSN")=$P(X,"^",6)
 . S ^TMP($J,"RFQ","ITEM",L,"NDC")=$P(X,"^",8)
 . S ^TMP($J,"RFQ","ITEM",L,"MFG PART")=$P(X,"^",9)
 Q
