LAMIVTLP ;DALISC/PAC - VITEK MICRO DATA LITERAL PARSER; 5-24-95;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12,35**;Sep 27, 1994
 ;Parses the literal data stream and calls LAMIVTLU
 ;to stuff data in the LAH for verification
 ;***** LOCAL PATCH *****
LA1 S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)) Q:TSK<1
 Q:'$D(^LA(TSK,"I",0))
 K LATOP D ^LASET Q:'TSK  S LROVER=1,X="TRAP^"_LANM,@^%ZOSF("TRAP")
 S MTRSL="mtrsl|",RT="rt",PI="pi",CI="ci",SI="si",ZZ="zz",U="^"
 S LABUG="o2",LADRUG="a2",LAMIC="a3",A4="a4"
 ; FIELD HIEARCHY = "pi^si^ci^rt^zz"
 S LABGNODE="o1",LANTIB="a1",LACOUNT=0
 K ^TMP("VITEK") ;S LAFIN=0
LA2 K LAIN,LAPD,LASI,LART,LACI,LARTX
 S TOUT=0,LAIN=0,LASUM=0,ERR=0
 ;Q:LAFIN=2
 D IN G QUIT:TOUT,LA2:$E(IN,1,6)'=MTRSL
 I IN["TEST PATTERN" G LA2
 D AGAIN G:ERR LA2
 D PARSE G:'$G(LACI(CI)) LA2
 I $D(^LA("VITEK")) D DEBUG^LAMIVTLC
 S ID=LACI(CI) ;G:$L(ID)<9 LA2
 ;----------------------------------------------------------------
 ; Entered to accomadate file 60 prefix field
 ; point to micro det-up file
 ; chk accn also
 S:$D(^LAB(61.38,1,1)) LRPREFIX=^(1)
 I $G(LRPREFIX)=1 D
 .  I '$D(^LRO(68,WL,1,LADT,1,ID)) D
 ..  I $L(ID)=6 S ID=+$E(ID,2,6)
LA3 S DHZGEN="S LOG=+ID D LOG^LAMIVTLG" S IDE=+ID
 S LROVER=0
 X DHZGEN G LA2:'ISQN ;Can be changed by the cross-link code
 D ^LAMIVTLC
 ;CREATE^LAMIVTLC (DAVID'S RTN)
 G LA2
AGAIN ;store records in array
 ;K LAHARCHY
READ ;
 S LAIN=LAIN+1
 S LAIN(LAIN)=IN S LASUM=LASUM+$$CHK(IN)
 I IN["~]" D IN D  Q
 .S LAHEX=$$HEX(LASUM)
 .S LAHEX=$E(LAHEX,$L(LAHEX)-1,$L(LAHEX))
 .;D:LAHEX'[$E(IN,1,2) ERR("CHECKSUM") ;TAKEOFFLATER
 D IN G AGAIN ;READ ;W !,"READ" G READ
PARSE ;create separate arrays pat demographics, tests, results, etc.
 S TERM=0,INT="",FIN=0,II=1,END=0
 S INT=INT_LAIN(II)
 S INT=$P(INT,MTRSL,2) ;D ADD
 K LAPD,LASI,LACI,LARTX,LART
 ;K LAPD pat demographics
PID D PD(INT,SI) D ADD G:'TERM&('END) PID
 Q:END  ;K LASI ;-> specimen demographics
SID D SI(INT,CI) D ADD G:'TERM&('END) SID
 Q:END  ;K LACI ;->culture demographics
CID D CI(INT,RT) D ADD G:'TERM&('END) CID
 Q:END  ;K LARTX,LART ;->results and other fields
RTD D RT(INT,ZZ) D ADD G:'TERM&('END) RTD
 Q:END
 G:'FIN!('TERM) RTD
 Q
