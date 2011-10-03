DVBHQDX ;ISC-ALBANY/PKE/PHH-HINQ IDCU,VBA diagnostic ; 3/23/06 7:56am
 ;;4.0;HINQ;**9,12,33,34,49,57**;03/25/92
EN S X="A" X ^%ZOSF("LPC") K X S U="^",DVBTSK=0 S:'$D(DTIME) DTIME=300 I $D(IO)<11 S IOP="HOME" D ^%ZIS K IOP
 S:'$D(DVBSTN) DVBSTN=$P(^DVB(395,1,0),U,2) I 'DVBSTN W !!,"Station number not defined in HINQ Parameters file. " D EX1 Q
 S DVBDXX=""
 S DVBZ="HINQ"_DVBSTN_" "_"E00000000000000SS12345678NMTEST,HINQ/ABCD1234"
 W !,"This test will take 30 seconds.  No input is required or allowed.",!,"Responses are from the Frame Relay Network, or remote VBA computer."
 W !,"Success in this test will return a message to the user"
AGN U IO(0) W !!,"Do you wish to continue" S %=1 D YN^DICN
 I %Y["?" G AGN
 I %'=1 D EX1 Q
 W !!
 S DVBIDCU=^DVB(395,1,"HQVD")_"^"_$P(^("HQ"),"^",11)
 S DVBLOG=$P(DVBIDCU,U),(DVBDEV,ION)=$P(DVBIDCU,U,4),DVBPU=$P(DVBIDCU,U,2),DVBID=$P(DVBPU,"-"),DVBPW=$P(DVBPU,"-",2)
 I DVBLOG'?3U1"."4U W !,"IDCU ADDRESS not correct in HINQ Parameter file #395" H 2 G END
 ;I '$L(DVBDEV) W !!,"DEVICE NAME not defined in HINQ DEVICE NAME of DVB #395" H 2 G END
 ;I '$L(DVBID) W !,"HINQ IDCU User ID not defined in IDCU USERNAME-PASSWORD parameter." H 2 G END
 ;I '$L(DVBPW) W !,"HINQ IDCU Password not defined in IDCU USERNAME-PASSWORD parameter." H 2 G END
 I $P(DVBIDCU,"^",6) S DVBLOG="VHA"_$P(DVBLOG,"DMS",2)
 ;U IO(0) W !,"HINQ device defined as ",DVBDEV,!!
 ;with DVB*4*49 there will be only one server - message will be 
 ;"Connecting to VBA"
 U IO(0) W !,"Connecting to VBA"
 ;
 S DVBIP=$P($G(^DVB(395,1,"HQIP")),"^")
 I DVBIP,DVBIP?1.3N1P1.3N1P1.3N1P1.3N
 E  W:'DVBTSK !?3,"RDPC IP Address not defined or invalid in DVB parameter file #395" H 3 G EX
 ;
 N DVBPORT,DVBSTN
 S DVBSTN=$P(^DVB(395,1,0),U,2)
 S DVBPORT=$$PORT^DVBHQDL(DVBSTN)
 D CALL^%ZISTCP(DVBIP,DVBPORT,"33")
 I POP G BUSY
 ; 
 S X=0 U IO X ^%ZOSF("EOFF"),^%ZOSF("TYPE-AHEAD"),^%ZOSF("RM") H 1 ;;;F Z=0:0 R *X:1 Q:'$T  U IO(0) W $C(X) U IO
 S C=0
NAM ;;;U IO W $C(13)
 ;
HEL F Z2=1:1:50 U IO R X(Z2):1 U IO(0) W "." U IO H 1 I X(Z2)["**HELLO**" S DVBXM=1,DVBTSK=0,DVBABORT=0 U IO S DVBIO=IO,DVBJDX=1 D MES^DVBHQD1 S IO=DVBIO Q
 I DVBLOG'["VHA" U IO W "$$$BYEF",$C(13) D DISP G EX
 I DVBLOG["VHA" U IO W "$%$DIS",$C(13),! D DISP G EX
 D DISP
END F Z=1:1:30 I $D(X(Z)),X(Z)["???" U IO I DVBLOG'["VHA" W "BYEF",$C(13) Q
 F Z=1:1:30 I $D(X(Z)),X(Z)["$%$" U IO I DVBLOG["VHA" W "DIS",$C(13) Q
 ;
EX ;U IO F Z=1:1 R *X:4 Q:'$T  U IO(0) W $C(X) U IO
EX1 K R,DVBJDX,%Y,%,I,K,Y0,Z2,DVBDXX,DVBLEN,D,DVBIO,X,Z,H,DVBSTN,DVBABORT
 K DVBLOG,DVBDEV,DVBECHO,DVBEND,DVBTMX,DVBTSK,DVBTX,DVBXM,DVBZ,Y,C,G
 K DVBID,DVBIDCU,DVBPU,DVBPW,^TMP($J),DVBIP
 D CLOSE^%ZISTCP
 Q
XXX U IO(0) W:$D(X(Z)) !,X(Z) U IO
 S C=C+1 I C>2 G END
 H 5 G NAM
BUSY U IO(0) W !," ",IO,"   Device is busy" H 1 K DVBLOG,DVBDEV,DVBSTN,DVBDXX,DVBTSK,DVBZ Q
YYY U IO(0) W !,"Bad Network Password notify Site Manager" D EX Q
DISP U IO(0) F G=1:1:Z2 I $D(X(G)) D TRIM W:$L(X(G)) !,X(G) I X(G)["0900 BYE" Q
 U IO Q
TRIM F H=0:0 Q:$E(X(G))'=$C(10)  S X(G)=$E(X(G),2,999)
 F I=$L(X(G)),-1,1 Q:$E(X(G),I)'=$C(10)  S X(G)=$E(X(G),1,I-1)
 Q
