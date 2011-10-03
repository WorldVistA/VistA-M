SROESPR ;BIR/ADM - SURGERY E-SIG UTILITY ;08/09/04
 ;;3.0; Surgery ;**100,129,134**;24 Jun 93
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to $$PRNTGRP^TIULG supported by DBIA #3003
 ; Reference to $$PRNTMTHD^TIULG supported by DBIA #3003
 ; Reference to $$PRNTNBR^TIULG supported by DBIA #3003
 ; Reference to EXTRACT^TIULQ supported by DBIA #2693
 ; Reference to ^TMP("TIUPR",$J) supported by DBIA #4377
 ; Reference to DOCPARM^TIUSRVP1 supported by DBIA #4331
 ; Reference to $$ISA^USRLM supported by DBIA #2324
 ;
ENTRY ; Entry point to print reports
 N SRFLAG,SRI,SRJ,SRK,SRL,SRM,SRN,SRO,SRPGRP,SRPFHDR,SRSPG
 I $G(TIUFLAG) S SRFLAG=TIUFLAG
 I '$O(^TMP("SRPR",$J,0)) M ^TMP("SRPR",$J)=^TMP("TIUPR",$J)
 S SRI="" F  S SRI=$O(^TMP("SRPR",$J,SRI)) Q:SRI=""  S SRJ="" F  S SRJ=$O(^TMP("SRPR",$J,SRI,SRJ)) Q:SRJ=""  S SRK="" F  S SRK=$O(^TMP("SRPR",$J,SRI,SRJ,SRK)) Q:SRK=""  D
 .S SRPGRP=$P(SRI,"$"),SRL=$P(SRI,"$",2),SRM=$P(SRL,";"),SRN=$P(SRL,";",2)
 .S SRPFHDR=$$TITLE^SROESPR(SRK)
 .S SRO("SRPR",$J,SRPGRP_"$"_SRPFHDR_";"_SRN,SRJ,SRK)=^TMP("SRPR",$J,SRI,SRJ,SRK)
 .K ^TMP("SRPR",$J,SRI,SRJ,SRK)
 M ^TMP("SRPR",$J)=SRO("SRPR",$J)
 U IO
ENTRY1 ; Entry point from above
 N SRERR,D0,DN,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I $E(IOST,1,2)="C-" S (SRSPG,SRFLAG)=1
 I '+$G(SRFLAG) S SRSPG=1
 K ^TMP("SRLQ",$J)
 I $D(ZTQUEUED) S ZTREQ="@" ; Tell TaskMan to delete Task log entry
 D PRINT^SROESPR1($G(SRFLAG),$G(SRSPG))
EXIT K ^TMP("SRLQ",$J),^TMP("SRPR",$J)
 Q
PRNT(SRTN,SRTIU,SRDTITL) ; print report from TIU
 N DFN,SRDARR,SRFLAG,SRPFHDR,SRPFNBR,SRPGRP,SRPMTHD,SRSPG,SRTYP
 K ^TMP("SRPR",$J) S SRFLAG=$$FLAG Q:SRFLAG=""  I $G(SRDTITL)="" S SRDTITL="Surgery Print TIU Document"
 S DFN=$P(^SRF(SRTN,0),"^"),SRTYP=$$TYPE(SRTIU) Q:'+SRTYP
 S SRPMTHD=$$PRNTMTHD^TIULG(+SRTYP)
 S SRPGRP=$$PRNTGRP^TIULG(+SRTYP)
 S SRPFHDR=$$TITLE(SRTIU)
 S SRPFNBR=$$PRNTNBR^TIULG(+SRTYP)
 I $G(SRPMTHD)]"",+$G(SRPGRP),($G(SRPFHDR)]""),($G(SRPFNBR)]"") S SRDARR(SRPMTHD,+$G(SRPGRP)_"$"_$G(SRPFHDR)_";"_DFN,1,SRTIU)=$G(SRPFNBR)
 E  S SRDARR(SRPMTHD,DFN,1,SRTIU)=""
 I $G(SRPMTHD)']"" W !,$C(7),"No Print Method Defined" H 2 Q
 M ^TMP("SRPR",$J)=SRDARR(SRPMTHD)
DEVICE I IOST'["P-" W ! K IOP S %ZIS="Q" D ^%ZIS I POP K POP G EXIT
 S SRFLAG=+$G(SRFLAG),SRSPG=+$G(SRSPG)
 I $D(IO("Q")) K IO("Q") D  G EXIT
 .S ZTRTN="ENTRY1^SROESPR",ZTSAVE("^TMP(""SRPR"",$J,")=""
 .S ZTSAVE("SRFLAG")="",ZTSAVE("SRSPG")="",ZTDESC=SRDTITL
 .D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,SRFLAG,SRSPG
 .D HOME^%ZIS
 U IO D ENTRY1,^%ZISC
 Q
