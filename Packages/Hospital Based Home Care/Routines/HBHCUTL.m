HBHCUTL ; LR VAMC(IRMS)/MJT-HBHC Utility module, Entry points:  ACTION, STATUS, START, TODAY, HDRPAGE, HDRRANGE, HDR132, HDR132NR, HDRXPAGE ; Mar 2000
 ;;1.0;HOSPITAL BASED HOME CARE;**2,6,8,16,24**;NOV 01, 1993;Build 201
ACTION ; Set appropriate fields/variables for Admit/Reject Action
 K HBHCQ,HBHCKEEP
 S HBHCY0=^HBHC(631,HBHCDFN,0)
 S:X="" Y=$S($D(HBHCUPD):0,1:87) S:X=1 Y=18 S:X=2 HBHCQ=1
 S HBHCAFLG=0 F HBHCI=19:1:37 Q:HBHCAFLG  S:$P(HBHCY0,U,HBHCI)]"" HBHCAFLG=1
 S HBHCRFLG=0 I ($P(HBHCY0,U,16)]"")!($P(HBHCY0,U,17)]"") S HBHCRFLG=1
 Q:(HBHCAFLG=0)&(HBHCRFLG=0)
 Q:(HBHCRFLG=0)&(X=1)
 Q:(HBHCAFLG=0)&(X=2)
 S HBHCWRD1=$S(HBHCAFLG=1:"admission",1:"rejection")
 S HBHCWRD2=$S(X="":"to 'Delete'",X=2:"'Reject' in",1:"'Admit' in")
 S HBHCWRD3=$S(HBHCAFLG=1:"1 for Admit",1:"2 for Reject")
 D PROCADM I %=1 D:HBHCAFLG ADMIT S:HBHCRFLG $P(^HBHC(631,HBHCDFN,0),U,16)="",$P(^HBHC(631,HBHCDFN,0),U,17)=""
 Q
PROCADM ; Process 'Delete' & 'Reject' responses
 W $C(7),!!,"This record contains ",HBHCWRD1," data.  Are you sure you want ",HBHCWRD2," the",!,"Admit/Reject Action field  ('Yes' will delete the ",HBHCWRD1," data)" S %=2 D YN^DICN
 W ! W:%=0 !!,"Admit/Reject Action field must either contain ",HBHCWRD3," or the ",HBHCWRD1,!,"data MUST be deleted by responding 'Yes'.",!!
 I %'=1 S Y=$S($D(HBHCUPD):0,1:14) S:$D(HBHCUPD) HBHCKEEP=1
 Q
ADMIT ; Set appropriate fields = null
 F HBHCJ=19:1:37 S $P(^HBHC(631,HBHCDFN,0),U,HBHCJ)=""
 S $P(^HBHC(631,HBHCDFN,1),U,14)=""
 Q
