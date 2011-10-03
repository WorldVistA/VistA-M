ONCOPA2A ;Hines OIFO/RTK [PA Print Complete Abstract (132c)]; 09/05/97
 ;;2.11;ONCOLOGY;**15,16,22,25,34,36,37,44,48**;Mar 07, 1995;Build 13
 ; ONCO PRINT ABSTRACT CONTINUED
 W !!,"   Text-Remarks:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,19,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,19,TX,0) D P Q:EX=U
 W !,"   Text Dx Proc-Phys.Exam:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,10,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,10,TX,0) D P Q:EX=U
 W !,"   Text Dx Proc-Xray/Scan:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,11,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,11,TX,0) D P Q:EX=U
 W !,"   Text Dx Proc-Operations:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,9,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,9,TX,0) D P Q:EX=U
 W !,"   Text Dx Proc-Lab Tests:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,22,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,22,TX,0) D P Q:EX=U
 W !,"   Text Dx Proc-Endoscopy:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,12,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,12,TX,0) D P Q:EX=U
 W !,"   Text Dx Proc-Path/Cyto:  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,13,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,13,TX,0) D P Q:EX=U
 ;
 S NAME="RECURRENCES" D FORMAT^ONCOPA1
 W !!,TITLE
 W !!,"   Date of First Recurrence:  ",ONCAB(165.5,IEN,70)
 W ?50,"   Type of First Recurrence:  ",ONCAB(165.5,IEN,71) D P Q:EX=U
 W !,"   Distant Site 1:  ",ONCAB(165.5,IEN,71.1) D P Q:EX=U
 W !,"   Distant Site 2:  ",ONCAB(165.5,IEN,71.2) D P Q:EX=U
 W !,"   Distant Site 3:  ",ONCAB(165.5,IEN,71.3) D P Q:EX=U
 F SR=0:0 S SR=$O(ONCAB(165.572,SR)) Q:SR'>0  D
 .W !!,"   Subsequent Recurrence Date:  ",ONCAB(165.572,SR,.01)
 .W ?50,"   Type of Subsequent Recurrence:  ",ONCAB(165.572,SR,.02) D P Q:EX=U
 .W !,"   Distant Site 1:  ",ONCAB(165.572,SR,.03) D P Q:EX=U
 .W !,"   Distant Site 2:  ",ONCAB(165.572,SR,.031) D P Q:EX=U
 .W !,"   Distant Site 3:  ",ONCAB(165.572,SR,.032) D P Q:EX=U
 .Q
 S NAME="SUBSEQUENT COURSE OF THERAPY" D FORMAT^ONCOPA1
 W !!,TITLE
 F SCT=0:0 S SCT=$O(ONCAB(165.51,SCT)) Q:SCT'>0  D
 .W !!?30,"   Date Started:  ",ONCAB(165.51,SCT,.01) D P Q:EX=U
 .W !?8,"   Surgery of Primary Site:  ",ONCAB(165.51,SCT,.041)
 .W "   ",ONCAB(165.51,SCT,.04) D P Q:EX=U
 .;W !?8,"   Scope of Lymph Node Surg:  ",ONCAB(165.51,SCT,35) D P Q:EX=U
 .;W !?8,"   Number of Nodes Removed:  ",ONCAB(165.51,SCT,37) D P Q:EX=U
 .;W !?8,"   Surgery of Other Sites/Nodes:  ",ONCAB(165.51,SCT,36) D P Q:EX=U
 .;W !?8,"   Recon/Restore - Delayed:  ",ONCAB(165.51,SCT,34)
 .;W "   ",ONCAB(165.51,SCT,33) D P Q:EX=U
 .W !?8,"   Radiation:  ",ONCAB(165.51,SCT,.051)
 .W "   ",ONCAB(165.51,SCT,.05) D P Q:EX=U
 .W !?8,"   Radiation Sequence:  ",ONCAB(165.51,SCT,1) D P Q:EX=U
 .W:$P($G(^ONCO(165.5,IEN,0)),U,16)<2960000 !?8,"   Radiation Therapy to CNS:  ",ONCAB(165.51,SCT,.031)
 .W:$P($G(^ONCO(165.5,IEN,0)),U,16)<2960000 "   ",ONCAB(165.51,SCT,.03) D P Q:EX=U
 .W !?8,"   Chemotherapy:  ",ONCAB(165.51,SCT,.061)
 .W "   ",ONCAB(165.51,SCT,.06) D P Q:EX=U
 .W !?8,"   Hormone Therapy:  ",ONCAB(165.51,SCT,.071)
 .W "   ",ONCAB(165.51,SCT,.07) D P Q:EX=U
 .W !?8,"   Immunotherapy:  ",ONCAB(165.51,SCT,.081)
 .W "   ",ONCAB(165.51,SCT,.08) D P Q:EX=U
 .W !?8,"   Hema Trans/Endocrine Proc:  ",ONCAB(165.51,SCT,.021)
 .W "   ",ONCAB(165.51,SCT,.02) D P Q:EX=U
 .W !?8,"   Other Treatment:  ",ONCAB(165.51,SCT,.091)
 .W "   ",ONCAB(165.51,SCT,.09) D P Q:EX=U
 .W !,"   Place:  ",ONCAB(165.51,SCT,2) D P Q:EX=U
 .W !,"   Comment(s):  " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,4,SCT,1,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,4,SCT,1,TX,0) D P Q:EX=U
 S NAME="OTHER PRIMARY SITES" D FORMAT^ONCOPA1
 W !!,TITLE,!
 S (FLG,J)=0 F XD1=0:0 S XD1=$O(^ONCO(165.5,"C",PTIEN,XD1)) Q:XD1'>""!(FLG=1)  I $$DIV^ONCFUNC(XD1)=DUZ(2) D
 .I $D(^ONCO(165.5,XD1,0)),XD1'=IEN S J=J+1 D ^ONCOCOML D P I EX=U S FLG=1
 I J=0 W !?24,"No Other Primary Sites"
 ;
 I IOST?1"C".E W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue with this abstract" D ^DIR Q:'Y  D HDR G PA3
 D P Q:EX=U
PA3 D ^ONCOPA3
 Q
P ;
 I ($Y'<(LINE-1)) D  Q:EX=U  W !
 .I IOST?1"C".E W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue with this abstract" D ^DIR I 'Y S EX=U Q
 .D HDR Q
 Q
HDR ; Header
 W @IOF S PG=PG+1
 W CRA,!
 W ?5," Patient Name:  ",PATNAME,?84,"SSN:  ",SSAN,!
 Q
PAUSE ;
 W ! R "Enter RETURN to continue or '^' to exit: ",PAUSE:30
 I PAUSE="" Q
 I PAUSE=U Q
 G PAUSE
