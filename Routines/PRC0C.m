PRC0C ;WISC/PLT-UTILITY (2) ; 1/23/98  1200 
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ; invalid entry
 ;
 ;extrinsic function for fms document required fields
 ;A is ^1=record id of file 420.14 (option)
 ;     ^2=station #, ^3=fund control pt #,
 ;     ^4=(document) fiscal year, ^5=beginning budget fiscal year
 ;B=fix value of doc type in file 420.16
 ;C=fix value of doc data element of file 420.17
 ; variable=Y for yes, N or nil for no
REQ(A,B,C) ;get fund's one required field value Y/N
 N D,X
 S X="",B=$O(^PRCD(420.16,"AC",B,"")),C=$O(^PRCD(420.17,"AC",C,""))
 I $P(A,"^",2) S D=$$ACC($P(A,"^",2),$P(A,"^",3)_"^"_$P(A,"^",4)_"^"_$P(A,"^",5)),$P(A,"^")=$P(D,"^",9)
 I A,B,C D
 . S X=$O(^PRCD(420.18,"UNQ",$P(A,"^"),B,C,""))
 . S:X>0 X=$P($G(^PRCD(420.18,X,0)),"^",4)
 . QUIT
 QUIT X
 ;
 ; A=^1 fund 420.14 ri (opt), ^2 station #, ^3 control pt #,
 ;   ^4=(document) fiscal year, ^5=beginning budget fiscal year
 ; B=document type fix value, C=variable name
 ; return value is variable name(data element fix value)="Y","N" or nil
 ; variable name=$$ACC^PRC0C
DOCREQ(A,B,C) ;get fund's all required fields in array
 N D,E
 I $P(A,"^",2) S D=$$ACC($P(A,"^",2),$P(A,"^",3)_"^"_$P(A,"^",4)_"^"_$P(A,"^",5)),@C=D,$P(A,"^",1)=$P(D,"^",9)
 S B=$O(^PRCD(420.16,"AC",B,""))
 I A,B D
 .S D="" F  S D=$O(^PRCD(420.18,"UNQ",+A,B,D)) Q:'D  S E=$O(^(D,"")) D:E
 .. S E=^PRCD(420.18,E,0)
 .. S @(C_"($P(^PRCD(420.17,D,0),""^"",4))=$P(E,""^"",4)")
 .. QUIT
 . QUIT
 QUIT
 ;
 ;A is station #
 ;B is data ^1=fund control point code, ^2= (document) fiscal 2-digit year,
 ;          ^3=beginning budget fiscal year (4-digit)
 ; value ^1=a/o code, ^2=program, ^3=fcp/prj code
 ;       ^4=object class, ^5=fund code
 ;       ^6=bfy beginning, ^7=bfy end, ^8=fund trans allowed
 ;       ^9=file 420.14 record id, ^10=job, ^11=fill-in-year(s) appropriation, ^12=gross/net, ^13='Y' if revolving fund
ACC(A,B) ;extrinsic function
 N C,D,E,F,G,I
 S (C,D,F)=""
 S:$P(B,"^",2)?2N&A&B C=$$ACC^PRCSEZ(+A,$P(B,"^",2),+B)
 S:$P(C,"^",4) D=$$NP^PRC0B("^PRCD(420.15,$P(C,""^"",4),",0,1)
 S:$P(C,"^",5) $P(D,"^",2)=$$NP^PRC0B("^PRCD(420.13,$P(C,""^"",5),",0,1)
 S:$P(C,"^",6) $P(D,"^",3)=$$NP^PRC0B("^PRCD(420.131,$P(C,""^"",6),",0,1)
 S:$P(C,"^",7) $P(D,"^",4)=$$NP^PRC0B("^PRCD(420.132,$P(C,""^"",7),",0,1)
 I $P(C,"^",10)]"",$P(B,"^",3) S F=$$FUND($P(C,"^",10),$P(B,"^",3))
 S E="" F I=2,4,5,8,1 S E=E_$P(F,"^",I)_"^"
 S $P(D,"^",5,9)=E,$P(D,"^",12)=$P(F,"^",6) S:$P(D,"^",12)="" $P(D,"^",12)="N"
 S:$P(C,"^",8) $P(D,"^",10)=$$NP^PRC0B("^PRCD(420.133,$P(C,""^"",8),",0,1)
 S:$P(D,"^",6) $P(D,"^",11)=$$APPF($P(C,"^",9),$P(D,"^",6),$P(D,"^",7))
 I $P(D,"^",5)]"" S C=$O(^PRCD(420.3,"B",$P(D,"^",5),0)) S:C $P(D,"^",13)=$P(^PRCD(420.3,C,0),"^",8)
 QUIT D
 ;
FUND(A,B) ;get fund, A=fund code, B=bbfy
 N C
 S C="" I A]"",B]"" S C=$O(^PRCD(420.14,"UNQ",A,B,"")) I C S C=$O(^(C,""))
 QUIT C_"^"_$S(C:$G(^PRCD(420.14,C,0)),1:"")
 ;
 ;A=station #, B=fiscal year (2-digit), C=fcp #
 ;D is data ^1=appropriation code, ^2=fund code
APP(A,B,C) ;EF data ^1=app symbol, ^2=fund code, ^3=program ri
 N D
 S D=$G(^PRC(420,+A,1,+C,4,B,2)) S:D]"" D=$P(D,"^",9,10)_"^"_$P(D,"^",5)
 S:D="" D=$P($G(^PRC(420,+A,1,+C,0)),"^",3),$P(D,"^",2,3)=$P($G(^(5)),"^",1,2)
 QUIT D
 ;
APPF(A,B,C) ;fill-in-years appropriation, A=appropriation, B=bbfy, C=ebfy
 N D
 S D=$F(A,"_/_")
 QUIT $S(D>1:$E(A,1,D-4)_(B#10)_"/"_(C#10)_$E(A,D,999),1:$TR(A,"_",B#10))
 ;
 ;X date
 ;A=I if fm date, E if external date, H if $H date
DATE(X,A) ;ext value ^1=fy (4 digits),^2=fy qtr,^3=year,^4=month (2 digits),^5=day (2 digits),^6=week day #,^7=fm date,^8=$H date, ^9=fiscal month( 2-dig)
 N B,C,D,E,Y,%H,%,%DT,%T,%Y
 S D=""
 I A="H" S D=X,E=D-3#7,%H=X D YMD^%DTC
 I A="E" S %DT="" D ^%DT S X=Y
 S A=X\10000+1700,B=$E(X,4,5),C=$E(X,6,7)
 I D="" D H^%DTC S D=%H,E=%Y
 QUIT B>9+A_"^"_(B+2\3#4+1)_"^"_A_"^"_B_"^"_C_"^"_E_"^"_X_"^"_D_"^"_$E(B+2#12+1+100,2,3)
 ;
 ;A is 2/4 digit year
YEAR(A) ;EF value ^1=4-digit year,^2=2-digit year
 N B,C,D,F,X,Y,%DT
 I A>100 S B=A_"^"_$E(A,$L(A)-1,$L(A))
 E  S X=$E(100+A,2,3),%DT="" D ^%DT S B=$E(Y,1,3)+1700_"^"_X
 QUIT B
 ;
 ;A=staiton #
SEC1(A) ;EF value=fms sec1 code
 QUIT $P($G(^PRCD(420.138,+$P($G(^PRC(411,+A,9)),"^",2),0)),"^",1)
 ;
