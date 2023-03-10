TIUCCRHL7P1 ; CCRA/PB - TIU CCRA HL7 Msg Processing; January 6, 2006
 ;;1.0;TEXT INTEGRATION UTILITIES;**337,344,348,349,352**;Jun 20, 1997;Build 21
 ;
 ;PB - Patch 344 to modify how the note and addendum text is formatted
 ;PB - Patch 348 modification to parse the note text from NTE segments rather than the OBX segment
 ;PB - Patch 349 modification to parse and file the consult factor from the note and file as a comment with the consult
 ;NOTES FROM NOV 10: Need to loop thru the XTMP("TIUHL7" temp global and if the last character is 
 ;$C(160), remove it.
 ;PB - Patch 352 removes the text CF#: from the CFNOTE
 Q
PROCMSG ;
 N DFN,DUZ,MSGID,TIU,TIUDA,TIUDPRM,TIUDT,TIUERR,TIUI,TIUJ,TIUMSG,TIUELS,STOP,TIUIEN,NOTEDATE,NOTENUM
 N TIUEMAIL,TIUNAME,TIUTMP,TIUFS,TIUCS,TIURS,TIUES,TIUSS,TIUZ,VNUM,MSGTEXT,ADDENDUM,CFNOTE,ORIGSTAT
 S ADDENDUM=""
 ;
 ; remove HL7 message entries7 days or older
 D CLEAN^TIUHL7U1
 ;
 S U="^"
 S TIUDT=$$NOW^XLFDT    ;3200319.131747
 ;
 ; sets field, component and repetition separators from HL7 Message
 S TIUFS=$G(HL("FS")),TIUJ=0 F TIUI="TIUCS","TIURS","TIUES","TIUSS" S TIUJ=TIUJ+1 S @TIUI=$E(HL("ECH"),TIUJ,TIUJ)
 ; initializes variables and ^XTMP expiration
 S TIU="TIU",(TIU("EC"),TIUDA)=0,TIUNAME=$NA(^XTMP("TIUHL7",TIUDT,HLMTIENS)),^XTMP("TIUHL7",0)=$$FMADD^XLFDT(TIUDT,7)_U_TIUDT
 S MSGID=HL("MID")
 ; retrieves HL7 message and stores to temporary global
 F TIUI=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S @TIUNAME@("MSG",TIUI)=HLNODE,TIUJ=0
 . F  S TIUJ=$O(HLNODE(TIUJ)) Q:'TIUJ  D
 . . S @TIUNAME@("MSG",TIUI)=@TIUNAME@("MSG",TIUI)_HLNODE(TIUJ)  ;$$TIUC^TIUCCHL7UT(HLNODE(TIUJ))
 ; places temporary global in local meory & adds EOM flag
 M TIUMSG=@TIUNAME@("MSG")
 S TIU("XTMP")=TIUNAME,TIUNAME="TIUMSG",TIUI="",TIUI=$O(TIUMSG(TIUI),-1),TIUI=TIUI+1,TIUMSG(TIUI)="EOM"
 ; verify message format
 S TIUI="" F  S TIUI=$O(@TIUNAME@(TIUI)) Q:@TIUNAME@(TIUI)="EOM"  D
 . S TIUJ=$S(TIUI=1:"MSH",TIUI=2:"EVN",TIUI=3:"PID",TIUI=4:"PV1",TIUI=5:"TXA",TIUI=6:"OBX",TIUI>6:"NTE",1:"OBX")
 . I $P(@TIUNAME@(TIUI),TIUFS)'=TIUJ D ERR^TIUCCHL7UT("MSG",1,"000.000","Improper/missing message format: "_TIUJ_" segment.")
 ; get consult id
 S TIU("VNUM")=$$REMESC^TIUHL7U1($P($G(@TIUNAME@(4)),TIUFS,20))
 S (TIU("VNUM"),VNUM)=+TIU("VNUM")
 S STOP=0
 I '$G(VNUM) D  Q
 .S MSGTEXT="HL7 message missing Consult Number.",STOP=1 D MESSAGE^TIUCCRHL7P3(MSGID,$G(VNUM),MSGTEXT),ANAK^TIUCCHL7UT(MSGID,$G(MSGTEXT),$G(VNUM))
 Q:$G(STOP)=1
 Q:$G(VNUM)'>0
 ; get patient name [required]
 S TIU("PTNAME")=$$UPPER^HLFNC($$FMNAME^HLFNC($P($P($G(@TIUNAME@(3)),TIUFS,6),TIUCS,1,4),TIUCS)),TIU("PTNAME")=$$REMESC^TIUHL7U1(TIU("PTNAME"))
 ;
 ; get patient ICN/SSN/DFN - order may vary [conditionally required]
 S (TIU("DFN"),TIU("ICN"),TIU("SSN"))="" F TIUI=1:1:$L($P($G(@TIUNAME@(3)),U,4),TIURS) S TIUJ=$P($P($G(@TIUNAME@(3)),TIUFS,4),TIURS,TIUI) I +TIUJ>0 D
 . S TIU("ICN")=+$P(TIUJ,U,1)
 I +$G(TIU("ICN"))'>0 S MSGTEXT="Patient ICN not in HL7 message.",STOP=1 D MESSAGE^TIUCCRHL7P3(MSGID,$G(VNUM),MSGTEXT),ANAK^TIUCCHL7UT(MSGID,$G(MSGTEXT),$G(VNUM))
 Q:$G(STOP)=1
 Q:+$G(TIU("ICN"))'>0
 S (DFN,TIU("DFN"))=$$GETDFN^MPIF001($P(TIU("ICN"),"V")),TIU("SSN")=$$GET1^DIQ(2,TIU("DFN")_",",.09,"I")
 S TIUTMP=$S($P(TIUJ,TIUCS,5)="NI":"ICN",$P(TIUJ,TIUCS,5)="SS":"SSN",$P(TIUJ,TIUCS,5)="PI":"DFN",1:"UNK")
 I +TIU("DFN")=-1 S MSGTEXT="Patient not found on VistA ",STOP=1 D MESSAGE^TIUCCRHL7P3(MSGID,$G(VNUM),MSGTEXT),ANAK^TIUCCHL7UT(MSGID,$G(MSGTEXT),$G(VNUM))
 Q:$G(STOP)=1
 Q:+TIU("DFN")=-1
 ; get dfn from consult in file 123 and compare to HL7 dfn
 I $G(VNUM)>0 N CDFN S CDFN=$$GET1^DIQ(123,VNUM_",",.02,"I") I CDFN'=TIU("DFN") D
 . S MSGTEXT="PATIENT NAME "_$G(TIU("PTNAME"))_" mismatch between HL7 message and CONSULT",STOP=1
 . D MESSAGE^TIUCCRHL7P3(MSGID,$G(VNUM),MSGTEXT),ANAK^TIUCCHL7UT(MSGID,$G(MSGTEXT),$G(VNUM))
 Q:$G(STOP)=1
 Q:$G(CDFN)'=$G(TIU("DFN"))
 ; get DOCUMENT TITLE (#8925.1) [required] & set IEN, document title is in TIU("TITLE")
 S TIU("TITLE")=$$UPPER^HLFNC($P($G(@TIUNAME@(5)),TIUFS,17)),TIU("TITLE")=$$REMESC^TIUHL7U1(TIU("TITLE"))
 S TIU("TITLEB")=$$UPPER^HLFNC($P($G(@TIUNAME@(5)),TIUFS,3)),TIU("TITLEB")=$$REMESC^TIUHL7U1(TIU("TITLEB")),TIU("TITLEB")=$P(TIU("TITLEB"),"^",2)
 ;patch 344 code below to determine if this is an original note or an addendum
 I $G(TIU("TITLEB"))["ADDENDUM" D
 .K T2 S T2(" - ")="-" S TIU("TITLEB")=$$REPLACE^XLFSTR(TIU("TITLEB"),.T2) K T2
 .S:$G(TIU("TITLEB"))["ADDENDUM" ADDENDUM=$P(TIU("TITLEB"),"-",2)
 .;S TIU("TITLE")=$P(TIU("TITLEB"),"-",1)
 S TIU("TDA")=$$LU^TIUHL7U1(8925.1,TIU("TITLE"),"X","I $P(^TIU(8925.1,+Y,0),U,4)=""DOC""") I $L(TIU("TITLE"))'>0 S TIU("TITLE")="[UNKNOWN]"
 ; get VISIT # [optional]
 S:$G(TIU("VNUM"))'="" TIU("AVAIL")="AV",TIU("COMP")="LA"
 S TIU("SIGNED")=$$NOW^TIULC,TIU("CSIGNED")=""
 I '$G(VNUM) D  Q
 .S MSGTEXT="HL7 message missing Consult Number.",STOP=1 D MESSAGE^TIUCCRHL7P3(MSGID,$G(VNUM),MSGTEXT),ANAK^TIUCCHL7UT(MSGID,$G(MSGTEXT),$G(VNUM))
 Q:$G(STOP)=1
 S TIUEMAIL=$$LOW^XLFSTR($P($G(@TIUNAME@(5)),TIUFS,10))
 I $L(TIUEMAIL)'>0 S MSGTEXT="Missing or invalid VA Email Address.",STOP=1 D MESSAGE^TIUCCRHL7P3(MSGID,$G(VNUM),MSGTEXT),ANAK^TIUCCHL7UT(MSGID,$G(MSGTEXT),$G(VNUM))
 Q:$G(STOP)=1
 Q:$L(TIUEMAIL)'>0
 S (TIU("AUIEN"),TIU("AUDA"))=$O(^VA(200,"ADUPN",TIUEMAIL,""))
 I $L(TIU("AUIEN"))'>0 S MSGTEXT="No valid User Account for "_$G(TIUEMAIL),STOP=1 D MESSAGE^TIUCCRHL7P3(MSGID,$G(VNUM),MSGTEXT),ANAK^TIUCCHL7UT(MSGID,$G(MSGTEXT),$G(VNUM))
 Q:$G(STOP)=1
 Q:$L(TIU("AUIEN"))'>0
 S TIU("AUNAME")=$$UPPER^HLFNC($P(^VA(200,TIU("AUIEN"),0),U,1))
 S TIU("AUNAME")=$$REMESC^TIUHL7U1(TIU("AUNAME"))
 S TIU("ELESIG")=$$GET1^DIQ(200,TIU("AUIEN"),20.4)
 S TIUTMP="" F  S TIUTMP=$O(@TIUNAME@(TIUTMP)) Q:TIUTMP=""  D:$P($G(@TIUNAME@(TIUTMP)),TIUFS)="OBX"
 . I $P(@TIUNAME@(TIUTMP),TIUFS,2)=1,$L($G(TIU("SUB")))'>0 S TIU("SUB")=$P($P(@TIUNAME@(TIUTMP),TIUFS,4),TIUCS,2),TIU("SUB")=$$REMESC^TIUHL7U1(TIU("SUB"))
 . F TIUI=1:1:$L($P(@TIUNAME@(TIUTMP),TIUFS,6),TIURS) D
 . . S TIUZ("TEXT",TIUI,0)=$P($P(@TIUNAME@(TIUTMP),TIUFS,6),TIURS,TIUI)
 . . S TIUZ("TEXT",TIUI,0)=$$STRIP^TIUHL7U2($$REMESC^TIUHL7U1(TIUZ("TEXT",TIUI,0)))
 I $L(@TIUNAME@(7))>0&($E(@TIUNAME@(7),1,3)="NTE") D
 .N X1X,XCNTX S XCNTX=1,X1X=6 F  S X1X=$O(@TIUNAME@(X1X)) Q:X1X'>""  D
 ..S TIUZ("TEXT",XCNTX,0)=$TR($P($G(@TIUNAME@(X1X)),"|",4),$C(160)," ")
 ..I $G(TIUZ("TEXT",XCNTX,0))["&apos;" D
 ...N SPEC,T5 S SPEC("&apos;")="'",T5=TIUZ("TEXT",XCNTX,0)
 ...S TIUZ("TEXT",XCNTX,0)=$$REPLACE^XLFSTR(T5,.SPEC)
 ..I $G(TIUZ("TEXT",XCNTX,0))["&quot;" D
 ...N SPEC,T5 S SPEC("&quot;")="""",T5=TIUZ("TEXT",XCNTX,0)
 ...S TIUZ("TEXT",XCNTX,0)=$$REPLACE^XLFSTR(T5,.SPEC)
 ..I $G(TIUZ("TEXT",XCNTX,0))["Original CCP Note Date (mm/dd/yyyy):" S NOTEDATE=$P(TIUZ("TEXT",XCNTX,0),":",2)
 ..I $G(TIUZ("TEXT",XCNTX,0))["CCPN Number:" S NOTENUM=$P(TIUZ("TEXT",XCNTX,0),":",2)
 ..I $G(TIUZ("TEXT",XCNTX,0))'=""&($L(TIUZ("TEXT",XCNTX,0))>80) D SPLIT(TIUZ("TEXT",XCNTX,0),XCNTX)
 ..;patch 349, PB - Feb 15, 2022 - modifications to capture the Consult Factor text to be filed as a comment with the consult
 ..I $G(TIUZ("TEXT",XCNTX,0))["CF#:" S CFNOTE=$P($G(TIUZ("TEXT",XCNTX,0)),"CF#: ",2)
 ..S XCNTX=XCNTX+1
 I '$D(@TIUNAME@(7)) D
 .D:$G(ADDENDUM)="" WORD
 .D:$G(ADDENDUM)'="" WORD^TIUCCRHL7P4
 ;S:$G(ADDENDUM)'="" TIUIEN=$$TIULKUP^TIUCCHL7UT(VNUM,TIU("TITLE"),$G(NOTEDATE),$G(NOTEUM)) ;Patch 344 lookup the note in the consult to file the addendum with
 ; begin data verification
 ; PATIENT IDENTIFICATION
 D
 .Q
 . N TIUI,TIUJ,TIUERR,TIUN,TIUOUT,TIUTMP,TIUQUIT
 . I $D(TIU("DFN")) S TIUJ=1
 . I '+$L($G(TIU("PTNAME"))) D ERR^TIUCCHL7UT("PID",5,"0000.00","Missing PATIENT NAME.")
 . I +TIUJ=1 D
 . . I '+$L($P(TIU("PTNAME"),",",2)) D ERR^TIUCCHL7UT("PID",5,"0000.00","FIRST NAME/INITIAL missing with only one numeric identifier sent.")
 . . S TIUN("PT")=$$PNAME^TIUHL7U1(TIU("PTNAME")),TIUTMP=1
 . E  S TIUN("PT")=$P(TIU("PTNAME"),",")
 . S TIUJ=0
 . ; check DFN if available
 . I +$G(TIU("DFN")) S TIUJ=TIUJ+1,DFN(TIUJ)=TIU("DFN") D
 . . I +$G(TIUTMP) S TIUN("DFN")=$$PNAME^TIUHL7U1($$GET1^DIQ(2,TIU("DFN"),.01))
 . . E  S TIUN("DFN")=$P($$GET1^DIQ(2,TIU("DFN"),.01),",")
 . . I '$$COMPARE^TIUHL7U1(TIUN("DFN"),TIUN("PT")) D ERR^TIUCCHL7UT("PID",5,"0000.00","PATIENT NAME discrepancy between HL7 message name ["_TIU("PTNAME")_"] & the HL7 message DFN #"_TIU("DFN")_" ["_$$GET1^DIQ(2,DFN(TIUJ),.01)_"].")
 . ; check ICN if available
 . I +$G(TIU("ICN")) S TIUJ=TIUJ+1,DFN(TIUJ)=+$$FIND1^DIC(2,"","X",TIU("ICN"),"AICN") D
 . . I +$G(TIUTMP) S TIUN("ICN")=$$PNAME^TIUHL7U1($$GET1^DIQ(2,DFN(TIUJ),.01))
 . . E  S TIUN("ICN")=$P($$GET1^DIQ(2,DFN(TIUJ),.01),",")
 . . I '$$COMPARE^TIUHL7U1(TIUN("ICN"),TIUN("PT")) D ERR^TIUCCHL7UT("PID",5,"0000.00","PATIENT NAME discrepancy between HL7 message name ["_TIU("PTNAME")_"] & the HL7 message ICN #"_TIU("ICN")_" ["_$$GET1^DIQ(2,DFN(TIUJ),.01)_"].")
 . ; check SSN if available
 . I +$G(TIU("SSN")) S TIUJ=TIUJ+1,DFN(TIUJ)=+$$FIND1^DIC(2,"","X",TIU("SSN"),"SSN") D
 . . I +$G(TIUTMP) S TIUN("SSN")=$$PNAME^TIUHL7U1($$GET1^DIQ(2,DFN(TIUJ),.01))
 . . E  S TIUN("SSN")=$P($$GET1^DIQ(2,DFN(TIUJ),.01),",")
 . . I '$$COMPARE^TIUHL7U1(TIUN("SSN"),TIUN("PT")) D ERR^TIUCCHL7UT("PID",5,"0000.00","PATIENT NAME discrepancy between HL7 message name ["_TIU("PTNAME")_"] & the HL7 message SSN #"_TIU("SSN")_" ["_$$GET1^DIQ(2,DFN(TIUJ),.01)_"].")
 . ; compare DFN lookup values
 . I TIUJ>1 S (TIUI,TIUJ)=0 F  S TIUI=$O(DFN(TIUI)) Q:'TIUI  I TIUI>1 S TIUJ=TIUI-1 I DFN(TIUI)'=DFN(TIUJ) D ERR^TIUCCHL7UT("PID",5,"0000.00","PATIENT IEN discrepancies between the numeric lookups.") Q
 . I TIU("EC") Q
 . S DFN=DFN(1)
 I $G(ADDENDUM)'="" D
 .N N1 S N1=0 F  S N1=$O(TIUZ("TEXT",N1)) Q:N1'>0  D
 ..I $G(TIUZ("TEXT",N1,0))["Original CCP Note Date (mm/dd/yyyy):" S NOTEDATE=$P(TIUZ("TEXT",N1,0),": ",2)
 ..I $G(TIUZ("TEXT",N1,0))["CCPN Number:" S NOTENUM=$P(TIUZ("TEXT",N1,0),": ",2)
 .S:$G(NOTENUM)'="" TIUIEN=$$TIULKUP^TIUCCHL7UT(VNUM,TIU("TITLE"),$G(NOTEDATE),NOTENUM)
 ;
 D CONTINUE^TIUCCRHL7P2
 Q
SPLIT(NODE,CNTR) ;
 Q:$G(NODE)=""
 Q:$G(CNTR)=""
 Q:$L(NODE)<80
 K LINE
 S NODE=$TR(NODE,$C(160),""),XCNTX=CNTR
 N WORDS,I,XX,SEGS,LEN
 S LEN=$L(NODE),SEGS=LEN/80 S:$P(SEGS,".",2)>0 SEGS=SEGS+1
 S WORDS=0 F I=1:1:$L(NODE) I $E(NODE,I)=" " S WORDS=WORDS+1
 S XX="",CNT=1,LASTWORD=0
 F I=1:1:(WORDS+1) D
 .S XX=XX_$P(NODE," ",I)_" "
 .I $L(XX)>80 D
 ..S LASTWORD=I
 ..S LINE(CNT)=XX,CNT=CNT+1 S XX="",TIUZ("TEXT",XCNTX,0)=$G(LINE(CNT-1)),XCNTX=XCNTX+1
 I ((WORDS+1)>LASTWORD) D
 .S LINE(CNT)=$P(NODE," ",LASTWORD+1,WORDS+1),TIUZ("TEXT",XCNTX,0)=$G(LINE(CNT)),XCNTX=XCNTX+1
 K I,CNT,LASTWORD
 Q
WORD ;
 K I1,CNT,LCNT,LEN,I,LINES,T2,LASTWORDS,TEST1,WORDS,WORDSLEN,XX,T2,T4,T5
 S WORDS=$G(TIUZ("TEXT",1,0)),WORDSLEN=$L(TIUZ("TEXT",1,0))
 I $G(ADDENDUM)'="" D
 .S NOTEDATE=$$GETDATE^TIUCCRHL7P4
 .S NOTENUM=$$NOTENUM^TIUCCRHL7P4
 .S:$G(NOTENUM)'="" TIUIEN=$$TIULKUP^TIUCCHL7UT(VNUM,TIU("TITLE"),NOTEDATE,NOTENUM) ;Patch 344 lookup the note in the consult to file the addendum with
 ;S T2("VETERAN'S"_$C(160)_"CAREGIVER"_$C(160)_"CONTACT")="VETERAN'S CAREGIVER CONTACT"
 ;S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 F TEST1=1:1:WORDSLEN S LASTWORDS=$E(TIUZ("TEXT",1,0),WORDSLEN,(WORDSLEN-25))
 K T2 S T2("PROVIDER"_$C(160)_"CONTACT ADDENDUM")="PROVIDER CONTACT ADDENDUM"
 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 ;TEST CODE ADDED DEC 3
 K T2 S T2("CCP Note Create Date:")=$C(10)_"CCP Note Create Date:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("CCPN Number:")=$C(10)_"CCPN Number:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 ;K T2 S T2("Basic*")="Basic*"_$C(10) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 ;K T2 S T2("Navigation")=$C(10)_"Navigation" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 ;K T2 S T2("Scheduling")=$C(10)_"Scheduling" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran Last Name:")=$C(10)_"Veteran Last Name:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran First Name:")=$C(10)_"Veteran First Name:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran Social:")=$C(10)_"Veteran Social:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2($C(160)_$C(160)_"CONSULT AND REFERRAL INFORMATION ")=$C(10)_"CONSULT AND REFERRAL INFORMATION " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Name of Referring VA Provider:")=$C(10)_"Name of Referring VA Provider:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Selected SEOC:")=$C(10)_"Selected SEOC:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Referral Number:")=$C(10)_"Referral Number:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Unique Consult ID:")=$C(10)_"Unique Consult ID:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Patient Admitted (Yes/No): If yes, then please complete the Discharge Planning Addendum.")=$C(10)_"Patient Admitted (Yes/No): If yes, then please complete the Discharge Planning Addendum" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Chief Complaint: "_$C(160))=$C(10)_"Chief Complaint:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Risks")=$C(10)_"Risks x" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Level of Care Coordination: ")=$C(10)_"Level of Care Coordination: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="BasicPlease review all notes, this note may have one or more of the following addenda associated:" D
 .K T5 S T5="Basic Please review all notes, this note may have one or more of the following addenda associated:"
 .S T2($G(T4))=$C(10)_$G(T5) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2) K T5
 K T2 S T2("Care Coordination Follow Up:")=$C(10)_"Care Coordination Follow Up:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Appointment Management:")=$C(10)_"Appointment Management:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Case Management:")=$C(10)_"Case Management:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Continued Stay Review:")=$C(10)_"Continued Stay Review:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Disease Management:")=$C(10)_"Disease Management:"  S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Discharge Planning:")=$C(10)_"Discharge Planning: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Discharge Disposition:")=$C(10)_"Discharge Disposition:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran Contact: ")=$C(10)_"Veteran Contact:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Provider Contact: ")=$C(10)_"Provider Contact:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Transfer:")=$C(10)_"Transfer:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran Handoff:")=$C(10)_"Veteran Handoff:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("FACILITY COMMUNITY CARE OFFICE CONTACT")=$C(10)_"FACILITY COMMUNITY CARE OFFICE CONTACT" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Care Coordination Point of Contact:")=$C(10)_"Care Coordination Point of Contact:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("  Phone Number:")=$C(10)_"Phone Number:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 ;K T2 S T2("VETERAN'S CAREGIVER CONTACT INFO")=$C(10)_"X1 VETERAN'S CAREGIVER CONTACT INFO" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Is Veteran's caregiver same as next of kin listed in the demographic section of CPRS (Yes/No)?:" D
 .S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("If no, provide the following:")=$C(160)_"If no, provider the following:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran's Caregiver Point of Contact:")=$C(10)_"Veteran's Caregiver Point of Contact" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Caregiver's Relationship to Veteran:")=$C(10)_"Caregiver's Relationship to Veteran:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Caregiver's Primary Phone Number:")=$C(10)_"Caregiver's Primary Phone Number::" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Caregiver's Alternate Phone Number:")=$C(10)_"Caregiver's Alternate Phone Number:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("PLAN:")=$C(10)_"PLAN:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="*** CC Plan may include specialty and associated appointment information, date of surgery, post-op needs, post d/c appointment, and any other care coordination plan ***" D
 .S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("ADDITIONAL NOTES:")=$C(10)_"ADDITIONAL NOTES:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 S LEN=$L(WORDS),I1=1,XX=1,CNT=0,LCNT=0
 F I=1:1:LEN D
 .S LCNT=LCNT+1
 .I LCNT>100&($E(WORDS,I)=" ")!($E(WORDS,I)=$C(160))!($E(WORDS,I)=$C(10)) D
 ..S:XX=1 LINES("TEXT",XX,0)=$$TRIM^XLFSTR($E(WORDS,1,63),"LR"),XX=XX+1,I=64,LCNT=0,I1=I
 ..Q:XX=1
 ..S LINES("TEXT",XX,0)=$TR($E(WORDS,I1,I-1),$C(160)," "),LINES("TEXT",XX,0)=$$TRIM^XLFSTR(LINES("TEXT",XX,0),"LR"),XX=XX+1,LCNT=0  ;,I1=I
 ..;W !,$G(LINES("TEXT",XX-1,0)),"  ",XX-1_"^"_I1_"^"_I_"^"_LCNT
 ..S I1=I
 I I1'=LEN N LASTLINES S LASTLINES=$E(WORDS,I1,I) K T2 S T2($C(160)_" ")="" S LINES("TEXT",XX,0)=$$REPLACE^XLFSTR(LASTLINES,.T2)
 M TIUZ("TEXT")=LINES("TEXT")
 K LINES("TEXT")
 Q
