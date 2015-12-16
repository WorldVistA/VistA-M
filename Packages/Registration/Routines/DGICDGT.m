DGICDGT ;BIR/SJA - ALB/AAS - ADT ICD DIAGNOSIS SEARCH ;02-Feb-2012
 ;;5.3;Registration;**850,884**;Aug 13, 1993;Build 31
 ;
 ;This routine does not conform to Standard & Conventions routine naming conventions
 ;since package routine names of DG_I* (with the exceptions of Kernel, VA FileMan, and
 ;routines created to support the INIT process) should not be used.  The SACC has granted
 ;an exemption for this routine.
 ;
 ; CSI^ICDEX     ICR 5747
 ; SYS^ICDEX     ICR 5747
 ; LS^ICDEX      ICR 5747
 ;
 ;Reference to $$ICDDATA^ICDXCODE supported by DBIA #5699
 ;
GETAPI(APP,TYPE,PTF,CHK,DGNODE) ;ICD-9/ICD-10 selection - called by input transform
 ; - INPUT: X    := the initial user input to be searched on (REQUIRED)
 ;          APP  := application name "DG PTF" ;drp removed file ref  in file 130.4;.01 (REQUIRED)
 ;          TYPE := type of call "DIAG or "PROC" ;drp removed file ref in file 130.4;.04 (REQUIRED)
 ;          PTF  := top level entry in file 130 (DA) used to get date to compute correct version (OPTIONAL but needs DA)
 ;          CHK  := additional screening logic
 ;                  Note: applications using this as an example will need to modify the code that uses this.
 ;       DGNODE  := node variable needed to account for increased DX code storage across different
 ;                  PTF global nodes, default=0 (OPTIONAL)
 ; - OUTPUT: X   := the internal value to be stored in the field.
 ;           Y   := the internal value to be stored in the field
 ;
 N DIC,DIE,DGPTDA,DGDT,IMPDATE,ENTRY,CODE,VERSION,DGX,LEXI,EFFDATE,IMPDATE,DGPTDAT,DGER,KEY,DUOUT,DTOUT
 ;
 S DGNODE=$G(DGNODE,0) ;default to 0 node if not passed
 ;
 I X="?BAD" S X="" D MSG("") Q
 I X="@" K X Q
 I '$L($G(APP)) D MSG("The Application making the call was not specified.") K X Q
 I '$L($G(TYPE)) D MSG("The Search Type (diagnosis or procedure) was not specified.") K X Q
 I $L($G(X))>100!($L($G(X))<1) D MSG("Answer must be 1-100 characters in length.") K X Q
 ;
 ;I $G(PTF)=-1 S DGPTDAT=$S($G(DGPTDAT)?7N:DGPTDAT,1:DT) D  G GO ; special case for call not related to PTF record
 ;. K CHK
 ;. S DGTEMP=$$IMPDATE^DGPTIC10("10D")
 ;. S EFFDATE=+DGTEMP
 ;. S IMPDATE=$P(DGTEMP,U,1)
 ;. I DGPTDAT'<IMPDATE,+$P(DGTEMP,U,2)?7N S EFFDATE=+$P(DGTEMP,U,2)
 ;
 ; -- next FOUR lines are DG PTF Specific, plus one more line further below
 ; - Note: X and EFFDATE are used inside the executed code
 S DGPTDA=$S($G(PTF):PTF,$D(DA(2)):DA(2),$D(DA(1)):DA(1),$D(DA):DA,$D(D0):D0,1:"")
 I DGPTDA="" S EFFDATE=$G(DGDRGDT),CHK="" D EFFDAT1^DGPTIC10(EFFDATE) G GO
 I $G(^DGPT($G(DGPTDA),0))="" D MSG("Entry in the PTF file was not found.") K X Q
 ; DGTYPE determines which EFFDATE is used inside executable code. 701 is default.
 N DGTYPE S DGTYPE=$P($G(X1,"^701"),U,2) D EFFDATE^DGPTIC10(DGPTDA,DGTYPE)
 ;
