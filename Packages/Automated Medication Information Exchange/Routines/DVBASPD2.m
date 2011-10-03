DVBASPD2 ;ALB/GTS-557/THM,SBW-AMIE SPECIAL REPORT ; 3/MAY/2011
 ;;2.7;AMIE;**3,57,149,168**;Apr 10, 1995;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 K ^TMP($J) G TERM
SET Q:'$D(^DPT(DA,0))  S DFN=DA D RCV^DVBAVDPT Q:RCVPEN'=1&(REP="P")  Q:RCVAA'=1&(REP="A")  Q:CFLOC'=RONUM&(RO="Y")&(CFLOC'=0)&(CFLOC'=376)
 S DCHPTR=$P(^DGPM(MB,0),U,17),TDIS=$S($D(^DGPM(+DCHPTR,0)):$P(^(0),U,18),1:"")
 I +TDIS,'$D(^TMP("DVBA",$J,"DUP",+TDIS)) Q
 S TDIS=$S($P($G(^DG(405.2,+TDIS,0)),U,1)]"":$P(^(0),U,1),1:"Unknown discharge type")
 S ^TMP($J,XCN,CFLOC,MB,DA)=MA_U_RCVAA_U_RCVPEN_U_CNUM_U_TDIS
 Q
 ;
PRINTB W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 W !!!,?(80-$L(HEAD)\2),HEAD,!,?(80-$L(HEAD1)\2),HEAD1,!!
 W ?10,REP(0),?26,PNAM,!!,?14,REP(1),?26,CNUM,!,?6,REP(2),?26,XCFLOC,!,?9,REP(3),?26,SSN,!,?8,REP(4),?26,ADMDT,!,?3,REP(5),?26,DIAG,!
 W ?8,REP(6),?26,DCHGDT,! W:DCHGDT]"" ?5,REP(7),?26,$$DIS,!
 W ?11,REP(8),?26,BEDSEC,!,?13,REP(9),?26,$$RAA,!
 W ?14,REP(10),?26,$$PEN,! D ELIG^DVBAVDPT
 I IOST?1"C-".E W *7,!,"Press RETURN to continue or ""^"" to stop    " R ANS:DTIME S:ANS=U!('$T) QUIT=1 I '$T S DVBAQUIT=1 I '$T S DVBAQUIT=1
 S DVBAON2=""
 Q
RAA() Q $S(RCVAA=0:"NO",RCVAA=1:"YES",1:"Not specified")
PEN() Q $S(RCVPEN=0:"NO",RCVPEN=1:"YES",1:"Not specified")
DIS() Q TDIS_$S(TO]"":" TO "_$S($D(^DIC(4,+TO,0)):$P(^(0),U,1),1:""),1:"")
SP(N,M) S $P(M," ",N-1)=" " Q M  ;pass one arg, 2nd for local use
PRINTC F J=0:1:7 S ^TMP("DVBSPCRP",$J,DVBC+J)=DVBS(J) ;NakedRefs = ^TMP("DVBSPCRP",$J,DVBC+J)
 S DVBC=DVBC+6,^TMP("DVBSPCRP",$J,DVBC)=$$SP(10)_REP(0)_PNAM
 S ^(DVBC+2)=$$SP(14)_REP(1)_CNUM
 S ^(DVBC+3)=$$SP(6)_REP(2)_XCFLOC
 S ^(DVBC+4)=$$SP(9)_REP(3)_SSN
 S ^(DVBC+5)=$$SP(8)_REP(4)_ADMDT
 S ^(DVBC+6)=$$SP(3)_REP(5)_DIAG
 S DVBC=DVBC+7,^(DVBC)=$$SP(8)_REP(6)_DCHGDT
 I DCHGDT]"" D
 .S DVBC=DVBC+1,^(DVBC)=$$SP(5)_REP(7)_$$DIS
 S ^(DVBC+1)=$$SP(11)_REP(8)_BEDSEC
 S ^(DVBC+2)=$$SP(13)_REP(9)_$$RAA
 S DVBC=DVBC+3,^(DVBC)=$$SP(14)_REP(10)_$$PEN
 D ELIG^DVBAVDPT
 Q
 ;
