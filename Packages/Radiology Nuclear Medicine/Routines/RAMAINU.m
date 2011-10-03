RAMAINU ;HISC/GJC-Radiology Utility File Maintenance (utility)
 ;;5.0;Radiology/Nuclear Medicine;**45**;Mar 16, 1998
 ;Note: new routine with the release of RA*5*45
 ;
CPT(DA,RAX) ;Ask for CPT Code when the 'Procedure Enter/Edit' option
 ;is exercised. Called from input template: RA PROCEDURE EDIT
 ;Input: DA=ien of new record being edited & RAX=procedure name
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RAFDA,RAYN,X,Y S RAYN=0
 F  D  Q:+RAYN!($D(DIRUT)#2)
 .K X,Y S DIR(0)="71,9" D ^DIR Q:$D(DIRUT)#2
 .;Y=N^S where N=record ien & S=.01 value of the record
 .W !!,"Note: If an erroneous CPT Code is accepted it cannot be changed; the",!,"procedure must be inactivated."
 .W !!,"Are you adding '"_$P(Y,U,2)_"' as the CPT Code for the new Rad/Nuc Med Procedure",!,"'"_RAX_"'? NO// "
 .R RAYN:DTIME
 .I '$T!(RAYN["^") S RAYN=-1 Q
 .S RAYN=$E(RAYN) S:RAYN="" RAYN="N"
 .I "YyNn"'[RAYN W !?3,"Enter 'Y' to accept the CPT Code, or 'N' to reject the CPT Code or '^' to",!?3,"exit without selecting a CPT Code."
 .I  W !?5,"Note: If an erroneous CPT Code is accepted it cannot be changed; the",!?5,"procedure must be inactivated."
 .S:"Yy"[RAYN RAYN="1^Y"
 .S:"Nn"[RAYN RAYN=0
 .Q
 I $P(RAYN,U,2)="Y" S RAFDA(71,DA_",",9)=$P(Y,U) D FILE^DIE("","RAFDA")
 Q
 ;
TRKCMB(DA,RACMB4) ;Contrast Medium/Media is used with this procedure.
 ;Track the editing of this data. This subroutine saves off the 'before'
 ;values in a local variable. The 'before' and 'after' values will be
 ;compared. If they differ, then the 'before' value will be filed in
 ;the audit log.
 ; input: DA=IEN of the Rad/Nuc Med Procedure record
 ;output: RACMB4=CM definitions for this procedure before edit
 N I S I=0,RACMB4=""
 F  S I=$O(^RAMIS(71,DA,"CM",I)) Q:'I  D
 .S RACMB4=RACMB4_$P($G(^RAMIS(71,DA,"CM",I,0)),U)
 .Q
 Q
 ;
TRK70CMB(RADFN,RADTI,RACNI,RACMB4) ;Contrast Medium/Media is used with
 ;this procedure. Track the editing of this data. This subroutine saves
 ;off the 'before' values in a local variable. The 'before' and 'after'
 ;values will be compared. If they differ, then the 'before' value will
 ;be filed in the audit log.
 ;input: RADFN=DFN of the Rad/Nuc Med patient (file 2)
 ;       RADTI=exam date/time (inverse)
 ;       RACNI=ien of exam record (examinations sub-file 70.03)
 ;output: RACMB4=CM definitions for this procedure before edit
 N I S I=0,RACMB4=""
 F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",I)) Q:'I  D
 .S RACMB4=RACMB4_$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",I,0)),U)
 .Q
 Q
 ;
TRKCMA(DA,RATRKCMB,RATRKCMA,RACMDIF) ;Contrast Medium/Media is used with this
 ;procedure. Tracks the editing of this data. This subroutine saves
 ;off the 'before' values.
 ; input: DA=IEN of the Rad/Nuc Med Procedure record
 ;        RATRKCMB=CM definitions for this procedure before edit
 ;return: RATRKCMA=CM definitions for this procedure after edit
 ;        RACMDIF=if before & after CM values differ, set to 1 else 0
 N I,J S (I,RACMDIF)=0,RATRKCMA=""
 F  S I=$O(^RAMIS(71,DA,"CM",I)) Q:'I  D
 .S RATRKCMA=RATRKCMA_$P($G(^RAMIS(71,DA,"CM",I,0)),U)
 .Q
 ;
 ;If the before & after values are null, no CM definitions exist.
 I $L(RATRKCMB)=0,$L(RATRKCMA)=0 S RACMDIF=0 Q
 ;
 ;If the before value is null and the after value is not null file
 ;the after value
 I $L(RATRKCMB)=0,($L(RATRKCMA)>0) D  Q
 .S RACMDIF=1 D FILEAU^RAMAINU1(DA,RATRKCMA)
 .Q
 ;
 ;If the before value is not null and the after value is null file
 ;the after value (indicates that CM data has been deleted)
 I $L(RATRKCMB)>0,($L(RATRKCMA)=0) D  Q
 .S RACMDIF=1 D FILEAU^RAMAINU1(DA,RATRKCMA)
 .Q
 ;
 ;If the before and after values are non-null and the number of
 ;characters differ between strings, store the after value and exit.
 I $L(RATRKCMB)'=$L(RATRKCMA) S RACMDIF=1 D FILEAU^RAMAINU1(DA,RATRKCMA) Q
 ;
 ;If the before and after values have definition (non-null) and are of
 ;the same length, check to see if they have the same characters in
 ;their respective strings (character position not important). Only if
 ;characters differ between the two strings do we file the after data.
 F I=1:1:$L(RATRKCMB) D  Q:RACMDIF
 .S J=$E(RATRKCMB,I) S:RATRKCMA'[J RACMDIF=1
 .Q
 D:RACMDIF FILEAU^RAMAINU1(DA,RATRKCMA)
 Q
 ;
TRK70CMA(RADFN,RADTI,RACNI,RATRKCMB) ;Contrast Medium/Media is used with
 ;this exam.
 ;Tracks the editing of this data. This subroutine saves off the
 ;'before' values.
 ;input: RADFN=DFN of the Rad/Nuc Med patient (file 2)
 ;       RADTI=exam date/time (inverse)
 ;       RACNI=ien of exam record (examinations sub-file 70.03)
 ;       RATRKCMB=the before contrast media definition
 N I,J,K S (I,K)=0,RATRKCMA=""
 F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",I)) Q:'I  D
 .S RATRKCMA=RATRKCMA_$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",I,0)),U)
 .Q
 ;
 ;If the before & after values are null, no CM definitions exist.
 I $L(RATRKCMB)=0,$L(RATRKCMA)=0 Q
 ;
 ;If the before value is null and the after value is not null file
 ;the after value
 I $L(RATRKCMB)=0,($L(RATRKCMA)>0) D AUD70^RAMAINU1(RADFN,RADTI,RACNI,RATRKCMA) Q
 ;
 ;If the before value is not null and the after value is null file
 ;the after value (indicates that CM data has been deleted)
 I $L(RATRKCMB)>0,($L(RATRKCMA)=0) D AUD70^RAMAINU1(RADFN,RADTI,RACNI,RATRKCMA) Q
 ;
 ;If the before and after values are non-null and the number of
 ;characters differ between strings, store the after value and exit.
 I $L(RATRKCMB)'=$L(RATRKCMA) D AUD70^RAMAINU1(RADFN,RADTI,RACNI,RATRKCMA) Q
 ;
 ;If the before and after values have definition (non-null) and are of
 ;the same length, check to see if they have the same characters in
 ;their respective strings (character position not important). Only if
 ;characters differ between the two strings do we file the after data.
 F I=1:1:$L(RATRKCMB) D  Q:K
 .S J=$E(RATRKCMB,I) S:RATRKCMA'[J K=1
 .Q
 D:K AUD70^RAMAINU1(RADFN,RADTI,RACNI,RATRKCMA)
 Q
 ;
PRGCM(DA) ;Purge contrast media data related to an exam when the user
 ;answers 'No' to the 'CONTRAST MEDIA USED?' field (#10) prompt when
 ;'CONTRAST MEDIA USED?' is presented to the user by the 'RA EXAM EDIT'
 ;& 'RA STATUS CHANGE' input templates.
 ;
 ;input: DA=expressed as DA(2), DA(1), & DA IENs for file and sub-files
 ;returns: placeholder for input template
 ;
 I +$O(^RADPT(DA(2),"DT",DA(1),"P",DA,"CM",0)) D
 .W !?3,$C(7),"Deleting contrast media data associated with this exam.",!
 .K ^RADPT(DA(2),"DT",DA(1),"P",DA,"CM") ;'B' xrefs deleted too!
 .Q
 Q "@225"
 ;
UPXCM(DA,X) ;set the 'CONTRAST MEDIA USED?' (#10) field to 'No' if contrast
 ;media data is not associated with this exam.
 ;called from the 'RA EXAM EDIT' & 'RA STATUS CHANGE' input templates.
 ;
 ;input: DA=expressed as DA(2), DA(1), & DA IENs for file and sub-files
 ;        X='Y' for 'Yes', 'N' for 'No'
 ;
 K RASFM S RAIENS=DA_","_DA(1)_","_DA(2)_","
 S RASFM(70.03,RAIENS,10)=X D UPDATE^DIE("","RASFM","RAIENS")
 K RAIENS,RASFM
 Q
 ;
STUFCM70(DA,RAPRI) ;If the exam record indicates that a contrast medium
 ;or media was used, and the exam record does not identify the CM,
 ;assume the CM definition of the procedure and stuff the exam
 ;record (usually done initially while editing the exam record for the
 ;first time).
 ;
 ;Called from the following input templates:
 ; RA EXAM EDIT & RA STATUS CHANGE
 ;
 ;input: DA array; DA(2)-RADFN, DA(1)-RADTI, & DA-RACNI
 ;       RAPRI: IEN of the procedure being performed
 ;
 N I K RAD3,RAIENS,RASFM
 S I=0 F  S I=$O(^RAMIS(71,RAPRI,"CM",I)) Q:'I  D
 .S RAD3=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",$C(32)),-1)+1
 .S RAIENS="+"_RAD3_","_DA_","_DA(1)_","_DA(2)_","
 .S RASFM(70.3225,RAIENS,.01)=$P($G(^RAMIS(71,RAPRI,"CM",I,0)),U)
 .D UPDATE^DIE("","RASFM","RAD3") K RAD3,RAIENS,RASFM
 .Q
 Q
 ;
