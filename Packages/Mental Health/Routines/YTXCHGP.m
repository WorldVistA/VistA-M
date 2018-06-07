YTXCHGP ;SLC/KCM - MH Exchange Prompting ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**121**;Dec 30, 1994;Build 61
 ;
LKUP(FILE) ; Lookup Mental Health Instrument & return IEN
 ; returns IEN, 0 for no selection, -1 for up-arrow or timeout
 N DIC,X,Y,DTOUT,DUOUT
 S DIC=FILE,DIC(0)="AEMQ" D ^DIC
 S:Y<1 Y=0 S:$G(DUOUT)!$G(DTOUT) Y=-1
 Q +Y
 ;
LIST(FILE,ENTRIES) ; Lookup in File to make list of ENTRIES
 ;.ENTRIES=total
 ;.ENTRIES(n)=ien
 N I,IEN
 S ENTRIES=0
 F I=1:1 S IEN=$$LKUP(FILE) Q:IEN<1  S ENTRIES=I,ENTRIES(I)=IEN
 I IEN<0 K ENTRIES S ENTRIES=0  ; ^out or timeout
 Q
PRMTNAME(ASK,HELP,MAX) ; Prompt using ASK and return text or ""
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S MAX=$G(MAX,64)
 S DIR(0)="FO^3:"_MAX,DIR("A")=ASK S:$L($G(HELP)) DIR("?")=HELP
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S Y=""
 S Y=$$TRIM^XLFSTR(Y)
 Q Y
 ;
CONFIRM(ASK,DFLT) ; return true if user confirms
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YA",DIR("A")=ASK,DIR("B")=$G(DFLT,"YES")
 D ^DIR
 I $G(DUOUT)!$G(DTOUT) S Y=-1
 Q +Y
 ;
PAUSE() ; prompt user for return to continue
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="EA",DIR("A")="Press return to continue..."
 D ^DIR
 Q
EDITWP(INSTRUCT,DEST) ; Edit word processing text in DEST
 ; INSTRUCT: instructions to user
 ;     DEST: global reference for WP text
 I $E($RE(DEST))=")" S $E(DEST,$L(DEST))=","
 W !,INSTRUCT," --"
 N DIC,DDWFLAGS,DWLW,DWPK
 N I,J,X,X1  ; variables that DIWE seems to leave around
 S DIC=DEST,DDWFLAGS="Q",DWLW=72,DWPK=1
 D EN^DIWE
 I '$D(@(DEST_"1,0)")) D
 . S @(DEST_"0)")="^^1^1^"_DT_"^"
 . S @(DEST_"1,0)")="(no description)"
 Q
PICKTEST(TREE) ; Return a string of instruments selected]
 N I,X,T,TESTS
 S I=0 F  S I=$O(@TREE@("test",I)) Q:'I  D
 . S TESTS=I
 . S TESTS(I)=@TREE@("test",I,"info","name")
 . S TESTS("B",$$LOW^XLFSTR(TESTS(I)))=I
 I TESTS=1 Q 1  ; no prompting if only 1 tests
 ;
 F  D  Q:X'["?"
 . D TESTLIST
 . W !!,"Choose instrument to browse: "
 . R X:DTIME S:$E(X)="^" X="" Q:X=""
 . S X=$$LOW^XLFSTR(X)
 . I +X,$D(TESTS(X)) Q                    ; number entered
 . I $D(TESTS("B",X)) S X=TESTS("B",X) Q  ; full name entered
 . S T=$O(TESTS("B",X))                   ; partial name entered
 . I X=$E(T,1,$L(X)) W "  ",T S X=TESTS("B",T) Q
 . W "  ??",! S X="?"                     ; no match
 Q X
 ;
TESTLIST ; Show a list of tests
 ; expects TESTS,TREE from PICKTEST
 W !,"Instruments contained in ",@TREE@("xchg","name")," are:"
 S I=0 F  S I=$O(TESTS(I)) Q:'I  W !,$J(I,4),?7,TESTS(I)
 Q
SHOSUMM(YTXLOG,YTXDRY) ; Display summary log information
 ; may be called during KIDS build, so uses MES^XPDUTL
 N MSG
 I $G(YTXLOG("conflict")) D
 . N I S I=0 F  S I=$O(YTXLOG("conflict",I)) Q:'I  D
 . . S MSG="Conflict -- "_YTXLOG("conflict",I)
 . . D MES^XPDUTL(MSG)
 . S MSG="Conflicts with existing instruments prevent installation."
 . D LOG^YTXCHGU("error",MSG)
 . S MSG="Contact national support to resolve the conflicts."
 . D MES^XPDUTL(MSG)
 S MSG="  "_$G(YTXLOG("added"),0)_" records "_$S(YTXDRY:"would be ",1:"")_"added."
 D MES^XPDUTL(MSG)
 S MSG="  "_$G(YTXLOG("updated"),0)_" records "_$S(YTXDRY:"would be ",1:"")_"updated."
 D MES^XPDUTL(MSG)
 S MSG="  "_$G(YTXLOG("deleted"),0)_" records "_$S(YTXDRY:"would be ",1:"")_"deleted."
 D MES^XPDUTL(MSG)
 S MSG="  "_$G(YTXLOG("error"),0)_" errors."
 D MES^XPDUTL(MSG)
 Q
