ORQPTQ5 ; SLC/PKS - Functions for Patient Selection Lists. [4/23/04 4:49pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**82,85,187,190**;Dec 17, 1997
 ;
 Q
 ;
COMBDISP(ORQDUZ,ORQPTR) ; Display user's "Combination" pt selection sources.
 ;
 ; Variables used:
 ;
 ;   ORQCNT = Counter for number of entries displayed.
 ;   ORQDUZ = DUZ of user involved.
 ;   ORQPTR = IEN for user's OE/RR PT SEL COMBO file entries.
 ;   ORQSRC = $O command values from combo entries, file ^OR(100.24,.
 ;   ORQTXT = Text name string for combo entry pointers.
 ;
 N ORQCNT,ORQSRC,ORQTXT
 ;
 ; Check passed variables, punt on errors:
 S ORQCNT=0
 I '($D(ORQDUZ)) W !,"No user DUZ passed.",! Q ORQCNT
 I '($D(ORQPTR)) W !,"No combination pointer passed.",! Q ORQCNT
 I ORQDUZ="" W !,"No user DUZ passed.",! Q ORQCNT
 I ORQPTR="" W !,"No combination pointer passed.",! Q ORQCNT
 ;
 ; Order through the user's combination source entries:
 K ^TMP("OR",$J,"ORQCPL")
 S ORQSRC=0
 F  S ORQSRC=$O(^OR(100.24,ORQPTR,.01,ORQSRC)) Q:'ORQSRC  D
 .;
 .; Get the actual source name based on the pointer entry value:
 .S ORQTXT=""
 .S ORQTXT=$G(^OR(100.24,ORQPTR,.01,ORQSRC,0))
 .I '(ORQTXT="") D
 ..S ORQCNT=ORQCNT+1         ; Increment counter.
 ..S ORQTXT=$$COMBNM(ORQTXT) ; Call tag to create complete string.
 ..;
 ..; Write to ^TMP file for sorting:
 ..I ORQTXT'="" S ^TMP("OR",$J,"ORQCPL",$P(ORQTXT,U))=$P(ORQTXT,U,2)
 ;
 ; Write data to the screen:
 I ORQCNT D                                       ; Data to write?
 .S ORQTXT=""                                     ; Reset, re-use.
 .F  S ORQTXT=$O(^TMP("OR",$J,"ORQCPL",ORQTXT)) Q:ORQTXT=""  D
 ..W !,$G(^TMP("OR",$J,"ORQCPL",ORQTXT))
 ;
 K ^TMP("OR",$J,"ORQCPL")                         ; Clean house.
 ;
 Q ORQCNT                                         ; Return counter.
 ;
COMBNM(ORQVAL) ; Returns name of "Combination" source entry, ^OR(100.24 file.
 ;
 ; Returned string is "X_Name^String" where X is letter of type,
 ;    Name is name of entity, and String resembles examples below:
 ; 
 ;       W_1W^Ward:       1W  SURGERY WEST
 ;       P_JONES,WILMA MD^Provider:   JONES,WILMA MD
 ;       T_SURGERYLIST2^Team List:  SURGERYLIST2
 ;       (Etc.)
 ;
 ; Variables used:
 ;
 ;    ORQFILE = File for retrieval of name.
 ;    ORQPTR  = Name string to return.
 ;    ORQRTN  = Value returned by this function.
 ;    ORQVAL  = Combo source entry pointer.
 ;
 N ORQPTR,ORQFILE,ORQRTN
 I '($D(ORQVAL)) Q ORQRTN                         ; Error - punt.
 ;
 S ORQRTN="No source found...."                   ; Default init.
 S ORQPTR=$P(ORQVAL,";")                          ; Get pointer.
 S ORQFILE="^"_$P(ORQVAL,";",2)                   ; Get file.
 ;
 I ORQFILE="^DIC(42," D  Q ORQRTN                 ; Wards.
 .S ORQRTN=$G(^DIC(42,ORQPTR,0))
 .I $D(ORQRTN) S ORQRTN="W"_"_"_$P(ORQRTN,U)_U_"Ward:       "_$P(ORQRTN,U)_"  "_$P(ORQRTN,U,2)
 ;
 I ORQFILE="^VA(200," D  Q ORQRTN                 ; Providers.
 .S ORQRTN=$G(^VA(200,ORQPTR,0))
 .I $D(ORQRTN) S ORQRTN="P"_"_"_$P(ORQRTN,U)_U_"Provider:   "_$P(ORQRTN,U)
 ;
 I ORQFILE="^DIC(45.7," D  Q ORQRTN               ; Specialties.
 .S ORQRTN=$G(^DIC(45.7,ORQPTR,0))
 .I $D(ORQRTN) S ORQRTN="S"_"_"_$P(ORQRTN,U)_U_"Specialty:  "_$P(ORQRTN,U)
 ;
 I ORQFILE="^OR(100.21," D  Q ORQRTN              ; Team Lists.
 .S ORQRTN=$G(^OR(100.21,ORQPTR,0))
 .I $D(ORQRTN) S ORQRTN="T"_"_"_$P(ORQRTN,U)_U_"Team List:  "_$P(ORQRTN,U)
 ;
 I ORQFILE="^SC(" D  Q ORQRTN                     ; Clinics.
 .S ORQRTN=$G(^SC(ORQPTR,0))
 .I $D(ORQRTN) S ORQRTN="C"_"_"_$P(ORQRTN,U)_U_"Clinic:     "_$P(ORQRTN,U)
 ;
 ; Return value (null will be returned if nothing matched):
 Q ORQRTN
 ;
PTSCOMBO(ORQTYP,ORQPTR) ; Write ^TMP("OR",$J,"PATIENTS","B") patient entries.
 ;
 ; Called from COMBPTS^ORQPTQ6.
 ; (ORQCNT,ORQPDAT,ORQPIEN,ORQPNM,ORQPSTAT,SORT new'd in calling tag.)
 ; (Array ORY new'd in calling routine ORQPTQ2.)
 ;
 ; Variables used:
 ;
 ;    ORQDOB  = Patient DOB.
 ;    ORQDONE = Flag for end of patient records.
 ;    ORQIDT  = Clinic app't date stored in internal format.
 ;    ORQMORE = Room/bed or appointment information.
 ;    ORQPTR  = PASSED: Pointer from subfile entry, combination file.
 ;    ORQSNM  = Name of source from subfile entry pointer.
 ;    ORQSNM4 = First four letters of name of source.
 ;    ORQSSN  = Patient SSN suffix.
 ;    ORQTYP  = PASSED: Holds source type:
 ;
 ;                W = Ward
 ;                P = Provider
 ;                S = Specialty
 ;                T = Team List
 ;                C = Clinic
 ;
 N ORQDOB,ORQDONE,ORQIDT,ORQMORE,ORQSNM,ORQSNM4,ORQSSN
 ;
 ; Initialize variables:
 S ORQDONE=0
 S ORQCNT=1
 ;
 ; Get name data for source:
 S ORQSNM4=""                                     ; Default setting.
 I ORQTYP="W" S ORQSNM4=$G(^DIC(42,ORQPTR,0))     ; Wards.
 I ORQTYP="P" S ORQSNM4=$G(^VA(200,ORQPTR,0))     ; Providers.
 I ORQTYP="S" S ORQSNM4=$G(^DIC(45.7,ORQPTR,0))   ; Specialties.
 I ORQTYP="T" S ORQSNM4=$G(^OR(100.21,ORQPTR,0))  ; Team Lists.
 I ORQTYP="C" S ORQSNM4=$G(^SC(ORQPTR,0))         ; Clinics.
 ;
 ; Assure use of first 4 letters of name:
 S ORQSNM4=$P(ORQSNM4,U)_"    "                   ; Add 4 for safety.
 S ORQSNM4=$E(ORQSNM4,1,4)                        ; Get first 4 only.
 ;
 ; Add label prefix to source name:
 S ORQSNM=""                                      ; Default setting.
 S ORQSNM=$S(ORQTYP="W":"Wd ",ORQTYP="P":"Pr ",ORQTYP="S":"Sp ",ORQTYP="T":"Tm ",ORQTYP="C":"Cl ",1:"     ")           ; Get correct name.
 S ORQSNM=ORQSNM_ORQSNM4                          ; Prepend label.
 ;
 ; Order thru ORY array created by calls in calling routine:
 S ORQPDAT=""                                     ; Initialize.
 F  S ORQPDAT=$G(ORY(ORQCNT)) Q:((ORQPDAT="")!(ORQDONE))  D
 .;
 .; Clear variables each time:
 .S (ORQPIEN,ORQPNM,ORQSSN,ORQDOB,ORQIDT,ORQMORE,ORQPSTAT)=""
 .;
 .S ORQPIEN=$P(ORQPDAT,U)                         ; Get patient IEN.
 .I ORQPIEN="" S ORQDONE=1 Q                      ; Punt if no IEN.
 .S ORQPNM=$P(ORQPDAT,U,2)                        ; Get patient name.
 .;
 .; Get patient SSN suffix:
 .S ORQSSN=$$ID($G(ORQPIEN))
 .;
 .; Get patient DOB:
 .S ORQDOB=$$FMTE^XLFDT($P($G(^DPT(ORQPIEN,0)),U,3))
 .;
 .; Get patient room/bed information where data exists:
 .S ORQMORE=$P($G(^DPT(ORQPIEN,.101)),U)
 .;
 .; Assure at least 4 letters for any existing room/bed data:
 .I ORQMORE'="" D                                 ; Any data now?
 ..I $L(ORQMORE)<4 D                              ; Less than 4 now?
 ...S ORQMORE=ORQMORE_"   "                       ; Add 3 for safety.
 ...S ORQMORE=$E(ORQMORE,1,4)                     ; Get first 4 only.
 .;
 .; Get clinic appointment information, if applicable:
 .I ORQTYP="C" D
 ..S ORQMORE=""                                   ; Reset, re-use.
 ..S ORQMORE=$P(ORQPDAT,U,4)                      ; App't data.
 ..S ORQIDT=ORQMORE                               ; Internal format.
 ..S $P(ORQMORE,".",2)=$E($P(ORQMORE,".",2)_"000",1,4)
 ..S ORQMORE=$$FMTE^XLFDT($P(ORQMORE,U))          ; Format app't.
 ..S ORQPSTAT=$P(ORQPDAT,U,9)                     ; Ipt/Opt status.
 .;
 .; Write a sorted entry in ^TMP("OR",$J,"PATIENTS","B"):
 .;    (Node's data:)
 .;    (DFN^PtName^SSN^DOB^SourceName^App't/Room/Bed^SourceIEN^IOStat)
 .I ORQPIEN'="" D
 ..;
 ..; Write using source name first if sorted by "S" (source) -or-
 ..;    if "P" (app't) sort and not a clinic:
 ..I ((SORT="S")!((SORT="P")&(ORQTYP'="C"))) D  Q
 ...S ^TMP("OR",$J,"PATIENTS","B",ORQSNM_" "_ORQPNM_" "_ORQPIEN_" "_ORQIDT)=ORQPIEN_U_ORQPNM_U_ORQSSN_U_ORQDOB_U_ORQSNM_U_ORQMORE_U_ORQPTR_U_ORQIDT_U_ORQPSTAT
 ..; 
 ..; Use source source+app't first if "P" (app't) sort, and a clinic:
 ..I ((ORQTYP="C")&(SORT="P")) D  Q
 ...S ^TMP("OR",$J,"PATIENTS","B",ORQSNM_" "_ORQIDT_" "_ORQPNM_" "_ORQPIEN)=ORQPIEN_U_ORQPNM_U_ORQSSN_U_ORQDOB_U_ORQSNM_U_ORQMORE_U_ORQPTR_U_ORQIDT_U_ORQPSTAT
 ..;
 ..; If not by source or source/app't, default to alpha ("A") sort:
 ..S ^TMP("OR",$J,"PATIENTS","B",ORQPNM_" "_ORQPIEN_" "_ORQSNM_" "_ORQIDT)=ORQPIEN_U_ORQPNM_U_ORQSSN_U_ORQDOB_U_ORQSNM_U_ORQMORE_U_ORQPTR_U_ORQIDT_U_ORQPSTAT
 .;
 .S ORQCNT=ORQCNT+1                               ; Increment counter.
 ;
 Q
 ;
ID(ORQPIEN) ; Return short ID for patient ID.
 ; (Copied from ORQPT routine and modified.)
 ;
 N ID
 ;
 S ID=$P($G(^DPT(ORQPIEN,.36)),U,4)               ; Gets short ID.
 I '$L(ID) D                                      ; - or -
 .S ID=$E($P($G(^DPT(ORQPIEN,0)),U,9),6,9)        ; Last 4 of SSN
 ;
 Q "("_$E(ORQPNM)_ID_")"
 ;
