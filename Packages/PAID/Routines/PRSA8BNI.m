PRSA8BNI ;WOIFO/JAH - Tour Hours vs 8B Norm Hrs Report ;7/9/08
 ;;4.0;PAID;**116,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
GETPP() ;prompt for pay period
 N DIC,X,Y,PPI,DTOUT
 S DIC="^PRST(458,",DIC(0)="AEQM",DIC("A")="Select PAY PERIOD: "
 W !
 D ^DIC
 S PPI=+Y
 I $D(DTOUT)!(+Y'>0) S PPI=0
 Q PPI
NOTOURS() ;return true if user wants to see data from employees with
 ;        no tour of duty set up yet
 ;        otherwise return 0 or -1 for abort
 ;
 N DIR,DIRUT,Y
 S DIR(0)="Y"
 S DIR("B")="N"
 S DIR("A")="Include employees with no tour of duty entered"
 D ^DIR
 Q:$D(DIRUT) -1
 Q +Y
 ;
NOTCARD() ;return true if user wants to see data from employees with
 ;  no timecard on file, ie no entry for pp in 458
 ;  otherwise return 0 or -1 for abort
 ;
 N DIR,DIRUT,Y
 S DIR(0)="Y"
 S DIR("B")="N"
 S DIR("A")="Include employees with no timecard on file"
 D ^DIR
 Q:$D(DIRUT) -1
 Q +Y
SHONOTES() ;return true if user wants to see footnotes that describe
 ; the columns in the report at the end of the report
 ;
 N DIR,DIRUT,Y
 S DIR(0)="Y"
 S DIR("B")="N"
 S DIR("A")="Include report footnotes"
 D ^DIR
 Q:$D(DIRUT) -1
 Q +Y
DAILYHRS() ;return true if user wants to see tour hours for each day
 ;  otherwise return 0 or -1 for abort
 ;
 N DIR,DIRUT,Y
 S DIR(0)="Y"
 S DIR("B")="N"
 S DIR("A")="Include employees daily tour hours"
 D ^DIR
 Q:$D(DIRUT) -1
 Q +Y
 ;
TRHDR ;
 W !!,?7,"Day",?12,"ToD #*",?19,"Tour Week 1",?34,"Hours*",?47,"ToD #*",?54,"Tour Week 2",?69,"Hours*"
 W !,?7,"---",?12,"-----",?19,"-----------",?34,"-----",?47,"-----",?54,"-----------",?69,"-----"
 Q
EMPINFO(PRSENAME,PRSSN,HRS) ;
 W !!?2,PRSENAME,?26,PRSSN,?44,$P(HRS,U),?55,$P(HRS,U,2)
 I $G(DUZ(0))="@" W ?63,PRSIEN
 Q
HDR(PG,TSTAMP,END,FORWHO,PPE,PPRANGE,OPT) ;
 S PG=PG+1
 W @IOF
 N H1,H2,B,OPTHDR
 S H1="VA TIME & ATTENDANCE REPORT "_FORWHO_"--"_TSTAMP
 S B=$E("               ",1,(IOM-$L(H1))\2-3-$L(PG))
 S OPTHDR=$S($G(OPT)>0:"Display Employee Tour Hours",1:"Tour Hrs Don't Match 8B Normal Hrs")
 S H2=OPTHDR_": PP "_PPE_" ("_PPRANGE_")"
 W !,?(IOM-$L(H1)\2),H1,B,"p",PG,!,?(IOM-$L(H2)\2),H2
 Q:END
 W !!,?2,"EMPLOYEE NAME",?26,"    SSN",?40,"8B NRM HRS   ToD HRS*"
 I $G(DUZ(0))="@" W ?63,"IEN 450"
 W !?2,"======================",?26,"===========",?40,"==========   ======="
 I $G(DUZ(0))="@" W "   ======="
 Q
 ;
RET(TSTAMP) ;
 I ($E(IOST,1,2)'="C-")!($D(ZTQUEUED)) D HDR(.PG,TSTAMP,0,FORWHO,PPE,PPRANGE) Q 0
 ;
 N OUT
 S OUT=$$ASK^PRSLIB00(1)
 I 'OUT D HDR(.PG,TSTAMP,0,FORWHO,PPE,PPRANGE)
 Q OUT
GETHOURS(PPI,PRSIEN) ; Return TOUR HOURS AND NORMAL HOURS
 N MATCH,HRS,NH,ENT,ENTPTR,DFN,TH
 I $G(PPI)'>0!($G(PRSIEN)'>0) Q 1
 S MATCH=1
 S NH=-1
 S ENTPTR=$P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,5)
 I ENTPTR'="" D
 .  S ENT=$P($G(^PRST(457.5,ENTPTR,1)),U)
 .  S NH=$E($G(^PRST(458,PPI,"E",PRSIEN,5)),26,27)
 .  Q:NH="00"
 .  I +NH'>0 S NH=$P($G(^PRSPC(PRSIEN,0)),U,50)
 I $G(ENT)="" S DFN=PRSIEN D ^PRSAENT
 I $G(ENT)'="",$E(ENT)'="D",($E(ENT,1,2)'="0D") D
 .  D TOURHRS^PRSARC07(.HRS,PPI,PRSIEN)
 .  S TH=($G(HRS("W1"))+$G(HRS("W2")))
 Q NH_U_TH
 ;
REPDONE(OUT,TLECNT,TSTAMP,DAILYHRS,GRANDTOT) ; report done display page
 ;
 I TLECNT=0 D HDR(.PG,TSTAMP,1,FORWHO,PPE,PPRANGE) W !,"NO T&L UNITS WERE FOUND ASSIGNED TO YOU THAT COULD BE CHECKED." Q
 I 'OUT,$Y>(IOSL-24) S OUT=$$ASK^PRSLIB00(1) D HDR(.PG,TSTAMP,1,FORWHO,PPE,PPRANGE)
 I OUT W !!,"********REPORT ABORTED*********"
 E  W !!,"REPORT COMPLETED.  TOTAL MISMATCHES FOUND:  ",GRANDTOT
 D FOOTNOTE(DAILYHRS)
 Q
FOOTNOTE(DAILYHRS) ; display notes about the report
 W !,"================================================================="
 N TXT,I
 W !
 F I=1:1 S TXT=$P($T(ALLFT+I),";",3) Q:TXT=""  W !,TXT
 I DAILYHRS D
 .  F I=1:1 S TXT=$P($T(DAILYFT+I),";",3) Q:TXT=""  W !,TXT
 Q
ALLFT ;;
 ;;                   FOOTNOTES TO REPORT HEADINGS
 ;;                   ============================
 ;;*ToD HRS (Tour of Duty Hours) The total Tour of Duty hours that fall within the
 ;;--------  two week pay period, beginning midnight Saturday.  Hours that cross 
 ;;          midnight from a tour that starts on the last day of a pay period will
 ;;          appear on the following pay period.
 ;;.....................................................................
DAILYFT ;;
 ;;*Hours   (DAILY TOUR HOURS) This column contains actual tour hours that fall
 ;;------    on that day from the 24 hour period beginning at midnight.  A two day
 ;;          tour will contribute hours to each day the tour falls on.  Hours 
 ;;          that cross midnight from a tour that starts on the last day of a pay
 ;;          period will appear on the following pay period.
 ;;.....................................................................
 ;;*ToD #   (Tour of Duty Number) The tour's entry number in the Tour 
 ;;------   of Duty file (#457.1) 
 ;;.....................................................................
