GMRCCCR1 ;MJ - Receive HL7 Message for HCP ;3/21/18 09:00
 ;;3.0;CONSULT/REQUEST TRACKING;**99,106,112,123,134,146**;JUN 1, 2018;Build 12
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10106 HLADDR^HLFNC
 ;
 ; MJ - 5/24/2018 patch 106 changes to add - GETADD function
 ; MJ - 2/28/2019 patch 112 subroutines added or split from GMRCCCRA
 ; MJ - 4/02/2019 patch 123 updated to find VistA user from HSRM message and create NAK if invalid
 ; MJ - 7/30/2019 patch 134 fix control character issue in TIU notes
 ; MJ - 9/20/2019 patch 146 clear space-only address fields
 ;
 Q
 ;
GETADD(INSP) ;
 ; INSP contains internal value of insurance plan for this patient (IN1 segment)
 N ADDLN1,ADDLN2,ADDLN3,ADDCITY,ADDST,ADDZIP,VADD,VCSZ,X
 S ADDLN1=$$GET1^DIQ(36,INSP_",",.111)
 S ADDLN2=$$GET1^DIQ(36,INSP_",",.112)
 S ADDLN3=$$GET1^DIQ(36,INSP_",",.113)
 S ADDCITY=$$GET1^DIQ(36,INSP_",",.114)
 S ADDST=$$GET1^DIQ(36,INSP_",",.115,"I") ; S:ADDST ADDST=ADDST_"~"_$$GET1^DIQ(36,INSP_",",.115)
 S ADDZIP=$$GET1^DIQ(36,INSP_",",.116)
 S VADD=ADDLN1_"^"_ADDLN2,VCSZ=ADDCITY_"^"_ADDST_"^"_ADDZIP
 S X=$$HLADDR^HLFNC(VADD,VCSZ)
 S:X]"" $P(X,"^",7)="M" ; address type = 'mailing'
 Q X
 ; end patch 106 mod
 ;
CLRADD(ADDRESS) ;
 ; patch 146 - take any address field that contains only spaces and change to null
 N I,J,ADD
 F I=1:1:$L(ADDRESS,"^") D  ;
 . S ADD=$P(ADDRESS,"^",I) I $L(ADD) D  ;
 .. F  Q:$E(ADD,1)'=" "  S ADD=$E(ADD,2,$L(ADD))
 .. S $P(ADDRESS,"^",I)=ADD
 Q ADDRESS
 ;
MESSAGE(MSGID,ERRARY) ; Send a MailMan Message with the errors
 ; moved here for patch 112
 N MSGTEXT,DUZ,XMDUZ,XMSUB,XMTEXT,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMZ,XMMG,DATE,I,J
 S DATE=$$FMTE^XLFDT($$FMDATE^HLFNC($P(HL("DTM"),"-",1)))
 S XMSUB="GMRC CCRA Consults to HSRM HL7 Error"
 S MSGTEXT(1)=" "
 S MSGTEXT(2)="Error in transmitting HL7 message to HSRM"
 S MSGTEXT(3)="Date: "_DATE
 S MSGTEXT(4)="Message ID: "_MSGID
 S MSGTEXT(5)="Error(s):"
 S I=0,J=5 F  S I=$O(ERRARY(I)) Q:'I  D
 . S J=J+1,MSGTEXT(J)=" "
 . S J=J+1,MSGTEXT(J)=" "_$P($G(ERRARY(I,3)),U)_" - "_$P($G(ERRARY(I,3)),U,2)
 . I $P($G(ERRARY(I,2)),U,1)'="" S J=J+1,MSGTEXT(J)=" Segment: "_$P($G(ERRARY(I,2)),U,1)
 . I $P($G(ERRARY(I,2)),U,2)'="" S J=J+1,MSGTEXT(J)=" Sequence: "_$P($G(ERRARY(I,2)),U,2)
 . I $P($G(ERRARY(I,2)),U,3)'="" S J=J+1,MSGTEXT(J)=" Field: "_$P($G(ERRARY(I,2)),U,3)
 . I $P($G(ERRARY(I,2)),U,4)'="" S J=J+1,MSGTEXT(J)=" Fld Rep: "_$P($G(ERRARY(I,2)),U,4)
 . I $P($G(ERRARY(I,2)),U,5)'="" S J=J+1,MSGTEXT(J)=" Component: "_$P($G(ERRARY(I,2)),U,5)
 . I $P($G(ERRARY(I,2)),U,6)'="" S J=J+1,MSGTEXT(J)=" Sub-component: "_$P($G(ERRARY(I,2)),U,6)
 S XMTEXT="MSGTEXT("
 S XMDUZ="GMRC-CCRA->HSRP Transaction Error"
 S XMY("G.GMRC HCP HL7 MESSAGES")=""
 D ^XMD
 Q
 ;
