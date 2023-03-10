IBCNBOA ;ALB/ARH - Ins Buffer: Activity Report ; 1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,305,528,602,702**;21-MAR-94;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;get parameters then run the report
 ;
 ; IB*702 initialize variables
 N IBBA,IBBB,IBBC,IBBD,IBBEG,IBBEGEX,IBBENEX,IBBUFEM,IBBUFEME,IBBUFSD,IBBUFSM,IBBUFSME
 N IBCO,IBCUR,IBCURFM,IBEDDT,IBEND,IBHDR,IBMONTH,IBOK,IBOUT,IBSTDT
 K ^TMP($J)
 ;
 S IBHDR="INSURANCE BUFFER ACTIVITY REPORT" W @IOF,!!,?25,IBHDR
 W !!,"This report contains the counts and time statistics for all activity in the"
 W !,"Insurance Buffer.",!!
 ;
 ;IB*702/DTG Change question flow, month first, if not month then dates. 
 ; Rewrote month and date prompt, plus behavior with the "^" throughout the routine.
 ;S IBBEG=$$DATES^IBCNBOE("Beginning") G:'IBBEG EXIT
 ;S IBEND=$$DATES^IBCNBOE("Ending",IBBEG) G:'IBEND EXIT  W !!
 ;S IBMONTH=$$MONTH^IBCNBOE G:IBMONTH="" EXIT  W !!
 ;
10 ; ask Previous Completed month
 S IBMONTH=$$MONTH^IBCNBOE G:IBMONTH="" EXIT
 ;W !!
 ;
 S (IBBEG,IBEND,IBSTDT,IBEDDT,IBCO,IBBUFSM,IBBUFSME,IBBUFEM,IBBUFEME,IBBUFSD)=""
 ;get current month/year
 S IBCURFM=$E(DT,1,5),IBCUR=$$EXMON(IBCURFM)
 ;
 I IBMONTH S IBOK=0 D  I 'IBOK G 10
 . ; get buffer starting month/year
 . S IBBUFSD=$O(^IBA(355.33,"B",0))
 . I 'IBBUFSD W !,"May Not run Month option since there is not a complete 'Month Year'" Q
 . I IBBUFSD D
 . . ; check if first date is complete month
 . . S IBBC=+$E(IBBUFSD,6,7),IBBB=$E(IBBUFSD,1,3) I IBBC'=1 D  ;<
 . . . ; get first day of next month
 . . . S IBBA=+$E(IBBUFSD,4,5)+1 S:$L(IBBA)=1 IBBA="0"_IBBA I IBBA>12 D
 . . . . S IBBB=$E(IBBUFSM,1,3)+1,IBBA="01"
 . . . S IBBD=IBBB_IBBA_"00.999999",IBBUFSD=$O(^IBA(355.33,"B",IBBD))
 . S IBBUFSM=$E(IBBUFSD,1,5)
 . I IBBUFSM'="" S IBBUFSME=$$EXMON(IBBUFSM)
 . I IBBUFSM'=""&((IBBUFSM=IBCURFM)!(IBBUFSM>IBCURFM)) D  S IBOK=0 Q
 . . W "May Not run Month option since the buffer start is the current 'Month Year' "_IBCUR
 . ; get buffer ending month/year prior to current month/year
 . S IBBUFEM=$O(^IBA(355.33,"B",(IBCURFM_"01.000000")),-1),IBBUFEM=$E(IBBUFEM,1,5)
 . I IBBUFEM="" W "Incomplete ending buffer entries" S IBOK=0 Q
 . S IBBUFEME=$$EXMON(IBBUFEM)
 . S IBOK=1
 ;
109 ; come here for dates if going back
 ;
 ; month dates
 I IBMONTH S (IBOK,IBCO)=0 D  I 'IBOK G:IBCO=2 EXIT G 10
 . D 11 I 'IBCO!(IBCO=2) Q
 . S IBOK=1
 ;
 ; daily dates
 I 'IBMONTH S (IBOK,IBCO)=0 D  I 'IBOK G:IBCO=2 EXIT G 10
 . D 21 I 'IBCO!(IBCO=2) Q
 . S IBOK=1
 ;
