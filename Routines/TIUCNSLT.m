TIUCNSLT ; SLC/JER - Patient movement look-up ;1/7/03 [6/11/04 8:34am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**4,31,109,131,142,144,184**;Jun 20, 1997
 ; External References
 ;   DBIA 2324   $$ISA^USRLM
 ;   DBIA 3473   SEND^GMRCTIU
 ;   DBIA 3473   GET^GMRCTIU
 ;   DBIA 3575   ROLLBACK^GMRCTIU1
GETCNSLT(DFN,TIUCPF,TIUDA,TIUOVR) ; Match consult result
 ;to an active request
 ; Call with:
 ;     [DFN] - patient file entry number
 ;  [TIUCPF] - flag to indicate clinical procedure (Optional)
 ;  [TIUDA] - TIU document IEN of consult result (Optional).
 ;            If TIUDA has a request, return it w/o asking user.
 ;  [TIUOVR] - flag to override restrictions on selectable requests
 ;             (Optional).  If not received or received as null, reset
 ;             according to whether user is in MIS.
 ;      Note - If DA is defined and TIU document DA has a request,
 ;             code returns its request instead of asking user.
 ;   Returns:     TIUY  - Variable pointer to consult request
 ;                      = -1 if pat has no requests
 ;                      = 0 if no request is selected
AGN ; Loop for handling repeated attempts
 N TIUI,TIUII,TIUER,TIUOK,TIUOUT,TIUX,TIUY,TIUCNT,X
 I +DFN'>0 S TIUOUT=1 Q 0
 I +$G(GMRCO) S TIUX=+$G(GMRCO) G GETX
 ; -- If TIUDA is not defined, try DA for backward
 ;    compatibility:
 S TIUDA=$S('$D(TIUDA):+$G(DA),1:+TIUDA)
 ; -- Ignore TIUDA if it doesn't match pt DFN:
 I $P($G(^TIU(8925,TIUDA,0)),U,2)'=+DFN S TIUDA=0
 ; -- If TIUDA or its parent already has a request,
 ;    return it & don't ask user:
 I +$P($G(^TIU(8925,TIUDA,14)),U,5) S TIUX=+$P($G(^(14)),U,5) G GETX
 I +$$ISADDNDM^TIULC1(TIUDA) S TIUX=+$$DADCR(TIUDA) G:+TIUX>0 GETX
 ; -- If override flag is null or is not defined, set it according to
 ;    user's membership in MIS:
 S TIUOVR=$S($G(TIUOVR)="":+$$ISA^USRLM(DUZ,"MEDICAL INFORMATION SECTION"),1:+TIUOVR)
 D SEND^GMRCTIU(DFN,$G(TIUOVR),$G(TIUCPF))
 ; If no consult requests for patient, then quit with -1
 I $S($G(^TMP("GMRCR",$J,"TIU",1,0))["No Consults":1,'$D(^TMP("GMRCR",$J,"TIU")):1,1:0) D  Q -1
 . W !!,$C(7),"No CONSULT REQUESTS to Result for ",$P($G(^DPT(DFN,0)),U),".",!
 S (TIUCNT,TIUI)=0 F  S TIUI=+$O(^TMP("GMRCR",$J,"TIU",TIUI)) Q:+TIUI'>0  D
 . S TIUCNT=+$G(TIUCNT)+1
 W !,"You must link this Result to a Consult Request...",!
 D  I +TIUER Q:+$G(TIUOUT) 0  G AGN
 . W !,"The following CONSULT REQUEST"
 . W $S(+TIUCNT>1:"(S) are",1:" is")," available:"
 . S (TIUER,TIUOK,TIUI)=0
 . F  S TIUI=$O(^TMP("GMRCR",$J,"TIU",TIUI)) Q:+TIUI'>0!+TIUER!+TIUOK  D
 . . S TIUII=TIUI,TIUX=$G(^TMP("GMRCR",$J,"TIU",TIUI,0))
 . . D WRITE I '(TIUI#5) D BREAK
 . Q:$D(TIUOUT)
 . I +TIUER S TIUOUT=1 Q
 . I TIUII#5 D BREAK Q:$D(TIUOUT)
 . I +TIUER S TIUOUT=1 Q
 . S TIUX=$O(^TMP("GMRCR",$J,"TIU","B",+TIUOK,0))
 . ;,^DISV(DUZ,"^GMR(123,",DFN)=+TIUX
 . W "  ",+TIUX
GETX S TIUY=+TIUX_";GMR(123,"
 Q $G(TIUY)
BREAK ; Handle prompting
 W !,"CHOOSE 1-",TIUII W:$D(^TMP("GMRCR",$J,"TIU",TIUII+1,0)) !,"<RETURN> TO CONTINUE",!,"OR '^' TO QUIT" W ": " R X:DTIME
 I $S('$T!(X["^"):1,X=""&'$D(^TMP("GMRCR",$J,"TIU",TIUII+1)):1,1:0) S TIUER=1 Q
 I X="" Q
 I X'=+X!'$D(^TMP("GMRCR",$J,"TIU",+X)) W !!,$C(7),"INVALID RESPONSE",! G BREAK
 S TIUOK=X
 Q
DADCR(DA) ; Get the Consult request associated with the parent record
 N TIUDADA,TIUY S TIUDADA=$P($G(^TIU(8925,+DA,0)),U,6)
 S TIUY=$P($G(^TIU(8925,TIUDADA,14)),U,5)
 Q TIUY
WRITE W !,TIUX
 Q
POST(TIUDA,STATUS) ; Post status updates to Consult Tracking
 N GMRCDA,DA,TIUAUTH S GMRCDA=+$P($G(^TIU(8925,+TIUDA,14)),U,5)
 I +GMRCDA'>0 Q
 S TIUAUTH=$P($G(^TIU(8925,TIUDA,12)),U,2)
 D GET^GMRCTIU(GMRCDA,TIUDA,STATUS,TIUAUTH)
 Q 
ISCNSLT(TIUY,TITLE) ; Boolean RPC to evaluate whether TITLE is a CONSULT
 N TIUCLASS
 S TIUCLASS=+$$CLASS
 I +TIUCLASS'>0 S TIUY=0 Q
 S TIUY=+$$ISA^TIULX(TITLE,TIUCLASS)
 Q
CHANGE(TIUDA,TIUCPF,TIUNOCS) ; Re-direct the TIU Document to a different CT Record
 ; Passes back TIUNOCS=-1 if pt has no requests or none is selected
 N DA,DFN,DIE,DR,GMRCO,GMRCSTAT,GMRCVP,TIUD0,TIUD14
 S TIUD0=$G(^TIU(8925,TIUDA,0)),TIUD14=$G(^(14))
 S DFN=$P(TIUD0,U,2),GMRCO=$P(TIUD14,U,5)
 Q:+DFN'>0
 I GMRCO'="" D ROLLBACK(TIUDA) K GMRCO ;P144
CHAGN S DA=TIUDA,TIUNOCS=0
 W ! S GMRCVP=+$$GETCNSLT(DFN,$G(TIUCPF))_";GMR(123,"
 I +GMRCVP=0 W !!,$C(7),"You must select a Consult Request...Restoring record."
 I +GMRCVP'>0 D RETREAT(TIUDA,TIUD14) S TIUPOP=1,TIUNOCS=-1 Q  ;P144
 S DIE=8925,DA=TIUDA,DR="1405////^S X=GMRCVP" D ^DIE
 D UPDTADD(TIUDA,GMRCVP)
 S GMRCO=+GMRCVP,GMRCSTAT=$S($P(TIUD0,U,5)>6:"COMPLETED",1:"INCOMPLETE")
 D POST(TIUDA,GMRCSTAT)
 Q
RETREAT(DA,TIUD14) ; If Pt has no requests, retreat gracefully
 N DIE,DR,GMRCO,GMRCSTAT
 S DIE=8925,DR="1405////^S X=$P(TIUD14,U,5)" D ^DIE
 S GMRCO=+$P(TIUD14,U,5)
 S GMRCSTAT=$S($P(TIUD0,U,5)>6:"COMPLETED",1:"INCOMPLETE")
 D POST(TIUDA,GMRCSTAT)
 Q
UPDTADD(TIUDA,TIUCVP) ; Addenda for re-linked original are updated
 ;Update TIU(8925 ONLY.  GMR(123 doesn't track individual adda
 I $$HASADDEN^TIULC1(+TIUDA) D
 . N DA
 . S DA=0 F  S DA=$O(^TIU(8925,"DAD",+TIUDA,DA)) Q:+DA'>0  D
 . . N DR,DIE
 . . I '+$$ISADDNDM^TIULC1(+DA) Q
 . . S DR="1405////^S X=TIUCVP"
 . . S DIE=8925 D ^DIE
 . . D ^DIE
 Q
ROLLBACK(TIUDA) ; Roll back CT Record when TIU changes require it
 N GMRCDA,DIE,DR,DA S GMRCDA=+$P($G(^TIU(8925,TIUDA,14)),U,5)
 I +GMRCDA>0 D ROLLBACK^GMRCTIU1(GMRCDA,TIUDA) ;P144
 S DIE="^TIU(8925,",DA=TIUDA,DR="1405///@" D ^DIE
 Q
CLASS() ; What is the TIU Class (or Document Class) for CONSULTS
 N GMRCY
 S GMRCY=+$O(^TIU(8925.1,"B","CONSULTS",0))
 I +GMRCY>0,$S($P($G(^TIU(8925.1,+GMRCY,0)),U,4)="CL":0,$P($G(^(0)),U,4)="DC":0,1:1) S GMRCY=0
 Q GMRCY
REMCNSLT(TIUDA) ;Remove link to consult if there is one ;*171
 ;TIUDA is a TIU record number
 N TIUTYPE,TIUDELX
 S TIUTYPE=+$G(^TIU(8925,+TIUDA,0))
 S TIUDELX=$$DELETE^TIULC1(TIUTYPE)
 I TIUDELX]"" X TIUDELX
 Q
CONSCT(TIUDA,TIUOTTL,TIUNTTL) ;
 ;non cons title to cons title - already handled
 ;cons title to cons title - already handled
 ;cons title to non cons title
 N TIUCLASS
 S TIUCLASS=$$CLASS^TIUCNSLT()
 I +$$ISA^TIULX(TIUOTTL,TIUCLASS),'+$$ISA^TIULX(TIUNTTL,TIUCLASS) D
 . W !,"The Title you selected is not a Consults Title."
 . W !,"  The note is currently linked to a Consults Request,"
 . W !,"  but will be disassociated when the title is changed"
 . W !,"  to a non Consults Title.",!
 . W !,"Do you want to continue with this Change Title Action?"
 . I +$$READ^TIUU("YO",,"N")'>0 S TIUQUIT=1
 . I $G(TIUQUIT)=1 W !,"Title not changed." Q
 . D REMCNSLT(+TIUDA)
 Q
CNSCTGUI(TIUDA,TIUOTTL,TIUNTTL) ;
 ;non cons title to cons title - already handled
 ;cons title to cons title - already handled
 ;cons title to non cons title
 N TIUCLASS
 S TIUCLASS=$$CLASS^TIUCNSLT()
 I +$$ISA^TIULX(TIUOTTL,TIUCLASS),'+$$ISA^TIULX(TIUNTTL,TIUCLASS) D
 . ;Assume the confirmation has been taken care of already
 . D REMCNSLT(+TIUDA)
 Q