STATUS ; Set appropriate fields/variables for Discharge Status
 K HBHCQ,HBHCQ1,HBHCKEEP
 S HBHC12="^1^2^",HBHC359="^3^5^9^",HBHCNOD1=$G(^HBHC(631,HBHCDFN,1)),HBHCY0=^HBHC(631,HBHCDFN,0)
 S:X="" Y=$S($D(HBHCUPD):0,1:65) S:HBHC12[(U_X_U) HBHCQ1=1,Y=44 S:HBHC359[(U_X_U) Y="@1" S:X=4 HBHCQ=1,Y=$S($D(HBHCUPD):0,1:69)
 S HBHCTFLG=0 S:($P(HBHCY0,U,45)]"")!($P(HBHCY0,U,46)]"") HBHCTFLG=1
 S HBHCDIED=0 S:$P($G(^HBHC(631,HBHCDFN,1)),U,15)]"" HBHCDIED=1
 S HBHCDFLG=0 F HBHCL=47:1:55 Q:HBHCDFLG  S:$P(HBHCY0,U,HBHCL)]"" HBHCDFLG=1
 I HBHCNOD1]"" F HBHCM=1:1:10 Q:HBHCDFLG  S:$P(HBHCNOD1,U,HBHCM)]"" HBHCDFLG=1
 Q:(HBHCTFLG=0)&(HBHCDIED=0)&(HBHCDFLG=0)
 Q:(HBHC12[(U_X_U))&(HBHCDIED=0)
 Q:(X=4)&(HBHCTFLG=0)&(HBHCDFLG=0)
 Q:(HBHC359[(U_X_U))&(HBHCTFLG=0)&(HBHCDIED=0)
 S HBHCWRD1=$S(HBHCTFLG:"transfer",HBHCDIED:"deceased",1:"discharge")
 S HBHCWRD2=$S(X="":"to 'Delete'",HBHC12[(U_X_U):"'Transfer' in",X=4:"'Died' in",1:"'Discharge' in")
 S HBHCWRD3=$S(HBHCTFLG:"1 or 2 for Transfer",HBHCDIED:"4 for Died on HBHC",1:"3, 5 or 9 for Discharge")
 D PROCDIS Q:%'=1
 S:HBHCTFLG $P(^HBHC(631,HBHCDFN,0),U,45)="",$P(^HBHC(631,HBHCDFN,0),U,46)=""
 D:(HBHCDFLG)&((X=4)!(X="")) DISCHRG
 S:HBHCDIED $P(^HBHC(631,HBHCDFN,1),U,15)=""
 Q
PROCDIS ; Process 'Delete', '1 or 2', '4', & '3 or 5 or 9' responses
 W $C(7),!!,"This record contains ",HBHCWRD1," data.  Are you sure you want ",HBHCWRD2," the",!,"Discharge Status field  ('Yes' will delete the ",HBHCWRD1," data)" S %=2 D YN^DICN
 W ! W:%=0 !!,"Discharge Status field must contain ",HBHCWRD3," or the ",HBHCWRD1,!,"data MUST be deleted by responding 'Yes'.",!!
 I %'=1 S Y=$S($D(HBHCUPD):0,1:43) S:$D(HBHCUPD) HBHCKEEP=1
 Q
DISCHRG ; Delete discharge data 
 F HBHCI=47:1:55 S $P(^HBHC(631,HBHCDFN,0),U,HBHCI)=""
 F HBHCJ=1:1:10 S $P(^HBHC(631,HBHCDFN,1),U,HBHCJ)=""
 S $P(^HBHC(631,HBHCDFN,1),U,16)=""
 Q
START ; Prompt for beginning/ending report dates
 W ! K %DT S (HBHCBEG1,HBHCEND1,HBHCPAGE)=0,%DT("A")="Beginning Report Date: ",%DT="AEX" D ^%DT S HBHCBEG1=Y Q:HBHCBEG1=-1  D DD^%DT S HBHCBEG2=Y
END ; Ending date prompt
 S %DT("A")="Ending Report Date: " D ^%DT I (Y>0)&(Y<HBHCBEG1) W $C(7),!!,"Ending Report Date must be closer to today than the Beginning Report Date",! G END
 S HBHCEND1=Y_.9999 Q:HBHCEND1=-1  D DD^%DT S HBHCEND2=Y
TODAY ; Obtain current date
 S $P(HBHCZ,"=",81)=""
 K %DT S X="T" D ^%DT,DD^%DT S HBHCTDY=Y K %DT
 Q
HDRPAGE ; Print header with Page
 S HBHCPAGE=HBHCPAGE+1
 W !?HBHCCOLM,">>> HBPC ",HBHCHEAD," Report <<<",?71,"Page: ",HBHCPAGE,!!,"Run Date: ",HBHCTDY,!! I $D(HBHCHDR) X HBHCHDR W !
 W HBHCZ
 Q
HDRRANGE ; Print header with Date Range
 S HBHCPAGE=HBHCPAGE+1
 W !?HBHCCOLM,">>> HBPC ",HBHCHEAD," Report <<<",?71,"Page: ",HBHCPAGE,! W:$D(HBHCNAM) ?HBHCCLM1,$S($D(HBHCONE):"Provider:  ",1:"HBPC Team: "),HBHCNAM,! W !,"Run Date: ",HBHCTDY,?53,"Date Range: ",HBHCBEG2," to",!?65,HBHCEND2,!
 I $D(HBHCHDR) X HBHCHDR W !
 W HBHCZ
 Q
HDR132 ; Print 132 column header with Date Range 
 S HBHCPAGE=HBHCPAGE+1
 W !?HBHCCOLM,">>> HBPC ",HBHCHEAD," Report <<<",?123,"Page: ",HBHCPAGE,! W:$D(HBHCNAM) ?HBHCCLM1,HBHCWHOC_": ",HBHCNAM,! W !,"Run Date: ",HBHCTDY,?105,"Date Range: ",HBHCBEG2," to",!?117,HBHCEND2,! I $D(HBHCHDR) X HBHCHDR W !
 W HBHCZ
 Q
HDR132NR ; Print 132 column header with No Date Range 
 S HBHCPAGE=HBHCPAGE+1
 W !?HBHCCOLM,">>> HBPC ",HBHCHEAD," Report <<<",?123,"Page: ",HBHCPAGE,! W !,"Run Date: ",HBHCTDY I $D(HBHCHDR) X HBHCHDR W !
 W HBHCZ
 Q
HDRXPAGE ; Print header with Page & xtra info
 S HBHCPAGE=HBHCPAGE+1
 W !?HBHCCOLM,">>> HBPC ",HBHCHEAD," Report <<<",?71,"Page: ",HBHCPAGE,!! I $D(HBHCHDRX) X HBHCHDRX W !!,"Run Date: ",HBHCTDY,! I $D(HBHCHDR) X HBHCHDR W !
 W HBHCZ
 Q