30 ; report or excel
 S IBOUT=$$OUT^IBCNBOE I IBOUT="" G:$$STOP^IBCNINSU EXIT  G 109
 I IBOUT="E" W !!,"To avoid undesired wrapping, please enter '0;256;999' at the 'DEVICE:' prompt.",!
 ;
 ; IB*702/DTG tweaked device prompt
DEV ;get the device
 N POP,ZTDESC,ZTRTN,ZTSAVE
 S ZTRTN="RPT^IBCNBOA",ZTDESC=IBHDR,ZTSAVE("IB*")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 I POP G:$$STOP^IBCNINSU EXIT  G 30
 Q
 ;
11 ; starting month ; IB*702
 ;
 ; starting date
 S IBCO=0,IBSTDT=$$IBSM("Beginning","")
 I 'IBSTDT S:$$STOP^IBCNINSU IBCO=2 Q
 S IBBEGEX=$P(IBSTDT,U,2),IBSTDT=$P(IBSTDT,U,1)
 S IBBEG=IBSTDT_"01"
 ;
12 ; ending month ; IB*702
 ;
 W !
 S IBEDDT=$$IBSM("Ending",IBSTDT)
 S IBBENEX=$P(IBEDDT,U,2),IBEDDT=$P(IBEDDT,U,1)
 I 'IBEDDT G:'$$STOP^IBCNINSU 11 S IBCO=2 Q
 S IBEND=$$LAST^IBAGMM(IBEDDT)
 S IBCO=1
 Q
 ;
21 ; starting date ; IB*702
 ;
 S IBBEG=$$DATES^IBCNBOE("Beginning") I 'IBBEG S:$$STOP^IBCNINSU IBCO=2 Q
 ;
22 ; ending date ; IB*702
 ;
 W !
 S IBEND=$$DATES^IBCNBOE("Ending",IBBEG) I 'IBEND G:'$$STOP^IBCNINSU 21 S IBCO=2 Q
 S IBCO=1
 Q
 ;
