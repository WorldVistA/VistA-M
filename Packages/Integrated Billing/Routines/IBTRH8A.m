IBTRH8A ;ALB/JWS - HCSR Worklist - view 278 message in X12 format ;24-AUG-2015
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 Q
NM1 ; create NM1 segment in loop 2010EA
 N R1,R2,R3,R4
 N SEQ,Z,NODE0,PRVPTR,PERSON,PRVDATA,ADDR1,ADDR2,NAME,ADDR3,ENTITY,PCODEPRV,TAXONOMY
 ; create NM1 segments for patient event providers
 S (SEQ,Z)=0 F  S Z=$O(^IBT(356.22,IBTRIEN,13,Z)) Q:Z'=+Z  D
 . S NODE0=$G(^IBT(356.22,IBTRIEN,13,Z,0)) I NODE0="" Q  ; 0-node of sub-file 356.2213
 . S SEQ=SEQ+1 I SEQ>14 Q  ; only allow up to 14 providers
 . S PRVPTR=$P(NODE0,U,3) I PRVPTR="" Q  ; missing provider pointer
 . S PERSON=$P(NODE0,U,2) I 'PERSON Q  ; missing person / non-person indicator
 . S PRVDATA=$$PRVDATA^IBTRHLO2(+$P(PRVPTR,";"),$P($P(PRVPTR,"(",2),","))
 . S ADDR1=$P(PRVDATA,U,2,3),ADDR2=$P(PRVDATA,U,4,6)
 . S NAME=$$HLNAME^HLFNC($P(PRVDATA,U))
 . S ENTITY=$$GET1^DIQ(365.022,+$P(NODE0,U)_",",.01)
 . S X="NM1*"_ENTITY_"*"_PERSON_"*"_$P(NAME,"^")_"*"_$P(NAME,"^",2)_"*"_$P(NAME,"^",3)_"**"_$P(NAME,"^",4)_"*XX*"_$P(PRVDATA,U,7)
 . D SAVE^IBTRH8(X)
 . S ADDR3=$P($$HLADDR^HLFNC(ADDR1,ADDR2),U,1,5)
 . S X="N3*"_$P(ADDR3,U)_"*"_$P(ADDR3,U,2)
 . D SAVE^IBTRH8(X)
 . S X="N4*"_$P(ADDR3,U,3)_"*"_$P(ADDR3,U,4)_"*"_$P(ADDR3,U,5)
 . D SAVE^IBTRH8(X)
 . ; add PRV segment info for Patient Event Provider Loop 2010EA
 . S PCODEPRV=$$PCODECNV^IBTRHLO2(ENTITY) I PCODEPRV'="" D
 .. S TAXONOMY=$P($$GTXNMY^IBTRH3(PRVPTR),U) I TAXONOMY="" Q
 .. S X="PRV*"_PCODEPRV_"*PXC*"_TAXONOMY
 .. D SAVE^IBTRH8(X)
 .. Q
 . Q
 ; create NM1, N3, N4 for Patient Event Transport Loop 2010EB
 I 'MSGTYPE S (SEQ,Z)=0 F  S Z=$O(^IBT(356.22,IBTRIEN,14,Z)) Q:Z'=+Z  D
 . S NODE0=$G(^IBT(356.22,IBTRIEN,14,Z,0)) I NODE0="" Q  ; 0-node of sub-file 356.2214
 . S SEQ=SEQ+1 I SEQ>5 Q  ; only allow up to 5 transports
 . S X="NM1*"_$P(NODE0,U)_"*2*"_$P(NODE0,U,2) D SAVE^IBTRH8(X)
 . S (ADDR1,ADDR2,ADDR3)=""
 . I $P(NODE0,U,3)'="",$P(NODE0,U,5)'="" S ADDR1=$P(NODE0,U,3,4),ADDR2=$P(NODE0,U,5,7)
 . S X="N3*"_$P(NODE0,U,3)_"*"_$P(NODE0,U,4) D SAVE^IBTRH8(X)
 . S ADDR3=$P($$HLADDR^HLFNC(ADDR1,ADDR2),"^",1,5)
 . S X="N4*"_$P(ADDR3,U,3)_"*"_$P(ADDR3,U,4)_"*"_$P(ADDR3,U,5) D SAVE^IBTRH8(X)
 . Q
 ; create NM1 segment for Patient Event Other UMO Name loop 2010EC
 I 'MSGTYPE S (SEQ,Z)=0 F  S Z=$O(^IBT(356.22,IBTRIEN,15,Z)) Q:Z'=+Z  D
 . S NODE0=$G(^IBT(356.22,IBTRIEN,15,Z,0)) I NODE0="" Q  ; 0-node of sub-file 356.2215
 . S SEQ=SEQ+1 I SEQ>3 Q  ; only allow up to 3 other UMOs
 . S X="NM1*"_$P(NODE0,U)_"*2*"_$$EXTERNAL^DILFD(356.2215,.02,,+$P(NODE0,U,2))
 . D SAVE^IBTRH8(X)
 . S R1=$P(NODE0,U,3),R2=$P(NODE0,U,4),R3=$P(NODE0,U,5),R4=$P(NODE0,U,6)
 . I R1="",R2="",R3="",R4="" Q  ; no UMO denial reasons to send
 . S X="REF*ZZ*"_R1_"**"_$S(R2'="":"ZZ",1:"")_":"_R2_":"_$S(R3'="":"ZZ",1:"")_":"_R3_":"_$S(R4'="":"ZZ",1:"")_":"_R4 D SAVE^IBTRH8(X)
 . I $P(NODE0,U,7)="" Q
 . S X="DTP*598*D8*"_$$HLDATE^HLFNC($P(NODE0,U,7)) D SAVE^IBTRH8(X)
 . Q
 Q
 ;
DETAIL ; generate service line detail X12 segments
 N FQUAL,FTYPE,NODE160,PRB,REQCAT,Z1
 S Z1="" F  S Z1=$O(^IBT(356.22,IBTRIEN,16,Z1)) Q:Z1'=+Z1  D
 . S NODE160=$G(^IBT(356.22,IBTRIEN,16,Z1,0)) I NODE160="" Q  ; 0-node of sub-file 356.2216
 . S REQCAT=$$GET1^DIQ(356.001,+$P(NODE160,U,15)_",",.01)
 . I REQCAT'="" D
 .. S X="UM*"_REQCAT_"*"_$$GET1^DIQ(356.002,+$P(NODE160,U,2)_",",.01)_"*"_$$GET1^DIQ(365.013,+$P(NODE160,U,3)_",",.01)
 .. S FQUAL=$P(NODE160,U,4) I FQUAL'="" D
 ... S FTYPE=$S(FQUAL="A":$P(NODE160,U,6)_$P(NODE160,U,7),1:$$EXTERNAL^DILFD(356.2216,.05,,+$P(NODE160,U,5)))
 ... I FTYPE'="" S $P(X,"*",5)=FTYPE_":"_$P(NODE160,U,4)
 .. D SAVE^IBTRH8(X)
 .. Q
 . D DREF,DDTP,DSV
 . I 'MSGTYPE D HSD,PWK,NTE
 . D NM1F
 . Q
 Q
 ;
DREF ; create service level REF segment
 N NODE169
 S NODE169=$G(^IBT(356.22,IBTRIEN,16,Z1,9)) ; 9-node of sub-file 356.2216
 S X=""
 I $P(NODE169,U)'="" S X="REF*BB*"_$P(NODE169,U)
 I X="",$P(NODE169,U,2)'="" S X="REF*NT*"_$P(NODE169,U,2)
 I X="" Q
 D SAVE^IBTRH8(X)
 Q
 ;
DDTP ; create service level DTP Service Date segment
 N SRVDATE
 S SRVDATE=$P(NODE160,U,11) I SRVDATE="" Q
 S X="DTP*472*"_$S($F(SRVDATE,"-"):"RD8",1:"D8")_"*"_$$HLDATE^HLFNC($P(SRVDATE,"."))
 D SAVE^IBTRH8(X)
 Q
 ;
DSV ; create service level SV segments
 N NODE161,NODE162,NODE163,NODE1640,NODE1612,SEQ,SRVTYPE,TMP,Z2
 N EXT161U2,EXT161U3
 S NODE161=$G(^IBT(356.22,IBTRIEN,16,Z1,1)) I NODE161="" Q  ; 1-node of sub-file 356.2216
 S NODE162=$G(^IBT(356.22,IBTRIEN,16,Z1,2)) ; 2-node of sub-file 356.2216
 S NODE163=$G(^IBT(356.22,IBTRIEN,16,Z1,3)) ; 3-node of sub-file 356.2216
 S NODE1612=$G(^IBT(356.22,IBTRIEN,16,Z1,12)) ; 12-node of sub-file 356.2216
 S SRVTYPE=$P(NODE161,U,12)
 S TMP=$S(SRVTYPE="D":"AD",1:$P(NODE161,U))
 S EXT161U2=$$EXTERNAL^DILFD(356.2216,1.02,,$P(NODE161,U,2))
 S $P(TMP,":",2)=$S(TMP="N4":$P(NODE1612,U),1:EXT161U2)
 S EXT161U3=$$EXTERNAL^DILFD(356.2216,1.03,,$P(NODE161,U,3))
 S $P(TMP,":",8)=$S(TMP="N4":$P(NODE1612,U,2),1:EXT161U3)
 I 'MSGTYPE D
 . S $P(TMP,":",3)=$$EXTERNAL^DILFD(356.2216,1.04,,$P(NODE161,U,4))
 . S $P(TMP,":",4)=$$EXTERNAL^DILFD(356.2216,1.05,,$P(NODE161,U,5))
 . S $P(TMP,":",5)=$$EXTERNAL^DILFD(356.2216,1.06,,$P(NODE161,U,6))
 . S $P(TMP,":",6)=$$EXTERNAL^DILFD(356.2216,1.07,,$P(NODE161,U,7))
 . S $P(TMP,":",7)=$P(NODE161,U,8)
 . Q
 I SRVTYPE'="D" S $P(TMP,"*",4)=$P(NODE161,U,11),$P(TMP,"*",3)=$P(NODE161,U,10)
 I 'MSGTYPE S $P(TMP,"*",2)=$P(NODE161,U,9)
 I SRVTYPE="I" D
 . S X="SV2**"_TMP
 . S $P(X,"*",2)=$$GET1^DIQ(399.2,+$P(NODE162,U,6)_",",.01)
 . I 'MSGTYPE D
 .. S $P(X,"*",7)=$P(NODE162,U,7)
 .. S $P(X,"*",10)=$$GET1^DIQ(356.011,+$P(NODE162,U,8)_",",.01)
 .. S $P(X,"*",11)=$$GET1^DIQ(356.019,+$P(NODE162,U,9)_",",.01)
 .. Q
 . Q
 I SRVTYPE="P" D
 . S X="SV1*"_TMP
 . I 'MSGTYPE D
 .. S TMP=$P(NODE162,U)_":"_$P(NODE162,U,2)_":"_$P(NODE162,U,3)_":"_$P(NODE162,U,4)
 .. S $P(X,"*",8)=TMP
 .. S $P(X,"*",12)=$P(NODE162,U,5)
 .. S $P(X,"*",21)=$$GET1^DIQ(356.019,+$P(NODE162,U,9)_",",.01)
 .. Q
 . Q
 I SRVTYPE="D",$TR(NODE163,U)'="" D
 . S X="SV3*"_TMP
 . S $P(X,"*",6)=$P(NODE163,U,6)
 . S $P(X,"*",7)=$P(NODE161,U,11)
 . I 'MSGTYPE D
 .. S $P(X,"*",8)=$P(NODE163,U,7)
 .. Q
 . S TMP=$P(NODE163,U)_":"_$P(NODE163,U,2)_":"_$P(NODE163,U,3)_":"_$P(NODE163,U,4)_":"_$P(NODE163,U,5)
 . S $P(X,"*",5)=TMP
 . Q
 D SAVE^IBTRH8(X)
 I SRVTYPE'="D" Q
 ; additional TOO segments for tooth information
 S Z2="" F  S Z2=$O(^IBT(356.22,IBTRIEN,16,Z1,4,Z2)) Q:Z2'=+Z2  D
 . S NODE1640=$G(^IBT(356.22,IBTRIEN,16,Z1,4,Z2,0)) I NODE1640="" Q  ; 0-node of sub-file 356.22164
 . S X="TOO*JP*"_$$GET1^DIQ(356.022,+$P(NODE1640,U)_",",.01)
 . S TMP=$P(NODE1640,U,2)
 . I 'MSGTYPE D
 .. S TMP=TMP_":"_$P(NODE1640,U,3)_":"_$P(NODE1640,U,4)_":"_$P(NODE1640,U,5)_":"_$P(NODE1640,U,6)
 .. Q
 . S $P(X,"*",4)=TMP
 . D SAVE^IBTRH8(X)
 . Q
 Q
 ;
HSD ; create HSD loop 2000F segment
 N NODE165,ZHS
 S NODE165=$G(^IBT(356.22,IBTRIEN,16,Z1,5)) I NODE165="" Q  ; 5-node of sub-file 356.2216
 S X="HSD*"_$$GET1^DIQ(365.016,+$P(NODE165,U)_",",.01)_"*"
 S X=X_$P(NODE165,U,2)_"*"_$P(NODE165,U,3)_"*"_$P(NODE165,U,4)_"*"
 S X=X_$$GET1^DIQ(365.015,+$P(NODE165,U,5)_",",.01)_"*"_$P(NODE165,U,6)_"*"
 S X=X_$$GET1^DIQ(365.025,+$P(NODE165,U,7)_",",.01)_"*"_$$GET1^DIQ(356.007,+$P(NODE165,U,8)_",",.01)
 I $TR($P(X,"*",3,99),"*")="" Q
 D SAVE^IBTRH8(X)
 Q
 ;
PWK ; create PWK segment loop 2000F
 N NODE1660,PSL,SEQ,Z2,Z3
 S (SEQ,Z2)=0 F  S Z2=$O(^IBT(356.22,IBTRIEN,16,Z1,6,Z2)) Q:Z2'=+Z2  D
 . S NODE1660=$G(^IBT(356.22,IBTRIEN,16,Z1,6,Z2,0)) I NODE1660="" Q  ; 0-node of sub-file 356.22166
 . S SEQ=SEQ+1 I SEQ>10 Q
 . S X="PWK*"
 . S $P(X,"*",2)=$$GET1^DIQ(356.018,+$P(NODE1660,U)_",",.01)
 . S $P(X,"*",3)=$P(NODE1660,U,2)
 . S $P(X,"*",6)="AC"
 . S $P(X,"*",7)=$P(NODE1660,U,3)
 . S $P(X,"*",8)=$P(NODE1660,U,4)
 . D SAVE^IBTRH8(X)
 . Q
 Q
 ;
NTE ; create MSG segment loop 2000F
 N MSG,NTE
 S MSG=$$WP2STR^IBTRHLO2(356.2216,7,Z1_","_IBTRIEN_",",264)
 I MSG="" Q
 S X="MSG*"_MSG
 D SAVE^IBTRH8(X)
 Q
 ;
NM1F ; create NM1, N3, N4 Service Provider segments loop 2000F
 N ADDR1,ADDR2,NODE1680,PERSON,PRD,PRVDATA,PRVPTR,SEQ,TMP,Z2,PCODEPRV,ENTITY,TAXONOMY
 S (SEQ,Z2)=0 F  S Z2=$O(^IBT(356.22,IBTRIEN,16,Z1,8,Z2)) Q:Z2'=+Z2  D
 . S NODE1680=$G(^IBT(356.22,IBTRIEN,16,Z1,8,Z2,0)) I NODE1680="" Q  ; 0-node of sub-file 356.22168
 . S SEQ=SEQ+1 I SEQ>14 Q  ; only allow up to 14 providers
 . S PRVPTR=$P(NODE1680,U,3) I PRVPTR="" Q  ; missing provider pointer
 . S PERSON=$P(NODE1680,U,2) I 'PERSON Q  ; missing person / non-person indicator
 . S PRVDATA=$$PRVDATA^IBTRHLO2(+$P(PRVPTR,";"),$P($P(PRVPTR,"(",2),","))
 . S ADDR1=$P(PRVDATA,U,2,3),ADDR2=$P(PRVDATA,U,4,6)
 . S NAME=$$HLNAME^HLFNC($P(PRVDATA,U))
 . S X="NM1*"
 . S ENTITY=$$GET1^DIQ(365.022,+$P(NODE1680,U)_",",.01)
 . S $P(X,"*",2)=ENTITY
 . S $P(X,"*",3)=PERSON
 . S $P(X,"*",4)=$P(NAME,"^")
 . S $P(X,"*",5)=$P(NAME,"^",2)
 . S $P(X,"*",6)=$P(NAME,"^",3)
 . S $P(X,"*",8)=$P(NAME,"^",4)
 . S $P(X,"*",9)="XX"
 . S $P(X,"*",10)=$P(PRVDATA,U,7)
 . D SAVE^IBTRH8(X)
 . S ADDR3=$P($$HLADDR^HLFNC(ADDR1,ADDR2),U,1,5)
 . S X="N3*"_$P(ADDR3,U)_"*"_$P(ADDR3,U,2)
 . D SAVE^IBTRH8(X)
 . S X="N4*"_$P(ADDR3,U,3)_"*"_$P(ADDR3,U,4)_"*"_$P(ADDR3,U,5)
 . D SAVE^IBTRH8(X)
 . ; create PRV segment info for service level loop 2000F
 . S PCODEPRV=$$PCODECNV^IBTRHLO2(ENTITY) I PCODEPRV'="" D
 .. I '$F(",AS,OP,OR,OT,PC,PE",","_PCODEPRV) Q
 .. S TAXONOMY=$P($$GTXNMY^IBTRH3(PRVPTR),U) I TAXONOMY="" Q
 .. S X="PRV*"_PCODEPRV_"*PXC*"_TAXONOMY
 .. D SAVE^IBTRH8(X)
 .. Q
 . Q
 Q
 ;
CR5 ; create CR5 segment
 N BGAS,RXE,OXYTST,Z
 S BGAS=+$P(NODE9,U) I 'BGAS Q  ; missing arterial blood gas quantity
 S X="CR5***"
 S $P(X,"*",9)=$P(NODE8,U,7)
 S $P(X,"*",10)=$P(NODE8,U,8)
 S $P(X,"*",11)=BGAS
 S $P(X,"*",6)=$P(NODE8,U,4)
 S $P(X,"*",12)=$P(NODE9,U,2)
 S $P(X,"*",4)=$$GET1^DIQ(356.013,+$P(NODE8,U)_",",.01)
 S $P(X,"*",5)=$$GET1^DIQ(356.013,+$P(NODE8,U,2)_",",.01)
 S $P(X,"*",17)=$P(NODE9,U,7)
 S $P(X,"*",8)=$P(NODE8,U,6)
 S $P(X,"*",7)=$P(NODE8,U,5)
 S Z=+$P(NODE9,U,4) I Z>0 S $P(X,"*",14)=$$GET1^DIQ(356.015,Z_",",.01)
 S Z=+$P(NODE9,U,5) I Z>0 S $P(X,"*",15)=$$GET1^DIQ(356.015,Z_",",.01)
 S Z=+$P(NODE9,U,6) I Z>0 S $P(X,"*",16)=$$GET1^DIQ(356.015,Z_",",.01)
 S $P(X,"*",13)=$$GET1^DIQ(356.014,+$P(NODE9,U,3)_",",.01)
 S $P(X,"*",18)=$$GET1^DIQ(356.016,+$P(NODE9,U,8)_",",.01)
 S $P(X,"*",19)=$$GET1^DIQ(356.013,+$P(NODE8,U,3)_",",.01)
 D SAVE^IBTRH8(X)
 Q
 ;
CR6 ; generate CR6 segment
 N DATESTR,PRB,PROCSTR,Z
 I $TR(NODE10,U)=""!(CERT="") Q
 S X="CR6*"
 S $P(X,"*",9)=CERT,$P(X,"*",8)="W"
 S Z=$P(NODE10,U,6) I Z'="" S $P(X,"*",11)=$$EXTERNAL^DILFD(356.22,10.06,,Z)
 S Z=$P(NODE10,U,7) I Z'="" S $P(X,"*",12)=$$EXTERNAL^DILFD(356.22,10.07,,Z)
 S $P(X,"*",13)=$$HLDATE^HLFNC($P(NODE10,U,8))
 S $P(X,"*",10)=$$HLDATE^HLFNC($P(NODE10,U,5))
 S $P(X,"*",14)=$$HLDATE^HLFNC($P(NODE10,U,9))
 S $P(X,"*",18)=$$GET1^DIQ(356.017,+$P(NODE10,U,13)_",",.01)
 S DATESTR="",Z=$P(NODE10,U,11) I Z'="" S DATESTR=$$HLDATE^HLFNC(Z)
 I DATESTR'="" S Z=$P(NODE10,U,12) S:Z'="" DATESTR=DATESTR_"-"_$$HLDATE^HLFNC(Z) S $P(X,"*",16)="RD8",$P(X,"*",17)=DATESTR ; last admission date range
 S $P(X,"*",15)=$$HLDATE^HLFNC($P(NODE10,U,10))
 S $P(X,"*",3)=$$HLDATE^HLFNC($P(NODE10,U))
 S DATESTR="",Z=$P(NODE10,U,2) I Z'="" S DATESTR=$$HLDATE^HLFNC(Z)
 I DATESTR'="" S Z=$P(NODE10,U,3) S:Z'="" DATESTR=DATESTR_"-"_$$HLDATE^HLFNC(Z) S $P(X,"*",4)="RD8",$P(X,"*",5)=DATESTR ; home health cert. date range
 S $P(X,"*",2)=$$GET1^DIQ(356.004,+$P(NODE2,U,15)_",",.01)
 D SAVE^IBTRH8(X)
 Q
 ;
AAA(LP) ; AAA segment info
 N X,X1,LOOP,AAA03,AAA04,DATA
 S X1=0
 F  S X1=$O(^IBT(356.22,IBTRIEN,101,X1)) Q:X1'=+X1  S DATA=$G(^(X1,0)),LOOP=$P(DATA,"^",2) I LOOP D
 . S LOOP=$$GET1^DIQ(365.027,LOOP_",",.01)
 . I LP'=LOOP Q
 . S X="AAA*"_$P(^IBT(356.22,IBTRIEN,101,X1,0),"^",3)
 . S AAA03=$P(DATA,"^",4)
 . S $P(X,"*",4)=$$GET1^DIQ(365.017,AAA03_",",.01)
 . S AAA04=$P(DATA,"^",5)
 . S $P(X,"*",5)=$$GET1^DIQ(365.018,AAA04_",",.01)
 . D SAVE^IBTRH8(X)
 . Q
 Q
 ;
DISPLAY ;
 N X1,X2,CNT,DATA,I
 D CLEAR^VALM1
 S X1="" F  S X1=$O(^TMP($J,"IBTRH8",X1)) Q:X1=""  S DATA=^(X1) D  Q:X="^"
 . ;;S DATA=$P(DATA,"~")
 . S X2=$L(DATA,"*") F I=2:1:X2 I $P(DATA,"*",I)'="" Q
 . I I=X2,$P(DATA,"*",I)="" Q
 . F I=$L(DATA):-1:1 Q:$E(DATA,I)'="*"
 . I I'=$L(DATA) S DATA=$E(DATA,1,I)
 . F I=$L(DATA):-1:1 Q:$E(DATA,I)'=":"
 . I I'=$L(DATA) S DATA=$E(DATA,1,I)
 . W !,DATA S CNT=$G(CNT)+1 I CNT#21=0 D PAUSE^VALM1 Q:X="^"
 I X'="^" D PAUSE^VALM1
 S VALMBCK="R"
 D RE^VALM4
 Q
