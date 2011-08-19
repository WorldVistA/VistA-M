RMPRPIXR ;HINES OIFO/ODJ - REMOVE/DEACTIVATE ITEM ;12/11/02  10:22
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
RE ;remove/deactivate an HCPCS/ITEM
 ;***** STN - prompt for Site/Station
STN S RMPRERR=$$STN^RMPRPIY1(.RMPRSTN,.RMPREXC)
 I RMPRERR G DLX
 I RMPREXC'="" G DLX
 W !!,"*** Removing/Deactivating HCPCS......",!
 ;
HCPCS ;
 K ^TMP($J),Y,DIR
 K RMPR1,RMPR11,RMPR5,RMPRLCN,RMPREXC,RMPRERR,RMPRUNI,RMDEL,RMOUT
 W !
 S RMPR1("REMOVE")=1
 D HCPCS^RMPRPIY7(RMPRSTN("IEN"),$G(RMPR1("HCPCS")),.RMPR1,.RMPR11,.RMPREXC)
 I RMPREXC="T" G DLX
 I RMPREXC="P" G STN
 I RMPREXC="^" D  G DLX
 . W !,"** No HCPCS selected." H 1
 S RS=RMPRSTN("IEN"),RH=RMPR1("HCPCS")
 ;
ALL ;ask if all item will be remove/deactivate
 S DIR(0)="Y",DIR("B")="N"
 W !
 S DIR("A")="Do you want to Remove/Deactivate ALL Items for this HCPCS"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="^") W !!,"Nothing Remove.." G HCPCS
 I Y=1 S RMDEL="ALL" D  I $G(RMOUT) H 2 G HCPCS
 .S DIR(0)="Y",DIR("B")="N"
 .W !
 .S DIR("A")="Are you sure you want to Remove/Deactivate ALL ITEMs for HCPCS "_RMPR1("HCPCS")
 .D ^DIR
 .I $D(DTOUT)!$D(DUOUT)!(Y="^")!(Y=0) W !!,"Nothing Remove.." S RMOUT=1
 G:$D(RMDEL) ZERO
 ;
ITEM ;
 D ITEM^RMPRPIYP(RMPRSTN("IEN"),$G(RMPR1("HCPCS")),.RMPR11,.RMPREXC)
 I RMPREXC="T" G DLX
 I RMPREXC="P" G HCPCS
 I RMPREXC="^" G HCPCS
 ;
 S DIR(0)="Y",DIR("B")="N"
 W !
 S DIR("A")="Are you sure you want to Remove/Deactivate this HCPCS/ITEM "_RMPR11("HCPCS-ITEM")
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="^")!(Y=0) W !!,"Nothing Remove.." G HCPCS
 ;
ZERO ;zero out
 ;only delete one if item if specified
 I $D(RMPR11("ITEM")) G DEL1
 G:$D(RMDEL) ALLIT
 ;
DEL1 ;remove one item
 ;
 S RI=RMPR11("ITEM")
 F RD=0:0 S RD=$O(^RMPR(661.7,"XSHIDS",RS,RH,RI,RD)) Q:RD'>0  F RIEN=0:0 S RIEN=$O(^RMPR(661.7,"XSHIDS",RS,RH,RI,RD,1,RIEN)) Q:RIEN'>0  D
 .Q:'$D(^RMPR(661.7,RIEN,0))
 .S RMDA=^RMPR(661.7,RIEN,0)
 .S RML=$P(RMDA,U,6),RMQ=$P(RMDA,U,7),RMV=$P(RMDA,U,8)
 .;call update 661.6
 .S RMPR11("HCPCS")=RH,RMPR11("ITEM")=RI,RMPR11("STATION")=RS
 .S RMPR6("COMMENT")="",RMPR6("LOCATION")="",RMPR6("QUANTITY")=0
 .S RMPR6("SEQUENCE")=0,RMPR6("TRAN TYPE")=9,RMPR6("USER")=$G(DUZ)
 .S RMPR6("VALUE")=0,RMPR6("VENDOR")=""
 .S RMERR=$$CRE^RMPRPIX6(.RMPR6,.RMPR11)
 .;delete entry in #661.7
 .Q:'$G(RIEN)
 .K DIK S DIK="^RMPR(661.7,",DA=RIEN D ^DIK
 .;update 661.9
 .K R9,R9DA
 .I $D(^RMPR(661.9,"ASHID",RS,RH,RI,DT)) D
 ..S R9=$O(^RMPR(661.9,"ASHID",RS,RH,RI,DT,""),-1)
 ..I $G(R9),$D(^RMPR(661.9,R9,0)) S R9DA=^RMPR(661.9,R9,0)
 ..I $D(R9DA),$P(R9DA,U,8)=0 Q
 ..D UP9
 .I '$D(^RMPR(661.9,"ASHID",RS,RH,RI,DT)) D UP9
 .S RHRI=RH_"-"_RI
 .S ^TMP($J,RHRI)=""
 ;print a message to the screen for items being removed
 D MESS
 ;change status of hcpcs & deactivation date in 661.11
 K RMERR,RMDAT,K
 S RMDAT(661.11,RMPR11("IEN")_",",8)=1
 S RMDAT(661.11,RMPR11("IEN")_",",9)=DT
 D FILE^DIE("K","RMDAT","RMERR")
 I $D(RMERR) W !!,"*** Error updating file #661.11 update!!!",!!
 G HCPCS
 ;
