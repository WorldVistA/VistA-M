FBAAPAR ;WOIFO/SAB - PAYMENT AGING REPORT ;11/7/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; ICRs
 ;  #10090  ^DIC(4,
 ;  #2056   $$GET1^DIQ
 ;  #10026  DIR
 ;  #10003  DD^%DT
 ;  #10000  NOW^%DTC
 ;  #4398   FIRST^VAUTOMA
 ;  #10103  $$FMADD^XLFDT, $$FMDIFF^XLFDT, $$FMTE^XLFDT
 ;  #2171   $$STA^XUAF4
 ;  #10086  %ZIS, HOME^%ZIS
 ;  #10089  %ZISC
 ;  #10063  %ZTLOAD, $$S^%ZTLOAD
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FBDT1,FBDT2,FBPSV,FBX,%ZIS,POP,X,Y
 ;
 ; user prompts
 ;
 ; ask one/many/all primary service failities
 W !!
 S DIC="^DIC(4,"
 S VAUTSTR="Primary Service Facility",VAUTNI=2,VAUTVB="FBPSV"
 D FIRST^VAUTOMA K DIC I Y=-1 G EXIT
 ;
 ; ask end date
 S DIR(0)="D^:"_DT_":EX"
 S DIR("A")="Report payments finalized on or before"
 ;   default end date is last day of month at least 30 days ago
 S FBX=$$FMADD^XLFDT($E(DT,1,5)_"01",-1) ; last date of prior month
 I $$FMDIFF^XLFDT(DT,FBX)<30 S FBX=$$FMADD^XLFDT($E(FBX,1,5)_"01",-1)
 S DIR("B")=$$FMTE^XLFDT(FBX)
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDT2=Y
 ;
 ; ask start date
 S DIR(0)="D^:"_FBDT2_":EX"
 S DIR("A")="Earliest finalized date to report"
 ;   default start date is first day of selected month
 S DIR("B")=$$FMTE^XLFDT($E(FBDT2,1,5)_"01")
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDT1=Y
 ;
 ; ask device
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 . S ZTRTN="QEN^FBAAPAR",ZTDESC="Fee Basis Payment Aging Report"
 . F FBX="FBDT*","FBPSV","FBPSV(" S ZTSAVE(FBX)=""
 . D ^%ZTLOAD,HOME^%ZIS
 ;
QEN ; queued entry
 U IO
 ;
