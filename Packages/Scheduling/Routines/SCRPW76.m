SCRPW76 ;BP-OIFO/KEITH,ESW - Clinic appointment availability extract (cont.) ; 5/28/03 4:02pm
 ;;5.3;Scheduling;**223,291**;AUG 13, 1993
 ;
HINI ;Initialize header variables
 N %,%H,%I,X,X1,X2
 S SDLINE="",$P(SDLINE,"-",$S(SDPAST:133,1:(SDIOM+1)))="",SDPAGE=1,SDPG=0
 D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2)
 S SDTITL="<*>  Clinic Appointment Availability Report  <*>"
 Q
 ;
HDR(SDTY,SDREPORT,SDIV,SDCP,SC) ;Print header
 ;Input: SDTY=type of header where:
 ;            '0'=negative report
 ;            '1'=detailed report
 ;            '2'=division summary
 ;            '3'=facility summary
 ;Input: SDREPORT=report output element where:
 ;            '1'='next ava.' appt. information
 ;            '2'='follow up' appt. information
 ;            '3'='non-follow up' appt. information
 ;Input: SDIV=division name^division number
 ;Input: SDCP=credit pair
 ;Input: SC=clinic ifn
 ;
 Q:SDOUT
 I $G(SDXM) D HDRXM(SDREPORT) Q
 I $E(IOST)="C",SDPG N DIR S DIR(0)="E" W ! D ^DIR S SDOUT=Y'=1 Q:SDOUT
 N SDX,SDI D STOP Q:SDOUT
 W:SDPG!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0)
 W SDLINE,!?(SDIOM-$L(SDTITL)\2),SDTITL
 I SDREPORT=1,'SDPAST S SDX="Clinic availability data"
 I SDREPORT=1,SDPAST S SDX="Clinic availability and 'next available' appointment data"
 I SDREPORT=2 S SDX="'Follow up' appointment data"
 I SDREPORT=3 S SDX="'Non-follow up' appointment data"
 I SDREPORT=4 S SDX="Listing of patient appointments"
 I SDREPORT=5 S SDX="Listing of appointments for selected patient"
 W !?(SDIOM-$L(SDX)\2),SDX
 D HDRX(SDTY) Q:SDOUT  S SDI=0
 I $G(SDREPORT)'=5 F  S SDI=$O(SDTIT(SDI)) Q:'SDI  W !?(SDIOM-$L(SDTIT(SDI))\2),SDTIT(SDI)
 I $G(SDREPORT)=5 Q:'$O(SDTIT(""))  D
 .N SD F SD=1,2 W !?(SDIOM-$L(SDTIT(SD))\2),SDTIT(SD)
 .W !,SDTIT(3),?100,SDTIT(4),!,SDTIT(5),?100,SDTIT(6)
 W !,SDLINE
 W !,"For clinic availability dates ",SDPBDT," through ",SDPEDT
 W !,"Date printed: ",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE
 W !,SDLINE
 S SDPAGE=SDPAGE+1,SDPG=1 D:SDTY SUBT(SDTY,SDREPORT) Q
 ;
HDRX(SDTY) ;Extra header lines
 K SDTIT
 Q:SDTY=0  S SDIV=$G(SDIV)
 I SDTY=3 S SDTIT(1)="Facility Summary" Q
 N SDDV S SDDV=$P(SDIV,U)_" ("_$P(SDIV,U,2)_")"
 I SDTY=2 S SDTIT(1)="Summary for division: "_SDDV Q
 S SDTIT(1)="Division: "_SDDV
 S:SDSORT="CP" SDTIT(2)="For clinics with credit pair: "_$$OTX^SCRPW73("CP")
 I $G(SDREPORT)=5 D
 .S:SDSORT="CP" SDTIT(2)="For clinics with selected credit pair"
 .S:SDSORT="CA" SDTIT(2)="For all clinics"
 .S:SDSORT="CL" SDTIT(2)="For clinics selected by name"
 .N DA,DIC,DIQ,DR
 .S DIC=2,SDPT=DIC,DA=$G(DFN) F DR=.01,.09 N SDPT,SDARR S DIQ="SDARR(",DIQ(0)="I" D EN^DIQ1 D
 ..I DR=.01 S SDTIT(3)="Patient: "_SDARR(2,DA,.01,"I")
 ..I DR=.09 S SDTIT(4)="SSN: "_SDARR(2,DA,.09,"I")
 .S SDTIT(5)="Clinic: "_$P(^SC(SC,0),U)
 .S SDTIT(6)="Clinic Stop Code Pair: "_SDCP
 E  S SDTIT(3)="Detail for clinic: "_$$OTX^SCRPW73("CL")
 Q
 ;
SUBT(SDTY,SDREPORT) ;Print subtitles
 D:SDREPORT=1 SUBT1 D:SDREPORT=2 SUBT2
 D:SDREPORT=3 SUBT3 D:SDREPORT=4 SUBT4
 D:SDREPORT=5 SUBT5
 Q
 ;
