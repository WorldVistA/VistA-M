ENPRUTL ;WISC/SAB-PROJECT TRACKING UTILITIES ;1/20/1998
 ;;7.0;ENGINEERING;**28,49**;Aug 17, 1993
 Q
 ;
PRDOM ; Determine Domain for project tracking transmissions
 S ENDOMAIN=$$GET1^DIQ(6910,1,101)
 I ENDOMAIN']"" W !,"Domain not found in PROJECT TRACKING ROLLUP DOMAIN (#101) field",!,"of the ENG INIT PARAMETERS (#6910) file. Transmission aborted!",!! R "Press RETURN to Continue",X:DTIME
 Q
 ;
FMS(ENDA) ; FMS # Extrinsic Function
 ; called from FMS # (# .05) computed field
 ; Input: DA - ien of construction project
 ; Returns: computed FMS #
 N ENFT,ENPR,ENX,ENY
 S ENX="",ENY=$G(^ENG("PROJ",ENDA,0)),ENPR=$P(ENY,U,6)
 I "^MA^MI^"[(U_ENPR_U) D
 . N ENFT,ENPN,ENPC
 . S ENPN=$P(ENY,U)
 . S ENFT("I")=$P($G(^ENG("PROJ",ENDA,52)),U,6)
 . S ENPC("C")=$S(ENFT("I")="VBA":"VB",ENFT("I")="NCS":"CM",1:"")
 . I ENPC("C")="" D
 . . S ENPC("I")=$P($G(^ENG("PROJ",ENDA,52)),U)
 . . S:ENPC("I") ENPC("C")=$P($G(^OFM(7336.8,ENPC("I"),0)),U,9)
 . I $G(ENPC("C"))'?2U S ENPC("C")="??"
 .S ENX=$P(ENPN,"-")_"-"_ENPC("C")_$S(ENPR="MA":2,1:3)_"-"_$P(ENPN,"-",2)
 Q ENX
 ;
MSL(ENDA) ; Milestone List Extrinsic Function
 ; ENDA - ien of construction project
 ; Returns value with pieces (true/false) which indicate applicability
 ; of the corresponding 22 milestones
 N ENAM,ENCM,ENCAF,ENPR,ENX
 S ENPR=$$GET1^DIQ(6925,ENDA,155,"I") ; program
 S ENAM=$$GET1^DIQ(6925,ENDA,7) ; design (a/e) method
 S ENCM=$$GET1^DIQ(6925,ENDA,8) ; construction method
 S ENCAF=$$GET1^DIQ(6925,ENDA,4) ; approved construction funding
 D MSLAP
 Q ENX
 ;
MSLAP ; set pieces of ENX for milestone applicability
 ; also called from ENPRF1
 ; needs ENAM,ENCM,ENCAF,ENPR returns ENX
 N ENI
 S ENX="",$P(ENX,U,22)=""
 I "^MA^MI^"[(U_ENPR_U) F ENI=1,2 S $P(ENX,U,ENI)=1
 I "^MA^MI^MM^NR^"[(U_ENPR_U) S $P(ENX,U,3)=1
 I ENCM'="DESIGN/BUILD",ENAM'="VAMC" F ENI=4,5,6 S $P(ENX,U,ENI)=1
 I "^MA^"[(U_ENPR_U),ENCM'="DESIGN/BUILD" F ENI=7,8 S $P(ENX,U,ENI)=1
 I "^MA^MI^MM^"[(U_ENPR_U),ENCM'="DESIGN/BUILD" F ENI=9,10 S $P(ENX,U,ENI)=1
 I "^MA^MI^MM^NR^SL^"[(U_ENPR_U) D
 . I ENCM'="DESIGN/BUILD" F ENI=11,12 S $P(ENX,U,ENI)=1
 . I ENCAF'<500000 F ENI=13,16 S $P(ENX,U,ENI)=1
 . I ENCAF'<500000 F ENI=14,17 S $P(ENX,U,ENI)=1
 . I ENCM'="STATION LABOR",ENCM'="P&H" F ENI=15,18,19 S $P(ENX,U,ENI)=1
 . F ENI=20,21,22 S $P(ENX,U,ENI)=1
 Q
 ;
MSD(ENDA,ENPRIOR) ; Milestone Dates for Project
 ; Input Variables
 ;   ENDA - ien of project
 ;   ENPRIOR - (optional) flag, true if previous values also desired
 ; Output Variables
 ;   ENMS("%",milestone #) = % complete ("%0" for previous values)
 ;   ENMS("P",milestone #) = planned date ("P0" for previous values)
 ;   ENMS("R",milestone #) = revised date ("R0" for previous values)
 ;   ENMS("A",milestone #) = actual date ("A0" for previous values)
 K ENMS S ENPRIOR=$G(ENPRIOR)
 N ENI,ENP,ENY
 S ENP=""
 S ENY=$G(^ENG("PROJ",ENDA,1))
 S ENMS("%",2)=$P(ENY,U,11)
 S ENMS("%",8)=$P(ENY,U,6)
 S ENMS("%",10)=$P(ENY,U,9)
 S ENMS("%",12)=$P(ENY,U,7)
 S ENMS("%",21)=$P(ENY,U,8)
 S ENY=$G(^ENG("PROJ",ENDA,2)) D N2
 S ENY=$G(^ENG("PROJ",ENDA,3)) D N3
 S ENY=$G(^ENG("PROJ",ENDA,4)) D N4
 S ENY=$G(^ENG("PROJ",ENDA,50)) D N50
 S ENY=$G(^ENG("PROJ",ENDA,51)) D N51
 S ENY=$G(^ENG("PROJ",ENDA,56)) D N56
 ; set n/a milestones blank
 ;S ENY=$$MSL(ENDA) F ENI=1:1:22 I '$P(ENY,U,ENI) D
 ;. S ENMS("P",ENI)="",ENMS("R",ENI)="",ENMS("A",ENI)=""
 ;. I $D(ENMS("%",ENI)) S ENMS("%",ENI)=""
 Q:'ENPRIOR
 S ENP="0"
 S ENY=$G(^ENG("PROJ",ENDA,60))
 S ENMS("%0",2)=$P(ENY,U,21)
 S ENMS("%0",8)=$P(ENY,U,16)
 S ENMS("%0",10)=$P(ENY,U,19)
 S ENMS("%0",12)=$P(ENY,U,17)
 S ENMS("%0",21)=$P(ENY,U,18)
 S ENY=$G(^ENG("PROJ",ENDA,61)) D N2
 S ENY=$G(^ENG("PROJ",ENDA,62)) D N3
 S ENY=$G(^ENG("PROJ",ENDA,63)) D N4
 S ENY=$G(^ENG("PROJ",ENDA,66)) D N50
 S ENY=$G(^ENG("PROJ",ENDA,67)) D N51
 S ENY=$G(^ENG("PROJ",ENDA,69)) D N56
 ; set n/a milestones blank
 ;S ENY=$$MSL(ENDA) F ENI=1:1:22 I '$P(ENY,U,ENI) D
 ;. S ENMS("P0",ENI)="",ENMS("R0",ENI)="",ENMS("A0",ENI)=""
 ;. I $D(ENMS("%0",ENI)) S ENMS("%0",ENI)=""
 Q
N2 ;
 F ENI=0:1:1 S ENMS("P"_ENP,7+ENI)=$P(ENY,U,2+ENI)
 F ENI=0:1:1 S ENMS("P"_ENP,11+ENI)=$P(ENY,U,4+ENI)
 F ENI=0:1:0 S ENMS("P"_ENP,15+ENI)=$P(ENY,U,6+ENI)
 F ENI=0:1:3 S ENMS("P"_ENP,18+ENI)=$P(ENY,U,7+ENI)
 Q
N3 ;
 F ENI=0:1:1 S ENMS("R"_ENP,7+ENI)=$P(ENY,U,1+ENI)
 F ENI=0:1:1 S ENMS("R"_ENP,11+ENI)=$P(ENY,U,3+ENI)
 F ENI=0:1:0 S ENMS("R"_ENP,15+ENI)=$P(ENY,U,5+ENI)
 F ENI=0:1:3 S ENMS("R"_ENP,18+ENI)=$P(ENY,U,6+ENI)
 Q
N4 ;
 F ENI=0:1:5 S ENMS("A"_ENP,3+ENI)=$P(ENY,U,1+ENI)
 F ENI=0:1:1 S ENMS("A"_ENP,11+ENI)=$P(ENY,U,7+ENI)
 F ENI=0:1:0 S ENMS("A"_ENP,15+ENI)=$P(ENY,U,9+ENI)
 F ENI=0:1:3 S ENMS("A"_ENP,18+ENI)=$P(ENY,U,10+ENI)
 F ENI=0:1:1 S ENMS("A"_ENP,9+ENI)=$P(ENY,U,14+ENI)
 Q
N50 ;
 F ENI=0:1:1 S ENMS("P"_ENP,9+ENI)=$P(ENY,U,2+ENI)
 F ENI=0:1:0 S ENMS("P"_ENP,22+ENI)=$P(ENY,U,4+ENI)
 F ENI=0:1:2 S ENMS("R"_ENP,1+ENI)=$P(ENY,U,5+ENI)
 F ENI=0:1:5 S ENMS("P"_ENP,1+ENI)=$P(ENY,U,8+ENI)
 F ENI=0:1:2 S ENMS("R"_ENP,4+ENI)=$P(ENY,U,14+ENI)
 F ENI=0:1:1 S ENMS("R"_ENP,9+ENI)=$P(ENY,U,17+ENI)
 F ENI=0:1:0 S ENMS("R"_ENP,22+ENI)=$P(ENY,U,19+ENI)
 Q
N51 ;
 F ENI=0:1:1 S ENMS("A"_ENP,1+ENI)=$P(ENY,U,1+ENI)
 F ENI=0:1:0 S ENMS("A"_ENP,22+ENI)=$P(ENY,U,3+ENI)
 Q
N56 ;
 F ENI=0:1:1 S ENMS("P"_ENP,13+ENI)=$P(ENY,U,ENI*3+1)
 F ENI=0:1:1 S ENMS("P"_ENP,16+ENI)=$P(ENY,U,ENI*3+7)
 F ENI=0:1:1 S ENMS("R"_ENP,13+ENI)=$P(ENY,U,ENI*3+2)
 F ENI=0:1:1 S ENMS("R"_ENP,16+ENI)=$P(ENY,U,ENI*3+8)
 F ENI=0:1:1 S ENMS("A"_ENP,13+ENI)=$P(ENY,U,ENI*3+3)
 F ENI=0:1:1 S ENMS("A"_ENP,16+ENI)=$P(ENY,U,ENI*3+9)
 Q
MS(ENI) ; Milestone Name Extrinsic Function
 ; Input ENI - index number for milestone (1-22)
 ; Returns name of milestone
 N ENX
 S ENX=""
 S:ENI ENX=$P($P($T(MSDATA+ENI),";;",2),U)
 Q ENX
MSFP(ENI) ; Milestone Planned Field Number Extrinsic Function
 ; Input ENI - index number for milestone (1-22)
 ; Returns field number of milestone (planned)
 N ENX
 S ENX=""
 S:ENI ENX=$P($P($T(MSDATA+ENI),";;",2),U,2)
 Q ENX
 ;
MSFR(ENI) ; Milestone Field Number Extrinsic Function
 ; Input ENI - index number for milestone (1-22)
 ; Returns field number of milestone (revised)
 N ENX
 S ENX=""
 S:ENI ENX=$P($P($T(MSDATA+ENI),";;",2),U,3)
 Q ENX
 ;
MSFA(ENI) ; Milestone Field Number Extrinsic Function
 ; Input ENI - index number for milestone (1-22)
 ; Returns field number of milestone (actual)
 N ENX
 S ENX=""
 S:ENI ENX=$P($P($T(MSDATA+ENI),";;",2),U,4)
 Q ENX
 ;
MSDATA ;;
1 ;;Design Program Start^20^34^49
2 ;;Design Program Compl^20.1^34.1^49.1
3 ;;Authorized^^^50
4 ;;Advertise for A/E^20.3^34.3^51
5 ;;Select A/E^20.4^34.4^52
6 ;;A/E Award^20.5^34.5^53
7 ;;Start Schematics^21^35^54
8 ;;Complete Schematics^22^36^55
9 ;;Start Design Dev.^22.5^36.1^55.5
10 ;;Compl. Design Dev.^22.6^36.2^55.6
11 ;;Start/Award CD^23^37^56
12 ;;Complete CD^24^38^57
13 ;;Start L/T Review^24.4^38.4^57.4
14 ;;Start Audit Review^24.6^38.6^57.6
15 ;;Issue IFB/SBA^25^39^58
16 ;;Compl. L/T Review^25.4^39.4^58.4
17 ;;Compl. Audit Review^25.6^39.6^58.6
18 ;;Bid Open/Negotiation^26^40^59
19 ;;Construction Award^27^41^60
20 ;;Construction Start^28^42^61
21 ;;Const. Complete^29^43^62
22 ;;Activation^30^44^63
 ;ENPRUTL