GATHER ; collect and sort data
 K ^TMP($J)
 ; init counters
 K FBC F X="B2","B3","B5","B9" F Y="F","P" S FBC(X,Y)=0
 ;
 ;
 ; batch type B2
 ; loop thru batch file by date finalized for specified period
 ;   because DATE FINALIZED field is not being populated
 S FBDT=FBDT1-.0001
 F  S FBDT=$O(^FBAA(161.7,"AF",FBDT)) Q:FBDT>FBDT2!(FBDT="")  D
 . ; loop thru batch
 . S FBN=0 F  S FBN=$O(^FBAA(161.7,"AF",FBDT,FBN)) Q:'FBN  D
 . . ; loop thru payments for batch
 . . S FBJ=0 F  S FBJ=$O(^FBAAC("AD",FBN,FBJ)) Q:'FBJ  D
 . . . S FBK=0 F  S FBK=$O(^FBAAC("AD",FBN,FBJ,FBK)) Q:'FBK  D
 . . . . S FBY0=$G(^FBAAC(FBJ,3,FBK,0))
 . . . . ;
 . . . . ; dont't check primary service facility since it is not
 . . . . ;   stored with payment, associated auth. is not known, and
 . . . . ;   station in batch file is not necessarily the same
 . . . . ;
 . . . . S FBC("B2","F")=FBC("B2","F")+1 ; incr finalized count
 . . . . ;
 . . . . ; check if payment meets criterion for pending
 . . . . Q:$P(FBY0,U,7)'=""  ; check number
 . . . . Q:$P(FBY0,U,6)'=""  ; date paid
 . . . . Q:$P(FBY0,U,8)'=""  ; cancel date
 . . . . Q:$P($G(^FBAAC(FBJ,3,FBK,"FBREJ")),U)'=""  ; reject status
 . . . . ; travel payment cannot be void
 . . . . ;
 . . . . ; save payment in list
 . . . . S ^TMP($J,"B2",FBDT,FBJ,FBK)=""
 . . . . S FBC("B2","P")=FBC("B2","P")+1 ; incr pending payment count
 ;
 ; batch type B3
 ; loop thru DATE FINALIZED x-ref
 S FBDT=FBDT1-.0001
 F  S FBDT=$O(^FBAAC("AK",FBDT)) Q:FBDT>FBDT2!(FBDT="")  D
 . S FBJ=0 F  S FBJ=$O(^FBAAC("AK",FBDT,FBJ)) Q:'FBJ  D
 . . S FBK=0 F  S FBK=$O(^FBAAC("AK",FBDT,FBJ,FBK)) Q:'FBK  D
 . . . S FBL=0 F  S FBL=$O(^FBAAC("AK",FBDT,FBJ,FBK,FBL)) Q:'FBL  D
 . . . . S FBM=0 F  S FBM=$O(^FBAAC("AK",FBDT,FBJ,FBK,FBL,FBM)) Q:'FBM  D
 . . . . . S FBY0=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,0))
 . . . . . S FBY2=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,2))
 . . . . . ;
 . . . . . ; skip if not selected primary service facility
 . . . . . I 'FBPSV,$P(FBY0,U,12),'$D(FBPSV($P(FBY0,U,12))) Q
 . . . . . ;
 . . . . . S FBC("B3","F")=FBC("B3","F")+1 ; incr finalized count
 . . . . . ;
 . . . . . ; check if payment meets criterion for pending
 . . . . . Q:$P(FBY2,U,3)'=""  ; check number
 . . . . . Q:$P(FBY0,U,14)'=""  ; date paid
 . . . . . Q:$P(FBY2,U,4)'=""  ; cancellation date
 . . . . . Q:$P($G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,"FBREJ")),U)'=""  ; rej.
 . . . . . Q:$P(FBY0,U,21)'=""  ; void
 . . . . . ;
 . . . . . ; save payment in list
 . . . . . S ^TMP($J,"B3",FBDT,FBJ,FBK,FBL,FBM)=""
 . . . . . S FBC("B3","P")=FBC("B3","P")+1 ; incr pending payment count
 ;
 ; batch type B5
 ; loop thru batch file by date finalized for specified period
 ;   because DATE FINALIZED field does not exist
 S FBDT=FBDT1-.0001
 F  S FBDT=$O(^FBAA(161.7,"AF",FBDT)) Q:FBDT>FBDT2!(FBDT="")  D
 . ; loop thru batch
 . S FBN=0 F  S FBN=$O(^FBAA(161.7,"AF",FBDT,FBN)) Q:'FBN  D
 . . ; loop thru payments for batch
 . . S FBJ=0 F  S FBJ=$O(^FBAA(162.1,"AE",FBN,FBJ)) Q:'FBJ  D
 . . . S FBK=0 F  S FBK=$O(^FBAA(162.1,"AE",FBN,FBJ,FBK)) Q:'FBK  D
 . . . . S FBY2=$G(^FBAA(162.1,FBJ,"RX",FBK,2))
 . . . . ;
 . . . . ; skip if not selected primary service facility
 . . . . I 'FBPSV,$P(FBY2,U,5),'$D(FBPSV($P(FBY2,U,5))) Q
 . . . . ;
 . . . . S FBC("B5","F")=FBC("B5","F")+1 ; incr finalzied count
 . . . . ;
 . . . . ; check if payment meets criterion as pending
 . . . . Q:$P(FBY2,U,10)'=""  ; check number
 . . . . Q:$P(FBY2,U,8)'=""  ; date paid
 . . . . Q:$P(FBY2,U,11)'=""  ; cancel date
 . . . . Q:$P(FBY2,U,3)'=""  ; void
 . . . . Q:$P($G(^FBAA(162.1,FBJ,"RX",FBK,"FBREJ")),U)'=""  ; reject
 . . . . ;
 . . . . ; save payment in list
 . . . . S ^TMP($J,"B5",FBDT,FBJ,FBK)=""
 . . . . S FBC("B5","P")=FBC("B5","P")+1 ; incr pending payment count
 ;
 ; batch type B9
 ; loop thru DATE FINALIZED x-ref
 S FBDT=FBDT1-.0001
 F  S FBDT=$O(^FBAAI("AD",FBDT)) Q:FBDT>FBDT2!(FBDT="")  D
 . S FBJ=0 F  S FBJ=$O(^FBAAI("AD",FBDT,FBJ)) Q:'FBJ  D
 . . S FBY0=$G(^FBAAI(FBJ,0))
 . . S FBY2=$G(^FBAAI(FBJ,2))
 . . ;
 . . ; skip if not selected primary service facility
 . . I 'FBPSV,$P(FBY0,U,20),'$D(FBPSV($P(FBY0,U,20))) Q
 . . ;
 . . S FBC("B9","F")=FBC("B9","F")+1 ; incr finalized count
 . . ;
 . . ; check if payment meets criterion
 . . Q:$P(FBY2,U,4)'=""  ; check number
 . . Q:$P(FBY2,U,1)'=""  ; date paid
 . . Q:$P(FBY2,U,5)'=""  ; cancellation date
 . . Q:$P($G(^FBAAI(FBJ,"FBREJ")),U)'=""  ; reject status
 . . Q:$P(FBY0,U,14)'=""  ; void
 . . ;
 . . ; save payment in list
 . . S ^TMP($J,"B9",FBDT,FBJ)=""
 . . S FBC("B9","P")=FBC("B9","P")+1 ; incr pending payment count
 ;
