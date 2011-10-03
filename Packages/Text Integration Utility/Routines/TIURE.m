TIURE ; SLC/JER - Error handler actions ;04/23/10  15:11
 ;;1.0;TEXT INTEGRATION UTILITIES;**3,21,81,131,113,184,250**;Jun 20, 1997;Build 14
 ;
 ; ICR #10018    - ^DIE Routine & DIE, DA, DR, DTOUT, & DUOUT local vars
 ;     #10010    - EN1^DIP Routine & BY, DIC, FLDS, FR, L, TO, & IOP local vars
 ;     #10028    - EN^DIWE Routine & DIC & DWPK local vars
 ;     #10118    - EN^VALM, CLEAR^VALM1, & FULL^VALM1  Routines & VALM("ENTITY"),
 ;                 VALMBCK, VALMY, & VALMY( Local Vars
 ;     #10119    - EN^VALM2 Routine & XQORNOD(0) Local Var
 ;     #10081    - DELETEA^XQALERT Routine & XQAKILL & XQAID local vars
 ;
PRINT ; Print Buffer record associated w/unresolved filing error
 N TIUDA,TIUDATA,TIUI,DIROUT,ZTDESC,ZTRTN
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . S TIUDATA=$G(^TMP("TIUERRIDX",$J,TIUI))
 . S (TIUDA,TIUDA(TIUI))=+$P(TIUDATA,U,3) D RESTORE^TIULM(+$O(@VALMAR@("PICK",TIUI,0)))
 . I +TIUDA'>0!'$D(^TIU(8925.2,+TIUDA,0))!+$P(^TIU(8925.4,+$P(TIUDATA,U,2),0),U,6) W !!,"Item #",+TIUI," is already resolved." K TIUDA(TIUI) H 3 Q
 I $D(TIUDA)'<9 D
 . S ZTRTN="PRINT1^TIURE",ZTDESC="Print Report Buffer"
 . D CLEAR^VALM1,DEVICE^TIUPRDS
 . S TIUI=$$READ^TIUU("FOA","Press RETURN to continue...")
 K VALMY S VALMBCK="R"
 Q
PRINT1 ; Print a single buffer record
 N DIC,TIUI,FLDS,FR,TO,L,BY,IOP S TIUI=0
 F  S TIUI=$O(TIUDA(TIUI)) Q:+TIUI'>0  D
 . S IOP=$S($D(ZTIO):ZTIO,$D(ION):ION,1:"") Q:IOP']""
 . S DIC="^TIU(8925.2,",FLDS="[TIU PRINT REPORT BUFFER]",L=0
 . S BY=.01,(FR,TO)=+$G(^TIU(8925.2,+TIUDA(TIUI),0))
 . D EN1^DIP
 Q
EDIT ; Edit Buffer record associated w/unresolved filing error
 N TIUDA,BUFDA,TIUDATA,TIUI,DIROUT,TIUDI
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N VALMY
 . S TIUDATA=$G(^TMP("TIUERRIDX",$J,TIUI))
 . S BUFDA=+$P(TIUDATA,U,3)
 . W !!,"Resolving Event #",TIUI
 . S TIUDA=+$P(TIUDATA,U,2)
 . D EN^VALM("TIU DISPLAY FILING EVENT")
 . D RESTORE^TIULM(+$O(@VALMAR@("PICK",TIUI,0)))
 W !,"Refreshing the list."
 M TIUDI=^TMP("TIUERR",$J,"DIV")
 D BUILD^TIUELST($P(^TMP("TIUERR",$J,0),U,2),$P(^(0),U,3),TIUEDT,TIULDT,.TIUDI)
 K VALMY S:'$D(VALMBCK) VALMBCK="R"
 Q
EDIT1 ; Single record edit
 ; Receives TIUDATA
 N DIC,ERRDA,ERRTYPE,RETRY,DWPK K XQAKILL
 D FULL^VALM1
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 S ERRDA=+$P(TIUDATA,U,2),ERRTYPE=$P(^TIU(8925.4,+ERRDA,0),U,8)
 I +ERRTYPE=0 W !!,"Item #",+TIUDATA," was a successful filing event." H 3 Q
 I +ERRTYPE=1 D FILERR(ERRDA)
 I +ERRTYPE=2 D FLDERR(ERRDA)
 Q
FILERR(ERRDA) ; Resolve filing errors
 N DIC,DIRUT,DWPK,TIUI,INQUIRE,BUFDA,TIUTYPE,RESCODE,TIUDONE
 N TIUEVNT,TIUSKIP,ERR0,RETRY,STATUS,PRFILERR
 ; Set TIUEVNT for PN resolve code:
 S TIUEVNT=+ERRDA
 S TIUI=0,ERR0=$G(^TIU(8925.4,TIUEVNT,0)),STATUS=$P(ERR0,U,6)
 I STATUS=1 W !,"Error has already been resolved.",! Q
 S BUFDA=+$P(ERR0,U,5) I +BUFDA'>0 Q
 I TIUEVNT D  I +$G(TIUDONE)!$G(TIUSKIP) G FILEX
 . D WRITEHDR^TIUPEVNT(TIUEVNT)
 . S TIUTYPE=$P(ERR0,U,3)
 . I $L(TIUTYPE) S TIUTYPE=+$$WHATYPE^TIUPUTPN(TIUTYPE)
 . I TIUTYPE>0 S RESCODE=$$FIXCODE^TIULC1(+TIUTYPE)
 . ;E  S RESCODE="D GETPAT^TIUCHLP"
 . I $G(RESCODE)]"" D  Q
 . . W ! S INQUIRE=$$READ^TIUU("YO","Inquire to patient record","YES","^D INQRHELP^TIUPEVNT")
 . . I $D(DIRUT) S TIUSKIP=1 Q
 . . I +INQUIRE X RESCODE
 . W !!,"Filing error resolution code could not be found for this document type.",!,"Please edit the buffered data directly and refile."
 W !!,"You may now edit the buffered upload data in an attempt to resolve error:",!,$P(ERR0,U,4),!
 I '$$READ^TIUU("EA","Press RETURN to continue and edit the buffer or '^' to exit: ") G FILEX
 S DIC="^TIU(8925.2,"_+BUFDA_",""TEXT"",",DWPK=1 D EN^DIWE
 S RETRY=$$READ^TIUU("YO","Now would you like to retry the filer","YES","^D FIL^TIUDIRH")
 I +RETRY D
 . S PRFILERR=1 ; Tell Patient Record Flag lookup to get flag link
 . D ALERTDEL^TIUPEVNT(+BUFDA),RESOLVE^TIUPEVNT(TIUEVNT)
 . K TIUDONE
 . D FILE^TIUUPLD(+BUFDA)
 . I '$G(TIUDONE) W !,"Old error marked resolved; new error created.  New error may take several more",!,"seconds to file, and may not be within current date/time range.",! H 5
