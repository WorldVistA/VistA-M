GMRAIAL1 ;BPOIFO/JG - BUILD HL7 ORU^R01 MESSAGE FOR ALLERGIES - PART 1 ; 17 Mar 2006  11:07 AM
 ;;4.0;Adverse Reaction Tracking;**22,23,34**;Mar 29, 1996
VALID ;;VDEF HL7 MESSAGE BUILDER
 ; Creates HL7 V2.4 ORU^R01 message for allergy updates & assessments
 ;
 ; This routine uses the following IAs:
 ;   #4248 - VDEFEL calls       (controlled)
 ;   #3630 - VAFCQRY calls      (controlled)
 ;   #2196 - ^PS(50.416,IEN,0)  (controlled)
 ;   #2574 - $$CLASS2^PSNAPIS   (supported)
 ;   #4571 - ERR^VDEFREQ        (controlled)
 ;   #4631 - XTID calls         (supported)
 ;
 ; This routine is called at tag EN as a Function by VDEFREQ1
 ;
 ; This routine calls GMRAIAL2 for a portion of message
 ;
 Q
 ;
EN(EVIEN,KEY,VFLAG,OUT,MSHP) ; Entry point
 ;
 ; Inputs: EVIEN = IEN of VDEF Event in file 577
 ;         KEY - IEN of file to create message from
 ;         VFLAG - "V" for VistA HL7 destination (default)
 ;         OUT - target array, passed by reference
 ;         MSHP - Piece 4 contains message subtype
 ;
 ; Output: Two part string with parts separated by "^"
 ;         Part 1: "LM" - output in local array passed in "OUT" parameter
 ;                 "GM" - output in ^TMP("HLS",$J)
 ;         Part 2: No longer used
 ;
 N DFN,HLFS,HLCM,HLSC,HLRP,HLES,HLQ,ALRDATA,ADD,ALTYPE,XX ;34
 N DATA,VAL,I,S,X,Y,Z,X1,HL7RC,IEN,IEN1,OUTX,GMRAPID,ENTERR
 N SEPF,SEPC,SEPR,SEPE,SEPS,ARRAY,CMP,SEQ,GMRAHL,RSLTSTA
 N GMRAFILE,GMRAIENS,GMRAVUID
 ;
 ; Initialize stuff
 K ^TMP("HLS",$J) S S=0,ARRAY="OUT("_"""HLS"""_",S)",TARGET="LM^"
 M GMRAHL=VDEFHL
 ;
 ; Determine whether API was Allergy Update or Assessment
 S ALTYPE=$S($P(MSHP,"~",4)="ALGY":1,$P(MSHP,"~",4)="ADAS":2,1:1)
 ;
 ; Set up HL7 delimiters
 S HLCM=$E(GMRAHL("ECH")),HLRP=$E(GMRAHL("ECH"),2),HLSC=$E(GMRAHL("ECH"),4),HLES=$E(GMRAHL("ECH"),3)
 S HLFS=GMRAHL("FS"),HLQ=GMRAHL("Q"),HL7RC=HLES_HLFS_HLCM_HLRP_HLSC
 D SETDLMS^VDEFEL
 ;
 ; Get allergy data, patient ID, 'entered in error data'
 ; based on whether it's an allergy update or an assessment
 ; Allergy: ALTYPE=1, Assessment: ALTYPE=2
 D:ALTYPE=1  G EXIT:ZTSTOP=1
 . S ALRDATA=$G(^GMR(120.8,KEY,0))
 . I ALRDATA="" D ERR^VDEFREQ("No data in file GMR(120.8) for IEN "_KEY) S ZTSTOP=1 Q
 . S DFN=$P(ALRDATA,U),ENTERR=$G(^GMR(120.8,KEY,"ER"))
 . S RSLTSTA=$E("FW",1+ENTERR) ;34
 . I $G(^DPT(DFN,0))="" D ERR^VDEFREQ("No data in file DPT for DFN "_DFN) S ZTSTOP=1 Q
 D:ALTYPE=2  G EXIT:ZTSTOP=1
 . S ENTERR="",ALRDATA=$G(^GMR(120.86,KEY,0))
 . I $P(ALRDATA,U,2)="" S ENTERR=1
 . S DFN=$S(+ENTERR=1:KEY,1:$P(ALRDATA,U))
 . I $G(^DPT(DFN,0))="" D ERR^VDEFREQ("No data in file DPT for DFN "_DFN) S ZTSTOP=1 Q
 ;
 ; Build segments for message in OUT, $P # = HL7 field #
 ;
 ; PID - Use MPI PID builder
