ONCOPA2 ;HINES OIFO/GWB - [PA Print Complete Abstract (132c)] cont ;10/05/11
 ;;2.2;ONCOLOGY;**1,5,10,12,13,15**;Jul 31, 2013;Build 5
 ;
 N TX
 S NAME="FIRST COURSE OF TREATMENT" D FORMAT^ONCOPA1
 W !!,TITLE
 W ! D P Q:EX=U
 W:DATEDX<3210000 !,"   Neoadjuvant therapy:            ",ONCAB(165.5,IEN,245,"E") D P Q:EX=U
 I DATEDX>3201231 D
 .W !!,"   Neoadjuvant therapy (2021): ",ONCAB(165.5,IEN,245.1,"E") D P Q:EX=U
 .W !,"   Neoadjuvant therapy-Clin Resp: ",ONCAB(165.5,IEN,245.2,"E") D P Q:EX=U
 .W !,"   Neoadjuvant therapy-TX Effect: ",ONCAB(165.5,IEN,245.3,"E") S NEOXVAL=ONCAB(165.5,IEN,245.3,"E") D NEODSP^ONCOEOD1 K NEOXVAL D P Q:EX=U
 W ! D P Q:EX=U
 W !,"   Surgical Dx/Staging Proc:       ",ONCAB(165.5,IEN,58.1) D P Q:EX=U
 W !,"   Surgical Dx/Staging Proc Date:  ",ONCAB(165.5,IEN,58.3) D P Q:EX=U
 W !,"   Surg Dx/Staging Proc @Fac:      ",ONCAB(165.5,IEN,58.4) D P Q:EX=U
 W !,"   Surg Dx/Staging Proc @Fac Date: ",ONCAB(165.5,IEN,58.5) D P Q:EX=U
 W ! D P Q:EX=U
 W:DATEDX>3091231 !,"   Treatment Status:               ",ONCAB(165.5,IEN,235,"E") D P Q:EX=U
 W !,"   Date of no treatment:           ",ONCAB(165.5,IEN,124) D P Q:EX=U
 W ! D P Q:EX=U
 W !,"   Date First Surgical Procedure:  ",ONCAB(165.5,IEN,170) D P Q:EX=U
 W !,"   Surgery of Primary (F):         ",ONCAB(165.5,IEN,58.6) D P Q:EX=U
 W !,"   Most Definitive Surg Date:      ",ONCAB(165.5,IEN,50) D P Q:EX=U
 W !,"   Surgery of Primary @Fac (F):    ",ONCAB(165.5,IEN,58.7) D P Q:EX=U
 W !,"   Most Definitive Surg @Fac Date: ",ONCAB(165.5,IEN,50.3) D P Q:EX=U
 W:DATEDX>3091231 !,"   RX Hosp--Surg App 2010:         ",ONCAB(165.5,IEN,234,"E") D P Q:EX=U
 W !,"   Surgical Margins:               ",ONCAB(165.5,IEN,59) D P Q:EX=U
 W !,"   Scope of LN Surgery (F):        ",ONCAB(165.5,IEN,138.4) D P Q:EX=U
 W !,"   Scope of LN Surgery Date:       ",ONCAB(165.5,IEN,138.2) D P Q:EX=U
 W !,"   Scope of LN Surgery @Fac (F):   ",ONCAB(165.5,IEN,138.5) D P Q:EX=U
 W !,"   Scope of LN Surgery @Fac Date:  ",ONCAB(165.5,IEN,138.3) D P Q:EX=U
 W !,"   Surg Proc/Other Site (F):       ",ONCAB(165.5,IEN,139.4) D P Q:EX=U
 W !,"   Surg Proc/Other Site Date:      ",ONCAB(165.5,IEN,139.2) D P Q:EX=U
 W !,"   Surg Proc/Other Site @Fac (F):  ",ONCAB(165.5,IEN,139.5) D P Q:EX=U
 W !,"   Surg Proc/Other Site @Fac Date: ",ONCAB(165.5,IEN,139.3) D P Q:EX=U
 W:DATEDX<3030000 !,"   Reconstruction/Restoration:     ",ONCAB(165.5,IEN,23) D P Q:EX=U
 W !,"   Date of Surgical Discharge:     ",ONCAB(165.5,IEN,435) D P Q:EX=U
 W !,"   Readmission w/i 30 Days/Surg:   ",ONCAB(165.5,IEN,14) D P Q:EX=U
 W ! D P Q:EX=U
 W !,"   Reason No Surgery of Primary:   ",ONCAB(165.5,IEN,58) D P Q:EX=U
 W !!,"   RX Text-Surgery: " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,14,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,14,TX,0) D P Q:EX=U
 W !,"   CAP Protocol Review:            ",ONCAB(165.5,IEN,46,"E") D P Q:EX=U
 W:ONCAB(165.5,IEN,46,"I")=0 !,"   CAP Text:                       ",ONCAB(165.5,IEN,47,"E") D P Q:EX=U
 W !,"   Tx Guidelines Discussion:       ",ONCAB(165.5,IEN,281,"E") D P Q:EX=U
 W !,"   Treatment Guideline #1:         ",ONCAB(165.5,IEN,228,"E") D P Q:EX=U
 W !,"   Treatment Guideline #2:         ",ONCAB(165.5,IEN,229,"E") D P Q:EX=U
 W !,"   Treatment Guideline #3:         ",ONCAB(165.5,IEN,230,"E") D P Q:EX=U
 W !,"   Treatment Guideline Location:   ",ONCAB(165.5,IEN,231,"E") D P Q:EX=U
 W !,"   Treatment Guideline Doc Date:   ",ONCAB(165.5,IEN,232,"E") D P Q:EX=U
 W ! D P Q:EX=U
 W !,"   Radiation:                      ",ONCAB(165.5,IEN,51.2) D P Q:EX=U
 W !,"   Date Radiation Started:         ",ONCAB(165.5,IEN,51) D P Q:EX=U
 W !,"   Location of Radiation Tx:       ",ONCAB(165.5,IEN,126) D P Q:EX=U
 I DATEDX<3180101 D
 .W !,"   Radiation treatment volume...: ",ONCAB(165.5,IEN,125) D P Q:EX=U
 .W !,"   Regional treatment modality..: ",ONCAB(165.5,IEN,363) D P Q:EX=U
 .W !,"   Regional dose:cGy............: ",ONCAB(165.5,IEN,442) D P Q:EX=U
 .W !,"   Boost treatment modality.....: ",ONCAB(165.5,IEN,363.1) D P Q:EX=U
 .W !,"   Boost dose:cGy...............: ",ONCAB(165.5,IEN,443) D P Q:EX=U
 .W !,"   Number of txs to this volume.: ",ONCAB(165.5,IEN,56) D P Q:EX=U
 I DATEDX>3171231 D
 .W !,"   Phase I rad treatment volume...........: ",ONCAB(165.5,IEN,5504) D P Q:EX=U
 .W !,"   Phase I rad to draining lymph nodes....: ",ONCAB(165.5,IEN,5505) D P Q:EX=U
 .W !,"   Phase I treatment modality.............: ",ONCAB(165.5,IEN,5506) D P Q:EX=U
 .W !,"   Phase I rad external beam planning.....: ",ONCAB(165.5,IEN,5502) D P Q:EX=U
 .W !,"   Phase I dose per fraction..............: ",ONCAB(165.5,IEN,5501) D P Q:EX=U
 .W !,"   Phase I number of fractions............: ",ONCAB(165.5,IEN,5503) D P Q:EX=U
 .W !,"   Phase I total dose.....................: ",ONCAB(165.5,IEN,5507) D P Q:EX=U
 .W !,"   Phase II rad treatment volume..........: ",ONCAB(165.5,IEN,5514) D P Q:EX=U
 .W !,"   Phase II rad to draining lymph nodes...: ",ONCAB(165.5,IEN,5515) D P Q:EX=U
 .W !,"   Phase II treatment modality............: ",ONCAB(165.5,IEN,5516) D P Q:EX=U
 .W !,"   Phase II rad external beam planning....: ",ONCAB(165.5,IEN,5512) D P Q:EX=U
 .W !,"   Phase II dose per fraction.............: ",ONCAB(165.5,IEN,5511) D P Q:EX=U
 .W !,"   Phase II number of fractions...........: ",ONCAB(165.5,IEN,5513) D P Q:EX=U
 .W !,"   Phase II total dose....................: ",ONCAB(165.5,IEN,5517) D P Q:EX=U
 .W !,"   Phase III rad treatment volume.........: ",ONCAB(165.5,IEN,5524) D P Q:EX=U
 .W !,"   Phase III rad to draining lymph nodes..: ",ONCAB(165.5,IEN,5525) D P Q:EX=U
 .W !,"   Phase III treatment modality...........: ",ONCAB(165.5,IEN,5526) D P Q:EX=U
 .W !,"   Phase III rad external beam planning...: ",ONCAB(165.5,IEN,5522) D P Q:EX=U
 .W !,"   Phase III dose per fraction............: ",ONCAB(165.5,IEN,5521) D P Q:EX=U
 .W !,"   Phase III number of fractions..........: ",ONCAB(165.5,IEN,5523) D P Q:EX=U
 .W !,"   Phase III total dose...................: ",ONCAB(165.5,IEN,5527) D P Q:EX=U
 .W !,"   Number of phases rad TX................: ",ONCAB(165.5,IEN,7024,"E") D P Q:EX=U
 .W !,"   Radiation treatment discontinued early.: ",ONCAB(165.5,IEN,7025,"E") D P Q:EX=U
 .W !,"   Total dose.............................: ",ONCAB(165.5,IEN,7026,"E") D P Q:EX=U
 W !,"   Date Radiation Ended:           ",ONCAB(165.5,IEN,361) D P Q:EX=U
 W !,"   Radiation @Fac:                 ",ONCAB(165.5,IEN,51.4) D P Q:EX=U
 W !,"   Radiation @Fac Date:            ",ONCAB(165.5,IEN,51.5) D P Q:EX=U
 W !,"   Radiation/Surgery Sequence:     ",ONCAB(165.5,IEN,51.3) D P Q:EX=U
 W !,"   Reason for No Radiation:        ",ONCAB(165.5,IEN,75) D P Q:EX=U
 W !!,"   RX Text-Radiation (Beam):  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,15,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,15,TX,0) D P Q:EX=U
 ;W !,"   RX Text-Radiation Other:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,16,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,16,TX,0) D P Q:EX=U
