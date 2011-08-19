PRCH0A ;WISC/PLT-UTILITY FOR PRCH-ROUTINE ;6/28/96  09:07
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;called from menu (purchase card menu)
EN ;Count reconciliation record
 N PRCA,PRCB
 N A,B,C,D,X,Y
 S A=$$RECCT(DUZ) I A W !,"You have ",+A," charge(s) to be reconciled for statement ("_$P(A,"^",2)_" - "_$P(A,"^",3)_")."
 S PRCA=0 F  S PRCA=$O(^PRC(440.5,"MAAH",DUZ,PRCA)) QUIT:'PRCA  I PRCA-DUZ S A=$$APPCT(PRCA) W:A !,"You have ",A," order(s) to approve for ",$P(^VA(200,PRCA,0),U),"."
 QUIT
 ;
RECCT(PRCA) ;prca = user ri, ef value: ^1=count reconcile records by user, ^2=earliest statement date, ^3=latest statement date (fm date)
 N A,B,C,D
 S A=0,B=0,C="",D="" F  S B=$O(^PRCH(440.6,"ST","N"_PRCA_"~",B)) QUIT:'B  S A=A+1,D=$P($G(^PRCH(440.6,B,0)),"^",6) S:C="" C=$P($G(^PRCH(440.6,B,0)),"^",6)
 QUIT A_"^"_($E(C,4,5)_"/"_$E(C,6,7)_"/"_$E(C,2,3))_"^"_($E(D,4,5)_"/"_$E(D,6,7)_"/"_$E(D,2,3))
 ;
APPCT(PRCA) ;prca = user ri, count ready approved order by user
 N A,B,C
 S A=0,B=0 F  S B=$O(^PRC(442,"MAPP",PRCA_"~",B)) QUIT:'B  S C=$P(^PRC(442,B,23),"^",8) I C,$P(^PRC(440.5,C,0),"^",10)=DUZ!($P(^PRC(440.5,C,0),"^",9)=DUZ) S A=A+1
 QUIT A
 ;
 ;prca =^1 RI of file 440.6, ^2=Fileman date, prcb = ri of file 442
