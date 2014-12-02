RADUTL ;HISC/GJC Radiation dosage data filing utility ;1/30/13  09:15
 ;;5.0;Radiology/Nuclear Medicine;**113**;Mar 16, 1998;Build 6
 ;
 ;<<< Business rules >>>
 ;-Exam moved to a status of 'Complete': Initially create the record in
 ; 70.3. Call the VI API and get dose parameters. Store the relevant
 ; radiation dose data in file 70.3.
 ;
 ;-Exam backed down from a status of 'Complete': Do nothing; leave rad
 ; dose data tied to the study
 ;
 ;-Exam moved to a status of 'Complete' for a second/nth time: Delete
 ; existing rad dosage data. Call the VI API and get up to date rad
 ; dose parameters. Store the relevant rad dose data in file 70.3.
 ;
 ;-Exam deleted: The exam is deleted from the database (file 70).
 ; The rad dosage data tied to the study, a study which no longer
 ; exists, cannot be referenced via an exam. Therefore, the rad dose
 ; data record in file 70.3 tied to that study is also deleted.
 ;<<< end business rules >>>
 ;
 ;--- IAs ---
 ;Call                  Number     Type
 ;------------------------------------------------
 ;FILE^DIE              2056       S
 ;UPDATE^DIE            2056       S
 ;REFRESH^MAGVRD03      6000       P
 ;where 'S'=Supported; 'C'=Controlled Subscription; 'P'=Private
 ;
 Q
 ;
DEL(Y) ;delete the top level record from file 70.3
 ;called from option: RA DELETEXAM -Exam Deletion
 ;Input: Y - the top level IEN from file 70.3
 N DIERR,RAFDA,RAIEN
 S RAIEN=Y_",",RAFDA(70.3,RAIEN,.01)="@" D UPDATE^DIE("","RAFDA")
 Q
 ;
