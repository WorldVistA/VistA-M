MDWCHK ; HOIFO/NCA - Create CP Studies for Existing Procedures ;12/13/07  15:52
 ;;1.0;CLINICAL PROCEDURES;**14**;Apr 01,2004;Build 20
 ; Reference IA #10103 [Supported] XLFDT call
 ;               10035 [Supported] Access DPT file (#2)
 ;               10061 [Supported] VADPT call
 ;               5062  [Private] Use of GMR(123,"ACP"
 ;
START ; Convert procedure to procedures.
 N MDAP,MDCPR,MDFD,MDFDA,MDFLG,MDFR,MDHEMO,MDHL7,MDHOLD,MDIEN,MDIENS,MDINST,MDJ1,MDL,MDLP,MDMAXD,MDNDT,MDNOW,MDNVS,MDP,MDST,MDX,MDY
 Q:$G(MDCP)=""
 Q:$G(MDUSR)=""
 N MDY,X,Y,MDIEN,MDINST K ^TMP("MDPAT",$J) S MDMAXD=DT+.24,MDP=MDCP,MDFLG=0,MDAP=""
 S MDY=+$G(MDSAP)
 S MDL="" F  S MDL=$O(^GMR(123,"ACP",MDP,MDL)) Q:MDL<1  S MDJ1=0 F  S MDJ1=$O(^GMR(123,"ACP",MDP,MDL,MDJ1)) Q:MDJ1<1  D
 .Q:$D(^TMP("MDPAT",$J,MDL))
 .S MDFD=$O(^MDD(702,"ACON",+MDJ1,0)) Q:+MDFD>0
 .S MDST=$$GET1^DIQ(123,+MDJ1_",",8,"E")
 .Q:MDST'["PENDING"&(MDST'["ACTIVE")&(MDST'["SCHEDULED")
 .S ^TMP("MDPAT",$J,MDL)="",MDAP=""
 .S:'MDY MDAP=$$NOW^XLFDT()_"^"_$P($G(^MDS(702.01,+MDP,0)),"^",5)
 .I $G(^DPT(MDL,.1))'=""&(MDY=1) S MDAP=$$NOW^XLFDT()_"^"_$P($G(^MDS(702.01,+MDP,0)),"^",5) Q:$P($G(^MDS(702.01,+MDP,0)),"^",5)=""
 .I $G(^DPT(MDL,.1))=""&(MDY=2) S MDAP=$$NOW^XLFDT()_"^"_$P($G(^MDS(702.01,+MDP,0)),"^",5) Q:$P($G(^MDS(702.01,+MDP,0)),"^",5)=""
 .I MDAP=""&(+$G(MDCL)>0) S MDAP=$$GETAPPT(MDL,MDCL)
 .Q:'+MDAP
 .S MDHEMO=$P($G(^MDS(702.01,+MDCP,0)),"^",6)
 .S MDNDT=$S($P(MDAP,"^",1)="":$$NOW^XLFDT(),1:$P(MDAP,"^",1))
 .S MDNVS=$S($P(MDAP,"^",1)="":$$NOW^XLFDT(),1:"A;"_$P(MDAP,"^",1)_";"_$P(MDAP,"^",2))
 .I $E(MDAP,1)="A" Q:$P(MDAP,";",3)=""
 .K MDFDA,MDIEN
 .S MDFDA(702,"+1,",.01)=MDL
 .S MDFDA(702,"+1,",.02)=$$NOW^XLFDT()
 .S MDFDA(702,"+1,",.03)=MDUSR
 .S MDFDA(702,"+1,",.04)=MDCP
 .S MDFDA(702,"+1,",.05)=MDJ1
 .S MDFDA(702,"+1,",.07)=MDNVS
 .S MDINST=+$$GINST^MDWORSR(MDCP) Q:'MDINST
 .S:MDNDT>MDMAXD MDFDA(702,"+1,",.09)=0
 .S MDFDA(702,"+1,",.11)=+MDINST
 .S MDFDA(702,"+1,",.14)=MDNDT
 .D UPDATE^DIE("","MDFDA","MDIEN","MDERR") K MDFDA
 .Q:MDNDT>MDMAXD
 .S MDIENS=MDIEN(1)_"," I +MDHEMO=2 S MDHOLD=$P($G(^MDD(702,MDIEN(1),0)),"^",7),MDNOW=$$NOW^XLFDT(),$P(^MDD(702,MDIEN(1),0),"^",7)=$S(MDNOW>MDNDT:MDNDT,1:MDNOW)
 .S MDHL7=$$SUB^MDHL7B(MDIEN(1))
 .I +MDHL7=-1 S MDFDA(702,MDIENS,.09)=2,MDFDA(702,MDIENS,.08)=$P(MDHL7,U,2)
 .I +MDHL7=1 S MDFDA(702,MDIENS,.09)=5,MDFDA(702,MDIENS,.08)=""
 .D:$D(MDFDA) FILE^DIE("","MDFDA","MDERR")
 .Q:'+$G(MDIENS)
 .I MDHEMO=2 D CP^MDKUTL(+MDIENS) K MDFDA S:$G(MDHOLD)'="" MDFDA(702,+MDIENS_",",.07)=MDHOLD S MDFDA(702,+MDIENS_",",.09)=5 D FILE^DIE("","MDFDA","MDERR")
 .Q
 K ^TMP("MDPAT",$J)
 Q
GETAPPT(MDPAT,MDDA) ; Get appointment
 N DFN,MDALP,MDARES K ^UTILITY("VASD",$J) S DFN=MDPAT
 S X1=DT,X2=365 D C^%DTC S VASD("T")=X+.24,VASD("F")=DT,VASD("W")="129",VASD("C",+MDDA)=+MDDA D SDA^VADPT
 S MDARES=0 F MDALP=0:0 S MDALP=$O(^UTILITY("VASD",$J,MDALP)) Q:MDALP<1  S MDARES=$G(^(MDALP,"I")) Q
 K ^UTILITY("VASD",$J),VASD,X1,X2,X
 Q MDARES
CHELP ; Help Message for the Schedule Appointment prompt
 W !!,"REQUIRED field for the procedure to have auto CP study check-in."
 W !,"Enter a ""^"" will exit completely."
 W !!,"Enter 0 if you do not schedule appointments."
 W !,"      1 if you only schedule appointments for outpatients."
 W !,"      2 if you only schedule appointments for inpatients."
 W !,"      3 if you schedule appointments for both 1 and 2."
 Q
PHELP ; Help Message for Procedure prompt
 W !,"Enter a CP Definition for the procedure to"
 W !,"have auto CP study check-in.",!
 K MDLST D GETLST^XPAR(.MDLST,"SYS","MD CHECK-IN PROCEDURE LIST")
 F MDLP=0:0 S MDLP=$O(MDLST(MDLP)) Q:MDLP<1  I +$G(MDLST(MDLP)) W !,$P($G(^MDS(702.01,+MDLST(MDLP),0)),"^",1)
 K MDLST
 Q
