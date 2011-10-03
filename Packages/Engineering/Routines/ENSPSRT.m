ENSPSRT ;(WIRMFO)/DH-Sort by LOCATION ;6.18.97
 ;;7.0;ENGINEERING;**35,42**;Aug 17, 1993
GEN ;  Full SORT
 ;  Builds ENSRT(x) array
 N EN,ENI,I
 S ENSRT("DIV")=0 I $D(^ENG(6928.3,"D")) S ENSRT("DIV")=1
 I ENSRT("DIV") S DIR(0)="S^1:DIV, BLDG, WING, ROOM;2:DIV, WING, BLDG, ROOM;3:DIV, BLDG, ROOM;4:BLDG, WING, ROOM;5:WING, BLDG, ROOM;6:BLDG, ROOM;7:WING, ROOM;8:ROOM"
 E  S DIR(0)="S^1:BLDG, WING, ROOM;2:WING, BLDG, ROOM;3:BLDG, ROOM;4:WING, ROOM;5:ROOM"
 S DIR("A")="Choose 'SELECT BY' Parameters",DIR("B")=$S(ENSRT("DIV"):3,1:1)
 D ^DIR K DIR I $D(DIRUT) K ENSRT G EXIT
 I ENSRT("DIV") S ENSRT("BY")=$S(Y=1:"DBWR",Y=2:"DWBR",Y=3:"DBR",Y=4:"BWR",Y=5:"WBR",Y=6:"BR",Y=7:"WR",Y=8:"R",1:"")
 E  S ENSRT("BY")=$S(Y=1:"BWR",Y=2:"WBR",Y=3:"BR",Y=4:"WR",Y=5:"R",1:"")
 I ENSRT("BY")="" K ENSRT G EXIT ;Shouldn't happen
 S DIR(0)="Y",DIR("A")="Would you like to specify a range of LOCATIONS",DIR("B")="NO"
 S DIR("?",1)="  Enter 'YES' if you want only some "_$S(ENSRT("DIV"):"DIVISIONS, ",1:"")_"BUILDINGS, WINGS, or ROOMS."
 S DIR("?")="  Enter 'NO' if you want to include all LOCATIONS."
 D ^DIR K DIR I $D(DIRUT) K ENSRT G EXIT
 S ENSRT("LOC","ALL")=$S(Y:0,1:1) G:ENSRT("LOC","ALL") EXIT
 ;
 F ENI=1:1:$L(ENSRT("BY")) S PARAM=$E(ENSRT("BY"),ENI) D @PARAM Q:$D(DIRUT)
 G EXIT
 ;
D ;  DIVISION range
 S DIR("A",1)=""
 S DIR("A",2)="Enter individual DIVISIONS (ex: "_$O(^ENG(6928.3,"D",0))_") separated by comas, or a range of"
 S DIR("A",3)="DIVISIONS separated by a colon, or 'ALL' for all DIVISIONS. The '@'"
 S DIR("A",4)="character represents the empty set (no DIVISION), and 'ALL' includes"
 S DIR("A",5)="entries with no DIVISION."
 S DIR("A",6)=""
 S DIR("A",7)="   For example, 'OPC,JB:JBZ' would yield the OPC division and all divisions"
 S DIR("A",8)="   beginning with JB. The ""@"" character (which must be enclosed in double"
 S DIR("A",9)="   quotes) would yield entries having no division, and '@:C' would yield"
 S DIR("A",10)="   entries having no division and entries with a division beginning with '0'"
 S DIR("A",11)="   through '9' or 'A' through 'C' (numbers collate before letters)."
 S DIR("A",12)=""
 S DIR(0)="F^1:100",DIR("A")="Select DIVISION(S)"
 D ^DIR K DIR Q:$D(DIRUT)
 K EN F I=1:1 S EN(I)=$P(Y,",",I) Q:EN(I)=""
 S I=0 F  S I=$O(EN(I)) Q:EN(I)=""  D
 . I EN(I)="ALL" S ENSRT("DIV","ALL")="" Q
 . I EN(I)'[":" S:EN(I)="""@""" EN(I)="NULL" S ENSRT("DIV","AIND",EN(I))="" Q
 . I $P(EN(I),":",2)="@",$P(EN(I),":")'="@" Q
 . I $P(EN(I),":")="@" D  Q
 .. S ENSRT("DIV","FR",I)=""
 .. S ENSRT("DIV","TO",I)=$S($P(EN(I),":",2)="@":"",1:$P(EN(I),":",2)_"z")
 . I $P(EN(I),":")']$P(EN(I),":",2) D
 .. S ENSRT("DIV","FR",I)=$P(EN(I),":")
 .. S ENSRT("DIV","TO",I)=$P(EN(I),":",2)
 Q
