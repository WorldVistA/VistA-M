SRHLUI ;B'ham ISC/DLR - Surgery Interface Utility to process incoming segments ; [ 02/06/01  9:53 PM ]
 ;;3.0; Surgery ;**41,100**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;;This routine utilizes the Surgery Interface file (133.2).
OBR(CASE,DFN,IEN,MSG) ;process Observation Request Segment (OBR) fields 3-4,7-8,27
 ;variables set in the calling routine SRHLORU
 ; CASE - IEN of the case # in Surgery Case file (#130)
 ; DFN  - IEN of the patient
 ; IEN  - The Observation ID's internal entry number in file 133.2
 ; MSG  - (parameter) HL7 incoming segment
 ;
 K DA,DR,DIE
 N LVL,OBR,SRNOCON,SRX
 Q:$G(MSG)="" ""
 ;set the surgery no concurrent case flag 
 S SRNOCON=1
 S OBR=MSG,DA=CASE,DIE=$P(^SRO(133.2,IEN,0),U,2) K DR,DO
 ;if there is a VISTA Surgery field(s) associated with this entry process the DR strings
 I $P(^SRO(133.2,IEN,0),U,3)!($D(^(1,0))) D
 .S:$P(^SRO(133.2,IEN,0),U,3) DR=$P(^(0),U,3)_"///^S X="_$$VALUE(IEN) D:$D(^SRO(133.2,IEN,1,0))
 ..;sets the DR string level (DR and DR(2,...)) for the standard DIE call
 ..S SRX=0 F  S SRX=$O(^SRO(133.2,IEN,1,SRX)) Q:'SRX  S LVL=$P(^SRO(133.2,SRX,0),U,9) Q:"12"[$G(LVL)&($G(LVL)="")  I $$VALUE(SRX)'="" D:$$CHECK(SRX) DR(LVL,SRX)
 .I $D(DR) N SRESQ D
 ..D ^SROESHL Q:SRESQ
 ..D DRCHK D ^DIE K DIE,DA,DR,DO I $D(Y) S SRDISC="Unknown OBR identifier ("_$G(ID)_")." D SETDSC^SRHLU(.HL,SRDISC,.SRHL)
 Q OBR
