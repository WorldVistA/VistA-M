SCMCMHTC ;BP/DMR - PCMM/MH API ;02/27/2015
 ;;5.3;Scheduling;**575,603**;AUG 13, 1993;Build 79
 ;
 ;This API provides the Mental Health Treatment Coordinator
 ;from PCMM for display in CPRS, or used as a stand alone API.
 ;ICR #5697 - PCMM MHTC API's for CPRS
 ;
 ;Input  - DFN
 ;Output - IEN^MHTC^Team Position^Role^Team
 ;
START(DFN) ; Get patient MHTC info.
 Q:'$G(DFN)
 N ACT,IEN,PNAM,PRO,TIEM,TPUR,TEAM
 N TP,TPR,TPRIEN,ADATE,UDATE,SAVE,NP,TNAM,SCNOW
 S MHTC="",SAVE=""
 ;
 S IEN="" F  S IEN=$O(^SCPT(404.42,"B",DFN,IEN)) Q:IEN=""!(SAVE=1)  D
 .S TIEM="" S TIEM=$P($G(^SCPT(404.42,IEN,0)),"^",3) Q:TIEM=""
 .Q:$$GET1^DIQ(404.51,TIEM,.03)'="MENTAL HEALTH TREATMENT"
 .S TPIEN="" F  S TPIEN=$O(^SCPT(404.43,"B",IEN,TPIEN)) Q:TPIEN=""!(SAVE=1)  D
 ..S TPRIEN="",TPRIEN=$$GET1^DIQ(404.43,TPIEN,.02,"I") Q:TPRIEN=""
 ..S TPR="",TPR=$$GET1^DIQ(404.57,TPRIEN,.03) Q:TPR=""
 ..Q:TPR'["(MHTC)"  S TP="",TP=$$GET1^DIQ(404.57,TPRIEN,.01) Q:TP=""
 ..S PRO="",PRO=$O(^SCTM(404.52,"B",TPRIEN,PRO),-1) Q:PRO=""
 ..S ACT="",ACT=$$GET1^DIQ(404.52,PRO,.04,"I") Q:ACT'=1
 ..S PNAM="",PNAM=$$GET1^DIQ(404.52,PRO,.03) Q:PNAM=""
 ..S ADATE="",ADATE=$$GET1^DIQ(404.43,TPIEN,.03,"I")
 ..S UDATE="",UDATE=$$GET1^DIQ(404.43,TPIEN,.04,"I")
 ..;Q:ADATE>DT  Q:UDATE>ADATE&(UDATE<DT)  Q:UDATE=ADATE&(UDATE<DT)  D SAVE
 ..S SCNOW=$$NOW^XLFDT() ;603
 ..Q:ADATE>SCNOW  ;603
 ..Q:UDATE>ADATE&(UDATE<SCNOW)  ;603
 ..Q:UDATE=ADATE&(UDATE<SCNOW)  ;603
 ..D SAVE
 I $G(CPRSGUI) D PRINT Q
 Q MHTC
 ;
SAVE ;Save MHTC info.
 ;
 S MHTC="",SAVE="",NP="",TNAM=""
 S NP=$$GET1^DIQ(404.52,PRO,.03,"I")
 S TNAM=$$GET1^DIQ(404.51,TIEM,.01)
 S $P(MHTC,"^",1)=NP
 S $P(MHTC,"^",2)=PNAM
 S $P(MHTC,"^",3)=TP
 S $P(MHTC,"^",4)=TPR
 S $P(MHTC,"^",5)=TNAM
 S SAVE=1
 Q
 ;
PRINT ;Display in CPRS Patient Inquiry.
 ;
 Q:'$G(CPRSGUI)
 N PH,PAG,DPAG
 Q:'+$G(NP)
 Q:PNAM=""
 Q:TP=""
 S PH=$$GET1^DIQ(200,NP,.132),PAG=$$GET1^DIQ(200,NP,.137),DPAG=$$GET1^DIQ(200,NP,.138)
 W !!," MH Treatment Team: ",TNAM
 W !,"MH Treatment Coord: ",$E(PNAM,1,28),?52,"Position: ",$E(TP,1,18)
 W !,"                  Analog Pager: ",PAG,?55,"Phone: ",PH
 W !,"                 Digital Pager: ",DPAG
 Q
 ;
LIST ;List of all active MHTC's from PCMM to CPRS.
 ;
 ;Output Fields - PIEN^MHTC^Role^Team Position^Team
 ;Output Global - ^TMP("SCMCMHTC",$J,MHTC,CC)
 ;
 S MHTC="",PIEN="",IEN="",ROLE="",PAIEN="",TPIEN="",TP="",TEAM="",CC=""
 K ^TMP("SCMCMHTC",$J)
 ;
 S IEN="" F  S IEN=$O(^SCTM(404.52,"B",IEN)) Q:IEN=""  D
 .S PAIEN="" F  S PAIEN=$O(^SCTM(404.52,"B",IEN,PAIEN)) Q:PAIEN=""  D
 ..Q:$$GET1^DIQ(404.52,PAIEN,.04,"I")'=1
 ..S TPIEN="",TPIEN=$$GET1^DIQ(404.52,PAIEN,.01,"I") Q:TPIEN=""
 ..S ROLE="",ROLE=$$GET1^DIQ(404.57,TPIEN,.03) Q:ROLE'["(MHTC)"
 ..S MHTC="",MHTC=$$GET1^DIQ(404.52,PAIEN,.03) Q:MHTC="" 
 ..S PIEN="",PIEN=$$GET1^DIQ(404.52,PAIEN,.03,"I")
 ..S TP="",TP=$$GET1^DIQ(404.57,TPIEN,.01)
 ..S TEAM="",TEAM=$$GET1^DIQ(404.57,TPIEN,.02)
 ..S CC=CC+1 S ^TMP("SCMCMHTC",$J,MHTC,CC)=PIEN_"^"_MHTC_"^"_ROLE_"^"_TP_"^"_TEAM
 ..Q
 D EXIT
 Q
 ;
EXIT ;
 K PIEN,ROLE,PAIEN,TP,TEAM,CC,MHTC,IEN,TPIEN
 Q
