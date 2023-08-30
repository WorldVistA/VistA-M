RAO7CH ;HISC/FPT,GJC-Cancel/Hold request from Rad to OE/RR! ; Nov 08, 2022@12:47:01
 ;;5.0;Radiology/Nuclear Medicine;**18,196**;Mar 16, 1998;Build 1
 ;;last modification by SS JUN 19,2000 for P18
EN1(RAOIFN) ; 'RAOIFN' is the IEN in 75.1
 ; New vars & define the following variables: RAECH, RAECH array & RAHLFS
 N RA,RA0,RACTION,RAECH,RAHLFS,RANATURE,RAR,RAREASON,RATAB,RAVAR,RAVARBLE
 S RATAB=1 D EN1^RAO7UTL S RA0=$G(^RAO(75.1,RAOIFN,0)) Q:RA0']""
 S RACTION=$S(+$P(RA0,U,5)=1:"OD",1:"OH")
 S RAVAR="RATMP(",RAVARBLE="RATMP"
 ; msh
 S @(RAVAR_RATAB_")")=$$MSH^RAO7UTL("ORM^O01") ;P18 Event type
 ; pid
 S RATAB=RATAB+1
 S @(RAVAR_RATAB_")")=$$PID^RAO7UTL(RA0)
 ; orc
 I $D(RAOPT("CCR")),$G(RAORC)]"" S RAREASON=RAORC  ;p196 - special comment to CPRS for referred orders (from RAORDR1)
 E  S RAREASON=$P($G(^RA(75.2,+$P(RA0,U,10),0)),U) ;     - else set the normal reason
 S RANATURE=$P($G(^RA(75.2,+$P(RA0,U,10),0)),U,4) I '$L(RANATURE) S RANATURE=$S(RACTION="OH":"s",1:"x")
 S RA("ORC",16)=$$UP^XLFSTR(RANATURE)_RAECH(1)_$$EXTERNAL^DILFD(75.2,4,"",RANATURE)_RAECH(1)_"99ORN"_RAECH(1)_+$P(RA0,U,10)_RAECH(1)_RAREASON_RAECH(1)_"99RAR"
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")="ORC"_RAHLFS_RACTION_RAHLFS_$P(RA0,U,7)_RAECH(1)_"OR"_RAHLFS_RAOIFN_RAECH(1)_"RA"_$$STR^RAO7UTL(9)_$P(RA0,U,14)_$$STR^RAO7UTL(4)_RA("ORC",16)
 D SNDOERR
 Q
 ;
EN2(RAOIFN) ; Inform OE/RR that the Request Status has changed from
 ;         complete to some other value.
 ;         New vars & define the following variables: RAECH, RAECH
 ;         array & RAHLFS
 N RA0,RAECH,RAHLFS,RATAB,RAVAR
 S RATAB=1 D EN1^RAO7UTL S RA0=$G(^RAO(75.1,RAOIFN,0)) Q:RA0']""
 S RAVAR="RATMP(",RAVARBLE="RATMP"
 ; msh
 S @(RAVAR_RATAB_")")=$$MSH^RAO7UTL("ORM^O01") ;P18 Event type
 ; pid
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")=$$PID^RAO7UTL(RA0)
 ; orc
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")="ORC"_RAHLFS_"SC"_RAHLFS_$P(RA0,U,7)_RAECH(1)_"OR"_RAHLFS_RAOIFN_RAECH(1)_"RA"_$$STR^RAO7UTL(2)_"ZU"_$$STR^RAO7UTL(7)_$P(RA0,U,14)
 D SNDOERR
 Q
SNDOERR ; ship message to MSG^RAO7UTL which fires of the HL7 message to CPRS
 D MSG^RAO7UTL("RA EVSEND OR",.@RAVARBLE)
 Q
