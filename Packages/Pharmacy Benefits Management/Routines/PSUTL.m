PSUTL ;BIR/PDW - Utilities for AR/WS extracts ;12 AUG 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ; Reference to DOLRO^%ZOSV supported by DBIA 2500
 ;
 ; Entry Points
 ;
 ; D GETS^PSUTL(,,,,)
 ; D GETM^PSUTL(,,,,)
 ; $$VAL^PSUTL(,,)
 ; $$VALI^PSUTL(,,)
 ; ---------------------
 ; D MOVEI^PSUTL("ref")    Moves @ref@(Fld,"I") Value to (Fld) node
 ; D MOVEMI^PSUTL("ref")   Moves @ref@(da,Fld,"I") value to (da,Fld) node
 ; ---------------------
 ; ---------------------
 ; Details & Parameters
 ; D GETS^PSUTL(,,,,)       Returns @root@(Field Number(s))    = Value(s)
 ;   Multiples NO
 ;
 ; D GETM^PSUTL(,,,,)       Returns @root@(DA,Field Number(s)) = Value(s)
 ;   Multiples YES & ONLY
 ;
 ; S X=$$VAL^PSUTL(,,)      X = External Value
 ; S X=$$VALI^PSUTL(,,)    X = Interanl Value
 ;
 ; [ Variables for Parameter Passing ]
 ; PSUFILE = file number or subfile number    as described in GETS^DIQ()
 ; PSUDA   = List or array of IENS        NOT as described in GETS^DIQ()
 ;
 ;   A .DA array or a list of IENS left to right as they are in the
 ;   global data arrays D0,D1,D2 as within a FM Global map
 ;   This Iens list can be constructed with variables.
 ;   Example: as reaching into file 200 division subfile 200.02
 ;            "DUZ,SITE"
 ;
 ; PSUDR   = DR string                         as described in GETS^DIQ()
 ; PSUROOT = closed array                      as described in GETS^DIQ()
 ; PSUFORM = format control                    as described in GETS^DIQ()
 ;
GETS(PSUFILE,PSUDA,PSUDR,PSUROOT,PSUFORM) ;
 ; Example S PSUSITE=6025
 ; D GETS^PSUTL(200.02,"DUZ,PSUSITE",".01","DIV")
 ; returns
 ; DIV(.01)="HINES DEVELOPMENT"
 ;
 N PSUIEN,DA
 I $D(PSUFILE),$D(PSUDA),$D(PSUDR),$D(PSUROOT)
 E  Q
 I '$D(PSUFORM) S PSUFORM=""
 D PARSE(PSUDA)
 S PSUIEN=$$IENS^DILF(.DA)
 K ^TMP("PSUDIQ",$J)
 D GETS^DIQ(PSUFILE,PSUIEN,PSUDR,PSUFORM,"^TMP(""PSUDIQ"",$J)")
 ;
 I $G(PSUMTUL) Q
 ;
 M @PSUROOT=^TMP("PSUDIQ",$J,PSUFILE,PSUIEN)
 K ^TMP("PSUDIQ",$J)
 Q
 ;
VAL(PSUFILE,PSUDA,PSUFLD) ; Returns External Value
 N PSUTMP
 I $D(PSUFILE),$D(PSUDA),$D(PSUFLD)
 E  Q ""
 D GETS(PSUFILE,PSUDA,PSUFLD,"PSUTMP")
 Q $G(PSUTMP(PSUFLD))
VALI(PSUFILE,PSUDA,PSUFLD) ; Returns Internal Value
 N PSUTMP
 I $D(PSUFILE),$D(PSUDA),$D(PSUFLD)
 E  Q ""
 D GETS(PSUFILE,PSUDA,PSUFLD,"PSUTMP","I")
 Q $G(PSUTMP(PSUFLD,"I"))
 ;
