PXRPC ;ISL/JLC - PCE DATA2PCE RPC ;Jul 20, 2021@08:24:07
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**200,209,210,215,216,211,217**;Aug 12, 1996;Build 134
 ;
 ; Reference to UCUMDATA^LEXMUCUM supported by ICR #6225
 ;
 ;
SAVE(OK,PCELIST,LOC,PKGNAME,SRC,PXAVST,PXRETVST) ; save PCE information
 ;
 N PXRET
 ;
 D SAVE2(.PXRET,.PCELIST,.PKGNAME,.SRC,.PXAVST)
 S OK=$G(PXRET(0))
 I '$G(PXRETVST) S OK=$P(OK,U,1)
 Q
 ;
SAVE2(OK,PCELIST,PKGNAME,SRC,PXAVST) ; save PCE information - and return err info
 ;
 N PXAPI,PXERRTYP,PKG,PROBLEMS,PXAPREDT,PXIMMRDAPI
 ;
 S PXERRTYP="INPUT_ERR"
 ;
 I $G(PKGNAME)="" D  Q
 . S OK(0)=-3
 . S OK(1)=PXERRTYP_U_U_U_U_U_"Package Name argument not defined."
 I $G(SRC)="" D  Q
 . S OK(0)=-3
 . S OK(1)=PXERRTYP_U_U_U_U_U_"Source argument not defined."
 S PKG=$$PKG2IEN^VSIT(PKGNAME)
 I PKG=-1 D  Q
 . S OK(0)=-3
 . S OK(1)=PXERRTYP_U_U_U_U_U_"Package, '"_PKGNAME_"', does not exist in the Package file (#9.4)."
 ;
 D DQSAVE(.PCELIST,.PXAPI,.PROBLEMS,.SRC,.PXIMMRDAPI)
 I '$D(PXAPI) D  Q
 . S OK(0)=-3
 . S OK(1)=PXERRTYP_U_U_U_U_U_"'PCELIST' argument not valid."
 ;
 S PXAPREDT=1 ;Flag to allow edit of primary provider
 D DATA2PCE(.OK,"PXAPI",PKG,SRC,PXAPREDT,.PXAVST)
 ;
 ; save immunization reading (for smallpox) in a seperate DATA2PCE call
 ; as it is part of the placement visit.
 I $D(PXIMMRDAPI) D
 . D IMMREAD(.OK,.PXIMMRDAPI,PKG,SRC,PXAPREDT)
 ;
 Q
 ;
IMMREAD(OK,PXIMMRDAPI,PKG,SRC) ; save immunization reading (for smallpox)
 ;
 N PXAPREDT,PXERROR,PXERRCOUNT,PXI,PXTEMP,PXVISIT,OK2
 ;
 S PXERRCOUNT=+$O(OK(""),-1)
 ;
 S PXERROR=$G(PXIMMRDAPI("IMMUNIZATION",1,"ERROR"))
 S PXVISIT=$G(PXIMMRDAPI("IMMUNIZATION",1,"VISIT"))
 K PXIMMRDAPI("IMMUNIZATION",1,"ERROR")
 K PXIMMRDAPI("IMMUNIZATION",1,"VISIT")
 I PXERROR'="" D  Q
 . I +OK(0)>0 S $P(OK(0),U,1)=-1
 . S PXERRCOUNT=PXERRCOUNT+1
 . S OK(PXERRCOUNT)="ERROR_IMM_READING"_U_U_U_U_U_PXERROR
 I 'PXVISIT D  Q
 . I +OK(0)>0 S $P(OK(0),U,1)=-1
 . S PXERRCOUNT=PXERRCOUNT+1
 . S OK(PXERRCOUNT)="ERROR_IMM_READING"_U_U_U_U_U_"Could not file Immunization Reading, as the Placement Visit could not be obtained."
 ;
 S PXAPREDT=1 ;Flag to allow edit of primary provider
 D DATA2PCE(.OK2,"PXIMMRDAPI",PKG,SRC,PXAPREDT,PXVISIT)
 I +OK2(0)<0,+OK(0)>0 S $P(OK(0),U,1)=$P(OK2(0),U,1)
 S PXI=0
 F  S PXI=$O(OK2(PXI)) Q:'PXI  D
 . S PXERRCOUNT=PXERRCOUNT+1
 . S PXTEMP=$G(OK2(PXI))
 . S OK(PXERRCOUNT)=$P(PXTEMP,U,1)_"_IMM_READING"_U_$P(PXTEMP,U,2,99)
 ;
 Q
 ;
