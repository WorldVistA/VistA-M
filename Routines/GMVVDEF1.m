GMVVDEF1 ;BPOIFO/JG,HIOFO/FT - BUILD HL7 ORU^R01 MESSAGE FOR VITALS ; 20 Sep 2005  4:36 PM
 ;;5.0;GEN. MED. REC. - VITALS;**5,8,12,17,11**;Oct 31, 2002
 ;11/30/2005 KAM/BAY Remedy Calls 121661 and 122742 changes for HL7 message
VALID ;;VDEF HL7 MESSAGE BUILDER
 ; Creates HL7 V2.4 ORU^R01 message for vitals
 ;
 ; This routine uses the following IAs:
 ;    #93 - FILE 44 references   (controlled)
 ;   #557 - FILE 40.7 references (controlled)
 ;  #2432 - FILE 44 references   (controlled)
 ;  #3630 - VAFCQRY calls        (controlled)
 ;  #4248 - VDEFEL calls         (controlled)
 ;  #4571 - VDEFREQ calls        (controlled)
 ; #10035 - DPT( references      (supported)
 ; #10040 - FILE 44 references   (supported)
 ; #10112 - VASITE calls         (supported)
 ;
 ; This routine is called at tag EN as a Function by VDEFREQ1
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
 N DFN,HLFS,HLCM,HLSC,HLRP,HLES,HLQ,VTLDAT,UM,VTLTYP,DTE,DTP
 N VTLERR,VAL,I,S,X,XX,Y,QUALS,HL7RC,PIDSEG,IEN1,SEQ,STOPCD,EIEVUID
 N SEPF,SEPC,SEPR,SEPE,SEPS,VTLNAM,ARRAY,O2SUP,OUTX,ADD,VTLVUID
 ;
 ; Initialize stuff
 K ^TMP("HLS",$J) S S=0,ARRAY="OUT("_"""HLS"""_",S)",TARGET="LM^"
 ;
 ; Set up HL7 delimiters
 S HLCM=$E(VDEFHL("ECH")),HLRP=$E(VDEFHL("ECH"),2),HLSC=$E(VDEFHL("ECH"),4),HLES=$E(VDEFHL("ECH"),3)
 S HLFS=VDEFHL("FS"),HLQ=VDEFHL("Q"),HL7RC=HLES_HLFS_HLCM_HLRP_HLSC
 D SETDLMS^VDEFEL
 ;
 ; Get the vitals measurement record & patient ID
 S VTLDAT=$$EN^GMVHDR(KEY)
 I 'VTLDAT D ERR^VDEFREQ("Invalid data in file GMR(120.5) for IEN "_KEY) S ZTSTOP=1 G EXIT
 S DFN=$P(VTLDAT,U,2),VTLTYP=$P(VTLDAT,U,7)
 S VTLVUID=$$GET^GMVUID(120.51,.01,+VTLTYP_",") ;vital type vuid
 S O2SUP=$P(VTLDAT,U,10),VTLERR=$P(VTLDAT,U,11)
 S X=$P(VTLDAT,U,5) I +X'=X!(X<0) S $P(VTLDAT,U,5)=""
 S STOPCD=""
 I $P(VTLDAT,U,5)'="" D
 . S STOPCD=$P($G(^SC($P(VTLDAT,U,5),0)),U,7) Q:STOPCD=""
 . S STOPCD=$G(^DIC(40.7,STOPCD,0))
 . S STOPCD=$$HL7RC($P(STOPCD,U,2))_";"_$$HL7RC($P(STOPCD,U))
 ;
 ; Build segments for message in OUTX, $P # = HL7 field #
 ;
 ; PID - Use MPI PID builder
PID K PIDSEG S OUTX="",S=1,SEQ=""
 I $G(^DPT(DFN,0))="" D ERR^VDEFREQ("No entry in file DPT for DFN "_DFN) S ZTSTOP=1 G EXIT
 D BLDPID^VAFCQRY(DFN,1,SEQ,.PIDSEG,.VDEFHL)
 F I=2:1 Q:$G(PIDSEG(I))=""  S PIDSEG(1,I-1)=PIDSEG(I) K PIDSEG(I)
 M OUTX=PIDSEG(1) K PIDSEG D SAVE
 ;
 ; ORC
