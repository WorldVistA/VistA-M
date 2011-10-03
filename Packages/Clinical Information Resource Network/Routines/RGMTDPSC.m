RGMTDPSC ;GAI/TMG-COUNT DUPLICATE RECORD ENTRIES BY CMOR SCORE RANGE ;5/30/98
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**19**;30 Apr 99
 ;
 ;Reference to ^VA(15 supported by IA #2532
 ;Reference to ^DPT("ACMORS" and ^DPT(0 supported by IA #2070
 ;
 ;; search the Duplicate Record file (#15) for duplicate pairs and
 ;; display by CMOR activity score range.  The ranges are in 100's with
 ;; a separate range for pairs where both members have no score and where
 ;; both members have zero score or one member has a zero score and the
 ;; other has no score.
 ;; 
EN ; que or select device for output
 I '$D(^DPT("ACMORS")) D  Q
 . W !,"The option, Start/Restart CMOR Score Calculation"
 . W !,"[RG CMOR START], needs to be run before this option."
 S %ZIS="QM" D ^%ZIS Q:POP  S:IO'=IO(0) IO("Q")="" I '$D(IO("Q")) G SCAN
 S ZTRTN="SCAN^RGMTDPSC"
 S ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL,ZTSAVE("IO*")=""
 S ZTDESC="DUP. RECORD REPORT BY CMOR SCORE" D ^%ZTLOAD,EXIT,^%ZISC
 Q
 ;
SCAN ; search and count duplicate pairs by score ranges
 S U="^",MSG=0,MSGLINE=1,DPTCNT=0 K SCRARR
 N NODE1,NODE2
 S IEN=0 F  S IEN=$O(^VA(15,IEN)) Q:+IEN'>0  I $D(^VA(15,+IEN,0)) S NODE=^(0) D
 . S (SCRANGE,SCORE,SCORE1,SCORE2)="NO SCORE"
 . S DPT1=+$P(NODE,U),DPT2=+$P(NODE,U,2)
 . S NODE1=$$MPINODE^MPIFAPI(+DPT1)
 . I $P($G(NODE1),U,6)'="" S SCORE1=$P(NODE1,U,6)
 . S NODE2=$$MPINODE^MPIFAPI(+DPT2)
 . I $P($G(NODE2),U,6)'="" S SCORE2=$P(NODE2,U,6)
 . I SCORE1=0&(SCORE2=0) S (SCRANGE,SCORE)="ZERO"
 . I SCORE1?.N!(SCORE2?.N) D
 . . Q:SCRANGE="ZERO"
 . . S:+SCORE1>+SCORE SCORE=SCORE1 S:+SCORE2>+SCORE SCORE=SCORE2 S SCRANGE=SCORE\100 I SCRANGE>0 S SCRANGE=SCRANGE*100
 . S:'$D(SCRARR("RANGE",SCRANGE)) SCRARR("RANGE",SCRANGE)=0
 . S SCRARR("RANGE",SCRANGE)=SCRARR("RANGE",SCRANGE)+1
 D PRINT
 ;
EXIT K COUNT,DPT1,DPT2,DPTCNT,IEN,MSG,MSGLINE,NODE,PAGE,POP,PRANGE,PRDT,SCORE
 K SCORE1,SCORE2,SCRANGE,SCRARR,S,TXT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZZ,%DT,%ZIS,DTOUT,DUOUT,SITE,XMSUB,XMTEXT,XMY,XMDUZ
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
PRINT ; print duplicate pair counts by score range
 S (PAGE,COUNT)=0 S X="N",%DT="T" D ^%DT S X=Y X ^DD("DD") S PRDT=Y
 D HDR I MSG=0 D MSG
 I $D(SCRARR("RANGE","ZERO")) D
 . S PRANGE="0" W !?10,PRANGE,?40,$J(SCRARR("RANGE","ZERO"),6,0)
 . S COUNT=COUNT+SCRARR("RANGE","ZERO")
 S SCRANGE="" F  S SCRANGE=$O(SCRARR("RANGE",SCRANGE)) Q:SCRANGE=""  Q:SCRANGE="ZERO"  D
 . I SCRANGE=0 S PRANGE="1 - 99"
 . I SCRANGE'="NO SCORE" I SCRANGE>0 S PRANGE=SCRANGE_" - "_(SCRANGE+99)
 . I SCRANGE="NO SCORE" S PRANGE=SCRANGE
 . S MSGLINE=MSGLINE+.001
 . S TXT(MSGLINE)=$J(" ",10)_PRANGE_$J(" ",23)_$J(SCRARR("RANGE",SCRANGE),6,0)
 . D:$Y>(IOSL-6) HDR W !?10,PRANGE,?39,$J(SCRARR("RANGE",SCRANGE),6,0) S COUNT=COUNT+SCRARR("RANGE",SCRANGE)
 S DPTCNT=$P(^DPT(0),U,4)
 D:$Y>(IOSL-6) HDR W !!,"TOTAL Potential Duplicates (15): ",?39,$J(COUNT,6,0)
 D:$Y>(IOSL-6) HDR W !,"TOTAL Patients (2): ",?39,$J(DPTCNT,6,0)
 S MSGLINE=MSGLINE+.001 D
 . S TXT(MSGLINE)="  ",MSGLINE=MSGLINE+.001
 . S TXT(MSGLINE)="TOTAL Potential Duplicates (15)       "_COUNT
 . S MSGLINE=MSGLINE+.001
 . S TXT(MSGLINE)="TOTAL Patients (2)                    "_DPTCNT
 D MSG1
 Q
 ;
HDR I ($E(IOST,1,2)="C-")&(IO=IO(0)) D
 . S DIR(0)="E" D ^DIR K DIR
 Q:$D(DUOUT)!($D(DTOUT))
 S PAGE=PAGE+1 W #
 W "Duplicate Record Count by CMOR Score",?(IOM-23),"Page: ",PAGE
 W !?(IOM-23),"Date: ",PRDT,!
 F ZZ=1:1:IOM W "-"
 I PAGE=1 D
 .W !,"This report is drawn from the Duplicate Record file (#15) with"
 .W !,"CMOR scores from the PATIENT file, CMOR ACTIVITY SCORE field.",!
 .W !,"- If both members of a pair have a score of zero the pair is"
 .W !,"  counted in the '0' group."
 .W !,"- If one or both members of the pair have a score greater than"
 .W !,"  zero, that pair is counted in the group for the higher score."
 .W !,"- If neither member of the pair have a CMOR score, the pair is"
 .W !,"  counted in the 'NO SCORE' group."
 W !!,?10,"Score Range",?40,"Count",!?10,"-----------",?40,"-----",!
 Q
MSG ;create the message
 S TXT(.1)="Duplicate Record Count by CMOR Score"_$J(" ",20)_"Date: "_PRDT
 S TXT(.2)="  "
 S SITE=$$SITE^VASITE()
 S TXT(.3)=$P(SITE,U,2)_" ("_$P(SITE,U)_")"
 S TXT(.4)="  "
 S TXT(.5)=$J(" ",10)_"Score Range"_$J(" ",20)_"Count"
 S TXT(.6)=$J(" ",10)_"-----------"_$J(" ",20)_"-----"
 S TXT(.7)="  "
 Q
MSG1 ;call XMD
 S XMSUB="Duplicate Records by CMOR Score: "_$P(SITE,U,2)
 S XMY(DUZ)="",XMDUZ=DUZ
 S XMTEXT="TXT(" D ^XMD
 Q
