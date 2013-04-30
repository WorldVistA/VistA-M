LRSTUF2 ;DALOI/STAFF - MASS DATA ENTRY INTO FILE 63.04 ;07/12/12  17:03
 ;;5.2;LAB SERVICE;**121,153,263,347,350**;Sep 27, 1994;Build 230
 ;
LRSTUFF ;
 N LRCDT
 W !,"Acc #: ",LRAN
 ;
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))!'$D(^(3)) W !," not set up." Q
 ;
 S LRNOP=1,I=0
 F  S I=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,I)) Q:I<1  I $D(^(I,0)),LRTESTSV=+^(0) S LRNOP=0
 I LRNOP W " doesn't have the selected test." Q
 ;
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRODT=$P(^(0),U,4),LRSN=$P(^(0),U,5)
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX
 W ?15,PNM,?45,SSN
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,3))
 ;
 S LRCDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U),LRIDT=$P(^(3),U,5),LRMETH="(BD)"_DUZ_"/"_DUZ(2)
 I LRDPF'=62.3 S LRLLOC=$P(^(0),U,7) S:LRLLOC="" LRLLOC="UNKNOWN" W ?65,LRLLOC
 ;
 L +^LR(LRDFN,"CH",LRIDT):DILOCKTM
 I '$T W !!,"Someone else is editing this entry ",!,$C(7) Q
 ;
 I $P(^LR(LRDFN,LRSS,LRIDT,0),U,3),("pending"'[$S($D(^(LRFLD)):$P(^(LRFLD),U,1),1:"pending")) W !?25,"VERIFIED DATA, CAN'T CHANGE" L -^LR(LRDFN,"CH",LRIDT) Q
 I $P(^LR(LRDFN,LRSS,LRIDT,0),U,3) W !?5,"Some Data Already Verified"
 I '$T,$O(^LR(LRDFN,LRSS,LRIDT,1))>1 W !?5,"Some Unverified Data Already Entered." L -^LR(LRDFN,"CH",LRIDT) Q
 ;
 S I=0 F  S I=$O(^TMP("LR",$J,"VTO",I)) Q:I<1  S ^TMP("LR",$J,"VTO",I,"P")=I_U_$$NLT^LRVER1(I)
 ;
 W ! S DIE="^LR("_LRDFN_",""CH"",",DA=LRIDT D ^DIE
 I LRA'=1,$D(Y) D  Q:LREND
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . S DIR(0)="Y",DIR("A")="Do you wish to stop",DIR("B")="Y"
 . D ^DIR
 . I Y=0 Q
 . S LREND=1
 . L -^LR(LRDFN,"CH",LRIDT)
 ;
 I $G(LRVX)'="" D
 . S X=LRVX,LRFLG="",LRSPEC=+$P(^LR(LRDFN,LRSS,LRIDT,0),U,5)
 . I $G(M(LRFLD)) S LRTS=M(LRFLD)
 . E  S LRTS=$O(^LAB(60,"C",LRSS_";"_LRFLD_";1",0))
 . K LRSB S LRSB=LRFLD
 . D V25^LRVER5
 ;
STOR ; Store other info with results
 I '$G(LRNOW) S LRNOW=$$NOW^XLFDT
 I $P($G(^LR(LRDFN,LRSS,LRIDT,LRFLD)),U)'="" D
 . N LRX,LRXX,LRP,X
 . S (LRSB(LRFLD),X)=^LR(LRDFN,LRSS,LRIDT,LRFLD),X=$P(LRSB(LRFLD),U)
 . I $G(LRDEL)'="" D DELTA
 . D RANGE^LRVER5
 . S LRXX=LRSB(LRFLD),$P(LRXX,U)=X
 . S $P(LRXX,U,2)=LRFLG,$P(LRXX,U,4)=DUZ,$P(LRXX,U,9)=$G(DUZ(2))
 . S $P(LRXX,U,5)=$TR(LRNG,U,"!")
 . S $P(LRXX,U,6)=LRNOW
 . K ^TMP("LR",$J,"TMP")
 . S LRP=$O(^LAB(60,"C",LRSS_";"_LRFLD_";1",0))
 . S ^TMP("LR",$J,"TMP",LRFLD)=LRP
 . S LRX=+$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTESTSV,0)),U,9)
 . I LRX,LRP D
 . . S ^TMP("LR",$J,"TMP",LRFLD,"P")=LRX_U_$$NLT^LRVER1(LRX)_"!"_$$RNLT^LRVER1(LRP)
 . . S $P(LRXX,U,3)=$P($G(^TMP("LR",$J,"TMP",LRFLD,"P")),U,2)
 . S ^LR(LRDFN,LRSS,LRIDT,LRFLD)=LRXX,LRSB(LRFLD)=LRXX
 . I $D(^LR(LRDFN,LRSS,LRIDT,0)),$P(^(0),U,8)'[LRMETH S $P(^(0),U,8)=LRMETH_";"_$P(^(0),U,8)
 ;
 I '$D(LRSB(LRFLD)) W ?39,"**NOT STUFFED**",$C(7) L -^LR(LRDFN,"CH",LRIDT) Q
 ;
 ; Set reporting site in file #63.
 D SETRL^LRVERA(LRDFN,LRSS,LRIDT,DUZ(2))
 ;
 N LRCORECT S LRCORECT=0
 D VER^LRVER3A,REQ W ?45,"STUFFED"
 I $P(LRPARAM,U,14),$P($G(^LRO(68,LRAA,0)),U,16) D LOOK^LRCAPV1
 S ^LRO(68,"AC",LRDFN,LRIDT,LRFLD)=""
 ;
 L -^LR(LRDFN,"CH",LRIDT)
 ;
 ; Check if LEDI specimen and trigger sending results
 I $P($G(LRORU3),U,3),$O(LRSB(0)) D LRORU3^LRVER3
 ;
 Q
 ;
 ;
