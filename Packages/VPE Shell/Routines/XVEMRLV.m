XVEMRLV ;DJB/VRR**RTN VER - Routine Editor Prompts ;2017-08-15  2:03 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
ADD(RTN) ;Create and store a version of the current rtn?
 ;
 NEW DEFAULT,DESC,IEN,PREV,PREVIOUS,PROMPT,VERSION
 NEW XVVUSERI,XVVUSERN
 ;
 Q:$G(RTN)']""
 Q:'$$CHKLBRY^XVEMRLU(1,"V")
 Q:'$D(^XVV(19200.112))  ;...Version file doesn't exist
 ;
 ;Does user want to be prompted for versioning
 S PROMPT="YES" ;...Offer prompts as the default
 D GETUSER^XVEMRLU(1)
 I XVVUSERI,$P($G(^XVV(19200.111,XVVUSERI,0)),"^",4)="n" S PROMPT="NO"
 I PROMPT="NO" D ADD2 Q
 ;
 W !!,"--- VERSIONING ---",!
 Q:$$ASK^XVEMKU("Store a version of this routine",1)'="Y"
 ;
 S DEFAULT=$$DEFAULT(RTN)
 S PREVIOUS=$$PREVIOUS(RTN)
 S PREV=$E(PREVIOUS,2,$L(PREVIOUS)-1) ;Strip beginning/ending commas.
 ;
 W !!,"Versions on file: "
 W $S(PREV:PREV,1:"None")
 ;
ADD1 W !,"VERSION: "_DEFAULT_"//"
 R VERSION:300 S:'$T VERSION="^" S:VERSION="" VERSION=DEFAULT
 I "^"[VERSION Q
 ;
 ;Allow user to type L to update last version number.
 I ",l,L,"[(","_VERSION_",") D  ;
 . S VERSION=DEFAULT-1
 . S:VERSION<1 VERSION=1
 . W "  ",VERSION
 ;
 ;Help
 I VERSION["?" D  G ADD1
 . W !,"Enter "_DEFAULT_" to create a new version."
 . W !,"Enter a previous version number to update that version."
 . W !,"Enter L as a shortcut to update the last previous version.",!
 ;
 ;Default entry
 I VERSION'=DEFAULT,PREVIOUS'[(","_VERSION_",") D  G ADD1
 . W "   Invalid entry"
 ;
 S DESC="" ;Initialize Description field value
 I VERSION=DEFAULT S IEN=$$CREATE(RTN,VERSION) I 1
 E  D  ;
 . S IEN=$O(^XVV(19200.112,"AKEY",RTN,VERSION,""))
 . I IEN S DESC=$P($G(^XVV(19200.112,IEN,0)),"^",3)
 Q:'IEN
 ;
 ;Update Description, Date & Text fields
 D UPDATE(IEN,DESC,0)
 W !!,"Version filed.",!
 Q
 ;
ADD2 ;Create version with no prompting
 NEW DEFAULT,DESC,IEN,VERSION
 ;
 S VERSION=$$DEFAULT(RTN)
 S IEN=$$CREATE(RTN,VERSION) ;...Create new entry
 S DESC="" ;...Initialize Description field value
 D UPDATE(IEN,DESC,1) ;...Update Description, Date & Text fields
 W !!,"Version filed.",!
 Q
 ;
PREVIOUS(RTN) ;Get list of previous versions for this routine.
 ;RTN=Name of routine
 ;Return string of versions. Example: ",1,2,"
 NEW LINE,VER
 S LINE=""
 S VER=0
 F  S VER=$O(^XVV(19200.112,"AKEY",RTN,VER)) Q:'VER  D  ;
 . S LINE=LINE_VER_","
 S:LINE]"" LINE=","_LINE
 Q LINE
 ;
DEFAULT(RTN) ;Get appropriate new version number for this routine.
 ;RTN=Name of routine
 Q 1+($O(^XVV(19200.112,"AKEY",RTN,""),-1))
 ;
CREATE(RTN,VER) ;Create a new version
 ;RTN=Routine name
 ;VER=Version number
 ;Return IEN or zero if no entry created.
 ;
 NEW D,DD,FDA,IEN,MSG
 S DD=19200.112
 S FDA(DD,"+1,",.01)=RTN
 S FDA(DD,"+1,",2)=VER
 D UPDATE^DIE("E","FDA","IEN","MSG")
 I $D(DIERR) Q 0
 Q IEN(1)
 ;
UPDATE(IEN,DESC,BYPASS) ;Update an existing version
 ;IEN : IEN to file 19200.112
 ;DESC: Description text
 ;BYPASS: 1=Don't edit Description field
 ;
 NEW D,D0,DA,DI,DIC,DIE,DQ,DR
 ;
 ;Edit Description field
 S DIE=19200.112
 S DA=IEN
 S DR="4///NOW"
 I $G(BYPASS)'=1 S DR=DR_";3"
 D ^DIE
 ;
 ;Stuff Routine text
 D WP^DIE(19200.112,IEN_",",20,"","^UTILITY("_$J_",0)")
 Q