PRINTD ;print delimited special report
 N ELIG,INCMP,DVBADATA,DVBABRKER
 S DVBABRKER=$$BROKER^XWBLIB
 S ELIG=DVBAELIG,INCMP=""
 I ELIG]"" S ELIG=ELIG_" ("_$S(DVBAELST="P":"Pend Ver",DVBAELST="R":"Pend Re-verif",DVBAELST="V":"Verified",1:"Not Verified")_")"
 I $D(^DPT(DA,.29)) S INCMP=$S($P(^(.29),U,12)=1:"Incompetent",1:"")
 I INCMP]"",ELIG]"" S ELIG=ELIG_", "_INCMP
 D:('DVBADHDR) COLHDR
 S DVBADATA=PNAM_DVBADLMTR_CNUM_DVBADLMTR_XCFLOC_DVBADLMTR
 S DVBADATA=DVBADATA_SSN_DVBADLMTR_ADMDT_DVBADLMTR_DIAG_DVBADLMTR_DCHGDT_DVBADLMTR
 S DVBADATA=DVBADATA_$S(DCHGDT]"":$$DIS,1:"")_DVBADLMTR_BEDSEC_DVBADLMTR
 S DVBADATA=DVBADATA_$$RAA_DVBADLMTR_$$PEN_DVBADLMTR_ELIG
 D:DVBABRKER
 .S ^TMP("DVBSPCRP",$J,DVBC)=DVBADATA,DVBC=DVBC+1
 D:('DVBABRKER)
 .W !,DVBADATA
 Q
 ;
PRINT S QUIT="",XCN=""
 F  S XCN=$O(^TMP($J,XCN)) Q:XCN=""!(QUIT=1)  S XCFLOC="" F  S XCFLOC=$O(^TMP($J,XCN,XCFLOC)) Q:XCFLOC=""!(QUIT=1)  D PRINT1
 Q
PRINT1 S ADM="" F  S ADM=$O(^TMP($J,XCN,XCFLOC,ADM)) Q:ADM=""!(QUIT=1)  D
 .S DA="" F  S DA=$O(^TMP($J,XCN,XCFLOC,ADM,DA)) Q:DA=""!(QUIT=1)  D
 ..S DATA=^(DA),MA=$P(DATA,U),RCVAA=$P(DATA,U,2),RCVPEN=$P(DATA,U,3)
 ..S CNUM=$P(DATA,U,4),TDIS=$P(DATA,U,5),DFN=DA,TO="",QUIT1=1
 ..D ADM^DVBAVDPT
 ..S:ADMDT]"" ADMDT=$E(ADMDT,4,5)_"/"_$E(ADMDT,6,7)_"/"_$E(ADMDT,2,3)
 ..S:DCHGDT]"" DCHGDT=$E(DCHGDT,4,5)_"/"_$E(DCHGDT,6,7)_"/"_$E(DCHGDT,2,3)
 ..I $$BROKER^XWBLIB D @$S(($G(DVBADLMTR)=""):"PRINTC",1:"PRINTD") Q
 ..D @$S(($G(DVBADLMTR)=""):"PRINTB",1:"PRINTD")
 Q
SETUP S RPT="VARO REPORT"_$S(REP="A":" FOR A & A",1:" FOR PENSION"),DTAR=^DVB(396.1,1,0),FDT(0)=$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)
 S HEAD="SPECIAL "_$S(REP="A":"A & A",1:"PENSION")_" REPORT",HEAD1="FOR "_$P(DTAR,U,1)_" ON "_FDT(0)
 S Y=$P(DTAR,U,9) X ^DD("DD") S REP("LRUN")="Last report was run on "_Y
 S REP(0)="Patient Name:",REP(1)="Claim No:"
 S REP(2)="Claim Folder Loc:",REP(3)="Social Sec No:"
 S REP(4)="Admission Date:",REP(5)="Admitting Diagnosis:"
 S REP(6)="Discharge Date:",REP(7)="Type of Discharge:"
 S REP(8)="Bed Service:",REP(9)="Recv A&A?:",REP(10)="Pension?:"
 Q
TERM D HOME^%ZIS,SETUP K NOASK
 W @IOF,!,RPT,!,HEAD1
 ;
EN1 W !!,"Please enter dates for search, oldest date first, most recent date last.",!!,REP("LRUN"),!!
 D DATE^DVBAUTIL
 G:X=""!(Y<0) KILL
 S %ZIS="Q" D ^%ZIS K %ZIS G:POP KILL^DVBAUTIL
 ;
QUEUE I $D(IO("Q")) S ZTRTN="DEQUE^DVBASPD2",ZTIO=ION,NOASK=1,ZTDESC="AMIE PENSION/A&A REPORT" F I="^TMP(""DVBA"",$J,""DUP"",","DVBATYPS","REP","FDT(0)","HEAD","HEAD1","BDATE","EDATE","TYPE","RO","RONUM","NOASK" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",!! G KILL
 ;
