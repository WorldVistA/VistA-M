ECXOBSUR ;ALB/CMD - Surgery Pre-Extract Observation Report ;4/28/20  13:18
 ;;3.0;DSS EXTRACTS;**178**;Dec 22, 1997;Build 67
 ;Reference to MVT^DGPMOBS supported by IA #2664
 ;Reference to global ^SRF supported by ICR #130
 ;Reference to global ^DGPM supported by ICR #1865
 ;
EN ; Entry point
 N X,Y,DATE,ECRUN,ECXDESC,ECXSAVE,ECXPORT,CNT
 N ECSD,ECSD1,ECSTART,ECED,ECEND,ECXERR,QFLG
 K ^TMP($J),^TMP($J,"ECXPORT")
 S QFLG=0
 ; get today's date
 D NOW^%DTC S DATE=X,Y=$E(%,1,12) D DD^%DT S ECRUN=$TR(Y,"@"," ") K %DT
 D BEGIN Q:QFLG
 D SELECT Q:QFLG
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D  Q
 .S ^TMP($J,"ECXPORT",0)="NAME^SSN^OBS ADM DATE/TIME^OBS TREATING SPECIALTY^OBS ENTERED BY^DATE/TIME IN HOLD AREA^DATE/TIME IN  OR^CASE#^PRINCIPAL PROCEDURE"
 .D PROCESS
 .D EXPDISP^ECXUTL1
 .D AUDIT^ECXKILL
 S ECXDESC="Surgery Pre-Extract Observation Report"
 S ECXSAVE("EC*")=""
 W !!,"This report requires 132-column format."
 D EN^XUTMDEVQ("PROCESS^ECXOBSUR",ECXDESC,.ECXSAVE)
 I POP W !!,"No device selected...exiting.",! Q
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
SELECT ;Start Date and End Date of the Report
 N DONE
 S DONE=0
 F  S (ECED,ECSD)="" D  Q:QFLG!DONE
 .K %DT S %DT="AEX",%DT("A")="Starting with Date: ",%DT(0)=-DATE D ^%DT
 .I Y<0 S QFLG=1 Q
 .S ECSD=Y,ECSD1=ECSD-.1
 .D DD^%DT S ECSTART=Y
 .K %DT S %DT="AEX",%DT("A")="Ending with Date: ",%DT(0)=-DATE D ^%DT
 .I Y<0 S QFLG=1 Q
 .I Y<ECSD D  Q
 ..W !!,"The ending date cannot be earlier than the starting date."
 ..W !,"Please try again.",!!
 .I $E(Y,1,5)'=$E(ECSD,1,5) D  Q
 ..W !!,"Beginning and ending dates must be in the same month and year"
 ..W !,"Please try again.",!!
 .S ECED=Y
 .D DD^%DT S ECEND=Y
 .S DONE=1
 Q
 ;
PROCESS ;Queue report  for the date range
 N ECD
 S ZTREQ="@"
 S ECXERR=0
 I '$G(ECXPORT) K ^TMP($J)
 S COUNT=0
 S ECD=ECSD1
 F  S ECD=$O(^SRF("AC",ECD)) Q:(ECD="")!((ECD\1)>ECED)!(ECXERR)  D
 .S ECD0=0
 .F  S ECD0=$O(^SRF("AC",ECD,ECD0)) Q:'ECD0  D
 ..I $D(^SRF(ECD0,0)) D GETDATA
 D PRINT
 Q
 ;
