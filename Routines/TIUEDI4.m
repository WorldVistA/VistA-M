TIUEDI4 ; SLC/JER - Enter/Edit a Document ; 7-FEB-2001 08:01:51
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,109,216**;Jun 20, 1997
 ;new rtn in TSC, created feb 2 from TIUEDIT
 ; 2/2: Moved LOADDFLT, BOIL, CANXEC, REPLACE, INSMULT to TIUEDI4
 ; 2/3 moved DIE, TEXTEDIT from TIUEDIT to TIUEDI4
 ; 3/2 moved SETTL, GETVST, ASKOK from TIUEDIT to TIUEDI4
 ;
SETTL(TIUTYP,TIUCLASS,TIUTITLE) ; Set array TIUTYP w/ title info
 ;  e.g. TIUTYP(1) = 1^113^CRISIS, where 113 is IFN of CRISIS title,
 ;          TIUTYP = 1 if gotten from TIUTITLE
 ;          TIUTYP = 113 if gotten from user
 ; Requires TIUCLASS
 ; Receives TIUTITLE - optional = Title DA or Title Name or DA^Name
 N TIUDFLT
 ; -- Get title from TIUTITLE if it's there: --
 I $G(TIUTITLE)]"",$S(+$G(NOSAVE):1,+$P(TIUTITLE,U,2):1,1:0) D  I 1
 . S TIUTYP=1,TIUTITLE=$P(TIUTITLE,U)
 . S TIUTYP(1)=1_U_$S(+$G(TIUTITLE)>0:+$G(TIUTITLE),1:+$O(^TIU(8925.1,"B",TIUTITLE,0)))
 . S $P(TIUTYP(1),U,3)=$$PNAME^TIULC1(+$P(TIUTYP(1),U,2))
 ; -- If not, ask user: --
 E  D
 . S TIUDFLT="LAST" ; use user's preferred list of docmts
 . D DOCSPICK^TIULA2(.TIUTYP,TIUCLASS,"1A",TIUDFLT,"","+$$CANPICK^TIULP(+Y),+$$CANENTR^TIULP(+Y)")
 I +$G(TIUTYP)'>0 S TIUOUT=1 Q
 S TIUTYP=+$P($G(TIUTYP(1)),U,2)
 Q
 ;
GETVST(DFN,TIUTYP,TIU,EVNTFLAG) ; Get visit, set array TIU
 ; -- If no eventflag & don't suppress visit, then execute
 ;    visit linkage method: --
 ; Requires DFN
 ; Requires simple variable TIUTYP = title DA
 ; Optional EVNTFLAG
 ; Returns array TIU
 N TIUVSUPP,TIULMETH
 S TIUVSUPP=0
 I '$G(EVNTFLAG) S TIUVSUPP=+$$SUPPVSIT^TIULC1(TIUTYP)
 ; -- execute visit linkage method for TIUTYP --
 I 'TIUVSUPP,'$G(EVNTFLAG) D  I 1
 . S TIULMETH=$$GETLMETH^TIUEDI1(TIUTYP)
 . I '$L(TIULMETH) D  S TIUOUT=1 Q
 . . W !,$C(7),"No Visit Linkage Method defined for "
 . . W $$PNAME^TIULC1(TIUTYP),".",!,"Please contact IRM..."
 . ; -- TIULMETH for PN: D ENPN^TIUVSIT(.TIU,.DFN,1) --
 . X TIULMETH
 ; -- else create new historical "E" visit: --
 E  D EVENT^TIUSRVP1(.TIU,DFN)
 I $S($D(DIROUT):1,$D(DTOUT):1,1:0) S TIUQUIT=1 Q
 I '$D(TIU("VSTR")) D
 . W !,$C(7),"Patient & Visit required." H 2
 Q
 ;
