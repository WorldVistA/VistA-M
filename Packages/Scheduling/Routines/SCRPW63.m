SCRPW63 ;BP-CIOFO/KEITH - SC veterans awaiting appointments (cont.) ; 23 August 2002@20:23
 ;;5.3;Scheduling;**267,269,357,491**;AUG 13, 1993;Build 53
 ;
E ;Gather data for patients entered report
 N DFN,SDX,SDATE,SD0,SDSCEL,SDEL,SDYR,SDREL,SDTOT,SDSDT,SDLVDT,SDEDT
 N SDNAME
 D SCEL^SCRPW62(.SDSCEL,SDSCVT)  ;Get eligibility code pointers
 S (SDSDT,SDATE)=DT-(10000*SDATES),SDSTOP=0
 ;Find the patients entered after date specified
 S DFN=0 F  Q:SDSTOP  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .Q:$D(^DPT(DFN,-9))  ;Skip merged records
 .I DFN#1000=0 D STOP Q:SDSTOP  ;Check for stop task request
 .S SDLVDT=""
 .S SD0=$G(^DPT(DFN,0)) Q:'$L(SD0)
 .S SDEDT=$P(SD0,U,16) S:SDEDT SDLVDT=SDEDT
 .I SDEDT,SDEDT<SDATE Q  ;Date entered < start date
 .I 'SDEDT,SDLVDT<SDATE Q  ;No date entered, last valid date < start
 .S SDEL=+$G(^DPT(DFN,.36)) Q:'$D(SDSCEL(SDEL))  ;Only SC vets
 .Q:+$G(^DPT(DFN,.35))  ;No deceased patients
 .Q:$$SCHAPP(DFN)  ;Appointments not cancelled by clinic?
 .S SDYR=$$FMDIFF^XLFDT(DT,$S(SDEDT:SDEDT,1:SDLVDT))\365.25  ;Year entered
 .S SDEL=SDSCEL(SDEL) D  Q:SDFMT="S"
 ..;Record statistics
 ..S ^TMP("SCRPW",$J,"STATS",SDYR,SDEL)=$G(^TMP("SCRPW",$J,"STATS",SDYR,SDEL))+1
 ..Q
 .S SDNAME=$P(SD0,U) Q:'$L(SDNAME)
 .S ^TMP("SCRPW",$J,SDEL,SDNAME,DFN)=SD0
 .Q
 Q:SDSTOP
 D:$E(IOST,1,2)="C-" DISP0^SCRPW23
 I '$D(^TMP("SCRPW",$J)) D  Q  ;Negative report
 .D HDR^SCRPW62 S SDX="No patients found within report parameters!"
 .W !!?(132-$L(SDX)\2),SDX
 .I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
 .Q
 ;Detailed report
 I SDFMT="D" D HDR^SCRPW62 S SDEL=0 F  S SDEL=$O(^TMP("SCRPW",$J,SDEL)) Q:'SDEL!SDOUT  D
 .S SDNAME="" F  S SDNAME=$O(^TMP("SCRPW",$J,SDEL,SDNAME)) Q:SDNAME=""!SDOUT  S DFN=0 D
 ..F  S DFN=$O(^TMP("SCRPW",$J,SDEL,SDNAME,DFN)) Q:'DFN!SDOUT  D
 ...S SDREL=$S(SDEL=1:0,1:+$P($G(^DPT(DFN,.372,0)),U,4))
 ...D:$Y>(IOSL-(4+SDREL)) HDR^SCRPW62 Q:SDOUT
 ...S SDX=^TMP("SCRPW",$J,SDEL,SDNAME,DFN) D PLINE(DFN,SDX,SDEL)
 ...Q
 .Q
 Q:SDOUT
ESUM ;Print summary
 G:SDELIM EQ
 S SDT(3)="STATISTICAL SUMMARY" D HDR^SCRPW62 Q:SDOUT
 W !! S SDYR="",SDTOT=0
 F  S SDYR=$O(^TMP("SCRPW",$J,"STATS",SDYR)) Q:SDYR=""  D
 .S SDEL=0 F  S SDEL=$O(^TMP("SCRPW",$J,"STATS",SDYR,SDEL)) Q:'SDEL  D
 ..S SDX=$$CSCEL(SDEL)_" veterans entered "_$S(SDYR=0:"in the past year",SDYR=1:"two years ago",SDYR=2:"three years ago",1:"")_":"
 ..W !?36,$J(SDX,45),?83,$J(^TMP("SCRPW",$J,"STATS",SDYR,SDEL),6,0)
 ..S SDTOT=SDTOT+^TMP("SCRPW",$J,"STATS",SDYR,SDEL)
 ..Q
 .Q
 W !?36,$E(SDLINE,1,53),!?75,"TOTAL:",?83,$J(SDTOT,6,0)
