IVMZ7CD ;CKN,BAJ,ERC - HL7 Z07 CONSISTENCY CHECKER -- DEMOGRAPHIC SUBROUTINE ; 8/1/08 1:54pm
 ;;2.0;INCOME VERIFICATION MATCH;**105,127,132,115**;OCT 21,1994;Build 28
 ;
 ; Demographic Consistency Checks
 ; This routine will be called from driver routine and it checks the
 ; various elements of Person demographic information prior to
 ; building a Z07 record. Any test which fails consistency check will
 ; be saved in file 38.6 INCONSISTENT DATA ELEMENT record for Person.
 ;
 Q
 ;
EN(DFN,DGP,DGSD) ;Entry point
 ;  input:  DFN - Patient IEN
 ;          DGP - Patient data array
 ;         DGSD - Spouse and Dependent data array
 ; output: ^TMP($J,DFN,RULE) global
 ;          DFN - Patient IEN
 ;         RULE - Consistency rule #
 ;initializing variables
 N RULE,Y,X,FILERR
 ;
 ; loop through rules in INCONSISTENT DATA ELEMENTS file.
 ; execute only the rules where CHECK/DON'T CHECK and INCLUDE IN Z07
 ; CHECKS fields are turned ON.
 ; 
 ; ***NOTE loop boundary (301-311) must be changed if rule numbers
 ; are added ***
 F RULE=301:1:312 I $D(^DGIN(38.6,RULE)) D
 . S Y=^DGIN(38.6,RULE,0)
 . I $P(Y,"^",6) D @RULE
 I $D(FILERR) M ^TMP($J,DFN)=FILERR
 Q
 ;
301 ; PERSON LASTNAME REQUIRED
 S X=$P($G(DGP("NAME",1)),U) I X="" S FILERR(RULE)=""
 I '$D(DGSD("DEP")) Q
 S RIEN=0 F  S RIEN=$O(DGSD("DEP",RIEN)) Q:RIEN=""  D
 . S X=$P(DGSD("DEP",RIEN,0),U)
 . S X=$P(X,",") I X="" S FILERR(RULE)=""
 Q
 ;
302 ; DATE OF BIRTH REQUIRED - Duplicate with #4
 Q  ;This tag needs to be removed after its placement in IVMZ7CR
 S X=$P($G(DGP("PAT",0)),U,3) I X="" S FILERR(RULE)=""
 I '$D(DGSD("DEP")) Q
 S RIEN=0 F  S RIEN=$O(DGSD("DEP",RIEN)) Q:RIEN=""  D
 . S X=$P(DGSD("DEP",RIEN,0),U,3) I X="" S FILERR(RULE)=""
 Q
 ;
303 ; GENDER REQUIRED
 S X=$P($G(DGP("PAT",0)),U,2) I X="" S FILERR(RULE)=""
 I '$D(DGSD("DEP")) Q
 S RIEN=0 F  S RIEN=$O(DGSD("DEP",RIEN)) Q:RIEN=""  D
 . S X=$P(DGSD("DEP",RIEN,0),U,2) I X="" S FILERR(RULE)=""
 Q
 ;
304 ; GENDER INVALID
 S X=$P($G(DGP("PAT",0)),U,2) I X]"",X'="M",X'="F" S FILERR(RULE)=""
 I '$D(DGSD("DEP")) Q
 S RIEN=0 F  S RIEN=$O(DGSD("DEP",RIEN)) Q:RIEN=""  D
 . S X=$P(DGSD("DEP",RIEN,0),U,2)
 . I X]"",X'="M",X'="F" S FILERR(RULE)=""
 Q
 ;
305 ; VETERAN SSN MISSING - Duplicate with #7
 Q  ;This tag needs to be removed after its placement in IVMZ7CR
 S X=$P($G(DGP("PAT",0)),U,9) I X="" S FILERR(RULE)=""
 Q
 ;
306 ; VALID SSN/PSEUDO SSN REQUIRED, turned off with DG*5.3*771
 N Z
 S X=$P($G(DGP("PAT",0)),U,9)
 Q:X=""  ;quit if no SSN
 Q:$E(X,$L(X))="P"       ;quit if SSN is a Pseudo
 I $E(X,1,5)="00000" S FILERR(RULE)="" ;First 5 number are zero
 S $P(Z,$E(X),9)=$E(X) I X=Z S FILERR(RULE)="" ;all numbers are same
 I $E(X,1,3)="000" S FILERR(RULE)="" ;First 3 digits are zeros
 I $E(X,4,5)="00" S FILERR(RULE)="" ;4th & 5th are zeros
 I $E(X,6,9)="0000" S FILERR(RULE)="" ;Last 4 digits are zeros
 I X=123456789 S FILERR(RULE)="" ;SSN is 123456789
 Q
 ;
307 ; PSEUDO SSN REASON REQUIRED, turned off with DG*5.3*771
 S X=$P($G(DGP("PAT",0)),U,9)
 I X]"",X["P",$P($G(DGP("PAT","SSN")),U)="" S FILERR(RULE)=""
 I '$D(DGSD("DEP")) Q
 S RIEN=0 F  S RIEN=$O(DGSD("DEP",RIEN)) Q:RIEN=""  D
 . S X=$P(DGSD("DEP",RIEN,0),U,9)
 . I X]"",X["P",$P(DGSD("DEP",RIEN,0),U,10)="" S FILERR(RULE)=""
 Q
 ;
308 ; DATE OF DEATH BEFORE DOB
 S X=$P($G(DGP("PAT",.35)),U) I X']"" Q
 I X<$P($G(DGP("PAT",0)),U,3) S FILERR(RULE)=""
 Q
 ;
309 ; PATIENT RELATIONSHIP INVALID
 N DEPSEX,RELSEX,DEPREL
 I '$D(DGSD("DEP")) Q
 S RIEN=0 F  S RIEN=$O(DGSD("DEP",RIEN)) Q:RIEN=""  D
 . S DEPREL=$G(DGSD("DEP",RIEN))
 . I DEPREL="" S FILERR(RULE)="" Q
 . I '$D(^DG(408.11,DEPREL)) S FILERR(RULE)="" Q
 . S DEPSEX=$P(DGSD("DEP",RIEN,0),U,2)
 . S RELSEX=$P(^DG(408.11,DEPREL,0),U,3)
 . I RELSEX="E" Q  ;Gender for relation can be either
 . I DEPSEX'=RELSEX S FILERR(RULE)=""
 Q
 ;
310 ; DEPENDENT EFF. DATE REQUIRED
 I '$D(DGSD("DEP")) Q
 S RIEN=0 F  S RIEN=$O(DGSD("DEP",RIEN)) Q:RIEN=""  D
 . S X=$G(DGSD("DEP",RIEN,"EFF")) I 'X S FILERR(RULE)=""
 Q
 ;
311 ; DATE OF DEATH IS FUTURE DATE - Duplicate with #16
 Q  ;This tag needs to be removed after its placement in IVMZ7CR
 S X=$P($G(DGP("PAT",.35)),U)
 I X]"",X>$$NOW^XLFDT() S FILERR(RULE)=""
 Q
 ;
312 ; PERSON MUST HAVE NATIONAL ICN
 I $$GETICN^MPIF001(DFN)<0 S FILERR(RULE)="" Q  ;No ICN
 I $$IFLOCAL^MPIF001(DFN)=1 S FILERR(RULE)=""  ;Not National ICN
 Q
 ;
