YTXUTL ;SLC/KCM - Debug Utilities ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**121**;Dec 30, 1994;Build 61
 ;
 ; View instrument spec as a tree
 ;
VIEWTREE ;
 N DIC,X,Y
 S DIC="^YTT(601.95,",DIC(0)="AEMQ" D ^DIC Q:'Y
 K ^TMP($J)
 D SPEC2TR^YTXCHGT(+Y,$NA(^TMP($J)))
 W !,"Use ^TMP($J) to view tree"
 Q
 ; Look for usages of an ID (question ID, display ID, etc.) in the MHA files.
 ; Can be used, for example, to see if a question is used by multiple tests.
 ;
QLOOP(IDFILE) ; Repeat prompt for ID to search for usages
 ; IDFILE:  Reference file where the ID resides
 N X
 F  W !,"IEN: " R X:DTIME Q:'$L(X)  D
 . W ?20,$G(^YTT(IDFILE,+X,0))
 . D QUSAGE(+X,IDFILE)
 Q
QUSAGE(ID,IDFILE) ; Search files for usage of QUEST
 ;     ID: Identifier (IEN) that we are finding usages of
 ; IDFILE: File number -- tells which file:field map to use
 N I,X,MAP,QMAP,FILE,PIECE,IEN,TESTP
 ; Build the map -- MAP(file,piece)=testPiece
 S QMAP="Q"_$P(IDFILE,".",2)
 F I=1:1 S X=$P($T(@QMAP+I),";;",2,99) Q:X="zzzzz"  D
 . S MAP($P(X,U),$P(X,U,2))=$P(X,U,3)
 ; Search thru files, pieces for usage of ID
 S FILE=0 F  S FILE=$O(MAP(FILE)) Q:'FILE  D
 . S PIECE=0 F  S PIECE=$O(MAP(FILE,PIECE)) Q:'PIECE  D
 . . S TESTP=MAP(FILE,PIECE)
 . . S IEN=0 F  S IEN=$O(^YTT(FILE,IEN)) Q:'IEN  D
 . . . I $P(^YTT(FILE,IEN,0),U,PIECE)=ID D QOUT(FILE,IEN,TESTP)
 Q
QCTYP(ID) ; Find instruments using this choice type
 S IEN=0 F  S IEN=$O(^YTT(601.72,IEN)) Q:'IEN  D
 . I $P($G(^YTT(601.72,IEN,2)),U,3)=ID D QUSAGE(IEN,601.72)
 Q
QOUT(FILE,IEN,TESTP) ; Write out using IEN, Instrument
 ;  FILE: file number that contains the usage
 ;   IEN: IEN of the usage
 ; TESTP: piece number of the instrument pointer (or S or R)
 N TEST
 I TESTP S TEST=$P(^YTT(FILE,IEN,0),U,TESTP)
 I TESTP="R" D  ; from rule file (601.82)
 . N RULE S RULE=+^YTT(601.82,IEN,0)
 . S TEST=$P(^YTT(601.83,IEN,0),U,2)
 I TESTP="S" D  ; from scoring key file (601.91)
 . N SCALE S SCALE=$P(^YTT(601.91,IEN,0),U,2)
 . N GROUP S GROUP=$P(^YTT(601.87,SCALE,0),U,2)
 . S TEST=$P(^YTT(601.86,GROUP,0),U,2)
 W !,FILE," IEN:",IEN,?20,"Instrument: ",$P($G(^YTT(601.71,TEST,0)),U)
 Q
