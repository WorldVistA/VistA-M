DGSSNRP2 ;ALB/SEK/PHH - DUPLICATE SPOUSE/DEPENDENT Report - Continued; 04/07/2004
 ;;5.3;Registration;**313,535,568**;Aug 13,1993
 ;
MAIN ;
 N X S X=$$DT^XLFDT
 S ^XTMP("DG-SSNRP2",0)=X+1_U_X_"^DG DUPLICATE SSN REPORT "
 D GETDATA
 I $D(ZTQUEUED) D
 .N ZTRTN,ZTDESC,ZTSK,ZTIO
 .S ZTRTN="PRINT^DGSSNRP2",ZTDESC="Duplicate Spouse/Dependent SSN Report",ZTIO="`"_DEV
 .S:$D(HFS) IO("HFSIO")=HFS
 .S:$D(PAR) IOPAR=PAR
 .D ^%ZTLOAD
 .S ZTREQ="@"
 E  S IOP="`"_IOS D ^%ZIS,PRINT,HOME^%ZIS
 Q
PRINT ;
 N STATS,CRT,QUIT,PAGE,PART1D,PART2D,PART1ST,SECTION,DGVETNM,DGVETSSN,VA,VADM,VAERR
 K DEV,HFS,PAR
 S (QUIT,PAGE)=0,CRT=$S($E(IOST,1,2)="C-":1,1:0)
 U IO
 I CRT,PAGE=0 W @IOF
 S (PAGE,PART1D,PART2D)=1,SECTION="PART1"
 D CHECKP1,HEADER
 I PART1D D PPART1
 I QUIT K ^XTMP("DG-SSNRP2") Q
 S SECTION="PART2"
 S:'$D(^XTMP("DG-SSNRP2","DGPART2")) PART2D=0
 D HEADER
 I PART2D D PPART2
 I CRT,'QUIT D PAUSE
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
 K ^XTMP("DG-SSNRP2"),^TMP("DGSSNAR",$J)
 Q
