DGJTEVT ;ALB/MIR - EVENT DRIVER CALL FOR IRT ; 04 JAN 91
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
 ;
EN2 N CA,DGPMA,DGPMP,DGPMT
 S DGONE=1 ;first time
 F DGJII=1,2,3,6 F DGJJ=0:0 S DGJJ=$O(^UTILITY("DGPM",$J,DGJII,DGJJ)) Q:'DGJJ  S DGPMA=^(DGJJ,"A"),DGPMP=^("P") D START
 D DISQ K DGJTDA,DGJII,DGJJ,DGONE Q
 Q
 ;
START ;start processing mvmts. in event driver
 S CA=+$S($P(DGPMP,"^",14):$P(DGPMP,"^",14),1:$P(DGPMA,"^",14))
 S DGPMT=+$S($P(DGPMP,"^",2):$P(DGPMP,"^",2),1:$P(DGPMA,"^",2))
 I DGPMT=1&('DGPMA) D  Q
 .I DGONE,'$G(DGQUIET) W !!,"Updating incomplete records..."
 .S:DGONE DGONE=0
 .D DIK
 D WARD^DGJTUTL
 I +X S DGJTWARD=+X,X=$S($D(^DIC(42,+X,0)):$P(^(0),"^",11),1:""),DGJTDIV=X
 I $S('$D(^DG(40.8,+X,"DT")):1,$D(^DG(40.8,+X,"DT"))&(+^("DT")=0):1,1:0) Q  ;IRT off
EN1 I DGONE,'$G(DGQUIET) W !!,"Updating incomplete records..." S DGONE=0
 I $D(^UTILITY("DGPM",$J,6)) S DGJTSIFN=$O(^(6,0))
 D DIS Q
 ;
 ;if delete adm., del all corresponding summaries
 ;
DIK S DIK="^VAS(393," F DA=0:0 S DA=$O(^VAS(393,"ADM",DGPMDA,DA)) Q:'DA  D ^DIK
 K DIK,DA,DGJDIK Q
DIS ;create IRT summ., update if edit in ADT, del record if adm. deleted
 N DR
 S DGJTADM=$S(DGPMP:$P(DGPMP,"^",14),DGPMA:$P(DGPMA,"^",14),1:"") I 'DGJTADM G DISQ ;get adm ptr
 F I=0:0 S I=$O(^VAS(393,"ADM",DGJTADM,I)) Q:'I  I $D(^VAS(393,I,0)),$P(^(0),"^",2)=1 Q
 I $D(I),I]"" S DGJTDA=I
 I DGPMT=2,I,(DGPMA'=DGPMP),'$D(^UTILITY("DGPM",$J,6)) D CHNG Q
 I DGPMT=1!(DGPMT=3) I DGPMA,'I D NEW Q:DGPMT=3  D CK S DIE="^VAS(393,",DA=DGJTDA D ^DIE Q  ;no IRT rec
 I DGPMT=1,DGPMP,'DGPMA,I S DIK="^VAS(393,",DA=I D ^DIK Q  ;del IRT record
 I DGPMT=1,I,(DGPMA'=DGPMP) S DGJTCA=I D CK,CHNG Q
 I DGPMT=3,I,(DGPMA'=DGPMP) S DGJTPMA=$S(+DGPMA:+DGPMA,1:$P(^DGPM(DGJTADM,0),"^",1)) S DGJTCA=1 S DR=".03////"_DGJTPMA D CHNG Q
 I DGPMT=3,'DGPMA,DGPMP S X=$P(DGPMP,"^",14) I $D(^DGPM(X,0)) S DGPMA=^DGPM(X,0) D NEW Q
 I DGPMT=3 Q
 I I,DGPMT=1 S DGJTCA=I
 I I,^UTILITY("DGPM",$J,6,DGJTSIFN,"P")'=^UTILITY("DGPM",$J,6,DGJTSIFN,"A") D CHNG Q  ;TS change
 I I,^UTILITY("DGPM",$J,6,DGJTSIFN,"P")=^UTILITY("DGPM",$J,6,DGJTSIFN,"A"),$P(DGPMA,"^",6)'=$P(DGPMP,"^",6) D CHNG Q  ;WARD CHNG
DISQ K DA,DIC,DIE,DIK,DR,I,DGJTADM,DGJTWD,DGJTWARD,DGJTTM,DLAYGO,DGJTST,D0,D1,DGJT,DGJT9,DGJT10,DGJTDIV,DGJTP,DGJTSIFN,DGJTSV,DIV,DGJI,DGJX,DGJTCA,DGJTPMA,DGJY,X,Y Q
 ;
 ;
NEW ;new discharge
 S DGJT=$S(DGPMA]"":+$P(DGPMA,"^",14),1:+$P(DGPMP,"^",14)),DGJT=$O(^DGPM("ATS",DFN,DGJT,0)),DGJT=$O(^(+DGJT,0)),DGJT=$O(^(+DGJT,0)),DGJT=$S($D(^DGPM(+DGJT,0)):^(0),1:"") ;last TS mvt
 S DGJTP=$S($D(^DG(40.8,+DGJTDIV,"DT")):^("DT"),1:"")
 S DGJTWD=$S($D(^DIC(42,DGJTWARD,0)):^DIC(42,DGJTWARD,44),1:"")
 S DGJTSV=$S(DGJTWARD]"":$P(^DIC(42,+DGJTWARD,0),"^",3),1:"")
 S:DGJTSV']"" DGJTSV=0 S DGJTSV=$S($D(^DG(393.1,"AC",DGJTSV)):$O(^(DGJTSV,0)),1:"") I DGJTSV']"" S DGJTSV=$O(^DG(393.1,"AC",0,0))
 S DGJX=8,DGJY=2 D DOC S DGJT9=X,X=""
 S DGJT10="" I $P(DGJTP,"^",3)!('$P(DGJTP,"^",3)&($P(DGJTP,"^",10)="A")) S DGJX=19,DGJY=4 D DOC S DGJT10=X
 I "^6^2^"[DGPMT Q
 I $D(DGJTCA) Q
 S X=DFN,DIC="^VAS(393,",DIC(0)="L",DLAYGO=393 K DD,DO D FILE^DICN
 S DGJTST=$O(^DG(393.2,"B","INCOMPLETE",0))
 I Y>0 S DIE=DIC,(DA,DGJTDA)=+Y
 I Y>0 S DR=".02////1;.03////"_+DGPMA_";.04////"_+$P(DGPMA,"^",14)_";.05////"_DGJTWD_";.06////"_DGJTDIV_";.07////"_$S(+$P(DGJT,"^",9):+$P(DGJT,"^",9),1:"")_";.08////"_DGJTSV_";.09////"_DGJT9_";.1////"_DGJT10_";.11////"_DGJTST_";.12////"_DGJT9
 I Y>0 D ^DIE
 D DISQ Q
FILE I DGPMT=1!(DGPMT=2)!(DGPMT=3) S DR=$S($D(DR):DR_";",1:"")_".05////"_DGJTWD_";"_".06////"_DGJTDIV
 S DR=$S($D(DR):DR_";",1:"")_".07////"_$S(+$P(DGJT,"^",9):+$P(DGJT,"^",9),1:"")_";.08////"_DGJTSV_";.09////"_DGJT9_";.1////"_$S(DGJT10]"":DGJT10,1:"@") D ^DIE
 D DISQ
 Q
 ;
DOC ;provider resp.
 S X=$P(DGJTP,"^",DGJY)
 S X=$S(X="A":$P(DGJT,"^",19),X="N":"",1:$P(DGJT,"^",8))
 Q
CHNG S DGJI=I D NEW S DIE="^VAS(393,",DA=DGJI D FILE Q
 ;
 ;
CK Q:'$D(^DGPM(DGJJ,0))  I $P(^DGPM(DGJJ,0),"^",17)']"" S DGJTTM=+DGPMA
 I $P(^DGPM(DGJJ,0),"^",17)]"" S X=$P(^(0),"^",17) I $D(^DGPM(X,0)) S DGJTTM=+^(0)
 S DR=".03////"_DGJTTM Q
