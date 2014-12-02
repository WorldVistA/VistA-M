SROICDGT ;BIR/SJA - CODE SET VERSIONING UTILITY ;26 Sep 2013  3:39 PM
 ;;3.0;Surgery;**177**;24 Jun 93;Build 89
 ;
 ; Reference to $$SYS^ICDEX supported by DBIA #5747
 ;
GETAPI(SRAPP,TYPE,SRIEN) ;ICD-9/ICD-10 selection - called by input transform
 ; - INPUT: X    := the initial user input to be searched on (REQUIRED)
 ;         SRAPP := application name in file 130.4;.01 (REQUIRED)
 ;          TYPE := type of call in file 130.4;.04 (REQUIRED)
 ;         SRIEN := top level entry in file 130 (DA) used to get date to compute correct version (OPTIONAL but needs DA)
 ;                  Note: applications using this as an example will need to modify the code that uses this.
 ; - OUTPUT: X   := the internal value to be stored in the field.
 ;           Y   := the internal value to be stored in the field
 ;
 N DIC,DIE,SRDA,SRDT,ENTRY,SRCODE,SRVER,SRX,DTOUT,DUOUT,DIROUT,SRONECH
 ; JAS - Patch 177 - Next line - A value for Y was leaking into this API
 K Y
 I X=" " S X=$$SPACEBAR^SROICD("^ICD9(") I X=" " K X,Y Q
 I X="?BAD" W ! S X="" Q
 ;
 I X="@" K X Q
 I '$L($G(SRAPP)) D MSG("The Application making the call was not specified.") K X Q
 I '$L($G(TYPE)) D MSG("The Search Type (diagnosis or procedure) was not specified.") K X Q
 I $L($G(X))>100!($L($G(X))<1) D MSG("Answer must be 1-100 characters in length.") K X Q
 ;
 ; -- next three lines are Surgery Specific
 ;
 ; - Note: X and SRDT are used inside the executed code
 S SRDA=$S($G(SRIEN):SRIEN,$D(DA(2)):DA(2),$D(DA(1)):DA(1),$D(DA):DA,$D(D0):D0,$G(SRTN):SRTN,1:"")
 I $G(^SRF($G(SRDA),0))="" D MSG("Entry in the Surgery file was not found.") K X Q
 S SRDT=$S($G(SRDA):$P($P(^SRF(SRDA,0),"^",9),"."),1:DT) ; SRDT is used in executable code
 ;
 N DA
 S SRVER=$$SYS^ICDEX(TYPE,SRDT)
 I SRVER'>0 D MSG("Could not acquire the correct ICD Version for '"_TYPE_"' on "_$$FMTE^XLFDT(SRDT)) K X Q
 ;
 I X["?" D  K X,Y Q
 . N SRTAG S SRTAG=""
 . I SRVER=30 S SRTAG=$S(X["???":"D3",X["??":"D2",X["?":"D1",1:"D1") D @SRTAG Q
 . I SRVER=1 S SRTAG="Answer with ICD-9 DIAGNOSIS CODE NUMBER, or DESCRIPTION."
 . N SRFORMAT S SRFORMAT=$S(X["??":"!?8",1:"!?5")
 . D EN^DDIOL(SRTAG,"",SRFORMAT)
 . Q
 I SRVER=30,X="*" S X=""
 ;
 I SRVER=30,$L(X)<2 D  K X,Y S SRONECH=1 Q
 . D EN^DDIOL("Please enter at least the first two characters of the ICD-10","","!!?5")
 . D EN^DDIOL("code or code description to start the search.","","!?5")
 . D EN^DDIOL(" ")
 . Q
 ;
 S ENTRY=$O(^DIC(130.4,"C",SRAPP,TYPE,SRVER,0))
 I ENTRY'>0 D MSG("Search Entry in ICD SEARCH API file for application '"_SRAPP_"' of type '"_TYPE_"' for Version '"_SRVER_"' is missing.") K X Q
 S SRCODE=$G(^DIC(130.4,ENTRY,1))
 I '$L(SRCODE) D MSG("No Executable Code found for a ICD code search for type '"_TYPE_"'.") K X Q
 I $L(SRCODE) X SRCODE
 I SRVER=1 D
 . I $D(Y(0,1)) W "  ",$P(Y(0,1),U,2),"  ICD-9  ",$P(Y(0,1),U,4)
 I $G(Y)>0 S X=+Y Q
 K X,Y
 Q
MSG(SRTEXT) ;
 D EN^DDIOL(SRTEXT)
 Q
 ;
D1 ; -- Diagnosis ?  Help
 Q:$G(SRONECH)
 Q:X="?BAD"
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
 N SRHLP
 S SRHLP(1)="Number of Code Matches"
 S SRHLP(1,"F")="!?8"
 S SRHLP(2)="----------------------"
 S SRHLP(2,"F")="!?8"
 S SRHLP(3)="The ICD-10 Diagnosis Code search will show the user the number of"
 S SRHLP(3,"F")="!!?8"
 S SRHLP(4)="matches found, indicate if additional characters in ICD code exist,"
 S SRHLP(4,"F")="!?8"
 S SRHLP(5)="and the number of codes within the category or subcategory that are"
 S SRHLP(5,"F")="!?8"
 S SRHLP(6)="available for selection.  For example:"
 S SRHLP(6,"F")="!?8"
 S SRHLP(8)="19 matches found"
 S SRHLP(8,"F")="!!?8"
 S SRHLP(10)="M91. -      Juvenile osteochondrosis of hip and pelvis (19)"
 S SRHLP(10,"F")="!!?8"
 S SRHLP(12)="This indicates that 19 unique matches or matching groups have been"
 S SRHLP(12,"F")="!!?8"
 S SRHLP(13)="found and will be displayed."
 S SRHLP(13,"F")="!?8"
 S SRHLP(15)="M91. -  the ""-"" indicates that there are additional characters"
 S SRHLP(15)="M91. -  the ""-"" indicates that there are additional characters"
 S SRHLP(15,"F")="!!?8"
 S SRHLP(16)="that specify unique ICD-10 codes available."
 S SRHLP(16,"F")="!?8"
 S SRHLP(18)="(19)   Indicates that there are 19 additional ICD-10 codes in the"
 S SRHLP(18,"F")="!!?8"
 S SRHLP(19)="M91 ""family"" that are possible selections."
 S SRHLP(19,"F")="!?8"
 D EN^DDIOL(.SRHLP)
 Q
 ;
TR(X) ;
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q X
TEST ; -- test api calls
 S X="003.1" D GETAPI^SROICDGT("SURG","DIAG",1)
 Q
 S X="F1" W !,"1" D GETAPI^SROICDGT(,"DIAG",1) ;no application
 S X="F1" W !,"2" D GETAPI^SROICDGT("SURG",,1) ;no Type
 S X="F1" W !,"3" D GETAPI^SROICDGT("SURG","DIAG",199999) ;no entry is Surgery file
 S X="" W !,"4" D GETAPI^SROICDGT("SURG","DIAG",1) ;Answer too short
 S X="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
 W !,"5" D GETAPI^SROICDGT("SURG","PROC",1) ;answer too long
 S X="F1" W !,"6" D GETAPI^SROICDGT("SURG","DAIG",1) ; NO VERSION found
 S X="F1" W !,"7" D GETAPI^SROICDGT("SUGR","DIAG",1) ; no entry for Daig
 S X="F1" W !,"8" D GETAPI^SROICDGT("SURG","PROC",1) ;no executable code
 ;
 S X="330" W !,"9 - SHOULD WORK" D GETAPI^SROICDGT("SURG","DIAG",1) ; This one is icd-9
 S X="S62" W !,"10 - SHOULD WORK" D GETAPI^SROICDGT("SURG","DIAG",21) ; This one is icd-10
 S X="COCAINE" W !,"11 - SHOULD WORK" D GETAPI^SROICDGT("SURG","DIAG",21) ; This one is icd-10
 S X="fracture" W !,"12 - SHOULD WORK" D GETAPI^SROICDGT("SURG","DIAG",21) ; This one is icd-10
 Q