PRINT ; report data
 S (FBQUIT,FBPG)=0 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 K FBDL
 S FBDL="",$P(FBDL,"-",80)=""
 ;
 ; build page header text for selection criteria
 K FBHDT
 S FBHDT(1)="  Payments finalized from "
 S FBHDT(1)=FBHDT(1)_$$FMTE^XLFDT(FBDT1)_" to "_$$FMTE^XLFDT(FBDT2)
 S FBHDT(2)="  for "_$S(FBPSV:"all ",1:"")_"primary service facilities"_$S(FBPSV:"",1:": ")
 I 'FBPSV D
 . ; load facility numbers into header lines
 . S FBK=2
 . S FBJ=0 F  S FBJ=$O(FBPSV(FBJ)) Q:'FBJ  D
 . . S FBX=$$STA^XUAF4(FBJ)_"  "
 . . I $L(FBHDT(FBK))+$L(FBX)>78 S FBK=FBK+1,FBHDT(FBK)="  "
 . . S FBHDT(FBK)=FBHDT(FBK)_FBX
 S Q="",$P(Q,"=",80)="="
 S (FBAAOUT,FBINTOT)=0
 ;
 ; loop thru ^TMP global by batch type
 S FBTYPE="" F  S FBTYPE=$O(^TMP($J,FBTYPE)) Q:FBTYPE=""  D  Q:FBQUIT
 . ; print header
 . D HD
 . ; add header for batch type
 . D:FBTYPE="B2" HEDP^FBAACCB0
 . D:FBTYPE="B3" HED^FBAACCB
 . D:FBTYPE="B5" HED^FBAACCB
 . D:FBTYPE="B9" HEDC^FBAACCB1
 . ;
 . ; loop thru date finalized
 . S FBDT="" F  S FBDT=$O(^TMP($J,FBTYPE,FBDT)) Q:FBDT=""  D  Q:FBQUIT
 . . ; process payments
 . . D:FBTYPE="B2" PROCB2
 . . D:FBTYPE="B3" PROCB3
 . . D:FBTYPE="B5" PROCB5
 . . D:FBTYPE="B9" PROCB9
 ;
 I FBQUIT W !!,"REPORT STOPPED AT USER REQUEST"
 E  D  ; report footer
 . I $Y+5>IOSL D HD Q:FBQUIT
 . W !,FBDL
 . W !,"Type",?30,"Total Finalized",?50,"Pending Payment"
 . F FBTYPE="B2","B3","B5","B9" D
 . . W !,"  "
 . . W:FBTYPE="B2" "Travel"
 . . W:FBTYPE="B3" "Outpatient/Ancillary"
 . . W:FBTYPE="B5" "Pharmacy"
 . . W:FBTYPE="B9" "Inpatient"
 . . W ?30,$J(FBC(FBTYPE,"F"),10)
 . . W ?50,$J(FBC(FBTYPE,"P"),10)
 ;
 I 'FBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K FBC,FBDA,FBDL,FBDT,FBDT1,FBDT2,FBDTR,FBEV,FBHDT,FBJ,FBK,FBL,FBM,FBN
 K FBPG,FBSTALL,FBSTN,FBQUIT,FBY0,FBY2
 D Q^FBAACCB0
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
HD ; page header
 N FBI
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W !,"Fee Basis Payment Aging Report",?49,FBDTR,?72,"page ",FBPG
 S FBI=0 F  S FBI=$O(FBHDT(FBI)) Q:'FBI  W !,FBHDT(FBI)
 W !
 Q
 ;
