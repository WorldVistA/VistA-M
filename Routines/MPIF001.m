MPIF001 ;ALB/RJS/CMC-UTILITY ROUTINE OF APIS ;JUL 12, 1996
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,3,9,16,18,21,27,33,35,41,45,48**;30 Apr 99;Build 6
 ;
 ; Integration Agreements Utilized:
 ;  ^DPT( - #2070
 ; ^DPT("AICN" - #2070
 ; ^DPT("AMPIMIS" - #2070
 ; EXC^RGHLLOG - #2796
 ; START^RGHLLOG - #2796
 ; STOP^RGHLLOG - #2796
 ;
GETICN(DFN) ; This function returns the ICN, including checksum for a given
 ; DFN or -1^error message
 ; INPUT: DFN - ien in Patient file
 ;
 N RETURN,NODE
 I $G(DFN)'>0 S RETURN="-1^NO DFN" G EXIT1
 I '$D(^DPT(DFN,0)) S RETURN="-1^PATIENT NOT IN DATABASE" G EXIT1
 I '$D(^DPT(DFN,"MPI")) S RETURN="-1^NO MPI NODE" G EXIT1
 S NODE=$G(^DPT(DFN,"MPI"))
 I $P(NODE,"^",1)'>0 S RETURN="-1^NO ICN" G EXIT1
 S RETURN=$P(NODE,"^",1)_"V"_$$CHECKDG^MPIFSPC($P(NODE,"^",1)) ;**48
 I '$D(^DPT("AICN",$P(NODE,"^"),DFN)) S ^DPT("AICN",$P(NODE,"^"),DFN)=""
 ; ^ set AICN x-ref if missing one
EXIT1 ;
 Q RETURN
 ;
GETDFN(ICN) ; Returns DFN (ien Patient file) or -1^error message for a given ICN
 ; ICN - ICN for a given Patient in the Patient file
 N RETURN,DFN
 I $G(ICN)'>0 S RETURN="-1^NO ICN" G EXIT2
 I ICN["V" S ICN=+ICN
 I '$D(^DPT("AICN",ICN)) S RETURN="-1^ICN NOT IN DATABASE" G EXIT2
 S DFN=$O(^DPT("AICN",ICN,0))
 I $G(DFN)'>0 S RETURN="-1^BAD ICN CROSS-REFERENCE" G EXIT2
 I '$D(^DPT(DFN)) K ^DPT("AICN",ICN) S RETURN="-1^ICN NOT IN DATABASE" G EXIT2
 ;^ **41 - CHECK IF THE DFN HOLDING THIS ICN IS RELATED TO BOGUS XREF
 S RETURN=DFN
EXIT2 ;
 Q RETURN
 ;
ICNLC(DFN) ;This API will return an ICN if one exists or create and return
 ; a Local ICN and update the appropriate fields if a Local was created
 ; DFN= Patient IEN
 ; Returns ICN (local or National including checksum) or -1^error msg
 N ICN,TMP,CHKSUM,ICNX
 I $G(DFN)'>0 Q "-1^No DFN Passed"
 D LOCK
 S ICN=$$GETICN(DFN)
 I +ICN=-1 D
 .;no icn create a Local ICN
 .S ICN=$$EN2^MPIFAPI()
 .S CHKSUM=$P(ICN,"V",2),ICNX=$P(ICN,"V")
 .S NOLOCK=""
 .I ICNX="" K NOLOCK S ICN="-1^PROBLEM CREATING LOCAL ICN" Q
 .S TMP=$$SETICN(DFN,ICNX,CHKSUM)
 .I +TMP=-1 K NOLOCK Q
 .S TMP=$$SETLOC(DFN,1)
 .S TMP=$$CHANGE(DFN,$P($$SITE^VASITE(),"^"))
 .K NOLOCK
 D UNLOCK
 Q ICN
 ;
CMOR2(DFN) ; Returns CMOR Site Name or -1^error message
 ; DFN = Patient IEN
 I $G(DFN)'>0 Q "-1^No DFN Passed"
 N NODE
 S NODE=$$MPINODE^MPIFAPI(DFN)
 Q:$P(NODE,"^",3)="" "-1^No CMOR"
 Q $$CMORNAME($P(NODE,"^",3))
 ;
CMORNAME(CIEN) ; Returns CMOR site name or -1^error message
 ; CIEN - ien from Institution file
 ;
 Q:CIEN="" "-1^No Institution parameter"
 N INST
 S INST=$$NNT^XUAF4(CIEN)
 Q:INST="" "-1^No Institution for that IEN"
 Q:$P(INST,"^")="" "-1^No Name for this Institution"
 Q $P(INST,"^")
 ;
GETVCCI(DFN) ; Returns CMOR or -1^error message for a given patient
 ; DFN - ien of patient in Patient file
 N RETURN,NODE,PTR,STANUM
 I $G(DFN)'>0 S RETURN="-1^NO DFN" G EXIT3
 I '$D(^DPT(DFN,0)) S RETURN="-1^PATIENT NOT IN DATABASE" G EXIT3
 I '$D(^DPT(DFN,"MPI")) S RETURN="-1^NO MPI NODE" G EXIT3
 S NODE=$$MPINODE^MPIFAPI(DFN)
 S PTR=$P(NODE,"^",3)
 I PTR'>0 S RETURN="-1^NO CMOR DEFINED FOR PT" G EXIT3
 S STANUM=$P($$NNT^XUAF4(PTR),"^",2)
 I STANUM'>0 S RETURN="-1^PTS CMOR IS DANGLING PTR" G EXIT3
 S RETURN=STANUM
EXIT3 ;
 Q RETURN
 ;
CHANGE(DFN,VCCI) ;
 ; ** This function is only to be used by approved packages **
 ;
 ; This function updates the CMOR field in the Patient file
 ; DFN = ien in Patient file
 ; VCCI = CMOR ien from the institution file
 ; returned:  -1^error message - problem
 ;             1 - successful
 ; Exception will be generated if Update to File Fails only
 N RETURN,DIQUIET,DIE,DA,DR,Y,X,DIC
 S (RETURN,DIQUIET)=1
 I $G(DFN)'>0 S RETURN="-1^NO DFN PASSED" G EXIT4
 I '$D(^DPT(DFN,0)) S RETURN="-1^PATIENT NOT IN DATABASE" G EXIT4
 I $G(VCCI)="" S RETURN="-1^NO CMOR PASSED" G EXIT4
 N CNT,TIEN S DIQUIET=1,CNT=0
 I '$D(NOLOCK) D LOCK
 ; moved to here to fix problem with timing
 I $E($$GETICN(DFN),1,3)=$P($$SITE^VASITE(),"^",3) S VCCI=$P($$SITE^VASITE(),"^")
 ; ^ to be sure site is self for a local icn
 S VCCI="`"_VCCI
 ; ^ Have ien stuff added to use ien instead of station number
REP S DIE="^DPT(",DA=DFN,DR="991.03///^S X=VCCI"
 D ^DIE
 S CNT=CNT+1
 S TIEN=$P($$MPINODE^MPIFAPI(DFN),"^",3)
 I "`"_TIEN'=VCCI&(CNT<4) G REP
 I "`"_TIEN'=VCCI&(CNT>3) D
 .S RETURN="-1^Couldn't Update CMOR"
 .D START^RGHLLOG(0)
 .D EXC^RGHLLOG(221,"Unable to update CMOR to "_$$STA^XUAF4(TIEN)_" for patient DFN= "_DFN,DFN)
 .D STOP^RGHLLOG(0)
 I '$D(NOLOCK) D UNLOCK
EXIT4 ;
 Q RETURN
 ;
SETICN(DFN,ICN,CHKSUM) ;
 ; ** this function is to only be used by approved packages **
 ;
 ; This function updates the ICN and ICN Checksum fields in the Patient 
 ; file for a given patient.
 ; DFN - ien in the Patient file to be updated
 ; ICN - ICN (without checksum) to be updated
 ; CHKSUM - ICN checksum
 ; return:  -1^error message - problem
 ;          1 - successful
 N RETURN,DIQUIET,DIE,DA,DR,RGRSICN,Y,ERR
 S (RETURN,DIQUIET,RGRSICN)=1
 I $G(DFN)'>0 S RETURN="-1^NO DFN PASSED" G EXIT5
 I '$D(^DPT(DFN,0)) S RETURN="-1^PATIENT NOT IN DATABASE" G EXIT5
 I $G(ICN)="" S RETURN="-1^NO ICN PASSED" G EXIT5
 I $G(CHKSUM)="" S RETURN="-1^NO CHKSUM PASSED" G EXIT5
 I +$$GETICN(DFN)>0 I $E(ICN,1,3)=$P($$SITE^VASITE(),"^",3),$E($$GETICN(DFN),1,3)'=$E(ICN,1,3) S RETURN="-1^Don't overwrite national with local" G EXIT5
 ; ^ stop local from overwriting a national ICN
 I +$$GETICN(DFN)>0 I $E(ICN,1,3)=$P($$SITE^VASITE(),"^",3),$E($$GETICN(DFN),1,3)=$P($$SITE^VASITE(),"^",3) S RETURN="-1^Don't overwrite local ICN with another Local ICN" G EXIT5
 ; ^ STOP LOCAL FROM OVERWRITING ANOTHER LOCAL ICN
 I $D(^DPT("AICN",ICN)) D
 .Q:DFN=$O(^DPT("AICN",ICN,""))
 .I DFN'=($O(^DPT("AICN",ICN,""))) D
 ..N DFN2 S DFN2=$O(^DPT("AICN",ICN,""))
 ..I '$D(TWODFN) D TWODFNS^MPIF002(DFN2,DFN,ICN)
 .S RETURN="-1^ICN ALREADY IN USE"
 G:+RETURN=-1 EXIT5
 I '$D(NOLOCK) D LOCK
 S DIQUIET=1
 S CHKSUM=$$CHECKDG^MPIFSPC(ICN) ;**45 calculate checksum based upon what's passed for ICN and use that to update 991.02
 S DIE="^DPT(",DA=DFN,DR="991.01///^S X=ICN;991.02///^S X=CHKSUM"
 D ^DIE
 I +$G(Y)=-1 S RETURN="-1^UNSUCCESSFUL DIE CALL"
 I +RETURN>0 D
 .K ^DPT("AMPIMIS",DFN)
 .I $E(ICN,1,3)=$P($$SITE^VASITE(),"^",3) S ERR=$$SETLOC(DFN,1)
 .I $E(ICN,1,3)'=$P($$SITE^VASITE(),"^",3) S ERR=$$SETLOC(DFN,0)
 I '$D(NOLOCK) D UNLOCK
EXIT5 ;
 Q RETURN
 ;
SETLOC(DFN,DELFLAG) ;
 ; ** This function should be only used by approved packages **
 ;
 ; This function updates the LOCALLY ASSIGNED ICN field in the Patient
 ; for the given patient
 ;DFN - ien from Patient file of patient to be updated
 ;DELFLAG - 1 is to turn the flag on
 ;        - 0 is to turn off the flag
 ;
 N RETURN,DIQUIET,DIE,DA,DR,VALUE,Y
 S (RETURN,DIQUIET)=1
 I $G(DFN)'>0 S RETURN="-1^NO DFN PASSED" G EXIT6
 I '$D(^DPT(DFN,0)) S RETURN="-1^PATIENT NOT IN DATABASE" G EXIT6
 I '$D(NOLOCK) D LOCK
 S DIQUIET=1,VALUE=$S($G(DELFLAG)=0:"@",1:1)
 S DIE="^DPT(",DA=DFN,DR="991.04///^S X=VALUE"
 D ^DIE
 I +$G(Y)=-1 S RETURN="-1^UNSUCCESSFUL DIE CALL"
 I +RETURN>0 K ^DPT("AMPIMIS",DFN)
 I '$D(NOLOCK) D UNLOCK
EXIT6 ;
 Q RETURN
 ;
IFLOCAL(DFN) ; This function is used to see if a patient has a local ICN
 ; DFN - ien of patient in Patient file
 ; returned:  0 = patient does not exist, dfn is not defined or no MPI node OR Patient does not have a local ICN
 ;            1 = patient has a Local ICN assigned
 Q:$G(DFN)="" 0
 Q:$G(^DPT(DFN,0))="" 0
 Q:'$D(^DPT(DFN,"MPI")) 0
 Q:$E($$GETICN(DFN),1,3)=$P($$SITE^VASITE,"^",3) 1
 Q 0
 ;
IFVCCI(DFN) ; this function returns 1 if your facility is the CMOR for the given pt
 ; DFN - ien of patient in Patient file
 ; returns: 1 = your site in the CMOR for this patient
 ;          -1 = your site is not the CMOR for this patient
 ;          0^ERROR MSG
 N VCCI,SITE
 I $G(DFN)'>0 Q "0^No DFN Passed"
 S VCCI=$P($$GETVCCI(DFN),"^",1)
 S SITE=$P($$SITE^VASITE,"^",3)\1
 I $P(VCCI,"^",1)=-1 Q -1
 I VCCI'=SITE Q -1
 Q 1
 ;
HL7CMOR(DFN,SEP) ; This function returns the CMOR station number and institution name for
 ; the given patient.
 ; DFN = ien for patient in Patient file
 ; SEP = delimiter to separate station number and name
 ; returned:  Station Number <sep> Institution name
 ;            -1^error message
 N RETURN,NODE,PTR,STAT
 I $G(DFN)'>0 S RETURN="-1^NO DFN" G EXIT7
 I $G(SEP)="" S RETURN="-1^NO FIELD SEPERATOR" G EXIT7
 I '$D(^DPT(DFN,0)) S RETURN="-1^PATIENT NOT IN DATABASE" G EXIT7
 I $$MPINODE^MPIFAPI(DFN)<1 S RETURN="-1^NO MPI NODE" G EXIT7
 S NODE=$$MPINODE^MPIFAPI(DFN)
 S PTR=$P(NODE,"^",3)
 I PTR'>0 S RETURN="-1^NO CMOR DEFINED FOR PT" G EXIT7
 S STAT=$$NNT^XUAF4(PTR)
 I STAT="" S RETURN="-1^PTS CMOR IS DANGLING PTR" G EXIT7
 I $P(STAT,"^")="" S RETURN="-1^NO INSTITUTION NAME" G EXIT7
 S RETURN=$P(STAT,"^",2)_SEP_$P(STAT,"^")
EXIT7 ;
 Q RETURN
 ;
LOCK ;
 F  L +^DPT(DFN,"MPI"):10 Q:$T
 Q
 ;
UNLOCK ;
 L -^DPT(DFN,"MPI")
 Q
