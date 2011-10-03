ORCMGMCK ;SLC/JFR - FIND GMRC QO'S WITH INACTIVE CODES ;6/4/03 11:33
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**181**;Dec 17, 1997
 ;
 ; This routine invokes IA # 3990
 ;
 Q
FINDQOS ; find cons/proc quick orders with a default Prov. DX code
 N ORDLG,ORPDLG,ORDGC,ORDGP
 K ^TMP("ORCMGMCK",$J)
 S ORDGC=$$FIND1^DIC(100.98,,"QX","CONSULTS") ;find disp. group ien
 S ORDGP=$$FIND1^DIC(100.98,,"QX","PROCEDURES") ;find disp. group ien
 S ORPDLG=$$PTR^ORCD("OR GTX CODE")
 S ORDLG=0
 F  S ORDLG=$O(^ORD(101.41,ORDLG)) Q:'ORDLG  I $P(^(ORDLG,0),U,4)="Q" D
 . N ORQDG,ORCODEF,ORPRMPT,ORAPIVAL,ACTDT
 . S ORQDG=$P(^ORD(101.41,ORDLG,0),U,5)
 . I ORQDG'=ORDGC&(ORQDG'=ORDGP) Q  ;not in CONS or PROC display group
 . S ORPRMPT=$O(^ORD(101.41,ORDLG,6,"D",ORPDLG,0))
 . I 'ORPRMPT Q  ;no PD prompt
 . S ORCODEF=$G(^ORD(101.41,ORDLG,6,ORPRMPT,1))
 . I '$L(ORPRMPT) Q  ; no default CODE stored.
 . I '$$STATCHK^ICDAPIU(ORCODEF,DT) D  Q
 .. S ^TMP("ORCMGMCK",$J,"I",ORDLG)=$P(^ORD(101.41,ORDLG,0),U)_U_ORCODEF
 . S ORAPIVAL=$$HIST^ICDAPIU(ORCODEF,.ORAPIVAL)
 . S ACTDT=$O(ORAPIVAL(DT))
 . I ACTDT,'$G(ORAPIVAL(ACTDT)) D  ; future inactivation
 .. S ^TMP("ORCMGMCK",$J,"F",ORDLG)=$P(^ORD(101.41,ORDLG,0),U)_U_ORCODEF_U_$$FMTE^XLFDT(ACTDT)
 Q
 ;
CSVPEP ; protocol event point called upon CSV install
 ;  Called by Protocol -  ??
 ;
 N LN,XMSUB,XMTEXT,XMDUZ,XMY
 D FINDQOS
 K ^TMP("ORCMMSG",$J)
 S LN=1
 I $D(^TMP("ORCMGMCK",$J,"I")) D
 . S ^TMP("ORCMMSG",$J,LN)="The following Consult or Procedure quick orders were found that currently",LN=LN+1
 . S ^TMP("ORCMMSG",$J,LN)="have a provisional diagnosis code that is inactive. These should be edited",LN=LN+1
 . S ^TMP("ORCMMSG",$J,LN)="as soon as possible to reduce interruption of ordering these quick orders.",LN=LN+1
 . S ^TMP("ORCMMSG",$J,LN)=" ",LN=LN+1
 . S IREC=0
 . F  S IREC=$O(^TMP("ORCMGMCK",$J,"I",IREC)) Q:'IREC  D
 .. S ^TMP("ORCMMSG",$J,LN)="Quick order name: "_$P(^TMP("ORCMGMCK",$J,"I",IREC),U)_"    IEN: "_IREC,LN=LN+1
 .. S ^TMP("ORCMMSG",$J,LN)="Provisional Diagnosis code: "_$P(^TMP("ORCMGMCK",$J,"I",IREC),U,2),LN=LN+1
 .. S ^TMP("ORCMMSG",$J,LN)=" ",LN=LN+1
 . Q
 ;
 I $D(^TMP("ORCMGMCK",$J,"F")) D
 . S ^TMP("ORCMMSG",$J,LN)="The following Consult or Procedure quick orders were found to have a",LN=LN+1
 . S ^TMP("ORCMMSG",$J,LN)="provisional diagnosis code that will become inactive in the future.",LN=LN+1
 . S ^TMP("ORCMMSG",$J,LN)="These should be edited as soon as possible after the inactivation date to",LN=LN+1
 . S ^TMP("ORCMMSG",$J,LN)="reduce interruption in ordering these quick orders.",LN=LN+1
 . S ^TMP("ORCMMSG",$J,LN)=" ",LN=LN+1
 . S FREC=0
 . F  S FREC=$O(^TMP("ORCMGMCK",$J,"F",FREC)) Q:'FREC  D
 .. S ^TMP("ORCMMSG",$J,LN)="Quick order name: "_$P(^TMP("ORCMGMCK",$J,"F",FREC),U)_"    IEN: "_FREC,LN=LN+1
 .. S ^TMP("ORCMMSG",$J,LN)="Provisional Diagnosis code: "_$P(^TMP("ORCMGMCK",$J,"F",FREC),U,2)_"  Inactivation Date: "_$$FMTE^XLFDT($P(^(FREC),U,3),2)
 .. S LN=LN+1
 . Q
 I '$D(^TMP("ORCMMSG",$J)) D
 . S ^TMP("ORCMMSG",$J,LN)="There were no problem quick orders found."
 . S LN=LN+1
 S XMY("G.ORCM CSV EVENT")=""
 S XMSUB="DX Code check of Consult/Procedure QO's"
 S XMDUZ="Code Set Version Install"
 S XMTEXT="^TMP(""ORCMMSG"",$J,"
 D ^XMD
 K ^TMP("ORCMGMCK",$J),^TMP("ORCMMSG",$J)
 Q
 ;
