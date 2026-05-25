IBCE837ACC2A ;EDE/JWS - ACC consume X12 claim data ;
 ;;2.0;INTEGRATED BILLING;**770**;23-MAY-18;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
TOS(XP) ;obtain Type of Service code for each professional claim service line
 N X
 ;S DIC("DR")=DIC("DR")_";9////"_$S($P(XD,"*",4)="MJ":$$FIND1^DIC(353.2,,,7),1:$$FIND1^DIC(353.2,,,1))
 ;"SV1*HC:97012:GP*15*UN*1***3:1:2"
 ; ANESTHESIA : 00100-01999 = 7
 ; SURGERY : 10000-69999 = 2
 ; PATHOLOGY : 88305-88398 = 5
 ; RADIOLOGY : 70000-79999 = 4
 ; CONSULTATIONS : 99241-99245 = 3
 ;
 I +XP>99,+XP<2000 S X=7 G TOS1
 I +XP>9999,+XP<70000 S X=2 G TOS1
 I +XP>69999,+XP<80000 S X=4 G TOS1
 I +XP>88304,+XP<88399 S X=5 G TOS1
 I +XP>99240,+XP<99246 S X=3 G TOS1
 S X=1
TOS1 ;
 Q $$FIND1^DIC(353.2,,"X",X)
 ;
TEETH ;10/15/25;from IBCE837ACC2
 N XTS,I,XDATA,XD,XIEN,X
 S XTS=0 F  S XTS=$O(^TMP("IB837ACC",$J,"DN2",XTS)) Q:XTS=""  S XDATA=^(XTS) D
 . S X=$P(XDATA,"*") I X="" Q
 . K DIC,DA,DINUM,DO,DD,DLAYGO
 . I $P(XDATA,"*",2)'="E",$P(XDATA,"*",2)'="M" Q
 . S DIC="^DGCR(399,"_IBIFN_",""DEN1"",",DIC(0)="L",DA(1)=IBIFN,DLAYGO=399.096,DIC("DR")=".02////"_$P(XDATA,"*",2)
 . D FILE^DICN
 . K DO,DD,DLAYGO,DA,DIC
 Q
 ;
WRAP(STRING,ROOM,SUBS,IBARY) ; wrap long lines without breaking up words
 ;JWS;10/23/25;EBILL-6172;wrap note field
 ;
 ; STRING = data string to wrap
 ; ROOM = number of characters to break at for line 1
 ; SUBS = number of characters to break at for subsequent lines (may or may not be same as ROOM)
 ; IBARY = (required) subscripted array to return wrapped data in:
 ;  array(1)=first line
 ;  array(2)= 2nd line and so on
 ;
 ; Returns total # of lines in description
 ;
 N START,END,I,C,STOP
 ; if there is enough room for 1 line, no wrapping needed
 I $L(STRING)'>ROOM S IBARY(1)=STRING Q 1
 I $F(STRING," ")=0 D  Q 1
 . N LEN S LEN=$L(STRING)
 . F I=1:1 S IBARY(I)=$E(STRING,1,ROOM),STRING=$E(STRING,ROOM+1,LEN) Q:STRING=""
 . Q
 I $F(STRING," ")>ROOM S IBARY(1)=STRING Q 1
 ; add a space to the end of the string to avoid dropping last character
 S START=1,END=ROOM,STRING=STRING_" "
 F C=1:1 D  Q:$L(STRING)<START  Q:$G(STOP)  ; stop if we have made it to the end of the data string
 .; start at the end and work backwards until you find a blank space, cut the line there and move on to the next line 
 .F I=END:-1:1 I $E(STRING,I)=" " S IBARY(C)=$E(STRING,START,I),START=I+1,END=SUBS+START Q
 .I I=1 S STOP=1 I '$D(IBARY(1)) S IBARY(1)=STRING Q
 Q C
 ;
STRIP(DATA) ; strip leading spaces
 N I,RTN
 S RTN=DATA F I=1:1:$L(DATA) Q:$E(DATA,I)'=" "  S RTN=$E(RTN,2,999)
 Q RTN
 ;
