GMRCPREF ;SLC/DCM - Setup package/procedure protocols ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
A ;Setup package and procedure
 K ORDR I $D(ORDA),ORDA,$D(^ORD(101,ORDA)),$P(^(ORDA,0),"^",12)=ORPKG S ORIN=ORDA,ORNAME=$P(^(0),"^") G A1
 S X=$S($D(ORDANM):ORDANM,1:$$GET1^DIQ(9.4,+ORPKG_",",1)_+ORFL_" "_X),X=$E(X,1,63)
 I $D(^ORD(101,"B",X)) S Y=$O(^(X,0)),ORNAME=X,ORDR="" I $D(^ORD(101,Y,0)) W !,X_" PROTOCOL Updated",! S:ORTXT'=$P(^(0),"^",2) ORDR="1///"_ORTXT
 I '$D(^ORD(101,"B",X)) S ORNAME=X,DIC(0)="XZL",(DLAYGO,DIC)=101 D ^DIC S:Y'<1 ORNAME=$P(Y,"^",2) W:Y>0 !,ORNAME_" PROTOCOL Created" I Y<1 W $C(7),!,"Unable to create "_ORNAME_" as an entry in the PROTOCOL file." Q
 ;
A1 ;Entry point given a protocol ien
 S:'$D(ORIN) ORIN=+Y I '$D(ORDA) S %X="^ORD(101,"_ORDEF_",",%Y="^ORD(101,"_+Y_"," D %XY^%RCR S:ORTXT=$P(^ORD(101,+Y,0),"^",2) ORDR="" S $P(^ORD(101,+Y,0),"^",1)=ORNAME
 I $D(OREA),$L(OREA) S ^ORD(101,ORIN,20)=OREA
 S:'$D(ORDR) ORDR=".01////"_$S($D(ORDANM):ORDANM,1:ORNAME)_$S($D(ORTXT):";1////"_ORTXT,1:"") S:$D(ORFL) ORDR=ORDR_";6////^S X=ORFL" I $L(ORDR) S DR=ORDR,DA=ORIN,DIE="^ORD(101," D ^DIE
 Q
 ;
EN3 ;On the fly protocol setup
 Q:'$D(ORPKG)!('$D(ORDEF))!('$D(ORFL))  Q:'ORPKG!('ORDEF)
 Q:'$D(^ORD(101,ORDEF,0))
 Q:'$L($$GET1^DIQ(9.4,+ORPKG_",",.01))
 I ORFL Q:'$D(@("^"_$P(ORFL,";",2)_+ORFL_",0)"))  S:'$D(ORTXT) ORTXT=$P(^(0),"^")
 Q:'$D(ORTXT)  S X=ORTXT D A
 K ORDA,ORDANM,ORDEF,ORDR,OREA,ORIN,ORNAME,ORTXT,ORIN,%X,%Y
 Q
