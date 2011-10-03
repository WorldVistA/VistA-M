PRCNPRNT ;SSI/SEB-Display an NX transaction ;[ 01/30/97  1:30 PM ]
 ;;1.0;PRCN;**3**;Sep 13, 1996
 ;
 ; Needs IN to be set to internal # of transaction,
 ; PRCNUSR = user code: 0:requestor/CMR official, 1=PPM Committee I,
 ; 2=Engineering Committee, 3=PPM II, 4=Director, 5=Concurring Officials,
 ; 6=PPM III, 7=VACO Chief of Supply, 8=Equipment Committee.
 ;
 S DIC("A")="Enter TRANSACTION #: ",DIC="^PRCN(413,",DIC(0)="AEQ" D ^DIC
 S IN=+Y G EXIT:IN<0 S ST=$P(^PRCN(413,IN,0),U,7),PRCNTDA=$P(^(0),U,11)
 S PRCNUSR=$S(ST<4:0,ST<7:1,ST=7!(ST=13):4,ST=8!(ST=11):2,ST=28:7,ST=15!(ST=32):6,ST=26!(ST=27)!(ST=30):3,ST=10!(ST=20)!(ST=29)!(ST=33):8,ST<15:5,1:3)
SETUP ; Set up necessary variables & open device
VIEWA W !!,"Do you want to view the information related to this request"
 S %=1 D YN^DICN Q:%=2!(%<0)
 I %=0 D  G VIEWA
 . W !,"Enter 'YES' if you want to see a display of the information related"
 . W !,"to this request."
 S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D QUE^PRCNPR2 Q
 Q:$D(DUOUT)  I $E(IOST)="C" W @IOF
 I $E(IOST)'="C" U IO
BEG S NL=0,FF=0,PRCNDEEP=0,N=413,GLO="^PRCN(413,",OFN=.01,PROG="PRNT"
FORMAT ; Deal with special field formatting
 S F(413)="3^5^6^7^15^16^30^55^56^57^46",F(413.015)=".01^2^4^6"
 S F(413.028)=.01,F(413.046)=1,F(6914)="1^4"
SUBS ; Handle subfields
 G:PRCNDEEP=0 REQCMR I N=413.015 D  Q
 . F FN=.01,1,15,2:1:8 Q:$D(DUOUT)  D PRFLD(FN)
 . Q:$D(DUOUT)  D:PRCNUSR>1 PRFLD(13)
 . W !
 I N=413.046 D  Q
 . S PNAME=$P(@(GLO_"IN,0)"),U),NAME=$P(^PRCN(413.3,PNAME,0),U)
 . W !,?4,"NAME: ",$P(^VA(200,NAME,0),U),?45,"TITLE: "
 . S TITLE=$P(^VA(200,NAME,0),U,9) W:TITLE]"" $P(^DIC(3.1,TITLE,0),U)
 . F FN=1,2,4 Q:$D(DUOUT)  D PRFLD(FN)
 . S:$P($G(@(GLO_IN_",0)")),U,2)="N" QF=""
 Q:$D(DUOUT)  S FN=0
 F  S FN=$O(^DD(N,FN)) Q:FN="B"!($D(DUOUT))  D PRFLD(FN)
 Q
TURNIN ; Print stuff for turn-in
 S IN=$P(^PRCN(413.1,TDA,1,TI,0),U),PRCNTDA=TDA
TI2 S F(6914)="1^4",N=6914,GLO="^ENG(6914,",PRCNDEEP=1,FF=0
 I '$D(IOST) D  Q:POP>0
 . S %ZIS="Q" D ^%ZIS
 . I $D(IO("Q")) D QUT^PRCNPR2 Q
TN I $E(IOST)'="C" U IO
 S FN=.01 D PRFLD(FN) Q:$D(DUOUT)  S FF=0
 F FN=3,1,4,5,17,18,12,13,19,16,24 D PRFLD(FN) Q:$D(DUOUT)
 S F(413.11)=".5^.7^1",N=413.11,GLO="^PRCN(413.1,"_PRCNTDA_",1,",PRCNDEEP=1,FF=0
 F FN=.5,.7,1 NEW IN S IN=TI D PRFLD(FN) Q:$D(DUOUT)
 S IN=TDA,F(413.1)=16,N=413.1,GLO="^PRCN(413.1,",PRCNDEEP=1,FF=0
 F FN=16 D PRFLD(FN) Q:$D(DUOUT)
 W !
 Q
