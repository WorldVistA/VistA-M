SRONRPT1 ;BIR/ADM - NURSE INTRAOP REPORT ;02/20/05
 ;;3.0; Surgery ;**100,143,157**;24 Jun 93;Build 3
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 S SRLF=1 N SRTD S SRTD=$P($G(^SRF(SRTN,3)),"^") I SRTD="",SRALL D LINE(1) S @SRG@(SRI)="Tubes and Drains: N/A"
 I SRTD'="" D LINE(1) S @SRG@(SRI)="Tubes and Drains: " D LINE(1) S @SRG@(SRI)="  "_SRTD
 S SRLF=1 I '$O(^SRF(SRTN,2,0)),SRALL D LINE(1) S @SRG@(SRI)="Tourniquet: N/A"
 I $O(^SRF(SRTN,2,0)) D LINE(1) S @SRG@(SRI)="Tourniquet:" D TOUR
 S SRLF=1,SRLINE="Thermal Unit: " I '$O(^SRF(SRTN,21,0)),SRALL D LINE(1) S @SRG@(SRI)=SRLINE_"N/A"
 I $O(^SRF(SRTN,21,0)) D LINE(1) S @SRG@(SRI)=SRLINE D THERM
 S SRLF=1,SRLINE="Prosthesis Installed: " I '$O(^SRF(SRTN,1,0)),SRALL D LINE(1) S @SRG@(SRI)=SRLINE_"N/A"
 I $O(^SRF(SRTN,1,0)) D LINE(1) S @SRG@(SRI)=SRLINE D PRO
 S SRLF=1,SRLINE="Medications: " I '$O(^SRF(SRTN,22,0)),SRALL D LINE(1) S @SRG@(SRI)=SRLINE_"N/A"
 I $O(^SRF(SRTN,22,0)) D LINE(1) S @SRG@(SRI)=SRLINE D MED
 D ^SRONRPT2
 Q
MED ; medications
 N ADBY,ADM,COMMENT,DOSE,DRUG,MED,MM,ORBY,ROUTE,TIME
 S MED=0 F  S MED=$O(^SRF(SRTN,22,MED)) Q:'MED  D
 .S Y=$P(^SRF(SRTN,22,MED,0),"^"),C=$P(^DD(130.33,.01,0),"^",2) D Y^DIQ,LINE(1) S @SRG@(SRI)="  "_Y,ADM=0 F  S ADM=$O(^SRF(SRTN,22,MED,1,ADM)) Q:'ADM  D
 ..S MM=^SRF(SRTN,22,MED,1,ADM,0),Y=$P(MM,"^") D D^DIQ S TIME=$P(Y,"@")_"  "_$P(Y,"@",2)
 ..S DOSE=$P(MM,"^",2),X=$P(MM,"^",3) S:X="" ORBY="N/A" I X S Y=$P(^VA(200,X,0),"^") D N(20) S ORBY=Y
 ..S X=$P(MM,"^",4) S:X="" ADBY="N/A" I X S Y=$P(^VA(200,X,0),"^") D N(29) S ADBY=Y
 ..S Y=$P(MM,"^",5),C=$P(^DD(130.34,4,0),"^",2) D:Y'="" Y^DIQ S ROUTE=Y
 ..S COMMENT=$P(MM,"^",6) S:COMMENT="" COMMENT="N/A"
 ..D LINE(1) S @SRG@(SRI)="    Time Administered: "_TIME D LINE(1) S @SRG@(SRI)="      Route: "_ROUTE,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Dosage: "_DOSE
 ..D LINE(1) S @SRG@(SRI)="      Ordered By: "_ORBY S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Admin By: "_ADBY
 ..D LINE(1) S @SRG@(SRI)="      Comments: "_COMMENT
 Q
N(SRL) N SRN I $L(Y)>SRL S SRN=$P(Y,",")_","_$E($P(Y,",",2))_".",Y=SRN
 Q
