SCMCHLB1 ;BPOI/DJB - PCMM HL7 Bld Segment Array Cont.;8/17/99
 ;;5.3;Scheduling;**177,515,524**;08/17/99;Build 29
 ;
SEGMENTS(DFN,SUB) ;Build EVN & PID segments
 ;Input:
 ;   DFN      - Patient IEN
 ;   SUB      - Value for 1st Subscript
 ;Output:
 ;   XMITARRY() - Array of EVN & PID segments
 ;
 NEW LINETAG,SEGMENTS,SEGNAME,SEGORD
 NEW EVNTDATE,EVNTHL7,VAFARRY,VAFEVN,VAFPID,VAFSTR
 ;
 ;Initialize variables
 Q:'$G(DFN)  ;Required for PID segment
 Q:'$G(SUB)
 S EVNTDATE=DT
 S EVNTHL7="A08"
 ;
 ;Get array of segments to be built
 D SEGMENTS^SCMCHLS(EVNTHL7,"SEGMENTS")
 ;
 ;Loop thru segments array. Ignore ZPC segment - already built.
 S SEGORD=0
 F  S SEGORD=+$O(SEGMENTS(SEGORD)) Q:'SEGORD  D  ;
 . S SEGNAME=""
 . F  S SEGNAME=$O(SEGMENTS(SEGORD,SEGNAME)) Q:SEGNAME=""  D  ;
 .. Q:SEGNAME="ZPC"  ;.................ZPC already built
 .. S VAFSTR=SEGMENTS(SEGORD,SEGNAME) ;String of segment fields
 .. S LINETAG="BLD"_SEGNAME
 .. D @LINETAG^SCMCHLS ;...............Build segment
 .. S LINETAG="CPY"_SEGNAME
 .. D @LINETAG^SCMCHLS ;...............Copy segment into array
 Q
 ;
ZPC(ARRAY,DELETE) ;Loop thru array and build array of ZPC segments.
 ;
 ;Input:
 ;   ARRAY  - Array to be processed. This array was built in ^SCMCHLB
 ;            with calls to $$PRTPC^SCAPMC() and $$PRPTTPC^SCAPMC().
 ;            Examples:
 ;               ARRAY(2290,"PCP","2290-406-34-PCP")= Data
 ;               ARRAY(345,"PROV-P","2290-405-0-AP")= Data
 ;   DELETE - 1=Process a delete type ZPC segment (all fields null)
 ;Output:
 ;   Array of ZPC segments
 ;
 NEW DATA,DATE,ID,ID1,LINETAG,SUB,TYPE,VAFZPC
 ;
 S SUB=0
 F  S SUB=$O(ARRAY(SUB)) Q:'SUB  D  ;
 . S TYPE=""
 . F  S TYPE=$O(ARRAY(SUB,TYPE)) Q:TYPE=""  D  ;
 .. S ID=""
 .. F  S ID=$O(ARRAY(SUB,TYPE,ID)) Q:ID=""  D  ;
 ... S DATA=$G(ARRAY(SUB,TYPE,ID))
 ... I $G(DELETE) S DATA="^^^" ;A Delete type ZPC segment
 ... E  D  ;....................A ZPC segment with data
 .... ;Get dates
 .... S DATE(9)=$P(DATA,U,9)
 .... S DATE(10)=$P(DATA,U,10)
 .... S DATE(14)=$P(DATA,U,14) ;Preceptor start date
 .... S DATE(15)=$P(DATA,U,15) ;Preceptor end date
 .... I DATE(14),DATE(14)>DATE(9) S DATE(9)=DATE(14)
 .... I DATE(15) D  ;
 ..... I 'DATE(10) S DATE(10)=DATE(15) Q
 ..... I DATE(15)<DATE(10) S DATE(10)=DATE(15)
 .... ;
 .... ;Provider^AssignDate^UnassignDate^ProviderType
 .... S DATA=$P(DATA,U,1)_"^"_DATE(9)_"^"_DATE(10)
 ....; PATCH 515 DLL ADD NEW ROLES (TPA,CCM,PM)
 ....; OLD CODE = S DATA=DATA_"^"_$S(ID["AP":"AP",1:"PCP")
 ....S ROLE=$P(ID,"-",4) I $G(ROLE)="" S ROLE="PCP"
 ....S DATA=DATA_"^"_ROLE
 ... ;
 ... D BLDZPC^SCMCHLS ;..Build segment ; og/sd/524
 ... D CPYZPC^SCMCHLS ;..Copy segment into array ; og/sd/524
 Q
 ;
DFN(ND) ;Find DFN from zero node of Patient Team Position Assign (404.43).
 ;Input:
 ;   ND  - Zero node of 404.43
 ;Output:
 ;   DFN - Patient IEN
 ;   ""  - No valid DFN found
 ;
 S DFN=$P(ND,U,1)
 I DFN S DFN=$P($G(^SCPT(404.42,DFN,0)),U,1)
 Q DFN
 ;
ADJID(ARRAY,SCIEN) ;Adjust ID to include Pt Tm Pos Assign pointer
 ;Example:  From this:       424-34-AP
 ;            To this:  2290-424-34-AP
 ;Input:
 ;    ARRAY - Array to be processed
 ;    SCIEN - 404.43 IEN to be added to ID
 ;
 NEW ADJID,ID,NUM,TMP,TYPE
 ;
 ;Build TMP() array using adjusted ID
 S NUM=0
 F  S NUM=$O(ARRAY(NUM)) Q:'NUM  D  ;
 . S TYPE=""
 . F  S TYPE=$O(ARRAY(NUM,TYPE)) Q:TYPE=""  D  ;
 .. S ID=""
 .. F  S ID=$O(ARRAY(NUM,TYPE,ID)) Q:ID=""  D  ;
 ... S ADJID=SCIEN_"-"_ID ;..Add 404.43 IEN
 ... S TMP(NUM,TYPE,ADJID)=ARRAY(NUM,TYPE,ID)
 ;
 ;Replace ARRAY() with adjusted TMP() array.
 Q:'$D(TMP)
 KILL ARRAY
 M ARRAY=TMP ;Copy TMP() into ARRAY()
 Q
 ;
CHECK(VARPTR) ;Validate event variable pointer.
 ;Input:
 ;      VARPTR - EVENT POINTER field of PCMM HL7 EVENT (#404.48)
 ;Output:
 ;      SCIEN  - IEN portion of variable pointer
 ;      SCGLB  - Global portion of variable pointer
 ;Return:
 ;      0: Invalid variable pointer format
 ;      1: Valid pointer
 ;      2: No data. Entry has been deleted. Send a delete to NPCD.
 ;
 NEW CHK,GLB
 ;
 S SCIEN=$P(VARPTR,";") ;....IEN portion of variable pointer
 S SCGLB=$P(VARPTR,";",2) ;..Global portion of variable pointer
 ;
 ;Return zero if variable pointer is invalid.
 I 'SCIEN Q 0
 S CHK=0 D  I CHK Q 0
 . Q:SCGLB="SCPT(404.43,"
 . Q:SCGLB="SCTM(404.52,"
 . Q:SCGLB="SCTM(404.53,"
 . S CHK=1
 ;
 ;Is there data for this IEN?
 S GLB="^"_SCGLB_SCIEN_",0)"
 I '$D(@GLB) Q 2 ;..Entry has been deleted
 Q 1