B ;  BUILDING range
 S DIR("A",1)=""
 S DIR("A",2)="Enter individual BUILDINGS separated by comas, or a range of BUILDINGS"
 S DIR("A",3)="separated by a colon, or 'ALL' for all BUILDINGS."
 S DIR("A",4)=""
 S DIR("A",5)="   For example, '13,100:114A,65' would yield buildings 13 and 65 and all"
 S DIR("A",6)="   buildings from 100 thru 114A (inclusive)."
 S DIR("A",7)=""
 S DIR(0)="F^1:200",DIR("A")="Select BUILDING(S)",DIR("B")="ALL"
 D ^DIR K DIR Q:$D(DIRUT)
 K EN F I=1:1 S EN(I)=$P(Y,",",I) Q:EN(I)=""
 S I=0 F  S I=$O(EN(I)) Q:EN(I)=""  D
 . I EN(I)="ALL" S ENSRT("BLDG","ALL")="" Q
 . I EN(I)'[":" S:EN(I)="""@""" EN(I)="NULL" S ENSRT("BLDG","AIND",EN(I))="" Q
 . I $P(EN(I),":",2)="@",$P(EN(I),":")'="@" Q
 . I $P(EN(I),":")="@" D  Q
 .. S ENSRT("BLDG","FR",I)=""
 .. S ENSRT("BLDG","TO",I)=$S($P(EN(I),":",2)="@":"",1:$P(EN(I),":",2))
 . I $P(EN(I),":")']$P(EN(I),":",2) D
 .. S ENSRT("BLDG","FR",I)=$P(EN(I),":")
 .. S ENSRT("BLDG","TO",I)=$P(EN(I),":",2)
 Q
W ;  WING range
 S DIR("A",1)=""
 S DIR("A",2)="Enter individual WINGS separated by comas, or a range of WINGS separated"
 S DIR("A",3)="by a colon, or 'ALL' for all WINGS. The ""@"" (double quotes are necessary)"
 S DIR("A",4)="character represents null WINGS, and 'ALL' will include entries with no WING."
 S DIR("A",5)=""
 S DIR("A",6)="   For example, '4,3A:3C' would yield WINGS 4 and 3A through 3C (inclusive)."
 S DIR("A",7)="   The ""@"" character would yield only those entries having no WING."
 S DIR("A",8)="   Note that numbers collate before letters."
 S DIR("A",9)=""
 S DIR(0)="F^1:150",DIR("A")="Select WING(S)",DIR("B")="ALL"
 D ^DIR K DIR Q:$D(DIRUT)
 K EN F I=1:1 S EN(I)=$P(Y,",",I) Q:EN(I)=""
 S I=0 F  S I=$O(EN(I)) Q:EN(I)=""  D
 . I EN(I)="ALL" S ENSRT("WING","ALL")="" Q
 . I EN(I)'[":" S:EN(I)="""@""" EN(I)="NULL" S ENSRT("WING","AIND",EN(I))="" Q
 . I $P(EN(I),":",2)="@",$P(EN(I),":")'="@" Q
 . I $P(EN(I),":")="@" D  Q
 .. S ENSRT("WING","FR",I)=""
 .. S ENSRT("WING","TO",I)=$S($P(EN(I),":",2)="@":"",1:$P(EN(I),":",2)_"z")
 . I $P(EN(I),":")']$P(EN(I),":",2) D
 .. S ENSRT("WING","FR",I)=$P(EN(I),":")
 .. S ENSRT("WING","TO",I)=$P(EN(I),":",2)
 Q
R ;  ROOM range
 S DIR("A",1)=""
 S DIR("A",2)="Enter individual ROOMS separated by comas, or a range of ROOMS separated"
 S DIR("A",3)="by a colon, or 'ALL' for all ROOMS. The ""@"" character will not be accepted"
 S DIR("A",4)="because NULL ROOMS cannot exist."
 S DIR("A",4)=""
 S DIR("A",5)="  For example, '501,100:299' would yield all rooms numbered  501 and all"
 S DIR("A",6)="  rooms whose first three characters are between 100 and 299 (inclusive)."
 S DIR("A",7)="  Remember that numbers collate before letters."
 S DIR("A",8)=""
 S DIR(0)="F^1:200",DIR("A")="Select ROOM(S)",DIR("B")="ALL"
 D ^DIR K DIR Q:$D(DIRUT)
 K EN F I=1:1 S EN(I)=$P(Y,",",I) Q:EN(I)=""
 S I=0 F  S I=$O(EN(I)) Q:EN(I)=""  D  I Y["@" W !!,"The ROOM cannot possibly be NULL. Perhaps you mean 'ALL'." G R
 . I Y="ALL" S ENSRT("ROOM","ALL")="" Q
 . I Y["@" Q  ;Can't have null ROOMS
 . I Y'[":" S ENSRT("ROOM","AIND",EN(I))="" Q
 . I $P(EN(I),":")']$P(EN(I),":",2) D
 .. S ENSRT("ROOM","FR",I)=$P(EN(I),":")
 .. S ENSRT("ROOM","TO",I)=$P(EN(I),":",2)_"z"
 Q
 ;
EXIT K:$D(DIRUT) ENSRT
 Q
 ;ENSPSRT
