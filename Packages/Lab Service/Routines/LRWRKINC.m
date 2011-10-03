LRWRKINC ;SLC/DCM/CJS-INCOMPLETE STATUS REPORT ;2/19/91  11:47
 ;;5.2;LAB SERVICE;**153,201,221**;Sep 27, 1994
EN ;
 K ^TMP($J),^TMP("LR",$J),^TMP("LRWRKINC",$J)
 K %ZIS,DIC
 S Y=$$NOW^XLFDT D DD^LRX S LRDT=Y
 S (LRCNT,LRCUTOFF,LREND,LREXD,LREXTST,LRNOCNTL,LREXNREQ)=0,LRSORTBY=1
 S DIC="^LRO(68,",DIC(0)="AEMOQZ"
 F  D  Q:$G(LRAA)<1!(LREND)
 . N LAST,LRAD,LRAN,LRFAN,LRLAN,LRWDTL,LRSTAR,LRUSEAA,X,Y
 . D ^DIC
 . I $D(DUOUT) S LREND=1 Q
 . S LRAA=+Y,LRAA(0)=$G(Y(0))
 . I LRAA<1 Q
 . D CHKAA^LRWRKIN1
 . I LREND Q
 . I '$L(LRUSEAA) D PHD Q:LREND
 . S LRCNT=LRCNT+1,^TMP("LRWRKINC",$J,$P(LRAA(0),"^")_"^"_LRAA,LRCNT,0)=LRAA(0)
 . I $L(LRUSEAA) D
 . . N X
 . . S X=$P($G(^LRO(68,LRUSEAA,0)),"^")_"^"_LRUSEAA
 . . S ^TMP("LRWRKINC",$J,$P(LRAA(0),"^")_"^"_LRAA,LRCNT,1)=^TMP("LRWRKINC",$J,$P(LRUSEAA,"^",1,2),$P(LRUSEAA,"^",3),1)
 . E  S ^TMP("LRWRKINC",$J,$P(LRAA(0),"^")_"^"_LRAA,LRCNT,1)=$G(LRAD)_"^"_$G(LRFAN)_"^"_$G(LRLAN)_"^"_$G(LRSTAR)_"^"_$G(LAST)_"^"_$G(LRWDTL)
 . W !
 I LREND!('$D(^TMP("LRWRKINC",$J))) D LREND^LRWRKIN1 Q
 K DIC
 N DIR,DIRUT,DTOUT,DUOUT
 I LRCNT>1 D
 . S DIR(0)="SO^1:ACCESSION AREA;2:TEST NAME",DIR("A")="Sort Report By",DIR("B")=1
 . S DIR("?",1)="ACCESSION AREA will separate tests by accession area, then by test name."
 . S DIR("?")="TEST NAME will list tests alphabetically without regard to accession area."
 . D ^DIR
 . I $D(DIRUT) S LREND=1 Q
 . S LRSORTBY=+Y
 I LREND D LREND^LRWRKIN1 Q
 S DIR(0)="YO",DIR("A")="Specify detailed sort criteria",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' if you WANT to specify detailed criteria."
 S DIR("?",2)="Examples are excluding controls, specifying a lab arrival cut-off time,"
 S DIR("?",3)="selecting or excluding specific tests, or excluding non-required tests."
 S DIR("?")="Answer 'NO' if you DO NOT want to specify detailed criteria."
 D ^DIR
 I $D(DIRUT) D LREND^LRWRKIN1 Q
 I Y=1 D
 . K DIR
 . S DIR(0)="DO^::EXT",DIR("A")="Lab Arrival Cut-off"
 . S DIR("?",1)="Entering a date/time will exclude uncollected specimens and"
 . S DIR("?")="specimens with a lab arrival time after the time specified."
 . D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) Q
 . I Y>0 S LRCUTOFF=+Y
 . K DIR
 . S DIR(0)="YO",DIR("A")="Do you want to exclude controls",DIR("B")="YES"
 . S DIR("?",1)="Answer 'NO' if you WANT accessions for LAB CONTROLS included on"
 . S DIR("?")="the report. 'YES' if you DO NOT want accessions for LAB CONTROLS."
 . D ^DIR
 . I $D(DIRUT) Q
 . S LRNOCNTL=+Y
 . K DIR
 . S DIR(0)="YO",DIR("A")="Do you want a specific test",DIR("B")="NO"
 . D ^DIR
 . I $D(DIRUT) Q
 . I Y=1 D
 . . N I,LRY
 . . K DIR
 . . S DIR(0)="YO",DIR("A")="Check tests on panels also",DIR("B")="YES"
 . . S DIR("?",1)="If you select a panel test do you want to also check"
 . . S DIR("?")="the tests that make up the panel for an incomplete status."
 . . D ^DIR
 . . I $D(DIRUT) Q
 . . S LRY=+Y
 . . N DIC
 . . S DIC="^LAB(60,",DIC(0)="AEFOQZ"
 . . F  D  Q:+Y<1
 . . . N LRTEST,LRTSTS
 . . . D ^DIC Q:+Y<1
 . . . S ^TMP("LR",$J,"T",+Y)=Y(0)
 . . . I LRY S LRTEST=+Y,LREXPD="D LREXPD^LRWRKINC" D ^LREXPD
 . I $D(DIRUT) Q
 . K DIR
 . S DIR(0)="YO"
 . S DIR("A")="Do you want to exclude a specific test",DIR("B")="NO"
 . D ^DIR
 . I $D(DIRUT) Q
 . I Y=1 D
 . . N DIC
 . . S DIC="^LAB(60,",DIC(0)="AEFOQ",DIC("S")="I '$D(^TMP(""LR"",$J,""T"",Y))"
 . . F  D ^DIC Q:+Y<1  S LREXTST(+Y)="",LREXTST=1
 . K DIR
 . S DIR(0)="YO",DIR("A")="Exclude non-required tests",DIR("B")="YES"
 . S DIR("?",1)="Answer 'NO' if you WANT incomplete non-required test included on"
 . S DIR("?")="the report. 'YES' if you DO NOT want non-required tests."
 . D ^DIR
 . I $D(DIRUT) Q
 . S LREXNREQ=+Y
 I $D(DIRUT) D LREND^LRWRKIN1 Q
 S DIR(0)="YO",DIR("A")="Do you want an extended display",DIR("B")="NO"
 S DIR("?")="Extended display will show UID and other referral information"
 D ^DIR
 I $D(DIRUT) D LREND^LRWRKIN1 Q
 S LREXD=+Y
 S %ZIS="Q" D ^%ZIS
 I POP D LREND^LRWRKIN1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQ^LRWRKINC",ZTDESC="Lab incomplete test list",ZTSAVE("LR*")=""
 . S ZTSAVE("^TMP(""LRWRKINC"",$J,")=""
 . I $D(^TMP("LR",$J,"T")) S ZTSAVE("^TMP(""LR"",$J,""T"",")=""
 . D ^%ZTLOAD,^%ZISC
 . W !,"Request ",$S($G(ZTSK):"Queued - Task #"_ZTSK,1:"NOT Queued")
 . D LREND^LRWRKIN1
 ;
