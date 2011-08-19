PRCB1C ;WISC/PLT-FMS documents Inquiry/Regenerate Rejected SA/ST/AT ; 08/16/95  1:45 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;FMS doc inquiry
 D EN^PRC0E("SA:Suballowance;ST:Suballowance Transfer;AT:Allowance Transfer^FMS Budget Document ID: ","D INQ^PRCB1C")
 QUIT
INQ ;dispaly dcocument data
 N A,B,PRCFC,PRCTX,PRCRI
 S PRCTX=$P(X,"^",2),PRCRI(2100.1)=$P(X,"^",4)
 S PRCFC=$TR($G(GECSDATA(2100.1,PRCRI(2100.1),26,"E")),"/","^")
 S $P(PRCFC,"^",6)=$FN($P(PRCFC,"^",6),"",2)
 D:PRCFC]""
 . S A=$$DT^PRC0B2(+PRCFC,"I"),$P(PRCFC,"^",1)=$P(A,"^",5)
 . D @("INQ"_PRCTX)
 QUIT
 ;
 ;
INQSA ;display SA
 F B=1,11,10,2:1:7,9 D EN^DDIOL($J($P("FMS Txn Date^Doc Year^Quarter^Station #^FCP #^$Amount^BBFY^^FMS Action^FY Acctg Per^FMS Acctg Per","^",B),13)_": "_$P(PRCFC,"^",B))
 QUIT
 ;
INQST ;dispaly ST
INQAT ;dispalt AT
 F B=1,11,10,2:1:8 D EN^DDIOL($J($P("FMS Txn Date^Doc Year^Quarter^Station #^From FCP #^$Amount^BBFY^To FCP#^^FY Acctg Per^FMS Acctg Per","^",B),13)_": "_$P(PRCFC,"^",B))
 QUIT
 ;
 ;PRCA data ^1=txn type;txn type...,^2=select document text, ^3=status
EN1 ;rejected FMS document process
 N PRC,PRCA,PRCRI,PRCID,PRCTX,PRCF,PRCFC,PRCLACT
 D EN^PRC0E("SA:Suballowance;ST:Suballowance Transfer;AT:Allowance Transfer^FMS Rejected Budget Document ID: ^~E~R~T~~","D INQ^PRCB1C,EN2^PRCB1C")
 QUIT
 ;
EN2 ;File process rejected fms doc
 N PRCRI,PRCTX,PRCID,PRCFC,PRCFDT,PRCFAC,PRCAP,PRCFP
 S PRCTX=$P(X,"^",2),PRCID=$P(X,"^",3),PRCRI(2100.1)=$P(X,"^",4)
 D EN^DDIOL(" ")
 D DATA^GECSSGET(PRCID,0)
 S PRCFC=GECSDATA(2100.1,PRCRI(2100.1),26,"E") K GECSDATA
 S PRCFDT=$P(PRCFC,"^"),PRCFAC=$P(PRCFC,"/",9)
