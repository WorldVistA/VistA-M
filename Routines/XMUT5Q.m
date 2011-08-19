XMUT5Q ;(WASH ISC)/CAP-Delivery Queue Analysis ;04/17/2002  12:03
 ;;8.0;MailMan;;Jun 28, 2002
 Q
QUIT ;End process
 D REC
QUIT1 K %,A,B,I,J,RSP,X,Y,ZTSK,ZTSAVE,ZTRTN,ZTDTH
 K:'$D(ZTQUEUED) C,M,R
 G ZTSK0
 ;
ZTSK ;SCHEDULE TO RUN
 K XMUT5,XMUT5Q S ZTRTN="GO^XMUT5Q1" G GO
ZTSK0 ;Reschedules itself here
 S ZTRTN="GO2^XMUT5Q1"
GO Q:$S($D(XMUT5NO):1,'$D(XMUT5F):0,'$D(XMUT5Q):0,XMUT5Q>XMUT5F:1,1:0)
 S:'$D(XMUT5S) XMUT5S=1800
 K XMUT5N S XMUT5Q=$G(XMUT5Q)+1,ZTSAVE("C*")="",ZTSAVE("XMZUT*")="",ZTREQ="@" I $D(ZTQUEUED) S XMUT5=1
 S X=$H*86400+$P($H,",",2)+XMUT5S\XMUT5S*XMUT5S,ZTDTH=X\86400_","_(X#86400),ZTDESC="MGRMAIL "_XMUT5S_" second interval Delivery Queue Check"
 S:'$D(ZTRTN) ZTRTN="GO^XMUT5Q1" S ZTIO="" D ^%ZTLOAD
 Q
REC ;RECORD QUEUE STATUS
 D NOW^%DTC
 ;
 ;Look to see if data already file and quit if it is there
 S X=$P(%,".")_"."_$E($P(%,".",2),1,2) I $E($P(%,".",2),3)>2 S X=X_3
 S X=$O(^XMBX(4.2998,"B",X)),DA=$S(X="":"",1:$O(^(X,0))) Q:DA
 I 'DA S X=%,DIC="^XMBX(4.2998,",DIC(0)="FI",Y=0 D FILE^DICN
 S DIE="^XMBX(4.2998,",DA=+Y,XMUSER=$$USERS^XMUT5B(0)
 ;zero node
 S DR="1///"_(M("T")+R("T"))_";11///"_+M("T")_";12///"_+R("T")_";43///"_$P(^XMB(3.9,0),U,3)
 I $G(XMUSER) S DR=DR_";39///"_XMUSER_";38///"_XMUSER
 S %="LINES_READ" I $D(^XMBPOST(%)) L +^XMBPOST(%) S DR=DR_";15///"_^XMBPOST(%,0) S ^(0)=0 L -^XMBPOST(%)
 ;File it
 D ^DIE K DR
 L +^XMBPOST("GSTATS","R")
 S %=$G(^XMBPOST("STATS","R")) S:%>0 DR="45///"_+% S ^("R")=0
 L -^XMBPOST("GSTATS","R")
 L +^XMBPOST("GSTATS","M")
 S %=$G(^XMBPOST("STATS","M")) S:%>0 DR=$S($D(DR):DR_";",1:"")_"44///"_+% S ^("M")=0
 L -^XMBPOST("GSTATS","M")
 S (%0,%)="" F I=1:1:10 S %0=$G(^XMBPOST("M",I)) S %=%+$P(%0,U,2)
 S:%>0 DR=$S($D(DR):DR_";",1:"")_"46///"_%
 S (%0,%)="" F I=1:1:10 S %0=$G(^XMBPOST("R",I)) S %=%+$P(%0,U,2)
 S:%>0 DR=$S($D(DR):DR_";",1:"")_"47///"_% K %0
 I $D(DR) D ^DIE K DR
 ;1 node
 S %=$P(M("T"),U,2) I % S DR=$S($D(DR):DR_";",1:"")_"101///"_($H*86400+$P($H,",",2)-%)
 S %=$P(R("T"),U,2) I % S DR=$S($D(DR):DR_";",1:"")_"102///"_($H*86400+$P($H,",",2)-%)
 S %=$S($D(^XMB(1,1,6)):^(6),1:"10^50,400"),DR=$S($D(DR):DR_";",1:"")_"103///"_$P(%,U,2)_";104///"_$P(%,U)
 ;File it
 I $D(DR) D ^DIE K DR
 ;2 & 3 nodes
 S I=201,DR="" D DR
 D ^DIE:$L($G(DR)) K DR
 ;4 & 5 nodes
 S I=401,DR="" D DR
 ;File it
 D ^DIE:$L($G(DR)) K DR
 ;Nodes 6 & 7 - Deliveries
 F I=1:1:10 S %=$P(R("O",I),U,3) I % S DR=$S($D(DR):DR_";",1:"")_60_I_"///"_%
 F I=1:1:10 S %=$P(M("O",I),U,3) I % S DR=$S($D(DR):DR_";",1:"")_70_I_"///"_%
 D ^DIE:$L($G(DR))
 K %H,D,D0,DI,DIE,DIC,DA,DO,DR,DQ,X
 Q
DR F I=I:1:I+9 S:$E(I)=2 %=R("O",I#100) S:$E(I)=4 %=M("O",I#100) I +% S:$L(DR) DR=$G(DR)_";" S DR=$G(DR)_(I+100)_"///"_+% I +$P(%,U,2) S DR=$G(DR)_";"_I_"///"_($H*86400+$P($H,",",2)-$P(%,U,2))
 Q
GET N J S J=I N I S I=J,Z=J
GET1 W !!,"Please enter the following for "_$P("ORIGINAL MESSAGES: ,RESPONSES: ",",",Z)
 R !!,"Enter up to 9 numbers separated by commas to determine statistical groupings.",!,"EG:  50,100,500 will create 4 groups: 1-49, 50-99, 100-499 & 500 and above.",!!,"Enter them now: ",X:DTIME
 Q:"^"[X
 F I=1:1 S A=$P(X,",",I) Q:A=""  S B=$P(X,",",I+1) I $S(+A'=A:1,I>10:1,1:0)!(B'>A&B) D ERR G GET1
 Q
ENUSER ;Entry point called by VMS job that calculates active logons
 ;Parameter passed has three comma (",") pieces for active logons
 ;
 ;**** REVISED 1/93 ****
 ;VMS JOB NO LONGER WORKS -- ZSLOT USER ARE KEPT TRCK OF DIFFERENTLY
 ;
 ;$P(%,",",1)=Total - $P(%,",",2)=ZSLOT - $P(%,",",3)=Non-ZSLOT
 ;$P(%,",",4)=VMS style date (N-MMM-YYY HH:MM:SS:xx)
 ;
 S U="^" L +^XMBX(4.2998)
 S XMA0=%,%=$P(%,",",4),DA=$P($G(^XMBX(4.2998,0)),U,3) Q:'DA
 ;
 ;Re-construct VMS date to date FileMan's conversion can handle as input
 F I=0:0 Q:$E(%)'=" "  S %=$E(%,2,99)
 S X=$P(%,"-",2)_" "_$E("0",$L(+%))_+%_", "_+$P(%,"-",3),XMB0=$P(%," ",2)
 ;
 ;If this data applies to the last entry made for statistics (within
 ;1/2 hour) file it in this entry.
 ;
 D ^%DT S X=Y_"."_$P(XMB0,":")_$P(XMB0,":",2),(%0,Y)=^XMBX(4.2998,DA,0)
 I X-Y<.003 F %=22,23 S X=$P(XMA0,",",%-20) I X>$P(Y,"^",%) S $P(Y,"^",%)=X,$P(Y,"^",21)=$P(Y,"^",21)+X
 S ^XMBX(4.2998,DA,0)=Y L -^XMBX(4.2998) K DA,XMA0
 Q
ERR W $C(7),"  ???" S X="" Q
 ;
NOTASK ;Run in foreground
 S XMUT5NO=1,XMUT5=1
 R !!,"Initialize time stamps in queue (necessary 1st run): NO// ",X:DTIME
 K:$E(X)="Y" XMUT5
 G 0^XMUT5Q1
