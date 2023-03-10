TIUCCHL7UT ; CCRA/PB - TIUCCRA HSRM Msg Processing; November 3, 2020
 ;;1.0;TEXT INTEGRATION UTILITIES;**337,344**;Nov 3, 2020;Build 11
 ;
 ;PB - Patch 344 to modify how the note and addendum text is formatted
 ;
 Q
 ;
TIUC(X) ; Check each segment of the CCRA TIU notes for HL7 control characters
 Q:$G(X)=""
 I $G(X)[$C(13,10,10) S X=$TR(X,$C(13,10,10),"") ; <cr><lf><lf>
 I $G(X)[$C(13,10) S X=$TR(X,$C(13,10),"") ; <cr><lf>
 I $G(X)[$C(13) S X=$TR(X,$C(13),"") ; TERM char
 I $G(X)[$C(1) S X=$TR(X,$C(1),"") ; SOH
 I $G(X)[$C(2) S X=$TR(X,$C(2),"") ; STX
 I $G(X)[$C(3) S X=$TR(X,$C(3),"") ; ETX
 I $G(X)[$C(4) S X=$TR(X,$C(4),"") ; EOT
 I $G(X)[$C(5) S X=$TR(X,$C(5),"") ; ENQ
 I $G(X)[$C(6) S X=$TR(X,$C(6),"") ; ACK
 I $G(X)[$C(21) S X=$TR(X,$C(21),"") ; NAK
 I $G(X)[$C(23) S X=$TR(X,$C(23),"") ; ETB
 I $G(X)[$C(11) S X=$TR(X,$C(11)," ") ; TAB with space
 I $G(X)[$C(160) S X=$TR(X,$C(160)," ")  ; Inverted question mark formatting from HSRM
 Q X
 ;
ANAK(MSGID,MSGTEXT,CONID) ; Application Error
 N PATNAME,EID,EIDS,MSGN,SITE,CONPAT,CS,FS,RS,ES,SS,RES,ICN  ;Jan 21,2020 - PB - patch 735 new and then set FS,CS,RS,ES,SS
 ;D INIT^HLFNC2("TIU CCRA-HSRM MDM-T02 SERVER",.HL)
 S HL("FS")="|",HL("ECH")="^~\&"
 S CS=$E($G(HL("ECH")),1) S:CS="" CS="^"
 S RS=$E($G(HL("ECH")),2) S:RS="" RS="~"
 S ES=$E($G(HL("ECH")),3) S:ES="" ES="\"
 S SS=$E($G(HL("ECH")),4) S:SS="" SS="&"
 Q:$G(MSGTEXT)=""
 Q:$G(CONID)=""
 S CONPAT=$$GET1^DIQ(123,CONID_",",.02,"I")
 S:$G(CONPAT)>0 PATNAME=$$GET1^DIQ(123,CONID_",",.02,"E")
 S:$G(CONPAT)'>0 PATNAME=$$GET1^DIQ(123,$G(DFN)_",",.02,"E")
 S SITE=$$KSP^XUPARAM("INST")
 S:$G(ICN)="" ICN=$$GET1^DIQ(2,CONPAT_",",991.1,"E")
 I $G(ICN)="" S ICN="NOT IN MSG"
 S EID=$G(HL("EID"))
 S EIDS=$G(HL("EIDS"))
 S MSGN=$G(HL("MID"))
 ;S HLA("HLA",1)="MSA|AE|"_$G(MSGN)_"|"_$G(USERMAIL)_" "_$G(NAKMSG)_"|||"_$G(ICN)_"^"_$G(PATNAME)_"^"_SITE_"^"_CONID_"^"_APTTM
 S HLA("HLA",1)="MSA"_HL("FS")_"AE"_HL("FS")_$G(MSGID)_HL("FS")_$G(TIUEMAIL)_" "_$G(MSGTEXT)_HL("FS")_HL("FS")_HL("FS")_$G(ICN)_"^"_$G(TIU("PTNAME"))_"^"_SITE_"^"_CONID_"^"_$$FMTHL7^XLFDT($$NOW^XLFDT())
 D GENACK^HLMA1(EID,$G(HLMTIENS),EIDS,"LM",1,.RES)
 Q
ERR(TIUSEG,TIUP,TIUNUM,TIUTXT) ;
 S TIU("EC")=TIU("EC")+1
 S @TIUNAME@("MSGERR",TIU("EC"))="ERR"_TIUFS_TIUSEG_TIUFS_TIUP_TIUFS_TIUFS_TIUNUM_TIUCS_TIUTXT
 Q
ACK(MSGID,MSGTEXT,CONID) ; Application Error
 N PATNAME,EID,EIDS,MSGN,SITE,CONPAT,CS,FS,RS,ES,SS,RES,ICN  ;Jan 21,2020 - PB - patch 735 new and then set FS,CS,RS,ES,SS
 ;D INIT^HLFNC2("TIU CCRA-HSRM MDM-T02 SERVER",.HL)
 S HL("FS")="|",HL("ECH")="^~\&"
 S CS=$E($G(HL("ECH")),1) S:CS="" CS="^"
 S RS=$E($G(HL("ECH")),2) S:RS="" RS="~"
 S ES=$E($G(HL("ECH")),3) S:ES="" ES="\"
 S SS=$E($G(HL("ECH")),4) S:SS="" SS="&"
 Q:$G(MSGTEXT)=""
 Q:$G(CONID)=""
 S CONPAT=$$GET1^DIQ(123,CONID_",",.02,"I")
 S:$G(CONPAT)>0 PATNAME=$$GET1^DIQ(123,CONID_",",.02,"E")
 S:$G(CONPAT)'>0 PATNAME=$$GET1^DIQ(123,$G(DFN)_",",.02,"E")
 S SITE=$$KSP^XUPARAM("INST")
 S:$G(ICN)="" ICN=$$GET1^DIQ(2,CONPAT_",",991.1,"E")
 I $G(ICN)="" S ICN="NOT IN MSG"
 S EID=$G(HL("EID"))
 S EIDS=$G(HL("EIDS"))
 S MSGN=$G(HL("MID"))
 ;S HLA("HLA",1)="MSA|AE|"_$G(MSGN)_"|"_$G(USERMAIL)_" "_$G(NAKMSG)_"|||"_$G(ICN)_"^"_$G(PATNAME)_"^"_SITE_"^"_CONID_"^"_APTTM
 S HLA("HLA",1)="MSA"_HL("FS")_"CA"_HL("FS")_$G(MSGID)  ;_HL("FS")_$G(TIUEMAIL)_" "_$G(MSGTEXT)_HL("FS")_HL("FS")_HL("FS")_$G(ICN)_"^"_$G(TIU("PTNAME"))_"^"_SITE_"^"_CONID_"^"_$$FMTHL7^XLFDT($$NOW^XLFDT())
 D GENACK^HLMA1(EID,$G(HLMTIENS),EIDS,"LM",1,.RES)
 Q
TIULKUP(VNUM,TITLE,NOTEDATE,NOTENUM) ; test adding an addendum from HSRM to a TIU note
 ;RTN returns the IEN for the last HSRM COMMUNITY CARE COORDINATION NOTE PLAN TIU document in the consult
 ;VNUM is the consult IEN in file GMRC(123 and is passed in by the calling application
 ;If more than one note with the same title has been filed with the consult, look for the note that was 
 ;created after the NOTEDATE parameter. 
 N TIUIEN,XX,T89251,RTN,CNT,C1,LIST,FILEDATE,Z1
 Q:$G(^GMR(123,VNUM,0))=""
 S RTN=0,CNT=0
 S XX=0 F  S XX=$O(^GMR(123,VNUM,50,XX)) Q:XX'>0  D
 .I $P(^GMR(123,VNUM,50,XX,0),";",2)="TIU(8925," D
 ..K TIUIEN
 ..S TIUIEN=$P(^GMR(123,VNUM,50,XX,0),";",1)
 ..Q:$G(^TIU(8925,TIUIEN,0))=""
 ..S T89251=$P(^TIU(8925,TIUIEN,0),"^",1),FILEDATE=$P($P(^TIU(8925,TIUIEN,12),"^"),".",1)
 ..Q:$G(^TIU(8925.1,T89251,0))=""
 ..S:$P(^TIU(8925.1,T89251,0),"^",1)=TITLE CNT=CNT+1,LIST(CNT)=TIUIEN_"^"_$G(FILEDATE)
 ..S RTN=TIUIEN
 I CNT>1 D
 .Q:$G(NOTENUM)'>0
 .I (+$G(LIST(NOTENUM))>0) S RTN=+$P($G(LIST(NOTENUM)),"^")
 I RTN'>0 D
 .S Z1=0 F  S Z1=$O(LIST(Z1)) Q:Z1'>0  D
 ..I $P(LIST(Z1),"^",2)=NOTEDATE S RTN=Z1
 I $G(RTN)'>0 S RTN=0
 Q RTN
