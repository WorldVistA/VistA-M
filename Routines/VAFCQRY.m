VAFCQRY ;BIR/DLR-Query for patient demographics ;10/18/2000
 ;;5.3;Registration;**428,575,627,707**;Aug 13, 1993;Build 14
 ;   
IN ;process in the patient query
 N IEN,HLA,VAFCCNT,ICN,CLAIM,SG,VAFCER,VAFC,DFN,STATE,CITY,SUBCOMP,COMP,REP,LVL,LVL2,VAFC,SSN
 S VAFCCNT=1,VAFCER=1
 F VAFC=1:1 X HLNEXT Q:HLQUIT'>0  S SG=$E(HLNODE,1,3) D:$T(@SG)]"" @SG
 D CHKID^VAFCQRY2(.ICN,.SSN,.DFN)
 I $G(DFN)'>0 S VAFCER="-1^Unknown ICN#"_$G(ICN)_" and SSN#"_$G(SSN)
 S ^TMP("HLA",$J,VAFCCNT)="MSA"_HL("FS")_"AA"_HL("FS")_HL("MID")_HL("FS")_$S(+$G(VAFCER)'>0:$P(VAFCER,"^",2),1:""),VAFCCNT=VAFCCNT+1
 S ^TMP("HLA",$J,VAFCCNT)=VAFCQRD,VAFCCNT=VAFCCNT+1
 I $G(VAFCER)>0 D BLDRSP(DFN,.VAFCCNT)
 D LINK^HLUTIL3(SITE,.VAFC) S IEN=$O(VAFC(0)) S HLL("LINKS",1)="^"_VAFC(IEN)
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"GM",1,.HLRESLTA,"",.HL)
 K VAFCER,VAFCID,COMP,SITE,VAFCFS,VAFCRCV,VAFCQRD,^TMP("HLA",$J)
 Q
RESP ;Response processing initiated from the MPI.
 Q
ROUTE ;Routine logic initiated from the MPI.
 Q
BLDRSP(DFN,VAFCCNT) ;
 N EVN,PID,PD1,SEQ,ERR,CNT,X,PV2,RADE,LABE,PRES
 ;construct EVN (for TF Event Type AND Last Treatment Date)
 S SEQ="1,2" D BLDEVN(DFN,.SEQ,.EVN,.HL,"A19",.ERR) S ^TMP("HLA",$J,VAFCCNT)=EVN(1) S VAFCCNT=VAFCCNT+1
 ;construct PID
 S SEQ="ALL" D BLDPID(DFN,1,.SEQ,.PID,.HL,.ERR) S ^TMP("HLA",$J,VAFCCNT)=PID(1) S X=1,CNT=1 F  S X=$O(PID(X)) Q:'X  I $D(PID(X)) S ^TMP("HLA",$J,VAFCCNT,CNT)=PID(X),CNT=CNT+1
 S VAFCCNT=VAFCCNT+1
 ;construct PD1 **707
 ;S SEQ="3" D BLDPD1(DFN,.SEQ,.PD1,.HL,.ERR) S ^TMP("HLA",$J,VAFCCNT)=PD1(1)
 S PD1=$$PD1^VAFCSB I PD1'="" S ^TMP("HLA",$J,VAFCCNT)=PD1,VAFCCNT=VAFCCNT+1 ;**707
 S PV1=$$PV1^VAFCSB I PV1'="" S ^TMP("HLA",$J,VAFCCNT)=PV1,VAFCCNT=VAFCCNT+1 ;**707
 S PV2=$$PV2^VAFCSB I PV2'="" S ^TMP("HLA",$J,VAFCCNT)=PV2,VAFCCNT=VAFCCNT+1 ;**707
 S PRES=$$PHARA^VAFCSB I PRES'="" S ^TMP("HLA",$J,VAFCCNT)=PRES,VAFCCNT=VAFCCNT+1 ;**707
 S LABE=$$LABE^VAFCSB I LABE'="" S ^TMP("HLA",$J,VAFCCNT)=LABE,VAFCCNT=VAFCCNT+1 ;**707
 S RADE=$$RADE^VAFCSB I RADE'="" S ^TMP("HLA",$J,VAFCCNT)=RADE,VAFCCNT=VAFCCNT+1 ;**707
 ;** PATCH 575
 ;construct ZPD segment
 S SEQ="1,17,21,34" ;**707 Added 1, 21 and 34 to ZPD fields
 S ^TMP("HLA",$J,VAFCCNT)=$$EN1^VAFHLZPD(DFN,SEQ)
 S VAFCCNT=VAFCCNT+1
 Q
