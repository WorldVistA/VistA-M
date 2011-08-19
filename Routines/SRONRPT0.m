SRONRPT0 ;BIR/ADM - NURSE INTRAOP REPORT ;05/31/06
 ;;3.0; Surgery ;**100,129,147,153,157**;24 Jun 93;Build 3
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 D LINE(2) S @SRG@(SRI)="OR Support Personnel:" D LINE(1) S @SRG@(SRI)="  Scrubbed",@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Circulating" D NURSE
 S SRLF=1,SRLINE="Other Persons in OR: " I '$O(^SRF(SRTN,32,0)),SRALL D LINE(1) S @SRG@(SRI)=SRLINE_"N/A"
 I $O(^SRF(SRTN,32,0)) D LINE(1) S @SRG@(SRI)=SRLINE D
 .S OTH=0 F  S OTH=$O(^SRF(SRTN,32,OTH)) Q:'OTH  D
 ..S X=^SRF(SRTN,32,OTH,0),SRLINE="  "_$P(X,"^")
 ..S Y=$P(X,"^",2) S:Y'="" SRLINE=SRLINE_" ("_Y_")"
 ..D LINE(1) S @SRG@(SRI)=SRLINE
 S SRLF=1
 S X=$P(SR(.1),"^",9),SRMOOD=$S(X:$E($P(^SRO(135.3,X,0),"^"),1,20),1:"N/A")
 S X=$P(SR(.1),"^",15),SRCONS=$S(X:$E($P(^SRO(135.4,X,0),"^"),1,24),1:"N/A")
 S X=$P(SR(0),"^",7),SRSKIN=$S(X:$E($P(^SRO(135.2,X,0),"^"),1,20),1:"N/A")
 S Y=$P(SR(.1),"^",14),C=$P(^DD(130,.195,0),"^",2) D:Y'="" Y^DIQ S SRCONV=$S(Y'="":Y,1:"N/A")
 I 'SRALL,SRMOOD="N/A",SRCONS="N/A" G SKIN
 D LINE(1) S @SRG@(SRI)="Preop Mood:",@SRG@(SRI)=@SRG@(SRI)_$$SPACE(18)_SRMOOD,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Preop Consc:",@SRG@(SRI)=@SRG@(SRI)_$$SPACE(56)_SRCONS
SKIN I 'SRALL,SRSKIN="N/A",SRCONV="N/A" G VAL
 D LINE(1) S @SRG@(SRI)="Preop Skin Integ: "_SRSKIN,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Preop Converse: "_SRCONV
VAL S SRLF=1,Y=$P(SR(.6),"^",9),C=$P(^DD(130,.69,0),"^",2) D:Y'="" Y^DIQ S SRUSER=$S(Y="":"N/A",1:Y)
 I 'SRALL,SRUSER="N/A" G VER
 D LINE(1) S @SRG@(SRI)="Valid Consent/ID Band Confirmed By: "_SRUSER
 ;
VER N II,SROIM,SROUT,SROIN,SRHRM
 S Y=$P(SR("VER"),"^",5),SROIN=$S(Y="Y":"YES",Y="M":"MARKING NOT REQUIRED FOR THIS PROCEDURE",Y="N":"NO - MARKING REQUIRED BUT NOT DONE (see MARKED SITE COMMENTS)",1:"* NOT ENTERED *")
 D LINE(1) S @SRG@(SRI)="Mark on Surgical Site Confirmed: "_$S($L(SROIN)>43:"",1:SROIN)
 I $L(SROIN)>43 D LINE(1) S @SRG@(SRI)=$$SPACE(2)_SROIN
 S II=84 D ENSC,LINE(1)
 S Y=$P(SR("VER"),"^",4),SROIM=$S(Y="Y":"YES",Y="I":"IMAGING NOT REQUIRED FOR THIS PROCEDURE",Y="N":"IMAGING REQUIRED BUT NOT VIEWED (see IMAGING CONFIRMED COMMENTS)",1:"* NOT ENTERED *")
 D LINE(1) S @SRG@(SRI)="Preoperative Imaging Confirmed:  "_$S($L(SROIM)>43:"",1:SROIM)
 I $L(SROIM)>43 D LINE(1) S @SRG@(SRI)=$$SPACE(2)_SROIM
 S II=83 D ENSC,LINE(1)
 S Y=$P(SR("VER"),"^",3),SROUT=$S(Y="Y":"YES",Y="N":"NO (see TIME OUT VERIFIED COMMENTS)",1:"* NOT ENTERED *")
 D LINE(1) S @SRG@(SRI)="Time Out Verification Completed: "_$S($L(SROUT)>43:"",1:SROUT)
 S II=82 D ENSC
 S SRLF=1
 ;
