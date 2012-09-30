PRSN9A ;;WOIFO/PLT - RPC Nurs Location Extraction ; 08/14/2009  7:56 AM
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ;.ret - rpc return value with return value type: global array
 ;prsndt - rpc parameter 1 with type: literal date in format yyyymmdd
NURSLOC(RET,PRSNDT) ;remote procedure call- extract all active nurse locations
 N PRSNA,PRSNB,PRSNC,PRSNE,PRSNF,PRSNSEQ,PRSNLOC,PRSNSITE,PRSNGLB
 ;convert yyyymmdd to fileman date
 S PRSNDT=PRSNDT-17000000
 ;get active location of the date
 ;prsnloc(ien of file# 211.4)=^1-location name, ^2-instituion name
 ;^3-institution ien of file# 4 ^4-station # (field #99 of file #4)
 K PRSNLOC D ACTIVLOC^PRSNUT01(.PRSNLOC,PRSNDT)
 K ^TMP("PRSN",$J,"RPCLOC") S PRSNGLB=$NAME(^TMP("PRSN",$J,"RPCLOC"))
 ;assembly records
 S (PRSNSEQ,PRSNA)=0 F  S PRSNA=$O(PRSNLOC(PRSNA)) QUIT:'PRSNA  S PRSNB=PRSNLOC(PRSNA),PRSNC=$G(^NURSF(211.4,PRSNA,1)) D
 . ;location records
 . S PRSNLOC=+^NURSF(211.4,PRSNA,0)_"^"_$P(PRSNB,U)_"^"_$P(PRSNB,U,3)_"^"_$P(PRSNB,U,2)_"^"_$P(PRSNC,U,5)_"^"_$S($P(PRSNC,U,6):$P(^NURSF(212.8,$P(PRSNC,U,6),0),U),1:"")
 . S $P(PRSNLOC,U,10)=$P(PRSNB,U,4)
 . S PRSNSEQ=PRSNSEQ+1,@PRSNGLB@(PRSNSEQ)=PRSNA_"^L^"_PRSNLOC
 . ;ward records in mas ward multiple field #3 of file 211.4
 . S PRSNE=0 F  S PRSNE=$O(^NURSF(211.4,PRSNA,3,PRSNE)) QUIT:'PRSNE  S PRSNF=^(PRSNE,0) D
 .. S:PRSNF $P(PRSNLOC,U,7,8)=+PRSNF_"^"_$P(^DIC(42,+PRSNF,0),U)
 .. S PRSNSEQ=PRSNSEQ+1,@PRSNGLB@(PRSNSEQ)=PRSNA_"^W^"_PRSNLOC
 .. QUIT
 . QUIT
 ;
 ;set the header node
 S PRSNSITE=$P($G(^XMB(1,1,"XUS")),"^",17),PRSNSITE=$S(+PRSNSITE>0:$P($G(^DIC(4,PRSNSITE,99)),"^",1),1:"")
 S @PRSNGLB@(0)=PRSNSITE_"^"_PRSNSEQ
 S RET=$NAME(^TMP("PRSN",$J,"RPCLOC"))
 QUIT
 ;
