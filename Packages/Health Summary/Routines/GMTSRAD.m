GMTSRAD ; SLC/JER,KER HIN/GJC - Radiology Request Status ; 08/27/2002
 ;;2.7;Health Summary;**14,28,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  3125  ^RADPT(
 ;   DBIA  3125  ^RADPT("AO"
 ;   DBIA   504  ^RAO(75.1
 ;   DBIA  2056  $$GET1^DIQ (file 72)
 ;   DBIA  2056  GETS^DIQ (file 70.03)
 ;   DBIA 10015  EN^DIQ1 (file 75.1)
 ;   DBIA 10104  $$LOW^XLFSTR
 ;                  
ENRAD ; Entry Point for HS only
 N MAX K ^TMP("GMTSRAD",$J)
 S MAX=$S(+$G(GMTSNDM)>0:GMTSNDM,1:99999)
 Q:'$D(^RAO(75.1,"AS",DFN))  D GET
 Q:'$D(^TMP("GMTSRAD",$J))  D LOOP
 K ^TMP("GMTSRAD",$J)
 Q
GET ; Extract radiology orders
 N DA,DIC,DIQ,DR,GMI,GMOUT,GMP,GMRDT,GMSTAT,GMPRC,GMSDT,GMDOC S GMI=0
 F  S GMI=$O(^RAO(75.1,"AS",DFN,GMI)) Q:+GMI'>0!+$G(GMOUT)  D
 . S DA=0 F  S DA=$O(^RAO(75.1,"AS",DFN,GMI,DA)) Q:+DA'>0!+$G(GMOUT)  D
 . . N GMORD
 . . S DIC="^RAO(75.1,",DIQ="GMORD(",DIQ(0)="IE",DR="2;5;14;16;23"
 . . D EN^DIQ1
 . . S GMRDT=$G(GMORD(75.1,DA,16,"I")),GMSTAT=$G(GMORD(75.1,DA,5,"E"))
 . . I $S(GMRDT>GMTSEND:1,GMRDT<GMTSBEG:1,1:0) Q
 . . S GMPRC=$G(GMORD(75.1,DA,2,"E")),GMP=$G(GMORD(75.1,DA,2,"I"))
 . . S GMSDT=$G(GMORD(75.1,DA,23,"I")),GMDOC=$E($G(GMORD(75.1,DA,14,"E")),1,14)
 . . I $L(GMPRC)>24 S GMPRC=$$WRAP^GMTSORC(GMPRC,24)
 . . S GMSTAT=$E($$LOW^XLFSTR(GMSTAT))
 . . S ^TMP("GMTSRAD",$J,9999999-GMRDT,DA,+GMP,0)=""
 . . S ^TMP("GMTSRAD",$J,9999999-GMRDT,DA,+GMP)=GMRDT_U_GMSTAT_U_GMPRC_U_GMSDT_U_GMDOC
 . . D REG(DA,GMP)
 Q
HDR ; Write column header
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Req DT",?11,"Status",?22,"Procedure",?48,"Scheduled DT",?66,"Provider",!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
LOOP ; Loops through ^TMP("GMTSRAD",$J,
 N GMCNT,GMI,GMORD,GMRDT,GMREC S (GMCNT,GMRDT)=0
 D HDR
 F  S GMRDT=$O(^TMP("GMTSRAD",$J,GMRDT)) Q:+GMRDT'>0!(GMCNT=MAX)  D
 . S GMORD=0
 . F  S GMORD=$O(^TMP("GMTSRAD",$J,GMRDT,GMORD)) Q:+GMORD'>0!(GMCNT=MAX)  D
 . . S GMI=0
 . . F  S GMI=$O(^TMP("GMTSRAD",$J,GMRDT,GMORD,GMI)) Q:+GMI'>0!(GMCNT=MAX)  D
 . . . S GMREC(0)=$G(^TMP("GMTSRAD",$J,GMRDT,GMORD,GMI,0))
 . . . S GMREC=$G(^TMP("GMTSRAD",$J,GMRDT,GMORD,GMI)),GMCNT=GMCNT+1 D WRT
 Q
WRT ; Write record
 N GMII,GMRDT1,GMSTAT,GMPRC,GMSDT,GMDOC,GMPRO,X
 S X=+GMREC D REGDT4^GMTSU S GMRDT1=X,GMSTAT=$P(GMREC,U,2)
 S GMPRC=$P(GMREC,U,3)
 S X=$P(GMREC,U,4) D REGDTM4^GMTSU S GMSDT=X,GMDOC=$P(GMREC,U,5)
 D CKP^GMTSUP Q:$D(GMTSQIT)  D
 . I GMTSNPG D HDR
 . W GMRDT1,?13,GMSTAT W:+$G(GMREC(0)) ?17,"Ord: "
 . W ?22,$P(GMPRC,"|"),?48,GMSDT,?66,GMDOC,!
 F GMII=2:1:$L(GMPRC,"|") D
 . D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR W ?22,$P(GMPRC,"|",GMII),!
 I +$G(GMREC(0)) D
 . D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 . S GMRCNT=0 W ?13,"Actual: "
 . F  S GMRCNT=$O(^TMP("GMTSRAD",$J,GMRDT,GMORD,GMI,GMRCNT)) Q:GMRCNT'>0  D
 .. S GMPRO=$G(^TMP("GMTSRAD",$J,GMRDT,GMORD,GMI,GMRCNT))
 .. D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,$P(GMPRO,"|"),!
 .. F GMII=2:1:$L(GMPRO,"|") D
 ... D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR W ?22,$P(GMPRO,"|",GMII),!
 ... Q
 .. Q
 . Q
 Q
 ;                  
REG(DA,GMP) ; Registered Order Parent/Differs
 ;                 
 ; If the order has been registered, check to see if the
 ; procedure ordered is a parent or if the ordered procedure
 ; differs from the registered procedure.
 ;                 
 ; Input: DA  -> ien of the order in file 75.1
 ;      : GMP -> ien of the ordered procedure
 Q:'$D(^RADPT("AO",DA))
 N GMCNI,GMDFN,GMDTI,GMREG,GMRCNT,GMY2 S GMRCNT=0
 S GMDFN=+$O(^RADPT("AO",DA,0)) Q:'GMDFN
 S GMDTI=+$O(^RADPT("AO",DA,GMDFN,0)) Q:'GMDTI
 S GMY2=$G(^RADPT(GMDFN,"DT",GMDTI,0))
 I '$P(GMY2,"^",5) D  Q
 . S GMCNI=+$O(^RADPT("AO",DA,GMDFN,GMDTI,0)) Q:GMCNI'>0
 . D REG1(DA,GMDFN,GMDTI,GMCNI,GMP)
 . Q
 S GMCNI=0
 F  S GMCNI=$O(^RADPT(GMDFN,"DT",GMDTI,"P",GMCNI)) Q:GMCNI'>0  D
 . D REG1(DA,GMDFN,GMDTI,GMCNI,GMP)
 . Q
 Q
 ;                  
REG1(DA,GMDFN,GMDTI,GMCNI,GMP) ; Registered Order Differs
 ;                    
 ; Check if the ordered procedure differs from
 ; the registered procedure.
 ;                         
 ; Input: DA    -> Order (75.1) ien
 ;        GMDFN -> ien of the patient
 ;        GMDTI -> inv. date/time of exam
 ;        GMCNI -> ien of each case
 ;        GMP   -> ien of the procedure for the order
 ;                     
 ; Sets: ^TMP("GMTSRAD",$J,inv Req Entered Date/Time,
 ;       order ien,proc ien,
 ;                   
 ;            0)=1 if one of the following conditions exist:
 ;            1) the procedure ordered is not the procedure
 ;               registered (exam not cancelled)
 ;            2) the ordered procedure is a parent and the
 ;               descendent procedure(s) have been registered
 ;               (exam not cancelled)
 ;                   
 ; Sets: ^TMP("GMTSRAD",$J,inv Req Entered Date/Time,
 ;       order ien,proc ien,seq #)=Registered Procedure
 N GMIEN,GMPRO,GMREG S GMRCNT=GMRCNT+1
 S GMIEN=GMCNI_","_GMDTI_","_GMDFN_","
 D GETS^DIQ(70.03,GMIEN,"2;3","IE","GMREG")
 S GMPRO=GMREG(70.03,GMIEN,2,"E")
 Q:GMPRO=""
 Q:GMREG(70.03,GMIEN,3,"I")=""
 Q:$$GET1^DIQ(72,GMREG(70.03,GMIEN,3,"I"),3,"I")=0
 Q:GMP=GMREG(70.03,GMIEN,2,"I")
 S ^TMP("GMTSRAD",$J,9999999-GMRDT,DA,+GMP,0)=1
 S:$L(GMPRO)>24 GMPRO=$$WRAP^GMTSORC(GMPRO,24)
 S ^TMP("GMTSRAD",$J,9999999-GMRDT,DA,+GMP,GMRCNT)=GMPRO
 Q
