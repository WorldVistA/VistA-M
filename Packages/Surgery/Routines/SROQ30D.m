SROQ30D ;BIR/ADM - 30-DAY READMISSION TRANSMISSION ;10/31/2011
 ;;3.0;Surgery;**176**;24 Jun 93;Build 8
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to ^DGPM("APTT1" supported by DBIA #565
 Q
MSG ; create mail message to server
 S X=$$ACTIVE^XUSER(DUZ) I '+X S XMDUZ=.5
 S XMSUB="VAMC-"_SRASITE_" 30-DAY READMITS ("_SRCNT_") - FY"_$E(SRYR,3,4)_" Q"_SRQTR
 S SRD=^XMB("NETNAME"),ISC=0 I SRD["FO-"!(SRD["ISC-")!(SRD["ISC.")!(SRD["FORUM")!(SRD["TST") S ISC=1
 K XMY I 'ISC S (XMY("G.SRCOSERV@FO-HINES.DOMAIN.EXT"),XMY("G.CARDIAC RISK ASSESSMENTS@DENVER.DOMAIN.EXT"))=""
 I ISC S XMY("G.SR-QUARTERLY@"_SRD)=""
 S XMTEXT="^TMP(""SRQTR"",$J," N I D ^XMD K ^TMP("SRQTR",$J),XMY,XMTEXT
 I '$D(XMMG) D SITE
 Q
EN ; entry point when run manually to generate current report
 D CURRENT
EN1 D DATES K ^TMP("SRQTR",$J)
 S SRASITE=+$P($$SITE^SROVAR,"^",3),SRSD=SRSTART-.0001,SRED=SREND+.9999,SRCNT=0,^TMP("SRQTR",$J,1)=SRASITE_"^^^^^"
 F  S SRSD=$O(^SRF("AC",SRSD)) Q:SRSD>SRED!('SRSD)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSD,SRTN)) Q:'SRTN  D CASE
 D MSG,END
 Q
CASE ; examine case
 Q:$P($G(^SRF(SRTN,30)),"^")!'$P($G(^SRF(SRTN,.2)),"^",12)!($P($G(^SRF(SRTN,"NON")),"^")="Y")
 N DFN,SR,SRADM,SRDISCH,SRPTF,SRRES
 S X=$$SITE^SROUTL0(SRTN),SRDIV=$S(X:$P(^SRO(133,X,0),"^"),1:""),SRDIV=$S(SRDIV:$$GET1^DIQ(4,SRDIV,99),1:SRASITE)
 S SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^")
 S SRDISCH=$P($G(^SRF(SRTN,208)),"^",15) I 'SRDISCH D PIMS I 'SRDISCH Q
 ; determine if patient was readmitted within 30 days after discharge
 S SRADM=$O(^DGPM("APTT1",DFN,SRDISCH)) I 'SRADM Q
 S X1=SRDISCH,X2=30 D C^%DTC S SR30=X,SRADM=$O(^DGPM("APTT1",DFN,SRDISCH)) Q:'SRADM!(SRADM>SR30)
 S VAINDT=SRADM D INP^VADPT S SRX=$P(VAIN(3),"^"),SRSPE="" D SPEC
 S SRPTF=VAIN(10),SRRES="" D RPC^DGPTFAPI(.SRRES,SRPTF)
 S SRCNT=SRCNT+1,^TMP("SRQTR",$J,SRCNT)=SRASITE_"^"_SRTN_"^"_SRDIV_"^"_SRADM_"^"_SRSPE_"^"_$P($G(SRRES(1)),"^",3)
 Q
PIMS ; determine if inpatient surgery
 N SRSDATE,SRSOUT S SRSOUT=0,(VAIP("D"),SRSDATE)=$P(SR(0),"^",9) D IN5^VADPT
 ; if not admitted before surgery, look for admission within 24 hours of leaving OR
 I 'VAIP(13) S X1=$P($G(^SRF(SRTN,.2)),"^",12),X2=1 D C^%DTC S SR24=X,SRDT=$O(^DGPM("APTT1",DFN,SRSDATE)) Q:'SRDT!(SRDT>SR24)  S VAIP("D")=SRDT D IN5^VADPT I 'VAIP(13) Q
 I VAIP(13) D ADM Q:SRSOUT
 Q
ADM ; get information related to admission
 ; determine if admission was for observation
 ; quit if no specialty defined for admission
 S SRX=$P($G(VAIP(13,6)),"^") I SRX="" S SRDISCH=$E($P(VAIP(17,1),"^"),1,12),SRSOUT=1 Q
 D SPEC S Y="18,23,24,36,41,65,94" I Y[SRSP D  Q:SRSOUT
 .; look for admission following discharge from observation
 .S X1=$P($G(^SRF(SRTN,.2)),"^",12),X2=2 D C^%DTC S SR48=X,SRDT=$O(^DGPM("APTT1",DFN,$P(VAIP(13,1),"^"))) I 'SRDT!(SRDT>SR48) S SRDISCH="",SRSOUT=1 Q
 .S VAIP("D")=SRDT D IN5^VADPT I 'VAIP(13) S SRDISCH="",SRSOUT=1
 S SRDISCH=$E($P(VAIP(17,1),"^"),1,12)
 Q
SPEC ; find specialty associated with movement
 K DA,DIC,DIQ,DR,SRY S DIC=45.7,DR=1,DA=SRX,DIQ="SRY",DIQ(0)="EI" D EN^DIQ1 K DA,DIC,DIQ,DR S SRSP=SRY(45.7,SRX,1,"I"),SRSPE=SRY(45.7,SRX,1,"E")
 Q
END K ^TMP("SRQTR",$J),DA,DIC,DIQ,DR,ISC,SR24,SR30,SR48,SRASITE,SRCNT,SRD,SRDAY,SRDIV,SRDT,SRE,SRED,SREMO
 K SREND,SRFQ,SRQTR,SRSD,SRSMO,SRSOUT,SRSP,SRSPE,SRSTART,SRTN,SRX,SRY,SRYR,SRYRF,VAIN,VAINDT,VAIP,X,X1,X2,Y
 S ZTREQ="@"
 Q
SITE ; update site parameters file
 S SRE=0 F  S SRE=$O(^SRO(133,SRE)) Q:'SRE  I $P(^SRO(133,SRE,0),"^",9)<SRFQ S $P(^(0),"^",9)=SRFQ
 Q
NIGHT ; determine if current quarterly 30-day readmission report has been transmitted
 D CURRENT S SRE=$O(^SRO(133,0)) I $P(^SRO(133,SRE,0),"^",9)'<SRFQ Q
 D EN1
 Q
DATES S SRSMO=$S(SRQTR=1:"1001",SRQTR=2:"0101",SRQTR=3:"0401",1:"0701"),SREMO=$S(SRQTR=1:"1231",SRQTR=2:"0331",SRQTR=3:"0630",1:"0930"),SRSTART=$S(SRQTR=1:SRYRF-1,1:SRYRF)_SRSMO,SREND=$S(SRQTR=1:SRYRF-1,1:SRYRF)_SREMO
 Q
CURRENT ; get current reporting quarter
 S SRYR=$E(DT,1,3),SRDAY=$E(DT,4,7),SRQTR=$S(SRDAY>930:3,SRDAY>630:2,SRDAY>331:1,1:4)
 I SRQTR=4,SRDAY<401 S SRYR=SRYR-1
 S SRYRF=SRYR,SRYR=SRYR+1700,SRFQ=SRYR_SRQTR
 Q
SEL ; run for selected fiscal quarter
 K DIR S DIR(0)="FO",DIR("A")="Enter fiscal year and quarter (e.g., 2012-3)" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!(X="") Q
 D CHECK I '$D(X) D HELP G SEL
 S SRYR=SRX,SRQTR=SRY,SRFQ=SRYR_SRQTR,SRYRF=SRX-1700
 D EN1
 Q
QTR D CHECK I '$D(X) D HELP
 K SRX,SRY
 Q
CHECK I $L(X)'=6!(X'["-") K X Q
 I $P(X,"-",2)?1N,"1243"'[$P(X,"-",2) K X Q
 I X'?4N1"-"1N K X Q
 S SRX=$P(X,"-") I SRX<2011!(SRX>2030) K X Q
 S SRY=$P(X,"-",2) I "1234"'[SRY K X Q
 S X=SRX_SRY
 Q
HELP K SRHELP S SRHELP(1)="",SRHELP(2)="Answer must be in format:  FISCAL YEAR-QUARTER",SRHELP(3)="",SRHELP(4)="NOTE: A hyphen (-) must separate FISCAL YEAR and QUARTER. The FISCAL"
 S SRHELP(5)="      YEAR must be in the range 2011 to 2030. QUARTER must be a",SRHELP(6)="      number (1, 2, 3 or 4).",SRHELP(7)="" D EN^DDIOL(.SRHELP) K SRHELP
 Q
