SCMCHLR3 ;ALB/KCL - PCMM HL7 Reject Processing - Build List Area con't; 10-JAN-2000
 ;;5.3;Scheduling;**210,272,505**;AUG 13, 1993;Build 20
 ;
BLDLIST(SCSORTBY,SCEPS,SCCNT) ; Description: Build list area for for PCMM Transmission errors.
 ;
 ;  Input:
 ;   SCSORTBY - Sort by criteria
 ;               N -> Patient Name
 ;               D -> Date/Time Ack Received
 ;               P -> Provider
 ;               I -> Institution
 ;      SCEPS -  Error processing status
 ;
 ; Output:
 ;  SCCNT - Number of lines in the list
 ;
 N DFN,SCSUB,SCTEXT,SCTLIEN,SCERIEN,SCTLOG,SCHL
 ;
 ;Init line counter and selection number
 S (SCLINE,SCNUM)=0
 ;
 ;Quit if unable to determine col/width for caption flds in List Template
 Q:'$$CAPFLD(.SCCOL,.SCWID)
 ;
 ;Loop thru sort array by pat name, OR date ack rec'd, OR provider, OR Institution
 S SCSUB=$S(SCSORTBY="N":"",SCSORTBY="P":"",SCSORTBY="I":"",1:0)
 F  S SCSUB=$O(^TMP("SCERRSRT",$J,SCSORTBY,SCSUB)) Q:SCSUB=""  D
 .;loop through PCMM HL7 Transmission Log ien(s)
 .S SCTLIEN=0
 .F  S SCTLIEN=$O(^TMP("SCERRSRT",$J,SCSORTBY,SCSUB,SCTLIEN)) Q:'SCTLIEN  D
 ..;loop through Error Code subfile ien(s)
 ..S SCERIEN=0
 ..F  S SCERIEN=$O(^TMP("SCERRSRT",$J,SCSORTBY,SCSUB,SCTLIEN,SCERIEN)) Q:'SCERIEN  D
 ...;
 ...;write dot to screen as list is being built (every 50 lines) 
 ...W:'(SCLINE#50) "."
 ...;
 ...;get data for PCMM HL7 Trans Log entry
 ...I $$GETLOG^SCMCHLA(SCTLIEN,SCERIEN,.SCTLOG) D
 ....;
 ....;increment selection number
 ....S SCNUM=SCNUM+1
 ....;
 ....;increment line counter
 ....S SCLINE=SCLINE+1
 ....;
 ....;set selection number in display array
 ....D SET(SCARY,SCLINE,SCNUM,SCCOL("NUM"),SCWID("NUM"),SCNUM,SCTLIEN,SCTLOG("DFN"),SCERIEN,.SCCNT)
 ....;
 ....;set retransmit flag in display array
 ....S SCTEXT=$S($G(SCTLOG("STATUS"))="M":"*",1:" ")
 ....D SET(SCARY,SCLINE,SCTEXT,SCCOL("RET"),SCWID("RET"),SCNUM,,,,.SCCNT)
 ....;set patient name in display array
 ....S SCTEXT=$$LOWER^VALM1($S($G(SCTLOG("WORK")):"WORKLOAD",$G(SCTLOG("DFN")):$P($G(^DPT(SCTLOG("DFN"),0)),"^",1),1:"UNKNOWN"))
 ....D SET(SCARY,SCLINE,SCTEXT,SCCOL("PAT"),SCWID("PAT"),SCNUM,,,,.SCCNT)
 ....;
 ....;set patient id in display array
 ....S DFN=+SCTLOG("DFN") D PID^VADPT
 ....D SET(SCARY,SCLINE,VA("BID"),SCCOL("PATID"),SCWID("PATID"),SCNUM,,,,.SCCNT)
 ....;
 ....;set date ack received in display array
 ....S SCTEXT=$$LOWER^VALM1($S($G(SCTLOG("ACK DT/TM")):$E($$FDATE^VALM1(SCTLOG("ACK DT/TM")),1,8),1:"UNKNOWN"))
 ....D SET(SCARY,SCLINE,SCTEXT,SCCOL("DTR"),SCWID("DTR"),SCNUM,,,,.SCCNT)
 ....;
 ....;set provider in display array
 ....S SCPROV=""
 ....K SCHL
 ....;I workload get provider
 ....I $G(SCTLOG("WORK")) S SCPROV=$$PROV^SCMCHLP(SCTLOG("WORK"))
 ....;get provider if ZPC segment error
 ....I $G(SCTLOG("ERR","SEG"))="ZPC" D
 .....I $$GETHL7ID^SCMCHLA2($G(SCTLOG("ERR","ZPCID")),.SCHL)
 .....S SCPTR=$P($G(SCHL("HL7ID")),"-",2)
 .....S SCPROV=$P($G(^SCTM(404.52,+$G(SCPTR),0)),"^",3)
 ....S SCTEXT=$$LOWER^VALM1($S($G(SCPROV)'="":$$EXTERNAL^DILFD(404.52,.03,,SCPROV),1:"N/A"))
 ....D SET(SCARY,SCLINE,SCTEXT,SCCOL("PROV"),SCWID("PROV"),SCNUM,,,,.SCCNT)
 ....;
 ....;set provider type in display array
 ....S SCTYPE=$P($G(SCHL("HL7ID")),"-",4)
 ....I $G(SCTLOG("WORK")) S SCTYPE="PC"
 ....S SCTEXT=$S(SCTYPE'="":SCTYPE,1:"N/A")
 ....D SET(SCARY,SCLINE,SCTEXT,SCCOL("TYPE"),SCWID("TYPE"),SCNUM,,,,.SCCNT)
 ....;
 ....;set error processing status in display array
 ....S SCTEXT=$$LOWER^VALM1($S($G(SCTLOG("ERR","EPS")):$$EXTERNAL^DILFD(404.47142,.06,,SCTLOG("ERR","EPS")),1:"UNKNOWN"))
 ....D SET(SCARY,SCLINE,SCTEXT,SCCOL("STA"),SCWID("STA"),SCNUM,,,,.SCCNT)
 ....;
 ....;set INSTITUTION in display array
 ....I SCSORTBY="I" D
 .....;numeric version of institution SD*5.3*505
 .....S SCTEXT=$G(SCSUB)
 .....D SET(SCARY,SCLINE,SCTEXT,SCCOL("INST"),SCWID("INST"),SCNUM,,,,.SCCNT)
 ....;increment line counter
 ....S SCLINE=SCLINE+1
 ....;
 ....;set error code/desc in display array
 ....I $$GETEC^SCMCHLA2($G(SCTLOG("ERR","CODE")),.SCERR)
 ....S SCTEXT="Error: "_$S($G(SCERR("CODE"))'="":SCERR("CODE")_" - "_$G(SCERR("SHORT")),1:$$LOWER^VALM1("UNKNOWN"))
 ....K X S $P(X," ",160)=""
 ....S SCTEXT=$E(SCTEXT_X,1,150)
 ....D SET(SCARY,SCLINE,SCTEXT,10,$L(SCTEXT),SCNUM,,,,.SCCNT)
 ;
 Q
 ;
 ;
SET(SCARY,SCLINE,SCTEXT,SCCOL,SCWID,SCNUM,SCTLIEN,SCDFN,SCERIEN,SCCNT) ;
 ; Description: Set display array.
 ;
 ;  Input:
 ;     SCARY - Global array subscript
 ;    SCLINE - Line number
 ;    SCTEXT - Text
 ;     SCCOL - Column to start at
 ;     SCWID - Column or text width
 ;     SCNUM - Selection number
 ;   SCTLIEN - PCMM HL7 Transmission Log IEN
 ;   SCERIEN - IEN of record in Error Code (#404.47142) multiple
 ;     SCDFN   Patient IEN
 ;
 ; Output:
 ;  SCCNT - Number of lines in the list
 ;
 N X
 S:SCLINE>SCCNT SCCNT=SCLINE
 S X=$S($D(^TMP(SCARY,$J,SCLINE,0)):^(0),1:"")
 S ^TMP(SCARY,$J,SCLINE,0)=$$SETSTR^VALM1(SCTEXT,X,SCCOL,SCWID)
 S ^TMP(SCARY,$J,"IDX",SCLINE,SCNUM)=""
 ;
 ;Set special index used in retransmitting patient
 I $G(SCTLIEN),$G(SCERIEN) D
 .I '$G(SCTLOG("WORK")) Q:'SCDFN
 .S ^TMP(SCARY_"IDX",$J,SCNUM)=SCLINE_"^"_SCTLIEN_"^"_SCERIEN
 .S ^TMP(SCARY_"IDX",$J,"PT",$S(SCDFN:SCDFN,1:"W"),SCLINE)=SCTLIEN_"^"_SCERIEN
 Q
 ;
 ;
CAPFLD(SCCOL,SCWID) ; Description: Used to determine column/width of caption fields in the List Template.
 ;
 ;  Input:
 ;   VALMDDF - Array available at run-time of list template. This array
 ;             is subscripted by caption field name of List Template.
 ;
 ; Output:
 ;  Function value: Returns 1 on success, 0 on failure
 ;  SCCOL - array subscripted by abbreviation of caption field name containing the column number where the data/caption starts, pass by reference
 ;  SCWID - array subscripted by abbreviation of caption field name containing the number of charaters the data/caption will use, pass by reference 
 ;
 ;Quit if VALMDDF array is not defined
 Q:'$D(VALMDDF) 0
 ;
 N X
 S X=VALMDDF("NUMBER"),SCCOL("NUM")=$P(X,"^",2),SCWID("NUM")=$P(X,"^",3)
 S X=VALMDDF("RETRANS"),SCCOL("RET")=$P(X,"^",2),SCWID("RET")=$P(X,"^",3)
 S X=VALMDDF("PATIENT"),SCCOL("PAT")=$P(X,"^",2),SCWID("PAT")=$P(X,"^",3)
 S X=VALMDDF("PATID"),SCCOL("PATID")=$P(X,"^",2),SCWID("PATID")=$P(X,"^",3)
 S X=VALMDDF("DATE"),SCCOL("DTR")=$P(X,"^",2),SCWID("DTR")=$P(X,"^",3)
 S X=VALMDDF("PROV"),SCCOL("PROV")=$P(X,"^",2),SCWID("PROV")=$P(X,"^",3)
 S X=VALMDDF("TYPE"),SCCOL("TYPE")=$P(X,"^",2),SCWID("TYPE")=$P(X,"^",3)
 S X=VALMDDF("STATUS"),SCCOL("STA")=$P(X,"^",2),SCWID("STA")=$P(X,"^",3)
 S X=VALMDDF("INST"),SCCOL("INST")=$P(X,"^",2),SCWID("INST")=$P(X,"^",3)
 Q 1
