RCDPESR6 ;ALB/TMK - Server auto-update file 344.4 - EDI Lockbox ;10/29/02
 ;;4.5;Accounts Receivable;**173,214,208,230,252**;Mar 20, 1995;Build 63
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
UPD3444(RCRTOT) ; Add EOB detail to list in 344.41 for file 344.4 entry RCRTOT
 ; If passed by reference, RCRTOT is returned = "" if errors
 ;
 N RC,RCCOM1,RCCOM2,RCCT,RC1,RC2,RCDPNM,RCEOB,RCNPI1,RCNPI2,DA,DR,DO,DD,DLAYGO,DIC,DIK,X,Y,Z
 S RC=0 F  S RC=$O(^TMP($J,"RCDPEOB",RC)) Q:'RC  S RC1=$G(^(RC)),RC2=$G(^(RC,"EOB")),RCEOB=+RC2 D  Q:'RCRTOT
 . ; Upd 344.41 with reference to this record if it doesn't already exist
 . I RCEOB>0 Q:$D(^RCY(344.4,RCRTOT,1,"AC",RCEOB,RC))
 . I RCEOB'>0,$S($P(RC1,U,2)'="":$D(^RCY(344.4,RCRTOT,1,"AD",$P(RC1,U,2),RC)),1:0) Q
 . ; Disregard ECME reject related EEOBs
 . I RCEOB'>0,'$P(RC2,U,2),$P(RC1,U,2)?1.7N,$$REJECT^IBNCPDPU($P(RC1,U,2),$P(RC1,U,3)) Q
 . S DA(1)=RCRTOT,X=RC,DIC="^RCY(344.4,"_DA(1)_",1,",DIC(0)="L",DLAYGO=344.41
 . S DIC("DR")=$S($G(RCEOB)>0:".02////"_RCEOB,1:".05////"_$P(RC1,U,2)_";.07////1")
 . I $P(RC2,U,2)'="" S DIC("DR")=DIC("DR")_$S($L(DIC("DR")):";",1:"")_".03///"_$P(RC2,U,2) ; amt
 . I $P(RC2,U,3)'="" S DIC("DR")=DIC("DR")_$S($L(DIC("DR")):";",1:"")_".04////"_$P(RC2,U,3) ; ins co
 . I $P(RC2,U,4) S DIC("DR")=DIC("DR")_$S($L(DIC("DR")):";",1:"")_".14////1" ; reversal
 . I $P(RC2,U,5)'="" S DIC("DR")=DIC("DR")_$S($L(DIC("DR")):";",1:"")_".15////^S X=$E($P(RC2,U,5),1,30)" ; Patient name
 . ; Process Billing Prov NPI, Rendering/Servicing NPI & name
 . S (RCCOM1,RCCOM2)=""
 . S RCNPI1=$P(RC2,U,10),RCNPI2=$P(RC2,U,11)
 . I RCNPI1'="",'$$CHKDGT^XUSNPI(RCNPI1) S RCCOM1="The Billing Provider NPI received on the 835 ("_$E(RCNPI1,1,10)_") is not a valid format."
 . I RCNPI2'="",'$$CHKDGT^XUSNPI(RCNPI2) S RCCOM2="The "_$S($P(RC2,U,12)=1:"Rendering",1:"Servicing")_" NPI received on the 835 ("_$E(RCNPI2,1,10)_") is not a valid format."
 . I RCCOM1="" S DIC("DR")=DIC("DR")_";.18////^S X=$P(RC2,U,10)"  ;Billing Provider NPI
 . I RCCOM2="" S DIC("DR")=DIC("DR")_";.19////^S X=$P(RC2,U,11)"  ;Rendering Provider NPI
 . S RCDPNM=$P(RC2,U,13) I $P(RC2,U,14)]"" S RCDPNM=RCDPNM_$S(RCDPNM]"":",",1:"")_$P(RC2,U,14)
 . S DIC("DR")=DIC("DR")_";.2////^S X=$P(RC2,U,12);.21////^S X=RCDPNM"  ; Entity Type Qualifier ^ Last name,First Name
 . S DIC("DR")=DIC("DR")_";.22////^S X=RCCOM1;.23////^S X=RCCOM2"  ;Comment on Billing provider^comment on rendering/servicing provider NPI
 . D FILE^DICN K DO,DD,DLAYGO,DIC,DIK
 . S RCCT=+Y
 . I RCCT<0 D  Q
 .. S DA=RCRTOT,DIK="^RCY(344.4," D ^DIK
 .. S RCRTOT=0
 . ; If there is no IB EOB record, store the raw data in 344.411
 . I RC1'>0!(RCEOB'>0) D
 .. N RCDATA,RCC,RCDA
 .. S RCC=2,RCDATA(1)=$G(^TMP($J,"RCDPEOB","HDR"))
 .. S Z=0 F  S Z=$O(^TMP($J,"RCDPEOB",RCCT,Z)) Q:'Z  S RCC=RCC+1,RCDATA(RCC)=$G(^TMP($J,"RCDPEOB",RCCT,Z))
 .. S RCDA(1)=RCRTOT,RCDA=RCCT
 .. D WP^DIE(344.41,$$IENS^DILF(.RCDA),1,"A","RCDATA")
 Q
 ;
 ;
