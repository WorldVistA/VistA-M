PRC0G ;WISC/PLT-IFCAP UTILITY ; 02/19/96  3:37 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;prca data ^1=station #, ^2=fcp code,
 ;          ^3=year (yyyy) or (yy optional for fiscal year only),
 ;          ^4=F if fiscal year, else bbfy year
QTRDT(PRCA) ;ef - ^1=first qtr date, ^2=last qtr date, ^3=oldest open qtr date for this bbfy & ebfy
 ;     ^4=true if revolving fund, ^5=todays qtr date
 N PRCRI,PRCB,PRCC
 N A,B,C,D,E,X,Y
 S (A,B,C,D,E)=""
 I $P(PRCA,"^",4)="F" S $P(PRCA,"^",3)=$$BBFY^PRCSUT($P(PRCA,"^",1),$P(PRCA,"^",3),$P(PRCA,"^",2),1)
 S PRCB=$$ACC^PRC0C(+PRCA,$P(PRCA,"^",2)_"^"_$E($P(PRCA,"^",3),1,2)_"^"_$P(PRCA,"^",3))
 I $P(PRCB,"^",5)]"" S D=$O(^PRCD(420.3,"B",$P(PRCB,"^",5),"")) I D S D=$P($G(^PRCD(420.3,D,0)),"^",8)="Y" S:D $P(PRCB,"^",7)=2099
 I $P(PRCB,"^",6) S A=$P($$QTRDATE^PRC0D($P(PRCB,"^",6),1),"^",7),B=$P($$QTRDATE^PRC0D($P(PRCB,"^",7),4),"^",7)
 S C=$P($G(^PRC(420,+PRCA,0)),"^",9)
 S C=$S(C<A:A,B<C:B,1:C)
 S E=$$DATE^PRC0C(+$H,"H"),E=$P($$QTRDATE^PRC0D(+E,$P(E,"^",2)),"^",7)
 QUIT A_"^"_B_"^"_C_"^"_D_"^"_E
 ;
 ;prca data ^1=ri of file 410, ^2=quarter beginning date (FM DATE)
E410(PRCA) ;edit running balance quarter date field 449
 N X
 D EDIT^PRC0B(.X,"410;^PRCS(410,;"_$P(PRCA,"^"),"449////"_$P(PRCA,"^",2),"LS")
 QUIT
 ;
 ;prca data ^1=ri of file 410, ^2=status code E, A, O, or C.
ERS410(PRCA) ;edit running balance status field 450, and rb quarter date field 449 if nil
 N A,B,C,D,X,Y
 S A=$G(^PRCS(410,+PRCA,0)) QUIT:A=""
 S B=""
 I $P(A,"^",11)="" D
 . S B=$G(^PRCS(410,+PRCA,3)),B=$P(B,"^",11)
 . S B=$S(B="":$P(A,"-",2)_"^F",1:+$$DATE^PRC0C(B,"I"))
 . S C=$$QTRDT($P(A,"-",1)_"^"_$P(A,"-",4)_"^"_B)
 . S D=$$QTRDATE^PRC0D($P(A,"-",2),$P(A,"-",3)),D=$P(D,"^",7)
 . S B=$S(D<$P(C,"^",3):$P(C,"^",3),$P(C,"^",2)<D:$P(C,"^",2),1:D)
 . S B="449////"_B_";"
 . QUIT
 I $P(PRCA,"^",2)]"" S B=B_"450////"_$P(PRCA,"^",2)
 I B]"" D EDIT^PRC0B(.X,"410;^PRCS(410,;"_$P(PRCA,"^"),B,"LS")
 QUIT
 ;
 ;prca data ^1=station #, ^2=running balance quarter date (fileman date)
 ;prcb = obligation, p.o. or amendment date (fileman date)
OBDT(PRCA,PRCB) ;ef value = true if rb qtr date and obl/p.o./amend are compatible
 N A,B,C
 S A=$$DATE^PRC0C(PRCB,"I"),A=$P($$QTRDATE^PRC0D(+A,$P(A,"^",2)),"^",7)
 S B=$P($G(^PRC(420,+PRCA,0)),"^",9)
 S C=$S($P(PRCA,"^",2)'>B:B,1:$P(PRCA,"^",2))
 QUIT A=C
 ;
 ;A data ^1=station #, ^2=fiscal year, ^3=quarter year, ^4=fcp code
 ;       ^5=BBFY
RBDT(A) ;ef=runing balance (quarter) date
 N B,C,D
 S C=$$QTRDT($P(A,"^",1)_"^"_$P(A,"^",4)_"^"_$S($P(A,"^",5):$P(A,"^",5),1:$P(A,"^",2)_"^F"))
 S D=$$QTRDATE^PRC0D($P(A,"^",2),$P(A,"^",3)),D=$P(D,"^",7)
 S B=$S(D<$P(C,"^",3):$P(C,"^",3),$P(C,"^",2)<D:$P(C,"^",2),1:D)
 QUIT B
