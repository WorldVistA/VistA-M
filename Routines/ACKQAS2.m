ACKQAS2 ;HCIOFO/BH-Edit an Existing Visit ; 04/01/99
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
OPTN ;  Introduce option.
 ;
 W @IOF D HEADING
 ;
VEDIT ;   EDIT AN EXISTING VISIT
 ;
DATE ;  Enter date
 S ACKVISIT="EDIT"
 W !
 S DIC("W")="W $$DISPLAY^ACKQUTL3(Y,$X)"
 S DIC=509850.6,DIC(0)="AEMQZ" D ^DIC
 I X?1"^"1.E W !,"Jumping not allowed.",! G DATE
 G:Y<0 VEXIT
 ;
 S ACKY=+Y,ACKVD=$P(Y,U,2),DFN=$P(Y(0),U,2)
 S ACKVIEN=+Y
 ;
 ;  Check Visit Date Okay
 S ACKQDTE=$$GET1^DIQ(509850.6,ACKVIEN,.01,"E")
RES W !,"DATE: "_ACKQDTE_"//" R ACKQRES:DTIME
 I ACKQRES="^" G DATE
 I ACKQRES'="" W !!,"Enter <RETURN> to continue or '^' to Quit.",! G RES
 ;
 ; Attempt to Lock record if lock display error and re-promt
 L +^ACK(509850.6,ACKVIEN):2 E  W !!,"This record is locked by another process - Please try again later.",!! G DATE
 ;
 ; Check to see if PCE data has got out of set with Quasar data
 I $$GET1^DIQ(509850.6,ACKVIEN,"125","I")'="" I '$$DATACHK^ACKQASU3(ACKVIEN) D UNLOCK,VEXIT,HEADING G DATE
 ;
 S (ACKPAT,ACKDFN)=DFN
 S ACKCLIN=$$GET1^DIQ(509850.6,ACKVIEN,"2.6","I")
 S ACKCSC=$$GET1^DIQ(509850.6,ACKVIEN,"4","I")
 S ACKDIV=$$GET1^DIQ(509850.6,ACKVIEN,"60","I")
 S ACKVTME=$$GET1^DIQ(509850.6,ACKVIEN,55,"I"),ACKVTME=$P(ACKVTME,".",2)
 S ACKPCE=$$PCE^ACKQUTL4(ACKDIV,ACKVD)
 ;
 ;
 I 'ACKCLIN!(ACKCSC="") W !,"No clinic or Clinic Stop Code set up for original visit" D UNLOCK G VEXIT
 ;
SUPER ; Staff designated as supervisors can edit/delete .01 field.
 ; I $D(^ACK(509850.3,DUZ,0)) I $P(^(0),"^",6)=1 D  I $D(DIRUT)!($D(DTOUT)) D UNLOCK G VEXIT
 ; .K DIRUT,DTOUT,X,Y S DIE=DIC,DA=ACKY,DR=".01" D ^DIE Q:$D(DTOUT)
 ; .I ('$D(DA))!($D(Y)) S DIRUT="" Q
 ; .S ACKVD=$P(^ACK(509850.6,ACKY,0),"^")
 ;
 ;
TPLATE S DIE=DIC,DA=ACKY,DR="[ACKQAS VISIT ENTRY]" D ^DIE
 D UTLAUD^ACKQASU2
 S ACKQTST=$$POST^ACKQASU2(ACKVIEN) I 'ACKQTST S ACKDFN=DFN G TPLATE
 ;  ACKQTST will equal 1 (Visit okay or user chose to continue) or
 ;  ACKQTST will equal 2 the visit has been deleted
 I ACKPCE,ACKQTST=1,$$EXPT^ACKQASU2(ACKVIEN) I '$$PCESEND^ACKQASU3(ACKVIEN) S ACKDFN=DFN G TPLATE
 ;  If visit is okay and visit not to be sent to PCE but visit has a
 ;  value in the PCE IEN field - the EXCEPTION DATE from the visit is 
 ;  used to check the Exception cross reference.  If an exception exists
 ;  display a warning message.
 I ACKQTST=1,'ACKPCE,$$GET1^DIQ(509850.6,ACKVIEN_",",125,"I")'="" D
 . Q:'$$EXPT^ACKQASU2(ACKVIEN)
 . D EXCEPT^ACKQASU1
 ; Unlock - Kill off old vars. - re-display heading and return to start
 D UNLOCK,VEXIT,HEADING G VEDIT
 ;
VEXIT K ACK0,ACK2,ACKCAT,ACKCD,ACKCDN,ACKCLN,ACKCNT,ACKCP,ACKDA,ACKDC,ACKDUP
 K ACKDUPN,ACKECSC,ACKESITE,ACKFLD,ACKFLG1,ACKFLG2,ACKGEN,ACKI,ACKLAYGO
 K ACKMOD,ACKMON,ACKQCPS,ACKQCPT,ACKQRAW,ACKRAW,ACKREQ,ACKSEL,ACKSTF
 K ACKSIG,ACKTM,ACKVD,ACKDIRUT,VADM,ACKLAMD,ACKVISIT,ACKQDTE,ACKQRES
 K %,%DT,%I,%X,%Y,C,D0,DA,DFN,DIC,DIE,DIK,DIRUT,DLAYGO,DR,DTOUT,I,J,X,Y
 K ACKCHK,ACKAO,ACKSC,ACKRAD,ACKENV,ACKCP,ACKELIG,ACKVELIG,ACKEGCT
 K ACKATS,ACKBA,ACKCLIN,ACKCLNO,ACKDIV,ACKELDIS,ACKELGCT,ACKK2,ACKLOSS
 K ACKPAT,ACKPCE,ACKVELG,ACKVIEN,ACKY,ACKCPNO,ACKQTST
 K ACKQSER,ACKQORG,ACKQIR,ACKQECON
 D KILL^%ZISS
 Q
 ;
UNLOCK ;  Unlock locked record
 L
 Q
 ;
HEADING ;
 W @IOF
 W !!,"This option is used to modify an existing clinic visit when the data is",!,"incorrect, incomplete, or needs to be updated.",!!
 Q
 ;
