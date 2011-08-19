KMPDU2 ;OAK/RAK - CM Tools Routine Utilities ;7/22/04  09:06
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**2**;Mar 22, 2002
 ;
IRSRC(KMPDDA) ;-- extrinsic function - check for local mods in INSTALL file
 ;-----------------------------------------------------------------------
 ; KMPDDA... DA as defined in fileman programmers manual.
 ;
 ; Return: "NO"  - no local mods.
 ;         "YES" - local mods.
 ;
 ; This extrinsic function is called from computed field #573099 (LOCAL
 ; MODIFICATIONS) in file #9.7 (INSTALL).
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPDDA) "NO"
 ;
 N I,RTN,RETURN
 S I=0,RETURN="NO"
 F  S I=$O(^XPD(9.7,KMPDDA,"RTN",I)) Q:'I  D  Q:RETURN="YES"
 .Q:'$D(^XPD(9.7,KMPDDA,"RTN",I,0))  S RTN=$P(^(0),U)
 .S:$$ROUSRC1(RTN,"LOCAL MOD/") RETURN="YES"
 .;S:$$ROUSRC1(RTN,"/LOCAL MOD/") RETURN="YES"
 ;
 Q RETURN
 ;
ROUFIND(KMPDY,KMPDRNM,KMPDGBL) ;-- find routines.
 ;-----------------------------------------------------------------------
 ; KMPDRNM.. Routine name to search for.
 ; KMPDGBL... Global to store data.  Stored in format:
 ;              RoutineName^RoutineSize^Checksum
 ;-----------------------------------------------------------------------
 ;
 K KMPDY
 ;
 S KMPDRNM=$G(KMPDRNM),KMPDGBL=$G(KMPDGBL)
 ;
 I KMPDGBL="" S KMPDY="[Global for storage is not defined]" Q
 ;
 N DATA,LN,ROU,RTN,X,Y
 ;
 ; kill global with check for ^tmp or ^utility.
 D KILL^KMPDU(.DATA,KMPDGBL)
 ; if error.
 I $E(DATA)="[" S KMPDY=DATA Q
 ;
 S KMPDY=$NA(@KMPDGBL)
 ;
 ; if no asterisk (*) then look for routine.
 I KMPDRNM'["*" D  Q
 .; if routine name greater than 8 characters
 .I $L(KMPDRNM)>8 S @KMPDGBL@(0)="<"_KMPDRNM_" is greater than 8 characters>" Q
 .; if routine not defined.
 .I '$D(^$ROUTINE(KMPDRNM)) S @KMPDGBL@(0)="<Routine "_KMPDRNM_" not defined>" Q
 .; if defined.
 .S $P(@KMPDGBL@(0),U)=KMPDRNM
 .; checksum
 .S X=KMPDRNM X ^%ZOSF("RSUM") S $P(@KMPDGBL@(0),U,2)=Y
 ;
 ; remove "*" if any.
 S:$E(KMPDRNM,$L(KMPDRNM))="*" KMPDRNM=$E(KMPDRNM,1,$L(KMPDRNM)-1)
 S (ROU,RTN)=KMPDRNM,LN=0
 S ROU=$E(ROU,1,$L(ROU)-1)
 S ROU=ROU_$C(($A($E(KMPDRNM,$L(KMPDRNM)))-1))_"zz"
 F  S ROU=$O(^$ROUTINE(ROU)) Q:ROU=""!($E(ROU,1,$L(RTN))'=RTN)  D 
 .S $P(@KMPDGBL@(LN),U)=ROU
 .; checksum
 .S X=ROU X ^%ZOSF("RSUM") S $P(@KMPDGBL@(LN),U,2)=Y
 .S LN=LN+1
 ;
 S:'$D(@KMPDGBL) KMPDY(0)="<No Data To Report>"
 ;
 Q
 ;
ROUINQ(KMPDY,KMPDROU) ;-- routine inquiry.
 ;----------------------------------------------------------------------
 ; KMPDROU.. Routine(s) to search (this may be a partial name.
 ;----------------------------------------------------------------------
 ;
 K KMPDY
 ;
 S KMPDROU=$G(KMPDROU)
 I KMPDROU="" S KMPDY(0)="[Routine name not defined]" Q
 I '$D(^$ROUTINE(KMPDROU)) S KMPDY(0)="[Routine '"_KMPDROU_"' not defined]" Q
 ;
 N DIF,I,LN,ROU,X,XCNP
 ;
 S DIF="ROU(",XCNP=0
 S X=KMPDROU X ^%ZOSF("TEST")
 I '$T S KMPDY(0)="[Routine '"_KMPDROU_"' not defined]" Q
 X ^%ZOSF("LOAD")
 S (I,LN)=0
 F  S I=$O(ROU(I)) Q:'I  I $D(ROU(I,0)) D 
 .S KMPDY(LN)=ROU(I,0),LN=LN+1
 ;
 S:'$D(KMPDY) KMPDY(0)="[Unable to load routine]"
 ;
 Q
 ;
ROUSRC(KMPDY,KMPDROU,KMPDTXT) ;-- routine search
 ;----------------------------------------------------------------------
 ; KMPDROU.. Routine(s) to search (this may be a partial name.
 ; KMPDTXT.. Text to search for in routine.
 ;----------------------------------------------------------------------
 ;
 K KMPDY
 ;
 S KMPDROU=$G(KMPDROU),KMPDTXT=$$UP^XLFSTR($G(KMPDTXT))
 ;
 I KMPDROU="" S KMPDY(0)="[Routine(s) not defined]" Q
 ;
 I KMPDTXT="" S KMPDY(0)="[Search Text not defined]" Q
 ;
 N LN,RN,RTN,STAR
 ;
 S RTN=KMPDROU,STAR=$E(RTN,$L(RTN))
 S:STAR="*" RTN=$E(RTN,1,$L(RTN)-1)
 ;
 ; if just one routine.
 I STAR'="*" D  Q
 .; if match.
 .I $$ROUSRC1(RTN,KMPDTXT) S KMPDY(0)=RTN Q
 .; else no match.
 .S KMPDY(0)="<No Matches Found>"
 ;
 S RN=RTN,LN=0
 F  S RN=$O(^$ROUTINE(RN)) Q:RN=""!($E(RN,1,$L(RTN))'=RTN)  D 
 .; if match.
 .I $$ROUSRC1(RN,KMPDTXT) S KMPDY(LN)=RN,LN=LN+1 Q
 ;
 S:'$D(KMPDY) KMPDY(0)="<No Matches Found>"
 ;
 Q
 ;
ROUSRC1(KMPDROU,KMPDTXT) ;-- extrinsic function - check for text.
 ;----------------------------------------------------------------------
 ; KMPDROU.. Routine(s) to search (this may be a partial name.
 ; KMPDTXT.. Text to search for in routine.
 ;
 ; Return: 0 - no match.
 ;         1 - match.
 ;----------------------------------------------------------------------
 ;
 S KMPDROU=$G(KMPDROU),KMPDTXT=$$UP^XLFSTR($G(KMPDTXT))
 ;
 Q:KMPDROU="" 0
 Q:KMPDTXT="" 0
 ;
 N DIF,I,RETURN,ROU,X,XCNP
 ;
 S DIF="ROU(",(I,RETURN,XCNP)=0,RETURN=0
 S X=KMPDROU X ^%ZOSF("TEST")
 Q:'$T 0
 X ^%ZOSF("LOAD")
 F  S I=$O(ROU(I)) Q:'I  I $D(ROU(I,0)) D  Q:RETURN
 .I $$UP^XLFSTR(ROU(I,0))[KMPDTXT S RETURN=1
 ;
 Q RETURN
 ;
ROUSRC2(KMPDY,KMPDROU,KMPDTXT,KMPDGBL) ;-- search for text in routine.
 ;----------------------------------------------------------------------
 ; KMPDROU.. Routine(s) to search.
 ; KMPDTXT.. Text to search for in routine.
 ; KMPDGBL... Global to store data.
 ;-----------------------------------------------------------------------
 ;
 K KMPDY
 ;
 S KMPDROU=$G(KMPDROU),KMPDGBL=$G(KMPDGBL)
 ;
 I KMPDGBL="" S KMPDY="[Global for storage is not defined]" Q
 ;
 N DATA,DIF,I,LABEL,LN,OFFSET,ONE,ROU,RTN,X,XCNP
 ;
 ; kill global with check for ^tmp or ^utility.
 D KILL^KMPDU(.DATA,KMPDGBL)
 ; if error.
 I $E(DATA)="[" S KMPDY=DATA Q
 ;
 S KMPDY=$NA(@KMPDGBL)
 ;
 S KMPDROU=$G(KMPDROU),KMPDTXT=$$UP^XLFSTR($G(KMPDTXT))
 ;
 I KMPDROU="" S @KMPDGBL@(0)="[Routine(s) name not defined]" Q
 I KMPDTXT="" S @KMPDGBL@(0)="[Search text not defined]" Q
 ;
 S ONE=1
 ; remove "*" if any.
 I $E(KMPDROU,$L(KMPDROU))="*" D 
 .S KMPDROU=$E(KMPDROU,1,$L(KMPDROU)-1)
 .S ONE=0
 ; get ready to $order.
 S RTN=KMPDROU
 S DATA=KMPDROU
 S DATA=$E(DATA,1,$L(DATA)-1)
 S DATA=DATA_$C(($A($E(KMPDROU,$L(KMPDROU)))-1))_"zz"
 S KMPDROU=DATA
 ;
 S ROU=KMPDROU,LN=0
 F  S ROU=$O(^$ROUTINE(ROU)) Q:ROU=""!($E(ROU,1,$L(RTN))'=RTN)  D  Q:ONE
 .K ROUT
 .S DIF="ROUT(",(I,OFFSET,XCNP)=0,LABEL=ROU
 .S X=ROU X ^%ZOSF("TEST") Q:'$T
 .X ^%ZOSF("LOAD")
 .F  S I=$O(ROUT(I)) Q:'I  I $D(ROUT(I,0)) D 
 ..S OFFSET=OFFSET+1
 ..; if new label.
 ..I $E(ROUT(I,0))'=" " S LABEL=$$ROULABEL^KMPDU2(ROUT(I,0)),OFFSET=0
 ..; quit if no match.
 ..Q:$$UP^XLFSTR(ROUT(I,0))'[KMPDTXT
 ..S @KMPDGBL@(LN)=ROU_"^"_LABEL_$S(OFFSET:"+"_OFFSET,1:"")_"  "_ROUT(I,0)
 ..S LN=LN+1
 ;
 S:'$D(@KMPDGBL) @KMPDGBL@(0)="<No Match Found>"
 ;
 Q
 ;
ROULABEL(TEXT) ;-- routine label.
 Q:$G(TEXT)="" ""
 N I,LABEL
 S LABEL=""
 F I=1:1 Q:$E(TEXT,I)=" "!($E(TEXT,I)="(")  S LABEL=$E(TEXT,0,I)
 Q LABEL
