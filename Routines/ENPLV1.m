ENPLV1 ;WISC/SAB-PROJECT VALIDATION, REPORT; 8/27/95
 ;;7.0;ENGINEERING;**23,28**;Aug 17, 1993
EN ;
 ; Input Variables
 ;   ENTY                          type of validation (F, A, R)
 ;   ^TMP($J,"L",project number)=ien^validation code
 ;   ^TMP($J,"V",ien,1,line,0)=TXT     error text
 ;   ^TMP($J,"V",ien,2,line,0)=TXT     warning text
 S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="QEN^ENPLV1",ZTDESC="Invalid Projects"
 . S ZTSAVE("^TMP($J,""L"",")="",ZTSAVE("^TMP($J,""V"",")=""
 . S ZTSAVE("ENTY")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 S (END,ENPG)=0 S Y=$P(DT,".") D DD^%DT S ENDT=Y
 S ENDASH="",$P(ENDASH,"-",IOM)="" D HD
 S ENPN=""
 F  S ENPN=$O(^TMP($J,"L",ENPN)) Q:ENPN=""  D  Q:END
 . S ENX=^TMP($J,"L",ENPN),ENDA=$P(ENX,U),ENV=$P(ENX,U,2)
 . Q:ENV'<3
 . W !,"Project: ",ENPN,$S(ENV=1:" (failed)",1:" (passed with warnings)")
 . F ENS=1,2 Q:END  D
 . . S ENL=0
 . . K ^UTILITY($J,"W")
 . . F  S ENL=$O(^TMP($J,"V",ENDA,ENS,ENL)) Q:'ENL  D:$Y+7>IOSL HD Q:END  S X=$S(ENS=1:"E",1:"W")_") "_^TMP($J,"V",ENDA,ENS,ENL,0) S DIWL=1,DIWF="WC"_(IOM-5) D ^DIWP D ^DIWW
 I 'END W !,?5,"Note: E) = Error which prevents transmission     W) = Warning",! I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="Q" K ^TMP($J)
 K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,X,Y
 K END,ENDA,ENDASH,ENDT,ENL,ENPG,ENS,ENV,ENX
 Q
HD ; header
 W:ENPG !,?5,"Note: E) = Error which prevents transmission     W) = Warning",!
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W $S(ENTY="F":"Five Year Facility Plan",ENTY="A":"Project Application",ENTY="R":"Progress Report",1:"Misc.")_" Validation Results   ",?50,ENDT,?70,"page ",ENPG
 W !,ENDASH
 I ENPG>1 W !!,"Project: ",ENPN," (continued)"
 Q
 ;ENPLV1
