TIUASRPT ; SLC/JMH - Review unsigned additional signer Documents by DIVISION ; [12/2/04 11:50am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**157**;Jun 20, 1997
BEGIN ; Select Division(s), Entry Date Range, Service, Type of Report
 N TIUI,TIUSTDT,TIUENDT,TIUSVCS
 D SELDIV^TIULA Q:SELDIV'>0
 I $D(TIUDI) D
 . S TIUI=0 F  S TIUI=$O(TIUDI(TIUI)) Q:'TIUI  D
 . . S TIUDI("ENTRIES")=$G(TIUDI("ENTRIES"))_TIUI_";"
 E  D
 . S TIUDI("ENTRIES")="ALL DIVISIONS"
 ;
 ;Ask Date Range, exit if timeout, '^' or no selection
 Q:'$$ASKRNG(.TIUSTDT,.TIUENDT)
 ;
 ;Select Service, exit if timeout, '^' or no selection
 Q:'$$SELSVC^TIULA(.TIUSVCS)
 ;
 N DIR,DIRUT,DTOUT,DUOUT,TIURPT
 S DIR(0)="S^F:FULL;S:SUMMARY",DIR("A")="Type of Report"
 S DIR("?",1)="Summary lists the number of documents by author's"
 S DIR("?",2)="service/section. Full lists detailed document"
 S DIR("?",3)="information by author's service/section."
 S DIR("?")="Enter ""^"", or a RETURN to quit."
 D ^DIR Q:$D(DIRUT)  S TIURPT=Y
 ;
DEV ; Device selection
 I TIURPT="F" D
 . W !!,"This report should be sent to a 132 Column Device"
 S %ZIS="Q" W ! D ^%ZIS I POP K POP G EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="BUILD^TIUASRPT"
 . S ZTSAVE("TIUDI(")="",ZTSAVE("TIURPT")=""
 . S ZTSAVE("TIUSTDT")="",ZTSAVE("TIUENDT")=""
 . S ZTSAVE("TIUSVCS")="",ZTSAVE("TIUSVCS(")=""
 . S ZTDESC="TIU PENDING ADD. SIGNATURES BY DIV"
 . D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled!")
 . K ZTSK,ZTDESC,ZTRTN,ZTSAVE,%ZIS,TIUDIV,TIURPT,TIUIFP
 . D HOME^%ZIS
 U IO D BUILD,^%ZISC
 Q
BUILD ; Build list
 N TIUIFP,TIUK
 K ^TMP("TIUD",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 I +$G(TIUDI("ENTRIES")) D
 . S TIUK=0 F  S TIUK=$O(TIUDI(TIUK)) Q:'TIUK  D
 . . S TIUIFP=$G(TIUDI(TIUK))
 . . D GATHER(TIUIFP,TIUSTDT,TIUENDT,.TIUSVCS)
 E  D
 . S TIUIFP=0
 . F  S TIUIFP=$O(^TIU(8925,"ADIV",TIUIFP)) Q:+TIUIFP'>0  D
 . . D GATHER(TIUIFP,TIUSTDT,TIUENDT,.TIUSVCS)
 D PRINT
 ;
EXIT ; Clean up and exit
 K SELDIV,TIUDI,TIUSTDT,TIUENDT,TIUSVCS K ^TMP("TIUD",$J)
 Q
GATHER(TIUIFP,TIUSTDT,TIUENDT,TIUSVCS) ; Find records for the list
 ; Input   -- TIUIFP  INSTITUTION file (#4) IEN
 ;            (0 = gather all divisions)
 ;            TIUSTDT Start Date
 ;            TIUENDT End Date
 ;            TIUSVCS Service Selection Array
 ; Output  -- None
 N TIUDA,TIUJ,TIUS,TIUTP
 S TIUTP=TIUSTDT
 F  S TIUTP=$O(^TIU(8925.7,"AC",TIUTP)) Q:'TIUTP!(TIUTP>(TIUENDT+1))  D
 . N TIUIEN S TIUIEN=0
 . F  S TIUIEN=$O(^TIU(8925.7,"AC",TIUTP,TIUIEN)) Q:'TIUIEN  D
 . . I $P($G(^TIU(8925,TIUIEN,12)),U,12)'=TIUIFP Q
 . . D ADDELMNT(TIUIEN,.TIUSVCS)
 Q
 ;
ADDELMNT(TIUDA,TIUSVCS) ; Add each element to the list
 ; Input  -- TIUDA   TIU DOCUMENT file (#8925) IEN
 ;           TIUSVCS Service Selection Array
 ; Output -- None
 N TIUASREC,TIUSVC,TIUEDT,TIUD12,TIUIFP,TIUSTAT
 S TIUSTAT=$P($G(^TIU(8925,TIUDA,0)),U,5)
 I TIUSTAT>8 Q
 S TIUASREC=0
 S TIUD12=$G(^TIU(8925,TIUDA,12))
 S TIUEDT=+$P(TIUD12,U),TIUIFP=+$P(TIUD12,U,12)
 F  S TIUASREC=$O(^TIU(8925.7,"B",TIUDA,TIUASREC)) Q:'TIUASREC  D
 . N TIUAS,TIUASSVC
 . S TIUAS=$P(^TIU(8925.7,TIUASREC,0),U,3)
 . I 'TIUAS!$P(^TIU(8925.7,TIUASREC,0),U,4) Q
 . S TIUASSVC=$$PROVSVC^TIULV(TIUAS)
 . I $G(TIUSVCS)="ALL"!($D(TIUSVCS(+TIUASSVC))) D
 . . S TIUAS=$$PERSNAME^TIULC1(TIUAS)
 . . I $P(TIUASSVC,U,2)]"" S TIUASSVC=$P(TIUASSVC,U,2)
 . . E  S TIUASSVC="UNKNOWN"
 . . I TIUAS'="UNKNOWN" S TIUAS=$$NAME^TIULS(TIUAS,"LAST, FI MI")
 . . S ^TMP("TIUD",$J,TIUIFP,TIUASSVC,TIUAS,TIUEDT)=TIUDA
 Q
 ;
PRNT(TIUDA) ; Does document have a parent?
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- TIUPRNT  Null= TIU Document file (#8925) entry does
 ;                          not have a parent
 ;                    Exists= TIU Document file (#8925) entry is
 ;                            an addendum or ID child.
 ;                            Value: Parent TIU Document file
 ;                                   (#8925) IEN 
 N ADDMPRNT,IDPRNT,TIUPRNT
 S TIUPRNT=""
 S ADDMPRNT=+$P($G(^TIU(8925,TIUDA,0)),U,6) ; Addm parent
 I '$D(^TIU(8925,ADDMPRNT,0)) S ADDMPRNT=0
 I ADDMPRNT D
 . S TIUPRNT=ADDMPRNT
 E  D
 . S IDPRNT=+$G(^TIU(8925,TIUDA,21)) ; ID parent
 . I '$D(^TIU(8925,IDPRNT,0)) S IDPRNT=0
 . I IDPRNT D
 . . S TIUPRNT=IDPRNT
 Q TIUPRNT
 ;
ASKRNG(STDT,ENDT) ;Prompt for entry date range
 ; Input  -- None
 ; Output -- 1=Successful and 0=Failure
 ;           STDT  Start Date
 ;           ENDT  End Date
 N DIRUT,DTOUT,DUOUT,Y
 W !!,"Please specify an Entry Date Range:",!
 S STDT=+$$READ^TIUU("DA^:DT:E"," Start Entry Date: ")
 I $D(DIRUT)!(STDT'>0) G ASKRNGQ
 S ENDT=+$$READ^TIUU("DA^"_STDT_":DT:E","Ending Entry Date: ")_"."_235959
 I $D(DIRUT)!(ENDT'>0) G ASKRNGQ
 S Y=1
ASKRNGQ Q +$G(Y)
DHDR(TIUFP,TIUSTDT,TIUENDT) ;
 ;DIVISION HEADER
 N TIUR,TIURNG,TIUINST
 S TIUPG=(+$G(TIUPG))+1
 D DT^DILF("ET","NOW",.TIUR)
 S TIURNG=$$FMTE^XLFDT(TIUSTDT)_" thru "_$$FMTE^XLFDT(TIUENDT)
 S TIUINST=$S(TIUIFP:$P($$NS^XUAF4(TIUIFP),U),1:"ALL DIVISIONS")
 W @IOF,"Pending Additional Signature Documents for "_TIUINST
 W " on "_$$FMTE^XLFDT($$NOW^XLFDT)
 W !,?10,TIURNG,?70,"Page: "_+$G(TIUPG)
 I TIURPT'="F" D
 . W !,"------------------------------------------------------------------------------"
 I TIURPT="F" D
 . W !,"------------------------------------------------------------------------------------------------------------------------------------"
 . W !,"IDENT. SIGNER",?17,"PATIENT",?27,"STATUS",?35,"ENTRY DATE"
 . W ?54,"DOCUMENT TITLE",?81,"DOCUMENT IEN"
 . W !,"------------------------------------------------------------------------------------------------------------------------------------"
 Q
SHDR(TIUSVC) ;
 ; SERVICE HEADER
 W !!?10,"SERVICE: ",TIUSVC
 Q
PRINT ;
 N TIUPG,TIUIFP,TIUOUT,TIUTOT
 S (TIUPG,TIUIFP,TIUOUT,TIUTOT)=0
 F  S TIUIFP=$O(^TMP("TIUD",$J,TIUIFP)) Q:'TIUIFP!(TIUOUT)  D
 . N TIUSVC,TIUDCNT
 . S (TIUSVC,TIUDCNT)=0
 . D DHDR(TIUIFP,TIUSTDT,TIUENDT)
 . F  S TIUSVC=$O(^TMP("TIUD",$J,TIUIFP,TIUSVC)) Q:TIUSVC=""!(TIUOUT)  D
 . . N TIUAS,TIUSVCNT
 . . S (TIUAS,TIUSVCNT)=0
 . . I $Y>(IOSL-5) D ASK Q:TIUOUT  D DHDR(TIUIFP,TIUSTDT,TIUENDT)
 . . I TIURPT="F" D SHDR(TIUSVC)
 . . F  S TIUAS=$O(^TMP("TIUD",$J,TIUIFP,TIUSVC,TIUAS)) Q:TIUAS=""!(TIUOUT)  D
 . . . N TIUEDT
 . . . S TIUEDT=""
 . . . F  S TIUEDT=$O(^TMP("TIUD",$J,TIUIFP,TIUSVC,TIUAS,TIUEDT)) Q:'TIUEDT!(TIUOUT)  D
 . . . . N TIUDA
 . . . . S TIUDA=^TMP("TIUD",$J,TIUIFP,TIUSVC,TIUAS,TIUEDT)
 . . . . I TIURPT="F" D PRNTITEM(TIUDA,TIUAS,TIUEDT)
 . . . . I $Y>(IOSL-5) D ASK Q:TIUOUT  D DHDR(TIUIFP,TIUSTDT,TIUENDT)
 . . . . S TIUSVCNT=TIUSVCNT+1,TIUDCNT=TIUDCNT+1
 . . W !,"  Totals for Service   ",TIUSVC,": ",?55,TIUSVCNT
 . . I $Y>(IOSL-5) D ASK Q:TIUOUT  D DHDR(TIUIFP,TIUSTDT,TIUENDT)
 . Q:TIUOUT
 . N TIUDVSTR S TIUDVSTR=$E($P($$NS^XUAF4(TIUIFP),U),1,25)
 . W !,"Totals for Division    ",TIUDVSTR,": ",?55,TIUDCNT
 . I $O(^TMP("TIUD",$J,TIUIFP)) D ASK Q:TIUOUT
 . S TIUTOT=TIUTOT+TIUDCNT
 Q:TIUOUT
 W !,"Totals for all Divisions: ",?55,TIUTOT
 Q
PRNTITEM(TIUDA,TIUAS,TIUEDT) ;
 N TIUPRNT,TIUPAT,TIUSTAT,TIUTYP,TIUD0,TIUD12,TIULST4,TIUDATE
 S TIUPRNT=$$PRNT(TIUDA)
 S TIUD0=$G(^TIU(8925,TIUDA,0))
 S TIULST4=$E($$GET1^DIQ(2,$G(TIUPAT),.09),6,9)
 S TIUPAT=$$PATPRNT($P($G(TIUD0),U,2))
 S TIUSTAT=$P($G(TIUD0),U,5)
 S TIUSTAT=$S(TIUSTAT:$E($$EXTERNAL^DILFD(8925,.05,"",TIUSTAT),1,11),1:"UNKNOWN")
 S TIUSTAT=$$STATXFER(TIUSTAT)
 S TIUTYP=+TIUD0
 S TIUTYP=$E($P($G(^TIU(8925.1,TIUTYP,0)),U),1,25)
 S TIUDATE=$$FMTE^XLFDT(TIUEDT,2)
 W !,TIUAS,?17,$G(TIUPAT),?27," "_TIUSTAT,?35,$G(TIUDATE)
 W ?54,$G(TIUTYP),?81,TIUDA
 I +$G(TIUPRNT) W " PARENT = "_TIUPRNT
 Q
ASK ;
 I IO=IO(0),$E(IOST)="C" D
 . W ! N DIR,Y S DIR(0)="E" D ^DIR K DIR
 . I Y=""!(Y=0) S TIUOUT=1
 Q
STATXFER(TIUSTAT) ;format a small status string
 I TIUSTAT="COMPLETED"!(TIUSTAT="completed") Q "com"
 I TIUSTAT="UNSIGNED"!(TIUSTAT="unsigned") Q "uns"
 I TIUSTAT="UNCOSIGNED"!(TIUSTAT="uncosigned") Q "uncos"
 I TIUSTAT="UNDICTATED"!(TIUSTAT="undictated") Q "undic"
 I TIUSTAT="UNTRANSCRIBED"!(TIUSTAT="untranscribed") Q "untr"
 I TIUSTAT="UNRELEASED"!(TIUSTAT="unreleased") Q "unrel"
 I TIUSTAT="UNVERIFIED"!(TIUSTAT="unverified") Q "unver"
 I TIUSTAT="AMENDED"!(TIUSTAT="amended") Q "amend"
 Q "???"
PATPRNT(TIUPAT) ; format patient as initials and then last 6 SSN
 N PAT,LST4,INIT
 I 'TIUPAT Q ""
 S PAT=$$EXTERNAL^DILFD(8925,.02,"",TIUPAT)
 S LST4=$E($$GET1^DIQ(2,$G(TIUPAT),.09),4,9)
 S INIT=$E($P(PAT,",",2))_$E($P(PAT,","))
 Q INIT_LST4
