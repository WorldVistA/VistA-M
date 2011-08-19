EASWTAPI ; ALB/SCK - ENROLLMENT DATE API - ; 7-12-2002
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**17**;MAR 15, 2001
 ;
ENROLL(DFN) ; Find enrollement date for patient
 ; Input
 ;    DFN - IEN of the patient file
 ;
 ; Output
 ;    0 -  If an enrollment date cannot be determined
 ;    1^IEN^date^type - If an enrollment date can be determined
 ;
 ;    1    - Flag that an enrollment date was determined
 ;    IEN  - IEN of the PATIENT ENROLLMENT File entry returned
 ;    date - Date in FileMan internal format
 ;    type - "E" for an ENROLLMENT DATE
 ;           "A" for an ENROLLMENT APPLICATION DATE
 ;
 N RSLT,EAIEN,EAIEN1,EAX,DONE,EAVER,EASTAT,EANODE
 ;
 S RSLT=0
 S DFN=$G(DFN) I 'DFN Q RSLT
 I '$D(^DPT(DFN,0)) Q RSLT
 ;
 ;; Retrieve last enrollment record for patient
 S EAIEN="Z",EAIEN=$O(^DGEN(27.11,"C",DFN,EAIEN),-1)
 I 'EAIEN Q RSLT
 ;; If last enrollment record is Cancel/Decline, return 0
 I $$GET1^DIQ(27.11,EAIEN,.04,"I")=7 Q $G(RSLT)
 ;
 S RSLT=$$VERIFY(EAIEN)
 I 'RSLT S RSLT=$$UNVERIFY(EAIEN)
 Q RSLT
 ;
VERIFY(EAIEN) ; Find latest verified record
 N EAX,EANODE,EAVER,RSLT,DONE
 ;
 S EANODE=EAIEN_"~"_$G(^DGEN(27.11,EAIEN,0))
 S RSLT=0
 S EAVER=$$SEARCH(EANODE,2)
 I +$P($G(EAVER),"~",1)>0 D
 . S RSLT="1^"_$P(EAVER,"~",1)_U_$P(EAVER,U,10)_"^E"
 Q RSLT
 ;
UNVERIFY(EAIEN) ; Find an un-verified record 
 N EAX,EANODE,EAUNV,RSLT,DONE
 ;
 S RSLT=0
 S EANODE=EAIEN_"~"_$G(^DGEN(27.11,EAIEN,0))
 S EAUNV=$$SEARCH(EANODE,1)
 I +$P($G(EAUNV),"~",1)>0 D
 . S RSLT="1^"_$P(EAUNV,"~",1)_U_$P($P(EAUNV,"~",2),U,1)_"^A"
 Q RSLT
 ;
SEARCH(EANODE,STAT) ;  Search for enrollment record
 N EACUR,DONE,EAX,EAIEN
 ;
 I $P(EANODE,U,4)=STAT S EACUR=EANODE
 F EAX=1:1 D  Q:$G(DONE)
 . S EAIEN=$P(EANODE,U,9)
 . I 'EAIEN S DONE=1 Q
 . S EANODE=$G(^DGEN(27.11,EAIEN,0))
 . I $P(EANODE,U,4)=STAT S EACUR=EAIEN_"~"_$G(^DGEN(27.11,EAIEN,0))
 . I $P(EANODE,U,4)=7 S DONE=1
 Q $G(EACUR)
 ;
CHECK(DFN) ;
 N EAX,EAIEN,EANODE,DONE
 ;
 S DFN=$G(DFN) I 'DFN Q
 Q:'$D(^DPT(DFN,0))
 ;
 S EAIEN="Z"
 S EAIEN=$O(^DGEN(27.11,"C",DFN,EAIEN),-1)
 Q:'EAIEN
 S EANODE=$G(^DGEN(27.11,EAIEN,0))
 W !,EAIEN_" | "_EANODE
 ;
 F EAX=1:1 D  Q:$G(DONE)
 . S EAIEN=$P(EANODE,U,9)
 . I 'EAIEN S DONE=1 Q
 . S EANODE=$G(^DGEN(27.11,EAIEN,0))
 . W !,EAIEN_" | "_EANODE
 Q
