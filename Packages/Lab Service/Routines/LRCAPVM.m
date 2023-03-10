LRCAPVM ;DALOI/FHS - ADD WKLD CODES FOR MICRO VERIFICATION ;Jul 20, 2020@13:53
 ;;5.2;LAB SERVICE;**49,163,263,537**;Sep 27, 1994;Build 11
 ;
EN ;
 N LRORG
 Q:'$P(LRPARAM,U,14)!('$P($G(^LRO(68,LRAA,0)),U,16))  S LREND=0
 I $D(LAMIAUTO),$D(LRINST) S LRTS=$S(+$P(^LAB(62.4,LRINST,0),U,16):$P(^(0),U,16),1:LRTS),LRORG=0 I LRTS D
 .  F  S LRORG=$O(^LAH(LRLL,1,LRIFN,3,LRORG)) K LRADD Q:LRORG<1  I $D(^(LRORG,0))#2 S LRGB1=+^(0),GLB="^LAB(61.2,LRGB1,9,A)",LRADD="" D ETIOL^LRCAPV1
 ;LR*5.2*537 - LRVR Micro instrumentation logic
 ;FLD=etiology nodes
 ;Look in all "MI" subscripts for organisms
 ;3=organism,6=parasite,9=fungus,12=microbacteria,17-virus
 I $G(LRINTYPE)=1,$G(LRTS) D
 . N LRFLD,LRT,LRTIME,LRMETH,LRINST,LRADD,LRISO,LRGB1,GLB
 . S:'$G(LRURGW) LRURGW=$G(LRALERT,9)
 . S LRTIME=$$NOW^XLFDT
 . S LRMETH=$P($G(^LAH(LRLL,1,ISQN,0)),U,7)
 . I LRMETH]"" S LRINST=$O(^LAB(62.4,"D",LRMETH,0))
 . I $G(LRINST) S (LRT,LRTS)=$S(+$P(^LAB(62.4,LRINST,0),U,16):$P(^(0),U,16),1:LRTS)
 . S LRORG=0
 . I '$G(LRT) S LRT=LRTS
 . S:'$G(LRT("P")) LRT("P")=LRT
 . F LRFLD=3,6,9,12,17 S LRORG=0 D
 . . F  S LRORG=$O(^LAH(LRLL,1,ISQN,"MI",LRFLD,LRORG)) K LRADD Q:LRORG<1  I $G(^(LRORG,0)) S LRGB1=+^(0) D
 . . . ;LRISO = Isolate ID
 . . . S LRISO=$G(^LAH(LRLL,1,ISQN,"MI",LRFLD,LRORG,.1))
 . . . Q:LRISO=""
 . . . ;Do not re-accumulate workload if this is a re-transmission of
 . . . ;the same isolate id.  LRM63ORG array is set by routine LRVR0.
 . . . ;Not checking isolate number IEN in ^LAH vs ^LR because the IEN's
 . . . ;could differ between ^LAH and ^LR. The isolate ID is consistent
 . . . ;with subsequent transmissions of the same organism. Also, not
 . . . ;checking organism IEN from the ETIOLOGY (#61.2) file because an
 . . . ;organism might be filed multiple times on an accession.  In the
 . . . ;instance that an isolate id is changed for an organism, workload
 . . . ;counts must be adjusted manually. It is standard laboratory
 . . . ;practice to not change the isolate id for an organism.
 . . . Q:$D(LRM63ORG(LRFLD,LRISO))
 . . . S GLB="^LAB(61.2,LRGB1,9,A)",LRADD="" D ETIOL^LRCAPV1
 ;LR*5.2*537 end
 Q:$G(LRMIMASS)
 K GLB F  W !!?10,"(D)isplay (A)dd Work Load " R X:DTIME S X=$E(X) S:'$T!(X=U)!(X="") LREND=1 Q:X="A"!(LREND)  D:X="D" DIS^LRCAPU
 G END:LREND
 S X1="" S LRTIME=$$NOW^LRAFUNC1,LRADD=""
SEL ;
 K DIC,DA S DIC("A")="Which Test ",DIC(0)="AEQNMZ",DIC="^LRO(68,"_LRAA_",1,"_LRAD_",1,"_LRAN_",4,"
 S DA(1)=LRAN,DA(2)=LRAD,DA(3)=LRAA,X1="" F  D ^DIC Q:Y<1  S:$L(X1) X1=X1_","_+Y I '$L(X1) S X1=+Y
 G:'$L(X1) END S X=X1 D RANGE^LRWU2 I '$L(X9) W !,"NOTHING SELECTED " G END
 K DIC S LREND=0,LRSTAR=1,X9=X9_"Q:LREND  D LOAD" X X9 S LREND=0
 G EN
LOAD ;
 Q:'$D(^LAB(60,T1,0))
 I '$P(^LAB(60,T1,0),U,14) W !!?7,"  ** NO EDIT TEMPLATE FOR ",$P(^(0),U),! Q
CODE S LREC=$P(^LAB(60,T1,0),U,14) I '$D(^LAB(62.07,LREC,0)) W !,"ERROR IN ",$P(^LAB(60,T1,0),U) Q
 I '$O(^LAB(62.07,LREC,9,0)) W !!?5,"NO CODE DEFINED FOR THE TEST ",!,$C(7) Q
 W !!?10,"Additional Work load for "_$P(^LAB(60,T1,0),U),!
 S LRT=T1,DIC="^LAB(62.07,"_LREC_",9,",DIC(0)="AEZMNQ"
 F  G:LREND MORE D ^DIC Q:Y<1  S:X=U LREND=1 Q:LREND  S LRP=+Y,LRCODE=$P(Y,U,2),LRCNT=$S($P(Y(0),U,3):$P(Y(0),U,3),1:1) D CNT
 K LRSTAR1,LRCNTD
MORE S LREND=0
 Q
CNT ;
 D  Q:$D(DIRUT)!($D(DTOUT))!($D(DUOUT))
 . N DIR
 . S DIR(0)="NO^0:25:0",DIR("A")=" MULTIPLY BY "
 . I $G(LRCNT),$G(LRCNT)<26 S DIR("B")=+$G(LRCNT)
 . S DIR("?")=$$CJ^XLFSTR("to be used for this procedure.",IOM)
 . S DIR("?",1)=$$CJ^XLFSTR("Enter the WKLD CODE weight multiplier,",IOM)
 . S DIR("?",2)=$$CJ^XLFSTR("enter a number between 1 - 25",IOM)
 . D ^DIR
 S LRCNT=+Y
 I LRCNT<1 W !?5,"No workload added ",! Q
CK Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT))  S:'$D(^(LRT,1,0)) ^(0)="^68.14P^" S NODE0=^(0),LRADD="" D STUFE^LRCAPV1 K LRADD
 Q
QUE ;S X="?" D ^DIC G RD
END ;
 K DIC,T1,LRSTAR,LRADD S LREND=0
 Q
