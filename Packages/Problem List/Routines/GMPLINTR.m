GMPLINTR ;ISP/TC - Problem List Input Transform ;08/09/17  08:17
 ;;2.0;Problem List;**49**;Aug 25, 1994;Build 43
 ;
VCLASS(X,GMPIMPRT,GMPTYPE) ;Check for valid CLASS field
 ; Ordinary users cannot create National classes.
 ; Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 S:'$D(GMPIMPRT) GMPIMPRT=0
 S:'$D(GMPTYPE) GMPTYPE=""
 I '$L(X) D EN^DDIOL(" Error: "_GMPTYPE_" class cannot be empty.") Q 0
 I (X["N"),(DUZ(0)'="@"),('GMPIMPRT) D  Q 0
 . D EN^DDIOL("You are not allowed to create a NATIONAL class")
 S X=$$UP^XLFSTR(X)
 I X="NATIONAL"!(X="LOCAL")!(X="VISN")!(X="N")!(X="L")!(X="V") Q 1
 E  D EN^DDIOL(" Error: Invalid "_GMPTYPE_" class value, "_X_".") Q 0
 Q 1
VFLAG(GMPLFLAG) ;Check for a valid flag in CSV file
 N GMPLTXT,GMPLINV S GMPLINV=0
 I '$L(GMPLFLAG) S GMPLTXT(1)=" Add/delete cell cannot be empty.",GMPLINV=1
 E  I GMPLFLAG="#"!(GMPLFLAG="@") S GMPLINV=0
 E  S GMPLTXT(1)=" '"_GMPLFLAG_"' is an invalid character.",GMPLINV=1
 I GMPLINV D  Q 0
 . S GMPLTXT(1)=GMPLTXT(1)_" Must contain # (to add) or @ (to delete)."
 . S GMPLTXT(2)=" Please verify cell in import file and correct any errors."
 . D EN^DDIOL(.GMPLTXT)
 E  Q 1
VNAME(GMPNAME,GMPIMPRT,GMPTYPE) ;Check for a valid NAME value.
 ; The names of selection list components start with "VA-"
 ; and normal users are not allowed to create them.
 ; Do not execute as part of a verify fields.
 N GMPAUTH,GMPSTEXT,GMPTEXT,GMPVALID
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 S:'$D(GMPIMPRT) GMPIMPRT=0
 S:'$D(GMPTYPE) GMPTYPE=""
 I '$L(GMPNAME) D  Q GMPVALID
 . S GMPTEXT=" Error: "_GMPTYPE_" name cannot be empty."
 . D EN^DDIOL(GMPTEXT) S GMPVALID=0
 S GMPNAME=$$UP^XLFSTR(GMPNAME)
 S GMPVALID=1
 I GMPNAME["~" D
 . S GMPTEXT=" Name cannot contain the ""~"" character."
 . D EN^DDIOL(GMPTEXT)
 . H 2
 . S GMPVALID=0
 S GMPSTEXT=$E(GMPNAME,1,3)
 I (GMPSTEXT="VA-"),('GMPIMPRT) D
 . S GMPAUTH=(DUZ(0)="@")
 . I 'GMPAUTH D
 . . S GMPTEXT=" Name cannot start with ""VA-"", reserved for national selection list components!"
 . . D EN^DDIOL(GMPTEXT)
 . . H 2
 . . S GMPVALID=0
 Q GMPVALID
 ;
VICD(GMPLICD) ;Check for a valid ICD code
 N GMI,GMPDT,GMPVALID S GMPDT=$$DT^XLFDT,GMPVALID=0
 ; Do not execute if ICD-9 code and as part of verify fields report
 I GMPLICD?1.3(1.3N1"."0.3N0.1"/"),($G(DIUTIL)="VERIFY FIELDS") S GMPVALID=1
 I GMPLICD?1.3(1U2N1".".4N0.1"/")!(GMPLICD?1.3(1U2N1".".4U0.1"/")) S GMPVALID=1
 I GMPLICD?1.3(1U2N1".".3N.1U0.1"/")!(GMPLICD?1.3(1U2N1".".1U.3N0.1"/")) S GMPVALID=1
 I GMPLICD?1.3(1U2N1".".1N.1U0.2N0.1"/")!(GMPLICD?1.3(1U2N1"."0.2N.1U.1N0.1"/")) S GMPVALID=1
 I GMPVALID D
 . F GMI=1:1:$L(GMPLICD,"/") D
 . . N GMPLCPTR S GMPLCPTR=$P($$CODECS^ICDEX($P(GMPLICD,"/",GMI),80,GMPDT),U)
 . . I '$$STATCHK^ICDEX($P(GMPLICD,"/",GMI),GMPDT,GMPLCPTR) D  Q
 . . . D EN^DDIOL(" ICD Code: "_GMPLICD_" is inactive.")
 . . . S GMPVALID=0
 E  D EN^DDIOL(" ICD Code: "_GMPLICD_" is invalid.")
 Q GMPVALID
 ;
VSCTCODE(GMPLSCTC) ;Check for a valid SNOMED CT code
 N GMPDT,GMPVALID,GMPSCHK S GMPDT=$$DT^XLFDT,GMPVALID=1
 S GMPSCHK=$$STATCHK^LEXSRC2(GMPLSCTC,GMPDT,"","SCT")
 I '+GMPSCHK,($L($P(GMPSCHK,U,3))) D
 . D EN^DDIOL(" SNOMED CT Concept: "_GMPLSCTC_" is inactive.")
 . S GMPVALID=0
 E  I '+GMPSCHK,($P(GMPSCHK,U,2)<0) D
 . D EN^DDIOL(" SNOMED CT Concept: "_GMPLSCTC_" is invalid.")
 . S GMPVALID=0
 E  I '+GMPSCHK,('$L($P(GMPSCHK,U,3))) D
 . D EN^DDIOL(" SNOMED CT Concept: "_GMPLSCTC_" is not yet active.")
 . S GMPVALID=0
 Q GMPVALID
 ;
VSCTDSGN(GMPLSCTC,GMPLSCTD,GMPLDTXT) ;Check for a valid SNOMED CT designation code
 N GMPDT,GMPVALID,GMPLSDGN,GMPQT,GMPSYN,GMPTYP,GMPNUM,GMPLRSLT,GMPLTXT
 S GMPDT=$$DT^XLFDT,GMPVALID=1,(GMPQT,GMPNUM)=0,(GMPTYP,GMPLSDGN)=""
 S GMPLRSLT=$$GETSYN^LEXTRAN1("SCT",GMPLSCTC,GMPDT,"GMPSYN",1,1)
 I +GMPLRSLT<0 D  G VSCTDX Q
 . S GMPLTXT(2)=" Error: "_$P(GMPLRSLT,U,2)
 . S GMPVALID=0
 S GMPLDTXT=$$STRIPSPC^GMPLX(GMPLDTXT)
 F  S GMPTYP=$O(GMPSYN(GMPTYP)) Q:GMPTYP=""!(GMPQT)  D
 . I GMPTYP="S" F  S GMPNUM=$O(GMPSYN(GMPTYP,GMPNUM)) Q:GMPNUM=""!(GMPQT)  D
 . . I $$STRIPSPC^GMPLX($P(GMPSYN(GMPTYP,GMPNUM),U))=GMPLDTXT S GMPLSDGN=$P(GMPSYN(GMPTYP,GMPNUM),U,3),GMPQT=1 Q
 . I (GMPNUM=""),(GMPLSDGN="") D  G VSCTDX Q
 . . S GMPLTXT(2)=" Error: Check failed, problem description does not match that of system."
 . . S GMPVALID=0,GMPQT=1
 . Q:GMPQT
 . I $$STRIPSPC^GMPLX($P(GMPSYN(GMPTYP),U))=GMPLDTXT S GMPLSDGN=$P(GMPSYN(GMPTYP),U,3),GMPQT=1 Q
 I 'GMPVALID G VSCTDX1
 I +GMPLRSLT>0 D
 . I GMPLSCTD'=GMPLSDGN S GMPLTXT(2)=" Error: Check failed, designation code does not match that of system.",GMPVALID=0
VSCTDX I 'GMPVALID D
 . S GMPLTXT(1)=" SNOMED CT Designation: "_GMPLSCTD_" is invalid."
 . D EN^DDIOL(.GMPLTXT)
VSCTDX1 Q GMPVALID
 ;
VSEQ(X,GMPLTYPE) ; Check for valid SEQUENCE field
 N GMPLTXT,GMPLINV S GMPLINV=0
 I '$L(X) S GMPLTXT=" Error: "_GMPLTYPE_" sequence cannot be empty.",GMPLINV=1
 E  I +X'=X!(X>999.99)!(X<.01)!(X?.E1"."3N.N) S GMPLTXT=" "_GMPLTYPE_" Sequence: "_X_" is invalid.",GMPLINV=1
 I GMPLINV D EN^DDIOL(GMPLTXT) Q 0
 E  Q 1
