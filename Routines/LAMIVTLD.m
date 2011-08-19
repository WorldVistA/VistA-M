LAMIVTLD ;SLC/RWF/DAL/DRH-VITEK BUILD DOWNLOAD FILE ;7/18/89  11:51
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12,33,42,48**;Sep 27, 1994
 ;Call with LRLL = load list to build
 ;Call with LRINST = Auto Instrument pointer
A ;
 ;
 S:$D(ZTQUEUED) ZTREQ="@"
 S:'$D(T) T=LRINST
 D:'$D(^LA(LRINST,"O")) SETO^LAB S LREND=""
 Q:'$D(^LRO(68.2,LRLL,1,LRTRAY1))
 S:'$D(^LA(T,"P3")) ^("P3")=0 S ^("P3")=^("P3")+1
 ;
 S SZ=$P(^LAB(69.9,1,1),U,7) ;---Download full data
 ;
 F LRTRAY=LRTRAY1:0 Q:+LRTRAY'>0  D:$D(^LRO(68.2,LRLL,1,LRTRAY)) TRAY D
 .  S LRTRAY=$O(^LRO(68.2,LRLL,1,LRTRAY)) Q:LRTRAY'>0
 ;
 S LRECORD=$C(4)
 D SEN
TIK ;
 I $D(^LA("TP")) L +^LA("TP"):10 S C=1+^LA("TP",0),^(0)=C,^LA("TP",C)=T_"^Sent:~E" L -^LA("TP"):10
 ;
 L +^LA("Q"):10 S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=T L -^LA("Q"):10
 D NEW^LASET
 ;
 K C,CNT,DOB,I,J,LRAA,LRAD,LRADAT,LRADIA,LRAN,LRCOM,LRCTY,LRCUP,LRDC,LRDPF,LRECORD,LRNDA,LRPMD,PRPNM,LRPRE,LRRD,LRRT,LRS,LRSERV,LRSI,LRSP,LRSPEC,LRSSN,LRSUM,LRTC,LRWARD,LRWRD,PNM,Q,SEX,SSN,SZ,T Q
 ;-----------------------------------------------------------------------
TRAY ;
 F LRCUP=0:0 S LRCUP=$O(^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP)) Q:+LRCUP'>0  D
 .  S LRECORD=$C(5) D SEN,BLD S LRECORD=$C(4) D SEN
 Q
BLD ;
 S LRECORD=$C(2)
 D SEN
 S LRSUM=0,LRECORD=$C(30)_"mtmpr|"
 D SAMPLE S LRECORD=$C(3) D SEN
 QUIT
 ;
 ;-----------------------------------------------------------------------
SAMPLE ;
 S (LRSSN,DOB,LRWRD,LRS,LRDIA,LRADAT,LRWARD,LRSERV,LRDC,LRRT,LRRD,LRCOM,LREND)=""
 S LRL=^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP,0)
 S LRAA=+LRL
 S LRAD=$P(LRL,U,2)
 S LRAN=$P(LRL,U,3)
 D PNM
 I LRSSN']"" S LRECORD=LRECORD_"|pi"_LRAN D SUM G M
 I 'SZ S LRECORD=LRECORD_"|pi"_LRSSN D SUM G M
 S LRECORD=LRECORD_"pn"_$G(PNM)_"|pi"_$G(LRSSN)_"|"
 S:DOB]"" LRECORD=LRECORD_"pb"_DOB_"|"
 S:SEX]"" LRECORD=LRECORD_"ps"_SEX_"|"
 ;
 ;
 I LRWRD]"" D
 . S LRWRD=$S($L($P(LRWRD," ",1)_" "_$P(LRWRD," ",2))<7:$P(LRWRD," ",1)_" "_$P(LRWRD," ",2),1:$P(LRWRD," ",1)),LRWRD=$E(LRWRD,1,6)
 . S LRECORD=LRECORD_"pl"_$E(LRWRD,1,6)_"|"
 ;
 ;---------put in chk for setup wild cards-----------
 D ^LAMIVTL6
 ;S:LRWRD]"" LRECORD=LRECORD_"|w1"_LRWRD_"|"
 D:$L(LRECORD)>1 SUM
 ;----------------------End Patient section------------------------------
 ;
 S LRECORD=$C(30)
 S:LRS]"" LRECORD=LRECORD_"px"_$G(LRS)_"|"
 S:LRADIA]"" LRECORD=LRECORD_"po"_LRADIA_"|"
 S:LRADAT]"" LRECORD=LRECORD_"pa"_LRADAT_"|" D:$L(LRECORD)>1 SUM
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRWARD=$P(X,"^",7) S:LRWARD="" LRWARD="UNK" S LRSERV=$P(X,"^",9)
 ;
 S LRSERV=$G(VAIN(3))
 S LRDOC=$P(X,"^",8)
 S:LRDOC]"" LRDOC=$P($G(^VA(200,+LRDOC,0)),U)
 S:LRDOC="" LRDOC="UNKNOWN"
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,3),LRDC=$P(X,"^",1)
 S LRTC=$P(LRDC,".",2)
 S LRTC=$E(LRTC_"0000",1,2)_":"_$E(LRTC_"0000",3,4)
 S LRDC=$$Y2K^LRX(LRDC)
 S LRRD=$P(X,"^",3)
 S LRRT=$P(LRRD,".",2)
 S LRRT=$E(LRRT_"0000",1,2)_":"_$E(LRRT_"0000",3,4)
 S LRRD=$$Y2K^LRX(LRRD)
 S LRCOM=$P(X,"^",6),X=""