GO S MA=BDATE F  S MA=$O(^DGPM("AMV1",MA)) Q:$P(MA,".")>EDATE!(MA="")  W:'$D(NOASK) "." F DA=0:0 S DA=$O(^DGPM("AMV1",MA,DA)) Q:DA=""  F MB=0:0 S MB=$O(^DGPM("AMV1",MA,DA,MB)) Q:MB=""  D SET
 S:'$D(^TMP($J)) ER="No data found for parameters entered."
 G:$$BROKER^XWBLIB BROKER
 U IO I $D(ER) W !!,*7,ER,!! G KILL
 D PRINT
 I $D(DVBAQUIT) D:$D(ZTQUEUED) KILL^%ZTLOAD K ER,DVBAON2 G KILL^DVBAUTIL
 ;
KILL D ^%ZISC D:$D(ZTQUEUED) KILL^%ZTLOAD S X=9 K ER,DVBAON2 G FINAL^DVBAUTIL
 ;
INIT ;add header info to report
 I ($G(DVBADLMTR)'="") D  Q  ;no header info for delimited report
 .S DVBC=1
 F J=0,2,5,6,7 S DVBS(J)=" "
 S $P(DVBS(1),"-",70)="-",DVBS(3)=$$SP(70-$L(HEAD)\2)_HEAD,DVBS(4)=$$SP(70-$L(HEAD1)\2)_HEAD1
 S ^TMP("DVBSPCRP",$J,1)=" ",^(2)=RPT,^(3)=HEAD1,^(4)=" ",^(5)=REP("LRUN"),DVBC=6
 F J=0:1:10 S REP(J)=REP(J)_"    "
 Q
BROKER I $D(ER) K ^TMP("DVBSPCRP",$J) S ^($J,1)=ER
 E  D INIT,PRINT
 S X=9 G FINAL^DVBAUTIL
 ;
 ;Input: DVBADLMTR - Indicates if report should be delimited (Optional)
SPECRPT(ZMSG,DCTYPES,BDATE,EDATE,RONUM,REP,DVBADLMTR)      ;
 N I,J,REQ,DVBC,DVBACEPT,DVBS,ER,DVBADHDR
 S DVBADLMTR=$S('+$G(DVBADLMTR):"",1:"^"),DVBADHDR=0
 ; If RONUM not passed set value to "0" (zero) in order to include data
 ; for all regional offices
 I $G(RONUM)']"" S RONUM=0
 S ZMSG=$NA(^TMP("DVBSPCRP",$J)),REQ=" IS REQUIRED"
 S MB=" MUST BE ",TYPE="REPORT TYPE",BDT="BEGINNING DATE",EDT="ENDING DATE"
 I $G(BDATE)="" S ER=BDT_REQ
 I $G(EDATE)="" S ER=EDT_REQ
 I EDATE<BDATE S ER=BDT_MB_"BEFORE THE "_EDT
 I $G(REP)="" S ER=TYPE_REQ
 I "^A^P"'[REP S ER=TYPE_MB_"'A' OR 'P'"
 ;Only validate RONUM to be valid Station Number if it isn't zero
 I RONUM'="0"&(RONUM'?3N.4AN) S ER="REGIONAL OFFICE"_MB_"3 NUMBERS + OPTIONAL 1 TO 4 MODIFIER (MAX 7 CHARACTERS)"
 K ^TMP("DVBSPCRP",$J) I $D(ER) S ^($J,1)=ER,X=9 G FINAL^DVBAUTIL
 ;If RONUM = 0 then RO set to "N" to include data for all ROs
 ;If RONUM passed then RO set to "Y" to include data for only passed RO
 S (NOASK,DVBACEPT)=1,RO=$S(RONUM=0:"N",1:"Y")
 F J=0:0 S J=$O(DCTYPES(J)) Q:'J  S ^TMP("DVBA",$J,"DUP",DCTYPES(J))=""
 D SETUP
DEQUE K ^TMP($J) G GO
 ;
COLHDR ;Column header for delimited report
 N DVBACHDR,DVBABRKER
 S DVBABRKER=$$BROKER^XWBLIB
 S DVBACHDR="Patient Name"_DVBADLMTR_"Claim No"_DVBADLMTR_"Claim Folder Loc"_DVBADLMTR
 S DVBACHDR=DVBACHDR_"Social Sec No"_DVBADLMTR_"Admission Date"_DVBADLMTR_"Admitting Diagnosis"_DVBADLMTR
 S DVBACHDR=DVBACHDR_"Discharge Date"_DVBADLMTR_"Type of Discharge"_DVBADLMTR_"Bed Service"_DVBADLMTR
 S DVBACHDR=DVBACHDR_"Recv A&A?"_DVBADLMTR_"Pension?"_DVBADLMTR_"Eligibility Data"
 S:DVBABRKER ^TMP("DVBSPCRP",$J,DVBC)=DVBACHDR,DVBC=DVBC+1
 D:('DVBABRKER)
 .W !,DVBACHDR
 S DVBADHDR=1  ;set so header info only printed once
 Q
