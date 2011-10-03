PRCHQRP4 ;WISC/KMB-DISPLAY ABS/AGGREGATE QUOTE ;8/6/96  21:05
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;Entry point for aggregate report
 W @IOF S DIC="^PRC(444,",DIC("S")="I $P(^(0),""^"",8)>1"
 S DIC(0)="AEMQZ" D ^DIC K DIC I Y<0 K DTOUT,DUOUT,PRCDA,Y Q
 S PRCDA=+Y
 ;
 W ! S %ZIS="MQ" D ^%ZIS I POP K PRCDA,Y Q
 I $D(IO("Q")) S ZTRTN="PROCESS^PRCHQRP4",ZTSAVE("DUZ")="",ZTSAVE("PRCDA")="" D ^%ZTLOAD,^%ZISC K ZTSK G START
 D PROCESS,^%ZISC K PRCDA,Y G START
PROCESS ;
 N Q,Z1,ITEMNO,ID,I,J,K,L,VEN,ID,ITEMNO,P,STRING,VDUN,VNAME,VN,FOB,TOT,FILE
 N ZIP1,ZIP2,ZIP3,ZIP4,ZIP5,VENDOR,FLAG,PRCFLG,X,Y K ^TMP($J)
 S ZIP1=$P($G(^PRC(444,PRCDA,0)),"^"),ZIP2=$P($G(^(0)),"^",3),ZIP3=$P($G(^(8,0)),"^",4)
 S ZIP5=$P($G(^PRC(444,PRCDA,0)),"^",12) S:ZIP5'="" ZIP5=$P($G(^VA(200,ZIP5,0)),"^")
 S ZIP4=$P($G(^PRC(444,PRCDA,2,0)),"^",4)
 S Y=ZIP2 D DD^%DT S ZIP2=Y
 D VENDOR,RFQLOAD^PRCHQRP3,DETAIL,WRITE
 K PRCDA,^TMP($J) S:$D(ZTQUEUED) ZTREQ="@"
 QUIT