DQ ;
 U IO
 S (LRAA,LRINDEX,LRPAGE)=0,(LRX,LRY)=""
 F  S LRX=$O(^TMP("LRWRKINC",$J,LRX)) Q:LRX=""  D
 . N LRZ
 . S LRZ=0
 . F  S LRZ=$O(^TMP("LRWRKINC",$J,LRX,LRZ)) Q:'LRZ  D
 . . N LRFAN,LRLAN,LRSTAR,LRLAST,LRY
 . . F I=0,1 S LRZ(I)=$G(^TMP("LRWRKINC",$J,LRX,LRZ,I))
 . . S LRFAN=$P(LRZ(1),"^",2),LRLAN=$P(LRZ(1),"^",3),LRSTAR=$P(LRZ(1),"^",4),LRLAST=$P(LRZ(1),"^",5)
 . . I LRSTAR,LRLAST S LRY="From Date: "_$$FMTE^XLFDT(LRSTAR,"5DZ")_"    To: "_$$FMTE^XLFDT(LRLAST,"5DZ")
 . . E  S LRY=" For Date: "_$$FMTE^XLFDT(LRLAST,"5DZ")_"  From: "_LRFAN_"  To: "_LRLAN
 . . S LRINDEX=LRINDEX+1,LRNAME(LRINDEX)=$$LJ^XLFSTR($E($P(LRZ(0),"^"),1,20),22)_LRY
 S LRINDEX=LRINDEX+1,LRNAME(LRINDEX)=$S(LRINDEX>1:"Sorted by "_$S(LRSORTBY=1:"Accession Area",1:"Test Name")_"; ",1:"")_"Controls Excluded: "_$S(LRNOCNTL:"YES",1:"NO")_"; Specific Tests: "_$S($D(^TMP("LR",$J,"T")):"YES",1:"NO")
 S LRINDEX=LRINDEX+1,LRNAME(LRINDEX)="Exclude Specific Tests: "_$S(LREXTST:"YES",1:"NO")_"; Required Tests Only: "_$S(LREXNREQ:"YES",1:"NO")
 I LRCUTOFF S LRINDEX=LRINDEX+1,LRNAME(LRINDEX)="For Tests Received Before: "_$$FMTE^XLFDT(LRCUTOFF,"5MZ")
 D HED^LRWRKIN1 D URG^LRX
 S LRX=""
 F  S LRX=$O(^TMP("LRWRKINC",$J,LRX)) Q:LRX=""  D
 . S LRZ=0
 . F  S LRZ=$O(^TMP("LRWRKINC",$J,LRX,LRZ)) Q:'LRZ  D
 . . I LRSORTBY=1 S LRAA("NAME")=$P(LRX,"^")
 . . S X=^TMP("LRWRKINC",$J,LRX,LRZ,1)
 . . S LRAA=$P(LRX,"^",2),LRAD=$P(X,"^"),LRFAN=$P(X,"^",2),LRLAN=$P(X,"^",3),LRSTAR=$P(X,"^",4),LAST=$P(X,"^",5),LRWDTL=$P(X,"^",6)
 . . N LRX,LRZ
 . . F  S LRAD=$O(^LRO(68,LRAA,1,LRAD)) Q:LRAD<1!(LRAD>LAST)  D
 . . . I $G(LRSTAR) D AC Q
 . . . S LRAN=LRFAN-1
 . . . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:'LRAN!(LRAN>LRLAN)  D
 . . . . S LREND=0
 . . . . D TD Q:LREND
 . . . . I 'LRVERVER D LST1^LRWRKIN1,TESTS
 D X^LRWRKIN1
 I LREND D LREND^LRWRKIN1 Q
 D EQUALS^LRX D WAIT^LRWRKIN1:$E(IOST,1,2)="C-"
 D LREND^LRWRKIN1
 Q
 ;