PREP N SRSKIP S SRSKIP=0
 S Y=$P(SR(.1),"^",8),C=$P(^DD(130,.18,0),"^",2) D:Y'="" Y^DIQ,N(25) S SRUSER=$S(Y="":"N/A",1:Y)
 S Y=$P(SR(.1),"^",7),C=$P(^DD(130,.175,0),"^",2) D:Y'="" Y^DIQ S SRAGNT=$S(Y="":"N/A",1:$E(Y,1,22))
 I 'SRALL,SRUSER="N/A",SRAGNT="N/A" G PREP2
 D LINE(1) S @SRG@(SRI)="Skin Prep By: "_SRUSER,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Skin Prep Agent: "_SRAGNT
 S SRSKIP=1
PREP2 S Y=$P(SR(.1),"^",12),C=$P(^DD(130,4,0),"^",2) D:Y'="" Y^DIQ,N(21) S SRUSER=$S(Y="":"N/A",1:Y)
 S Y=$P(SR(31),"^",2),C=$P(^DD(130,8,0),"^",2) D:Y'="" Y^DIQ S SRAGNT=$S(Y="":"N/A",1:$E(Y,1,18))
 I 'SRALL,SRUSER="N/A",SRAGNT="N/A" G PREOP
 D LINE(1) S @SRG@(SRI)="Skin Prep By (2): "_SRUSER,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"2nd Skin Prep Agent: "_SRAGNT
 S SRSKIP=0 D LINE(1)
PREOP S Y=$P(SR(.1),"^",2),C=$P(^DD(130,.12,0),"^",2) D:Y'="" Y^DIQ S SRUSER=$S(Y="":"N/A",1:Y)
 D:SRSKIP LINE(1) D LINE(1) S @SRG@(SRI)="Preop Surgical Site Hair Removal by: "_SRUSER
 S Y=$P(SR("VER"),"^",6),C=$P(^DD(130,506,0),"^",2) D:Y'="" Y^DIQ S SRHRM=$S(Y="":"* NOT ENTERED *",1:Y)
 D LINE(1) S @SRG@(SRI)="Surgical Site Hair Removal Method: "_$S($L(SRHRM)>43:"",1:SRHRM)
 I $L(SRHRM)>43 D LINE(1) S @SRG@(SRI)=$$SPACE(2)_SRHRM
 S II=49 D ENSC
 ;
