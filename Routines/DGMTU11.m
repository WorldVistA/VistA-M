DGMTU11 ;ALB/MIR,TDM,GTS - Patient Relation Retrieval Utilities ; 10/30/06
 ;;5.3;Registration;**33,45,182,311,688**;Aug 13, 1993;Build 29
 ;
 ;
 ;=======================================================================
 ; The following utilities will obtain data from the PATIENT RELATION
 ; file
 ;=======================================================================
 ;
 ;
GETREL(DFN,DGTYPE,DGDT,DGMT) ; Get all active dependents for a patient
 ;
 ;     Input -- DFN as the IEN of file 2 (for the patient)
 ;              DGTYPE containing the letters V, S, C, or D representing
 ;                     the type of dependents returned
 ;                     (C and D should be mutually exclusive)
 ;              DGDT [optional] as active date...DT if not  defined
 ;                   if no month/day, checks entire year/month
 ;              DGMT [optional] IFN of means test
 ;    Output -- DGREL("V") = veteran reference
 ;              DGREL("S") = spouse reference
 ;              DGREL("C",counter) = child reference (only MT dep)
 ;              DGREL("D",counter) = dependent reference (all deps)
 ;              reference=IFN of 408.12^dep file ref
 ;              DGDEP = number of active dependents
 ;
 N CT,DGX,IFN,IEN,REF,X,DGCD K DGREL
 S (CT,IFN,IEN)=0,DGDT=$S($G(DGDT):DGDT,1:DT)
 D:$G(DGMT) RELINC  ;IFN of Means Test is supplied
 D:('$G(DGREL("V"))&(DGTYPE["V"))!('$G(DGMT)) RELFND ;No Means Test IFN or problem setting DGREL(V)
 D GETRELQ ; Increment the dependent count
 Q 
RELINC F  S IFN=$O(^DGMT(408.22,"AMT",DGMT,DFN,IFN)) Q:'IFN  D
 .S IEN=+$P($G(^DGMT(408.21,IFN,0)),"^",2),DGX=$G(^DGPR(408.12,IEN,0))
 .D SET
 Q
RELFND S IEN=0 F  S IEN=$O(^DGPR(408.12,"B",DFN,IEN)) Q:'IEN  S DGX=$G(^DGPR(408.12,IEN,0)) I $$ACTIVE(IEN,DGDT) D SET
 Q
GETRELQ S DGDEP=CT
 Q
 ;
 ;
