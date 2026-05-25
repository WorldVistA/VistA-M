ORDOTP ; SLC/MAE - Opioid Treatment Components  ; Dec 16, 2024@13:29:17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**618**;;Build 14
 ;                    
 ; Reference to ^DPT in ICR# 10035
 ; Reference to %DTC in ICR# 10000
 ; Reference to %ZIS in ICR# 10086
 ; Reference to %ZISC in ICR# 10089
 ; Reference to %ZISH in ICR# 2320
 ; Reference to ^DIC in ICR# 10006
 ; Reference to D^DIQ in ICR# 10004
 ; Reference to ^DIR in ICR# 10026
 ; Reference to ^XLFDT in ICR# 10103
 ; Reference to ^XLFSTR in ICR# 10104
 ;                  
EN(ROOT,DFN,ID,ALPHA,OMEGA,DTRANGE,REMOTE,ORMAX,ORFHIE) ;OTP REPORT
 N DSPAMT,DSPAMTCHG,DSPBY,DSPDATE,DSPDOW,DSPDIFF,DSPDTTM,DSPEND,DSPFMDATE,DSPFMDAY,DSPHOW,DSPIEN
 N DSPINI,DSPINT,DSPINTDT,DSPLINE,DSPREC,DSPROWS,DSPTIME,DSPMED,DSPWEEK,DSPWKCOL,DSPWKCTR
 N FRSTDSPDT,HDR,LASTDSPDT,LEGEND,M,MEDDATE,NODSPCTR,NUMWEEKS,PTIEN,PTNAME,X
 I $L($G(DTRANGE)),'$G(ALPHA) S ALPHA=$$FMADD^XLFDT(DT,-DTRANGE),OMEGA=$$NOW^XLFDT
 Q:'$G(ALPHA)  Q:'$G(OMEGA)
 ;
 I $G(OTPVFLG)="" D
 .N IOM,IOSL,IOST,IOF
 .D HFSOPEN("RPC") I POP S ^TMP("OR OTP",$J,1)="ERROR: UNABLE TO ACCESS HFS DIRECTORY "_$$DEFDIR^%ZISH(),^TMP("OR OTP",$J,2)="PLEASE CHECK DIRECTORY WRITE PRIVILEGES." Q
 .U IO
 .D GETDATA
 .D PRTDATA
 .D HFSCLOSE("RPC")
 .S ROOT=$NA(^TMP("OR OTP",$J))
 I $G(OTPVFLG)=1 D
 .U IO
 .D GETDATA
 .D PRTDATA
 .D ^%ZISC
 .K OTPSTOP
 .K ^TMP("OR OTP",$J)
 ;
 Q
 ;