CHEM W !!,"   Chemotherapy:  ",ONCAB(165.5,IEN,53.2) D P Q:EX=U
 W !,"   Chemotherapy Date:  ",ONCAB(165.5,IEN,53) D P Q:EX=U
 W !,"   Chemotherapy @Fac:  ",ONCAB(165.5,IEN,53.3) D P Q:EX=U
 W !,"   Chemotherapy @Fac Date:  ",ONCAB(165.5,IEN,53.4) D P Q:EX=U
 W !,"   Chemotherapeutic Agent #1:  ",ONCAB(165.5,IEN,1423,"E") D P Q:EX=U
 W !,"   Chemotherapeutic Agent #2:  ",ONCAB(165.5,IEN,1423.1,"E") D P Q:EX=U
 W !,"   Chemotherapeutic Agent #3:  ",ONCAB(165.5,IEN,1423.2,"E") D P Q:EX=U
 W !,"   Chemotherapeutic Agent #4:  ",ONCAB(165.5,IEN,1423.3,"E") D P Q:EX=U
 W !,"   Chemotherapeutic Agent #5:  ",ONCAB(165.5,IEN,1423.4,"E") D P Q:EX=U
 W !,"   RX Text-Chemo:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,17,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,17,TX,0) D P Q:EX=U
HT W !!,"   Hormone Therapy:  ",ONCAB(165.5,IEN,54.2) D P Q:EX=U
 W !,"   Hormone Therapy Date:  ",ONCAB(165.5,IEN,54) D P Q:EX=U
 W !,"   Hormone Therapy @Fac:  ",ONCAB(165.5,IEN,54.3) D P Q:EX=U
 W !,"   Hormone Therapy @Fac Date:  ",ONCAB(165.5,IEN,54.4) D P Q:EX=U
 W !,"   RX Text-Hormone:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,18,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,18,TX,0) D P Q:EX=U