DQSAVE(PCELIST,PXPCEARR,PROBLEMS,SRC,PXPCEIMMRD) ;
 ;
 ; Processes PCELIST input array and creates a new array in a format
 ; that can be passed into DATA2PCE^PXAPI.
 ;
 ;Input:
 ;   .PCELIST - (Required) Array passed by reference.
 ;              This should be in the same format as the PX SAVE DATA
 ;              and ORWPCE SAVE RPCs' PCELIST input parameter.
 ;  .PXPCEARR - (Required) The root of an array passed by reference
 ;              that this API will populate based off the PCELIST
 ;              argument. This array will be in a format that can be
 ;              passed into DATA2PCE^PXAPI.
 ;  .PROBLEMS - (Required) This API will populate this array with POV
 ;              entries that are marked to be added to the Problem List.
 ;       .SRC - (Required) The source of the data - such as 'TEXT
 ;              INTEGRATION UTILITIES'. This API can possibly change the
 ;              value of SRC, depending on the Health Factor (HF) values
 ;              contained in PCELIST.
 ;.PXPCEIMMRD - (Required) The root of an array passed by reference
 ;              that this API will populate based off the PCELIST argument.
 ;              It will only be populated if there is an immunization
 ;              reading. This array will be in a format that can be passed
 ;              into DATA2PCE^PXAPI.
 ;
 ;
 D DQSAVE^PXRPC1(.PCELIST,.PXPCEARR,.PROBLEMS,.SRC,.PXPCEIMMRD)
 Q
 ;
 ;
DATA2PCE(OK,PXPCEARR,PKG,SRC,PXAPREDT,PXAVST) ;
 N PXERROR,PXERRPROB
 I '($D(PXAVST)#2) S PXAVST=""
 S OK(0)=$$DATA2PCE^PXAI(PXPCEARR,PKG,SRC,.PXAVST,"",0,.PXERROR,PXAPREDT,.PXERRPROB)
 S OK(0)=OK(0)_U_$G(PXAVST)
 D ERROR(.OK,.PXERROR,.PXERRPROB)
 ;
 Q
 ;
ERROR(PXRET,PXERROR,PXERRPROB) ; Return errors
 ;
 N PXERRCOUNT,PXERRTYP,PXFIELD,PXFILE,PXIEN,PXMSG,PXNODE,PXNUM,PXSUB
 ;
 I '$D(PXERRPROB),'$D(PXERROR) Q
 S PXERRCOUNT=0
 ;
 S PXNODE="PXERROR"
 S PXERRTYP="ERROR_FILING"
 F  S PXNODE=$Q(@PXNODE) Q:PXNODE=""  D
 . S PXFILE=$QS(PXNODE,1)
 . S PXNUM=$QS(PXNODE,2)
 . S PXIEN=$QS(PXNODE,3)
 . S PXFIELD=$QS(PXNODE,4)
 . S PXSUB=$QS(PXNODE,5)
 . I PXSUB'="" S PXFIELD=PXFIELD_","_PXSUB
 . S PXMSG=$G(@PXNODE)
 . S PXERRCOUNT=PXERRCOUNT+1
 . S PXRET(PXERRCOUNT)=PXERRTYP_U_PXFILE_U_PXNUM_U_PXIEN_U_PXFIELD_U_PXMSG
 ;
 S PXNODE="PXERRPROB"
 F  S PXNODE=$Q(@PXNODE) Q:PXNODE=""  D
 . S PXERRTYP=$QS(PXNODE,3)
 . S PXFILE=$QS(PXNODE,4)
 . S PXFIELD=$QS(PXNODE,5)
 . S PXNUM=$QS(PXNODE,6)
 . S PXMSG=$G(@PXNODE)
 . I PXFILE="PX/DL",PXERRTYP="ERROR4" D
 . . S PXNUM=PXFIELD
 . . S PXFIELD=""
 . I PXFILE="ENCOUNTER",PXERRTYP="WARNING3" D
 . . S PXFIELD=PXNUM
 . . S PXNUM=1
 . S PXERRCOUNT=PXERRCOUNT+1
 . S PXRET(PXERRCOUNT)=PXERRTYP_U_PXFILE_U_PXNUM_U_U_PXFIELD_U_PXMSG
 ;
 Q
 ;
IMMSRC(IMMIS) ; Returns Event Info Source IEN
 N IMMISHL,IMMISIEN,X
 S IMMISHL=$P(IMMIS,";",1)
 S IMMISIEN=$P(IMMIS,";",2)
 ; Look up the value in the "H" Cross-reference
 I 'IMMISIEN D
 . S IMMISIEN=$$FIND1^DIC(920.1,,,IMMISHL,"H",,"IMMISERR")
 Q IMMISIEN
 ;
IMMROUTE(IMMRT) ; Returns Route IEN
 N IMMRTHL,IMMRTIEN,IMMRTNM,X
 S IMMRTNM=$P(IMMRT,";",1)
 S IMMRTHL=$P(IMMRT,";",2)
 S IMMRTIEN=$P(IMMRT,";",3)
 I 'IMMRTIEN,IMMRTHL'="" D
 . S IMMRTIEN=$$FIND1^DIC(920.2,,,IMMRTHL,"H",,"IMMRTERR")
 I 'IMMRTIEN,IMMRTNM'="" D
 . S IMMRTIEN=$$FIND1^DIC(920.2,,,IMMRTNM,"B",,"IMMRTERR")
 Q IMMRTIEN
 ;
