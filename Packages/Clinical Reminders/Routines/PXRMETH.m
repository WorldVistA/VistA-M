PXRMETH ; SLC/PJH - Reminder Extract History ;10/11/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;Main entry point for PXRM EXTRACT HISTORY
START(EDIEN) ;
 ;EDIEN is the extract definition IEN.
 N VALMBCK,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 ;Details of last run
 N DATA,NPERIOD,NSDATE,NTAS,PXRMVIEW
 S DATA=$G(^PXRM(810.2,EDIEN,0))
 S NPERIOD=$P(DATA,U,6),NSDATE=$P(DATA,U,7)
 ;Default view is in date created order
 S PXRMVIEW="D"
 S X="IORESET"
 D ENDR^%ZISS
 S VALMCNT=0
 D EN^VALM("PXRM EXTRACT HISTORY")
 Q
 ;
DELETE ;Delete an extract, called by protocol PXRM EXTRACT SUMMARY DELETE.
 N CLASS,IEN,IENLIST,IND
 S IENLIST=$$LMSEL
 F IND=1:1:$L(IENLIST,U) D
 .S IEN=$P(IENLIST,U,IND)
 .D DELETE^PXRMETXU(IEN)
 ;Rebuild workfile
 D BLDLIST^PXRMETH1(EDIEN)
 ;Refresh
 S VALMBCK="R"
 Q
 ;
