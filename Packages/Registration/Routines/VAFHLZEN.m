VAFHLZEN ;ALB/KCL,KUM - Create generic HL7 Enrollment (ZEN) segment ;11/16/19 3:34PM
 ;;5.3;Registration;**122,147,232,993**;Aug 13, 1993;Build 92
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ;Supported ICRs
 ; #2055  - $$EXTERNAL^DILFD()
 ; #2056  - $$GET1^DIQ(}
 ;
 ; This generic extrinsic function is designed to return the
 ; HL7 Enrollment (ZEN) segment. This segment contains VA-specific
 ; current enrollment information for a patient.
 ;
EN(DFN,VAFSTR,VAFNUM,VAFHLQ,VAFHLFS) ; --
 ; Entry point for creating HL7 Enrollment (ZEN) segment. 
 ;     
 ;  Input(s):
 ;        DFN - internal entry number of Patient (#2) file
 ;     VAFSTR - (optional) string of fields requested, separated by
 ;              commas.  If not passed, return all data fields.
 ;     VAFNUM - (optional) sequential number for SET ID (default=1)
 ;     VAFHLQ - (optional) HL7 null variable.
 ;    VAFHLFS - (optional) HL7 field separator.
 ;
 ; Output(s):
 ;    String containing the desired components of the HL7 ZEN segment
 ;
 N VAFENR,VAFIEN,VAFPREF,VAFY,SEQ
 ;
 ; if VAFHLQ or VAFHLFS not passed, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 ;
 ; if set id not passed, use default
 S VAFNUM=$S($G(VAFNUM):VAFNUM,1:1)
 ;
 ; if DFN not passed, exit
 I '$G(DFN) S VAFY=1 G ENQ
 ;
 ; if VAFSTR not passed, return all data fields (SEQ's)
 ; DG*5.3*993 KUM - Allow new sequence numbers to send
 ;I $G(VAFSTR)']"" F SEQ=1:1:13 S $P(VAFSTR,",",SEQ)=SEQ
 I $G(VAFSTR)']"" F SEQ=1:1:19 S $P(VAFSTR,",",SEQ)=SEQ
 ;
 ; find IEN of patients 'current' enrollment record using
 ; enrollment API, exit if not successful
 S VAFIEN=$$FINDCUR^DGENA(DFN)
 I '$G(VAFIEN) S VAFY=1 G ENQ
 ;
 ; get current enrollment record from Patient Enrollment (#27.11) file
 ; using enrollment API, exit if not successful
 I '$$GET^DGENA(VAFIEN,.VAFENR) S VAFY=1 G ENQ
 ;
 ; initialize output string and requested data fields
 S $P(VAFY,VAFHLFS,12)="",VAFSTR=","_VAFSTR_","
 ;
 ; set-up segment data fields
 S $P(VAFY,VAFHLFS,1)=$S($G(VAFNUM):VAFNUM,1:1)  ; Set ID
 ;
 ;!!!!!! until HEC is ready to accept new Application Date, must transmit
 ;Application Date in the Enrollment Date field
 ; DG*5.3*933 - KUM - Make sure only send Date value for all Date fields
 ;I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$S($G(VAFENR("DATE")):$$HLDATE^HLFNC(VAFENR("DATE")),1:VAFHLQ)  ; Enrollment Date
 ;I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$S($G(VAFENR("APP")):$$HLDATE^HLFNC(VAFENR("APP")),1:VAFHLQ)  ; Enrollment Date filled with Application Date
 I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$S($G(VAFENR("APP")):$$HLDATE^HLFNC(VAFENR("APP"),"DT"),1:VAFHLQ)  ; Enrollment Date filled with Application Date
 ;
 I VAFSTR[",3," S $P(VAFY,VAFHLFS,3)=$S($G(VAFENR("SOURCE"))]"":VAFENR("SOURCE"),1:VAFHLQ)  ; Enrollment Source
 I VAFSTR[",4," S $P(VAFY,VAFHLFS,4)=$S($G(VAFENR("STATUS"))]"":VAFENR("STATUS"),1:VAFHLQ)  ; Enrollment Status
 I VAFSTR[",5," S $P(VAFY,VAFHLFS,5)=$S($G(VAFENR("REASON"))]"":VAFENR("REASON"),1:VAFHLQ)  ; Enrollment Reason Canceled/Declined
 I VAFSTR[",6," S $P(VAFY,VAFHLFS,6)=$S($G(VAFENR("REMARKS"))]"":VAFENR("REMARKS"),1:VAFHLQ)  ; Canceled/Declined Remarks
 I VAFSTR[",7," S X=$$STATION^VAFHLFNC(VAFENR("FACREC")) S $P(VAFY,VAFHLFS,7)=$S(X]"":X,1:VAFHLQ)  ; Facility Received
 I VAFSTR[",8," S X=$$STATION^VAFHLFNC($$PREF^DGENPTA(DFN)) S $P(VAFY,VAFHLFS,8)=$S(X]"":X,1:VAFHLQ)  ; Preferred Facility
 I VAFSTR[",9," S $P(VAFY,VAFHLFS,9)=$S($G(VAFENR("PRIORITY"))]"":VAFENR("PRIORITY"),1:VAFHLQ)  ; Enrollment Priority
 ;I VAFSTR[",10," S $P(VAFY,VAFHLFS,10)=$S($G(VAFENR("EFFDATE")):$$HLDATE^HLFNC(VAFENR("EFFDATE")),1:VAFHLQ)  ; Effective Date
 I VAFSTR[",10," S $P(VAFY,VAFHLFS,10)=$S($G(VAFENR("EFFDATE")):$$HLDATE^HLFNC(VAFENR("EFFDATE"),"DT"),1:VAFHLQ)  ; Effective Date
 ;I VAFSTR[",11," S $P(VAFY,VAFHLFS,11)=$S($G(VAFENR("APP")):$$HLDATE^HLFNC(VAFENR("APP")),1:VAFHLQ)  ; Enrollment Application Date
 I VAFSTR[",11," S $P(VAFY,VAFHLFS,11)=$S($G(VAFENR("APP")):$$HLDATE^HLFNC(VAFENR("APP"),"DT"),1:VAFHLQ)  ; Enrollment Application Date
 ;I VAFSTR[",12," S $P(VAFY,VAFHLFS,12)=$S($G(VAFENR("END")):$$HLDATE^HLFNC(VAFENR("END")),1:VAFHLQ)  ; Enrollment End Date
 I VAFSTR[",12," S $P(VAFY,VAFHLFS,12)=$S($G(VAFENR("END")):$$HLDATE^HLFNC(VAFENR("END"),"DT"),1:VAFHLQ)  ; Enrollment End Date
 I VAFSTR[",13," S $P(VAFY,VAFHLFS,13)=$S($G(VAFENR("SUBGRP"))]"":VAFENR("SUBGRP"),1:VAFHLQ)  ; Enrollment Priority Subgroup
 ;DG*5.3*993 KUM - Add Seq numbers 16, 17, 18, 19 in ZEN segment
 I VAFSTR[",14," S $P(VAFY,VAFHLFS,14)=VAFHLQ  ; Adding to allow to send sequence numbers 16-18
 I VAFSTR[",15," S $P(VAFY,VAFHLFS,15)=VAFHLQ  ; Adding to allow to send sequence numbers 16-18 
 I VAFSTR[",16," S $P(VAFY,VAFHLFS,16)=$S($G(VAFENR("PTAPPLIED"))]"":VAFENR("PTAPPLIED"),1:VAFHLQ)  ; PT Applied for Enrollment?
 S VAFSTR("REGREA")=$$GET1^DIQ(408.43,$G(VAFSTR("REGREA")),.03)
 I VAFSTR[",17," S $P(VAFY,VAFHLFS,17)=$S($G(VAFENR("REGREA"))]"":VAFENR("REGREA"),1:VAFHLQ)  ; Registration only Reason
 ;I VAFSTR[",18," S X=$G(VAFENR("REGDATE")) I X]"" S $P(VAFY,VAFHLFS,18)=$S(X]"":$$HLDATE^HLFNC(X),1:VAFHLQ)  ; Registration only Date
 I VAFSTR[",18," S X=$G(VAFENR("REGDATE")) I X]"" S $P(VAFY,VAFHLFS,18)=$S(X]"":$$HLDATE^HLFNC(X,"DT"),1:VAFHLQ)  ; Registration only Date
 S VAFENR("REGSRC")=$$EXTERNAL^DILFD(27.11,.17,"",$G(VAFENR("REGSRC")))
 I VAFSTR[",19," S $P(VAFY,VAFHLFS,19)=$S($G(VAFENR("REGSRC"))]"":VAFENR("REGSRC"),1:VAFHLQ)  ; Source of Registration
 ;
ENQ Q "ZEN"_VAFHLFS_$G(VAFY)