IBSM(IBLABEL,IBSTDT) ; START/END MONTH ; IB*702
 ; IBLABEL - starting or ending month
 ; IBSTDT - starting month year in FM form
 ;
 N DIR,DIRUT,DUOUT,DTOUT,IBB,IBD,IBL,IBNDT,X,Y
 ;
 S IBD="",IBNDT=$S(IBSTDT'="":IBSTDT,1:IBBUFSM),IBB=$$EXMON($E(IBNDT,1,5))
 I $E(IBLABEL,1,3)="Beg" D
 . W !!,"Future dates are not allowed and the month selected cannot be later than"
 . W !,"the previous month."
 . W !,"The month selected must be a complete/full month. The current 'Month Year'"
 . W !,"of ("_IBCUR_") is not allowed.",!
IBSMA ; skip back tag
 S DIR("?",1)="Enter the "_IBLABEL_" 'Month Year' for the range to be reported."
 S DIR("?",2)="Use the Form 'MM YYYY' or '^' to Quit."
 S DIR("?",3)="The month selected cannot be later than the previous month."
 S DIR("?",4)="The month selected must be a complete/full month."
 S DIR("?")="The current 'Month Year' of "_IBCUR_" is not allowed."
 S DIR("A")=$G(IBLABEL)_" Month Year (Ex. January 2021)"
 S DIR(0)="DO^::EM"
 D ^DIR
 I Y="" W *7,!,"Please enter the "_IBLABEL_" Month Year or '^' to Quit.",! G IBSMA
 I $D(DIRUT)!$D(DUOUT)!$D(DTOUT) S IBD="" G IBSMX
 S IBD=$E(Y,1,5) I IBD="" G IBSMX
 S IBL=$G(Y(0)) I IBL="" S IBL=$E(IBD,4,5)_" "_($E(IBD,1,3)+1700)
 ; check range(s)
 I IBD=IBCURFM W !,*7,"May Not Select current 'Month Year' "_IBCUR_".",! G IBSMA
 I IBD>IBCURFM W !,*7,"Future Dates are not allowed.",!  G IBSMA
 I IBD<IBNDT W *7,!,"Month Year entered ("_IBL_") is less than minimum entry of ("_IBB_").",! G IBSMA
 S IBD=IBD_U_IBL
 ;
IBSMX ;  Exit subroutine
 Q IBD
 ;
EXMON(IBCHGDT) ; change FM year month to external 'month year'
 ;Input:
 ; IBCHGDT    - year month of FM date (ex: 32107)
 ;
 I IBCHGDT="" Q ""
 Q $P("JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC",",",+$E(IBCHGDT,4,5))_" "_($E(IBCHGDT,1,3)+1700)
 ;
 ;
RPT ; run report
 ;IB*702/TAZ - New variables used during processing.
 N IBQUIT,ZTQUEUED,ZTSTOP
 ;
 S IBQUIT=0
 ;
 ;Patch 305- QUIT in line below inserted for transmission to ARC
 D SEARCH(IBBEG,IBEND,IBMONTH) Q:$G(IBARFLAG)  G:IBQUIT EXIT
 D PRINT(IBBEG,IBEND,IBOUT)
 ;
EXIT ; exit report
 K ^TMP($J)
 Q
 ;
SEARCH(IBBEG,IBEND,IBMONTH) ; search/sort statistics for activity report
 ;IB*702/DTG remove IBVER for 'verified' logic
 ; N IBXST,IBXDT,IBBUFDA,IBB0,IBSTAT,IBTIME,IBS3,IBDATE,IBVER,IBDT2 S IBQUIT=""
 N IBXST,IBXDT,IBBUFDA,IBB0,IBSTAT,IBTIME,IBS3,IBDATE,IBDT2 S IBQUIT=""
 S IBBEG=$G(IBBEG)-.01,IBEND=$S('$G(IBEND):9999999,1:$P(IBEND,".")+.9)
 ;
 S IBXST="" F  S IBXST=$O(^IBA(355.33,"AFST",IBXST)) Q:IBXST=""  D   Q:IBQUIT
 . S IBXDT=+IBBEG F  S IBXDT=$O(^IBA(355.33,"AFST",IBXST,IBXDT)) Q:'IBXDT!(IBXDT>IBEND)  D  S IBQUIT=$$STOP Q:IBQUIT
 .. S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,"AFST",IBXST,IBXDT,IBBUFDA)) Q:'IBBUFDA  D
 ... ;
 ... ;IB*702/DTG remove Set IBVER for 'verified' logic
 ... ;S IBB0=$G(^IBA(355.33,IBBUFDA,0)),IBSTAT=$P(IBB0,U,4),IBVER=$P(IBB0,U,10)
 ... S IBB0=$G(^IBA(355.33,IBBUFDA,0)),IBSTAT=$P(IBB0,U,4)
 ... ;
 ... ; entered
 ... I IBXST="E" S IBDATE=+IBB0 I +IBDATE,IBDATE>IBBEG,IBDATE<IBEND D
 .... S IBDT2=+$P(IBB0,U,10) I 'IBDT2 S IBDT2=+$P(IBB0,U,5) I 'IBDT2 S IBDT2=$$NOW^XLFDT
 .... S IBTIME=+$$FMDIFF^XLFDT(IBDT2,IBDATE,2),IBSTAT="ENTERED",IBS3=1
 .... I +$G(IBMONTH) D SET(IBSTAT,$E(IBDATE,1,5),IBS3,IBTIME,IBB0)
 .... D SET(IBSTAT,99999,IBS3,IBTIME,IBB0)
 ... ;
 ... ;IB*702/DTG remove 'verified' logic
 ... ; verified
 ... ;I IBXST="V" S IBDATE=+$P(IBB0,U,10) I +IBDATE,IBDATE>IBBEG,IBDATE<IBEND D
 ... ;. ;S IBTIME=+$$FMDIFF^XLFDT(IBDATE,+IBB0,2),IBSTAT="VERIFIED",IBS3=2
 ... ;. ;I +$G(IBMONTH) D SET(IBSTAT,$E(IBDATE,1,5),IBS3,IBTIME,IBB0)
 ... ;. ;D SET(IBSTAT,99999,IBS3,IBTIME,IBB0)
 ... ;
 ... ; processed
 ... I IBXST="A"!(IBXST="R") S IBDATE=+$P(IBB0,U,5) I +IBDATE,IBDATE>IBBEG,IBDATE<IBEND D
 .... S IBDT2=+IBB0
 .... S IBTIME=+$$FMDIFF^XLFDT(IBDATE,+IBDT2,2),IBSTAT="UNKNOWN",IBS3=6
 .... ;IB*702/DTG remove &V and V
 .... ;I $P(IBB0,U,4)="A" S IBS3=3,IBSTAT="ACCEPTED" I 'IBVER S IBS3=4,IBSTAT=IBSTAT_" (&V)"
 .... ;I $P(IBB0,U,4)="R" S IBS3=5,IBSTAT="REJECTED" I +IBVER S IBS3=6,IBSTAT=IBSTAT_" (V)"
 .... I $P(IBB0,U,4)="A" S IBS3=3,IBSTAT="ACCEPTED"
 .... I $P(IBB0,U,4)="R" S IBS3=5,IBSTAT="REJECTED"
 .... I +$G(IBMONTH) D SET(IBSTAT,$E(IBDATE,1,5),IBS3,IBTIME,IBB0)
 .... D SET(IBSTAT,99999,IBS3,IBTIME,IBB0)
 ;
 Q
 ;
