DIAC1 ;SLCISC/KCM,MKB - Policy Evaluation API's ;17FEB2017
 ;;22.2;VA FileMan;**8**;Jan 05, 2016;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
CANDO(DIFN,DIENS,DIACTN,DIUSR,DIVAL,DIFLDS,DITXT,DIERROR) ;main API
 ; Can user take requested action on [given record in] this file?
 ; 
 ; Returns 1 = Yes (permit)
 ;         0 = No  (deny)
 ;        "" = Undetermined/no applicable policy
 ;        -1 = Error
 ;
 N DIPOL,DIACT,DIUSRNM,DIRESULT,Y
 D CLEAN^DILF K DIFLDS
 S DIRESULT=""
 ;
 ; validate input parameters
 S:$G(DIUSR)="" DIUSR=DUZ
 I '$D(^VA(200,+DIUSR,0)) D ERROR(202,"USER") Q
 S DIUSRNM=$P($G(^VA(200,+DIUSR,0)),U)
 ;
 I $G(DIACTN),DIACTN=+DIACTN D  G CQ:$G(DIERR),C1 ;IEN vs name
 . N X0 S X0=$G(^DIAC(1.61,+DIACTN,0))
 . I X0="" D ERROR(202,"ACTION") Q
 . S DIACT=+DIACTN,DIACTN=$P(X0,U,3),DIPOL=$P(X0,U,5)
 . S:'$G(DIFN) DIFN=$P(X0,U,2)
 ;
 I $G(DIFN)="" D ERROR(202,"FILE") G CQ
 I '$$VFILE^DILFD(DIFN) D ERROR(401,DIFN) G CQ
 I $G(DIENS),'$$VIENS(DIENS,DIFN) G CQ
 I $G(DIACTN)="" D ERROR(202,"ACTION") G CQ
 ;
C1 ; find & evaluate policy
 S:'$G(DIPOL) DIPOL=$$FIND(DIFN,DIACTN),DIACT=+$P(DIPOL,U,2)
 I DIPOL S DIPOL=+DIPOL D EN
 ;
CQ ;return result
 S Y=$S($G(DIERR):-1,DIRESULT="P":1,DIRESULT="D":0,1:"")
 I Y>0,'$L($G(DIFLDS)) D FIELDS(DIACT,1.61)
 Q Y
 ;
FIND(FILE,ACTION) ; -- find matching Event, return Policy^Event iens
 N I,X,Y S Y=""
 I $G(FILE)<1!($G(ACTION)="") G FQ
 S I=0 F  S I=+$O(^DIAC(1.61,"C",FILE,$$UP^XLFSTR(ACTION),I)) Q:I<1  D  Q:Y
 . S X=$P(^DIAC(1.61,I,0),U,5) ;default policy for event
 . I X S Y=X_U_I
FQ Q Y
 ;
