LRRPU ;DALOI/JMC - Interim Report Results Utility ; May 10, 2004 0900
 ;;5.2;LAB SERVICE;**286**;Sep 27, 1994
 ;
 ;
TSTRES(LRDFN,LRSS,LRIDT,LRDN,LR60,LRCODE) ; Test results and parameters
 ; Call with LRDFN = ien of entry in file #63
 ;            LRSS = subscript in file #63, currently only "CH" supported
 ;           LRIDT = inverse date/time of result
 ;            LRDN = ien of data name in "CH" subscript
 ;            LR60 = pointer to file 60 test related to this dataname (optional)
 ;          LRCODE = 1 - return NLT/LOINC codes (optional)
 ;
 ; Returns
 ;  LRY = result^normalcy flag^reference low^reference high^units^performing lab (file #4 ien)^therapeutic normal used (0=no/1=yes)^NLT order code;NLT name!NLT result code;NLT name!LOINC result code;LOINC name^performing user (DUZ)^EII
 ;
 N LRFLAG,LRNR,LRX,LRY,X,Y
 S LRX=$G(^LR(LRDFN,LRSS,LRIDT,LRDN))
 S LRY=$P(LRX,"^",1,2),$P(LRY,"^",7)=0
 I LRSS="CH",$$GET1^DID(63.04,LRDN,"","TYPE")="SET" D
 . S X=$$EXTERNAL^DILFD(63.04,LRDN,"",$P(LRY,"^"))
 . I X'="" S $P(LRY,"^")=X
 ;
 ; Check for units/ranges stored in file #63
 ; If flag (NPC>1) indicates units/ranges are stored but pieces 5-12
 ; are null then use values from file #60 - some class III software
 ; still does not store this info in file #63 when NPC>1.
 S LRFLAG=0,LRNR=$TR($P(LRX,"^",5),"!","^")
 I $G(^LR(LRDFN,LRSS,LRIDT,"NPC"))>1,$P(LRX,"^",5,12)'="" S LRFLAG=1
 ;
 I LRFLAG D
 . I $P(LRNR,"^",11)="",$P(LRNR,"^",12)="" S $P(LRY,"^",3,4)=$P(LRNR,"^",2,3)
 . E  S $P(LRY,"^",3,4)=$P(LRNR,"^",11,12),$P(LRY,"^",7)=1
 . S $P(LRY,"^",5)=$P(LRNR,"^",7)
 ;
 ; If no units/ranges (LRFLAG=0) then use file 60
 ; values to determine reference ranges
 ; If no therapeutic normals then return reference normals
 ; Need to handle age and sex in normals from file #60
 I 'LRFLAG D
 . N AGE,DOB,LR61,LRCDT,LRDPF,LRLO,LRHI,LRTLO,LRTHI,SEX,X
 . S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 . S X=$G(^LR(LRDFN,LRSS,LRIDT,0)),LRCDT=$P(X,"^"),LR61=+$P(X,"^",5)
 . S X=$$ROOT^DILFD(+LRDPF)
 . S SEX=$P($G(@(X_+DFN_",0)")),"^",2),DOB=$P($G(@(X_+DFN_",0)")),"^",3)
 . S AGE=$$CALCAGE(DOB,LRCDT)
 . I '$G(LR60) S LR60=+$O(^LAB(60,"C","CH;"_LRDN_";1",0))
 . S X=$G(^LAB(60,LR60,1,LR61,0)) Q:X=""
 . S $P(LRY,"^",5)=$P(X,"^",7)
 . S LRLO=$P(X,U,2),LRHI=$P(X,U,3),LRTLO=$P(X,U,11),LRTHI=$P(X,U,12)
 . I LRTLO="",LRTHI="" D  Q
 . . I LRLO'="" S @("LRLO="_LRLO)
 . . I LRHI'="" S @("LRHI="_LRHI)
 . . S $P(LRY,"^",3)=LRLO,$P(LRY,"^",4)=LRHI
 . I LRTLO'="" S @("LRTLO="_LRTLO)
 . I LRTHI'="" S @("LRTHI="_LRTHI)
 . S $P(LRY,"^",3)=LRTLO,$P(LRY,"^",4)=LRTHI,$P(LRY,"^",7)=1
 ;
 ; Remove leading/trailing quotes from normals.
 I $P(LRY,"^",3)[$C(34) S $P(LRY,"^",3)=$$TRIM^XLFSTR($P(LRY,"^",3),"LR",$C(34))
 I $P(LRY,"^",4)[$C(34) S $P(LRY,"^",4)=$$TRIM^XLFSTR($P(LRY,"^",4),"LR",$C(34))
 ; Performing laboratory
 S $P(LRY,"^",6)=$P(LRX,"^",9)
 ;
 ; Return NLT/LOINC codes
 I $G(LRCODE)=1 D
 . N LR64
 . S X=$P($P(LRX,"^",3),"!",1,3)
 . F I=1,2 I $P(X,"!",I)'="" D
 . . S LR64=$O(^LAM("E",$P(X,"!",I),0)),Y=""
 . . I LR64 S Y=$$GET1^DIQ(64,LR64_",",.01,"I")
 . . I Y'="",Y["!" S Y=$TR(Y,"!","*")
 . . S $P(X,"!",I)=$P(X,"!",I)_";"_Y
 . I $P(X,"!",3)'="" D
 . . S Y=$$GET1^DIQ(95.3,$P(X,"!",3)_",",.01)
 . . S Y(0)=$$GET1^DIQ(95.3,$P(X,"!",3)_",",80)
 . . I Y(0)["!" S Y(0)=$TR(Y(0),"!","*")
 . . S $P(X,"!",3)=Y_";"_Y(0)
 . S $P(LRY,"^",8)=X
 ;
 ; Performing user
 S $P(LRY,"^",9)=$P(LRX,"^",4)
 ; EII - Equipment instance Identifier
 S $P(LRY,"^",10)=$P(LRX,"^",11)
 ;
 Q LRY
 ;
 ;
CALCAGE(DOB,LRCDT) ; Calculate age based on difference between DOB and collection date.
 ;
 ; Call with DOB = patient date of birth
 ;         LRCDT = specimen collection date
 ;
 ; Returns   AGE = patient's age in years at time of specimen collection
 ;
 I $T(DATE^LRDAGE)'="" Q $$DATE^LRDAGE(DOB,LRCDT)
 ;
 S AGE=99
 I DOB>2000000,LRCDT>2000000,DOB'>LRCDT S X=$$FMDIFF^XLFDT(LRCDT,DOB,1),AGE=X\365.25
 Q AGE
