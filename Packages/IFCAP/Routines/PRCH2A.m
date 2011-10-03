PRCH2A ;WISC/PLT-DAILY PURCHASE CARD CHARGES STATEMENT ; 6/28/99 3:18pm
V ;;5.1;IFCAP;**8,125**;Oct 20, 2000;Build 15
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;print daily purchase card charges statement
 N PRCA,PRCB,PRCDATE,PRCDATEF,PRCDATEE,PRCDUZ,PRCNAME
 N A,B,C
 S PRCDUZ=DUZ
Q1 ;statement from date
 S A=$$DATE^PRC0C($H-2,"H") D DT^PRC0A(.X,.Y,"For Credit Card Charge Statement Beginning Date: ","AO",$P(A,"^",4)_"/"_$P(A,"^",5)_"/"_$E($P(A,"^",3),3,4))
 I X["^"!(X="") G EXIT
 I $E(Y,6,7)<1 D EN^DDIOL("Date missing! Enter date format: MM/DD/YY") G Q1
 S PRCDATEF=Y
Q2 ;statement ending date
 S A=$$DATE^PRC0C(PRCDATEF,"I") D DT^PRC0A(.X,.Y,"For Credit Card Charge Statement Ending Date: ","AO",$P(A,"^",4)_"/"_$P(A,"^",5)_"/"_$E($P(A,"^",3),3,4))
 I X["^"!(X="") G Q1
 I $E(Y,6,7)<1 D EN^DDIOL("Date missing! Enter date format: MM/DD/YY") G Q2
 I Y<PRCDATEF D EN^DDIOL("The beginning and ending dates are not in order") G Q2
 S PRCDATEE=Y
 G:'$G(PRCOPT) START
Q3 ;select card holder
 S PRCDI="200;^VA(200,;"
 S X("S")="I Y-DUZ,$D(^PRC(440.5,""MAAH"",DUZ,+Y))"
 D LOOKUP^PRC0B(.X,.Y,PRCDI,"AEOQS","Select Purchase Card Holder: ")
 I Y<0!(X="") G Q1
 K X S PRCRI(200)=+Y,PRCDUZ=+Y
 ;
START N L,DIC,FLDS,BY,FR,TO,DHD
 S DIC="^PRCH(440.6,",L=0,BY="#STATEMENT DATE;C1,@STATION NUMBER,@INTERNAL(CARD HOLDER),+""XXXXXXXXXXXX""_$E(CREDIT CARD NUMBER;C1;S1;""CHARGE DATA for CREDIT CARD #: "",13,16)"
 S FR=PRCDATEF_",1,"_PRCDUZ_",0",TO=PRCDATEE_",9999,"_PRCDUZ_",~"
 S PRCNAME=$P(^VA(200,PRCDUZ,0),"^"),PRCDATE=$$MDY(PRCDATEF)_" - "_$$MDY(PRCDATEE)
 S DHD="E-Charge Statement for "_PRCNAME_"   Statement Date: "_PRCDATE
 S FLDS=".01;C1;S1;""Charge Id"",8;""PO Date"",31;L30;""Vendor"",20;C5;""P.O. #"",9;""TXN Ref"",&13;C60;R15;""Charge $AMT"",41;""IFCAP P.O. #"";C5;L16,6;""TXN DATE"",15;C50"
 D EN1^DIP G:$G(PRCOPT) Q3
EXIT QUIT
 ;
MDY(A) ;EV = MM/DD/YY
 QUIT $E(A,4,5)_"/"_$E(A,6,7)_"/"_$E(A,2,3)
 ;
EN1 ;from approving official menu
 N PRCOPT
 S PRCOPT=1
 G EN
 ;
EN2 ;from print unregistered card charges option
 S PRCOPT=2
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
 S DIC="^PRCH(440.6,",L=0
 S FLDS="3;""Credit Card #"";C1;N;L16,8;""PO Date"",31;L30;""Vendor"",20;C5;""P.O. #"",9;""TXN Ref"",&13;C60;R15;""Charge $AMT"",.01;C5;""Charge Id"",6;""TXN DATE"",15;C50"
 S DHD="Unregistered Credit Card Charges for Station #: "_PRC("SITE")
 S BY(0)="^PRCH(440.6,""ST"",""N~"","
 S L(0)=1
 S BY="3",FR="0",TO="99999999999999999999999"
 S DIS(0)="I $D(PRC(""SITE"")),$P(^PRCH(440.6,D0,0),""^"",8)=PRC(""SITE"")"
 D EN1^DIP
 QUIT
 ;
EN3 ;charge card reg exception option
 N PRC
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
 S DIC="^PRC(440.5,",L=0
 S FLDS="60;""Charge Card #"";C1;S1;N,59;""Exp. Date"";L15,51;""Replaced Card #"",52;C5;""Card Holder"";L30,7;C36;""IFCAP CARD HOLDER"";L25,63;L10;C62;""FCP #"",53;C5;""Station"";L8,61;C22;""S.P. Limit"";L15,62;""M.P. Limit"";L15"
 S FLDS(1)="55;C5;""Fund Code"";L15,56;""ACC Code"";L15,57;""Cost Center"";L15,58;""BOC"";L15"
 S DHD="Charge Card Reg. Exception List"
 S BY(0)="^PRC(440.5,""ST"","
 S L(0)=2
 S BY="@70,@.01",FR="E",TO="E"
 S DIOEND="I Y'[""^"" D EOR^PRCH2A"
 S:$D(ZTIO) IOP=ZTIO
 S DIS(0)="I $D(PRC(""SITE"")),($P($G(^PRC(440.5,D0,2)),""^"",3)=PRC(""SITE"")!($P($G(^PRC(440.5,D0,50)),""^"",3)=PRC(""SITE"")))"
 D EN1^DIP
 QUIT
EOR W !!,"* - Invalid data, it must be corrected by the charge card company.",!,"# - New charge card data may not match the old one.",!!,"END OF REPORT"
 I $E(IOST,1,2)="C-",'$D(ZTQUEUED) D EOP^PRC0A(.X,.Y,"Enter return to continue","","")
 QUIT