PRO ; prosthesis
 N C,ITEM,MODEL,PRO,QTY,SERIAL,SIZE,SRISC,SRSED,SRRN,STERILE,VENDOR
 S PRO=0 F  S PRO=$O(^SRF(SRTN,1,PRO)) Q:'PRO  D
 .S X=^SRF(SRTN,1,PRO,0),ITEM=$P(X,"^"),VENDOR=$P(X,"^",2),MODEL=$P(X,"^",3),SERIAL=$P(X,"^",5),Y=$P(X,"^",7),C=$P(^DD(130.01,5,0),"^",2) D:Y'="" Y^DIQ S STERILE=$S(Y'="":Y,1:"N/A")
 .S X=$G(^SRF(SRTN,1,PRO,1)),SIZE=$P(X,"^"),QTY=$P(X,"^",2)
 .S X=$G(^SRF(SRTN,1,PRO,2)),SRISC=$S($P(X,"^")="Y":"YES",1:$P(X,"^"))
 .S Y=$P(X,"^",2),C=$P(^DD(130.01,9,0),"^",2) D:Y'="" Y^DIQ S SRSED=$S(Y="":"NOT ENTERED",1:Y)
 .S Y=$P(X,"^",3),C=$P(^DD(130.01,10,0),"^",2) D:Y'="" Y^DIQ S SRRN=$S(Y="":"NOT ENTERED",1:Y)
 .D LINE(1) S @SRG@(SRI)="  Item: "_$P(^SRO(131.9,ITEM,0),"^")
 .D LINE(1) S @SRG@(SRI)="    Implant Sterility Checked (Y/N): "_$S(SRISC'="":SRISC,1:"NOT ENTERED")
 .D LINE(1) S @SRG@(SRI)="    Sterility Expiration Date: "_SRSED
 .D LINE(1) S @SRG@(SRI)="    RN Verifier: "_SRRN
 .D LINE(1) S @SRG@(SRI)="    Vendor: "_$S(VENDOR'="":VENDOR,1:"N/A")
 .D LINE(1) S @SRG@(SRI)="    Model: "_$S(MODEL'="":MODEL,1:"N/A")
 .D LINE(1) S @SRG@(SRI)="    Lot/Serial Number: "_$S(SERIAL'="":SERIAL,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(53)_"Sterile Resp: "_STERILE
 .D LINE(1) S @SRG@(SRI)="    Size: "_$S(SIZE'="":SIZE,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(53)_"Quantity: "_$S(QTY'="":QTY,1:"N/A")
 Q
THERM ; thermal unit
 N OFF,ON,TEMP,TH,UNIT S TH=0 F  S TH=$O(^SRF(SRTN,21,TH)) Q:'TH  D
 .S UNIT=^SRF(SRTN,21,TH,0),TEMP=$P(UNIT,"^",3),TEMP=$S(TEMP'="":TEMP,1:"N/A"),ON=$P(UNIT,"^",2),OFF=$P(UNIT,"^",4)
 .D LINE(1) S @SRG@(SRI)="  "_$P(UNIT,"^"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Temperature: "_TEMP
 .S Y=ON D:Y D^DIQ S ON=$S(Y="":"N/A",1:$P(Y,"@")_"  "_$P(Y,"@",2)),Y=OFF D:Y D^DIQ S OFF=$S(Y="":"N/A",1:$P(Y,"@")_"  "_$P(Y,"@",2))
 .D LINE(1) S @SRG@(SRI)="    Time On: "_ON,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Time Off: "_OFF
 Q
TOUR ; tourniquet info
 N APBY,C,M,PRESS,SITE,TIME,TIME2,TOUR
 S TOUR=0 F  S TOUR=$O(^SRF(SRTN,2,TOUR)) Q:'TOUR  D
 .S M=^SRF(SRTN,2,TOUR,0),Y=$P(M,"^") D D^DIQ S TIME=$P(Y,"@")_"  "_$P(Y,"@",2),Y=$P(M,"^",4) S TIME2="NOT ENTERED" I Y D D^DIQ S TIME2=$P(Y,"@")_"  "_$P(Y,"@",2)
 .D LINE(1) S @SRG@(SRI)="  Time Applied: "_TIME S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Time Released: "_TIME2
 .S Y=$P(M,"^",2),C=$P(^DD(130.02,1,0),"^",2) D:Y'="" Y^DIQ S SITE=$S(Y="":"NOT ENTERED",1:Y),X=$P(M,"^",5),PRESS=$S(X="":"N/A",1:X)
 .D LINE(1) S @SRG@(SRI)="    Site Applied: "_SITE,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Pressure Applied (in TORR): "_PRESS
 .S Y=$P(M,"^",3),C=$P(^DD(130.02,2,0),"^",2) D:Y'="" Y^DIQ S APBY=$S(Y="":"N/A",1:Y) D LINE(1) S @SRG@(SRI)="    Applied By: "_APBY
 Q
SPACE(NUM) ; create spaces
 ;pass in position returns number of needed spaces
 I '$D(@SRG@(SRI)) S @SRG@(SRI)=""
 Q $J("",NUM-$L(@SRG@(SRI)))
LINE(NUM) ; create carriage returns
 I $G(SRLF) S NUM=NUM+1,SRLF=0
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=""
 Q
