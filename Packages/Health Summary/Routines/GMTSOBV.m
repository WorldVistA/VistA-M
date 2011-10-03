GMTSOBV ; SLC/KER - HS Object - Verify                 ; 06/24/2009
 ;;2.7;Health Summary;**58,89**;Oct 20, 1995;Build 61
 ;                
 ; External References
 ;   DBIA  10006  ^DIC  (file #2 and 142.5)
 ;   DBIA  10013  ^DIK  (file #142.5)
 ;   DBIA  10026  ^DIR        
 ;   DBIA  10104  $$UP^XLFSTR
 ;   DBIA  10076  ^XUSEC(
 ;   DBIA  10076  ^XUSEC("GMTSMGR"
 ;   DBIA   3798  $$EXIST^TIUHSOBJ
 ;   DBIA  10005  DT^DICRW
 ;   DBIA  10103  $$DT^XLFDT
 ;   DBIA  10061  DEM^VADPT
 ;                       
 Q
VT(X) ; Verify Type Selection
 N GMTSHDR,GMTSNOQ,GMTSNOI,GMTSX,GMTSREDO S GMTSX=+($G(X)) Q:+GMTSX'>0 -1
 S GMTSHDR(1)="You have selected the following Health Summary Type to use as an Object:"
 S GMTSHDR(2)=" ",GMTSNOQ="",GMTSNOI="",GMTSREDO=0
 D DT^GMTSOBD(+GMTSX) I $D(^TMP("GMTSOBT",$J)) D
 . D NOQUE^GMTSOBD W ! N DIR,DTOUT,DUOUT S DIR(0)="YAO",DIR("A")="Is this correct?  ",DIR("B")="Y"
 . D ^DIR S:$$UP^XLFSTR($E(X,1))="N" GMTSREDO=1 I +Y'>0 S GMTSX=-1
 I GMTSREDO>0!(GMTSX'>0) S X=-1
 Q X
VTE(X) ; Verify Type Edit
 N GMTSX,GMTSOWN,GMTSNAT,GMTSLOCK,GMTSKEY,GMTSMGR S GMTSX=+($G(X)) Q:$D(GMTSDEV) X
 I +GMTSX'>0 W:'$D(GMTSQT) !!,"   Health Summary Type not found.",! Q -1
 I +($G(DUZ))'>0 W:'$D(GMTSQT) !!,"   User not defined.",! Q -1
 I +($$UACT^GMTSU2(+($G(DUZ))))'>0 W:'$D(GMTSQT) !!,"   User is not an active user.",! Q -1
 I '$D(^GMT(142,+GMTSX,0)) W:'$D(GMTSQT) !!,"   Health Summary Type not found.",! Q -1
 I '$L($P($G(^GMT(142,+GMTSX,0)),"^",1)) W:'$D(GMTSQT) !!,"   Invalid Health Summary Type.",! Q -1
 S GMTSMGR=$S($D(^XUSEC("GMTSMGR",+($G(DUZ)))):1,1:0),GMTSLOCK=$P($G(^GMT(142,+GMTSX,0)),"^",2)
 S GMTSKEY=1 S:$L(GMTSLOCK) GMTSKEY=$D(^XUSEC(GMTSLOCK,+($G(DUZ))))
 S GMTSOWN=$P($G(^GMT(142,+GMTSX,0)),"^",3),GMTSNAT=+($P($G(^GMT(142,+GMTSX,"VA")),"^",1))
 I GMTSNAT>0 W:'$D(GMTSQT) !!,"   You can not edit a Nationally exported Health Summary Type.",! Q -1
 I 'GMTSMGR,'GMTSKEY W:'$D(GMTSQT) !!,"   This Health Summary Type is currently locked to prevent alteration.",! Q -1
 I GMTSOWN>0,GMTSOWN'=+($G(DUZ)),'$D(^XUSEC("GMTSMGR",DUZ)) W:'$D(GMTSQT) !!,"   You can not edit a Health Summary Type you don't own.",! Q -1
 S X=GMTSX Q X
VOE(X) ; Verify Object Edit
 N GMTSX,GMTSOWN,GMTSNAT,GMTSMGR S GMTSX=+($G(X)) Q:$D(GMTSDEV) X
 I +GMTSX'>0 W:'$D(GMTSQT) !!,"   Health Summary Object not found.",! Q -1
 I +($G(DUZ))'>0 W:'$D(GMTSQT) !!,"   User not defined.",! Q -1
 I +($$UACT^GMTSU2(+($G(DUZ))))'>0 W:'$D(GMTSQT) !!,"   User is not an active user.",! Q -1
 I '$D(^GMT(142.5,+GMTSX,0)) W:'$D(GMTSQT) !!,"   Health Summary Object not found.",! Q -1
 I '$L($P($G(^GMT(142.5,+GMTSX,0)),"^",1)) W:'$D(GMTSQT) !!,"   Invalid Health Summary Object.",! Q -1
 S GMTSMGR=$S($D(^XUSEC("GMTSMGR",+($G(DUZ)))):1,1:0)
 S GMTSOWN=$P($G(^GMT(142.5,+GMTSX,0)),"^",17),GMTSNAT=+($P($G(^GMT(142,+GMTSX,"VA")),"^",1))
 I GMTSNAT>0 W:'$D(GMTSQT) !!,"   You can not edit a Nationally exported Health Summary Object.",! Q -1
 I GMTSOWN>0,GMTSOWN'=+($G(DUZ)) W:'$D(GMTSQT) !!,"   You can not edit a Health Summary Object you don't own.",! Q -1
 S X=GMTSX Q X
VO(X) ; Verify Object
 N GMTSHDR,GMTSNOQ,GMTSNOI,GMTSX,GMTSREDO S GMTSREDO=0,GMTSX=+($G(X)) Q:+GMTSX'>0 -1
 S GMTSHDR(1)="You have selected the following Health Summary Object:"
 S GMTSHDR(2)=" " D SO^GMTSOBS(+GMTSX) W ! N DIR,DTOUT,DUOUT S DIR(0)="YAO",DIR("A")="Is this correct?  ",DIR("B")="Y"
 D ^DIR S:$$UP^XLFSTR($E(X,1))="N" GMTSREDO=1
 S X=1 I GMTSREDO>0!(+Y'>0) S X=-1
 Q X
VOD(X) ; Verify Object Deletion
 N GMTS,GMTSIEN,GMTSOWN,GMTSOK,GMTSI,GMTSN,GMTST,GMTSS,GMTSNAT,DIR,DTOUT,DIROUT,DUOUT,Y
 S GMTSOK=0,GMTSIEN=+($G(X)) I +X'>0 D  Q 0
 . W !!,"   Sorry, you can not delete this Health Summary Object.",!
 S GMTSN=$P($G(^GMT(142.5,+($G(GMTSIEN)),0)),"^",1) I '$L(GMTSN) D  Q 0
 . W !!,"   Sorry, you can not delete this Health Summary Object."
 . W !,"   There is a problem with the object's NAME field (#.01).",!
 S GMTSNAT=$P($G(^GMT(142.5,+($G(GMTSIEN)),0)),"^",20),GMTSOWN=$P($G(^GMT(142.5,+($G(GMTSIEN)),0)),"^",17)
 I +GMTSOWN>0,+GMTSOWN'=+($G(DUZ)) D  Q 0
 . W !!,"   You can not delete a Health Summary Object you don't own.",!
 I +GMTSNAT>0,'$D(GMTSDEV) D  Q 0
 . W !!,"   You can not delete a Nationally Exported Health Summary Object.",!
 S GMTST=" Object:  "_GMTSN,GMTSS="",$P(GMTSS," ",(60-$L(GMTST))\2)=" ",GMTST=GMTSS_GMTST
 I '$L($T(EXIST^TIUHSOBJ)) D  Q 0
 . W !!,"   Unable to determine if this Health Summary Object is linked"
 . W !,"   to a TIU Object.  Nothing deleted.",!
 S X=$$EXIST^TIUHSOBJ(GMTSIEN) Q:+X'>0 1
 S DIR("A",1)="   WARNING -- You are about to delete a Health Summary Object "
 S DIR("A",2)="   currently in use by TIU.  If you continue, then the associated"
 S DIR("A",3)="   TIU Object will not display correctly."
 S DIR("A",4)="",DIR("A",5)=GMTST,DIR("A",6)=""
 S DIR("A")=" Are you sure you want to delete this Health Summary Object?  "
 S DIR(0)="YAO",DIR("B")="NO",(DIR("?"),DIR("??"))="^D VODH^GMTSOBV"
 D ^DIR S X=$S(+Y>0:+GMTSX,1:0) S:$D(DTOUT)!($D(DUOUT)) X=0
 Q X
VODH ; VOD Help
 W !,"     Enter either 'Y' or 'N'."
 Q
DEL(X) ; Verify Object Deletion
 N GMTSIEN S GMTSIEN=+($G(X)) Q:GMTSIEN'>0 0 Q:'$L($P($G(^GMT(142.5,+GMTSIEN,0)),"^",1)) 0
 Q:+($P($G(^GMT(142.5,+($G(GMTSIEN)),0)),"^",17))&(+($P($G(^GMT(142.5,+($G(GMTSIEN)),0)),"^",17))'=+($G(DUZ))) 0
 Q:+($P($G(^GMT(142.5,+($G(GMTSIEN)),0)),"^",20))&('$D(GMTSDEV)) 0
 I $L($T(EXIST^TIUHSOBJ)),+($$EXIST^TIUHSOBJ(GMTSIEN))>0,'$D(GMTSDEV) Q 0
 Q 1
CRD(X) ; Create Delete
 N GMTSIEN S GMTSIEN=+($G(X)) Q:GMTSIEN'>0  N DA,DIK,GMTSC,GMTSE,GMTSN,GMTST,GMTSR S GMTSN=$P($G(^GMT(142.5,+GMTSIEN,0)),"^",1)
 S GMTSC=+($P($G(^GMT(142.5,+($G(GMTSIEN)),0)),"^",17)) I +GMTSC>0,+GMTSC'=+($G(DUZ)) Q
 S GMTSE=+($P($G(^GMT(142.5,+($G(GMTSIEN)),0)),"^",20)) I GMTSE>0&('$D(GMTSDEV)) Q
 I $L($T(EXIST^TIUHSOBJ)),+($$EXIST^TIUHSOBJ(GMTSIEN))>0 Q
 S GMTSN=+($P($G(^GMT(142.5,+($G(GMTSIEN)),0)),"^",1)),GMTST=+($P($G(^GMT(142.5,+($G(GMTSIEN)),0)),"^",3))
 I $L(GMTSN),+($G(GMTST))>0,$D(^GMT(142,+($G(GMTST)),0)) Q
 S DA=GMTSIEN,DIK="^GMT(142.5," D ^DIK
 Q
NAME(X) ; Verify Name for $$CRE^GMTSOBJ
 N GMTSN,GMTSE S GMTSN=$G(X),GMTSE=$$EXIST(GMTSN) S:$L(GMTSN)<3!($L(GMTSN)>60) GMTSN=""
 I $L(GMTSN)>2,$L(GMTSN)'>60,GMTSE'>0 Q X
 N X,Y,DIR,DIROUT,DTOUT,DUOUT
 S DIR(0)="FAO^3:60^N GMTS S GMTS=$$NIT^GMTSOBV(X) K:+GMTS'>0 X",GMTSN=""
 S DIR("A")=" Health Summary Object Name:  "
 S (DIR("?"),DIR("??"))="^D NH^GMTSOBV"
 D ^DIR S:$L(Y)>2&($L(Y)'>60) GMTSN=Y S X=GMTSN W !
 Q X
NIT(X) ; Name Input Transform
 N GMTSN S GMTSN=$$EXIST($G(X)) Q:+GMTSN<0 0
 I +GMTSN>0 D  Q 0
 . W !!,"     A Health Summary Object of the same name exist"
 Q 1
NH ; Name Help
 W !,"     Enter a name of a new Health Summary Object, "
 W !,"     3 to 30 characters in length."
 Q
EXIST(X) ; Name Exist
 ; Returns   0  Does not Exist
 ;           1  Exist
 ;          -1  Error
 N GMTSN,GMTSO,GMTSC,GMTSI,GMTSE,GMTST S GMTSN=$$UP^XLFSTR($G(X))
 Q:$L(GMTSN)<3 -1  Q:$L(GMTSN)>60 -1
 S GMTSE=0,GMTSO=$E(GMTSN,1,28),GMTSO=$E(GMTSO,1,($L(GMTSO)-1))_$C($A($E(GMTSO,$L(GMTSO)))-1)_"~",GMTSC=$E(GMTSO,1,($L(GMTSO)-2))
 F  S GMTSO=$O(^GMT(142.5,"C",GMTSO)) Q:GMTSO=""!(+GMTSE>0)!(GMTSO'[GMTSC)  D
 . S GMTSI=0 F  S GMTSI=$O(^GMT(142.5,"C",GMTSO,GMTSI)) Q:+GMTSI=0  D
 . . S GMTST=$$UP^XLFSTR($P($G(^GMT(142.5,GMTSI,0)),"^",1)) S:GMTSN=GMTST GMTSE=1
 S X=GMTSE
 Q X
PAT ; Patient Lookup
 K DFN,GMP D DT^DICRW N DIC,DTOUT,DUOUT,DIROUT,GMTSNAM,GMTSLAS,VA,VADM
 S DIC=2,DIC("A")=" Select Patient:  ",DIC(0)="AEQMZ",DT=$$DT^XLFDT,DTIME=300 D ^DIC I +Y>0 D
 . S DFN=+Y N GMTSNAM,GMTSLAS,VA,VADM D DEM^VADPT S GMTSNAM=$G(VADM(1)),GMTSLAS=+($G(VA("BID")))
 . S GMP=1,GMP(0)=1,GMP(1)=DFN_"^"_GMTSNAM_"^ "_GMTSNAM_" "_$S(+GMTSLAS>0:"(",1:0)_+GMTSLAS_$S(+GMTSLAS>0:")",1:0)_"^1"
 Q
LKO(X) ; Lookup Object
 N DIC,DTOUT,DUOUT,DIROUT,DIR,GMTSX
 S DIC="^GMT(142.5,",DIC("A")=" Select HEALTH SUMMARY OBJECT:  ",U="^"
 S DIC(0)="AEMQ" K DLAYGO D ^DIC S (X,GMTSX)=+Y Q:+Y'>0 -1  Q:$D(DTOUT)!($D(DUOUT)) -1
 I +Y>0 D  Q X
 . N DIR,GMTSI,GMTSN S GMTSI=+Y,X=-1,GMTSN=$P($G(^GMT(142.5,+GMTSI,0)),"^",1) Q:'$L(GMTSN)
 . S DIR(0)="YAO",DIR("A")=" Is this correct?  ",DIR("B")="Y"
 . W !!,"You have selected ",GMTSN,! D SO^GMTSOBS(GMTSX) W !
 . D ^DIR S X=$S(+Y>0:+GMTSX,1:-1) S:$D(DTOUT)!($D(DUOUT)) X=-1
 Q X
TRIM(X) ; Trim Space Characters
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
