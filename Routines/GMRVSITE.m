GMRVSITE ;HIOFO/YH,FT-V/M SITE FILE EDIT/ENTRY ;2/17/05  14:38
 ;;5.0;GEN. MED. REC. - VITALS;**8**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
 ; This routine supports the following IAs:
 ; #1938 - CHAR & DEFAULT entry points     (private)
 ;
CHAR ;Enter/edit qualifier
 ; Due to the data standardization project, the package will no
 ; longer allow users to modify FILE 120.52.
 Q
DEFAULT ;Enter/edit location default for TEMP./PULSE
 N DA,I
 N GMRDEF,GMRVCAT,GMRVIT,GMRX,GMRV,GMRY,GMROUT
 S GMROUT=0,GMRVCAT="LOCATION"
 S GMRVCAT(1)=$O(^GMRD(120.53,"B",GMRVCAT,0))
 Q:GMRVCAT(1)'>0
 Q:$$ACTIVE^GMVUID(120.53,"",GMRVCAT(1)_",","")  ;active vuid?
 F GMRVIT(1)="TEMPERATURE","PULSE" D
 .S GMRVIT=$O(^GMRD(120.51,"B",GMRVIT(1),0)) Q:GMRVIT'>0!GMROUT  D
 ..Q:$$ACTIVE^GMVUID(120.51,"",GMRVIT_",","")  ;active vuid?
 ..S DA(1)=GMRVCAT(1),DA=$O(^GMRD(120.53,DA(1),1,"B",GMRVIT,0)) Q:DA'>0
 ..I '$D(^GMRD(120.53,DA(1),1,DA,0)) Q
 ..S GMRDEF=+$P(^GMRD(120.53,DA(1),1,DA,0),"^",7)
 ..I $$ACTIVE^GMVUID(120.52,"",GMRDEF_",","") D
 ...D CAT2^GMVUID(DA(1),DA)
 ...S GMRDEF=""
 ...Q
 ..S GMRDEF=$S($D(^GMRD(120.52,+GMRDEF,0)):$P(^(0),"^"),1:"")
 ..D GETQUAL
 ..Q:GMRV'>0
 ..D SELECT
 ..Q
 .Q
 Q
SELECT ;
 W !!,GMRVIT(1)_" has the following location qualifiers:",!
 F I=1:1:GMRV W !,I_"  "_$P(GMRV(I),"^")
 W !!,"Enter a number for "_GMRVIT(1)_" default qualifier",!,"or ^ to quit or @ to delete: "_$S(GMRDEF'="":GMRDEF_"// ",1:"")
 S GMRX="" R GMRX:DTIME
 I '$T!(GMRX["^") S GMROUT=1 Q
 Q:GMRX=""
 G:$L(GMRX)>4 SELECT
 I GMRX["?" W !,"Enter an appropriate qualifier as a default qualifier for this type of",!,"vital measurement",! G SELECT
 I GMRX="@" S $P(^GMRD(120.53,DA(1),1,DA,0),"^",7)="" W:GMRDEF'="" !,GMRDEF_" has been deleted" Q
 I '$D(GMRV(GMRX)) W !,"ERROR ENTRY!!!",! G SELECT
 S $P(^GMRD(120.53,DA(1),1,DA,0),"^",7)=$P(GMRV(GMRX),"^",2)
 W "   ",$P(GMRV(GMRX),"^")
 Q
GETQUAL ;Extract qualifiers for the VITAL TYPE and the CATEGORY
 K GMRV
 S GMRV=0,GMRX=""
 F  S GMRX=$O(^GMRD(120.52,"AA",GMRVIT,1,GMRX)) Q:GMRX=""  D
 .S GMRY=0
 .F  S GMRY=$O(^GMRD(120.52,"AA",GMRVIT,1,GMRX,GMRY)) Q:GMRY'>0  D
 ..Q:$$ACTIVE^GMVUID(120.52,"",GMRY_",","")  ;active vuid?
 ..S GMRV=GMRV+1
 ..S GMRV(GMRV)=$P(^GMRD(120.52,GMRY,0),"^")_"^"_GMRY
 ..Q
 .Q
 Q
