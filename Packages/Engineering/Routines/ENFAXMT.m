ENFAXMT ;WCIOFO/KLD/DH/SAB; TRANSMIT FAP RECORDS ; 12/16/1998
 ;;7.0;ENGINEERING;**29,33,39,57,60**;Aug 17, 1993
 ; This routine should not be modified.
 ;
 ; Input
 ;   ENEQ("DA") - equipment entry number
 ;   ENFAP("DOC") - type of FAP document
 ;   ENFA("DA") or ENFB("DA")... - ien of document
ST K X F I=0:1:3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 S ENFAP("STATION")=$P(ENEQ(9),U,5) ;Owning station
 I '$D(ENFAP("FY")) S ENFAP("FY")=$E($E(DT,1,3)+$E(DT,4),2,3)
COUNT ;Update document counter
 S:'$D(ENFAP("SITE")) ENFAP("SITE")=+^ENG(6915.1,1,0)
 S DIC="^ENG(6915.1,",DIC(0)="M",X=ENFAP("SITE") D ^DIC
 L +^ENG(6915.1,+Y):5
 S X=$S(ENFAP("DOC")="FR":6,1:$A(ENFAP("DOC"),2)-63) ; piece in node
 S ENFAP("COUNT")=$P(^ENG(6915.1,+Y,0),U,X)+1
 S:ENFAP("COUNT")>9999 ENFAP("COUNT")=1
 S $P(^ENG(6915.1,+Y,0),U,X)=ENFAP("COUNT")
 L -^ENG(6915.1,+Y)
 S ENFAP("COUNT")="000"_ENFAP("COUNT"),ENFAP("COUNT")=$E(ENFAP("COUNT"),$L(ENFAP("COUNT"))-3,$L(ENFAP("COUNT")))
FX1 ;  set up first 4 fields of first data segment
 S ENFAP("AO")=$$GET1^DIQ(6914,ENEQ("DA"),63)
 S ENFAP("FUND")=$$GET1^DIQ(6914,ENEQ("DA"),62)
 S ENFAP("CFO")=$S(ENFAP("AO")=10:"01",ENFAP("AO")=40:"05",ENFAP("AO")=20:"02",ENFAP("AO")="02":"06",ENFAP("AO")="00":"05",1:10)
 S ENFAP("TRANS")=$S(ENFAP("STATION")]"":$E(ENFAP("STATION"),1,3),1:ENFAP("SITE"))_$E(ENFAP("FY"),2)_"N"_ENFAP("COUNT")
 S X(1)=ENFAP("DOC")_"1"_U_ENFAP("DOC")_U_ENFAP("AO")_U_ENFAP("TRANS")
 ; add remaining data to first segment
FA I ENFAP("DOC")="FA" D
 . D FANUM^ENFAXMT3(1)
 . S ENFAP("GRP")=$$GROUP^ENFAVAL($$GET1^DIQ(6914,ENEQ("DA"),18))
 . S ENFAP("CMR")=$E($$GET1^DIQ(6914,ENEQ("DA"),19),1,5)
 . S ENFAP("LOC")=$$LOC^ENFAVAL(ENFAP("CMR"))
 . S X(1)=X(1)_U_ENFAP("GRP")_U_ENFAP("LOC")
 . D BUDFY^ENFAXMT3($P(ENEQ(9),U,7))
 . S X(1)=X(1)_"^^"_ENFAP("FUND")_U_ENFAP("AO")
 . D XORG,XPROG^ENFAXMT3
 . S X(1)=X(1)_U_$$GET1^DIQ(6914,ENEQ("DA"),61)_U_$$GET1^DIQ(6914,ENEQ("DA"),18)
 . D ACQTIME,ACQMETH,XAREA,FUNDSRC
 . I ENFAP("TY")="X" S X(1)=X(1)_"^^^^^^" ; excessed
 . E  D REPLTIME,LIFEXP,SALDEPM
 . D SUMAV,COSTCEN
 . D SUBORG
 . S $P(X(1),U,33)="~"
FB I ENFAP("DOC")="FB" D
 . S X(1)=X(1)_"^^^^^"
 . D FANUM^ENFAXMT3(1) S X(1)=X(1)_U_$P(ENFAP(3),U,7,8)
 . D CVTDATE($P($G(^ENG(6915.3,ENFB("DA"),100)),U))
 . S X(1)=X(1)_U_$P(ENFAP(3),U,12)
 . S $P(X(1),U,26)="~"
