GMRAIAD1 ;BPOIFO/JG - BUILD HL7 ORU^R01 MESSAGE FOR ADVERSE REACTION - PART 1 ; 18 Feb 2005  2:54 PM
 ;;4.0;Adverse Reaction Tracking;**22,23**;Mar 29, 1996
VALID ;;VDEF HL7 MESSAGE BUILDER
 ; Creates HL7 V2.4 ORU^R01 message for allergy adverse reaction
 ;
 ; This routines uses the following IAs:
 ;   #4248 - VDEFEL calls        (controlled)
 ;   #3630 - VAFCQRY calls       (controlled)
 ;   #2196 - ^PS(50.416,IEN,0)   (controlled)
 ;   #4571 - ERR^VDEFREQ         (controlled)
 ;
 ; This routine is called at tag EN as a Function by VDEFREQ1
 ;
 ; This routine calls GMRAIAD2 for a portion of message
 ;
 Q
 ;
EN(EVIEN,KEY,VFLAG,OUT,MSHP) ;
 ;
 ; Inputs: EVIEN = IEN of message in file 577
 ;      KEY - IEN of file to create message from
 ;      VFLAG - "V" for VistA HL7 destination (default)
 ;      OUT - target array, passed by reference
 ;      MSHP - Piece 4 contains message subtype
 ;
 ; Output: Two part string with parts separated by "^"
 ;      Part 1: "LM" - output in local array passed in "OUT" parameter
 ;              "GM" - output in ^TMP("HLS",$J)
 ;      Part 2: No longer used
 ;
 N DFN,HLFS,HLCM,HLSC,HLRP,HLES,HLQ,ALRDATA,DTE,DTP,ADD
 N DATA,VAL,I,S,X,Y,Z,X1,X2,HL7RC,IEN,OUTX,LIKE,LIKERSP,GMRAPID,SEQ
 N SEPF,SEPC,SEPR,SEPE,SEPS,ARRAY,PTC,CMP,GMRAHL
 ;
 ; Initialize stuff
 K ^TMP("HLS",$J) S S=0,ARRAY="OUT("_"""HLS"""_",S)",TARGET="LM^"
 M GMRAHL=VDEFHL
 ;
 ; Set up HL7 delimiters
 S HLCM=$E(GMRAHL("ECH")),HLRP=$E(GMRAHL("ECH"),2),HLSC=$E(GMRAHL("ECH"),4),HLES=$E(GMRAHL("ECH"),3)
 S HLFS=GMRAHL("FS"),HLQ=GMRAHL("Q"),HL7RC=HLES_HLFS_HLCM_HLRP_HLSC
 D SETDLMS^VDEFEL
 ;
 ; Get allergy data & patient ID
 S ALRDATA=$G(^GMR(120.85,KEY,0))
 I ALRDATA="" D ERR^VDEFREQ("No data in file GMR(120.85) for IEN "_KEY) S ZTSTOP=1 G EXIT
 S DFN=$P(ALRDATA,U,2)
 I $G(^DPT(DFN,0))="" D ERR^VDEFREQ("No data in file DPT for DFN "_DFN) S ZTSTOP=1 G EXIT
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
OBR S S=S+1,OUTX="",$P(OUTX,HLFS)=1,$P(OUTX,HLFS,25)="F"
 S VAL=KEY_HLCM_$P(SITEPARM,U,6)_"_120.85",$P(OUTX,HLFS,3)=VAL
 S $P(OUTX,HLFS,4)="ADVERSE REACTION REPORT"_HLCM_HLCM_"L"
 ;
 ;Date/time reaction occured
 S $P(OUTX,HLFS,7)=$$TS^VDEFEL($P(ALRDATA,U,1))
 ;
 ; Entering User
 S VAL=$$XCN200^VDEFEL($P(ALRDATA,U,19)),$P(VAL,HLCM,8)="ENT",$P(OUTX,HLFS,32)=VAL
 ;
 ; Observer (Witness)
 S VAL=$$XCN200^VDEFEL($P(ALRDATA,U,13)),$P(VAL,HLCM,8)="OBS"
 ;
 ; Reporter
 S X=$P($G(^GMR(120.85,KEY,"RPT")),U,1)
 S X=HLCM_$P(X,",",1)_HLCM_$P($P(X,",",2)," ",1)_HLCM_$P($P(X,",",2)," ",2)
 S $P(X,HLCM,8)="RPT",$P(OUTX,HLFS,34)=VAL_HLRP_X
 ;
 ; Related Reaction
 S X=$P(ALRDATA,U,15)_HLCM_$P($G(^GMR(120.8,$P(ALRDATA,U,15),0)),U,2)_HLCM_"L"
 S $P(OUTX,HLFS,47)=X
 S OUTX="OBR"_HLFS_OUTX D SAVE
 ;
 ; OBX 1 - Symptoms