WRITE ;
 U IO S (P,Z1)=1 D HDR
 I '$D(STRING) W !,"No dollar totals were entered for vendor quotes",!
 S Q=""
 F  S Q=$O(STRING(Q)) Q:Q=""  D  Q:Z1[U
 . S J=""
 . F  S J=$O(STRING(Q,J)) Q:J=""  D  Q:Z1[U
 . . S K=""
 . . F  S K=$O(STRING(Q,J,K)) Q:K=""  D  Q:Z1[U
 . . . I IOSL-$Y<6 D HDR Q:Z1[U
 . . . W !,$P(STRING(Q,J,K),"^"),?20,$P(STRING(Q,J,K),"^",2),?25,$J($FN($P(STRING(Q,J,K),"^",3),"",2),10)
 . . . W ?40,$P(STRING(Q,J,K),"^",4),?47,$P(STRING(Q,J,K),"^",5),?56,$P(STRING(Q,J,K),"^",6)
 I Z1'[U,IOSL-$Y<14 R:$E(IOST,1,2)="C-"&'$D(ZTQUEUED) !,"Enter RETURN to continue or '^' to exit: ",Z1:DTIME W @IOF
 D:Z1'[U LEGEND
 I Z1'[U,$E(IOST,1,2)="C-",'$D(ZTQUEUED) R !,"Enter RETURN to continue ",Z1:DTIME
 QUIT
HDR ;
 I $E(IOST,1,2)="C-",P>1,'$D(ZTQUEUED) R !,"Enter RETURN to continue or '^' to exit: ",Z1:DTIME Q:Z1["^"
 W @IOF
 W !,"RFQ #",ZIP1,?70,"Page ",P,!,"Quotations Due Date: ",ZIP2,!,"Number of Quotes: ",ZIP3,!,"Number of Items on RFQ: ",ZIP4,!,"Point of Contact: ",ZIP5,!
 W !,?20,"#Items",?30,"Total",?47,"Total"
 W !,"Vendor",?20,"Quoted",?30,"Price",?40,"FOB",?47,"#Msgs.",?56,"Flags",!
 F I=1:1:8 W "----------"
 S P=P+1
 QUIT
DETAIL ;
 S I=0
 F  S I=$O(^PRC(444,PRCDA,8,I)) Q:+I'=I  D
 .S TOT=$P($G(^PRC(444,PRCDA,8,I,1)),"^",3) Q:+TOT=0
 .S FOB=$P($G(^PRC(444,PRCDA,8,I,1)),"^")
 .S J=0
 .F  S J=$O(^PRC(444,PRCDA,8,I,3,J)) Q:+J'=J  D
 . . S K=$G(^PRC(444,PRCDA,8,I,3,J,0)) Q:K=""
 . . I $P(K,"^",10)]"",$P(K,"^",10)'=$P(FOB,"/") S $P(FOB,"/",FOB]""+1)=$P(K,"^",10)
 .S VEN=$P($G(^PRC(444,PRCDA,8,I,0)),"^")
 .S VN=$P(VEN,";"),FILE=$P(VEN,";",2),VNAME="^"_FILE_VN_",0)"
 .S VDUN=0 S:FILE[440 VDUN=$P($G(^PRC(440,VN,7)),"^",12) S:FILE[444.1 VDUN=$P($G(^PRC(444.1,VN,0)),"^",2) S:VDUN="" VDUN=0
 .S VNAME=$P($G(@VNAME),"^") Q:VNAME=""  S VNAME=$E(VNAME,1,18)
 .S ITEMNO=$P($G(^PRC(444,PRCDA,8,I,3,0)),"^",4)
 .S STRING(TOT,VNAME,I)=VNAME_"^"_ITEMNO_"^"_TOT_"^"_FOB_"^"_$G(VENDOR(VDUN))
 . K PRCFLG
 . I FOB'=^TMP($J,"RFQ","FOB") S PRCFLG("FOB")=""
 . I $P($G(^PRC(444,PRCDA,8,I,0)),"^",4)>^TMP($J,"RFQ","QUOTE DUE") S PRCFLG("RECVD DATE")=""
 . I ^TMP($J,"RFQ","SET ASIDE") D
 . . I FILE[440,$P($G(^PRC(440,VN,2)),"^",3)='1 S PRCFLG("SIZE")=""
 . . I FILE[444.1,$P($G(^PRC(444.1,VN,0)),"^",5)'=1 S PRCFLG("SIZE")=""
 . I $P($G(^PRC(444,PRCDA,8,I,3,0)),"^",4)'=^TMP($J,"RFQ","NBR ITEMS") S PRCFLG("NBR")=""
 . I $P($G(^PRC(444,PRCDA,8,I,0)),"^",7)]"" S PRCFLG("CONTRACT")=""
 . S J=0
 . F  S J=$O(^PRC(444,PRCDA,8,I,3,J)) Q:+J'=J  D
 . . S X=$G(^PRC(444,PRCDA,8,I,3,J,0)) Q:X=""
 . . S L=$P(X,"^")
 . . I $P(X,"^",2)'=$G(^TMP($J,"RFQ","ITEM",L,"QUANTITY")) S PRCFLG("QUANTITY")=""
 . . S K=$S($P(X,"^",3)]"":$P($G(^PRCD(420.5,$P(X,"^",3),0)),"^",2),1:"")
 . . I K'=$G(^TMP($J,"RFQ","ITEM",L,"UNIT")) S PRCFLG("UNIT")=""
 . . I $P(X,"^",9)'=$G(^TMP($J,"RFQ","ITEM",L,"MFG PART")) S PRCFLG("MFG PART")=""
 . . I $P($G(^PRC(444,PRCDA,8,I,3,J,1)),"^",6)]"" S PRCFLG("CONTRACT")=""
 . . I $P(X,"^",4)]"" S PRCFLG("VENDOR PRODUCT #")=""
 . . I $P(X,"^",8)'=$G(^TMP($J,"RFQ","ITEM",L,"NDC")) S PRCFLG("NDC")=""
 . . I $P(X,"^",6)'=$G(^TMP($J,"RFQ","ITEM",L,"NSN")) S PRCFLG("NSN")=""
 . S FLAG=""
 . F J="FOB^F","QUANTITY^Q","UNIT^U","RECVD DATE^DT","SIZE^S","NBR^LI","CONTRACT^C","MFG PART^M","VENDOR PRODUCT #^V","NSN^NSN","NDC^NDC" I $D(PRCFLG($P(J,"^"))) S FLAG=FLAG_$S(FLAG]"":",",1:"")_$P(J,"^",2)
 . S $P(STRING(TOT,VNAME,I),"^",6)=FLAG
 QUIT
VENDOR ;     determine 864 messages for each vendor
 S J=0
 F  S J=$O(^PRC(444,PRCDA,7,J)) Q:+J'=J  D
 .S ID=$P($G(^PRC(444,PRCDA,7,J,0)),"^",3) Q:ID=""
 .S:'$D(VENDOR(ID)) VENDOR(ID)=0 S VENDOR(ID)=VENDOR(ID)+1
 QUIT
LEGEND ;Print Flags Legend at end of last page.
 W !!,?5,"Flags Legend:"
 W !,"F=FOB is Different from That Requested"
 W !,"Q=Quantity Quoted is Different from RFQ"
 W !,"U=Unit of Purchase is Different from RFQ"
 W !,"DT=Quote Received at Station after Date/Time Set for Receipt of Quotes"
 W !,"S=RFQ Set-Aside for Small Business But Size Status of Vendor is Large or Missing"
 W !,"LI=Number of Line Items Quoted Differs from Number of RFQ Line Items"
 W !,"C=Vendor Indicates Item(s) on Contract"
 W !,"M=Quoted Mfg. Part Number is Different from that Requested"
 W !,"V=Vendor has Quoted a Vendor Product Number"
 W !,"NSN=National Stock Number Quoted is Different from that Requested"
 W !,"NDC=National Drug Code is Different from that Requested"
 Q