ERATOT(RCTDA,RCERR) ; File ERA TOTAL rec in 344.4 from entry RCTDA in 344.5
 ; RCTDA = ien file 344.5
 ; Returns: the ien file 344.4
 ;          RCERR if passed by reference, with error text
 ;          RCERR(1)=duplicated message
 N RCTYPE,RCDA,RCMETH,RCTRACE,RCID,RCDT,RCAMT,RCDUP,RCZ,RCX,RCPAYER,DIE,DIK,DIC,DLAYGO,DD,DO,DR,DA,X,Y,Z0,Z1
 S (RCERR,RCDA)=""
 S RCZ=$G(^RCY(344.5,RCTDA,2,1,0))
 S RCTYPE=$P(RCZ,U),RCTRACE=$P(RCZ,U,8),RCID=$P(RCZ,U,7),RCPAYER=$P(RCZ,U,6),RCMETH=$P(RCZ,U,17)
 ; Need header record as first entry in field
 I RCTYPE'["835ERA" S RCERR="No header record found in message.  An EEOB exception record was created" G ERATOTQ
 ;
 S RCDT=$$FMDT^RCDPESR1($P(RCZ,U,9)),RCAMT=$J(($P(RCZ,U,10)/100),0,2)
 ;Elec ERA's must have a trace # and an ins co id
 I RCTRACE=""!(RCID="") S RCERR="Trace # or ins ID missing on ERA transaction.  An EEOB exception record was created." G ERATOTQ
 ; Make sure it's not already there
 S (RCDUP,Z1)=0
 F  S Z1=$O(^RCY(344.4,"ATRID",RCTRACE,RCID,Z1)) Q:'Z1  S Z0=$G(^RCY(344.4,Z1,0)) I $P(Z0,U,4)=RCDT,+$P(Z0,U,5)=+RCAMT S RCDUP=1 Q
 ;
 I RCDUP,$P(Z0,U,8) D  G ERATOTQ ; Receipt already exists - no update
 . S RCERR="This is a duplicate ERA and has already been posted",RCERR(1)=-2
 I RCDUP S RCERR="DUP",RCERR(1)=$S($P(Z0,U,12)'=$P($G(^RCY(344.5,RCTDA,0)),U,11):$P(Z0,U,12),1:-1) G ERATOTQ
 ;
 S RCX=+$O(^RCY(344.4," "),-1)
 S DIC(0)="L",DIC="^RCY(344.4,",DLAYGO=344.4
 S DIC("DR")=".02////"_RCTRACE_";.03////"_RCID_";.04////"_RCDT_";.05////"_RCAMT_";.06////"_$P(RCZ,U,6)_";.09////0;.12////"_$P($G(^RCY(344.5,RCTDA,0)),U,11)_";.07////"_$$NOW^XLFDT()_";.1////1"
 I RCMETH'="" S DIC("DR")=DIC("DR")_";.15////"_RCMETH
 F RCX=RCX+1:1 L +^RCY(344.4,RCX,0):1 I $T,'$D(^RCY(344.4,RCX,0)) S X=RCX Q
 D FILE^DICN K DO,DLAYGO,DD,DIC
 L -^RCY(344.4,RCX,0)
 S RCDA=$S(Y<0:"",1:+Y)
 I 'RCDA D
 . S RCERR="An error was encountered that prevented the adding of an ERA totals record.  An EEOB exception record was created."
 ;
ERATOTQ Q RCDA
 ;
UPDCON(RCRTOT) ; Add contact information to file 344.4 for an ERA
 N DIE,DA,DR,Z,Q,X,Y
 S Z=$G(^TMP($J,"RCDPEOB","CONTACT"))
 Q:$TR($P(Z,U,3,9),U)=""
 S DA=RCRTOT,DIE="^RCY(344.4,",DR=""
 F Q=3:1:9 S DR=DR_$S(DR'="":";3.0",1:"3.0")_(Q-2)_"///"_$S($P(Z,U,Q)="":"@",1:"/"_$P(Z,U,Q))
 D ^DIE
 Q
 ;
UPDADJ(RCRTOT) ; Add ERA level adj data to file 344.4
 N Z,Z0,DA,DIC,DLAYGO,DR,X,Y,DO,DD
 ; Remove any already there
 S Z=0 F  S Z=$O(^RCY(344.4,RCRTOT,2,Z)) Q:'Z  S DA(1)=RCRTOT,DA=Z D ^DIK
 ;
 S Z=0 F  S Z=$O(^TMP($J,"RCDPEOB","ADJ",Z)) Q:'Z  S Z0=$G(^(Z)) D
 . S DIC(0)="L",X=$P(Z0,U,3)_" ",DA(1)=RCRTOT,DIC="^RCY(344.4,"_DA(1)_",2,",DIC("DR")=$S($P(Z0,U,2)'="":".02////"_$P(Z0,U,2),1:"")
 . S DIC("DR")=DIC("DR")_$S(DIC("DR")'="":";",1:"")_$S($P(Z0,U,4)'="":".03////"_$J(-$P(Z0,U,4)/100,"",2),1:"")
 . S DIC("DR")=DIC("DR")_$S(DIC("DR")'="":";",1:"")_$S($P(Z0,U,5)'="":".04////"_$P(Z0,U,5),1:""),DLAYGO=344.42
 . S:$O(^RCY(344.4,RCRTOT,2,"B",X,0)) X=""""_X_""""
 . D FILE^DICN K DIC,DO,DD
 Q
 ;
DUPREC(RCET,RCCT,RCSTAR,RCFILE,RCALLDUP,RCEOB,RCBILL,RCDUPEOB) ; Overflow from RCDPESR2
 S ^TMP("RCERR1",$J,RCCT)=" ",^TMP("RCERR1",$J,RCCT,1)=RCET_RCCT_RCSTAR
 S ^TMP("RCERR1",$J,RCCT,2)="(Warning): EEOB detail already filed for "_RCBILL_" - "_$S(RCALLDUP:"Duplicate not stored",1:"EEOB updated"),^TMP("RCERR1",$J,RCCT,3)=" " S:RCFILE=5 ^TMP("RCERR1",$J,RCCT,"*")=^TMP("RCERR1",$J,RCCT,2)
 I RCALLDUP S RCEOB="",RCDUPEOB=-1 Q
 S $P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U)=RCEOB
 Q
 ;
