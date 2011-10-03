PRCH1C ;WISC/PLT-FMS documents Inquiry/Regenerate Rejected ET ; 08/16/95  1:45 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;FMS doc inquiry
 D EN^PRC0E("ET:Expenditure Transfer^FMS ET Document ID: ","D INQ^PRCH1C")
 QUIT
INQ ;dispaly dcocument data
 N A,B,PRCFC,PRCTX,PRCRI,PRCIDL
 S PRCTX=$P(X,"^",2),PRCRI(2100.1)=$P(X,"^",4)
 S PRCFC=$TR($G(GECSDATA(2100.1,PRCRI(2100.1),26,"E")),"/","^")
 S PRCRI(440.6)=+PRCFC,PRCRI(442)=$P(PRCFC,"^",2),PRCDI=$P(PRCFC,"^",3),PRCBOC=$P(PRCFC,"^",4)
 S PRCIDL=$P(^PRCH(440.6,PRCRI(440.6),0),"^")
 S PRCB(1)=$$DDA4406^PRCH0A(PRCRI(440.6)),PRCB(2)=$$DDA442^PRCH0A(PRCRI(442))
 S $P(PRCB(2),"^",21)=PRCBOC
 S $P(PRCB(2),"^",33)=$P(PRCB(1),"^",33)
 S $P(PRCB(1),"^",40)=$E(PRCIDL,13,15),$P(PRCB(2),"^",40)=$E(PRCIDL,13,15)+500
 F A=1,2 S $P(PRCB(A),"^",34)=$E("DI",A)
 I PRCDI=2 F A=1,2 S $P(PRCB(A),"^",34)=$E("ID",A)
 I $P(PRCB(1),"^",33)<0 S A=$P(PRCB(1),"^",34),$P(PRCB(1),"^",34)=$P(PRCB(2),"^",34),$P(PRCB(2),"^",34)=A F A=1,2 S $P(PRCB(A),"^",33)=$E($P(PRCB(A),"^",33),2,999)
 I $P(PRCB(1),"^",34)="I" S A=PRCB(1),PRCB(1)=PRCB(2),PRCB(2)=A
 D:PRCFC]""
 . D @("INQ"_PRCTX)
 QUIT
 ;
INQET ;display ET
 W !,"Description",?25,"Line #",$P(PRCB(1),"^",40),?45,"Line #",$P(PRCB(2),"^",40)
 F B=13:1:21,23 W !,$J($P("BBFY^BBEY^FUND^STATION^SUB STATION^COST CENTER^SUB COST CENTER^FCP/PRJ^BOC^^JOB NO","^",B-12),15),": ",?25,$P(PRCB(1),"^",B),?45,$P(PRCB(2),"^",B)
 F B=33,34 W !,$J($P("LINE AMOUNT^LINE ACTION","^",B-32),15),": ",?25,$P(PRCB(1),"^",B),?45,$P(PRCB(2),"^",B)
 W !,"PURCHASE CARD ORDER: ",$P(^PRC(442,PRCRI(442),0),"^")
 QUIT
 ;
 ;
 ;PRCA data ^1=txn type;txn type...,^2=select document text, ^3=status
EN1 ;rejected FMS document process
 N PRC,PRCA,PRCRI,PRCID,PRCTX,PRCF,PRCFC,PRCLACT,PRCDI,PRCBOC
 D EN^PRC0E("ET:Expenditure Transfer^FMS Rejected Budget Document ID: ^~E~R~T~~","D INQ^PRCH1C,EN2^PRCH1C")
 QUIT
 ;
EN2 ;File process rejected fms doc
 N PRCRI,PRCTX,PRCID,PRCFC,PRCFDT,PRCFAC,PRCAP,PRCFP
 S PRCTX=$P(X,"^",2),PRCID=$P(X,"^",3),PRCRI(2100.1)=$P(X,"^",4)
 D EN^DDIOL(" ")
 D DATA^GECSSGET(PRCID,0)
 S PRCFC=GECSDATA(2100.1,PRCRI(2100.1),26,"E") K GECSDATA
 S PRCRI(440.6)=+PRCFC,PRCRI(442)=$P(PRCFC,"/",2),PRCDI=$P(PRCFC,"/",3),PRCBOC=$P(PRCFC,"/",4)
 S PRCRI(420.1)=+$P(^PRC(442,PRCRI(442),0),"^",5)
 ;lookup boc
Q12  S A="420.1;^PRCD(420.1,;"_PRCRI(420.1)_";1~420.11;^PRCD(420.1,"_PRCRI(420.1)_",1,"
 ;S X("S")="I $P(^(0),U)>0"
 D LOOKUP^PRC0B(.X,.Y,A,"AEOQS","Select BOC: ")
 I Y<0!(X="") QUIT
 S PRCRI(420.2)=+Y
 S PRCBOC=$P(^PRCD(420.2,PRCRI(420.2),0)," ")
Q13 K X,Y D YN^PRC0A(.X,.Y,"Ready To Regenerate ET-FMS Document","","NO")
 I X["^"!'Y QUIT
 I Y=1 D
 . D:PRCFC]"" @PRCTX,EN^DDIOL("<Regenerated>")
 QUIT
 ;
EXIT K X,Y
 QUIT
 ;
ET S PRCFC=PRCRI(440.6)_"^"_PRCRI(442)_"^"_PRCDI_"^"_PRCBOC
 D ET^PRCH8A(.X,PRCFC,PRCRI(2100.1)_"^"_$P(PRCID,"-",2,999))
 QUIT
