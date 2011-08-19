DGACT ;ALB/CAW - Active check for facility TS or Specialty ; 7/27/94
 ;;5.3;Registration;**64,683,729**;Aug 13, 1993;Build 59
 ;
 ;
ACTIVE(FILE,IEN,DGDT) ; Extrinsic function to determine if TS entry is active
 ;
 ;     Input -- FILE to determine if checking facility TS or TS
 ;                  FACILITY TREATING SPECIALTY (45.7)
 ;                  SPECIALTY (42.4)
 ;          IEN is the internal IFN of whichever file passed in
 ;       DGDT as 'as of' date (uses DT if undefined)
 ;    Output -- 1 if active, 0 otherwise
 ;
 N DGID,Y,X
 S DGID=$S($G(DGDT):DGDT,1:DT)
 S DGID=$S('$P(DGID,".",2):(DGID)_.2359,1:(DGID)),DGID=-DGID
 S Y=0
 S ID=$O(^DIC(FILE,IEN,"E","ADATE",DGID)) G:'ID ACTIVEQ
 S ID=$O(^DIC(FILE,IEN,"E","ADATE",ID,0))
 S X=$G(^DIC(FILE,IEN,"E",ID,0)) I 'X G ACTIVEQ
 I $P(X,"^",2)=1 S Y=1
ACTIVEQ Q $S(Y:1,1:0)
 ;
TSDATA(FILE,IEN,ARRAY,DGDT) ; Call to return TS data
 ;
 ;     Input -- FILE to determine if checking facility TS or TS
 ;                  FACILITY TREATING SPECIALTY (45.7)
 ;                  SPECIALTY (42.4)
 ;          IEN is the internal IFN of whichever file passed in
 ;       DGDT as 'as of' date (uses DT if undefined)
 ;    Output -- 1 if entry exists, -1 otherwise
 ;** Responsibility of calling routine to handle undefined array when -1
 ;       ARRAY(0) := 1 if active, 0 otherwise
 ;       If FILE=45.7
 ;         ARRAY(1) := Name
 ;         ARRAY(2) := Specialty ptr to 42.4 file^Specialty name
 ;         ARRAY(3) := Abbreviation
 ;         ARRAY(4) := Service ptr to 49 file^Service name
 ;       If FILE=42.4
 ;         ARRAY(1) := Name
 ;         ARRAY(2) := Print name
 ;         ARRAY(3) := Service (set value)^Service (set value) name
 ;         ARRAY(4) := Ask Psychiatric Question? (set value)^null/yes/no
 ;         ARRAY(5) := Billing Rate Bedsection^
 ;         ARRAY(6) := MPCR Account
 ;         ARRAY(7) := PTF Code (alpha-numeric)
 ;
 ;
 K ARRAY N DGI
 S FILE=$G(FILE),IEN=$G(IEN),DGDT=$G(DGDT)
 I '$D(^DIC(FILE,+$G(IEN),0)) Q -1
 I FILE=45.7 D
 . F DGI=0:1:4 S ARRAY(DGI)=""
 . S ARRAY(0)=$$ACTIVE(FILE,IEN,DGDT)
 . S ARRAY(1)=$$GET1^DIQ(45.7,IEN_",",.01)
 . S ARRAY(2)=$$GET1^DIQ(45.7,IEN_",",1,"I")_"^"_$$GET1^DIQ(45.7,IEN_",",1)
 . S ARRAY(3)=$$GET1^DIQ(45.7,IEN_",",99)
 . S ARRAY(4)=$$GET1^DIQ(45.7,IEN_",",2,"I")_"^"_$$GET1^DIQ(45.7,IEN_",",2)
 I FILE=42.4 D
 . F DGI=1:1:7 S ARRAY(DGI)=""
 . S ARRAY(0)=$$ACTIVE(FILE,IEN,DGDT)
 . S ARRAY(1)=$$GET1^DIQ(42.4,IEN_",",.01)
 . S ARRAY(2)=$$GET1^DIQ(42.4,IEN_",",1)
 . S ARRAY(3)=$$GET1^DIQ(42.4,IEN_",",3,"I")_"^"_$$GET1^DIQ(42.4,IEN_",",3)
 . S ARRAY(4)=$$GET1^DIQ(42.4,IEN_",",4,"I")_"^"_$$GET1^DIQ(42.4,IEN_",",4)
 . S ARRAY(5)=$$GET1^DIQ(42.4,IEN_",",5,"I")_"^"_$$GET1^DIQ(42.4,IEN_",",5)
 . S ARRAY(6)=$$GET1^DIQ(42.4,IEN_",",6)
 . S ARRAY(7)=$$GET1^DIQ(42.4,IEN_",",7)
TSDATAQ Q 1