UPCT(RAX,RAII,RAIEN) ;update the CT sub-file 70.31
 ;input: RAX array - RAX(IIUID,fld #)=data for that field
 ;       RAII - irradiation instance UID value
 ;       RAIENS - IEN top level record # for 70.3
 ;*** First find the IIUID record, if not found add it as new ***
 N RAFDA,RAH,RAIENS,RAXX,RAY S RAXX="?+1,"_RAIEN_","
 S RAFDA(70.31,RAXX,.01)=RAII
 D UPDATE^DIE("E","RAFDA","RAY(1)")
 Q:$D(DIERR)#2
 S RAH=$G(RAY(1,1))
 Q:'RAH  S RAIENS=RAH_","_RAIEN_","
 ;
 ;*** file the remaining (non .01 field) CT data  ***
 S RAH=.01 K RAFDA
 F  S RAH=$O(RAX(RAII,RAH)) Q:RAH'>0  D
 .S RAFDA(70.31,RAIENS,RAH)=$G(RAX(RAII,RAH))
 .Q
 D FILE^DIE("E","RAFDA")
 Q
 ;
EDTFL(RAP,RAQ,RAR,RAS,RAIENS) ;edit fluoroscopy specific data
 ;<< assumed RADFN, RADTE & RACN are defined globally >>
 ;Input: RAP - DOSE COLLECTED WITHIN THE VA? (#.04)
 ;       RAQ - AIR KERMA (#.05)
 ;       RAR - AIR KERMA AREA PRODUCT (#.06)
 ;       RAS - TOTAL FLUOROSCOPY TIME (#.07)
 ;       RAIENS - IEN file 70.3
 ;
 ;Note: All input variables are REQUIRED. If an input
 ;value is null the value in the field, if any, will
 ;be deleted.
 N DIERR,RAFDA
 Q:RAIENS=""  S RAIENS=RAIENS_","
 S RAFDA(70.3,RAIENS,.04)=RAP
 S RAFDA(70.3,RAIENS,.05)=RAQ
 S RAFDA(70.3,RAIENS,.06)=RAR
 S RAFDA(70.3,RAIENS,.07)=RAS
 D FILE^DIE("","RAFDA")
 Q
 ;
FIND(RADFN,RADTE,RACN) ;find the record in file 70.3
 ;Input: RADFN = DFN of the Radiology patient
 ;       RADTE = the EXAM DATE (FM internal value)
 ;        RACN = case number of the study
 ;
 ;Output: the IEN of the 70.3 record or null
 ;
 Q $O(^RAD("ARAD",RADTE,RADFN,RACN,0))
 ;
NEW(RADFN,RADTE,RACN) ;create a radiation absorbtion dose (RAD) record
 ;(top-level) for this exam
 ;Input: RADFN - the DFN of the patient
 ;       RADTE - the exam date w/time (FM internal format)
 ;        RACN - the case number on the exam
 ;Return: if successful the record number is returned else return
 ;an error message.
 N DIERR,RAFDA,RAIEN703
 S RAFDA(70.3,"+1,",.01)=RADFN
 S RAFDA(70.3,"+1,",.02)=RADTE,RAFDA(70.3,"+1,",.03)=RACN
 D UPDATE^DIE("","RAFDA","RAIEN703")
 S RAIEN703=$S(+$G(RAIEN703(1))>0:RAIEN703(1),1:"-1^unable to create a radiation dose record for this exam")
 Q RAIEN703
 ;
 ;----------------------------------------------------------------
 ;
RADPTR(RADFN,RADTI,RACNI,Y) ;file/delete the pointer value from 70.3 from
 ;the RADIATION ABSORBED DOSAGE (1.1) field of the EXAMINATION (70.03)
 ;sub-file.
 ;Input: RADFN - the DFN of the patient DA(2)
 ;       RADTI - inverse exam date/time DA(1)
 ;       RACNI - the exam record number DA
 ;           Y - if filing the file 70.3 record number 
 ;               if deleting the "@" 
 ;
 N DIERR,RAFDA,RAIENS S RAIENS=RACNI_","_RADTI_","_RADFN_","
 S RAFDA(70.03,RAIENS,1.1)=Y D FILE^DIE("","RAFDA")
 Q
 ;
II(X) ;check the data integrity of the Irradiation Instance UID (IIUID).
 ;Definition: IIUID is defined as a character string containing a UID
 ;that is used to uniquely identify a wide variety of items. The UID
 ;is a series of numeric components separated by the period "."
 ;character. If a Value Field containing one or more UIDs is an
 ;odd number of bytes in length, the Value Field shall be padded
 ;with a single trailing NULL (00H) character (binary: 00000000)
 ;to ensure that the Value Field is an even number of bytes in length.
 ;
 ;Data format: "0"-"9", "." (A series of numeric components separated
 ;by the period "." character)
 ;
 ;Length: 64 bytes maximum
 ;
 ;Input: X = the IIUID with padding or w/o padding
 ;Return: the IIUID w/o padding
 ;
 Q $P(X,$C(0),1)
 ;
GETDOSE ;call the Imaging API which returns radiation dose data for a study
 ; RADFN, RADTI & RACNI exist 
 ; RAY2, RAY3 & RAIT set in RAORDC
 ; $P(RAY3,U) = case #
 N D,FLD,I,II,P,Q,RACCNUM,RADOSE,RAIEN,RAII,RAQ,RARY,X
 ;S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 ;S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RACCNUM=$P(RAY3,U,31) ;SSAN
 S:RACCNUM="" RACCNUM=$E(RAY2,4,7)_$E(RAY2,2,3)_"-"_$P(RAY3,U)
 ;S X=$P($G(^RA(79.2,$P(RAY2,U,2),0)),U,3) ;abbreviation
 ;S RAIT=$S(X="RAD":"FLUORO",1:"CT")
 ;
 D REFRESH^MAGVRD03(.RARY,RADFN,RACCNUM,RAIT)
 Q:+RARY(1)'=0  ;'0' indicates the call was a success; else quit
 Q:$P(RARY(1),"`",3)=0  ;call a success but no data
 ;
 ;is there an existing rad dose record for this study?
 S RADOSE=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,1)),U)
 ;if RADOSE="" create new record in file 70.3
 S:RADOSE="" RADOSE=$$NEW(RADFN,RADTE,$P(RAY3,U))
 ;
 ;<<< FORMAT the data into a structure I can use. Note: the variable 'D' will act as my delimiter >>>
 S D="|"
 ;
 ; Note: Each new CT repetition starts with TYPE
 ;       as a label
 ;
 ;CT from: ARRAY(n)=field name_D_value
 ;     to: RAQ(IIUID,field 70.31)=value
 ;IRRADIATION INSTANCE -> fld: .01; TARGET REGION -> fld: 2
 ;PHANTOM TYPE -> fld: 3; CTDIvol -> fld: 4 and DLP -> fld: 5
 I RAIT="CT" D
 .K RAQ S RAI=$O(RARY(0)) ;# rec indicator
 .S RAI=0 F  S RAI=$O(RARY(RAI)) Q:RAI'>0  D
 ..S X=$G(RARY(RAI))
 ..I $P(X,D,1)="IRRADIATION INSTANCE UID" D
 ...S II=$$II($P(X,D,2)) ;IIUID
 ...S RAQ(II,.01)=II
 ...Q
 ..I $P(X,D,1)="TARGET REGION" S RAQ(II,2)=$P(X,D,2)
 ..I $P(X,D,1)="PHANTOM TYPE" S RAQ(II,3)=$P(X,D,2)
 ..I $P(X,D,1)="CTDIVOL" S RAQ(II,4)=+$FN($P(X,D,2),"",3)
 ..I $P(X,D,1)="DLP" S RAQ(II,5)=+$FN($P(X,D,2),"",3)
 ..Q
 .K RARY S RAII=""
 .F  S RAII=$O(RAQ(RAII))  Q:RAII=""  D
 ..D UPCT(.RAQ,RAII,RADOSE) ;update CT multiple
 ..Q
 .K I,II,RAI,RAII,RAQ,X
 .Q
 ;
 ;
 ;FLUORO from: ARRAY(n)=field name_D_value
 ;         to: RAQ(field 70.3)=value
 E  D  ;else if RAIT="FLUORO"
 .;TOTAL TIME IN FLUOROSCOPY maps to TOTAL FLUOROSCOPY TIME (70.3;.07)
 .;DOSE (RP) TOTAL (AKE) maps to AIR KERMA (70.3 ; .05)
 .;FLUORO DOSE AREA PRODUCT TOTAL maps to AIR KERMA AREA PRODUCT (70.3 ; .06)
 .S T="0^0^0"
 .;first piece air kerma (.05)
 .;second piece air kerma area product (.06)
 .;third piece total fluoroscopy time (.07)
 .S RAI=$O(RARY(0)) ;# rec indicator
 .F  S RAI=$O(RARY(RAI)) Q:RAI'>0  D
 ..S X=$G(RARY(RAI))
 ..S:$P(X,D,1)="DOSE (RP) TOTAL (AKE)" $P(T,U,1)=$P(T,U,1)+$P(X,D,2)
 ..S:$P(X,D,1)="FLUORO DOSE AREA PRODUCT TOTAL" $P(T,U,2)=$P(T,U,2)+$P(X,D,2)
 ..S:$P(X,D,1)="TOTAL TIME IN FLUOROSCOPY" $P(T,U,3)=$P(T,U,3)+$P(X,D,2)
 ..Q
 .;file fluoro data into file 70.3
 .K RARY D EDTFL("",$P(T,U,1),$P(T,U,2),$P(T,U,3),RADOSE)
 .K RAI,T,X
 .Q
 ;
 ;
 ;<<< update the EXAMINATIONS sub-file's >>>
 ;    RADIATION ABSORBED DOSE field (#1.1)
 D RADPTR(RADFN,RADTI,RACNI,RADOSE)
 Q
 ;
