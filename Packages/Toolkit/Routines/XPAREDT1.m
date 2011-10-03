XPAREDT1 ; SLC/KCM - Supporting Calls - Entities; [3/31/03 7:19am] ;9/12/07  16:19
 ;;7.3;TOOLKIT;**26,109**;Apr 25, 1995;Build 5
 ;
BLDLST ; ...continued from BLDLST^XPAREDIT(LST,PAR)
 ; Build list of entities allowed for this parameter
 ; # is precedence, 'fixed' is VP to implied instance (i.e., SYS, PKG)
 ; .LST(#)=file number^message^order^prefix^fixed^lookup info
 ;     ("M", message) = #
 ;     ("P", prefix) = #
 ;  PAR=ien^name
 N IEN,SEQ,FN,X K LST ; make sure LST is empty initially
 S SEQ=0,LST=0
 F  S SEQ=$O(^XTV(8989.51,+PAR,30,"B",SEQ)) Q:'SEQ  S IEN=$O(^(SEQ,0)) D
 . S FN=$P(^XTV(8989.51,+PAR,30,IEN,0),"^",2) I FN=9.4,(DUZ(0)'["@") Q
 . S X=^XTV(8989.518,FN,0),X=FN_U_$P(X,U,3)_U_U_$P(X,U,2)
 . S LST=LST+1,LST(SEQ)=X
 . S LST("M",$$UPPER($P(X,U,2)))=SEQ
 . S LST("P",$P(X,U,4))=SEQ
 . ; find IEN's where only one entity instance is possible
 . I FN=9.4 D  ; find package to which this parameter belongs
 . . N PRN,PRE
 . . S PRN=$P($G(^XTV(8989.51,+PAR,0)),"^",1) Q:'$L(PRN)
 . . S PRE=PRN F  S PRE=$O(^DIC(9.4,"C",PRE),-1) Q:'$L(PRE)  Q:(PRE=$E(PRN,1,$L(PRE)))  I '($E(PRE,1)=$E(PRN,1)) S PRE="" Q
 . . Q:'$L(PRE)
 . . S X=$O(^DIC(9.4,"C",PRE,0))
 . . S $P(LST(SEQ),U,5)=X_";DIC(9.4,"
 . . S $P(LST(SEQ),U,6)=$P(^DIC(9.4,X,0),"^",1)
 . I FN=4.2 D  ; find domain for this system
 . . S X=$$KSP^XUPARAM("WHERE")
 . . S $P(LST(SEQ),U,5)=$$FIND1^DIC(4.2,"","QX",X)_";DIC(4.2,"
 . . S $P(LST(SEQ),U,6)=X
 . I FN=4 D  ; find division if this site not multi-divisional
 . . S X=$$KSP^XUPARAM("INST")
 . . I $P($G(^DIC(4,X,"DIV")),U,1)'="Y" D
 . . . S $P(LST(SEQ),U,5)=X_";DIC(4,"
 . . . S $P(LST(SEQ),U,6)=$P(^DIC(4,X,0),"^",1)
 . I '$L($P(LST(SEQ),U,5)) D  ; otherwise...
 . . S $P(LST(SEQ),U,6)=$P($G(^DIC(FN,0)),"^",1)
 Q
GETCLS ; ...continued from GETCLS^XPAREDIT(X,PAR,LST)
 ; Choose the class of entity
 ; optionally, lookup entity using variable pointer syntax (PRE.NAME)
 ;   .X=returns seq # or entity in VP format
 ;  PAR=ien^name for parameter
 ; .LST=list from which the entity is selected
 N TMP,DONE
 D SHWCLS
 S DONE=0 F  D  Q:DONE
 . W !,"Enter selection: " R X:DTIME S:'$T X="^" S X=$$UPPER(X)
 . I '$L(X)!(X="^")!(X="^^") S ENT="",DONE=1 Q
 . I $E(X)="?" D HLPCLS I $E(X,1,2)="??" D SHWCLS    ; help requested
 . I X=" " S X=$G(^DISV(DUZ,"XPAR01",+PAR)) Q:'X     ; spacebar recall
 . I +X,$D(LST(X)) S DONE=1 Q                        ; # -> seq #
 . I $D(LST("P",X)) S X=LST("P",X),DONE=1 Q          ; PRE -> seq #
 . I $D(LST("M",X)) S X=LST("M",X),DONE=1 Q          ; NAME -> seq #
 . S TMP=$O(LST("M",X))
 . I $E(TMP,1,$L(X))=X S X=LST("M",TMP),DONE=1 Q     ; PARTIAL -> seq #
 . I $L(X,".")>1,$D(LST("P",$P(X,".",1))) D  Q:DONE  ; if VP syntax
 . . S TMP=$P(X,".",2)
 . . D LOOKUP^XPAREDIT(.TMP,+LST(LST("P",$P(X,".",1)))) ; silent lookup
 . . I $L(TMP) S X=TMP,DONE=1                        ; PRE.NAME -> VP
 . W " ??" D HLPCLS                                  ; invalid entry
 I +X,X'[";" D  ;Don't show for resoved pointer p109
 . W "  ",$P(LST(X),U,2),"   ",$P(LST(X),U,6)  ; echo selection
 . I +LST(X)=9.4 D
 . . W !!,"Parameters set for 'Package' may be replaced if "
 . . W $P(LST(X),U,6),!,"is installed in this account."
 . S ^DISV(DUZ,"XPAR01",+PAR)=X
 Q
SHWCLS ; procedure used only by GETCLS
 ; show entity classes appropriate for this parameter
 N I,X
 W !!,$P(PAR,"^",2)," may be set for the following:",!!
 S I=0 F  S I=$O(LST(I)) Q:'I  S X=LST(I) D
 . W ?5,I,?9,$P(X,"^",2),?23,$P(X,U,4),?30
 . I $L($P(X,U,5)) W "["_$P(X,U,6)_"]",!
 . I '$L($P(X,U,5)) W "[choose from "_$P(X,U,6)_"]",!
 Q
HLPCLS ; procedure used only by GETCLS
 ; display help for entity class selection
 W !,"Enter the number, name, or abbreviation of the selection."
 W !,"You may also use variable pointer syntax (Example: LOC.WEST2)."
 Q
UPPER(X) ; function - convert lower to upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
