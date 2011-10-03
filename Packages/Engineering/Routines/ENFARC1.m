ENFARC1 ;WIRMFO/SAB-FIXED ASSET RPT, TRANSACTION REGISTER (CONT); 5.16.97
 ;;7.0;ENGINEERING;**39**;Aug 17, 1993
QEN ; queued entry
 ; in
 ;   ENDTS - start date
 ;   ENDTE - end date
 ;   ENAV  - flag, when true then print adjustment voucher data
 ;
 U IO
 ;
GETDATA ; collect/sort data
 ; loop thru FAP document file transactions within selected date range
 K ^TMP($J) F ENFILE="6915.2","6915.3","6915.4","6915.5","6915.6" D
 . S ENDT=ENDTS
 . F  S ENDT=$O(^ENG(ENFILE,"D",ENDT)) Q:ENDT=""!($P(ENDT,".")>ENDTE)  D
 . . S ENDA("F?")=0
 . . F  S ENDA("F?")=$O(^ENG(ENFILE,"D",ENDT,ENDA("F?"))) Q:'ENDA("F?")  D
 . . . S ^TMP($J,ENDT,ENFILE_";"_ENDA("F?"))=""
 ;
PRINT ; print
 ; load table for converting FA Type to SGL
 K ENFAPTY S ENDA=0 F   S ENDA=$O(^ENG(6914.3,ENDA)) Q:'ENDA  D
 . S ENX=$G(^ENG(6914.3,ENDA,0))
 . I $P(ENX,U,3)]"" S ENFAPTY($P(ENX,U,3))=$P(ENX,U)
 ;
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDTR=Y
 S ENTAG("HD")="HD^ENFARC1",ENTAG("HDC")="HDC^ENFARC1"
 S ENTAG("FT")="FT^ENFARC1"
 S ENL="",$P(ENL,"-",IOM)=""
 D HD
 I '$D(^TMP($J)) W !!,"No activity in selected period",!
 ; loop thru sorted data
 S ENDT="" F  S ENDT=$O(^TMP($J,ENDT)) Q:ENDT=""  D  Q:END
 . S ENFAP="" F  S ENFAP=$O(^TMP($J,ENDT,ENFAP)) Q:ENFAP=""  D  Q:END
 . . S ENFILE=$P(ENFAP,";"),ENDA("F?")=$P(ENFAP,";",2)
 . . S ENY0=$G(^ENG(ENFILE,ENDA("F?"),0))
 . . S ENY1=$G(^ENG(ENFILE,ENDA("F?"),1))
 . . S ENDA("EQ")=$P($G(^ENG(ENFILE,ENDA("F?"),0)),U)
 . . S ENDA("FA")=$$AFA^ENFAR5A(ENFILE,ENDA("F?")) ; associated FA
 . . S ENFAY3=$G(^ENG(6915.2,ENDA("FA"),3))
 . . S ENSN=$TR($E($P(ENFAY3,U,5),1,5)," ","")
 . . S:ENFILE=6915.2 ENFUND=$P(ENFAY3,U,10)
 . . S:ENFILE'=6915.2 ENFUND=$$FUND^ENFAR5A(ENFILE,ENDA("F?"),ENDA("FA"))
 . . S ENSGL=$S($P(ENFAY3,U,6)]"":$G(ENFAPTY($P(ENFAY3,U,6))),1:"")
 . . S ENAMT=0
 . . I ENFILE=6915.2 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,27)
 . . I ENFILE=6915.3 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),4)),U,4)
 . . I ENFILE=6915.4 S ENX=$P($G(^ENG(ENFILE,ENDA("F?"),4)),U,6),ENAMT=$S(ENX="":0,1:ENX-$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,4))
 . . I ENFILE=6915.5 S ENAMT="-"_$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,2)
 . . I ENFILE=6915.6 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,8)
 . . S:ENFILE=6915.2 ENTRC="FA 00"
 . . S:ENFILE=6915.3 ENTRC="FB "_$$GET1^DIQ(ENFILE,ENDA("F?"),23)
 . . S:ENFILE=6915.4 ENTRC="FC "_$$GET1^DIQ(ENFILE,ENDA("F?"),27)
 . . S:ENFILE=6915.5 ENTRC="FD "_$$GET1^DIQ(ENFILE,ENDA("F?"),100,"I")
 . . S:ENFILE=6915.6 ENTRC="FR"
 . . I $Y+12>IOSL D FT,HD Q:END
 . . W !!,?2,ENTRC,?8,$P(ENY1,U,9)
 . . W ?20,$TR($$FMTE^XLFDT($P(ENY0,U,2),"2DF")," ",0)
 . . W ?30,ENSN,?37,ENFUND,?45,ENSGL
 . . I ENFILE=6915.6 D  ; check FR doc for FUND change
 . . . S ENFUNDNW=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,9)
 . . . I ENFUND=ENFUNDNW S ENAMT=0 Q  ; fund didn't change
 . . . S ENAMT=-ENAMT ; subtract from old fund
 . . W ?51,$J($FN(ENAMT,",",2),16)
 . . W ?69,$E($P($$GET1^DIQ(ENFILE,ENDA("F?"),1.5),","),1,10)
 . . I ENFILE=6915.6,ENFUND'=ENFUNDNW D
 . . . ; show addition to new fund
 . . . W !,?37,ENFUNDNW,?45,ENSGL
 . . . W ?51,$J($FN(-ENAMT,",",2),16)
 . . ;
 . . W !,?4,"ENTRY #: ",ENDA("EQ")
 . . D @("F"_$P(ENFILE,".",2)_"^ENFARC2")
 . . I 'END,ENAV,$$GET1^DIQ(ENFILE,ENDA("F?"),301)]"" D
 . . . ; print adjustment voucher
 . . . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . . . W !,?4,"AV REASON: ",$E($$GET1^DIQ(ENFILE,ENDA("F?"),303),1,20)
 . . . W ?37,"DATE: ",$P($$GET1^DIQ(ENFILE,ENDA("F?"),301),"@")
 . . . W ?57,"BY: ",$P($$GET1^DIQ(ENFILE,ENDA("F?"),302),",")
 . . . K ^UTILITY($J,"W") S DIWL=5,DIWR=(IOM-5),DIWF="W|"
 . . . S X="AV COMMENTS: ",ENI=0
 . . . F  S ENI=$O(^ENG(ENFILE,ENDA("F?"),301,ENI)) Q:'ENI  S X=X_^(ENI,0) D ^DIWP S X="" I $Y+6>IOSL D FT,HD Q:END  D HDC
 . . . Q:END
 . . . D ^DIWW
 I 'END D FT I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