MESSAGE2(MSGID,ABORT,CONID) ; Send a MailMan Message with the errors
 N MSGTEXT,DUZ,XMDUZ,XMSUB,XMTEXT,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMZ,XMMG,DATE,J,SITE,MSG
 S SITE=$$KSP^XUPARAM("INST")
 S DATE=$$FMTE^XLFDT($$FMDATE^HLFNC($P(HL("DTM"),"-",1)))
 S XMSUB="Consult ID "_CONID_" - GMRC CCRA Scheduling Updates from HSRM - HL7 Error"
 S MSGTEXT(1)=" "
 S MSGTEXT(2)="Error in receiving HL7 message from HSRM"
 S MSGTEXT(3)="Date:       "_DATE
 S MSGTEXT(4)="Message ID: "_MSGID
 S MSG="Error(s): "_$P(ABORT,"^",2)_"/VISTA "_SITE_"/Consult ID:"_CONID_". Please manually synchronize the consult"
 S MSG=MSG_" in VistA #"_SITE_" with the information currently available in HSRM."
 S MSGTEXT(5)=MSG
 S XMTEXT="MSGTEXT("
 S XMDUZ="GMRC-CCRA <-HSRM Transaction Error"
 S XMY("G.GMRC HSRM SIU HL7 MESSAGES")=""  ;  ** CHECK THIS OUT **
 D ^XMD
 Q
 ;
CCONTROL(GMRCDA) ; patch 112
 ; remove control characters from data before building OBR segment
 ;
 S YY=0 F  S YY=$O(^GMR(123,GMRCDA,40,YY)) Q:YY'>0  D
 .S XX=0 F  S XX=$O(^GMR(123,GMRCDA,40,YY,1,XX)) Q:XX'>0  D
 ..K NODE
 .. ;S TESTSTRING=$C(13)
 ..S NODE=$G(^GMR(123,GMRCDA,40,YY,1,XX,0))
 ..I $G(NODE)[$C(13,10,10) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(13,10,10)," ") ; <cr><lf><lf>
 ..I $G(NODE)[$C(13,10) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(13,10)," ") ; <cr><lf>
 ..I $G(NODE)[$C(13) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(13)," ") ; TERM char
 ..I $G(NODE)[$C(1) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(1)," ") ; SOH
 ..I $G(NODE)[$C(2) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(2)," ") ; STX
 ..I $G(NODE)[$C(3) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(3)," ") ; ETX
 ..I $G(NODE)[$C(4) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(4)," ") ; EOT
 ..I $G(NODE)[$C(5) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(5)," ") ; ENQ
 ..I $G(NODE)[$C(6) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(6)," ") ; ACK
 ..I $G(NODE)[$C(21) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(21)," ") ; NAK
 ..I $G(NODE)[$C(23) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(23)," ") ; ETB
 ..;I $C(13,10,10)[$G(NODE) W !,XX," ",NODE
 ..K NODE ;,TESTSTRING
 K XX,YY
 Q
 ;
ANAK(NAKMSG,USERMAIL,ICN,DFN,CONID,GMRCDT) ; Application Error, send NAK back
 N PATNAME,EID,EIDS,MSGN,SITE,CONPAT,RES,NAKMSG1
 Q:$G(NAKMSG)=""
 Q:$G(DFN)'>0
 Q:$G(CONID)=""
 Q:$G(GMRCDT)=""
 Q:$G(^DPT(DFN,0))=""
 S CONPAT=$$GET1^DIQ(123,CONID_",",.02,"I")
 Q:$G(CONPAT)'=DFN  ;Patient in appt msg not the same as patient in the consult
 S PATNAME=$P(^DPT(DFN,0),"^"),SITE=$$KSP^XUPARAM("INST")
 S:$G(ICN)="" ICN=$P(^DPT(DFN,"MPI"),"^",10)
 S EID=$G(HL("EID"))
 S EIDS=$G(HL("EIDS"))
 S MSGN=$G(HL("MID"))
 ; S NAKMSG1=NAKMSG_"/VISTA "_SITE_"/Consult ID:"_CONID_". Please manually synchronize the consult"
 ; S NAKMSG1=NAKMSG1_" in VistA #"_SITE_" with the information currently available in HSRM."
 S HLA("HLA",1)="MSA|AE|"_$G(MSGN)_"|"_$G(USERMAIL)_" "_$G(NAKMSG)_"|||"_$G(ICN)_"^"_$G(PATNAME)_"^"_SITE_"^"_CONID_"^"_GMRCDT
 D GENACK^HLMA1(EID,$G(HLMTIENS),EIDS,"LM",1,.RES)
 Q
TIUC(X) ; Check each segment of the TIU notes for HL7 control characters
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
 Q X
ADDEND ; moved from ADDEND^GMRCCCRA routine for space ; patch 146 ; MJ
 ; returns 0 if value not found
 ;
 ; modified in patch GMRC*3.0*106 to use ICR 2693
 D EXTRACT^TIULQ(TIUDA)
 ;
 ; Quit if not an addendum
 S TIUTYP=^TMP("TIULQ",$J,+TIUDA,.01,"I")
 I TIUTYP'=81 Q 0
 ;
 S DFN=^TMP("TIULQ",$J,+TIUDA,.02,"I")
 I 'DFN!('$D(^DPT(DFN))) Q 0
 ;
 ; Get parent note IEN, if addendum IEN is passed in:
 S GMRCPARN=^TMP("TIULQ",$J,+TIUDA,.06,"I")
 ;
 ; Quit if not an addendum
 ;S TIUTYP=$$GET1^DIQ(8925,TIUDA,.01,"I")
 ;I TIUTYP'=81 Q
 ;
 ;S DFN=$$GET1^DIQ(8925,TIUDA,.02,"I")
 ;I 'DFN,'$D(^DPT(DFN)) Q
 ;
 ; Get parent note IEN, if addendum IEN is passed in:
 ;S GMRCPARN=$$GET1^DIQ(8925,TIUDA,.06,"I")
 ;
 ; end patch 106 mods
 ;
 S (GMRCO,GMRCD)=0
 F  S GMRCD=$O(^GMR(123,"AD",DFN,GMRCD)) Q:'GMRCD!(GMRCO)  D
 .S GMRCDA=0
 .F  S GMRCDA=$O(^GMR(123,"AD",DFN,GMRCD,GMRCDA)) Q:'GMRCDA!(GMRCO)  D
 ..S GMRCD1=0
 ..F  S GMRCD1=$O(^GMR(123,GMRCDA,50,GMRCD1)) Q:'GMRCD1!(GMRCO)  D
 ...S GMRC8925=$$GET1^DIQ(123.03,GMRCD1_","_GMRCDA_",",.01,"I")
 ...I +GMRC8925=$S(+GMRCPARN:+GMRCPARN,1:TIUDA) S GMRCO=GMRCDA
 Q GMRCO
 ;