ASKOK(TIUTYP,TIU,TIUBY,TIUASK) ; X Validation method.
 ; Receives and returns array TIU, simple var TIUTYP, [array TIUBY]
 ; Sets TIUASK = answer, = 0 for not OK or 1 for OK
 N TIUVMETH
 S TIUVMETH=$$GETVMETH^TIUEDI1(TIUTYP)
 I '$L(TIUVMETH) D  S TIUOUT=1 Q
 . W !,$C(7),"No Validation Method defined for "
 . W $$PNAME^TIULC1(TIUTYP),".",!,"Please contact IRM..."
 ; -- TIUVMETH for PN: S TIUASK=$$CHEKPN^TIULD(.TIU,.TIUBY) --
 X TIUVMETH
 ; -- If finish without a visit, then quit: --
 I '$D(TIU("VSTR")) D
 . W !,$C(7),"Patient & Visit required." H 2
 Q
 ;
DIE(DA,TIUQUIT,TIUCHNG) ; Invoke ^DIE
 N Y,DIE,DR
 I '$D(TIUPREF) S TIUPREF=$$PERSPRF^TIULE(DUZ)
 L +^TIU(8925,+DA):1
 E  D  Q
 . W !!?5,$C(7),"Another user is editing this entry.",! S TIUQUIT=2
 . I $$READ^TIUU("FOA","Press RETURN to continue...") W ""
 S ^TIU(8925,"ASAVE",DUZ,DA)=""
 S DR=$$GETTMPL^TIUEDI1(+$P(^TIU(8925,+DA,0),U))
 I DR']"" W !?5,$C(7),"No Edit template defined for ",$$PNAME^TIULC1(+$P(^TIU(8925,+DA,0),U)),! S TIUQUIT=2 Q
 S DIE=8925 D ^DIE
 I $D(Y)!($D(DTOUT)) S TIUQUIT=1
 I +$G(TIUQUIT)>0,+$G(TIUNEW)>0 Q
 D:+$G(TIUQUIT) UPDTIRT^TIUDIRT(.TIU,DA),SEND^TIUALRT(DA)
 Q:+$G(TIUQUIT)
 D TEXTEDIT(DA,.TIUCHNG)
 I +$G(^TIU(8925,DA,0))'>0 S TIUQUIT=2 Q
 S DR=".05///"_$$STATUS^TIULC(DA),DIE=8925 D ^DIE
 D UPDTIRT^TIUDIRT(.TIU,DA),SEND^TIUALRT(DA)
 L -^TIU(8925,+DA)
 Q
