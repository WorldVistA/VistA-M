LRTT5P1 ;DALOI/FHS-LAB URGENCY TURNAROUND TIMES PROCESSOR ;12/3/1997
 ;;5.2;LAB SERVICE;**153,221,263,274,358**;Sep 27, 1994
ONE ; from LRTT5
 ; return for reg & irreg: # tests, total time, bad turnaround time
 ; input:
 ; ^TMP("LRTT5",$J,"TESTS",tests)=test names
 ; LRPQ("URGENCY",urgencies)=urgency names
 ; LRSDT, LREDT, LRPDET
 ; output:
 ; ^TMP("LR",$J,"REG")=#tests^total time
 ; ^TMP("LR",$J,"REG",TAT,#)=acc^test^in^out
 ; ^TMP("LR",$J,"REGT",test)=#tests^total time
 ; ^TMP("LR",$J,"IRREG")=#tests^total time
 ; ^TMP("LR",$J,"IRREG",TAT,#)=acc^test^in^out
 ; ^TMP("LR",$J,"IRREGT",test)=#tests^total time
 ; ^TMP("LR",$J,"BAD",TAT,#)=acc^test^in^out
 ;
START ; go thru tests
 S LRSDT=$P(LRSDT,"."),LREDT=$P(LREDT,".")
 I LRSDT>LREDT S X=LRSDT,LRSDT=LREDT,LREDT=X
 S LRPSDT=LRSDT,LRPEDT=LREDT
 S LRTEST=0 F  S LRTEST=$O(^TMP("LRTT5",$J,"TESTS",LRTEST)) Q:LRTEST<1  D
 .; get acc areas for tests
 . S LRPN=0 F  S LRPN=$O(^LAB(60,LRTEST,8,LRPN)) Q:LRPN<1  I $D(^(LRPN,0)) S LRAA=+$P(^(0),U,2) I $D(^LRO(68,LRAA,0)) S LRAA(LRAA)=""
 ; go thru valid accession areas, get accession type - daily, yearly, etc
 S (LRPN,LRAA)=0 F  S LRAA=$O(LRAA(LRAA)) Q:LRAA<1  I $D(^LRO(68,LRAA,0)) S LRAAT=$P(^(0),U,3) D
 . ; go thru accession dates, start using appropriate acc type
 . S LRSDT=LRPSDT,LREDT=$P(LRPEDT,".")_".24"
 . S LRAD=$S(LRAAT="D":LRSDT,LRAAT="M":LRSDT\100*100,1:LRSDT\10000*10000)-.000001
 . F  S LRAD=$O(^LRO(68,LRAA,1,LRAD)) Q:LRAD<1!(LRAD>(LREDT))  D
 . . ; go thru accession #s
 . . S LRAN=0 F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:LRAN<1  S LRDPF=$P($G(^(LRAN,0)),U,2) D
 . . . Q:$S('LRDPF:1,LRDPF=2:0,LRDPF=67:0,1:1)
 . . . ; check lab arrival time, must be >= begin time and <= end time
 . . . Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,3))  S LRPLRRX1=$P(^(3),U,3) Q:LRPLRRX1<LRSDT  Q:LRPLRRX1>(LREDT)
 . . . I $G(^LRO(68,LRAA,1,LRAD,1,LRAN,.4)),$O(LRLLOC(0)),'$D(LRLLOC(+$G(^(.4)))) Q
 . . . ; go thru tests on accession, if valid urgency get date reported
 . . . S LRTEST=0 F  S LRTEST=$O(^TMP("LRTT5",$J,"TESTS",LRTEST)) Q:LRTEST<1  I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0)),$D(LRPQ("URGENCY",+$P(^(0),U,2))),$P(^(0),U,8)'="" S LRPLRRX2=+$P(^(0),U,5) D
 . . . . Q:'$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0),U,4)  ;Must be verified and have suffix code.
 . . . . ; increment sequence number
 . . . . S LRPN=LRPN+1
 . . . . ; no report date, set to zero TAT save as bad and quit
 . . . . I 'LRPLRRX2 S LRPLRRX2=LRPLRRX1 D SAVE("BAD") Q
 . . . . ; if negative times save as bad and quit
 . . . . I LRPLRRX1>LRPLRRX2 D SAVE("BAD") Q
 . . . . ; if time is not regular (7am-5pm) then save as irregular and quit
 . . . . S LRPRX1T="."_$P(LRPLRRX1,".",2) I LRPRX1T<.07!(LRPRX1T>.17) D SAVE("IRREG") Q
 . . . . ; if Sunday or Saturday save as irregular and quit
 . . . . S (LRPRX1D,X)=LRPLRRX1\1 D H^%DTC I %Y=0!(%Y=6) D SAVE("IRREG") Q
 . . . . ; if holiday save as irregular and quit
 . . . . I $D(^HOLIDAY("B",LRPRX1D)) D SAVE("IRREG") Q
 . . . . ; otherwise save as regular and quit
 . . . . D SAVE("REG")
 ; go thru reg & irreg
 F LRPTYPE="REG","IRREG" D
 . ; go thru TATs
 . S (LRPNN,LRPNT)=0,LRPDIFF="" F  S LRPDIFF=$O(^TMP("LR",$J,LRPTYPE,LRPDIFF)) Q:LRPDIFF=""  D
 . . ; go thru each reg & irreg TAT, count # and total
 . . S LRPN="" F  S LRPN=$O(^TMP("LR",$J,LRPTYPE,LRPDIFF,LRPN)) Q:LRPN=""  S LRPNN=LRPNN+1,LRPNT=LRPNT+LRPDIFF
 . ; store reg data
 . S ^TMP("LR",$J,LRPTYPE)=LRPNN_U_LRPNT
