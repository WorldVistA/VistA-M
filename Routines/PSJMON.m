PSJMON ;BIR/MV - Display/Print Monograph ;6 Jun 07 / 3:37 PM
 ;;5.0; INPATIENT MEDICATIONS ;**181**;16 DEC 97;Build 190
 ;
MON(PSJMON) ;Process monographs
 NEW PSJPRTFL,PSJIOF,PSJSERVR
 S PSJPRTFL=0,PSJIOF=1
 Q:'$$ASK()
 D LSTMON(.PSJMON)
 D:PSJPRTFL DSPMON
 K PSJMON,^TMP($J,"PSJPMON")
 Q
 ;
ASK(X) ;Ask if user want to see the monograph
 NEW PSJX,DIR,DTOUT,DUOUT,DIRUT,Y
 S PSJX=$S($G(X):"(s)",1:"")
 K DIR S DIR(0)="Y",DIR("A")="Display Professional Interaction Monograph(s)"_PSJX,DIR("B")="NO" D ^DIR
 I 'Y K PSJMON W !
 Q Y
DSPMON ;
 NEW ZTDESC,ZTRTN,ZTSAVE
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS
 I POP K SEL,DIR,DTOUT,DUOUT,DIRUT,MONT W !,"NOTHING PRINTED" Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="OUT^PSJMON",ZTDESC="Monograph Report of Drug Interactions"
 .S ZTSAVE("LIST")="",ZTSAVE("^TMP($J,""PSJPMON"",")=""
 .D ^%ZTLOAD,^%ZISC W !,"Monograph Queued to Print!",! S:$D(ZTQUEUED) ZTREQ="Q"
 D OUT,^%ZISC
 Q
OUT ;Print the Professional Monograph
 NEW PSJMONV,PSJPN,PSJQUIT,PSJNUM
 U IO
 S PSJQUIT=0
 F PSJNUM=0:0 S PSJNUM=$O(^TMP($J,"PSJPMON",PSJNUM)) Q:'PSJNUM  D
 .S PSJSERVR="" F  S PSJSERVR=$O(^TMP($J,"PSJPMON",PSJNUM,PSJSERVR)) Q:PSJSERVR=""  F PSJPN=0:0 S PSJPN=$O(^TMP($J,"PSJPMON",PSJNUM,PSJSERVR,PSJPN)) Q:'PSJPN  Q:PSJQUIT=2  D
 .. S PSJMONV=^TMP($J,"PSJPMON",PSJNUM,PSJSERVR,PSJPN)
 .. I PSJMONV="Professional Monograph " S PSJQUIT=0 D
 ... I $G(PSJIOF) K PSJIOF W !! W @IOF Q
 ... ;Ignore 1 "^" and display the next mon.
 ... I '$G(PSJIOF) W !! S:$E(IOST)="C" PSJQUIT=$$PAUSE1^PSJMISC() S:PSJQUIT=1 PSJQUIT=0 W @IOF
 .. I PSJQUIT Q
 .. W !,PSJMONV
 .. I $Y+4>IOSL,$E(IOST)="C" W ! S PSJQUIT=$$PAUSE1^PSJMISC() W @IOF S:PSJQUIT=1 PSJIOF=1
 W !
 Q
LSTMON(PSJMON) ;Display a list of monographs to the user & store mon for printing to screen/printer
 ;PSJMON(ProfileVaGEN+ProspectiveDrugname,monographTitle)=P1...P11 (PSJMON array groups the same drug pair and title into one selectable choice)
 ;PSJMONS(seq no,monographTitle)=P1...P11 (a drug pair may have 1 or more titles.  This array is to store title 2 and subsequence)
 ;PSJMONLI(n)=P1...P11 (PSJMONLI array keeps the drug pair/monograph in a numeric list)
 ;P1 : Sequential #
 ;P2 : Drug name (profile)
 ;P3 : Profile Drug IEN file 50
 ;P4 : Drug name of order being worked on
 ;p5 : Drug IEN file 50 from order being worked on
 ;P6 : Pharmacy order # (Package;ON;PROFILE/PROSPECTIVE;SEQ # (I;29V;PROFILE;1)
 ;P7 : Severity (C: critical, S: significant)
 ;P8 : Use by PSJMONLI array (extra PMON for the same pair)
 ;P9 : If set to 1, the display will be "CRITICAL/SIGNIFICANT" for severity in the selection drug pair display
 ;P10: If set to 1, the package display will be "IO" in the selection drug pair display
 ;P11: VA GENERIC name (profile)
 NEW DIR,DIRUT,DTOUT,DUOUT,PSJCNT,PSJPON1,PSJMONV,PSJMONTI,PSJDNM,PSJN,PSJPN,PSJS,PSJSEV1,PSJX,PSJX1,PSJY,X,Y
 NEW PSJMONLI,PSJMONS
 K ^TMP($J,"PSJPMON")
 D NUMLST
 S PSJY=$O(PSJMONLI(""),-1)
 I PSJY>1 S PSJY=$$SELLST(.PSJMONLI)
 Q:'+PSJY
 S PSJPRTFL=1
 S PSJCNT=0
 F PSJX1=1:1:$L(PSJY) S PSJX=$P(PSJY,",",PSJX1) Q:PSJX=""  D
 . S PSJMONV=PSJMONLI(PSJX)
 . D SETMON(PSJX1,PSJMONV)
 . I +$P(PSJMONV,U,8) S PSJMONTI="" F  S PSJMONTI=$O(PSJMONS(PSJX,PSJMONTI)) Q:PSJMONTI=""  D
 .. S PSJMONV=PSJMONS(PSJX,PSJMONTI) D SETMON(PSJX1,PSJMONV)
 Q
