SRHLUO4 ;B'HAM ISC\DLR - Surgery Interface (Cont.) Utilities for building Outgoing HL7 Segments ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
OBR(SRI,CASE,SRENT) ;Observation
 ;variables
 ; OBR(obr) & OBX(obr,x) = temp array for processing segments
 ; CNT(IEN) - eliminates redundant processing in file 133.2
 ; SRHL - local array built by GETS^DIQ() call
 ;
 ;process all OBR and underlying OBX segments
MAIN N CNT,FIELD,FILE,FLAGS,IEN,SEQ,SRST,SRX,SRY,SRY1,SROBR,TAR,TMPOBR
 S (SROBR,SRX)=0 F  S SRX=$O(^SRO(133.2,SRX)) Q:'SRX  I $D(^SRO(133.2,SRX,2,0)) K OBR,OBX,NTE,TMPOBR I $$CHECK^SRHLUO4C(SRX) D POBR,POBX D MSG^SRHLUO4C(.OBR,.OBX,.NTE)
EXIT ;
 K DIQ,DA,DR,OBR,OBX,NTE
 Q
POBR ;sets up the DIQ
 K SRHL,HDR,SR
 ;setup the variables for the GETS^DIQ() call
 S TAR="SRHL",FLAGS="IEN",IENS=CASE_",",SRST=""
 ;check multiple entries to process using the GETS call
 I $D(^SRO(133.2,SRX,1,0)) D INIT(SRX) I FIELD'="" S FIELD=FIELD_"*" D GETS^DIQ(FILE,IENS,FIELD,FLAGS,TAR)
 ;OBR-4 text identifier
 S (TMPOBR,HDR)="OBR"_HL("FS")_HL("FS")_HL("FS")_CASE_HL("FS")_$P(^SRO(133.2,SRX,0),U,10)_HLCOMP_$P(^(0),U)_HLCOMP_$P(^(0),U,11)
 ;process all subordinate sequences (1 node)
 S SRY=0 F  S SRY=$O(^SRO(133.2,SRX,1,SRY)) Q:'SRY  D:$$CHECK^SRHLUO4C(SRY)
 .D INIT(SRY)
 .;GETS file 130 fields or multiples if file 133.2 has 1 node
 .I FILE=130 S FIELDS=FIELD_$S($D(^SRO(133.2,SRY,1,0)):"*",1:"") D GETS^DIQ(FILE,IENS,FIELDS,FLAGS,TAR)
 .;process fields that are not multiples and do not have subordinate sequences
 .I '$D(^SRO(133.2,SRY,1,0)) S SRST="" F  S SRST=$O(SRHL(FILE,SRST)) Q:SRST=""  D:$D(SRHL(FILE,SRST,FIELD,$S($P(^SRO(133.2,SRY,0),U,6)="TS":"I",$P(^(0),U,6)="CN":"I",1:"E")))
 ..S:'$D(OBR(SRST)) OBR(SRST)=HDR S $P(OBR(SRST),HL("FS"),SEQ)=$S($P(OBR(SRST),HL("FS"),SEQ)="":"",1:$P(OBR(SRST),HL("FS"),SEQ)_HLCOMP)_$$VALUE^SRHLUO4C(SRY,FILE,SRST,FIELD)
 .;process all multiples and subordinate sequences
 .I $D(^SRO(133.2,SRY,1,0)) S SRY1=$O(^SRO(133.2,SRY,1,0)) I $$CHECK^SRHLUO4C(SRY1) S SRST="" F  S SRST=$O(SRHL($P(^SRO(133.2,SRY1,0),U,2),SRST)) Q:SRST=""  D
 ..D INIT(SRY1) Q:'$D(SRHL(FILE,SRST,FIELD,$S($P(^SRO(133.2,SRY1,0),U,6)="TS":"I",$P(^(0),U,6)="CN":"I",1:"E")))
 ..S FLD=$P(SRST,",",2,4),SEQ=$P($P(^SRO(133.2,SRY1,0),U,8),"-")+1
 ..;process level 3 multiples: move lower level 2 info up to level 3 and level 2 info for other multiples at level 3
 ..I $D(OBR(FLD))!$D(SR(FLD)) S OBR(SRST)=$S($D(OBR(FLD)):OBR(FLD),1:SR(FLD)) I $D(OBR(FLD)) S SR(FLD)=OBR(FLD) K OBR(FLD)
 ..S $P(OBR(SRST),HL("FS"),SEQ)=$$VALUE^SRHLUO4C(SRY1,FILE,SRST,FIELD)
 .K SR
 Q
