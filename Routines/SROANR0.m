SROANR0 ;BIR/ADM - ANESTHESIA REPORT ; [ 06/28/04  12:45 PM ]
 ;;3.0; Surgery ;**100,131**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
TECH D LINE(2) S @SRG@(SRI)="Anesthesia Technique(s): " D
 .I '$O(^SRF(SRTN,6,0)) S @SRG@(SRI)=@SRG@(SRI)_"* NOT ENTERED *" Q
 .S ANE=0 F  S ANE=$O(^SRF(SRTN,6,ANE)) Q:'ANE  D ANE
 Q
ANE ; print anesthesia technique
 N A,AGNT,C,CNT
 S A=^SRF(SRTN,6,ANE,0),Y=$P(A,"^"),C=$P(^DD(130.06,.01,0),"^",2) D:Y'="" Y^DIQ D LINE(1) S Y=Y_$S($P(A,"^",3)="Y":"  (PRINCIPAL)",1:""),@SRG@(SRI)=Y D AGENT
 D INFO
 Q
AGENT ; print agents
 Q:$P(A,"^")="N"
 D LINE(1) S @SRG@(SRI)="  Agent: " I '$O(^SRF(SRTN,6,ANE,1,0)) S @SRG@(SRI)=@SRG@(SRI)_"NONE ENTERED" Q
 S (AGNT,CNT)=0 F  S AGNT=$O(^SRF(SRTN,6,ANE,1,AGNT)) Q:'AGNT  S CNT=CNT+1 D
 .S Y=$P(^SRF(SRTN,6,ANE,1,AGNT,0),"^"),C=$P(^DD(130.47,.01,0),"^",2) D Y^DIQ
 .D:CNT>1 LINE(1) S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(13)_Y
 .;; SR*3*131 ADDED LOGIC TO INCLUDE DOSE
 .S Y=$P(^SRF(SRTN,6,ANE,1,AGNT,0),"^",2) I Y'="" S @SRG@(SRI)=@SRG@(SRI)_"  "_Y_" mg"
 Q
INFO ; anesthesia technique information
 N C,SRFLG,I,S,X,Y F I=2,3,8 S S(I)=$G(^SRF(SRTN,6,ANE,I))
 I $P(S(8),"^")="Y" D LINE(1) S @SRG@(SRI)="  MONITORED ANESTHESIA CARE"
 I $P(S(8),"^",2)'="" D LINE(1) S @SRG@(SRI)="  Intubated: "_$S($P(S(8),"^",2)="Y":"YES",1:"NO")
 S S=^SRF(SRTN,6,ANE,0),(Y,SRFLG)=$P(S,"^",5),C=$P(^DD(130.06,3,0),"^",2) D:Y'="" Y^DIQ I Y'="" D LINE(1) S @SRG@(SRI)="  Approach: "_Y
 I $P(S,"^",6)'="" S Y=$P(S,"^",6),C=$P(^DD(130.06,4,0),"^",2) D:Y'="" Y^DIQ I Y'="" D:SRFLG="" LINE(1) S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Route: "_Y
 S Y=$P(S,"^",7),C=$P(^DD(130.06,5,0),"^",2) D:Y'="" Y^DIQ I Y'="" D LINE(1) S @SRG@(SRI)="  Laryngoscope Type: "_Y
 S Y=$P(S,"^",8),C=$P(^DD(130.06,6,0),"^",2) D:Y'="" Y^DIQ I Y'="" D LINE(1) S @SRG@(SRI)="  Laryngoscope Size: "_Y
 S (Y,SRFLG)=$P(S,"^",9),C=$P(^DD(130.06,7,0),"^",2) D:Y'="" Y^DIQ I Y'="" D LINE(1) S @SRG@(SRI)="  Stylet Used: "_Y
 S Y=$P(S,"^",10),C=$P(^DD(130.06,8,0),"^",2) D:Y'="" Y^DIQ I Y'="" D:SRFLG="" LINE(1) S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Lidocaine Topical: "_Y
 S Y=$P(S,"^",11),C=$P(^DD(130.06,9,0),"^",2) D:Y'="" Y^DIQ I Y'="" D LINE(1) S @SRG@(SRI)="  Lidocaine IV: "_Y
 S (Y,SRFLG)=$P(S,"^",12),C=$P(^DD(130.06,10,0),"^",2) D:Y'="" Y^DIQ I Y'="" D LINE(1) S @SRG@(SRI)="  Tube Type: "_Y
 I $P(S,"^",13) D:SRFLG="" LINE(1) S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Tube Size: "_$P(S,"^",13)
 S Y=$P(S,"^",14),C=$P(^DD(130.06,12,0),"^",2) D:Y'="" Y^DIQ I Y'="" D LINE(1) S @SRG@(SRI)="  Trauma: "_Y
 S (Y,SRFLG)=$P(S,"^",23),C=$P(^DD(130.06,21,0),"^",2) D:Y'="" Y^DIQ I Y'="" D LINE(1) S @SRG@(SRI)="  Extubated In: "_Y
 S Y=$P($G(^SRF(SRTN,6,ANE,6)),"^"),C=$P(^DD(130.06,39,0),"^",2) D:Y'="" Y^DIQ I Y'="" D:SRFLG="" LINE(1) S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Extubated By: "_$S($L(Y)>25:$P(Y,",")_","_$P(Y,",",2)_".",1:Y)
 I $P(S,"^",24)="Y" D LINE(1) S @SRG@(SRI)="  Reintubated within 8 Hours: YES"
 I $P(S,"^",19)="Y" D LINE(1) S @SRG@(SRI)="  Heat, Moisture Exchanger Used: YES"
 I $P(S,"^",20)="Y" D LINE(1) S @SRG@(SRI)="  Bacteria Filter in Circuit: YES"
 S (Y,SRFLG)=$P(S(2),"^") I Y'="" D LINE(1) S @SRG@(SRI)="  Continuous: "_$S(Y="Y":"YES",1:"NO")
 S Y=$P(S(2),"^",2) I Y'="" S Y=$S(Y=1:"HYPERBARIC",Y=2:"HYPOBARIC",1:"ISOBARIC") D:SRFLG="" LINE(1) S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Baricity: "_Y
 S (Y,SRFLG)=$P(S(2),"^",3),C=$P(^DD(130.06,27,0),"^",2) D:Y'="" Y^DIQ I Y'="" D LINE(1) S @SRG@(SRI)="  Puncture Site: "_Y
 S Y=$P(S(2),"^",5),C=$P(^DD(130.06,29,0),"^",2) D:Y'="" Y^DIQ I Y'="" D:SRFLG="" LINE(1) S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Needle Size: "_Y
 S (Y,SRFLG)=$P(S(8),"^",3),C=$P(^DD(130.06,43,0),"^",2) I Y'="" D Y^DIQ D LINE(1) S @SRG@(SRI)="  Level: "_Y
 Q
MED ; medications
 N ADBY,ADM,C,CNT,COMMENT,DOSE,MED,MM,ORBY,ROUTE,TIME,X,Y
 S (CNT,MED)=0 F  S MED=$O(^SRF(SRTN,22,MED)) Q:'MED  S CNT=CNT+1 D
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
SPACE(NUM) ;create spaces
 ;pass in position returns number of needed spaces
 I '$D(@SRG@(SRI)) S @SRG@(SRI)=""
 Q $J("",NUM-$L(@SRG@(SRI)))
LINE(NUM) ;create carriage returns
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=""
 Q
