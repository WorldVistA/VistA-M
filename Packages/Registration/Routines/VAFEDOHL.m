VAFEDOHL ;ALB/JLU/CAW;generates the HL7 message to be sent;6/29/93
 ;;5.3;Registration;**38**;Aug 13, 1993
EN DO
 .D DATE
 .I '$$CHK(VAFEDDT) Q
 .D HL
 .I $D(HLERR) Q
 .D SETUP
 D EXOHL^VAFEDUTL
 Q
 ;
DATE ;this subroutine gets the date to start from.
 S %DT="",X="T-1"
 D ^%DT
 S:'$D(VAFEDDT) VAFEDDT=Y_.9
 K Y,X
 Q
 ;
CHK(VAFEDDT) ;this subroutine checks for the existance of data in the 391.51
 ;file.
 N X
 S X=$O(^VAT(391.51,"ABDC",0))
 DO
 .I 'X S X=0 Q
 .I X>VAFEDDT S X=0 Q
 .S X=1 Q
 Q X
 ;
HL ;this subroutine sets up HL7 variables.
 ;init of hltrans may return an error HLERR
 S HLEVN=0
 S HLNDAP="EDR-MAS"
 D NOW^%DTC
 S HLSDT=%
 S HLMTN="ORU"
 K ^TMP("HLS",$J),%H,%I,%
 D INIT^HLTRANS
 Q
 ;
SETUP ;starts the looping to get the info from the 391.51 file.
 S VAFEDLCT=0
 N VAFEDLP,X1,DFN,VAFEDD,VAFEDT
 F VAFEDLP=0:0 S VAFEDLP=$O(^VAT(391.51,"ABDC",VAFEDLP)) Q:'VAFEDLP!(VAFEDLP>VAFEDDT)  F DFN=0:0 S DFN=$O(^VAT(391.51,"ABDC",VAFEDLP,DFN)) Q:'DFN  D SET
 Q
 ;
SET ;second layer of the loop.
 K VA,VADM,VAPA,VAERR
 D DEM^VADPT,ADD^VADPT
 I VADM(1)]"" DO
 .I 'HLEVN DO
 ..I '$D(HLDA) D FILE^HLTF
 ..S ^TMP("HLS",$J,HLSDT,0)=$$BHS^HLFNC1(HLMTN)
 .F VAFEDD=0:0 S VAFEDD=$O(^VAT(391.51,"ABDC",VAFEDLP,DFN,VAFEDD)) Q:'VAFEDD  F VAFEDT=98,99 S VAFEDDA=$O(^VAT(391.51,"ABDC",VAFEDLP,DFN,VAFEDD,VAFEDT,0)) D:VAFEDDA BUILD I HLEVN>99 D SEND DO
 ..I '$D(HLDA) D FILE^HLTF
 ..S ^TMP("HLS",$J,HLSDT,0)=$$BHS^HLFNC1(HLMTN)
 Q
 ;
BUILD ;this subroutine builds the HL7 messages segments
 S VAFEDST1=$G(^VAT(391.51,VAFEDDA,100)) I VAFEDDA]"" S VAFEDST2=$G(^VAT(391.51,VAFEDDA,200)),VAFELIG=$P($G(^VAT(391.51,VAFEDDA,0)),U,7) D:$G(^(150,1,0)) DSTR DO
 .S HLEVN=HLEVN+1
 .D MSH^VAFEOHL1
 .D PID^VAFEOHL1
 .D ZEL^VAFEOHL1
 .D PV1^VAFEOHL1
 .D ORC^VAFEOHL2
 .D OBR^VAFEOHL2
 .D OBX^VAFEOHL2
 .S $P(^VAT(391.51,VAFEDDA,0),"^",5)=HLDA
 Q
 ;
LOG ;sets the HL7 string into the TMP global
 S ^TMP("HLS",$J,HLSDT,VAFEDLCT)=VAFEDHL
 Q
 ;
SEND ;sends the HL7 message
 S VAFEDLCT=VAFEDLCT+1
 S VAFEDHL="BTS"_HLFS_HLEVN
 D LOG
 D EN1^HLTRANS
 D DELETE
 S (VAFEDLCT,HLEVN)=0
 Q
 ;
DELETE ;deletes entries that were sent.
 N LP,Y
 F LP=0:0 S LP=$O(^VAT(391.51,LP)) Q:'LP  S Y=$G(^(LP,0)) I $P(Y,U,5) DO
 .I '$D(HLERR) S DA=LP,DIK="^VAT(391.51," D ^DIK K DA,DIK Q
 .I $D(HLERR) S $P(^VAT(391.51,LP,0),U,5)=""
 K ^TMP("HLS",$J),HLDA,HLERR
 Q
 ;
DSTR ;builds diagnosis string
 N I
 S I=0
 F  S I=$O(^VAT(391.51,VAFEDDA,150,I)) Q:'I  S VAFEDDX(I)=^(I,0)
 Q
