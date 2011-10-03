SRONP1 ;BIR/ADM - PROCEDURE REPORT (NON-OR) ; [ 07/10/04  10:45 AM ]
 ;;3.0; Surgery ;**132**;24 Jun 93
 I $O(^SRF(SRTN,22,0)) D LINE(2) S @SRG@(SRI)="Medications:" D MED
 I $O(^SRF(SRTN,40,0)) D LINE(2) S @SRG@(SRI)="Indications for Procedure:" S SRLINE=0 D
 .F  S SRLINE=$O(^SRF(SRTN,40,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,40,SRLINE,0) D COMM^SRONP2(X,2)
 I $O(^SRF(SRTN,39,0)) D LINE(2) S @SRG@(SRI)="Brief Clinical History:" S SRLINE=0 D
 .F  S SRLINE=$O(^SRF(SRTN,39,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,39,SRLINE,0) D COMM^SRONP2(X,2)
 I $O(^SRF(SRTN,38,0)) D LINE(2) S @SRG@(SRI)="Operative Findings:" S SRLINE=0 D
 .F  S SRLINE=$O(^SRF(SRTN,38,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,38,SRLINE,0) D COMM^SRONP2(X,2)
 I $O(^SRF(SRTN,9,0)) D LINE(2) S @SRG@(SRI)="Specimens: " S SRLINE=0 D
 .F  S SRLINE=$O(^SRF(SRTN,9,SRLINE)) Q:'SRLINE  D LINE(1) S @SRG@(SRI)=$$SPACE(2)_^SRF(SRTN,9,SRLINE,0)
 I $O(^SRF(SRTN,43,0)) D LINE(2) S @SRG@(SRI)="Occurrences:" D OCC
 I $O(^SRF(SRTN,5,0)) D LINE(2) S @SRG@(SRI)="General Comments:" S SRLINE=0 D
 .F  S SRLINE=$O(^SRF(SRTN,5,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,5,SRLINE,0) D COMM^SRONP2(X,2)
 S Y=$P($G(^SRF(SRTN,"TIU")),"^",5),Y=$S(Y=0:"NO",Y=1:"YES",1:"NOT ENTERED")
 D LINE(2) S @SRG@(SRI)="Dictated Summary Expected: "_Y
 Q
N(SRL) N SRNM I $L(Y)>SRL S SRNM=$P(Y,",")_","_$E($P(Y,",",2))_".",Y=SRNM
 Q
MED ; medications
 N ADBY,ADM,C,CNT,COMMENT,DOSE,MED,MM,ORBY,ROUTE,TIME,X,Y
 S (CNT,MED)=0 F  S MED=$O(^SRF(SRTN,22,MED)) Q:'MED  S CNT=CNT+1 D
 .S Y=$P(^SRF(SRTN,22,MED,0),"^"),C=$P(^DD(130.33,.01,0),"^",2) D Y^DIQ,LINE(1) S @SRG@(SRI)="  "_Y,ADM=0 F  S ADM=$O(^SRF(SRTN,22,MED,1,ADM)) Q:'ADM  D
 ..S MM=^SRF(SRTN,22,MED,1,ADM,0),Y=$P(MM,"^") D D^DIQ S TIME=$P(Y,"@")_"  "_$P(Y,"@",2)
 ..S DOSE=$P(MM,"^",2)
 ..S Y=$P(MM,"^",5),C=$P(^DD(130.34,4,0),"^",2) D:Y'="" Y^DIQ S ROUTE=Y
 ..D LINE(1) S @SRG@(SRI)="    Time Administered: "_TIME D LINE(1) S @SRG@(SRI)="      Route: "_ROUTE,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Dosage: "_DOSE
 Q
OCC N C,SRC,SRT,Y S SRC=0 F  S SRC=$O(^SRF(SRTN,43,SRC)) Q:'SRC  D
 .D LINE(1) S @SRG@(SRI)="  "_$P(^SRF(SRTN,43,SRC,0),"^")
 .S Y=$P(^SRF(SRTN,43,SRC,0),"^",3) D:Y D^DIQ S SRT=$S(Y'="":$P(Y,"@")_"  "_$P(Y,"@",2),1:"") S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(50)_"Date: "_SRT
 .D LINE(1) S @SRG@(SRI)="    Treatment: "_$P(^SRF(SRTN,43,SRC,0),"^",4)
 .S Y=$P(^SRF(SRTN,43,SRC,0),"^",2),C=$P(^DD(130.0126,1,0),"^",2) D:Y'="" Y^DIQ S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(58)_"Outcome: "_Y
 .I $O(^SRF(SRTN,43,SRC,1,0)) D LINE(1) S @SRG@(SRI)="    Comments:" S SRLINE=0 D
 ..F  S SRLINE=$O(^SRF(SRTN,43,SRC,1,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,43,SRC,1,SRLINE,0) D COMM^SRONP2(X,6)
 Q
SPACE(NUM) ;create spaces
 ;pass in position returns number of needed spaces
 I '$D(@SRG@(SRI)) S @SRG@(SRI)=""
 Q $J("",NUM-$L(@SRG@(SRI)))
LINE(NUM) ;create carriage returns
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=""
 Q