WRAPUP ; wrap up
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 K DIWF,DIWL,DIWR,X,Y
 K ^TMP($J),ENAMT,ENAV,END,ENDA,ENDT,ENDTE,ENDTR,ENDTS,ENFAP,ENFAPTY
 K ENFAY3,ENFILE,ENFUND,ENFUNDNW,ENI,ENL,ENPG,ENSGL,ENSN,ENTAG,ENTRC
 K ENX,ENY,ENY0,ENY1
 Q
HD ; page header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 S $X=0
 W "TRANSACTION REGISTER"
 W " FROM ",$$FMTE^XLFDT(ENDTS,"2")," TO ",$$FMTE^XLFDT(ENDTE,"2")
 W ?49,ENDTR,?72,"page ",ENPG
 W !!,?2,"...... TRANSACTION .......",?30,"STN",?37,"FUND"
 W ?45,"SGL",?51,"NET AMOUNT",?69,"SENDER"
 W !,?2,"CODE* NUMBER      DATE"
 W !,?2,"----- ----------- --------",?30,"-----",?37,"------"
 W ?45,"----",?51,"----------------",?69,"----------"
 Q
HDC ; header for continued transaction
 W !,?5,"Transaction: ",$P(ENY1,U,6),"-",$P(ENY1,U,9)," (continued)"
 Q
FT ; footer
 W !!," * Betterment # follows FB and FC. T (Turn-In) or D (Final Disp.) follows FD."
 Q
 ;ENFARC1
