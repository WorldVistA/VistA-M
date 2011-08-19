XPAREDIT ;SLC/KCM - Simple Parameter Editor ;11:39 PM  12 May 1998
 ;;7.3;TOOLKIT;**26**;Apr 25, 1995
 ;
EN ; Enter here to select parameter, then entity
 ; ENT: variable pointer to the entity selected
 ; PAR: IEN^NAME of the selected parameter
 W !,?25,"--- Edit Parameter Values ---"
 N ENT,PAR,LST,JUST1,DIRUT,DUOUT,DTOUT
 F  W ! D GETPAR(.PAR) Q:'PAR  D  W !,$$DASH($S($D(IOM):IOM-1,1:78))
 . D BLDLST(.LST,PAR)
 . F  D GETENT(.ENT,PAR,.JUST1) Q:'ENT  D EDIT(ENT,PAR) Q:JUST1
 Q
TED(TLT,SHWFLG,ALLENT) ; Edit parameters using a template
 G TED^XPAREDT3
 ;
TEDH(TLT,SHWFLG,ALLENT) ; Edit parameters using a template, show dash headers
 G TEDH^XPAREDT3
 ;
TEDIT(ENT,PAR,INST,USRX) ; Edit an instance of a parameter
 I $G(INST)="" D EDITA S USRX=$G(Y("X")) I 1
 E  D EDIT1^XPAREDT2 S USRX=$G(Y("X"))
 I $E(USRX)=U,$E(USRX,2)'=U,$L(USRX)>1 K DTOUT,DUOUT,DIRUT
 Q
EDITPAR(PAR) ; Edit a single parameter
 ; add second parameter to limit entity type?  ENTTYP
 ; LOC,CLS,TEA,USR,DIV,SVC call LOOKUP with appropriate FN
 ; PKG,SYS figure out appropriate defaults (param nmsp, domain)
 N ENT
 I 'PAR S PAR=$O(^XTV(8989.51,"B",PAR,0))
 S PAR=PAR_U_$P(^XTV(8989.51,PAR,0),U,2)
 ; W $P(PAR,U,2)
 D GETENT(.ENT,PAR) Q:'ENT
 D EDIT(ENT,PAR)
 Q
GETPAR(Y) ; Select parameter to edit
 N DIC,DTOUT,DUOUT,X
 S DIC=8989.51,DIC(0)="AEMQ"
 S DIC("W")="W ""   "",$P(^(0),U,2)"
 D ^DIC I Y<1 S Y=0
 Q
GETENT(ENT,PAR,JUST1) ; Select entity to edit for a given parameter
 ; .ENT=entity, returned as variable pointer
 ;  PAR=ien^name
 N X,I,LST
 S JUST1=0
 D BLDLST(.LST,PAR) S ENT=""
 I LST=1 D                                ; if only one class of entity
 . S X=LST($O(LST(0))),ENT=$P(X,U,5)            ; instance for entity
 . I ENT S JUST1=1 Q                            ;   is fixed entry
 . I 'ENT D LOOKUP(.ENT,+X)                     ; not fixed - do lookup
 E  D                                     ; otherwise
 . D GETCLS(.X,PAR,.LST)                        ; choose class
 . I 'X S ENT="" Q                              ; nothing selected
 . I +X&(X[";") S ENT=X Q                       ; resolved VP returned
 . I $L($P(LST(X),U,5)) S ENT=$P(LST(X),U,5) Q  ; fixed instance
 . S ENT="" D LOOKUP(.ENT,+LST(X))              ; lookup on selected file
 Q
EDIT(ENT,PAR) ; Edit value(s) for entity/parameter
 N INST,X,Y
EDITA ; come here from TEDIT
 N ERR,INSTLST
 I '$D(NOHDR) W !!,$$CENTER("Setting "_$P(PAR,U,2)_" "_$$ENTDISP(ENT))
 I +$P(^XTV(8989.51,+PAR,0),U,3) F  D  Q:'$L(INST)!$D(DIRUT)  ; multiple
 . I $D(NOHDR) W !!,"For "_$P(PAR,U,2)_" -"
 . ; D SHWINST^XPAREDT2(ENT,+PAR,$S($D(IOSL):IOSL-4,1:20),0,.INSTLST)
 . D SELINST^XPAREDT2(.INST,ENT,+PAR) Q:'$L(INST)
 . W ! S Y="" D EDITVAL^XPAREDT2(.Y,+PAR,"I",INST) Q:(Y="")!($E(Y)=U)
 . I Y="@" D DEL^XPAR(ENT,+PAR,$P(INST,U),.ERR) D  Q
 . . I ERR W $$ERR^XPAREDT2 Q
 . . W "  ...deleted"
 . I $P(Y,U)'=$P(INST,U) D  I ERR W $$ERR^XPAREDT2 Q
 . . D REP^XPAR(ENT,+PAR,$P(INST,U),$P(Y,U),.ERR) S INST=Y
 . W "   ",$P(INST,U,2) D EDIT1^XPAREDT2
 E  S INST="1^1" D EDIT1^XPAREDT2 ;W ! before    ; single valued
 K ^TMP($J,"XPARWP")
 Q
BLDLST(LST,PAR) ; Build list of entities allowed for this parameter
 G BLDLST^XPAREDT1
 ;
GETCLS(X,PAR,LST) ; Choose the class of entity
 G GETCLS^XPAREDT1
 ;
LOOKUP(X,FN) ; Lookup entry in a file and return selection as varptr
 ; if X has data, pass that into lookup silently
 N DIC,DTOUT,DUOUT
 S DIC=FN
 S:$L(X) DIC(0)="M" S:'$L(X) DIC(0)="AEMQ"
 D ^DIC I $D(DTOUT)!$D(DUOUT)!(Y<1) S X="" Q
 S X=+Y_";"_$P($$ROOT^DILFD(FN),U,2)
 Q
ENTDISP(ENT) ; function - returns text descriptor of an entity
 Q:'ENT ""
 N X,FN
 S FN=+$P(@(U_$P(ENT,";",2)_"0)"),U,2),X=$P(^XTV(8989.518,FN,0),U,3)
 S X=" for "_X_": "_$$EXTPTR^XPARDD(+ENT,FN)
 Q X
CENTER(X) ; function - writes a centered title with dashes on either side
 N I,MAR
 S MAR=(($S($D(IOM):IOM,1:80)-$L(X))\2)-2
 Q $$DASH(MAR)_" "_X_" "_$$DASH(MAR)
DASH(N) ; function - returns N dashes
 N X
 S X="",$P(X,"-",N+1)=""
 Q X
