IBDF18E4 ;ALB/DHH - ENCOUNTER FORM - MISC INTERFACES utilities ;19-JUN-01
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**37**;APR 24, 1997
 ;
 ;-- this routine is to be called after PXCA is called in order to 
 ;   send additional information to other packages that PCE does not
 ;   send to currently
 ;
GAF ;send GAF information to Mental Health
 ;
 ;-- GAF information is filed with Mental Health only if the following
 ;   variables are set
 ;       -- DFN   = Patient IEN
 ;          SCORE = GAF Score
 ;          PROV  = Provider holding SD GAF SCORE security key
 ;          DATE  = Encounter Date/Time
 ;          VISIT = Inpatient or Outpatient Visit
 ;
 N DIG1,DIG2,DIG3,EPROV,SCORE,PROV,DATE,VISIT,X,DFN
 S (SCORE,PROV,DATE,VISIT)=""
 ;
 ; --if pxca (ibd gaf score col 3) exist the there should be 3
 ;   columns present to make the 3 character number
 ;
 I $D(PXCA("IBD GAF SCORE COL 3")) D
 . ;
 . S (DIG1,DIG2,DIG3)=""
 . ;
 . ; checking to see if column  3 is existing
 . ; column 1 and 2 are not required to make score
 . ;
 . Q:'$D(PXCA("IBD GAF SCORE COL 3"))
 . S EPROV="" F  S EPROV=$O(PXCA("IBD GAF SCORE COL 3",EPROV)) Q:EPROV=""  D
 .. ;
 .. S DIG1=$P($G(PXCA("IBD GAF SCORE COL 1",EPROV,+$O(PXCA("IBD GAF SCORE COL 1",EPROV,0)))),"^",1)
 .. S DIG2=$P($G(PXCA("IBD GAF SCORE COL 2",EPROV,+$O(PXCA("IBD GAF SCORE COL 2",EPROV,0)))),"^",1)
 .. S DIG3=$P($G(PXCA("IBD GAF SCORE COL 3",EPROV,+$O(PXCA("IBD GAF SCORE COL 3",EPROV,0)))),"^",1)
 .. S SCORE=DIG1_DIG2_DIG3
 .. ;
 .. ; -- score is required to be 1-100
 .. ;
 .. I SCORE>100 S SCORE=""
 .. S PXCA("IBD GAF SCORE COL 1",EPROV,1)=SCORE
 .. ;
 I $D(PXCA("IBD GAF SCORE COL 1")) D
 . S EPROV="" F  S EPROV=$O(PXCA("IBD GAF SCORE COL 1",EPROV)) Q:EPROV=""  D
 .. S SCORE=$P($G(PXCA("IBD GAF SCORE COL 1",EPROV,+$O(PXCA("IBD GAF SCORE COL 1",EPROV,0)))),"^")
 .. S PROV=$P($G(PXCA("IBD GAF SCORE PROVIDER",EPROV,+$O(PXCA("IBD GAF SCORE PROVIDER",EPROV,0)))),"^")
 .. S DFN=$P($G(PXCA("ENCOUNTER")),"^",2)
 .. S DATE=$P($G(PXCA("ENCOUNTER")),"^",14)
 .. S VISIT=$S($P($G(PXCA("ENCOUNTER")),"^",3)="W":"I",1:"O")
 .. ;
 .. ; do error check and file error quit if error
 .. ;   -- if any mandated information is missing file an error
 .. ;      in AICS' error log.
 .. ;
 .. I DFN="" D LOGERR^IBDF18E2(3570005,.FORMID) Q
 .. I SCORE>100!(SCORE<1) D LOGERR^IBDF18E2(3570005,.FORMID) Q
 .. I DATE="" D LOGERR^IBDF18E2(3570005,.FORMID) Q
 .. I PROV="" D LOGERR^IBDF18E2(3570005,.FORMID) Q
 .. I VISIT="" D LOGERR^IBDF18E2(3570005,.FORMID) Q
 .. D UPD^YSGAF(DFN,SCORE,DATE,PROV,VISIT)
 Q