TD ;
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) S LREND=1 Q
 I LRNOCNTL,$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),"^",2)=62.3 S LREND=1 Q
 S LRVERVER=1,I=0
 F  S I=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,I)) Q:I<.5  I $D(^(I,0)) S LRVERVER=(LRVERVER&$P(^(0),U,5))
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) S LREND=1
 Q
 ;
TESTS Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0))
 N LRI
 S LRI=0
 F  S LRI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI)) Q:LRI<.5  D
 . N LR60,LRURG,LRTSTN
 . S LRI(0)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI,0)),LRURG=+$P(LRI(0),U,2)
 . S LR60=+LRI(0)
 . I $D(^TMP("LR",$J,"T")),'$D(^TMP("LR",$J,"T",LR60)) Q  ; Not specific test
 . I LREXTST,$D(LREXTST(LR60)) Q  ; Exclude specific test
 . I $P(LRI(0),U,5) Q  ; Complete date
 . I LRCUTOFF,'LRDLA Q  ; Uncollected
 . I LRCUTOFF,LRCUTOFF<LRDLA Q  ; After cut-off date/time
 . S LR60(0)=$G(^LAB(60,LR60,0)) ; Get zeroth node from file #60
 . I LREXNREQ,'$P(LR60(0),"^",17) Q  ; Exclude non-required tests
 . S LRTSTN=$P(LR60(0),U) ; Test name
 . I $P(LR60(0),"^")="" S LRTSTN="MISSING FILE 60 - "_LR60
 . I LRSORTBY=1 S LRTSTN=LRAA("NAME")_"^"_LRTSTN
 . S Y=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,3))
 . S LRST=$S($L($P(LRI(0),U,3)):"Load/work list",$L($P(Y,U,3)):"In lab",1:"Not in lab")
 . D REF
 . S ^TMP($J,LRTSTN,LRURG,$P(LRACC," ",1)_"^"_+$P(LRDX,"^",3),LRAN)=LRST_U_SSN_U_PNM_U_$P(LRDX,U,7)_U_$P(LRDLA,"^",2)_U_LRMAN_U_LRACC
 . I $G(LREXD) S ^TMP($J,LRTSTN,LRURG,$P(LRACC," ",1)_"^"_+$P(LRDX,"^",3),LRAN,.3)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 Q
 ;
REF ; if referred test, get referral status
 N LREVNT,LRUID
 S LRUID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),"^"),LRMAN=$P(X,"^",10)
 I LRMAN S LRMAN=$P($G(^LAHM(62.8,LRMAN,0)),"^")
 S LREVNT=$$STATUS^LREVENT(LRUID,+X,LRMAN)
 I LREVNT'="" S LRST=$P(LREVNT,"^")
 Q
 ;
PHD ;
 S LREND=0
 I $P(LRAA(0),"^",3)="Y" D STAR^LRWU3
 I $G(LRSTAR) Q
 D ADATE^LRWU Q:LREND
 S LAST=LRAD,LRAD=LRAD-1
 D LRAN^LRWU3
 Q
 ;
AC S LRTK=LRSTAR-.00001
 F  S LRTK=$O(^LRO(68,LRAA,1,LRAD,1,"E",LRTK)) Q:LRTK<1!(LAST>1&(LRTK\1>LAST))  D
 . S LRAN=0
 . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,"E",LRTK,LRAN)) Q:'LRAN  D
 . . S LREND=0
 . . I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) S LREND=1 Q
 . . D TD Q:LREND
 . . ;I LRUNC!('LRVERVER) D LST,TESTS
 . . I 'LRVERVER D LST1^LRWRKIN1,TESTS
 Q
 ;
% R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
 Q
 ;
LREXPD ;Include panel test in list when selecting specific tests
 I $G(S1(+$G(S1))) S ^TMP("LR",$J,"T",S1(S1))=^LAB(60,S1(S1),0)
 Q
