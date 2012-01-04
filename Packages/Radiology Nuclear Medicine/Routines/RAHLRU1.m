RAHLRU1 ;HISC/PB,GJC - utilities for HL7 messaging ;1/28/00  11:03
 ;;5.0;Radiology/Nuclear Medicine;**47**;Mar 16, 1998;Build 21
 ;
 ;IA 5023: builds the PID ($$PID^MAGDHLS) & PV1 ($$PV1^MAGDHLS) segments
 ;Integration Agreements
 ;----------------------
 ;$$GET1^DIQ(2056); $$HLDATE^HLFNC(10106); M11^HLFNC(10106)
 ;GENERATE^HLMA(2164); $$PID^MAGDHLS(5023); $$PV1^MAGDHLS(5023)
 ;$$DT^XLFDT(10103); $$LOW^XLFSTR(10104)
 ;
 ;IA: 10060 global of file ^VA(200
 ;
PID(RADFN) ;compile the PID segment
 ;$$PID^MAGDHLS(XDFN,XYMSG)
 ; input: XDFN internal entry number of the patient on global ^DPT/^RADPT
 ; XYMSG name of array to which to add message elts
 ; output: @XYMSG input array plus new subtree containing PV1 elts
 ; function return 0 (success) always
 ;
 K RA0X S X=$$PID^MAGDHLS(RADFN,"RA0X")
 D MAG(.RA0X,.RAPID)
 D BLSEG("PID",.RAPID) K RA0X
 Q
 ;
PV1(RADFN) ;compile the PV1 segment determine if the patient is
 ;an inpatient or outpatient by looking at the exam record
 ;$$PV1^MAGDHLS(XDFN,XEVN,XEVNDT,XYMSG)
 ; input: XDFN internal entry number of the patient on global ^DPT/^RADPT
 ; XEVN event type of this message
 ; XEVNDT event date/time (FileMan format)
 ; XYMSG name of array to which to add message elts
 ; output: @XYMSG input array plus new subtree containing PV1 elts
 ; function return 0 (success) always
 K RA0X S X=$$PV1^MAGDHLS(RADFN,"O01",RAZDTE,"RA0X")
 D MAG(.RA0X,.RAPV1)
 K:RAPV1(3)="O"&($G(RAPV1(20))=0) RAPV1(20)
 ;
 ;After call to MAG API add PV1-15: Ambulatory Status of the patient
 ;MODE OF TRANSPORT - file: 75.1, field: 19, node: 0, piece: 19
 ;'a' FOR AMBULATORY; 'p' FOR PORTABLE;
 ;'s' FOR STRETCHER; 'w' FOR WHEEL CHAIR; 
 ;
 ;'a' translates to 'A0', 's' & 'w' translate to 'A2'
 ;
 ;PREGNANT - first check field (70.03,32) if NULL check field (75.1,13)
 ; file: 70.03, field: 32, node: 0, piece: 32
 ; 'y' FOR 'Patient answered yes'
 ; 'n' FOR 'Patient answered no'
 ; 'u' FOR 'Patient is unable to answer or is unsure'
 ; file: 75.1, field: 13, node: 0, piece: 13
 ; 'y' FOR YES; 'n' FOR NO; 'u' FOR UNKNOWN;
 ;
 ;'y' in either field translates to 'B6'
 ;
 ;PV1(15) might repeat; $E(HLECH,2) is the repeat character
 ;PV1(15) represented by RAPV1(16)
 S RAZPREG=$P($G(RAZXAM),U,32) I RAZPREG="" S RAZPREG=$P($G(RAZORD),U,13)
 S RAZMODE=$P($G(RAZORD),U,19)
 S RAPV1(16)=$S(RAZMODE="a":"A0",RAZMODE="s":"A2",RAZMODE="w":"A2",1:"")
 I RAPV1(16)]"",RAZPREG="y" D
 .S RAPV1(16)=RAPV1(16)_$E(HLECH,2)_"B6"
 .Q
 E  I RAPV1(16)="",RAZPREG="y" S RAPV1(16)="B6"
 ;
 D BLSEG("PV1",.RAPV1) K RA0X
 Q
 ;
REPEAT(X,N) ;return a string of HL7 encoding characters; ideal when a field
 ;is comprised of many components
 ;input: X=character repeated; for example, the component delimiter
 ;       N=string length of the character
 ;rturn: S=string in question
 N S S $P(S,X,(N+1))=""
 Q S
 ;
