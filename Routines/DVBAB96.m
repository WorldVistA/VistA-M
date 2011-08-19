DVBAB96 ;ALB/SPH - CAPRI CONVERSION OF DVBCUTL2 FOR SUPPORT ;09/11/00
 ;;2.7;AMIE;**35**;Apr 10, 1995
 ;
KILL K %ZIS,BY,COLUMN,DVBCDT(0),EXAM,EXAMNM,HIST,FF,LABEL,LEVEL,LOC,MA,MB,NFINAL,NODE,OLDEXAM,OUT,PDATE,PDTA,PIECE,REAS,STAT1,TYPE,X1,X2,XDR,XST,JIJ,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZW,JJY,VX,ADIV,ADIVNUM,DVBCDD,EDAYS,HEAD,HEAD2,ULINE,IO("Q")
 K EXHD,XMTEXT,ZTDTH,OUT,CANC,DOTS,L,MG,REASON,SEND,XEXAM,XMDUZ,XMSUB,XMY,%X,%Y,JFLD,JX,JDR,DTREL,DTREQ,DTRQCMP,DTSCHEDC,DTTRANS,EDATE,ER,EXDATE,EXSTAT,RQSTAT,SBULL,TOT,XDT,XMDISPI,XMKK,XMLOC,XMLOCK,XMQF,XMR,XMT,XMTYP,XMZ,%H,K,NODATA,PNAM
 K ANS,BDATE,PROCDT,QQ,RDATE,REQSTR,SADIV,OLDY,RQDT,RQDT2,PGM,SDATE,SDATE1,SDATE2,EDATE,EDATE1,EDATE2,CMPDIV,BY1,DAYS,FAX,PRTDIV,XMMG,ADEQ,EXMNM,PRTDATE,RUNDATE,RPTSITE,FEXAM,XSTAT,JZ,ZPR,REQDA,DVBCDT,FDT,RN,XIX,DVBCZ,EXDT,AGE
 K COMP,DTOUT,DTSCH,DTSCH2,LNE,PG,PHYS,EXDA,DVBCDIV,%W,PRTNM,DIVNM,AW,AX,AY,BDATE1,CANDT,COL,DVBCJ,DVBCSEQ,DVBCSITE,ELTYP,EXPTR,EXSTAT,HD3,HEAD3,JJZ,JK,LVL,LX,NAME,OLDDA1,ORVP,PG,PRBY,RELBY,SEQNUM,TOTAL,TXT,TYP,DVBCXJI,PNM,PREF,NARR
 G KILL^DVBCUTL3
 ;
DDIS1 ;display rated disabilities
 S ZMSG(DVBABCNT)="  "_DX_"  "_$J(PCT,3,0)_" %"_"  "_$S(SC=1:"Yes",1:"No")_"  "_DXCOD,DVBABCNT=DVBABCNT+1
 Q
 ;
DDIS I '$D(^DPT(DFN,.372)) S ZMSG(DVBABCNT)="No rated disabilities on file",DVBABCNT=DVBABCNT+1 Q
 ;W ZMSG(DVBABCNT)="  Rated Disability"_"  "_"Percent"_,?50,"SC ?",?58,"Dx Code",! W ?2 F LINE=1:1:63 W "-"
 W !! F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:I=""  S DXNUM=$P(^DPT(DFN,.372,I,0),U,1),PCT=$P(^(0),U,2),SC=$P(^(0),U,3),DX=$S($D(^DIC(31,DXNUM)):$P(^(DXNUM,0),U,1),1:"Unknown"),DXCOD=$S($D(^DIC(31,DXNUM)):$P(^(DXNUM,0),U,3),1:"Unknown") D DDIS1
 W !! Q
 ;
HDR2 W @IOF,!,"C&P Final Report",?71,"Page: ",PG,!!,"Name: ",PNAM,?38,"SSN: ",SSN,?60,"C-number: ",CNUM,!,EXHD,!
 F ZI=1:1:80 W "="
 W !
 Q
 ;
HDR3 W @IOF,!,"C&P Reprint of Final Report",?71,"Page: ",PG,!!,"Name: ",PNAM,?38,"SSN: ",SSN,?60,"C-number: ",CNUM,!,EXHD,!
 F ZI=1:1:80 W "="
 W !
 Q
 ;
DUZ2 ;select station number
 S DVBCD2=$S($D(^DIC(4,DUZ(2),99)):$P(^(99),U,1),1:0)
 Q
 ;
TST F DA=0:0 S DA=$O(^DVB(396.4,"C",DA(1),DA)) Q:DA=""  K PRINT S TSTAT=$P(^DVB(396.4,DA,0),U,4),TST=$P(^DVB(396.4,DA,0),U,3),PRTNM=$S($D(^DVB(396.6,TST,0)):$P(^(0),U,2),1:"") D TST1
 Q
