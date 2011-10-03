ZISPL1 ;SF/RWF - %ZIS UTILITIES FOR SPOOLING ;11/20/97  08:53
 ;;8.0;KERNEL;**23,36,69**;Jul 10, 1995
 ;This is general code for managment of the spooler file from %ZIS.
 Q
 ;
FILE ;Called by %ZIS4 to setup spool data file.
 S %ZDA=$S($D(IO("SPOOL")):IO("SPOOL"),$D(^XUTL("XQ",$J,"SPOOL")):^("SPOOL"),1:0) Q:%ZDA'>0
 I '$D(ZISPLAD),$D(^XUTL("XQ",$J,"ADSPL")) S ZISPLAD=^("ADSPL")
 K ^XUTL("XQ",$J,"SPOOL"),^("ADSPL"),IO("SPOOL") S %ZS=$S($D(^XMB(3.51,%ZDA,0)):^(0),1:"") I %ZS']"" S %ZDA=-1 Q
 I '$D(ZTSK) S ZTRTN="DQC^ZISPL1",ZTDESC="Background Spool Filer",ZTDTH=$H,ZTIO="",ZTSAVE("%ZDA")="" S:$D(ZISPLAD) ZTSAVE("ZISPLAD")="",ZTSAVE("%ZS")="" D ^%ZTLOAD K ZISPLAD,ZTSK S %ZDA=-1 Q
 N X,Y K DD,DO S X=%ZDA,DIC="^XMBS(3.519,",DIC(0)="LZ",DLAYGO=3.519 D FILE^DICN S XS=+Y
 K DD,DO,DLAYGO
 S $P(^XMB(3.51,%ZDA,0),"^",3)="a",$P(^(0),"^",6)=DT,$P(^(0),"^",10)=XS,^XMB(3.51,"AM",XS,%ZDA)="" Q
 ;
CLOSE S ^XMBS(3.519,XS,2,0)="^^"_%_"^"_%,$P(^XMB(3.51,%ZDA,0),"^",2,3)="^r",$P(^(0),"^",9)=%
 I $D(ZISPLAD) F %=0:0 S %=$O(^%ZIS(1,+ZISPLAD,"SPL",%)) Q:%'>0  D
 .I $D(^%ZIS(1,+ZISPLAD,"SPL",%,0)) S %X=^(0) D
 ..S ZISPLC=$S($P(%X,"^",2)]"":+$P(%X,"^",2),1:1),%X=$P(%X,"^")
 ..I $D(^%ZIS(1,+%X,0)) K ZISDA2 S ZISPLDV=$P(^(0),"^"),DIE="^XMB(3.51,",DR="[XU-ZISPL1]",(ZISDA,DA)=%ZDA D ADSPL
 K ^XMB(3.51,"C",%ZFN),XMZ,XMDUZ,%ZDA,%ZFN,% Q
 ;
DQC ;DQ the move from spool to mail message.
 S IO("SPOOL")=%ZDA D CLOSE^%ZIS4 Q
 ;
ADSPL N %,ZTSK D ^DIE Q:'$D(ZISDA2)
 S %X="^"_ZISPLC_"^^^^^"_ZISPLDV_";"_$P(%ZS,"^",8)_"^"_$H
 ;
QDSPL S ZISPLC=$P(%X,"^",2),ZTIO=$P(%X,"^",7),ZTDTH=$P(%X,"^",8),ZTRTN="DQP^ZISPL2",ZTDESC="Auto despool document"
 I ZTIO]"",ZTDTH]"",ZISPLC S ZISDA=%ZDA,ZTSAVE("ZISDA")="",ZTSAVE("ZISDA2")="",ZTSAVE("ZISPLC")="" D ^%ZTLOAD K ZTSK
 Q
 ;
NEWDOC ;Called by %ZIS4 to get or setup a spool document.
 N DIC,X,Y I $S($D(^VA(200,DUZ,"SPL")):$E(^("SPL"),1),1:"N")'["y" W:'$D(IOP) !?5,"You aren't an authorized SPOOLER user." Q
 D LIMITS
 I '$D(IOP),%Z1'>%Z2!($P(%Z1,"^",2)'>%Z3) D MSG1 Q
R S %Y=$S($D(IO("DOC")):IO("DOC"),$G(%ZISMY)]"":$P(%ZISMY,";",1),1:$P(%Y,";",1)) K %Z1,%Z2,%Z3
 S DIC=3.51,U="^",DIC("DR")="",DIC("S")="I '$P(^(0),U,10)",DIC("W")="W "" Status: "",$P(^(0),U,3),""  Lines: "",$P(^(0),U,9)"
 I %IS'[0,$D(^%ZIS(1,%ZISIOS,1)),$P(^(1),"^",9) D GENDOC G R1
 I $D(IOP) S X=%Y,DIC(0)="XMLZ"
 E  S DIC(0)="AEQMZL" S:%Y?1A.ANP DIC("B")=%Y
 S DLAYGO=3,%ZY=-1 D ^DIC K DLAYGO Q:Y<0
R1 S %ZY=Y,%ZY(0)=Y(0),ZISIOST="P-OTHER",$P(%Z91,"^",2)="#" G:'$P(Y,"^",3) ND3
 S %=$$NOW^XLFDT
 S ^XMB(3.51,+Y,0)=$P(^XMB(3.51,+Y,0),"^",1)_"^^o^"_%_U_DUZ_"^^^"_+%Z91_";"_$P(%Z91,"^",3),^XMB(3.51,"AOK",+Y,DUZ)="",^XMB(3.51,"ADUZ",DUZ,+Y)=""
ND3 S %=$P(^XMB(3.51,+Y,0),"^",8),$P(%Z91,"^")=+%,$P(%Z91,"^",3)=$P(%,";",2)
 Q
LIMITS S %Z1=$G(^XTV(8989.3,1,"SPL")),(%Z2,%Z3)=0
 ;The next line only counts doc names w/ data
 ;F %=0:0 S %=$O(^XMB(3.51,"ADUZ",DUZ,%)) Q:%'>0  S %Z4=$S($D(^XMB(3.51,%,0)):^(0),1:""),%Z2=%Z2+$P(%Z4,"^",9),%Z3=$P(%Z4,"^",10)>1+%Z3
 ;This line counts all doc names.
 F %=0:0 S %=$O(^XMB(3.51,"ADUZ",DUZ,%)) Q:%'>0  S %Z4=$G(^XMB(3.51,%,0)),%Z2=%Z2+$P(%Z4,"^",9),%Z3=%Z3+1
 Q
GENDOC ;Auto generate document name.
 D FLST S %ZY=$E($P(^%ZIS(1,%ZISIOS,0),"^"),1,25)
 I %ZY["|DT|" S %ZY=$P(%ZY,"|DT|")_$$HTE^XLFDT($H,"2D")_$P(%ZY,"|DT|",2)
G1 S ZISPLST=ZISPLST+1,X=%ZY_"_"_+ZISPLST G G1:$D(^XMB(3.51,+ZISPLST,0)),G1:$O(^XMB(3.51,"B",X,0))>0
 S DIC=3.51,DIC(0)="XMLZ",DINUM=+ZISPLST,DLAYGO=3
 D ^DIC K DLAYGO I Y'>0 G G1
 Q
 ;
MSG1 W !,*7,"You have too many documents or lines, Please delete some documents" Q
 ;
FLST S ZISPLST=$P($G(^XMB(3.51,0)),"^",3)
 Q