POBX ;process the underlying OBX & NTE segments
 S (SRY,OBX)=0 F  S SRY=$O(^SRO(133.2,SRX,2,SRY)) Q:'SRY  D:$$CHECK^SRHLUO4C(SRY)
 .D INIT(SRY) I FILE=130 S:$D(^SRO(133.2,SRY,1,0)) FIELD=FIELD_"*" D GETS^DIQ(FILE,IENS,FIELD,FLAGS,TAR)
 .I $P(^SRO(133.2,SRY,0),U,5)="NTE" D  Q
 ..S SRST="",SRZ=0 F  S SRST=$O(SRHL(FILE,SRST)) Q:SRST=""  S FLD=$S('$D(OBR(SRST)):$P(SRST,",",2,4),1:SRST) F  S SRZ=$O(SRHL(FILE,SRST,FIELD,SRZ)) Q:'SRZ  S NTE(FLD,SRZ)="NTE"_HL("FS")_SRZ_HL("FS")_"P"_HL("FS")_SRHL(FILE,SRST,FIELD,SRZ)
 .S HDR="OBX"_HL("FS")_HL("FS")_$P(^SRO(133.2,SRY,0),U,6)_HL("FS")_$P(^(0),U,10)_HLCOMP_$P(^(0),U)_HLCOMP_$P(^(0),U,11),OBX=OBX+1
 .;process non-multiple entries with or without 1 nodes
 .S SRST="" F  S SRST=$O(SRHL(FILE,SRST)) Q:SRST=""  S VALUE=$$VALUE^SRHLUO4C(SRY,FILE,SRST,FIELD) I VALUE'="" D
 ..S OBX(SRST,OBX)=HDR,SEQ=$P($P(^SRO(133.2,SRY,0),U,8),"-")+1,$P(OBX(SRST,OBX),HL("FS"),SEQ)=$S($P(OBX(SRST,OBX),HL("FS"),SEQ)="":"",1:$P(OBX(SRST,OBX),HL("FS"),SEQ)_HLCOMP)_VALUE
 ..S:$P(^SRO(133.2,SRY,0),U,12)'="" $P(OBX(SRST,OBX),HL("FS"),7)=$P(^(0),U,12)
 ..I '$D(OBR(SRST)) S OBR(SRST)=TMPOBR
 ..;process the subordinate sequences
 ..S SRY1=0,CNT(SRY)=1 F  S SRY1=$O(^SRO(133.2,SRY,1,SRY1)) Q:'SRY1  S CNT(SRY1)=1 D INIT(SRY1) S FLD=$S('$D(OBR(SRST)):$P(SRST,",",2,4),1:SRST),$P(OBX(FLD,OBX),HL("FS"),SEQ)=$$VALUE^SRHLUO4C(SRY1,FILE,SRST,FIELD)
 ..;reset FILE for the SRHL array loop
 ..D INIT(SRY)
 .;process all multiple entries
 .I $D(^SRO(133.2,SRY,1,0)) S SRY1=$O(^SRO(133.2,SRY,1,0)) I SRY1>0 D INIT(SRY1) S SRST="" F  S SRST=$O(SRHL(FILE,SRST)) Q:SRST=""  D
 ..;process all of the subordinate sequences (all 1 nodes)
 ..S OBX=OBX+1,SRY1=0 F  S SRY1=$O(^SRO(133.2,SRY,1,SRY1)) Q:'SRY1  D INIT(SRY1) S FLD=$S('$D(OBR(SRST)):$P(SRST,",",2,4),1:SRST),VALUE=$$VALUE^SRHLUO4C(SRY1,FILE,SRST,FIELD) D:VALUE'=""
 ...S:SEQ=4 OBX(FLD,OBX)=HDR_HLCOMP_VALUE,$P(OBX(FLD,OBX),HL("FS"),7)=$P(^SRO(133.2,SRY1,0),U,12) S:SEQ'=4 $P(OBX(FLD,OBX),HL("FS"),SEQ)=VALUE
 ...;S:SEQ=4 OBX(SRST,OBX)=HDR_HLCOMP_VALUE S:SEQ'=4 $P(OBX(FLD,OBX),HL("FS"),SEQ)=VALUE
 Q
INIT(IEN) ;initialize FILE FIELD and SEQ
 S FILE=$P(^SRO(133.2,IEN,0),U,2),FIELD=$P(^(0),U,3),SEQ=$P($P(^(0),U,8),"-")+1
 Q
