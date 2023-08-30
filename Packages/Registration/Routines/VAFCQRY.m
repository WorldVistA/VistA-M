VAFCQRY ;BIR/DLR-Query for patient demographics ;1/27/23  14:07
 ;;5.3;Registration;**428,575,627,707,863,902,926,967,1059,1092**;Aug 13, 1993;Build 1
 ;
IN ;process in the patient query
 N IEN,HLA,VAFCCNT,ICN,CLAIM,SG,VAFCER,VAFC,DFN,STATE,CITY,SUBCOMP,COMP,REP,LVL,LVL2,VAFC,SSN,SAVEDFN
 S VAFCCNT=1,VAFCER=1
 F VAFC=1:1 X HLNEXT Q:HLQUIT'>0  S SG=$E(HLNODE,1,3) D:$T(@SG)]"" @SG
 S SAVEDFN=$G(DFN)
 D CHKID^VAFCQRY2(.ICN,.SSN,.DFN)
 I $G(DFN)'>0 D
 . ;**863 MVI_2352 if merged send back merged record info for update
 . I SAVEDFN,$D(^DPT(SAVEDFN,-9)) D  Q
 .. N DFN,ICN
 .. S DFN=^DPT(SAVEDFN,-9),ICN=$$GETICN^MPIF001(+DFN)
 .. S VAFCER="-1^New Primary record "_DFN_" at site with ICN "_ICN
 . S VAFCER="-1^Unknown ICN#"_$G(ICN)_" and SSN#"_$G(SSN)
 S ^TMP("HLA",$J,VAFCCNT)="MSA"_HL("FS")_"AA"_HL("FS")_HL("MID")_HL("FS")_$S(+$G(VAFCER)'>0:$P(VAFCER,"^",2),1:""),VAFCCNT=VAFCCNT+1
 S ^TMP("HLA",$J,VAFCCNT)=VAFCQRD,VAFCCNT=VAFCCNT+1
 I $G(VAFCER)>0 D BLDRSP(DFN,.VAFCCNT)
 D LINK^HLUTIL3(SITE,.VAFC) S IEN=$O(VAFC(0)) S HLL("LINKS",1)="^"_VAFC(IEN)
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"GM",1,.HLRESLTA,"",.HL)
 K VAFCER,VAFCID,COMP,SITE,VAFCFS,VAFCRCV,VAFCQRD,^TMP("HLA",$J)
 Q
 ;
RESP ;Response processing initiated from the MPI.
 Q
 ;
ROUTE ;Routine logic initiated from the MPI.
 Q
 ;
