PRC0D ;WISC/PLT-IFCAP UTILITY ; 04/14/94  1:21 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;A=station #,B=acc^prc0c string
FMSACC(A,B) ;EF - value=field .01 of rile 420.141
 ;~1=station 3, ~2=bbbfy, ~3=fund code, ~4=a/o, ~5=program,
 ;~6=fcp/prj, ~7=object clas, ~8=job #
 N C
 S C=A,$P(C,"~",2)=$P(B,"^",6),$P(C,"~",3)=$P(B,"^",5)
 S $P(C,"~",4)=$P(B,"^"),$P(C,"~",5)=$P(B,"^",2),$P(C,"~",6)=$P(B,"^",3)
 S $P(C,"~",7)=$P(B,"^",4),$P(C,"~",8)=$P(B,"^",10)
 QUIT C
 ;
 ;A=station, B=fcp#, C=fy, D=1 if obligate balance, 2 if comm, 3 if scp comm
 ;return value data ^1=1st qtr bal, ^2=2nd, ^3=3rd, ^4=4th
FCPBAL(A,B,C,D) ;EF get fcp balance
 S A=$G(^PRC(420,+A,1,+B,4,C,$S(D=3:1,1:0)))
 Q $S(D=1:$P(A,"^",6,9),1:$P(A,"^",2,5))
 ;
 ;A=station, B=fcp#
 ;return value 1=gpf, 2=supp, 3=casca/canteen
SFCP(A,B) ;EF get special control point code
 Q $P($G(^PRC(420,+A,1,+B,0)),"^",12)
 ;
 ;A is data, ^1=nil,^2=station #,^3=fcp#,^4=fy,^5=bbfy
FCPVAL(A) ;EF validate fcp, EF value=1 if invalid
 N PRCA,PRCB,B,C,Z
 D DOCREQ^PRC0C(A,"AB","PRCA"),DOCREQ^PRC0C(A,"SAB","PRCB")
 S Z=""
 S:'$P(PRCA,"^",9)!'$P(PRCA,"^",6) Z=1
 I 'Z F B=1:1:4 S C=$P("AO^PGM^FCPRJ^OC","^",B) S:$G(PRCA(C))="Y"!($G(PRCB(C))="Y")&($P(PRCA,"^",B)="")!($G(PRCA(C))="N"&($G(PRCB(C))="N")&($P(PRCA,"^",B)]"")) Z=1 QUIT:Z
 D:'Z
 . S C="" F B="SPE","REV","GL" S C=C_$$REQ^PRC0C($P(PRCA,"^",9),B,"JOB")
 . I C["Y",$P(PRCA,"^",10)="" S Z=1
 . I 'Z I C'["Y",$P(PRCA,"^",10)]"" S Z=1
 . QUIT
 QUIT Z
 ;
 ;A=station #, B data=^1 fcp1, ^2 fy, ^3 bbfy, ^4 fcp2
FCPTRF(A,B) ;EF compare fms accounts value =1 if allow transfer
 N C,D,Z
 S Z=""
 S C=$$ACC^PRC0C(A,$P(B,"^",1,3)),D=$$ACC^PRC0C(A,$P(B,"^",4)_"^"_$P(B,"^",2,3))
 S B=$P(C,"^",8),C=$$FMSACC(A,C),D=$$FMSACC(A,D)
 I $P(C,"~",1,5)=$P(D,"~",1,5) S Z=1
 E  I B="Y",$P(C,"~",1,4)=$P(D,"~",1,4) S Z=1
 QUIT Z
 ;
 ;A=fy, B=quarter
QTRDATE(A,B) ;EF value=$$DATE^PRC0C - the first date of the quarter
 S A=$$YEAR^PRC0C(A)-(B<2),B=$P("10~1~4~7","~",B)_"/1/"_A
 QUIT $$DATE^PRC0C(B,"E")
 ;
 ;A=station #, B=fcp#, C=1 if display available year
BBFY(A,B,C) ;EF value ~1=0-node of file 420.14, ~2=fcp bbfy, ~3=length of fund, ~4=default year
 N D,E,F,G,H,I,J
 S D=$G(^PRC(420,+A,1,+B,5)) I D="" QUIT ""
 S E=+$$DATE^PRC0C($P(D,"^",8),"I")
 S F=$$FUND^PRC0C($P(D,"^",1),E) I F="" QUIT ""
 S $P(F,"~",2)=E,G=$P(F,"^",5)-$P(F,"^",4)+1,$P(F,"~",3)=G
 S J=+$$DATE^PRC0C($H,"H")
 I G<2 D:C EN^DDIOL("Warning: Selected Fund Control Point has a single year fund with multi-appropriation set up.")
 F I=J:-1:J-G+1 Q:I-E#G=0
 S E=I,I="" F H=-3*G+E:G:3*G+E S I=I_H_"    " S:H'>J $P(F,"~",4)=H
 D:C EN^DDIOL("Enter a year in the following sequence of years.")
 D:C EN^DDIOL("..."_I_"...")
 QUIT F
