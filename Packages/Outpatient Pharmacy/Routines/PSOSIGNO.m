PSOSIGNO ;BHAM ISC/RTR-Check new Sig for Route and Schedule ; 10/10/96
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 ;
 ;Pass in IEN from Pending File, and New Sig
 ;Returned   PSOSIGFL=0  no new order (common Routes and Schedules)
 ;           PSOSIGFL=1  new order (no Route to having route) or
 ;                                 (no Schedule to having schedule) or
 ;                                 (visa versa, or discrepency)
 ;
 ;Also returned are arrays with Original and New Routes & Schedules:
 ;
 ; PSOMDRTE array (original route)      PSOMDRTE(1)="ORAL"
 ;
 ; PSONEWMD array (new routes)          PSONEWMD(1)="ORAL"
 ;                                      PSONEWMD(22)="BOTH EYES"
 ;
 ; PSOSCH array (original schedules)    PSOSCH("Q12H")=""
 ;                                      PSOSCH("Q4H")=""
 ;
 ; PSONEWSD array (new schedules)       PSONEWSD("Q4H")=""
 ;                                      PSONEWSD("Q8H")=""
 ;
EN(PSPENIEN,PSPENSIG) ;
 K PSONEWMD,PSOMDRTE,PSOSCH,PSONEWSD N AA,GGG,PSONULL,XXX,XXXX,ZZZZ
 ;S PSOSIGFL=0
 I $P($G(^PS(52.41,PSPENIEN,0)),"^",15),$P($G(^PS(51.2,+$P(^(0),"^",15),0)),"^")'="" S PSOMDRTE($P(^PS(52.41,PSPENIEN,0),"^",15))=$P(^PS(51.2,+$P(^(0),"^",15),0),"^")
 F ZZZZ=0:0 S ZZZZ=$O(^PS(52.41,PSPENIEN,1,ZZZZ)) Q:'ZZZZ  I $P($G(^PS(52.41,PSPENIEN,1,ZZZZ,1)),"^")'="" S PSOSCH($P(^(1),"^"))=""
 F GGG=1:1:$L(PSPENSIG," ") S XXX=$P(PSPENSIG," ",GGG) D:XXX]""
 .I $D(^PS(51,"A",XXX)) D
 ..S XXXX=$O(^PS(51,"B",XXX,0)) D:XXXX
 ...I $P($G(^PS(51,XXXX,0)),"^",5),$P($G(^PS(51.2,+$P(^(0),"^",5),0)),"^")'="" S PSONEWMD($P(^PS(51,XXXX,0),"^",5))=$P(^PS(51.2,$P(^(0),"^",5),0),"^")
 ...I $P($G(^PS(51,XXXX,0)),"^",6)'="" S PSONEWSD($P(^(0),"^",6))=""
NEW ;Check for new order
 S PSONULL=""
 I $O(PSOMDRTE(0)),'$O(PSONEWMD(0)) S PSOSIGFL=1
 Q:$G(PSOSIGFL)  I $O(PSONEWMD(0)),'$O(PSOMDRTE(0)) S PSOSIGFL=1
 Q:$G(PSOSIGFL)  I $O(PSOSCH(PSONULL))="",$O(PSONEWSD(PSONULL))'="" S PSOSIGFL=1
 Q:$G(PSOSIGFL)  I $O(PSONEWSD(PSONULL))="",$O(PSOSCH(PSONULL))'="" S PSOSIGFL=1
 Q:$G(PSOSIGFL)
ERROR ;check for error
 ;This is also a new order now
 F AA=0:0 S AA=$O(PSOMDRTE(AA)) Q:'AA!($G(PSOSIGFL))  I '$D(PSONEWMD(AA)) S PSOSIGFL=1
 Q:$G(PSOSIGFL)  F AA=0:0 S AA=$O(PSONEWMD(AA)) Q:'AA!($G(PSOSIGFL))  I '$D(PSOMDRTE(AA)) S PSOSIGFL=1
 Q:$G(PSOSIGFL)  S AA="" F  S AA=$O(PSOSCH(AA)) Q:AA=""!($G(PSOSIGFL))  I '$D(PSONEWSD(AA)) S PSOSIGFL=1
 Q:$G(PSOSIGFL)  S AA="" F  S AA=$O(PSONEWSD(AA)) Q:AA=""!($G(PSOSIGFL))  I '$D(PSOSCH(AA)) S PSOSIGFL=1
 Q
 ;