GETM(PSUFILE,PSUDA,PSUFLD,PSUROOT,PSUFORM) ;EP RETURN MULTIPLES
 ; PSUFILE is the immediate upper level file number of the one desired
 ; PSUDA is the "DO,D1,Dx .." IENS to get to the immediate upper level
 ; PSUFLD is the field notation for the multiple at the upper level
 ;   "3*"
 ;   appended with "^" and the list of fields ".01;.02;9.3;..."
 ;   resulting in "3*^.01;.02;9.3;..."
 ; PSUROOT is the target closed array reference
 ; PSUFORM is the format as in GET^DIQ
 ; return form is @PSUROOT@(da,fld)=VALUE
 ;
 ; example: pulls multiple divisions from file 200
 ; D GETM^PSUTL(200,DUZ,"16*^.01","DIV")
 ; Returns  DIV(578,.01) ="HINES, IL"
 ;          DIV(6020,.01)="HINES ISC"
 ;          DIV(6025,.01)="HINES DEVELOPMENT"
 ;        
 N PSUMTUL,PSUSUB,PSUDID
 I $D(PSUFILE),$D(PSUDA),$D(PSUFLD),$D(PSUROOT)
 E  Q
 S PSUMTUL=1
 I '$D(PSUFORM) S PSUFORM=""
 I PSUFLD'["^" Q
 K PSUFLDL
 S PSUFLDL=$P(PSUFLD,U,2),PSUFLD=$P(PSUFLD,U)
 I +PSUFLDL,+PSUFLD
 E  Q
 D FIELD^DID(PSUFILE,+PSUFLD,"","SPECIFIER","PSUDID")
 S PSUSUB=+PSUDID("SPECIFIER")
 D GETS(PSUFILE,PSUDA,PSUFLD,PSUROOT,PSUFORM)
 ; load multiple into target array
 S PSUIEN=0 F  S PSUIEN=$O(^TMP("PSUDIQ",$J,PSUSUB,PSUIEN))  Q:+PSUIEN'>0  M @PSUROOT@(+PSUIEN)=^TMP("PSUDIQ",$J,PSUSUB,PSUIEN)
 K ^TMP("PSUDIQ",$J)
 Q:'$D(PSUFLDL)
 ;
 ; process individual fields
 N I,FLD
 S FLD=+PSUFLDL,PSUFLDL(FLD)=0
 F I=2:1 S FLD=$P(PSUFLDL,";",I) Q:FLD'>0  S PSUFLDL(FLD)=""
 S PSUIEN=0 F  S PSUIEN=$O(@PSUROOT@(PSUIEN)) Q:PSUIEN'>0  D
 . S FLD=0
 . F  S FLD=$O(@PSUROOT@(PSUIEN,FLD)) Q:FLD'>0  I '$D(PSUFLDL(FLD)) K @PSUROOT@(PSUIEN,FLD)
 K PSUFLDL
 Q
PARSE(XBDA) ;PEP - parse DA literal into da array
 I XBDA="",$D(XBDA)=1 S DA=0 Q
 NEW D,I,J
 F I=1:1 S D(I)=$P(XBDA,",",I) Q:D(I)=""
 S I=I-1
 F J=0:1:I-1 S DA(J)=D(I-J)
 F J=0:1:I-1 F  Q:(DA(J)=+DA(J))  S DA(J)=@(DA(J)) S:DA(J)="" DA(J)=0
 S DA=DA(0)
 KILL DA(0)
 Q
MOVEI(PSUREF) ;EP Move @PSUREF@(Fld,"I") values to @PSUREF@(Fld)
 N PSUFLD
 S PSUFLD=0 F  S PSUFLD=$O(@PSUREF@(PSUFLD)) Q:PSUFLD'>0  S @PSUREF@(PSUFLD)=$G(@PSUREF@(PSUFLD,"I")) K @PSUREF@(PSUFLD,"I")
 Q
 ;
MOVEMI(PSUREF) ;EP Move @PSUREF@(da,Fld,"I") values to @PSUREF@(da,Fld)
 N PSUDA,PSUFLD
 S PSUDA=0 F  S PSUDA=$O(@PSUREF@(PSUDA)) Q:PSUDA'>0  D
 . S PSUFLD=0 F  S PSUFLD=$O(@PSUREF@(PSUDA,PSUFLD)) Q:PSUFLD'>0  S @PSUREF@(PSUDA,PSUFLD)=@PSUREF@(PSUDA,PSUFLD,"I") K @PSUREF@(PSUDA,PSUFLD,"I")
 Q
 ;
UPPER(PSUX) ;Convert lower case to upper case
 Q $TR(PSUX,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
VARKILL ;PEP Kill variable PSU* namespace 
 ;Kills off all PSU Variables
 S X="^TMP(""PSUVAR"",$J,"
 D DOLRO^%ZOSV ; load symbols into ^TMP(,,var)=..
 ;   (preserve PSU,PSUXMY*)
 S X="" F  S X=$O(^TMP("PSUVAR",$J,X)) Q:X=""  I $E(X,1,3)="PSU",X'="PSU",($E(X,1,6)'="PSUXMY"),X'="PSUJOB" K @X
 K ^TMP("PSUVAR",$J)
 ;
 ;
