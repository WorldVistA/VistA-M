PSGLBA ;BIR/CML3-LABEL ALIGNMENT ;16 DEC 97 / 1:36 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
ENLP ; please do NOT place an IF statement in this paragraph
 U IO W "\------------- FIRST LINE OF LABEL ------------/"
 W !,"<",?47,">",!,"<------------- LABEL BOUNDARIES --------------->"
 W !,"<",?47,">",!,"/--------------LAST LINE OF LABEL--------------\"
L2 W !!," XX/XX | XX/XX | XX/XX/XX  XX:XX  (PXXXX)  | A T",?52,"PATIENT NAME",?87,"ROOM-BED"
 W !," DRUG NAME",?30,"SCHEDULE TYPE| D I",?52,"XXX-XX-XXXX",?70,"DOB"," (AGE)",?91,"TEAM"
 W !," DOSAGE ORDERED   MED ROUTE   SCHEDULE     | M M",?52,"SEX",?65,"DIAGNOSIS"
 W !," SPECIAL INSTRUCTIONS",?43,"| I E",?52,"ACTIVITY DATE/TIME",?72,"ACTIVITY"
 W !," WS HSM NF",?25,"RPH:_____ RN:_____",?43,"| N S",?52,"WARD GROUP",?91,"WARD",!! Q
 ;
EN1 ; alignment upon entry into package
 I IO=IO(0),$E(IOST,1,2)'="C-" D SLAVE G DONE
 D ASK G:Y DONE S %ZIS="Q"
E1 F Q=1:1:5 S IOP=$P(PSJSYSL,"^",2) D ^%ZIS I 'POP Q
 E  R "   DEVICE [BUSY] ... WAIT? ",X:DTIME I X]"","YES"[X!("yes"[X) W "  (WAITING)",! G E1
 E  W "  (NO)" G DONE
 D DEV G DONE
 ;
EN2 ;
 I IO=IO(0),$E(IOST)'="C" D SLAVE S IOP=PSGLBA D ^%ZIS G DONE
 D ASK,DEV:'Y
 ;
DONE ;
 K IOP,POP,PSGLBA Q
 ;
ENAL ; for align option
 D ENCV^PSGSETU Q:$D(XQUIT)
 K %ZIS,IOP S %ZIS="Q",%ZIS("A")="Select LABEL PRINTER: ",%ZIS("B")=$P(PSJSYSL,"^",2) W ! D ^%ZIS I POP D ^%ZISC W !!,"No printer selected; labels not aligned." G ALDONE
 I IO=IO(0),$E(IOST)'="C" D  G ALDONE
 .S PSGLBA=ION_";132" K %ZIS F  D ENLP,^%ZISC,OK Q:Y  S IOP=PSGLBA D ^%ZIS
 D DEV,^%ZISC
 ;
ALDONE ;
 D ENKV^PSGSETU K PSGLBA Q
 ;
DEV ;
 I '$D(IO("Q")) F  D ENLP,OK Q:Y
 Q:'$D(IO("Q"))  K ZTSAVE S PSGLBA=ION,PSGTINC=1 F  S PSGTID=$H,ZTDESC="UD LABEL ALIGN",PSGTIR="ENLP^PSGLBA" D ENTSK^PSGTI,OK Q:Y
 K PSGTINC Q
 ;
SLAVE ;
 S PSGLBA=ION_";132",%ZIS="" D ^%ZISC D ASK Q:Y  F  S IOP=PSGLBA D ^%ZIS,ENLP D ^%ZISC D OK Q:Y
 Q
 ;
ASK ;
 F  W !,"Do you need to align the UNIT DOSE label stock" S %=2 D YN^DICN Q:%  D H1
 S Y=%'=1 Q
 ;
H1 ;
 W !!?2,"Enter 'Y' to print test labels on the printer just selected to check the",!,"alignment of the label stock.  If the test labels are not needed, enter an 'N'  (or simply press the RETURN key).",! Q
 ;
OK ;
 U IO(0) F  W !!," Are the labels aligned correctly" S %=1 D YN^DICN Q:%  D H2
 S Y=%<2 Q:Y  W !!,"Re-align the labels, and then press the RETURN key for more test labels. " R X:DTIME W:'$T $C(7) S:X="^"!'$T Y=1 Q
 ;
H2 ;
 W !!?2,"Enter 'Y' if the label stock is aligned correctly.  Enter an 'N' if you need",!,"to adjust the label stock and print test labels again." Q