GETDATA ;Retrieve OTP Dispense data
 K ^TMP("OR OTP",$J,"WEEKS"),^TMP("OR OTP",$J,"OTPREC")
 I '$D(^ORD(101.22,"B",DFN)) D HDR W !," **** NO PATIENT DATA FOUND ***" Q
 S PTIEN=$O(^ORD(101.22,"B",DFN,""))
 S PTNAME=$P(^DPT(DFN,0),U)
 S FRSTDSPDT=$O(^ORD(101.22,PTIEN,1,"B",""))
 S LASTDSPDT=$O(^ORD(101.22,PTIEN,1,"B",""),-1)
 D WEEKS
 Q:'$D(^TMP("OR OTP",$J,"WEEKS"))
 S MEDDATE="" F  S MEDDATE=$O(^ORD(101.22,PTIEN,1,"B",MEDDATE)) Q:MEDDATE=""  D
 .Q:MEDDATE<ALPHA
 .Q:MEDDATE>OMEGA
 .S DSPIEN="" F  S DSPIEN=$O(^ORD(101.22,PTIEN,1,"B",MEDDATE,DSPIEN)) Q:DSPIEN=""  D
 ..S DSPREC=^ORD(101.22,PTIEN,1,DSPIEN,0)
 ..S DSPBY=$P(DSPREC,U,4)
 ..S DSPINI=$P(DSPREC,U,5)
 ..S DSPHOW=$S($P(DSPREC,U,6)="C":"In Clinic",$P(DSPREC,U,6)="H":"Take Home")
 ..S DSPMED=$P(DSPREC,U,2) I DSPMED[" " S DSPMED=$E($P(DSPMED," ",1),1,4)_" "_$E($P(DSPMED," ",2),1,3)_" "
 ..S DSPAMT=$P(DSPREC,U,7) I $G(DSPAMTCHG)="" S DSPAMTCHG=DSPAMT
 ..I DSPAMTCHG'=DSPAMT S DSPAMTCHG=DSPAMT,DSPAMT=DSPAMT_" **"
 ..S DSPDATE=$P($P(DSPREC,U,3),".",1)
 ..S DSPTIME=$P($P(DSPREC,U,3),".",2)_"0000",DSPTIME=$E(DSPTIME,1,2)_":"_$E(DSPTIME,3,4)
 ..S DSPINTDT=$P(DSPREC,U,8)
 ..S DSPINT=$P(DSPREC,U,9)
 ..S DSPWKCOL=$P(^TMP("OR OTP",$J,"WEEKS","DATE",MEDDATE),U)
 ..I DSPHOW="In Clinic" D
 ...S ^TMP("OR OTP",$J,"OTPREC",MEDDATE,DSPWKCOL)=$G(^TMP("OR OTP",$J,"OTPREC",MEDDATE,DSPWKCOL))_U_DSPHOW_U_DSPTIME_" "_DSPINI_" "_U_DSPMED_U_DSPAMT_$$REPEAT^XLFSTR(" ",9-$L(DSPAMT))
 ..I DSPHOW="Take Home" D
 ...S ^TMP("OR OTP",$J,"OTPREC",MEDDATE,DSPWKCOL)=$G(^TMP("OR OTP",$J,"OTPREC",MEDDATE,DSPWKCOL))_U_DSPHOW_U_"         "_U_"         "_U_"         "
 ..I $G(DSPBY)'="" I '$D(LEGEND(DSPBY)) S LEGEND(DSPBY)=DSPINI
 ;
 Q
 ;
PRTDATA ;Print OTP Dispense data
 I '$D(^ORD(101.22,"B",DFN)) Q
 D HDR
 I '$D(^TMP("OR OTP",$J,"WEEKS")) W !," **** NO OTP MEDICATION DISPENSE DATA FOUND ***",! Q
 S DSPWEEK="" F  S DSPWEEK=$O(^TMP("OR OTP",$J,"WEEKS","COL",DSPWEEK)) Q:DSPWEEK=""  D
 .S NODSPCTR=0,DSPWKCTR=0
 .W !,$TR($J("-",26)," ","-")_" MEDICATION TO BE TAKEN ON: "_$TR($J("-",25)," ","-")
 .W !,"|          |          |          |          |          |          |           |"
 .W !,"|" F X=1:1:7 W $S('$D(^TMP("OR OTP",$J,"WEEKS","COL",DSPWEEK,X)):"          ",1:$P(^TMP("OR OTP",$J,"WEEKS","COL",DSPWEEK,X),U,2))_$S(X=7:" |",1:"|")
 .W !,"|          |          |          |          |          |          |           |"
 .W !,$TR($J("",79)," ","-"),!
 .S DSPWKCTR=$O(^TMP("OR OTP",$J,"WEEKS","COL",DSPWEEK,""),-1) F X=1:1:DSPWKCTR S DSPFMDAY=$P($G(^TMP("OR OTP",$J,"WEEKS","COL",DSPWEEK,X)),U,1) Q:DSPFMDAY=""  D
 ..I '$D(^TMP("OR OTP",$J,"OTPREC",DSPFMDAY,X)) S NODSPCTR=$G(NODSPCTR)+1
 .I NODSPCTR=DSPWKCTR W !," **** NO OTP MEDICATION DISPENSE DATA FOUND ***",! Q
 .S DSPROWS=""
 .F X=1:1:DSPWKCTR D  ;GET NUMBER OF ROWS
 ..S DSPFMDAY=$P(^TMP("OR OTP",$J,"WEEKS","COL",DSPWEEK,X),"^",1)
 ..Q:'$D(^TMP("OR OTP",$J,"OTPREC",DSPFMDAY,X))
 ..S DSPROWS=$S($L(^TMP("OR OTP",$J,"OTPREC",DSPFMDAY,X),"^")-1>DSPROWS:$L(^TMP("OR OTP",$J,"OTPREC",DSPFMDAY,X),"^")-1,1:DSPROWS)
 .F M=1:1:DSPROWS D
 ..S DSPLINE=""
 ..F X=1:1:7 Q:'$D(^TMP("OR OTP",$J,"WEEKS","COL",DSPWEEK))  D
 ...S DSPFMDAY=$P($G(^TMP("OR OTP",$J,"WEEKS","COL",DSPWEEK,X)),U,1)
 ...S DSPFMDATE=$P($G(^TMP("OR OTP",$J,"WEEKS","COL",DSPWEEK,X)),U,2)
 ...I DSPFMDAY="" S DSPLINE=DSPLINE_"|          "_$S(X=7:" |",1:"") Q
 ...S DSPLINE=DSPLINE_$S($P($G(^TMP("OR OTP",$J,"OTPREC",DSPFMDAY,X)),U,M+1)="":"|          ",1:"|"_$P(^TMP("OR OTP",$J,"OTPREC",DSPFMDAY,X),U,M+1)_" ")_$S(X=7:" |",1:"")
 ..W DSPLINE,!
 ..I M#4=0,(M'=DSPROWS) W "|          |          |          |          |          |          |           |",!
 .W $TR($J("",79)," ","-"),!
 ;
 D LEGEND
 ;
 Q
 ;
HDR ;OTP Report Header
 W "OTP MEDICATION DISPENSE REPORT for "_$$FMTE^XLFDT(ALPHA)_" to "_$$FMTE^XLFDT(OMEGA)
 D NOW^%DTC S Y=+$E(%,1,12) D D^DIQ
 W !,?80-$L("Run Date: "_Y),"Run Date: "_Y
 S HDR("PAGE")=$G(HDR("PAGE"))+1
 W !,?80-$L("Page: "_HDR("PAGE")),"Page: "_HDR("PAGE")
 W !,$TR($J("",80)," ","="),!
 Q
 ;
WEEKS ;Build Weeks Header
 S DSPDIFF=$$FMDIFF^XLFDT(OMEGA,ALPHA,1)
 S DSPEND=$$FMADD^XLFDT(ALPHA,DSPDIFF)
 S MEDDATE=$S(ALPHA<FRSTDSPDT:FRSTDSPDT,1:ALPHA)
 F  D  Q:X>DSPEND
 .S X=MEDDATE D H^%DTC S DSPWEEK=%H
 .F DSPDOW=1:1:7 D
 ..S %H=DSPWEEK+DSPDOW-1 D YMD^%DTC
 ..Q:X>OMEGA!(X>LASTDSPDT)
 ..S ^TMP("OR OTP",$J,"WEEKS","COL",DSPWEEK,DSPDOW)=X_U_$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3))
 ..S ^TMP("OR OTP",$J,"WEEKS","DATE",X)=DSPDOW_U_DSPWEEK
 .S %H=DSPWEEK+7 D YMD^%DTC S MEDDATE=X
 .S NUMWEEKS=$G(NUMWEEKS)+1
 Q
 ;