EN ; -- process policy DIPOL, returns DIRESULT (P/D)
 ; Expects all input parameters from $$CANDO to be defined and valid
 ; If DIZTRACE = true, the execution trace will be captured
 ;
 I +$G(DIPOL)'>0 D ERROR(330,$G(DIPOL),"POLICY") Q
 I $$DISABLED(DIPOL) D:$G(DIZTRACE) TRACE(DIPOL,0,-1) Q  ;error??
 ;
 N DIFCN,DITYPE,DISTK,DISEQ,DIACMSG
 S:'$L($G(DITXT)) DITXT=$NA(^TMP("DIMSG",$J))
 ;
 D FCN(DIPOL)
 S DITYPE=$P($G(^DIAC(1.6,DIPOL,0)),U,2),DISTK=0
 I DITYPE="P" S DIRESULT=$$POLICY(DIPOL) G ENQ
 I DITYPE'="S" D ERROR(330,$G(DIPOL),"primary policy") Q
 D:$G(DIZTRACE) TRACE(DIPOL,DISTK,1)
 ;
 ; initialize stack if a set, loop until DONE
 ;   DISTK = stack level being processed
 ;   DISTK(DISTK) = parent Policy IEN ^ SEQ of last member processed
 S DISTK=1,DISTK(DISTK)=DIPOL_"^0",DISTK(0)=0,DISEQ=0
 F  S DISEQ=$O(^DIAC(1.6,+DISTK(DISTK),10,"AC",DISEQ)) D @$S($$DONE(+DISTK(DISTK)):"POP",+DISEQ'>0:"POP",1:"PROC") Q:DISTK<1
 ;
ENQ ; exit
 I DIRESULT="" S DIRESULT=$G(DIFCN(DIPOL,"NULL"))
 I DIRESULT'="",$D(DIACMSG(DIRESULT)) D  ;get messages
 . S DIMSG=+$G(DIACMSG(DIRESULT)) Q:DIMSG<1
 . M @DITXT=DIACMSG(DIRESULT)
 Q
 ;
POP ; -- pop the stack [set]
 D:$G(DIZTRACE) TRACE(+DISTK(DISTK),DISTK-1,2)
 ;
 ; tie up current level
 I DIRESULT="" S DIRESULT=$G(DIFCN(+DISTK(DISTK),"NULL"))
 I $L(DIRESULT) D ADDMSG(+DISTK(DISTK),DIRESULT),OBLIG(+DISTK(DISTK),DIRESULT),FIELDS(+DISTK(DISTK),1.6)
 ;
 ; pop the stack
 S DISTK=DISTK-1,DISEQ=$P(DISTK(DISTK),U,2)
 Q
 ;
PROC ; -- process member
 N DIEM
 S $P(DISTK(DISTK),U,2)=DISEQ
 S DIEM=+$O(^DIAC(1.6,+DISTK(DISTK),10,"AC",DISEQ,0)) Q:DIEM<1
 D FCN(DIEM)
 ;
 ; if target doesn't match, save item in Trace & quit to next sibling
 I '$$MATCH(DIEM) D:$G(DIZTRACE) TRACE(DIEM,DISTK,0) Q
 I $$DISABLED(DIEM) D:$G(DIZTRACE) TRACE(DIEM,DISTK,-1) Q
 ;
 ; if policy set, push stack and reset member loop
 I $P($G(^DIAC(1.6,DIEM,0)),U,2)="S" D  Q
 . D:$G(DIZTRACE) TRACE(DIEM,DISTK,1)
 . S DISTK=DISTK+1,DISTK(DISTK)=DIEM_"^0",DISEQ=0
 ;
 ; else evaluate policy
 S DIRESULT=$$POLICY(DIEM)
 Q
 ;
POLICY(DIEN) ; -- loop on matching rules of policy DIEN
 N DIRESULT,DISEQ,DIRULE,DIEFFECT Q:$G(DIEN)<1
 D:$G(DIZTRACE) TRACE(DIEN,DISTK,1)
 ;
 S DISEQ=0,DIRESULT="" ;loop on rules, process if target matches:
 F  S DISEQ=$O(^DIAC(1.6,DIEN,10,"AC",DISEQ)) Q:DISEQ<1  D  I $$DONE(DIEN) D:$G(DIZTRACE) TRACE(DIEN,DISTK,2) Q
 . S DIRULE=+$O(^DIAC(1.6,DIEN,10,"AC",DISEQ,0)) Q:DIRULE<1
 . D FCN(DIRULE)
 . I '$$MATCH(DIRULE) D:$G(DIZTRACE) TRACE(DIRULE,DISTK+1,0) Q
 . I $$DISABLED(DIRULE) D:$G(DIZTRACE) TRACE(DIRULE,DISTK+1,-1) Q
 . D:$G(DIZTRACE) TRACE(DIRULE,DISTK+1,1)
 . ;
 . S DIEFFECT=$P($G(^DIAC(1.6,DIRULE,0)),U,8)
 . I $$COND(DIRULE) S DIRESULT=DIEFFECT  ; true -> return Effect
 . E  S DIRESULT=$TR(DIEFFECT,"PD","DP") ;false -> return opposite
 . ;
 . I $L(DIRESULT) D ADDMSG(DIRULE,DIRESULT),OBLIG(DIRULE,DIRESULT),FIELDS(DIRULE,1.6)
 . S:$G(DIZTRACE) $P(DIZTRACE(DIZ),U,4)=DIRESULT
 I DISEQ<1 D:$G(DIZTRACE) TRACE(DIEN,DISTK,2) ;capture trace I '$$DONE
 ;
 ; check for quit value (if null), or Deny Message
 I DIRESULT="" S DIRESULT=$G(DIFCN(DIEN,"NULL"))
 I $L(DIRESULT) D ADDMSG(DIEN,DIRESULT),OBLIG(DIEN,DIRESULT),FIELDS(DIEN,1.6)
 Q DIRESULT
 ;
MATCH(IEN) ; -- return 1 or 0, if target matches
 N X,Y,CONJ,KEY,DONE
 S IEN=+$G(IEN),CONJ=$P($G(^DIAC(1.6,IEN,0)),U,5),Y=1,DONE=0
 S KEY="" F  S KEY=$O(^DIAC(1.6,IEN,2,"AKEY",KEY)) Q:KEY=""  D  Q:DONE
 . S X=$G(DIVAL(KEY))
 . I $L(X),$D(^DIAC(1.6,IEN,2,"AKEY",KEY,X)) S Y=1
 . E  S Y=0
 . S DONE=$S(CONJ="!"&Y:1,CONJ="&"&'Y:1,CONJ="":Y,1:0)
MQ ;done
 Q Y
 ;
DISABLED(IEN) ; -- return 1 or 0, if item is disabled
 Q +$P($G(^DIAC(1.6,+$G(IEN),0)),U,3)
 ;
FCN(IEN) ; -- run attribute function to accummulate DIVAL(key)=value
 N FCN,CODE S IEN=+$G(IEN)
 S FCN=+$P($G(^DIAC(1.6,IEN,0)),U,4) ;attributes
 I FCN S CODE=$G(^DIAC(1.62,FCN,1)) X:$L(CODE) CODE
 ;
 ; and stash quit condition code in DIFCN(IEN) for reuse in Member loop
 S FCN=+$P($G(^DIAC(1.6,IEN,0)),U,7) Q:FCN<1
 S DIFCN(IEN)=$G(^DIAC(1.62,FCN,1)) ;Result Function code
 S DIFCN(IEN,"NULL")=$P($G(^DIAC(1.62,FCN,0)),U,4)
 Q
 ;
DONE(IEN) ; -- return 1 or 0, if quit condition is met for policy IEN
 N Y,CODE
 S IEN=+$G(IEN),Y=0
 S CODE=$G(DIFCN(IEN)) X:$L(CODE) CODE ;must set Y
 ;i.e., I DIRESULT="D" S Y=1
 Q $G(Y)
 ;
COND(IEN) ; -- evaluate any rule IEN conditions [return boolean in Y]
 N CONJ,DONE,Y,DII,DA,X,X0,FCN,CODE
 S IEN=+$G(IEN),CONJ=$P($G(^DIAC(1.6,IEN,0)),U,6),DONE=0
 S Y=1,DII=0 ;return true if no conditions
 F  S DII=$O(^DIAC(1.6,IEN,3,"B",DII)) Q:DII<1  S DA=+$O(^(DII,0)) D  Q:DONE
 . S X0=$G(^DIAC(1.6,IEN,3,DA,0)),X=$P(X0,U,3)
 . ; Operator function may use X, must return boolean in Y
 . S FCN=+$P(X0,U,2) I FCN D
 .. S CODE=$G(^DIAC(1.62,FCN,1)) X:$L(CODE) CODE
 .. D:$G(DIZTRACE) TRACE(DA,DISTK+2,Y,DII)
 . S DONE=$S(CONJ="!"&Y:1,CONJ="&"&'Y:1,CONJ="":Y,1:0)
 Q Y
 ;
ADDMSG(IEN,RES) ; -- add line to DIMSG array
 N I,N,X,Y Q:'$L($G(RES))
 S N=$S(RES="D":7,RES="P":8,1:"") Q:N<1
 S X=$P($G(^DIAC(1.6,+$G(IEN),N)),U,2) Q:'$L(X)
 I X["|" D  ;look for |VAR|
 . F I=2:2:$L(X,"|") S Y=$P(X,"|",I) I Y?1.A D
 .. I $D(@Y) S $P(X,"|",I)=@Y Q
 .. I $D(DIVAL(Y)) S $P(X,"|",I)=DIVAL(Y) Q
 . S X=$TR(X,"|","")
 ; DIMSG=+$G(DIMSG)+1,@DITXT@(DIMSG)=X
 S DIACMSG(RES,$$MSG)=X
 Q
MSG() ;
 N I S I=+$G(DIACMSG(RES))+1
 S DIACMSG(RES)=I
 Q I
 ;
OBLIG(IEN,RES) ; -- execute obligation code
 N N,FCN,CODE Q:'$L($G(RES))
 S N=$S(RES="D":7,RES="P":8,1:"") Q:N<1
 S FCN=+$G(^DIAC(1.6,+$G(IEN),N))
 I FCN S CODE=$G(^DIAC(1.62,FCN,1)) X:$L(CODE) CODE
 Q
 ;
FIELDS(IEN,FN) ; -- return available fields in DIFLDS
 Q:$G(DIRESULT)'="P"  ;on permit only
 Q:$G(DIFLDS)'=""     ;lowest level takes precedence
 Q:'$L($G(^DIAC(+$G(FN),+$G(IEN),5)))
 N I,L,S,DR S DIFLDS=$G(^DIAC(FN,IEN,5)),I=0
 F  S I=$O(^DIAC(FN,IEN,5.1,I)) Q:I<1  S X=$G(^(I,0)) I X D
 . S L=+$P(X,U,2),S=$P(X,U,3),DR=$P(X,U,4) Q:DR=""
 . I S>0 S DIFLDS(L,+X,+S)=DR
 . E  S DIFLDS(L,+X)=DR
 S:$G(DIZTRACE) DIZTRACE("FLDS")=FN_U_IEN
 Q
 ;
VIENS(IENS,FN) ; -- validate IENS string for file# FN
 N GBL S GBL=$$ROOT^DILFD(FN,IENS,,1)
 I $G(DIERR) D:$D(DIERROR)  Q 0
 . ;add message to end of provided array
 . N I S I=+$O(@DIERROR@(""),-1)
 . S:I I=I+1,@DIERROR@(I)=" "
 . S @DIERROR@(I+1)=$G(^TMP("DIERR",$J,1,"TEXT",1))
 I '$D(@(GBL_+IENS_")")) D ERROR(601) Q 0
 Q 1
 ;
ERROR(CODE,PARAM,TYPE) ; -- create error message
 I '$L($G(TYPE)) D BLD^DIALOG(CODE,$G(PARAM),,$G(DIERROR)) Q
 N DIX S DIX(1)=$G(PARAM),DIX(2)=$G(TYPE)
 D BLD^DIALOG(CODE,.DIX,,$G(DIERROR))
 Q
 ;
TRACE(IEN,STK,ACT,COND) ; -- set trace array
 ; DIZTRACE(#)   = PolicyIEN ^ stack level ^ match? (1/0)
 ;       or      = PolicyIEN ^ stack level ^ done (2) ^ ResultFcnIEN
 ; DIZTRACE(#,c) = ConditionDA ^ stack level ^ result (1/0)
 ;
 I $G(COND) S DIZTRACE(+$G(DIZ),COND)=$G(IEN)_U_$G(STK)_U_$G(ACT) Q
 N RES S RES=$S($G(ACT)=2:$P($G(^DIAC(1.6,+$G(IEN),0)),U,7),1:"")
 S DIZTRACE($$NXT)=$G(IEN)_U_$G(STK)_U_$G(ACT)_U_RES
 Q
 ;
NXT() ; -- increment trace array subscript
 S DIZ=+$G(DIZ)+1
 Q DIZ
