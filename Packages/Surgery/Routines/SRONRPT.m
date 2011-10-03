SRONRPT ;BIR/ADM - NURSE INTRAOP REPORT ; [ 06/16/04  10:12 AM ]
 ;;3.0; Surgery ;**100,129**;24 Jun 93
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 D:'$D(SRTN) ^SROPS Q:'$D(SRTN)
 D RPT^SRONRPT(SRTN)
 Q
RPT(SRTN) ; send text of nurse intraoperative report to ^TMP
 N ANE,C,CNT,I,J,K,SR,SRAGNT,SRALL,SRANES,SRANESA,SRC,SRCT,SRCASE,SRCONS,SRCONV,SRDISP,SRDIV,SRDT,SREL,SRELP,SRELP2,SRG,SRI,SRL,SRLF,SRLINE,SRMOOD,SROP,SROPER,SROPS,SROR,SRSCAN,SRSKIN,SRTIME,SRTYPE,SRUSER,SRX,SRZ,VIA,X,Y,Z
 N SROIM,SROUT
 S SRCASE=SRTN,SRG=$NA(^TMP("SRNIR",$J,SRCASE)),SRI=0 K @SRG
 S SRDIV=$$SITE^SROUTL0(SRTN),SRALL=$S(SRDIV:$P(^SRO(133,SRDIV,0),"^",6),1:1)
 I $P($G(^SRF(SRTN,30)),"^")!$P($G(^SRF(SRTN,31)),"^",8) D LINE(1) S @SRG@(SRI)="  * * OPERATION ABORTED * *" D LINE(1)
 F X=0:.1:1.1,31,"1.0","VER" S SR(X)=$G(^SRF(SRTN,X))
 S SROR=$P(SR(0),"^",2) I SROR S SROR=$P(^SRS(SROR,0),"^"),SROR=$P(^SC(SROR,0),"^")
 I SROR="" S SROR="NOT ENTERED"
 S Y=$P(SR(0),"^",10),C=$P(^DD(130,.035,0),"^",2) D:Y'="" Y^DIQ S SRTYPE=$S(Y="":"NOT ENTERED",1:Y)
 D LINE(1) S @SRG@(SRI)="Operating Room:  "_SROR S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Surgical Priority: "_SRTYPE
 S Y=$P(SR(.2),"^",15) I Y D D^DIQ S SRTIME=$P(Y,"@")_"  "_$P(Y,"@",2)
 S:Y="" SRTIME="NOT ENTERED" D LINE(2) S @SRG@(SRI)="Patient in Hold: "_SRTIME
 S Y=$P(SR(.2),"^",10) I Y D D^DIQ S SRTIME=$P(Y,"@")_"  "_$P(Y,"@",2)
 S:Y="" SRTIME="* NOT ENTERED *" S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Patient in OR:  "_SRTIME
 S Y=$P(SR(.2),"^",2) I Y D D^DIQ S SRTIME=$P(Y,"@")_"  "_$P(Y,"@",2)
 S:Y="" SRTIME="NOT ENTERED" D LINE(1) S @SRG@(SRI)="Operation Begin: "_SRTIME
 S Y=$P(SR(.2),"^",3) I Y D D^DIQ S SRTIME=$P(Y,"@")_"  "_$P(Y,"@",2)
 S:Y="" SRTIME="NOT ENTERED" S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Operation End:  "_SRTIME
 D LINE(1) S @SRG@(SRI)="",Y=$P(SR(.2),"^",9) I Y D
 .D D^DIQ S SRTIME=$P(Y,"@")_"  "_$P(Y,"@",2)
 .S:Y="" SRTIME="NOT ENTERED" S @SRG@(SRI)=@SRG@(SRI)_"Surgeon in OR:   "_SRTIME
 S Y=$P(SR(.2),"^",12) I Y D D^DIQ S SRTIME=$P(Y,"@")_"  "_$P(Y,"@",2)
 S:Y="" SRTIME="* NOT ENTERED *" S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Patient Out OR: "_SRTIME
 D PROC I $O(^SRF(SRTN,13,0)) D OTHER
 S Y=$P(SR("1.0"),"^",8),C=$P(^DD(130,1.09,0),"^",2) D:Y'="" Y^DIQ D LINE(2) S @SRG@(SRI)="Wound Classification: "_$S(Y'="":Y,1:"NOT ENTERED")
 S Y=$P(SR(.4),"^",6),C=$P(^DD(130,.46,0),"^",2) D:Y'="" Y^DIQ S SRDISP=$S(Y'="":Y,1:"N/A")
 I (SRDISP="N/A"&SRALL)!(SRDISP'="N/A") D LINE(1) S @SRG@(SRI)="Operation Disposition: "_SRDISP
 S Y=$P(SR(.7),"^",4),C=$P(^DD(130,25,0),"^",2) D:Y'="" Y^DIQ S VIA=$S(Y'="":Y,1:"N/A")
 I (VIA="N/A"&SRALL)!(VIA'="N/A") D LINE(1) S @SRG@(SRI)="Discharged Via: "_VIA
 S Y=$P(SR(.1),"^",4),C=$P(^DD(130,.14,0),"^",2) D:Y'="" Y^DIQ,N(30) S:Y="" Y="NOT ENTERED" D LINE(2) S @SRG@(SRI)="Surgeon: "_Y
 S Y=$P(SR(.1),"^",5),C=$P(^DD(130,.15,0),"^",2) D:Y'="" Y^DIQ,N(25) S:Y="" Y="N/A" S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"First Assist: "_Y
 S Y=$P(SR(.1),"^",13),C=$P(^DD(130,.164,0),"^",2) D:Y'="" Y^DIQ,N(26) S:Y="" Y="N/A" D LINE(1) S @SRG@(SRI)="Attend Surg: "_Y
 S Y=$P(SR(.1),"^",6),C=$P(^DD(130,.16,0),"^",2) D:Y'="" Y^DIQ,N(24) S:Y="" Y="N/A" S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Second Assist: "_Y
 S Y=$P(SR(.3),"^"),C=$P(^DD(130,.31,0),"^",2) D:Y'="" Y^DIQ,N(26) S SRANES=$S(Y="":"NOT ENTERED",1:Y)
 S Y=$P(SR(.3),"^",3),C=$P(^DD(130,.33,0),"^",2) D:Y'="" Y^DIQ,N(21) S SRANESA=$S(Y="":"N/A",1:Y)
 I 'SRALL,SRANES="NOT ENTERED",SRANESA="N/A" G OSA
 D LINE(1) S @SRG@(SRI)="Anesthetist: "_SRANES,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Assistant Anesth: "_SRANESA
OSA S SRLINE="Other Scrubbed Assistants: "
 I '$O(^SRF(SRTN,28,0)),SRALL D LINE(2) S @SRG@(SRI)=SRLINE_"N/A"
 I $O(^SRF(SRTN,28,0)) D LINE(2) S @SRG@(SRI)=SRLINE,OTH=0 F  S OTH=$O(^SRF(SRTN,28,OTH)) Q:'OTH  D
 .S Y=$P(^SRF(SRTN,28,OTH,0),"^"),C=$P(^DD(130.23,.01,0),"^",2) D:Y'="" Y^DIQ D LINE(1) S @SRG@(SRI)="  "_Y
 .I $O(^SRF(SRTN,28,OTH,1,0)) D
 ..S SRLINE=0,SRL=4 D LINE(1) S @SRG@(SRI)="    Comments:"
 ..F  S SRLINE=$O(^SRF(SRTN,28,OTH,1,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,28,OTH,1,SRLINE,0) D COMM^SRONRPT3(X,SRL)
 D ^SRONRPT0
 Q
PROC ; print procedure informatiom
 N I,M,MM,SRJ,SRMAJ,SROPER,SROPS,SRX,SRY,X,Z
 S SRMAJ=$P(SR(0),"^",3),SRMAJ=$S(SRMAJ="J":"Major",SRMAJ="N":"Minor",1:"Major")
 D LINE(2) S @SRG@(SRI)=SRMAJ_" Operations Performed:"
 S SROPER=$P(^SRF(SRTN,"OP"),"^")
 I $P($G(^SRF(SRTN,30)),"^")&$P($G(^SRF(SRTN,.2)),"^",10) S SROPER="** ABORTED ** "_SROPER
 K SROPS,MM,MMM S:$L(SROPER)<70 SROPS(1)=SROPER I $L(SROPER)>69 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 F I=1:1 Q:'$D(SROPS(I))  D LINE(1) S @SRG@(SRI)=$S(I=1:"Primary: ",1:"         ")_SROPS(I)
 Q
OTHER ; other procedures
 N CNT,OTH,OTHER,SRJ,SRX,SRY
 S (OTH,CNT)=0 F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH  S CNT=CNT+1 D OTH
 Q
OTH S OTHER=$P(^SRF(SRTN,13,OTH,0),"^")
 D LINE(1) S @SRG@(SRI)="Other:   "_OTHER
 Q
LOOP ; break procedure if greater than 70 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<70  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
N(SRL) N SRN I $L(Y)>SRL S SRN=$P(Y,",")_","_$E($P(Y,",",2))_".",Y=SRN
 Q
SPACE(NUM) ; create spaces
 ; pass in position returns number of needed spaces
 I '$D(@SRG@(SRI)) S @SRG@(SRI)=""
 Q $J("",NUM-$L(@SRG@(SRI)))
LINE(NUM) ; create carriage returns
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=""
 Q
