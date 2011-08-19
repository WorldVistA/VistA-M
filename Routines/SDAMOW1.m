SDAMOW1 ;ALB/CAW - Waiting Time Report (con't) ; 8-NOV-93
 ;;5.3;Scheduling;**12**;Aug 13, 1993
 ;
START ; -- entry point to start
 K ^TMP("SDWAIT",$J),^TMP("SDWTTOT",$J)
 U IO
 N SDASH,SDPAGE,SDRT,SDAMDD,SDLEN
 I '$$INIT G STARTQ
 D BUILD,PRINT^SDAMOWP
 K ^TMP("SDWAIT",$J),^TMP("SDWTTOT",$J),^TMP("SDWTTOTD",$J),^TMP("SDWTTOTG",$J)
STARTQ D:'$D(ZTQUEUED) ^%ZISC
 K SDATA,SDATE,SDCHKIN,SDCHKOUT,SDCLIN,SDDATA,SDDAY,SDDIV,SDDIVNAM,SDOPEIEN,SDOTTIME,SDSTOP,SDT,SDTTTIME,SDWTTIME,VAERR,VAUTS
 Q
 ;
INIT() ; init variables
 S SDLEN=25,$P(SDASH,"-",IOM+1)="",$P(SDASH1,"=",IOM+1)="",SDPAGE=0
 Q 1
BUILD ;build tmp array with line values & summary totals
 ;
 S SDT=SDBEG
 F  S SDT=$O(^SCE("B",SDT)) Q:'SDT!(SDT>SDEND)  S SDOPEIEN=0 D
 .F  S SDOPEIEN=$O(^SCE("B",SDT,SDOPEIEN)) Q:'SDOPEIEN  D PROCAPPT
 Q
PROCAPPT ;process each appointment
 ; INPUT:
 ;    SDOPEINE - INE of Outpatient Encounter File #409.68
 ;    SDT      - Appointment Date/Time
 ; OUTPUT:
 ;    DFN      - IEN of Patient File #2
 ;    SDCLIN   - Clinic, Pointer to Hospital Location File #44
 ;    SDSTOP   - Stop Code Number Pointer to Clinic Stop #40.7
 ;    SDDIV    - Division, Pointer to MC Division File #40.8
 ;    SDCHKIN  - Checkin Date/Time in FM format
 ;    SDCHKOUT - Checkout Date/Time "
 ;
 N SDENODE,SDTMPND,PC,SDCKNODE,SDX
 S SDENODE=$G(^SCE(SDOPEIEN,0))
 S DFN=$P(SDENODE,U,2) G:'DFN QTPRAPP
 ; - Originating Process (1=appoint)& Scheduled else quit
 G:$P(SDENODE,U,8)'=1 QTPRAPP
 G:$P($G(^DPT(DFN,"S",SDT,0)),U,7)'=3 QTPRAPP
 ; - Status must be checked out (no pending,inpatient, or non-count)
 G:$P(SDENODE,U,12)'=2 QTPRAPP
 S SDCLIN=$P(SDENODE,U,4)
 S SDSTOP=$P(SDENODE,U,3)
 S X=SDT D DW^%DTC
 S SDDAY=$S(%Y>0:%Y,%Y:"",1:7)
 S SDDIV=$P(SDENODE,U,11)
 S SDX=U_SDCLIN_U_SDSTOP_U_SDDAY_U_SDDIV_U_DFN_U
 G:SDX["^^" QTPRAPP
 S SDCKNODE=$G(^SC(SDCLIN,"S",SDT,1,+$$FIND^SDAM2(DFN,SDT,SDCLIN),"C"))
 S SDCHKIN=$P(SDCKNODE,U,1)
 S SDCHKOUT=$P(SDCKNODE,U,3)
 S SDX=SDX_SDCHKIN_U_SDCHKOUT ;add checkin;checkout
 G:SDX["^^" QTPRAPP ; no missing variables allowed
 S SDDATA=$P(SDX,U,2,99)
 G:$$REJECT^SDAMOWB QTPRAPP
 D STORE^SDAMOWB(SDSORT,SDDIV,SDCLIN,SDSTOP,SDT,DFN)
QTPRAPP Q
 ;
DISP() ; -- display selection choices
 ;    input: all selection variables
 ;   output: none
 ; return: displayed w/o mishap [ 1|yes   0|no]
 ;
 D HOME^%ZIS W @IOF,*13
 W $$LINE^SDAMOW("Report Specifications")
 W !!," Appointment Dates: ",$$FDATE^VALM1(SDBEG)," to ",$$FDATE^VALM1(SDEND)
 W:$D(SDSORT) !,"         Sorted By: ",$P($T(SORT1+SDSORT^SDAMOWP1),";;",2)
 W !!?15,"Divisions",?55,$S(SDSORT=1!(SDSORT=2):"Clinics",SDSORT=5:"Patients",1:"Stop Codes")
 W !?15,"---------",?55,"----------",!
 S (D,C,S)=0
 S D=$S($G(VAUTD):"All",1:$O(VAUTD(0))) W ?15,$S(D:VAUTD(D),1:D) S D=+D
 S C=$S($G(VAUTC):"All",1:$O(VAUTC(0))) W ?55,$S(C:VAUTC(C),1:C) S C=+C
 I SDSORT'=5 S S=$S($G(VAUTS):"All",1:$O(VAUTS(0))) W ?55,$S(S:VAUTS(S),1:S) S S=+S
 F I=1:1 S:D'="" D=$O(VAUTD(D)) S:C'="" C=$O(VAUTC(C)) S:S'="" S=$O(VAUTS(S)) Q:'D&('C!('S))  W ! W:D ?15,VAUTD(D) W:C ?55,VAUTC(C) W:S ?55,VAUTS(S) I I>9 S I=0 D PAUSE^VALM1 I 'Y G DISPQ
 W !,$$LINE^SDAMOW("")
 S Y=1
DISPQ Q Y