FC I ENFAP("DOC")="FC" D
 . S X(1)=X(1)_"^^^^^"
 . D BUDFY^ENFAXMT3($P(ENEQ(9),U,7))
 . S X(1)=X(1)_"^" ;No END BUDGET FY
 . D FANUM^ENFAXMT3(1) S X(1)=X(1)_U_$P(ENFAP(3),U,8)
 . I $P(ENFAP(3),U,8)="00" D  Q  ;FC against an FA
 . . S X=$$GROUP^ENFAVAL($$GET1^DIQ(6915.4,ENFC("DA"),100))
 . . S X(1)=X(1)_U_$S(X="0":"",1:X) ; csn may not have been entered
 . . S X(1)=X(1)_U_$$LOC^ENFAVAL($$GET1^DIQ(6915.4,ENFC("DA"),101))
 . . S X(1)=X(1)_U_$$GET1^DIQ(6915.4,ENFC("DA"),100) ;Description (CSN)
 . . D ACQTIME,ACQMETH S $P(X(1),U,32)="~"
 . S X(1)=X(1)_"^^" ;FC against a betterment
 . S X(1)=X(1)_U_$P(ENFAP(3),U,11)
 . D CVTDATE($P(ENFAP(100),U,6)) ; acquisition date from FC
 . S X(1)=X(1)_U_$P(ENFAP(3),U,15) ; acquisition method from FC
 . S $P(X(1),U,32)="~"
FD I ENFAP("DOC")="FD" D
 . S X(1)=X(1)_"^^^^^"
 . D BUDFY^ENFAXMT3($P(ENEQ(9),U,7))
 . S $P(X(1),U,12)="~"
FR I ENFAP("DOC")="FR" D
 . S X(1)=X(1)_"^^^^^"
 . D FANUM^ENFAXMT3(1)
 . S X(1)=X(1)_U_$P(^ENG(6915.6,ENFR("DA"),3),U,7,8)_"^^"_$P(^(3),U,9,18)
 . S $P(X(1),U,25)="~"
 ;end of Fx1 document
 D:ENFAP("DOC")'="FR" ^ENFAXMT1
 D SEND^ENFAXMT2
 ;
K K X,Y ;Campground cleanup performed by calling routine
 Q
 ;
FUNDXDIV S X(1)=X(1)_U_ENFAP("FUND")_U_ENFAP("AO") Q
 ;
XORG S X(1)=X(1)_U_$E(ENFAP("STATION"),1,3) Q
 ;
ACQTIME S X=$P(ENEQ(2),U,4)
 S X(1)=X(1)_U_($E(X,1,3)+1700)_U_$E(X,4,5)_U_$E(X,6,7)
 Q
 ;
ACQMETH S X(1)=X(1)_U_$P(ENEQ(3),U,4) Q
 ;
XAREA S X(1)=X(1)_U_ENFAP("CMR") Q
 ;
FUNDSRC S X(1)=X(1)_U_$E($P(ENEQ(2),U,4),2,3)_$E(ENFAP("FUND"),1,4)_ENFAP("CFO") Q
 ;
REPLTIME S X=$P(ENEQ(2),U,10)
 I X="" S X(1)=X(1)_"^^^" Q
 S X(1)=X(1)_U_($E(X,1,3)+1700)_U_$E(X,4,5)_U_$E(X,6,7) Q
 ;
LIFEXP S X(1)=X(1)_U_$P(ENEQ(2),U,6) Q
SALDEPM S X(1)=X(1)_"^0.00^SL" Q  ;Salvage value & Deprec. method
 ;
SUMAV ;Summary asset value
 S X(1)=X(1)_U_$P(ENEQ(2),U,3) Q
 ;
COSTCEN S X(1)=X(1)_U_$$GET1^DIQ(6914,ENEQ("DA"),"19:10") ; cost center num
 S X(1)=X(1)_U ; not passing sub-cost center
 Q
 ;
SUBORG ;Used for satellite designator
 I $E(ENFAP("STATION"),4,5)?2UN S X(1)=X(1)_U_$E(ENFAP("STATION"),4,5)
 E  S X(1)=X(1)_U
 Q
CVTDATE(ENX) ; year^month^date from FileMan date
 I ENX="" S X(1)=X(1)_"^^^" Q
 S X(1)=X(1)_U_($E(ENX,1,3)+1700)_U_$E(ENX,4,5)_U_$E(ENX,6,7) Q
 ;ENFAXMT