SET(STAT,S1,S3,TIME,IBB0) ;
 D TMP("IBCNBOA",S1,1,S3,TIME,STAT)
 I S3<3 D TMP("IBCNBOA",S1,2,1,TIME,"NOT PROCESSED")
 I S3>2 D TMP("IBCNBOA",S1,2,2,TIME,"PROCESSED")
 D TMP("IBCNBOA",S1,2,9,TIME,"TOTAL")
 ;
 Q:$E(STAT)'="A"
 ;
 D TMP1("IBCNBOAC",S1,+$P(IBB0,U,7),+$P(IBB0,U,8),+$P(IBB0,U,9))
 Q
 ;
TMP(XREF,S1,S2,S3,TIME,NAME) ;
 S ^TMP($J,XREF,S1,S2,S3)=NAME
 S ^TMP($J,XREF,S1,S2,S3,"CNT")=$G(^TMP($J,XREF,S1,S2,S3,"CNT"))+1
 S ^TMP($J,XREF,S1,S2,S3,"TM")=$G(^TMP($J,XREF,S1,S2,S3,"TM"))+TIME
 I '$G(^TMP($J,XREF,S1,S2,S3,"HG"))!($G(^TMP($J,XREF,S1,S2,S3,"HG"))<TIME) S ^TMP($J,XREF,S1,S2,S3,"HG")=TIME
 I '$G(^TMP($J,XREF,S1,S2,S3,"LS"))!($G(^TMP($J,XREF,S1,S2,S3,"LS"))>TIME) S ^TMP($J,XREF,S1,S2,S3,"LS")=TIME
 ; IB*702/DTG start call to set stubs
 D TMPCHK(XREF,S1,S2,S3,TIME,NAME)
 ; IB*702/DTG end call to set stubs
 Q
 ;
 ; IB*702/DTG start set stubs for item entries.
TMPCHK(XREF,S1,S2,S3,TIME,NAME) ; check if not there set stub for all if one is set
 ; use S1 (date), and S2 1 or 2
 N IBBI
 I S2=1 F IBBI=1,3,5 I $G(^TMP($J,XREF,S1,S2,IBBI))="" D
 . S ^TMP($J,XREF,S1,S2,IBBI)=$P("ENTERED,VERIFIED,ACCEPTED,,REJECTED",",",IBBI)
 . S ^TMP($J,XREF,S1,S2,IBBI,"CNT")=""
 . S ^TMP($J,XREF,S1,S2,IBBI,"TM")=""
 . I $G(^TMP($J,XREF,S1,S2,IBBI,"HG"))="" S ^TMP($J,XREF,S1,S2,IBBI,"HG")=""
 . I $G(^TMP($J,XREF,S1,S2,IBBI,"LS"))="" S ^TMP($J,XREF,S1,S2,IBBI,"LS")=""
 I S2=2 F IBBI=1,2,9 I $G(^TMP($J,XREF,S1,S2,IBBI))="" D
 . S ^TMP($J,XREF,S1,S2,IBBI)=$P("NOT PROCESSED,PROCESSED,,,,,,,TOTAL",",",IBBI)
 . S ^TMP($J,XREF,S1,S2,IBBI,"CNT")=""
 . S ^TMP($J,XREF,S1,S2,IBBI,"TM")=""
 . I $G(^TMP($J,XREF,S1,S2,IBBI,"HG"))="" S ^TMP($J,XREF,S1,S2,IBBI,"HG")=""
 . I $G(^TMP($J,XREF,S1,S2,IBBI,"LS"))="" S ^TMP($J,XREF,S1,S2,IBBI,"LS")=""
 Q
 ; IB*702/DTG end set stubs for item entries.
 ;