SET ; set variables into array...first subscript is relation type, second
 ; is IEN of file 408.12 (patient relations file)
 ;
 N REF,TYPE
 S X=$P(DGX,"^",2),REF=$P(DGX,"^",3),TYPE=""
 I X=1,(DGTYPE["V") S TYPE="V"
 I X=2,(DGTYPE["S") S TYPE="S"
 I X>2,(X<7) S TYPE=$S(DGTYPE["D":"D",DGTYPE["C":"C",1:"")
 I X>6,(DGTYPE["D") S TYPE="D"
 I 'X!(TYPE']"") Q  ; not valid or not chosen
 I "VS"[TYPE,$D(DGREL(TYPE)) Q  ; take first self or spouse on file
 S REF=IEN_"^"_REF
 I "VS"[TYPE S DGREL(TYPE)=REF
 I "CD"[TYPE&('$G(DGCD(REF))) S CT=CT+1,DGREL(TYPE,CT)=REF,DGCD(REF)=CT
 Q
 ;
 ;
ACTIVE(IEN,DGDT) ; Extrinsic function to determine if 408.12 entry is active
 ;
 ;     Input -- IEN as internal entry number of pt relation file
 ;              DGDT as 'as of' date (uses DT if undefined)
 ;    Output -- 1 if active, 0 otherwise
 ;
 N DGFL,DGID,MIEN,DGNOM,DGNOY,ID,Y
 S DGID=$S($G(DGDT):DGDT,1:DT) I '$P(DGID,".",2) S $P(DGID,".",2)=2359
 S (DGFL,Y,DGNOM,DGNOY)=0
 S ID=DGID S:'$E(ID,4,5) ID=$E(ID,1,3)_99_$E(ID,6,99),DGNOM=1 I '$E(ID,6,7) S ID=$E(ID,1,5)_99_$E(ID,8,99),DGNOY=1 ;end of year or end of month if nothing passed
 S ID=-ID,DGID=-DGID
 F  S ID=$O(^DGPR(408.12,IEN,"E","AID",ID)) Q:'ID!DGFL!Y  S MIEN=$O(^(ID,0)) D
 . S X=$G(^DGPR(408.12,IEN,"E",MIEN,0)) I 'X Q
 . ;I 'DGNOY,'DGNOM S DGFL=1 S:$P(X,"^",2) Y=1 Q
 . I $P(X,"^",2)=1 S Y=1 Q
 . I ID>DGID S DGFL=1 ;quit...already before begin date
 Q $S(Y:1,1:0)
 ;
 ;
RESET(DFN,DGDT,DGMT) ;
 ; Sets 'NUMBER OF DEPENDENT CHILDREN' (#.13) and
 ;      'DEPENDENT CHILDREN' (#.08) in Income Relation File (#408.22)
 ;      based upon the count of active child dependents in Patient
 ;      Relation File (#408.12).
 ;
 ; IN:  DFN  - IEN of Patient File (#2)
 ;      DGDT - [optional] as 'as of' date
 ;      DGMT - [optional] means test IEN
 ; OUT: SETS (.08) & (.13) fields of (408.22)
 ;      No Formal Output
 ;
 N DGNODE,DGDEPYN,DGDEP,DGREL,DGX,PRIEN,SPOUSE
 S (CT,IEN,PRIEN,SPOUSE,DGDEP)=0,DGDT=$S($G(DGDT):DGDT,1:$$LYR^DGMTSCU1(DT))
 D GETREL(DFN,"VSD",DGDT,$G(DGMT)) S PRIEN=+$G(DGREL("V")),SPOUSE=$S($G(DGREL("S")):1,1:0)
 S DGX=$$IAI^DGMTU3(+PRIEN,($E(DGDT,1,3)_"0000"),$S($G(DGMT):$P($G(^DGMT(408.31,DGMT,0)),"^",19),1:1)) ;408.21 IEN
 S DGX=$O(^DGMT(408.22,"AIND",+DGX,0)) ;408.22 IEN
 S DGNODE=$G(^DGMT(408.22,+DGX,0)) I DGNODE']"" Q
 S DGDEPYN=$S(DGDEP:1,1:0)
 I $P(DGNODE,"^",13)'=DGDEP!($P(DGNODE,"^",8)'=DGDEPYN)!($P(DGNODE,"^",5)'=SPOUSE) D
 .S DIE="^DGMT(408.22,",DA=+DGX,DR=".13////^S X=DGDEP"_$S(+$P(DGNODE,"^",8)=DGDEPYN:"",1:";.08////^S X=DGDEPYN")_$S($P(DGNODE,"^",5)=SPOUSE:"",1:";.05////^S X=SPOUSE")
 .D ^DIE
 .K DR,DA,DIE,DIC,Y,X
 Q
 ;
GETINACD(DFN,DGREL) ; Get all INACTIVE dependents for a patient
 ;     Input -- DFN as the IEN of file 2 (for the patient)
 ;              DGREL as Array of active spouse/dependents
 ;    Output -- DGIREL("S",counter) = spouse reference
 ;              DGIREL("C",counter) = child reference
 N IEN,XCTR,TMPDGEL,XITYP,EDT,IFN,NODE
 K DGIREL
 Q:'$D(DGREL)
 S IEN=$P($G(DGREL("S")),U) S:IEN'="" TMPDGREL(IEN)=""
 S XCTR="" F  S XCTR=$O(DGREL("C",XCTR)) Q:XCTR=""  D
 . S IEN=$P(DGREL("C",XCTR),U) S:IEN'="" TMPDGREL(IEN)=""
 S IEN=0 F  S IEN=$O(^DGPR(408.12,"B",DFN,IEN)) Q:IEN=""  D
 . Q:($D(TMPDGREL(IEN)))!('$D(^DGPR(408.12,IEN,"E")))
 . S XITYP=$P($G(^DGPR(408.12,IEN,0)),U,2)
 . S XITYP=$S(XITYP=2:"S",((XITYP>2)&(XITYP<7)):"C",1:"") Q:XITYP=""
 . S EDT=$O(^DGPR(408.12,IEN,"E","AID","")) Q:EDT=""
 . S IFN=$O(^DGPR(408.12,IEN,"E","AID",EDT,"")) Q:IFN=""
 . Q:$P($G(^DGPR(408.12,IEN,"E",IFN,0)),U,2)   ;Don't want Active
 . S NODE=$G(^DGPR(408.12,IEN,0))
 . S DGIREL(XITYP,$O(DGIREL(XITYP,""),-1)+1)=IEN_U_$P(NODE,U,3)_U_(EDT*-1)
 Q
 ;
CNTDEPS(DFN) ;Count Dependent children
 ; DG*5.3*688 - EVC changes; GTS
 ; Called by DGDEP4 and DGRPEIS1
 ;
 ;INPUT:
 ;  DFN - Patient file IEN for MT Veteran
 ;OUTPUT:
 ;  Number of child dependents
 ;
 N IEN,DEPCNT,DGX
 S DEPCNT=0
 S IEN=0
 F  S IEN=$O(^DGPR(408.12,"B",DFN,IEN)) Q:'IEN  DO
 . S DGX=$G(^DGPR(408.12,IEN,0))
 . I ($P(DGX,U,2)>2),($P(DGX,U,2)<7) S DEPCNT=DEPCNT+1
 Q DEPCNT
