GMRVFUT0 ;HIRMFO/RM-FILE UTILITIES FOR 120.5 FILE ;1/21/97
 ;;4.0;Vitals/Measurements;;Apr 25, 1997
EN1(Y,DA) ; INPUT TRANSFORM FOR NAME (.01) FIELD OF QUALIFIER
 ; (120.505) SUB-FILE OF GMRV VITAL MEASUREMENT (120.5) FILE.
 ;   Input variables:  Y is entry in 120.52 being looked up
 ;                     DA is entry in 120.5 where Qualifier data
 ;                        is being selected.
 ;   Function value: 1 if can select this Qualifier, else 0.
 ;
 N GMRVFXN,GMRVTYP S GMRVFXN=0
 S GMRVTYP=$P($G(^GMR(120.5,DA,0)),"^",3)
 I GMRVTYP>0,$D(^GMRD(120.52,"C",GMRVTYP,+Y)) S GMRVFXN=1
 Q GMRVFXN
 ;
EN2(DA,X) ; CALLED FROM INPUT TRANSFORM OF RATE (1.2) FIELD OF THE GMRV
 ; VITAL MEASUREMENT (#120.5) FILE.
 ;   Input variable: DA is entry in 120.5 where Rate is being validated.
 ;                   X is value of Rate being validated.
 ;
 N GMRVFXN,GMRVINP,GMRVM,GMRVTYP
 S GMRVFXN=1 I $A(X)=45 S GMRVFXN=0
 I GMRVFXN D
 .  S GMRVTYP=$P($G(^GMR(120.5,DA,0)),"^",3)
 .  I GMRVTYP'>0 S GMRVFXN=0
 .  I GMRVTYP>0,'$P($G(^GMRD(120.51,GMRVTYP,0)),"^",4) S GMRVFXN=0
 .  I 'GMRVFXN D
 .  .  S GMRVFXN=0,GMRVM(1)=$C(7),GMRVM(3)=""
 .  .  S GMRVM(2)="   RATE CANNOT BE ENTERED FOR THIS MEASUREMENT TYPE!"
 .  .  D EN^DDIOL(.GMRVM,"","?5")
 .  .  Q
 .  Q
 I GMRVFXN,$L(X)>30!($L(X)<1) S GMRVFXN=0
 I GMRVFXN D
 .  S GMRVINP=$E($G(^GMRD(120.51,$P(^GMR(120.5,DA,0),U,3),1)),1,245)
 .  I GMRVINP'="" X GMRVINP I '$D(X) S GMRVFXN=0
 .  I GMRVINP="" S GMRVFXN=0
 .  Q
 Q GMRVFXN
 ;
AA(GMRVFLD,GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF:  AA01 XREF OF
 ; DATE/TIME VITALS TAKEN (.01) FIELD, AA02 XREF OF PATIENT (.02)
 ; FIELD, AND AA03 XREF OF VITAL TYPE (.03) FIELD OF THE GMRV VITAL
 ; MEASUREMENT (120.5) FILE TO SET "AA" INDEX.
 ;    Input variables: GMRVFLD=field making call
 ;                     GMRVSK=1 if called from SET LOGIC, 2 if called
 ;                            from KILL LOGIC.
 ;                     DA is entry being indexed.
 ;                     X is value of GMRVFLD to be indexed.
 ;
 N GMRVDFN,GMRVDT,GMRVTYP,GMRVX
 S GMRVX=$G(^GMR(120.5,DA,0))
 S GMRVDT=$S(GMRVFLD=.01:X,1:$P(GMRVX,"^"))
 S GMRVDFN=$S(GMRVFLD=.02:X,1:$P(GMRVX,"^",2))
 S GMRVTYP=$S(GMRVFLD=.03:X,1:$P(GMRVX,"^",3))
 Q:GMRVDT=""!(GMRVDFN="")!(GMRVTYP="")
 I GMRVSK=1 S ^GMR(120.5,"AA",GMRVDFN,GMRVTYP,9999999-GMRVDT,DA)=""
 I GMRVSK=2 K ^GMR(120.5,"AA",GMRVDFN,GMRVTYP,9999999-GMRVDT,DA)
 Q
RATEHLP(DA) ; CALLED FROM EXECUTABLE HELP OF RATE (1.2) FIELD OF GMRV
 ; VITAL MEASUREMENT (120.5) FILE.
 ;    Input Variable:  DA is entry in 120.5 to display help for.
 ;
 N GMRVTYP,XQH
 S GMRVTYP=$P($G(^GMR(120.5,DA,0)),"^",3)
 S XQH=$P($G(^GMRD(120.51,+GMRVTYP,0)),"^",6)
 I XQH="" D EN^DDIOL("RATE NOT APPLICABLE FOR THIS TYPE OF MEASUREMENT")
 I XQH'="" D EN^XQH
 Q
