XMCQH ;ISC-SF/GMB-Transmit Queue History ;01/08/2003  13:52
 ;;8.0;MailMan;**8,14**;Jun 28, 2002
 ; Was (WASH ISC)/CAP/AML/RJ
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ENTER   XMQHIST     (was ^XMS4)
ENTER ;
 N XMPARM,XMABORT
 S XMABORT=0
 D INIT(.XMPARM,.XMABORT) Q:XMABORT
 S ZTSAVE("XMPARM(")=""
 D EN^XUTMDEVQ("ENT^XMCQH",$$EZBLD^DIALOG(42100),.ZTSAVE) ; MailMan: Transmission Queue History Report
 Q
INIT(XMPARM,XMABORT) ; Get period to report on.  Default is current month.
 S (XMPARM("START"),XMPARM("END"))=$E(DT,1,5)
 Q:$D(ZTQUEUED)
 D START(.XMPARM,.XMABORT) Q:XMABORT
 D END(.XMPARM,.XMABORT)
 Q
START(XMPARM,XMABORT) ; Start of report period
 N DIR,Y,X
 S DIR(0)="DO^:DT:E"
 S DIR("A")=$$EZBLD^DIALOG(42107) ; Start of report period
 D BLD^DIALOG(42107.1,"","","DIR(""?"")")
 ;Enter a month and year or just a year.  Any day will be ignored.
 ;This is the start of the period you want reported.  The report will
 ;start on the first day of the period you enter.
 S DIR("B")=$$FMTE^XLFDT(XMPARM("START")_"00")
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 S XMPARM("START")=$E(Y,1,5)
 Q
END(XMPARM,XMABORT) ; End of report period
 S XMPARM("END")=XMPARM("START")
 Q:$E(XMPARM("START"),1,5)=$E(DT,1,5)  ; This month
 Q:XMPARM("START")=($E(DT,1,3)_"00")  ; This year
 N DIR,Y,X,XMDT
 S XMDT=XMPARM("START")
 S:$E(XMDT,4,5)="00" XMDT=$E(XMDT,1,3)_"01"
 S DIR(0)="DO^"_XMDT_"01:DT:E"
 S DIR("A")=$$EZBLD^DIALOG(42108) ; End of report period
 D BLD^DIALOG(42108.1,"","","DIR(""?"")")
 ;Enter a month and year or just a year.  Press enter to accept the default.
 ;This is the end of the period you want reported.  The report will go
 ;through the last day of the period you enter.
 I $E(XMPARM("END"),4,5)="00" S XMPARM("END")=$E(XMPARM("END"),1,3)_"1200"
 E  S XMPARM("END")=$$SCH^XLFDT("1M(L)",XMPARM("END")_"01")
 S DIR("B")=$$FMTE^XLFDT(XMPARM("END"))
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 S XMPARM("END")=$E(Y,1,5)
 Q
ENT ;
 N XMNAME,XMRPT,XMIEN,XMREC,XMABORT,XMQD,XMCNT,XMTITLE,XMMON,XMSENT,XMRCVD
 ;Transmission Queue History
 ;Domain          Queued    Sent    Rcvd   Domain          Queued    Sent    Rcvd
 I $E(XMPARM("END"),4,5)'="00",$E(XMPARM("START"),4,5)="00" D
 . I $E(XMPARM("END"),4,5)=12 S XMPARM("END")=XMPARM("START") Q
 . S $E(XMPARM("START"),4,5)="01"
 I $E(XMPARM("END"),4,5)="00",$E(XMPARM("START"),4,5)'="00" D
 . I $E(XMPARM("END"),1,3)=$E(DT,1,3) S XMPARM("END")=$E(DT,1,5) Q
 . S $E(XMPARM("END"),4,5)=12
 I XMPARM("START")=XMPARM("END") D
 . S XMTITLE=$$EZBLD^DIALOG(42101,$$FMTE^XLFDT(XMPARM("START")_"00")) ;Transmission Queue History, |1|
 E  D
 . N XMP S XMP(1)=$$FMTE^XLFDT(XMPARM("START")_"00"),XMP(2)=$$FMTE^XLFDT(XMPARM("END")_"00")
 . S XMTITLE=$$EZBLD^DIALOG(42101.1,.XMP) ;Transmission Queue History, |1| - |2|
 D INIT^XMCQA(.XMRPT,XMTITLE,42102)
 I $E(XMPARM("END"),4,5)="00" S XMPARM("END")=$E(XMPARM("END"),1,3)_"12"
 S XMNAME="",(XMCNT,XMABORT,XMCNT("SENT"),XMCNT("RCVD"),XMCNT("QD"))=0
 F  S XMNAME=$O(^DIC(4.2,"B",XMNAME)) Q:XMNAME=""  D  Q:XMABORT
 . S XMIEN=""
 . F  S XMIEN=$O(^DIC(4.2,"B",XMNAME,XMIEN)) Q:'XMIEN  D  Q:XMABORT
 . . S (XMSENT,XMRCVD)=0
 . . S XMMON=XMPARM("START")-.01
 . . F  S XMMON=$O(^XMBS(4.2999,XMIEN,100,XMMON)) Q:XMMON>XMPARM("END")!'XMMON  D
 . . . S XMREC=$G(^XMBS(4.2999,XMIEN,100,XMMON,0))
 . . . S XMSENT=XMSENT+$P(XMREC,U,2),XMRCVD=XMRCVD+$P(XMREC,U,3)
 . . S XMQD=$$BMSGCT^XMXUTIL(.5,XMIEN+1000)
 . . I 'XMQD,'XMSENT,'XMRCVD Q
 . . S XMCNT("SENT")=XMCNT("SENT")+XMSENT
 . . S XMCNT("RCVD")=XMCNT("RCVD")+XMRCVD
 . . S XMCNT("QD")=XMCNT("QD")+XMQD
 . . S XMCNT=XMCNT+1
 . . I XMCNT#2 D  Q:XMABORT
 . . . I $Y+3>IOSL D  Q:XMABORT
 . . . . D PAGE^XMCQA(.XMABORT) Q:XMABORT
 . . . . D HDR^XMCQA(.XMRPT)
 . . . W !
 . . E  W "   "
 . . W $$MELD^XMXUTIL1(XMNAME,XMQD,22),$J(XMSENT,8),$J(XMRCVD,8)
 Q:XMABORT
 I $Y+7>IOSL D  Q:XMABORT
 . D PAGE^XMCQA(.XMABORT)
 . D HDR^XMCQA(.XMRPT)
 W !!,$$MELD^XMXUTIL1($$EZBLD^DIALOG(42103),XMCNT,27) ; Total Domains:
 W !,$$MELD^XMXUTIL1($$EZBLD^DIALOG(42104),XMCNT("QD"),27) ; Total Queued:
 W !,$$MELD^XMXUTIL1($$EZBLD^DIALOG(42105),XMCNT("SENT"),27) ; Total Sent:
 W !,$$MELD^XMXUTIL1($$EZBLD^DIALOG(42106),XMCNT("RCVD"),27) ; Total Received:
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
