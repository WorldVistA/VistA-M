LRBLAUD ;TOG/CYM  -  AUDIT TRAIL MULTIPLE FIELDS  9/3/97  14:32
 ;;5.2;LAB SERVICE;**90,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
 ;
 ;  Routine is called by file 65 edit template LRBLIXR
 ;
 ;  Multiple field arrays are built and totaled before and after
 ;  editing LRBLIXR to be used for comparison. If total after editing
 ;  is less than before editing, then the entire node is put onto
 ;  the Audit trail for Blood Bank.
 ;
REL ;  Gets original relocation episodes for a unit, sets into the
 ;  BEGR() array and counts total for later comparison
 S (REL,BEGREL)=0
 F  S REL=$O(^LRD(65,LRIEN,3,REL)) Q:REL'>0  S BEGREL=BEGREL+1,BEGR(REL)=^LRD(65,LRIEN,3,REL,0)
 Q
 ;
REL1 ;  Gets relocation episodes for unit after editing, sets into AFTR()
 ;  array, counts total. If total after edit < original total, then
 ;  entire deleted record is built onto the audit trail
 S (REL,AFTREL)=0
 F  S REL=$O(^LRD(65,LRIEN,3,REL)) Q:REL'>0  S AFTREL=AFTREL+1,AFTR(REL)=^LRD(65,LRIEN,3,REL,0)
 I AFTREL<BEGREL D
 . S LRM=NODE
 . S O=$P(LRM,U),Z="65.03,.01" D AUDIT
 . S O=$P(LRM,U,2),Z="65.03,.02" D AUDIT
 . S O=$P(LRM,U,3),Z="65.03,.03" D AUDIT
 . S O=$P(LRM,U,4),Z="65.03,.04" D AUDIT
 . S O=$P(LRM,U,5),Z="65.03,.05" D AUDIT
 . S O=$P(LRM,U,6),Z="65.03,.06" D AUDIT
 . S O=$P(LRM,U,7),Z="65.03,.07" D AUDIT
 . K NODE
 Q
 ;
PAT ;  Gets all unit's Patient Xmatched/Assigned episodes, sets into
 ;  the BEGP() array & counts total for later comparison
 S (BEGPAT,PAT)=0
 F  S PAT=$O(^LRD(65,LRIEN,2,PAT)) Q:PAT'>0  S BEGPAT=BEGPAT+1,BEGP(PAT)=^LRD(65,LRIEN,2,PAT,0)
 Q
 ;
PAT1 ;  Gets all Patients Xmatched/Assigned for a unit after editing and
 ;  puts into AFTP() array.  If total after editing < original total
 ;  then the deleted patient Xmatched/Assigned node is built onto the
 ;  audit trail.  The input template then call line BLD3 to get the
 ;  associated Blood Sample date/time multiple & include this on the
 ;  audit trail also.
 S (PAT,AFTPAT)=0
 F  S PAT=$O(^LRD(65,LRIEN,2,PAT)) Q:PAT'>0  S AFTPAT=AFTPAT+1,AFTP(PAT)=^LRD(65,LRIEN,2,PAT,0)
 I AFTPAT<BEGPAT D
 . S LRM=PNODE
 . S O=$P(LRM,U),Z="65.01,.01" D AUDIT
 . S O=$P(LRM,U,2),Z="65.01,.02" D AUDIT
 I AFTPAT<BEGPAT D BLD4
 Q
 ;
BLD ;  Gets all original blood samples for a patient, sets into the
 ;  BEGB() array and counts total for later comparison
 S (BLD,BEGBLD)=0
 F  S BLD=$O(^LRD(65,LRIEN,2,LRDFN,1,BLD)) Q:BLD'>0  S BEGBLD=BEGBLD+1,BEGB(BLD)=^LRD(65,LRIEN,2,LRDFN,1,BLD,0)
 Q
 ;
BLD1 ;  Gets patient blood samples after editing, set into AFTB() array,
 ;  counts total.  If total after editing < original total, then the
 ;  deleted node is built onto the audit trail.
 S (BLD,AFTBLD)=0
 F  S BLD=$O(^LRD(65,LRIEN,2,LRDFN,1,BLD)) Q:BLD'>0  S AFTBLD=AFTBLD+1,AFTB(BLD)=^LRD(65,LRIEN,2,LRDFN,1,BLD,0)
 Q:'$D(BEGBLD)  I AFTBLD<BEGBLD D BLD2 Q
 Q
BLD2 ;  Actual code that puts the Blood Sample Date/Time subfields
 ;  into the audit trail.
 S LRM=BNODE
 S O=$P(LRM,U),Z="65.02,.01" D AUDIT
 S O=$P(LRM,U,2),Z="65.02,.02" D AUDIT
 S O=$P(LRM,U,3),Z="65.02,.03" D AUDIT
 S O=$P(LRM,U,4),Z="65.02,.04" D AUDIT
 S O=$P(LRM,U,5),Z="65.02,.05" D AUDIT
 S O=$P(LRM,U,7),Z="65.02,.07" D AUDIT
 S O=$P(LRM,U,8),Z="65.02,.08" D AUDIT
 S O=$P(LRM,U,9),Z="65.02,.09" D AUDIT
 S O=$P(LRM,U,10),Z="65.02,.1" D AUDIT
 Q
 ;
BLD3 ;  Gets all Blood Sample date/time assigned to a particular 
 ;  LRDFN, sets into BEGB1() array, counts total.  This is so 
 ;  that the audit trail is built for this submultiple node
 ;  in the case that the entire Patient Xmatched/Assigned node
 ;  is deleted.
 S (BLD1,BEGBLD1)=0
 F  S BLD1=$O(^LRD(65,LRIEN,2,LRDFN,1,BLD1)) Q:BLD1'>0  S BEGB1(BLD1)=^LRD(65,LRIEN,2,LRDFN,1,BLD1,0),BEGBLD1=BEGBLD1+1
 Q
 ;
BLD4 ;  If a Patients Xmatched/Assigned entry has been deleted, adds
 ;  adds any Blood Sample Date/time entries for that deleted
 ;  patient to the audit trail.
 I '$D(BEGB1) Q
 F BLD1=0:0 S BLD1=$O(BEGB1(BLD1)) Q:'BLD1  S BNODE=BEGB1(BLD1) D BLD2
 Q
 ;
AUDIT I O]"" S X="Deleted" D EN^LRUD
 Q
 ;
K ; Kills variables created during editing of a disposition
 K LRDISP,LRDSP,LRDIST,LRPERS,LRPTRANS,LRDIPD,LRPTR,LRPHYS,LRTS,LRREC,LRREACT,LRPROVN,LRTSNUM,LRRXTYPE,LRPTREC,LRTRDT,LRCOMP,LRCOMPID,LRENTP,LRUNABO,LRUNRH,LRPOOL,LRRECRX,LROLD,LRVOL,LRTYPE
 Q
 ;
CHECK I O'=X D EN^LRUD
 Q