SUBT1 N SDI
 W !?(SDCOL+44),"Ava.",?(SDCOL+51),"Pct."
 I SDPAST D
 .F SDI=0:1:3 W ?(SDCOL+63+(14*SDI)),"--Type '",SDI,"'---"
 .W ?120,"% NNA   % NA" Q
 W ! W:SDTY>1 ?(SDCOL),"Credit Pair"
 W ?(SDCOL+35),"Clinic",?(SDCOL+43),"Appt.",?(SDCOL+50),"Slots"
 I SDPAST D
 .W ?(SDCOL+56),"Clinic"
 .F SDI=0:1:3 W ?(SDCOL+65+(14*SDI)),"Sch.   Wait"
 .W ?122,"<31    <31" Q
 W !?(SDCOL+4),$S(SDTY=1:"Availability Date",1:"Clinic Name")
 W ?(SDCOL+33),"Capacity",?(SDCOL+43),"Slots",?(SDCOL+51),"Ava."
 I SDPAST D
 .W ?(SDCOL+58),"Enc."
 .F SDI=0:1:3 W ?(SDCOL+64+(14*SDI)),"Appts   Time"
 .W ?121,"Days   Days"
 W !?(SDCOL),$E(SDLINE,1,($S(SDPAST:132,1:58)))
 Q
 ;
SUBT2 N SDI
 W !?48,"Next",?54,$E(SDLINE,1,24),"Non-next Available Appointments",$E(SDLINE,1,23)
 W !?40,"Next    Ava.     0-1     0-1     2-7     2-7    8-30    8-30   31-60   31-60     >60     >60"
 W ! W:SDTY>1 "Credit Pair" W ?40,"Ava.    Wait"
 F SDI=56:16:121 W ?(SDI),"Days    Wait"
 W !?4,$S(SDTY=1:"Availability Date",1:"Clinic Name")
 F SDI=39:16:120 W ?(SDI),"Appts    Time"
 W !,SDLINE
 Q
 ;
SUBT3 N SDI
 W !?38,"Next",?43,$E(SDLINE,1,29),"Non-next Available Appointments",$E(SDLINE,1,29)
 W !?32,"Next  Ava.   0-1   0-1   0-1   2-7   2-7   2-7  8-30  8-30  8-30 31-60 31-60 31-60   >60   >60   >60"
 W ! W:SDTY>1 "Credit Pair" W ?32,"Ava.  Wait"
 F SDI=44:18:117 W ?(SDI),"Days  Wait  Wait"
 W !?4,$S(SDTY=1:"Availability Date",1:"Clinic Name"),?31,"Appts Time1"
 F SDI=43:18:116 W ?(SDI),"Appts Time1 Time2"
 W !,SDLINE
 Q
 ;
SUBT4 W !?96,"Next",!,"Date",?96,"Ava.  Date               Wait   Wait"
 W !,"Scheduled    Patient Name             SSN         Appointment Date   Scheduling Request Type    Ind.  Desired      F/U  Time1  Time2"
 W !,SDLINE
 Q
 ;
SUBT5 W !?11,"SCHEDULING",?63,"TIME",!,"DATE",?11,"REQUEST",?31,"DATE",?58,"WAIT",?63,"TO",?68,"APPT",?96,"APPT",?102,"COMPLETION"
 W !,"SCHEDULED",?11,"TYPE",?31,"DESIRED",?42,"APPT DATE/TIME",?58,"TIME",?63,"APPT",?68,"TYPE",?73,"F/U",?79,"REBOOK DATE",?96,"STAT",?102,"DATE",?113,"SCHEDULER"
 W !,SDLINE
 Q
