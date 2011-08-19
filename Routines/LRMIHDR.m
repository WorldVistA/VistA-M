LRMIHDR ;DALOI/CJS/BA/RLM-HEALTH DEPARTMENT REPORT ;2/19/91 10:46
 ;;5.2;LAB SERVICE;**45,272,298**;Sep 27, 1994
 ; Reference to ^%DT supported by DBIA #10003
 ; Reference to ^%ZISC supported by DBIA #10089
 ; Reference to EN^DIQ supported by DBIA #10004
 ; Reference to KVAR^VADPT supported by DBIA #10061
 ; Reference to $$NOW^XLFDT supported by IA #10103
 ; Reference to $$FMTE^XLFDT supported by IA #10103
 ; Reference to ^DIC(10 supported by IA #925
 ; Reference to ^DIC( supported by IA #916
 ; Reference to ^DIC(11 supported by IA #924
BEGIN S LREND=0,LREDT="T-1" D ^LRWU3 I 'LREND S ZTRTN="DQ^LRMIHDR" D IO^LRWU
END W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC
 K %DT,A,AGE,D0,DA,DFN,DIC,DL,DOB,DR,DX,I,LRACC,LRBUG,LROCCU,LRDFN,LRDPF,LRDT,LREDT,LREND,LRHC,LRIDT,LRMARST,LRPHONE,LRRACE,LRSAMP,LRSDT,LRSPEC,LRWRD,POP,PNM,S,SEX,SSN,X,Y,Z0
 D KVAR^LRX
 Q
DQ S:$D(ZTQUEUED) ZTREQ="@" U IO
 I LRSDT>LREDT S X=LRSDT,LRSDT=LREDT,LRSDT=X
 S LRHC=$E(IOST,1,2)'="C-" W !!,?5,"HEALTH DEPARTMENT REPORT  (" S X=LRSDT\1 D ^%DT,DD^LRX W Y," - " S X=LREDT\1 D ^%DT,DD^LRX W Y,")",?65 S X="N",%DT="T" D ^%DT,DD^LRX W Y I LRHC W !! D DASH^LRX
 S LRDT=LREDT-.0001 F  S LRDT=$O(^LR("AD",LRDT)) Q:LRDT<1!(LRDT>LRSDT)  D DATE Q:LREND
 D END
 Q
DATE S DR=.11 S LRBUG=0 F  S LRBUG=$O(^LR("AD",LRDT,LRBUG)) Q:LRBUG<1  D LIST Q:LREND
 Q
LIST W !!,?5,"Isolated Organism: ",$P(^LAB(61.2,LRBUG,0),U),!,"Printed :  "_$$FMTE^XLFDT($$NOW^XLFDT,""),!
 S LRACC="" F  S LRACC=$O(^LR("AD",LRDT,LRBUG,LRACC)) Q:LRACC=""  S LRDFN=^(LRACC) D SPEC,PAT,WAIT:'LRHC Q:LREND
 D:LRHC DASH^LRX W !
 Q
SPEC S (LRIDT,LRSPEC,LRSAMP)=0 F  S LRIDT=$O(^LR(LRDFN,"MI",LRIDT)) Q:LRIDT<1  I $D(^(LRIDT,0)),$E(LRACC,1,$L(LRACC)-1)=$P(^(0),U,6) S LRSPEC=+$P(^(0),U,5),LRSAMP=+$P(^(0),U,11) W:LRSPEC!LRSAMP ! Q
 I LRSAMP,$D(^LAB(62,LRSAMP,0)) W ?4," COLLECTION SAMPLE: ",$P(^(0),U)
 I LRSPEC,$D(^LAB(61,LRSPEC,0)) W ?40," SPECIMEN: ",$P(^(0),U)
 Q
PAT D KVAR^VADPT
 W !! S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3),DIC=^DIC(+LRDPF,0,"GL") D PT^LRX
 S Y=DOB D DD^LRX W !!,PNM,?25," ID: ",SSN,?44," DOB: ",Y,?60," SEX: ",SEX
 I +LRDPF=2 D ADDPT^LRX,OPDPT^LRX D
 . S LRPHONE=$G(VAPA(8)),LRMARST=$P($G(VADM(10)),U,2),LROCCU=VAPD(6)
 E  S X=DIC_"DFN"_",0)",LRRACE=$P($G(^DIC(10,+$P(@X,U,6),0)),U) D
 . S X=DIC_DFN_",.13)",LRPHONE=$S($D(@X):$P(^(.13),U),1:"")
 . S X=DIC_DFN_",0)",X=@X,LRRACE=$P(X,U,6),LRMARST=$P(X,U,5),LROCCU=$P(X,U,7)
 . I LRRACE S LRRACE=$S($D(^DIC(10,LRRACE,0)):$P(^(0),U),1:"")
 . I LRMARST S LRMARST=$S($D(^DIC(11,LRMARST,0)):$P(^(0),U),1:"")
 W !,"Accession Number: ",LRACC,!
 W:$L(LRPHONE) !,"PHONE: ",LRPHONE
 D RACE
 I $L($G(LRRACE))!$L(LRMARST)!$L(LROCCU) W !
 W:$L($G(LRRACE)) "RACE: ",LRRACE,"   " W:$L(LRMARST) "MARRIAGE STATUS: ",LRMARST,"   " W:$L(LROCCU) "OCCUPATION: ",LROCCU
 S DA=DFN D EN^DIQ S:$D(DTOUT)!($D(DUOUT)) LREND=1
 D KVAR^VADPT
 Q
WAIT F I=$Y:1:IOSL-3 W !
 W ?59," PRESS '^' TO STOP " R X:DTIME S:X="" X=1 S LREND=".^"[X W:'LREND @IOF
 Q
RACE ;ETHNICITY AND RACE MODS
 ;-----ethnicity/race retrieval and display
 K ERT,SEQ
 S (ERT,SEQ)=""  ;ERT=ethnicity race type; display multiple for both
 I $D(VADM(11)) I VADM(11)>0 S SEQ=SEQ+1,ERT(SEQ)="" D
 . F I=1:1 Q:'$D(VADM(11,I))  I $TR($P(VADM(11,I),"^",2),"")'="" D
 .. ;length of race or ethnicity; plus 25 characters for field label; plus length of data to be added to the field; minus 2 char for comma and space; up to 80 characters.
 .. I ($L(ERT(SEQ))+25+$L($P(VADM(11,I),"^",2))-2)'>80 D  Q
 ... S ERT(SEQ)=ERT(SEQ)_", "_$P(VADM(11,I),"^",2)
 S:'$D(ERT(1)) ERT(1)=", UNANSWERED"
 W !,"Veteran's ethnicity: "_$E(ERT(1),3,999)
 I SEQ>1 F I=2:1:SEQ W !?30,$E(ERT(I),3,999)
 K ERT S (ERT,SEQ)=""
 I $D(VADM(12)) I VADM(12)>0 S SEQ=SEQ+1,ERT(SEQ)="" D
 . F I=1:1:VADM(12) Q:'$D(VADM(12,I))  I $TR($P(VADM(12,I),"^",2),"")'="" D
 .. I ($L(ERT(SEQ))+25+$L($P(VADM(12,I),"^",2))-2)'>80 D  Q
 ... S ERT(SEQ)=ERT(SEQ)_", "_$P(VADM(12,I),"^",2)
 .. I ($L(ERT(SEQ))+25+$L($P(VADM(12,I),"^",2))-2)>80 D
 ... S ERT(SEQ)=ERT(SEQ)_", ",SEQ=SEQ+1,ERT(SEQ)=""
 .. S ERT(SEQ)=ERT(SEQ)_", "_$P(VADM(12,I),"^",2)
 S:'$D(ERT(1)) ERT(1)=", UNANSWERED"
 I ERT(1)=", UNANSWERED",$G(VADM(8)) S ERT(1)="  "_$P(VADM(8),U,2)
 W !,"Veteran's race: "_$E(ERT(1),3,999)
 I SEQ>1 F I=2:1:SEQ W !?25,$E(ERT(I),3,999)
 K ERT,SEQ
 Q