EQ I $E(IOST,1,2)="C-" N DIR S DIR(0)="E" W !! D ^DIR
 Q
 ;
SCHAPP(DFN) ;Look for scheduled appointments not cancelled by clinic
 ; Input: DFN=patient ifn
 ;Output: '1' if appointments exist, '0' otherwise
 N SDI,SDX,SDY
 S (SDI,SDY)=0
 F  S SDI=$O(^DPT(DFN,"S",SDI)) Q:'SDI!SDY  D
 .S SDX=$G(^DPT(DFN,"S",SDI,0)) Q:'$L(SDX)
 .S SDX=$P(SDX,U,2) I $L(SDX),"CA"[SDX Q
 .S SDY=1
 .Q
 Q SDY
 ;
A ;Gather data for future appointments report
 N DFN,SDA0,SDX,SDI,SDSCEL,SDEL,SDDATE,SDIFF,SDAPT,SDIVL,SDIVN
 N SDREL,SDTOT,SDIV,SD0,SDNAME
 D SCEL^SCRPW62(.SDSCEL,SDSCVT)  ;Get eligibility code pointers
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN!SDSTOP  D
 .I DFN#1000=0 D STOP Q:SDSTOP  ;Check for stop task request
 .S SDEL=+$G(^DPT(DFN,.36)) Q:'$D(SDSCEL(SDEL))  ;Only SC vets
 .S SDEL=SDSCEL(SDEL)
 .Q:+$G(^DPT(DFN,.35))  ;No deceased patients
 .S SDI=DT F  S SDI=$O(^DPT(DFN,"S",SDI)) Q:'SDI  D
 ..S SDDATE=+$G(^DPT(DFN,"S",SDI,1)) Q:'SDDATE  Q:SDDATE>SDI
 ..S SDA0=$G(^DPT(DFN,"S",SDI,0)) Q:'$L(SDA0)
 ..S SDIV=$P($G(^SC(+SDA0,0)),U,15) Q:'$$DIV(.SDIV)  ;Division check
 ..;Exclude cancelled appointments
 ..S SDX=$P(SDA0,U,2) I $L(SDX),"PCA"[SDX Q
 ..S SDIFF=$$FMDIFF^XLFDT(SDI,SDDATE) Q:SDIFF'>SDATES
 ..S SDNAME=$P($G(^DPT(DFN,0)),U) Q:'$L(SDNAME)
 ..;Record detailed information
 ..S ^TMP("SCRPW",$J,SDIV,SDEL,SDNAME,DFN,SDI)=SDDATE_U_SDA0
 ..S ^TMP("SCRPW",$J,SDIV,SDEL,SDNAME,DFN)=$G(^TMP("SCRPW",$J,SDIV,SDEL,SDNAME,DFN))+1
 ..Q
 .Q
 Q:SDSTOP
 ;Tally up statistics
 S SDIV=0 F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:'SDIV  D
 .S SDEL=0 F  S SDEL=$O(^TMP("SCRPW",$J,SDIV,SDEL)) Q:'SDEL  D
 ..S SDNAME="" F  S SDNAME=$O(^TMP("SCRPW",$J,SDIV,SDEL,SDNAME)) Q:SDNAME=""!SDOUT  D
 ...S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,SDEL,SDNAME,DFN)) Q:'DFN  D
 ....S ^TMP("SCRPW",$J,"STATS",SDIV,SDEL,"PTS")=$G(^TMP("SCRPW",$J,"STATS",SDIV,SDEL,"PTS"))+1
 ....S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,SDIV,SDEL,SDNAME,DFN,SDI)) Q:'SDI  D
 .....S ^TMP("SCRPW",$J,"STATS",SDIV,SDEL,"APPTS")=$G(^TMP("SCRPW",$J,"STATS",SDIV,SDEL,"APPTS"))+1
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 Q:SDSTOP
 ;Print report
 S SDIV="" F  S SDIV=$O(SDDIV(SDIV)) Q:'SDIV  S SDIV(SDDIV(SDIV))=SDIV
 I 'SDDIV,$P(SDDIV,U,2)'="ALL DIVISIONS" D
 .S SDIV($P(SDDIV,U,2))=$$PRIM^VASITE()
 .Q
 I $P(SDDIV,U,2)="ALL DIVISIONS" S SDI=0 D
 .F  S SDI=$O(^TMP("SCRPW",$J,SDI)) Q:'SDI  D
 ..S SDX=$P($G(^DG(40.8,SDI,0)),U) S:$L(SDX) SDIV(SDX)=SDI
 ..Q
 .Q
 D:$E(IOST)="C" DISP0^SCRPW23
 I '$D(^TMP("SCRPW",$J)) D  Q  ;Negative report
 .S SDIV=0 D DHDR^SCRPW40(3,.SDT),HDR^SCRPW62
 .S SDX="No appointments found that meet report criteria."
 .I SDELIM W !,SDX Q
 .W !!?(IOM-$L(SDX)\2),SDX
 .I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
 .Q
 G:SDFMT="S" ASUM
 ;Print detailed report by division
 S SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""!SDOUT  D
 .S SDIV=SDIV(SDIVN) D ADPRT(.SDIV)
 .Q
 Q:SDOUT
 ;Print summary
