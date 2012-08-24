PXRMINTR ;SLC/PKR/PJH - Input transforms for Clinical Reminders. ;02/024/2011
 ;;2.0;CLINICAL REMINDERS;**4,12,16,18**;Feb 04, 2005;Build 152
 ;=======================================================
VASP(DA,X) ;Check for valid associate sponsor in file 811.6.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 ;Make sure that an associated sponsor does not point to itself.
 I X=DA D  Q 0
 . D EN^DDIOL("An associated sponsor cannot point to itself.")
 ;A sponsor cannot be an associated sponsor if it contains associated
 ;sponsors.
 I $D(^PXRMD(811.6,X,2,"B")) D  Q 0
 . D EN^DDIOL("A sponsor cannot be selected as an associated sponsor if it contains associated sponsors.")
 ;The class of an associated sponsor must match that of the sponsor.
 N ASCLASS,SCLASS
 S SCLASS=$P(^PXRMD(811.6,DA,0),U,2)
 S ASCLASS=$P(^PXRMD(811.6,X,0),U,2)
 I ASCLASS'=SCLASS D  Q 0
 . N TEXT
 . S TEXT="The associated sponsor's class is "_ASCLASS_", it does not match the sponsor's class which is "_SCLASS_". They must match."
 . D EN^DDIOL(TEXT)
 Q 1
 ;
 ;=======================================================
