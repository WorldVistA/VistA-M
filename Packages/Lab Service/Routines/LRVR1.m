LRVR1 ;DALOI/CJS/JAH - LAB ROUTINE DATA VERIFICATION ;8/10/04
 ;;5.2;LAB SERVICE;**42,153,221,286,291**;Sep 27, 1994
 N LRI,LRN,LRBETST,LRBEY
 S (LRI,LRN)=0
 F  S LRI=$O(^LAH(LRLL,1,"C",LRAN,LRI)) Q:LRI<1  D
 . N LRX
 . S LRX=$G(^LAH(LRLL,1,LRI,0))
 . ; Quit if different accession area.
 . I $P(LRX,"^",3),$P(LRX,"^",3)'=LRAA Q
 . ; Quit if different accession date and not a rollover accession (same original accession date).
 . I $P(LRX,"^",4),$P(LRX,"^",4)'=LRAD,$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),"^",3)'=$P($G(^LRO(68,LRAA,1,$P(LRX,"^",4),1,LRAN,0)),"^",3) Q
 . I LRN W !
 . S LRN=LRN+1,LRSQ=LRI
 . W !,?2,"Seq #: ",LRI,?13," Accession: ",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^")
 . I $P(LRX,"^",10) W ?40," Results received: ",$$FMTE^XLFDT($P(LRX,"^",10),"1M")
 . W !,?20,"UID: ",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3),"UNKNOWN"),"^")
 . I $P(LRX,"^",11) W ?44," Last updated: ",$$FMTE^XLFDT($P(LRX,"^",11),"1M")
 G VER:LRN=1,T3:LRN>1
 ;
 ; If attempting to verify reference lab results and no entry in LAH
 ; associated with this accession then quit - do not allow manual entry
 ; of ref lab results via this option. Will not store units/normals.
 I $G(LRDUZ(2)),DUZ(2)'=LRDUZ(2) W !,"No data there" Q
 ;
T1 R !,"What tray: ",X:DTIME Q:X["^"!'$T  I X["?"!(X'?.N) W !,"Enter a number" G T1
 I X'="" S LRTRAY=X G T2
 I $D(^LRO(68.2,"AS",LRLL)) W !,"Can't MANUALLY add to a SEQUENCE instrument data file." G QUIT
 W !,"Enter manually" S %=1 D YN^DICN G QUIT:%<1,T1:%=2 S LRSQ=-1 G VER
 G VER
T2 R !,"What cup: ",X:DTIME Q:X["^"!'$T  I X["?"!(X'?.N) W !,"Enter a number" G T2
 Q:X=""  S LRTRCP=LRTRAY_";"_X
 K LRPRGSQ
 S LRN=0 F LRI=0:0 S LRI=$O(^LAH(LRLL,1,"B",LRTRCP,LRI)) Q:LRI<1  S LRN=LRN+1,LRSQ=LRI,LRPRGSQ(LRI)="" W !,?5,LRI
T3 I LRN=0 W !,"No data for that tray & cup" Q
 I LRN>1 R !,"Choose sequence number: ",X:DTIME Q:'$T  I X["?"!(X'?.N) W !,"Enter a number" G T3
 I X["^"!(X="") K LRPRGSQ Q
 S:LRN'=1 LRSQ=X I '$D(^LAH(LRLL,1,LRSQ,0)) W !,"No data there" G T3
 ;
VER ; from LRFLAG, LRGP, LRVRW
 N LRROOT
 K LRTEST,LRNM,^TMP("LR",$J,"TMP")
 S LRUID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),"^")
 ;
 ; Determine if there are amended results to process via "EM"
 S LRROOT=$Q(^LAH("LA7 AMENDED RESULTS",LRUID,1,LRLL))
 I LRROOT'="",$QS(LRROOT,1)="LA7 AMENDED RESULTS",$QS(LRROOT,2)=LRUID,$QS(LRROOT,4)=LRLL D  Q
 . W !!,"Amended results exist for this accession. Please process these"
 . W !,"first using option Enter/verify/modify data (manual) [LRENTER]"
 ;
 D TEST
 I $O(^TMP("LR",$J,"TMP",0))="" W !,"No tests in editing profile" Q
 S X=DUZ D DUZ^LRX
 G V2:LRSQ>0
 L +^LAH(LRLL)
 S (^LAH(LRLL),LRSQ)=1+$G(^LAH(LRLL))
 S ^LAH(LRLL,1,LRSQ,0)="^^"_LRAA_"^"_LRAD_"^"_LRAN_"^^MANUAL"
 D UID^LAGEN(LRLL,LRSQ,LRUID)
 D UPDT^LAGEN(LRLL,LRSQ)
 S ^LAH(LRLL,1,"C",LRAN,LRSQ)=""
 L -^LAH(LRLL)
