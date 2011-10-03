RAMAINU1 ;HISC/GJC-Radiology Utility File Maintenance (utility)
 ;;5.0;Radiology/Nuclear Medicine;**45**;Mar 16, 1998
 ;Note: new routine with the release of RA*5*45
 ;
FILEAU(RAD0,RATRKCMB) ;File the 'when, where, and who' data when the contrast
 ;media definitions for our Rad/Nuc Med Procedure change via an edit.
 ;input: RADA=IEN of the Rad/Nuc Med Procedure record
 ;       RATRKCMB=the before contrast media definition
 S RAD1=$O(^RAMIS(71,RAD0,"AUD",$C(32)),-1)+1
 ;It is important to know when the user purges cm associations
 ;related to a procedure. In this case, we want to audit file to
 ;track subsequent cm purge events ignoring the case when the user
 ;initially associates cm with a procedure.
 I RAD1=1,RATRKCMB="" K RAD1 Q
 S RASFM(71.06,"+"_RAD1_","_RAD0_",",.01)=+$E($$NOW^XLFDT(),1,12)
 S RASFM(71.06,"+"_RAD1_","_RAD0_",",2)=RATRKCMB
 S RASFM(71.06,"+"_RAD1_","_RAD0_",",3)=$G(DUZ)
 D UPDATE^DIE("","RASFM","RAD1") K RAD1,RASFM
 Q
 ;
AUD70(RADFN,RADTI,RACNI,RATRKCMB) ;File the 'when, where, and who' data
 ;when the contrast media definitions for our Rad/Nuc Med exam change
 ;via an edit.
 ;input: RADFN=DFN of the Rad/Nuc Med patient (file 2)
 ;       RADTI=exam date/time (inverse)
 ;       RACNI=ien of exam record (examinations sub-file 70.03)
 ;       RATRKCMB=the before contrast media definition
 S RAD3=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"AUD",$C(32)),-1)+1
 ;It is important to know when the user purges cm associations related
 ;to an exam. In this case, we want to audit file to track subsequent
 ;cm purge events ignoring the case when the user initially associates
 ;cm with an exam.
 I RAD3=1,RATRKCMB="" K RAD3 Q
 S RAIENS="+"_RAD3_","_RACNI_","_RADTI_","_RADFN_","
 S RASFM(70.16,RAIENS,.01)=+$E($$NOW^XLFDT(),1,12)
 S RASFM(70.16,RAIENS,2)=RATRKCMB
 S RASFM(70.16,RAIENS,3)=$G(DUZ)
 D UPDATE^DIE("","RASFM","RAD3") K RAD3,RAIENS,RASFM
 Q
 ;
UPPCM(DA,X) ;Check that if contrast media data is associated with this
 ;procedure that the 'CONTRAST MEDIA USED' (#20) field is set
 ;to 'Yes'. If contrast media data is not associated with this
 ;procedure check that the 'CONTRAST MEDIA USED' field is set
 ;to 'No'. Called immediately after exiting the 'RA PROCEDURE EDIT'
 ;input template in RAMAIN2.
 ;
 ;input: DA=IEN of the record in file 71
 ;        X=the internal value; 'N' - No, 'Y' - Yes, or '@' - delete
 ;
 K RASFM S RASFM(71,DA_",",20)=X
 D UPDATE^DIE("","RASFM") K RASFM
 Q
 ;
CMINTEG(DA,X) ;ensure data consistency between the 'CONTRAST MEDIA USED' &
 ;'CONTRAST MEDIA' fields for file 71.
 ;
 ;input: DA=ien of the record in file 71
 ;        X=zero node of RAD/NUC MED PROCEDURE record
 S RACM471=$O(^RAMIS(71,DA,"CM",0))
 I RACM471,$P(X,U,20)'="Y" D  ;cm assoc, contrast media used 'no'
 .W !!?3,"'"_$E($P(X,U),1,45)_"' has contrast media associations:"
 .S RAI=0 F  S RAI=$O(^RAMIS(71,DA,"CM",RAI)) Q:'RAI  D  ;display CM
 ..S RAI(0)=$G(^RAMIS(71,DA,"CM",RAI,0))
 ..W !?5,$$EXTERNAL^DILFD(71.0125,.01,"",$P(RAI(0),U))
 ..Q
 .W !?3,"Updating the 'CONTRAST MEDIA USED' field to 'Yes'."
 .D UPPCM(DA,"Y") K RAI
 .Q
 I 'RACM471,$P(X,U,20)="Y" D  ;no cm assoc, contrast media used 'yes'
 .W !!?3,"'"_$E($P(X,U),1,45)_"' doesn't have contrast media associations;"
 .W !?3,"updating the 'CONTRAST MEDIA USED' field to 'No'."
 .D UPPCM(DA,"N")
 .Q
 K RACM471 Q
 ;
XCMINTEG(DA) ;ensure data consistency between the 'CONTRAST MEDIA USED' &
 ;'CONTRAST MEDIA' fields for file 70.
 ;
 ;input: DA=ien of the record in file 70 array; DA, DA(1), & DA(2)
 ;
 S RAXCM0=$G(^RADPT(DA(2),"DT",DA(1),"P",DA,0))
 S RAXCMP=$P(RAXCM0,U,2),RAXCMP=$$EXTERNAL^DILFD(70.03,2,"",RAXCMP)
 S RACM470=$O(^RADPT(DA(2),"DT",DA(1),"P",DA,"CM",0))
 I RACM470,$P(RAXCM0,U,10)'="Y" D  ;cm assoc, contrast media used 'no'
 .W !!?3,"'"_$E(RAXCMP,1,45)_"' has contrast media associations:"
 .S RAI=0
 .F  S RAI=$O(^RADPT(DA(2),"DT",DA(1),"P",DA,"CM",RAI)) Q:'RAI  D  ;display CM
 ..S RAI(0)=$G(^RADPT(DA(2),"DT",DA(1),"P",DA,"CM",RAI,0))
 ..W !?5,$$EXTERNAL^DILFD(70.3225,.01,"",$P(RAI(0),U))
 ..Q
 .W !?3,"Updating the 'CONTRAST MEDIA USED' field to 'Yes'."
 .D UPXCM^RAMAINU(.DA,"Y") K RAI
 .Q
 I 'RACM470,$P(RAXCM0,U,10)="Y" D  ;no cm assoc, contrast media used 'yes'
 .W !!?3,"'"_$E(RAXCMP,1,45)_"' doesn't have contrast media associations;"
 .W !?3,"updating the 'CONTRAST MEDIA USED' field to 'No'."
 .D UPXCM^RAMAINU(.DA,"N")
 .Q
 K RACM470,RAXCM0,RAXCMP Q
 ;
