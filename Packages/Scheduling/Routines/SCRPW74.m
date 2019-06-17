SCRPW74 ;BP-CIOFO/KEITH,ESW - Clinic appointment availability extract (cont.) ; 6/10/03 9:13am
 ;;5.3;Scheduling;**192,206,223,241,249,291**;AUG 13, 1993
 ;
MON(SDEX,SDT,SDMON) ;Determine month and date ranges for extracts
 ;Input: SDEX=extract type, '1' for prospective, '2' for retrospective
 ;Input: SDT=date of extract run
 ;Input: SDMON=array to return date information (pass by reference)
 ;Output: month/year of extract^begin date of report data
 ;Output: SDMON array as follows:
 ;        SDMON("SDBDT")=begin date
 ;        SDMON("SDDIV")=0
 ;        SDMON("SDEDT")=end date
 ;        SDMON("SDEX")=extract type ('1' or '2')
 ;        SDMON("SDPAST")='1' for extract 2, '0' otherwise
 ;        SDMON("SDPBDT")=begin date external value
 ;        SDMON("SDPEDT")=end date external value
 ;        SDMON("SDRPT")=month/year of extract^begin date of data
 ;
 N SDPAR,Y,SDX,SDY,X1,X2
 S SDMON("SDDIV")=0,SDMON("SDPAST")=$S(SDEX=1:0,1:1)
 S SDMON("SDEX")=SDEX,SDPAR=$G(^SD(404.91,1,"PATCH192"))
 I SDEX=1 D
 .S Y=$S($E(SDT,4,5)=12:$E(SDT,1,3)+1_"0101",1:$E(SDT,1,5)+1_"01")
 .S SDMON("SDBDT")=Y X ^DD("DD") S SDMON("SDPBDT")=Y
 .S X1=SDMON("SDBDT"),X2=$P(SDPAR,U,2) S:X2<1 X2=180 S X2=X2-1
 .D C^%DTC S (SDMON("SDEDT"),Y)=X X ^DD("DD") S SDMON("SDPEDT")=Y
 .Q
 I SDEX=2 D
 .S Y=$S($E(SDT,4,5)="01":$E(SDT,1,3)-1_1201,1:$E(SDT,1,5)-1_"01")
 .S SDMON("SDBDT")=Y X ^DD("DD") S SDMON("SDPBDT")=Y
 .S X1=SDMON("SDBDT"),X2=$P(SDPAR,U,4) S:X2<1 X2=31 S X2=X2-1
 .D C^%DTC I $E(X,1,5)>$E(SDMON("SDBDT"),1,5) D
 ..S X1=$E(X,1,5)_"01",X2=-1 D C^%DTC Q
 .S (SDMON("SDEDT"),Y)=X X ^DD("DD") S SDMON("SDPEDT")=Y
 .Q
 S SDY=SDMON("SDBDT")
 S:SDEX=2 SDY=$S($E(SDY,4,5)=12:$E(SDY,1,3)+1_"0101",1:$E(SDY,1,5)+1_"01") S SDX=+$E(SDY,4,5)
 S SDX=$P("JANUARY^FEBRUARY^MARCH^APRIL^MAY^JUNE^JULY^AUGUST^SEPTEMBER^OCTOBER^NOVEMBER^DECEMBER",U,SDX)
 S SDX=SDX_" "_(17+$E(SDY)_$E(SDY,2,3))_U_SDMON("SDBDT")
 S SDMON("SDRPT")=SDX
 Q SDX
 ;
QDIS(SDXTMP) ;Display extract queuing information
 ;Input: SDXTMP=array of data from ^XTMP("SD53P192")
 N SDEX,Y
 W !!?18,"*** Extract queuing information on file ***"
 I '$D(SDXTMP) W !!,"==> No extract queuing data found" Q
 F SDEX=1,2 D
 .W !!?22,"Extract ",SDEX," report: ",$P($G(SDXTMP("EXTRACT",SDEX,"REPORT")),U)
 .W !?24,"Extract ",SDEX," task: ",$G(SDXTMP("EXTRACT",SDEX,"TASK"))
 .S Y=$G(SDXTMP("EXTRACT",SDEX,"DATE")) I Y X ^DD("DD")
 .W !?20,"Extract ",SDEX," run date: ",Y
 .Q
 Q
 ;
DAYS(SDATE,SDAY) ;Adjust target day if necessary
 ;Input: SDATE=date
 ;Input: SDAY=target day
 ;Output: target SDAY for the month of SDATE, adjusted if necessary
 N SDX,X,X1,X2
 S X1=$S($E(SDATE,4,5)=12:($E(SDATE,1,3)+1)_"01",1:$E(SDATE,1,5)+1)_"01"
 S X2=-1 D C^%DTC S SDX=$E(X,6,7)
 Q $S(SDX<SDAY:SDX,1:SDAY)
 ;