IMM W !!,"   Immunotherapy:  ",ONCAB(165.5,IEN,55.2) D P Q:EX=U
 I $P($G(^ONCO(165.5,IEN,3)),U,19)=0 G OTH
 W !,"   Immunotherapy Date:  ",ONCAB(165.5,IEN,55) D P Q:EX=U
 W !,"   Immunotherapy @Fac:  ",ONCAB(165.5,IEN,55.3) D P Q:EX=U
 W !,"   Immunotherapy @Fac Date:  ",ONCAB(165.5,IEN,55.4) D P Q:EX=U
 W !,"   RX Text-BRM:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,20,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,20,TX,0) D P Q:EX=U
 W !,"   Hema Trans/Endocrine Proc:  ",ONCAB(165.5,IEN,153) D P Q:EX=U
 W !,"   Hema Trans/Endocrine Proc Date:  ",ONCAB(165.5,IEN,153.1) D P Q:EX=U
 W !,"   Hema Trans/Endocrine Proc @Fac:  ",ONCAB(165.5,IEN,153.2) D P Q:EX=U
 W !,"   Hema Trans/Endocrine Proc @Fac Date:  ",ONCAB(165.5,IEN,153.3) D P Q:EX=U
 W ! D P Q:EX=U
 W !,"   Systemic/Surgery Sequence:  ",ONCAB(165.5,IEN,15) D P Q:EX=U
