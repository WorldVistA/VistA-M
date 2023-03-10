PXAISKV ;ISL/PKR - VALIDATE SKIN TEST DATA ;Nov 27, 2020@13:06:12
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**199,211,217**;Aug 12, 1996;Build 134
 ;
ERRSET ;Set the rest of the error data.
 S STOP=1
 S PXAERRF("SK")=1
 S PXADI("DIALOG")=8390001.001
 S PXAERR(7)="SKIN TEST"
 Q
 ;
VAL ;Validate the input data.
 I '$D(PXAA("TEST")) D  Q
 . S PXAERR(9)="SKIN TEST"
 . S PXAERR(12)="You are missing the name of the Skin Test."
 . D ERRSET
 ;
 I $G(PXAA("DELETE"))=1 D  Q
 . N PXAIEN
 . ;Check to see if there is a skin test reading linked to this entry
 . S PXAIEN=+$$GETIEN^PXAISK(PXAVISIT,PXAA("TEST"))
 . I '$D(^AUPNVSK("APT",PXAIEN)) Q
 . S PXAERR(9)="SKIN TEST"
 . S PXAERR(11)=$G(PXAA("TEST"))
 . S PXAERR(12)="There is a skin test reading linked to this entry; "
 . S PXAERR(12)=PXAERR(12)_"you must first delete the skin test reading entry (#"
 . S PXAERR(12)=PXAERR(12)_$O(^AUPNVSK("APT",PXAIEN,0))_") before deleting this placement entry"
 . D ERRSET
 ;
 ; if passing in placement entry, make sure the skin test and patient are the same
 I $G(PXAA("PLACEMENT")) D  Q:$G(STOP)=1
 . I PXAA("TEST")=$P($G(^AUPNVSK(PXAA("PLACEMENT"),0)),U,1) Q
 . I $G(PATIENT)=$P($G(^AUPNVSK(PXAA("PLACEMENT"),0)),U,2) Q
 . S PXAERR(9)="SKIN TEST"
 . S PXAERR(11)=$G(PXAA("TEST"))
 . S PXAERR(12)="The placement entry is for a different skin test"
 ;
 I '$D(^AUTTSK(PXAA("TEST"))) D  Q
 . S PXAERR(9)="SKIN TEST"
 . S PXAERR(11)=PXAA("TEST")
 . S PXAERR(12)="The Skin Test pointer is not valid."
 . D ERRSET
 ;
 N TEMP S TEMP=$G(^AUTTSK(PXAA("TEST"),0))
 ;Check that the .01 is not null.
 I $P(TEMP,U,1)="" D  Q
 . S PXAERR(9)="SKIN TEST"
 . S PXAERR(11)=PXAA("TEST")
 . S PXAERR(12)="The Skin Test does not have a .01."
 . D ERRSET
 ;
 ;Check that the test is active.
 ;* I $P(TEMP,U,3)=1 D  Q
 ;* . S PXAERR(9)="SKIN TEST"
 ;* . S PXAERR(11)=PXAA("TEST")
 ;* . S PXAERR(12)="The Skin Test is inactive."
 ;* . D ERRSET
 ;
 ;If a Reading is input validate it.
 ;* I $G(PXAA("READING"))'="",(+PXAA("READING")'=PXAA("READING")!(PXAA("READING")>40)!(PXAA("READING")<0)!(PXAA("READING")?.E1"."1N.N)) D  Q
 ;* . S PXAERR(9)="READING"
 ;* . S PXAERR(12)=+PXAA("READING")_" is not a whole number between 0 and 40."
 ;* . D ERRSET
 ;
 ;If a Result is input validate it.
 ;* I $G(PXAA("RESULT"))'="",'$$SET^PXAIVAL(9000010.12,"RESULT",.04,PXAA("RESULT"),.PXAERR) D  Q
 ;* . D ERRSET
 ;
 ;If D/T Read is input verify it is a valid FileMan date .
 ;* I $G(PXAA("D/T READ"))'="",'$$DATETIME^PXAIVAL("D/T READ",PXAA("D/T READ"),"T",.PXAERR) D  Q
 ;* . D ERRSET
 ;
 ;If D/T Read is input verify it is not a future date.
 ;* I $G(PXAA("D/T READ"))'="",$$FUTURE^PXDATE(PXAA("D/T READ")) D  Q
 ;* . S PXAERR(9)="D/T READ"
 ;* . S PXAERR(11)=PXAA("D/T READ")
 ;* . S PXAERR(12)=+PXAA("D/T READ")_" is a future date."
 ;* . D ERRSET
 ;
 ;If Event D/T is input verify it is a valid FileMan date and not in
 ;the future.
 ;* I $G(PXAA("EVENT D/T"))'="",'$$EVENTDT^PXAIVAL(PXAA("EVENT D/T"),"T",.PXAERR) D  Q
 ;* . D ERRSET
 ;
 ;If an Ordering Provider is passed verify it is valid.
 ;* I $G(PXAA("ORD PROVIDER"))'="",'$$PRV^PXAIVAL(PXAA("ORD PROVIDER"),"ORD",.PXAA,.PXAERR,PXAVISIT) D  Q
 ;* . D ERRSET
 ;
 ;If an Encounter Provider is passed verify it is valid.
 ;* I $G(PXAA("ENC PROVIDER"))'="",'$$PRV^PXAIVAL(PXAA("ENC PROVIDER"),"ENC",.PXAA,.PXAERR,PXAVISIT) D  Q
 ;* . D ERRSET
 ;
 ;If an Anatomic Location is passed verify it is valid.
 ;* I $G(PXAA("ANATOMIC LOC"))'="",'$D(^PXV(920.3,PXAA("ANATOMIC LOC"),0)) D  Q
 ;* . S PXAERR(9)="ANATOMIC LOC"
 ;* . S PXAERR(11)=PXAA("ANATOMIC LOC")
 ;* . S PXAERR(12)=PXAA("ANATOMIC LOC")_" is a not a valid pointer to the Imm Administration Site file."
 ;* . D ERRSET
 ;
 ;If a Reading Comment is passed verify it.
 ;* I $G(PXAA("READING COMMENT"))'="",'$$TEXT^PXAIVAL("READING COMMENT",PXAA("READING COMMENT"),1,245,.PXAERR) D  Q
 ;* . D ERRSET
 ;
 ;If a Comment is passed verify it.
 ;* I $G(PXAA("COMMENT"))'="",'$$TEXT^PXAIVAL("COMMENT",PXAA("COMMENT"),1,245,.PXAERR) D  Q
 ;* . D ERRSET
 ;
 ;If PKG is input verify it.
 ;* I $G(PXAA("PKG"))'="" D
 ;* . N PKG
 ;* . S PKG=$$VPKG^PXAIVAL(PXAA("PKG"),.PXAERR)
 ;* . I PKG=0 S PXAERR(9)="PKG" D ERRSET Q
 ;* . S PXAA("PKG")=PKG
 ;* I $G(STOP)=1 Q
 ;
 ;If SOURCE is input verify it.
 ;* I $G(PXAA("SOURCE"))'="" D
 ;* . N SRC
 ;* . S SRC=$$VSOURCE^PXAIVAL(PXAA("SOURCE"),.PXAERR)
 ;* . I SRC=0 S PXAERR(9)="SOURCE" D ERRSET Q
 ;* . S PXAA("SOURCE")=SRC
 ;* I $G(STOP)=1 Q
 ;
 ;Check for diagnosis input and return a warning.
 ;* N DIAGSTR,DIAGNUM,NDIAG
 ;* S NDIAG=0
 ;* F DIAGNUM=1:1:8 D
 ;* . S DIAGSTR="DIAGNOSIS"_$S(DIAGNUM>1:" "_DIAGNUM,1:"")
 ;* . I $G(PXAA(DIAGSTR))]"" S NDIAG=NDIAG+1
 ;* I NDIAG>0 D  Q
 ;* . S PXADI("DIALOG")=8390001.002
 ;* . S PXAERRW("SK")=1
 ;* . S PXAERR(9)="DIAGNOSIS"
 ;* . S PXAERR(12)="As of patch PX*1*211 diagnoses cannot be stored in V SKIN TEST."
 Q
 ;
