PSOPOST2 ;ISC-Bham/SAB-post routine clear data in new field in 1;9 of file 59 ; 1/20/00
 ;;7.0;OUTPATIENT PHARMACY;**32,46,74**;DEC 1997
 ;External reference to PSSORPH is supported by DBIA 3234
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(50.607 supported by DBIA 2221
 N I F I=0:0 S I=$O(^PS(59,I)) Q:'I  S $P(^PS(59,I,1),"^",9)=""
 Q
EN ;PSO*7*46 checks pre-poe orders for conversion and flags all rxs as poe
 S ZTREQ="@",ZTDTH=$H,ZTRTN="POE^PSOPOST2",ZTIO="",ZTDESC="Flagging All Prescriptions as POE Orders." D ^%ZTLOAD,BMES^XPDUTL("Queuing Background Job to Flag Prescriptions as POE Orders...")
 D BMES^XPDUTL("Attempting to Convert Outpatient Pharmacy Pre-POE Pending Orders...")
 F I=0:0 S I=$O(^PS(52.41,"AOR",I)) Q:'I  F F=0:0 S F=$O(^PS(52.41,"AOR",I,F)) Q:'F  F G=0:0 S G=$O(^PS(52.41,"AOR",I,F,G)) Q:'G  D
 .I $P(^PS(52.41,G,0),"^",3)'="NW",$P(^(0),"^",3)'="RNW",$P(^(0),"^",3)'="RF" K ^PS(52.41,"AOR",I,F,G) Q
 .Q:'$P(^PS(52.41,G,0),"^",9)
 .S IEN=$P(^PS(52.41,G,0),"^",9),RTE=$P(^(0),"^",15)
 .K DOSE D DOSE^PSSORPH(.DOSE,IEN,"O") Q:'$D(DOSE("DD",IEN))
 .S ^PS(52.41,G,"POE")=1,NOUN=$P(DOSE("DD",IEN),"^",9),VERB=$P(DOSE("DD",IEN),"^",10)
 .F E=0:0 S E=$O(^PS(52.41,G,1,E)) Q:'E  S DUPD=$P(^PS(52.41,G,1,E,0),"^"),DUPD=$P(DUPD,"&") D
 ..S:$G(RTE)]"" $P(^PS(52.41,G,1,E,1),"^",8)=RTE S $P(^PS(52.41,G,1,E,1),"^",5)=NOUN,$P(^(1),"^",10)=VERB
 ..I DUPD'?.N&(DUPD'?.N1".".N),$P($G(^PS(52.41,G,1,E,2)),"^")']"" S $P(^PS(52.41,G,1,E,2),"^")=DUPD Q
 ..I DUPD,'$P(DOSE("DD",IEN),"^",5),$P($G(^PS(52.41,G,1,E,2)),"^")']"" D  Q
 ...S $P(^PS(52.41,G,1,E,2),"^")=DUPD_" "_NOUN
 ...S:$P(DOSE("DD",IEN),"^",6)]"" UNITS=$O(^PS(50.607,"B",$P(DOSE("DD",IEN),"^",6),0))
 ...I $G(UNITS) S $P(^PS(52.41,G,1,E,1),"^",9)=UNITS
 ..S:$P($G(^PS(52.41,G,1,E,2)),"^")']"" $P(^PS(52.41,G,1,E,2),"^")=DUPD*$P(DOSE("DD",IEN),"^",5)
 ..S:$P($G(^PS(52.41,G,1,E,2)),"^",2)']"" $P(^PS(52.41,G,1,E,2),"^",2)=DUPD
 ..S:$P(DOSE("DD",IEN),"^",6)]"" UNITS=$O(^PS(50.607,"B",$P(DOSE("DD",IEN),"^",6),0))
 ..I $G(UNITS) S $P(^PS(52.41,G,1,E,1),"^",9)=UNITS
 K DOSE,I,F,G,IEN,RTE,DUPD,UNITS,NOUN,VERB,DD
 Q
POE F RXN=0:0 S RXN=$O(^PSRX(RXN)) Q:'RXN  I $G(^PSRX(RXN,0))]"" S ^PSRX(RXN,"POE")=1
 K RXN
 Q
PSOMIS ;checks for unfinished orders without drugs PSO*7*74
 F I=0:0 S I=$O(^PS(52.41,"AOR",I)) Q:'I  F F=0:0 S F=$O(^PS(52.41,"AOR",I,F)) Q:'F  F G=0:0 S G=$O(^PS(52.41,"AOR",I,F,G)) Q:'G  D
 .Q:$P(^PS(52.41,G,0),"^",9)
 .I $P(^PS(52.41,G,0),"^",3)'="NW",$P(^(0),"^",3)'="RNW",$P(^(0),"^",3)'="RF" K ^PS(52.41,"AOR",I,F,G) Q
 .F E=0:0 S E=$O(^PS(52.41,G,1,E)) Q:'E  S $P(^PS(52.41,G,1,E,1),"^",5)=""
 K G,I,E,F
 Q