M F LRSPEC=0:0 S LRSPEC=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,LRSPEC)) Q:LRSPEC'>0  D T2
 ;
 Q
PNM ;Get patient name and SSN from an accession.
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0)
 S X=^LR(+X,0)
 S LRPNM="" S LRDPF=$P(X,U,2),DFN=$P(X,"^",3) D PT^LRX
 D ^VADPT D INP^VADPT
 S:$D(SSN) LRSSN=$E(SSN,1,3)_$E(SSN,5,6)_$E(SSN,8,11)
 ;----fileman can do this----------------------------------
 S DOB=$$Y2K^LRX(DOB)
 S (LRS,LRADIA,LRPMD,LRADAT)=""
 QUIT
 ;-------------------End patient Look-up--------------------------------
 ;
T2 ;
 ;-----\/------------------Bashfull ref. must go!
 ;
 S X=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,5,LRSPEC,0))
 S LRSP=$P(^LAB(62,$P(X,U,2),0),"^",1)
 S LRSI=$P(^LAB(61,+X,0),"^",2)
 ;
 ;
 S LRECORD=$C(30)_"si|ss"_$E(LRSP,1,6)_"|st"_$E(LRSI,1,6)_"|"
 S:SZ LRECORD=LRECORD_"sl"_LRWARD_"|sx"_$G(LRSERV)_"|"
 ;
 D:$L(LRECORD)>1 SUM
 I SZ S LRECORD=$C(30)_"s1"_$P($G(LRDC),"@")_"|s2"_LRTC_"|s3"_$P($G(LRRD),"@")_"|s4"_LRRT_"|sc"_LRCOM_"|" D:$L(LRECORD)>1 SUM
 ;
 S I=0
 F  S I=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,I)) Q:+I'>0  D
 .  S LRCTY=$P(^LAB(60,I,0),U,1),LRPRE=$P(^(0),U,21)
 .  I LRPRE]"" S LRECORD=$C(30)_"ci"_(LRPRE*100000+LRAN)_"|ct"_$E(LRCTY,1,6)_"|" D SUM
 ;
 S LRECORD=$C(29) D SUM S LRECORD=""
 QUIT
 ;
SUM ;
 I $A($E(LRECORD,1))=30 S LRSUM=LRSUM+13 D
 .  F J=1:1:$L(LRECORD) S LRSUM=LRSUM+$A($E(LRECORD,J))
 S:$A($E(LRECORD,1))=29 LRSUM=LRSUM+29,LRSUM=LRSUM#256,LRSUM=$E("0123456789abcdef",(LRSUM\16+1))_$E("0123456789abcdef",(LRSUM#16+1)),LRECORD=LRECORD_LRSUM,LRSUM=0
SEN S CNT=^LA(LRINST,"O")+1,^("O")=CNT,^("O",CNT)=LRECORD Q
