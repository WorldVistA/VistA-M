TIUCCRHL ;LB/PB - Send TIU Notes MDM-T02 HL7 Message to CCRA/HSRM ;02/01/19 09:00
 ;;1.0;TEXT INTEGRATION UTILITIES;**323,327,329**;Oct 24, 2019;Build 42
 ;This patch requires:
 ;four (4) CCRA TIU Historical Documents :
 ;     1   COMMUNITY CARE - PATIENT LETTER       TITLE  
 ;     Std Title: NONVA PROGRESS NOTE
 ;     2   COMMUNITY CARE- ADMINISTRATIVE REQUEST       TITLE  
 ;     Std Title: ADMINISTRATIVE NOTE
 ;     3   COMMUNITY CARE-COORDINATION NOTE       TITLE  
 ;      Std Title: NONVA PROGRESS NOTE
 ;     4   COMMUNITY CARE-HOSPITAL NOTIFICATION NOTE       TITLE  
 ;      Std Title: PRIMARY CARE ADMINISTRATIVE NOTE
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2161  INIT^HLFNC2
 ;2164  GENERATE^HLMA
 ;3267  SSN^DPTLK1
 ;3630  BLDPID^VAFCQRY
 ;10103 FMTE^XLFDT, FMTHL7^XLFDT
 ;10104 UP^XLFSTR
 ;10106 FMDATE^HLFNC
 ;1252  OUTPTPR^SDUTL3
 ;6917  EN^VAFHLIN1
 ;10106 HLADDR^HLFNC
 ;2467  OR^ORX8
 ;2171  NS^XUAF4
 ;Fileman READ OF 8925:
 ;      .01      DOCUMENT TYPE        0;1      Read w/Fileman
 ;      .02      PATIENT              0;2      Read w/Fileman
 ;      .03      VISIT                0;3      Read w/Fileman
 ;      .04      PARENT DOCUMENT TYPE (P8925.1)
 ;      .05      STATUS               0;5      Read w/Fileman
 ;      .06      PARENT               0;6      Read w/Fileman
 ;      .11      CREDIT STOP CODE ON  0;11     Read w/Fileman
 ;      .07      EPISODE BEGIN DATE/T 0;7      Read w/Fileman
 ;      .13      VISIT TYPE           0;13     Read w/Fileman
 ;      1202     AUTHOR/DICTATOR      12;2     Read w/Fileman
 ;      1204     EXPECTED SIGNER      12;4     Read w/Fileman
 ;      1208     EXPECTED COSIGNER    12;8     Read w/Fileman
 ;      1211     VISIT LOCATION       12;11    Read w/Fileman
 ;      1506     COSIGNER NEEDED      15;6     Read w/Fileman
 ;      1201     ENTRY DATE/TIME      12;1     Read w/Fileman
 ;      1301     REFERENCE DATE       13;1     Read w/Fileman
 ;  GLOBAL REFERENCE: 
 ;    ^TIU(8925,'AAU'
 ;  GLOBAL REFERENCE: 
 ;    ^TIU(8925,'ASUP'
 ;   GLOBAL REFERENCE: 
 ;    ^TIU(8925,'APT'
 ;  GLOBAL REFERENCE: 
 ;    ^TIU(8925,'ACLPT'
 ;==============================================================
 Q
 ;
EN() ;Entry point to routine called from POSTSIGN^TIULC1 for the CCRA TIU Documents - Historical
 ;Expects the context has defined: DFN (Patient IEN -^DPT(), DA (TIU document ID:^TIU(8925,DA)
 ;
 N I,GMRCDA,GMRCM,STATUS,POSTSIGC,PARDOCTY,OK,TIUTYP
 ;SET HL7 VARIABLES
 N FS,CS,RS,ES,SS,MID,HLQUIT,HLNODE
 N MSG,HDR,SEG,SEGTYPE,MSGARY,LASTSEG,HDRTIME,ABORT,BASEDT,CLINARY,COUNT,PROVDTL
 ;
 I +$G(DA)'>0 S ^TMP("TIUHL7CCRA",$J,"ERR NO TIU Document IEN("_DA_") passed from CPRS")="" Q
 ;Patch 329 fix thE undefined DFN, occuring  when  the user comes back in CPRS
 ;and signs a previously saved and unsigned note
 I $G(DFN)="" D
 . S DFN=$P($G(^TIU(8925,+DA,0)),"^",2)
 . I $G(DFN)="" S ^TMP("TIUHL7CCRA",$J,"ERR NO TIU Document IEN("_DA_") passed from CPRS")="" Q
 ;
 N SNAME,GMRCHL,ZERR,ZCNT,ECH,DATA,GDATA,URG,TYP,RES,EFFDT,PDUZ,PN,ADDR,PH,GMRCP,SENS,DX,DXCODE
 N PCP,PCDUZ,PCPN,PCADDR,PCPH
 S SNAME="TIU CCRA-HSRM MDM-T02 SERVER"
 S GMRCHL("EID")=$$FIND1^DIC(101,,"X",SNAME)
 Q:'GMRCHL("EID")  D INIT^HLFNC2(GMRCHL("EID"),.GMRCHL)
 S ZERR="",ZCNT=0,ECH=$E(GMRCHL("ECH")) ;component separator
 S FS=$G(GMRCHL("FS"),"|")
 S CS=$E($G(GMRCHL("ECH")),1) S:CS="" CS="^"
 S RS=$E($G(GMRCHL("ECH")),2) S:RS="" RS="~"
 S ES=$E($G(GMRCHL("ECH")),3) S:ES="" ES="\"
 S SS=$E($G(GMRCHL("ECH")),4) S:SS="" SS="&"
 S MID=$G(GMRCHL("MID"))
 S (HLQUIT,HLNODE)=0
 ;
 S GMRCDA=$G(DA)
 S POSTSIGC=""
  ;Check if document DA passed in has  Addenda, and retrieve the most recent one
 I $D(^TIU(8925,"DAD",$G(DA)))=10 S GMRCDA=+$O(^TIU(8925,"DAD",$G(DA),99999999),-1)
 ;
 ;get TIU Note data in ^TMP
 S DATA=$NA(^TMP("TIUHL7CCRA",$J)) K @DATA
 ;file,record,field,parm,targetarray,errortargetarray,internal
 D GETS^DIQ(8925,GMRCDA,"*","IE",DATA)
 ;File 8925 data IN ^TMP
 S GDATA=$NA(^TMP("TIUHL7CCRA",$J,8925,+GMRCDA_","))
 ;Patch TIU*1*329 fix <undefined> When User picks up an unsigned  note  from another CPRS session-
 ;I DFN'=$G(@GDATA@(.02,"I")) S ^TMP("TIUHL7CCRA",$J,"ERR: CPRS Patient DFN :"_DFN_" doesn't match Document Patient DFN: "_$G(@GDATA@(.02,"I")))="" Q
 I $G(DFN)'=$G(@GDATA@(.02,"I")) S ^TMP("TIUHL7CCRA",$J,"ERR: CPRS Patient DFN :"_$G(DFN)_" doesn't match Document Patient DFN: "_$G(@GDATA@(.02,"I")))="" Q
 ;check if addendum DA is passed in and check if it is for Community
 S TIUTYP=$G(@GDATA@(.01,"E"))
 S OK=1
 I TIUTYP="ADDENDUM" D
 . ;check if parent title has the POST-SIGNATURE CODE
 . S PARDOCTY=+$G(^TIU(8925,$G(DA),0))
 . I +$G(PARDOCTY)<=0 S OK=0
 . S POSTSIGC=$$GET1^DIQ(8925.1,PARDOCTY_",",4.9)
 . I POSTSIGC'["TIUCCRHL" S OK=0 S ^TMP("TIUHL7CCRA",$J,"ERR: TIU ADDENDA IS NOT SETUP TO SEND MHM-T02:"_POSTSIGC)=""
 . I $G(@GDATA@(.05,"E"))'="COMPLETED" S OK=0 S ^TMP("TIUHL7CCRA",$J,"ERR: TIU ADDENDA STATUS IS NOT COMPLETED:"_$G(@GDATA@(.05,"E")))=""
 I OK<1  Q  ;QUIT if addendum and original note does not have the CCRA HL7 trigger code
 ;
 ;start creating the segments.
 ;EVN Segment
 ;  EVN 1-Event Type Code:  "T02"
 ;  EVN 3-Recorded Date/Time: 1201     ENTRY DATE/TIME
 ;  EVN 4-Event Reason: can use "O"-Other / "02"-Physician/health practitioner order
 ;  EVN 5-Operator ID: 1202     AUTHOR/DICTATOR IEN(+DUZ)
 ;  EVN 6-Event Occurred: 1301     REFERENCE DATE
 ;  EVN 7-Event Facility: 1211     VISIT LOCATION (P44)
 ;
 S ZCNT=ZCNT+1
 S GMRCM(ZCNT)="EVN"_FS_"T02"_FS_FS_$$FMTHL7^XLFDT($G(@GDATA@(1201,"I")))_FS_"O"_FS_$G(@GDATA@(1202,"I"))
 S GMRCM(ZCNT)=GMRCM(ZCNT)_FS_$$FMTHL7^XLFDT($G(@GDATA@(1301,"I")))_FS_$G(@GDATA@(1211,"I"))_CS_$G(@GDATA@(1211,"E"))
 ;
 ;PID segment -  May be multiple nodes in the return array - make nodes 2-n sub nodes
 S DFN=$G(@GDATA@(.02,"I")),ZERR=""
 D BLDPID^VAFCQRY(DFN,1,"ALL",.GMRCP,.GMRCHL,ZERR)
 S I=0 F  S I=$O(GMRCP(I)) Q:'I  D
 .I I=1 S ZCNT=ZCNT+1,GMRCM(ZCNT)=$TR(GMRCP(I),"""") Q
 .S GMRCM(ZCNT,I)=$TR(GMRCP(I),"""")
 K GMRCP
 ; 
 ;PV1 segment
 D IN5^VADPT ;VAIP(18)=Attending Physician, VAIP(13,5)=Primary Physician for admission
 S ZCNT=ZCNT+1,GMRCM(ZCNT)="PV1"_FS_"1"_FS_$S(VAIP(13):"I",1:"O")_FS_FS_FS_FS_FS_VAIP(18)_FS
 I VAIP(5) S $P(GMRCM(ZCNT),FS,4)=VAIP(5) ;location for last movement event
 N GMRCDIV
 S GMRCDIV=$$NS^XUAF4(DUZ(2)),GMRCDIV=$P(GMRCDIV,CS,2) ; add in division value
 N A,B S A=SS_GMRCDIV,B=$P(GMRCM(ZCNT),FS,4),$P(B,CS,4)=A,$P(GMRCM(ZCNT),FS,4)=B K A,B
 K GMRCDIV
 ;
 S SENS=$$SSN^DPTLK1(DFN) I SENS["*SENSITIVE*" S $P(GMRCM(ZCNT),FS,17)="R" ;sensitive patient
 S $P(GMRCM(ZCNT),FS,18)=VAIP(13,5)
 K VAIP
 D KVA^VADPT
 ;
 ;TXA segment
 ;  TXA.1 Set ID - TXA: "1"
 ;  TXA.2 Document Type: .01      DOCUMENT TYPE
 ;  TXA.4 Activity Date/Time:  1301     REFERENCE DATE
 ;  TXA.8 Edit Date/Time: 1201     ENTRY DATE/TIME
 ;  TXA.12 Unique Document Number: GMRCDA   TIU note IEN
 ;  TXA.13 Parent Document Number: GMRCDA/DA        TIU note/ADDENDUM IEN
 ;  TXA.16 Unique Document File Name: ADDENDUM Parent Document Title
 ;   XA.17 Document Completion Status: .05      STATUS
 S ZCNT=ZCNT+1
 S GMRCM(ZCNT)="TXA"_FS_"1"_FS_$G(@GDATA@(.01,"E"))_FS_FS_$$FMTHL7^XLFDT($G(@GDATA@(1301,"I")))_FS_FS_FS_FS_$$FMTHL7^XLFDT($G(@GDATA@(1201,"I")))
 S GMRCM(ZCNT)=GMRCM(ZCNT)_FS_FS_FS_FS_GMRCDA_FS_$G(@GDATA@(.06,"I"))_FS_FS_FS_$G(@GDATA@(.06,"E"))_FS_$G(@GDATA@(.05,"E"))
 ;
 ;OBX segment
 ;      OBX.1-Set ID: 1
 ;      OBX.2-Value Type: "TX"
 ;      OBX.3-Observation Identifier:TIU note IEN (GMRCDA)
 ;      OBX.11-Observation result status codes interpretation: F (Final results)
 ;      OBX.14-Date/Time of the Observation:  1201 -TIU ENTRY DATE/TIME
 ;      OBX.16-ResponsibleObserver() : 1204     EXPECTED SIGNER /1208 EXPECTED COSIGNER
 N PRSIG1,PRSIG2
 S ZCNT=ZCNT+1
 S GMRCM(ZCNT)="OBX"_FS_"1"_FS_"TX"_FS_GMRCDA_FS_FS_FS_FS_FS_FS_FS_FS_"F"_FS_FS_FS_$$FMTHL7^XLFDT($G(@GDATA@(1201,"I")))
 S GMRCM(ZCNT)=GMRCM(ZCNT)_FS_FS_$P($G(@GDATA@(1204,"E")),",",1)_CS_$P($G(@GDATA@(1204,"E")),",",2)
 S GMRCM(ZCNT)=GMRCM(ZCNT)_SS_$P($G(@GDATA@(1208,"E")),",",1)_CS_$P($G(@GDATA@(1208,"E")),",",2)
 ;
 ;NTE segment
 D NTE(.GMRCHL)
 ;
 ;Send HL7 Message
 N HL,HLA,GMRCRES,GMRCHLP
 M HL=GMRCHL,HLA("HLS")=GMRCM
 M GMRCHL=^XTMP("TIUHL7CCRA","MESSAGE")
 D GENERATE^HLMA(GMRCHL("EID"),"LM",1,.GMRCRES,"",.GMRCHLP)
 K ^TMP("TIUHL7CCRA",$J)
 Q
NTE(HL) ; Find TIU and build NTE segments
 N NTECNT,X S NTECNT=1
 D AUTHDTTM
 ; Build NTE for CM^ADDENDED
 N GMRCCMP
 S GMRCCMP=""
 S ZCNT=ZCNT+1,GMRCM(ZCNT)="NTE"_FS_NTECNT_FS_"P"_FS_"Progress Note:"_$G(@GDATA@(.01,"E"))
 ;check if Document Type is ADDENDUM
 S TIUTYP=$G(@GDATA@(.01,"E"))
 I TIUTYP="ADDENDUM" D
 . S GMRCCMP=$$DATE^GMRCCCRA($G(@GDATA@(1301,"I")),"MM/DD/CCYY")_" ADDENDUM"_"                      STATUS: "_$$GET1^DIQ(8925,+GMRCDA_",",.05)
 S I=0
 F  S I=$O(@GDATA@(2,I)) Q:+I=0  S X=@GDATA@(2,I) D
 .S X=$$TRIM^XLFSTR(X) I $L(X)=0 Q
 .S X=$$TIUC(X) ; Check for control characters -emergency patch TIU*1.0*32
 .I $L(X)=0 Q
 .D HL7TXT^GMRCHL7P(.X,.HL,"\")
 .S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE"_FS_NTECNT_FS_FS_X
 Q
 ;
AUTHDTTM ; Add Author and Date/Time to NTE
 S ZCNT=ZCNT+1,GMRCM(ZCNT)="NTE"_FS_NTECNT_FS_FS_"Author\R\\R\"_$G(@GDATA@(1202,"E"))
 S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE"_FS_NTECNT_FS_FS_"Datetime\R\\R\"_$$FMTHL7^XLFDT($G(@GDATA@(1201,"I")))
 S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE"_FS_NTECNT_FS_FS_"Comment\R\\R\"
 S NTECNT=4
 Q
 ;
TIME(X,FMT) ; Copied from $$TIME^TIULS
 ; Receives X as 2910419.01 and FMT=Return Format of time (HH:MM:SS).
 N HR,MIN,SEC,TIUI
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="HR:MIN"
 S X=$P(X,".",2),HR=$E(X,1,2)_$E("00",0,2-$L($E(X,1,2))),MIN=$E(X,3,4)_$E("00",0,2-$L($E(X,3,4))),SEC=$E(X,5,6)_$E("00",0,2-$L($E(X,5,6)))
 F TIUI="HR","MIN","SEC" S:FMT[TIUI FMT=$P(FMT,TIUI)_@TIUI_$P(FMT,TIUI,2)
 Q FMT
DATE(X,FMT) ; Copied from $$DATE^TIULS
 ; Call with X=2910419.01 and FMT=Return Format of date ("MM/DD")
 N AMTH,MM,CC,DD,YY,TIUI,TIUTMP
 I +X'>0 S $P(TIUTMP," ",$L($G(FMT))+1)="",FMT=TIUTMP G QDATE
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="MM/DD/YY"
 S MM=$E(X,4,5),DD=$E(X,6,7),YY=$E(X,2,3),CC=17+$E(X)
 S:FMT["AMTH" AMTH=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+MM)
 F TIUI="AMTH","MM","DD","CC","YY" S:FMT[TIUI FMT=$P(FMT,TIUI)_@TIUI_$P(FMT,TIUI,2)
 I FMT["HR" S FMT=$$TIME(X,FMT)
QDATE Q FMT
 ;
ACK ; Process ACK HL7 messages
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
MESSAGE(MSGID,ERRARY) ; Send a MailMan Message with the errors
 N MSGTEXT,DUZ,XMDUZ,XMSUB,XMTEXT,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMZ,XMMG,DATE,J
 S DATE=$$FMTE^XLFDT($$FMDATE^HLFNC($P(HL("DTM"),"-",1)))
 S XMSUB="TIU CCRA Consults to HSRM HL7 Error"
 S MSGTEXT(1)=" "
 S MSGTEXT(2)="Error in transmitting HL7 message to HSRM"
 S MSGTEXT(3)="Date:       "_DATE
 S MSGTEXT(4)="Message ID: "_MSGID
 S MSGTEXT(5)="Error(s):"
 S I=0,J=5 F  S I=$O(ERRARY(I)) Q:'I  D
 . S J=J+1,MSGTEXT(J)=" "
 . S J=J+1,MSGTEXT(J)="   "_$P($G(ERRARY(I,3)),U)_" - "_$P($G(ERRARY(I,3)),U,2)
 . I $P($G(ERRARY(I,2)),U,1)'="" S J=J+1,MSGTEXT(J)="      Segment:       "_$P($G(ERRARY(I,2)),U,1)
 . I $P($G(ERRARY(I,2)),U,2)'="" S J=J+1,MSGTEXT(J)="      Sequence:      "_$P($G(ERRARY(I,2)),U,2)
 . I $P($G(ERRARY(I,2)),U,3)'="" S J=J+1,MSGTEXT(J)="      Field:         "_$P($G(ERRARY(I,2)),U,3)
 . I $P($G(ERRARY(I,2)),U,4)'="" S J=J+1,MSGTEXT(J)="      Fld Rep:       "_$P($G(ERRARY(I,2)),U,4)
 . I $P($G(ERRARY(I,2)),U,5)'="" S J=J+1,MSGTEXT(J)="      Component:     "_$P($G(ERRARY(I,2)),U,5)
 . I $P($G(ERRARY(I,2)),U,6)'="" S J=J+1,MSGTEXT(J)="      Sub-component: "_$P($G(ERRARY(I,2)),U,6)
 S XMTEXT="MSGTEXT("
 S XMDUZ="TIU-CCRA->HSRM Transaction Error"
 S XMY("G.GMRC HCP HL7 MESSAGES")=""
 D ^XMD
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
