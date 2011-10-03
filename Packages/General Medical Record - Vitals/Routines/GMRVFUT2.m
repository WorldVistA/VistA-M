GMRVFUT2 ;HIRMFO/RM-FILE UTILITIES FOR 120.52 FILE ;5/1/97
 ;;4.0;Vitals/Measurements;**1**;Apr 25, 1997
 ;
ACHR(GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF ACHR XREF ON
 ; QUALIFIER (.01) FIELD OF GMRV VITAL QUALIFIER (120.52) FILE.
 ; THIS PROCEDURE SETS/KILLS THE FOLLOWING MUMPS INDICES:  "AA".
 ;    Input variables:  GMRVSK=1 if called from SET, 2 if from KILL
 ;                      DA=DA array passed by reference.
 ;                      X=value being indexed.
 ;
 S GMRVDA=DA N DA,GMRVY
 S DA(1)=GMRVDA,DA=0
 F  S DA=$O(^GMRD(120.52,DA(1),1,DA)) Q:DA'>0  D
 .  S GMRVY=$G(^GMRD(120.52,DA(1),1,DA,0))
 .  D AA($P(GMRVY,"^"),$P(GMRVY,"^",2),X,.DA,GMRVSK)
 .  Q
 K GMRVDA
 Q
ATYP(GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF ATYP XREF ON VITAL
 ; TYPE (.01) FIELD OF VITAL TYPE (120.521) SUB-FILE OF GMRV
 ; GMRV VITAL QUALIFIER (120.52) FILE.  THIS PROCEDURE SETS/KILLS THE
 ; FOLLOWING MUMPS INDEX:  "AA".
 ;    Input variables:  GMRVSK=1 if called from SET, 2 if from KILL
 ;                      DA=DA array passed by reference.
 ;                      X=value being indexed.
 ;
 N GMRVX,GMRVY
 S GMRVX=$P($G(^GMRD(120.52,DA(1),0)),"^"),GMRVY=$G(^GMRD(120.52,DA(1),1,DA,0))
 D AA(X,$P(GMRVY,"^",2),$P(GMRVX,"^"),.DA,GMRVSK)
 Q
ACAT(GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF ACAT XREF ON CATEGORY
 ; (.02) FIELD OF VITAL TYPE (120.521) SUBFILE OF GMRV VITAL QUALIFIER
 ; (120.52) FILE.  THIS PROCEDURE SETS/KILLS THE FOLLOWING MUMPS
 ; INDEX:  "AA".
 ;    Input variables:  GMRVSK=1 if called from SET, 2 if from KILL
 ;                      DA=DA array passed by reference.
 ;                      X=value being indexed.
 ;
 N GMRVX,GMRVY
 S GMRVX=$G(^GMRD(120.52,DA(1),0)),GMRVY=$G(^GMRD(120.52,DA(1),1,DA,0))
 D AA($P(GMRVY,"^"),X,$P(GMRVX,"^"),.DA,GMRVSK)
 Q
AA(TYPE,CAT,CHAR,DA,SK) ; This procedure updates the "AA" index for the 120.52
 ; file.  This index has the following format:
 ;    ^GMRD(120.52,"AA",TYPE,CAT,CHAR,DA(1),DA)=""
 ;  Input variables:
 ;      TYPE=Vital Type (.01) field 120.521 sub-file.
 ;       CAT=Category (.02) field of 120.521 sub-file.
 ;      CHAR=Name (.01) field of 120.52 file.
 ;        DA=Passed by reference will have entry in 120.52 sub-file, DA,
 ;           and entry in 120.52 file, DA(1).
 ;        SK=1 if set xref, 2 if kill xref.
 ;
 Q:$G(TYPE)=""!($G(CAT)="")!($G(CHAR)="")!($G(DA(1))="")!($G(DA)="")
 I $G(SK)=1 S ^GMRD(120.52,"AA",TYPE,CAT,CHAR,DA(1),DA)=""
 I $G(SK)=2 K ^GMRD(120.52,"AA",TYPE,CAT,CHAR,DA(1),DA)
 Q
SCR02(Y,DA) ; CALLED FROM INPUT TRANSFORM OF CATEGORY (.02) FIELD OF THE
 ; VITAL TYPE (120.521) SUB-FILE OF THE GMRV VITAL QUALIFIER
 ; (120.52) FILE.  WILL CHECK TO SEE IF CATEGORY IS VALID FOR THIS
 ; VITAL TYPE.
 ;   Input Variables: DA = DA arrary passed by reference from screen.
 ;                    Y = Entry in 120.53 file being validated.
 ;
 N GMRVFXN,GMRVTYP S GMRVFXN=0
 S GMRVTYP=$P($G(^GMRD(120.52,DA(1),1,DA,0)),"^")
 I GMRVTYP>0,$D(^GMRD(120.53,"C",GMRVTYP,+Y)) S GMRVFXN=1
 Q GMRVFXN
