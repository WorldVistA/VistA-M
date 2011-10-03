SRONP0 ;BIR/ADM - PROCEDURE REPORT (NON-OR) ;10 Mar 2005  10:39 AM
 ;;3.0; Surgery ;**132,142**;24 Jun 93
 D TIMES
 D PRIN I $O(^SRF(SRTN,13,0)) D OTHER
 D ^SRONP1
 Q
N(SRL) N SRNM I $L(Y)>SRL S SRNM=$P(Y,",")_","_$E($P(Y,",",2))_".",Y=SRNM
 Q
TIMES ; anesthesia start and end times, procedure start and end times
 N AB,AE,OB,OE D LINE(1)
 S AB="N/A",Y=$P(SR(.2),"^") I Y D D^DIQ S AB=$P(Y,"@")_"  "_$P(Y,"@",2)
 S AE="N/A",Y=$P(SR(.2),"^",4) I Y D D^DIQ S AE=$P(Y,"@")_"  "_$P(Y,"@",2)
 I AB="N/A",AE="N/A" G PRTM
 D LINE(1) S @SRG@(SRI)="Anes Begin:  "_AB S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Anes End:  "_AE
PRTM S Y=$P(SR("NON"),"^",4) I Y D D^DIQ S OB=$P(Y,"@")_"  "_$P(Y,"@",2)
 D LINE(1) S @SRG@(SRI)="Proc Begin:  "_$S($D(OB):OB,1:"NOT ENTERED")
 S Y=$P(SR("NON"),"^",5) I Y D D^DIQ S OE=$P(Y,"@")_"  "_$P(Y,"@",2)
 S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Proc End:  "_$S($D(OE):OE,1:"NOT ENTERED")
 Q
PRIN ; principal procedure information
 N CNT,I,LOOP,M,MM,MMM,SRJ,SROPER,SROPS,SRX,SRY,SRZ,X,Z
 D LINE(2) S @SRG@(SRI)="Procedure(s) Performed:"
PRIN2 S SROPER=$P(^SRF(SRTN,"OP"),"^")
 S SROPER="Principal: "_SROPER
 S:$L(SROPER)<74 SROPS(1)=SROPER I $L(SROPER)>73 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 F I=1:1 Q:'$D(SROPS(I))  D LINE(1) S @SRG@(SRI)=$S(I=1:"  ",1:"    ")_SROPS(I)
 Q
LOOP ; break procedure if greater than 74 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<74  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
OTHER ; other procedures
 N CNT,OTH,OTHER,SRJ,SRX,SRY,SRZ,Z
 D LINE(1) S (OTH,CNT)=0 F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH  S CNT=CNT+1 D OTH
 Q
OTH S OTHER=$P(^SRF(SRTN,13,OTH,0),"^")
 S @SRG@(SRI)="  Other: "_OTHER
 I $P($G(^SRF(SRTN,13,OTH,2)),"^"),$O(^SRF(SRTN,13,OTH,1,0)) D CPT
 Q
CPT D LINE(1) S @SRG@(SRI)="     Procedure Code Comments:" S SRLINE=0
 F  S SRLINE=$O(^SRF(SRTN,13,OTH,1,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,13,OTH,1,SRLINE,0) D COMM^SRONP2(X,5)
 Q
SPACE(NUM) ;create spaces
 ;pass in position returns number of needed spaces
 I '$D(@SRG@(SRI)) S @SRG@(SRI)=""
 Q $J("",NUM-$L(@SRG@(SRI)))
LINE(NUM) ;create carriage returns
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=""
 Q
