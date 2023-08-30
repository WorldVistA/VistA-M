PSOPRVW ;BIR/SAB,MHA-enter/edit/view provider ;3/10/22  16:20
 ;;7.0;OUTPATIENT PHARMACY;**11,146,153,263,268,264,398,391,450,630,545**;DEC 1997;Build 270
 ;
 ;Ref. to ^VA(200 supp. by IA 224
 ;Ref. to ^DIC(7 supp. by IA 491
 ;Ref.  to $$NPI^XUSNPI supp. by IA 4532
 ;Ref. to XUSERNEW supp. by 10053
 ;External reference to sub-file NEW DEA #'S (#200.5321) is supported by DBIA 7000
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 ;
START W ! S DIC("A")="Select Provider: ",DIC("S")="I $D(^VA(200,+Y,""PS""))",DIC="^VA(200,",DIC(0)="AEQMZ" D ^DIC G:U[X EX G:Y<0 START K DIC S PRNO=+Y
 ;N PSOMARG,PRVNMLBL
 ;S PSOMARG=$S($G(IOM):$G(IOM)-6,1:74)
 ;W:$D(IOF) @IOF
 ;S PRVNMLBL="NAME: "_$P($G(^VA(200,PRNO,0)),"^")
 ;W !?((PSOMARG/2)-($L(PRVNMLBL)/2)),PRVNMLBL,!
 ;W @IOF,?2,"NAME: "_$P(^VA(200,PRNO,0),U) G:$$CHKP START
 ;I +$P(^VA(200,PRNO,"PS"),U,4),$P(^("PS"),U,4)'>DT W ?40,$C(7),"* * * INACTIVE AS OF ",$E($P(^("PS"),U,4),4,5),"/",$E($P(^("PS"),U,4),6,7),"/",$E($P(^("PS"),U,4),2,3)," * * *"
 ;W !?2,"INITIALS: "_$P(^VA(200,PRNO,0),U,2)
 D PRNAMDSP(PRNO)
 D DISPLAY(PRNO)
 G START
EX K DIC,DIE,DA,DR,D0,PRNO,PRCLS,STAT,T,Y,X,L,LF,I,DIR,DIROUT,DUOUT,DTOUT,DIRUT,%,%Y,%W,%Z,C,DDH,DI,DIH,DLAYGO,DQ,X1,XMDT,XMN
 Q
ASK ;edit providers
 K DIR,DTOUT,DUOUT,DIROUT,DIRUT,FMG,FMGO,FMGX,MSG,EXIT S EXIT=0
 W !! S DIC("A")="Select Provider: ",(DIC,DIE)=200,DIC(0)="AEQMZ" D ^DIC G:U[X EX G:Y<0 ASK S (FADA,DA)=+Y
 I '$D(^VA(200,DA,"PS")) G NPRV
ASK1 ; Prompt for provider
 ;N PSOMARG,PRVNMLBL
 ;S PSOMARG=$S($G(IOM):$G(IOM)-6,1:74)
 ;W:$D(IOF) @IOF
 ;S PRVNMLBL="NAME: "_$P($G(^VA(200,DA,0)),"^")
 ;W !?((PSOMARG/2)-($L(PRVNMLBL)/2)),PRVNMLBL,! G:$$CHKP START
 D PRNAMDSP(DA)
 D DISPLAY(DA) G:$G(EXIT) START
EDT W ! L +^VA(200,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3)
 I '$T W $C(7),!!,"Provider Data is Being Edited by Another User!",! G QX
 N RTPB S RTPB=$G(^VA(200,DA,"TPB"))
 N PSOPOM S PSOPOM=$$GET1^DIQ(59.7,1,102,"I")       ; JCH-PSO*7*630; Pharmacy Operating Mode=MBM or VAMC
 S DR="53.91;53.6" D ^DIE I $D(Y)!$D(DTOUT) G QX    ; JCH-PSO*7*630; Prompt for PROVIDER TYPE after NON-VA 
 I '$$GET1^DIQ(200,DA,53.91,"I"),$G(PSOTPBFG) G QX
 I $$GET1^DIQ(200,DA,53.91,"I") S DR="53.92R;53.93R;53.94R;53.95R"
 E  S DR="53.92;53.93;53.94;53.95"
 S DR=DR_";D:X MS^PSOPRVW",DIE("NO^")="OUTOK" D ^DIE K DIE("NO^")
 I '$D(^VA(200,DA,"TPB")),$G(PSOTPBFG) G QX
 I $D(Y)!$D(DTOUT) D:$P($G(^VA(200,DA,"TPB")),U,3)  G QX
 .I RTPB=""!('$P(RTPB,U,3)) S DR="53.96////"_DUZ D ^DIE
 I $P($G(^VA(200,DA,"TPB")),U,3) D
 .I RTPB=""!('$P(RTPB,U,3)) S DR="53.96////"_DUZ D ^DIE
 N PSORTPB S PSORTPB=$G(^VA(200,DA,"TPB"))
 I $P(PSORTPB,U,4)'=$P(RTPB,U,4)!($P(PSORTPB,U,5)'=$P(RTPB,U,5)) D
 .S DR="53.96////"_DUZ D ^DIE
 G:$G(PSOTPBFG) QX
 ; PSO*7*630; Move PROVIDER TYPE (53.6), DETOX/MAINTENANCE ID NUMBER to after check of PROVIDER TYPE and NON-VA PRESCRIBER
ED1 ; Edit provider
 S DR="53.1"
 S DIE("NO^")="OUTOK" D ^DIE I $D(Y)!$D(DTOUT) G QX
 D DEAEDT^PSOPRVW1(DA)
 D VANUMEDT(DA) I $D(DTOUT) K DTOUT G QX
 S DR="53.4;53.5;D DR1^PSOPRVW"
 S DR(1,200,1)="D DR1^PSOPRVW"  ;Just a place holder PSO*7.0*450
 S DIE("NO^")="OUTOK" D ^DIE K DIE("NO^") S FADA=DA D:'$D(Y) KEY
QX K FADA,RTPB,PSORTPB L -^VA(200,DA) Q:$G(PSOTPBFG)  K DR,DIC,DIQ G:+$G(VADA) ADD G ASK
 Q
 G:'$D(^VA(200,DA,"TPB")) ED1
ADD ;add new providers (kernel 7)
 N PSDRSTR N VADA ;,PSOPX
 S PSDRSTR="53.91;53.6;S:'($$GET1^DIQ(200,DA,53.91,""I"")) Y=""@2"";53.92R;53.93R;53.94R;53.95R;D:X MS^PSOPRVW;@2;53.1;"
 W ! S VADA=$$ADD^XUSERNEW(PSDRSTR)
 S (FADA,DA)=+VADA,(DIC,DIE)="^VA(200,"
 I VADA>0,$P(VADA,U,3) D
 . D DEAEDT^PSOPRVW1(DA)
 . D VANUMEDT(DA) I $D(DTOUT) K DTOUT Q
 . K DR I $$EDITCHK^PSOPRVW(+$G(FADA)) S DR="29;8932.1;"
 . S DR=$G(DR)_"53.4;53.5;53.7;S:'X Y=""@1"";53.8;@1;53.9;.111:.116;.131:.134;.136;.141"
 . D ^DIE
 I VADA>0,$P(VADA,U,3),$P($G(^VA(200,DA,"TPB")),U) D
 .S DR="53.96////"_DUZ S DIE("NO^")="OUTOK" D ^DIE
 I VADA>0,'$P(VADA,U,3) S DIC(0)="AEQMZ" G:'$D(^VA(200,+VADA,"PS")) NPRV G:$D(^VA(200,+VADA,"PS")) ASK1
 I VADA>0 D KEY K DIK,DIC,Y,X,VADA,VA,DEA Q:$G(PSOTPBFG)  K DA D EX G ADD
 Q
NPRV W ! S DIR("A",1)=$P(^VA(200,DA,0),U)_" is NOT currently indicated as being a provider.",DIR("A")="Do you want to make "_$P(^VA(200,DA,0),U)_" a provider? (Y/N): ",DIR(0)="SA^1:YES;0:NO",DIR("B")="NO"
 S DIR("?",1)="Answer with '1' or 'Yes' if "_$P(^VA(200,DA,0),U)_" is to become a provider",DIR("?")="otherwise press return for 'No' and re-enter name." D ^DIR G:$D(DTOUT) EX
 G:'Y!($D(DIRUT))&('+$G(VADA)) ASK G:'$P(+$G(VADA),U,3)&('Y) ADD
 G EDT
 Q
KEY I $D(^VA(200,DA,"PS")) D
 .I '$P(^VA(200,DA,"PS"),U,4)!($P(^("PS"),U,4)>DT) S PSOPDA=DA K DIC S DIC="^DIC(19.1,",DIC(0)="MZ",X="PROVIDER" D ^DIC K DIC S DA=PSOPDA K PSOPDA I +Y>0 S X=+Y D
 ..S:'$D(^VA(200,FADA,51,0)) ^VA(200,FADA,51,0)=U_$P(^DD(200,51,0),U,2)_"^^"
 ..S DIC="^VA(200,"_FADA_",51,",DIC(0)="LM",DIC("DR")="1////"_$S($G(DUZ):DUZ,1:"")_";2///"_DT,DLAYGO=200.051,DINUM=X,DA(1)=FADA
 ..L +^VA(200,FADA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) K DD,DO D FILE^DICN L -^VA(200,FADA) K DIC,DR,X,Y
 Q
MS ;
 W !!,$C(7),"This provider will not be selectable during TPB medication order entry!!",!
 Q
DR1 ;Added for processing of JUMP correctly PSO*7.0*450
 ; PSO*7*630; Use PROVIDER TYPE that was filed into $P(^VA(200,DA,"PS"),U,6), not X. The last field has been re-requenced, so can't rely on local X at this point.
 N PSOPX S PSOPX=$$GET1^DIQ(200,+$G(DA),53.6,"I")
 I PSOPX'?1N!(PSOPX'>0)!(PSOPX'<6) Q
 I $$EDITCHK(+$G(DA)) D  Q   ; PROVIDER TYPE="C&A"or"FEE BASIS"  -OR- NON-VA PRESCRIBER="YES"    
 .N TMPDR S TMPDR="D DR1^PSOPRVW;S Y=""@1"";53.1;53.3;53.4;53.5;@1;29;8932.1;53.7;"
 .S (DR,DR(1),DR(1,200,1))=TMPDR_"I 'X S Y=""@2"";53.8;@2;53.9;.111:.116;.131:.134;.136;.137;.138;.141"  ;_";53.1;53.3:53.5"
 S (DR,DR(1),DR(1,200,1))="D DR1^PSOPRVW;S Y=""@1"";53.1;53.3;53.4;53.5;@1;53.7;I 'X S Y=""@2"";53.8;@2;53.9;.111:.116;.131:.134;.136;.137;.138;.141"
 Q
CHKP(ROWPAD)  ; Check for End Of Page
 N X,Y,DTOUT,DUOUT,DIRUT,DIR,RESPONSE S RESPONSE=0
 S:'$G(ROWPAD) ROWPAD=6
 I $Y>(IOSL-ROWPAD) S DIR(0)="E" D ^DIR S:$D(DIRUT) RESPONSE=1 W @IOF D PRNAMDSP(PRNO)
 Q RESPONSE
VANUMEDT(DA) ; -- Code used to add/edit/delete the VA Number
 N ACNT,DIE,DIR,DR,X,Y
VANUMEDC  ; -- Loop Continuation Point
 S DIR(0)="200,53.3" D ^DIR
 I $G(X)="^" S DTOUT=1 Q
 I $G(X)["^" W !,$C(7),"   No Jumping allowed??" G VANUMEDC
 I $G(X)="@" D  Q
 . S DIR("A")="DO YOU STILL WANT TO DELETE THIS VA NUMBER"
 . S ACNT=0
 . S ACNT=ACNT+1,DIR("A",ACNT)="Removing the VA number does not affect previously written prescriptions."
 . I '$$NPDEACNT^PSOPRVW1(DA) D
 .. S ACNT=ACNT+1,DIR("A",ACNT)="There are no DEA#'s on file for this provider.  The provider will no"
 .. S ACNT=ACNT+1,DIR("A",ACNT)="longer be able to prescribe controlled substances at the VA."
 . S ACNT=ACNT+1,DIR("A",ACNT)=" "
 . S DIR(0)="Y" D ^DIR
 . I Y=1 S DIE="^VA(200,",DR="53.3///@" D ^DIE Q
 ;S DIE="^VA(200,",DR="53.3////"_X D ^DIE
 N FDA S FDA(200,DA_",",53.3)=X D FILE^DIE("","FDA","MSGROOT")
 Q
 ;
EDITCHK(PSOPRDA)  ; Check fields to enable editing of DETOX NUMBER , EXPIRATION DATE , SERVICE/SECTION (29), PERSON CLASS (8932.1), SCHEDULES 
 ; INPUT: PSOPRDA = Provider DUZ
 N PROVTYP K EDCHKRET S EDCHKRET="000"
 I '$L($$GET1^DIQ(200,PSOPRDA,.01)) Q ""
 I $$POM="MBM" S $E(EDCHKRET)=1
 I $$GET1^DIQ(200,PSOPRDA,53.91,"I") S $E(EDCHKRET,2)=1
 S PROVTYP=$$GET1^DIQ(200,PSOPRDA,53.6,"I")
 I PROVTYP=3!(PROVTYP=4) S $E(EDCHKRET,3)=1
 Q EDCHKRET
 ;
DISPLAY(PRNO)  ; Display Provider Info from NEW PERSON file (#200)
 ; Input: PRNO - Provider IEN from NEW PERSON file (#200)
 N PSAR,PSDATA S EXIT=0
 W ?2,"NAME: "_$P(^VA(200,PRNO,0),U)
 D GETS^DIQ(200,PRNO,53.4,"IE","PSINACT")
 S PSINACTE=$G(PSINACT(200,PRNO_",",53.4,"E"))
 S PSINACTI=$G(PSINACT(200,PRNO_",",53.4,"I"))
 W !?2,"INITIALS: "_$P(^VA(200,PRNO,0),"^",2) I PSINACTI D
 .I PSINACTI>DT W ?40,"INACTIVE DATE: ",PSINACTE
 .I PSINACTI'>DT W ?40,$C(7),"*** INACTIVE AS OF ",PSINACTE," ***"
 N NPI S NPI=$P($$NPI^XUSNPI("Individual_ID",PRNO),U) S NPI=$S(NPI>0:+NPI,1:"")
 D GETS^DIQ(200,PRNO,"53.91;53.92;53.93;53.94;53.95;53.96","E","PSAR")
 N PSLINE D LINEP(PRNO,.PSAR,53.91,,53.92),LINEP(PRNO,.PSAR,53.93,,53.95),LINEP(PRNO,.PSAR,53.94),LINEP(PRNO,.PSAR,53.96)
 D GETS^DIQ(200,PRNO,"29;53.1;53.3;53.4;53.5;53.6;53.7;53.8;53.9;55.1;55.2;55.3;55.4;55.5;55.6;.111;.112;.113;.114;.115;.116;.131;.132;.133;.134;.136;.137;.138;.141","E","PSAR")
 ; Don't print lines with no Data
 N PSLINE D LINEP(PRNO,.PSAR,53.1)  ; "Authorized to Write Med Orders" 
 ;
 ; PSO*7*545 - Multiple DEA Enhancements
 N NPDEAIEN,DNDEAIEN,EXIT
 W ! G:$$CHKP START
 N SET,SETARRAY,LINE S SET=0
 S NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,PRNO,"PS4",NPDEAIEN)) Q:'+NPDEAIEN  D
 . N PSODOJE
 . S DNDEAIEN=$P(^VA(200,PRNO,"PS4",NPDEAIEN,0),U,3) Q:DNDEAIEN=""
 . S PSODOJE=$G(^XTV(8991.9,DNDEAIEN,0)) Q:PSODOJE=""
 . S SET=SET+1,LINE=0
 . S LINE=LINE+1,SETARRAY(SET,LINE)="DEA NUMBER: "_$P(PSODOJE,U,1)
 . S:$P(^VA(200,PRNO,"PS4",NPDEAIEN,0),U,2)'="" SETARRAY(SET,LINE)=SETARRAY(SET,LINE)_"-"_$P(^VA(200,PRNO,"PS4",NPDEAIEN,0),U,2)
 . S LINE=LINE+1,SETARRAY(SET,LINE)="DEA EXPIRATION DATE: " S T=+$P(^XTV(8991.9,DNDEAIEN,0),U,4) S:T SETARRAY(SET,LINE)=SETARRAY(SET,LINE)_$$FMTE^XLFDT(T)
 . S LINE=LINE+1,SETARRAY(SET,LINE)="  USE FOR INPATIENT ORDERS: " S T=+$P(^XTV(8991.9,DNDEAIEN,0),U,6) S SETARRAY(SET,LINE)=SETARRAY(SET,LINE)_$S(T:"YES",1:"NO")
 . S:$P(^XTV(8991.9,DNDEAIEN,0),U,3)'="" LINE=LINE+1,SETARRAY(SET,LINE)="              DETOX NUMBER: "_$P(^XTV(8991.9,DNDEAIEN,0),U,3)
 . N SCHNODE S SCHNODE=$G(^XTV(8991.9,DNDEAIEN,2)) D:SCHNODE'=""
 .. I $$GET1^DIQ(8991.9,DNDEAIEN,.07)="INSTITUTIONAL" S SCHNODE=$G(^VA(200,PRNO,"PS3"))
 .. S LINE=LINE+1,SETARRAY(SET,LINE)="      SCHEDULE II NARCOTIC: "_$S($P(SCHNODE,U,1):"YES",1:"NO")
 .. S LINE=LINE+1,SETARRAY(SET,LINE)="  SCHEDULE II NON-NARCOTIC: "_$S($P(SCHNODE,U,2):"YES",1:"NO")
 .. S LINE=LINE+1,SETARRAY(SET,LINE)="     SCHEDULE III NARCOTIC: "_$S($P(SCHNODE,U,3):"YES",1:"NO")
 .. S LINE=LINE+1,SETARRAY(SET,LINE)=" SCHEDULE III NON-NARCOTIC: "_$S($P(SCHNODE,U,4):"YES",1:"NO")
 .. S LINE=LINE+1,SETARRAY(SET,LINE)="               SCHEDULE IV: "_$S($P(SCHNODE,U,5):"YES",1:"NO")
 .. S LINE=LINE+1,SETARRAY(SET,LINE)="                SCHEDULE V: "_$S($P(SCHNODE,U,6):"YES",1:"NO")
 .  S:'$D(SETARRAY(SET,10)) SETARRAY(SET,10)=""
 ;
 S EXIT=0
 F SET=1:2:$O(SETARRAY(100),-1) Q:($G(EXIT)=1)  D
 . W ! I $$CHKP(6) S EXIT=1 Q
 . F LINE=1:1:10 Q:EXIT  D
 .. Q:'$D(SETARRAY(SET))  ; Should never happen - IEN in 200.5321 doesn't exist in 8991.9
 .. W SETARRAY(SET,LINE),?40,$G(SETARRAY(SET+1,LINE)),!
 .. I SETARRAY(SET,LINE)="" I $$CHKP(6) S EXIT=1 Q
 K SETARRAY,SET,LINE
 Q:EXIT=1  W ! I $$CHKP(20) S EXIT=1 Q
 ;
 D LINEP(PRNO,.PSAR,53.3,,53.5) I $$CHKP S EXIT=1 Q    ; VA# and Provider Class
 N DEAUSER,HASVANO,DEAIPEXDT
 S DEAUSER=$$DEA^XUSER(0,PRNO)
 S HASVANO=$$DEA^XUSER(1,PRNO)
 S DEAIPEXDT=$$DEAXDT^XUSER($$PRDEA^XUSER(PRNO))
 I (DEAUSER["-")!((DEAUSER="")&(HASVANO]""))!(DEAIPEXDT&(DEAIPEXDT<$$DT^XLFDT)) D SKED200
 D LINEP(PRNO,.PSAR,53.6,,,$S($L($G(NPI)):"NPI",1:""),,,$S($L($G(NPI)):NPI,1:"")) I $$CHKP S EXIT=1 Q    ; Provider Type
 D LINEP(PRNO,.PSAR,53.7,,53.8) I $$CHKP S EXIT=1 Q    ; Cosigners
 D LINEP(PRNO,.PSAR,53.9) I $$CHKP S EXIT=1 Q
 W !?2,"SYNONYM(S):  "_$S($P($G(^VA(200,PRNO,.1)),U,4)]"":$P(^(.1),U,4)_",",1:"")_$S($P(^(0),U,2)]"":" "_$P(^(0),U,2),1:"") I $$CHKP S EXIT=1 Q
 W !?2,"SERVICE/SECTION: "_$G(PSAR(200,PRNO_",",29,"E")) I $$CHKP S EXIT=1 Q
 W ! D LINEP(PRNO,.PSAR,.111,,.112),LINEP(PRNO,.PSAR,.113,,.114),LINEP(PRNO,.PSAR,.115,,.116) I $$CHKP S EXIT=1 Q
 D LINEP(PRNO,.PSAR,.131,,.132),LINEP(PRNO,.PSAR,.133,,.134),LINEP(PRNO,.PSAR,.136,,.137),LINEP(PRNO,.PSAR,.138,,.141)
 K DIC,Y
 Q
SKED200 ;
 N SKED200 S SKED200=$G(^VA(200,PRNO,"PS3")) D:SKED200'=""
 . W !,"      SCHEDULE II NARCOTIC: "_$S($P(SKED200,U,1):"YES",1:"NO")
 . W !,"  SCHEDULE II NON-NARCOTIC: "_$S($P(SKED200,U,2):"YES",1:"NO")
 . W !,"     SCHEDULE III NARCOTIC: "_$S($P(SKED200,U,3):"YES",1:"NO")
 . W !," SCHEDULE III NON-NARCOTIC: "_$S($P(SKED200,U,4):"YES",1:"NO")
 . W !,"               SCHEDULE IV: "_$S($P(SKED200,U,5):"YES",1:"NO")
 . W !,"                SCHEDULE V: "_$S($P(SKED200,U,6):"YES",1:"NO")
 . W !,""
 Q
LINEP(DA,PSAR,F1,L1,F2,L2,DSPNUL,V1,V2) ; Print Line
 ; Input: DA    - Provider IEN from NEW PERSON file (#200). (required)
 ;        PSAR  - Array returned from GETS^DIQ(200,DA. (required) 
 ;        F1    - Field number from NEW PERSON file (#200) to display in left column. (required)
 ;        L1    - Label text to display with F1 field. (optional-label from ^DD(200 will be used if not passed).
 ;        F2    - Field number from NEW PERSON file (#200) to display in right column. (optional)
 ;        L2    - Label text to display with F2 field. (optional-label from ^DD(200 will be used if not passed).
 ;    DSPNUL    - Display Null data - 1:Only applies to first column/field, 2:Only applies to second column/field, 3: Both fields
 ;        V1    - Constant value to be displayed with label 1
 ;        V2    - Constant value to be displayed with label 2
 N PSDATA1,PSDATA2,LB1,LB2
 S PSDATA1="",PSDATA2="",LB1=$G(L1),LB2=$G(L2),DSPNUL=$G(DSPNUL),F1=$G(F1),F2=$G(F2),V1=$G(V1),V2=$G(V2)
 I $L(F1) S PSDATA1=$G(PSAR(200,DA_",",F1,"E"))
 I $L(F2) S PSDATA2=$G(PSAR(200,DA_",",F2,"E")) ; Get values from New Person file
 I $L(V1) S PSDATA1=V1
 I $L(V2) S PSDATA2=V2
 I '$G(DSPNUL) Q:'$L(PSDATA1_PSDATA2)  ; display null labels?
 I '$L(LB1) D FIELD^DID(200,F1,,"LABEL","LABEL","ERR") S LB1=$S($L(LABEL("LABEL")):LABEL("LABEL"),1:"NO LABEL")
 Q:'$L(LB1)
 W !
 I '$L(LB2) I $L(F2) D FIELD^DID(200,F2,,"LABEL","LABEL","ERR") S LB2=$S($L(LABEL("LABEL")):LABEL("LABEL"),1:"NO LABEL")
 I $L(PSDATA1)!(DSPNUL=1)!(DSPNUL=3) W ?2,LB1_": ",PSDATA1
 I $L(PSDATA2)!(DSPNUL=2)!(DSPNUL=3) W ?40,LB2_": ",PSDATA2
 Q
 ;
POM() ; Pharmacy Operating Mode
 N POM S POM=$$GET1^DIQ(59.7,1,102,"I")
 Q POM
 ;
PRNAMDSP(PRNO) ; Display provider name and label
 N PSOMARG,PRVNMLBL
 S PSOMARG=$S($G(IOM):$G(IOM)-6,1:74)
 W:$D(IOF) @IOF
 S PRVNMLBL="NAME: "_$P($G(^VA(200,PRNO,0)),"^")
 W !?((PSOMARG/2)-($L(PRVNMLBL)/2)),PRVNMLBL,!
 Q
