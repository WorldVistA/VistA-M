XUSTZIP ;WRJ/DAF,ISF/RWF - Security Twilight Zone, Failed Access Attempts ;03/24/2004  11:12
 ;;8.0;KERNEL;**265,419**;Jul 10, 1995;Build 5
 Q
 ;The subfiles in KSP file.
 ;405.2 List of Terminal Servers, slack, last reset
 ;
 ;^XUSEC(3, (File 3.083) Locked IP's, lock until
 ;^XUSEC(4, (File 3.084) Failed attempts count
 ;$P(^VA(200,DUZ,1.1),U,5) Locked Users
 ;
CLEAN ;CLEAN UP OLD LOCKED IP NODES, ^XUSEC(3,
 N ZNUM,NOW
 S ZNUM=0,NOW=$$NOW^XLFDT
 L +^XUSEC(3,0):10
 F  S ZNUM=$O(^XUSEC(3,ZNUM)) Q:ZNUM'>0  D
 .I $P(^XUSEC(3,ZNUM,0),"^",2)'>NOW D LKDEL(ZNUM)
 L -^XUSEC(3,0),+^XUSEC(4,0):10
 N XUFAC,OV
 S ZNUM=0,NOW=$$H3-90
 F  S ZNUM=$O(^XUSEC(4,ZNUM)) Q:ZNUM'>0  D
 .S OV=$$H3($P(^XUSEC(4,ZNUM,0),"^",3)) I OV'>NOW D
 ..N DIK,DA
 ..S DA=ZNUM,DIK="^XUSEC(4," D ^DIK
 L -^XUSEC(4,0)
 Q
X6IP ;EXAMINE AND ALLOW RESET OF LOCKED IPS
 N I,ZFDA,DIR,XUNOW,ZNM,ZNUM,Y S ZNM="",I=0
 I '$D(^XUSEC(3,"B")) W !,"There are no IP's to Clear" Q
 F  S ZNM=$O(^XUSEC(3,"B",ZNM)) Q:ZNM']""  S ZNUM=$O(^XUSEC(3,"B",ZNM,"")) D
 . I '$D(^XUSEC(3,ZNUM,0)) K ^XUSEC(3,"B",ZNM) Q  ;419
 . S I=I+1,ZNM(I)=ZNUM_"^"_ZNM
 . W !,I_". ",ZNM,"  lock out till: ",$$FMTE^XLFDT($P(^XUSEC(3,ZNUM,0),"^",2))
 . Q
 S DIR(0)="N^1:"_I,DIR("A")="Choose the number of the IP to reset" D ^DIR Q:$D(DIRUT)
 S ZNM=$P(ZNM(Y),"^",2),ZNUM=+ZNM(Y)
 ;Call with IEN
 D LKDEL(ZNUM)
 W !,ZNM," Cleared"
 ;Call with IP
 D CLRFAC^XUS3(ZNM) ;Clear access count
 ;if this is a ts reset and then set reset date in site param file
 S ZIEN=$$TSCHK(ZNM)
 I ZIEN>0 S ZFDA(8989.305,ZIEN_",1,",2)=$$NOW D UPDATE^DIE("","ZFDA")
 K DIR,DIRUT
 Q
 ;
LKSET(IP) ;Set IP Lock Node
 N ZNUM,ZFDA,ZIEN
 Q:'$$ON 0
 S ZIEN="?+2,",ZFDA(3.083,ZIEN,.01)=IP
 S ZFDA(3.083,ZIEN,2)=$$LKTL
 D UPDATE^DIE("","ZFDA","ZIEN")
 D CLRFAC^XUS3(IP) ;Clear the access count
 Q 1
LKTL() ;Lock until
 Q $$HTFM^XLFDT($$HADD^XLFDT($H,0,0,0,$$LKTME))
 ;
NOW() ;
 I $G(XUNOW) Q XUNOW
 S XUNOW=$$NOW^XLFDT
 Q XUNOW
 ;
IP() ;Get a device IP.
 Q $S($D(IP):IP,$D(IO("IP")):IO("IP"),$D(IO("ZIO")):IO("ZIO"),1:"")
 ;
LKTME() ;Get lock-out time
 I $D(XOPT) Q $P(XOPT,U,3)
 Q $P(^XTV(8989.3,1,"XUS"),U,3)
 ;
LKCHECK(IP) ;Check if IP is LOCKED
 I '$$ON Q 0 ;Are we doing IP/device locking
 S IP=$$IP() Q:'$L(IP) 0
 N ZREC S ZREC=$$LKREC(IP)
 Q:'$L(ZREC) 0
 ;Found a LOCK record, Check time
 S X=$P(ZREC,"^",2)>$$NOW
 Q X
 ;
LKREC(IP) ;Get the Lock record
 N ZNUM
 S ZNUM=+$O(^XUSEC(3,"B",IP,0))
 Q $G(^XUSEC(3,ZNUM,0))
 ;
LKDEL(ZNUM) ;Delete LOCKED IP
 N DIK,DA ;419
 S DIK="^XUSEC(3,",DA=ZNUM D ^DIK
 Q
 ;
LKWAIT(%) ;How long to wait
 N T1,T2,IP
 S IP=$$IP() Q:'$L(IP) %
 S T1=$$LKREC(IP)
 Q $$FMDIFF^XLFDT($P(T1,U,2),$$NOW^XLFDT,2)
 ;
TSCHK(IP) ;Check if IP is for a TERMINAL SERVER.
 ;is this IP for a teriminal server.
 N ZNUM S ZNUM=$O(^XTV(8989.3,1,405.2,"B",IP,0))
 Q ZNUM
 ;
IPCHECK(IP) ;Check if IP should be LOCKED. Called from XUSTZ, and others.
 ;Return 1 if should lock, 0 if No.
 I '$$ON Q 0
 S IP=$$IP Q:'$L(IP) 0
 N LIMIT,TSIEN,ZEND,ZNUM,ZLST,SLK,TFAC,TSREC,Z10
 ;If the IP is locked, Don't relock. Could cause an endless lock.
 I $$LKCHECK(IP) Q 0
 ;is this the IP of a teriminal server. if not lock
 S TSIEN=$$TSCHK(IP) ;Returns TS ien.
 ;If TSIEN<1 lock the IP.
 Q:TSIEN<1 1
 ;count # of failures for this TS in last 10 minutes and compare that 
 ;against the established limit.  if no limit set, use 2. maybe cut
 ;some slack.
 S Z10=$$HTFM^XLFDT($$HADD^XLFDT($H,0,0,-10)) ;NOW-10
 S TSREC=$G(^XTV(8989.3,1,405.2,TSIEN,0)) ;Get TS record
 S ZLST=$P(TSREC,"^",3) ;Last reset
 S ZEND=$S(ZLST>Z10:ZLST,1:Z10) ;stop at last reset or NOW-10.
 S ZNUM="A",TFAC=0,Y=$S(IP["/":"/",1:":")
 F  S ZNUM=$O(^%ZUA(3.05,ZNUM),-1) Q:ZNUM'>0!(ZEND>ZNUM)  D
 . I $P($P(^%ZUA(3.05,ZNUM,0),"^",7),Y)=$P(IP,Y) S TFAC=TFAC+1
 S LIMIT=$P($G(^XTV(8989.3,1,405)),"^",6) S:'LIMIT LIMIT=2
 S SLK=$$SLACK(Z10) ;
 Q $S(SLK:TFAC>SLK,1:TFAC>LIMIT)
 ;
SLACK(TEND) ;SLACK CALCULATOR
 ;if this TS has been reset in last 10 minutes allow 100 tries.
 ;Normal hours return 0, after hours use TS Slack value
 N HRMIN,X,NOW,TS
 S X=$P(TSREC,"^",3) ;Last Reset
 I X>TEND Q 100 ;TEND is Now-10 min
 ;if now is during normal work hours 8am to 4:30 pm, cut no slack
 S HRMIN=$P($H,",",2)
 ; 8am is 28800 and 4:30 pm is 59400
 ; If Normal hours don't give slack unless user locking is on.
 I (HRMIN>28800&(HRMIN<59400)) Q $S($P($G(^XTV(8989.3,1,405)),"^",4)="y":10,1:0)
 ;if TS param says to cut slack, cut amount of slack set up in param.
 Q $S($P(TSREC,"^",2):$P(TSREC,"^",2),1:0)
 ;
ON() ;ON OR OFF
 Q $P($G(^XTV(8989.3,1,405)),"^",1)="y"
 ;
H3(%H) ;Make seconds
 S:'$G(%H) %H=$H
 Q %H*86400+$P(%H,",",2)
 ;
H0(%H) ;
 S:'$G(%H) %H=0
 Q (%H\86400)_","_(%H#86400)
 ;
DSPTME(%H) ;Convert seconds to display format
 Q $$HTE^XLFDT($$H0(%H),"1P")
 ;
WATCH ;Watch the globals
 N TIME,C,I,X
WT2 S TIME=$$HTE^XLFDT($H)
 W @IOF,"Failed access attempts count.   Current time: ",TIME
 S I=0,C=0
 F  S I=$O(^XUSEC(4,I)) Q:I'>0  S X=^(I,0),C=1 W !,I,?5,"IP: ",$P(X,U,1),?25,"Count: ",$P(X,U,2),?35,"Until: ",$$HTE^XLFDT($P(X,U,3))
 I C=0 W !,?10,"None"
 W !,"Locked IP's.  Current time: ",TIME
 S I=0,C=0
 F  S I=$O(^XUSEC(3,I)) Q:I'>0  S X=^(I,0),C=1 W !,I,?5,"IP: ",$P(X,U,1),?25,"Until: ",$$FMTE^XLFDT($P(X,U,2))
 I C=0 W !,?10,"None"
 R !,"Refresh: Yes// ",X:30 S:'$T X="Y" G WT2:"Yy"[$E(X)
 I $E(X)="?" W !,"Enter 'Yes' or return to refresh, anyother key will exit" H 2 G WT2
 Q