WHEN(SDEX,SDNOW) ;Determine date for next run
 ;Input: SDEX=extract type
 ;Input: SDDT=date/time to calculate from (optional)
 ;Output: if success, date/time for next run
 ;        if already scheduled, -1^date_scheduled^task_number
 N SDPAR,SDAY,X1,X2,X,SDTIME,SDINT,SDT,SDDT
 S SDNOW=$G(SDNOW) I SDNOW<1 S SDNOW=$$NOW^XLFDT()
 S SDDT=$P(SDNOW,".")
 ;
 ;Quit if already scheduled
 Q:$G(^XTMP("SD53P192","EXTRACT",SDEX,"DATE"))>SDNOW "-1^"_^XTMP("SD53P192","EXTRACT",SDEX,"DATE")_U_$G(^XTMP("SD53P192","EXTRACT",SDEX,"TASK"))
 ;
 S SDPAR=$G(^SD(404.91,1,"PATCH192")),SDAY=$P(SDPAR,U) S:'SDAY SDAY=31
 S SDINT=$P(SDPAR,U,5) I SDINT=""!("MQSA"'[SDINT) S SDINT="M"
 S SDTIME=$P(SDPAR,U,6) I 'SDTIME!(SDTIME>.2359) S SDTIME=.22
 S X1=$E(SDDT,1,5)_"01",X2=$$DAYS(SDDT,SDAY)-1 D C^%DTC
 I (X+SDTIME)<SDNOW D
 .S X1=$S($E(X,4,5)=12:($E(X,1,3)+1)_"01",1:$E(X,1,5)+1)_"01"
 .S X2=$$DAYS(X1,SDAY)-1 D C^%DTC
 .Q
 ;
 ;Values for monthly queuing
 I SDINT="M" Q:SDEX=1 X+SDTIME  Q $$WHEN2(X)
 ;
 ;Values for quarterly queuing
 I SDINT="Q" D  Q X
 .S X1=+$E(X,4,5),X1=$S(X1<4:"03",X1<7:"06",X1<10:"09",1:12)
 .S X1=$E(X,1,3)_X1_"01",X2=$$DAYS(X1,SDAY)-1 D C^%DTC
 .I SDEX=1 S X=X+SDTIME Q
 .S X=$$WHEN2(X) Q
 ;
 ;Values for semi-annual queuing
 I SDINT="S" D  Q X
 .S X1=+$E(X,4,5) S:X1>9 X=$E(X,1,3)+1_$E(X,4,7)
 .S X1=$S(X1<4:"03",X1<10:"09",1:"03")
 .S X1=$E(X,1,3)_X1_"01",X2=$$DAYS(X1,SDAY)-1 D C^%DTC
 .I SDEX=1 S X=X+SDTIME Q
 .S X=$$WHEN2(X) Q
 ;
 ;Values for annual queuing
 S X1=+$E(X,4,5) S:X1>9 X=$E(X,1,3)+1_$E(X,4,7)
 S X=$E(X,1,3)_"0901",X2=$$DAYS(X1,SDAY)-1 D C^%DTC
 Q:SDEX=1 X+SDTIME  Q $$WHEN2(X)
 ;
WHEN2(X) ;Determine date for extract 2
 ;Input: X=date for extract 1
 ;Output: date/time for extract 2
 S SDT=$S($E(X,4,5)=12:$E(X,1,3)+1_"0101",1:$E(X,1,5)+1_"01")
 S SDAY=$P(SDPAR,U,3) S:'SDAY!SDAY>31 SDAY=5
 S X1=SDT,X2=$$DAYS(SDT,SDAY)-1 D C^%DTC
 S X=X+SDTIME Q X
 ;
SCHED(SDEX,SDT,SDRPT,SDMON,SDKID) ;Schedule repetitive extract run
 ;Input: SDEX=extract type
 ;Input: SDT=date/time to queue extract
 ;Input: SDRPT=month/year of report^begin date of report data
 ;Input: SDMON=report parameters from MON^SCRPW74 (pass by reference)
 ;Input: SDKID='1' if from KIDS install (optional)
 N SDI,Y,ZTSK,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE
 S ZTDTH=SDT,ZTSAVE("SDMON(")="",ZTRTN="RUN^SCRPW74(1)",ZTIO=""
 S ZTDESC="Clinic Appointment Wait Time Extract ("_SDMON("SDEX")_")"
 F SDI=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
 ;
QQ I '$G(ZTSK) D  Q
 .I $G(SDKID) D BMES^XPDUTL("Extract not queued!!!") Q
 .W !!,"Extract not queued!!!",! Q
 S Y=SDT X ^DD("DD")
 I $G(SDKID) D BMES^XPDUTL("Extract "_SDEX_" queued for "_Y_", task number: "_ZTSK)
 I '$G(SDKID) W !!,"Extract "_SDEX_" queued for "_Y_", task number: "_ZTSK,!
 ;
XTMP ;Service ^XTMP nodes
 N X1,X2,X
 S X1=$P($P(SDT,U),"."),X2=45 D C^%DTC S SDPGDT=X
 I '$D(^XTMP("SD53P192",0)) D
 .S ^XTMP("SD53P192",0)=SDPGDT_"^Patch SD*5.3*192 'Clinic Wait Time' extract repetitive queuing information.  Created by user: "_DUZ
 .Q
 S:$P(^XTMP("SD53P192",0),U)<SDPGDT $P(^XTMP("SD53P192",0),U)=SDPGDT
 S ^XTMP("SD53P192","EXTRACT",SDEX,"TASK")=ZTSK
 S ^XTMP("SD53P192","EXTRACT",SDEX,"DATE")=SDT
 S ^XTMP("SD53P192","EXTRACT",SDEX,"REPORT")=SDRPT
 Q
 ;
RUN(SDR) ;Run extract (reschedule if requested)
 ;Input: SDR='1' if rescheduling is requested, '0' otherwise.
 N SDV,SDBDT,SDDIV,SDEDT,SDEX,SDPAST,SDPBDT,SDPEDT,SDRPT
 S SDV="" F  S SDV=$O(SDMON(SDV)) Q:SDV=""  S @SDV=SDMON(SDV)
 I SDR=1 D
 .I $G(^XTMP("SD53P192","EXTRACT",SDEX,"TASK"))=ZTSK K ^XTMP("SD53P192","EXTRACT",SDEX)
 .N SDT,SDMON
 .S SDT=$P(SDRPT,U,2)
 .S:SDEX=2 SDT=$S($E(SDT,4,5)=12:$E(SDT,1,3)+1_"0101",1:$E(SDT,1,5)+1_"01")
 .S SDT=$$WHEN(SDEX),SDRPT=$$MON(SDEX,SDT,.SDMON)
 .D SCHED(SDEX,SDT,SDRPT,.SDMON)
 .Q
 D EXTRACT^SCRPW72
 ;
EXIT I $E(IOST)="C",'$G(SDOUT),'$G(SDXM) N DIR S DIR(0)="E" D ^DIR
 F SDI="SD","SDS","SDTMP","SDTOT","SDXM","SDNAVA","SDNAVB","SDIP","SDPAT","SDORD","SDIPLST" K ^TMP(SDI,$J)
 K ^TMP("SDPAT",+$G(SDJN))
 K %,%DT,%H,%I,%T,%Y,CT,D,DA,DAY,DIC,DIE,DIR,DR,DTOUT,DUOUT,ENDATE
 K I,J,MAX,MAXDT,SC,SC0,SCNA,SD,SDAY,SDBDT,SDBEG,SDC,SDFLEN,SDREPORT
 K SDCAP,SDCCP,SDCNAM,SDCOL,SDCP,SDCT,SDDAY,SDDIV,SDDT,SDDV,SDDW
 K SDEDT,SDEND,SDEX,SDEXDT,SDFAC,SDFMT,SDHD,SDI,SDIN,SDINT,SDIV
 K SDKID,SDL,SDLINE,SDMAX,SDMD,SDMG,SDMON,SDMPDT,SDNOW,SDOE,SDOE0
 K SDOUT,SDP,SDPAGE,SDPAR,SDPAST,SDPATT,SDPBDT,SDPCT,SDPEDT,SDPG
 K SDPGDT,SDPNOW,SDQUIT,SDR,SDRE,SDRPT,SDS,SDSC1,SDSC2,SDSIZE,SDSL
 K SDSOH,SDSORT,SDSSC,SDSTRTDT,SDT,SDTCAP,SDTIME,SDTIT,SDTITL,SDTOE
 K SDTSL,SDTX,SDTY,SDV,SDX,SDXM,SDXTMP,SDY,SDZ,SI,SM,SS,X,X1,X2,Y
 K SDJN,SDFMT,SDFMTS
 D:$D(IOM) END^SCRPW50 Q