ENTRY ;Entry code
 D BLDLIST^PXRMETH1(EDIEN),XQORM
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMETH",$J)
 K ^TMP("PXRMETHH",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
EXTRACT(EDIEN) ;Run Extract/Transmission
 ;Reset screen mode
 W IORESET
 ;Refresh on exit
 S VALMBCK="R"
 ;
 ;Get details from parameter file
 N ANS,DATA,DUOUT,DTOUT,EDATE,EXSUMPUG,FREQ,MODE
 N NAME,NAT,NEXT,PLISTPUG,RTN,REPL,STATUS,SNEXT,TEXT,XMIT
 S DATA=$G(^PXRM(810.2,EDIEN,0))
 S NAT=$P($G(^PXRM(810.2,EDIEN,100)),U)
 ;Determine Extract Name and Frequency
 S NAME=$P(DATA,U),FREQ=$P(DATA,U,3),NEXT=$P(DATA,U,6),RTN="PXRMETX"
 ;Save next scheduled extract
 S SNEXT=NEXT
 ;Select extract period
EXSEL D SELECT(FREQ,.NEXT) Q:$D(DUOUT)!$D(DTOUT)
 ;Warn if period is still open
 D WARN(NEXT,.STATUS)
 ;Option to continue
 S TEXT="Are you sure you want to run a "_NAME_" extract for "_$TR(NEXT,"/"," ")
SURE ;
 S ANS=$$ASKYN^PXRMEUT("N",TEXT,RTN,1) Q:$D(DUOUT)!$D(DTOUT)  Q:'ANS
 ;Purge options
PLIST ;
 S PLISTPUG="N" D ASK^PXRMXD(.PLISTPUG,"Purge Patient List after 5 years?: ",5)
 G:$D(DUOUT) SURE Q:$D(DTOUT)
 S EXSUMPUG="N" D ASK^PXRMXD(.EXSUMPUG,"Purge Extract Summary after 5 years?: ",5)
 G:$D(DUOUT) PLIST Q:$D(DTOUT)
 ;Option to transmit
 S TEXT="Transmit extract results to AAC"
 I NAT="N" S XMIT=$$ASKYN^PXRMEUT("N",TEXT,RTN,3) Q:$D(DUOUT)!$D(DTOUT)
 E  S XMIT=0
 ;Option to replace scheduled run
 S REPL=0
 I XMIT,SNEXT=NEXT,STATUS="COMPLETE" D  Q:$D(DUOUT)!$D(DTOUT)
 .S TEXT="Does this extract replace the scheduled extract"
 .S REPL=$$ASKYN^PXRMEUT("N",TEXT,RTN,4) Q:$D(DUOUT)!$D(DTOUT)
 ;
 ;Note that the manual extract does not update 810.2
 ;exept if the selected period is the same as the scheduled
 ;period AND this period is complete
 ;
 ;Default is to extract and transmit and not update 810.2
 S MODE=2 I 'XMIT S MODE=3
 ;Update 810.2 if this extract is for current completed period
 I REPL S MODE=0 I 'XMIT S MODE=1
 ;
 ;Extract/transmission run
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTDESC="Reminder Extract "_NAME
 S ZTRTN="RUN^PXRMETX(EDIEN,NEXT,MODE,EXSUMPUG)"
 S ZTSAVE("EDIEN")=""
 S ZTSAVE("MODE")=""
 S ZTSAVE("NEXT")=""
 S ZTSAVE("PLISTPUG")=""
 S ZTSAVE("EXSUMPUG")=""
 S ZTIO=""
 ;
 ;Select and verify start date/time for task
 N DIR,DTOUT,DUOUT,MINDT,SDTIME,STIME,X,Y
 S MINDT=$$NOW^XLFDT
 W !,"Queue a "_ZTDESC_" for "_NEXT
 S DIR("A",1)="Enter the date and time you want the job to start."
 S DIR("A",2)="It must be after "_$$FMTE^XLFDT(MINDT,"5Z")
 S DIR("A")="Start the task at: "
 S DIR(0)="DAU"_U_MINDT_"::RSX"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q
 S SDTIME=Y
 ;
 ;Put the task into the queue.
 S ZTDTH=SDTIME
 D ^%ZTLOAD
 W !,"Task number ",ZTSK," queued." H 2
 S VALMBCK="Q"
 Q
 ;
HDR ; Header code
 N VIEW
 S VIEW=$S(PXRMVIEW="D":"Creation Date Order",1:"Extract Period Order")
 S VALMHDR(2)="          Extract Name: "_$P($G(^PXRM(810.2,EDIEN,0)),U)
 S VALMHDR(3)="   Next Extract Period: "_NPERIOD
 S VALMHDR(4)="      Scheduled to Run: "_$$FMTE^XLFDT(NSDATE,"5Z")
 S VALMHDR(4)=$$LJ^XLFSTR(VALMHDR(4),45)_"    View: "_VIEW
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HLP ;Help code
 N ORU,ORUPRMT,SUB,XQORM
 S SUB="PXRMETHH"
 D EN^VALM("PXRM EXTRACT HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 Q
 ;
LMSEL() ;Return selection list
 N IENLIST,IND,VALMY,XIEN
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q ""
 S PXRMDONE=0,IENLIST=""
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the ien.
 .S XIEN=^TMP("PXRMETH",$J,"SEL",IND)
 .S IENLIST=$S(IENLIST'="":IENLIST_U_XIEN,1:XIEN)
 Q IENLIST
 ;
PEXIT ;PXRM EXCH MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 D XQORM
 Q
 ;
SELECT(FREQ,SEL) ;Select extract period
 N BDATE,EDATE,DA,DIE,DIK,DIR,DR,FDATE,VALID,X
 ;Get the new name.
 F  D  Q:$D(DTOUT)!$D(DUOUT)  Q:SEL]""
 .S DIR("A")="Select EXTRACT PERIOD "
 .I FREQ="M" D
 ..S DIR("A")=DIR("A")_"(Mnn/yyyy)"
 ..S DIR(0)="F"_U_"7:8"_U_"K:'$$VALID^PXRMETH(FREQ,X) X"
 .I FREQ="Q" D
 ..S DIR("A")=DIR("A")_"(Qnn/yyyy)"
 ..S DIR(0)="F"_U_"7:7"_U_"K:'$$VALID^PXRMETH(FREQ,X) X"
 .I FREQ="Y" D
 ..S DIR("A")=DIR("A")_"(yyyy)"
 ..S DIR(0)="N"_U_"2000:2050"_U_"K:(X'?4N) X"
 .;Default is next period
 .S DIR("B")=NEXT
 .W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 .;Calculate beginning and end dates for period
 .S Y=$$UP^XLFSTR(Y) D CALC^PXRMEUT(Y,.BDATE,.EDATE)
 .;Abort if period has not started
 .I $$FMDIFF^XLFDT(BDATE,$$NOW^XLFDT)>0 D   Q
 ..S FDATE=$$FMTE^XLFDT(BDATE,5)
 ..W !,"ERROR -This period does not start until "_FDATE,*7
 .S SEL=Y
 Q
 ;
TLIST ;Extract summary display
 N IEN,IENLIST,IND
 S IENLIST=$$LMSEL
 F IND=1:1:$L(IENLIST,U) D
 .S IEN=$P(IENLIST,U,IND)
 .D START^PXRMETT(IEN)
 .S VALMBCK="R"
 S VALMBCK="R"
 Q
 ;
TRANS ;Run Transmission
 N IEN,IENLIST,IND
 S IENLIST=$$LMSEL
 F IND=1:1:$L(IENLIST,U) D
 .S IEN=$P(IENLIST,U,IND)
 .I $P($G(^PXRMXT(810.3,IEN,100)),U)'="N" D  Q
 ..W !,"Local extracts cannot be transmitted to AAC." H 2
 .;Transmit extract summary
 .N ANS,DUOUT,DTOUT,RTN,TEXT
 .S TEXT="Transmit this extract to AAC",ANS="",RTN="PXRMETH"
 .S ANS=$$ASKYN^PXRMEUT("N",TEXT,RTN,3) Q:$D(DUOUT)!$D(DTOUT)
 .I ANS D TRANS^PXRMETX(IEN)
 ;
 ;Rebuild workfile
 D BLDLIST^PXRMETH1(EDIEN)
 ;Refresh
 S VALMBCK="R"
 Q
 ;
TRHIST ;Transmission History
 N IEN,IENLIST,IND
 S IENLIST=$$LMSEL
 F IND=1:1:$L(IENLIST,U) D
 .S IEN=$P(IENLIST,U,IND)
 .D START^PXRMETHL(IEN)
 S VALMBCK="R"
 Q
 ;
VALID(FREQ,INP) ;Validate Period input
 W !
 N PERIOD,YEAR
 ;Convert to upper case
 S INP=$$UP^XLFSTR(INP)
 ;General format
 I $E(INP)'=FREQ D EN^DDIOL("Format should be "_FREQ_"nn/yyyy") Q 0
 S PERIOD=$P(INP,"/"),YEAR=$P(INP,"/",2)
 S PERIOD=$P(PERIOD,FREQ,2)
 ;All runs
 I (YEAR<2000)!(YEAR>2050) D EN^DDIOL("Year should be in range 2000-2050") Q 0
 ;Quarterly run
 I FREQ="Q",(PERIOD>4)!(PERIOD<1) D EN^DDIOL("Quarter should be in range 1-4") Q 0
 ;Monthly run
 I FREQ="M",(PERIOD>12)!(PERIOD<1) D EN^DDIOL("Month should be in range 1-12") Q 0
 ;Otherwise
 Q 1
 ;
VIEW ;Select view
 W IORESET
 S VALMBCK="R"
 N X,Y,CODE,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"D:Sort by Creation Date;"
 S DIR(0)=DIR(0)_"P:Sort by Extract Period;"
 S DIR("A")="TYPE OF VIEW"
 S DIR("B")=$S(PXRMVIEW="P":"D",1:"P")
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 ;BOOKMARK - HELP NEEDS MOVING
 S DIR("??")=U_"D HELP^PXRMSEL2(3)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 ;Change display type
 S PXRMVIEW=Y
 ;
 ;Rebuild Workfile
 D BLDLIST^PXRMETH1(EDIEN),HDR
 Q
 ;
WARN(NEXT,STATUS) ;Warn if period is not completed
 N BDATE,EDATE,FDATE
 ;Calculate beginning and end dates for period
 D CALC^PXRMEUT(NEXT,.BDATE,.EDATE)
 ;No warning if period end date is a prior date
 I $$FMDIFF^XLFDT($$NOW^XLFDT,EDATE)>0 S STATUS="COMPLETE" Q
 ;Else Format date
 S FDATE=$$FMTE^XLFDT(EDATE,5),STATUS="INCOMPLETE"
 ;And Warn that period end date is a future date
 W !!,"WARNING -This period is not complete until "_FDATE
 Q
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM EXTRACT HISTORY SELECT ENTRY",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 Q
 ;
XSEL ;PXRM EXTRACT HISTORY SELECT ENTRY validation
 N SEL,PXRMSIEN
 S SEL=$P(XQORNOD(0),"=",2)
 ;Remove trailing ,
 I $E(SEL,$L(SEL))="," S SEL=$E(SEL,1,$L(SEL)-1)
 ;Invalid selection
 I SEL["," D  Q
 .W $C(7),!,"Only one item number allowed." H 2
 .S VALMBCK="R"
 I ('SEL)!(SEL>VALMCNT)!('$D(@VALMAR@("SEL",SEL))) D  Q
 .W $C(7),!,SEL_" is not a valid item number." H 2
 .S VALMBCK="R"
 ;
 ;Get the list ien.
 ;S PXRMSIEN=^TMP("PXRMETH",$J,"IDX",SEL,SEL)
 S PXRMSIEN=^TMP("PXRMETH",$J,"SEL",SEL)
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Options
 N X,Y,DIR,OPTION K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="SBM"_U_"DE:Delete Extract;"
 S DIR(0)=DIR(0)_"ES:Extract Summary;"
 S DIR(0)=DIR(0)_"MT:Manual Transmission;"
 S DIR(0)=DIR(0)_"TH:Transmission History;"
 S DIR("A")="Select Action"
 S DIR("B")="ES"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMETH1(1)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) S VALMBCK="R" Q
 S OPTION=Y
 ;
 ;Delete an extract
 I OPTION="DE" D
 .D DELETE^PXRMETXU(PXRMSIEN)
 .;Rebuild workfile
 .D BLDLIST^PXRMETH1(PXRMSIEN)
 .;Refresh
 .S VALMBCK="R"
 ;
 ;Display Extract Summary
 I OPTION="ES" D START^PXRMETT(PXRMSIEN)
 ;
 ;Transmission option
 I OPTION="MT" D
 .N ANS,DUOUT,DTOUT,RTN,TEXT
 .I $P($G(^PXRMXT(810.3,PXRMSIEN,100)),U)'="N" D  Q
 ..W !,"Local extracts cannot be transmitted to AAC" H 2 Q
 .S TEXT="Transmit this extract to AAC",ANS="",RTN="PXRMETH"
 .S ANS=$$ASKYN^PXRMEUT("N",TEXT,RTN,3) Q:$D(DUOUT)!$D(DTOUT)
 .I ANS D TRANS^PXRMETX(PXRMSIEN)
 ;
 ;Transmission History
 I OPTION="TH" D START^PXRMETHL(PXRMSIEN)
 ;
 S VALMBCK="R"
 Q
 ;