LINE(LINE) ; Prints header if end of page.
 I CRT,($Y>(IOSL-4)) D  Q:QUIT
 .D PAUSE
 .Q:QUIT
 .W @IOF
 .D HEADER Q:QUIT
 .W:SECTION="PART1" !
 .W LINE
 ;
 E  I ('CRT),($Y>(IOSL-2)) D
 .W @IOF
 .D HEADER
 .W !,LINE
 ;
 E  W !,LINE
 Q
 ;
GETDATA ;Setup global with vets included in the report
 D GETPART1
 D GETPART2
 Q
 ;
GETPART1 ;1st part of report
 ;S ^XTMP("DG-SSNRP2","DGPART1",DGVETSSN)=DGVETNM
 ;S ^XTMP("DG-SSNRP2","DGPART1",DGVETSSN,DGCTR1)=DGDEPNM^DGDEPSSN^DGDEPREL
 N DFN,DG40812,DGDEP,DGDEPIEN,DGIEN,DGSSNCTR,VARR
 K ^TMP("DGSSNAR",$J) S VARR=1
 S DFN=0 F  S DFN=$O(^DGPR(408.12,"B",DFN)) Q:'DFN  D
 .S (DGIEN,DGSSNCTR)=0
 .F  S DGIEN=$O(^DGPR(408.12,"B",DFN,DGIEN)) D  Q:'DGIEN
 ..Q:'DGIEN
 ..S DG40812=$G(^DGPR(408.12,DGIEN,0)) Q:'DG40812
 ..I DG40812["DPT" D  Q
 ...;if can't get veteran's SSN kill array and get next veteran
 ...D DEM^VADPT
 ...I '$P(VADM(2),"^") K ^TMP("DGSSNAR",$J,DFN) S DGIEN="" Q
 ...; Check if patient has a Date of Death
 ...I '$$OKRPT(DFN,.VADM) Q
 ...; Check if patient was IN/OUT patient in last 3 years
 ...I $$OKIMP(DFN)
 ...;^TMP("DGSSNAR",$J) for vet (subscript "V") = name^SSN (no P)^SSN (with P)
 ...S ^TMP("DGSSNAR",$J,DFN,"V")=VADM(1)_"^"_$TR(VADM(2),"-P","")_"^"_$P(VADM(2),"^")
 ..;^TMP("DGSSNAR",$J) for dependents = SSN or Not Available^name^relationship code
 ..I DG40812["DGPR" D  Q
 ...S DGDEPIEN=$P($P(DG40812,"^",3),";") Q:'DGDEPIEN
 ...S DGDEP=$G(^DGPR(408.13,DGDEPIEN,0)) Q:DGDEP']""
 ...S DGSSNCTR=DGSSNCTR+1
 ...S ^TMP("DGSSNAR",$J,DFN,"D",DGSSNCTR)=$S($P(DGDEP,"^",9):$P(DGDEP,"^",9),1:"Not Available")_"^"_$P(DGDEP,"^")_"^"_$P(DG40812,"^",2)
 .D:$D(^TMP("DGSSNAR",$J,DFN)) VBLDARR(DFN)
 ;
 D SDAM,SETTMPA
 Q
 ;
SETTMPA ;check if spouse/dep SSN is the same as the vet's SSN or if not available (missing)
 N DGDEPSSN,DGSCTR,DGTMPN1,DGVETSNP,AFLG,APPCK,APPTYP
 S DFN=0 F  S DFN=$O(^TMP("DGSSNAR",$J,DFN)) Q:'DFN  D
 .; Only want appts kept in the last 3 years
 .I '$$OK2RPT(DFN) K ^TMP("DGSSNAR",$J,DFN),^TMP($J,"SDAMA",DFN) Q
 .S DGSSNCTR=+($O(^TMP("DGSSNAR",$J,DFN,"D",""),-1))
 .I ('DGSSNCTR)!('$D(^TMP("DGSSNAR",$J,DFN,"V"))) K ^TMP("DGSSNAR",$J,DFN) Q
 .S DGVETSNP=$P(^TMP("DGSSNAR",$J,DFN,"V"),"^",2)
 .S DGTMPN1=0
 .F DGSCTR=1:1:DGSSNCTR D
 ..S DGDEPSSN=$P(^TMP("DGSSNAR",$J,DFN,"D",DGSCTR),"^")
 ..Q:((DGDEPSSN'=DGVETSNP)&(DGDEPSSN))
 ..I 'DGTMPN1 S ^XTMP("DG-SSNRP2","DGPART1",("A"_$P(^TMP("DGSSNAR",$J,DFN,"V"),"^",3)))=$P(^TMP("DGSSNAR",$J,DFN,"V"),"^"),DGTMPN1=1
 ..S ^XTMP("DG-SSNRP2","DGPART1",("A"_$P(^TMP("DGSSNAR",$J,DFN,"V"),"^",3)),DGSCTR)=$P(^TMP("DGSSNAR",$J,DFN,"D",DGSCTR),"^",2)_"^"_DGDEPSSN_"^"_$P(^TMP("DGSSNAR",$J,DFN,"D",DGSCTR),"^",3)
 Q
 ;
GETPART2 ;2nd part of report
 ;S ^XTMP("DG-SSNRP2","DGPART2",DGDEPSSN,DGCTR2)=DGDEPNM^DGDEPEL^DGVETSSN
 N DGSSN,DGSSND,DGSSNDA,DGSSN1,DGSSNCTR
 K ^TMP("DGSSNAR",$J)
 S DGSSN=0 F  S DGSSN=$O(^DGPR(408.13,"SSN",DGSSN)) D  Q:'DGSSN
 .Q:'DGSSN
 .S DGSSN1="A"_DGSSN
 .S (DGSSNDA,DGSSNCTR)=0
 .F  S DGSSNDA=$O(^DGPR(408.13,"SSN",DGSSN,DGSSNDA)) D  Q:'DGSSNDA
 ..Q:'DGSSNDA
 ..S DGSSND=$G(^DGPR(408.13,DGSSNDA,0)) Q:DGSSND']""
 ..;^TMP("DGSSNAR",$J) array = IEN of INCOME PERSON file (#408.13)^dependent name
 ..S DGSSNCTR=DGSSNCTR+1
 ..S ^TMP("DGSSNAR",$J,DGSSN1,DGSSNCTR)=DGSSNDA_"^"_$P(DGSSND,"^")
 ;
 D SELPRT2,SDAM,SETTMP
 Q
 ;
SETTMP ; Spouse/dependent with the same SSN
 N DGSSNCTR,DGDEPNM,DGDEPREL,DGPAT,DGPATRL,DGSCTR,DGSSNDA1,DGVETSN2
 S DGSSN="" F  S DGSSN=$O(^TMP("DGSSNAR",$J,DGSSN)) Q:DGSSN=""  D
 .S DGSSNCTR=+($O(^TMP("DGSSNAR",$J,DGSSN,""),-1))
 .F DGSCTR=1:1:DGSSNCTR D
 ..S DGSSNDA1=$P(^TMP("DGSSNAR",$J,DGSSN,DGSCTR),"^")
 ..S DGDEPNM=$P(^TMP("DGSSNAR",$J,DGSSN,DGSCTR),"^",2)
 ..S DGPAT=$O(^DGPR(408.12,"C",DGSSNDA1_";DGPR(408.13,",0))
 ..S DGPATRL=$G(^DGPR(408.12,+DGPAT,0))
 ..;missing "C" x-ref or 0 node of 408.12 record
 ..I 'DGPATRL S DGDEPREL="U",DGVETSN2="UNKNOWN"
 ..E  D  I +DGVETSN2 Q:'$$OK2RPT(DFN)
 ...S DFN=+DGPATRL
 ...D DEM^VADPT
 ...S DGVETSN2=$P($G(VADM(2)),"^")
 ...S DGDEPREL=$P(DGPATRL,"^",2)
 ..S ^XTMP("DG-SSNRP2","DGPART2",DGSSN,DGSCTR)=DGDEPNM_"^"_DGDEPREL_"^"_DGVETSN2
 Q
 ;
CHECKP1 ;if there is no part1 data S PART1D=0
 ;if data S PART1ST=1 indicating 1st time thru header
 I '$D(^XTMP("DG-SSNRP2","DGPART1")) S PART1D=0 Q
 S PART1ST=1
 Q
 ;
HEADER ;Description: Prints the report header.
 Q:QUIT
 N LINE
 I $Y>1 W @IOF
 W !,?21,"Duplicate Spouse/Dependent SSN Report"
 W ?70,"Page ",PAGE,!,?26,"Date Generated: "_$$FMTE^XLFDT(DT)
 S PAGE=PAGE+1
 ;
 W !,$S(SECTION="PART1":"            Spouse/Dependent with no SSN or the same SSN as Veteran",1:"         Spouse/Dependent with the same SSN as another Spouse/Dependent")
 I SECTION="PART1" D
 .I 'PART1D,$D(^TMP($J,"SDAMA","ERR")) W !!,?10,"Appointment Database Unavailable to validate active veterans." Q
 .I 'PART1D W !!,?25,"No entries meet this criteria" Q
 .I 'PART1ST D PART1HD Q
 .S PART1ST=0
 I SECTION="PART2" D
 .W !!
 .I 'PART2D,$D(^TMP($J,"SDAMA","ERR")) W !!,?10,"Appointment Database Unavailable to validate active veterans." Q
 .I 'PART2D W ?25,"No entries meet this criteria" Q
 .W "Spouse/Dependent Name",?33,"Spouse/Dependent SSN",?55,"Relationship",?69,"Veteran SSN"
 Q
 ;
PAUSE N DIR,DIRUT,X,Y
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E" D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 Q
 ;
PPART1 ;Description: Prints Part 1 - Spouse/Dependent with no SSN or the same SSN as Veteran
 N DGPART1,DGSCTR,LINE S DGVETSSN=0
 F  S DGVETSSN=$O(^XTMP("DG-SSNRP2","DGPART1",DGVETSSN)) Q:DGVETSSN']""  D  Q:QUIT
 .S DGSCTR=0,DGVETNM=$G(^XTMP("DG-SSNRP2","DGPART1",DGVETSSN))
 .Q:QUIT  D PART1HEA Q:QUIT
 .F  S DGSCTR=$O(^XTMP("DG-SSNRP2","DGPART1",DGVETSSN,DGSCTR)) Q:'DGSCTR  D  Q:QUIT
 ..S DGPART1=$G(^XTMP("DG-SSNRP2","DGPART1",DGVETSSN,DGSCTR))
 ..Q:DGPART1']""
 ..S LINE=$$LJ(" "_$P(DGPART1,"^"),25)_"     "_$$LJ($P(DGPART1,"^",2),22)
 ..S LINE=LINE_$$LJ($$RELCODE($P(DGPART1,"^",3)),12)
 ..D LINE(LINE) Q:QUIT
 ..Q:QUIT
 .Q:QUIT
 Q
 ;
PPART2 ;Description: Prints Part 2 -Spouse/Dependent with the same SSN as another Spouse/Dependent
 N DGDEPSSN,DGPART2,DGP2F,DGSCTR,LINE
 S DGP2F=1,DGDEPSSN=0
 F  S DGDEPSSN=$O(^XTMP("DG-SSNRP2","DGPART2",DGDEPSSN)) Q:DGDEPSSN']""  D  Q:QUIT
 .I 'DGP2F W !
 .E  S DGP2F=0
 .S DGSCTR=0
 .F  S DGSCTR=$O(^XTMP("DG-SSNRP2","DGPART2",DGDEPSSN,DGSCTR)) Q:'DGSCTR  D  Q:QUIT
 ..S DGPART2=$G(^XTMP("DG-SSNRP2","DGPART2",DGDEPSSN,DGSCTR))
 ..Q:DGPART2']""
 ..S LINE=$$LJ(" "_$P(DGPART2,"^"),29)_"     "_$$LJ($E(DGDEPSSN,2,10),21)
 ..S LINE=LINE_$$LJ($$RELCODE($P(DGPART2,"^",2)),13)
 ..S LINE=LINE_$$LJ(" "_$P(DGPART2,"^",3),10)
 ..D LINE(LINE) Q:QUIT
 ..Q:QUIT
 .Q:QUIT
 Q
 ;
LJ(STRING,LENGTH) ;
 Q $$LJ^XLFSTR($E(STRING,1,LENGTH),LENGTH)
 ;
RELCODE(DGCODE) ;returns relationship name from RELATIONSHIP file (#408.11)
 ;
 N DGNAME S DGNAME=$P($G(^DG(408.11,+DGCODE,0)),"^")
 I DGNAME']"" Q "UNKNOWN"
 Q DGNAME
 ;
PART1HEA ;heading for part1 (vet name & SSN and spouse/dep name & SSN)
 I ('CRT),($Y>(IOSL-6)) D  Q
 .D HEADER
 ;
 E  I CRT,($Y>(IOSL-8)) D  Q:QUIT
 .D PAUSE
 .Q:QUIT
 .D HEADER
 ;
 E  D PART1HD
 Q
 ;
PART1HD W !!,"Veteran: ",$$LJ(DGVETNM,30),"     Veteran SSN: ",$$LJ($E(DGVETSSN,2,11),10),!!,"  Spouse/Dependent Name       Spouse/Dependent SSN  Relationship"
 Q
OKRPT(DFN,VADM) ; Date of Death?
 N X,X1,X2
 I '$D(VADM) D DEM^VADPT
 I +VADM(6) Q 0
 Q 1
 ;
OKIMP(DFN) ; Inpatient or Outpatient in the last 3 years?
 N VAIP S VAIP("D")="LAST" D IN5^VADPT
 I VAIP(3)'="" D  Q '(X>1095)
 .S X1=DT,X2=$P(VAIP(3),U)\1 D ^%DTC
 .I X<1096 S ^TMP($J,"SDAMA",DFN,+VAIP(3))="^^I;INPATIENT"
 Q 1
 ;
OK2RPT(DFN) ; Appt kept in the last 3 years?
 N APPCK,AFLG S (APPCK,AFLG)=0
 F  S APPCK=$O(^TMP($J,"SDAMA",DFN,APPCK)) Q:'APPCK!(AFLG)  D
 .S APPTYP=$P($P(^TMP($J,"SDAMA",DFN,APPCK),U,3),";")
 .I "^R^I^"[(U_APPTYP_U) S AFLG=1
 Q AFLG
 ;
VBLDARR(DFN) ; Build array of specified veterans
 S ^TMP($J,"SDAMAPI",VARR)=$G(^TMP($J,"SDAMAPI",VARR))_DFN_";"
 I $L(^TMP($J,"SDAMAPI",VARR))>180 S VARR=VARR+1
 Q
 ;
SDAM N DGARRAY,I,SDCNT
 S DGARRAY(1)=$$FMADD^XLFDT(DT,-1095)_";"_DT,DGARRAY("FLDS")=3,DGARRAY("SORT")="P"
 F I=1:1 Q:'$D(^TMP($J,"SDAMAPI",I))  D
 .S DGARRAY(4)=^TMP($J,"SDAMAPI",I)
 .S SDCNT=$$SDAPI^SDAMA301(.DGARRAY)
 .I SDCNT'>0 K ^TMP($J,"SDAMA301"),^TMP($J,"SDAMAPI",I) Q
 .M ^TMP($J,"SDAMA")=^TMP($J,"SDAMA301")
 .K ^TMP($J,"SDAMA301"),^TMP($J,"SDAMAPI",I)
 I '$D(^TMP($J,"SDAMA")) S ^TMP($J,"SDAMA","ERR")=""
 Q
 ;
SELPRT2 ; Select records for Part 2
 N DGSSN,DGCNT,DGSSNP,DGPTR,DGPTRL,VARR S VARR=1
 S DGSSN="" F  S DGSSN=$O(^TMP("DGSSNAR",$J,DGSSN)) Q:DGSSN=""  D
 .S DGCNT=$O(^TMP("DGSSNAR",$J,DGSSN,""),-1)
 .I DGCNT<2 K ^TMP("DGSSNAR",$J,DGSSN) Q
 .S DGSSNP=$P(^TMP("DGSSNAR",$J,DGSSN,DGCNT),U)
 .S DGPTR=$O(^DGPR(408.12,"C",DGSSNP_";DGPR(408.13,",0))
 .S DGPTRL=+$G(^DGPR(408.12,+DGPTR,0))
 .I $$OKIMP(DGPTRL)
 .Q:$D(^TMP($J,"SDAMA",DGPTRL))
 .D VBLDARR(DGPTRL)
 Q