CLEAN K %Y,LRAA,LRAAT,LRAN,LRPDIFF,LRAD,LRPLRRX1,LRPLRRX2,LRPN,LRPNN,LRPNT,LRPRX1D,LRPRX1T,LRTEST,LRTESTN,LRPTYPE,X
 Q
SAVE(LRPUTYPE) ; collect reg, irreg, and bad
 N LRUID
 S LRUID=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 S LRPDIFF=$$DIFF(LRPLRRX2,LRPLRRX1),LRTESTN=$P(^LAB(60,LRTEST,0),U)
 I LRPUTYPE="BAD"!('$L(LRUID)) S ^TMP("LR",$J,"BAD",-LRPDIFF,LRPN)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2))_U_LRTESTN_U_LRPLRRX1_U_$S(LRPLRRX2=LRPLRRX1:"",1:LRPLRRX2) Q
 Q:$D(^TMP("LR",$J,LRPUTYPE,+LRPDIFF,LRTESTN_LRUID))#2
 S ^TMP("LR",$J,LRPUTYPE,+LRPDIFF,LRTESTN_LRUID)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2))_U_LRTESTN_U_LRPLRRX1_U_LRPLRRX2
 S $P(^(LRTESTN),U)=$P($G(^TMP("LR",$J,LRPUTYPE_"T",LRTESTN)),U)+1,$P(^(LRTESTN),U,2)=$P($G(^(LRTESTN)),U,2)+LRPDIFF
 Q
DIFF(LRPUT1,LRPUT2) ; $$(time1,time2) -> difference in min
 N LRPUDIFF,X1,X2,LRPUX1M,LRPUX2M,LRPUX1H,LRPUX2H,LRPUX1TH,LRPUX2TH,LRPUX1TM,LRPUX2TM,LRPUXMI
 S X1=$P(LRPUT1,"."),X2=$P(LRPUT2,"."),LRPUX1TH=$E(LRPUT1,9),LRPUX2TH=$E(LRPUT2,9),LRPUX1H=$E(LRPUT1,10),LRPUX2H=$E(LRPUT2,10),LRPUX1TM=$E(LRPUT1,11),LRPUX2TM=$E(LRPUT2,11),LRPUX1M=$E(LRPUT1,12),LRPUX2M=$E(LRPUT2,12)
 D ^%DTC S LRPUXMI=X*1440+(LRPUX1M+(LRPUX1TM*10)+(LRPUX1TH*600)+(LRPUX1H*60))-(LRPUX2M+(LRPUX2TM*10)+(LRPUX2TH*600)+(LRPUX2H*60)),LRPUDIFF=LRPUXMI S:LRPUXMI<0 LRPUDIFF=-LRPUXMI
 Q LRPUDIFF
