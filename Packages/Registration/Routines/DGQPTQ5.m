DGQPTQ5 ; SLC/PKS - Functions for Patient Selection Lists. ; 6/5/01 12:37pm
 ;;5.3;Registration;**447**;Aug 13, 1993
 ;
 Q
 ;
COMBDISP(DGQDUZ,DGQPTR) ; Display user's "Combination" pt selection sources.
 ;
 ; Variables used:
 ;
 ;   DGQCNT = Counter for number of entries displayed.
 ;   DGQDUZ = DUZ of user involved.
 ;   DGQPTR = IEN for user's OE/RR PT SEL COMBO file entries.
 ;   DGQSRC = $O command values from combo entries, file ^OR(100.24,.
 ;   DGQTXT = Text name string for combo entry pointers.
 ;
 N DGQCNT,DGQSRC,DGQTXT
 ;
 ; Check passed variables, punt on errors:
 S DGQCNT=0
 I '($D(DGQDUZ)) W !,"No user DUZ passed.",! Q DGQCNT
 I '($D(DGQPTR)) W !,"No combination pointer passed.",! Q DGQCNT
 I DGQDUZ="" W !,"No user DUZ passed.",! Q DGQCNT
 I DGQPTR="" W !,"No combination pointer passed.",! Q DGQCNT
 ;
 ; Order through the user's combination source entries:
 K ^TMP("DG",$J,"DGQCPL")
 S DGQSRC=0
 F  S DGQSRC=$O(^OR(100.24,DGQPTR,.01,DGQSRC)) Q:'ORQSRC  D
 .;
 .; Get the actual source name based on the pointer entry value:
 .S DGQTXT=""
 .S DGQTXT=$G(^OR(100.24,DGQPTR,.01,DGQSRC,0))
 .I '(DGQTXT="") D
 ..S DGQCNT=DGQCNT+1         ; Increment counter.
 ..S DGQTXT=$$COMBNM(DGQTXT) ; Call tag to create complete string.
 ..;
 ..; Write to ^TMP file for sorting:
 ..I DGQTXT'="" S ^TMP("DG",$J,"DGQCPL",$P(DGQTXT,U))=$P(DGQTXT,U,2)
 ;
 ; Write data to the screen:
 I DGQCNT D                                       ; Data to write?
 .S DGQTXT=""                                     ; Reset, re-use.
 .F  S DGQTXT=$O(^TMP("DG",$J,"DGQCPL",DGQTXT)) Q:DGQTXT=""  D
 ..W !,$G(^TMP("DG",$J,"DGQCPL",DGQTXT))
 ;
 K ^TMP("OR",$J,"DGQCPL")                         ; Clean house.
 ;
 Q DGQCNT                                         ; Return counter.
 ;
COMBNM(DGQVAL) ; Returns name of "Combination" source entry, ^OR(100.24 file.
 ;
 ; Returned string is "X^Name^String" where X is letter of type,
 ;    Name is name of entity, and String resembles examples below:
 ; 
 ;       W_1W^Ward:       1W  SURGERY WEST
 ;       P_JONES,WILMA MD^Provider:   JONES,WILMA MD
 ;       T_SURGERYLIST2^Team List:  SURGERYLIST2
 ;       (Etc.)
 ;
 ; Variables used:
 ;
 ;    DGQFILE = File for retrieval of name.
 ;    DGQPTR  = Name string to return.
 ;    DGQRTN  = Value returned by this function.
 ;    DGQVAL  = Combo source entry pointer.
 ;
 N DGQPTR,DGQFILE,DGQRTN
 I '($D(DGQVAL)) Q DGQRTN                         ; Error - punt.
 ;
 S DGQRTN="No source found...."                   ; Default init.
 S DGQPTR=$P(DGQVAL,";")                          ; Get pointer.
 S DGQFILE="^"_$P(DGQVAL,";",2)                   ; Get file.
 ;
 I DGQFILE="^DIC(42," D  Q DGQRTN                 ; Wards.
 .S DGQRTN=$G(^DIC(42,DGQPTR,0))
 .I $D(DGQRTN) S DGQRTN="W"_"_"_$P(DGQRTN,U)_U_"Ward:       "_$P(DGQRTN,U)_"  "_$P(DGQRTN,U,2)
 ;
 I DGQFILE="^VA(200," D  Q DGQRTN                 ; Providers.
 .S DGQRTN=$G(^VA(200,DGQPTR,0))
 .I $D(DGQRTN) S DGQRTN="P"_"_"_$P(DGQRTN,U)_U_"Provider:   "_$P(DGQRTN,U)
 ;
 I DGQFILE="^DIC(45.7," D  Q DGQRTN               ; Specialties.
 .S DGQRTN=$G(^DIC(45.7,DGQPTR,0))
 .I $D(DGQRTN) S DGQRTN="S"_"_"_$P(DGQRTN,U)_U_"Specialty:  "_$P(DGQRTN,U)
 ;
 I DGQFILE="^OR(100.21," D  Q DGQRTN              ; Team Lists.
 .S DGQRTN=$G(^OR(100.21,DGQPTR,0))
 .I $D(DGQRTN) S DGQRTN="T"_"_"_$P(DGQRTN,U)_U_"Team List:  "_$P(DGQRTN,U)
 ;
 I DGQFILE="^SC(" D  Q DGQRTN                     ; Clinics.
 .S DGQRTN=$G(^SC(DGQPTR,0))
 .I $D(DGQRTN) S DGQRTN="C"_"_"_$P(DGQRTN,U)_U_"Clinic:     "_$P(DGQRTN,U)
 ;
 ; Return value (null will be returned if nothing matched):
 Q DGQRTN
 ;
PTSCOMBO(DGQTYP,DGQPTR) ; Write ^TMP("DG",$J,"PATIENTS","B") patient entries.
 ;
 ; Called from COMBPTS^DGQPTQ6.
 ; (DGQCNT,DGQPDAT,DGQPIEN,DGQPNM,SORT new'd in calling code.)
 ; (Array DGY new'd in calling routine DGQPTQ2.)
 ;
 ; Variables used:
 ;
 ;    DGQDOB  = Patient DOB.
 ;    DGQDONE = Flag for end of patient records.
 ;    DGQIDT  = Clinic app't date stored in internal format.
 ;    DGQMORE = Room/bed or appointment information.
 ;    DGQPTR  = PASSED: Pointer from subfile entry, combination file.
 ;    DGQSNM  = Name of source from subfile entry pointer.
 ;    DGQSNM4 = First four letters of name of source.
 ;    DGQSSN  = Patient SSN suffix.
 ;    DGQTYP  = PASSED: Holds source type:
 ;
 ;                W = Ward
 ;                P = Provider
 ;                S = Specialty
 ;                T = Team List
 ;                C = Clinic
 ;
 N DGQDOB,DGQDONE,DGQIDT,DGQMORE,DGQSNM,DGQSNM4,DGQSSN
 ;
 ; Initialize variables:
 S DGQDONE=0
 S DGQCNT=1
 ;
 ; Get name data for source:
 S DGQSNM4=""                                     ; Default setting.
 I DGQTYP="W" S DGQSNM4=$G(^DIC(42,DGQPTR,0))     ; Wards.
 I DGQTYP="P" S DGQSNM4=$G(^VA(200,DGQPTR,0))     ; Providers.
 I DGQTYP="S" S DGQSNM4=$G(^DIC(45.7,DGQPTR,0))   ; Specialties.
 I DGQTYP="T" S DGQSNM4=$G(^OR(100.21,DGQPTR,0))  ; Team Lists.
 I DGQTYP="C" S DGQSNM4=$G(^SC(DGQPTR,0))         ; Clinics.
 ;
 ; Assure use of first 4 letters of name:
 S DGQSNM4=$P(DGQSNM4,U)_"    "                   ; Add 4 for safety.
 S DGQSNM4=$E(DGQSNM4,1,4)                        ; Get first 4 only.
 ;
 ; Add label prefix to source name:
 S DGQSNM=""                                      ; Default setting.
 S DGQSNM=$S(DGQTYP="W":"Wd ",DGQTYP="P":"Pr ",DGQTYP="S":"Sp ",DGQTYP="T":"Tm ",DGQTYP="C":"Cl ",1:"     ")           ; Get correct name.
 S DGQSNM=DGQSNM_DGQSNM4                          ; Prepend label.
 ;
 ; Order thru DGY array created by calls in calling routine:
 S DGQPDAT=""                                     ; Initialize.
 F  S DGQPDAT=$G(DGY(DGQCNT)) Q:((DGQPDAT="")!(DGQDONE))  D
 .;
 .; Clear variables each time:
 .S (DGQPIEN,DGQPNM,DGQSSN,DGQDOB,DGQIDT,DGQMORE)=""
 .;
 .S DGQPIEN=$P(DGQPDAT,U)                         ; Get patient IEN.
 .I DGQPIEN="" S DGQDONE=1 Q                      ; Punt if no IEN.
 .S DGQPNM=$P(DGQPDAT,U,2)                        ; Get patient name.
 .;
 .; Get patient SSN suffix:
 .S DGQSSN=$$ID($G(DGQPIEN))
 .;
 .; Get patient DOB:
 .S DGQDOB=$$FMTE^XLFDT($P($G(^DPT(DGQPIEN,0)),U,3))
 .;
 .; Get patient room/bed information where data exists:
 .S DGQMORE=$P($G(^DPT(DGQPIEN,.101)),U)
 .;
 .; Assure at least 4 letters for any existing room/bed data:
 .I DGQMORE'="" D                                 ; Any data now?
 ..I $L(DGQMORE)<4 D                              ; Less than 4 now?
 ...S DGQMORE=DGQMORE_"   "                       ; Add 3 for safety.
 ...S DGQMORE=$E(DGQMORE,1,4)                     ; Get first 4 only.
 .;
 .; Get clinic appointment information, if applicable:
 .I DGQTYP="C" D
 ..S DGQMORE=""                                   ; Reset, re-use.
 ..S DGQMORE=$P(DGQPDAT,U,4)                      ; App't data.
 ..S DGQIDT=DGQMORE                               ; Internal format.
 ..S $P(DGQMORE,".",2)=$E($P(DGQMORE,".",2)_"000",1,4)
 ..S DGQMORE=$$FMTE^XLFDT($P(DGQMORE,U))          ; Format app't.
 .;
 .; Write a sorted entry in ^TMP("DG",$J,"PATIENTS","B"):
 .;    (Node's data:)
 .;    (DFN^PtName^SSN^DOB^SourceName^App't/Room/Bed^SourceIEN)
 .I DGQPIEN'="" D
 ..;
 ..; Write using source name first if sorted by "S" (source) -or-
 ..;    if "P" (app't) sort and not a clinic:
 ..I ((SORT="S")!((SORT="P")&(DGQTYP'="C"))) D  Q
 ...S ^TMP("DG",$J,"PATIENTS","B",DGQSNM_" "_DGQPNM_" "_DGQPIEN_" "_DGQIDT)=DGQPIEN_U_DGQPNM_U_DGQSSN_U_DGQDOB_U_DGQSNM_U_DGQMORE_U_DGQPTR_U_DGQIDT
 ..; 
 ..; Use source source+app't first if "P" (app't) sort, and a clinic:
 ..I ((DGQTYP="C")&(SORT="P")) D  Q
 ...S ^TMP("DG",$J,"PATIENTS","B",DGQSNM_" "_DGQIDT_" "_DGQPNM_" "_DGQPIEN)=DGQPIEN_U_DGQPNM_U_DGQSSN_U_DGQDOB_U_DGQSNM_U_DGQMORE_U_DGQPTR_U_DGQIDT
 ..;
 ..; If not by source or source/app't, default to alpha ("A") sort:
 ..S ^TMP("DG",$J,"PATIENTS","B",DGQPNM_" "_DGQPIEN_" "_DGQSNM_" "_DGQIDT)=DGQPIEN_U_DGQPNM_U_DGQSSN_U_DGQDOB_U_DGQSNM_U_DGQMORE_U_DGQPTR_U_DGQIDT
 .;
 .S DGQCNT=DGQCNT+1                               ; Increment counter.
 ;
 Q
 ;
ID(DGQPIEN) ; Return short ID for patient ID.
 ; (Copied from DGQPT routine and modified.)
 ;
 N ID
 ;
 S ID=$P($G(^DPT(DGQPIEN,.36)),U,4)               ; Gets short ID.
 I '$L(ID) D                                      ; - or -
 .S ID=$E($P($G(^DPT(DGQPIEN,0)),U,9),6,9)        ; Last 4 of SSN
 ;
 Q "("_$E(DGQPNM)_ID_")"
 ;
