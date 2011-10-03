SDWLQSC1 ;IOFO BAY PINES/ESW - WAITING LIST-SC PRIORITY BACKGROUND ;09/02/2004 2:10 PM [4/21/05 8:04pm]  ; Compiled December 20, 2006 09:00:39  ; Compiled May 15, 2008 16:54:54  ; Compiled June 23, 2008 10:26:21
 ;;5.3;scheduling;**446,528**;AUG 13, 1993;Build 4
 ;
 ;Modification included to be provided with patch SD*5.3*528, see: Q:SS'[$J          
 ;This routine will be called by SDWLQSC that run as a background job. It is created because SDWLQSC exceeded 10000.                               
 Q
EN2 ;Part 2 - checks status of appts linked to closed EWL entries.
 N IEN,APPT,WLAPPT,CLINIC,SDAPPT,WLSTAT,STATUS,NN,SDFORM,EE
 S (IEN,APPT,WLAPPT,CLINIC,SDAPPT,WLSTAT,STATUS,NN,SDFORM,EE)=""
 S EE=0,DFN=0
 F  S DFN=$O(^SDWL(409.3,"B",DFN)) Q:DFN<1  D
 .K ^TMP("ENC",$J)
 .S IEN="" F  S IEN=$O(^SDWL(409.3,"B",DFN,IEN)) Q:IEN<1  D
 ..S STATUS="" S STATUS=$$GET1^DIQ(409.3,IEN_",",23,"I")
 ..IF STATUS="C" D
 ...IF $G(^SDWL(409.3,IEN,"SDAPT")) D
 ....S CLINIC=$$GET1^DIQ(409.3,IEN_",",13.2,"I") IF CLINIC>0 D
 .....S WLAPPT=$$GET1^DIQ(409.3,IEN_",",13,"I"),WLSTAT=$$GET1^DIQ(409.3,IEN_",",21,"I")
 .....IF WLSTAT="SA" D APPT^SDWLQSC(CLINIC,IEN) ; call creates ^TMP("SDWLQSC3",$J)
 ..I STATUS="O" N SDPCL,SDPSP S SDPCL=$$GET1^DIQ(409.3,IEN_",",8,"I"),SDPSP=$$GET1^DIQ(409.3,IEN_",",7,"I") I SDPCL>0!(SDPSP>0) D
 ...S (SDCL,SDSP)=""
 ...I SDPCL>0 S SDCL=$$GET1^DIQ(409.32,SDPCL_",",.01,"I")
 ...I SDPSP>0 S SDSP=$$GET1^DIQ(409.31,SDPSP_",",.01,"I")
 ...S SDORG=$$GET1^DIQ(409.3,IEN_",",1,"I")
 ...N SDD S SDD=$$CHKENC(DFN,SDORG,SDCL,SDSP,0)  ; 0 - the first appt/enc only 
 .IF $D(^TMP("ENC",$J)) D MESS9^SDWLMSG(DFN) K ^TMP("ENC",$J)
 IF $D(^TMP("SDWLQSC3",$J)) D MESS2^SDWLMSG
 Q