Q11 S Y(1)="Enter a date you want to send documents to FMS in format: MM/DD/YY"
 S A=$$DT^PRC0B2("T","E"),A=$P(A,"^",5)
 D DT^PRC0A(.X,.Y,"FMS Transaction Date","",A)
 QUIT:Y=""!(Y["^")
 I Y#100=0 W "   Enter precise date!" G Q11
 S Y=$$DT^PRC0B2(Y,"I")
 W "    (",$P(Y,"^",5),")"
 S PRCFDT=+Y,PRCAP=$P($$DT^PRC0B2($E(Y,1,5)_"00","I"),"^",5)
Q115 S Y(1)="Enter a calender (not fiscal year) accounting period in format: MM/YY."
 S Y(2)="NOTE: a closed FMS accounting period will cause documents to be rejected."
 D DT^PRC0A(.X,.Y,"Accounting Period (MM/YY)","O",PRCAP)
 I X=""!(X["^") G Q11
 G:Y<0 Q115
 I Y#100'=0 W "    Enter nonth/year only!" G Q115
 S Y=$$DT^PRC0B2(Y,"I")
 W "    (",$P(Y,"^",5),")"
 S PRCFP=$P(Y,"^",5),X=$$DATE^PRC0C(+Y,"I"),PRCFP=$P(X,"^",9)_$E(X,3,4)_"/"_PRCFP
 G:PRCTX'="SA" Q13
Q12 ;D SC^PRC0A(.X,.Y,"Select FMS Action Code","B^A:Add New Suballowance;C:Inc/Dec Suballowance",PRCFAC)
 ;G Q11:Y=""!(Y["^")
 S Y="C"
 S PRCFAC=Y
Q13 K X,Y D YN^PRC0A(.X,.Y,"Ready To File Regenerated FMS Document","","NO")
 G:Y["^" Q11
 I Y=1 D
 . D:PRCFC]"" @PRCTX,EN^DDIOL("<Filed>")
 QUIT
 ;
EXIT K X,Y
 QUIT
 ;
SA I PRCFAC="A" D FMSSAL(PRCFC,-1)
 I PRCFAC="C" D FMSSAL(PRCFC,1)
 S $P(PRCFC,"/")=PRCFDT,PRCFC=$P(PRCFC,"/",1,8),$P(PRCFC,"/",9)=PRCFP
 D SA^PRCB8A(.X,$TR(PRCFC,"/","^"),PRCRI(2100.1)_"^"_$P(PRCID,"-",2,999))
 QUIT
 ;
ST S $P(PRCFC,"/")=PRCFDT,PRCFC=$P(PRCFC,"/",1,8),$P(PRCFC,"/",9)=PRCFP
 D ST^PRCB8A1(.X,$TR(PRCFC,"/","^"),PRCRI(2100.1)_"^"_$P(PRCID,"-",2,999))
 QUIT
 ;
AT S $P(PRCFC,"/")=PRCFDT,PRCFC=$P(PRCFC,"/",1,8),$P(PRCFC,"/",9)=PRCFP
 D AT^PRCB8A2(.X,$TR(PRCFC,"/","^"),PRCRI(2100.1)_"^"_$P(PRCID,"-",2,999))
 QUIT
 ;
 ;A=file 2100.1 ri, B=status
SAREJ(A,B) ;DCT process rejected sa subroutine
 N GECSDATA,PRCRI,PRCID,PRCFC,PRCDDT,PRCY,PRCQ,PRCSITE,PRCAMT,PRCY
 QUIT:B'="R"
 D DATA^GECSSGET(A,0) QUIT:'$G(GECSDATA)
 S PRCRI(2100.1)=GECSDATA,PRCID=GECSDATA(2100.1,PRCRI(2100.1),.01,"E")
 S PRCFC=GECSDATA(2100.1,PRCRI(2100.1),26,"E")
 K GECSDATA
 D:$P(PRCFC,"/",9)="A" FMSSAL(PRCFC,-1)
 QUIT
 ;
 ;PRCFC=SA document string, PRCA=1 if add, -1 if delete
FMSSAL(PRCFC,PRCA) ;add/delete entry in file 420.141
 N PRCRI,PRCQ,PRCSITE,PRCAMT,PRCY,PRCF
 N A,B
 S PRCFC=$TR($P(PRCFC,"/",1,8),"/","^")
 S PRCY=$P(PRCFC,"^",2),PRCQ=$P(PRCFC,"^",3)
 S PRCSITE=+$P(PRCFC,"^",4),PRCRI(420.01)=+$P(PRCFC,"^",5),PRCAMT=$P(PRCFC,"^",6)
 S PRCY=$$YEAR^PRC0C(PRCY)
 S PRCF=$$ACC^PRC0C(PRCSITE,PRCRI(420.01)_"^"_$E(PRCY,3,4)_"^"_$P(PRCFC,"^",7))
 S A=$$FMSACC^PRC0D(PRCSITE,PRCF)
 S B=$$FIRST^PRC0B1("^PRCD(420.141,""B"","""_A_""",",0)
 I PRCA=-1,B D DELETE^PRC0B1(.X,";^PRCD(420.141,;"_B)
 I PRCA=1,'B S B=$$A420D141^PRC0F(A,PRCRI(420.01))
 QUIT
 ;