ORC S S=S+1,OUTX="RE"
 ;
 ; Filler ID
 S X=KEY_HLCM_$$HL7RC($P(SITEPARM,U,6))_"_120.5",$P(OUTX,HLFS,3)=X
 ;
 ; Enterer's location
 I $P(VTLDAT,U,5)'="" D
 . S X=$G(^SC($P(VTLDAT,U,5),0)),VAL=$$HL7RC($P(X,U,2))_HLCM_$P(VTLDAT,U,5)
 . S $P(VAL,HLCM,9)=$$HL7RC($P(X,U)),$P(OUTX,HLFS,13)=VAL
 . I +$P(X,U,15) S X=$$SITE^VASITE($P(VTLDAT,U),$P(X,U,15)) S:X=-1 X=""
 . E  S X=""
 . S VAL=$$HL7RC($P(X,U,3))_HLCM_$$HL7RC($P(X,U,2))_HLCM_"L",$P(OUTX,HLFS,17)=VAL
 ; Parent Facility (Added 04/17/2006)
 S $P(OUTX,HLFS,21)=$P($$SITE^VASITE(),"^",2)
 ;
 S VAL=$P(OUTX,HLFS,3),OUTX="ORC"_HLFS_OUTX D SAVE
 ;
 ; OBR
OBR S S=S+1,OUTX="",VTLNAM=$$HL7RC($P(^GMRD(120.51,VTLTYP,0),U))
 S X=VTLVUID_HLCM_VTLNAM_HLCM_$$HL7RC("99VA120.51")
 ;
 ; Add filler ID from ORC-3 & Procedure name
 S $P(OUTX,HLFS,3)=VAL,$P(OUTX,HLFS,4)=X
 ;
 ; Dates/times vital taken & entered
 S DTP=$$HL7RC($$TS^VDEFEL($P(VTLDAT,U))),$P(OUTX,HLFS,7)=DTP
 S DTE=$$HL7RC($$TS^VDEFEL($P(VTLDAT,U,4))),$P(OUTX,HLFS,8)=DTE
 ;
 ; Use date/time vital entered for results reported
 S $P(OUTX,HLFS,22)=DTE
 ;
 ; Set result status to Final or Error if entered in error
 S $P(OUTX,HLFS,25)=$E("FE",VTLERR'=""+1)
 ;
 ; Technician name
 S XX=$$XCN200^VDEFEL($P(VTLDAT,U,6))
 F II=2:1:7 S $P(XX,SEPC,II)=$$HL7RC($P(XX,SEPC,II))
 S $P(OUTX,HLFS,34)=XX
 S OUTX="OBR"_HLFS_OUTX D SAVE
 ;
 ; OBX 1 - Vital name
OBX1 S S=S+1,OUTX=HLFS_"ST"
 ;
 ; Observation ID - Vital name
 S X=VTLVUID_HLCM_VTLNAM_HLCM_$$HL7RC("99VA120.51"),$P(OUTX,HLFS,3)=X
 ;
 ; Unit of measure
 ; If vital not performed, set units to null
 S UM=$$HL7RC($P(VTLDAT,U,9)) S:$F("Pass Refused Unavailable",$P(VTLDAT,U,8))>0 UM=""
 S UM=UM_HLCM_UM_HLCM_"L"
 ;
 ; Set sub-id if O2 supplements to follow
 S:O2SUP'="" $P(OUTX,HLFS,4)=1
 S $P(OUTX,HLFS,5)=$$HL7RC($P(VTLDAT,U,8)),$P(OUTX,HLFS,6)=UM
 ;
 ; Set result status to Final or Wrong if errors entered
 S $P(OUTX,HLFS,11)=$E("FW",VTLERR'=""+1)
 S XX=$$XCN200^VDEFEL($P(VTLDAT,U,6))
 F II=2:1:7 S $P(XX,SEPC,II)=$$HL7RC($P(XX,SEPC,II))
 S $P(OUTX,HLFS,16)=XX
 S OUTX="OBX"_HLFS_OUTX D SAVE
 ;
 ; OBX2 - O2 Supplement
OBX2 G QUALS:O2SUP="" S (VAL,UM)=""
 S S=S+1,OUTX=HLFS_"ST"_HLFS_"O2 Supplement" D
 . I O2SUP["%",O2SUP'["l/min" S VAL=+O2SUP,UM="%" Q
 . I O2SUP'["%",O2SUP["l/min" S VAL=+O2SUP,UM="l/min"
 . I O2SUP["%",O2SUP["l/min" S $P(VAL,U)=$P(O2SUP," "),$P(UM,U)="l/min",$P(VAL,U,2)=+$P(O2SUP," ",3),$P(UM,U,2)="%"
 S X=$P(UM,U),X=X_HLCM_X_HLCM_"L",$P(UM,U)=X
 I $P(UM,U,2)'="" S X=$P(UM,U,2),X=X_HLCM_X_HLCM_"L",$P(UM,U,2)=X
 S $P(OUTX,HLFS,4)=2,$P(OUTX,HLFS,5)=$P(VAL,U,1),$P(OUTX,HLFS,6)=$P(UM,U)
 ;
 ; Set result status to Final or Wrong if errors entered
 S $P(OUTX,HLFS,11)=$E("FW",VTLERR'=""+1)
 S OUTX="OBX"_HLFS_OUTX,X=OUTX D SAVE
 ; If more than one O2 supplement, add another OBX
 ; Field offset in OUT is now +1 because OBX has been added
 S OUTX=X I $P(VAL,U,2)'="" D
 . S S=S+1,$P(OUTX,HLFS,5)=3,$P(OUTX,HLFS,6)=$P(VAL,U,2),$P(OUTX,HLFS,7)=$P(UM,U,2)
 . D SAVE
 ;
 ; Qualifiers
QUALS S QUALS="",X=$O(^GMR(120.5,KEY,5,0)) G ERRS:X=""
 S S=S+1,OUTX=HLFS_"CE"_HLFS_"Qualifiers"_HLFS_HLFS
 ;
 ; Get qualifiers
 S IEN1=0 F  S IEN1=$O(^GMR(120.5,KEY,5,IEN1)) Q:'+IEN1  D
 . S X=^GMR(120.5,KEY,5,IEN1,0),VAL=$$HL7RC($P(^GMRD(120.52,X,0),U))
 . S X=$$GET^GMVUID(120.52,.01,+X_",") ;qualifier vuid
 . S VAL=X_HLCM_VAL_HLCM_$$HL7RC("99VA120.52"),QUALS=QUALS_VAL_HLRP
 ;
 ; Set result
 S $P(OUTX,HLFS,5)=$E(QUALS,1,$L(QUALS)-1)
 ;
 ; Set result status to Final or Wrong if errors entered
 S $P(OUTX,HLFS,11)=$E("FW",VTLERR'=""+1)
 S OUTX="OBX"_HLFS_OUTX D SAVE
 ;
 ; Entered in Error
ERRS G ZSC:VTLERR="" S S=S+1,OUTX=HLFS_"CE"_HLFS_"Error Reasons"_HLFS_HLFS
 ;
 ; Error data reason(s)
 S X=$P(VTLDAT,U,13),VAL=""
 F I=1:1:$L(X,"~") D
 .S Y=$P(X,"~",I)
 .S EIEVUID=$$GET^GMVUID(120.506,.01,$P(Y,"-",1)) ;error vuid
 .S VAL=VAL_$$HL7RC(EIEVUID)_HLCM_$$HL7RC($P(Y,"-",2))_HLCM_$$HL7RC("99VA8985.1")_HLRP
 S VAL=$E(VAL,1,$L(VAL)-1),$P(OUTX,HLFS,5)=VAL
 ;
 ; Set result status to Final or Wrong if errors entered
 S $P(OUTX,HLFS,11)=$E("FW",VTLERR'=""+1)
 ;
 ; Entered in error by technician
 S XX=$$XCN200^VDEFEL($P(VTLDAT,U,12))
 F II=2:1:7 S $P(XX,SEPC,II)=$$HL7RC($P(XX,SEPC,II))
 S $P(OUTX,HLFS,16)=XX
 S OUTX="OBX"_HLFS_OUTX D SAVE
 ;
 ; Stop Code & Name
ZSC G EXIT:STOPCD=""
 S S=S+1,OUTX=HLFS_$P(STOPCD,";")_HLFS_$P(STOPCD,";",2)
 S OUTX="ZSC"_HLFS_OUTX D SAVE
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
