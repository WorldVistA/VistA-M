SDAMEX ;ALB/MJK,RMO - Appointment Check In/Check Out ; 12/1/91
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
EN ; -- main entry point
 N SDATA,SDTOT,DFN,SDACT,SDATE,SDT,SDCL,SDDA,SDASH,SDAMDD,SDMAX
 I '$$INIT G ENQ
 S SDACT=$$ASK(DT) G ENQ:SDACT']""
 F  Q:'$$DATE(.SDATE)  K SDCL D  Q:SDTOT'<SDMAX
 .F  Q:'$$CLINIC(SDATE,.SDCL)  K DFN D  Q:SDTOT'<SDMAX
 ..F  Q:'$$PAT(.SDATE,.SDCL,SDACT,.DFN,.SDT,.SDDA)  D  Q:SDTOT'<SDMAX
 ...S SDTOT=SDTOT+$$CK^SDAMEX1(DFN,SDCL,SDT,SDDA,SDACT)
 W !!?5,"Total Appointments Processed: ",SDTOT
ENQ Q
 ;
INIT() ; -- set up vars
 S SDTOT=0,SDMAX=9999,$P(SDASH,"_",IOM)="",SDAMDD=$P(^DD(2.98,3,0),U,3)
 Q 1
 ;
ASK(SDDT) ; -- select appt CI or CO
 N DIR,DIRUT,DTOUT,DUOUT,Y
 S DIR(0)="SB^CI:Check In;CO:Check Out"
 S DIR("A")="Select Appointment Check In or Check Out"
 S:$G(SDDT) DIR("B")=$S($$REQ^SDM1A(SDDT)="CO":"Check Out",1:"Check In")
 W ! D ^DIR S:$D(DIRUT) Y=""
 Q $G(Y)
 ;
DATE(SDATE) ; -- get appt date
 ;    input: none
 ;   output: SDATE := appt date selected
 ; returned: date selected [1 := yes | 0 := no]
 ;
 S DIR(0)="DO^:"_DT_":EPX",DIR("A")=$S($D(SDATE):"Next ",1:"")_"Appointment Date"
 S:'$D(SDATE) DIR("B")="TODAY"
 W ! D ^DIR K DIR S SDATE=Y
 Q $S($D(DIRUT):0,Y:1,1:0)
 ;
CLINIC(SDATE,SDCL) ; -- get clinic
 ;    input: SDATE := appt date selected
 ;   output: SDCL := ifn of selected clinic
 ; returned: clinic selected [1 := yes | 0 := no]
 ;
 N X,Y,SDDEF