IMMLOC(IMMAL) ; Returns Anatomic Location IEN
 N IMMALHL,IMMALIEN,IMMALNM,X
 S IMMALNM=$P(IMMAL,";",1)
 S IMMALHL=$P(IMMAL,";",2)
 S IMMALIEN=$P(IMMAL,";",3)
 I 'IMMALIEN,IMMALHL'="" D
 . S IMMALIEN=$$FIND1^DIC(920.3,,,IMMALHL,"B",,"IMMALERR")
 I 'IMMALIEN,IMMALNM'="" D
 . S IMMALIEN=$$FIND1^DIC(920.3,,,IMMALNM,"B",,"IMMALERR")
 Q IMMALIEN
 ;
IMMLOT(IMMLOT,IMMMANUF,IMMEXPDT) ; Returns Lot_IEN^Comment
 N IMMCOMM,IMMLOTIEN,IMMLOTNM,X
 S IMMLOTNM=$P(IMMLOT,";",1)
 S IMMLOTIEN=$P(IMMLOT,";",2)
 ;
 I IMMLOTIEN Q IMMLOTIEN
 ;
 ; If the Lot Number, Manufacturer and Expiration Date are all specified,
 ; then find an entry matching all three values in File 9999999.41 (IMMUNIZATION LOT)
 ; If we don't find a match, then add the fields to the Comment.
 ; For now, we will not receive the Expiration Date from Walgreens, so we always update the Comment.
 S IMMCOMM=""
 S:IMMLOTNM'="" IMMCOMM=IMMCOMM_$S(IMMCOMM="":"",1:" ")_"Lot#: "_IMMLOTNM
 S:IMMMANUF'="" IMMCOMM=IMMCOMM_$S(IMMCOMM="":"",1:" ")_"Mfr: "_IMMMANUF
 S:IMMEXPDT'="" IMMCOMM=IMMCOMM_$S(IMMCOMM="":"",1:" ")_"Expiration Date: "_IMMEXPDT
 Q "^"_IMMCOMM
 ;
IMMVIS(IMMVISMULT,PXPCEARR,IMM) ; Sets PXPCEARR's VIS multiple
 N IMMVIS,IMMVISDT,IMMVISENTRY,PXSEQ,PXX,X
 S PXSEQ=0
 F PXX=1:1:$L(IMMVISMULT,";") D
 . S IMMVISENTRY=$$TRIM^XLFSTR($P(IMMVISMULT,";",PXX))
 . S IMMVIS=$P(IMMVISENTRY,"/",1)
 . I 'IMMVIS Q
 . S IMMVISDT=$P(IMMVISENTRY,"/",2)
 . I IMMVISDT S IMMVIS=IMMVIS_U_IMMVISDT
 . S PXSEQ=PXSEQ+1
 . S PXPCEARR("IMMUNIZATION",IMM,"VIS",PXSEQ,0)=IMMVIS
 Q
 ;
IMMRMRKS(IMMREMARKS,IMMNUM,REMARK) ; Sets REMARK array
 N PXEND,PXSTART,PXX,X
 S PXSTART=$P(IMMREMARKS,";",1)
 S PXEND=$P(IMMREMARKS,";",2)
 I ('PXSTART)!('PXEND)!(PXEND<PXSTART) Q
 F PXX=PXSTART:1:PXEND D
 . S REMARK(PXX)="IMMUNIZATION^"_IMMNUM
 Q
 ;
IMMDSG(IMMDSG) ;
 N IMMDOSE,IMMUNIT,IMMUNITIEN,IMMDOSEV,IMMUNERR,X
 S IMMDSG=$$TRIM^XLFSTR(IMMDSG)
 I IMMDSG="" Q ""
 S IMMDOSE=$P(IMMDSG,";",1)
 S IMMUNIT=$P(IMMDSG,";",2)
 S IMMUNITIEN=$P(IMMDSG,";",3)
 I IMMDSG[" ",IMMDSG'[";" D  ;Remove this DO block when VLER DAS starts using ";" between dose and units
 . S IMMDOSE=$P(IMMDSG," ",1)
 . S IMMUNIT=$P(IMMDSG," ",2)
 ;
 I IMMDOSE="" Q ""
 ;
 I IMMUNIT'="",'IMMUNITIEN D
 . N UCUMDATA
 . D UCUMDATA^LEXMUCUM(IMMUNIT,.UCUMDATA)  ; ICR 6225
 . S IMMUNITIEN=$O(UCUMDATA(0))
 D CHK^DIE(9000010.11,1312,,IMMDOSE,.IMMDOSEV,"IMMUNERR")
 I IMMUNITIEN,IMMDOSEV'="^" Q IMMDOSEV_U_IMMUNITIEN
 ;
 Q U_U_"Dosage: "_IMMDOSE_" "_IMMUNIT
