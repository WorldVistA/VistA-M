ENFAXMT3 ;WCIOFO/KLD/DH; TRANSMIT FAP RECORDS ;11/13/2000
 ;;7.0;ENGINEERING;**29,39,57,66**;Aug 17, 1993
 ;This routine should not be modified.
 ;
CSN S X(1)=X(1)_U,ENFA("CSN")=$P(ENFADAT(2),U,8) Q:'ENFA("CSN")
 S ENFA("CSN")=$P(^ENCSN(6917,ENFA("CSN"),0),U)
 I $E(ENFA("CSN"),1,2)'=70 S X(1)=X(1)_$E(ENFA("CSN"),1,2)_"00" Q
 I +ENFA("CSN")'=7020,+ENFA("CSN")'=7021,+ENFA("CSN")'=7025,+ENFA("CSN")'=7035,+ENFA("CSN")'=7040,+ENFA("CSN")'=7050 S X(1)=X(1)_$E(ENFA("CSN"),1,4)
 E  S X(1)=X(1)_7000
 Q
 ;
FANUM(N) N STATION S STATION=$S(ENFAP("STATION")]"":ENFAP("STATION"),1:ENFAP("SITE")) S STATION=STATION_"     ",STATION=$E(STATION,1,5)
 S X(N)=X(N)_U_STATION_ENEQ("DA") ;FA Number
 I $P(ENEQ(8),U,6),ENFAP("DOC")'="FD" S ENFAP("TY")=$P(^ENG(6914.3,$P(ENEQ(8),U,6),0),U,3)
 E  S ENFA("DA")=$P($$CHKFA^ENFAUTL(ENEQ("DA")),U,4),ENFAP("TY")=$P(^ENG(6915.2,ENFA("DA"),3),U,6)
 S X(N)=X(N)_U_ENFAP("TY") ; FA Type
 Q
 ;
BUDFY(FUND) ;
 N ENY
 S ENY=$G(^ENG(6914.6,FUND,0))
 I $P(ENY,U)="4539" S ENFAP("BUDFY")="2000" G BUDFYX ; franchise EN*7*66
 I $P(ENY,U,3) S ENFAP("BUDFY")="1994" G BUDFYX ; revolving fund
 I $E($P(ENY,U),1,4)="AMAF" S ENFAP("BUDFY")="1995" G BUDFYX ; amafxx
 ;S ENFAP("BUDFY")=$E($P(ENEQ(2),U,4),1,3)+1700+$E($P(ENEQ(2),U,4),4)
 S ENFAP("BUDFY")=$E(DT,1,3)+1700+$E(DT,4)
BUDFYX ;
 S X(1)=X(1)_U_$E(ENFAP("BUDFY"),3,4)
 Q
 ;
XPROG ; append ACC Code to X(1)
 ; input
 ;   ENFAP("STATION") - station number
 ;   ENFAP("SITE")    - station number
 ;   $P(ENEQ(8),U,3)  - FCP
 ;   $P(ENEQ(2),U,4)  - acquisition date
 ;   ENFAP("BUDFY")   - 4 digit beginning budget fiscal year
 ; output
 ;   X(1)
 N ENACC
 S ENACC="000000000" ; default value - always send per Bob Landrum
 ;S X="PRC0C" X ^%ZOSF("TEST") D:$T
 ;. N ENSN,ENFCP,ENDOCFY,ENX
 ;. S ENSN=$S(ENFAP("STATION")]"":ENFAP("STATION"),1:ENFAP("SITE"))
 ;. S ENFCP=$P(ENEQ(8),U,3)
 ;. S ENDOCFY=$E($E($P(ENEQ(2),U,4),1,3)+$E($P(ENEQ(2),U,4),4),2,3)
 ;. Q:ENSN=""!(ENFCP="")!(ENDOCFY="")!(ENFAP("BUDFY")="")
 ;. S ENX=$$ACC^PRC0C(ENSN,ENFCP_U_ENDOCFY_U_ENFAP("BUDFY"))
 ;. I $P(ENX,U,3)?9AN S ENACC=$P(ENX,U,3)
 S X(1)=X(1)_U_ENACC ;Xprog
 Q
 ;
 ;ENFAXMT3