SELLST(PSJMONLI) ;Only present selection pair if there are more than 1 pair in the list
 NEW DIR,DIRUT,DTOUT,DUOUT,PSJPON1,PSJMONV,PSJS,PSJSEV1,PSJX,X,Y
 W !
 F PSJX=0:0 S PSJX=$O(PSJMONLI(PSJX)) Q:'PSJX  D
 . S PSJMONV=PSJMONLI(PSJX)
 . F X=1:1:11 S PSJS(X)=$P(PSJMONV,U,X)
 . S PSJSEV1=$S(PSJS(9):"CRITICAL/SIGNIFICANT",PSJS(7)="C":"CRITICAL",PSJS(7)="S":"SIGNIFICANT",1:"")
 . S PSJPON1=$S(PSJS(10):"IO",$P(PSJS(6),";")="I":"I",1:"O")
 . W !,PSJX,".  ",$$VAGEN^PSJMISC(PSJS(5))," and ",$P(PSJS(11),"+")," ("_PSJSEV1_" - "_PSJPON1_")"
 W !
 K DIR S DIR(0)="LO^1:"_$O(PSJMONLI(""),-1),DIR("A")="Select Monograph(s) for printing by number" D ^DIR
 Q Y
SETMON(PSJNUM,PSJMONV) ;Setup monograph for screen/prt
 ;PSJNUM - selected # from monograph's list
 NEW PSJPN,PSJS,X
 I $G(PSJMONV)="" Q
 Q:'$G(PSJNUM)
 F X=1:1:11 S PSJS(X)=$P(PSJMONV,U,X)
 S X=$G(^TMP($J,"PSJPRE","OUT","DRUGDRUG",PSJS(7),PSJS(2),PSJS(6),PSJS(1),"PMON",5,0))
 S X=$P(X,"SEVERITY LEVEL:  ",2)
 S PSJSERVR=PSJS(11)_$E(X,1,1)
 D STOREMON("Professional Monograph",PSJSERVR)
 S PSJMONV="Drug Interaction with "_$P(PSJS(11),"+")_" and "_$$VAGEN^PSJMISC(PSJS(5))
 D STOREMON(PSJMONV,PSJSERVR),STOREMON("",PSJSERVR)
 F PSJPN=0:0 S PSJPN=$O(^TMP($J,"PSJPRE","OUT","DRUGDRUG",PSJS(7),PSJS(2),PSJS(6),PSJS(1),"PMON",PSJPN)) Q:'PSJPN  D
 . S PSJMONV=$G(^TMP($J,"PSJPRE","OUT","DRUGDRUG",PSJS(7),PSJS(2),PSJS(6),PSJS(1),"PMON",PSJPN,0))
 . S PSJCNT=PSJCNT+1
 . D STOREMON(PSJMONV,PSJSERVR)
 Q
NUMLST ;Set the monograph into a number selectable list
 NEW PSJDNM,PSJMONTI,PSJMFLG,PSJN,PSJON1,PSJON2,PSJONFG
 S PSJN=0
 S PSJDNM="" F  S PSJDNM=$O(PSJMON(PSJDNM)) Q:PSJDNM=""  S PSJMONTI="",PSJMFLG=0 F  S PSJMONTI=$O(PSJMON(PSJDNM,PSJMONTI)) Q:PSJMONTI=""  D
 . I 'PSJMFLG S PSJN=PSJN+1 S PSJMONLI(PSJN)=PSJMON(PSJDNM,PSJMONTI)
 . I PSJMFLG D
 .. S PSJMONLI(PSJN)=PSJMONLI(PSJN)_"^^"_PSJN
 .. S $P(PSJMONLI(PSJN),U,8)=1
 .. S PSJMONS(PSJN,PSJMONTI)=PSJMON(PSJDNM,PSJMONTI)
 .. S PSJON1=$P($P(PSJMONLI(PSJN),U,6),";")
 .. S PSJON2=$P($P(PSJMONS(PSJN,PSJMONTI),U,6),";")
 .. S PSJONFG=0
 .. I PSJON1="I",PSJON1'="I" S PSJONFG=1
 .. I PSJON1'="I",PSJON1="I" S PSJONFG=1
 .. S:PSJONFG $P(PSJMONLI(PSJN),U,10)=1
 .. I $P(PSJMONLI(PSJN),U,7)'=$P(PSJMONS(PSJN,PSJMONTI),U,7) S $P(PSJMONLI(PSJN),U,9)=1
 . S PSJMFLG=1
 K PSJON1,PSJON2,PSJONFG
 Q
STOREMON(PSJX,PSJSERVR) ;Store the formatted Monograph
 NEW PSJX1,X,Y,Y1
 Q:'$G(PSJNUM)
 I $G(PSJSERVR)="" S PSJSERVR=1
 S PSJCNT=$G(PSJCNT)+1
 S X="REFERENCES:"
 I $E(PSJX,1,$L(X))=X S ^TMP($J,"PSJPMON",PSJNUM,PSJSERVR,PSJCNT)=X,PSJCNT=PSJCNT+1 S PSJX=$P(PSJX,X,2)
 S PSJX1=""
 F Y=1:1:$L(PSJX," ") S Y1=$P(PSJX," ",Y) D
 . I ($L(PSJX1)+$L(Y1)+1)>73 S:$E(PSJX1,1,1)=" " PSJX1=$E(PSJX1,2,$L(PSJX1)) S ^TMP($J,"PSJPMON",PSJNUM,PSJSERVR,PSJCNT)=PSJX1,PSJX1="",PSJCNT=PSJCNT+1
 . S PSJX1=PSJX1_Y1_" "
 I PSJX1]"" S ^TMP($J,"PSJPMON",PSJNUM,PSJSERVR,PSJCNT)=PSJX1
 K PSJX1
 Q
