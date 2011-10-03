SRONP2 ;BIR/ADM - PROCEDURE REPORT (NON-OR) ;07/26/04  9:45 AM
 ;;3.0; Surgery ;**132,142**;24 Jun 93
 Q
OPTOP(SRTN) ; send op-top to ^TMP
 ; SRTN   - case number in file 130
 ;
 N ANE,DFN,ICD,J,NUM,SR,SRATT,SRCASE,SRDIV,SRI,SRL,SRLINE,SRLOC,SRN,SROPTOP,SRSPEC,SRSTATUS,SRTECH,X,Y
 S SRCASE=SRTN,SRG=$NA(^TMP("SRNOR",$J,SRCASE)) K @SRG
 S SRI=0,SRDIV=$$SITE^SROUTL0(SRTN)
 I $P($G(^SRF(SRTN,30)),"^")!$P($G(^SRF(SRTN,31)),"^",8) D LINE(1) S @SRG@(SRI)="  * * PROCEDURE ABORTED * *" D LINE(1)
 F SRN=0:.1:1.1,"NON" S SR(SRN)=$G(^SRF(SRTN,SRN))
 S Y=$P(SR("NON"),"^",8),C=$P(^DD(130,125,0),"^",2) D:Y'="" Y^DIQ S SRSPEC=$S(Y="":"NOT ENTERED",1:$E(Y,1,25))
 S SRLOC="NOT ENTERED",SRL=$P(SR("NON"),"^",2) S:SRL SRLOC=$E($P(^SC(SRL,0),"^"),1,25)
 D LINE(1) S @SRG@(SRI)="Med. Specialty: "_SRSPEC,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(44)_"Location: "_SRLOC
 S X=$P($G(^SRF(SRTN,33)),"^",2) D LINE(2) S @SRG@(SRI)="Principal Diagnosis: " D
 .I X="" S @SRG@(SRI)=@SRG@(SRI)_"NOT ENTERED" Q
 .D LINE(1) S @SRG@(SRI)="  "_X
 .S @SRG@(SRI)=@SRG@(SRI)
 .N OTH,CNT S (OTH,CNT)=0 F  S OTH=$O(^SRF(SRTN,15,OTH)) Q:'OTH  S CNT=CNT+1 D DIAG
 S Y=$P(SR("NON"),"^",6),C=$P(^DD(130,123,0),"^",2) D:Y'="" Y^DIQ D LINE(2) S @SRG@(SRI)="Provider: "_Y
 S X=$P($G(SR(0)),"^",12),SRSTATUS=$S(X="I":"INPATIENT",X="O":"OUTPATIENT",1:"NOT ENTERED")
 S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(50)_"Patient Status: "_SRSTATUS
 S Y=$P(SR("NON"),"^",7),C=$P(^DD(130,124,0),"^",2) D:Y'="" Y^DIQ,N(28) S:Y="" Y="N/A" D LINE(1) S @SRG@(SRI)="Attending: "_Y
 D RS S:SRATT="" SRATT="NOT ENTERED" D LINE(1) S @SRG@(SRI)="Attending Code: "_SRATT
 S Y=$P(SR(.3),"^",4),C=$P(^DD(130,.34,0),"^",2) D:Y'="" Y^DIQ S:Y="" Y="N/A" D LINE(2) S @SRG@(SRI)="Attend Anesth: "_Y
 S X=$P(SR(.3),"^",6),X=$S(X:$P(^SRO(132.95,X,0),"^"),1:"N/A")
 D LINE(1) S @SRG@(SRI)="Anesthesia Supervisor Code: "_X
 S Y=$P(SR(.3),"^"),C=$P(^DD(130,.31,0),"^",2) D:Y'="" Y^DIQ S:Y="" Y="N/A" D LINE(1) S @SRG@(SRI)="Anesthetist: "_Y
 D LINE(2) S @SRG@(SRI)="Anesthesia Technique(s): " D
 .I '$O(^SRF(SRTN,6,0)) S @SRG@(SRI)=@SRG@(SRI)_"N/A" Q
 .S ANE=0 F  S ANE=$O(^SRF(SRTN,6,ANE)) Q:'ANE  D ANE
 D TECH I $E(SRTECH,1,2)'="NO" S X=$P($G(^SRF(SRTN,31)),"^",9),X=$S(X="N":"NO",X="Y":"YES",1:"") I X'="" D LINE(2) S @SRG@(SRI)="Diagnostic/Therapeutic: "_X
 D ^SRONP0
 Q
