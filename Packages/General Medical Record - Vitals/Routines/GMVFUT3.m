GMVFUT3 ;HOIFO/RM,FT-FILE UTILITIES FOR 120.53 FILE ;5/23/01  15:43
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
ACAT(GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF ACAT XREF ON CATEGORY
 ; (.01) FIELD OF GMRV CATEGORY (120.53) FILE.  THIS PROCEDURE
 ; SETS/KILLS THE FOLLOWING MUMPS INDICES:  "AA".
 ;    Input variables:  GMRVSK=1 if called from SET, 2 if from KILL
 ;                      DA=DA array passed by reference.
 ;                      X=value being indexed.
 ;
 S GMRVDA=DA N DA,GMRVY
 S DA(1)=GMRVDA,DA=0
 F  S DA=$O(^GMRD(120.53,DA(1),1,DA)) Q:DA'>0  D
 .  S GMRVY=$G(^GMRD(120.53,DA(1),1,DA,0))
 .  D AA($P(GMRVY,"^"),X,.DA,GMRVSK)
 .  Q
 K GMRVDA
 Q
ATYP(GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF ATYP XREF ON VITAL
 ; TYPE (.01) FIELD OF VITAL TYPE (120.531) SUB-FILE OF GMRV CATEGORY
 ; (120.53) FILE.  THIS PROCEDURE SETS/KILLS THE FOLLOWING MUMPS
 ; INDICES:  "AA", "APRINT", AND "AEDIT".
 ;    Input variables:  GMRVSK=1 if called from SET, 2 if from KILL
 ;                      DA=DA array passed by reference.
 ;                      X=value being indexed.
 ;
 N GMRVX,GMRVY
 S GMRVX=$G(^GMRD(120.53,DA(1),0)),GMRVY=$G(^GMRD(120.53,DA(1),1,DA,0))
 D AA(X,$P(GMRVX,"^"),.DA,GMRVSK)
 D APRINT(X,$P(GMRVY,"^",5),.DA,GMRVSK)
 D AEDIT(X,$P(GMRVY,"^",6),.DA,GMRVSK)
 Q
AEDT(GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF AEDT XREF ON EDIT
 ; ORDER (.06) FIELD OF VITAL TYPE (120.531) SUB-FILE OF GMRV CATEGORY
 ; (120.53) FILE.  THIS PROCEDURE SETS/KILLS THE FOLLOWING MUMPS
 ; INDICES:  "AEDIT".
 ;    Input variables:  GMRVSK=1 if called from SET, 2 if from KILL
 ;                      DA=DA array passed by reference.
 ;                      X=value being indexed.
 ;
 N GMRVY
 S GMRVY=$G(^GMRD(120.53,DA(1),1,DA,0))
 D AEDIT($P(GMRVY,"^"),X,.DA,GMRVSK)
 Q
APRT(GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF APRT XREF ON PRINT
 ; ORDER (.05) FIELD OF VITAL TYPE (120.531) SUB-FILE OF GMRV CATEGORY
 ; (120.53) FILE.  THIS PROCEDURE SETS/KILLS THE FOLLOWING MUMPS
 ; INDICES:  "APRINT".
 ;    Input variables:  GMRVSK=1 if called from SET, 2 if from KILL
 ;                      DA=DA array passed by reference.
 ;                      X=value being indexed.
 ;
 N GMRVY
 S GMRVY=$G(^GMRD(120.53,DA(1),1,DA,0))
 D APRINT($P(GMRVY,"^"),X,.DA,GMRVSK)
 Q
AA(TYPE,CAT,DA,SK) ; This procedure updates the "AA" index for the 120.53
 ; file.  This index has the following format:
 ;    ^GMRD(120.53,"AA",TYPE,CAT,DA(1),DA)=""
 ;  Input variables:
 ;      TYPE=Vital Type (.01) field 120.531 sub-file.
 ;       CAT=Name (.01) field of 120.53 file.
 ;        DA=Passed by reference will have entry in 120.531 sub-file, DA,
 ;           and entry in 120.53 file, DA(1).
 ;        SK=1 if set xref, 2 if kill xref.
 ;
 Q:$G(TYPE)=""!($G(CAT)="")!($G(DA(1))="")!($G(DA)="")
 I $G(SK)=1 S ^GMRD(120.53,"AA",TYPE,CAT,DA(1),DA)=""
 I $G(SK)=2 K ^GMRD(120.53,"AA",TYPE,CAT,DA(1),DA)
 Q
AEDIT(TYPE,EORD,DA,SK) ; This procedure updates the "AEDIT" index for the
 ; 120.53 file.  This index has the following format:
 ;    ^GMRD(120.53,"AEDIT",TYPE,EORD,DA(1),DA)=""
 ;  Input variables:
 ;      TYPE=Vital Type (.01) field 120.531 sub-file.
 ;      EORD=Edit Order (.06) field of 120.531 sub-file.
 ;        DA=Passed by reference will have entry in 120.531 sub-file, DA,
 ;           and entry in 120.53 file, DA(1).
 ;        SK=1 if set xref, 2 if kill xref.
 ;
 Q:$G(TYPE)=""!($G(EORD)="")!($G(DA(1))="")!($G(DA)="")
 I $G(SK)=1 S ^GMRD(120.53,"AEDIT",TYPE,EORD,DA(1),DA)=""
 I $G(SK)=2 K ^GMRD(120.53,"AEDIT",TYPE,EORD,DA(1),DA)
 Q
APRINT(TYPE,PORD,DA,SK) ; This procedure updates the "APRINT" index for the
 ; 120.53 file.  This index has the following format:
 ;    ^GMRD(120.53,"APRINT",TYPE,PORD,DA(1),DA)=""
 ;  Input variables:
 ;      TYPE=Vital Type (.01) field 120.531 sub-file.
 ;      PORD=Print Order (.05) field of 120.531 sub-file.
 ;        DA=Passed by reference will have entry in 120.531 sub-file, DA,
 ;           and entry in 120.53 file, DA(1).
 ;        SK=1 if set xref, 2 if kill xref.
 ;
 Q:$G(TYPE)=""!($G(PORD)="")!($G(DA(1))="")!($G(DA)="")
 I $G(SK)=1 S ^GMRD(120.53,"APRINT",TYPE,PORD,DA(1),DA)=""
 I $G(SK)=2 K ^GMRD(120.53,"APRINT",TYPE,PORD,DA(1),DA)
 Q
SCR07(DA,Y) ; CALLED FROM INPUT TRANSFORM OF DEFAULT QUALIFIER (.07)
 ; FIELD OF THE VITAL TYPE (120.531) SUB-FILE OF THE GMRV VITAL CATEGORY
 ; (120.53) FILE.  WILL CHECK TO SEE IF QUALIFIER IS VALID FOR THIS
 ; VITAL TYPE AND CATEGORY.
 ;   Input Variables: DA = DA arrary passed by reference from screen.
 ;                    Y = Entry in 120.53 file being validated.
 ;
 N GMRVCHAR,GMRVFXN,GMRVTYP S GMRVFXN=0
 S GMRVTYP=$P($G(^GMRD(120.53,DA(1),1,DA,0)),"^"),GMRVCHAR=$P($G(^GMRD(120.52,+Y,0)),"^")
 I GMRVTYP>0,GMRVCHAR]"",$D(^GMRD(120.52,"AA",GMRVTYP,DA(1),GMRVCHAR,+Y)) S GMRVFXN=1
 Q GMRVFXN
