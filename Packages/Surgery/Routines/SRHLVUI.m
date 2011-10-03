SRHLVUI ;B'ham ISC/DLR - Surgery Interface Utility to process incoming segments ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;;This routine utilizes the Surgery Interface file (133.2).
OBR(IEN,OBR) ;process Observation Request Segment (OBR) fields 3-4,7-8,27
 ;variables set in the calling routine SRHLORU
 ; IEN  - The Observation ID's internal entry number in file 133.2
 ; OBR  - (parameter) HL7 incoming segment
 ;
 N LVL,VALUE
 I $G(IEN)="" D
 .S ID=$P($P(OBR,HLFS,5),HLCOMP,2) I $G(ID)="" S HLERR="Missing OBR identifier" Q
 .S IEN=$O(^SRO(133.2,"AC",ID,0)) I $G(IEN)="" D SET^SRHLVORU("Invalid OBR identifier",OBR,"",.SRHLX) Q
 ;Process all Surgery field(s) associated with this Observation ID entry
 ;  a DR string is set for every field in the message that is associated
 ;  with a surgery field (1 node multiple holds associated fields)
 I $$CHECK(IEN)'=1 S QOBR=1 Q
START I $P(^SRO(133.2,IEN,0),U,3)!($D(^(1,0))) D
 .I $P(^SRO(133.2,IEN,0),U,3)&('$D(^(1,0))) S LVL=$P(^SRO(133.2,IEN,0),U,9),VALUE=$$VALUE(IEN) Q:$$CHKV(IEN,VALUE)="^"  D DR(LVL,IEN)
 .;sets the DR string level (DR and DR(2,...)) for the standard DIE call
 .I $D(^SRO(133.2,IEN,1,0)) S SRX=0 F  S SRX=$O(^SRO(133.2,IEN,1,SRX)) Q:'SRX!($D(HLERR))!$G(QOBR)=1  S LVL=$P(^SRO(133.2,SRX,0),U,9) Q:"123"[$G(LVL)&($G(LVL)="")  D
 ..I $D(^SRO(133.2,SRX,1,0)) S SRIEN=SRX ; SRIEN is for DR(3 string sets
 ..I $$CHECK(SRX)=1&('$D(^SRO(133.2,SRX,1,0))) I $$CHKV(SRX,$$VALUE(SRX))'="^" D DR(LVL,SRX) D:$P(^SRO(133.2,SRX,0),U,3)=.01
 ...S LVL=$P(^SRO(133.2,$S($D(SRIEN):SRIEN,1:IEN),0),U,9) D DR(LVL,$S($D(SRIEN):SRIEN,1:IEN)) I $D(SRIEN) K SRIEN
 Q
ERR(MSG,IEN) ;setup the error message for the acknowledgement message
 S:'$D(HLERR) HLERR="Invalid "_ID_" information." S SRERR(1)=$P(MSG,HLFS),SRERR(2)=$P(MSG,HLFS,2)
 Q
CHECK(IEN) ;check universal id or observation id sequence to the Surgery Interface file
 I $G(IEN)="" Q 0
 Q $P($G(^SRO(133.2,IEN,0)),U,4)["R"
VALUE(XX) ;SET the value of the identified segment field in file 133.2
 I XX="" Q ""
 N VALUE
 ;set VALUE = identifiers field #6 Message and #7 HL7 sequence in file 133.2, ex.  S VALUE=$P($P(OBX,HLFS,5),HLCOMP,1)
 S:$P(^SRO(133.2,XX,0),U,6)'="CN" VALUE=$P($P(@$P(^SRO(133.2,XX,0),U,5),HLFS,$P($P(^(0),U,8),"-")+1),HLCOMP,$P($P(^(0),U,8),"-",2))
 S:$P(^SRO(133.2,XX,0),U,6)="CN" VALUE=$P(@$P(^SRO(133.2,XX,0),U,5),HLFS,$P($P(^(0),U,8),"-")+1)
 S:VALUE'="" VALUE=$S($P(^(0),U,6)="TS":$$FMDATE^HLFNC(VALUE),$P(^(0),U,6)="CE":VALUE,$P(^(0),U,6)="TX":VALUE,$P(^(0),U,6)="FT":VALUE,$P(^(0),U,6)="NM":+VALUE,1:VALUE)
 I $P(^SRO(133.2,XX,0),U,6)="CN" S VALUE=$$DNAME^SRHLVU(VALUE),VALUE=$S(VALUE="":"",1:VALUE)
 ;if field #14, Always create new entry, is set then add "" for DIE stuff
 I $P(^SRO(133.2,XX,0),U,13)=1 S VALUE=""""_VALUE_""""
 Q VALUE
DR(LVL,IEN) ;set DR or DR(... string for the FileMan DIE call
 Q:$G(LVL)=""!$G(IEN)=""
 N VALUE,FLAG,RESULT,FILE,FIELD,TYPE
 S VALUE=$$VALUE(IEN),TYPE=$P(^SRO(133.2,IEN,0),U,6)
 I LVL=1 S DR=$G(DR)_$S($G(DR)'="":";",1:"")_$P(^SRO(133.2,IEN,0),U,3)_$S(TYPE="TS":"////",1:"///")_VALUE
 I LVL'=1 D
 .S DR(LVL,$P(^SRO(133.2,IEN,0),U,2))=$G(DR(LVL,$P(^SRO(133.2,IEN,0),U,2)))_$S($D(DR(LVL,$P(^SRO(133.2,IEN,0),U,2))):";",1:"")_$P(^SRO(133.2,IEN,0),U,3)_$S(TYPE="TS":"////",1:"///")_VALUE
 Q
CHKV(IEN,VALUE) ;check for invalid field values
 N TEXT
 I (VALUE="")!(IEN="") Q ""
 ;added to by-pass time stamp fields input transforms
 I $P(^SRO(133.2,IEN,0),U,6)="TS" Q VALUE_"^"
 N D0,CVALUE,FILE,FIELD,FLAG,RESULT
 S FILE=$P(^SRO(133.2,IEN,0),U,2),FIELD=$P(^(0),U,3),FLAG="E",CVALUE=$TR(VALUE,"""",""),RESULT=""
 S D0=$P(OBR,HLFS,4) ; set for input transformer purposes
 D CHK^DIE(FILE,FIELD,FLAG,CVALUE,.RESULT) I RESULT="^" S TEXT="Invalid value, "_VALUE_$S($P(^SRO(133.2,IEN,0),U,11)'="":" for File #"_$P($P(^SRO(133.2,IEN,0),U,11),"99VA",2),1:"") D SET^SRHLVORU(TEXT,OBR,$G(OBX),.SRHLX)
 ;if a multilple value is invalid kill DR and to stop processing this OBR
 I RESULT="^",$P(^SRO(133.2,IEN,0),U,5)="OBR",FIELD=.01 K DR S QOBR=1
 Q $S($D(RESULT(0)):RESULT(0),1:RESULT)