ALLIT ;remove/deactivate all items for selected HCPCS.
 ;
 F RI=0:0 S RI=$O(^RMPR(661.7,"XSHIDS",RS,RH,RI)) Q:RI'>0  D
 .F RD=0:0 S RD=$O(^RMPR(661.7,"XSHIDS",RS,RH,RI,RD)) Q:RD'>0  F RIEN=0:0 S RIEN=$O(^RMPR(661.7,"XSHIDS",RS,RH,RI,RD,1,RIEN)) Q:RIEN'>0  D
 ..Q:'$D(^RMPR(661.7,RIEN,0))
 ..S RMDA=^RMPR(661.7,RIEN,0)
 ..S RML=$P(RMDA,U,6),RMQ=$P(RMDA,U,7),RMV=$P(RMDA,U,8)
 ..;update 661.6
 ..S RMPR11("HCPCS")=RH,RMPR11("ITEM")=RI,RMPR11("STATION")=RS
 ..S RMPR6("COMMENT")="",RMPR6("LOCATION")="",RMPR6("QUANTITY")=0
 ..S RMPR6("SEQUENCE")=0,RMPR6("TRAN TYPE")=9,RMPR6("USER")=$G(DUZ)
 ..S RMPR6("VALUE")=0,RMPR6("VENDOR")=""
 ..S RMERR=$$CRE^RMPRPIX6(.RMPR6,.RMPR11)
 ..;delete entry from  #661.7
 ..Q:'$G(RIEN)
 ..K DIK S DIK="^RMPR(661.7,",DA=RIEN D ^DIK
 ..; update 661.9
 K R9,R9DA
 F RI=0:0 S RI=$O(^RMPR(661.9,"ASHID",RS,RH,RI)) Q:RI'>0  D UP9
 ;
 ;print a message of items being removed/deactivated
 F I=0:0 S I=$O(^RMPR(661.11,"ASHI",RS,RH,I)) Q:I'>0  D
 .F J=0:0 S J=$O(^RMPR(661.11,"ASHI",RS,RH,I,J)) Q:J'>0  D
 ..S RHRI=RH_"-"_I
 ..S ^TMP($J,RHRI)=""
 D MESS
 ;change status of hcpcs & deactivation date in 661.11
 ;loop through all items in a particular HCPCS
 F RI=0:0 S RI=$O(^RMPR(661.11,"ASHI",RS,RH,RI)) Q:RI'>0  D
 .F RJ=0:0 S RJ=$O(^RMPR(661.11,"ASHI",RS,RH,RI,RJ)) Q:RJ'>0  D
 ..K RMERR,K,RMDAT
 ..S RMDAT(661.11,RJ_",",8)=1
 ..S RMDAT(661.11,RJ_",",9)=DT
 ..D FILE^DIE("K","RMDAT","RMERR")
 ..I $D(RMERR) W !!,"*** Error updating file #661.11 update!!!",!!
 ;ask for another HCPCCS to remove
 G HCPCS
 ;
UP9 ;CREATE entry in file #661.9
 K RMDAT,RMERR,RIN
 S RMDAT(661.9,"+1,",.01)=DT
 S RMDAT(661.9,"+1,",1)=RH
 S RMDAT(661.9,"+1,",2)=RI
 S RMDAT(661.9,"+1,",4)=RS
 S RMDAT(661.9,"+1,",7)=0
 S RMDAT(661.9,"+1,",8)=0
 D UPDATE^DIE("","RMDAT","RIN","RMERR")
 I $D(RMERR) W !!,"*** Error updating file #661.9 !!!",!!
 Q
 ;
MESS ;print a deleted message
 S I="" F  S I=$O(^TMP($J,I)) Q:I=""  D
 .W !!,"*** HCPCS/ITEM "_I_" has been Removed/Deactivated from PIP..."
 K ^TMP($J)
 Q
 ;
DLX N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
