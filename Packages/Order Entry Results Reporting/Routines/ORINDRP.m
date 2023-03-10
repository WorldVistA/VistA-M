ORINDRP ;BIR/MA - Indication Usage Report ;Mar 30, 2022@08:09:34
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**405**;Dec 17, 1997;Build 211
 ;
 Q
EN ;
 N SEL,IYR,IDT,IQRT,CQRT,SDT,EDT,LATE,CMT,X,Y,SQRT,SYR,BMT,EMT,MEND,SDT,EDT,%DT
 D:'$D(DT) DT^DICRW
 S LATE=$E(DT,1,5)_"00"
 S IYR="",IYR=$$INSTALDT^XPDUTL("PSO*7.0*441",.IYR)
 I IYR S IDT=$P($O(IYR(0)),".")
 E  S IDT=DT
 S IYR=$E(IDT,1,3)+1700
 S IQRT=+$E(IDT,4,5),IQRT=$P("1^1^1^2^2^2^3^3^3^4^4^4","^",IQRT)
 S CQRT=+$E(DT,4,5),CQRT=$P("1^1^1^2^2^2^3^3^3^4^4^4","^",CQRT)
 S CMT=$E(DT,1,3)+1700
 W !!
 K DIR,DIRUT,DUOUT,DTOUT
 S DIR("A")="Select (M)ONTHLY, (Q)UARTERLY or (F)LEXIBLE REPORT: "
 S DIR(0)="SA^M:MONTHLY;Q:QUARTERLY;F:FLEXIBLE REPORT"
 D ^DIR K DIR I $D(DIRUT) K DIRUT,DUOUT,DTOUT Q
 S SEL=Y
 D @(Y_"EN")
 Q