OBX1 S S=S+1,OUTX=1_HLFS_"CE"_HLFS_"SYMPTOM"_HLFS
 ;
 ; Get the reactions
 S X=0,(Y,Z)="" F  S X=$O(^GMR(120.85,KEY,2,X))  Q:X'?1N.N  D
 . S Y=^GMR(120.85,KEY,2,X,0),VAL=$P(Y,U,3)
 . I $P(Y,U,2)'="" S Z=Z_$P(Y,U,2)_HLRP
 . E  S Z=Z_$P(^GMRD(120.83,+Y,0),U,1)_HLRP
 S $P(OUTX,HLFS,5)=$E(Z,1,$L(Z)-1)
 ;
 ; Severity
 S $P(OUTX,HLFS,8)=$$GET1^DIQ(120.85,KEY_",",14.5)
 ;
 ; Reaction entered by
 S $P(OUTX,HLFS,16)=$$XCN200^VDEFEL(VAL)
 S $P(OUTX,HLFS,11)="F"
 S OUTX="OBX"_HLFS_OUTX D SAVE
 ;
 ; RXA/RXE/RXR/OBX Suspected Agent Group
 G OBX2:$G(^GMR(120.85,KEY,3,1,0))="" S IEN=0
RXAGRP1 F  S IEN=$O(^GMR(120.85,KEY,3,IEN)) Q:IEN'?1N.N  D
 . S S=S+1,OUTX="0"_HLFS_"1" K ALRDATA M ALRDATA=^GMR(120.85,KEY,3,IEN)
 . ;
 . ; RXA
 . ; Start & Stop dates
 . S VAL=$P($G(ALRDATA(1)),U) I VAL S $P(OUTX,HLFS,3)=$$TS^VDEFEL(VAL)
 . S VAL=$P($G(ALRDATA(1)),U,2) I VAL S $P(OUTX,HLFS,4)=$$TS^VDEFEL(VAL)
 . ;
 . ; Suspected agent & daily dose
 . S VAL=$P(ALRDATA(0),U),$P(OUTX,HLFS,5)=$$HL7RC(VAL)
 . S VAL=$P(ALRDATA(0),U,2),$P(OUTX,HLFS,6)=$$HL7RC(VAL)
 . ;
 . ; Lot number, Exp. Date, Manufacturer
 . S VAL=$P(ALRDATA(0),U,8) S:VAL $P(OUTX,HLFS,15)=$$HL7RC(VAL)
 . S VAL=$P($G(ALRDATA(1)),U,3) I VAL S $P(OUTX,HLFS,16)=$$TS^VDEFEL(VAL)
 . S VAL=$P(ALRDATA(0),U,7) S:VAL $P(OUTX,HLFS,17)=$$HL7RC(VAL)
 . ;
 . ; Indication for use
 . S VAL=$P(ALRDATA(0),U,4) S:VAL $P(OUTX,HLFS,19)=$$HL7RC(VAL)
 . ;
 . ; Set into array
 . S OUTX="RXA"_HLFS_OUTX D SAVE
 . ;
 . ; RXE
 . S S=S+1,OUTX="",CMP=""
 . ;
 . ; Previous doses
 . S $P(CMP,HLCM,1)=$$HL7RC($P(ALRDATA(0),U,9))
 . ;
 . ; Duration
 . S X1=$P($G(ALRDATA(1)),U,2),X2=$P($G(ALRDATA(1)),U) D ^%DTC S:X="" X=0 S $P(CMP,HLCM,3)=X
 . ;
 . ; Last date given
 . S VAL=$P(ALRDATA(0),U,10) I VAL S $P(CMP,HLCM,5)=$$TS^VDEFEL(VAL)
 . S $P(OUTX,HLFS)=CMP,CMP=""
 . ;
 . ; Give codes
 . S VAL=$P(ALRDATA(0),U),$P(CMP,HLCM,1)=$$HL7RC(VAL)
 . S $P(CMP,HLCM,4)=$P($G(ALRDATA(1)),U,4),$P(CMP,HLCM,6)="NDC"
 . S $P(OUTX,HLFS,2)=CMP,$P(OUTX,HLFS,3)=0
 . ;
 . ; SIG
 . S $P(OUTX,HLFS,7)=$$HL7RC($P($G(ALRDATA(1)),U,5))
 . ;
 . ; Daily dose
 . S $P(OUTX,HLFS,19)=$$HL7RC($P(ALRDATA(0),U,2))
 . S OUTX="RXE"_HLFS_OUTX D SAVE
 . ;
 . ; RXR
 . ; Route of administration
 . S OUTX="",VAL=$P(ALRDATA(0),U,3) S:VAL="" VAL="UNKNOWN" S $P(OUTX,HLFS,1)=$$HL7RC(VAL)
 . S S=S+1,OUTX="RXR"_HLFS_OUTX D SAVE
 . ;
 . ; OBX - LIKES
 . S LIKERSP=$G(ALRDATA("LIKE")) I LIKERSP'="" F LIKE=1:1:6 D
 . . S S=S+1,OUTX=1_HLFS_"CE"_HLFS
 . . S VAL="LIKE "_LIKE_HLCM_$P($T(LIKEQ+(LIKE)),";",3),$P(OUTX,HLFS,3)=VAL
 . . S X=$P(LIKERSP,U,LIKE),X=$S(X="y":"Y",X="n":"N",1:""),VAL=X_HLCM
 . . S X=$S(X="Y":"YES",X="N":"NO",1:"")
 . . S VAL=VAL_X_HLCM_"HL70136",$P(OUTX,HLFS,5)=VAL,$P(OUTX,HLFS,11)="F"
 . . S OUTX="OBX"_HLFS_OUTX D SAVE
 . . ;
 . ; Likelihood
 . S S=S+1,OUTX=1_HLFS_"CE"_HLFS_"LIKELIHOOD"
 . S VAL=$P(LIKERSP,U,7) S:VAL="" VAL=5
 . S X=VAL_HLCM_$P("REMOTE,POSSIBLE,PROBABLE,HIGHLY PROBABLE, ",",",VAL)
 . S $P(OUTX,HLFS,5)=X,$P(OUTX,HLFS,11)="F"
 . S OUTX="OBX"_HLFS_OUTX D SAVE
 ;
 ; OBX2 - Lab Results
