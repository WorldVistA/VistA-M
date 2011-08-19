SDCP ;BSN/GRR - CLINIC LIST ; 15 MAR 1999  4:10 PM ;
 ;;5.3;Scheduling;**140,171,187,354**;Aug 13, 1993
 D ASK2^SDDIV G:Y<0 END S VAUTNI=1 D CLINIC^VAUTOMA G:Y<0 END
QUE N ZTSAVE F Y="VAUTD","VAUTD(","VAUTC","VAUTC(" S ZTSAVE(Y)=""
 D EN^XUTMDEVQ("START^SDCP","Clinic Profile",.ZTSAVE) Q
 ;
START ;Print report
 S END=0 D:'$D(DT) DT^SDUTL
 S Y=DT D DTS^SDUTL S PDATE=Y,SCN=0 D TOF G:'VAUTC SOME
 F  S SCN=$O(^SC("B",SCN)) Q:SCN=""!(END)  S SC=$O(^SC("B",SCN,0)) D:$$CHECK() SET0,SETSL,PRT
 G END
 ;
SOME F  S SCN=$O(VAUTC(SCN)) Q:SCN=""!(END)  S SC=+VAUTC(SCN) D:$$CHECK() SET0,SETSL,PRT
 G END
 ;
END W ! I $E(IOST)="C",'$G(END,1) N DIR S DIR(0)="E" D ^DIR
 K ABBR,ALV,C,DAYS,DIC,DIPH,DOW,END,HCDB,I,J,L,LOC,LOP,M,NAME,ODM,PC,PDATE,POP,SC,SCSC,SDSC,SDMX,SDNO,SDNO,SDC,SDCR,SCSC,SCN,SDIN,SDPR,SDRE,STCD,STDAT,X,Y,SD,SDCNT,VAUTC,VAUTD,VAUTNI,STRING Q
 ;
SET0 S STRING=^SC(SC,0)
 S NAME=$P(STRING,U,1),ABBR=$P(STRING,U,2),LOC=$P(STRING,U,11),(STCD,SDSC)=$P(STRING,U,7),SDCR=$P(STRING,U,18),SDCNT=$P(STRING,U,17)
 S:$D(^SC(SC,"SDP")) SDMX=$P(^SC(SC,"SDP"),U,2) Q
 ;
