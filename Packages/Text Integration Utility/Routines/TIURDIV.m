TIURDIV ; SLC/JAK - Review unsig/uncosig Documents by DIVISION ;12/01/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**113**;Jun 20, 1997
 ; Multidivisional Enhancements - from BUF/DCN - modified by SLC/JAK
 ;
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
 I TIURPT="F" W !!,"This report must be sent to a 132-column device.",!
 ;
DEV ; Device selection
 S %ZIS="Q" W ! D ^%ZIS I POP K POP G EXIT
 I TIURPT="F",IOM'>131 W !!,"You must select a 132-column device." G DEV
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="BUILD^TIURDIV"
 . S ZTSAVE("TIUDI(")="",ZTSAVE("TIURPT")=""
 . S ZTSAVE("TIUSTDT")="",ZTSAVE("TIUENDT")=""
 . S ZTSAVE("TIUSVCS")="",ZTSAVE("TIUSVCS(")=""
 . S ZTDESC="TIU UNSIG/UNCOSIG DOCS BY DIV"
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
 D PRINT(TIUSTDT,TIUENDT)
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
 S TIUTP=0
 F  S TIUTP=$O(^TIU(8925,"ADIV",TIUIFP,TIUTP)) Q:+TIUTP'>0  D
 . S TIUS=4
 . F  S TIUS=$O(^TIU(8925,"ADIV",TIUIFP,TIUTP,TIUS)) Q:+TIUS'>0!(+TIUS>6)  D
 . . S TIUJ=0
 . . F  S TIUJ=$O(^TIU(8925,"ADIV",TIUIFP,TIUTP,TIUS,TIUJ)) Q:+TIUJ'>0  D
 . . . S TIUDA=0
 . . . F  S TIUDA=$O(^TIU(8925,"ADIV",TIUIFP,TIUTP,TIUS,TIUJ,TIUDA)) Q:+TIUDA'>0  D
 . . . . D ADDELMNT(TIUDA,TIUSTDT,TIUENDT,.TIUSVCS)
 Q
 ;
ADDELMNT(TIUDA,TIUSTDT,TIUENDT,TIUSVCS) ; Add each element to the list
 ; Input  -- TIUDA   TIU DOCUMENT file (#8925) IEN
 ;           TIUSTDT Start Date
 ;           TIUENDT End Date
 ;           TIUSVCS Service Selection Array
 ; Output -- None
 N TIUAU,TIUD12,TIUEDT,TIUIFP,TIUSVC
 S TIUD12=$G(^TIU(8925,TIUDA,12))
 S TIUEDT=+$P(TIUD12,U),TIUAU=+$P(TIUD12,U,2),TIUIFP=+$P(TIUD12,U,12)
 ;Check Date Range
 I TIUEDT,TIUEDT>TIUSTDT,TIUEDT<TIUENDT D
 . S TIUSVC=$$PROVSVC^TIULV(TIUAU)
 . ;Check Service
 . I $G(TIUSVCS)="ALL"!($D(TIUSVCS(+TIUSVC))) D
 . . S TIUAU=$$PERSNAME^TIULC1(TIUAU)
 . . I $P(TIUSVC,U,2)]"" D
 . . . S TIUSVC=$P(TIUSVC,U,2)
 . . E  D
 . . . S TIUSVC="UNKNOWN"
 . . I TIUAU'="UNKNOWN" S TIUAU=$$NAME^TIULS(TIUAU,"LAST, FI MI")
 . . S ^TMP("TIUD",$J,TIUIFP,TIUSVC,TIUAU,TIUEDT)=TIUDA
 Q
 ;