BLDRSP(DFN,VAFCCNT) ;
 N EVN,PID,PD1,SEQ,ERR,CNT,X,PV2,RADE,LABE,PRES
 N SIDG,ZEL,ZSP,NAMECOMP,OLD,PV1,DODF,DODD,DODOPT,DODNP,DODDISDT,SECLVL,SEXOR,SEXORD,PRON,PROND
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
 S SIDG=$$SIG^VAFCSB(DFN) I $G(SIDG)'="" S ^TMP("HLA",$J,VAFCCNT)=SIDG,VAFCCNT=VAFCCNT+1  ;**902 MVI_4634 (ckn) - OBX FOR SELF ID GENDER
 S NAMECOMP=$$NAMEOBX^VAFCSB(DFN) I $G(NAMECOMP)'="" S ^TMP("HLA",$J,VAFCCNT)=NAMECOMP,VAFCCNT=VAFCCNT+1  ;**902 MVI_4634 (ckn): OBX for Patient .01 and Name Components
 S OLD=$$OLD(DFN) I $G(OLD)'="" S ^TMP("HLA",$J,VAFCCNT)=OLD,VAFCCNT=VAFCCNT+1  ;**902 MVI_4634 (ckn) - OBX to mark and Older record
 S DODF=$$DODF^VAFCSB(DFN) I $G(DODF)'="" S ^TMP("HLA",$J,VAFCCNT)=DODF,VAFCCNT=VAFCCNT+1  ;**902 MVI_4898 (ckn) : OBX for DOD fields
 ;**926 Story 3230009 (ckn) : OBX for Additional DOD fields
 S DODD=$$DODD^VAFCSB(DFN) I $G(DODD)'="" S ^TMP("HLA",$J,VAFCCNT)=DODD,VAFCCNT=VAFCCNT+1  ;Date of Death Documents
 S DODOPT=$$DODOPT^VAFCSB(DFN) I $G(DODOPT)'="" S ^TMP("HLA",$J,VAFCCNT)=DODOPT,VAFCCNT=VAFCCNT+1  ;Date of Death Option
 S DODNP=$$DODNTPRV^VAFCSB(DFN) I $G(DODNP)'="" S ^TMP("HLA",$J,VAFCCNT)=DODNP,VAFCCNT=VAFCCNT+1  ;Date Of Death Notify Provider
 ;**967 - Story 783361 (ckn) - OBX for Security Level
 S SECLVL=$$SECLOG^VAFCSB(DFN) I $G(SECLVL)'="" S ^TMP("HLA",$J,VAFCCNT)=SECLVL,VAFCCNT=VAFCCNT+1
 D SEXOR^VAFCSB(DFN,.SEXOR) I $O(SEXOR(0)) N CNT S CNT=0 F  S CNT=$O(SEXOR(CNT)) Q:'CNT  S ^TMP("HLA",$J,VAFCCNT)=SEXOR(CNT),VAFCCNT=VAFCCNT+1 ;**1059, VAMPI-11114 (dri), **1092, VAMPI-18606 (dri)
 D SEXORD^VAFCSB(DFN,.SEXORD) I $O(SEXORD(0)) D  S VAFCCNT=VAFCCNT+1 ;**1059, VAMPI-11114 (dri), **1092, VAMPI-18606 (dri)
 .N CNT,LVL
 .S LVL=1,CNT=0 F  S CNT=$O(SEXORD(CNT)) Q:'CNT  D
 ..I CNT=1 S ^TMP("HLA",$J,VAFCCNT)=SEXORD(CNT)
 ..I CNT>1 S ^TMP("HLA",$J,VAFCCNT,LVL)=SEXORD(CNT),LVL=LVL+1
 D PRON^VAFCSB(DFN,.PRON) I $O(PRON(0)) N CNT S CNT=0 F  S CNT=$O(PRON(CNT)) Q:'CNT  S ^TMP("HLA",$J,VAFCCNT)=PRON(CNT),VAFCCNT=VAFCCNT+1 ;**1059, VAMPI-11118 (dri), **1092, VAMPI-18606 (dri)
 D PROND^VAFCSB(DFN,.PROND) I $O(PROND(0)) D  S VAFCCNT=VAFCCNT+1 ;**1059, VAMPI-11118 (dri), **1092, VAMPI-18606 (dri)
 .N CNT,LVL
 .S LVL=1,CNT=0 F  S CNT=$O(PROND(CNT)) Q:'CNT  D
 ..I CNT=1 S ^TMP("HLA",$J,VAFCCNT)=PROND(CNT)
 ..I CNT>1 S ^TMP("HLA",$J,VAFCCNT,LVL)=PROND(CNT),LVL=LVL+1
 ;construct ZPD segment
 S SEQ="1,17,21,34" ;**707 Added 1, 21 and 34 to ZPD fields
 S ^TMP("HLA",$J,VAFCCNT)=$$EN1^VAFHLZPD(DFN,SEQ)
 S VAFCCNT=VAFCCNT+1
 ;**902 MVI_4634 (ckn) - Add ZSP and ZEL segments
 S ZSP=$$EN^VAFHLZSP(DFN) I $G(ZSP)'="" S ^TMP("HLA",$J,VAFCCNT)=ZSP,VAFCCNT=VAFCCNT+1  ;ZSP segment
 S ZEL=$$EN^VAFHLZEL(DFN,"1,8,9",1) I $G(ZEL)'="" S ^TMP("HLA",$J,VAFCCNT)=ZEL,VAFCCNT=VAFCCNT+1  ;ZEL segment
 Q
 ;
MSH ;process MSH segment
 S VAFCFS=HL("FS")
 S HLQ=HL("Q"),HLFS=HL("FS"),HLECH=HL("ECH")
 S VAFCID=HL("MID")
 S COMP=$E(HL("ECH"),1)
 S REP=$E(HL("ECH"),2)
 S SUBCOMP=$E(HL("ECH"),4)
 S SITE=$$LKUP^XUAF4($P($P(HLNODE,HL("FS"),4),COMP))
 Q
 ;
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
 ;
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
 ;
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
 ;
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
 ;
OLD(DFN) ; **902 MVI_4634 (ckn) Return OBX segment to flag a record as "old"
 Q $S($D(^XTMP("MPIF OLD RECORDS",DFN))#2:"OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"OLDER RECORD"_HL("FS")_HL("FS")_"Y",1:"")
 ;
