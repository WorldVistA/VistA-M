DVBHUTIL ;ALB/JLU -This is a general utility program ;3/19/90
 ;;4.0;HINQ;**3,12,17,32**;03/25/92 
 ;entry point for DVBHQUP to set up intensity for screens.
A S DVBOUT="",IOP="HOME",(DVBBLO,DVBBLF,DVBON,DVBOFF,DVBLIT1,DVBLIT2)="" D ^%ZIS K IOP
 I $S('$D(^DVB(395,1,0)):1,'$P(^(0),U,3):1,1:0) Q
 S X="IOINHI;IOINLOW;IOBON;IOBOFF" D ENDR^%ZISS S DVBON=IOINHI,DVBOFF=IOINLOW,DVBBLO=IOBON,DVBBLF=IOBOFF
 ;;;I ^%ZOSF("OS")["VAX" S DVBLIT="" E  ;
 W !,DVBON,"",DVBOFF S O=$X
 S DVBLIT1="S DX=$X-"_O_",DY=$S($Y>IOSL:IOSL,1:$Y) "_^%ZOSF("XY")_" K DX,DY"
 W !,DVBBLO,"",DVBBLF S O=$X
 S DVBLIT2="S DX=$X-"_O_",DY=$S($Y>IOSL:IOSL,1:$Y) "_^%ZOSF("XY")_" K DX,DY"
 ;
 ;
 K IOINHI,IOINLOW,IOBOFF,IOBON
 Q
 ;Entry point from update template for three part question
Q W !!,"Is this the patient to update (YES, NO, IGNORE, DISPLAY, ALERT)? YES//" R DVBUQ:DTIME S DVBOUT=DVBUQ
 I DVBUQ["^" S Y="@10" Q
 I "Yy"[DVBUQ!(""[DVBUQ) S $P(^DVB(395.5,DFN,0),U,5)="I" W "  YES" DO  Q
 .I '$D(DVBDATA) Q
 .I 'DVBDATA Q
 .S DIE("NO^")=""
 .S Y=+DVBDATA
 .S Y=$S("1234"[Y:"@"_(Y-1),Y=5:"@104",Y=6:"@1006",1:"@10")
 .Q:Y="@10"
 .S DVBDATA=$P(DVBDATA,"^",2,10)_"^"_$P(DVBDATA,"^",10,99)
 .I Y="@" S Y="@8"
 I "Nn"[DVBUQ S Y="@10" W "  NO" Q
 I "Ii"[DVBUQ S Y="@10" S $P(^DVB(395.5,DFN,0),U,5)="I" W "  IGNORE" Q
 ;
 I "Dd"[DVBUQ W "  DISPLAY"  S DVBMM=1,DVBJIO=IO(0) D EN^DVBHIQM,WRT1^DVBHQD1,TEM^DVBHIQR K ^TMP($J),DVBMM,DVBJIO S Y="@101" Q
 I "Aa"[DVBUQ,$D(DVBDATA),1 W " ALERT" DO  Q
 .D ACHK^DVBHT1
 .D DISPLAY^DVBHT I $D(DVBNOALR) S Y="@10" Q
 .I $D(DVBJ2),DVBJ2 D ACKNOW^DVBHT S Y="@101" Q
 .D PAGE^DVBHT S Y="@101" Q
 E  I "Aa"[DVBUQ DO  G Q
 .W !!,"You are not processing an Alert, 'A'lert update and display not available."
 ;
 W *7,!," 'Y'es, Will continue with this patient",!," 'N'o, Go next patient",!," 'I'gnore, Patient will NOT appear in ALL option until reHINQ",!," 'D'isplay will show you the HINQ mail message."
 W !," 'A'lert, will update and display the Alert if processing alerts",!," '^' to quit"
 G Q
 ;header for ^DVBHQZ6
2 W !,?9,"**************************************************************"
 W !,?9,"* This option will print out a report, identical to the mail *"
 W !,?9,"* messages, of the patients in the suspense file with a      *"
 W !,?9,"* successful HINQ request.                                   *"
 W !,?9,"**************************************************************"
 Q
 ;
SIGN ;General sign converter var to be worked on/defined DVBV1,DVBV2
 ;DVBV1 contains the string of characters
 ;DVBV2 contains the character at which the sign resides.
 ;Must be sure there is a sign there before sending to this routine
 N CT,A1,V
 I '$D(DVBS) S CT=1,DVBS("{")=0 F A1=65:1:73 S DVBS($C(A1))=CT S CT=CT+1
 I '$D(DVBS($E(DVBV1,DVBV2))) D W2 Q
 S V=DVBS($E(DVBV1,DVBV2)),DVBV2=$S(DVBV2=1:1,1:DVBV2-1),DVBV1=$S(DVBV2=1:"",1:$E(DVBV1,1,DVBV2))_V
 Q
 ;
SCRHD W @$S('$D(IOF):"#",IOF="":"#",1:IOF)
 W ?1,$E(DVBDIQ(2,DFN,.01,"E"),1,30)
 W ?22,"Patient File"
 W ?35,DVBON,"((",DVBSCRN,"))",DVBOFF X DVBLIT1
 W ?49,"HINQ Response"
 W ?68,"SSN: ",DVBON,$E(DVBDIQ(2,DFN,.09,"E"),6,9),DVBOFF
 W !,"-------------------------------------------------------------------------------"
 Q
 ;
CHK ;This entry point will print an error message for the edit template
 ;if the diag. were BIRLS only and the DIAG. Verif. ind. was not 'Y'
 ;
 W !!,*7,?7,"BIRLS only response and the 'Diagnostic Verified Indicator' is NO.",!,?16,"Verify SC at folder location: ",DVBFL,!,?28,DVBON,"No updating allowed.",DVBOFF
 X DVBLIT1 S DVB=D0,DVBLP=2,DVBMM=1 D QB^DVBHQZ6 S Y="@50"
 Q
 ;
POW ;This entry point is to determine the variable for the input to the 
 ;patient file.  Whether POW or not.
 ;
 I $D(DVBPOW) S DVBPOW1=$S(DVBPOW=1!(DVBPOW=2):"Y",1:"N")
 I $D(DVBPOWD) S DVBPOW1=$S(+DVBPOWD:"Y",1:"N")
 Q
 ;
VERR ;This entry point prints an error message if mas not >5.1 cause .305 unemployable field is not there.
 W !!,*7,?2,"Your version of MAS is NOT greater than 5.1, thus the Unemployable field"
 W !,?2,"is not in your patient file.  No uploading of this field allowed."
 R !,?25,"<RET to continue>",DVBQ:DTIME K DVBQ
 Q
 ;
SCRQ ;The screens will call this entry point to read the answer from the user.
 W !!,DVBON,"<RET> ",DVBOFF X DVBLIT1
 W "to CONTINUE, "
 W DVBON,"'^' ",DVBOFF X DVBLIT1
 W "to QUIT, "
 W DVBON,"N  N-N  N,N,N,N  or (A)-ALL",DVBOFF X DVBLIT1
 W " to update: "
 R ANS:DTIME S Y=$S(ANS="^"!($T=0):"@10",ANS=""&$T=1:"@4",ANS["?":"@6",1:"@8")
 I Y="@4",$D(DVBDATA),DVBDATA DO
 .S Y=+DVBDATA
 .S DVBDATA=$P(DVBDATA,"^",2,10)_"^"_$P(DVBDATA,"^",10,99)
 .S Y=$S("1234"[Y:"@"_(Y-1),Y=5:"@104",Y=6:"@1006",1:"@10")
 I Y="@8" ;;;,$D(DVBDATA),DVBDATA S $P(DVBDATA,"^")=""
 Q
 S Y=$S(DVBJS=11:"@1",DVBJS=28:"@2",DVBJS=35:"@3",DVBJS=44:"@104",DVBJS=53:"@1006",1:"@10")
 Q
 ;
W2 ;error message for missing data found in sign subroutine
 S DVBERCS=1 I '$G(DVBTSK) D
 .W !!!!,?15,"HINQ data does NOT seem right."
 .I +DFN>0 D
 ..W !,?15,"Data appears to be missing for ",$S($D(^DPT(DFN,0)):$P(^(0),U),1:DFN)
 ..W !,?15,"Please re-HINQ for this patient.",! H 3
 Q