PRINT(TIUSTDT,TIUENDT) ; Display/print the output
 ; Input  -- TIUSTDT Start Date
 ;           TIUENDT End Date
 ; Output -- None
 N GTCT,ICT,SCT,TIUAU,TIUDA,TIUECS,TIUEDT
 N TIUIFP,TIULST4,TIUOUT,TIUPG,TIUPT,TIUSVC,TIUTP
 S (GTCT(5),GTCT(6),TIUIFP,TIUPG,TIUOUT)=0
 I '$D(^TMP("TIUD",$J)) W !!,"NO Unsigned/Uncosigned Documents!!" Q
 F  S TIUIFP=$O(^TMP("TIUD",$J,TIUIFP)) Q:TIUIFP=""!(TIUOUT)  D HDR(TIUIFP,TIUSTDT,TIUENDT) D
 . S (ICT(TIUIFP,5),ICT(TIUIFP,6))=0 S TIUSVC=""
 . F  S TIUSVC=$O(^TMP("TIUD",$J,TIUIFP,TIUSVC)) Q:TIUSVC=""!(TIUOUT)  D
 . . I $Y>(IOSL-5) D ASK Q:TIUOUT  D HDR(TIUIFP,TIUSTDT,TIUENDT)
 . . D FHDR(TIUSVC):TIURPT="F"
 . . S (SCT(TIUIFP,TIUSVC,5),SCT(TIUIFP,TIUSVC,6))=0 S TIUAU=""
 . . F  S TIUAU=$O(^TMP("TIUD",$J,TIUIFP,TIUSVC,TIUAU)) Q:TIUAU=""!(TIUOUT)  D
 . . . S TIUEDT=0
 . . . F  S TIUEDT=$O(^TMP("TIUD",$J,TIUIFP,TIUSVC,TIUAU,TIUEDT)) Q:TIUEDT=""!(TIUOUT)  D
 . . . . S TIUDA=+$G(^TMP("TIUD",$J,TIUIFP,TIUSVC,TIUAU,TIUEDT))
 . . . . D PRTELMNT(TIUDA,TIUIFP,TIUSVC,TIUAU,TIUEDT,TIUSTDT,TIUENDT)
 . . . . ;
 . . Q:TIUOUT
 . . I $Y>(IOSL-5) D ASK Q:TIUOUT  D HDR(TIUIFP,TIUSTDT,TIUENDT),FHDR(TIUSVC):TIURPT="F"
 . . W !!," Totals for Service: ",$E(TIUSVC,1,25),"---"
 . . W " UNSIGNED: ",$G(SCT(TIUIFP,TIUSVC,5))
 . . W "  UNCOSIGNED: ",$G(SCT(TIUIFP,TIUSVC,6))
 . Q:TIUOUT
 . I $Y>(IOSL-5) D ASK Q:TIUOUT  D HDR(TIUIFP,TIUSTDT,TIUENDT)
 . W !!,"Totals for Division: ",$E($P($$NS^XUAF4(TIUIFP),U),1,25),"---"
 . W " UNSIGNED: ",$G(ICT(TIUIFP,5))
 . W "  UNCOSIGNED: ",$G(ICT(TIUIFP,6))
 . S GTCT(5)=GTCT(5)+ICT(TIUIFP,5),GTCT(6)=GTCT(6)+ICT(TIUIFP,6)
 . D ASK Q:TIUOUT
 Q:TIUOUT
 S TIUIFP="ALL" D HDR(TIUIFP,TIUSTDT,TIUENDT)
 W !!,"GRAND Totals (All Divisions)--- UNSIGNED: ",+$G(GTCT(5))
 W "  UNCOSIGNED: ",+$G(GTCT(6))
 Q
