LR7OSBR ;slc/dcm - Silent BB report ;8/11/97
 ;;5.2;LAB SERVICE;**121,230,387**;Sep 27, 1994;Build 10
EN ;
 I '$D(DFN) S DFN=$P(^LR(LRDFN,0),"^",3)
 I $$GET^XPAR("DIV^SYS^PKG","OR VBECS ON",1,"Q"),$L($T(EN^ORWLR1)),$L($T(CPRS^VBECA3B)) D  Q
 . D VBECS
 . I $$GET^XPAR("DIV^SYS^PKG","OR VBECS LEGACY REPORT",1,"Q") D
 .. D LINE^LR7OSUM4
 .. D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(20,CCNT,"*** [LEGACY VISTA BLOOD BANK REPORT] ***")
 .. D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(4,CCNT,"The following historical information comes from the Legacy VISTA Blood Bank System")
 .. D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(4,CCNT,"It represents data collected prior to the installation of VBECS. Some of the information")
 .. D LN S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(4,CCNT,"in this report may have been duplicated in the VBECS report above (if available).")
 .. D LINE^LR7OSUM4
 .. D LEGACY
 D LEGACY
 Q
LEGACY ;VISTA Legacy Blood Bank Report
 I '$D(^LR(LRDFN,"BB"))&($O(^LR(LRDFN,.99))>3!($O(^LR(LRDFN,.99))<1)) Q
 S (LRN(2),LRSAV,LR("S"))=1,LRSS="BB"
 K ^TMP("LRBL",$J)
 F X=2.91,8,10.3,11.3 S LRN(X)=$P(^DD(63.01,X,0),"^")
 D SET
 N LRDFN
 S G=0
 F  S G=$O(^TMP("LRBL",$J,G)) Q:G=""  S N=0 F  S N=$O(^TMP("LRBL",$J,G,N)) Q:N=""  S LRDFN=0 F  S LRDFN=$O(^TMP("LRBL",$J,G,N,LRDFN)) Q:'LRDFN  S LR=^(LRDFN) D ^LR7OSBR1
 K ^TMP("LRBL",$J)
 Q
VBECS ;;Gets Blood Bank Report from VBECS
 N CNT,LRI
 K ^TMP("ORLRC",$J)
 D EN^ORWLR1(DFN),LN
 I '$O(^TMP("ORLRC",$J,0)) S ^TMP("ORLRC",$J,1,0)="",^TMP("ORLRC",$J,2,0)="No Blood Bank report available..."
 S CNT=$O(^TMP("LRC",$J,9999999999),-1),LRI="",^TMP("LRH",$J,"BLOOD BANK")=$S(CNT>0:CNT,1:1)
 F  S LRI=$O(^TMP("ORLRC",$J,LRI)) Q:LRI=""  S X=^(LRI,0),CNT=CNT+1,^TMP("LRC",$J,CNT,0)=X
 S GCNT=CNT
 K ^TMP("ORLRC",$J)
 Q
SET ;
 S W=^LR(LRDFN,0),Y=$P(W,"^",3),(LRDPF,P)=$P(W,"^",2),X=^DIC(P,0,"GL"),X=@(X_Y_",0)"),Z=+$G(^(.104)),Z(1)="^"_$P($G(^DD(P,.104,0)),"^",3),SSN=$P(X,"^",9)
 D SSN^LRU
 S LRMD=""
 I Z,$D(@(Z(1)_Z_",0)")) S LRMD=$P(^(0),"^")
 I 'Z S Z=$S($D(^LR(LRDFN,.2)):+^(.2),1:"") I Z,$D(^VA(200,Z,0)) S LRMD=$P(^(0),"^")
 S ^TMP("LRBL",$J,LRLLOC,$P(X,"^"),LRDFN)=$P(X,"^",3)_"^"_SSN_"^"_$P(W,"^",5)_"^"_$P(W,"^",6)_"^"_LRMD
 Q
 ;
C ;
 S X=$P(^LRO(69.2,LRAA,3,0),U,4)
 W !?30,"(",X," patient",$S(X>1:"s",1:""),")"
 Q
 ;
A ;
 S X="BLOOD BANK",DIC=68,DIC(0)="MOXZ"
 D ^DIC Q:Y<1
 S LRAA=+Y,LRAA(1)=$P(Y,"^",2),LRAA(2)=$P(Y(0),"^",2),LRABV=$P(Y(0),"^",11),LRSS=$P(Y(0),"^",2)
 Q
 ;
EN1(DFN) ;Process formatted Blood Bank Report
 ;Return formated report in ^TMP("LRC",$J)
 Q:'$D(^TMP("LRRR",$J,+$G(DFN),"BB"))
 N LBL,LCNT,LRAA,LRACC,LRAD,LRAN,LRCMNT,LRDFN,LRDPF,LRIDT,LRJ02,LRLLT,LRPG,LRSB
 N LRONESPC,LREND,LRONETST,LRLLOC,GCNT,GIOM,LREND,CCNT,CT1,COUNT,LRIN,SEX,SSN,CT1
 K ^TMP("LRC",$J)
 S (LRONETST,LRONESPC)="",CCNT=1,COUNT=99,(LREND,LRIN,CT1,GCNT)=0,GIOSL=999999,GIOM=80,LROUT=9999999
 Q:'$G(DFN)
 S LRDFN=$$LRDFN^LR7OR1(DFN)
 Q:'LRDFN
 S LRDPF="2^DPT(",LRLLOC=$S($L($G(ORL(0))):ORL(0),1:"unknown")
 S SEX=$P($G(@("^"_$P(LRDPF,"^",2)_+DFN_",0)")),"^",2),SSN=$P(^(0),"^",9)
 S LRIDT=0 F  S LRIDT=$O(^TMP("LRRR",$J,DFN,"BB",LRIDT)) Q:LRIDT<1  D
 . N DFN
 . D EN
 Q
LN ;
 S GCNT=GCNT+1,CCNT=1
 Q