CHECK(IEN) ;check universal id or observation id sequence to the Surgery Interface file
 I $G(IEN)="" Q 0
 Q $P($G(^SRO(133.2,IEN,0)),U,4)["R"
VALUE(XX) ;SET the value of the identified segment field in file 133.2
 S ^TMP("SR7",XX)=^SRO(133.2,XX,0)
 N VALUE
 ;set the value of the identifiers based on the sequences identified in file 133.2
 S:$P(^SRO(133.2,XX,0),U,6)'="CN" VALUE=$P($P(@$P(^SRO(133.2,XX,0),U,5),HL("FS"),$P($P(^(0),U,8),"-")+1),HLCOMP,$P($P(^(0),U,8),"-",2))
 S:$P(^SRO(133.2,XX,0),U,6)="CN" VALUE=$P(@$P(^SRO(133.2,XX,0),U,5),HL("FS"),$P($P(^(0),U,8),"-")+1)
 S:VALUE'="" VALUE=$S($P(^SRO(133.2,XX,0),U,6)="TS":$$FMDATE^HLFNC(VALUE),$P(^(0),U,6)="CE":""""_VALUE_"""",$P(^(0),U,6)="TX":""""_VALUE_"""",$P(^(0),U,6)="FT":""""_VALUE_"""",$P(^(0),U,6)="NM":+VALUE,1:VALUE)
 I $P(^SRO(133.2,XX,0),U,6)="CN" S VALUE=$$DNAME^SRHLU(VALUE),VALUE=$S(VALUE="":"",1:""""_VALUE_"""")
 Q VALUE
DR(LVL,IEN) ;set DR or DR(... string for the FileMan DIE call
 Q:$G(LVL)=""!$G(IEN)=""
 ;set DR string but do not four slash stuff Time Stamped values for multiples
 I LVL=1 S VALUE=$$VALUE(IEN) S:VALUE'="" DR=$G(DR)_$S($D(DR):";",1:"")_$P(^SRO(133.2,IEN,0),U,3)_$S($P(^(0),U,6)="TS"&($P(^(0),U,3)'=".01")&('$D(^(1,0))):"/",1:"")_"///"_VALUE
 ;set DR string but do not four slash stuff Time Stamped values for multiples
 I LVL'=1 S VALUE=$$VALUE(IEN) S:VALUE'="" DR(LVL,$P(^SRO(133.2,IEN,0),U,2))=$G(DR(LVL,$P(^(0),U,2)))_$S($D(DR(LVL,$P(^(0),U,2))):";",1:"")_$P(^(0),U,3)_$S($P(^(0),U,6)="TS"&($P(^(0),U,3)'=".01")&('$D(^(1,0))):"/",1:"")_"///"_VALUE
 Q
NTE(MSG,OBR,CASE) ;process Observation Segment (OBX) fields 3,5,14,16 and NTE-3
 ;anesthesia comments
 Q:MSG=""
 N ID
 S ID=$P($P(OBR,HL("FS"),5),HLCOMP,2) I $G(ID)="" S SRDISC="Unknown OBR identifier ("_$G(ID)_")." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 S IEN=$O(^SRO(133.2,"AC",ID,0)) I $G(IEN)="" S SRDISC="Unknown OBR identifier ("_$G(ID)_")." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 Q:$$CHECK(IEN)'=1
 I ID="ANESTHESIA" D
 .I $P(MSG,HL("FS"),2)>1,'$D(^SRF(CASE,6,1,7,0)) S SRDISC="Invalid sequence this NTE segment, '"_MSG_"'." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 .S:$P(MSG,HL("FS"),2)=1 ^SRF(CASE,6,1,7,0)="^^0^0^"_DT_"^^^^" S ^SRF(CASE,6,1,7,$P(^SRF(CASE,6,1,7,0),U,3)+1,0)=$P(MSG,HL("FS"),4),$P(^(0),U,3)=$P(^SRF(CASE,6,1,7,0),U,3)+1,$P(^(0),U,4)=$P(^(0),U,4)+1,$P(^(0),U,5)=DT
 Q
OBX(MSG,OBR,CASE) ;process Observation Segment (OBX) fields 3,5,14,16 and NTE-3
 N ID,IEN,NM,OBX,SRESQ,TYPE
 S DA=CASE,OBX=MSG
 S ID=$P($P(OBR,HL("FS"),5),HLCOMP,2) I $G(ID)="" S SRDISC="Unknown OBR identifier ("_$G(ID)_")." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 S IEN=$O(^SRO(133.2,"AC",ID,0)) I $G(IEN)="" S SRDISC="Unknown OBX identifier ("_$G(ID)_")." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 Q:$$CHECK(IEN)'=1
 I $P(^SRO(133.2,IEN,0),U,3) S NM=$$VALUE(IEN) I NM="" S SRDISC="Unknown OBX identifier ("_$G(ID)_")." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 K DIE,DR,DO S DIE=$P(^SRO(133.2,IEN,0),U,2) I DIE="" S SRDISC="Unknown OBX identifier ("_$G(ID)_")." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 I $P(^SRO(133.2,IEN,0),U,3) S DR=$P(^(0),U,3)_"///^S X="_NM D:$D(^SRO(133.2,IEN,1,0))
 .S SRX=0 F  S SRX=$O(^SRO(133.2,IEN,1,SRX)) Q:'SRX  S LVL=$P(^SRO(133.2,SRX,0),U,9) Q:"12"[$G(LVL)&($G(LVL)="")  I $$VALUE(SRX)'="" D DR(LVL,SRX)
 ;set the msg variable to the segment type for the VALUE subroutine
 I $P(MSG,HL("FS"))="OBX" S ID=$P($P(MSG,HL("FS"),4),HLCOMP,2) I $G(ID)="" S SRDISC="Unknown OBX identifier ("_$G(ID)_")." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 S IEN=$O(^SRO(133.2,"AC",ID,0)) I $G(IEN)="" S SRDISC="Unknown OBX identifier ("_$G(ID)_")." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 S NM=$$VALUE(IEN) I NM="" Q
 ;if field is set to receive, then set DR string for DIE call
 I $$CHECK(IEN)=1 S LVL=$P(^SRO(133.2,IEN,0),U,9) D DR(LVL,IEN) D:$D(^SRO(133.2,IEN,1,0))  N SRESQ D ^SROESHL Q:SRESQ  D ^DIE K DIE,DA,DR,DO
 .S SRX=0 F  S SRX=$O(^SRO(133.2,IEN,1,SRX)) Q:'SRX  S LVL=$P(^SRO(133.2,SRX,0),U,9) Q:"12"[$G(LVL)&($G(LVL)="")  I $$VALUE(SRX)'="" D DR(LVL,SRX)
 Q
DRCHK ;CHECK DR STRING (for debugging only)
 ;Check DR string by removing the Quit and adding TMP( global to the loop
 Q
 S SRCNT=+$G(SRCNT)+1 S SRJ="" F  S SRJ=$O(DR(SRJ)) Q:'SRJ  S SRK="" F  S SRK=$O(DR(SRJ,SRK)) Q:'SRK  S SRCNT=SRCNT+1
 Q