OTH W !!,"   Other Treatment:  ",ONCAB(165.5,IEN,57.2) D P Q:EX=U
 I $P($G(^ONCO(165.5,IEN,3)),U,25)=0 G PES
 W !,"   Other Treatment Date:  ",ONCAB(165.5,IEN,57) D P Q:EX=U
 W !,"   Other Treatment @Fac:  ",ONCAB(165.5,IEN,57.3) D P Q:EX=U
 W !,"   Other Treatment @Fac Date:  ",ONCAB(165.5,IEN,57.4) D P Q:EX=U
 W !,"   RX Text-Other:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,21,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,21,TX,0) D P Q:EX=U
PES W !,"   Palliative Care:  ",ONCAB(165.5,IEN,12) D P Q:EX=U
 W !,"   Palliative Care @Fac:  ",ONCAB(165.5,IEN,13) D P Q:EX=U
 W !,"   Clinical Trials Discussion:  ",ONCAB(165.5,IEN,279,"E") D P Q:EX=U
 W !,"   Protocol Eligibility Status:  ",ONCAB(165.5,IEN,346) D P Q:EX=U
 W !,"   Protocol Participation:  ",ONCAB(165.5,IEN,560) D P Q:EX=U
 W !,"   Year Put on Protocol:  ",ONCAB(165.5,IEN,133) D P Q:EX=U
 ;
 I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue with this abstract" D ^DIR Q:'Y  D HDR G PA2A
 D P Q:EX=U
PA2A D ^ONCOPA2A
 ; WILL CALL ONCOPA2A ROUTINE TO CONTINUE...
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
 K CRA,DATEDX,EX,IEN,LINE,NAME,ONCAB,PATNAME,PG,SSAN,TITLE,Y
