RAPCE1 ;HIRMFO/GJC-Interface with PCE APIs for workload, visits;6/4/96  15:03 ;5/28/97  12:59
 ;;5.0;Radiology/Nuclear Medicine;**17,21**;Mar 16, 1998
 Q
UNCOMPL(RADFN,RADTI,RACNI) ; When an exam backs out of a complete status
 ;back out all credit, visit pointers for all rad exams on this d/t
 ;and re-credit any complete ones that are not part of exam sets.
 ;
 ; Input Variables: RADFN=Patient DFN
 ;                  RADTI=Inv. date/time of exam
 ;
 ; $$DELVFILE^PXAPI returns: 1 if no errors, -4 if transaction OK but
 ;                  visit rec still there, else error condition
 ;
 N RA7002,RA7003,RARECMPL,RAVSIT,RAXAMSET,RALCKFAL,RAEARRY
 K ^TMP("RAPXAPI",$J)
 S RALCKFAL=0 ; need define this due its being used in RAPCE
 ; RARECMPL (re-complete), if set, is used to suppress displaying msgs
 S RA7002=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RAXAMSET=+$P(RA7002,"^",5)
 S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ;If this case has no visit ptr, whether it is within a set or not,
 ; quit because crediting never took place (exam set crediting is
 ; on an "all or nothing" basis)
 S RAVSIT=$P(RA7003,U,27) I 'RAVSIT Q
 S RAPKG=+$O(^DIC(9.4,"B","RADIOLOGY/NUCLEAR MEDICINE",0))
 S RADTE=9999999.9999-RADTI
 S RA791=$G(^RA(79.1,+$P(RA7002,"^",4),0))
 S RAEARRY="RAERROR" N @RAEARRY
 D DELVST
 K ^TMP("RAPXAPI",$J)
 Q
DELVST ; Delete all Rad/Nuc Med pkg data from
 ; Visit file, other V-files for exam date/time
 ; lock at DT level due re-crediting all prev cmpltd exms for same dt/tm
 ; also, lock before deleting entire visit, in case can't delete
 ;     cl.stp.rec and visit pointers from locked record
 L +^RADPT(RADFN,"DT",RADTI):30 I '$T S RALCKFAL=3 D FAILBUL^RAPCE2(RADFN,RADTI,RACNI,$S($G(RADUZ):RADUZ,1:DUZ)) W !?5,"Credit cannot be deleted for this exam due to lock failure for this exam date." Q
 ; quit if lock fails at DT level
 D DELVPTR(RADFN,RADTI)
 S RASULT=$$DELVFILE^PXAPI("ALL",RAVSIT,RAPKG,"",0,0,0)
 I RASULT=1!(RASULT=-4) D
 . D MULCS(RADFN,RADTI)
 . W:'$D(ZTQUEUED)&('$D(RADUPRC)) !,"Credit deleted for this Visit."
 . Q:RAXAMSET
 .;non-exmsets: re-credit cmplt'd cases of same dt/tm via exmset logic
 .; set var RAXAMSET to 1 to use code that credits all exms in same dt/tm
 . S RAXAMSET=1 N RA71,RACNT,RABAD,RACNT,RASTAT S RACNT=0,RARECMPL=1 K RAVSIT D EN2^RAPCE
 . Q
 L -^RADPT(RADFN,"DT",RADTI)
 Q
DELVPTR(RADFN,RADTI) ; each case in this exmset: del case ptrs to Visit file
 ; (subfile: 70.03 Field #: 27) ;visit ptr fld
 N RACNI,RADA1 S RACNI=0
 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D
 . S RADA1(70.03,RACNI_","_RADTI_","_RADFN_",",27)="@"
 . D FILE^DIE("K","RADA1")
 . K RADA1 ; clear var before reuse, incase filing problem met
 Q
MULCS(RADFN,RADTI) ; Clear the 'Clinic Stop Recorded?' field for ea case
 ; in this exam set
 ; (subfile: 70.03 Field #: 23) ;credit recorded fld
 N RACNI,RADA2 S RACNI=0
 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D
 . S RADA2(70.03,RACNI_","_RADTI_","_RADFN_",",23)="@"
 . D FILE^DIE("K","RADA2")
 . K RADA2 ; clear var before reuse, incase filing problem met
 . Q
 Q
REPNT(RADFN,RADTI) ; Repopulate the visit field
 N RAFDA S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",27)=RAVSIT
 D FILE^DIE("K","RAFDA")
 Q
CKDUP ; are there more than one procedure of same name ?
 ; return 0 if 1 or fewer completed procedure of the same name/dt/tm
 ; return 1 if more than 1 completed procedure of the same name/dt/tm
 ;             as this case
 ; RAX(raprcien) = no. cases with this procedure ien
 S RADUPRC=0
 I '$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)),'$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI),-1) Q  ;only 1 case for this dt/tm
 N I,J,K,RAX,RAPRCIEN
 S I=0,RAPRCIEN=+$P(RA7003,U,2)
C1 S I=$O(^RADPT(RADFN,"DT",RADTI,"P",I)) G:I'=+I C9
 S J=$P(^(I,0),U,2),K=$P(^(0),U,3) ; J = proc ien, K = status ien
 G:$P($G(^RA(72,+K,0)),U,3)'=9 C1 ; skip if ordercode is not 9
 S RACOMIEN(I)="" ; save ien of completed cases for use in RESEND
 S:J RAX(J)=$G(RAX(J))+1
 G C1
C9 Q:$G(RAX(RAPRCIEN))<2
 S RADUPRC=1 ; more than one completed case has the same procedure for this dt/tm
 Q
RESEND ; del and resend this dt/tm
 ; delete what was previously sent to PCE
 ; need to lock before finding RAVSIT because another case with same
 ;    patient/procedure/dt/tm may be setting up the visit pointer
 ;    for the first time for this dt/tm, at this moment
 L +^RADPT(RADFN,"DT",RADTI):30 I '$T S RALCKFAL=2 D FAILBUL^RAPCE2(RADFN,RADTI,RACNI,$S($G(RADUZ):RADUZ,1:DUZ)) Q  ;quit resend if DT-level lock failed
 N I
 S I=0 ; find visit pointer from first complted case's non-null visit fld
D1 S I=$O(RACOMIEN(I)) G:I'=+I D9
 G:$P(^RADPT(RADFN,"DT",RADTI,"P",I,0),U,27)="" D1
 S RAVSIT=$P(^(0),U,27)
D9 I $G(RAVSIT)="" G DUNL ; no valid vst ptr to delete
 D DELVST
 W:$G(RASENT)&('$D(ZTQUEUED)) !?5,"Visit credited for duplicate procedure."
DUNL L -^RADPT(RADFN,"DT",RADTI)
 Q
