SRONRPT2 ;BIR/ADM - NURSE INTRAOP REPORT ; [ 09/08/03  2:47 PM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 N BLOOD,COLOR,CONS,COUNTER,DRESS,INSTR,INTEG,MOOD,PACK,SHARP,SPONGE,URINE,VERIFY
 S SRLF=1,SRLINE="Irrigation Solution(s): " I '$O(^SRF(SRTN,26,0)),SRALL D LINE(1) S @SRG@(SRI)=SRLINE_"N/A"
 I $O(^SRF(SRTN,26,0)) D LINE(1) S @SRG@(SRI)=SRLINE D IRR
 S SRLF=1,SRLINE="Blood Replacement Fluids: " I '$O(^SRF(SRTN,4,0)),SRALL D LINE(1) S @SRG@(SRI)=SRLINE_"N/A"
 I $O(^SRF(SRTN,4,0)) D LINE(1) S @SRG@(SRI)=SRLINE D REP
 S SRLF=1,SR(25)=$G(^SRF(SRTN,25)),SPONGE=$P(SR(25),"^"),SHARP=$P(SR(25),"^",2),INSTR=$P(SR(25),"^",3)
 S Y=$P(SR(25),"^",5),C=$P(^DD(130,48,0),"^",2) D:Y'="" Y^DIQ S:Y="" Y="N/A" S VERIFY=Y
 S Y=SPONGE,C=$P(^DD(130,44,0),"^",2) D:Y'="" Y^DIQ S SPONGE=$S(Y'="":Y,VERIFY'="N/A":"* NOT ENTERED *",1:"N/A")
 S Y=SHARP,C=$P(^DD(130,45,0),"^",2) D:Y'="" Y^DIQ S SHARP=$S(Y'="":Y,VERIFY'="N/A":"* NOT ENTERED *",1:"N/A")
 S Y=INSTR,C=$P(^DD(130,46,0),"^",2) D:Y'="" Y^DIQ S INSTR=$S(Y'="":Y,VERIFY'="N/A":"* NOT ENTERED *",1:"N/A")
 S Y=$P(SR(25),"^",4),C=$P(^DD(130,47,0),"^",2) D:Y'="" Y^DIQ S COUNTER=$S(Y'="":Y,VERIFY'="N/A":"* NOT ENTERED *",1:"N/A")
 I 'SRALL,SPONGE="N/A" G SHARP
 D LINE(1) S @SRG@(SRI)="Sponge Count Correct:",@SRG@(SRI)=@SRG@(SRI)_$$SPACE(26)_SPONGE
SHARP I 'SRALL,SHARP="N/A" G INSTR
 D LINE(1) S @SRG@(SRI)="Sharps Count Correct:",@SRG@(SRI)=@SRG@(SRI)_$$SPACE(26)_SHARP
INSTR I 'SRALL,INSTR="N/A" G COUNT
 D LINE(1) S @SRG@(SRI)="Instrument Count Correct: "_INSTR
COUNT I 'SRALL,COUNTER="N/A" G CNTV
 D LINE(1) S @SRG@(SRI)="Counter:",@SRG@(SRI)=@SRG@(SRI)_$$SPACE(26)_COUNTER
CNTV I 'SRALL,VERIFY="N/A" G DRESS
 D LINE(1) S @SRG@(SRI)="Counts Verified By: ",@SRG@(SRI)=@SRG@(SRI)_$$SPACE(26)_VERIFY
DRESS S SRLF=1,SR(35)=$G(^SRF(SRTN,35)),DRESS=$P(SR(35),"^"),Y=$P(SR(.8),"^",11),C=$P(^DD(130,.875,0),"^",2) D:Y'="" Y^DIQ S PACK=$S(Y'="":Y,1:"N/A")
 S DRESS=$S(DRESS'="":DRESS,1:"N/A") I 'SRALL,DRESS="N/A" G PACK
 D LINE(1) S @SRG@(SRI)="Dressing: "_DRESS
PACK I 'SRALL,PACK="N/A" G LOSS
 D LINE(1) S @SRG@(SRI)="Packing:  "_PACK
LOSS S SRLF=1,BLOOD=$P(SR(.2),"^",5),URINE=$P(SR(.2),"^",16) I 'SRALL,BLOOD="",URINE="" G NEXT
 S BLOOD=$S(BLOOD="":"",1:BLOOD_" ml"),URINE=$S(URINE="":"",1:URINE_" ml") D LINE(1) S @SRG@(SRI)="Blood Loss: "_BLOOD,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Urine Output: "_URINE
NEXT D ^SRONRPT3
 Q
REP ; replacement fluids
 N FLUID,QTY,REP,SRCE,VID,SRCT
 S REP=0 F  S REP=$O(^SRF(SRTN,4,REP)) Q:'REP  D
 .S X=^SRF(SRTN,4,REP,0),FLUID=$P(^SRO(133.7,$P(X,"^"),0),"^"),QTY=$P(X,"^",2),SRCE=$P(X,"^",4),VID=$P(X,"^",5)
 .S:QTY="" QTY="N/A" S:SRCE="" SRCE="N/A" S:VID="" VID="N/A"
 .D LINE(1) S @SRG@(SRI)="  "_FLUID,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Quantity: "_QTY_" ml"
 .D LINE(1) S @SRG@(SRI)="    Source Identification: "_SRCE
 .D LINE(1) S @SRG@(SRI)="    VA Identification: "_VID
 .S (SRCT,SRLINE)=0 F  S SRLINE=$O(^SRF(SRTN,4,REP,1,SRLINE)) Q:'SRLINE  S SRCT=SRCT+1
 .Q:'SRCT  D LINE(1) S SRLINE=0,SRL=4,SRLINE=$O(^SRF(SRTN,4,REP,1,SRLINE)),X=^SRF(SRTN,4,REP,1,SRLINE,0)
 .I SRCT=1,$L(X)<67 S @SRG@(SRI)="    Comments: "_X Q
 .S @SRG@(SRI)="    Comments:" D COMM^SRONRPT3(X,SRL)
 .F  S SRLINE=$O(^SRF(SRTN,4,REP,1,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,4,REP,1,SRLINE,0) D COMM^SRONRPT3(X,SRL)
 Q
IRR ; irrigations
 N AMT,DOC,IRR,MM,SOLU,TIME,USED
 S IRR=0 F  S IRR=$O(^SRF(SRTN,26,IRR)) Q:'IRR  D
 .S X=^SRF(SRTN,26,IRR,0),SOLU=$P(^SRO(133.6,X,0),"^") D LINE(1) S @SRG@(SRI)="  "_SOLU
 .S USED=0 F  S USED=$O(^SRF(SRTN,26,IRR,1,USED)) Q:'USED  S MM=^SRF(SRTN,26,IRR,1,USED,0),Y=$P(MM,"^") D D^DIQ S TIME=$P(Y,"@")_"  "_$P(Y,"@",2) D
 ..D LINE(1) S @SRG@(SRI)="    Time Used: "_TIME S AMT=$P(MM,"^",2) S:AMT="" AMT="N/A"
 ..S Y=$P(MM,"^",3),C=$P(^DD(130.39,2,0),"^",2) D:Y'="" Y^DIQ,N(29) S:Y="" Y="N/A" S DOC=Y
 ..D LINE(1) S @SRG@(SRI)="      Amount: "_AMT,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Provider: "_DOC
 Q
N(SRL) N SRN I $L(Y)>SRL S SRN=$P(Y,",")_","_$E($P(Y,",",2))_".",Y=SRN
 Q
SPACE(NUM) ; create spaces
 ;pass in position returns number of needed spaces
 I '$D(@SRG@(SRI)) S @SRG@(SRI)=""
 Q $J("",NUM-$L(@SRG@(SRI)))
LINE(NUM) ; create carriage returns
 I $G(SRLF) S NUM=NUM+1,SRLF=0
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=""
 Q