TMP1(XREF,S1,IC,GC,PC) ;
 I +IC S ^TMP($J,XREF,S1,"I")=$G(^TMP($J,XREF,S1,"I"))+1
 I +GC S ^TMP($J,XREF,S1,"G")=$G(^TMP($J,XREF,S1,"G"))+1
 I +PC S ^TMP($J,XREF,S1,"P")=$G(^TMP($J,XREF,S1,"P"))+1
 S ^TMP($J,XREF,S1,"CNT")=$G(^TMP($J,XREF,S1,"CNT"))+1
 Q
 ;
 ;
 ;
PRINT(IBBEG,IBEND,IBOUT) ;
 N IBXREF,IBLABLE,IBS1,IBS2,IBS3,IBINS,IBGRP,IBPOL,IBCNT,IBIP,IBGP,IBPP,IBRDT,IBPGN,IBRANGE,IBLN,IBI,IBHED
 ;
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 S IBRANGE=$S(IBMONTH:IBBEGEX,1:$$FMTE^XLFDT(+IBBEG))_" - "_$S(IBMONTH:IBBENEX,1:$$FMTE^XLFDT(IBEND))
 ;S IBRANGE=$$FMTE^XLFDT(+IBBEG)_" - "_$$FMTE^XLFDT(IBEND)
 S IBRDT=$$FMTE^XLFDT($J($$NOW^XLFDT,0,4),2),IBRDT=$TR(IBRDT,"@"," "),(IBLN,IBPGN)=0
 ; IB*702/DTG start Combine vars, no data check, end of report
 S IBXREF="IBCNBOA",IBS1=""
 S IBHED=$S(IBOUT="E":"PHDL",1:"HDR") D @IBHED
 I '$D(^TMP($J,IBXREF)) D  Q
 . W ! W:$G(IBOUT)="R" ?23 W "* * * N O  D A T A  F O U N D * * *",!
 . D EOR(80)
 . S IBI=$$PAUSE
 ;
 ; Excel output
 I IBOUT="E" D  S IBI=$$PAUSE Q
 . F  S IBS1=$O(^TMP($J,IBXREF,IBS1)) D:IBS1="" EOR(132) Q:IBS1=""  D
 .. D GETLABL ;IB*702/DTG Moved pre-existing code to new function
 .. S IBS2=0 F  S IBS2=$O(^TMP($J,IBXREF,IBS1,IBS2)) Q:IBS2=""  D
 ... S IBS3="" F  S IBS3=$O(^TMP($J,IBXREF,IBS1,IBS2,IBS3)) Q:'IBS3  D PRTLN
 .. ;
 .. D GETOAC ;IB*702/DTG Moved pre-existing code to new function
 .. W U_IBINS_U_IBIP_"%"_U_IBGRP_U_IBGP_"%"_U_IBPOL_U_IBPP_"%"
 ;
 F  S IBS1=$O(^TMP($J,IBXREF,IBS1)) D:IBS1="" EOR(80) Q:IBS1=""  D:IBLN>(IOSL-17) HDR Q:IBQUIT  D  S IBLN=IBLN+7
 . D GETLABL ;IB*702/DTG Moved pre-existing code to new function
 . W !,?(40-($L(IBLABLE)/2)),IBLABLE,!
 . W !,?43,"AVERAGE",?56,"LONGEST",?68,"SHORTEST"
 . W !,"STATUS",?22,"COUNT",?30,"PERCENT",?43,"# DAYS",?56,"# DAYS",?68,"# DAYS"
 . ;
 . S IBS2=0 F  S IBS2=$O(^TMP($J,IBXREF,IBS1,IBS2)) Q:IBS2=""  D  S IBLN=IBLN+1
 .. W !,"-----------------------------------------------------------------------------"
 .. S IBS3="" F  S IBS3=$O(^TMP($J,IBXREF,IBS1,IBS2,IBS3)) Q:'IBS3  D PRTLN  S IBLN=IBLN+1
 . ;
 . D GETOAC ;IB*702/DTG Moved pre-existing code to new function
 . W !!,?2,IBINS," New Compan",$S(IBINS=1:"y",1:"ies")," (",IBIP,"%), "
 . W IBGRP," New Group/Plan",$S(IBGRP=1:"",1:"s")," (",IBGP,"%), "
 . W IBPOL," New Patient Polic",$S(IBPOL=1:"y",1:"ies")," (",IBPP,"%)",!
 ;
 ; IB*702/DTG end Combine vars, no data check, end of report
 ;
 I 'IBQUIT S IBI=$$PAUSE
 Q
 ;
 ; IB*702/DTG start Combine parts for excel and report
 ;