AUTHDTTM ;
 S ACTIEN=$G(ACTIEN,$O(^GMR(123,GMRCDA,40,99999),-1))
 I '+ACTIEN D  Q
 .S ZCNT=ZCNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"||Author\R\\R\"
 .S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"||Datetime\R\\R\"
 .S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"||Comment\R\\R\"
 .S NTECNT=4
 ;
 S ZCNT=ZCNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"||Author\R\\R\"_$$GET1^DIQ(123.02,ACTIEN_","_GMRCDA_",",4)
 S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"||Datetime\R\\R\"_$$FMTHL7^XLFDT($$GET1^DIQ(123.02,ACTIEN_","_GMRCDA_",",2,"I"))
 S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"||Comment\R\\R\"
 S NTECNT=4
 Q
ACK ;
 N GMRCMSG,I,X,DONE,MSGID,ERRARY,ERRI
 ;Get the message
 S ERRI=0
 F I=1:1 X HLNEXT Q:(HLQUIT'>0)  D
 . S GMRCMSG(I,1)=HLNODE
 . S X=0 F  S X=+$O(HLNODE(X)) Q:'X  S GMRCMSG(I,(X+1))=HLNODE(X)
 S DONE=0
 S I=0 F  S I=$O(GMRCMSG(I)) Q:'+I  D  Q:DONE
 . I $P($G(GMRCMSG(I,1)),"|",1)="MSA" D  Q
 . . I $P($G(GMRCMSG(I,1)),"|",2)="AA" S DONE=1 Q
 . . S MSGID=$P($G(GMRCMSG(I,1)),"|",3)
 . I $P($G(GMRCMSG(I,1)),"|",1)="ERR" D
 . . ;Process Error
 . . S ERRI=ERRI+1
 . . S ERRARY(ERRI,2)=$P($G(GMRCMSG(I,1)),"|",3)
 . . I $P($G(GMRCMSG(I,1)),"|",6)'="" D  Q
 . . . S ERRARY(ERRI,3)=$P($P($G(GMRCMSG(I,1)),"|",6),"^",4)_"^"_$P($P($G(GMRCMSG(I,1)),"|",6),"^",5)
 . . S ERRARY(ERRI,3)=$P($G(GMRCMSG(I,1)),"|",4)
 I $D(ERRARY) D MESSAGE(MSGID,.ERRARY)
 Q 
