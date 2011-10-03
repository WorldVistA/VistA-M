VAFHLDG1 ;ALB/CM/ESD HL7 DG1 SEGMENT BUILDING ; 3/24/05 5:05pm
 ;;5.3;Registration;**94,151,190,511,606,614**;Aug 13, 1993
 ;Routine currently being changed by GRR/EDS
 ;IN entry is being added
 ;
 ;This routine will build an HL7 DG1 segment for an inpatient or
 ;outpatient event depending on the entry point used.
 ;Use IN for inpatient
 ;Use OUT for outpatient
 ;
IN(DFN,VAFHMIEN,VAFSTR,VAOUT,VAFHMDT) ;
 ;Input parameters
 ;DFN - Patient's Internal Entry Number
 ;VAFHMIEN - Internal Entry Number of Movement
 ;VAFSTR - Sequence numbers of segment to include
 ;VAOUT - Variable name where output segments should be saved
 ;
 K @VAOUT ;Insure output array is empty
 Q:VAFHMIEN=""
 N VAFHLREC,VAFHAIEN,VAFHICD
 S $P(VAFHLREC,HL("FS"))="DG1" ;Set the segment identifier
 S VAFHMDT=$$GET1^DIQ(405,VAFHMIEN,".01","I") ;Movement Date/Time
 S VAFHTT=$$GET1^DIQ(405,VAFHMIEN,".02","I") ;Get the movement transaction type (admit, transfer, disharge)
 I VAFHTT=1 S VAFHAIEN=VAFHMIEN ;If 'admit' movement capture ien
 I VAFHTT'=1 S VAFHAIEN=$$GET1^DIQ(405,VAFHMIEN,".14","I") ;If not 'admit' movement, get ien of admission movement
 Q:VAFHAIEN=""  ;Quit if no admission movement
 S VAFHADT=$$GET1^DIQ(405,VAFHAIEN,".01","I") ;Get Admission date/time
 S VAFHPTF=$O(^DGPT("AAD",DFN,VAFHADT,"")) Q:VAFHPTF=""  ;Get pointer to ptf record and quit if none exists
 S VACNT=0 ;Initialize counter
 ;I VAFHTT'=3 D  ;If not a 'discharge' type, get Movement ICD codes and descriptions
 ;.S DGLMR=$P($G(^DGPT(VAFHPTF,"M",0)),"^",3) ;Get Last movement ien
 ;.Q:DGLMR=""  ;Quit if no movement entry
 ;.S DIQ="DGAM",DIQ(0)="I",DIC=45,DR=50,DA=VAFHPTF,DR(45.02)="5:15",DA(45.02)=DGLMR D EN^DIQ1 ;Retrieve the movement ICD fields
 ;.I $D(DGAM(45.02,DGLMR)) D  ;If ICD data exists
 ;..F VAFLD=5,6,7,8,9,11,12,13,14,15 I $G(DGAM(45.02,DGLMR,VAFLD,"I"))]"" S VACNT=VACNT+1,VAFHICD(VACNT)=DGAM(45.02,DGLMR,VAFLD,"I") ;Check each ICD field for data and store in array if data exists
 ;I VAFHTT=3 D  ;If movement 'discharge' type, get ICD codes and descriptions from discharge data
 F VAFLD=79,79.16:.01:79.19,79.201,79.21:.01:79.24,79.241,79.242,79.243,79.244 D
 . S VAFHICD=$$GET1^DIQ(45,VAFHPTF,VAFLD,"I")
 . I VAFHICD]"" S VACNT=VACNT+1,VAFHICD(VACNT)=VAFHICD ;Check each ICD field for data and store in array if data exists
 I $O(VAFHICD(0))="" Q  ;Quit if no data in ICD array
 S VACNT=0 F  S VACNT=$O(VAFHICD(VACNT)) Q:VACNT=""  D  ;If array contains ICD data
 .S $P(VAFHLREC,HL("FS"))="DG1" ;Set segment type to DG1
 .S $P(VAFHLREC,HL("FS"),2)=VACNT ;Set Segment Set ID to next sequential number
 .I VAFSTR[",2," S $P(VAFHLREC,HL("FS"),3)="I9" ;Set 'Diagnosis Coding Method' to reflect ICD9
 .I VAFSTR[",3," S $P(VAFHLREC,HL("FS"),4)=$$GET1^DIQ(80,VAFHICD(VACNT),".01","I")_$E(HL("ECH"))_$P($$ICDDX^ICDCODE(VAFHICD(VACNT),VAFHMDT),"^",4) ;Icd Code and Description
 .I VAFSTR[",5," S $P(VAFHLREC,HL("FS"),6)=$$HLDATE^HLFNC(VAFHMDT) ;Diagnosis Date/Time set to Movement Date/Time
 .S @VAOUT@(VACNT,0)=VAFHLREC ;Set next node of ICD output array to the newly created segment
 Q
 ;
 ;
OUT(DFN,EVT,EVDTS,VPTR,STRP,NUMP) ;
 ;DFN - Patient File
 ;EVT - event number from pivot file
 ;EVDTS - event date/time FileMan
 ;VPTR - variable pointer
 ;STRP - string of fields
 ;(if null - required fields, if "A" - supported
 ;fields, or string of fields seperated by commas")
 ;NUMP - ID # (optional)
 ;
 N ERR
 I '$D(NUMP) S NUMP=1
 S ERR=$$ODG1^VAFHCDG($G(DFN),$G(EVT),$G(EVDTS),$G(VPTR),$G(STRP),NUMP)
 Q ERR
 ;
 ;
EN(VAFENC,VAFSTR,VAFHLQ,VAFHLFS,VAFARRY) ; Entry point for Ambulatory Care Database Project
 ; - Entry point to return the HL7 DG1 segment
 ;
 ;   This function will create VA-specific DG1 segment(s) for a 
 ;   given outpatient encounter.  The DG1 segment is designed to transfer
 ;   generic information about an outpatient diagnosis or diagnoses.
 ;
 ;  Input:   VAFENC - IEN of the Outpatient Encounter (#409.68) file
 ;           VAFSTR - String of fields requested separated by commas
 ;           VAFHLQ - Optional HL7 null variable. If not there, use 
 ;                    default HL7 variable
 ;          VAFHLFS - Optional HL7 field separator. If not there, use 
 ;                    default HL7 variable
 ;          VAFARRY - Optional user-supplied array name to hold the HL7 DG1 segments
 ;
 ; Output:  Array of HL7 DG1 segments
 ;
 ;
 N I,VAFDICDE,VAFIDX,VAFNODE,VAFDNODE,VAFY,VAXY,X,ICDVDT
 S VAFARRY=$G(VAFARRY),ICDVDT=$$SCE^DGSDU(VAFENC,1,0)
 ;
 ; - If VAFARRY not defined, use ^TMP("VAFHL",$J,"DIAGNOSIS")
 S:(VAFARRY="") VAFARRY="^TMP(""VAFHL"",$J,""DIAGNOSIS"")"
 ;
 ; - If VAFHLQ or VAFHLFS aren't passed in, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 I '$G(VAFENC)!($G(VAFSTR)']"") S @VAFARRY@(1,0)="DG1"_VAFHLFS_1 G ENQ
 S VAFIDX=0,VAFSTR=","_VAFSTR_","
 ;
 ; - Get all outpatient diagnoses for encounter
 D GETDX^SDOE(VAFENC,"VAXY")
 ;
 ; - Set diagnosis array to 0 if no outpatient diagnosis for encounter
 I '$G(VAXY) S VAXY(1)=0
 ;
ALL ; -- All outpatient diagnoses for encounter
 ;
 ; -- only send dx once per encounter / build ok array
 N VAOK
 F I=0:0 S I=$O(VAXY(I)) Q:'I  D
 . S VAFNODE=VAXY(I)
 . ;
 . ; -- if this is first entry for dx then 'ok' it
 . IF '$D(VAOK(+VAFNODE)) S VAOK(+VAFNODE)=I Q
 . ;
 . ; -- if primary then 'ok' it (if two are primary we 'ok' last)
 . IF $P(VAFNODE,U,12)="P" S VAOK(+VAFNODE)=I
 ;
 ;
 F I=0:0 S I=$O(VAXY(I)) Q:'I  D
 .;
 .S VAFNODE=VAXY(I)
 .;
 .; - build array of HL7 (DG1) segments but only use ok'ed entry for dx
 .IF $G(VAOK(+VAFNODE))=I D BUILD
 ;
ENQ Q
 ;
 ;
BUILD ; - Build array of HL7 (DG1) segments
 S $P(VAFY,VAFHLFS,16)="",VAFIDX=VAFIDX+1
 S VAFDICDE="I9" ; Diagnosis Coding Method = I9 (ICD-9)
 ;
 ; - Sequential number (required field)
 S $P(VAFY,VAFHLFS,1)=VAFIDX
 ;
 I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$S($G(VAFDICDE)]"":VAFDICDE,1:VAFHLQ) ; Diagnosis Coding Method = ICD-9
 ;I (VAFSTR[",3,")!(VAFSTR[",4,") S VAFDNODE=$G(^ICD9(+$G(VAFNODE),0)) ; Get node from ICD Diagnosis file
 I (VAFSTR[",3,")!(VAFSTR[",4,") S VAFDNODE=$$ICDDX^ICDCODE(+VAFNODE,$G(ICDVDT)) ; Get node from ICD Diagnosis file
 I VAFSTR[",3," S X=$P($G(VAFDNODE),"^",2),$P(VAFY,VAFHLFS,3)=$S(X]"":X,1:VAFHLQ) ; Diagnosis Code
 I VAFSTR[",4," S X=$P($G(VAFDNODE),"^",4),$P(VAFY,VAFHLFS,4)=$S(X]"":X,1:VAFHLQ) ; Diagnosis Description
 I VAFSTR[",5," S X=$$HLDATE^HLFNC($$SCE^DGSDU(VAFENC,1,0)),$P(VAFY,VAFHLFS,5)=$S(X]"":X,1:VAFHLQ) ; Diagnosis Date/Time (Encounter Date/Time)
 ;
 ; - Contains 1 if primary diagnosis, blank otherwise
 I VAFSTR[",15," S X=$P($G(VAFNODE),"^",12),$P(VAFY,VAFHLFS,15)=$S(X="P":1,1:VAFHLQ) ; Diagnosis Ranking Number
 ;
 ; - Set all outpatient diagnoses into array
 S @VAFARRY@(VAFIDX,0)="DG1"_VAFHLFS_$G(VAFY)
 Q