GETDATA ;Get data from surgery file
 N DATA2,DATAOBS,DATAOP,ECXDFN,ECXDATE,EC0,ECCAN
 N PTINOR,PATINHLD,PATINOR,PATMN,PATMBY,SUOBSDT,SUOBSTS
 N NAME,SSN,SSNO,TSCODE,TSCDSTR,ECTSDT,PTMVIEN,PTMVDT,PTMVIDT,OBS
 S ECXDATE=ECD,ECXERR=0
 S TSCDSTR="18;24;41;65;94;1J"
 S EC0=^SRF(ECD0,0),ECXDFN=$P(EC0,U)
 S ECCAN=$P($G(^SRF(ECD0,30)),U) I +ECCAN Q  ;case is cancelled
 ;Check the Hospital Admission Status (I=Inpatient,O=Outpat,1=Same Day,2=Admission,3=Hospitalized
 ;I $P(EC0,U,12)'=1 Q  ;Hospital Admission Status is not "Same Day" (Observation)
 Q:'$$PATDEM^ECXUTL2(ECXDFN,ECXDATE,"1;")
 S DATA2=$G(^SRF(ECD0,.2))
 S DATAOBS=$G(^SRF(ECD0,208.1))
 S DATAOP=$G(^SRF(ECD0,"OP"))
 I $TR(DATAOBS,"NA^")="" Q  ;no OBS information on the case
 S SUOBSTS=$P(DATAOBS,U,3) ;OBS Treating Specialty
 S SUOBSTSO=$$RJ^XLFSTR($P($G(^DIC(42.4,SUOBSTS,0)),U),3,0)
 S TSCODE=$$GET1^DIQ(42.4,SUOBSTS,7) ;Treating Specialty Code
 I $F(TSCDSTR,TSCODE)<2 Q 
 S SUOBSDT=$P(DATAOBS,U)
 S PTINOR=$P(DATA2,U,10)
 I $$FMDIFF^XLFDT(PTINOR,SUOBSDT,2)'>0 Q  ; Only pick up cases that have Observation before Surgery.
 S PTMVIDT=10000000-SUOBSDT  ; Inverse Date of OBS Admission Date
 S PTMVDT=$O(^DGPM("ATID6",ECXDFN,PTMVIDT),-1) ;Get the Treating Specialty Transfer Date
 S PTMVIEN=0
 S PTMVIEN=$O(^DGPM("ATID6",ECXDFN,PTMVDT,PTMVIEN))
 S NAME=$$GET1^DIQ(2,ECXDFN,.01),NAME=$E(NAME,1,30)
 I NAME="" Q
 S SSN=$$GET1^DIQ(2,ECXDFN,.09)
 S SSNO=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 S PATMENT=$P(^DGPM(PTMVIEN,"USR"),U) ;ICR#1865
 S PATMBY=$$GET1^DIQ(200,PATMENT,.01)
 S PATMBY=$E(PATMBY,1,20)
 D FILE
 Q
 ;
FILE ; Set data in temp file to print later
 N PATINHLD,ECXPROC
 S SUOBSDTO=$$FMTE^XLFDT(SUOBSDT) S:SUOBSDTO="" SUOBSDTO="NO DATE/TIME" ;OBS ADM D/T
 S PATINOR=$$FMTE^XLFDT(PTINOR) S:PATINOR="" PATINOR="NO DATE/TIME" ;DT IN OR 
 S PATINHLD=$$FMTE^XLFDT($P(DATA2,U,15)) S:PATINHLD="" PATINHLD="NO DATE/TIME" ;DT IN HOLD AREA
 I $G(ECXPORT) S TSCODE=$P(^DIC(42.4,SUOBSTS,0),"^")
 S ECXPROC=$S('$G(ECXPORT):$E($P(DATAOP,U),1,50),1:$P(DATAOP,U)) ;Display full procedure if exporting
 S ^TMP($J,SUOBSDT,ECD0)=NAME_U_SSNO_U_SUOBSDTO_U_TSCODE_U_PATMBY_U_PATINHLD_U_PATINOR_U_$P(ECXPROC,U)_U_ECD0
 S COUNT=COUNT+1
 I COUNT#100=0 I $$S^ZTLOAD S (ZTSTOP,ECXERR)=1
 Q
 ;
BEGIN ; display report description
 W @IOF
 W !,"This report prints a listing of patients who had surgery while in observation "
 W !,"status.  As a pre-extract report, it should be run prior to the generation of"
 W !,"the surgery extract to identify and fix as necessary any record determined to be"
 W !,"erroneous.  This report has no effect on the actual extracts and can be run as"
 W !,"needed."
 W !!,"The report is sorted by Observation Admission Date. "
 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 W:$Y!($E(IOST)="C") @IOF,!!
 Q
 ;
HEADER ;Header of the report
 N SS,JJ,I
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,"Surgery Pre-Extract Observation Report",?124,"Page: "_PG
 W !,"Start Date: ",ECSTART,?91,"Report Run Date/Time: "_ECRUN
 W !,"End Date:   ",ECEND
 S LGDONE=0
 Q
 ;
WRTLN ;Write report line
 W !!,"Name: ",$P(REC,U),?44,"Principal Procedure: ",$P(REC,U,8)
 D HDRLN
 W !,$P(REC,U,2),?14,$P(REC,U,3),?37,$P(REC,U,4),?44,$P(REC,U,5),?67,$P(REC,U,6),?88,$P(REC,U,7),?110,$P(REC,U,9)
 W !
 Q
 ;
HDRLN ;Line Header
 I $Y+8>IOSL D WRTLGLN,HEADER Q:QFLG
 W !!,?17,"OBSERVATION",?35,"OBS TS",?48,"OBSERVATION",?67,"DATE/TIME PATIENT",?88,"DATE/TIME PATIENT",?110,"SURGICAL"
 W !,?4,"SSN",?18,"ADMISSION",?36,"CODE",?46,"ADMIT ENTERED BY",?68,"IN HOLDING AREA",?93,"IN  OR",?110,"CASE No."
 W !,$E(LN,1,11),?14,$E(LN,1,18),?35,$E(LN,1,6),?44,$E(LN,1,20),?67,$E(LN,1,18),?88,$E(LN,1,18),?110,$E(LN,1,9)
 Q
 ;
WRTLGLN ;Write legend line
 W !!,"Observation",?26,"18 Neurology Observation",?60,"24 Medical Observation",?96,"41 Rehab Medicine Observation"
 W !,"Treating Specialties",?26,"65 Surgical Observation",?60,"94 Psychiatric Observation",?96,"1J ED Observation"
 S LGDONE=1
 Q
 ;
PRINT ;Print report from temp file
 N PG,QFLG,LN,LGDONE,REC,OBSDT,CASENO,CNT,COUNT,SS,JJ
 S OBSDT="",(CNT,COUNT,PG,QFLG)=0
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (PG,QFLG)=0,$P(LN,"-",132)=""
 I '$G(ECXPORT) D HEADER Q:QFLG
 F  S OBSDT=$O(^TMP($J,OBSDT)) Q:OBSDT=""!(QFLG)!(OBSDT="ECXPORT")  D
 .S CASENO=0
 .F  S CASENO=$O(^TMP($J,OBSDT,CASENO)) Q:CASENO=""!(QFLG)  D
 ..S REC=^TMP($J,OBSDT,CASENO)
 ..I $G(ECXPORT) D  Q
 ...S CNT=CNT+1
 ...S ^TMP($J,"ECXPORT",CNT)=$P(REC,U)_U_$P(REC,U,2)_U_$P(REC,U,3)_U_$P(REC,U,4)_U_$P(REC,U,5)_U_$P(REC,U,6)_U_$P(REC,U,7)_U_CASENO_U_$P(REC,U,8)
 ..S COUNT=COUNT+1
 ..D WRTLN
 ..I $Y+8>IOSL D WRTLGLN D:$O(^TMP($J,OBSDT))'="" HEADER Q:QFLG
 Q:QFLG!($G(ECXPORT))
 I COUNT=0 W !!,?26,"* * *  No Observation Surgeries to report for the selected date range  * * *"
CLOSE ;
 I $E(IOST)="C",'QFLG D
 .S SS=$S(COUNT>0:18,1:22)-$Y F JJ=1:1:SS W !
 .I COUNT>0,'LGDONE D WRTLGLN
 .S DIR(0)="E" W ! D ^DIR K DIR
 Q