VCLASS(X) ;Check for valid CLASS field, ordinary users cannot create
 ;National classes.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 I (X["N"),(($G(PXRMINST)'=1)!(DUZ(0)'="@")) D  Q 0
 . D EN^DDIOL("You are not allowed to create a NATIONAL class")
 E  Q 1
 ;
 ;=======================================================
VDT(X) ;Check for a valid date/time. Input transform on 
 ;beginning date/time and ending date/time fields.
 N FMDATE,PXRMINTR,VALID
 S PXRMINTR=1
 ;If X is already in internal FileMan format make sure it is valid.
 I X?7N0.1"."0.6N D DT^DILF("ST",X,.FMDATE,"","MSG")
 I X'?7N0.1"."0.6N S FMDATE=$$CTFMD^PXRMDATE(X)
 S VALID=$S(FMDATE=-1:0,1:1)
 I 'VALID D 
 . N TEXT
 . S TEXT=X_" is not a valid date/time"
 . D EN^DDIOL(TEXT)
 Q VALID
 ;
 ;=======================================================
VFINDING(X) ;Check X to see if it is a valid finding. This is the input
 ;transform on the .01 field of the reminder findings multiple for
 ;definitions and terms.
 ;Include stubs for all possible finding types in case we need input
 ;transforms on them.
 ;I X["AUTTEDT(" Q 1
 ;I X["AUTTEXAM(" Q 1
 I X["AUTTHF(" Q $$VHF(X)
 ;I X["AUTTIMM(" Q 1
 ;I X["AUTTSK(" Q 1
 ;I X["GMRD(120.51," Q 1
 I X["LAB(60," Q $$VLAB(X)
 ;I X["ORD(101.43," Q 1
 I X["PXD(811.2," Q $$VTAX(X)
 ;I X["PXRMD(811.4," Q 1
 ;I X["PXRMD(811.5," Q 1
 ;I X["PS(50.605," Q 1
 ;I X["PSDRUG(" Q 1
 ;I X["PSNDF(50.6," Q 1
 ;I X["RAMIS(71," Q 1
 ;I X["YTT(601," Q 1
 Q 1
 ;
 ;=======================================================
VFREQ(X) ;Check for a valid frequency. It must be of the form NU,
 ;where N is an integer and U is unit. The integer can be between
 ;0 and 9999 inclusive. Valid units are: H (hours),
 ;D (days), W (weeks), M (months), and Y (years). Used as input
 ;transform for Baseline Frequency, finding multiple Reminder
 ;Frequency and called by Custom Date Due input transform.
 S X=$$UP^XLFSTR(X)
 Q X?1.4N1(1"H",1"D",1"W",1"M",1"Y")
 ;
 ;=======================================================
VHF(X) ;Check for valid health factor findings. It must be a factor, not
 ;a category.
 N CAT,IEN,TEMP,TYPE
 S IEN=$P(X,";",1)
 S TEMP=$G(^AUTTHF(IEN,0))
 S TYPE=$P(TEMP,U,10)
 I TYPE="C" D  Q 0
 . D EN^DDIOL("Category health factors cannot be used as a finding!")
 I TYPE'="F" D  Q 0
 . D EN^DDIOL("Only factor health factors can be used as a finding!")
 ;Make sure that the health factor has a category.
 S CAT=$P(TEMP,U,3)
 I CAT="" D  Q 0
 . D EN^DDIOL("Factor health factors must have a category!")
 I '$D(^AUTTHF(CAT)) D  Q 0
 . D EN^DDIOL("The category for this health factor does not exist!")
 Q 1
 ;
 ;=======================================================
VIGNAC(X) ;Check X to see if it contains valid IGNORE ON N/A codes.
 ;This is part of the input transform for this field. The length of the
 ;IGNORE ON N/A field is 8 characters. The valid codes are:
 ;   A - age
 ;   I - inactive
 ;   R - race
 ;   S - sex
 ;   * - wildcard matches anything.
 N LEN
 S LEN=$L(X)
 I (LEN>8)!(LEN<1) Q 0
 ;
 N TEMP,TEXT
 S TEMP=X
 S TEMP=$TR(TEMP,"A","")
 S TEMP=$TR(TEMP,"I","")
 S TEMP=$TR(TEMP,"R","")
 S TEMP=$TR(TEMP,"S","")
 S TEMP=$TR(TEMP,"*","")
 ;At this point TEMP should be NULL,if it is not then there are
 ;bad codes.
 S LEN=$L(TEMP)
 I LEN=1 D  Q 0
 . S TEXT=TEMP_" is not a valid IGNORE ON N/A code!"
 . D EN^DDIOL(TEXT)
 I LEN>1 D  Q 0
 . S TEXT=TEMP_" are not valid IGNORE ON N/A codes!"
 . D EN^DDIOL(TEXT)
 Q 1
 ;
 ;=======================================================
VLAB(X) ;Check for valid lab findings. Everything but a panel is ok.
 I X'["LAB(60" Q 1
 N DATANAME,LAB0,LABTEST,SUB,TEST,TEXT
 S LABTEST=$P(X,";",1)
 ;DBIA #91-A
 S LAB0=^LAB(60,LABTEST,0)
 S SUB=$P(LAB0,U,4)
 ;BB and WK not allowed
 I (SUB="BB")!(SUB="WK") D  Q 0
 . S TEXT=SUB_" tests cannot be used as reminder findings."
 . D EN^DDIOL(.TEXT)
 ;The concept of lab panel only applies to CH tests.
 I SUB'["CH" Q 1
 S DATANAME=$P(LAB0,U,5)
 ;If DATA NAME is null then it is a panel.
 I DATANAME="" D  Q 0
 . S TEXT(1)=$P(LAB0,U,1)_" is a lab panel, it cannot be used as a reminder finding!"
 . S TEXT(2)="Contact your Lab ADPAC for help"
 . D EN^DDIOL(.TEXT)
 Q 1
 ;
 ;=======================================================
VNAME(NAME) ;Check for a valid .01 value. The names of national reminder
 ;components start with "VA-" and normal users are not allowed to
 ;create them.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N AUTH,STEXT,TEXT,VALID
 S NAME=$$UP^XLFSTR(NAME)
 S VALID=1
 S STEXT=$E(NAME,1,3)
 I (STEXT="VA-") D
 . S AUTH=($G(PXRMINST)=1)&(DUZ(0)="@")
 . I 'AUTH D
 .. S TEXT="Name cannot start with ""VA-"", reserved for national reminder components!"
 .. D EN^DDIOL(TEXT)
 .. H 2
 .. S VALID=0
 Q VALID
 ;
 ;=======================================================
VSPONSOR(X) ;Make sure file Class and Sponsor Class match.
 ;If there is no sponsor don't do the check.
 I X="" Q 1
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N FCLASS,FILENUM,SCLASS,TEXT,VALID
 S VALID=1
 I $G(X)="" Q VALID
 I $G(DIC)="" Q 0
 S FILENUM=+$P(@(DIC_"0)"),U,2)
 S FCLASS=$P(@(DIC_DA_",100)"),U,1)
 S SCLASS=$P(^PXRMD(811.6,X,100),U,1)
 I SCLASS'=FCLASS D
 . S FCLASS=$$EXTERNAL^DILFD(FILENUM,100,"",FCLASS)
 . S SCLASS=$$EXTERNAL^DILFD(811.6,100,"",SCLASS)
 . S TEXT="Sponsor Class is "_SCLASS_", File Class is "_FCLASS_" they must match!"
 . D EN^DDIOL(TEXT)
 . S VALID=0
 Q VALID
 ;
 ;=======================================================
VTAX(X) ;Make sure the taxonomy is active.
 N IEN,INACTIVE
 S IEN=$P(X,";",1)
 S INACTIVE=$P(^PXD(811.2,IEN,0),U,6)
 I INACTIVE D  Q 0
 . D EN^DDIOL("This taxonomy is inactive and cannot be selected.")
 Q 1
 ;
 ;=======================================================
VUSAGE(X) ;Check X to see if it contains valid USAGE codes.
 ;This is part of the input transform for this field. The length of the
 ;USAGE field is 10 characters. The valid codes are:
 ;   C - CPRS
 ;   L - Reminder Patient List
 ;   O - Reminder Order Checks
 ;   P - Patient
 ;   R - Reports
 ;   X - Extracts
 ;   * - Wildcard matches anything, except P.
 N LEN
 S LEN=$L(X)
 I (LEN>10)!(LEN<1) Q 0
 ;
 N TEMP,TEXT
 S TEMP=$$UP^XLFSTR(X)
 S TEMP=$TR(TEMP,"C","")
 S TEMP=$TR(TEMP,"L","")
 S TEMP=$TR(TEMP,"O","")
 S TEMP=$TR(TEMP,"P","")
 S TEMP=$TR(TEMP,"R","")
 S TEMP=$TR(TEMP,"X","")
 S TEMP=$TR(TEMP,"*","")
 ;At this point TEMP should be NULL,if it is not then there are
 ;bad codes.
 S LEN=$L(TEMP)
 I LEN=1 D  Q 0
 . S TEXT=TEMP_" is not a valid USAGE code!"
 . D EN^DDIOL(TEXT)
 I LEN>1 D  Q 0
 . S TEXT=TEMP_" are not valid USAGE codes!"
 . D EN^DDIOL(TEXT)
 Q 1
