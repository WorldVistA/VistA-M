GMVFSYN ;HOIFO/RM,YH,FT-X REFERENCE FOR VITAL TYPE, CATEGORY AND SYNONYM ;3/8/05  13:38
 ;;5.0;GEN. MED. REC. - VITALS;**8**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
BSYNO(GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF ACHR XREF ON
 ; SYNONYM (.02) FIELD OF GMRV VITAL QUALIFIER (120.52) FILE.
 ; THIS PROCEDURE SETS/KILLS THE FOLLOWING MUMPS INDICES:  "BB".
 ;    Input variables:  GMRVSK=1 if called from SET, 2 if from KILL
 ;                      DA=DA array passed by reference.
 ;                      X=value being indexed.
 ;
 S GMRVDA=DA N DA,GMRVY
 S DA(1)=GMRVDA,DA=0
 F  S DA=$O(^GMRD(120.52,DA(1),1,DA)) Q:DA'>0  D
 .  S GMRVY=$G(^GMRD(120.52,DA(1),1,DA,0))
 .  D BB($P(GMRVY,"^"),$P(GMRVY,"^",2),X,.DA,GMRVSK)
 .  Q
 K GMRVDA
 Q
BTYP(GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF BTYP XREF ON VITAL
 ; TYPE (.01) FIELD OF VITAL TYPE (120.521) SUB-FILE OF GMRV
 ; GMRV VITAL QUALIFIER (120.52) FILE.  THIS PROCEDURE SETS/KILLS THE
 ; FOLLOWING MUMPS INDEX:  "BB".
 ;    Input variables:  GMRVSK=1 if called from SET, 2 if from KILL
 ;                      DA=DA array passed by reference.
 ;                      X=value being indexed.
 ;
 N GMRVX,GMRVY
 S GMRVX=$P($G(^GMRD(120.52,DA(1),0)),"^"),GMRVY=$G(^GMRD(120.52,DA(1),1,DA,0))
 D BB(X,$P(GMRVY,"^",2),$P(GMRVX,"^",2),.DA,GMRVSK)
 Q
BCAT(GMRVSK,DA,X) ; CALLED FROM SET/KILL LOGIC OF BCAT XREF ON CATEGORY
 ; (.02) FIELD OF VITAL TYPE (120.521) SUBFILE OF GMRV VITAL QUALIFIER
 ; (120.52) FILE.  THIS PROCEDURE SETS/KILLS THE FOLLOWING MUMPS
 ; INDEX:  "BB".
 ;    Input variables:  GMRVSK=1 if called from SET, 2 if from KILL
 ;                      DA=DA array passed by reference.
 ;                      X=value being indexed.
 ;
 N GMRVX,GMRVY
 S GMRVX=$G(^GMRD(120.52,DA(1),0)),GMRVY=$G(^GMRD(120.52,DA(1),1,DA,0))
 D BB($P(GMRVY,"^"),X,$P(GMRVX,"^",2),.DA,GMRVSK)
 Q
BB(TYPE,CAT,CHAR,DA,SK) ; This procedure updates the "BB" index for the 120.52
 ; file.  This index has the following format:
 ;    ^GMRD(120.52,"BB",TYPE,CAT,CHAR,DA(1),DA)=""
 ;  Input variables:
 ;      TYPE=Vital Type (.01) field 120.521 sub-file.
 ;       CAT=Category (.02) field of 120.521 sub-file.
 ;      CHAR=Name (.01) field of 120.52 file.
 ;        DA=Passed by reference will have entry in 120.52 sub-file, DA,
 ;           and entry in 120.52 file, DA(1).
 ;        SK=1 if set xref, 2 if kill xref.
 ;
 Q:$G(TYPE)=""!($G(CAT)="")!($G(CHAR)="")!($G(DA(1))="")!($G(DA)="")
 I $G(SK)=1 S ^GMRD(120.52,"BB",TYPE,CAT,CHAR,DA(1),DA)=""
 I $G(SK)=2 K ^GMRD(120.52,"BB",TYPE,CAT,CHAR,DA(1),DA)
 Q
SCREEN ;SCREEN FOR DUPLICATE ENTRY FOR A VITAL TYPE
 ; Called from SYNONYM field (#.02) of the GMRV VITAL QUALIFIER file
 ; (#120.52) - ^DD(120.52,.02,0)
 Q  ; SYNONYMs will be provided by the standardization process. 
 Q:X=""  S GMRVDA=DA N DA,GTYP,GCAT,GSYN
 S DA(1)=GMRVDA,DA=0
 F  S DA=$O(^GMRD(120.52,DA(1),1,DA)) Q:DA'>0!'$D(X)  D
 .  S GMRVY=$G(^GMRD(120.52,DA(1),1,DA,0))
 .  S GTYP=+$P(GMRVY,"^")
 .  I $D(^GMRD(120.52,"BB",GTYP)) D
 .  .S GCAT=0 F  S GCAT=$O(^GMRD(120.52,"BB",GTYP,GCAT)) Q:GCAT'>0!'$D(X)  S GSYN="" F  S GSYN=$O(^GMRD(120.52,"BB",GTYP,GCAT,GSYN)) Q:GSYN=""!'$D(X)  I GSYN=X&'$D(^(GSYN,DA(1))) W:'$D(ZTQUEUED) !!,X K X
 K GMRVDA Q