TYPE(SRTIU) ; get document type
 N SRY,SRERR D EXTRACT^TIULQ(SRTIU,"SRY",.SRERR,".01")
 Q SRY(SRTIU,.01,"I")
TITLE(SRTIU) ; get report title
 N SRY,SRERR D EXTRACT^TIULQ(SRTIU,"SRY",.SRERR,".01")
 Q SRY(SRTIU,.01,"E")
FLAG() ; chart vs work copies
 ; returns SRFLAG=1 if chart copy, SRFLAG=0 if work copy, null if '^'
 D DOCPARM^TIUSRVP1(.SRPARM,SRTIU) I +$P($G(SRPARM(0)),"^",9)'>0,'(+$$ISA^USRLM(DUZ,"MEDICAL INFORMATION SECTION")) S SRFLAG=0 Q SRFLAG
 I IOST["P-" S SRFLAG=0 Q SRFLAG
 S SRFLAG="" W ! K DIR S DIR("A")="Do you want WORK copies or CHART copies? ",DIR("B")="WORK",DIR(0)="SA^C:CHART;W:WORK"
 S DIR("?",1)="     The FOOTERs of WORK/CHART copies vary significantly.  The WORK",DIR("?",2)="     FOOTER has the patient's phone number and is clearly marked:"
 S DIR("?",3)="     'NOT FOR MEDICAL RECORD'.  Unless you really intend to file the",DIR("?")="     note(s) in the chart- print a WORK copy."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q SRFLAG
 S SRFLAG=$S(Y="C":1,1:0)
 Q SRFLAG
PAT(SRY,DFN) ; get minimum demographics for print
 N VADM,VAIP,VAIN,VAPA,VA D OERR^VADPT,ADD^VADPT
 S SRY("PNMP")=$E($G(VADM(1)),1,30),SRY("SSN")=$G(VA("PID"))
 S SRY("DOB")="DOB:"_$$DATE(+$G(VADM(3)),"MM/DD/CCYY")
 S SRY("PH#")="Ph:"_$S($G(VAPA(8))'="":VAPA(8),1:"**UNKNOWN**")
 S SRY("INTNM")=$$NAME^VASITE ;Integration Name
 S SRY("SITE")=$P($$SITE^VASITE,U,2)
 S SRY("LOCP")="Pt Loc: "_$S(VAIN(4)]"":$P(VAIN(4),U,2)_"  "_VAIN(5),1:"OUTPATIENT")
 Q
TIME(X,FMT) ; receives X as 2910419.01 and FMT=Return Format of time (HH:MM:SS).
 N HR,MIN,SEC,SRI I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="HR:MIN"
 S X=$P(X,".",2),HR=$E(X,1,2)_$E("00",0,2-$L($E(X,1,2))),MIN=$E(X,3,4)_$E("00",0,2-$L($E(X,3,4))),SEC=$E(X,5,6)_$E("00",0,2-$L($E(X,5,6)))
 F SRI="HR","MIN","SEC" S:FMT[SRI FMT=$P(FMT,SRI)_@SRI_$P(FMT,SRI,2)
 Q FMT
DATE(X,FMT) ; call with X=2910419.01 and FMT=Return Format of date ("MM/DD")
 N AMTH,MM,CC,DD,YY,SRI,SRTMP
 I +X'>0 S $P(SRTMP," ",$L($G(FMT))+1)="",FMT=SRTMP G QDATE
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="MM/DD/YY"
 S MM=$E(X,4,5),DD=$E(X,6,7),YY=$E(X,2,3),CC=17+$E(X)
 S:FMT["AMTH" AMTH=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+MM)
 F SRI="AMTH","MM","DD","CC","YY" S:FMT[SRI FMT=$P(FMT,SRI)_@SRI_$P(FMT,SRI,2)
 I FMT["HR" S FMT=$$TIME(X,FMT)
QDATE Q FMT
BEEP(SRPER) ; get beeper #'s
 N SRDP,SRVP,SRY S (SRDP,SRVP)="" K DA,DIC,DR,DIQ
 S DIC=200,DA=+SRPER,DR=".137;.138",DIQ="SRY",DIQ(0)="I" D EN^DIQ1 K DA,DIC,DR,DIQ
 S SRVP=SRY(200,+SRPER,.137,"I"),SRDP=SRY(200,+SRPER,.138,"I")
 Q SRVP_"^"_SRDP
SIGNAME(SRPER) ; get signature block printed name
 N SRY K DA,DIC,DR,DIQ
 S DIC=200,DA=+SRPER,DR="20.2",DIQ="SRY",DIQ(0)="I" D EN^DIQ1 K DA,DIC,DR,DIQ
 Q SRY(200,+SRPER,20.2,"I")
SIGTITL(SRPER) ; get signature block title
 N SRY K DA,DIC,DR,DIQ
 S DIC=200,DA=+SRPER,DR="20.3",DIQ="SRY",DIQ(0)="I" D EN^DIQ1 K DA,DIC,DR,DIQ
 Q SRY(200,+SRPER,20.3,"I")
