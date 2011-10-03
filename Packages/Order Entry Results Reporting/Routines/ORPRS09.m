ORPRS09 ; slc/dcm - The prints_es_n_da_p ;6/10/97  15:33
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,99**;Dec 17, 1997
PRES ;Change presentation context (All, Active, Expired, etc.)
 ;Returns ORPRES set to new context
 ;OREND=1 if no selection made
 S X=$O(^ORD(101,"B","ORRP STATUS MENU",0))_";ORD(101,"
 D EN^XQOR
 I $S('$D(X):0,X="^":1,X="^^":1,$D(DIROUT):1,$D(DTOUT):1,1:0) S OREND=1 Q
 S:'$D(ORPRES) ORPRES="2;ACTIVE ORDERS"
 Q
SERV ;Change service context (All, Lab, RX, etc.)
 S (OREND,ORDG)=0
 F  W !!,"Select Service/Section: All Services// " R X:DTIME S:'$T X="^" S:X["^^" DIROUT=1 S:'$L(X) X="ALL SERVICES" S:X["^" OREND=1 Q:OREND=1  D @$S(X["?":"LSRV",1:"LKUP") Q:ORDG
 I ORDG D SERV1(ORDG)
 Q
SERV1(ORBUF) ;Setup ORGRP array based on display group
 ;ORBUF=ORDG ptr to display group
 Q:'$G(ORBUF)
 K ORGRP
 D EN^ORPRS01(ORBUF,"BILD")
 S ORGRP("NAM")=^ORD(100.98,ORDG,0),ORGRP("ROOT")=ORBUF,ORGRP("NAM")=$S($L($P(ORGRP("NAM"),"^",3)):$P(ORGRP("NAM"),"^",3),1:$E($P(ORGRP("NAM"),"^"),1,5))
 Q
LKUP ;
 S DIC="^ORD(100.98,",DIC(0)="NEQ",DIC("W")="W ""   "",$P(Y,""^"",2)"
 D ^DIC
 K DIC
 S:+Y>0 ORDG=+Y
 Q
LSRV ;
 I X'["??" W !!,"ALL SERVICES" F I=0:0 S I=$O(^ORD(100.98,1,1,I)) Q:I'>0  I $D(^ORD(100.98,1,1,I,0)) S ORDG=+$P(^(0),"^") W:$D(^ORD(100.98,ORDG,0)) !?2,$P(^(0),"^")
 I X["??" S ORDG=1 W ! D EN^ORPRS01(ORDG,"DISP")
 S ORDG=0
 W !
 Q
FMT(LENGTH,INDEX,TEXT) ;Format text
 N X,Y,J
 S Y=1
 S:'$D(ORTX(INDEX)) ORTX(INDEX)=""
 S X=$L(TEXT)+$L(ORTX(INDEX))+1
 I X<255 S TEXT=$S($L(ORTX(INDEX)):ORTX(INDEX)_" "_TEXT,1:TEXT)
 I X'<255 S INDEX=INDEX+1,ORTX(INDEX)=""
 S ORTX(INDEX)=""
 F J=1:1 S X=$P(TEXT," ",J) Q:J>$L(TEXT," ")  D
 . Q:'$L(X)
 . I ($L(X)+$L(ORTX(INDEX)))>LENGTH S Y=1,INDEX=INDEX+1,ORTX(INDEX)=""
 . S ORTX(INDEX)=$S(Y:X,1:ORTX(INDEX)_" "_X),Y=0
 S ORTX(INDEX)=$$STRIP^ORU2(ORTX(INDEX)),ORINDX=INDEX
 Q ORINDX
ANSIH ;Clear scroll region and home cursor
 S DX=1,DY=ORANSI("T")
 W @ORANSI("XY"),$C(27),$C(91),"24",$C(77),$C(13)
 S (DX,DY)=0
 X ^%ZOSF("XY")
 Q
