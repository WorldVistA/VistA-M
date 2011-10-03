PRCNTIPR ;SSI/SEB-Display a NX Turn-in request ;[ 02/18/97  4:12 PM ]
 ;;1.0;PRCN;**2,3**;Sep 13, 1996
EN S DIC("A")="Select Turn-In TRANSACTION #: ",DIC="^PRCN(413.1,",DIC(0)="AEQ"
 D ^DIC G EXIT:Y<0 S (IN,PRCNTDA)=+Y,PRCNUSR=2
SETUP ; Set up necessary variables & open device
 S %ZIS="Q" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="BEG^PRCNTIPR",ZTDESC="Equipment Request"
 . S ZTSAVE("IN")="",ZTSAVE("PRCNUSR")="",ZTSAVE("PRCNTDA")=""
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q"),ZTSK,%ZTLOAD,ZTREQ
 G EXIT:$D(DUOUT) I $E(IOST)="C" W @IOF
BEG S NL=0,FF=0,PRCNDEEP=0,N=413.1,GLO="^PRCN(413.1,",PROG="TIPR",OFN=.01
FORMAT ; Deal with special field formatting
 S F(413.1)="2^3^5^6^7^20"
REQCMR ; Print fields for requestor display or CMR Official review
 F FN=.01,1,2,3,4,5,6,7 D PRFLD(FN) Q:$D(DUOUT)
 I PRCNUSR>0!($G(ST)=4) F FN=9,11 D PRFLD(FN) Q:$D(DUOUT)
 G EXIT:$G(TIF)=1
 S TI=0 D
 . W !!,"TURN-IN LINE ITEMS:" S NL=NL+1 D CHKPG Q:$D(DUOUT)
 . F  S TI=$O(^PRCN(413.1,PRCNTDA,1,TI)) Q:TI'>0!($D(DUOUT))  D
 .. W !!,?4,"EQ. REQUEST LINE NUMBER: ",$P(^PRCN(413.1,PRCNTDA,1,TI,0),U,3) S NL=NL+1
 .. S (IN,PRCNEIN)=$P(^PRCN(413.1,PRCNTDA,1,TI,0),U),TDA=PRCNTDA D TI2^PRCNPRNT
 .. Q:$D(DUOUT)  S IN=PRCNTDA
 .. S PRCNTT=0,PRCNDT=0
 .. F  S PRCNDT=$O(^ENG(6914,PRCNEIN,6,PRCNDT)) Q:'PRCNDT  S PRCNXX=^(PRCNDT,0) D
 ... F PRCNJ=5:1:7 S PRCNTT=PRCNTT+$P(PRCNXX,U,PRCNJ)
 .. W !,"TOTAL REPAIR COSTS: ",PRCNTT S NL=NL+1
 .. D CHKPG
PPM ; Print field seen by PPM
EXIT K DUOUT,QF,DIC,NL,FF,PRCNDEEP,N,N2,GLO,PROG,OFN,F,TIL,FN,PRCNEIN
 K CODES,PRCNXX,PRCNTT,OIN,PC,PGL,PRCNDD,PRCNDT,PRCNJ
 K TDA,TI,NEWL,OGLO,OID,OPC,PV,I,ID,C
 I $E(IOST)'="C" W @IOF
 D ^%ZISC
 Q
SUBS ; Handle subfields
 I N=413.11 S TIL=$P(@(GLO_"IN,0)"),U) W !,?4,"NUMBER: ",TIL,?41 D
 . W "DESCRIPTION: ",$P(^ENG(6914,TIL,0),U,2),!
 Q:N=413.11!($D(DUOUT))  S FN=0
 F  S FN=$O(^DD(N,FN)) Q:FN="B"!($D(DUOUT))  D PRFLD(FN)
 Q
PRFLD(FN) ; Print a single field
 I $$ISWP(FN) S FF=0 G PR2
 G:'$D(F(N)) PR2 I F(N)="" S FF=0 G PR2
 F I=1:1 S NEWL=$P(F(N),U,I) Q:NEWL=""!(NEWL=FN)
 S:NEWL=FN!(PRCNDEEP>1) FF=0
PR2 D:'FF CHKPG G PQ:$D(DUOUT) X "W "_$S(FF:"?41",1:"!") S FF='FF
 D PR^PRCNPR2 S:$$ISWP(FN) FF=0
PQ K NEWL,C Q
CHKPG ; Clear screen if it is full & start new one
 S NL=NL+1 Q:NL<(IOSL-2)  I $E(IOST)'="C" W @IOF S NL=0 Q
 F  R !!,"Press RETURN to continue, or '^' to exit. ",C:DTIME S:'$T C=U Q:C[U  W $C(7)
 I C="^" S DUOUT="" Q
 W @IOF S NL=0 Q
ISWP(FN) ; Check if field is word-processing or similar
 S N2=$P(^DD(N,FN,0),U,2) Q:N2="W" 1 Q:+N2=0 0 Q ($P(^DD(+N2,0),U,4)=1)