MAG(XX,RAD) ;Build the HL7 segment from the array passed back from the
 ;Imaging IA (#5023). HLCS, HLSCS, & HLREP defined in INIT^RAHLR
 N I,I1,I2,I3,II
 ;I  = HL7 Field #
 ;I1 = Repetition sequence  1,2,3...
 ;I2 = Component
 ;I3 = Subcomponent
 ;HLCS  = Component separator
 ;HLSCS = SubComponent separator.
 ;HLREP = Repetition separator
 S I=0 F  S I=$O(XX(1,I)) Q:'I  S I1=0 K II D
 .F  S I1=$O(XX(1,I,I1)) Q:'$L(I1)  S I2=0 D  S $P(RAD(I+1),HLREP,I1)=$G(II(I1))
 ..F  S I2=$O(XX(1,I,I1,I2)) Q:'$L(I2)  S I3=0 D  S $P(II(I1),HLCS,I2)=$G(II(I1,I2))
 ...F  S I3=$O(XX(1,I,I1,I2,I3)) Q:'I3  S $P(II(I1,I2),HLSCS,I3)=$G(XX(1,I,I1,I2,I3))
 S I=0 F  S I=$O(RAD(I)) Q:'$L(I)  K:'$L(RAD(I)) RAD(I)
 Q
 ;
RTNSUB(A) ;return the current first level subscript for the A array
 ; default is :  HLA array
 ; If array (HLA) is undefined, or only HLA("HLS") defined, return 0
 S:'$L($G(A)) A="HLA(""HLS"","
 S A=A_"$C(32))"
 Q +$O(@A,-1)
 ;
BLSEG(SEG,X,ADR) ;
 ;input: SEG="PV1" or "ORC", etc...
 ;       X=is the HL7 segment specific array subscripted by field #
 ;        Ex: PV1(2) is the PATIENT CLASS
 ;     ADR=ADDRESS where to put output if not defined set to HLA("HLS"
 ;        but may be:   ^TMP("HL7", is the same as root file in Fileman
 N DATA,I,J,JJ,REMAIN,Y,YY,YYSUB,XOLD,SS,A1,A2
 S:'$L($G(ADR)) ADR="HLA(""HLS"","
 S:ADR'["(" ADR=ADR_"("
 S A1=ADR_"Y)"     ; Y = 1st subscript (ie HLA("HLS",Y))
 S A2=ADR_"Y,YY)"  ;YY = 2nd subscript if split (ie HLA("HLS",Y,YY))
 ; if YY > 0, it means the segment has been split
 S Y=$$RTNSUB(ADR)+1,YY=0,JJ=0,SS=$E(HLECH,2)
 S @A1=SEG_HLFS,I=0   ;start with SEG, ie, OBR|
 F  S I=$O(X(I)) Q:'I  D  ;loop thru incoming array, ie, RAOBR(n)
 .I $O(X(I,0)) D  Q       ;two subscripts/repeating field
 ..; This loop is for a second level subscript of the incoming array,
 ..; for example, Assistant Interpreter(s) -> RAOBR(34,1)="FIRST^STAFF",
 ..; RAOBR(34,2)="SECOND^STAFF", RAOBR(34,3)="THIRD^STAFF" etc
 ..S J=0 F  S J=$O(X(I,J)) Q:'J  D
 ...I YY D  Q  ;if already split do this loop
 ....S XOLD=$P($G(@A2),HLFS,I-YYSUB),$P(XOLD,SS,J-JJ)=X(I,J)
 ....S $P(@A2,HLFS,I-YYSUB)=XOLD  ;add segment to output array
 ....D BLSEG2(.YY,.JJ,1)          ;check if over 245, if so, split again
 ...;No split yet
 ...S XOLD=$P($G(@A1),HLFS,I),$P(XOLD,SS,J)=X(I,J)
 ...S $P(@A1,HLFS,I)=XOLD ;add segment to output array
 ...D BLSEG1             ;check if over 245, if so, split for first time
 ..Q
 ..;---------------------------------------------
 .E  D  ;single subscript only, non repeating field
 ..S JJ=0
 ..I YY D  Q  ;if already split do this loop
 ...S $P(@A2,HLFS,I-YYSUB)=X(I)  ;add segment to output array
 ...D BLSEG2(.YY)               ;check if over 245, if so, split again
 ...Q
 ..;No split yet
 ..S $P(@A1,HLFS,I)=X(I)  ;add segment to output array
 ..D BLSEG1               ;check if over 245, if so, split for first time
 .Q
 Q
BLSEG1 ;Split for first time
 Q:$L(@A1)<246  ;over 245 chars, split the string first time
 S REMAIN=$E(@A1,246,$L(@A1))
 S YY=1,@A2=$E(@A1,$L(SEG_HLFS)+1,245)  ;YY/subscript = 1 for first split
 S YYSUB=$L(@A2,HLFS)        ;YYSUB=number of "|" pieces
 S @A1=SEG_HLFS              ;top level is segment only, ie "OBR|"
 S YY=2,@A2=REMAIN,JJ=1      ;YY/subscript = 2 for second half of split
 Q
BLSEG2(YY,JJ,K) ;Split any subsequent times
 Q:$L(@A2)<246  ;over 245 chars, split the string again...
 S REMAIN=$E(@A2,246,$L(@A2))
 S @A2=$E(@A2,1,245)
 S YYSUB=YYSUB+$L(@A2,HLFS)-1 ;YYSUB=# of "|" pieces counter
 S YY=YY+1                    ;YY/subscript incremented with each split
 S:$G(K) JJ=J-$L(REMAIN,SS)   ;K,JJ for repeating field/double subscript
 S @A2=REMAIN
 Q
PARSEG(ARR,PAR) ;Parse segment from ARR array to PAR array
 Q:'$D(HLFS)
 N SS,I,II,D,FLDN,FLDN1,JJ,D1 S I=0,II=0,J=0,D="",SS=$E($G(HLECH),2) Q:'$L(SS)
 S DATA=$G(ARR(1)) D:$L(DATA) PARPROC(DATA,$O(ARR(1,0)))
 F  S I=$O(ARR(1,I)) Q:'I  D PARPROC(ARR(1,I),$O(ARR(1,I)))
 Q
PARPROC(DATA,LAST) ;PROCES DATA
 ;LAST = Indication of last sequence IF LAST = "" (last sequence)
 S FLDN=$L(DATA,HLFS) ;Number of fields
 I FLDN=1 S D=D_DATA Q  ;No field separator
 F II=1:1:FLDN D
 .S D=$S(II=1:D,1:"")_$P(DATA,HLFS,II)
 .I II=1,FLDN=1,LAST Q  ;ONLY ONE FIELD..no field separators and not last sequence
 .I II=1,FLDN'=1 D GETPP(.D) Q  ; First field , more as one field in sequence
 .I II=1,FLDN=1,'LAST D GETPP(.D) Q  ; First field, no field delimiters, last sequence
 .I II=FLDN,LAST Q  ;Last field, but not last sequence
 .D GETPP(.D)
 S J=J+FLDN-1
 Q
GETPP(D) ;GET REPEATED FIELDS
 Q:'$L(D)
 I D'[SS S PAR(J+II)=D K D1 Q
 S FLDN1=$L(D,SS) F JJ=1:1:FLDN1 D
 .S D1=$P(D,SS,JJ) S:$L(D1) PAR(J+II,JJ)=D1
 Q
VFIER(X1,X2,X3) ; validation of OBR-32 , OBR-33  or OBR-35
 ; X1 = value to be Validated/Returned (IEN)
 ; Note: X1 is passed in as: ID Number (IEN)^Family Name^Given Name
 ;       (in this example "^" is the subcomponent separator) 
 ; X2 = Status ('C'orrected, 'F'inal, or 'R'esults filed, not verified)
 ; X3 = text 'OBR-32' or 'OBR-33' or 'OBR-33x' or 'OBR 35'
 ; Return value:    1 = Validation OK
 ;                  0^Error message to be returned to sender
 N C,DIERR,RARRAY,RAERROR,RALBL
 S RALBL=$S(X3="OBR-32":"staff","OBR-33":"resident",1:"transcriptionist")
 ;Note +X1 (we want only the IEN) 
 D FIND^DIC(200,"",.01,"A",+X1,"","","","","RARRAY","RAERROR")
 ;if $D(RAERROR("DIERR")) the input value is invalid (control character)
 I $D(RAERROR("DIERR"))#2 Q "0^Invalid "_RALBL_" name"
 ;how many hits? = 0 lookup failed...
 I $P($G(RARRAY("DILIST",0)),U)=0  Q "0^Lookup failed; no "_RALBL_" name found"
 ;how many hits? = 1 just right...
 Q 1
 ;
INDT(X1) ;check if MD has inactivation date.
 N RAINDT
 S RAINDT=$$GET1^DIQ(200,+X1,73,"I") I $G(RAINDT),RAINDT'>$$DT^XLFDT S RAERR="Physician is INACTIVE" Q "1^"_RAERR
 Q 0
 ;
SR(X1) ;'S'taff  or 'R'esident and inactive DATE
 ;input: ID Number (aka IEN)
 ;return: RASTRE: classification (staff, resident, clerk)
 ;              : -1 w/error code if error
 I +X1=0 S RASTRE="-1^"_"Missing or invalid IEN" Q
 N DIERR,RARRAY,RAERROR,X,Y S X1=+X1_","
 D GETS^DIQ(200,X1,"72*:73","I","RARRAY","RAERROR")
 ;if error return error message...
 I $D(RAERROR("DIERR"))#2 S RASTRE="-1^"_"The entry does not exist" Q
 ;we know the function finds a record.
 ;first check: has the individual been inactivated?
 S Y=$G(^RARRAY(200,X1,73,"I")) I Y Q:Y'>DT "-1^user inactivated"
 ;what's the classification of the user?
 S X="",RASTRE=U
 F  S X=$O(RARRAY(200.072,X)) Q:X=""  S RASTRE=RASTRE_$G(RARRAY(200.072,X,.01,"I"))_U
 Q
 ;
SPECSRC(RAOIFN) ;Specimen Source OBR-15
 ;Input: the IEN of the order record from the RAD/NUC MED ORDERS (#75.1)
 ;return: Specimen Source string (PROCEDURE MODIFIERS (left & right only))
 N RASPSRC S RASS=0
 F  S RASS=$O(^RAO(75.1,RAOIFN,"M",RASS)) Q:'RASS  D
 .S RAZPMOD=+$G(^RAO(75.1,RAOIFN,"M",RASS,0)) ;RAZPMOD=ptr to file 71.2
 .;convert the procedure modifier to lower case
 .S RASPSRC(0)=$$LOW^XLFSTR($P($G(^RAMIS(71.2,RAZPMOD,0)),U))
 .S:RASPSRC(0)="left"!(RASPSRC(0)="right") RASPSRC=$G(RASPSRC)_RASPSRC(0)_" "
 .Q
 I $L($G(RASPSRC)) S RASPSRC=$E(RASPSRC,1,($L(RASPSRC)-1))
 K RASS,RAZPMOD
 Q $G(RASPSRC)
 ;
SETUP ; Setup basic examination information
 S:RASET RACN0=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RADTE0=9999999.9999-RADTI,RADTECN=$E(RADTE0,4,7)_$E(RADTE0,2,3)_"-"_+RACN0,RARPT0=^RARPT(RARPT,0)
 S RAPROC=+$P(RACN0,U,2),RAPROCIT=+$P($G(^RAMIS(71,RAPROC,0)),U,12),RAPROCIT=$P(^RA(79.2,RAPROCIT,0),U,1)
 S RAPRCNDE=$G(^RAMIS(71,+RAPROC,0)),RACPT=+$P(RAPRCNDE,U,9)
 S RACPTNDE=$$NAMCODE^RACPTMSC(RACPT,DT)
 S Y=$$HLDATE^HLFNC(RADTE0) S RADTE0=$S(Y:Y,1:HLQ),Y=$$M11^HLFNC(RADFN)
 Q
 ;
USESSAN() ; Return the value of the parameter used as the switch
 ; to turn on use of the Site Specific Accession Numbers
 N RADIVIEN S RADIVIEN="" S RADIVIEN=$O(^RA(79,0)) I RADIVIEN="" Q 0
 I $P($G(^RA(79,RADIVIEN,.1)),"^",31)="Y" Q 1
 Q 0
 ;
SSANVAL(RADFN,RADTI,RACNI) ; Return the value of the Site Specific Acc Number
 Q $P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",31)
 ;
DATEPRT(RADTE) ; Return the printable format of the internal date value
 Q $E(RADTE,4,5)_"/"_$E(RADTE,6,7)_"/"_$E(RADTE,2,3)
