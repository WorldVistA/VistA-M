DENTDPL ;WASH ISC/TJK,FDJW,JA-DISPLAY SCREEN ;8/31/92  09:03
 ;;1.2;DENTAL;***15**;Oct 08, 1992
 S:'$D(DJDPL) DJDPL="" I DJDPL'=DJNM S DJN=$O(^DENT(220.6,"B",DJNM,0)) S:DJN="" DJN=-1 G ER:DJN<1
N S:'$D(DJFF) DJFF=0
 K DJJ,DJF,DJKEY,DJY S:DJN'=+DJN DJN=$O(^DENT(220.6,"B",DJN,0)) S:DJN="" DJN=-1 G ER:DJN<0 S DJ0=^DENT(220.6,DJN,0),DJDPL=$P(DJ0,U,1),DJJ=$P(DJ0,U,2,5),DJDD=$P(DJ0,U,6),V=$O(^DENT(220.6,DJN,1,"A",0)) S:V="" V=-1 S (DJL,DJF)=V
 G ER:+V<0
 D:'DJFF HDH I DJDD'=+DJDD S DIC="^DENT(220.6,DJN,1," G N1
 S DJ0="",DJ1=DJDD F V=1:1 Q:'$D(^DD(DJ1,0,"UP"))  S DJ1=^("UP"),DJ2=$O(^("NM",0)) S:DJ2="" DJ2=-1 S DJ2=$O(^DD(DJ1,"B",DJ2,0)) S:DJ2="" DJ2=-1 S DJ2=$P($P(^DD(DJ1,DJ2,0),U,4),";",1) S:DJ2'=+DJ2 DJ2=""""_DJ2_"""" S DJ0="DA("_V_"),"_DJ2_","
 S DIC=^DIC(DJ1,0,"GL")_DJ0,V=DJF,DIE=DIC I $D(DJST),DJST>1 S DIC=^TMP($J,"DJST",DJST,"DIC")
 IF '$D(^DENT(220.6,DJN,1,"A",V)) D
 .  S YMLH=$O(^DENT(220.6,DJN,1,"A",V))
 .  I YMLH="" S YMLH=-1
 .  S (DJF,V)=YMLH
 .  Q
 ;END IF
 ;
N1 S DJK=$O(^DENT(220.6,DJN,1,"A",V,0)) S:DJK="" DJK=-1
 G ER:DJK<0!($D(^DENT(220.6,DJN,1,DJK,0))<0) S DJ0=^DENT(220.6,DJN,1,DJK,0) S:$P(DJ0,U,5)=.01 DJKEY=V G:$P(DJ0,U,2)="" ER S @$P(DJ0,U,2) X XY I V#1=0 W DJHIN X XY W $J(V,2)," ",DJLIN
 I '$P(DJ0,U,8) W:(V#1<1)&(V#1>0) DJHIN W $P(DJ0,U,1) W DJLIN W:$P(DJ0,U,5)>0 ":"
 I V#1=0!(V=.5) S DJJ(V)=$P(DJ0,U,3,7)_"^"_$P(DJ0,U,12),@$P(DJ0,U,4) X XY K:$P(DJ0,U,5)<0 V(V) I $P(DJ0,U,12)]"" S DJNO=$O(^DENT(220.6,"B",$P(DJ0,U,12),0)) S DJJ(V)=DJJ(V)_U_$P(^DENT(220.6,DJNO,1,0),U,4) K DJNO
 I V#1=0!(V=.5) S $P(DJJ(V),U,8)=$P(DJ0,U,2)
 G:V#1'=0 N2
 ;
 ;    Is there data in the field?
 IF $G(V(V))]"",DJJ(V) D  ;    yes, prepare it for display
 .  W DJHIN
 .  X XY
 .  I DJJ(V)["M" S V(V)=$E(V(V),1,+DJJ(V))
 .  S DJDB=""
 .  I DJJ(V)-$L(V(V)) S $P(DJDB," ",DJJ(V)-$L(V(V)))=" "
 .  S DJDB=V(V)_DJDB
 .  ;W V(V)
 .  ;I $D(DJDB) W DJDB
 .  ;K DJDB
 .  ;W DJLIN
 .  Q
 ELSE  D  ;    there is no data in the field, just write dots
 .  S $P(DJDB,".",DJJ(V))="."
 .  W DJLIN ;,DJDB
 .  ;K DJDB
 .  Q
 ;END IF
 ;
 ;    Are we going to spill over to the next line?
 I $L(DJDB)<80 W DJDB ;    no
 E  W $E(DJDB,1,80-DX),!,$E(DJDB,80-DX+1,$L(DJDB)) ;    yes
 K DJDB
 ;
N2 S V=$O(^DENT(220.6,DJN,1,"A",V)) S:V="" V=-1 S:V>DJL DJL=V G N1:V>0 S V=DJF
 K DJ0,DJ1,DJ2 Q
EN S DJFF=0 G N
EN1 S DJFF=1 G N
 ;Q
HDH ;HEADING
 S DJT=$P(DJ0,U,7) S DY=0,DX=0 X DJCP W @IOF,?(80-$L(DJT))/2-5,DJT,"   ",$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3)
 I $D(DJST),DJST>1 F DJK=1:1:DJST-1 W !,?DJK*2,"***",^TMP($J,"DJST",DJK,"TITLE"),"***"
 ;I $D(DJST),$P(DJJ,U,2)'="" W !,?3,"***",^TMP($J,"DJST",DJST,"TITLE"),"***"
 Q
ER X DJCL W "SCREEN **",DJNM,"**  HAS NOT BEEN PROPERLY CREATED. Check your 'A' XREF",*7 H 2
 K DIC,DIE,DJ0,DJ1,DJDD,DJDPL,DJF,DJJ,DJK,DJKL,DJKL,DJL,DJNM,DJT,V
 S DJY=-1 Q