ASUM G:SDELIM AQ
 S SDT(3)="STATISTICAL SUMMARY" D HDR^SCRPW62 Q:SDOUT
 W !! S (SDTOT,SDIV,SDIVL)=0,SDIVN=""
 F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""  D
 .S SDIVN(SDIV(SDIVN))=SDIVN S:$L(SDIVN)>SDIVL SDIVL=$L(SDIVN)
 F  S SDIV=$O(^TMP("SCRPW",$J,"STATS",SDIV)) Q:'SDIV  D
 .S SDEL=0 F  S SDEL=$O(^TMP("SCRPW",$J,"STATS",SDIV,SDEL)) Q:'SDEL  D
 ..S SDAPT=^TMP("SCRPW",$J,"STATS",SDIV,SDEL,"APPTS"),SDTOT=SDTOT+SDAPT
 ..S SDX=$$CSCEL(SDEL)_" appointments at "_SDIVN(SDIV)_":"
 ..W !?(50-SDIVL),$J(SDX,(28+SDIVL)),?80,$J(SDAPT,6,0)
 ..Q
 .Q
 W !?(50-SDIVL),$E(SDLINE,1,(36+SDIVL)),!?72,"TOTAL:",?80,$J(SDTOT,6,0)
AQ I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
 Q
 ;
DIV(SDIV) ;Check division
 S:'$L(SDIV) SDIV=$$PRIM^VASITE()
 Q:'SDDIV 1  Q $D(SDDIV(+SDIV))
 ;
 ;
STOP ;Check for stop task request
 S:$G(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
ADPRT(SDIV) ;Print report for a division
 D DHDR^SCRPW40(3,.SDT) S:SDELIM SDPAGE=1
 I '$D(^TMP("SCRPW",$J,SDIV)) D HDR^SCRPW62 Q:SDOUT  D  Q
 .S SDX="No appointments found for this division within report parameters!"
 .I SDELIM W !,SDX Q
 .W !!?(132-$L(SDX)\2),SDX Q
 D HDR^SCRPW62 Q:SDOUT
 S SDEL="" F  S SDEL=$O(^TMP("SCRPW",$J,SDIV,SDEL)) Q:'SDEL!SDOUT  D
 .S SDNAME="" F  S SDNAME=$O(^TMP("SCRPW",$J,SDIV,SDEL,SDNAME)) Q:SDNAME=""!SDOUT  D
 ..S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,SDEL,SDNAME,DFN)) Q:'DFN!SDOUT  D
 ...S SD0=$G(^DPT(DFN,0)) Q:'$L(SD0)
 ...S SDREL=$S(SDEL=1:0,1:+$P($G(^DPT(DFN,.372,0)),U,4))
 ...S SDREL=SDREL+^TMP("SCRPW",$J,SDIV,SDEL,SDNAME,DFN)
 ...D:$Y>(IOSL-(4+SDREL)) HDR^SCRPW62 Q:SDOUT
 ...D PLINE(DFN,SD0,SDEL)
 ...Q
 ..Q
 .Q
 Q
 ;
