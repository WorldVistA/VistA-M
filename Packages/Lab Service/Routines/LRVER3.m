LRVER3 ;DALOI/STAFF - DATA VERIFICATION ;05/10/11  13:50
 ;;5.2;LAB SERVICE;**42,100,121,140,171,153,221,286,291,406,350**;Sep 27, 1994;Build 230
 ;
 D V1
 I $D(LRLOCKER)#2 L -@(LRLOCKER) K LRLOCKER
 Q
 ;
 ;
V1 ;
 ;
 I $D(LRLOCKER)#2 L -@(LRLOCKER)
 S LRLOCKER="^LR("_LRDFN_","""_LRSS_""","_LRIDT_")"
 D LOCK^DILF(LRLOCKER) ; L +@(LRLOCKER):DILOCKTM
 I '$T W !," This entry is being edited by someone else." Q
 ;
 I $D(LRGVP) S X="1-"_LRNTN D RANGE^LRWU2 G L10
 S LRALL="",LRALERT=LROUTINE,LRLCT=6
 ;
 ; List any not performed tests.
 S I=0
 F  S I=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,I)) Q:I<1  D
 . S LRX=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,I,0))
 . I $P(LRX,"^",6)'="*Not Performed" Q
 . W !,?3,$P(^LAB(60,I,0),"^"),?25," ",$P(LRX,"^",6)
 . S LRLCT=LRLCT+1 D:LRLCT>22 WT^LRVER4
 ;
 ; No tests to edit
 I LRNTN=0 D COM^LRVR4 G EXIT
 ;
 F I=1:1:LRNTN I $D(LRNAME(I)) D
 . S LRALL=LRALL_","_I W !,I,"  ",LRNAME(I)
 . I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,$O(LRNAME(I,0)),0))#2 D
 . . S LRX=^LRO(68,LRAA,1,LRAD,1,LRAN,4,$O(LRNAME(I,0)),0)
 . . S LRAL=$P(LRX,U,2)#50
 . . I $P(LRX,U,5) W ?25,$S($P(LRX,U,6)'="":$P(LRX,U,6),1:" verified")
 . . I LRAL S LRALERT=$S(LRAL<LRALERT:LRAL,1:LRALERT)
 . S LRLCT=LRLCT+1 D:LRLCT>22 WT^LRVER4
 ;
 I $D(LRALERT),LRALERT<($P(LRPARAM,U,20)+1) D
 . W !?15 W:IOST["C-" @LRVIDO
 . W "Test ordered "_$P($G(^LAB(62.05,+LRALERT,0)),U)
 . W:IOST["C-" @LRVIDOF W !,$C(7)
 ;
 S X9="" I LRNTN=1 S T1=1 G L10
V9 S LRALL=$P(LRALL,",",2,99)
 R !!,"TEST #(s) (or ""ALL""): ",X:DTIME S:'$T X=U S:X["A" X=LRALL
 I X["?" W !,"Enter for example 1,2,5-9." G V9
 Q:X[U!(X="")  D RANGE^LRWU2 G EXIT:X9="" X (X9_"S:'$D(LRNAME(T1)) X=0") G EXIT:X=0
 ;
L10 ;
 N LRCORECT S LRCORECT=0
 S LRNX=0 X (X9_"D EX1^LRVER1")
 ;
 ; Calculate days back for delta check based on specimen collection date/time.
 S LRTM60=$$LRTM60^LRVR(LRCDT)
 D V7^LRVER2
 ;
 S LRCMTDSP=$$CHKCDSP^LRVERA
 K LRSA,LRSB,LRORU3
 F LRSB=1:0 S LRSB=$O(^LR(LRDFN,LRSS,LRIDT,LRSB)) Q:LRSB<1  D
 . S LRSB(LRSB)=^(LRSB),LRSB(LRSB,"P")=$P(LRSB(LRSB),U,3)
 . I $D(LRNOVER) S LRNOVER(LRSB)=""
 S LREDIT=1
 D ^LRVER4
 ;
 ; If group data review then quit before updating results
 I $D(LRGVP) G EXIT
 ;
 I '$O(LRORD(0)) G EXIT
 ;
 ; Set reporting site in file #63.
 D SETRL^LRVERA(LRDFN,LRSS,LRIDT,DUZ(2))
 ;
 I '$G(LRCHG),'LRVF D
 . N LRNOW S LRNOW=$$NOW^XLFDT
 . F LRSB=1:0 S LRSB=$O(LRSB(LRSB)) Q:LRSB<1  I $P(LRSB(LRSB),"^")'="" D
 . . S $P(LRSB(LRSB),U,6)=LRNOW
 . . S ^LR(LRDFN,LRSS,LRIDT,LRSB)=LRSB(LRSB)
 ;
 I $G(LRCHG) D CHG K LRCHG,LRUP I $G(LREND) S LREND=0 D ASKXQA,EXIT Q
 ;
 I $D(LRSA),$D(LRF) D  Q
 . K LRF
 . S X=$P(^LR(LRDFN,LRSS,LRIDT,0),U,9)
 . S:$L(X)&($E(X)'["-") $P(^(0),U,9)="-"_X
 . D V11,ASKXQA
 ;
 ;G EXIT:$D(LRGVP),V11:LRVF&$D(LRSA),V1:LRVF&(LRNTN>1),EXIT:LRVF
 I $D(LRGVP) D EXIT Q
 I LRVF,$D(LRSA) D V11,ASKXQA Q
 I LRVF,LRNTN>1 D V1 Q
 I LRVF D ASKXQA,EXIT Q
 ;
NOVER ;
 I $O(LRNOVER(0)) D  G EXIT
 . N LRI,LRX
 . S LRI=1
 . F  S LRI=+$O(LRNOVER(LRI)) Q:LRI<2  D
 . . N LRX,LRERR
 . . S LRX="Test Not Reviewed: "_$$GET1^DID(63.04,LRI,"","LABEL","","LRERR")
 . . I $G(LRERR("DIERR",1)) W !,"For DATANAME "_LRI_" - "_LRERR("DIERR",1,"TEXT",1) Q
 . . W !,LRX
 . . I $D(LRSB(LRI))#2 W " = "_$P(LRSB(LRI),U)_" "_$P(LRSB(LRI),U,2)
 . W !,$$CJ^XLFSTR("The above test(s) have results already entered,",IOM)
 . W !,$$CJ^XLFSTR("but you did not select them for review.",IOM)
 . W !,$$CJ^XLFSTR(" Accession NOT approved. ",IOM),$C(7)
 . W !,$$CJ^XLFSTR("You must review all results before ANY can be released.",IOM),!!
 . W:$E(IOST,1,2)="C-" @LRVIDO
 . W $$CJ^XLFSTR("Suggest you select 'ALL' tests for verification/review. ",IOM)
 . W:$E(IOST,1,2)="C-" @LRVIDOF W !,$C(7)
 I $O(LRNOVER(0)) W !,"Has not been reviewed and have data.  Not approved.",! G EXIT
 I '$P($G(LRLABKY),U) W !,$C(7),"ENTERED BUT NOT APPROVED",! G EXIT
 I '$O(LRSB(0)) W !?5,"Nothing verified ",$C(7),! G EXIT
 N CNT S CNT=1
 ;
AGAIN ;
 R !,"Approve for release by entering your initials: ",LRINI:DTIME
 I $E(LRINI)="^" W !!?5,$C(7),"Nothing verified!" D READ G EXIT
 I LRINI'=LRUSI,$$UP^XLFSTR(LRINI)=$$UP^XLFSTR(LRUSI) S LRINI=LRUSI
 I $S($E(LRINI)="?":1,LRINI'=LRUSI&(CNT<2):1,1:0) W !,$C(7),"Please enter your correct initials" S:$E(LRINI)="?" CNT=0 S CNT=CNT+1 G AGAIN
 I LRINI'=LRUSI W !!?5,$C(7),"Nothing verified!" D READ G EXIT
 D V11
 D ASKXQA
 Q
 ;
 ;
V11 ;
 I $D(XRTL) D T0^%ZOSV ; START RESPONSE TIME LOGGING
 I +LRDPF=2&($G(LRSS)'="BB")&('$$CHKINP^LRBEBA4(LRDFN,LRODT)) D
 .D BAWRK^LRBEBA(LRODT,LRSN,1,.LRBEY,.LRTEST)
 D VER^LRVER3A
 I $P(LRPARAM,U,14),$P($G(^LRO(68,LRAA,0)),U,16) D LOOK^LRCAPV1
 N LRX
 S LRX=0
 F  S LRX=$O(^TMP("LR",$J,"TMP",LRX)) Q:LRX<1  S:'$D(^LRO(68,"AC",LRDFN,LRIDT,LRX)) ^(LRX)="" I LRVF S ^(LRX)=""
 I $P($G(LRORU3),U,3),$O(LRSB(0)) D LRORU3
 I $D(XRT0) S XRTN="V11^LRVER3" D T1^%ZOSV ; STOP RESPONSE TIME LOGGING
 S LRVF=1
 Q
 ;
 ;
EXIT Q
 ;
 ;
READ ;
 N X W !!,"Press ENTER or RETURN to continue: " R X:DTIME
 Q
 ;
 ;
CHG ; Check for changes, save results and create audit trail
 N LRNOW
 S LRUP="",LRNOW=$$NOW^XLFDT
  F  S LRCHG=$O(LRSB(LRCHG)) Q:LRCHG<1  D
 . I '$D(LRSA(LRCHG)) S LRUP=1 Q
 . I $P(LRSA(LRCHG),"^")=""!($P(LRSA(LRCHG),"^")="pending") D  Q   ; Update user/release time/performing lab if results entered.
 . . S LRSA(LRCHG,3)=1
 . . S LRUP=1
 . . S $P(LRSB(LRCHG),U,4)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ))
 . . S $P(LRSB(LRCHG),U,6)=LRNOW
 . . S $P(LRSB(LRCHG),U,9)=$S($G(LRDUZ(2)):LRDUZ(2),$G(DUZ(2)):DUZ(2),1:"")
 . I $P(LRSA(LRCHG),"^")'=$P(LRSB(LRCHG),"^") S LRUP=1,$P(LRSA(LRCHG,2),"^")=1 ; results changed
 . I $P(LRSA(LRCHG),"^",2)'=$P(LRSB(LRCHG),"^",2) S LRUP=1,$P(LRSA(LRCHG,2),"^",2)=1 ; normalcy flag changed
 . I $P(LRSA(LRCHG),"^",5)'=$P(LRSB(LRCHG),"^",5) D  ; units/normals changed
 . . N LRX,LRY
 . . S LRX=$$UP^XLFSTR($P(LRSA(LRCHG),"^",5)),LRX=$TR(LRX,"""")
 . . S LRY=$$UP^XLFSTR($P(LRSB(LRCHG),"^",5)),LRY=$TR(LRY,"""")
 . . I LRX'=LRY S LRUP=1,$P(LRSA(LRCHG,2),"^",5)=1
 . I $D(LRSA(LRCHG,2)) D  ; Update user/release time/performing lab if results changed.
 . . S $P(LRSB(LRCHG),U,4)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ))
 . . S $P(LRSB(LRCHG),U,6)=LRNOW
 . . S $P(LRSB(LRCHG),U,9)=$S($G(LRDUZ(2)):LRDUZ(2),$G(DUZ(2)):DUZ(2),1:"")
 I 'LRUP S LREND=1 Q
 S LREND=0
 W !! W:IOST["C-" @LRVIDO W "Approve update of data by entering your initials: " W:IOST["C-" @LRVIDOF
 R LRINI:DTIME
 I '$T S LREND=1
 I 'LREND,LRINI'=LRUSI,$$UP^XLFSTR(LRINI)=$$UP^XLFSTR(LRUSI) S LRINI=LRUSI
 I LRINI'=LRUSI S LREND=1
 I LREND W !,$C(7),"No updating occurred ",! Q
 ;
 F LRSB=1:0 S LRSB=$O(LRSB(LRSB)) Q:LRSB<1  D
 . K:'$D(^LR(LRDFN,LRSS,LRIDT,LRSB)) LRSA(LRSB)
 . I $P(LRSB(LRSB),"^")'="" S ^LR(LRDFN,LRSS,LRIDT,LRSB)=LRSB(LRSB)
 . I $D(LRSA(LRSB,1)),$D(LRSA(LRSB,2)) D DIDLE
 ;
 W !!
 Q
 ;
 ;
DIDLE ;
 ; Check if no previous result or pending result - no audit trail needed
 I $P(LRSA(LRSB),"^")=""!($P(LRSA(LRSB),"^")="pending") Q
 ;
 S LRF=1
 L +^LR(LRDFN,LRSS,LRIDT):DILOCKTM+999
NOW ;
 N LRNOW7
 S LRNOW7=$S($G(LRNOW):LRNOW,1:$$NOW^XLFDT)
 W !
 D ^LRDIDLE0
 I 'LROK K LRSA
 L -^LR(LRDFN,LRSS,LRIDT)
 S LRCORECT=1
 Q
 ;
 ;
RONLT ; (R)esolve (O)rder NLT code from file #68 original ordered test or
 ; use default when not specified for file #60 test.
 ;
 N LR60,LRX,LRY,X
 S LR60=+LRTS,LRY=$P(LRSB(LRSB),U,3)
 ;
 ; Try to determine order NLT from original ordered test
 F  Q:'LR60  D
 . S LRX=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LR60,0)),LR60=+$P(LRX,"^",9)
 . I LR60,LR60'=$P(LRX,"^") D
 . . S X=$$NLT^LRVER1(LR60)
 . . I X'="" S $P(LRY,"!")=X
 . I LR60=$P(LRX,"^") S LR60=0
 ;
 ; Otherwise use default for lab package
 I $P(LRY,"!")="" S $P(LRY,"!")=$P($$DEFCODE^LA7VHLU5(LRSS,LRSB,LRY,+LRSPEC),"!")
 ;
 S $P(LRSB(LRSB),U,3)=LRY
 ;
 Q
 ;
 ;
LRORU3 ;
SET ;
 N LR64,LR7V,LRDN,LROTA,LRT,LRTPN,LRTPNN,LRTYPE,X
 ;
 ; Go through LRSB array and sort results by order NLT code
 ; and put into ordered test array (LROTA).
 S LRDN=0
 F  S LRDN=$O(LRSB(LRDN)) Q:'LRDN  D
 . I $P(LRSB(LRDN),"^")="" Q
 . S LRTPNN=$P($P(LRSB(LRDN),U,3),"!"),LRT=+$G(^TMP("LR",$J,"TMP",LRDN))
 . I LRTPNN="" Q
 . S LRTYPE=$P($G(^LAB(60,LRT,0)),U,3)
 . I LRTYPE=""!("OB"'[LRTYPE) Q
 . S LROTA(LRTPNN,LRDN)=LRT
 . I $D(LRSA(LRDN,2)) S LROTA(LRTPNN,LRDN,1)="C"
 ;
 ; For each order NLT code setup call to put results into #62.49 queue
 S LRTPNN=""
 F  S LRTPNN=$O(LROTA(LRTPNN)) Q:LRTPNN=""  D
 . S LR64=+$O(^LAM("C",LRTPNN_" ",0)),LRTPN=$$GET1^DIQ(64,LR64_",",.01)
 . K LR7V
 . M LR7V=LROTA(LRTPNN)
 . D SET^LA7VMSG($P(LRORU3,U,4),$P(LRORU3,U,2),$P(LRORU3,U,5),$P(LRORU3,U,3),LRTPN,LRTPNN,LRIDT,LRSS,LRDFN,LRODT,.LR7V,"ORU")
 Q
 ;
 ;
ASKXQA ; Determine if user should be asked to send CPRS Alert
 ;
 N LRDEFAULT
 ;
 ; No CPRS alert for non-PATIENT file (#2) patients
 I +LRDPF'=2 Q
 ;
 S LRDEFAULT=$$GET^XPAR("USR^DIV^PKG","LR CH VERIFY CPRS ALERT",1,"Q")
 I LRDEFAULT>0 D ASKXQA^LR7ORB3(LRDFN,"CH",LRIDT,LRUID,LRDEFAULT)
 ;
 Q
