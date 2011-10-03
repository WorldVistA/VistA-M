SROANR ;BIR/ADM - ANESTHESIA REPORT ; [ 02/14/04  12:45 PM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 D:'$D(SRTN) ^SROPS Q:'$D(SRTN)
 D RPT(SRTN)
 Q
RPT(SRTN) ; send text of anesthesia report to ^TMP
 N ANE,C,DFN,J,JJ,SR,SRCASE,SRG,SRI,SRL,SRN,SROR,X,Y K ^TMP("SRANE",$J)
 S SRCASE=SRTN,SRG="^TMP(""SRANE"",$J,SRCASE)",SRI=0
 I $P($G(^SRF(SRTN,30)),"^")!$P($G(^SRF(SRTN,31)),"^",8) D LINE(1) S @SRG@(SRI)="  * * "_$S($P($G(^SRF(SRTN,"NON")),"^")="Y":"PROCEDURE",1:"OPERATION")_" ABORTED * *" D LINE(1)
 F SRN=0:.1:1.1,"NON" S SR(SRN)=$G(^SRF(SRTN,SRN))
 S SROR="NOT ENTERED" S X=$P(SR(0),"^",2) I X S X=$P(^SRS(X,0),"^"),X=$P(^SC(X,0),"^"),SROR=$E(X,1,24)
 I $P(SR("NON"),"^")="Y" S X=$P(SR("NON"),"^",2) I X S X=$P(^SC(X,0),"^"),SROR=X
 D LINE(1) S @SRG@(SRI)=$S($P(SR("NON"),"^")="Y":"Location: ",1:"Operating Room: ")_SROR
 S Y=$P(SR(.3),"^"),C=$P(^DD(130,.31,0),"^",2) D:Y'="" Y^DIQ,N(25) S:Y="" Y="* NOT ENTERED *" D LINE(2) S @SRG@(SRI)="Anesthetist: "_Y
 S Y=$P(SR(.3),"^",2),C=$P(^DD(130,.32,0),"^",2) D:Y'="" Y^DIQ,N(24) S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Relief Anesth: "_Y
 S Y=$P(SR(.3),"^",4),C=$P(^DD(130,.34,0),"^",2) D:Y'="" Y^DIQ,N(20) D LINE(1) S @SRG@(SRI)="Anesthesiologist: "_Y
 S Y=$P(SR(.3),"^",3),C=$P(^DD(130,.33,0),"^",2) D:Y'="" Y^DIQ,N(20) S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Assist Anesth: "_Y
 S Y=$P(SR(.3),"^",6),C=$P(^DD(130,.345,0),"^",2) D:Y'="" Y^DIQ D LINE(1) S @SRG@(SRI)="Attending Code: "_Y
 D TIMES
 S Y=$P(SR(1.1),"^",3),C=$P(^DD(130,1.13,0),"^",2) D:Y'="" Y^DIQ S:Y="" Y="* NOT ENTERED *" D LINE(2) S @SRG@(SRI)="ASA Class: "_Y
 S Y=$P(SR(.4),"^",6),C=$P(^DD(130,.46,0),"^",2) D:Y'="" Y^DIQ S:Y="" Y="* NOT ENTERED *" D LINE(2) S @SRG@(SRI)="Operation Disposition: "_Y
 D TECH^SROANR0
 D PRIN I $O(^SRF(SRTN,13,0)) D OTHER
 I $O(^SRF(SRTN,22,0)) D LINE(2) S @SRG@(SRI)="Medications:" D MED^SROANR0
 D ^SROANR1
 Q
N(SRL) N SRN I $L(Y)>SRL S SRN=$P(Y,",")_","_$E($P(Y,",",2))_".",Y=SRN
 Q
TIMES ; anesthesia start and end times
 N AB,AE,OB,OE
 S AB="* NOT ENTERED *",Y=$P(SR(.2),"^") I Y D D^DIQ S AB=$P(Y,"@")_"  "_$P(Y,"@",2)
 S AE="* NOT ENTERED *",Y=$P(SR(.2),"^",4) I Y D D^DIQ S AE=$P(Y,"@")_"  "_$P(Y,"@",2)
 D LINE(2) S @SRG@(SRI)="Anes Begin:  "_AB S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Anes End:  "_AE
 Q
PRIN ; principal procedure information
 N CNT,I,LOOP,M,MM,MMM,SRJ,SROPER,SROPS,SRX,SRY,SRZ,X,Z
 D LINE(2) S @SRG@(SRI)="Procedure(s) Performed:"
PRIN2 S SROPER=$P(^SRF(SRTN,"OP"),"^")
 S SROPER="Principal: "_SROPER
 S:$L(SROPER)<74 SROPS(1)=SROPER I $L(SROPER)>73 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 F I=1:1 Q:'$D(SROPS(I))  D LINE(1) S @SRG@(SRI)=$S(I=1:"",1:"  ")_SROPS(I)
 Q
LOOP ; break procedure if greater than 74 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<74  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
OTHER ; other procedures
 N CNT,OTH,OTHER,SRJ,SRX,SRY,SRZ,Z
 S (OTH,CNT)=0 F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH  S CNT=CNT+1 D OTH
 Q
OTH S OTHER=$P(^SRF(SRTN,13,OTH,0),"^")
 D LINE(1) S @SRG@(SRI)="Other: "_OTHER
 Q
SPACE(NUM) ; create spaces
 ; pass in position returns number of needed spaces
 I '$D(@SRG@(SRI)) S @SRG@(SRI)=""
 Q $J("",NUM-$L(@SRG@(SRI)))
LINE(NUM) ; create carriage returns
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=""
 Q
