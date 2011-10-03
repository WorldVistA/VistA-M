MCUIMAG0 ;HCIOFO/DAD-Create / Update Med Procedure with Image Pointer ;7/23/97  07:36
 ;;2.3;Medicine;**7,12**;09/13/1996
 Q
 ;
UPDATE(MCDATE,MCPROCD0,MCDFN,MCMAGPTR,MCD0,OK) ;
 ; *** Main driver to update Medicine files from Imaging ***
 ;  MCDATE = Date/Time of procedure (FM internal format)
 ;  MCPROCD0 = Pointer to the Procedure/Subspecialty file (#697.2)
 ;  MCDFN = Pointer to the Patient file (#2)
 ;  MCMAGPTR() = An array whose subscripts are pointers to the Image
 ;               file (#2005)  Returned as: MCMAGPTR(File 2005 IEN)=
 ;               MCFILE ^ MCD0 ^ MCD1 (IEN of image in image mult)
 ;  MCD0 = Pointer to one of the Medicine Procedure data files
 ;  OK = A return flag: '1^Message' = All is well, '0^Message' = Bad news
 N DD,DIC,DINUM,DO,MCPATFLD,X,Y
 S MCDATE=+$G(MCDATE),MCPROCD0=+$G(MCPROCD0)
 S MCDFN=+$G(MCDFN),MCD0=+$G(MCD0)
 S MCFILE=+$P($P($G(^MCAR(697.2,MCPROCD0,0)),U,2),"(",2)
 I MCFILE'>0 D  Q
 . S OK="0^Medicine Procedure file global location not found"
 . Q
 S MCPATFLD=$$PATFLD(MCFILE)
 I MCPATFLD'>0 D  Q
 . S OK="0^Medical Patient field not found in Medicine Procedure file"
 . Q
 I MCD0>0 S OK=$$VALID(MCFILE,MCD0,MCDFN,MCPROCD0) Q:'OK
 I MCD0'>0 D  Q:'OK
 . N MCIEN S MCIEN=0
 . F  S MCIEN=$O(^MCAR(MCFILE,"B",MCDATE,MCIEN)) Q:MCIEN'>0  D  Q:MCD0
 .. S OK=$$VALID(MCFILE,MCIEN,MCDFN,MCPROCD0)
 .. I OK S MCD0=MCIEN
 .. Q
 . I MCD0'>0 D NEW(MCDATE,MCDFN,MCFILE,MCPROCD0,MCPATFLD,.MCD0,.OK)
 . Q
 I $O(MCMAGPTR(0)) D FILE(MCD0,MCFILE,.MCMAGPTR,.OK) Q:'OK
 S MCD0=MCD0_U_MCFILE
 Q
 ;
NEW(MCDATE,MCDFN,MCFILE,MCPROCD0,MCPATFLD,MCD0,OK) ;
 ; *** Create new Medicine patient (if needed) and procedure records ***
 ;  MCDATE = Date/Time of procedure (FM internal format)
 ;  MCDFN = Pointer to the Patient file (#2)
 ;  MCFILE = File number of one of the Medicine Procedure data files
 ;  MCPROCD0 = Pointer to the Procedure/Subspecialty file (#697.2)
 ;  MCPATFLD = Field# in one of the Medicine Procedure data files
 ;             that points to the Medical Patient file (#690)
 ;  MCD0 = Pointer to one of the Medicine Procedure data files
 ;  OK = A return flag: '1^Message' = All is well, '0^Message' = Bad news
 N DD,DIC,DINUM,DLAYGO,DO,MCARCODE,MCPRCFLD,MCRESULT,X,Y
 S OK="1^New stub record created in Medicine Procedure data file"
 ; *** Create a new record in the Medical Patient file (#690) ***
 I '$D(^MCAR(690,MCDFN)) D  Q:'OK
 . K DD,DIC,DINUM,DO
 . S (X,DINUM)=MCDFN,DLAYGO=690
 . S DIC="^MCAR(690,",DIC(0)="L"
 . D FILE^DICN
 . I Y'>0 D
 .. S OK="0^Cannot add patient to Medical Patient file"
 .. Q
 . Q
 ; *** Create a stub record ***
 K DD,DIC,DINUM,DO
 S DIC=$$GET1^DID(MCFILE,"","","GLOBAL NAME")
 S DIC(0)="L",DLAYGO=MCFILE
 S DIC("DR")=MCPATFLD_"///`"_MCDFN
 S MCARCODE=$P($G(^MCAR(697.2,MCPROCD0,0)),U,4) S:MCARCODE="" MCARCODE=U
 S MCPRCFLD=$$PRCFLD(MCFILE)
 I MCPRCFLD>0 D PRCSUBS Q:'OK
 S X=MCDATE
 D FILE^DICN S MCD0=+Y
 I MCD0'>0 D
 . S OK="0^Cannot create stub record in the Medicine Procedure data file"
 . Q
 Q
 ;
FILE(MCD0,MCFILE,MCMAGPTR,OK) ;
 ; *** Store the Image file (#2005) pointers in Med Proc data files ***
 ;  MCD0 = Pointer to one of the Medicine Procedure data files
 ;  MCFILE = File number of one of the Medicine Procedure data files
 ;  MCMAGPTR() = An array whose subscripts are pointers to the Image
 ;               file (#2005)  Returned as: MCMAGPTR(File 2005 IEN)=
 ;               MCFILE ^ MCD0 ^ MCD1 (IEN of image in image mult)
 ;  OK = A return flag: '1^Message' = All is well, '0^Message' = Bad news
 N DD,DIC,DINUM,DLAYGO,DO,MCD1,MCDIC,MCMAGD0,MCNODE,X,Y
 S OK="1^The Medicine Procedure file has been updated"
 I $O(MCMAGPTR(0))'>0 D  Q
 . S OK="0^No image number to file in Medicine Procedure file"
 . Q
 I $$VFIELD^DILFD(MCFILE,2005)'>0 D  Q
 . S OK="0^Image field not found in the Medicine Procedure file"
 . Q
 S MCNODE=$P($$GET1^DID(MCFILE,2005,"","GLOBAL SUBSCRIPT LOCATION"),";")
 I MCNODE="" D  Q
 . S OK="0^Medicine Procedure file global subscript location not found"
 . Q
 S MCDIC=$$GET1^DID(MCFILE,"","","GLOBAL NAME")_MCD0_","
 S MCDIC=MCDIC_$S(MCNODE=+MCNODE:MCNODE,1:""""_MCNODE_"""")_","
 S MCDIC("P")=$$GET1^DID(MCFILE,2005,"","SPECIFIER")
 S MCMAGD0=0
 F  S MCMAGD0=$O(MCMAGPTR(MCMAGD0)) Q:MCMAGD0'>0  D  Q:'OK
 . S MCD1=+$O(^MCAR(MCFILE,MCD0,MCNODE,"B",MCMAGD0,0))
 . I MCMAGD0'=$P($G(^MCAR(MCFILE,MCD0,MCNODE,MCD1,0)),U) S MCD1=0
 . K DD,DIC,DINUM,DO
 . S DIC=MCDIC,DIC(0)="L",DIC("P")=MCDIC("P")
 . S DLAYGO=MCFILE,(D0,DA(1))=MCD0
 . S X=MCMAGD0
 . I MCD1'>0 D
 .. D FILE^DICN S MCD1=+Y
 .. I MCD1'>0 S OK="0^Cannot add image to Medicine Procedure file"
 .. Q
 . I OK S MCMAGPTR(MCMAGD0)=MCFILE_U_MCD0_U_MCD1
 . Q
 Q
 ;
VALID(FILE,IEN,DFN,PRC) ;
 ; *** Make sure we have the right Medicine Procedure data file rec ***
 ;  FILE = File number of one of the Medicine Procedure data files
 ;  IEN = Pointer to one of the Medicine Procedure data files
 ;  DFN = Pointer to the Patient file (#2)
 ;  PRC = Pointer to the Procedure/Subspecialty file (#697.2)
 ; Returns
 ;  '1^Message' = All is well, '0^Message' = Bad news
 N FIELD,OK,TYPE
 S OK="1^Record match found"
 S FIELD=$$PATFLD(FILE)
 I FIELD,$$GET1^DIQ(FILE,IEN,FIELD,"I")'=DFN D
 . S OK="0^Patient mismatch"
 . Q
 S FIELD=$$PRCFLD(FILE),TYPE=$$PRCTYPE(PRC)
 ; *** Old Generalized Procedures module and other modules
 I (MCFILE'=699.5)!((MCFILE=699.5)&($$VFILE^DILFD(MCFILE,.06)'>0)) D
 . S FIELD=$P(FIELD,U)
 . Q
 ; *** New Generalized Procedures module
 I (MCFILE=699.5)&($$VFIELD^DILFD(MCFILE,.06)>0) D
 . S FIELD=$S(TYPE="S":$P(FIELD,U),TYPE="P":$P(FIELD,U,2),1:0)
 . Q
 I FIELD,$$GET1^DIQ(FILE,IEN,FIELD,"I")'=PRC D
 . S OK="0^Procedure/Subspecialty mismatch"
 . Q
 Q OK
 ;
PRCFLD(FILE) ;
 ; *** Procedure/Subspecialty pointer field ***
 ;  FILE = File number of one of the Medicine Procedure data files
 ; Returns
 ;  The field# in one of the Medicine Procedure data files that points
 ;  to the Procedure/Subspecialty file (#690)  (Zero [0] if not found)
 N PRCFLD
 S PRCFLD(694)=2,PRCFLD(694.8)=9,PRCFLD(699)=1,PRCFLD(699.5)=".05^.06"
 Q $G(PRCFLD(FILE),0)
 ;
PATFLD(FILE) ;
 ; *** Medical Patient pointer field ***
 ;  FILE = File number of one of the Medicine Procedure data files
 ; Returns
 ;  The field# in one of the Medicine Procedure data files that points
 ;  to the Medical Patient file (#690)  (Zero [0] if not found)
 N MEDPAT
 S MEDPAT(691)=1,MEDPAT(691.1)=1,MEDPAT(691.5)=1,MEDPAT(691.6)=1
 S MEDPAT(691.7)=1,MEDPAT(691.8)=1,MEDPAT(694)=1,MEDPAT(694.5)=1
 S MEDPAT(698)=1,MEDPAT(698.1)=1,MEDPAT(698.2)=1,MEDPAT(698.3)=1
 S MEDPAT(699)=.02,MEDPAT(699.5)=.02,MEDPAT(700)=1,MEDPAT(701)=1
 Q $G(MEDPAT(FILE),0)
 ;
PRCSUBS ; *** Procedure/Subspecialty DIC("DR") builder ***
 ; *** Old Generalized Procedures module and other modules
 N MCGENPRC,MCGENSUB,MCPRCTYP
 I (MCFILE'=699.5)!((MCFILE=699.5)&($$VFIELD^DILFD(MCFILE,.06)'>0)) D
 . D PRCTEST(MCFILE,$P(MCPRCFLD,U),MCPROCD0,.OK)
 . S DIC("DR")=DIC("DR")_";"_$P(MCPRCFLD,U)_"///`"_MCPROCD0
 . Q
 ; *** New Generalized Procedures module
 I (MCFILE=699.5)&($$VFIELD^DILFD(MCFILE,.06)>0) D
 . S MCGENPRC=$$FINDPRC("GENERIC PROCEDURE","P")
 . I MCGENPRC'>0 S OK="0^Entry 'GENERIC PROCEDURE' not found" Q
 . S MCGENSUB=$$FINDPRC("GENERIC SUBSPECIALTY","S")
 . I MCGENSUB'>0 S OK="0^Entry 'GENERIC SUBSPECIALTY' not found" Q
 . S MCPRCTYP=$$PRCTYPE(MCPROCD0)
 . I "^P^S^"'[(U_MCPRCTYP_U) S OK="0^Invalid Procedure/Subspecialty" Q
 . D PRCTEST(MCFILE,$P(MCPRCFLD,U,$TR(MCPRCTYP,"PS","21")),MCPROCD0,.OK)
 . I MCPRCTYP="P" D
 .. S DIC("DR")=DIC("DR")_";"_$P(MCPRCFLD,U)_"///`"_MCGENSUB
 .. S DIC("DR")=DIC("DR")_";"_$P(MCPRCFLD,U,2)_"///`"_MCPROCD0
 .. Q
 . I MCPRCTYP="S" D
 .. S DIC("DR")=DIC("DR")_";"_$P(MCPRCFLD,U)_"///`"_MCPROCD0
 .. S DIC("DR")=DIC("DR")_";"_$P(MCPRCFLD,U,2)_"///`"_MCGENPRC
 .. Q
 . Q
 Q
 ;
PRCTEST(MCFILE,MCPRCFLD,MCPROCD0,OK) ;
 ; *** Test for valid procedure
 N MCRESULT
 D CHK^DIE(MCFILE,MCPRCFLD,"","`"_MCPROCD0,.MCRESULT)
 K ^TMP("DIERR",$J)
 I MCRESULT=U S OK="0^Procedure is invalid"
 Q
 ;
PRCTYPE(MCPROCD0) ;
 ; *** Return the procedure type ***
 Q $P($G(^MCAR(697.2,MCPROCD0,1)),U)
 ;
FINDPRC(MCENTRY,MCTYPE) ;
 ; *** Find a procedure ***
 ;  MCENTRY = External name of the entry (697.2,.01)
 ;  MCTYPE  = Internal 'Procedure/Subspecialty' type (697.2,1001)
 ; Returns
 ;  The IEN of the procedure or zero if not found.
 N MCFOUND,MCIEN
 S (MCIEN,MCFOUND)=0
 F  S MCIEN=$O(^MCAR(697.2,"B",MCENTRY,MCIEN)) Q:MCIEN'>0  D  Q:MCFOUND
 . I $P($G(^MCAR(697.2,MCIEN,0)),U)=MCENTRY D
 .. I $P($G(^MCAR(697.2,MCIEN,1)),U)=MCTYPE S MCFOUND=1
 .. Q
 . Q
 Q +MCIEN
 ;
KILL(MCFILE,MCD0,MCD1,OK) ;
 ; *** Remove an image from Image multiple ***
 ;  MCFILE = A Medicine Procedure data file number
 ;  MCD0 = Pointer to one of the Medicine Procedure data files
 ;  MCD1 = Pointer to one of the entries in the in the Image multiple
 ;  OK = A return flag: '1^Message' = All is well, '0^Message' = Bad news
 N D0,D1,DA,DIK,MCNODE
 S OK="1^Image pointer deleted from Medicine Procedure file"
 I $$VFIELD^DILFD(MCFILE,2005)'>0 D  Q
 . S OK="0^Image field not found in the Medicine Procedure file"
 . Q
 S DIK=$$GET1^DID(MCFILE,"","","GLOBAL NAME")
 I DIK="" D  Q
 . S OK="0^Medicine Procedure file global name not found"
 . Q
 S MCNODE=$P($$GET1^DID(MCFILE,2005,"","GLOBAL SUBSCRIPT LOCATION"),";")
 I MCNODE="" D  Q
 . S OK="0^Medicine Procedure file global subscript location not found"
 . Q
 S DIK=DIK_MCD0_","_$S(MCNODE=+MCNODE:MCNODE,1:""""_MCNODE_"""")_","
 S (D0,DA(1))=MCD0,(D1,DA)=MCD1
 D ^DIK
 Q
