RTQ2 ;MJK,JSM/TROY ISC;Scheduling Link; ; 5/21/87  3:09 PM ;
 ;;2.0;Record Tracking;**13,15,21,45**;10/22/91;Build 7
BLD I $D(SDPL) S RTINP=+$P(^RTV(195.9,RTB,0),"^",3)
 E  S RTINP=0
 F RTBLD=0:0 S RTBLD=$O(^RTV(195.9,RTB,"RECS",RTBLD)) Q:'RTBLD  S X=$G(^(RTBLD,0)) I X]"" D
 . I $D(RTINP(RTINP)) Q  ; don't create for inpts
 . I $P($G(^DIC(195.1,+RTINP,4)),"^",3)="n",'$D(^RT("AT",+X,DFN_";DPT(")) Q  ; don't create record, no record exists
 . D BLD1 S RTSD=""
 Q
 ;
BLD1 Q:$S('$D(^DIC(195.2,+X,0)):1,$P(X,"^",2)']"":1,$P(X,"^",2)="n":1,1:0)
 S RTTY=+X,RTTYR(+X)="",RTAPL=+$P(X,"^",3),RTSEL=$C($A($P(X,"^",2))-32)
BLD2 S (L,L1)=0 F I=0:0 S I=$O(^RT("AT",RTTY,RTE,I)) Q:'I  I $D(^RT(I,0)) S:RTSEL["A" RTSD(I)=+RTAPL S:$P(^(0),"^",7)>L L=$P(^(0),"^",7),L1=I
 I 'L1 K RTSHOW D TYPE1^RTDPA1 S RTTY=+RTTY G BLD2
 S:RTSEL["L" RTSD(L1)=+RTAPL
 Q
 ;ent from SD
CREATE Q:'$D(^SC(SDSC,0))  S Y=^(0),RTB=SDSC_";SC(",RTA=+^DIC(195.4,1,$S(SDPL:"MAS",$P(Y,"^",3)="I":"RAD",1:"MAS")) D CHK S Y=+$P(^RTV(195.9,Y,0),"^",12)
 S RTAPPIEN("MAS")=+^DIC(195.4,1,"MAS"),RTAPP("MAS")=$G(^DIC(195.1,RTAPPIEN("MAS"),4))
 S RTAPPIEN("RAD")=+^DIC(195.4,1,"RAD"),RTAPP("RAD")=$G(^DIC(195.1,RTAPPIEN("RAD"),4))
 ;exclude inpatients by app
 K RTINP I SDPL,$D(^DPT(DFN,.1)),^(.1)]"" DO
 .I +RTAPP("MAS") S RTINP(RTAPPIEN("MAS"))=""
 .I +RTAPP("RAD") S RTINP(RTAPPIEN("RAD"))=""
 I $D(RTINP(RTAPPIEN("MAS"))),$D(RTINP(RTAPPIEN("RAD"))) K RTINP Q
 ;
 I '$D(RTCLEX),$D(RTEXCLUD)>9,$D(^DPT(DFN,"S",SDTTM,0)),RTEXCLUD(RTA)[(U_$P(^(0),"^",16)_U) Q
 I $D(^RTV(195.9,Y,0)),$P(^(0),"^")[";SC(",$D(^SC(+^(0),0)) S SDSC=+^RTV(195.9,Y,0),RTB=Y
 I '$D(^SC("ARAD",SDSC,SDTTM,DFN)),$P(^RTV(195.9,RTB,0),"^",14)="n" Q
 S Y=^SC(SDSC,0),RTE=DFN_";DPT(",RTPLTY=1,(RTQDT,X)=SDTTM,RTPN=$P(Y,"^")_" ["_$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_"]"
 S X=RTB,A=+RTA K RTA,RTSD,RTDIV D INST1^RTUTL G Q:'$D(RTINST) S RTDIV=RTINST
 G Q:$S('SDPL:0,'$D(^SC(SDSC,"S",SDTTM,1,SDPL,0)):1,DFN'=+^(0):1,$P(^(0),"^",9)["C":1,$D(^("RTR")):1,1:0) D BLD
 I SDPL,'$D(RTSD) F RTBLD=0:0 S RTBLD=$O(^DIC(195.1,RTAPPIEN("MAS"),"MAS",RTBLD)) Q:'RTBLD  I $D(^(RTBLD,0)) S X=^(0) D
 . I $D(RTINP(RTAPPIEN("MAS"))) Q  ; don't create for inpatients
 . I $P(RTAPP("MAS"),"^",3)="n",'$D(^RT("AT",+X,DFN_";DPT(")) Q  ; don't create record, no record exists
 . D BLD1
 I SDPL,$D(^SC("ARAD",SDSC,SDTTM,DFN)),$P(^(DFN),"^")'["N" F RTBLD=0:0 S RTBLD=$O(^DIC(195.1,RTAPPIEN("MAS"),"RAD",RTBLD)) Q:'RTBLD  I $D(^(RTBLD,0)) S X=^(0) D  ; only stored under MAS application
 . I $D(RTINP(RTAPPIEN("RAD"))) Q  ; don't create for inpatients
 . I $P(RTAPP("RAD"),"^",3)="n",'$D(^RT("AT",+X,DFN_";DPT(")) Q  ; don't create record, no record exists
 . D BLD1:'$D(RTTYR(+X))
 D RTSD I $D(RTPAR),SDPL D RTSET^SDUTL
Q K RTINP,RTAPP,RTAPPIEN,RTBLD,RTTYR,RTBKGRD,RTPAR,RTSD,RT,RTSEL
 K A,Z,L,L1,I,RTINST,RTDIV,RTPULL,RTPN,RTTY,RTTYP,RTAPL,RTQ,RTY,RTS,RTQDT,RTB,RTPLTY,RTE D CLOSE^RTUTL Q
 ;
PULL F I=0:0 S I=$O(^RTV(194.2,"B",RTPN,I)) Q:'I  I $D(^RTV(194.2,I,0)),$P(^(0),"^",15)=+RTAPL,$P(^(0),"^",2)=$P(RTQDT,".") Q
 I I S RTPULL=I Q
 S I=$P(^RTV(194.2,0),"^",3)
LOCK S I=I+1 L +^RTV(194.2,I):1 I '$T!$D(^RTV(194.2,I)) L -^RTV(194.2,I) G LOCK
 S ^RTV(194.2,I,0)=RTPN_"^^^^^^^^^^^^^^"_+RTAPL,^RTV(194.2,"B",RTPN,I)="",^RTV(194.2,"AC",+RTAPL,I)="",^(0)=$P(^RTV(194.2,0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1),^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RTV(194.2,")=I L -^RTV(194.2,I)
 S (DA,RTPULL)=I,DR="[RT PULL LIST]",DIE="^RTV(194.2," D ^DIE K DQ,DE Q
 ;
CANCEL Q:'$D(^RTV(190.1,+RTPAR,0))  S (RTQ,RTPAR)=+RTPAR,RTCAN="I $P(^(0),""^"",6)'=""x"" S DA=RTQ,DIE=""^RTV(190.1,"",DR=""[RT CHANGE REQUEST STATUS]"",RTSTAT=""x"" D ^DIE K DQ,DE" X RTCAN
 F RTQ=0:0 S RTQ=$O(^RTV(190.1,"APAR",RTPAR,RTQ)) Q:'RTQ  I $D(^RTV(190.1,RTQ,0)) X RTCAN
 K RTCAN,RTQ,RTSTAT Q
 ;
RTSD K RTPAR F RT=0:0 S RT=$O(RTSD(RT)) Q:'RT  S RTB=SDSC_";SC(",(RTA,RTAPL)=+RTSD(RT) D CHK K RTA,RTQ D PULL:SDPL,SET^RTQ K:'$D(RTQ) RTSD(RT) I '$D(RTPAR),$D(RTQ) S RTPAR=RTQ
 Q
 ;
CHK S Y=+$O(^RTV(195.9,"ABOR",RTB,RTA,0)) D SET^RTDPA3:'Y S RTB=Y Q
 ;
QUE I SDPL,$P(SDTTM,".")=DT S X="I",RTCLEX="" D SAVE^RTQ3,ASK^RTQ3 K RTESC S:$E(X)'="Y" RTESC="" S X="I" D RESTORE^RTQ3 S X=SDTTM I $D(RTESC) K RTESC,RTCLEX Q
 ;
 I $P(SDTTM,".")'=DT,SDPL,SDRT="A",$P(^DIC(195.4,1,0),"^",5) Q
 ;S SAVX=X
 X ^%ZOSF("UCI") S ZTUCI=Y,ZTRTN="DQ^RTQ2",ZTDTH=$H
 F V="DUZ(0)","SDSC","SDTTM","SDPL","DFN","RTCOM","RTCLEX" I $D(@V) S ZTSAVE(V)=""
 S ZTDESC="MAS/X-RAY Record Request Link",ZTIO=$P(^DIC(195.4,1,0),"^",3) K H,V,ZTSK N X D ^%ZTLOAD Q
 ;
DQ S RTBKGRD="",U="^" K V S X="T",%DT="" D ^%DT S DT=Y
 ;I $P(^DIC(195.4,1,0),"^",5) S SDPL=0
 G CREATE
 ;
 ;
DOC ;
 ;
 ;
 ;
 ;    in: SDSC=clinic#, SDTTM=appt d/t, DFN=patient#
 ;    out: RTPAR=parent request#, RTSD(n)=volumes selected
