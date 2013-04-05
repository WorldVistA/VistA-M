LRMIAUD ;DALISC/RBN - Micro Audit/Alert System ;July 22, 2008
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; This routine is a shell to fit into the
 ; proposed framework for LR*5.2*216
 ;
 ; NOTE: All Auditing routines assume that the caller already has the appropriate global lock(s) before entry.
 ;        L +^LR(LRDFN,"MI",LRIDT)
 ; 
 ; ^LR data that is temporarily changed should all be changed in one spot.  Also an error trap should be setup
 ; so the changed data can be restored if an error happens between changing the data and restoring the data
 ;
 Q
 ;
 ;
LEDI(IN) ;
 ; This entry point is specifically for using the audit log with LDSI/LEDI lab results received via HL7 from a host lab.
 ; 
 ; Input
 ;   IN : <byref><opt>  Pass info to Audit trail
 ;      : IN(63.539,3) = #63.539 field #3 (dflt=1)
 ;      : IN(63.539,4) = #63.539 field #4 (dflt=UPDATED BY HOST)
 ; Output : Returns the IEN of the new #63.539 entry
 ;
 N X,LRNOW,LRAUDTMP,LREDT,LR63539,DATA,ZDUZP
 ;
 Q:$G(LRSB)'>0 0
 I LRSB'=.99,'$D(^LR(LRDFN,"MI",LRIDT,LRSB)) Q 0
 ;
 S ZDUZP=$S(LRSB=1:4,LRSB=5:3,LRSB=8:4,LRSB=11:5,1:"")
 I LRSB'=.99 Q:'ZDUZP 0
 S (LREDT,LRNOW)=$$NOW^XLFDT
 ; logic from proposed MI audit trail should audit trail really be setting these fields since
 ; audit trail gets triggered even when data doesnt change?
 ;I ZDUZP D  ;
 ;. N LRDFA,LRIEN,LRMSG,DIERR,FLD,FLDS
 ;. I LRSB=1 S FLDS(11)=LRNOW S FLDS(11.55)=DUZ
 ;. I LRSB=5 S FLDS(14)=LRNOW S FLDS(15.5)=DUZ
 ;. I LRSB=8 S FLDS(18)=LRNOW S FLDS(19.5)=DUZ
 ;. I LRSB=11 S FLDS(22)=LRNOW S FLDS(25.5)=DUZ
 ;. Q:'$D(FLDS)
 ;. S LRIEN=LRIDT_","_LRDFN_","
 ;. S FLD=""
 ;. F  S FLD=$O(FLDS(FLD)) Q:FLD=""  D  ;
 ;. . S LRFDA(1,63.05,LRIEN,FLD)=FLDS(FLD)
 ;. Q:'$D(LRFDA)
 ;. D FILE^DIE("","LRFDA(1)","LRMSG")
 ;. ;original LR*216 proposed code was setting these
 ;. ;S $P(^LR(LRDFN,"MI",LRIDT,LRSB),U,1)=LRNOW
 ;. ;S $P(^LR(LRDFN,"MI",LRIDT,LRSB),U,ZDUZP)=DUZ
 ;
 K DATA
 S DATA(63.539,3)=$G(IN(63.539,3),1)
 S DATA(63.539,4)=$G(IN(63.539,4),"UPDATED BY HOST LAB VIA HL7")
 S LR63539=$$FILEAUD^LRMIAU1(.DATA)
 Q LR63539
