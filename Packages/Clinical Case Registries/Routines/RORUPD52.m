RORUPD52 ;HCIOFO/SG - UPDATE PATIENT'S DEMOGRAPHIC DATA (2) ; 12/12/05 9:19am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #174          RATED DISBAILITIES (VA) multiple (controlled)
 ; #2701         $$GETICN^MPIF001  Gets ICN
 ; #4807         RDIS^DGRPDB (supported)
 ; #10061        6^VADPT
 ;
 Q
 ;
 ;***** LOAD DEMOGRAPHIC DATA FROM THE 'PATIENT' FILE
 ;
 ; DFN           Internal Entry Number in the PATIENT file
 ;
 ; .RES          Reference to a buffer for the data
 ;
 ;   RES(1,      Demographic and elegibility data
 ;                 ^1: SSN                           .09
 ;                 ^2: Date of Birth                 .03
 ;                 ^3: Sex                           .02
 ;                 ^4: Date of Death                 .351
 ;                 ^5: Period of Service             .323
 ;                 ^6: Service Connected?            .301
 ;                 ^7: Service Connected Percentage  .302
 ;                 ^8: ZIP+4                         .1112
 ;                 ^9: ICN (with the checksum)       991.*
 ;     "FL")     List of field numbers separated by the ";"
 ;
 ;   RES(2)      Race and ethnicity data
 ;                 Race^Method^...^Ethnicity^Method^...
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOADDM(DFN,RES) ;
 N I,J,VA,VADM,VAEL,VAHOW,VAPA,VAROOT
 S RES(1,"FL")=".09;.03;.02;.351;.323;.301;.302;.1112;991"
 D 6^VADPT  F I=1,2  S RES(I)=""
 ;--- Demographic and eligibility fields
 F I=2,3,5,6  S RES(1)=RES(1)_U_$P($G(VADM(I)),U)
 S $E(RES(1),1)=""  ; Remove the first "^"
 S I=$G(VAEL(3))
 S RES(1)=RES(1)_U_$P($G(VAEL(2)),U)_U_$S(I:"Y",1:"N")_U_$P(I,U,2)
 S I=$$GETICN^MPIF001(DFN)
 S RES(1)=RES(1)_U_$P($G(VAPA(6)),U,2)_U_$S(I'<0:I,1:"")
 ;--- Race & Ethnicity
 F I=11,12  S J=""  D
 . F  S J=$O(VADM(I,J))  Q:J=""  D
 . . S RES(2)=RES(2)_U_$P(VADM(I,J),U)_U_$P($G(VADM(I,J,1)),U)
 S $E(RES(2),1)=""  ; Remove the first "^"
 Q 0
 ;
 ;***** LOAD RATED DISABILITIES FROM THE 'PATIENT' FILE
 ;
 ; DFN           Internal Entry Number in the PATIENT file
 ;
 ; .RES          Reference to a buffer for the data
 ;
 ;   RES(3)      Rated disabilities data
 ;                 Rated Disability^Disability %^Service Connected^...
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOADRD(DFN,RES) ;
 N I,RC,RORBUF
 S I=0
 F  S I=$O(^DPT(DFN,.372,I))  Q:I'>0  D
 . S RORBUF(I)=$P($G(^DPT(DFN,.372,I,0)),U,1,3)
 S RES(3)=$$CRC32^RORBIN("RORBUF")
 Q 0
 ; Use this code to load disabilities when the API is fixed.
 ;S RC=$$RDIS^DGRPDB(DFN,.RORBUF)
 ;D:'RC ERROR^RORERR(-57,,,DFN,RC,"$$RDIS^DGRPDB")
 ;
 ;***** GETS AND PREPARES PATIENT'S DATA
 ;
 ; PATIENS       Patient IENS in the PATIENT file
 ; .RORPAT       Reference to the FDA for field values
 ; RORIENS       IENS of the record in the ROR PATIENT file
 ; [.DOD]        Date of death is returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Patient data has not been changed
 ;       >0  Data has been changed
 ;
PATDATA(PATIENS,RORPAT,RORIENS,DOD) ;
 N BUF,DIFCNT,N1,NODE,RC,RORDFN
 S:PATIENS'["," PATIENS=PATIENS_","
 S:RORIENS'["," RORIENS=RORIENS_","
 S RORDFN=$S(RORIENS?1.N1",":+RORIENS,1:-1)
 S DOD="",(DIFCNT,RC)=0
 ;--- Load demographic data from the PATIENT file
 S RC=$$LOADDM(+PATIENS,.NODE)  Q:RC<0 RC
 S DOD=$P(NODE(1),U,4),N1=$L(NODE(1,"FL"),";")
 ;--- Demographic and eligibility fields
 S BUF=$P($G(^RORDATA(798.4,RORDFN,1)),U,1,N1)
 I NODE(1)'=BUF  D
 . N CF,FLD,I
 . F I=1:1:N1  S FLD=+$P(NODE(1,"FL"),";",I)  D:FLD>0
 . . K RORPAT(798.4,RORIENS,FLD)
 . . ;--- Update the field if necessary
 . . S OLDVAL=$P(BUF,U,I)  Q:$P(NODE(1),U,I)=OLDVAL
 . . S RORPAT(798.4,RORIENS,FLD)=$P(NODE(1),U,I),CF=1
 . . ;--- Save previous values of the special fields
 . . I FLD=.09  D  Q
 . . . S RORPAT(798.4,RORIENS,10.1)=OLDVAL  ; Old SSN
 . . I FLD=991.01  D  Q
 . . . S RORPAT(798.4,RORIENS,10.2)=OLDVAL  ; Old ICN
 . I $G(CF)  S DIFCNT=DIFCNT+1  Q
 . S $P(^RORDATA(798.4,RORDFN,1),U,N1)=$P(BUF,U,N1)
 ;--- Race & Ethnicity
 I NODE(2)'=$G(^RORDATA(798.4,RORDFN,2))  D
 . S DIFCNT=DIFCNT+1,RORPAT(798.4,RORIENS,2)=NODE(2)
 K NODE
 ;--- Rated disabilities
 S RC=$$LOADRD(+PATIENS,.NODE)  Q:RC<0 RC
 I NODE(3)'=$G(^RORDATA(798.4,RORDFN,3))  D
 . S DIFCNT=DIFCNT+1,RORPAT(798.4,RORIENS,.3721)=NODE(3)
 Q $S(RC<0:RC,1:DIFCNT)