PLINE(DFN,SD0,SDEL) ;Print patient detail line         
 ;Input: DFN=patient ifn
 ;       SD0=zeroeth node of patient record
 ;      SDEL=1 or 3 to denote SC > or < 50%
 ;
 N SDSSN,SDNAME,SDDTE,SDADD,SDST,SDX,SDI,SDY,SDELN,SDZIP,SDZ,SDZA,SDII
 S SDNAME=$P(SD0,U),SDSSN=$P(SD0,U,9),SDDTE=$$FMTE^XLFDT($P(SD0,U,16))
 S SDSSN=$E(SDSSN,1,3)_"-"_$E(SDSSN,4,5)_"-"_$E(SDSSN,6,10)
 S SDEL=$G(SDEL),SDELN=$$CSCEL(SDEL),SDADD=$G(^DPT(DFN,.11))
 S SDST=$P($G(^DIC(5,+$P(SDADD,U,5),0)),U,2),SDZIP=$P(SDADD,U,12)
 S:$L(SDZIP)=9 SDZIP=$E(SDZIP,1,5)_"-"_$E(SDZIP,6,9)
 I SDELIM D  ;Set up delimited output
 .S SDZ=SDNAME_U_SDSSN_U_SDELN_U_SDDTE_U_$P(SDADD,U)_U_$P(SDADD,U,4)
 .S SDZ=SDZ_U_SDST_U_SDZIP_U_$P($G(^DPT(DFN,.13)),U)
 .Q
 I 'SDELIM D
 .;Print name, SSN, eligibility, date entered, address and phone number
 .W !,"Name: ",SDNAME,?39,"SSN: ",SDSSN,?58,"Prim. Elig.: ",SDELN
 .W ?84,"Date entered: ",SDDTE,!?10,"Address: ",$P(SDADD,U)
 .W ?55,$P(SDADD,U,4),$S($L($P(SDADD,U,4)):", ",1:""),SDST,"  ",SDZIP
 .W ?88,"Phone number: ",$P($G(^DPT(DFN,.13)),U)
 .;Print SC disabilities for 0-50% SC veterans
 .I SDEL=3 S SDI=0 F  S SDI=$O(^DPT(DFN,.372,SDI)) Q:'SDI  D
 ..S SDX=$G(^DPT(DFN,.372,SDI,0)) Q:'$P(SDX,U,3)
 ..S SDY=$G(^DIC(31,+SDX,0)) Q:'$L(SDY)
 ..W !?20,"SC disability: ",$P(SDY,U,3),"  ",$P(SDY,U)
 ..W ?89,"%SC: ",$P(SDX,U,2)
 ..Q
 .Q
 I SDRPT="E" D  Q
 .I SDELIM S SDZ(1)=SDZ D DELIM^SCRPW62(.SDZ) Q  ;W !,SDZ Q
 .W !
 .Q
 ;Print appointment details for future appointment report
 S SDI=0 D
 .F  S SDI=$O(^TMP("SCRPW",$J,SDIV,SDEL,SDNAME,DFN,SDI)) Q:'SDI  D
 ..S SDA0=^TMP("SCRPW",$J,SDIV,SDEL,SDNAME,DFN,SDI)
 ..I 'SDELIM D
 ...W !?30,"Appointment: ",$$FMTE^XLFDT(SDI)
 ...W ?63,$P($G(^SC(+$P(SDA0,U,2),0)),U),?96,"Desired date: "
 ...W $$FMTE^XLFDT(+SDA0),?124,"(",$$FMDIFF^XLFDT(SDI,+SDA0),")"
 ...Q
 ..I SDELIM D  ;Delimited output
 ...N SDC0,SDCP,SDCZ,SDADM,SDADME
 ...S SDC0=$G(^SC(+$P(SDA0,U,2),0)),SDCZ=$$CPAIR^SCRPW71(SDC0,.SDCP)
 ...S SDII=0,(SDZA,SDADM,SDADME)=""
 ...F  S SDII=$O(^SC(+$P(SDA0,U,2),"S",SDI,1,SDII)) D  Q:'SDII
 ....Q:+$G(^SC(+$P(SDA0,U,2),"S",SDI,1,+SDII,0))'=DFN
 ....S SDADM=$P(^SC(+$P(SDA0,U,2),"S",SDI,1,+SDII,0),U,7)
 ....S SDADME=$$FMTE^XLFDT(SDADM),SDII=0
 ....Q
 ...S SDCZ=SDCP_U_$P($$SITE^VASITE(,$P(SDC0,U,15)),U,2)_U_SDADME
 ...S SDZA=SDZA_U_$$FMTE^XLFDT(SDI)_U_$P(SDC0,U)_U_SDCZ
 ...S SDZA=SDZA_U_$$FMTE^XLFDT(+SDA0)_U_$$FMDIFF^XLFDT(SDI,+SDA0)
 ...S SDZA=SDZA_U_$S(SDADM:$$FMDIFF^XLFDT(+SDA0,SDADM),1:"")
 ...S SDZ(1)=SDZ_SDZA
 ...D DELIM^SCRPW62(.SDZ)  ;W !,SDZ,SDZA
 ...Q
 ..Q
 .Q
 W:'SDELIM ! Q
 ;
CSCEL(SDEL) ;Convert SC elig. to external
 Q $S(SDEL=1:"SC 50-100%",SDEL=3:"SC < 50%",1:"")