DIAG D LINE(1) S X=$G(^SRF(SRTN,15,OTH,0)),@SRG@(SRI)=$S(CNT=1:" Other: ",1:"        ")_$P(X,"^"),ICD=$P(X,"^",3)
 S ICD=$S(ICD:$P(^ICD9(ICD,0),"^"),1:"NOT ENTERED"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(50)_"ICD9 Code: "_ICD
 Q
N(SRL) N SRNM I $L(Y)>SRL S SRNM=$P(Y,",")_","_$E($P(Y,",",2))_".",Y=SRNM
 Q
TECH N SRT,SRZ D TECH^SROPRIN
 Q
ANE ; print anesthesia technique
 N A,AGNT,C,CNT
 S A=^SRF(SRTN,6,ANE,0),Y=$P(A,"^"),C=$P(^DD(130.06,.01,0),"^",2) D:Y'="" Y^DIQ D LINE(1) S Y=Y_$S($P(A,"^",3)="Y":"  (PRINCIPAL)",1:""),@SRG@(SRI)=$$SPACE(2)_Y D AGENT
 Q
AGENT ; print agents
 Q:$P(A,"^")="N"  N SRDOSE,SRY
 D LINE(1) S @SRG@(SRI)="     Agent: " I '$O(^SRF(SRTN,6,ANE,1,0)) S @SRG@(SRI)=@SRG@(SRI)_"NONE ENTERED" Q
 S (AGNT,CNT)=0 F  S AGNT=$O(^SRF(SRTN,6,ANE,1,AGNT)) Q:'AGNT  S CNT=CNT+1 D
 .S SRY=^SRF(SRTN,6,ANE,1,AGNT,0),SRDOSE=$P(SRY,"^",2)
 .S Y=$P(SRY,"^"),C=$P(^DD(130.47,.01,0),"^",2) D Y^DIQ
 .D:CNT>1 LINE(1) S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(13)_Y
 .I SRDOSE S @SRG@(SRI)=@SRG@(SRI)_"   "_SRDOSE_" mg"
 Q
RS ; attending code
 I $$GET1^DID(130,.166,"","LABEL")["ATTENDING CODE" D  Q
 .S Y=$P(SR(.1),"^",10),C=$P(^DD(130,.166,0),"^",2) D Y^DIQ S SRATT=Y
 S Y=$P(SR(.1),"^",16),C=$P(^DD(130,.165,0),"^",2) D Y^DIQ S SRATT=Y
 Q
COMM(X,NUM) ; output word-processing text
 ; X = line of text to be processed
 ; NUM = left margin
 N I,J,K,Y,SRL S SRL=80-NUM
 I $L(X)<(SRL+1)!($E(X,1,SRL)'[" ") D LINE(1) S @SRG@(SRI)=$$SPACE(NUM)_X Q
 S K=1 F  D  I $L(X)<SRL+1 S X(K)=X Q
 .F I=0:1:SRL-1 S J=SRL-I,Y=$E(X,J) I Y=" " S X(K)=$E(X,1,J-1),X=$E(X,J+1,$L(X)) S K=K+1 Q
 F I=1:1:K D LINE(1) S @SRG@(SRI)=$$SPACE(NUM)_X(I)
 Q
SPACE(NUM) ; create spaces
 ; pass in position returns number of needed spaces
 I '$D(@SRG@(SRI)) S @SRG@(SRI)=""
 Q $J("",NUM-$L(@SRG@(SRI)))
LINE(NUM) ; create carriage returns
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=""
 Q