FINISH ;
 ;JWS;10/23/25;EBILL-6172;add data comments to initial encounter load
 N IBPAIEN,ERR,I,II,J,NOTE,NOTE1
 S I=1,NOTE(1)="Encounter#: "_IBREFD9_"; ETD: "_IBPAYERID_"; Payer Claim Control #: "_$P($G(^TMP("IB837ACC",$J)),"^",44)
 I $L(NOTE(1))>80 D
 . S II=$$WRAP^IBCE837ACC2A(NOTE(1),80,80,.XX)
 . F I=1:1:II S NOTE(I)=XX(I)
 . S I=II
 I $G(IBAUTH)'="" S NOTE1=$S($G(IBREF)="":"; Authorization #: ",1:"; Authorization/Referral #: ")
 I $G(NOTE1)="",$G(IBREF)'="" S NOTE1="; Referral #: "
 S I=I+1,NOTE(I)="ICN: "_$G(IBPATICN)_$G(NOTE1)_$S($G(IBAUTH)'="":IBAUTH,1:"")_$S(($G(IBAUTH)'=""&($G(IBREF)'="")):" / ",1:"")_$S($G(IBREF)'="":IBREF,1:"")
 I $L(NOTE(I))>80 D
 . S II=$$WRAP^IBCE837ACC2A(NOTE(I),80,80,.XX)
 . I II>1 F J=1:1:II S NOTE(I)=XX(J),I=I+1
 I $O(^IBA(364.9,IBX12,7,"B",0)) S I=I+1,NOTE(I)="Error codes:",II=0 F  S II=$O(^IBA(364.9,IBX12,7,"B",II)) Q:II=""  S NOTE(I)=NOTE(I)_" "_$$GET1^DIQ(364.91,II_",",.01,"E")
 I $L(NOTE(I))>80 D
 . S II=$$WRAP^IBCE837ACC2A(NOTE(I),80,80,.XX)
 . I II>1 F J=1:1:II S NOTE(I)=XX(J),I=I+1
 S IBPAIEN=$O(^IBA(364.9,IBX12,4,"A"),-1) I IBPAIEN D
 . S IBPAIEN=IBPAIEN_","_IBX12_","
 . D WP^DIE(364.94,IBPAIEN,10,"A","NOTE","ERR")
 . Q
 ;JWS;9/4/2025;IB*2.0*770v44;make sure we send back a response, if not dups will occur
 I '$D(^TMP("IBCE837ACC",$J,"Status")) S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received and processed."
 ; Reference to ENCODE^XLFJSON in ICR #6682
 D ENCODE^XLFJSON("^TMP(""IBCE837ACC"",$J)","RESULT")
 I $G(RESULT(1))=""!($G(RESULT(1))="{}") S RESULT(1)="[{}]" Q
 S RESULT(1)="["_RESULT(1)_"]"
 Q
 ;
UPDATE(IBIEN,IBVAL,IBFLD) ;
 N DA,D0,DR,DIE,DIC
 S DA=IBIEN I DA="" Q
 S DR=IBFLD_"////"_IBVAL
 S DIE="^IBA(364.9,"
 D ^DIE
 Q
 ;
 ; JWS;10/30/2025;EBILL-5763;process inpatient CMS-1550 professional claims without PTF
ACCFT(IBFACT,IBFT) ;check facility type on a professional claim
 ; if facility type is in list, allow processing inpatient cms-1500 without PTF
 N XIB,XIB1,OK,I
 S OK=0
 I IBFT=2 D  Q OK
 . S XIB=$$FIND1^DIC(364.991,,"X","ACC_PROF_FACILITY_TYPE_NOPTF")
 . I 'XIB Q
 . S XIB1=$$GET1^DIQ(364.991,XIB_",",.1)
 . I XIB1="" Q
 . F I=1:1:$L(XIB1,"|") I IBFACT=$P(XIB1,"|",I) S OK=1 Q
 . Q
 I IBFT=3 D
 . S XIB=$$FIND1^DIC(364.991,,"X","ACC_INST_FACILITY_TYPE_PTF")
 . I 'XIB Q
 . S XIB1=$$GET1^DIQ(364.991,XIB_",",.1)
 . I XIB1="" Q
 . S OK=1
 . F I=1:1:$L(XIB1,"|") I IBFACT=$P(XIB1,"|",I) S OK=0 Q
 . Q
 Q OK
 ;
CHKPG(IBPATIEN,IBNOTE) ;
 N IBEGP,IBPGIEN,OK,IBEGPSG
 ; check priority group.  must be 7 or 8, and if 8, sub group must be c - d needs a clinical decision
 S IBPGIEN=$P($G(^DPT(IBPATIEN,"ENR")),"^") I IBPGIEN=""  S IBNOTE="PRIORITY GROUP NOT FOUND" Q 0  ;no priority group ;ICR ***NEW (Pending)
 ;JWS;IB*2.0*770v4;EBILL-4223;allow priority group 4
 S IBEGP=$P($G(^DGEN(27.11,IBPGIEN,0)),"^",7) I IBEGP'=4,IBEGP'=7,IBEGP'=8  S IBNOTE="PRIORITY GROUP MISMATCH ("_IBEGP_")" Q 0  ; wrong priority group ;ICR 5158 (Private)
 ;JWS;IB*2.0*770v4;EBILL-4221;add 8(d) exclusion due to clinical decision need
 I IBEGP=8 N OK S IBEGPSG=$$GET1^DIQ(27.11,IBPGIEN_",",.12,"E") D  Q OK   ;ICR #5158 (Private) *** Need to modify
 . I IBEGPSG'="c",IBEGPSG'="d" S IBNOTE="PRIORITY GROUP 8 SUBGRP MISMATCH ("_IBEGPSG_")",OK=0 Q  ;wrong sub-group
 . I IBEGPSG="d" S IBNOTE="PRIORITY GROUP 8 SUBGRP 'd' NEEDS CLINICAL DECISION",OK=2 Q
 . ;JWS;IB*2.0*770;10/4/24 - set fall thru result
 . S OK=1
 Q 1
 ;
