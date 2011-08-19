DVBHQDL ;ISC-ALBANY/PKE-HINQ IDCU,RDPC LOGON ; 10/27/05 4:12pm
 ;;4.0;HINQ;**9,12,32,33,34,38,49**;03/25/92
 S X="A" X ^%ZOSF("LPC") K X S U="^" I $D(IO)<11 S IOP="HOME" D ^%ZIS K IOP S:'$D(DTIME) DTIME=300
 I $D(DUZ)#2'=1 W !,"DUZ not defined",! Q
 I $D(^VA(200,DUZ,.1)) S DVBNUM=$P(^(.1),U,9) I DVBNUM
 E  W !,"  HINQ Employee Number not in New Person file",!,"  Notify System manager",! Q
 ;
EN W !,"This option will take 30 seconds to activate - using IP Addressing"
 U IO(0) W !!,"Do you wish to continue" S %=1 D YN^DICN
 I %'>0 G:%<0 EX1 W !,"    Enter YES to select option" G EN
 I %>1 G EX1
 S DVBTSK=0
 S DVBIOSL=IOSL,DVBIOST=IOST,DVBIOF=IOF
ENTSK ;entry from taskman
 D SILENT^DVBHQTM I $D(DVBSTOP) S DVBABORT=1 K DVBSTOP D:'DVBTSK MESS G EX
 S DVBIDCU=^DVB(395,1,"HQVD")_"^"_$P(^("HQ"),"^",11)
 S DVBLOG=$P(DVBIDCU,U),DVBPU=$P(DVBIDCU,U,2),DVBID=$P(DVBPU,"-"),DVBPW=$P(DVBPU,"-",2)
 I DVBLOG'?3U1"."4U W:'DVBTSK !,"IDCU ADDRESS not correct in HINQ Parameter file #395" H 3 S DVBABORT=1 G END
 I $P(DVBIDCU,"^",6) S DVBLOG="VHA"_$P(DVBLOG,"DMS",2)
 I 'DVBTSK U IO(0) W !!,"Connecting to VBA database"
 ;
 ;Set up the error trap for cache
 I 'DVBTSK,$$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^DVBHQDL"
 I 'DVBTSK,'$$NEWERR^%ZTER S X="ERR^DVBHQDL",@^%ZOSF("TRAP")
 ;
 S DVBIP=$P($G(^DVB(395,1,"HQIP")),"^",1)
 I DVBIP,DVBIP?1.3N1P1.3N1P1.3N1P1.3N
 E  W:'DVBTSK !?3,"RDPC IP Address not defined or invalid in DVB parameter file #395" H 3 G EX1
 ;
 S DVBSTN=$P(^DVB(395,1,0),U,2)
 ;
 ;with patch DVB*4*49 new routing and interface engines have been
 ;established for the HINQ process.  It was decided that multiple
 ;ports would be added to handle the volume of HINQs.  Three ports
 ;be used exclusively for the HEC, six for the VAMCs.  A new field
 ;(#23 - AAC PORT DESIGNATOR) has been added to act as a counter for
 ;the HINQ connections that have been requested. #3 or #6 + this field
 ;yeilds a code that is then interpreted into a port number depending
 ;on the station number.
 S DVBPORT=$$PORT(DVBSTN)
 ;
 D CALL^%ZISTCP(DVBIP,DVBPORT,"33")
 I POP G BUSY
 S X=0
 U IO X ^%ZOSF("EOFF"),^%ZOSF("TYPE-AHEAD"),^%ZOSF("RM") H 3
 S C=0 ;leave this off of next line
NAM ;
HEL ;
 N DVBFLG,DVBHEL,DVBQUIT
 I DVBTSK D
 . K X U IO F Z=1:1:50 R X(Z):3 D  Q:$G(DVBQUIT)=1
 . . I X(Z)["**HELLO**" K X S DVBABORT=0,DVBQUIT=1 Q
 . . I '$L(X(Z)) Q
 . . I $G(DVBFLG)>0 D HELLO2(Z)
 . . I $G(DVBHEL)["**HELLO**" K X S DVBABORT=0,DVBQUIT=1 Q
 . . S DVBFLG=0
 . . I X(Z)["**H" D HELLO(Z)
 . . I $E(X(Z),$L(X(Z)))="*" D HELLO(Z)
 . I Z'<50 S DVBVBA="NO"
 I 'DVBTSK D
 . U IO(0) W !!,"One moment, please...",!! U IO
 . K X F Z2=1:1:50 U IO R X(Z2):3 U IO(0) W "." D  Q:$G(DVBQUIT)=1
 . . I X(Z2)["**HELLO**" D CONT S DVBQUIT=1 Q
 . . I '$L(X(Z2)) Q
 . . I $G(DVBFLG)>0 D HELLO2(Z2)
 . . I $G(DVBHEL)["**HELLO**" D CONT S DVBQUIT=1 Q
 . . S DVBFLG=0
 . . I X(Z2)["**H" D HELLO(Z2)
 . . I $E(X(Z2),$L(X(Z2)))="*" D HELLO(Z2)
 . I Z2'<50 U IO(0) W !,"HINQ not allowed at this time" D MESS U IO
END ;
 I DVBTSK Q
 I DVBLOG["VHA" U IO W "$%$DIS",$C(13),!
 I DVBLOG'["VHA" U IO W "$$$BYEF",$C(13)
 U IO(0) W !!,"Terminating VBA session...",! U IO
 U IO F Z=1:1:6 R X(Z):1 Q:'$T  I X(Z)["0900 BYE" U IO(0) W !,"VBA DISCONNECTED",! Q  ;U IO Q
 ;I '$D(DVBIO) Q
 ;
EX I DVBTSK S DVBABORT=1 Q
EX1 K %,DVBNUM,DVBTSK,DVBLOG,DVBDEV,DVBVDI,DVBABORT,X,Y,Z,C,G,DVBIP,DVBIOSL,DVBIOST,DVBIOF
 D CLOSE^%ZISTCP Q
 Q
XXX I 'DVBTSK U IO(0) W !,X U IO
RESET S C=C+1 I C>2 G END
 H 5 G NAM
 ;
BUSY I 'DVBTSK W !," ",IO,"   Device is busy" D SUS H 1 G EX
YYY I 'DVBTSK U IO(0) W !,"Bad Network User ID/Password notify Site Manager " H 1 G EX
 Q
SUS I 'DVBTSK U IO(0) W !,"Enter requests in the Suspense file" Q
 Q
ERR ;Come here on error, screen with error screens 
 S DVBHERR=$$EC^%ZOSV
 I DVBHERR["READ"!(DVBHERR["ENDOFFIL") DO
 . U IO(0) W !,"Disconnect trapped..."
 D ^%ZTER
 D CLOSE^%ZISTCP
 G UNWIND^%ZTER
 Q
MESS ;DVB*38 HINQ UNAVAILABLE MESSAGE  MLR 5.10.01
 I $G(DVBTSK)>0 Q
 U IO(0)
 W !!
 W $$CJ^XLFSTR("ATTENTION:  HINQ IS CURRENTLY UNAVAILABLE!",80,".")
 W !!,$$CJ^XLFSTR("Please enter HINQ request in Suspense File",80)
 W !,$$CJ^XLFSTR("or try again later.",80)
 W !!
 Q  ;MESS
 ;
CONT ;display messages and continue with HINQ
 U IO(0) W !!,"You may continue with your HINQ request...",!!
 U IO S DVBIO=IO D ^DVBHQD1 U IO(0) W ! S IO=DVBIO
 Q
 ;
HELLO(IND) ;if **HELLO** string was broken up, save it to a var to combine
 ;with next read
 ;input parameter indicates whether called from task or direct
 S DVBFLG=1
 I X(IND)["**H" S DVBHEL="**H"_$P(X(IND),"**H",2) Q
 I $E(X(IND),$L(X(IND))-1)="*" S DVBHEL="**" Q
 S DVBHEL="*"
 Q
HELLO2(IND) ;add string from next read to string in HELLO
 I $G(DVBHEL)["" S DVBHEL=DVBHEL_$E(X(IND),1,9-$L(DVBHEL))
 Q
 ;
PORT(DVBSTN) ;
 K DVBERR
 S DVBPORT=50010
 S DVBPT=$$GET1^DIQ(395,"1,",23,,,"DVBERR")
 I $D(DVBERR) D  Q DVBPORT
 . S DVBFDA(395,"1,",23)=0
 . D FILE^DIE(,"DVBFDA","DVBERR")
 S DVBFDA(395,"1,",23)=DVBPT+1
 D FILE^DIE("E","DVBFDA","DVBERR")
 I $G(DVBSTN)=742 D
 . ;station 742 is the HEC - these 3 ports are reserved for the HEC
 . S DVBPORT=$G(DVBPT)#3 ;50000 - 50002
 . S DVBPORT=50000+DVBPORT
 I $G(DVBSTN)'=742 D
 . ;these 6 ports are for the use of VAMCs
 . S DVBPORT=$G(DVBPT)#6
 . S DVBPORT=50010+DVBPORT ;50010 - 50015
 Q DVBPORT