CHKENC(DFN,SDORG,SDCL,SDSP,PROC) ;check if any encounters are present
 ;SDORG - orig DATE of EWL entry
 ;SDCL - pointer to file 44
 ;SDSP - pointer to fiel # 40.7
 ;PROC - 0 -create the first appt/enc only
 ;       1 - multiple appt/enc ; called from outside for a list of appointment(s)/encounter(s)
 N CNT S CNT=0,EE=0
 N SDEND,X,X1,X2 S X1=SDORG,X2=119 D C^%DTC S SDEND=X
 K ^TMP("SD ENCOUNTER LIST",$J) K ^TMP($J,"SDAMA301") K ^TMP($J,"APPT") K ^TMP("ENC",$J)
 N SDARR S SDARR(1)=SDORG_";"_SDEND
 S SDARR(3)="R" ;only kept/scheduled 
 S SDARR(4)=DFN
 I SDCL S SDARR(2)=SDCL
 I SDSP S SDARR(13)=$$GET1^DIQ(40.7,SDSP_",",1) ; STOP CODE
 S SDARR("FLDS")="1;2;3;4;10;13;14;17"
 S SDAPPT=$$SDAPI^SDAMA301(.SDARR)
 I SDAPPT D
 .I 'PROC N SS,SDP S SS="^TMP("_$J_",""SDAMA301"")" S SDP=@$Q(@SS) D  ; string containg app data
 ..; see example: SDP=3060615.09^359;11CP SURG^^7171882;WOLF,ED^^^^^^^^
 ..N CL,SDC S CL=+$P(SDP,U,2) S SDC=$$GET1^DIQ(44,CL_",",.01),SDC=$E(SDC,1,17)
 ..N SDNAM S SDNAM=$$GET1^DIQ(2,DFN_",",.01),SDNAM=$E(SDNAM,1,19)
 ..N Y,SDAPPT S Y=+SDP D DD^%DT S SDAPPT=Y
 ..N Y S Y=SDORG D DD^%DT S SDORGD=Y S SDORGD=$S(SDCL>0:"C-",1:"S-")_SDORGD
 ..S SDFORM=$$FORM^SDFORM(SDNAM,22,SDC,20,SDORGD,20,SDAPPT,21)
 ..S EE="" S EE=+$O(^TMP("ENC",$J,EE),-1)+1 S ^TMP("ENC",$J,EE)=SDFORM
 .I PROC N SS,SCNT S SS="^TMP("_$J_",""SDAMA301"")" F  S SS=$Q(@SS) Q:SS'["SDAMA301"  Q:SS'[$J  D  ; SD/528
 ..N CL,SDP,SD S SDP=@SS S SD=+SDP,CL=+$P(SDP,U,2)
 ..S SCNT=$O(^TMP($J,"APPT",""),-1)+1
 ..S ^TMP($J,"APPT",SCNT)=^TMP($J,"SDAMA301",DFN,CL,SD)
 ..N SDCLIN,SDFAC,SDINST,SDINSTE S SDCLIN=$$CLIN^SDWLBACC(CL),SDINST=$P(SDCLIN,U),SDFAC=$P(SDCLIN,U,2),SDINSTE=$P(SDCLIN,U,3)
 ..S $P(^TMP($J,"APPT",SCNT),"^",15)=SDINST_";"_SDINSTE
 ..S $P(^TMP($J,"APPT",SCNT),"^",16)=SDFAC
 ..N SDD3 S SDD3=$S(SD<DT:"KEPT",1:"SCHEDULED") S $P(^TMP($J,"APPT",SCNT),U,3)=";"_SDD3
 I 'PROC I EE Q EE
 N ARR,SQ K ^TMP("SD ENCOUNTER LIST",$J) D LISTPAT^SDOERPC(.ARR,DFN,SDORG,SDEND)
 I $D(@ARR) S CNT=0,SQ="" F  S SQ=$O(^TMP("SD ENCOUNTER LIST",$J,SQ)) Q:SQ=""  D   I 'PROC,EE=1 Q
 .N STR I SDCL Q:$P(^TMP("SD ENCOUNTER LIST",$J,SQ),U,4)'=SDCL  S STR=$P(^TMP("SD ENCOUNTER LIST",$J,SQ),";;",2)
 .I SDSP Q:$P(^TMP("SD ENCOUNTER LIST",$J,SQ),U,3)'=SDSP  S STR=$P(^TMP("SD ENCOUNTER LIST",$J,SQ),";;",2)
 .S CL=$P(STR,U,4)
 .S SDC=$$GET1^DIQ(44,CL_",",.01),SDC=$E(SDC,1,17)
 .S SDNAM=$$GET1^DIQ(2,DFN_",",.01),SDNAM=$E(SDNAM,1,19)
 .N Y S Y=$P(STR,U) D DD^%DT S SDAPPT=Y,SDAPPT=SDAPPT_"-E"
 .N Y S Y=SDORG D DD^%DT S SDORGD=Y S SDORGD=$S(SDCL>0:"C-",1:"S-")_SDORGD ; C - clinic EWL entry ; S - specialty EWL entry
 .I 'PROC S SDFORM=$$FORM^SDFORM(SDNAM,22,SDC,20,SDORGD,20,SDAPPT,21) D  Q
 ..S EE="" S EE=+$O(^TMP("ENC",$J,EE),-1)+1 S ^TMP("ENC",$J,EE)=SDFORM
 .I PROC S SCNT=$O(^TMP($J,"APPT",""),-1)+1 D
 ..I +$P(STR,U,7) S ^TMP($J,"APPT",SCNT)=$P(STR,U)_U_CL_";"_SDC_"^^"_DFN_";"_SDNAM D
 ...S $P(^TMP($J,"APPT",SCNT),U,18)=$P(STR,U,7)
 ...S $P(^TMP($J,"APPT",SCNT),U,3)=";CHECKED OUT"
 I PROC I $D(^TMP($J,"APPT")) S EE=1
 Q EE