SETSL S (LOP,HCDB,ALV,PC,ODM,DIPH,STDAT,STRING)="",STCD=$S(STCD="":" ",1:STCD),STCD=$S('$D(^DIC(40.7,+STCD,0)):"",1:$P(^(0),U,2)),SDSC=$S($D(^DIC(40.7,+SDSC,0)):'$P(^(0),U,3)!($P(^(0),U,3)>DT),1:0)
 S SDPR=$S('$D(^SC(SC,"SDPROT")):"NO",'$L($P(^("SDPROT"),U)):"NO",1:"YES")
 S SDCR=$S(SDCR="":" ",1:SDCR),SDCR=$S('$D(^DIC(40.7,+SDCR,0)):"",1:$P(^(0),U,2))
 I $D(^SC(SC,"SL")) S STRING=^("SL"),LOP=$P(STRING,U,1),HCDB=$P(STRING,U,3),ALV=$S($P(STRING,U,2)["V":"YES",1:"NO")
 I  S PC=$S($P(STRING,U,5)]"":$P(^SC($P(STRING,U,5),0),U,1),1:""),ODM=$P(STRING,U,7),DIPH=$S($P(STRING,U,6)=4:15,$P(STRING,U,6)=3:20,$P(STRING,U,6)=1:60,$P(STRING,U,6)=2:30,1:10)
 S STDAT=$O(^SC(SC,"T",0)) S:STDAT<1 STDAT="UNKNOWN"
 K DOW F L=0:1:6 F M=DT-.1:0 S M=$O(^SC(SC,"T"_L,M)) Q:M=""  I $D(^(M,1)) S:^(1)]"" DOW(L+1)="" Q:^(1)]""  K DOW(L+1)
 F L=DT-.1:0 S L=$O(^SC(SC,"T",L)) Q:L=""  S X=L D DW^%DTC I '$D(DOW(Y+1)),$D(^SC(SC,"OST",L,1)),^(1)["[" S DOW(Y+1)=""
 S DAYS="" F M=1:1:7 I $D(DOW(M)) S DAYS=DAYS_$S(DAYS'="":",",1:"")_$P("SU^MO^TU^WE^TH^FR^SA",U,M)
 Q
 ;
L(SDT,SDCOL,SDVAL) ;Print field label
 ;Input: SDT=field label
 ;Input: SDCOL=column to line up to
 ;Input: SDVAL=field value
 W ?(SDCOL-$L(SDT)-2),SDT,": ",SDVAL Q
 ;
PRT I $Y+12>IOSL D:IOSL<25 SEEND:$E(IOST,1,2)="C-" Q:END  D TOF
 S SDNO="" W ! D L("Clinic",19,NAME),L("Abbr.",62,ABBR)
 W ! D L("Location",19,$E(LOC,1,30)),L("Telephone",62,$S($D(^SC(SC,99)):^SC(SC,99),1:""))
 W ! D L("Days clinic meets",19,DAYS) I 'SDNO S Y=STDAT D:STDAT'="UNKNOWN" DTS^SDUTL
 D L("Start date",62,$S(STDAT="UNKNOWN":"UNKNOWN",1:Y))
 W ! D L("Increments",19,DIPH_" Minutes"),L("Hour display begins",62,$S(HCDB="":"8 AM",HCDB<13:HCDB_" AM",1:HCDB-12_" PM"))
 W ! D L("Appt. length",19,LOP_" Minutes"),L("Variable length appts.",62,ALV)
 W ! D L("Stop Code",19,STCD),L("Maximum overbooks per day",62,ODM)
 W ! D L("Credit Stop Code",19,SDCR),L("Non-count clinic",62,$S(SDCNT="Y":"YES",1:"NO"))
 W ! D L("Prohibit access",19,SDPR),L("Maximum days for future booking",62,$G(SDMX))
 I PC]"" W ! D L("Principal clinic",19,PC)
 I $D(^SC(SC,"I")) S SDRE=+$P(^("I"),U,2),SDIN=+^("I") I SDRE'=SDIN D:SDIN'>DT&(SDRE=0!(SDRE>DT)) INACT
 I 'SDNO,$D(SDIN),SDIN>DT,SDRE'=SDIN W !!,?4,"**** Clinic will be inactive ",$S(SDRE:"from ",1:"as of ") S Y=SDIN D DTS^SDUTL W Y S Y=SDRE D:Y DTS^SDUTL W $S(SDRE:" to "_Y,1:"")," ****" K SDIN,SDRE
 I 'SDSC W !!,?4,"*** INVALID OR INACTIVE STOP CODE ASSIGNED TO THIS CLINIC ***"
 Q
 ;
INACT S Y=SDIN D DTS^SDUTL W !!,?4,"**** Clinic is inactive ",$S(SDRE:"from ",1:"as of "),Y S Y=SDRE D:Y DTS^SDUTL W $S(SDRE:" to "_Y,1:"")," ****" K SDIN,SDRE S SDNO=1
 Q
 ;
SEEND W ! N DIR S DIR(0)="E" D ^DIR S END=Y'=1 Q:END
TOF W @IOF,?22,"CLINIC PROFILES AS OF: ",PDATE,! Q
 ;
CHECK() ;Check location for inclusion
 I $D(^SC(SC,0)),($P(^(0),U,3)="C"),$S(VAUTD:1,$D(VAUTD(+$P(^(0),U,15))):1,'$P(^(0),U,15)&($D(VAUTD($O(^DG(40.8,0))))):1,1:0) Q 1
 Q 0
 ;
 ;
PAUSE(LINE) ;
 N Y S Y=1
 I $E(IOST,1,2)="C-",(LINE+5)>IOSL D PAUSE^VALM1 S LINE=0
 S LINE=LINE+1
 Q Y