LEGEND ;Legend
 W !!," ** LEGEND **"
 W !,$TR($J("",80)," ","=")
 W !!,"Initial - Name Legend"
 S DSPBY="" F  S DSPBY=$O(LEGEND(DSPBY)) Q:DSPBY=""  W !,LEGEND(DSPBY)_" - "_DSPBY
 W !!,"BLANK SPACE - shows that no dispense information was received via the interface."
 W !,"This can indicate the patient was a no-show for their appointment, no medication"
 W !,"was prescribed/dispensed, or that the interface failed to send the data."
 w !!,"** - Asterisks indicate that Dispense Amount may have changed within the week."
 W !,$TR($J("",80)," ","=")
 Q
 ;
HFSOPEN(HANDLE) ;open HFS
 N OTPDIR,OTPFILE
 S OTPDIR=$$DEFDIR^%ZISH()
 S OTPFILE="ORDOTP"_DUZ_".DAT"
 D OPEN^%ZISH(HANDLE,OTPDIR,OTPFILE,"W") Q:POP
 S IOM=132,IOSL=99999,IOST="P-DUMMY",IOF=""""""
 Q
 ;
HFSCLOSE(HANDLE) ;close HFS
 N OTPDIR,OTPFILE,OTPDEL
 D CLOSE^%ZISH(HANDLE)
 K ^TMP("OR OTP",$J,1)
 S OTPDIR=$$DEFDIR^%ZISH()
 S OTPFILE="ORDOTP"_DUZ_".DAT",OTPDEL(OTPFILE)=""
 S X=$$FTG^%ZISH(OTPDIR,OTPFILE,$NA(^TMP("OR OTP",$J,1)),3)
 S X=$$DEL^%ZISH(OTPDIR,$NA(OTPDEL))
 Q
 ;