PROCB2 ;
 N J,K,Y
 ; loop thru payments
 S FBJ=0 F  S FBJ=$O(^TMP($J,FBTYPE,FBDT,FBJ)) Q:'FBJ  D  Q:FBQUIT
 . S FBK=0 F  S FBK=$O(^TMP($J,FBTYPE,FBDT,FBJ,FBK)) Q:'FBK  D  Q:FBQUIT
 . . I $Y+7>IOSL D HD Q:FBQUIT  D HEDP^FBAACCB0
 . . S J=FBJ,K=FBK,Y(0)=^FBAAC(J,3,K,0)
 . . D SETT^FBAACCB0 I FBAAOUT S FBQUIT=1
 Q
 ;
PROCB3 ;
 N B,J,K,L,M
 ; loop thru payments
 S FBJ=0 F  S FBJ=$O(^TMP($J,FBTYPE,FBDT,FBJ)) Q:'FBJ  D  Q:FBQUIT
 . S FBK=0 F  S FBK=$O(^TMP($J,FBTYPE,FBDT,FBJ,FBK)) Q:'FBK  D  Q:FBQUIT
 . . S FBL=0
 . . F  S FBL=$O(^TMP($J,FBTYPE,FBDT,FBJ,FBK,FBL)) Q:'FBL  D  Q:FBQUIT
 . . . S FBM=0
 . . . F  S FBM=$O(^TMP($J,FBTYPE,FBDT,FBJ,FBK,FBL,FBM)) Q:'FBM  D  Q:FBQUIT
 . . . . I $Y+8>IOSL D HD Q:FBQUIT  D HED^FBAACCB
 . . . . S J=FBJ,K=FBK,L=FBL,M=FBM
 . . . . S Y(0)=^FBAAC(J,1,K,1,L,1,M,0),B=$P(Y(0),U,8)
 . . . . D SET^FBAACCB I FBAAOUT S FBQUIT=1
 Q
 ;
PROCB5 ;
 N A,B,B2,Z
 ; loop thru payments
 S FBJ=0 F  S FBJ=$O(^TMP($J,FBTYPE,FBDT,FBJ)) Q:'FBJ  D  Q:FBQUIT
 . S FBK=0 F  S FBK=$O(^TMP($J,FBTYPE,FBDT,FBJ,FBK)) Q:'FBK  D  Q:FBQUIT
 . . I $Y+7>IOSL D HD Q:FBQUIT  D HED^FBAACCB
 . . S A=FBJ,B2=FBK,Z(0)=^FBAA(162.1,A,"RX",B2,0),B=$P(Z(0),U,17)
 . . D SETV^FBAACCB0,MORE^FBAACCB1 I FBAAOUT S FBQUIT=1
 Q
 ;
PROCB9 ;
 N A,B,B2,Z
 ; loop thru payments
 S FBJ=0 F  S FBJ=$O(^TMP($J,FBTYPE,FBDT,FBJ)) Q:'FBJ  D  Q:FBQUIT
 . I $Y+7>IOSL D HD Q:FBQUIT  D HEDC^FBAACCB1
 . S I=FBJ,Z(0)=^FBAAI(I,0),B=$P(Z(0),U,17)
 . D CMORE^FBAACCB1 I FBAAOUT S FBQUIT=1
 Q
 ;
 ;FBAAPAR