RANGE ; Called from LRSTUF1
 F R=$P(LRAC,"-",1):1:$P(LRAC,"-",2) S LRAC(R)=""
 Q
 ;
 ;
REQ ; Called from above - handle pending required tests.
 N LRX,X
 S X=0
 F  S X=$O(M(X)) Q:X<1  S I=M(X) I $P($G(^LR(LRDFN,"CH",LRIDT,X)),U)="" D
 . S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,I,0)=I_U_LROUTINE,$P(^(0),U,9)=$P($G(^TMP("LR",$J,"TMP",LRFLD,"P")),U)
 . S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,"B",I,I)=""
 . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,4)=""
 . S LRX=$G(^LR(LRDFN,"CH",LRIDT,X))
 . S $P(LRX,"^")="pending"
 . I $P(LRX,"^",3)="" S $P(LRX,U,3)=$P($G(^TMP("LR",$J,"TMP",LRFLD,"P")),U,2)
 . S $P(LRX,"^",4)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ))
 . S $P(LRX,"^",9)=$S($G(DUZ(2)):DUZ(2),1:"")
 . S ^LR(LRDFN,"CH",LRIDT,X)=LRX
 Q
 ;
 ;
DELTA ; Execute delta check
 ; Setup expected variables for delta check - LRLDT, X, X1
 ; X2 (delta value) set in V25^LRVER5 call above
 ;
 N LRLDT,LROK,LRTM60,LRQ,LRX,X1
 ;
 ; Calculate days back for delta check based on specimen collection date/time.
 S LRTM60=$$LRTM60^LRVR(LRCDT)
 ;
 S LRLDT=LRIDT,LROK=0,X1=""
 F  S LRLDT=$O(^LR(LRDFN,LRSS,LRLDT)) Q:LRLDT<1  D  Q:LRLDT<1!(LROK)
 . I LRLDT>LRTM60 S LRLDT=-1 Q
 . I $P(^LR(LRDFN,LRSS,LRLDT,0),U,5)'=LRSPEC!'$P(^(0),U,3) Q
 . I $D(^LR(LRDFN,LRSS,LRLDT,LRFLD)) S X1=$P(^LR(LRDFN,LRSS,LRLDT,LRFLD),U),LROK=1
 S X=$P(^LR(LRDFN,LRSS,LRIDT,LRFLD),U)
 S LRQ=1 D XDELTACK^LRVERA
 ;
 Q
