LRPARAM ;SLC/CJS/DALISC/FHS - SET LAB PARAMETERS ;8/11/97
 ;;5.2;LAB SERVICE;**98,121,153,201**;Sep 27, 1994
INIT ;
 S U="^" I '$D(ZTQUEUED) S IOP="HOME" D ^%ZIS
 I '$D(ZTQUEUED),$S('$D(DUZ(2)):1,'DUZ(2):1,1:0) W !,"SORRY ! You must have a site defined. (NO DUZ(2))" S LREND=1 Q
 I '$D(DUZ(2)) W:'$D(ZTQUEUED) !,"SORRY ! You must have a site defined. (NO DUZ(2))" S LREND=1 Q
 I 'DUZ(2) W:'$D(ZTQUEUED) !,"SORRY ! You must have a site defined. (NO DUZ(2))" S LREND=1 Q
EN ;Entry point for external package calls - [Will not reset IO definitions]
 N X,X1,X2,Y
 K LRPARAM,LRDATA
 D
 . N X,DIK,DIC,%I,DICS,%DT
 . D DT^DICRW
 . S LRDT0=$$FMTE^XLFDT(DT,"5DZ")
 S U="^",VA200="",LRPARAM=1_"^"_$P(^LAB(69.9,1,0),"^",2,255) S:'$D(DTIME) DTIME=300
 ; LRPARAM("VR") is set to the version of lab installed at this site.
 ;This variable can be used by other packages when interfacing with
 ;laboratory routines (ie. OERR)
 S LRPARAM("VR")=$G(^DD(63,0,"VR"))_U_$G(^DD(100,0,"VR"))_U_$G(^DG(43,1,"VERSION"))
 D  ; Each Institution can have several associated divisions
 . ; The divisions are used to control editing of clinical results
 . ; performed by another instituion.
 . N N,SITE
 . S LRPARAM("ASITE",DUZ(2))="",N=$O(^LAB(69.9,1,99,"B",DUZ(2),0)) I N D
 . . S SITE=0 F  S SITE=$O(^LAB(69.9,1,99,N,1,"B",SITE)) Q:SITE<1  S LRPARAM("ASITE",SITE)=""
 S LRPCEVSO=$G(^LAB(69.9,1,"VSIT")) ;Indicates of PCE/VSIT is turned on
 S X=^LAB(69.9,1,1),LRBLOOD=$P(X,"^",1),LRURINE=$P(X,"^",2),LRSERUM=$P(X,"^",3),LRPLASMA=$P(X,"^",4),LRUNKNOW=$P(X,"^",5)
 I $D(^LRO(69,DT,0))[0 S ^(0)=DT,^LRO(69,"B",DT,DT)="",X=$P(^LRO(69,0),U,3,4),X1=($P(X,U)+1),X2=($P(X,U,2)+1),$P(^LRO(69,0),U,3)=X1,$P(^(0),U,4)=X2 K X1,X2
LABKEY ;If DUZ is a LRLAB or LRVERIFY Key holder then LRLABKY is defined. The 1st piece of LRLABKY IS 1 IF DUZ has the LRVERIFY key and the 2nd piece = LRSUPER key.
 ;If DUZ is holder of LRVERIFY and LRLIAISON then the third piece is 1
 ; The fourth 1 indicates if the user is allowed to edit Host results.
 ; LRLABKY=1^1^1^1 INDICATES THIS USER HOLD ALL FOUR SECURITY KEYS
 K LRLABKY I $G(DUZ),$D(^XUSEC("LRLAB",DUZ))!($D(^XUSEC("LRVERIFY",DUZ))) S LRLABKY="" S:$D(^XUSEC("LRVERIFY",DUZ)) $P(LRLABKY,U)=1 S:$D(^XUSEC("LRSUPER",DUZ)) $P(LRLABKY,U,2)=1
 I $P($G(LRLABKY),U,2),$D(^XUSEC("LRLIASON",DUZ)) S $P(LRLABKY,U,3)=1
 I $P($G(LRLABKY),U) S $P(LRLABKY,U,4)=1 D
 . N LRDATA
 . S I=+$O(^LAB(69.9,1,99,"B",+$G(DUZ(2)),0)) Q:I<1
 . S LRDATA=$P($G(^DIC(19.1,+$P($G(^LAB(69.9,1,99,I,0)),U,2),0)),U)
 . I $L(LRDATA),'$D(^XUSEC(LRDATA,DUZ)) S $P(LRLABKY,U,4)=0
 I $D(LRLABKY),$D(^LAB(69.9,1,"RO")),+$H'=+^("RO") W $C(7),!,"ROLLOVER ",$S($P(^("RO"),U,2):"IS RUNNING.",1:"HAS NOT RUN.")," ACCESSIONING SHOULDN'T BE DONE NOW.",$C(7) D
 . I '$$TM^%ZTLOAD W !!?7,"Taskman is not running ",!!,$C(7) Q
 . I $P($G(^LAB(69.9,1,"RO")),U,2) Q
 . N ZTSK S ZTRTN="LROLOVER",ZTIO="",ZTDTH=$H,ZTDESC="LAB ROLLOVER TASKED FROM ^LRPARAM" D ^%ZTLOAD K ZTRTN,ZTDTH,ZTDESC
 . W:$D(ZTSK) !!?10," ROLLOVER HAS BEEN TASKED  --  TRY ACCESSIONING LATER ",!!,$C(7)
VIDEO ;Get Video settings for reverse and blinking features
 S LRVIDO="$C(91)",LRVIDOF="$C(93),$C(7)"
 I $G(IOST(0)) S X=$G(^%ZIS(2,+IOST(0),5)) Q:'$L($P(X,U,4))!('$L($P(X,U,8)))!('$L($P(X,U,5)))!('$L($P(X,U,9)))  S LRVIDO=$P(X,U,4)_","_$P(X,U,8),LRVIDOF=$P(X,U,5)_","_$P(X,U,9)
 Q
VR() ;Return current version of Laboratory Package installed
 ;Other packages may call this line to determine version of lab loaded.
 ;No integration agreement required.
 Q $G(^DD(60,0,"VR"))
