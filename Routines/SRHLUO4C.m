SRHLUO4C ;B'HAM ISC\DLR - Surgery Interface (Cont.) Utility for SRHLUO4 ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
CHECK(FLD) ;uses file 133.2 IEN to check INTERFACE field is set to send or
 N VALUE,ID
 S VALUE=0
 I FLD="" Q VALUE
 ;check to see if this field has already been processed
 I $D(CNT(FLD)) Q VALUE
 S CNT(FLD)=1
 I '$D(^SRO(133.2,FLD,0)) Q VALUE
 I '$D(^SRF(CASE,"NON")) S ID=$O(^SRO(133.2,"AC","PROCEDURE",0)) I ID=FLD S VALUE=0 Q VALUE
 I $D(^SRF(CASE,"NON")) S ID=$O(^SRO(133.2,"AC","OPERATION",0)) I ID=FLD S VALUE=1 Q VALUE
 I $P(^SRO(133.2,FLD,0),U,4)["S" S VALUE=1
 Q VALUE
VALUE(IEN,FILE,SRST,FIELD) ;uses file 133.2 IEN to get the value from SRHL, create by GETS^DIQ(), and return it in an HL7 format. (ONLY OBR and OBX segments)
 N VALUE
 Q:'$D(SRHL(FILE,SRST,FIELD,$S($P(^SRO(133.2,IEN,0),U,6)="TS":"I",$P(^(0),U,6)="CN":"I",1:"E"))) ""
 S VALUE=SRHL(FILE,SRST,FIELD,$S($P(^SRO(133.2,IEN,0),U,6)="TS":"I",$P(^(0),U,6)="CN":"I",1:"E"))
 I $P(^SRO(133.2,IEN,0),U,6)="CE" S VALUE=$P(^(0),U,10)_HLCOMP_VALUE_HLCOMP_$P(^(0),U,11)
 I $P(^SRO(133.2,IEN,0),U,6)="CN" S VALUE=$$HNAME^SRHLU(VALUE)
 I $P(^SRO(133.2,IEN,0),U,6)="TS" S VALUE=$$HLDATE^HLFNC(VALUE)
 K SRHL(FILE,SRST,FIELD)
 Q VALUE
MSG(OBR,OBX,NTE) ;create ^TMP(SRENT global by processing OBR and underlying OBX segments
 N SRX,SRY
 S SRX=0 F  S SRX=$O(OBR(SRX)) Q:'SRX  I $P($P(OBR(SRX),HL("FS"),5),HLCOMP,5)'=""!$D(OBX(SRX))!$P(OBR(SRX),HL("FS"),8)'=""!$P(OBR(SRX),HL("FS"),9)'="" S SROBR=SROBR+1,SRI=SRI+1,$P(OBR(SRX),HL("FS"),2)=SROBR D
 .S ^TMP(SRENT,$J,SRI)=OBR(SRX)
 .I $D(NTE(SRX)) S SRY=0 F  S SRY=$O(NTE(SRX,SRY)) Q:'SRY  S SRI=SRI+1,^TMP(SRENT,$J,SRI)=NTE(SRX,SRY)
 .S (OBX,SRY)=0 F  S SRY=$O(OBX(SRX,SRY)) Q:'SRY  S OBX=OBX+1,SRI=SRI+1,$P(OBX(SRX,SRY),HL("FS"),2)=OBX,$P(OBX(SRX,SRY),HL("FS"),12)="F",^TMP(SRENT,$J,SRI)=OBX(SRX,SRY)
 Q
MSGV(OBR,OBX,NTE)  ;create ^TMP("HLS" global by processing OBR and underlying OBX segments
 N SRX,SRY
 S SRX=0 F  S SRX=$O(OBR(SRX)) Q:'SRX  I $P($P(OBR(SRX),HLFS,5),HLCOMP,5)'=""!$D(OBX(SRX))!$P(OBR(SRX),HLFS,8)'=""!$P(OBR(SRX),HLFS,9)'="" S SROBR=SROBR+1,SRI=SRI+1,$P(OBR(SRX),HLFS,2)=SROBR D
 .S ^TMP("HLS",$J,HLSDT,SRI)=OBR(SRX)
 .I $D(NTE(SRX)) S SRY=0 F  S SRY=$O(NTE(SRX,SRY)) Q:'SRY  S SRI=SRI+1,^TMP("HLS",$J,HLSDT,SRI)=NTE(SRX,SRY)
 .S (OBX,SRY)=0 F  S SRY=$O(OBX(SRX,SRY)) Q:'SRY  S OBX=OBX+1,SRI=SRI+1,$P(OBX(SRX,SRY),HLFS,2)=OBX,$P(OBX(SRX,SRY),HLFS,12)="F",^TMP("HLS",$J,HLSDT,SRI)=OBX(SRX,SRY)
 Q
