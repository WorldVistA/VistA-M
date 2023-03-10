PSOPRVW ;BIR/SAB,MHA-enter/edit/view provider ; 2/9/07 10:39am
 ;;7.0;OUTPATIENT PHARMACY;**11,146,153,263,268,264,398,391,450,630**;DEC 1997;Build 26
 ;
 ;Ref. to ^VA(200 supp. by IA 224
 ;Ref. to ^DIC(7 supp. by IA 491
 ;Ref.  to $$NPI^XUSNPI supp. by IA 4532
 ;Ref. to XUSERNEW supp. by 10053
 ;
START W ! S DIC("A")="Select Provider: ",DIC("S")="I $D(^VA(200,+Y,""PS""))",DIC="^VA(200,",DIC(0)="AEQMZ" D ^DIC G:"^"[X EX G:Y<0 START K DIC S PRNO=+Y
 N PSOMARG,PRVNMLBL
 S PSOMARG=$S($G(IOM):$G(IOM)-2,1:78)
 W:$D(IOF) @IOF
 S PRVNMLBL="NAME: "_$P($G(^VA(200,PRNO,0)),"^")
 W !?((PSOMARG/2)-($L(PRVNMLBL)/2)),PRVNMLBL,!
 D DISPLAY(PRNO)
 G START
EX K DIC,DIE,DA,DR,D0,PRNO,PRCLS,STAT,T,Y,X,L,LF,I,DIR,DIROUT,DUOUT,DTOUT,DIRUT,%,%Y,%W,%Z,C,DDH,DI,DIH,DLAYGO,DQ,X1,XMDT,XMN
 Q
ASK ;edit providers
 K DIR,DTOUT,DUOUT,DIROUT,DIRUT
 W !! S DIC("A")="Select Provider: ",(DIC,DIE)=200,DIC(0)="AEQMZ" D ^DIC G:"^"[X EX G:Y<0 ASK S (FADA,DA)=+Y
 I '$D(^VA(200,DA,"PS")) G NPRV
ASK1 ; Prompt for provider
 N PSOMARG,PRVNMLBL
 S PSOMARG=$S($G(IOM):$G(IOM)-2,1:78)
 W:$D(IOF) @IOF
 S PRVNMLBL="NAME: "_$P($G(^VA(200,DA,0)),"^")
 W !?((PSOMARG/2)-($L(PRVNMLBL)/2)),PRVNMLBL,!
 ;W @IOF,?2,"NAME: "_$P(^VA(200,DA,0),"^")
 D DISPLAY(DA)
EDT W ! L +^VA(200,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3)
 I '$T W $C(7),!!,"Provider Data is Being Edited by Another User!",! G QX
 N RTPB S RTPB=$G(^VA(200,DA,"TPB"))
 N PSOPOM S PSOPOM=$$GET1^DIQ(59.7,1,102,"I")       ; JCH-PSO*7*630; Pharmacy Operating Mode=MBM or VAMC
 S DR="53.91;53.6" D ^DIE I $D(Y)!$D(DTOUT) G QX    ; JCH-PSO*7*630; Prompt for PROVIDER TYPE after NON-VA 
 N PSOPX S PSOPX=$$GET1^DIQ(200,+$G(DA),53.6,"I")
 I '$$GET1^DIQ(200,DA,53.91,"I"),$G(PSOTPBFG) G QX
 I $$GET1^DIQ(200,DA,53.91,"I") S DR="53.92R;53.93R;53.94R;53.95R"
 E  S DR="53.92;53.93;53.94;53.95"
 S DR=DR_";D:X MS^PSOPRVW",DIE("NO^")="OUTOK" D ^DIE K DIE("NO^")
 I '$D(^VA(200,DA,"TPB")),$G(PSOTPBFG) G QX
 I $D(Y)!$D(DTOUT) D:$P($G(^VA(200,DA,"TPB")),"^",3)  G QX
 .I RTPB=""!('$P(RTPB,"^",3)) S DR="53.96////"_DUZ D ^DIE
 I $P($G(^VA(200,DA,"TPB")),"^",3) D
 .I RTPB=""!('$P(RTPB,"^",3)) S DR="53.96////"_DUZ D ^DIE
 N PSORTPB S PSORTPB=$G(^VA(200,DA,"TPB"))
 I $P(PSORTPB,"^",4)'=$P(RTPB,"^",4)!($P(PSORTPB,"^",5)'=$P(RTPB,"^",5)) D
 .S DR="53.96////"_DUZ D ^DIE
 G:$G(PSOTPBFG) QX
 ; PSO*7*630; Move PROVIDER TYPE (53.6), DETOX/MAINTENANCE ID NUMBER to after check of PROVIDER TYPE and NON-VA PRESCRIBER
ED1 S DR="53.1;53.2DEA NUMBER;53.11DETOX NUMBER;53.3:53.5;D DR1^PSOPRVW"  ;;747.44;29;8932.1;@1;53.7;I 'X S Y=""@2"";53.8;@2;53.9;.111:.116;.131:.134;.136;.137;.138;.141",DR(2,200.05)=".01;2;3"  ;PSO*7.0*450
 S DR(1,200,1)="D DR1^PSOPRVW"  ;Just a place holder PSO*7.0*450
 S DIE("NO^")="BACKOUTOK" D ^DIE K DIE("NO^") S FADA=DA D:'$D(Y) KEY
QX K FADA,RTPB,PSORTPB L -^VA(200,DA) Q:$G(PSOTPBFG)  K DR,DIC,DIQ G:+$G(VADA) ADD G ASK
 Q
 G:'$D(^VA(200,DA,"TPB")) ED1
ADD ;add new providers (kernel 7)
 N PSDRSTR N VADA,PSOPX
 N PSOPX S PSOPX=$$GET1^DIQ(200,+$G(DA),53.6,"I")
 S PSDRSTR="53.91;53.6;S:'($$GET1^DIQ(200,DA,53.91,""I"")) Y=""@2"";53.92R;53.93R;53.94R;53.95R;D:X MS^PSOPRVW;@2;53.1;53.2DEA NUMBER;53.11DETOX NUMBER;"
 S PSDRSTR=PSDRSTR_"S:'$$EDITCHK^PSOPRVW(+$G(DA)) Y=""@4"";55.1;55.2;55.3;55.4;55.5;55.6;747.44;29;8932.1;@4;53.3;53.4;53.5;53.7;S:'X Y=""@1"";53.8;@1;53.9;.111:.116;.131:.134;.136;.141"
 W ! S VADA=$$ADD^XUSERNEW(PSDRSTR)
 S (FADA,DA)=+VADA,(DIC,DIE)="^VA(200,"
 I VADA>0,$P(VADA,"^",3),$P($G(^VA(200,DA,"TPB")),"^") D
 .S DR="53.96////"_DUZ D ^DIE
 I VADA>0,'$P(VADA,"^",3) S DIC(0)="AEQMZ" G:'$D(^VA(200,+VADA,"PS")) NPRV G:$D(^VA(200,+VADA,"PS")) ASK1
 I VADA>0 D KEY K DIK,DIC,Y,X,VADA,VA,DEA Q:$G(PSOTPBFG)  K DA D EX G ADD
 Q
NPRV W ! S DIR("A",1)=$P(^VA(200,DA,0),"^")_" is NOT currently indicated as being a provider.",DIR("A")="Do you want to make "_$P(^VA(200,DA,0),"^")_" a provider? (Y/N): ",DIR(0)="SA^1:YES;0:NO",DIR("B")="NO"
 S DIR("?",1)="Answer with '1' or 'Yes' if "_$P(^VA(200,DA,0),"^")_" is to become a provider",DIR("?")="otherwise press return for 'No' and re-enter name." D ^DIR G:$D(DTOUT) EX
 G:'Y!($D(DIRUT))&('+$G(VADA)) ASK G:'$P(+$G(VADA),"^",3)&('Y) ADD
 G EDT
 Q
KEY I $D(^VA(200,DA,"PS")) D
 .I '$P(^VA(200,DA,"PS"),"^",4)!($P(^("PS"),"^",4)>DT) S PSOPDA=DA K DIC S DIC="^DIC(19.1,",DIC(0)="MZ",X="PROVIDER" D ^DIC K DIC S DA=PSOPDA K PSOPDA I +Y>0 S X=+Y D
 ..S:'$D(^VA(200,FADA,51,0)) ^VA(200,FADA,51,0)="^"_$P(^DD(200,51,0),"^",2)_"^^"
 ..S DIC="^VA(200,"_FADA_",51,",DIC(0)="LM",DIC("DR")="1////"_$S($G(DUZ):DUZ,1:"")_";2///"_DT,DLAYGO=200.051,DINUM=X,DA(1)=FADA
 ..L +^VA(200,FADA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) K DD,DO D FILE^DICN L -^VA(200,FADA) K DIC,DR,X,Y
 Q
MS ;
 W !!,$C(7),"This provider will not be selectable during TPB medication order entry!!",!
 Q
DR1 ;Added for processing of JUMP correctly PSO*7.0*450
 ; PSO*7*630; Use PROVIDER TYPE that was filed into $P(^VA(200,DA,"PS"),"^",6), not X. The last field has been re-requenced, so can't rely on local X at this point.
 N PSOPX S PSOPX=$$GET1^DIQ(200,+$G(DA),53.6,"I")
 I PSOPX'?1N!(PSOPX'>0)!(PSOPX'<6) Q
 I $$EDITCHK(+$G(DA)) D  Q   ; PROVIDER TYPE="C&A"or"FEE BASIS"  -OR- NON-VA PRESCRIBER="YES"    
 .N TMPDR S TMPDR="D DR1^PSOPRVW;S Y=""@1"";53.1;53.2DEA NUMBER;53.11DETOX NUMBER;53.3;53.4;53.5;@1;55.1;55.2;55.3;55.4;55.5;55.6;747.44;29;8932.1;53.7;"
 .S (DR,DR(1),DR(1,200,1))=TMPDR_"I 'X S Y=""@2"";53.8;@2;53.9;.111:.116;.131:.134;.136;.137;.138;.141"  ;_";53.1;53.2DEA NUMBER;53.11DETOX NUMBER;53.3:53.5"
 S (DR,DR(1),DR(1,200,1))="D DR1^PSOPRVW;S Y=""@1"";53.1;53.2DEA NUMBER;53.11DETOX NUMBER;53.3;53.4;53.5;@1;53.7;I 'X S Y=""@2"";53.8;@2;53.9;.111:.116;.131:.134;.136;.137;.138;.141"
 Q
EDITCHK(PSOPRDA)  ; Check fields to enable editing of DETOX NUMBER (53.11), EXPIRATION DATE (747.44), SERVICE/SECTION (29), PERSON CLASS (8932.1), SCHEDULES (55.1-55.6)
 N PROVTYP
 I '$L($$GET1^DIQ(200,PSOPRDA,.01)) Q ""
 I $$GET1^DIQ(59.7,1,102,"I")="MBM" Q 1
 I $$GET1^DIQ(200,PSOPRDA,53.91,"I") Q 1
 S PROVTYP=$$GET1^DIQ(200,PSOPRDA,53.6,"I")
 I PROVTYP=3!(PROVTYP=4) Q 1
 Q 0
DISPLAY(DA)  ; Display Provider Info from NEW PERSON file (#200)
 ; Input: DA - Provider IEN from NEW PERSON file (#200)
 N PSAR,PSDATA,PSINACT,PSINACTE,PSINACTI
 D GETS^DIQ(200,DA,53.4,"IE","PSINACT")
 S PSINACTE=$G(PSINACT(200,DA_",",53.4,"E"))
 S PSINACTI=$G(PSINACT(200,DA_",",53.4,"I"))
 ;I PSINACTI,(PSINACTI'>DT) W ?40,$C(7),"*** INACTIVE AS OF ",PSINACTE," ***"
 W !?2,"INITIALS: "_$P(^VA(200,DA,0),"^",2) I PSINACTI D
 .I PSINACTI>DT W ?40,"INACTIVE DATE: ",PSINACTE
 .I PSINACTI'>DT W ?40,$C(7),"*** INACTIVE AS OF ",PSINACTE," ***"
 N NPI S NPI=$P($$NPI^XUSNPI("Individual_ID",DA),"^") S NPI=$S(NPI>0:+NPI,1:"")
 D GETS^DIQ(200,DA,"53.91;53.92;53.93;53.94;53.95;53.96","E","PSAR")
 N PSLINE D LINEP(DA,.PSAR,53.91,,53.92),LINEP(DA,.PSAR,53.93,,53.95),LINEP(DA,.PSAR,53.94),LINEP(DA,.PSAR,53.96)
 D GETS^DIQ(200,DA,"29;53.1;53.2;53.3;53.4;53.5;53.6;53.7;53.8;53.9;53.11;55.1;55.2;55.3;55.4;55.5;55.6;.111;.112;.113;.114;.115;.116;.131;.132;.133;.134;.136;.137;.138;.141;747.44","E","PSAR")
 ; Don't print lines with no Data
 W !
 N PSLINE D LINEP(DA,.PSAR,53.1,,53.2,"DEA NUMBER")    ; "Authorized to Write Med Orders" and DEA#
 D LINEP(DA,.PSAR,53.3,,53.5)    ; VA# and Provider Class
 D LINEP(DA,.PSAR,53.6,,,$S($L($G(NPI)):"NPI",1:""),,,$S($L($G(NPI)):$G(NPI),1:""))    ; Provider Type
 ;I NPI W ?40,"NPI: ",NPI
 D LINEP(DA,.PSAR,53.7,,53.8)    ; Cosigners
 D LINEP(DA,.PSAR,747.44,,53.11,"DETOX NUMBER",2),LINEP(DA,.PSAR,55.1,,55.2),LINEP(DA,.PSAR,55.3,,55.4),LINEP(DA,.PSAR,55.5,,55.6)
 D LINEP(DA,.PSAR,53.9)
 W !?2,"SYNONYM(S):  "_$S($P($G(^VA(200,DA,.1)),"^",4)]"":$P(^(.1),"^",4)_",",1:"")_$S($P(^(0),"^",2)]"":" "_$P(^(0),"^",2),1:"")
 W !?2,"SERVICE/SECTION: "_$G(PSAR(200,DA_",",29,"E"))
 W ! D LINEP(DA,.PSAR,.111,,.112),LINEP(DA,.PSAR,.113,,.114),LINEP(DA,.PSAR,.115,,.116)
 D LINEP(DA,.PSAR,.131,,.132),LINEP(DA,.PSAR,.133,,.134),LINEP(DA,.PSAR,.136,,.137),LINEP(DA,.PSAR,.138,,.141)
 K DIC,Y
 Q
LINEP(DA,PSAR,F1,L1,F2,L2,DSPNUL,V1,V2) ; Print Line
 ; Input: DA    - Provider IEN from NEW PERSON file (#200). (required)
 ;        PSAR  - Array returned from GETS^DIQ(200,DA. (required) 
 ;        F1    - Field number from NEW PERSON file (#200) to display in left column. (required)
 ;        L1    - Label text to display with F1 field. (optional-label from ^DD(200 will be used if not passed).
 ;        F2    - Field number from NEW PERSON file (#200) to display in right column. (optional)
 ;        L2    - Label text to display with F2 field. (optional-label from ^DD(200 will be used if not passed).
 ;    DSPNUL    - Display Null data - 1:Only applies to first column/field, 2:Only applies to second column/field, 3: Both fields
 ;        V1    - Static value passed in for display field 1
 ;        V2    - Static value passed in for display field 2
 ;
 N PSDATA1,PSDATA2,LB1,LB2
 S PSDATA1="",PSDATA2="",LB1=$G(L1),LB2=$G(L2),DSPNUL=$G(DSPNUL)
 S F1=$G(F1),F2=$G(F2)
 S PSDATA1=$G(PSAR(200,DA_",",F1,"E")) S:$L($G(F2)) PSDATA2=$G(PSAR(200,DA_",",F2,"E"))
 I $L($G(V1)) S PSDATA1=V1
 I $L($G(V2)) S PSDATA2=V2
 I '$G(DSPNUL) Q:'$L(PSDATA1_PSDATA2)
 I '$L(LB1) D FIELD^DID(200,F1,,"LABEL","LABEL","ERR") S LB1=$S($L(LABEL("LABEL")):LABEL("LABEL"),1:"NO LABEL")
 Q:'$L(LB1)
 W !
 I '$L(LB2) I $L(F2) D FIELD^DID(200,F2,,"LABEL","LABEL","ERR") S LB2=$S($L(LABEL("LABEL")):LABEL("LABEL"),1:"NO LABEL")
 I $L(PSDATA1)!(DSPNUL=1)!(DSPNUL=3) W ?2,LB1_": ",PSDATA1
 I $L(PSDATA2)!(DSPNUL=2)!(DSPNUL=3) W ?40,LB2_": ",PSDATA2
 Q