POS S SRLF=1,SRLINE="Surgery Position(s): " I '$O(^SRF(SRTN,42,0)),SRALL D LINE(1) S @SRG@(SRI)=SRLINE_"N/A"
 I $O(^SRF(SRTN,42,0)) D LINE(1) S @SRG@(SRI)=SRLINE D
 .S SRP=0 F  S SRP=$O(^SRF(SRTN,42,SRP)) Q:'SRP  S X=^SRF(SRTN,42,SRP,0),Z=$P(X,"^"),Y=$P(X,"^",2) D
 ..S SRPOS=$P(^SRO(132,Z,0),"^") D:Y D^DIQ S SRTIME=$S(Y'="":$P(Y,"@")_"  "_$P(Y,"@",2),1:"N/A")
 ..D LINE(1) S @SRG@(SRI)="  "_SRPOS,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Placed: "_SRTIME
 S SRLF=1,SRLINE="Restraints and Position Aids: "
 I '$O(^SRF(SRTN,20,0)),SRALL D LINE(1) S @SRG@(SRI)=SRLINE_"N/A"
 I $O(^SRF(SRTN,20,0)) N SRRP D LINE(1) S @SRG@(SRI)=SRLINE,(SRRP,CNT)=0 F  S SRRP=$O(^SRF(SRTN,20,SRRP)) Q:'SRRP  S CNT=CNT+1,X=^SRF(SRTN,20,SRRP,0),Z=$P(X,"^"),Y=$P(X,"^",2),W=$P(X,"^",3) D
 .S SREST=$P(^SRO(132.05,Z,0),"^"),C=$P(^DD(130.31,1,0),"^",2) D:Y'="" Y^DIQ,N(31) S:Y="" Y="N/A"
 .D LINE(1) S @SRG@(SRI)="  "_SREST,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(36)_"Applied By: "_Y
 .I W'="" D LINE(1) S @SRG@(SRI)="      Comments: "_W
 S SRLF=1,X=$P(SR(.7),"^",5),SREL=$S(X'="":X,1:"N/A")
 S X=$P(SR(.5),"^",4),SRELP=$S(X:$P(^SRO(138,X,0),"^"),1:"N/A")
 S X=$P(SR(.5),"^",13),SRELP2=$S(X:$P(^SRO(138,X,0),"^"),1:"")
 S X=$P(SR(.7),"^"),SRC=$S(X'="":X,1:"N/A"),X=$P(SR(.7),"^",2),SRCT=$S(X'="":X,1:"N/A")
 I 'SRALL,SREL="N/A",SRELP="N/A",SRELP2="" G LAB
 D LINE(1) S @SRG@(SRI)="Electrocautery Unit:       "_SREL
 D LINE(1) S @SRG@(SRI)="ESU Coagulation Range:     "_SRC
 D LINE(1) S @SRG@(SRI)="ESU Cutting Range:         "_SRCT
 D LINE(1) S @SRG@(SRI)="Electroground Position(s): "_SRELP
 I SRELP2'="" D LINE(1) S @SRG@(SRI)=$$SPACE(27)_SRELP2
LAB S SRLF=1 I $O(^SRF(SRTN,9,0))!SRALL D LAB1
 S SRLF=1 I $O(^SRF(SRTN,6,0)) D LINE(1) S @SRG@(SRI)="Anesthesia Technique(s):" S ANE=0 F  S ANE=$O(^SRF(SRTN,6,ANE)) Q:'ANE  D ANE
 I '$O(^SRF(SRTN,6,0)),SRALL D LINE(1) S @SRG@(SRI)="Anesthesia Technique(s): N/A"
 D ^SRONRPT1
 Q
NURSE ; nurse info
 N CNT,CIRC,I,NURSE,SCRU,X,Y,Z
 S (CNT,CIRC)=0 F  S CIRC=$O(^SRF(SRTN,19,CIRC)) Q:'CIRC  S CNT=CNT+1 D
 .S Z=^SRF(SRTN,19,CIRC,0),Y=$P(Z,"^"),C=$P(^DD(130.28,.01,0),"^",2) D Y^DIQ,N(21) S SRX=Y
 .S Y=$P(Z,"^",3),C=$P(^DD(130.28,3,0),"^",2) D:Y'="" Y^DIQ S CIRC(CNT)=SRX_" ("_Y_")"
 S (CNT,SCRU)=0 F  S SCRU=$O(^SRF(SRTN,23,SCRU)) Q:'SCRU  S CNT=CNT+1 D
 .S Z=^SRF(SRTN,23,SCRU,0),Y=$P(Z,"^"),C=$P(^DD(130.36,.01,0),"^",2) D Y^DIQ,N(21) S SRX=Y
 .S Y=$P(Z,"^",3),C=$P(^DD(130.36,3,0),"^",2) D:Y'="" Y^DIQ S SCRU(CNT)=SRX_" ("_Y_")"
 S:'$D(SCRU(1)) SCRU(1)="N/A" S:'$D(CIRC(1)) CIRC(1)="N/A"
 F I=1:1 Q:('$D(SCRU(I))&'$D(CIRC(I)))  S NURSE(I)=$S($D(SCRU(I)):SCRU(I),1:"")_"^"_$S($D(CIRC(I)):CIRC(I),1:"")
 S I=0 F  S I=$O(NURSE(I)) Q:'I  D LINE(1) S @SRG@(SRI)=$$SPACE(2)_$P(NURSE(I),"^") S @SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_$P(NURSE(I),"^",2)
 Q
LAB1 N SRSP S SRLF=1 D LINE(1) S @SRG@(SRI)="Material Sent to Laboratory for Analysis: "
 I 'SRALL,'$O(^SRF(SRTN,9,0)),'$O(^SRF(SRTN,41,0)) S @SRG@(SRI)=@SRG@(SRI)_"N/A" Q
 D LINE(1) S @SRG@(SRI)="Specimens: " D
 .I '$O(^SRF(SRTN,9,0)) S @SRG@(SRI)=@SRG@(SRI)_"N/A" Q
 .S SRSP=0 F  S SRSP=$O(^SRF(SRTN,9,SRSP)) Q:'SRSP  D LINE(1) S @SRG@(SRI)=$$SPACE(2)_^SRF(SRTN,9,SRSP,0)
 D LINE(1) S @SRG@(SRI)="Cultures:  " D
 .I '$O(^SRF(SRTN,41,0)) S @SRG@(SRI)=@SRG@(SRI)_"N/A" Q
 .S SRSP=0 F  S SRSP=$O(^SRF(SRTN,41,SRSP)) Q:'SRSP  D LINE(1) S @SRG@(SRI)=$$SPACE(2)_^SRF(SRTN,41,SRSP,0)
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
ANE ; print anesthesia technique
 N A,AGNT,C,CNT,DRUG
 S A=^SRF(SRTN,6,ANE,0),Y=$P(A,"^"),C=$P(^DD(130.06,.01,0),"^",2) D:Y'="" Y^DIQ D LINE(1) S Y=Y_$S($P(A,"^",3)="Y":"  (PRINCIPAL)",1:""),@SRG@(SRI)=$$SPACE(2)_Y
 Q
ENSC N X,SRLINE
 D LINE(1) S @SRG@(SRI)="  "_$S(II=82:"Time Out Verified Comments: ",II=83:"Imaging Confirmed Comments: ",II=84:"Marked Site Comments: ",II=49:"Hair Removal Comments: ",1:"") D
 .I '$O(^SRF(SRTN,II,0)) S @SRG@(SRI)=@SRG@(SRI)_"NO COMMENTS ENTERED" Q
 .S SRLINE=0 F  S SRLINE=$O(^SRF(SRTN,II,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,II,SRLINE,0) D COMM^SRONRPT3(X,3)
 Q
