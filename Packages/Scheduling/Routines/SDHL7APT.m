SDHL7APT ;MS/TG,PH - TMP HL7 Routine;AUG 17, 2018
 ;;5.3;Scheduling;**704,714,754,773,780,798,810,817,821,848,859,863,879**;Aug 13, 1993;Build 31
 ;
 ;  Integration Agreements:
 ;
 ;879 MRTC changes, includes when Cancel appt then re-close Req file entry of 2nd site appt for a 1st RTC site appt.
 ;    Had to move a lot of code out to SDTMPAPU due to 15k limits.
 ;    All ERRTXT msg text extracts set to up to 99.
 Q
 ;
PROCSIU ;Process SI^S12 messages from the "TMP VISTA" Subscriber protocol
 ;
 ; This routine and subroutines assume that all VistA HL7 environment
 ; variables are properly initialized and will produce a fatal error
 ; if they are missing.
 ;  ;879 code moved here
 ;  The message will be checked to see if it is a valid SIU. If valid - the SIU will process the 1st RGS group
 ;  on the current facility. Any subsequent RGS groups will be sent to facilities as specified in AIL.3.4
 ;  In the event the appointment does not file on the remote facility (i.e. an AE is received from that remote facility)
 ;  an AE (with the appropriate error text) will be returned to HealthShare.
 ;  Input:
 ;          HL7 environment variables
 ;
 ; Output:
 ;          Positive (AA) or negative acknowledgement (AE - with appropriate error text)
 ;
 ;  Integration Agreements: NONE
 ;
 ; The incoming HL7 msg from HealthConnect always is sent to the Patient VAMC side only, then half way thru this code of receiving this HL7
 ; we will wrap up the Provider side HL7 data and pause the Patient side processing and send that HL7 directly to the Provider VAMC's HL7 
 ; listener. If the Provider side comes back successful, then the Patient side HL7 processing resumes. However, if the Provider side failed,
 ; then we should trap that error and abort Patient side processing and send a negative ACK back to HealthConnect and quit.
 ;
 N MSGROOT,DATAROOT,QRY,XMT,ERR,RNAME,IX,REQIEN,SAVTYP     ;817 reqien
 K SDTMPHL
 S (MSGROOT,QRY,XMT,ERR,RNAME)=""
 S U="^"
 ;
 ; Inbound SIU messages are small enough to be held in a local array.
 ; The following lines commented out support use of temporary globals and are
 ; left for debugging purposes.
 ;
 S MSGROOT="SDHL7APT"
 K @MSGROOT
 N EIN S EIN=HL("EID") ;ien of HL7 server receiving msg 821
 D LOADXMT^SDHL7APU(.HL,.XMT)         ;Load inbound message information
 K ACKMSG S ACKMSG=$G(HL("MID"))
 S RNAME=XMT("MESSAGE TYPE")_"-"_XMT("EVENT TYPE")_" RECEIVER"
 ;
 N CNT,SEG
 K @MSGROOT
 D LOADMSG^SDHL7APU(MSGROOT)
 D PARSEMSG^SDHL7APU(MSGROOT,.HL)
 ;
 N APPTYPE,AILNTE,DFN,RET,CNT,PID,PV1,RGS,AIS,AIG,AISNTE,OVB,OFFSET,AIP,RTCID,AIPNTE,INP,SETID,EXTIME,SCHNTE,SCH,SDMTC,QRYDFN,MSGCONID,LST,MYRESULT,HLA,PTIEN,SCPER,ATYPIEN
 N AIGNTE,AIL,ARSETE,CURDTTM,ERROR,FLMNFMT,EESTAT,GRPCNT,GRPNO,OBX,PREVSEG,PTIEN,SCHDFN,SCPERC,SDDDT,SDECATID,SDUSER,CHILD,MSAHDR,SDECTYP
 N SDECCR,SDECEND,SDECLEN,SDECNOTE,SDECRES,SDECSTART,SDECY,SDEKG,SDEL,SDID,SDLAB,SDMRTC,SDPARENT,SDCHILD,SDECAPTID,SDECDATE
 N SDREQBY,SDSVCP,SDSVCPR,INTRA,SDXRAY,SEGTYPE,INST,FLMNFMT2,SDAPTYP,STA,STATUS,STOP,PROVIEN,ERRCND,ERRSND,ERRTXT,URL,MSH,SDECNOT,RTN,SDCL
 ;
 S (MSGCONID,SCHDFN)=""
 S CNT=1,SETID=1,PREVSEG="",GRPCNT=0,PTIEN="",ERRTXT="",ERRSND=""
 ;
 ; Loop to build HL7 message segment arrays.
 S MSAHDR="MSA^1^^100^AE^"
 D LOOPMSG^SDHLAPT2(.ERR,.ERRTXT)    ;879 code moved here
 I ERR S ERRTXT=$G(MSAHDR)_$E(ERRTXT,1,99) D SENDERR^SDHL7APU(ERRTXT) K @MSGROOT Q
 K SCHNW,INP,PCE,SCPER,ATYPIEN
 ; Loop to build MSGARY and segment arrays
 N MSGARY,SDCL,SDCL2,SDCL3
 D BLDARRAYS^SDHLAPT2(.ERR,.ERRTXT)  ;879 code moved here
 I ERR S ERRTXT=$G(MSAHDR)_$E(ERRTXT,1,99) D SENDERR^SDHL7APU(ERRTXT) K @MSGROOT Q
 ; set what mode working on based on AIL(s) received
 I $D(AIL(1)),$D(AIL(2)) S SDPATMODE=1
 I $D(AIL(1)),'$D(AIL(2)) S SDPRVMODE=1     ;879
 ;
 N %,NOW
 D NOW^%DTC S CURDTTM=$$TMCONV^SDTMPHLA(%,$$KSP^XUPARAM("INST")) ;773
 S NOW=$$HTFM^XLFDT($H),INP(3)=$$FMTE^XLFDT(NOW)
 S INP(11)=INP(3)
 S INP(5)="APPT"
 S INP(8)="FUTURE"
 ;
 N X11 S X11=$P($G(SDAPTYP),"|") S:$G(X11)="" X11="A"
 S INP(9)=$S(X11="A":"PATIENT",1:"PROVIDER") ;request by provider or patient. RTC orders and consults are usually PROVIDER otherwise it is PATIENT
 K DFN
 S (DFN,INP(2))=$$GETDFN^MPIF001(MSGARY("MPI"))
 I $P(DFN,U,2)="NO ICN"!($P(DFN,U,2)="ICN NOT IN DATABASE") D  Q
 .S ERR=$G(MSAHDR)_"PATIENT ICN NOT FOUND"
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 ;
 N STOPME S STOPME=0
 I $P($G(SDAPTYP),"|",1)="C"!($P($G(SDAPTYP),"|",1)="R") D CHKCON^SDHLAPT2(DFN,SDAPTYP) Q:STOPME
 I $G(SDCL)="" D  Q
 .S ERR=$G(MSAHDR)_"CLINIC ID IS NULL",STOPME=1
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 Q:STOPME
 I '$D(^SC($G(SDCL),0)) D  Q
 .Q:$G(AIL(1,3,1,4))'=$P(^DIC(4,$$KSP^XUPARAM("INST"),99),"^")
 .S ERR=$G(MSAHDR)_"NOT A CLINIC AT THIS SITE "_$G(SDCL)
 .K @MSGROOT
 S STOPME=0
 I $G(SDCL2)>0 D
 .Q:$G(AIL(2,3,1,4))'=$P(^DIC(4,$$KSP^XUPARAM("INST"),99),"^")
 .I '$D(^SC($G(SDCL2),0)) S ERR=$G(MSAHDR)_"NOT A CLINIC AT THIS SITE "_$G(SDCL2),STOPME=1 D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 Q:STOPME
 ;
 ; 879 Corrections for REQ file updating via sdaptyp pce 2.  AIL group 1 is always the one being filed to REQ file. Goal below to get child ien = to what needs to be filed in RFEQ file 409.85
 D APPTSCENARIO^SDHLAPT2          ;Determine scenario and set parent, child and SDAPTYP prior to building INP segment next
 I $G(SDCLNERR)'="" D                ;New possible error scenario with RTCs
 .S:$G(SDPATMODE) SDPATCLNERR=SDCLNERR_" "_SDCL_" & "_SDRTCCLIN
 .S:$G(SDPRVMODE) SDPRVCLNERR=SDCLNERR_" "_SDCL_" & "_SDRTCCLIN
 .S STOPME=1,ERRCND=9999
 I $G(SDPATCLNERR)'="",STOPME D    ;send Patient clnerr NAck back to calling HC and quit entire process
 .I '$G(STA) S STA=$G(AIL(1,3,1,4)) S STA=$$GETSTA^SDHL7APU(STA)
 .S ERRTXT=SDPATCLNERR,ERRTXT=$E(ERRTXT_" - PATIENT FACILITY #"_$G(STA),1,99)
 I $G(SDPRVCLNERR)'="",STOPME D    ;send Provider clnerr NAck back to calling pat side vamc and quit prv side processing
 .S ERRTXT=SDPRVCLNERR_" - PROVIDER FACILITY"
 .;D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 I STOPME G ACK
 ;
 K INP D INP^SDHL7APU             ;Build INP for ARSET call
 S RET=""
 ;IF a regular or rtc appt, Not Consult, check to see if the appointment is in 409.85 and add if needed by arset
 I ($P(SDAPTYP,"|")="A")!($P(SDAPTYP,"|")="R"&$G(AIL(1,4,1,2))="R") D
 .Q:$$UPPER^SDUL1(MSGARY("HL7EVENT"))'="S12"
 .S:INP(3)="" INP(3)=DT S RTN=0 D ARSET^SDECAR2(.RTN,.INP)   ;set Req for Pat site
 .S REQIEN=+$P(RTN,$c(30),2),SDAPTYP="A|"_REQIEN    ;817- define REQIEN for later  ;810- SDECAR2 routine should be used instead of SDHLAPT1 version of ARSET
 ;
 ;714 - PB get the division associated with the clinic and pass to the function to convert utc to local time
 N TMPSTART,D1,D2
 S:$G(SDCL)>0 D1=$P(^SC(SDCL,0),"^",15),D2=$$GET1^DIQ(40.8,D1_",",.07,"I")
 S FLMNFMT=$$JSONTFM^SDHLAPT2(SDECSTART,D2),TMPSTART=FLMNFMT,SDECSTART=$$FMTE^XLFDT(FLMNFMT)
 I FLMNFMT<1 D  Q
 .S ERR=$G(MSAHDR)_"Invalid Start Date sent"
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 ;
 ;PB - 714 fix to stop duplicate appointments for the patient
 S STOPME=0
 I $G(^DPT(DFN,"S",FLMNFMT,0))&($G(MSGARY("HL7EVENT"))="S12") D
 .Q:$P($G(^DPT(DFN,"S",FLMNFMT,0)),"^",2)["C"
 .S ERR=$G(MSAHDR)_"PATIENT ALREADY HAS AN APPT AT ON "_$$FMTE^XLFDT(FLMNFMT),STOPME=1
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 Q:STOPME
 S STOPME=0
 I $G(INTRA)=1 D
 .S FLMNFMT2=$$FMADD^XLFDT(FLMNFMT,,,5)
 .Q:$G(MSGARY("HL7EVENT"))'="S12"
 .I $D(^DPT(DFN,"S",FLMNFMT,0)) D
 ..I $P($G(^DPT(DFN,"S",FLMNFMT,0)),"^",2)'["C" D
 ...S ERR=$G(MSAHDR)_"PATIENT ALREADY HAS AN APPT AT ON "_$$FMTE^XLFDT(FLMNFMT2),STOPME=1
 ...D SENDERR^SDHL7APU(ERR)
 ...K @MSGROOT
 .Q:STOPME
 .I $D(^DPT(DFN,"S",FLMNFMT2,0)) D
 ..I $P($G(^DPT(DFN,"S",FLMNFMT2,0)),"^",2)'["C" D
 ...S ERR=$G(MSAHDR)_"PATIENT ALREADY HAS AN APPT AT ON "_$$FMTE^XLFDT(FLMNFMT2),STOPME=1
 ...D SENDERR^SDHL7APU(ERR)
 ...K @MSGROOT
 Q:STOPME
 I $L(SDECLEN),$L($G(SCH(10))) D
 .I $G(SCH(10))="MIN" S SDECEND=$$FMADD^XLFDT(FLMNFMT,,,$G(SDECLEN))
 .I $G(SCH(10))="HR" S SDECEND=$$FMADD^XLFDT(FLMNFMT,,$G(SDECLEN))
 ;
 N TMPARR,LEN
 S LEN=0,ERRSND=0,ERRTXT="",MSGROOT="SDTMPHL"
 K @MSGROOT
 ; ****  Intra/Inter Provider Site - Loop to send RGS 2 group to remote.  Abort both Patient & Provider Make Appt S12 process, if Provider facility returns an AE from Intra/Inter Make Appt ****
 F GRPNO=2:1:GRPCNT D  Q:+ERRSND
 .K @MSGROOT
 .S CNT=1,INTRA=0
 .I $D(SCH) S @MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.SCH,.HL),LEN=LEN+$L(@MSGROOT@(CNT)) K FCHILD
 .I $D(SCHNTE) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.SCHNTE,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .I $D(PID) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.PID,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .I $D(PV1) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.PV1,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .M TMPARR=RGS(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AIS(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AISNTE(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AIG(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AIL(GRPNO)
 .I $D(TMPARR) D
 ..S STA=$G(TMPARR(3,1,4)) S STA=$$GETSTA^SDHL7APU(STA)
 ..S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AILNTE(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AIP(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AIPNTE(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .S:$G(AIL(1,3,1,4))=$G(AIL(2,3,1,4)) INTRA=1
 .I $G(INTRA)=1 D NEWTIME^SDHLAPT2
 .N HLRESLT,X
 .I $G(INTRA)=0,'$$CHKLL^HLUTIL($G(STA)) D  Q     ;821 quit@single dot, so errtxt can be sent now
 ..S ERRSND=1,ERRTXT=$E("Invalid Link assoc with institution: "_$G(STA),1,99)
 .N HLA,HLEVN   ;821 new instead of kill
 .N MC,HLFS,HLCS,IXX
 .F IXX=1:1:CNT S HLA("HLS",IXX)=$G(@MSGROOT@(IXX))
 .M HLA("HLA")=HLA("HLS")
 .;the following HL* variables are created by DIRECT^HLMA
 .N HL,HLCS,HLDOM,HLECH,HLFS,HLINST,HLINSTN,HLMTIEN,HLNEXT,HLNODE,HLPARAM,HLPROD,HLQ,HLQUITQ,SDLINK,OROK,MSASEG,ERRRSP
 .N AIL,INP,SDPARENT,SDCHILD,SDMRTC,SDAPTYP,SDPATMODE,SDPRVMODE       ;879 More News so these are preserved, when Patient site filing resumes After Intra/Inter call
 .;  more HL News, to protect Orig incoming HL* variables vs Intra/Inter msgs occurring real time below.   ;821
 .N HLL,HLMTIENS,HL771RF,HL771SF,HLARTYP,HLASTMSG,HLASTRSP,HLDBACK,HLDBSIZE,HLDP,HLDREAD,HLDRETR,HLDWAIT,HLIED,HLEIDS,HLENROU,HLFORMAT,HLHDRO,HLLSTN,HLMIDAR
 .N HLORNOD,HLOS,HLP,HLPID,HLPROU,HLQUIT,HLREC,HLRESLT,HLRETRA,HLFREQ,HLTCP,HLTCPADD,HLTCPCS,HLTPCI,HLTCPLNK,HLTCPO,HLTCPORT,HLTCPRET,HLTMBUF,HLEXROU,HLMTIENA
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S12" D
 ..K HL
 ..D:$G(INTRA)=0 INIT^HLFNC2("SD IFS EVENT DRIVER",.HL)
 ..D:$G(INTRA)=1 INIT^HLFNC2("SD TMP SEND INTRAFACILITY",.HL) ;if intra
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S15" D
 ..K HL
 ..D:$G(INTRA)=0 INIT^HLFNC2("SD TMP S15 SERVER EVENT DRIVER",.HL)
 ..D:$G(INTRA)=1 INIT^HLFNC2("SD TMP SEND CANCEL INTRA",.HL) ;if intra
 .I $G(STA)="" S STA=$G(AIL(2,3,1,4)),STA=$$GETSTA^SDHL7APU(STA)
 .D LINK^HLUTIL3(STA,.SDLINK,"I")
 .S SDLINK=$O(SDLINK(0))
 .I SDLINK="" D  Q
 ..Q:$G(INTRA)=1
 ..S ERRSND=1,ERRTXT=$E("Message link undefined for facility: "_$G(STA),1,99)
 .S SDLINK=SDLINK(SDLINK)
 .;817 removed code setting HLL("LINKS") for INTRA type appts. Not used for internal HL7 processing. TMP-1559
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S12" D
 ..S:$G(INTRA)=0 HLL("LINKS",1)="SD IFS SUBSCRIBER"_U_$G(SDLINK)
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S15" D
 ..S:$G(INTRA)=0 HLL("LINKS",1)="SD TMP S15 CLIENT SUBSCRIBER"_U_$G(SDLINK)
 .S HLMTIEN=""
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S12" D
 ..D:$G(INTRA)=0 DIRECT^HLMA("SD IFS EVENT DRIVER","LM",1,.OROK)
 ..I $G(INTRA)=1 D GENERATE^HLMA("SD TMP SEND INTRAFACILITY","LM",1,.OROK) S HLMTIEN=+OROK
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S15" D
 ..D:$G(INTRA)=0 DIRECT^HLMA("SD TMP S15 SERVER EVENT DRIVER","LM",1,.OROK)
 ..I $G(INTRA)=1 D GENERATE^HLMA("SD TMP SEND CANCEL INTRA","LM",1,.OROK) S HLMTIEN=+OROK
 .; check for provider rtc clinic error
 .I $G(SDPRVCLNERR)'="" S ERRSND=1,ERRCND=9999,ERRTXT=$E(SDPRVCLNERR_" PROVIDER FACILITY #"_$G(STA),1,99) Q    ;check for prv mode found a clnerr that now needs to be sent back to HC
 .I 'HLMTIEN S ERRSND=1,ERRTXT=$E("ERROR-PROVIDER FACILITY #"_$G(STA)_":"_$P(OROK,U,2)_":"_$P(OROK,U,3),1,99) Q   ;821 increase all Errtxt from 48 to 99
 .K @MSGROOT
 .I $G(INTRA)=0 D
 ..N HLNODE,SEG,I,RESP,IK
 ..F IK=1:1 X HLNEXT Q:HLQUIT'>0  D
 ...S RESP(IK)=HLNODE
 ..S MSASEG=$G(RESP(2))
 ..I $E(MSASEG,1,3)="MSA",$P(MSASEG,"|",2)="AE" S ERRSND=1,ERRTXT=$$STRIP^SDHL7APU($P(MSASEG,"|",4)),ERRTXT=$E(ERRTXT,1,99)
 ;
 I +ERRSND D  Q            ;**** If ERROR do not continue to file step ****
 .I $G(SDPRVCLNERR)="" S ERR=$G(MSAHDR)_ERRTXT D SENDERR^SDHL7APU(ERR)
 .I $G(SDPRVCLNERR)'="" S ERRCND=9999 D ACK^SDHL7APU   ;send nack to initial incoming HC HL7 msg
 .K @MSGROOT
 ;
 ;Begin Appt filing of AIL(1) info
 K @MSGROOT
 S (SDSVCP,SDSVCPR,SDEKG,SDXRAY,SDLAB,SDECCR,SDECY,SDID,APPTYPE,EESTAT,SDEL)="",SDCL=$G(AIL(1,3,1,1))
 S SDECRES=$$RESLKUP^SDHL7APU($G(SDCL))
 S SDECRES=SDECRES,OVB=1
 S (SDMRTC,MSGARY("SDMRTC"))=$S($G(SDMRTC)=1:"TRUE",1:"FALSE"),SDLAB="",PROVIEN=$G(MSGARY("PROVIEN"))
 I $G(AIL(1,4,1,2))="A" S $P(SDAPTYP,"|",1)="A"   ;879 correct for Pat site update
 S (ERRCND,ERRTXT)=""
 N SUCCESS
 S SUCCESS=0
 S (PROVIEN,DUZ)=$G(MSGARY("DUZ"))
 S:$G(DUZ)="" (PROVIEN,DUZ)=.5
 S:$G(DUZ(2))="" DUZ(2)=$G(MSGARY("HLTHISSITE"))
 S (INP(11),SDDDT)=$G(SCH(11,1,8))
 ;
 ;   Begin S12 processing (make)
 I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S12" D
 .S URL=$G(AILNTE)
 .I $P($G(SDAPTYP),"|")="A"&($G(SDAPT)>0) D
 ..;S $P(SDAPTYP,"|",2)=SDAPT      ; *848 - this 409.84 ien should not be set in SDAPTYP, which is a 409.85 file variable
 ..S:$G(SDDDT)="" (INP(11),SDDDT)=$P(SDECSTART,"@",1),SDECATID="WALKIN"
 .S:$G(AIL(1,4,1,2))="A" SDPARENT=""
 .S SAVTYP=$G(SDAPTYP)   ;save prior to forcing to A
 .S:$P($G(SDAPTYP),"|",1)="R" $P(SDAPTYP,"|",1)="A"   ;changing R to A now for sdec07
 .I $$APPTYPE^SDHL7APU(SDCL)=1 S APPTYPE=1  ;780
 .I $$PATCH^XPDUTL("SD*5.3*694") S SDECEND=$$FMTE^XLFDT(SDECEND)
 .D APPADD^SDEC07(.SDECY,SDECSTART,SDECEND,DFN,SDECRES,SDECLEN,SDECNOTE,SDECATID,SDECCR,SDMRTC,SDDDT,SDREQBY,SDLAB,PROVIEN,SDID,SDAPTYP,SDSVCP,SDSVCPR,SDCL,SDEKG,SDXRAY,APPTYPE,EESTAT,OVB,$G(SDPARENT),SDEL) ;ADD NEW APPOINTMENT
 .K SDAPT S SDAPT=+$P($G(^TMP("SDEC07",$J,2)),"^") ;if appointment is made this is the appointment number ien from 409.84
 .I SDAPT,$G(SDMTC) D    ;insure node 2 of parent mrtc is in sync when a child of MRTC is used in a make appt
 ..N TMPPARENT S TMPPARENT=$G(SCH(24,1,1)) I TMPPARENT,$P($G(SAVTYP),"|")="R",$G(SDCHILD),SDCHILD'=TMPPARENT D AR433^SDECAR2(TMPPARENT,SDAPT_"~"_SDCHILD)
 .S URL=$G(AILNTE)
 .D:$L(URL) GETAPT^SDHL7APU(URL,SDCL,$G(TMPSTART)) ; If the appointment has been made in SDEC(409,84, update the url in the Hospital Location file.
 .N TMP2 S TMP2=$G(^TMP("SDEC07",$J,2))
 .I ((+$P(TMP2,"^",1)>0)&($L($P(TMP2,"^",3))<1)) S SUCCESS=1
 .I SUCCESS=0 S ERRTXT=$P($G(^TMP("SDEC07",$J,2)),"^",3)
 .I ((SUCCESS=0)&(ERRTXT="")) D
 ..S ERRTXT=$P($G(^TMP("SDEC07",$J,3)),"^",2)
 .I $L(ERRTXT) S ERRCND=9999
 .S DUZ(2)=$G(STA)
 .;   APPT made, so close out and update Req record
 .I $G(SUCCESS)>0 D   ;close/disposition REQIEN
 ..N RET,INPA S INPA(1)=$S($G(REQIEN):REQIEN,1:$P(SDAPTYP,"|",2)),INPA(2)="SA",INPA(3)=$G(DUZ),DUZ(2)=$G(STA),INPA(4)=$$FMTE^XLFDT(DT) D ARCLOSE^SDECAR(.RET,.INPA)    ;INPA(1) is the IEN of Req file
 ..I (($G(AIL(1,4,1,2))="R")!($G(AIL(1,2))="R")),$G(SDMTC),SDPARENT,SDCHILD'=SDPARENT D MRTCCLOSEOUT^SDHLAPT2            ;879 MRTC parent and children Closeout processing
 ;
 ;  Begin S15 processing (cancel)
 I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S15" D
 .N XDT,%D,X,Y,STARTDT,ERRTXT,ERRCND
 .S SDECCR=$G(SCH(6,1,2)),SDUSER=$G(MSGARY("DUZ"))
 .S:$G(SDUSER)="" SDUSER=.5
 .S %DT="RXT",X=SDECSTART D ^%DT S STARTDT=Y
 .S SDECAPTID=$$GETAPP^SDHLAPT1(DFN,SDECRES,STARTDT)
 .S DUZ=$G(MSGARY("DUZ"))
 .S:$G(DUZ)="" DUZ=.5
 .S:$G(DUZ(2))="" DUZ(2)=$G(MSGARY("HLTHISSITE"))
 .;  cancel appt.
 .D APPDEL^SDEC08(.SDECY,SDECAPTID,SDECTYP,$G(SDECCR),$G(SDECNOT),$G(SDECDATE),$G(SDUSER))
 .I $G(AIL(1,4,1,2))="A",$G(AIL(1,4,1,4))="",$D(AIL(2,4,1,2)),$G(SDECAPTID) D   ;879 Close the stubbed in on the fly site Regular Request marked "A", as (NN), no longer necessary after a cancel of inter/intra.
 ..N RET,INPA S INPA(1)=+^SDEC(409.84,SDECAPTID,2),INPA(2)="NN",INPA(3)=$G(DUZ),DUZ(2)=$G(STA),INPA(4)=$$FMTE^XLFDT(DT) D ARCLOSE^SDECAR(.RET,.INPA)
 .S ERRTXT=$P($G(^TMP("SDEC",$J,2)),"^")
 .I +$L(ERRTXT)>0 S ERRCND=9999
 .D CHKCAN^SDHLAPT2(DFN,SDCL,STARTDT)
 .I $G(SDPARENT) D
 ..N SDMTC S SDMTC=$P($G(^SDEC(409.85,SDPARENT,3)),U,1)                              ;879 set SDMTC flag
 ..I (($G(AIL(1,4,1,2))="R")!($G(AIL(1,2))="R")),SDMTC,SDPARENT,SDCHILD'=SDPARENT D MRTCREOPEN^SDHLAPT2     ;879 MRTC parent and children Reopen processing
 ;
ACK ;
 D ACK^SDHL7APU
 K:'$G(SDPRVMODE) SDPRVMODE,SDPATMODE,SDPRVCLNERR,SDPATCLNERR,SDCLNERR,SDRTCCLIN    ;879 kill only when not prvmode, that has finished running and in final of patmode
 Q