V2 K LRPRGSQ(LRSQ)
 S LRLLOC=0,LROUTINE=$P(^LAB(69.9,1,3),U,2)
 I $D(^LRO(69,LRODT,1,LRSN,0)) S LRLLOC=$P(^(0),U,7) S:'$L(LRLLOC) LRLLOC=0 W !,$P(^LRO(69,LRODT,1,LRSN,1),U,6)
 S LRCDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U)
 I '$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),"^",3) D
 . N %DT,LRA1,LRA2,LRA3
 . S %DT("B")=$$FMTE^XLFDT(LRCDT,"1")
 . S LRSTATUS="C",LRA1=LRAA,LRA2=LRAD,LRA3=LRAN
 . D P15^LROE1
 . S LRAA=LRA1,LRAD=LRA2,LRAN=LRA3
 . I LRCDT<1 Q
 . I '$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,3) S $P(^(3),U,3)=$$NOW^XLFDT
 ; If user did not update then go to next
 I '$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,3) Q
 S LRCDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U)
 I LRCDT<1 Q
 S LREAL=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,2),LRALERT=LROUTINE
 S I=0
 F  S I=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,I)) Q:I<.5  I $G(^(I,0)) S LRAL=$P($G(^(0)),U,2) D
 . I $G(LRAL) S LRALERT=$S(LRAL<50&(LRAL<LRALERT):LRAL,LRAL>50&(LRAL-50<LRALERT):LRAL-50,1:LRALERT)
 S LRSAMP=$P($G(^LRO(69,LRODT,1,LRSN,0)),U,3)
 ;
 S LRSS=$P(^LRO(68,LRAA,0),U,2)
 I LRSS'="CH" Q
 ; Check for valid pointer to file #63 and entry in file #63.
 S LRIDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,5)
 I LRIDT<1 W !,">>>>ERROR - NO POINTER TO FILE #63 - PLEASE NOTIFY SYSTEM MANAGER^ <<<<<",! Q
 I '$D(^LR(LRDFN,LRSS,LRIDT,0)) W !,">>>>ERROR - NO ENTRY IN FILE #63 - PLEASE NOTIFY SYSTEM MANAGER<<^ <<<",! Q
 ;
 S LRCW=8
LD S LRSS="CH"
 I '($D(^LAH(LRLL,1,LRSQ,0))#2) W !!?5,"No Data for this Accession ",!! K ^LAH(LRLL,1,LRSQ),^LAH(LRLL,1,"C",LRAN,LRSQ) K LRPRGSQ Q
 ;
 ; Store any new methods with existing methods on file.
 S LRMETH=$P(^LAH(LRLL,1,LRSQ,0),U,7) S:$D(LRGVP) LRMETH=LRMETH_"(GV)"
 I $P($G(^LR(LRDFN,LRSS,LRIDT,0)),U,8)'="" D
 . N I,X
 . S X=$P(^LR(LRDFN,LRSS,LRIDT,0),U,8)
 . F I=1:1:$L(X,";") I $P(X,";",I)'="",LRMETH'[$P(X,";",I) S LRMETH=LRMETH_";"_$P(X,";",I)
 I LRMETH'="" S $P(^LR(LRDFN,LRSS,LRIDT,0),U,8)=LRMETH
 ;
 W:$D(^LAB(62,+LRSAMP,0)) !,"Sample: ",$P(^(0),U)
 ;
 D ^LRVR2
 K LRDL,LRPRGSQ
 Q  ; leave LRVR1, back to LRVR
 ;
 ;
TEST ; from LRGV1
 N LRI,LRX
 S LRI=0
 F  S LRI=$O(^TMP("LR",$J,"VTO",LRI)) Q:LRI<1  K ^(LRI,"P")
 S (LRI,LRNT)=0
 F  S LRI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI)) Q:LRI<.5  I $D(^(LRI,0)),'$L($P(^(0),U,6)) S X=^(0) I $D(^TMP("LR",$J,"VTO",+X)) D
 . S LRNT=LRNT+1,LRTEST(LRNT)=+X,LRX=$S($P(X,"^",2)>50:$P(X,"^",9),1:$P(X,"^"))
 . S LRTEST(LRNT,"P")=LRX_U_$$NLT^LRVER1(LRX)_"!"
 . S ^TMP("LR",$J,"VTO",+X,"P")=$P(LRTEST(LRNT,"P"),"!")
 ;
TEST1 ; from LRFLAG
 ;
 N LRI
 F LRI=1:1:LRNT S:$D(^LAB(60,+LRTEST(LRI),0)) (LRTEST(LRI),LRBETST(LRI))=LRTEST(LRI)_U_^(0)
 I $G(LRORDR)'="P" K ^TMP("LR",$J,"TMP")
 S LRNX=0
 K LRM
 F I=1:1 Q:'$D(LRTEST(I))  D
 . S X=LRTEST(I),XP=$G(LRTEST(I,"P"))
 . K LRTEST(I)
 . D EX2
 K LRTEST
 Q
 ;
 ;
EX2 ;
 ; If dataname then process and quit
 S LRSUB=$P(X,U,6)
 I LRSUB'="" D  Q
 . S LRSB=$P(LRSUB,";",2)
 . Q:'$D(LRVTS(LRSB))
 . I $D(^TMP("LR",$J,"TMP",LRSB)) S ^(LRSB,"P")=XP
 . Q:$D(^TMP("LR",$J,"TMP",LRSB))
 . S ^TMP("LR",$J,"TMP",LRSB)=+X
 . S XP=XP_$$RNLT^LRVER1(+X)
 . S ^TMP("LR",$J,"TMP",LRSB,"P")=XP
 . S:$P(X,U,18) LRM(LRSB)=+X,LRM(LRSB,"P")=XP
 . S LRBEY(+XP,LRSB)=""     ; CIDC
 ;
 I $D(^LAB(60,+X,4)),$P(^(4),"^",2) S LRCFL=LRCFL_$P(^(4),"^",2)_U
 ;
 ; If panel then explode components of panel and
 ;  set parent("P" node) to file #60 test being exploded
 S J=0
 F  S J=$O(^LAB(60,+X,2,J)) Q:J<1  I $D(^(J,0))#2 D
 . S LRNT=LRNT+1,Y=^LAB(60,+X,2,J,0)
 . S LRTEST(LRNT)=+Y_U_^LAB(60,+Y,0)
 . S LRTEST(LRNT,"P")=+XP_U_$$NLT^LRVER1(+XP)_"!"
 Q
 ;
 ;
QUIT Q
 ;
WAIT W !,"Type ""^"" to skip "
WAIT1 R X:10 G LRVR1:X[U,WAIT1:$O(^LAH(LRLL,1,"C",LRAN,0))<1 G LRVR1
