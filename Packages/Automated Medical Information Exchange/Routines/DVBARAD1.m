DVBARAD1 ;RE-ADMISSION REPORT, PRINT DRIVER ; 1/23/91  7:37 AM
 ;;2.7;AMIE;**17**;Apr 10, 1995
 ;
 S ZX="PENSION   ",ZY="A & A     "
 S MSG="" F ZZ=1:1:7 S MSG=MSG_ZX
 S MSG1="" F ZZ=1:1:7 S MSG1=MSG1_ZY
 U IO K DVBAQUIT
 F DVBAT="PEN","A&A" W:((IOST?1"C-".E)!(IOST'?1"P-OTHER".E)) @IOF W !!!!!!!!!! D PRINT Q:$D(DVBAQUIT)
 G KILL
 ;
PRINTB S DATA1=$S($D(^TMP("DVBA",DVBAT,$J,XCN,XCFLOC,K,DA,"LADM")):^("LADM"),1:"") S (LADMDT,ADMDT)=$P(DATA1,U),LTDIS=$P(DATA1,U,2),DFN=DA,QUIT1=1 K DATA1 D ADM^DVBAVDPT K QUIT1,DVBAQ
 S LBEDSEC=BEDSEC,LDIAG=DIAG,LDCHGDT=DCHGDT,ADMDT=$P(DATA,U),RCVAA=$P(DATA,U,2),RCVPEN=$P(DATA,U,3),CNUM=$P(DATA,U,4),TDIS=$P(DATA,U,5) D ADM^DVBAVDPT
 S RCVPEN=$S(RCVPEN=0:"NO",RCVPEN=1:"YES",1:"Not specified"),RCVAA=$S(RCVAA=0:"NO",RCVAA=1:"YES",1:"Not specified")
 W @IOF,!!!,?(80-$L(HEAD)\2),HEAD,!,?(80-$L(HEAD1)\2),HEAD1,!,?(80-$L(HEADDT)\2),HEADDT,!!!
 S:ADMDT]"" ADMDT=$$FMTE^XLFDT(ADMDT,"5DZ")
 S:DCHGDT]"" DCHGDT=$$FMTE^XLFDT(DCHGDT,"5DZ")
 S:LADMDT]"" LADMDT=$$FMTE^XLFDT(LADMDT,"5DZ")
 S:LDCHGDT]"" LDCHGDT=$$FMTE^XLFDT(LDCHGDT,"5DZ")
 W "Patient: ",PNAM,?60,"SSN: ",SSN,!,"Claim #: ",CNUM,?56,"Pension: ",RCVPEN,!,"Claim Folder Loc: ",CFLOC,?60,"A&A: ",RCVAA,! D ELIG F LINE=1:1:80 W "="
 W !?26,"------- Admission data -------",!!?18,"Current",?57,"Prior",!,?18,"-------",?57,"-----",!
 W ?(25-$L(ADMDT)),ADMDT,?26,"------ Admission date -------  ",LADMDT,!
 W ?(25-$L(DIAG)),$E(DIAG,1,26),?26,"---- Admitting diagnosis ----  ",$E(LDIAG,1,23),!
 W ?(25-$L(DCHGDT)),DCHGDT,?26,"------- Discharge date ------- ",LDCHGDT,!
 W ?(25-$L(TDIS)),$E(TDIS,1,26),?26,"------- Discharge type ------- ",$E(LTDIS,1,23),!
 W ?(25-$L(BEDSEC)),BEDSEC,?26,"-------- Bed Service --------- ",LBEDSEC,!
 I IOST?1"C-".E W *7,!,"Press RETURN to continue or ""^"" to stop    " R ANS:DTIME S:ANS=U!('$T) XCN="ZZZZ" I '$T S DVBAQUIT=1
 Q
 ;
PRINT S NODTA=1 S (XCN,XCFLOC,ANS)=""
 I $D(^TMP("DVBA",DVBAT,$J)) F XLINE=1:1:5 W ?5,$S(DVBAT="PEN":MSG,DVBAT="A&A":MSG1,1:""),!!
 F DVBAM=0:0 S XCN=$O(^TMP("DVBA",DVBAT,$J,XCN)) Q:XCN=""  F J=0:0 S XCFLOC=$O(^TMP("DVBA",DVBAT,$J,XCN,XCFLOC)) Q:XCFLOC=""  F K=0:0 S K=$O(^TMP("DVBA",DVBAT,$J,XCN,XCFLOC,K)) Q:K=""  D PRINTC
 Q
 ;
PRINTC F DA=0:0 S DA=$O(^TMP("DVBA",DVBAT,$J,XCN,XCFLOC,K,DA)) Q:DA=""  S DATA=^(DA) D PRINTB
 Q
 ;
KILL K ^TMP("DVBA","A&A",$J),^TMP("DVBA","PEN",$J)
 D ^%ZISC S X=7 D:$D(ZTQUEUED) KILL^%ZTLOAD G FINAL^DVBAUTIL
 ;
ELIG S ELIG=DVBAELIG,INCMP=0
 W "Eligibility: "
 I ELIG]"" S ELIG=ELIG_" ("_$S(DVBAELST="P":"Pend Ver",DVBAELST="R":"Pend Re-verif",DVBAELST="V":"Verified",1:"Not Verified")_")"
 I $D(^DPT(DA,.29)),$P(^(.29),U,1)]"" S INCMP=1 ;date ruled incomp, VA
 I $D(^DPT(DA,.29)),$P(^(.29),U,12)=1 S INCMP=1 ;ruled incomp field
 W ELIG_$S(ELIG]"":", ",1:"") W:$X>60 !?14 W $S(INCMP=1:"Incompetent",1:""),!