PRTELMNT(TIUDA,TIUIFP,TIUSVC,TIUAU,TIUEDT,TIUSTDT,TIUENDT) ; Print each element
 ; Input  -- TIUDA   TIU DOCUMENT file (#8925) IEN
 ;           TIUIFP  INSTITUTION file (#4) IEN
 ;           TIUSVC  SERVICE/SECTION file (#49) NAME
 ;           TIUAU   AUTHOR/DICTATOR's NAME
 ;           TIUEDT  Inverse REFERENCE DATE
 ;           TIUSTDT Start Date
 ;           TIUENDT End Date
 ; Output -- None
 N TIUD0,TIUD12,TIUS
 S TIUD0=$G(^TIU(8925,TIUDA,0)),TIUD12=$G(^TIU(8925,TIUDA,12))
 S TIUS=+$P(TIUD0,U,5) I TIUS'=5,TIUS'=6 Q
 S ICT(TIUIFP,TIUS)=ICT(TIUIFP,TIUS)+1
 S SCT(TIUIFP,TIUSVC,TIUS)=SCT(TIUIFP,TIUSVC,TIUS)+1
 I $Y>(IOSL-5) D ASK Q:TIUOUT  D HDR(TIUIFP,TIUSTDT,TIUENDT),FHDR(TIUSVC):TIURPT="F"
 I TIURPT="F" D
 . S TIUPT=+$P(TIUD0,U,2),TIULST4=$E($$GET1^DIQ(2,TIUPT,.09),6,9)
 . S TIUTP=+$P(TIUD0,U),TIUECS=+$P(TIUD12,U,8)
 . W !,$G(TIUAU)
 . W ?17,$S(TIUPT:$E($$EXTERNAL^DILFD(8925,.02,"",TIUPT),1,15),1:"UNK")
 . W ?34,$S(TIULST4]"":$G(TIULST4),1:"UNK")
 . W ?41,$E($$EXTERNAL^DILFD(8925,.05,"",TIUS),1,10)
 . W ?53,$S(TIUEDT>0:$$FMTE^XLFDT(TIUEDT,2),1:"UNK")
 . W ?71,$G(TIUDA)
 . W ?85,$S(TIUTP:$E($$EXTERNAL^DILFD(8925,.01,"",TIUTP),1,15),1:"UNK")
 . W ?102,$S(TIUECS:$E($$EXTERNAL^DILFD(8925,1208,"",TIUECS),1,15),1:"")
 . W ?119,$$PRNT(TIUDA)
 Q
ASK ; End of page
 I IO=IO(0),$E(IOST)="C" D
 . W ! N DIR,Y S DIR(0)="E" D ^DIR K DIR
 . I Y=""!(Y=0) S TIUOUT=1
 Q
HDR(TIUIFP,TIUSTDT,TIUENDT) ; Page (Division) Header
 ; Input   -- TIUIFP  INSTITUTION file (#4) IEN
 ;            TIUSTDT Start Date
 ;            TIUENDT End Date
 ; Output  -- None
 N LNE,TIUR,TIUINST,TIURNG
 S TIUPG=(+$G(TIUPG))+1
 D DT^DILF("ET","NOW",.TIUR)
 S TIURNG=$$FMTE^XLFDT(TIUSTDT)_" thru "_$$FMTE^XLFDT(TIUENDT)
 S TIUINST=$S(TIUIFP:$P($$NS^XUAF4(TIUIFP),U),1:"ALL DIVISIONS")
 W @IOF,?26,"Unsigned and Uncosigned Documents "_TIURNG,?(IOM-10)
 W "Page ",+$G(TIUPG),!,"PRINTED:",?26,"for ",TIUINST,!,TIUR(0)
 W ! S LNE="",$P(LNE,"-",(IOM-1))="" W LNE
 I TIURPT="F" D
 . W !,"AUTHOR",?17,"PATIENT",?34,"LAST4",?41,"STATUS"
 . W ?53,"ENTRY DATE",?71,"IEN",?85,"DOC TYPE"
 . W ?102,"EXP COSIGNER",?119,"PARENT IEN",!,LNE
 Q
FHDR(TIUSVC) ; Service Header
 ; Input   -- TIUSVC  SERVICE/SECTION file (#49) NAME
 ; Output  -- None
 W !!?10,"SERVICE: ",TIUSVC
 Q
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
