LRAC14 ;DALOI/DH/RLM-FIND LOCATION FOR MULTIPLE ABBREVIATION ;6/16/97 15:45
 ;;5.2;LAB SERVICE;**272**;SEP 27, 1994
 ; Reference to ^SC( supported by IA # 908
 ; Reference to ^%DTC supported by IA # 10000
 ; Reference to ^VADPT supported by IA # 10061
 ; Reference to ^XMD supported by IA # 10070
INIT ;
 Q:'$D(LRLLOC)
 S LRODT=DT
 Q:'$D(^LAB(64.58,"C"))
 I '$G(LRLLIN) S LRLLIN=0
 ;S LRLLIN=$O(^LAB(64.58,"C",LRLLOC,LRLLIN))
 ;I +$G(LRLLIN)>0 QUIT
CNT S LRCNT9=$G(LRCNT9)+1
 Q:'$G(LRDT)
 S LRODT=LRDT
 Q:'$D(^LRO(69,LRODT,1,"AR",LRLLOC))
 S PNM1=$O(^LRO(69,LRODT,1,"AR",LRLLOC,""))
 Q:'$D(^LRO(69,LRODT,1,"AR",LRLLOC,PNM1))
 S LRDFN1=$O(^LRO(69,LRODT,1,"AR",LRLLOC,PNM1,0))
 S DFN=$P(^LR(LRDFN1,0),U,3) D ^VADPT
 Q:'$D(^LRO(69,LRODT,1,"AR",LRLLOC,PNM1,LRDFN1))
 D CH D MI D BB D SP
 ; ^LR(50954,"CH",7029381.94999,0) = 2970617.05001^^^^71^WUA 0616 30^^^^36560^WMHC
CH ;
 S LRSUB="CH" D LR
 D MAIL
 K LRNODE
 Q:LRLLIN=0  ;--> This happens when location is UNKNOWN
MI ;
 Q:$G(LRLLIN)>0
 S LRSUB="MI" D LR
 Q
BB ;
 Q:$G(LRLLIN)>0
 S LRSUB="BB" D LR
 Q
SP ;
 Q:$G(LRLLIN)>0
 S LRSUB="SP" D LR
 Q
LR ;
 Q:'$D(^LR(LRDFN1,LRSUB))
 S LRIDT=$O(^LRO(69,LRODT,1,"AN",LRLLOC,LRDFN1,0)) Q:+LRIDT'>0  D
 .  I $D(^LR(LRDFN1,LRSUB,LRIDT,0)) S LRNODE=^LR(LRDFN1,LRSUB,LRIDT,0)
 .  Q:$G(LRNODE)=""
 .  S LRAD=9999999-LRIDT
 .  S LRAD=$P(LRAD,".")
 .  S LRACCN=$P(LRNODE,U,6)
 .  S LRAAN=$P(LRACCN," ") S LRAA=$O(^LRO(68,"B",LRAAN,0))
 .  Q:LRAA=""
 .  S LRAD=$S(LRSUB'="CH":$E(LRAD,1,3)_"0000",1:$E(LRAD,1,3)_$P(LRACCN," ",2))
 .  S LRAN=+$P(LRNODE," ",3)
 .  Q:LRAN'>0
 .  Q:LRAA'>0!(LRAD'>0)
 .  Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  D LRO
 ;
 ;D END
 Q
LRO ;
 S LRLLIN=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,13)
 ;W !,^SC(LRLLIN,0)
 ;K LRLLIN
 I '$G(LRLLIN) S ^TMP("LR","NO-LRLLIN",LRACCN,LRLLOC)="" D LRO69
 Q
LRO69 ;
 I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) S LRNODE=^(0) D
 .  S LRODT=$P(LRNODE,U,4),LRSN=$P(LRNODE,U,5)
 .  Q:$G(LRSN)'>0
 .  Q:'$D(^LRO(69,LRODT,1,LRSN,0))
 .  S LRLLIN=$P(^LRO(69,LRODT,1,LRSN,0),U,9)
 ;K LRLLIN
 I '$G(LRLLIN) D
 .  I '$G(PNM) S PNM=PNM1
 .  D PT^LRX S LRDATA=$G(PNM1)_U_$G(SSN)_U_$G(LRODT)_U_$G(DFN)
 .  S ^TMP("LR","LR-NO-LOC",LRLLOC)=LRDATA ;--->Send message
 .  D MAIL
 Q
MAIL ;
 ; Send a message to entries in G.LMI if the
 ; location can't be found in ^SC
 I $G(DUZ)'>0 S LRDUZ2=.5
 I $G(LRDUZ2)'>0 S LRDUZ2=.5
 S Y=0
 S XMY("G.LMI")="" D
 .  S XMDUZ=LRDUZ2
 .  S XMTEXT="LRTXT("
 .  S LRTXT(1)="Flash... Have a problem with: "_$G(LRLLOC)_" "_$G(VADM(1))_" "_$G(VADM(2))_" For "_$G(LRODT)
 .  I $G(LRLLIN) S LRTXT(2)="I think it might be: "_$G(^SC(LRLLIN,0))
 .  S XMSUB="Problem resolving locations for cumulative."
 .  D ^XMD
 QUIT
END ;
 QUIT
 K LRCNTCUM,LRSUB,LRDFN1,LRIDT,LRAD,LRAA,LRAN,LRACCN,LRAAN,LRODT,LRDUZ2
 K LRTXT,LRTIME0,LRTIME9
 Q
LOOK ;
 S X=0
 D NOW^%DTC S LRTIME0=%
 S X=0
 F  S X=$O(^LAC("LRAC",X)) Q:X=""
 D NOW^%DTC S LRTIME9=%
 W LRTIME0," TO ",LRTIME9
 ;  in ^LRO
 ;  From that we get the LRDFN and look ^LR(LRDFN,"CH" or 
 ;  ^LR(LRDFN,"MI"
 ;  fROM this we get the accn---Get the IEN from the accn area by
 ;  --------^LRO(68,"B","ABBRV")-----
 ;  The last peice of the 0 node is the IEN forn ^SC
 ;  Take that and look in the B x-ref of ^LAB(64.5,1,5,"B",IEN
 ;                                        ^LAB(64.5,1,5,"B",1870,422
 ;  and get the ien for the separate location and where it should
 ;  print
 ;  Lastly set LRLLIN VARABLE TO to the ien in ^SC
 QUIT