ADD ; 
 I END QUIT
 I FIN,INT["|zz|" Q
 I LAIN>II D
 . S II=II+1
 . I $L(INT)<160 S INT=$TR(INT,"~^")_LAIN(II) Q
 . I INT["~^" S INT=$TR(INT,"~^")_LAIN(II) Q
 . S INT=$TR(INT,"~^")_LAIN(II)
 S FIN=II=LAIN
 Q
PD(INPD,DELIM) ; patient demographics
 S TERM=0
 F J=1:1:$L(INPD,"|")-1 D  Q:TERM!(END)
 . S LAPD=$$BLANKS($P(INPD,"|",J))
 . S:$E(LAPD,1,2)=DELIM TERM=1  D
 . . S LAPD=$P(INPD,"|",J) S:LAPD=ZZ END=1
 . . Q:$L(LAPD)<3
 . . S LAPD($E(LAPD,1,2))=$E(LAPD,3,$L(LAPD))
 S INT=$S(INPD[LAPD:$P(INPD,LAPD_"|",2),1:INPD)
 Q
SI(INSD,DELIM) ; specimen demographics
 S TERM=0
 F J=1:1:$L(INSD,"|")-1 S:$E($P(INSD,"|",J),1,2)=DELIM TERM=1 Q:TERM!(END)  D
 .S LASI=$$BLANKS($P(INSD,"|",J)) S:LASI=ZZ END=1 Q:END  I LASI'="" D
 . .Q:$L(LASI)<3
 . .S LASI($E(LASI,1,2))=$E(LASI,3,$L(LASI))
 S INT=$S(INSD[LASI:$P(INSD,LASI_"|",2),1:INSD)
 Q
CI(INTD,DELIM) ; exam info, id etc
 S TERM=0
 F J=1:1:$L(INTD,"|")-1 S:$E($P(INTD,"|",J),1,2)=DELIM TERM=1 Q:TERM!(END)  D
 . S LACI=$$BLANKS($P(INTD,"|",J)) S:LACI=ZZ END=1
 . I LACI'="",$E(LACI)'="~" D
 . .Q:$L(LACI)<3
 . .S LACI($E(LACI,1,2))=$E(LACI,3,$L(LACI))
 S INT=$S(INTD[LACI:$P(INTD,LACI_"|",2),1:INTD)
 Q
RT(INTR,DELIM) ; results including tests organism, drugs etc.
 S TERM=0 S L=$L(INTR,"|") ;S:INTR["~]" FIN=1
 F J=1:1:L S LART=$$BLANKS($P(INTR,"|",J)) S:$E(LART,1,2)=DELIM END=1 Q:END  Q:LART["~"  Q:LART=""  D  ;!($L(LART)<3)  D
 .I LART["," D COMMA Q
 .Q:$L(LART)<3
 .I $D(SC) I SC="a3"&($E(LART,1,2)="a1") D
 ..S LARTX("a4")=$S($G(LARTX("a4")):LARTX("a4")+1,1:1)
 ..S LART("a4",LARTX("a4"))=LART("a3",LARTX("a4"))
 .S SC=$E(LART,1,2)
 .S LARTX(SC)=$S($G(LARTX(SC)):LARTX(SC)+1,1:1)
 .S LART(SC,LARTX(SC))=$E(LART,3,$L(LART))
 S INT=$P(INTR,"|",J,L)
 S:II=LAIN&(END) FIN=1
 Q
COMMA I SC="rr" S LAMULTST=1 Q
 I SC'="gn" Q
 S GN=$L(LART,",") Q:GN'>1
 F L=1:1:GN D
 .S LARTGN=$P(LART,",",L)
 .S LARTX(SC)=$S($G(LARTX(SC)):LARTX(SC)+1,1:1)
 .S LART(SC,LARTX(SC))=$$BLANKS($E(LARTGN,3,$L(LARTGN)))
 Q
IN S CNT=^LA(TSK,"I",0)+1
 IF '$D(^LA(TSK,"I",CNT)) S TOUT=TOUT+1 Q:TOUT>9  H 10 G IN
 ;S:TOUT>9 LAFIN=LAFIN+1 Q:TOUT>9  H 10 G IN
 S ^LA(TSK,"I",0)=CNT,IN=^(CNT),TOUT=0
 S ^TMP("VITEK",$J,CNT)=IN
 Q
OUT S CNT=^LA(TSK,"O")+1,^("O")=CNT,^("O",CNT)=TSK_OUT
 LOCK ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=TSK LOCK
 Q
CHK(XX) ;
 N X,I S XX=$TR(XX,"^"),X=0
 F I=1:1:$L(XX) D
 .S X=X+$S($E(XX,I)="~":30,$E(XX,I)="]":29,1:$A(XX,I))
 Q X
 ;
QUIT I (^LA(TSK,"I")'=^LA(TSK,"I",0)) G LA2
 I $D(^LA(TSK,"O",0)),^LA(TSK,"O")'=^LA(TSK,"O",0) G LA2
 L ^LA(TSK) H 1
 K ^LA(TSK),^LA("LOCK",TSK),^TMP($J),^TMP("LA",$J)
 D KILL^%ZTLOAD
 Q
TRAP D ^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM) ;ERROR TRAP
 ;
HEX(HEX) ;
 Q:'$D(HEX) 0  Q:'(HEX?.N) "*ERROR"  Q:'HEX 0
 N LADN,LADD,LADH S LADN=HEX,LADH=""
L I LADN'=0 D  S LADH=LADD_LADH G L
 .S LADD=LADN#16,LADN=LADN\16 Q:LADD<10  S LADD=$C($A("a")+LADD-10)
 Q LADH
ERR(ERTYPE) ;
 N LL
 F LL=CNT-LAIN:1:CNT D
 .S ^TMP("LA",ERTYPE_" ERR",$J,LL)=^LA(TSK,"I",LL)
 S ^TMP("VITEK",LL)=LAHEX_U_LASUM_U_^LA(TSK,"I",LL)
 S ERR=1
 Q
BLANKS(XX) ;
 N I,J
 F I=$L(XX):-1:1 Q:$E(XX,I)'=" "
 F J=1:1:$L(XX) Q:$E(XX,J)'=" "
 Q $E(XX,J,I)