ASK ;VistA hook for OTP Dispense Report
 N PTIEN,VOTPBDT,VOTPEDT,ID,OTPVFLG
 S (PTIEN,X)="",DIC(0)="AEQMZ"
 S DIC("A")="Select PATIENT: "
 S DIC="^DPT(" D ^DIC K DIC I $E(X)="^" Q
 I Y="-1" G ASK
 I Y>0 S PTIEN=+Y
 ;
ASKDT ;
 S VOTPBDT=+$$READ("DA^::E","Enter START Date: ","T-7","Enter a start date for the report")
 Q:'VOTPBDT
 S VOTPEDT=+$$READ("DA^::E","  Enter END Date: ","T","Enter an INCLUSIVE end date for the report")
 Q:'VOTPEDT
 I $L(VOTPEDT,".")=1 S VOTPEDT=VOTPEDT_".2359"
 I VOTPBDT>VOTPEDT W !,"END DATE must be more recent than the START DATE" S (VOTPBDT,VOTPEDT)="" G ASKDT
 ;
 Q:$$SELDEV()
 S OTPVFLG=1
 S ID="OR_OTP:ORRP OTP DISPENSE~;;24;10"
 D EN(.ROOT,PTIEN,ID,VOTPBDT,VOTPEDT,"","","","")
 Q
 ;
READ(TYPE,PROMPT,DEFAULT,HELP,SCREEN) ; Calls reader, returns response
 N DIR,X,Y
 S DIR(0)=TYPE
 I $D(SCREEN) S DIR("S")=SCREEN
 I $G(PROMPT)]"" S DIR("A")=PROMPT
 I $G(DEFAULT)]"" S DIR("B")=DEFAULT
 I $D(HELP) S DIR("?")=HELP
 D ^DIR
 I Y]"",($L($G(Y),U)'=2) S Y=Y_U_$G(Y(0),Y)
 Q Y
 ;
SELDEV() ;*** Ask for device type for report to output to ***
 K IOP,%ZIS,POP,IO("Q")
 S %ZIS("A")="Select output device: ",%ZIS("B")="",%ZIS="Q"
 D ^%ZIS S OTPSTOP=$S(POP:1,1:0) I POP W !,"** No device selected or Report printed **" D EXIT
 Q $G(OTPSTOP)
 ;
EXIT ;
 K %,%H,%I,%ZIS,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN
 W:$E(IOST,1,2)="C-"&($Y) @IOF
 S:$D(ZTQUEUED) ZTREQ="@"
 S IOP="HOME" D ^%ZISC
 K ZTQUEUED,ZTREQ
 Q
 ;