HDRXM(SDREPORT)   ;Create header in mail message
 ;Input: SDREPORT=report element to print
 ;
 N SDX,SDI,SDZ
 I SDPAGE>1 F SDI=1:1:5 D XMTX("")
 D XMTX($E(SDLINE,1,$S('SDPAST:79,1:132)))
 S SDZ="",$E(SDZ,($S(SDPAST:132,1:79)-$L(SDTITL)\2))=SDTITL D XMTX(SDZ)
 I SDREPORT=1,'SDPAST S SDX="Clinic availability data"
 I SDREPORT=1,SDPAST S SDX="Clinic availability and 'next available' appointment data"
 I SDREPORT=2 S SDX="'Follow up' appointment data"
 I SDREPORT=3 S SDX="'Non-follow up' appointment data"
 I SDREPORT=4 S SDX="Listing of patient appointments"
 I SDREPORT=5 S SDX="Listing of appointments for selected patient"
 S SDZ="",$E(SDZ,($S(SDPAST:132,1:79)-$L(SDX)\2))=SDX D XMTX(SDZ)
 D HDRX(SDTY) S SDI=0
 F  S SDI=$O(SDTIT(SDI)) Q:'SDI  S SDZ="" D
 .S $E(SDZ,($S(SDPAST:130,1:79)-$L(SDTIT(SDI))\2))=SDTIT(SDI) D XMTX(SDZ)
 .Q
 D XMTX($E(SDLINE,1,$S('SDPAST:79,1:132)))
 D XMTX("For clinic availability dates "_SDPBDT_" through "_SDPEDT)
 S SDZ="Date extracted: "_SDPNOW
 D XMTX(SDZ),XMTX($E(SDLINE,1,$S('SDPAST:79,1:132)))
 S SDPAGE=SDPAGE+1 D:SDTY SUBTXM(SDTY,SDREPORT) Q
 ;
SUBTXM(SDTY,SDREPORT) ;Create message header subtitles
 N SDZ
 D:SDREPORT=1 STXM1 D:SDREPORT=2 STXM2
 D:SDREPORT=3 STXM3 D:SDREPORT=4 STXM4
 Q
 ;
STXM1 N SDI
 S SDZ="",$E(SDZ,45)="Ava.",$E(SDZ,52)="Pct."
 I SDPAST D
 .F SDI=0:1:3 D
 ..S $E(SDZ,(SDCOL+64+(14*SDI)))="--Type '"_SDI_"'---"
 ..Q
 .S $E(SDZ,121)="% NNA   % NA"
 .Q
 D XMTX(SDZ)
 S SDZ="" I SDTY>1 S SDZ="Credit Pair"
 S $E(SDZ,36)="Clinic",$E(SDZ,44)="Appt.",$E(SDZ,51)="Slots"
 I SDPAST D
 .S $E(SDZ,57)="Clinic"
 .F SDI=0:1:3 S $E(SDZ,(SDCOL+66+(14*SDI)))="Sch.   Wait"
 .S $E(SDZ,123)="<31    <31"
 .Q
 D XMTX(SDZ)
 S SDZ="",$E(SDZ,4)=$S(SDTY=1:"Availability Date",1:"Clinic Name")
 S $E(SDZ,34)="Capacity",$E(SDZ,44)="Slots",$E(SDZ,52)="Ava."
 I SDPAST D
 .S $E(SDZ,59)="Enc."
 .F SDI=0:1:3 S $E(SDZ,(SDCOL+65+(14*SDI)))="Appts   Time"
 .S $E(SDZ,122)="Days   Days"
 .Q
 D XMTX(SDZ)
 S SDZ="",$E(SDZ,$S(SDTY>1:1,1:4))=$E(SDLINE,1,$S(SDPAST:132,1:58))
 D XMTX(SDZ)
 Q
 ;
STXM2 N SDI S SDZ=""
 S $E(SDZ,49)="Next"
 S $E(SDZ,55)=$E(SDLINE,1,24)_"Non-next Available Appointments"_$E(SDLINE,1,23)
 D XMTX(SDZ) S SDZ=""
 S $E(SDZ,41)="Next    Ava.     0-1     0-1     2-7     2-7    8-30    8-30   31-60   31-60     >60     >60"
 D XMTX(SDZ) S SDZ=""
 S:SDTY>1 SDZ="Credit Pair" S $E(SDZ,41)="Ava.    Wait"
 F SDI=57:16:121 S $E(SDZ,SDI)="Days    Wait"
 D XMTX(SDZ) S SDZ=""
 S $E(SDZ,4)=$S(SDTY=1:"Availability Date",1:"Clinic Name")
 F SDI=40:16:120 S $E(SDZ,SDI)="Appts    Time"
 D XMTX(SDZ) S SDZ=""
 S SDZ=SDLINE D XMTX(SDZ)
 Q
 ;
STXM3 N SDI S SDZ=""
 S $E(SDZ,39)="Next"
 S $E(SDZ,44)=$E(SDLINE,1,29)_"Non-next Available Appointments"_$E(SDLINE,1,29)
 D XMTX(SDZ) S SDZ=""
 S $E(SDZ,33)="Next  Ava.   0-1   0-1   0-1   2-7   2-7   2-7  8-30  8-30  8-30 31-60 31-60 31-60   >60   >60   >60"
 D XMTX(SDZ) S SDZ=""
 S:SDTY>1 SDZ="Credit Pair" S $E(SDZ,33)="Ava.  Wait"
 F SDI=45:18:117 S $E(SDZ,SDI)="Days  Wait  Wait"
 D XMTX(SDZ) S SDZ=""
 S $E(SDZ,4)=$S(SDTY=1:"Availability Date",1:"Clinic Name") S $E(SDZ,32)="Appts Time1"
 F SDI=44:18:116 S $E(SDZ,SDI)="Appts Time1 Time2"
 D XMTX(SDZ) S SDZ=""
 S SDZ=SDLINE D XMTX(SDZ)
 Q
 ;
STXM4 S SDZ=""
 S $E(SDZ,96)="Next"
 D XMTX(SDZ) S SDZ=""
 S SDZ="Date",$E(SDZ,96)="Ava.  Date               Wait   Wait"
 D XMTX(SDZ) S SDZ=""
 S SDZ="Scheduled    Patient Name             SSN         Appointment Date   Scheduling Request Type    Ind.  Desired      F/U  Time1  Time2"
 D XMTX(SDZ) S SDZ=""
 S SDZ=SDLINE D XMTX(SDZ)
 Q
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
XMTX(SDX) ;Set mail message text line
 ;Input: SDX=text value
 S ^TMP("SDXM",$J,SDXM)=SDX,SDXM=SDXM+1 Q
