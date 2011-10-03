ENFABAL1 ;WIRMFO/SAB-MAINTAIN FILE 6915.9 FAP BALANCES (cont);1.12.98
 ;;7.0;ENGINEERING;**29,33,48**;AUG 17, 1883
 ;This routine should not be modified.
 Q
 ;
SUM ; sum FAP transactions for period
 ; called from RECALC^ENFABAL
 ; input
 ;   ENDTR - month to recalculate (FileMan date)
 ; output
 ;   ^TMP($J,"R",station,fund,sgl)=net $ activity
 N ENAMT,ENDA,ENDT,ENDTE,ENDTS,ENFAPTY,ENFAY3,ENFILE
 N ENFUND,ENFUNDNW,ENI,ENSGL,ENSN,ENX,ENY0
 S ENDTS=$E(ENDTR,1,5)_"01" ; start of month
 S ENDTE=$$EOM^ENUTL(ENDTS) ; end of month
 ; load table for converting FA Type to SGL
 S ENDA=0 F   S ENDA=$O(^ENG(6914.3,ENDA)) Q:'ENDA  D
 . S ENY0=$G(^ENG(6914.3,ENDA,0))
 . I $P(ENY0,U,3)]"" S ENFAPTY($P(ENY0,U,3))=$P(ENY0,U)
 ; loop thru FAP document file transactions within month
 F ENFILE="6915.2","6915.3","6915.4","6915.5","6915.6" D
 . S ENDT=ENDTS
 . F  S ENDT=$O(^ENG(ENFILE,"D",ENDT)) Q:ENDT=""!($P(ENDT,".")>ENDTE)  D
 . . S ENDA("F?")=0
 . . F  S ENDA("F?")=$O(^ENG(ENFILE,"D",ENDT,ENDA("F?"))) Q:'ENDA("F?")  D
 . . . S ENDA("FA")=$$AFA^ENFAR5A(ENFILE,ENDA("F?")) ; associated FA
 . . . S ENFAY3=$G(^ENG(6915.2,ENDA("FA"),3)),ENSN=$E($P(ENFAY3,U,5),1,5)
 . . . S ENSN=$TR(ENSN," ","") ; remove spaces (if any)
 . . . S:ENFILE=6915.2 ENFUND=$P(ENFAY3,U,10)
 . . . S:ENFILE'=6915.2 ENFUND=$$FUND^ENFAR5A(ENFILE,ENDA("F?"),ENDA("FA"))
 . . . S ENSGL=$S($P(ENFAY3,U,6)]"":$G(ENFAPTY($P(ENFAY3,U,6))),1:"")
 . . . Q:ENFUND=""!(ENSGL="")
 . . . I ENFILE=6915.2 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,27)
 . . . I ENFILE=6915.3 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),4)),U,4)
 . . . I ENFILE=6915.4 S ENX=$P($G(^ENG(ENFILE,ENDA("F?"),4)),U,6),ENAMT=$S(ENX="":0,1:ENX-$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,4))
 . . . I ENFILE=6915.5 S ENAMT="-"_$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,2)
 . . . I ENFILE=6915.6 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,8)
 . . . Q:+ENAMT=0  ; don't include transactions for $0
 . . . I ENFILE'=6915.6 D  ; process non-FR doc
 . . . . S ^TMP($J,"R",ENSN,ENFUND,ENSGL)=$G(^TMP($J,"R",ENSN,ENFUND,ENSGL))+ENAMT
 . . . I ENFILE=6915.6 D  ; process FR doc
 . . . . S ENFUNDNW=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,9)
 . . . . Q:ENFUND=ENFUNDNW  ; don't include if fund unchanged by FR
 . . . . S ^TMP($J,"R",ENSN,ENFUNDNW,ENSGL)=$G(^TMP($J,"R",ENSN,ENFUNDNW,ENSGL))+ENAMT
 . . . . S ^TMP($J,"R",ENSN,ENFUND,ENSGL)=$G(^TMP($J,"R",ENSN,ENFUND,ENSGL))-ENAMT
 Q
 ;
FVST ; compare file 6915.9 vs. transactions
 ; input
 ;   ENDTR - month to recalculate (FileMan date)
 ;   ^TMP($J,"R",station,fund,sgl)=net $ activity from recalc
 ; output -
 ;   problems where net activity is not equal in
 ;     ^TMP($J,"P",station,fund,sgl)=net from file^net from recalc
 N ENI,ENFUND,ENPM,ENPMI,ENSGL,ENSMI,ENSN,PAMT,RAMT,SAMT
 ; loop thru station
 S ENI(1)=0 F  S ENI(1)=$O(^ENG(6915.9,ENI(1))) Q:'ENI(1)  D
 . S ENSN=$$GET1^DIQ(6915.9,ENI(1),.01)
 . ; loop thru fund
 . S ENI(2)=0 F  S ENI(2)=$O(^ENG(6915.9,ENI(1),1,ENI(2))) Q:'ENI(2)  D
 . . S ENFUND=$$GET1^DIQ(6915.91,ENI(2)_","_ENI(1),.01)
 . . ; loop thru sgl
 . . S ENI(3)=0
 . . F  S ENI(3)=$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3))) Q:'ENI(3)  D
 . . . S ENSGL=$$GET1^DIQ(6915.911,ENI(3)_","_ENI(2)_","_ENI(1),.01)
 . . . S ENSMI=$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",ENDTR,0))
 . . . S ENPM=$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",ENDTR),-1)
 . . . S ENPMI=$S(ENPM:$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",ENPM,0)),1:"")
 . . . S SAMT=$S(ENSMI:$P($G(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,ENSMI,0)),U,2),1:"")
 . . . S PAMT=$S(ENPMI:$P($G(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,ENPMI,0)),U,2),1:"")
 . . . I SAMT="" S SAMT=PAMT ; balance inherited from prior month
 . . . S RAMT=$P($G(^TMP($J,"R",ENSN,ENFUND,ENSGL)),U)
 . . . I +(SAMT-PAMT)'=+RAMT S ^TMP($J,"P",ENSN,ENFUND,ENSGL)=(+(SAMT-PAMT))_U_(+RAMT)
 Q
 ;
 ;ENFABAL1
