WVRPSCR2 ;HCIOFO/JWR,FT-WVRPSCR cont'd, Gathers Pap Regimens info. ;6/17/99  11:46
 ;;1.0;WOMEN'S HEALTH;**7**;Sep 30, 1998
EN ;---> NOW COLLATE DATA FROM ^TMP ARRAY INTO LOCAL WVTMP REPORT ARRAY.
 ;---> FIRST, SEED LOCAL ARRAY WITH ZEROS.
 K WVPR
 ;
 ;---> COLLATE DATA.
 S J="" F  S J=$O(^TMP("WVP",$J,J)) Q:J=""  D
 .S N=0 F  S N=$O(^TMP("WVP",$J,J,N)) Q:'N  D
 ..F M=1,28 S WVJTYP=$S(M=1:"PAPR",1:"MAM") D
 ...Q:$D(^TMP("WVP",$J,J,N,1,M))  ;DON'T INCLUDE IF PATIENT HAD ANY ABNOR
 ...S P=0,Q=0
 ...F  S P=$O(^TMP("WVP",$J,J,N,0,M,P)) Q:'P  S Q=Q+1
 ...Q:'Q
 ...I '$D(WVPR(WVJTYP,J,M,Q)) S WVPR(WVJTYP,J,M,Q)=1 Q
 ...S WVPR(WVJTYP,J,M,Q)=WVPR(WVJTYP,J,M,Q)+1
 ;
 ;---> STORE ALL NODES >5 IN THE 5+ NODE.
 F M=1,28 S WVJTYP=$S(M=1:"PAPR",1:"MAM") D
 .S J="" F  S J=$O(^TMP("WVP",$J,J)) Q:J=""  D
 ..S Q=5
 ..F  S Q=$O(WVPR(WVJTYP,J,M,Q)) Q:'Q  D
 ...S WVPR(WVJTYP,J,M,5)=$G(WVPR(WVJTYP,J,M,5))+WVPR(WVJTYP,J,M,Q)
 ;
 ;---> FIGURE PERCENTAGES OF WOMEN AND STORE IN ARRAY.
 F M=1,28 S WVJTYP=$S(M=1:"PAPR",1:"MAM") D
 .S J="" F  S J=$O(WVPR(WVJTYP,J)) Q:J=""  D
 ..F Q=1:1:5 I $D(WVPR(WVJTYP,J,M,Q)) S $P(WVPR(WVJTYP,J,M,Q),U,2)=$J((+WVPR(WVJTYP,J,M,Q)/WVTOT),0,2)
 ;
PRINT N BLANK,DATA
 S $P(BLANK," ",41)="",CN=7.001
 S WVJST=0 F M=1,28 S WVJTYP=$S(M=1:"PAPR",1:"MAM") S:M=28 CN=16.001 D
 .S J="" F  S J=$O(WVPR(WVJTYP,J)) Q:J=""  D
 ..Q:'$D(WVPR(WVJTYP,J,M))
 ..N P F Q=1:1:5 S DATA=$G(WVPR(WVJTYP,J,M,Q)) D
 ...S P(1)=$P(DATA,U),P(2)=$P(DATA,U,2)*100 S:P(1)="" P(1)=0
 ...S P("NO")=$G(P("NO"))_$E(BLANK,1,6-$L(P(1)))_P(1)
 ...S P("PCT")=$G(P("PCT"))_$E(BLANK,1,5-$L(P(2)))_P(2)_"%"
 ..S ^TMP("WV",$J,CN,0)=" "_J_$E(BLANK,1,36-$L(J))_"# of Women "_P("NO")
 ..S CN=CN+.001
 ..S ^TMP("WV",$J,CN,0)=$E(BLANK,1,37)_"% of Women "_P("PCT")
 ..S CN=CN+.001
 ..S ^TMP("WV",$J,CN,0)=""
 ..S CN=CN+.001
 Q
HDR ;
 Q:N>7.9&(N'>16)
 S WVJHDR=$S(N<8:"PAP REGIMEN",N>16:"AGE GROUPS ",1:"           ")
 W !!," ",WVJHDR,"                                       1     2     3     4     5+"
 W !," -----------                                     ----- ----- ----- ----- -----"
 Q
ACTIVE(WVBEGIN,WVEND,WVAGRG) ; Count active patients in WV PATIENT file (#790).
 ; Active is defined as not having a DATE INACTIVE (#.24) field
 ; value or that value falls within the date range selected.
 ; WVBEGIN - start of date range in FM format
 ;   WVEND - end of date range in FM format
 N WVLOOP,WVNODE,WVACTIVE,WVAGE
 S (WVLOOP,WVACTIVE)=0
 ; check if date range exists
 I 'WVBEGIN!('WVEND)!(WVAGRG="") S WVACTIVE=1 Q WVACTIVE
 F  S WVLOOP=$O(^WV(790,WVLOOP)) Q:'WVLOOP  D
 .S WVNODE=$G(^WV(790,WVLOOP,0))
 .Q:WVNODE=""
 .S WVAGE=+$$AGE^WVUTL9(WVLOOP)
 .I WVAGRG'=1 Q:((WVAGE<$P(WVAGRG,"-"))!(WVAGE>$P(WVAGRG,"-",2)))
 .I +$P(WVNODE,U,24)'>0 S WVACTIVE=WVACTIVE+1 Q  ;active
 .Q:$P(WVNODE,U,24)<WVBEGIN  ;inactive before date range
 .I $P(WVNODE,U,24)>WVEND S WVACTIVE=WVACTIVE+1 Q  ;inactive after range
 .S WVACTIVE=WVACTIVE+1 ;active at some time within range
 .Q
 S:WVACTIVE=0 WVACTIVE=1
 Q WVACTIVE
 ;