OBX2 S X=$G(^GMR(120.85,KEY,4,0)) G CALL:X=""
 S IEN=0 F  S IEN=$O(^GMR(120.85,KEY,4,IEN)) Q:IEN'?1N.N  D
 . S S=S+1,OUTX=1_HLFS_"CE"_HLFS
 . S X=^GMR(120.85,KEY,4,IEN,0),$P(OUTX,HLFS,3)=$$HL7RC($P(X,U,1))
 . S $P(OUTX,HLFS,5)=$$HL7RC($P(X,U,2)),$P(OUTX,HLFS,11)="F"
 . S $P(OUTX,HLFS,14)=$$TS^VDEFEL($P(X,U,3))
 . S OUTX="OBX"_HLFS_OUTX D SAVE
 ;
 ; Call GMRAIAD2
CALL D ENTRY^GMRAIAD2
 ;
 ; OBX10 - IND/NDA Info
OBX10 S X=$G(^GMR(120.85,KEY,"MFR2")) G RXAGRP2:X=""
 S S=S+1,OUTX=1_HLFS_"ST",$P(OUTX,HLFS,5)=$P(X,U,1)
 S OUTX="OBX"_HLFS_OUTX D SAVE
 ;
 ; RXA/RXE Concommitant Drugs Group
RXAGRP2 S X=$G(^GMR(120.85,KEY,13,0)) G EXIT:X=""
 S IEN=0 F  S IEN=$O(^GMR(120.85,KEY,13,IEN)) Q:IEN'?1N.N  D
 . ;
 . ; RXA
 . S X=^GMR(120.85,KEY,13,IEN,0),S=S+1,OUTX=0_HLFS_1
 . ;
 . ; Start Date, Stop Date
 . I $P(X,U,2)'="" S $P(OUTX,HLFS,3)=$$TS^VDEFEL($P(X,U,2))
 . I $P(X,U,3)'="" S $P(OUTX,HLFS,4)=$$TS^VDEFEL($P(X,U,3))
 . ;
 . ; Drug Name
 . S $P(OUTX,HLFS,5)=$$HL7RC($P(X,U,1)),$P(OUTX,HLFS,6)=0
 . S OUTX="RXA"_HLFS_OUTX D SAVE
 . ;
 . ; RXE
 . ; Stop Date
 . S S=S+1,OUTX="",VAL=$$TS^VDEFEL($P(X,U,3))
 . S Y="",$P(Y,HLCM,5)=VAL,$P(OUTX,HLFS,1)=Y
 . ;
 . ; Drug Name
 . S $P(OUTX,HLFS,2)=$$HL7RC($P(X,U,1)),$P(OUTX,HLFS,3)=0
 . ;
 . ; SIG if known
 . S $P(OUTX,HLFS,5)="UNK",$P(OUTX,HLFS,7)=$$HL7RC($P(X,U,5))
 . S OUTX="RXE"_HLFS_OUTX D SAVE
 ;
 ; Done building segments
EXIT Q TARGET
 ;
 ;
 ; Place current string into message array
 ; Turn string into array if length >245.
 ; Move local array to global if needed
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
LIKEQ ; LIKE set
 ;;1. Reaction normally occurs with this reactant?
 ;;2. Administration of the reactant was stopped?
 ;;3. Reaction stopped when the administration of the reactant was terminated?
 ;;4. Reactant was re-administered?
 ;;5. Reaction could be due to the patient current clinical condition?
 ;;6. Reaction reappeared after the reactant was re-administered?
