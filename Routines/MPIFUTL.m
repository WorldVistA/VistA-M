MPIFUTL ;BHM/RGY-CMOR Utilities ;FEB 26, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**11**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;
 ;  ^DGCN(391.91     IA #2751
 ;
TYPE ;Set type of CMOR request change
 NEW DIE,DR,DA
 S DIE="^RGSITE(991.8,",DR="[MPIF SITE PARAMETERS]",DA=1 D ^DIE
 Q
MAIL() ;Get mailgroup for new requests
 N IEN,MGROUP
 S IEN=$P($G(^RGSITE(991.8,1,0)),"^",3)
 Q:IEN="" "-1^No Mailgroup defined"
 S MGROUP=$$EXTERNAL^DILFD(991.8,.03,,IEN)
 Q:MGROUP="" "-1^No Mailgroup defined"
 Q MGROUP
CHK1(D0) ;Check out a new request for patient data
 NEW PAT,X,OPEN
 S OPEN=0
 S PAT=+$P($G(^MPIF(984.9,D0,0)),"^",4)
 I PAT=0 W !!,"*** Patient not defined for this request ***" Q 1
 I '$$PAT^MPIFNQ(PAT) W !!,"*** Patient has not been assigned a CMOR Site ***",! Q 1
 F X=0:0 S X=$O(^MPIF(984.9,"C",PAT,X)) Q:'X  D:X'=D0  Q:OPEN
 .I $P(^MPIF(984.9,X,0),"^",6)'=4,$P(^(0),"^",6)'=5 S OPEN=X
 I OPEN W !,"*** Patient already has an open request (",$P(^MPIF(984.9,OPEN,0),"^"),") ***" Q 1
 Q 0
 ;
CHK2(D0) ;Check out a new requeste for site
 I $P(^MPIF(984.9,D0,0),"^",7)="" W !!,"*** You must enter a site to send this request to ***" Q 1
 I $P(^MPIF(984.9,D0,0),"^",7)=+$$SITE^VASITE() W !!,"*** You cannot send a request to your own site ***" Q 1
 N SITE,PT
 S SITE=$P(^MPIF(984.9,D0,0),"^",7),PT=$P(^MPIF(984.9,D0,0),"^",4)
 I '$D(^DGCN(391.91,"APAT",PT,SITE)) W !!,"*** You cannot send a request to a site that isn't a treating facility for this patient ***" Q 1
 Q 0
 ;
CCRDAT(PAT,ARR) ; API to return all known CMOR Change Request Information
 ; PAT - DFN of patient in Patient file (#2)
 ; ARR - Array to return information.  First subscript will be request number, next will be the field number.  field 9999 will be the display text
 ; ARR(0) will equal -1 eror message if there was a problem or no data found.  If data is found, ARR(0) will equal the number of requests found.
 ;
 I '$D(PAT)!('$D(ARR)) Q
 I $O(^MPIF(984.9,"C",PAT,""))="" S @ARR@(0)="-1^No Requests on File" Q
 N SITE,IEN,MPIFA,CNT,IENT,TEXT,REQN
 S IEN=0,CNT=0
 F  S IEN=$O(^MPIF(984.9,"C",PAT,IEN)) Q:IEN=""  D
 .I '$D(^MPIF(984.9,IEN)) Q
 .D GETS^DIQ(984.9,IEN,".01;.02;.03;.04;.05;.06;.07;.08;.09;1.01;1.02;1.03;2.01;2.02;2.03;3.01;3.02","","MPIFA")
 .S IENT=IEN_","
 .Q:MPIFA(984.9,IENT,.01)=""
 .S CNT=CNT+1
 .S REQN=MPIFA(984.9,IENT,.01)
 .M @ARR@(REQN)=MPIFA(984.9,IENT)
 .N SIEN S SIEN=$P(^MPIF(984.9,IEN,0),"^",7)
 .N STN I SIEN'="" S STN=$P($$NS^XUAF4(SIEN),"^",2)
 .N SIEN2 S SIEN2=$P(^MPIF(984.9,IEN,0),"^",9)
 .N STN2 I SIEN2'="" S STN2=$P($$NS^XUAF4(SIEN2),"^",2)
 .S TEXT=@ARR@(REQN,1.03)_" "_@ARR@(REQN,.07)_" (#"_$G(STN)_") to change CMOR to "_@ARR@(REQN,.09)_" (#"_$G(STN2)_")."
 .S @ARR@(REQN,999)=TEXT
 S @ARR@(0)=CNT
 Q