FILEX S VALMBCK="Q" ;TIU*1*81 resolving twice creates errors so don't permit.
 Q
FLDERR(EVNTDA) ; Resolve field errors
 N DIE,DA,DR,ERRDESC,EVNTDA1,EVNTREC,TIUFIX,ERR0,STATUS
 S EVNTDA1=0
 S ERR0=^TIU(8925.4,+EVNTDA,0),STATUS=$P(ERR0,U,6)
 I STATUS=1 W "Error has already been resolved",! Q  ;TIU*1*81
 S ERRDESC=$P(ERR0,U,4)
 W !!,"You may now enter the correct information:",!
 W !,ERRDESC
 F  S EVNTDA1=$O(^TIU(8925.4,EVNTDA,1,EVNTDA1)) Q:+EVNTDA1'>0  D
 . S EVNTREC=$G(^TIU(8925.4,EVNTDA,1,EVNTDA1,0)) Q:+EVNTREC'>0
 . S DIE=$P(EVNTREC,U),DA=$P(EVNTREC,U,2)
 . S DR=$P(EVNTREC,U,3)_"//"_$P(EVNTREC,U,4)
 . I $$FIXED^TIUPEVN1(DIE,+DA,+DR) Q  ;P81 don't ask if already fixed; moved from TIUPEVNT
 . D ^DIE
 . ; P81 If missing field was just corrected, delete alert for that field:
 . S TIUFIX=$$FIXED^TIUPEVN1(DIE,+DA,+DR) ; TIU*1*81 moved from TIUPEVNT
 . I +TIUFIX=1 N XQAKILL,XQAID S XQAKILL=0,XQAID="TIUERR,"_+EVNTDA_","_+EVNTDA1 D DELETEA^XQALERT
 . ; If entry is a TIU Document, do Post-filing action and SEND^TIUALRT
 . I DIE="^TIU(8925," D
 . . N TIUPOST,TIUREC,DR,DIE,TIUD12,TIUD13,TIUAU,TIUEC,TIUEBY
 . . S TIUPOST=$$POSTFILE^TIULC1(+$G(^TIU(8925,DA,0)))
 . . S TIUREC("#")=DA
 . . I TIUPOST]"" X TIUPOST I 1
 . . ;if not entered by the author or expected cosigner record VBC Line Count
 . . S TIUD12=$G(^TIU(8925,DA,12)),TIUD13=$G(^(13))
 . . S TIUEBY=$P(TIUD13,U,2),TIUAU=$P(TIUD12,U,2),TIUEC=$P(TIUD13,U,8)
 . . I ((+TIUEBY>0)&(+TIUAU>0))&((TIUEBY'=TIUAU)&(TIUEBY'=TIUEC)) D LINES^TIUSRVPT(DA)
 . . D SEND^TIUALRT(DA)
 D FLDRSLV^TIUPEVN1(EVNTDA) ; TIU*1*81 moved from TIUPEVNT
 Q
