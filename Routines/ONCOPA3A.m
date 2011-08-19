ONCOPA3A ;Hines OIFO/RTK - [PA Print Complete Abstract (132c) ;11/29/10
 ;;2.11;ONCOLOGY;**15,17,25,26,44,50,51,52**;Mar 07, 1995;Build 13
 ;[PA Print Complete Abstract (132c)] continued
 S NAME="FOLLOW-UP HISTORY" D FORMAT^ONCOPA1
 W !!,TITLE,!
 I $D(^ONCO(160,PTIEN,"F",0)) D FH Q:EX=U
 W !!,"   Date of Last Contact:  ",ONCAB(165.5,IEN,200)
 W ?50,"   Last Tumor Status:  ",ONCAB(165.5,IEN,95) D P Q:EX=U
 W !!,"   Date of Death:  ",ONCAB(160,PTIEN,29) D P Q:EX=U
 ;W !,"   Cause of Death:  ",ONCAB(160,PTIEN,18.9) D P Q:EX=U
 ;W !,"   ICD Cause of Death:  ",ONCAB(160,PTIEN,19),"  "
 ;S ICDCD=$P($G(^ONCO(160,PTIEN,1)),U,3) I ICDCD'="" S IC=$$ICDDX^ICDCODE(ICDCD) I +IC'=-1 W $P(IC,U,4) D P Q:EX=U
 W !,"   State Death Cert:  ",$P($G(^ONCO(160,PTIEN,1)),U,14),"  ",ONCAB(160,PTIEN,19.1) D P Q:EX=U
 W !,"   ICD Revision:  ",ONCAB(160,PTIEN,20) D P Q:EX=U
 W !,"   Place of Death:  ",ONCAB(160,PTIEN,21) D P Q:EX=U
 W !,"   Care Center at Death:  ",ONCAB(160,PTIEN,24.5) D P Q:EX=U
 W !,"   Autopsy:  ",ONCAB(160,PTIEN,22.9) D P Q:EX=U
 W !,"   Autopsy Date/Time:  ",ONCAB(160,PTIEN,23) D P Q:EX=U
 W !,"   Autopsy No.:  ",ONCAB(160,PTIEN,24) D P Q:EX=U
 W !,"   Path/Autopsy:  " F PATH=0:0 S PATH=$O(^ONCO(160,PTIEN,4,PATH)) Q:PATH'>0  W !?8,$G(^ONCO(160,PTIEN,4,PATH,0)) D P Q:EX=U
 I $P($G(^ONCO(160,PTIEN,1)),U,1)=0 W !!?30,"TUMOR Status at DEATH (Multiple Primaries)",! S CNTR=1 F PRI=0:0 S PRI=$O(^ONCO(165.5,"C",PTIEN,PRI)) Q:PRI'>0  I $$DIV^ONCFUNC(PRI)=DUZ(2) D
 .S ZN=$G(^ONCO(165.5,PRI,0)) Q:ZN=""
 .S CNTR=CNTR+1,ST=$P(ZN,U,1),TOP=$P($G(^ONCO(165.5,PRI,2)),U,1)
 .S SITE=$S(TOP'="":$P($G(^ONCO(164,TOP,0)),U,1),1:$P($G(^ONCO(164.2,ST,0)),U,1))
 .S TSTAT=$P($G(^ONCO(165.5,PRI,7)),U,6)
 .I CNTR#2=0 W !?3,SITE,":  " I TSTAT'="" W $P($G(^ONCO(164.42,TSTAT,0)),U,1)
 .I CNTR#2'=0 W ?70,SITE,":  " I TSTAT'="" W $P($G(^ONCO(164.42,TSTAT,0)),U,1) D P Q:EX=U
 .Q
 W !
 I $G(PRTPCE)=1 D PCEPRT^ONCOGEN
 Q
FH ; Do the Follow-Up History display (#160,#400 multiple "F" node)
 F FOLH=0:0 S FOLH=$O(^ONCO(160,PTIEN,"F","AA",FOLH)) Q:FOLH'>0!(EX=U)  D
 .S FHIEN=$O(^ONCO(160,PTIEN,"F","AA",FOLH,""))
 .S FHZN=$G(^ONCO(160,PTIEN,"F",FHIEN,0)),FHDT=$P(FHZN,U,1) Q:FHDT=""!(EX=U)
 .W !,"--------------------------------------------------------------------------------------------------------------------------------" D P Q:EX=U
 .F OTHPRI=0:0 S OTHPRI=$O(^ONCO(165.5,"C",PTIEN,OTHPRI)) Q:OTHPRI'>0  I $$DIV^ONCFUNC(OTHPRI)=DUZ(2) D
 ..S PRZN=$G(^ONCO(165.5,OTHPRI,0)),DXDT=$P(PRZN,U,16)
 ..I DXDT=""!(DXDT>FHDT) Q
 ..S ST=$P(PRZN,U,1),TOP=$P($G(^ONCO(165.5,OTHPRI,2)),U,1)
 ..S SITE=$S(TOP'="":$P($G(^ONCO(164,TOP,0)),U,1),1:$P($G(^ONCO(164.2,ST,0)),U,1))
 ..S TSTAT="",TSIEN=$O(^ONCO(165.5,OTHPRI,"TS","B",FHDT,""))
 ..I TSIEN'="" S TSTAT=$P($G(^ONCO(165.5,OTHPRI,"TS",TSIEN,0)),U,2)
 ..W !?3,SITE,":  " I TSTAT'="" W $P($G(^ONCO(164.42,TSTAT,0)),U,1) D P Q:EX=U
 ..Q
 .W !!,"   Last Contact:  " S Y=FHDT D DD^%DT W Y
 .W ?70,"  Follow-up Method:  " S FM=$P(FHZN,U,4)
 .W $S(FM=0:"Reported Hospitalization",FM=1:"Readmission (inpatient or outpatient)",FM=2:"Physician",FM=3:"Patient",FM=4:"Department of Motor Vehicles",FM=5:"Medicare/Medicaid file",FM=7:"Death certificate",FM=8:"Other",FM=9:"Unknown",1:"")
 .D P Q:EX=U
 .W !,"   Vital Status:  " S VS=$P(FHZN,U,2) W $S(VS=0:"Dead",VS=1:"Alive",1:"")
 .W ?70,"  Next Follow-up Method:  " S NF=$P(FHZN,U,6)
 .W $S(NF=0:"Chart requisition",NF=1:"Physician",NF=2:"Contact letter",NF=3:"Phone call",NF=4:"Other hospital contact",NF=5:"Other",NF=8:"Foreign residents (not allowed)",NF=9:"Not followed",1:"")
 .D P Q:EX=U
 .;W !,"   Quality of Survival:  " S QS=$P(FHZN,U,5)
 .;W $S(QS=0:"Normal",QS=1:"Symptomatic & Ambulatory",QS=2:"More than 50% Ambulatory",QS=3:"Less than 50% Ambulatory",QS=4:"Bedridden",QS=8:"Not applicable, dead",QS=9:"Unknown or unspecified",1:"")
 .W ?70,"  Unusual Follow-up Method:  " S UF=$P(FHZN,U,7) W $S(UF=0!(UF=1):"1st unusual method",UF=2:"2nd unusual method",1:"") D P Q:EX=U
 .D P Q:EX=U
 .W !?3,"Date Entered:  " S DTE=$P(FHZN,U,11) I DTE'="" W $E(DTE,4,5)_"/"_$E(DTE,6,7)_"/"_($E(DTE,1,3)+1700)
 .W ?72,"Registrar:  " S REG=$P(FHZN,U,10) I REG'="" S REG1=$P($G(^VA(200,REG,0)),"^",1) W REG1
 .D P Q:EX=U
 .W !,"   Following Registry:  " S FR=$P(FHZN,U,9) I FR'="" W $P($G(^ONCO(160.19,FR,0)),U,2)
 .D P Q:EX=U
 .I $D(^ONCO(160,PTIEN,"F",FHIEN,1,0)) D
 ..W !!,"   Comments:"
 ..F CMIEN=0:0 S CMIEN=$O(^ONCO(160,PTIEN,"F",FHIEN,1,CMIEN)) Q:CMIEN'>0  W !?5,$G(^ONCO(160,PTIEN,"F",FHIEN,1,CMIEN,0)) D P Q:EX=U
 ..Q
 .Q
 Q:EX=U  W !,"--------------------------------------------------------------------------------------------------------------------------------"
 Q
P ;
 I ($Y'<(LINE-1)) D  Q:EX=U  W !
 .I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue with this abstract" D ^DIR I 'Y S EX=U Q
 .D HDR Q
 Q
HDR ; Header
 W @IOF S PG=PG+1
 W CRA,!
 W ?5," Patient Name:  ",PATNAME,?84,"SSN:  ",SSAN,!
 Q
 ;
CLEANUP ;Cleanup
 K CMIEN,CNTR,CRA,DTE,DXDT,EX,FHDT,FHIEN,FHZN,FM,FOLH,FR,IC,ICDCD,IEN
 K LINE,NAME,NF,ONCAB,OTHPRI,PATH,PATNAME,PG,PRI,PRTPCE,PRZN,PTIEN
 K REG,REG1,SITE,SSAN,ST,TITLE,TOP,TSIEN,TSTAT,UF,VS,Y,ZN
