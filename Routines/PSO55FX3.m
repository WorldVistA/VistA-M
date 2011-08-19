PSO55FX3 ;ISC-BHAM/MHA - cleanup of bad p nodes and mismatched Rxs in file 55 ; 07/26/2001
 ;;7.0;OUTPATIENT PHARMACY;**69**;DEC 1997
 ;External reference to ^PS(55 is supported by DBIA 2228
MSG ;
 W @IOF,"*** This patch will be queued to run in the background ***",!
 W !,"It will scan through the PHARMACY PATIENT file (#55) and will look"
 W !,"for possible bad 'P' or 'P','A' cross-references or prescriptions with"
 W !,"mismatched patients. If it finds any bad cross-references then it will clean"
 W !,"those bad cross-references and a count of them for each Outpatient Site"
 W !,"entry will be sent in a mail message to the patch installer. If it finds any"
 W !,"prescriptions that belong to other patients the mail message will also include"
 W !,"a list of those patients with prescriptions that may have been discontinued"
 W !,"because a DATE OF DEATH or an ADMISSION was entered for the patient with a"
 W !,"corrupt cross-reference. Forward this mail message to the corresponding"
 W !,"Pharmacy Application Coordinator, or to the appropriate Outpatient Pharmacy"
 W !,"Personnel, for their review and correction. It will send summary information"
 W !,"to G.PL2 PATCH TRACKING group on FORUM to keep a count of bad nodes by site."
 W !,"This patch will also scan through the PRESCRIPTION file (#52) using the 'AD'"
 W !,"cross-reference and will check if a  corresponding entry exists in the"
 W !,"PHARMACY PATIENT file (#55). The software will provide a count of missing"
 W !,"entries in a separate mail message that will be sent to G.PL2 PATCH TRACKING"
 W !,"on FORUM for their review.",!
 S DIR(0)="E",DIR("A")="Press Return to Continue " D ^DIR K DIR W !
 W !,"This task stores information in ^XTMP(""PSO"" global. Upon completion of the"
 W !,"cleanup process, the information stored in this global will be used to"
 W !,"generate several e-mail messages. If this task stops unexpectedly, it can be"
 W !,"restarted by doing BEG^PSO55FX2. The routine will begin processing with the"
 W !,"last record reviewed and will utilize the same global reference for storing"
 W !,"data. No information will be lost.",!
 W !,"We recommend re-indexing the ""B"" cross-reference of the PHARMACY PATIENT file"
 W !,"(#55), during non-peak hours or when the number of pharmacy users on the system"
 W !,"is at a minimum any time after completion of this job.",!!
 Q
PH2 ;
 S SD=2980101,PS=0,RX=0,TY="PSO",JN="692"
 I '$D(^XTMP(TY,JN)) S X1=DT,X2=+90 D C^%DTC S ^XTMP(TY,JN,0)=$G(X)_"^"_DT G SPH2
 I $D(^XTMP(TY,JN,1)) D
 .S SD=$P($G(^XTMP(TY,JN,1)),"^") S:'SD SD=2980101
 .S RX=$P($G(^XTMP(TY,JN,1)),"^",2) S:'RX RX=0
 .S PS=$P($G(^XTMP(TY,JN,1)),"^",3) S:'PS PS=0
SPH2 F  S SD=$O(^PSRX("AD",SD)) Q:'SD!(SD>3010801)  D
 .F  S RX=$O(^PSRX("AD",SD,RX)) Q:'RX  I $O(^PSRX("AD",SD,RX,""))=0,$D(^PSRX(RX,"STA")),+^PSRX(RX,"STA")'=13 D
 ..Q:$D(^PSRX(RX,"D"))
 ..S DFN=$P($G(^PSRX(RX,0)),"^",2),(PF,J)=0
 ..I DFN F  S J=$O(^PS(55,DFN,"P",J)) Q:PF!('J)  D
 ...I $P($G(^PS(55,DFN,"P",J,0)),"^")=RX S PF=1 Q
 ..I 'PF S PS=PS+1,^XTMP(TY,JN,2,PS)=$E(RX_"            ",1,12)_$G(^PSRX(RX,0))
 ..S ^XTMP(TY,JN,1)=(SD-.1)_"^"_RX_"^"_PS
 .S RX=0
 S ZZ="PSO",^TMP(ZZ,$J,1)=""
 S ^TMP(ZZ,$J,2)="Total Count of PRESCRIPTION Entries Missing from PHARMACY PATIENT file: "_PS
 S ^TMP(ZZ,$J,3)=""
 I PS D
 .S ^TMP(ZZ,$J,4)="Prescription Information"
 .S ^TMP(ZZ,$J,5)="IEN         ZERO NODE"
 .S ^TMP(ZZ,$J,6)="----------- -------------------------------------------------------------------"
 .S XX=7,J=0
 .F  S J=$O(^XTMP(TY,JN,2,J)) Q:'J  S ^TMP(ZZ,$J,XX)=^XTMP(TY,JN,2,J),XX=XX+1
 S XMY("G.PL2 PATCH TRACKING@FORUM.VA.GOV")=""
 ;S XMY(DUZ)=""
 S XMSUB=$P($$SITE^VASITE(),"^",2)_" - PSO*7*69 - PART TWO"
 S XMDUZ="Missing Rx entries from PHARMACY PATIENT file (#55)"
 S XMTEXT="^TMP(ZZ,$J," D ^XMD
 K ^XTMP(TY,JN),^TMP(ZZ,$J),^XTMP("PSO2",69),XMY,XMDUZ,SD,JN,TY,DFN,RX,XX,ZZ,J,PF,PS,X1,X2
 K AL,CDT,CT,EDT,II,JJ,PDFN,QQ,S1,S2,SDT,YY,UL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