TEXTEDIT(DA,TIUCMMT,TIUCHNG) ; Call DIWE
 N DIC,DIWE,DIWESUB,DIWPT,DR,DWHD,DWI,DWLC,DWLR,DWLW,DWO,DWPK,DDWRW
 N TIUCKSM0,TIUCKSM1,TIUESNM,TIUESBLK
 S TIUESNM=$$DECRYPT^TIULC1($P($G(^TIU(8925,DA,15)),U,3),1,$$CHKSUM^TIULC("^TIU(8925,"_+DA_",""TEXT"")"))
 S TIUESBLK=$$DECRYPT^TIULC1($P($G(^TIU(8925,DA,15)),U,4),1,$$CHKSUM^TIULC("^TIU(8925,"_+DA_",""TEXT"")"))
 W !!,"Calling text editor, please wait..." H 1
 X:$L($G(TIUPRM3)) TIUPRM3
 D BUFFER^TIUEDIU(DA) ; Load edit buffer to protect original from booboos
 S TIUCKSM0=$$CHKSUM^TIULC("^TIU(8925,"_+DA_",""TEMP"")")
 I $D(^TIU(8925,+DA,"TEXT"))'>9 D LOADDFLT(DA,+$P(TIUTYP(1),U,2))
 S DIWESUB="Patient: "_$G(TIU("PNM")),DIC="^TIU(8925,"_+DA_",""TEMP"","
 I $G(VALMAR)="^TMP(""TIUVIEW"",$J)",(+$G(VALMBG)>5),(+$G(VALMBG)'>(+$P($G(^TIU(8925,+DA,"TEXT",0)),U,3)+4)) S DDWRW=+$G(VALMBG)-4
 S DWPK=1,DWLW=74 D EN^DIWE
 ; DELETE if NOSAVE
 I +$G(NOSAVE) D DELETE^TIUEDIT(DA,0) S TIUQUIT=2 Q
 ; Save edit buffer
 S TIUCKSM1=$$CHKSUM^TIULC("^TIU(8925,"_+DA_",""TEMP"")")
 I TIUCKSM0'=TIUCKSM1 D  I 1
 . D COMMIT^TIUEDIU(DA),AUDIT^TIUEDI1(DA,TIUCKSM0,TIUCKSM1)
 . S TIUCHNG=1
 . ; re-file /es/-block
 . I $L(TIUESNM) D
 . . S DR="1503///^S X=TIUESNM;1504///^S X=TIUESBLK",DIE=8925
 . . D ^DIE
 E  W !,"No changes made..." D COMMIT^TIUEDIU(DA,1) S TIUCHNG=0
 S DIE=8925,DR=".1///"_$$LINECNT^TIULC(DA) D ^DIE
 Q
 ;
LOADDFLT(DA,TIUTYP) ; Load bp text
 N TIUI,TIUJ,TIUK,TIUL S TIUI=0
 S TIUJ=+$P($G(^TIU(8925,+DA,"TEMP",0)),U,3)+1
 ; - Set comp hdr -
 S ^TIU(8925,+DA,"TEMP",TIUJ,0)=$S($P($G(^TIU(8925.1,+TIUTYP,0)),U,4)="CO":$P(^TIU(8925.1,+TIUTYP,0),U)_":   ",1:"")
 I +TIUJ=1,($G(^TIU(8925,+DA,"TEMP",TIUJ,0))']"") K ^TIU(8925,+DA,"TEMP",TIUJ,0) S TIUJ=0
 S ^TIU(8925,+DA,"TEMP",0)="^^"_TIUJ_U_TIUJ_U_DT_"^^"
 F  S TIUI=$O(^TIU(8925.1,+TIUTYP,"DFLT",TIUI)) Q:+TIUI'>0  D
 . S TIUJ=TIUJ+1,X=$G(^TIU(8925.1,+TIUTYP,"DFLT",TIUI,0))
 . I $L($T(DOLMLINE^TIUSRVF1)),'$D(XWBOS),(X["{FLD:") S X=$$DOLMLINE^TIUSRVF1(X)
 . I X["|" S X=$$BOIL(X,TIUJ)
 . I X["~@" D INSMULT(X,"^TIU(8925,"_+DA_",""TEMP"")",.TIUJ) I 1
 . E  S ^TIU(8925,+DA,"TEMP",TIUJ,0)=X
 . S ^TIU(8925,+DA,"TEMP",0)="^^"_TIUJ_U_TIUJ_U_DT_"^^"
 I +$O(^TIU(8925.1,+TIUTYP,10,0)) D
 . N TIUFITEM,TIUI
 . D ITEMS^TIUFLT(+TIUTYP)
 . S TIUI=0 F  S TIUI=$O(TIUFITEM(TIUI)) Q:+TIUI'>0  D
 . . S TIUL=+$G(TIUFITEM(+TIUI)) D LOADDFLT(DA,TIUL)
 Q
BOIL(LINE,COUNT) ; execute objects
 N TIUI,DIC,X,Y,TIUFPRIV S TIUFPRIV=1
 N TIUOLDR,TIUNEWR,TIUOLDG,TIUNEWG
 S DIC=8925.1,DIC(0)="FMXZ"
 S DIC("S")="I $P($G(^TIU(8925.1,+Y,0)),U,4)=""O"""
 F TIUI=2:2:$L(LINE,"|") S X=$P(LINE,"|",TIUI) D
 . D ^DIC
 . I +Y'>0 S X="The OBJECT "_X_" was NOT found...Contact IRM."
 . I +Y>0 D
 . . I $D(^TIU(8925.1,+Y,9)),+$$CANXEC(+Y) X ^(9) S:X["~@" X=$$APPEND(X) I 1
 . . E  S X="The OBJECT "_X_" is INACTIVE...Contact IRM."
 . . I X["~@" D
 . . . I X'["^" D
 . . . . S TIUOLDR=$P(X,"~@",2),TIUNEWR=TIUOLDR_TIUI
 . . . . M @TIUNEWR=@TIUOLDR K @TIUOLDR
 . . . . S $P(X,"~@",2)=TIUNEWR
 . . . I X["^" D
 . . . . S TIUOLDG=$P(X,"~@",2),TIUNEWG="^TMP("_"""TIU201"""_","_$J_","_TIUI_")"
 . . . . M @TIUNEWG=@TIUOLDG
 . . . . S $P(X,"~@",2)=TIUNEWG
 . S LINE=$$REPLACE(LINE,X,TIUI)
 Q $TR(LINE,"|","")
CANXEC(TIUODA) ; Eval Obj Status
 N TIUOST,TIUY S TIUOST=+$P($G(^TIU(8925.1,+TIUODA,0)),U,7)
 S TIUY=$S(TIUOST=11:1,+$G(NOSAVE):1,1:0)
 Q +$G(TIUY)
REPLACE(LINE,X,TIUI) ; Replace TIUIth object in LINE
 S $P(LINE,"|",TIUI)=X
 Q LINE
INSMULT(LINE,TARGET,TIULCNT) ; Mult-valued results
 N TIUPC
 F TIUPC=2:2:$L(LINE,"~@") D
 . N TIUI,TIULINE,TIUX,TIUSRC,TIUSCNT,TIUTAIL
 . S TIUSRC=$P(LINE,"~@",TIUPC)
 . S TIUTAIL=$P(LINE,"~@",TIUPC+1)
 . S TIULINE=$P(LINE,"~@",(TIUPC-1)),(TIUI,TIUSCNT)=0
 . I $E(TIULINE)=" ",(TIUPC>2) S $E(TIULINE)=""
 . F  S TIUI=$O(@TIUSRC@(TIUI)) Q:+TIUI'>0  D
 . . N TIUSLINE
 . . S TIUSCNT=TIUSCNT+1
 . . S TIUSLINE=$G(@TIUSRC@(TIUI,0))
 . . S:'+$O(@TIUSRC@(TIUI))&(TIUPC+2>$L(LINE,"~@")) TIUSLINE=TIUSLINE_TIUTAIL
 . . I TIUSCNT=1,($L(TIULINE_TIUSLINE)>73) D  Q
 . . . S:$D(@TARGET@(TIULCNT,0)) TIULCNT=TIULCNT+1
 . . . S @TARGET@(TIULCNT,0)=TIULINE
 . . . S TIULCNT=TIULCNT+1
 . . . S @TARGET@(TIULCNT,0)=TIUSLINE
 . . I TIUSCNT=1,($L(TIULINE_TIUSLINE)'>73) D  Q
 . . . S:$D(@TARGET@(TIULCNT,0)) TIULCNT=TIULCNT+1
 . . . S @TARGET@(TIULCNT,0)=TIULINE_TIUSLINE
 . . S:$D(@TARGET@(TIULCNT,0)) TIULCNT=TIULCNT+1
 . . S @TARGET@(TIULCNT,0)=$G(TIUSLINE)
 . K @TIUSRC
 Q
APPEND(X) ;
 N TIUXL S TIUXL=$L(X)
 I $E(X,TIUXL-1,TIUXL)'="~@" S X=X_"~@"
 Q X