CL W !,$S($D(SDCL):"Next",1:"Select")_" Clinic: "
 S SDDEF=$S($P($O(^SC(+$G(^DISV(DUZ,"^SC(")),"S",SDATE)),".")=SDATE:+$G(^DISV(DUZ,"^SC(")),1:0)
 I '$D(SDCL),$G(^SC(SDDEF,0))]"" W $P(^(0),U)_"// "
 R X:DTIME
 I X="",SDDEF,'$D(SDCL) S X="`"_SDDEF
 I "^"[X S SDCL=0 G CLINICQ
 S:X?1" "1N.N X="`"_$E(X,2,99)
 S DIC(0)="NEMQ",DIC="^SC("
 S DIC("S")="I $P(^(0),U,3)[""C"",$P($O(^(""S"",SDATE)),""."")=SDATE"
 D ^DIC K DIC G CL:Y<1 S SDCL=+Y
CLINICQ Q SDCL>0
 ;
PAT(SDATE,SDCL,SDACT,DFN,SDT,SDDA) ; -- ask for pats & get appt
 ;    input: SDATE := appt date
 ;            SDCL := ifn of clinic
 ;           SDACT := action CI or CO
 ;   output:   DFN 
 ;             SDT := appt date/time
 ;            SDDA := ifn of ^sc multiple
 ; returned: appt selected [1 := yes | 0 := no]
 ;
 N X,SDCNT,SDLCNT,SDAPPT
PT W !,SDASH S (SDDA,SDT)=0
 W !!,$S($D(DFN):"Next",1:"Select")_" Patient: " R X:DTIME G PATQ:"^"[X
 IF X["?" D PTHLP(SDCL,SDATE) G PT
 D RT S DIC="^DPT(",DIC(0)="QEM" D ^DIC K DIC G PT:Y<1
 S DFN=+Y
 S (SDLCNT,SDCNT)=$$LIST(.DFN,.SDCL,.SDATE,.SDAPPT)
 I 'SDCNT W !?7,"o  No appointments for this patient.",*7 G PT
 I SDCNT>1 D  G PT:'SDCNT
 .S DIR(0)="N^1:"_SDCNT,SDCNT=0,DIR("A")="Select Appointment" D ^DIR K DIR S SDCNT=+Y
 I $D(SDAPPT(SDCNT)) D  G PT:'SDDA
 .S SDT=+SDAPPT(SDCNT),SDDA=+$P(SDAPPT(SDCNT),U,2),SDATA=$G(^DPT(DFN,"S",SDT,0))
 .I SDLCNT>1 W ! D PRT
 .I 'SDDA K SDAPPT W !?7,"o  This appointment cannot be checked ",$S(SDACT="CO":"out",1:"in"),".",*7
PATQ Q SDDA>0
 ;
LIST(DFN,SDCL,SDATE,SDAPPT) ;
 ;    input: DFN
 ;             SDCL := ifn of clinic
 ;            SDATE := appt date ; SDCL := ifn of clinic
 ;   output  SDAPPT := array of choices (appt d/t ^ multiple ifn)
 ; returned: count of appts for date
 ;
 N SDCNT
 W !!?5,"Clinic",?30,"Appointment Date/Time",?55,"Status"
 W !?5,"------",?30,"---------------------",?55,"------"
 S SDT=SDATE,DATE=0,SDCNT=0
 F  S SDT=$O(^DPT(DFN,"S",SDT)) Q:'SDT!(SDT>(SDATE_".2359"))  I $D(^(SDT,0)) S SDATA=^(0) I SDCL=+SDATA D
 .S SDCNT=SDCNT+1,SDAPPT(SDCNT)=SDT_U_+$$FIND^SDAM2(DFN,SDT,SDCL)
 .D PRT
LISTQ Q SDCNT
 ;
PRT W !?1,SDCNT,?5,$E($P($G(^SC(SDCL,0)),U),1,25),?30,$$FTIME^VALM1(SDT),?55,$P($$STATUS^SDAM1(DFN,SDT,SDCL,SDATA,SDDA),";",3)
 Q
 ;
RT ; -- is this a rt rec
 N C
 I X?.N1"/"1N.ANP S C=$$CHAR($E(X,1,$L(X)-1)) I C]"",C=$E(X,$L(X)),$D(^RT(+$P(X,"/",2),0)),$P(^(0),U,9) S X="`"_+$P(^(0),U,9)
 Q
CHAR(X) ; -- char checksum for code 39
 N C,Z,I,Y
 S C="",Z="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%"
 F I=1:1:$L(X) S Y=$F(Z,$E(X,I))-2 Q:Y<0  S C=C+Y
 Q $S(Y'<0:$E(Z,(C#43)+1),1:"")
 ;
PTHLP(SDCL,START) ;
 N END,SDT,SDDA,SDATA,SDCNT,X,DFN,SDESC,VA
 S END=START+.2359,SDCNT=0,SDESC=0
 W !,"The following appointments are listed for the clinic on the selected date:"
 F SDT=START:0 S SDT=$O(^SC(SDCL,"S",SDT)) Q:'SDT!(SDT>END)  D  Q:SDESC
 .S SDDA=0 F  S SDDA=$O(^SC(SDCL,"S",SDT,1,SDDA)) Q:'SDDA  S X=^SC(SDCL,"S",SDT,1,SDDA,0) D  Q:SDESC
 ..S DFN=+X,SDATA=$G(^DPT(DFN,"S",SDT,0))
 ..I SDCL=+SDATA,$$VALID^SDAM2(DFN,SDCL,SDT,SDDA) S SDCNT=SDCNT+1 D PID^VADPT6 D
 ...W !,$E($P($G(^DPT(DFN,0)),U),1,20),?21,VA("BID"),?30,$$FTIME^VALM1(SDT),?55,$P($$STATUS^SDAM1(DFN,SDT,SDCL,SDATA,SDDA),";",3)
 ...I '(SDCNT#20) S DIR(0)="E" D ^DIR K DIR S SDESC='Y
 I SDCNT=0 W !!?5,"...There are no appointments for this clinic on this date.",*7
 Q