GETLABL ; pick up common values for Excel and Report
 ;
 S IBLABLE=$S(IBS1=99999:"TOTALS",($E(IBBEG,1,5)<IBS1)&($E(IBEND,1,5)>IBS1):$$FMTE^XLFDT(IBS1_"00"),1:"")
 I IBLABLE="" D  ;<
 . S IBLABLE=$$FMTE^XLFDT($S($E(IBBEG,1,5)<IBS1:IBS1_"01",1:IBBEG))_" - "_$$FMTE^XLFDT($S($E(IBEND,1,5)>IBS1:$$SCH^XLFDT("1M(L)",IBS1_11),1:IBEND))
 . I $G(IBMONTH)&(IBLABLE["-") S IBLABLE=$$FMTE^XLFDT(IBS1_"00")
 Q
 ;
GETOAC ; pick up items for IBCNBOAC 
 ;
 S IBINS=+$G(^TMP($J,"IBCNBOAC",IBS1,"I")),IBGRP=+$G(^TMP($J,"IBCNBOAC",IBS1,"G"))
 S IBPOL=+$G(^TMP($J,"IBCNBOAC",IBS1,"P")),IBCNT=+$G(^TMP($J,"IBCNBOAC",IBS1,"CNT"))
 S (IBIP,IBGP,IBPP)=0 I IBCNT'=0 S IBIP=((IBINS/IBCNT)*100)\1,IBGP=((IBGRP/IBCNT)*100)\1,IBPP=((IBPOL/IBCNT)*100)\1
 Q
 ;
EOR(IBLE) ; write end of report
 I '$G(IBLE) S IBLE=80
 W ! W:$G(IBOUT)="R" ?((IBLE\2)-10) W "*** END OF REPORT ***",!
 Q
 ;
EXN(IBBN) ; round number by .05 return with 1st decimal
 N IBBW,IBBX,IBBR
 S IBBN=+$G(IBBN)
 ;I IBBN="" Q ""
 S IBBW=$S($E(IBBN,1)="-":"-",1:"")
 S IBBX=IBBN+(IBBW_.05)
 S:$P(IBBX,".",1)="" IBBX="0"_"."_$P(IBBX,".",2)
 S IBBR=$P(IBBX,".",1)_"."_+($E($P(IBBX,".",2),1))
 Q IBBR
 ;
PRTLN ; IB*702/DTG Rewrote tag to print zeros for statuses with no counts
 N IBSTX,IBCNT,IBTM,IBHG,IBLS,IBTCNT
 N IBBA,IBBC,IBBD ;IB*702 added variables
 ;
 S IBSTX=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3))
 ;S IBCNT=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"CNT")) Q:'IBCNT ;IB*702 removed quit
 S IBCNT=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"CNT"))
 S IBTM=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"TM"))
 S IBHG=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"HG"))
 S IBLS=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"LS"))
 ;S IBTCNT=$G(^TMP($J,IBXREF,IBS1,2,9,"CNT")) Q:'IBTCNT ;IB*702 removed quit
 S IBTCNT=$G(^TMP($J,IBXREF,IBS1,2,9,"CNT"))
 ;
 ; Excel output
 I IBOUT="E" D  Q
 . W !,IBLABLE_U_IBSTX_U_$FN(IBCNT,",")_U
 . S IBBA=$S((IBCNT'=""&(IBTCNT'="")):((IBCNT/IBTCNT)*100),1:0),IBBC=$$EXN(IBBA) W IBBC_"%"_U
 . S IBBA=$S(IBCNT'="":$$STD((IBTM/IBCNT)),1:0),IBBC=$$EXN(IBBA) W IBBC_U
 . S IBBA=$$STD(IBHG),IBBC=$$EXN(IBBA) W IBBC_U
 . S IBBA=$$STD(IBLS),IBBC=$$EXN(IBBA) W IBBC
 ;
 ; Report output
 W !,IBSTX,?20,$J($FN(IBCNT,","),7)
 S IBBA=$S((IBCNT'=""&(IBTCNT'="")):((IBCNT/IBTCNT)*100),1:0) W ?30,$J(IBBA,6,1),"%"
 S IBBA=$S(IBCNT'="":$$STD((IBTM/IBCNT)),1:0) W ?43,$J(IBBA,6,1)
 W ?56,$J($$STD(IBHG),6,1),?68,$J($$STD(IBLS),6,1)
 Q
 ;
STD(SEC) ; convert seconds to days
 N IBX,IBD,IBS,IBH,DAYS S DAYS="" G:'$G(SEC) STDQ
 S IBD=(SEC/86400),IBD=+$P(IBD,".")
 S IBS=SEC-(IBD*86400)
 S IBH=((IBS/60)/60),IBH=+$J(IBH,0,2)
 S DAYS=IBD+(IBH/24)
STDQ Q DAYS
 ;
HDR ;print the report header
 N RM
 S IBQUIT=$$STOP Q:IBQUIT
 I IBPGN>0 S IBQUIT=$$PAUSE Q:IBQUIT
 S RM=$S(IBOUT="R":80,1:IOM)
 S IBPGN=IBPGN+1,IBLN=4 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 W !,"INS BUFFER ACTIVITY REPORT   ",IBRANGE," "
 W ?(RM-22),IBRDT,?(RM-(6+$L(IBPGN)))," PAGE ",IBPGN,!
 S IBI="",$P(IBI,"-",RM+1)="" W IBI,!
 Q
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 ;IB*702/TAZ - Cleaned up code
 ; IB*602/HN ; Add report headers to Excel Spreadsheets 
 W !,"INS BUFFER ACTIVITY REPORT^",IBRANGE_"^"_$$FMTE^XLFDT($$NOW^XLFDT,1),!
 ; IB*602/HN end 
 W "MONTH^STATUS^COUNT^PERCENT^AVERAGE # DAYS^LONGEST # DAYS^SHORTEST # DAYS^New Companies^% New Companies^New Group/Plans^% New Group/Plans^New Patient Policies^% New Patient Policies"
 Q
 ;
PAUSE() ;pause at end of screen if being displayed on a terminal
 N IBX,DIRUT,DUOUT,DTOUT,X,Y
 S IBX=0
 I $E(IOST,1,2)["C-" W !! S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DIRUT)) S IBX=1
 Q IBX
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
 ;
IBAR(IBBEG,IBEND) ;Entry point for Vista IB AR data to ARC
 ;patch 305 - called by IBRFN4
 N IBMONTH,IBARFLAG,IBARDATA,IBTM,IBCNT
 S IBMONTH=0,IBARFLAG=1 K ^TMP($J)
 D RPT
 S IBTM=$G(^TMP($J,"IBCNBOA",99999,2,2,"TM"))
 S IBCNT=$G(^TMP($J,"IBCNBOA",99999,2,2,"CNT"))
 I 'IBCNT S IBARDATA=0 G IBARQ
 S IBARDATA=$FN($$STD((IBTM/IBCNT)),"",1)
 K ^TMP($J)
IBARQ Q IBARDATA
 ;