REQCMR ; Print fields seen by requestor/CMR official review
 F FN=.01,1:1:15 D PRFLD(FN) Q:$D(DUOUT)
 I $P(^PRCN(413,IN,0),U,9)="R" S (PRCNTDA,TDA)=$P(^(0),U,11),TI=0 D
 . W !!,"TURN-IN LINE ITEMS:" S NL=NL+1 D CHKPG Q:$D(DUOUT)
 . S TMP=IN F  S TI=$O(^PRCN(413.1,TDA,1,TI)) Q:TI'>0!($D(DUOUT))  D
 .. W !,?4,"EQ. REQUEST LINE NUMBER: ",$P(^PRCN(413.1,TDA,1,TI,0),U,3)
 .. D CHKPG,TURNIN:'$D(DUOUT)
 . S N=413,GLO="^PRCN(413,",IN=TMP,PRCNDEEP=0 K TMP
 Q:$D(DUOUT)  F FN=126,16:1:31,100:1:104 D PRFLD(FN) Q:$D(DUOUT)
PPM ; Print fields seen by PPM 1 official review
 G:PRCNUSR<1!($D(DUOUT)) EXIT
 S FN2=$S($P($G(^PRCN(413,IN,2)),U,16)="N":105,1:34) S:FN2=105 QF=""
 F FN=32,FN2 D PRFLD(FN) Q:$D(DUOUT)!($D(QF))
ENGIN ; Print fields seen by Engineering Committee
 G:PRCNUSR<2!($D(DUOUT))!($D(QF)) EXIT
 D PRFLD(35),PRFLD(121):$P($G(^PRCN(413,IN,4)),U)="N"
PPM2 ; Print fields seen by PPM 2 official review
 G:PRCNUSR<3!($D(DUOUT))!($D(QF)) EXIT
 F FN=52:1:72,74,117:1:120 D PRFLD(FN) Q:$D(DUOUT)
CONCUR ; Print fields seen by Concurring Official
 G:PRCNUSR<5!($D(DUOUT))!($D(QF)) EXIT
PPM3 ; Print fields seen by PPM 3 official review
 G:PRCNUSR<6!($D(DUOUT))!($D(QF)) EXIT
 F FN=45,46,49 D PRFLD(FN) Q:$D(DUOUT)
CHIEF ; Print fields seen by VACO Chief of Supply
 G:PRCNUSR<7!($D(DUOUT))!($D(QF)) EXIT S PRCNDATA=$G(^PRCN(413,IN,4))
 F FN=36,37 D PRFLD(FN) Q:$D(DUOUT)
EQUIP ; Print fields seen by Equipment Committee
 G:PRCNUSR<8!($D(DUOUT))!($D(QF)) EXIT
 I $P($G(^PRCN(413,IN,8)),U,9)]"" F FN=77 D PRFLD(FN) Q:$D(DUOUT)
EXIT K DUOUT,QF I $E(IOST)'="C" W @IOF
 K CODES,F,FF,FN,FN2,GLO,I,ID,J,N,N2,NEWL,NL,OFN,OGLO,OID,OIN,PNAME
 K OPC,PC,PGL,PRCNDATA,PRCNDD,PRCNDEEP,PROG,PV,VAL,C,V,NAME
 D ^%ZISC
 Q
PRFLD(FN) ; Print a single field
 I $$ISWP(FN) S FF=0 G PR2
 G:'$D(F(N)) PR2 I F(N)="" S FF=0 G PR2
 F I=1:1 S NEWL=$P(F(N),U,I) Q:NEWL=""!(NEWL=FN)
 S:NEWL=FN!(PRCNDEEP>1) FF=0
PR2 D:'FF CHKPG Q:$D(DUOUT)  X "W "_$S(FF:"?41",1:"!") S FF='FF
 D PR^PRCNPR2 S:$$ISWP(FN) FF=0 Q
CHKPG ; Clear screen if it is full & start new one
 I $G(C)=U Q
 S NL=NL+1 Q:NL<(IOSL-4)  I $E(IOST)'="C" W @IOF S NL=0 Q
 F  R !!,"Press RETURN to continue, or '^' to exit. ",C:DTIME S:'$T C=U Q:U[C  W $C(7)
 I C="^" S DUOUT="" Q
 W @IOF S NL=0 Q
ISWP(FN) ; Check if field is word-processing or similar
 S N2=$P(^DD(N,FN,0),U,2) Q:N2="W" 1 Q:+N2=0 0 Q ($P(^DD(+N2,0),U,4)=1)