EN1(PSRENIEN,PSRENSIG) ;
 ;Same as above, only for a new Sig from File 52
 ;Pass in IEN from 52, and new Sig
 K PSONEWMD,PSOMDRTE,PSOSCH,PSONEWSD N AA,GGG,PSONULL,XXX,XXXX,ZZZZ
 ;S PSOSIGFL=0
 F GGG=0:0 S GGG=$O(^PSRX(PSRENIEN,"MEDR",GGG)) Q:'GGG  S ZZZZ=+$P(^(GGG,0),"^") I ZZZZ,$P($G(^PS(51.2,ZZZZ,0)),"^")'="" S PSOMDRTE(ZZZZ)=$P(^(0),"^")
 F ZZZZ=0:0 S ZZZZ=$O(^PSRX(PSRENIEN,"SCH",ZZZZ)) Q:'ZZZZ  I $P(^(ZZZZ,0),"^")'="" S PSOSCH($P(^(0),"^"))=""
 F GGG=1:1:$L(PSRENSIG," ") S XXX=$P(PSRENSIG," ",GGG) D:XXX]""
 .I $D(^PS(51,"A",XXX)) D
 ..S XXXX=$O(^PS(51,"B",XXX,0)) D:XXXX
 ...I $P($G(^PS(51,XXXX,0)),"^",5),$P($G(^PS(51.2,+$P(^(0),"^",5),0)),"^")'="" S PSONEWMD($P(^PS(51,XXXX,0),"^",5))=$P(^PS(51.2,$P(^(0),"^",5),0),"^")
 ...I $P($G(^PS(51,XXXX,0)),"^",6)'="" S PSONEWSD($P(^(0),"^",6))=""
NEWOR ;Check for new order
 G NEW
 ;
POP(PSOPOPRX) ;Pass in Internal Rx number, will populate Med Route and
 ;schedule fields from BACK door Sig
 N BACKSIG,BBB,LLL,LLLL,POPMD,POPSC
 Q:'$D(^PSRX(PSOPOPRX,0))
 Q:$P($G(^PSRX(PSOPOPRX,"SIG")),"^")=""!($P($G(^("SIG")),"^",2))
 S BACKSIG=$P(^PSRX(PSOPOPRX,"SIG"),"^")
 F BBB=1:1:$L(BACKSIG," ") S LLL=$P(BACKSIG," ",BBB) D:LLL]""
 .I $D(^PS(51,"A",LLL)) D
 ..S LLLL=$O(^PS(51,"B",LLL,0)) D:LLLL
 ...I $P($G(^PS(51,LLLL,0)),"^",5),$P($G(^PS(51.2,+$P(^(0),"^",5),0)),"^")'="" S POPMD($P(^PS(51,LLLL,0),"^",5))=""
 ...I $P($G(^PS(51,LLLL,0)),"^",6)'="" S POPSC($P(^(0),"^",6))=""
 K ^PSRX(PSOPOPRX,"MEDR"),^PSRX(PSOPOPRX,"SCH")
 S LLLL=1 F LLL=0:0 S LLL=$O(POPMD(LLL)) Q:'LLL  S ^PSRX(PSOPOPRX,"MEDR",LLLL,0)=LLL,^PSRX(PSOPOPRX,"MEDR",0)="^52.037PA^"_LLLL_"^"_LLLL S LLLL=LLLL+1
 S LLLL=1,LLL="" F  S LLL=$O(POPSC(LLL)) Q:LLL=""  S ^PSRX(PSOPOPRX,"SCH",LLLL,0)=LLL,^PSRX(PSOPOPRX,"SCH",0)="^52.038A^"_LLLL_"^"_LLLL S LLLL=LLLL+1
 K PSOPOPRX
 Q