PID K GMRAPID S OUTX="",S=1,SEQ=""
 D BLDPID^VAFCQRY(DFN,1,SEQ,.GMRAPID,.GMRAHL)
 F I=2:1 Q:$G(GMRAPID(I))=""  S GMRAPID(1,I-1)=GMRAPID(I) K GMRAPID(I)
 M OUTX=GMRAPID(1) K GMRAPID D SAVE
 ;
 ; OBR
OBR S S=S+1,OUTX="",$P(OUTX,HLFS)=1
 S $P(OUTX,HLFS,3)=KEY_HLCM_$P(SITEPARM,U,6)_$S(ALTYPE=1:"_120.8",ALTYPE=2:"_120.86")
 S $P(OUTX,HLFS,4)=$P("ALLERGY,ASSESSMENT",",",ALTYPE)_HLCM_HLCM_"L"
 ;
 ; Result Status
 S $P(OUTX,HLFS,25)=$E("FE",1+ENTERR) ;34
 ;
 ; Date/time reaction entered in system
 S $P(OUTX,HLFS,7)=$$TS^VDEFEL($P(ALRDATA,U,4))
 ;
 ; Originator for allergy
 S XX=$P(ALRDATA,U,$P("5^3",U,ALTYPE)) ;34
 I XX'="" D  ;Block added in 34
 . S XX=$$XCN200^VDEFEL(XX),XX=$TR(XX,HLCM,HLSC)
 . F II=2:1:7 S $P(XX,SEPS,II)=$$HL7RC($P(XX,SEPS,II))
 . S $P(OUTX,HLFS,32)=XX
 G OBRX:ALTYPE=2
 ;
 ; Repeating field of various person roles
 ; Enterer, Verifier, Error User, ID Band Marker, Chart Marker
 ; and associated dates
 S (X,Y,Z)=""
ENT S XX=$P(ALRDATA,U,5) G VER:XX="" ;34
 S XX=$$XCN200^VDEFEL(XX),XX=$TR(XX,HLCM,HLSC) ;34
 F II=2:1:7 S $P(XX,SEPS,II)=$$HL7RC($P(XX,SEPS,II)) ;34
 S VAL=XX,$P(VAL,HLSC,8)="E",Z=VAL ;34
 S $P(Z,HLCM,2)=$$TS^VDEFEL($P(ALRDATA,U,4)),X=Z
VER G ERR:$P(ALRDATA,U,17)=""
 S XX=$$XCN200^VDEFEL($P(ALRDATA,U,18)),XX=$TR(XX,HLCM,HLSC) ;34
 F II=2:1:7 S $P(XX,SEPS,II)=$$HL7RC($P(XX,SEPS,II)) ;34
 S VAL=XX,$P(VAL,HLSC,8)="V",Z=VAL ;34
 S $P(Z,HLCM,2)=$$TS^VDEFEL($P(ALRDATA,U,17)),X=$G(X)_HLRP_Z
ERR S XX=+ENTERR G IDBM:'XX ;34
 S XX=$$XCN200^VDEFEL($P(ENTERR,U,3)),XX=$TR(XX,HLCM,HLSC) ;34
 F II=2:1:7 S $P(XX,SEPS,II)=$$HL7RC($P(XX,SEPS,II)) ;34
 S VAL=XX,$P(VAL,HLSC,8)="EE",Z=VAL ;34
 S $P(Z,HLCM,2)=$$TS^VDEFEL($P(ENTERR,U,2)),X=$G(X)_HLRP_Z
 ;
 ; May be multiple entries for ID Band & Chart Marker persons
IDBM G CHRT:'$D(^GMR(120.8,KEY,14))
 S IEN1=0 F  S IEN1=$O(^GMR(120.8,KEY,14,IEN1)) Q:'+IEN1  D
 . S X1=$G(^GMR(120.8,KEY,14,IEN1,0)) ;34
 . S XX=$$XCN200^VDEFEL($P(X1,U,2)),XX=$TR(XX,HLCM,HLSC) ;34
 . F II=2:1:7 S $P(XX,SEPS,II)=$$HL7RC($P(XX,SEPS,II)) ;34
 . S VAL=XX S:VAL="" VAL=Y S $P(VAL,HLSC,8)="BM",Z=VAL ;34
 . S $P(Z,HLCM,2)=$$TS^VDEFEL($P(X1,U,1)),X=$G(X)_HLRP_Z