MSH ;process MSH segment
 S VAFCFS=HL("FS")
 S HLQ=HL("Q"),HLFS=HL("FS"),HLECH=HL("ECH")
 S VAFCID=HL("MID")
 S COMP=$E(HL("ECH"),1)
 S REP=$E(HL("ECH"),2)
 S SUBCOMP=$E(HL("ECH"),4)
 S SITE=$$LKUP^XUAF4($P($P(HLNODE,HL("FS"),4),COMP))
 Q
QRD ;process QRD segment
 N QRD,X,IDS,WSF,ID,QRDAA,QRDNTC
 S VAFCQRD=HLNODE
 S VAFCRCV=$P(VAFCQRD,HL("FS"),5)
 S IDS=$P(VAFCQRD,HL("FS"),9)
 F X=1:1:$L(IDS,REP) S WSF=$P(IDS,REP,X) D
 . ;get id, assigning authority, and name type code
 . S ID=$P(WSF,COMP),QRDAA=$P($P(WSF,COMP,9),SUBCOMP),QRDNTC=$P(WSF,COMP,10)
 . ;check assigning authority(0363) AND name type code(0203)
 . I QRDAA="USVHA" D
 .. I QRDNTC="NI" S ICN=ID  ;National unique individual identifier
 .. I QRDNTC="PI" S DFN=ID  ;Patient internal identifier
 . I QRDAA="USSSA" D
 .. I QRDNTC="SS" S SSN=ID  ;Social Security number
 Q
BLDEVN(DFN,SEQ,EVN,HL,EVR,ERR) ;build EVN for TF last treatment date and event reason
 ; At this point only sequence one and two are supported
 ; Variable list
 ;  DFN - internal PATIENT (#2) number
 ;  SEQ - variable consisting of sequence numbers delimited by commas
 ;        that will be used to build the message
 ;  EVN (passed by reference) - array location to place EVN segment result, the array can have existing values when passed.
 ;   HL - array that contains the necessary HL variables (init^hlsub)
 ;  EVR - event reason that triggered this message
 ;  ERR - array that is used to return an error
 ;
 D BLDEVN^VAFCQRY2(DFN,SEQ,.EVN,.HL,EVR,.ERR)
 Q
BLDPD1(DFN,SEQ,PD1,HL,ERR) ;
 ; At this point only sequence 3 is supported
 ; Variable list
 ;  DFN - internal PATIENT (#2) number
 ;  SEQ - variable consisting of sequence numbers delimited by commas
 ;        that will be used to build the message
 ;  PD1 (passed by reference) - array location to place PD1 segment result, the array can have existing values when passed.
 ;   HL - array that contains the necessary HL variables (init^hlsub)
 ;  ERR - array that is used to return an error
 ;
 D BLDPD1^VAFCQRY2(DFN,SEQ,.PD1,.HL,.ERR)
 Q
BLDPID(DFN,CNT,SEQ,PID,HL,ERR) ;build PID from File #2
 ;The required sequences 3 and 5 will be returned and at this point
 ;sequences 1-3,5-8,10-14,16,17,19,22-24 and 29 are supported
 ;
 ; At this point only sequence one and two are supported
 ; Variable list
 ;  DFN - internal PATIENT (#2) number
 ;  CNT - value to be place in PID seq#1 (SET ID)
 ;  SEQ - variable consisting of sequence numbers delimited by commas
 ;        that will be used to build the message
 ;  PID (passed by reference) - array location to place PID segment
 ;        result, the array can have existing values when passed.
 ;   HL - array that contains the necessary HL variables (init^hlsub)
 ;  ERR - array that is used to return an error
 ;
 ;if this is a mismatch a null or """" should be passed in, so that
 ;the ICN will be removed at the site
 ;
 D BLDPID^VAFCQRY1(DFN,CNT,SEQ,.PID,.HL,.ERR)
 Q
