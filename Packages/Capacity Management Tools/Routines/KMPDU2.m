KMPDU2 ;OAK/RAK - CM Tools Routine Utilities ;08/31/11  09:21
 ;;3.0;KMPD;;Jan 22, 2009;Build 42
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
 I KMPDRNM="" S KMPDY="[Routine not defined]" Q
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
 ; remove all spaces
 S KMPDRNM=$TR(KMPDRNM," ","")
 ; if just one routine
 I $E(KMPDRNM,$L(KMPDRNM))'["*" D  Q
 .; if invalid routine name
 .I '$$ROUNAME(KMPDRNM) S @KMPDGBL@(0)="<"_KMPDRNM_" contains invalid characters or is greater than 8 characters length>" Q
 .; if routine not defined.
 .I '$D(^$ROUTINE(KMPDRNM)) S @KMPDGBL@(0)="<Routine "_KMPDRNM_" not defined>" Q
 .I $G(^%ZOSF("OS"))["OpenM",'$D(^ROUTINE(KMPDRNM)) S @KMPDGBL@(0)="<Routine "_KMPDRNM_" missing source code>" Q
 .; if defined.
 .S $P(@KMPDGBL@(0),U)=KMPDRNM
 .; checksum
 .S X=KMPDRNM X ^%ZOSF("RSUM1") S $P(@KMPDGBL@(0),U,2)=Y
 ;
 ; remove "*" if any.
 S:$E(KMPDRNM,$L(KMPDRNM))="*" KMPDRNM=$E(KMPDRNM,1,$L(KMPDRNM)-1)
 I '$$ROUNAME(KMPDRNM) S @KMPDGBL@(0)="<"_KMPDRNM_" contains invalid characters or is greater than 8 characters in length>" Q
 S ROU=$$ENDCHAR(KMPDRNM),RTN=KMPDRNM,LN=0
 F  S ROU=$O(^$ROUTINE(ROU)) Q:ROU=""!($E(ROU,1,$L(RTN))'=RTN)!(LN>1000)  D
 .I $G(^%ZOSF("OS"))["OpenM",'$D(^ROUTINE(ROU)) S @KMPDGBL@(LN)=ROU_"^no source",LN=LN+1 Q
 .S $P(@KMPDGBL@(LN),U)=ROU
 .; checksum
 .S X=ROU X ^%ZOSF("RSUM1") S $P(@KMPDGBL@(LN),U,2)=Y
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
 I '$$ROUNAME(KMPDROU) S @KMPDGBL@(0)="<"_KMPDROU_" contains invalid characters or is greater than 8 characters in length>" Q
 I '$D(^$ROUTINE(KMPDROU)) S KMPDY(0)="[Routine '"_KMPDROU_"' not defined]" Q
 ;
 N DIF,I,LN,ROU,X,XCNP
 ;
 S DIF="ROU(",XCNP=0
 S X=KMPDROU X ^%ZOSF("TEST")
 I '$T S KMPDY(0)="[Routine '"_KMPDROU_"' not defined]" Q
 I $G(^%ZOSF("OS"))["OpenM",'$D(^ROUTINE(KMPDROU)) S KMPDY(0)="[Unable to load routine - no source code]" Q
 X ^%ZOSF("LOAD")
 S (I,LN,LN(0))=0
 F  S I=$O(ROU(I)) Q:'I  I $D(ROU(I,0)) D
 .S X=$P(ROU(I,0)," ",1),ROU(I,0)=$P(ROU(I,0)," ",2,999)
 .I $A($E(X))>32 S LN(0)=0
 .I LN(0)>0,(LN(0)#10)=0 S X="[+"_LN(0)_"]"
 .S KMPDY(LN)=$$LJ^XLFSTR(X,8," ")_ROU(I,0),LN=LN+1,LN(0)=LN(0)+1
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
 I KMPDTXT="" S KMPDY(0)="[Search Text not defined]" Q
 ;
 N LN,RN,RTN,STAR
 ;
 S RTN=KMPDROU,STAR=$E(RTN,$L(RTN))
 S:STAR="*" RTN=$E(RTN,1,$L(RTN)-1)
 ;
 ; if just one routine.
 I STAR'="*" D  Q
 .I '$$ROUNAME(RTN) S @KMPDGBL@(0)="<"_RTN_" contains invalid characters or is greater than 8 characters in length>" Q
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
 I $G(^%ZOSF("OS"))["OpenM",'$D(^ROUTINE(KMPDROU)) Q
 X ^%ZOSF("LOAD")
 F  S I=$O(ROU(I)) Q:'I  I $D(ROU(I,0)) D  Q:RETURN
 .I $$UP^XLFSTR(ROU(I,0))[KMPDTXT S RETURN=1
 ;
 Q RETURN
 ;
ROUSRC2(KMPDY,KMPDTXT,KMPDGBL,KMPDROU) ;-- search for text in routine.
 ;----------------------------------------------------------------------
 ; KMPDTXT..  Text to search for in routine.
 ; KMPDGBL... Global to store data.
 ; KMPDROU..  array containing routine names to be searches.
 ;-----------------------------------------------------------------------
 ;
 K KMPDY
 ;
 S KMPDTXT=$G(KMPDTXT),KMPDGBL=$G(KMPDGBL)
 ;
 I '$D(KMPDROU) S @KMPDGBL@(0)="[Routine(s) name not defined]" Q
 I KMPDTXT="" S @KMPDGBL@(0)="[Search text not defined]" Q
 I KMPDGBL="" S KMPDY="[Global for storage is not defined]" Q
 ;
 N DATA,DIF,I,LABEL,LN,OFFSET,ROU,RTN,X,XCNP
 ;
 ; kill global with check for ^tmp or ^utility.
 D KILL^KMPDU(.DATA,KMPDGBL)
 ; if error.
 I $E(DATA)="[" S KMPDY=DATA Q
 ;
 S KMPDY=$NA(@KMPDGBL)
 ;
 S KMPDTXT=$$UP^XLFSTR(KMPDTXT)
 ;
 S ROU="",LN=0
 F  S ROU=$O(KMPDROU(ROU)) Q:ROU=""  D
 .K ROUT
 .S DIF="ROUT(",(I,OFFSET,XCNP)=0,LABEL=ROU
 .S X=ROU X ^%ZOSF("TEST") Q:'$T
 .I $G(^%ZOSF("OS"))["OpenM",'$D(^ROUTINE(ROU)) Q
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
 ;
ROUNAME(KMPDRNM) ;-- extrinsic function - determine if routine name is valid
 ;--------------------------------------------------------------------
 ; KMPDRNM... free text - routine name
 ;--------------------------------------------------------------------
 ; routine name must begin with alpha and then be 1 to 7 additional
 ; alpha or numeric characters.
 S KMPDRNM=$G(KMPDRNM)
 Q KMPDRNM?1A!(KMPDRNM?1A1.7AN)!(KMPDRNM?1"%"1.7AN)
 ;
ENDCHAR(RTN) ;-- extrinsic function - determine last character for $ordering
 ;--------------------------------------------------------------------
 ; RTN - routine name
 ;--------------------------------------------------------------------
 Q:$G(RTN)="" ""
 ; less than one
 Q:($A($E(RTN,$L(RTN)))<49) $E(RTN,1,$L(RTN)-1)
 ; numbers
 Q:($A($E(RTN,$L(RTN)))<58) $E(RTN,1,$L(RTN)-1)_$C(($A($E(RTN,$L(RTN)))-1))_"z"
 ; if RTN = 'A'
 Q:RTN="A" "%z"
 ; if 'A' then use '%'
 Q:($E(RTN,$L(RTN))="A") $E(RTN,1,$L(RTN)-1)_"9z"
 ; if 91 through 97
 Q:($A($E(RTN,$L(RTN)))>90)&($A($E(RTN,$L(RTN)))<98) $E(RTN,1,$L(RTN)-1)_"Z"
 ; if lowercase
 Q:($A($E(RTN,$L(RTN)))<123) $E(RTN,1,$L(RTN)-1)_$C(($A($E(RTN,$L(RTN)))-1))_"z"
 ; if greater than 122
 Q:($A($E(RTN,$L(RTN)))>122) $E(RTN,1,$L(RTN)-1)_"y"
 ; default
 Q RTN