GO ; -- Jump for DRG calculation
 S VERSION=$$SYS^ICDEX(TYPE,EFFDATE)
 I VERSION'>0 D MSG("Could not acquire the correct ICD Version for '"_TYPE_"' on "_$$FMTE^XLFDT(EFFDATE)) K X Q
 I X["?" D  K X,Y Q
 . N TAG S TAG=""
 . I VERSION=30 S TAG=$S(X["???":"D3",X["??":"D2",X["?":"D1",1:"D1") D @TAG Q
 . I VERSION=31 S TAG=$S(X["???":"P3",X["??":"P2",X["?":"P1",1:"P1") D @TAG Q
 . I VERSION=1 S TAG="Answer with ICD-9 DIAGNOSIS CODE NUMBER, or DESCRIPTION."
 . I VERSION=2 S TAG="Answer with ICD-9 OPERATION/PROCEDURE, or CODE NUMBER, or DESCRIPTION."
 . S FORMAT=$S(X["??":"!?8",1:"!?5")
 . D EN^DDIOL(TAG,"",FORMAT)
 . Q
 I VERSION=31,X["*" S X=$P(X,"*",1)_$P(X,"*",2)
 ;
 ;References to file 130.4  removed to eliminate dependency on Surgery SR*3.0*177
 ;I VERSION=30,X?1L1N S X=$$TR(X)
 ;S ENTRY=$O(^DIC(130.4,"C",APP,TYPE,VERSION,0))
 ;I ENTRY'>0 D MSG("Search Entry in ICD SEARCH API file for application '"_APP_"' of type '"_TYPE_"' for Version '"_VERSION_"' is missing.") K X Q
 ;S CODE=$G(^DIC(130.4,ENTRY,1))
 ;Replaced previous lines with lines below.
 S CODE=$S(VERSION=1:"S Y=$$GETICD9^DGPTF5(EFFDATE)",VERSION=30:"D LEX^DGICD",VERSION=2:"S Y=$$SEARCH^ICDSAPI(""PROC"",(""I $$LS^ICDEX(80.1,+Y,""""""_EFFDATE_"""""")=1""),""QEMZ"",EFFDATE)",VERSION=31:"D ASK^DGICP",1:-1)
 I CODE=-1 D MSG("Search Entry in ICD SEARCH API file for application '"_APP_"' of type '"_TYPE_"' for Version '"_VERSION_"' is missing.") K X Q
 ;
 I '$L(CODE) D MSG("No Executable Code found for a ICD code search for type '"_TYPE_"'.") K X Q
 I $L(CODE) X CODE
 ;
 ; -- execute additional checks for DG PTF
 ;    no code entered twice, gender specific codes, requires other codes, 
 ;    can't be used with other current codes, etc
 S DGER=0 I $G(CHK)'="",$G(Y)>0 D @(CHK_"^DGPTFJC") I $G(DGER) K X,Y Q
 ;
 I $G(Y)>0 S X=+Y Q
 K X,Y
 Q
MSG(TEXT) ;
 D EN^DDIOL(TEXT)
 Q
 ;
TR(X) ;
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q X
D1 ; -- Diagnosis ?  Help
 I X["???" D D3 Q  ;For calls from ^DIR, doesn't support ??? help
 I X["??" D D2 Q
 D EN^DDIOL("Enter code or ""text"" for more information.","","!?5")
 D EN^DDIOL(" ")
 Q
 ;
D2 ; -- Diagnosis ??  Help
 D EN^DDIOL("Enter a ""free text"" term or part of a term such as ""femur fracture"".","","!?8")
 D EN^DDIOL("    or","","!?8")
 D EN^DDIOL("Enter a ""classification code"" (ICD/CPT, etc.) to find the single term","","!?8")
 D EN^DDIOL("associated with the code","","!?8")
 D EN^DDIOL("    or","","!?8")
 D EN^DDIOL("Enter a ""partial code"". Include the decimal when a search criterion","","!?8")
 D EN^DDIOL("includes 3 characters or more for code searches.","","!?8")
 D EN^DDIOL(" ")
 Q
 ;
D3 ; -- Diagnosis ???  Help
 N HLP
 S HLP(1)="Number of Code Matches"
 S HLP(1,"F")="!?8"
 S HLP(2)="----------------------"
 S HLP(2,"F")="!?8"
 S HLP(3)="The ICD-10 Diagnosis Code search will show the user the number of"
 S HLP(3,"F")="!!?8"
 S HLP(4)="matches found, indicate if additional characters in ICD code exist,"
 S HLP(4,"F")="!?8"
 S HLP(5)="and the number of codes within the category or subcategory that are"
 S HLP(5,"F")="!?8"
 S HLP(6)="available for selection.  For example:"
 S HLP(6,"F")="!?8"
 S HLP(8)="19 matches found"
 S HLP(8,"F")="!!?8"
 S HLP(10)="M91. -      Juvenile osteochondrosis of hip and pelvis (19)"
 S HLP(10,"F")="!!?8"
 S HLP(12)="This indicates that 19 unique matches or matching groups have been"
 S HLP(12,"F")="!!?8"
 S HLP(13)="found and will be displayed."
 S HLP(13,"F")="!?8"
 S HLP(15)="M91. -  the ""-"" indicates that there are additional characters"
 S HLP(15,"F")="!!?8"
 S HLP(16)="that specify unique ICD-10 codes available."
 S HLP(16,"F")="!?8"
 S HLP(18)="(19)   Indicates that there are 19 additional ICD-10 codes in the"
 S HLP(18,"F")="!!?8"
 S HLP(19)="M91 ""family"" that are possible selections."
 S HLP(19,"F")="!?8"
 D EN^DDIOL(.HLP)
 Q
 ;
P1 ;
 I X["???" D P3 Q  ;For calls from ^DIR, doesn't support ??? help
 I X["??" D P2 Q
 D EN^DDIOL("Enter the initial character(s) of an ICD-10 partial code or an","","!?5")
 D EN^DDIOL("asterisk (*) for more information.","","!?5")
 D EN^DDIOL(" ")
 Q
 ;
P2 ;
 D EN^DDIOL("1. Enter an ICD-10 Procedure Code.","","!?8")
 D EN^DDIOL("      or  ","","!?8")
 D EN^DDIOL("2. Enter any alphanumeric char values of the procedure code to ""build""","","!?8")
 D EN^DDIOL("   an ICD-10 Procedure Code.","","!?8")
 D EN^DDIOL("      or  ","","!?8")
 D EN^DDIOL("3. Enter an asterisk (*) to initiate a procedure code build search. ","","!?8")
 D EN^DDIOL(" ")
 Q
 ;
P3 ;
 D EN^DDIOL("The procedure code search provides a ""decision tree"" type structure","","!?8")
 D EN^DDIOL("that makes use of the specific ICD-10-PCS code format and structure,","","!?8")
 D EN^DDIOL("where all codes consist of 7 alphanumeric characters, with each","","!?8")
 D EN^DDIOL("position in the code having a specific meaning.","","!?8")
 D EN^DDIOL(" ")
 Q
 ;
 ;TEST ; -- test api calls
 S X="F1" W !,"1" D GETAPI^DGICDGT(,"DIAG",1) ;no application
 S X="F1" W !,"2" D GETAPI^DGICDGT("DG PTF",,1) ;no Type
 S X="F1" W !,"3" D GETAPI^DGICDGT("DG PTF","DIAG",199999) ;no entry is PTFF file
 S X="" W !,"4" D GETAPI^DGICDGT("DG PTF","DIAG",1) ;Answer too short
 S X="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
 W !,"5" D GETAPI^DGICDGT("DG PTF","PROC",1) ;answer too long
 S X="F1" W !,"6" D GETAPI^DGICDGT("DG PTF","DAIG",1) ; NO VERSION found
 S X="F1" W !,"7" D GETAPI^DGICDGT("DG PTF","DIAG",1) ; no entry for Daig
 S X="F1" W !,"8" D GETAPI^DGICDGT("DG PTF","PROC",1) ;no executable code
 ;
 S X="330" W !,"9 - SHOULD WORK" D GETAPI^DGICDGT("DG PTF","DIAG",1) ; This one is icd-9
 S X="S62" W !,"10 - SHOULD WORK" D GETAPI^DGICDGT("DG PTF","DIAG",21) ; This one is icd-10
 S X="COCAINE" W !,"11 'COCAINE' - SHOULD WORK" D GETAPI^DGICDGT("DG PTF","DIAG",21) ; This one is icd-10
T12 S X="fracture" W !,"12 'FRACTURE'- TOO LONG" D GETAPI^DGICDGT("DG PTF","DIAG",14) ; This one is icd-10
 Q
D19 ;
 I X["???" D D29 Q  ;For calls from ^DIR, doesn't support ?? OR ??? help
 D EN^DDIOL("Enter a ""free text"" term.  Best results occur using one to")
 D EN^DDIOL("      three full or partial words without a suffix.")
 D EN^DDIOL("  or ")
 D EN^DDIOL("      Enter a classification code (ICD/CPT etc) to find the single")
 D EN^DDIOL("      term associated with the code.")
 D EN^DDIOL("  or ")
 D EN^DDIOL("      Enter a classification code (ICD/CPT etc) followed by a plus")
 D EN^DDIOL("      sign (+) to retrieve all terms associated with the code. ")
 Q
 ;
D29 ;
 D EN^DDIOL("      Enter a ""free text"" term.  Best results occur using one to ")
 D EN^DDIOL("      three full or partial words without a suffix (i.e., ""DIABETES"",")
 D EN^DDIOL("      ""DIAB MELL"",""DIAB MELL INSUL"")")
 D EN^DDIOL("  or  ")
 D EN^DDIOL("      Enter a classification code (ICD/CPT etc) to find the single ")
 D EN^DDIOL("      term associated with the code.  Example, a lookup of code 239.0 ")
 D EN^DDIOL("      returns one and only one term, that is the preferred ")
 D EN^DDIOL("      term for the code 239.0, ""Neoplasm of unspecified nature ")
 D EN^DDIOL("      of digestive system""")
 D EN^DDIOL("  or  ")
 D EN^DDIOL("      Enter a classification code (ICD/CPT etc) followed by a plus")
 D EN^DDIOL("      sign (+) to retrieve all terms associated with the code.  Example,")
 D EN^DDIOL("      a lookup of 239.0+ returns all terms that are linked to the ")
 D EN^DDIOL("      code 239.0.")
 Q
 ;
P19 ;
 N DGYN S DGYN=1
 D EN^DDIOL("Answer with ICD-9 OPERATION/PROCEDURE, or CODE NUMBER, or DESCRIPTION")
 I X="?" D EN^DDIOL("Do you want the entire ICD-9 OPERATION/PROCEDURE List") S %=0 D YN^DICN S DGYN=%
 S DIC("S")="I $$CSI^ICDEX(80.1,+Y)=2"
 S DIC("W")="N C,DINAME S IEN=+Y W ""  "" D EN^DDIOL(("" ""_$$IDOPS^ICDID(+Y)),"""",""?0"")"
 S DIC="^ICD0(",DIC("0")="AEQMZ",DZ="??",D="B",DO="ICD OPERATION/PROCEDURE^80.1OI^4487^4480",DO(2)="80.1OI"
 D:DGYN=1 DQ^DICQ
 Q
 ;