CSVOPT ; report of CSV affected quick orders from option ORCM ...
 N %ZIS,POP
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZISC,HOME^%ZIS Q
 . N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 . S ZTDESC="Review of OR Quick orders for CSV"
 . S ZTRTN="QUEUE^ORCMGMCK",ZTIO=ION,ZTDTH=$H
 . D ^%ZTLOAD
 . I '$G(ZTSK) W !,"Unable to task report"
 . Q
 ;
QUEUE ; entry point for tasked report
 I $D(ZTQUEUED) S ZTREQ="@"
 N PG
 U IO
 D FINDQOS  ;will return ^TMP("ORCMGMCK",$J) with list of quick orders
 S PG=1 D PAGE(.PG)
 I $D(^TMP("ORCMGMCK",$J,"I")) D
 . N IREC
 . W !,"The following Consult or Procedure quick orders were found that currently"
 . W !,"have a provisional diagnosis code that is inactive. These should be edited"
 . W !,"as soon as possible to reduce interruption of ordering these quick orders.",!
 . S IREC=0
 . F  S IREC=$O(^TMP("ORCMGMCK",$J,"I",IREC)) Q:'IREC!(PG<1)  D
 .. I IOSL-$Y<4 D PAGE(.PG) Q:'PG
 .. W !,"Quick order name: ",$P(^TMP("ORCMGMCK",$J,"I",IREC),U),"    IEN: ",IREC
 .. W !,"Provisional Diagnosis code: ",$P(^TMP("ORCMGMCK",$J,"I",IREC),U,2)
 .. W !," "
 . Q
 ;
 I $D(^TMP("ORCMGMCK",$J,"F")) D
 . I IOSL=$Y<8 D PAGE(.PG) Q:'PG
 . W !,"The following Consult or Procedure quick orders were found to have a"
 . W !,"provisional diagnosis code that will become inactive in the future."
 . W !,"These should be edited as soon as possible after the inactivation date to"
 . W !,"reduce interruption in ordering these quick orders."
 . W !," "
 . N FREC
 . S FREC=0
 . F  S FREC=$O(^TMP("ORCMGMCK",$J,"F",FREC)) Q:'FREC!(PG<1)  D
 .. I IOSL-$Y<4 D PAGE(.PG) Q:'PG
 .. W !,"Quick order name: ",$P(^TMP("ORCMGMCK",$J,"F",FREC),U),"    IEN: ",FREC
 .. W !,"Provisional Diagnosis code: ",$P(^TMP("ORCMGMCK",$J,"F",FREC),U,2),"  Inactivation Date: ",$$FMTE^XLFDT($P(^(FREC),U,3),2)
 . Q
 I '$D(^TMP("ORCMGMCK",$J)) D
 . W !,"There were no problem quick orders found.",!
 . I $E(IOST,1,2)="C-" D
 .. N DIR,DTOUT,DIRUT,DUOUT,X,Y
 .. S DIR(0)="E" D ^DIR
 . Q
 D:$E(IOST,1,2)'="C-" ^%ZISC
 D HOME^%ZIS
 K ^TMP("ORCMGMCK",$J)
 Q
 ;
PAGE(NUM) ;print header and raise page number
 I NUM'=1,$E(IOST,1,2)="C-" D  Q:'NUM
 . N DIR,DTOUT,DIRUT,DUOUT,X,Y
 . S DIR(0)="E" D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) S NUM=0
 W @IOF
 W "Code Set Version review of Consult/Procedure Quick Orders"
 W ?70,"Page: ",NUM
 W !,$$REPEAT^XLFSTR("-",78)
 S NUM=NUM+1
 Q
