FBUCDE ;BOIFO/SGJ-UNAUTHORIZED EDI CLAIMS THAT WERE NOT APPROVED ;12/18/03
 ;;3.5;FEE BASIS;**69**;JAN 30, 1995 
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N FBX
 ; ask date range
 S DIR(0)="D^::EX",DIR("A")="   Beginning Date"
 ;   default from date is first day of current month
 S DIR("B")=$$FMTE^XLFDT($E(DT,1,5)_"01")
 D ^DIR K DIR Q:$D(DIRUT)
 S FBBEG=Y
 S DIR(0)="DA^"_FBBEG_"::EX",DIR("A")="   Ending Date: "
 ;   default to date is last day of specified month
 D NOW^%DTC S DIR("B")=$$FMTE^XLFDT(X)
 D ^DIR K DIR Q:$D(DIRUT)
 S FBEND=Y
 ;
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^FBUCDE",ZTDESC="UNAUTHORIZED EDI CLAIMS REPORT"
 . F FBX="FBBEG","FBEND" S ZTSAVE(FBX)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
QEN ; queued entry
 U IO
 ;
GATHER ; collect and sort data by date
 N FBSET,FBFPPSC,FBC,FBPG,FBHDT,FBDA,FBDTR
 S (FBQUIT,FBPG)=0
 D NOW^%DTC S FBDTR=$$DATX^FBAAUTL(X)
 K FBDL S FBDL="",$P(FBDL,"=",IOM)=""
 ; build page header text for selection criteria
 S FBHDT(1)="From Date: "_$$DATX^FBAAUTL(FBBEG)_"    To Date: "_$$DATX^FBAAUTL(FBEND)
 ;
 D HD
 S FBBEG=FBBEG-.0000001
 S FBEND=FBEND+.999999
 K ^TMP("FBDE")
 ;
 ; Initialize Counter
 S FBC=0
 ;
 S FBSET="  Reason for Disapproval: "
 ;
 S (FBFPPSC,FBDA)=""
 F  S FBFPPSC=$O(^FB583("AFC",FBFPPSC)) Q:FBFPPSC=""  F  S FBDA=$O(^FB583("AFC",FBFPPSC,FBDA)) Q:FBDA=""  D ONE
 D PRINT
 ;
 I FBC=0 W !!,"no entries found.",!
 ;
 I FBQUIT W !!,"REPORT STOPPED AT USER REQUEST",!
 ;
 I 'FBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 G EXIT
 Q
 ;
HD ; page header
 N FBI
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W !,"UNAUTHORIZED EDI CLAIMS THAT WERE NOT APPROVED",?67,FBDTR
 S FBI=0 F  S FBI=$O(FBHDT(FBI)) Q:'FBI  W !,FBHDT(FBI)
 W ?68,"Page: ",FBPG
 W !!,"Date of Disposition",?23,"Disposition",?42,"FPPS Claim ID",?62,"Fee Program"
 W !?2,"Veteran",?38,"Vendor"
 W !?2,"Treatment From",?31,"Treatment To",?58,"Amt Claimed"
 W !,FBDL
 Q
 ;
ONE N FBZ,FBDT
 S FBZ=$G(^FB583(FBDA,0))
 S FBDT=$P(FBZ,U,12)
 ; skip if date of disposition not within specified period
 Q:FBDT=""!(FBDT>FBEND)!(FBDT<FBBEG)
 ; skip if disposition is not equal to disapproved,
 ; cancelled/withdrawn or abandoned.
 Q:"^1^4^"[(U_$P(FBZ,U,11)_U)
 ; store the ien in list (sorted by date of disposition)
 S ^TMP("FBDE",$J,FBDT,FBDA,FBFPPSC)=""
 Q
PRINT ; print claims 
 N I,FBZ,FBAC
 S FBDT="" F  S FBDT=$O(^TMP("FBDE",$J,FBDT)) Q:FBDT=""  D  Q:FBQUIT
 . S FBDA="" F  S FBDA=$O(^TMP("FBDE",$J,FBDT,FBDA)) Q:FBDA=""  D  Q:FBQUIT
 . . S FBC=FBC+1,I=""
 . . S FBZ=$G(^FB583(FBDA,0))
 . . S FBAC=$P(FBZ,U,9)+.0001,FBAC=$P(FBAC,".",1)_"."_$E($P(FBAC,".",2),1,2)
 . . I $Y+9>IOSL D HD Q:FBQUIT
 . . W !!,$$DATX^FBAAUTL($E(FBDT,1,7)),?21,$E($P($$PTR^FBUCUTL("^FB(162.91,",$P(FBZ,U,11)),U),1,30),?44,$O(^TMP("FBDE",$J,FBDT,FBDA,0)),?62,$$PROG^FBUCUTL($P(FBZ,U,2))
 . . W !?2,$E($$VET^FBUCUTL($P(FBZ,U,4)),1,30),?35,$E($$VEN^FBUCUTL($P(FBZ,U,3)),1,30)
 . . W !?2,$$DATX^FBAAUTL($E($P(FBZ,U,5),1,7)),?32,$$DATX^FBAAUTL($E($P(FBZ,U,6),1,7)),?58,$J(FBAC,6)
 . . F  S I=$O(^FB583(FBDA,"D","B",I)) Q:I=""  W !,FBSET_$P(^FB(162.94,I,0),U)
 Q
EXIT ; kill variables, tmp global and quit
 S:$D(ZTQUEUED) ZTREQ="@"
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,POP,X,Y
 K ^TMP("FBDE"),FBBEG,FBEND,FBQUIT,FBDL
 Q
 ;FBUCDE