QEN ;
 S BMT="01^04^07^10"
 S EMT="03^06^09^12"
 W !! S DIR("A")="Select Calendar Quarter",DIR(0)="SBO^1:Quarter 1 (Jan-Mar);2:Quarter 2 (Apr-Jun);3:Quarter 3 (Jul-Sep);4:Quarter 4 (Oct-Dec)"
 D ^DIR K DIR G:$D(DIRUT) EN
 S SQRT=Y
 S MEND=$S("23"[SQRT:30,1:31)
YR ;
 S (SYR,X)=$E(DT,1,3)+1700
 W !,"Select Calendar Year: ",X,"// " R X:DTIME
 I '$T!(X="^") G QEN
 S:X="" X=SYR
 I X'?4N W $C(7),!,"Enter a four digit calendar year (e.g. "_SYR_")",! G YR
 I X<IYR W $C(7),!!,"    No Data exist prior to "_$E(IDT,4,5)_"/"_IYR,! G YR
 I X>SYR W $C(7),!!,"    Year cannot be in the future",! G YR
 I SQRT<IQRT,X=IYR W $C(7),!!,"    No Data exist prior to Quarter "_IQRT_" of "_IYR,! G YR
 I SQRT>CQRT,X=SYR W $C(7),!!,"    Quarter cannot be in the future",! G YR
 S SYR=X-1700
 S BMT=$P(BMT,U,SQRT),EMT=$P(EMT,U,SQRT)
 S SDT=SYR_BMT_"00"
 S EDT=SYR_EMT_"99"
 G SOI
 ;
MEN ;
 W !!!,"**** Date Range Selection ****"
SDT ;
 W ! S %DT(0)=-DT,%DT="APEM",%DT("A")="Beginning MONTH/YEAR : " D ^%DT K %DT G:"^"[X!(Y<0) EN
 I $E(Y,1,5)<$E(IDT,1,5) W $C(7),!!,"    No Data exist prior to "_$E(IDT,4,5)_"/"_IYR,! G SDT
 S SDT=Y
EDT S %DT(0)=SDT W ! S %DT="APEM",%DT("A")="   Ending MONTH/YEAR : " D ^%DT K %DT
 G:"^"[X!(Y<0) EN G:(+$E(Y,6,7)'=0)!(+$E(Y,4,5)=0) EDT I Y>LATE W $C(7),!!,"    End of month cannot be in the future" G EDT
 S EDT=$E(Y,1,5)_"99"
 S MEND=$P("31^"_($$LEAP($E(EDT,1,3))+28)_"^31^30^31^30^31^31^30^31^30^31",U,$E(EDT,4,5))
 G SOI
 ;
FEN ;
SPR W ! S %DT(0)=IDT,%DT("A")="STARTING DATE: ",%DT="EXAP" D ^%DT G:"^"[X EN G:Y<0 SPR S (%DT(0),SDT)=Y
EPR W ! S %DT(0)=-DT,%DT("A")="ENDING DATE: ",%DT="EXAP" D ^%DT G:"^"[X EN G:Y<0 EPR S EDT=Y_".9999999" K %DT
SOI ;Allow selection of all/single/multiple Orderable item
 K DIR,DIRUT,DUOUT,DTOUT N ORALL,ORSEL
 S DIR(0)="Y",DIR("A")="Do you want ALL Orderable Items to appear on this report",DIR("B")="Y"
 S DIR("?")="Enter Yes to search for all Orderable Items. Enter No to select individual Orderable Item"
 D ^DIR K DIR G:$G(DIRUT) EN
 S ORALL=Y G:Y DQ
 F  D  Q:$D(DIRUT)
 .S DIR(0)="PO^101.43:AEQM",DIR("S")="I $P($G(^ORD(101.43,+Y,0)),""^"",2)[""PS"""
 .S DIR("A")="Select "_$S($D(ORSEL):"another ",1:"")_"Orderable Item"
 .S DIR("?")="Select Orderable Items to appear on report. Return when finished, ^ to stop processing"
 .D ^DIR Q:$D(DIRUT)  S ORSEL(+Y)=""
 K DIR I $D(ORSEL)'=10!($D(DUOUT))!($D(DTOUT)) G EN
 K DIRUT,DUOUT,DTOUT
DQ ;build and print
 W ! K %ZIS,IOP,POP S %ZIS="QM" D ^%ZIS G:POP EN
 I $D(IO("Q")) D  Q
 . K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK,ZTRTN,ZTDESC
 . N G S ZTRTN="RPT^ORINDRP",ZTDESC="Indication Usage Report"
 . F G="SDT","EDT","MEND","ORALL","SQRT" S:$D(@G) ZTSAVE(G)=""
 . S:$D(ORSEL) ZTSAVE("ORSEL(")=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
RPT ;
 U IO
 N ORDT,PKG,PG,ORQ,I,J,K,ORIEN
 S ORDT=SDT K ^TMP($J,"ORIND")
 F  S ORDT=$O(^OR(100,"AF",ORDT)) Q:'ORDT!(ORDT>EDT)  S ORIEN="" F  S ORIEN=$O(^OR(100,"AF",ORDT,ORIEN)) Q:'ORIEN  D:$D(^OR(100,ORIEN,4.5,"ID","INDICATION"))
 . Q:+$P($G(^OR(100,ORIEN,3)),"^",11)'=0  ;quit if order type not standard
 . S PKG=$$NMSP^ORCD($P($G(^OR(100,ORIEN,0)),"^",14)) Q:PKG'="PS"
 . S PKG=$P($G(^ORD(100.98,$P(^OR(100,ORIEN,0),U,11),0)),U,3) Q:PKG="SPLY"!(PKG="NV RX")
 . Q:$O(^OR(100,ORIEN,4.5,"ID","ORDERABLE",99),-1)>1  ;quit if multiple orderable item
 . I $O(^OR(100,"AF",ORDT,ORIEN,0))=1,$D(^OR(100,ORIEN,8,1,0)) D CHECK
 I '$D(^TMP($J,"ORIND")) W !!,"There is no data for the criteria you selected.",! G END
 S:+$E(SDT,6,7)=0 SDT=$E(SDT,1,5)_"01"
 S:+$E(EDT,6,7)=99 EDT=$E(EDT,1,5)_MEND
 S:$L(EDT,".")>1 EDT=$P(EDT,".")
 D PRINT
END ;
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J,"ORIND")
 Q
 ;
CHECK ;If order matches requirements then save
 N OI,OINM,ORUI,ORSI,POI,ND
 S PKG=$S(PKG="O RX":"OP",PKG="UD RX"!(PKG="C RX"):"IP",1:"IV")
 S J=$O(^OR(100,ORIEN,4.5,"ID","INDICATION",0)) Q:'J  Q:$P($G(^OR(100,ORIEN,4.5,J,0)),U,3)'=1  S ORUI=$G(^(1))
 S OI=0 S J=$O(^OR(100,ORIEN,4.5,"ID","ORDERABLE",0)) Q:'J  I $P($G(^OR(100,ORIEN,4.5,J,0)),U,3)=1 S OI=+$G(^(1)) D:OI
 . I 'ORALL,'$D(ORSEL(OI)) Q
 . S ND=$G(^ORD(101.43,OI,0)),POI=+$P(ND,U,2),OINM=$E($P(ND,U),1,30) Q:'POI
 . D INDCATN^PSS50P7(POI,"OROI")
 . D GIND
 . S ^TMP($J,"ORIND",OINM,PKG,ORSI)=$G(^TMP($J,"ORIND",OINM,PKG,ORSI))+1
 . S ^TMP($J,"ORIND",OINM,PKG,ORSI,ORUI)=$G(^TMP($J,"ORIND",OINM,PKG,ORSI,ORUI))+1
 . S ^TMP($J,"ORIND",OINM,PKG)=$G(^TMP($J,"ORIND",OINM,PKG))+1
 . S ^TMP($J,"ORIND",OINM)=POI
 Q
 ;
GIND ;
 I '$O(^TMP($J,"OROI",0)) S ORSI="FT" Q
 S (I,K)=0 F  S I=$O(^TMP($J,"OROI",I)) Q:'I!(K)  S ND=^(I) D
 . I $P(ND,U)=ORUI,$P(ND,U,2) S ORSI="MCI",K=1 Q
 . I $P(ND,U)=ORUI S ORSI="OTH",K=1 Q
 . S ORSI="FT"
 K ^TMP($J,"OROI")
 Q
 ;
PRINT ;
 N ORQ,TXT,ICT,CT,L,M,N,O,ARR,POI S ORQ=0
 D HDR
 S I="" F  S I=$O(^TMP($J,"ORIND",I)) Q:I=""!(ORQ)  S POI=+$G(^TMP($J,"ORIND",I)) W !,I_"("_POI_")" D
 . D SETAR
 . F J="OP","IP","IV" I $D(^TMP($J,"ORIND",I,J)) S CT=^(J) D  D PL Q:ORQ
 .. S TXT="   "_$S(J="OP":"Outpatient",J="IP":"Unit Dose",1:J) D
 ... K ARR F K="MCI","OTH","FT" I $D(^TMP($J,"ORIND",I,J,K)) S ICT=^(K) D
 .... S $E(TXT,$S(K="MCI":31,K="OTH":43,1:55))=ICT_" ("_$J(ICT/CT*100,2,0)_"%)"
 .... S L="" F  S L=$O(^TMP($J,"ORIND",I,J,K,L)) Q:L=""  D
 ..... S ARR("A"_$S(K="MCI":"1",K="OTH":"2",1:"3"),L)=^TMP($J,"ORIND",I,J,K,L)
 ..... I $D(NOIND(K,L)) K NOIND(K,L)
 . I ORQ K NOIND Q
 . I $D(NOIND) D NUIND K NOIND
 . W !
 Q
 ;
SETAR ;
 K NOIND N ZI,ZND
 Q:'POI
 D INDCATN^PSS50P7(POI,"OROI")
 Q:'$O(^TMP($J,"OROI",0))
 S ZI=0 F  S ZI=$O(^TMP($J,"OROI",ZI)) Q:'ZI  S ZND=^(ZI) D
 . I $P(ZND,U)]"" S NOIND($S($P(ZND,U,2):"MCI",1:"OTH"),$P(ZND,U))=""
 K ^TMP($J,"OROI")
 Q
 ;
NUIND ;
 I $Y>(IOSL-4) D HDR Q:ORQ
 W !,"   These Indications were not used: "
 N ZI,ZY,ZJ
 S ZI="" F  S ZI=$O(NOIND(ZI)) Q:ZI=""  D
 . S ZJ="" W !,?5,$S(ZI="MCI":"Most Common",1:"Other Indic")
 . S ZY=0 F  S ZJ=$O(NOIND(ZI,ZJ)) Q:ZJ=""  S ZY=ZY+1 D
 .. I ZY=1 W ?18," - "_ZJ
 .. E  W !,?18," - "_ZJ
 Q
 ;
PL ;
 I $Y>(IOSL-4) D HDR Q:ORQ
 W !,TXT,?68,CT
 S M="" F  S M=$O(ARR(M)) Q:M=""!(ORQ)  W !,?5,$S(M="A1":"Most Common",M="A2":"Other Indic",1:"Free Text")_": " D
 . S N="",O=0 F  S O=O+1,N=$O(ARR(M,N)) Q:N=""  D  Q:ORQ
 .. W:O>1 ! W ?18,N,?68,$G(ARR(M,N))
 .. D:$Y>(IOSL-4) HDR
 Q
 ;
HDR ;
 S PG=$G(PG)+1
 I PG>1,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S ORQ=1 Q
 W @IOF,"CPRS Indication Usage Report For "_$S('ORALL:"Selected",1:"All")_" Orderable Items   "_$$FMTE^XLFDT(DT)_" PAGE "_PG
 W !,"Selected Date Range: ",$$FMTE^XLFDT(SDT)," to ",$$FMTE^XLFDT(EDT)_$S($G(SQRT):"  (Quarter "_SQRT_")",1:"")
 W !,"Orderable Item             Most Common  Other       Free Text     Total"
 W !,"                           Indications  Indications Indications"
 W !,"-------------------------------------------------------------------------"
 Q
 ;
LEAP(%) ;Check if a Leap year
 S:%<1700 %=%+1700
 Q (%#4=0)&'(%#100=0)!(%#400=0)
