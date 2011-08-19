SROANR1 ;BIR/ADM - ANESTHESIA REPORT ; [ 09/09/03  12:45 PM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 N C,SRLINE,SRT,X,Y
 S X=$P(SR(.3),"^",7) I X'="" D LINE(2) S @SRG@(SRI)="Min Intraoperative Temp: "_X
 I $O(^SRF(SRTN,27,0)) D LINE(2) S @SRG@(SRI)="Monitors:" D MON
 I $O(^SRF(SRTN,4,0)) D LINE(2) S @SRG@(SRI)="Blood Replacement Fluids:" D REP
 D LINE(2) S Y=$P(SR(.2),"^",5) S:Y'="" Y=Y_" ml" S @SRG@(SRI)="Intraoperative Blood Loss: "_Y
 S Y=$P(SR(.2),"^",16) S:Y'="" Y=Y_" ml" S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Urine Output: "_Y
 D LINE(1) S @SRG@(SRI)="PAC(U) Admit Score: "_$P(SR(1.1),"^"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"PAC(U) Discharge Score: "_$P(SR(1.1),"^",2)
 I $O(^SRF(SRTN,5,0)) D LINE(2) S @SRG@(SRI)="General Comments:" S SRLINE=0 D
 .F  S SRLINE=$O(^SRF(SRTN,5,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,5,SRLINE,0) D COMM(X,2)
NOTE S Y=$P(SR(1.1),"^",9) D:Y D^DIQ S SRT=$S(Y'="":$P(Y,"@")_"  "_$P(Y,"@",2),1:"") D LINE(2) S @SRG@(SRI)="Postop Anesthesia Note Date/Time: "_SRT
 I $O(^SRF(SRTN,48,0)) D LINE(1) S @SRG@(SRI)="Postop Anesthesia Note:" S SRLINE=0 D
 .F  S SRLINE=$O(^SRF(SRTN,48,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,48,SRLINE,0) D COMM(X,2)
 Q
N(SRL) N SRN I $L(Y)>SRL S SRN=$P(Y,",")_","_$E($P(Y,",",2))_".",Y=SRN
 Q
MON ; monitors
 N C,MON,SRM,SRT,Y
 S MON=0 F  S MON=$O(^SRF(SRTN,27,MON)) Q:'MON  S SRM=^SRF(SRTN,27,MON,0) D
 .S Y=$P(SRM,"^"),C=$P(^DD(130.41,.01,0),"^",2) D:Y'="" Y^DIQ D LINE(1) S @SRG@(SRI)="  "_Y
 .S Y=$P(SRM,"^",4),C=$P(^DD(130.41,3,0),"^",2) D:Y'="" Y^DIQ,N(27) S:Y="" Y="N/A" S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Applied By: "_Y
 .S Y=$P(SRM,"^",2) D:Y D^DIQ S SRT=$S(Y'="":$P(Y,"@")_"  "_$P(Y,"@",2),1:"N/A") D LINE(1) S @SRG@(SRI)="    Installed: "_SRT
 .S Y=$P(SRM,"^",3) D:Y D^DIQ S SRT=$S(Y'="":$P(Y,"@")_"  "_$P(Y,"@",2),1:"N/A") S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Removed: "_SRT
 Q
REP ; blood replacement fluids
 N C,REP,SRLINE,SRX,X,Y
 S REP=0 F  S REP=$O(^SRF(SRTN,4,REP)) Q:'REP  S SRX=^SRF(SRTN,4,REP,0) D
 .S Y=$P(SRX,"^"),C=$P(^DD(130.04,.01,0),"^",2) D:Y'="" Y^DIQ D LINE(1) S @SRG@(SRI)="  "_Y
 .S Y=$P(SRX,"^",2),Y=$S(Y="":"N/A",1:Y_" ml"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Quantity: "_Y
 .S Y=$P(SRX,"^",4),Y=$S(Y="":"N/A",1:Y) D LINE(1) S @SRG@(SRI)="    Source ID: "_Y
 .S Y=$P(SRX,"^",5),Y=$S(Y="":"N/A",1:Y) D LINE(1) S @SRG@(SRI)="    VA ID: "_Y
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
SPACE(NUM) ;create spaces
 ;pass in position returns number of needed spaces
 I '$D(@SRG@(SRI)) S @SRG@(SRI)=""
 Q $J("",NUM-$L(@SRG@(SRI)))
LINE(NUM) ;create carriage returns
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=""
 Q