DD(PRCA,PRCB) ;ef value =  ~1 dd1 segment, ~2 dd2 segment of ET
 N PRCRI,PRCDD1,PRCDD2,PRCC,PRCD
 N A,B,C
 S PRCRI(442)=PRCB
 S PRCRI(440.6)=+PRCA,PRCC=$P(^PRCH(440.6,PRCRI(440.6),0),"^",1),PRCD=$G(^(5)),PRCRI(411)=+$P(^(0),"^",8)
 S PRCDD1="DD1^ET",$P(PRCDD1,"^",3)=$E(PRCC,2,12),$P(PRCDD1,"^",4)=$E($P(PRCD,"^",5),1,4)
 S A=$P(PRCDD1,"^",3),A=$E(A,1,3)_$TR($E(A,4,7),"1234567890","ABCDEFGHIJ")_$E(A,8,11),$P(PRCDD1,"^",3)=A
 S B=0 L +^PRC(411,PRCRI(411),60):99 I  S B=$G(^PRC(411,PRCRI(411),60))+1 S:B=1 B=1000+1 S $P(^(60),"^")=B L -^PRC(411,PRCRI(411),60)
 S $P(PRCDD1,"^",3)=$E(A,1,7)_$E(B#10000+10000,2,999)
 S PRCDD2="DD2",A=$P(PRCA,"^",2),$P(PRCDD2,"^",2,4)=$E(A,4,5)_"^"_$E(A,6,7)_"^"_$E(A,2,3)
 S $P(PRCDD2,"^",9)=$$EM(PRCC)
 S A="" S:PRCRI(411) A=$P($G(^PRC(411,PRCRI(411),9)),"^",5,6)
 S $P(PRCDD2,"^",14)=$E($P(A,"^"),1,9),$P(PRCDD2,"^",15)=$E($P(A,"^",2),1,2)
 S $P(PRCDD2,"^",16)="0.00",$P(PRCDD2,"^",19)=$P(PRCDD1,"^",3)
 QUIT PRCDD1_"~"_PRCDD2
 ;
 ;prca data ^1= ri of 440.6
DDA4406(PRCA) ;ev-value dda-segment (see et-dda doc)
 N PRCDDA,PRCRI,PRCB,PRCC,PRCREQ
 N A,B,C
 S PRCDDA="DDA",PRCRI(440.6)=+PRCA
 S A=^PRCH(440.6,PRCRI(440.6),0),B=^PRCH(440.6,PRCRI(440.6),5)
 S C=$$DATE^PRC0C($P(A,"^",11),"I"),C=$$FUND^PRC0C($P(B,"^"),+C)
 D DOCREQ^PRC0C(+C,"SPE","PRCREQ")
 D PIECE("01",12,2),PIECE($E($$DATE^PRC0C($P(A,"^",11),"I"),3,4),13,2)
 I $P(A,"^",11)'=$P(A,"^",12) D PIECE($E($$DATE^PRC0C($P(A,"^",12),"I"),3,4),14,2)
 D PIECE($P(B,"^"),15,6),PIECE($P(A,"^",8),16,7)
 D PIECE($S($G(PRCREQ("CC"))'="N":$P(B,"^",3),1:""),18,7)
 D:$P(PRCDDA,"^",18)]"" PIECE("00",19,2) D PIECE($P(B,"^",2),20,9),PIECE($P(B,"^",4),21,4)
 S C=$P(A,"^",14)  D PIECE(C,33,15)
 QUIT PRCDDA
 ;
 ;prca data ^1= ri of 442
DDA442(PRCA) ;ev-value dda-segment (see et-dda doc)
 N PRCDDA,PRCACC,PRCRI,PRCB,PRCC,PRCREQ
 N A,B,C
 S PRCDDA="DDA",PRCRI(442)=+PRCA
 S PRCB=^PRC(442,PRCRI(442),0),PRCC=$G(^(23)),B=$$DATE^PRC0C($P(^(1),"^",15),"I"),C=$$DATE^PRC0C($P(PRCC,"^",2),"I")
 S PRCACC=$$ACC^PRC0C(+PRCB,+$P(PRCB,"^",3)_"^"_$E(B,3,4)_"^"_+C)
 S A=$$FUND^PRC0C($P(PRCACC,"^",5),$P(PRCACC,"^",6))
 D DOCREQ^PRC0C(+A,"SPE","PRCREQ")
 D PIECE("01",12,2),PIECE($E($P(PRCACC,"^",6),3,4),13,2)
 I $P(PRCACC,"^",6)'=$P(PRCACC,"^",7) D PIECE($E($P(PRCACC,"^",7),3,4),14,2)
 D PIECE($P(PRCACC,"^",5),15,6),PIECE($P(PRCB,"-"),16,7)
 ;I $P(PRCC,"^",7)>99999 S A=$G(^PRC(411,$P(PRCC,"^",7),0)) D PIECE($E(A,4,5),17,2)  ;substation not in oracle record
 D PIECE($S($G(PRCREQ("CC"))'="N":$P($P(PRCB,"^",5)," "),1:""),18,7)
 D:$P(PRCDDA,"^",18)]"" PIECE("00",19,2) D PIECE($P(PRCACC,"^",3),20,9)
 S A=$O(^PRC(442,PRCRI(442),2,0)) I A S B=^PRC(442,PRCRI(442),2,A,0) D PIECE($P(B,"^",4),21,4)
 D PIECE($P(PRCACC,"^",10),22,8)
 S C=$P(PRCB,"^",16)  D PIECE($J(C,0,2),33,15)
 QUIT PRCDDA
 ;
PIECE(A,B,C) ;set piece in variable PRCDDA, A-VALUE, B-PPECE #, C-LENGTH
 S $P(PRCDDA,"^",B)=$E(A,1,C)
 QUIT
 ;
EM(PRCA) ;ef valaue = E if original, M if modification; PRCA is cc-doc id
 ;N A,B,C
 ;S PRCA=$E(PRCA,1,12),C="E"
 ;S A=PRCA F  S A=$O(^PRCH(440.6,"B",A)) QUIT:$E(A,1,12)'=PRCA!(A="")  D  QUIT:C="M"
 ;. S B=0 F  S B=$O(^PRCH(440.6,"B",A,B)) QUIT:'B  I $P(^PRCH(440.6,B,0),"^",18) S C="M" QUIT
 QUIT "E"
 ;
 ;prca = ri of file 442
FP(PRCA) ;ef value ^1 = if final pay, 0 if not, ^2=total payment, ^3=old p.o. status code
 N A,B,C,D,E
 S (A,B)=0,(C,D,E)=""
 F  S B=$O(^PRCH(440.6,"PO",PRCA,B)) QUIT:'B  S C=C+$P(^PRCH(440.6,B,0),"^",14),D=$P(^(0),"^",20) S:$P($G(^(1)),"^",4)="Y" A=1 S:E="" E=$P($G(^(6)),"^")
 QUIT A_"^"_C_"^"_D_"^"_E
 ;
 ;A=number for check, B=1 (optional) if number with check digit, 0 if not
LUHN(A,B) ;ef value ^1=1 if check digit is true, 0 if false, ^2=check digit
 N C,D,E,F
 S:'$D(B) B=1
 S D=1,E=0 F C=$L(A)-B:-1:1 S F=D#2+1*$E(A,C),D=D+1,E=F\10+(F#10)+E ;W !,A,"  ",B,"   ",C,"    ",D,"    ",E,"    ",F
 S E=E+10\10*10-E#10
 QUIT $S(B=0:1,1:$E(A,$L(A))=E)_"^"_E
 ;A=charge card number
CCN(A) ;ef = "*" if invalid charge card number
 QUIT $S($$LUHN(A)<1!(A'?16N):"*",1:"")
 ;A=replaced charge card number
CCNR(A) ;ef = "*" if replaced charge card number is on in file
 QUIT $S(A="":"",$D(^PRC(440.5,"B",A)):"",1:"*")
 ;site # in file 420
ST(A) ;ef = "*" if STATION # not in file, = "" if defined
 I A="" QUIT "*"
 QUIT $S($D(^PRC(420,A,0)):"",1:"*")
 ;
 ;A = replaced purchase card #, B =station #
STR(A,B) ;ef value = "#" if replaced card station # not equal B, else = nil
 N C
 QUIT:A="" ""
 S C=$O(^PRC(440.5,"B",A,0)) I C="" QUIT ""
 S C=$G(^PRC(440.5,C,2))
 QUIT $S(+$P(C,"^",3)=+B:"",1:"#")
 ;A=fund code 
FC(A) ;ef = "*" if FUND CODE not in file, ="" if defined
 I A="" QUIT "*"
 QUIT $S($O(^PRCD(420.3,"B",A,0)):"",1:"*")
 ;A=replaced purchase card #, B = fund code
FCR(A,B) ;ef= "#" if replaced card fund code is different B, else =nil
 N C,D,E
 QUIT:A="" ""
 S C=$O(^PRC(440.5,"B",A,0)) I C="" QUIT ""
 S D=$G(^PRC(440.5,C,50)),D=$P(C,"^",5),D=$TR(D,"*#")
 I D]"" QUIT $S(D=B:"",1:"#")
 S E=+$P($G(^PRC(440.5,C,2)),"^",3),C=$G(^PRC(440.5,C,0))
 S D=$G(^PRC(420,+E,1,+$P(C,"^",2),5))
 QUIT $S(B=$P(D,"^"):"",1:"#")
 ;A = acc code
ACC(A) ;ef = "*" if acc not in file, = "" if defined
 I A="" QUIT "*"
 QUIT $S($O(^PRCD(420.131,"B",A,0)):"",1:"*")
 ;A=replaced purchase card #, B = acc code
ACCR(A,B) ;ef= "#" if replaced card ACCcode is different B, else =nil
 N C,D,E
 QUIT:A="" ""
 S C=$O(^PRC(440.5,"B",A,0)) I C="" QUIT ""
 S D=$G(^PRC(440.5,C,50)),D=$P(C,"^",6),D=$TR(D,"*#")
 I D]"" QUIT $S(D=B:"",1:"#")
 S E=+$P($G(^PRC(440.5,C,2)),"^",3),C=$G(^PRC(440.5,C,0))
 S D=$G(^PRC(420,+E,1,+$P(C,"^",2),5)),D=+$P(D,"^",3)
 QUIT $S(B=$P($G(^PRCD(420.131,D,0)),"^"):"",1:"#")
 ;A= cost center code
CC(A) ;ef = "*" if cost center not in file, ="" if defined
 I A="" QUIT "*"
 QUIT $S($D(^PRCD(420.1,A,0)):"",1:"*")
 ;A = replaced purchase card #, B = new purchase card cost center
CCR(A,B) ;ef value="#"  if replaced card cc not equal B, else= nil
 N C
 QUIT:A="" ""
 S C=$O(^PRC(440.5,"B",A,0)) I C="" QUIT ""
 S C=$G(^PRC(440.5,C,0))
 QUIT $S($P($P(C,"^",3)," ")=B:"",1:"#")
 ;A = BOC code in file 420.2, B (optional) = cost center in file 420.1
BOC(A,B) ;ef = "*" if boc not in file, ="" if defined
 I A="" QUIT "*"
 I '$D(B) QUIT $S($D(^PRCD(420.2,A,0)):"",1:"*")
 I $G(B)="" QUIT "*"
 QUIT $S($D(^PRCD(420.1,B,1,A,0)):"",1:"*")
 ;A = replaced purchase card #, B =budget object class
BOCR(A,B) ;ef value = "#" if replaced card boc not equal B, else = nil
 N C
 QUIT:A="" ""
 S C=$O(^PRC(440.5,"B",A,0)) I C="" QUIT ""
 S C=$G(^PRC(440.5,C,0))
 QUIT $S($P($P(C,"^",4)," ")=B:"",1:"#")
 ;A=user #, B=station #, C=fcp #
UFCP(A,B,C) ;ef value = "#" if user code is not in fcp, else = nil
 QUIT $S($D(^PRC(420,"C",A,+B,+C)):"",1:"#")
 ;A=file #, B=field #, X=external value for vlidating
FFVV(A,B,X) ;ef= ^1=1 if valid, else =0,  ^2=internal value if valid
 X $P(^DD(A,B,0),"^",5,999)
 QUIT $G(X)]""_"^"_$G(X)