TST1 S TSTA1=""
 I $D(^DVB(396.4,DA,"CAN")) S TSTA1=$P(^DVB(396.4,DA,"CAN"),U,3)
 I $D(^DVB(396.4,DA,"TRAN")) S X=$P(^DVB(396.4,DA,"TRAN"),U,3)
 S:TSTA1]"" TSTA1=$P(^DVB(396.5,TSTA1,0),U,1) ;tsta1=cancellation reason
 W:($L(PRTNM)+$L(TSTA1)+$X)>55 !?3 S ZMSG(DVBABCNT)=$S(PRTNM]"":PRTNM,1:"Missing exam name")_$S(TSTA1]"":" - cancelled ("_TSTA1_")",TSTAT="T":" - Transferred",TSTAT="":" (Unknown status)",1:""),DVBABCNT=DVBABCNT+1
 I TSTAT="T" S X=$S($D(^DIC(4.2,+X,0)):$P(^(0),U,1),1:"unknown site") S ZMSG(DVBABCNT)=" to "_$P(X,".",1)_";",DVBABCNT=DVBABCNT+1
 W "; "
 Q
 ;
RQCODE ; ** Cancel an entire 2507 request after cancellation of last exam **
 N LASTTME
 S LASTTME=$O(^TMP("DVBA",$J,""))
 S CCODE=^TMP("DVBA",$J,LASTTME)
 D BULL^DVBCCNC1
 Q
 ;
PROCDAY(REQDA) ; ** Calculate processing time for REQDA (v2.7 - Enhc 13)
 ;** NOTICE: This tag is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;**  PROCDAY receives the variable REQDA as the IEN of the 2507
 ;**   request to calculate the processing time for
 ;**  Processing time returned to calling routine via PROCTME
 ;
 N STOPDT,STARTDT,LSORVTRS,PRESTRT,DAY30CUT,PROCTME,ADJTME
 N LPDT,LPDA,FSDTVTRS,LINKNODE
 S (STOPDT,STARTDT,LSORVTRS,PRESTRT,FSDTVTRS)=0
 ;
 ;** FSDTVTRS is earliest date on 396.95 rec of
 ;**  Current and Vet Resch dates
 ;** Find FSDTVTRS for each 396.95 rec, PRESTRT is latest FSDTVTRS of
 ;**  all 396.95 recs for request
 S LPDT=""
 F  S LPDT=$O(^DVB(396.95,"ARO",REQDA,LPDT)) Q:LPDT=""  DO
 .F LPDA=0:0 S LPDA=$O(^DVB(396.95,"ARO",REQDA,LPDT,LPDA)) Q:LPDA=""  DO
 ..S STOPDT=LPDT ;**Find the last original appt date (equals Stop Date)
 ..S LINKNODE=^DVB(396.95,LPDA,0)
 ..I +$P(LINKNODE,U,4)=1 DO  ;**FSDTVTRS=earliest of fields .03 and .05
 ...S LSORVTRS=$P(LINKNODE,U,2) ;**'ARO' - Original; Vet rsch date latest
 ...I $P(LINKNODE,U,3)<$P(LINKNODE,U,5) S FSDTVTRS=$P(LINKNODE,U,3)
 ...I $P(LINKNODE,U,3)'<$P(LINKNODE,U,5) S FSDTVTRS=$P(LINKNODE,U,5)
 ...S:FSDTVTRS>PRESTRT PRESTRT=FSDTVTRS ;**PRESTRT=latest FSDTVTRS
 ;
 ;** Calculate the Start Date
 S PRESTRT=PRESTRT\1
 S LSORVTRS=LSORVTRS\1
 S STOPDT=STOPDT\1
 S X1=LSORVTRS S X2=30 D C^%DTC S DAY30CUT=X K X,X1,X2 ;**30 day cut off
 ;
 ;** Find clock start date
 ;** (Start can't be >30 days from latest original date on an
 ;     appt reschd by vet)
 S:DAY30CUT<PRESTRT STARTDT=DAY30CUT
 S:DAY30CUT'<PRESTRT STARTDT=PRESTRT
 S:STARTDT>$P(^DVB(396.3,REQDA,0),U,14)\1 STARTDT=$P(^DVB(396.3,REQDA,0),U,14)\1
 S X1=STARTDT,X2=STOPDT D ^%DTC S ADJTME=X K X,X1,X2 ;**Days to subtract
 S X2=($P(^DVB(396.3,REQDA,0),U,5)\1)
 S X1=($P(^DVB(396.3,REQDA,0),U,14)\1)
 D ^%DTC S PROCTME=X S:+ADJTME>0 PROCTME=PROCTME-ADJTME
 K X,X1,X2
 Q PROCTME