CHRT G OBR1:'$D(^GMR(120.8,KEY,13))
 S IEN1=0 F  S IEN1=$O(^GMR(120.8,KEY,13,IEN1)) Q:'+IEN1  D
 . S X1=$G(^GMR(120.8,KEY,13,IEN1,0)) ;34
 . S XX=$$XCN200^VDEFEL($P(X1,U,2)),XX=$TR(XX,HLCM,HLSC) ;34
 . F II=2:1:7 S $P(XX,SEPS,II)=$$HL7RC($P(XX,SEPS,II)) ;34
 . S VAL=XX S:VAL="" VAL=Y S $P(VAL,HLSC,8)="CM",Z=VAL ;34
 . S $P(Z,HLCM,2)=$$TS^VDEFEL($P(X1,U,1)),X=$G(X)_HLRP_Z
OBR1 S $P(OUTX,HLFS,34)=X
 ;
 ; Observed/Historical Indicator
 S X=$P(ALRDATA,U,6),GMRAVUID=$$GETVUID(120.8,6,X)
 S VAL=$P(GMRAVUID,U)_HLCM_$S(X="o":"OBSERVED",X="h":"HISTORICAL",1:"")
 S VAL=VAL_HLCM_$P(GMRAVUID,U,2)
 S $P(OUTX,HLFS,47)=VAL
OBRX S OUTX="OBR"_HLFS_OUTX D SAVE
 ;
 ; If the record is missing both the Reactant and the GMR Allergy
 ; trap it as an error.
 I ALTYPE'=2,$P(ALRDATA,U,2)="",$P(ALRDATA,U,3)="" D ERR^VDEFREQ("Record is missing Reactant and GMR Allergy") S ZTSTOP=1 Q
 ;
 ; OK to continue, call GMRAIAL2 for the rest of the message
CALL D ENTRY^GMRAIAL2
 ;
 ; Done building segments
EXIT Q TARGET
 ;
 ;
 ; Place current string into message array.
 ; Turn string into array if length >245.
 ; Move local array to global if needed.
SAVE N I
 I $P(OUTX,HLFS)'="PID",$L(OUTX)>245 D
 . K ADD S ADD=$E(OUTX,1,245),OUTX=$E(OUTX,246,$L(OUTX))
 . F I=1:1 S ADD(I)=$E(OUTX,1,245),OUTX=$E(OUTX,246,$L(OUTX)) Q:OUTX=""
 . K OUTX M OUTX=ADD
 M @ARRAY=OUTX
 ;
 ; Move local array to global if it's getting big.
 I $P(TARGET,U)="LM",$S<16000 D
 . K ^TMP("HLS",$J) M ^TMP("HLS",$J)=OUT("HLS") K OUT("HLS")
 . S $P(TARGET,U)="GM",ARRAY="^TMP("_"""HLS"""_",$J,S)"
 K OUTX,ADD
 Q
 ;
 ; Replace any HL7 coding chars. in strings with HL7 escape sequence
 ; Input: X = data string
HL7RC(X) N OCHR,RCHR,RCHRI,TYPE,I F TYPE="E","F","C","R","S" D
 . S RCHRI=$S(TYPE="E":1,TYPE="F":2,TYPE="C":3,TYPE="R":4,TYPE="S":5)
 . S OCHR=$E(HL7RC,RCHRI),RCHR=$E("EFSRT",RCHRI)
 . Q:'$F(X,OCHR)
 . F I=1:1 Q:$E(X,I)=""  I $E(X,I)=OCHR S X=$E(X,1,I-1)_HLES_RCHR_HLES_$E(X,I+1,999),I=I+2
 Q X
 ;
 ; Get the VUID value and set up name of coding system
GETVUID(GMRAFILE,GMRAFLD,GMRADATA,GMRAFLSW) ;
 ; Input parameters:
 ;  GMRAFILE - VistA File #
 ;  GMRAFLD  - Field # in GMRAFILE
 ;  GMRADATA - Reference value to look up VUID for
 ;  GMRAFLSW - (Optional) Use 8985.1 if nil, else use GMRAFILE
 ;
 ; Output parameter:
 ;  1st '^' piece - VUID # or 0 if no VUID
 ;  2nd '^' piece - Coding system: "99VA8985.1" if VUID and GMRAFLSW=nil
 ;                                 "99VA"_GMRAFILE if GMRAFLSW=1
 ;                  else = <site_VistA application file #> if no VUID
 N X S X=+$$GETVUID^XTID(GMRAFILE,GMRAFLD,GMRADATA),GMRAFLSW=$G(GMRAFLSW)
 I X S $P(X,U,2)="99VA"_$S(GMRAFLSW:GMRAFILE,1:"8985.1")
 E  S $P(X,U,2)=$P(SITEPARM,U,6)_"_"_GMRAFILE
 Q X
