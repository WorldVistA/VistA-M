RCTCSJR ;ALBANY/LEG-CS DEBT REFERRAL REJECT REPORTING ;07/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301,315,339**;Mar 20, 1995;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
ECLIST ; prints IAI Error Codes List
 S DIC="^RC(348.5,",BY=.01
 S (FR,TO)=""
 S FLDS="[TCS IAI ERROR CODES LIST]"
 S DHD="TCS IAI ERROR CODES LIST"
 S DIOBEG="W !!"
 D EN1^DIP
 Q
 ; 
RJRPT ; for CS REJECT REPORT processing
 D INIT S STOP=0
 D PROMPTS Q:POP
 Q:STOP
 D HEADING,GETRECS,PRTRECS
 K %ZIS,ACTN,ASCDES,BILLID,BILLIEN,BLNKS,BY,CD,CDIEN,CDREC,CDSH,CHDR,CHDRS,CNTR,COLDASH,COLHDRS,COLWIDTH1,COLWIDTH2,COLWIDTH3,CWID,DASH,DATA,DATAITMS,DATE,DEBTIDX,DEBTIEN,DEBTOR,DEBTREC,DEBTREF,DEFAULT,DESC,DHD,DIOBEG
 K DTFRM,DTFRMTO,DTFROM,DTTO,ECDS,EXCEL,FIELD,FLDS,FR,GROUPBD,HDTITLE,I,INCLUDE,INDATE,L,LEV1,LEV2,LEV3,LEV4,LN,OUTDATE,PAGE,POP,QUIT,RPTITEMS,RPTREC,SEQ,SRC,SSN,STOP,STR,TO,TYP,UPDN,RECW1,RECW2,EXCOLH,EXSSN,CDREC1
 Q
 ;
INIT ;
 K ^TMP("RCTCSJR",$J),REC
 S DASH="",$P(DASH,"-",78)=""  ; (as per PRCA*4.5*315)
 S BLNKS="",$P(BLNKS," ",71)=""
 S DATAITMS="DATE^SRC^ECD(1)^ECD(2)^ECD(3)^ECD(4)^ECD(5)^ECD(6)^ECD(7)^ECD(8)^ECD(9)^TYP^ACTN"
 S RPTITEMS="BILLID^DEBTOR^SSN^TYP^ACTN^OUTDATE^SRC^ECDS"
 I $G(EXCEL) S RPTITEMS="BILLID^DEBTOR^EXSSN^TYP^ACTN^OUTDATE^SRC^ECDS^RECDET"  ;PRCA*4.5*315
 Q
 ;
GETRECS ;
 N PC,RECDET
 K ^TMP("RCTCSJR",$J)
 S (DATE,DTFRM)=$$FMADD^XLFDT(+$P(DTFRMTO,U,2),-1),DTTO=$P(DTFRMTO,U,3)
 F  S DATE=$O(^PRCA(430,"AB",DATE)),BILLIEN=0 Q:DATE>DTTO!'DATE  D  ;
 . S INDATE=DATE,OUTDATE=$$FMTE^XLFDT(DATE,"2Z")  ;Standardize dates (as per PRCA*4.5*315)
 . F  S BILLIEN=$O(^PRCA(430,"AB",DATE,BILLIEN)),SEQ=0 Q:BILLIEN=""  D  ;
 .. S BILLID=$P(^PRCA(430,BILLIEN,0),U)
 .. S DEBTIEN=$P(^PRCA(430,BILLIEN,0),U,9) ;33460
 .. S DEBTIDX=$P($G(^RCD(340,DEBTIEN,0)),U) ;777706050;DPT(
 .. Q:$G(DEBTIDX)=""
 .. S DEBTREF="^"_$P(DEBTIDX,";",2)_$P(DEBTIDX,";")_",0)"
 .. S DEBTREC=@(DEBTREF)
 .. S DEBTOR=$E($P(DEBTREC,U),1,19),SSN=$E($$SSN^RCFN01($P($G(^RCD(340,DEBTIEN,0)),"^")),6,9)  ;Last 4 of SSN only (as per PRCA*4.5*315)
 .. S SSN=$E($$SSN^RCFN01($P($G(^RCD(340,DEBTIEN,0)),"^")),6,9)  ;Last 4 of SSN if Excel PRCA*4.5*315
 .. S EXSSN=$E(DEBTOR)_$S(SSN'="":SSN,1:"    ")  ; 1st init last name, last 4 of SSN if not Excel PRCA*4.5*315
 .. F  S SEQ=$O(^PRCA(430,"AB",DATE,BILLIEN,SEQ)) Q:SEQ=""  D  ;
 ... S DATA=$G(^PRCA(430,BILLIEN,18,SEQ,0))
 ... Q:'$L(DATA)  ; in the event the X-REF is out of sync due to test clearing
 ... F PC=2,12,13 S CD=$P(DATA,U,PC),X=$P(DATAITMS,U,PC)_"="""_$S(CD="":CD,PC=2:CD,PC=12:$P($G(^RC(348.7,CD,0)),U),PC=13:$P($G(^RC(348.6,CD,0)),U),1:"")_"""",@X
 ... K ECD
 ... S ECDS=""
 ... F PC=3:1:11 S CD=$P(DATA,U,PC) Q:'$L(CD)  S CD=$S('$D(^RC(348.5,CD,0)):CD,1:$P(^RC(348.5,CD,0),U)) S X="S "_$P(DATAITMS,U,PC)_"="""_CD_"""" D  ;
 .... Q:'$D(^RC(348.5,$P(DATA,U,PC),0))!(CD="ZZ")  ; quits just in case bad error code got thru
 .... X X
 .... S ECDS=ECDS_$S(PC>3:";",1:"")_ECD(PC-2) ;Error codes new delimiter ";"
 ... ;  gets record layout based on RPTTYP and places into RPTTYP sorting sequence
 ... D @RPTTYP ;1=BILL NO.  2=DEBTOR  3=REJECT DATE
 ... Q  ;
 ... ;
 S LEV1="",CNTR=0
 K REC
 S UPDN=$S(ASCDES="D":-1,1:1) ; determines ASCending or DeSCending direction
 F  S LEV1=$O(^TMP("RCTCSJR",$J,"RPT",LEV1),UPDN),LEV2="" Q:LEV1=""  D  ;
 . F  S LEV2=$O(^TMP("RCTCSJR",$J,"RPT",LEV1,LEV2),UPDN),LEV3="" Q:LEV2=""  D  ;
 .. F  S LEV3=$O(^TMP("RCTCSJR",$J,"RPT",LEV1,LEV2,LEV3),UPDN),LEV4="" Q:LEV3=""  D  ;
 ... F  S LEV4=$O(^TMP("RCTCSJR",$J,"RPT",LEV1,LEV2,LEV3,LEV4),UPDN) Q:LEV4=""  D  ;
 .... S RPTREC=^TMP("RCTCSJR",$J,"RPT",LEV1,LEV2,LEV3,LEV4)
 .... I 'EXCEL S SRC=$E(RPTREC,65)
 .... I EXCEL S SRC=$P(RPTREC,U,7)
 .... I INCLUDE'="ALL",INCLUDE'=SRC Q  ; unwanted source
 .... S CNTR=CNTR+1
 .... S REC(CNTR)=$P(RPTREC,";",1,$S(EXCEL:10,1:4))
 .... I EXCEL S RECW1=$E(REC(CNTR),1,70),RECW2=$TR($E(REC(CNTR),71,999),"^","-"),REC(CNTR)=RECW1_RECW2
 .... ;Q:EXCEL  ;     only needs single line string if in Excel format
 .... I 'EXCEL S RECW1=$E(REC(CNTR),1,70),RECW2=$TR($E(REC(CNTR),71,999),"^",";"),REC(CNTR)=RECW1_RECW2
 .... I 'EXCEL,$L($P(RPTREC,";",5,8)) D
 ..... S CNTR=CNTR+1,REC(CNTR)=$E(BLNKS,1,67)_$P(RPTREC,";",5,8)
 .... I 'EXCEL,$L($P(RPTREC,";",9)) D
 ..... S CNTR=CNTR+1,REC(CNTR)=$E(BLNKS,1,67)_$P(RPTREC,";",9)
 .... I GROUPBD="D" D  ;
 ..... K ECD
 ..... S ECDS=$E(RPTREC,68,100)
 ..... F I=1:1:9 S ECD(I)=$P(ECDS,";",I) Q:'$L(ECD(I))  D
 ...... S CD=$P(ECDS,";",I),CDIEN=$O(^RC(348.5,"B",CD,0))
 ...... S (CDREC,CDREC1)="" I CDIEN,$D(^RC(348.5,CDIEN)) S CDREC=^RC(348.5,CDIEN,0),CDREC1=$G(^RC(348.5,CDIEN,1))
 ...... S (X,DESC,RECDET)="  "_CD_" - "_CDREC1
 ...... I $L(DESC)<81 S CNTR=CNTR+1,REC(CNTR)=X
 ...... ;  splits line if > 80 chars
 ...... I $L(DESC)>80 D  ;
 ....... F  S STR=$E(X,1,80) D  Q:'$L(X)  ;
 ........ I $L(X)<81 S CNTR=CNTR+1 S REC(CNTR)=X,X="" Q
 ........ F L=$L(STR):-1:1 I $F(STR," ",L) D  Q  ;
 ......... S CNTR=CNTR+1
 ......... S REC(CNTR)=$E(X,1,L),X=$E(X,L+1,999)
 ......... I $L(X) S X="     "_X
 ......... Q  ;
 M ^TMP("RCTCSJR",$J,"REC")=REC
 Q
 ;
1 ; for report by 1) Bill Number
 S QUIT=0
 I 'EXCEL D  Q:QUIT  ;
 . S RPTREC=""
 . F PC=1:1:7 D  Q:QUIT  ;
 .. S FIELD=$P(RPTITEMS,U,PC)
 .. I PC=7,INCLUDE'="ALL",@FIELD'=INCLUDE S QUIT=1 Q  ;
 .. S RPTREC=RPTREC_$E(@FIELD_BLNKS,1,$P(COLWIDTH1,U,PC))
 . F PC=8 S RPTREC=RPTREC_@$P(RPTITEMS,U,PC)
 I EXCEL S RPTREC=BILLID_U_DEBTOR_U_EXSSN_U_TYP_U_ACTN_U_OUTDATE_U_SRC_U_ECDS  ; PRCA*4.5*315
 S ^TMP("RCTCSJR",$J,"RPT",BILLID,INDATE,DEBTOR,SEQ)=RPTREC
 Q
2 ; for report by 2) Debtor Name
 S QUIT=0
 I EXCEL S RPTREC=DEBTOR_U_BILLID_U_EXSSN_U_TYP_U_ACTN_U_OUTDATE_U_SRC_U_ECDS  ; PRCA*4.5*315
 I 'EXCEL D  Q:QUIT  ;
 . S RPTREC=""
 . F PC=2,1,3:1:7 D  Q:QUIT  ;
 .. S FIELD=$P(RPTITEMS,U,PC)
 .. I PC=7,INCLUDE'="ALL",@FIELD'=INCLUDE S QUIT=1 Q  ;
 .. S RPTREC=RPTREC_$E(@FIELD_BLNKS,1,$P(COLWIDTH2,U,PC))
 . F PC=8 S RPTREC=RPTREC_@$P(RPTITEMS,U,PC)
 S ^TMP("RCTCSJR",$J,"RPT",DEBTOR,BILLID,INDATE,SEQ)=RPTREC
 Q
3 ; for report by 3) CS Reject Date
 S QUIT=0
 I EXCEL S RPTREC=OUTDATE_U_BILLID_U_DEBTOR_U_EXSSN_U_TYP_U_ACTN_U_SRC_U_ECDS  ; PRCA*4.5*315
 I 'EXCEL D  Q:QUIT  ;
 . S RPTREC=""
 . F PC=6,1:1:5,7 D  Q:QUIT  ;
 .. S FIELD=$P(RPTITEMS,U,PC)
 .. I PC=7,INCLUDE'="ALL",@FIELD'=INCLUDE S QUIT=1 Q  ;
 .. S RPTREC=RPTREC_$E(@$P(RPTITEMS,U,PC)_BLNKS,1,$P(COLWIDTH3,U,PC))
 . F PC=8 S RPTREC=RPTREC_@$P(RPTITEMS,U,PC)
 S ^TMP("RCTCSJR",$J,"RPT",INDATE,BILLID,DEBTOR,SEQ)=RPTREC
 Q
QRPT ;if queued
 D HEADING,GETRECS,PRTRECS
 Q
 ;
PRTRECS ; prints report
 S PAGE=0
 K DIRUT,DUOUT,DTOUT
 D HEADING,REJREPH
 S LN=0 F LN=1:1 Q:'$D(^TMP("RCTCSJR",$J,"REC",LN))  D  Q:$D(DIRUT)!$D(DUOUT)!$D(DTOUT)
 . W ^TMP("RCTCSJR",$J,"REC",LN),!
 . ;    check for end of page here, if necessary form feed and print header
 . I $Y+3>IOSL D
 .. I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR Q:$D(DIRUT)!$D(DUOUT)!$D(DTOUT)
 .. D REJREPH
 . Q
 I $E(IOST,1,2)="C-" R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 D ^%ZISC
 K ^TMP("RCTCSJR",$J)
 I $D(ZTQUEUED) S ZTREQ="@"    ; purge the task
 Q
REJREPH ;
 U IO W @IOF S PAGE=PAGE+1
 W "PAGE "_PAGE,?10,HDTITLE,?68,$$FMTE^XLFDT(DT,"2Z")   ;Standardize the date
 I EXCEL W !,$TR(CHDR," ",""),! Q
 W !,DASH,!,CHDR,!,CDSH,! Q
 Q
COLHDR ; sets report line based on type of report
 S CHDR=CHDR_$P(COLHDRS,U,PC)_$S(EXCEL:"^",1:"")
 S CDSH=CDSH_$P(COLDASH,U,PC)_$S(EXCEL:"^",1:"")
 Q
HEADING ;  compiles info for Heading and titles for cross-servicing reject report
 S HDTITLE="DEBT REFERRAL REJECT REPORT (SORTED BY "_$P("BILL NO.^DEBTOR^REJ DATE",U,RPTTYP)
 S HDTITLE=HDTITLE_" <"_$S(ASCDES="D":"DSC",1:"ASC")_">)"
 ;
 S COLWIDTH1="12^20^9^5^5^13^3^11"  ;Change SSN to last initial last 4 only (as per PRCA*4.5*315)
 S COLWIDTH2="12^20^9^5^5^13^3^8",COLWIDTH3="12^20^9^5^6^12^3^11"
 S EXCOLH="BILL NO.^DEBTOR^Pt ID^TYP ^ACTNCD ^REJECT DATE ^SRC ^ERR CODES"
 S COLHDRS="BILL NO.    ^DEBTOR              ^Pt ID   ^TYP ^ACTNCD ^REJECT DATE ^SRC ^ERR CODES"
 S COLDASH="----------- ^------------------- ^-----   ^--- ^------ ^----------- ^--- ^---------"
 S (CHDR,CDSH,CWID)=""
 I RPTTYP=1 S CWID=COLWIDTH1,CHDR=$S(EXCEL:COLHDRS,1:$TR(COLHDRS,"^","")),CDSH=$S(EXCEL:COLDASH,1:$TR(COLDASH,"^",""))
 I RPTTYP=2 F PC=2,1,3:1:8 D COLHDR
 I RPTTYP=3 F PC=6,1:1:5,7,8 D COLHDR
 Q
PROMPTS S U="^"
 S STOP=0,PROMPT="*** DEBT REFERRAL REJECT REPORT ***"
 S DTFRMTO=$$DTFRMTO(PROMPT) I 'DTFRMTO S (STOP,POP)=1 Q
 ;
 S PROMPT="Group Error Codes:  Brief or Detail"
 S DIR(0)="SB^B:Brief;D:Detail"
 S GROUPBD=$$SELECT(PROMPT,"B") I "BD"'[GROUPBD S (STOP,POP)=1 Q
 ;
 S SET="S^1:Bill Number;2:Debtor Name;3:CS Reject Date"
 S RPTTYP=$$RPTTYP("Select One of the Following:",SET) I 'RPTTYP S (STOP,POP)=1 Q
 ;
 S PROMPT="Include Only: AITC, DMC, TREASURY or 'ALL'"
 S DIR(0)="SB^A:AITC;D:DMC;T:TREASURY;ALL:ALL",DIR("L")=PROMPT
 S INCLUDE=$$SELECT(PROMPT,"ALL") I "ADT"'[$E(INCLUDE) S (STOP,POP)=1 Q
 ;
 S PROMPT="Sort ASCENDING or DESCENDING",DIR(0)="SB^A:ASCENDING;D:DESCENDING"
 S DIR("L")=PROMPT
 S ASCDES=$$SELECT(PROMPT,"A") I "AD"'[ASCDES S (STOP,POP)=1 Q
 ;
 S EXCEL=0
 I GROUPBD="B" D
 . S PROMPT="CAPTURE Report data to an Excel Document"
 . S DIR(0)="Y",DIR("?")="^D HEXC^RCTCSJR"
 . S EXCEL=$$SELECT(PROMPT,"NO") I "01"'[EXCEL S (POP,STOP)=1 Q
 I EXCEL=1 D EXCMSG^RCTCSJR ; Display Excel display message
 ; 
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS I POP S STOP=1 Q
 I $D(IO("Q")) D  Q
 .S ZTSAVE("DEBTOR")="",ZTSAVE("DTFRMTO")="",ZTSAVE("EXCEL")="",ZTSAVE("PROMPT")="",ZTSAVE("DASH")="",ZTSAVE("BLNKS")="",ZTSAVE("DATAITMS")="",ZTSAVE("RPTITEMS")=""
 .S ZTSAVE("GROUPBD")="",ZTSAVE("RPTTYP")="",ZTSAVE("INCLUDE")="",ZTSAVE("ASCDES")="",ZTSAVE("CHDR")="",ZTSAVE("CDSH")="",ZTSAVE("ZTASK")=""
 .S ZTRTN="QRPT^RCTCSJR",ZTDESC="CROSS-SERVICING BILL REPORT"
 .D ^%ZTLOAD,^%ZISC S (STOP,POP)=1
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 .Q
 Q  ; PROMPTS
 ;
SELECT(PROMPT,DEFAULT) ; prompts for a selection
 ;INPUT:
 ;   PROMPT - Message to display prior to prompting for dates
 ;OUTPUT:
 ;    1^BEGDT^ENDDT - Data found
 ;    0             - User up arrowed or timed out
 N Y,X,DTOUT,OUT,DIRUT,DUOUT,DIROUT
 S OUT=0
 W !
 S DIR("A")=PROMPT,DIR("B")=DEFAULT
 D ^DIR K DIR
 ;Quit if user time out or didn't enter valid date
 Q:Y<0 OUT
 Q Y
 ;
RPTTYP(PROMPT,SET) ;PRINT CROSS-SERVICING REPORT; print cross-servicing report, prints sorted individual bills that make up a cross-servicing account
 N DIC,ZTSAVE,ZTDESC,ZTRTN,RCSORT
 S OUT=0
 W !
 S DIR(0)=SET ;"S^1:Bill Number;2:Debtor Name;3:CS Reject Date"
 S DIR("A")="Sort by",DIR("B")=1 D ^DIR K DIR
 Q:Y<0 OUT
 Q Y
 ;
DTFRMTO(PROMPT) ;Get from and to dates
 ;INPUT:
 ;   PROMPT - Message to display prior to prompting for dates
 ;OUTPUT:
 ;    1^BEGDT^ENDDT - Data found
 ;    0             - User up arrowed or timed out
 ;
 N %DT,Y,X,BEGDT,ENDDT,DTOUT,OUT,DIRUT,DUOUT,DIROUT
 S OUT=0
 W !,$G(PROMPT)
 S %DT="AEX",%DT("A")="Date Range: FROM: " ;Enter Beginning Date: "
 S %DT("B")="T-7"
 W !
 D ^%DT K %DT
 Q:Y<0 OUT  ;Quit if user time out or didn't enter valid date
 S DTFROM=+Y
 S %DT="AEX"
 S %DT("A")="              TO:   ",%DT("B")="T" ;"TODAY"
 D ^%DT K %DT
 ;Quit if user time out or didn't enter valid date
 Q:Y<0 OUT
 S DTTO=+Y,OUT=1_U_DTFROM_U_DTTO
 ;Switch dates if Begin Date is more recent than End Date
 S:DTFROM>DTTO OUT=1_U_DTTO_U_DTFROM
 Q OUT
 ;
HEXC ; - 'Do you want to capture data to EXCEL' prompt
 W !!,"      Enter:  'Y'   -  To capture detail report data to transfer",!,"                        to an Excel document"
 W !,"              '<CR>' -  To skip this option",!,"              '^'    -  To quit this option"
 Q
 ;
EXCMSG ; - Displays the message about capturing to an Excel file format
 ;
 W !!?5,"To capture as an Excel format, it is recommended that you queue this"
 W !?5,"report to a spool device with margins of 256 and page length of 99999"
 W !?5,"(e.g. 0;256;99999). This should help avoid wrapping problems."
 W !!?5,"Another method would be to set up your terminal to capture the detail"
 W !?5,"report data. On some terminals, this can be done by invoking 'Logging'"
 W !?5,"or clicking on the 'Tools' menu above, then click on 'Capture Incoming "
 W !?5,"Data' to save to Desktop. To avoid undesired wrapping of the data saved"
 W !?5,"to the file, change the DISPLAY screen width size to 132 and you can"
 W !?5,"enter '0;256;99999' at the 'DEVICE:' prompt.",!
 Q
 ; ========================================================================
