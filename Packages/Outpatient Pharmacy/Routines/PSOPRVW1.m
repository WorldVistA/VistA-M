PSOPRVW1 ;BIR/BI,MHA-enter/edit/view provider ; 11/9/2018
 ;;7.0;OUTPATIENT PHARMACY;**545**;DEC 1997;Build 270
 ;External reference to sub-file NEW DEA #'S (#200.5321) is supported by DBIA 7000
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 ;
 Q
WS(X,PSOIENS,PSOWSDWN)  ; -- Link the NEW PERSON FILE #200 DEA pointer to the DEA NUMBERS FILE #8991.9 record.
 N DNDEAIEN,DA,DR,FDA
 Q:$G(X)=""  Q:$L(PSOIENS,",")'=3
 S DNDEAIEN=$$EN^PSODEAME(X,PSOWSDWN)
 I +DNDEAIEN D
 . S FDA(2,200.5321,DIIENS,.03)=+DNDEAIEN
 . D UPDATE^DIE("","FDA(2)")
 Q
 ;
INS(X)  ; -- Check for an Institutional DEA Number
 N DNDEAIEN,TYPE
 Q:$G(X)="" 0
 S DNDEAIEN=$O(^XTV(8991.9,"B",X,0)) Q:'DNDEAIEN 0
 S TYPE=$$GET1^DIQ(8991.9,DNDEAIEN,.07)
 I TYPE="INSTITUTIONAL" Q 1
 Q 0
 ;
NULL(X,DIIENS)  ; -- Check for an User Exit without using the Copy function.
 N DNDEAIEN,DA,DR,FDA,DQ,DP,DM,DL,DK
 Q:$G(X)="" 0
 S DNDEAIEN=$O(^XTV(8991.9,"B",X,0))
 I '+DNDEAIEN D  Q 1
 . S DA=$P(DIIENS,",",1),DA(1)=$P(DIIENS,",",2)
 . S DIE="^VA(200,"_DA(1)_",""PS4"","
 . S DR=".01///@" D ^DIE
 Q 0
 ;
DEAEDT(NPIEN)  ; -- Code to use the DEA API to download and update DOJ/DEA Information
 N DEAEDQ
 S DEAEDQ=0
 ; Allow user to edit multiple DEA numbers without having to reselect provider and start over
 F  Q:$G(DEAEDQ)  D DEAEDT1(NPIEN)
 W !! D INPUSE(NPIEN)
 Q
 ;
DEAEDT1(NPIEN) ; Select one DEA number and edit it
 S DEAEDQ=0
 I '$G(NPIEN) S DEAEDQ=1 Q
 N %,%DT,CNT,DA,DIIENS,DIE,D,DI,DIC,DIR,DIRUT,DNDEAIEN,DNDEATXT,DR,D0,NPDEAIEN,NPDEALST,NPDEATXT,X,Y,SAVEX
 N DK,DL,DM,DP,DQ,PSOWSDWN,PSODEAE
 S PSOWSDWN=0  ; Web Service down flag
 ;
 ; Check VAMC/MbM mode
 ; If VAMC mode only allow for FEE BASIS and C & A provider types.
 I '$$EDITCHK^PSOPRVW(NPIEN) S DEAEDQ=2
 ;
 S NPDEALST(0)=0
 S NPDEAIEN=0 F CNT=1:1 S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  D
 . S NPDEALST(CNT)=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.01)
 . S $P(NPDEALST(CNT),U,2)=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.02)
 . N F8991P9IE,F8991P9ER S F8991P9IE=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 . I '$$FIND1^DIC(8991.9,,"AX",F8991P9IE,,,"F8991P9ER"),($P(NPDEALST(CNT),U,3)="") S $P(NPDEALST(CNT),U,2)="  **ERROR-MISSING FROM DEA NUMBERS FILE**"
 . S $P(NPDEALST(CNT),U,3)=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 . S $P(NPDEALST(CNT),U,4)=NPDEAIEN_","_NPIEN_","
 . S:$P(NPDEALST(CNT),U,3) $P(NPDEALST(CNT),U,5)=$$GET1^DIQ(8991.9,$P(NPDEALST(CNT),U,3)_",",1.6)
 . S:$P(NPDEALST(CNT),U,3) $P(NPDEALST(CNT),U,6)=$$GET1^DIQ(8991.9,$P(NPDEALST(CNT),U,3)_",",.03)
 . S NPDEALST("B",$P(NPDEALST(CNT),U,1))=NPDEALST(CNT)
 . S NPDEALST(0)=CNT
 W !!,"DEA NUMBERS",!
 I 'NPDEALST(0) W ?5," * NO DEA NUMBERS ON FILE *",!
 F CNT=1:1:NPDEALST(0) D
 . Q:'$D(NPDEALST(CNT))
 . W $E("    ",1,5-$L(CNT)),CNT," - ",$P(NPDEALST(CNT),U,1)
 . W:$P(NPDEALST(CNT),U,2)'="" "-",$P(NPDEALST(CNT),U,2)
 . W " ",$P(NPDEALST(CNT),U,5)
 . W:$P(NPDEALST(CNT),U,6)'="" "  Contains Detox # ",$P(NPDEALST(CNT),U,6)
 . W:$O(NPDEALST(CNT)) !
 I $G(DEAEDQ)=2 D  Q
 .W !,"Use EPCS GUI (EPCS Data Entry for Prescriber) to manage this provider's DEA"
 .W !,"numbers."
 Q:$G(DEAEDQ)
 K DIRUT,DIR
 S DIR(0)="FO^1:9^K:'$$DEAEDTST^PSOPRVW1(X,.NPDEALST,NPIEN,.PSOWSDWN) X"
 ;
 I $O(^VA(200,+$G(NPIEN),"PS4",0)) S DIR("A",1)="SELECT an existing entry to edit,"
 I $O(^VA(200,+$G(NPIEN),"PS4",0)) S DIR("A",2)="or type '@' to delete an existing entry."
 S DIR("A")="Type a DEA number (e.g., AA1234563) to begin a new entry"
 ;
 S DIR("?")="^D DEAHELP^PSOPRVW1"
 ;
 D ^DIR S:X="@" DIRUT=0 I $G(DIRUT) S DEAEDQ=1 Q
 S (PSODEAE,SAVEX)=X S PSODEANW='$$FIND1^DIC(8991.9,,"QA",$G(PSODEAE))
 I $G(PSOWSDWN)&$G(PSODEANW) D  Q
 .N DIR,ASTRSK S $P(ASTRSK,"*",75)="*"
 .S DIR("A",1)=" ",DIR("A",2)="  "_$E(ASTRSK,1,60)
 .S DIR("A",3)=" UNABLE TO ESTABLISH A CONNECTION TO THE DOJ/DEA WEB SERVER "
 .S DIR("A",4)="    DEA number "_PSODEAE_" cannot be added at this time "
 .S DIR("A",5)="  "_$E(ASTRSK,1,60),DIR("A",6)=" "
 .S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K X,Y,DIRUT,DUOUT
 I '$D(NPDEALST(X))&('$D(NPDEALST("B",X))) D
 . Q:$E(X)="@"
 . S:'$D(^VA(200,NPIEN,"PS4",0)) ^VA(200,NPIEN,"PS4",0)="^200.5321^^0"
 . S DIIENS=$O(^VA(200,NPIEN,"PS4",999),-1)+1_","_NPIEN_","
 . S DA=$P(DIIENS,",",1),DA(1)=$P(DIIENS,",",2)
 . S DIE="^VA(200,"_DA(1)_",""PS4"","
 . S DR=".01///"_X D ^DIE
 S X=SAVEX
 I $D(NPDEALST(X)) D
 . S DNDEATXT=$P(NPDEALST(X),U,1)
 . S DNDEAIEN=$P(NPDEALST(X),U,3)
 . S DIIENS=$P(NPDEALST(X),U,4)
 I $D(NPDEALST("B",X)) D
 . S DNDEATXT=$P(NPDEALST("B",X),U,1)
 . S DNDEAIEN=$P(NPDEALST("B",X),U,3)
 . S DIIENS=$P(NPDEALST("B",X),U,4)
 S X=SAVEX
 I X="@",$$DELDEA(.NPDEALST) Q
 I X="@" Q  ;S DEAEDQ=1 Q
 S NPDEATXT=$$GET1^DIQ(200.5321,DIIENS,.01)
 D WS^PSOPRVW1(NPDEATXT,DIIENS,PSOWSDWN)
 I $$NULL^PSOPRVW1(NPDEATXT,DIIENS) Q
 I '$$INS^PSOPRVW1(NPDEATXT) Q
 S DA=$P(DIIENS,",",1),DA(1)=$P(DIIENS,",",2)
 S DIE="^VA(200,"_DA(1)_",""PS4"",",DR=".02R",DIE("NO^")="NO" D ^DIE
 I '$D(DA),$D(DNDEATXT),DNDEAIEN,'$D(^VA(200,"PS4",DNDEATXT)) D
 . K FDA S FDA(1,8991.9,DNDEAIEN_",",.06)=0 D UPDATE^DIE("","FDA(1)") K FDA
 Q
 ;
DEAEDTST(X,NPDEALST,NPIEN,PSOWSDWN)  ; -- Input Transform for the DEAEDT Tag.
 N DIR,DNDEAIEN,FG,INST,LNAME,RESPONSEX,PSOASTK
 S RESPONSE=0,$P(PSOASTK,"*",75)="*"
 I X="@" S RESPONSE=1 G DEAEDTSX
 I $D(NPDEALST(X)) S RESPONSE=1 G DEAEDTSX
 I '$$DEANUM^PSODEAUT(X) S RESPONSE=0 D  G DEAEDTSX
 . D EN^DDIOL($C(7)_" "),EN^DDIOL($C(7)_"  DEA number is invalid.  Please check the number entered.")
 . S RESPONSE=0
 I '$$DEANUMFL^PSODEAUT(X) S RESPONSE=0 G DEAEDTSX
 S DNDEAIEN=$O(^XTV(8991.9,"B",X,0)),INST=$$GET1^DIQ(8991.9,DNDEAIEN,.07,"I")
 I INST'=1,$D(X),$D(NPIEN),$D(^VA(200,"PS4",X)),$O(^(X,0))'=NPIEN D   G DEAEDTSX
 . D EN^DDIOL($C(7)_" "),EN^DDIOL($C(7)_$E(PSOASTK,1,70))
 . D EN^DDIOL($C(7)_" DEA number "_X_" has already been assigned to another provider:")
 . N DUPIEN S DUPIEN=$O(^VA(200,"PS4",X,"")) I DUPIEN S DUPNAME=$P($G(^VA(200,+DUPIEN,0)),U)
 . I DUPIEN D
 . . D EN^DDIOL($C(7)_"     NAME: "_$G(DUPNAME))
 . . D EN^DDIOL($C(7)_"      IEN: "_DUPIEN)
 . D EN^DDIOL($C(7)_$E(PSOASTK,1,70))
 . D EN^DDIOL($C(7)_"Please check the number entered.")
 . S RESPONSE=0
 . N DIR W ! S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K X,Y,DIRUT,DUOUT
 S RESPONSE=$$WSGET^PSODEAUT(.FG,X)
 I 'RESPONSE!($P(RESPONSE,U,3)=6059) D  G DEAEDTSX
 .S PSOECODE=$P(RESPONSE,U,3) I PSOECODE=6059 S RESPONSE=PSOECODE_"^"_RESPONSE,PSOWSDWN=1 Q
 .I '$G(PSOWSDWN) W !!,"*** "_$P(RESPONSE,U,2)_" ***"
 .S RESPONSE=0
 ;
 ; Test for name match, provide an option to reject.
 S LNAME=$$GET1^DIQ(200,NPIEN,.01)
 I $G(FG("name"))'="" I $P(FG("name"),",",1)'=$P(LNAME,",",1) D
 . W !!,"DOJ NAME:   ",FG("name")
 . W !,"VISTA NAME: ",LNAME,!
 . S DIR(0)="Y"
 . S DIR("A",1)="The last names don't match."
 . S DIR("A")="Do you really want to continue"
 . D ^DIR I Y'=1 S RESPONSE=0
 ;
DEAEDTSX ; Subroutine Exit Tag
 Q RESPONSE
 ;
INPUSE(NPIEN)  ; -- Subroutine to set the DEA NUMBER "USE FOR INPATIENT ORDERS?" flag.
 N CNT,DEACNT,DIR,DIRUT,DNDEAIEN,FDA,MULTIP,NPDEAIEN,NPDEALST,UFIO,UFIOCNTY,UFIOCNTN,X,XSAVE,Y S UFIOCNTY=0,UFIOCNTN=0
 ;
 I '$O(^VA(200,NPIEN,"PS4",0)) Q
 ;
 ; Loop through the DEA numbers in the NEW PERSON FILE #200
 S CNT=0,DEACNT=0,NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  D
 . ;
 . ; Get the DEA NUMBER IEN from the pointer in the NEW PERSON FILE
 . S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I") Q:'DNDEAIEN
 . ;
 . ; Test for an INSTITUTIONAL DEA; ignore INSTITIONAL DEA Numbers?
 . Q:$$GET1^DIQ(8991.9,DNDEAIEN,.07,"I")'=2
 . ;
 . ; Load the New Person Dea List (NPDEALST)
 . ; Piece: 1 - DEA NUMBER
 . ;        2 - DEA POINTER; POINTER TO DEA NUMBERS FILE (#8991.9)
 . ;        3 - USE FOR INPATIENT ORDERS? flag from the DEA NUMBERS FILE (#8991.9)
 . S CNT=CNT+1
 . S $P(NPDEALST(CNT),U,1)=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN,.01)
 . S $P(NPDEALST(CNT),U,2)=DNDEAIEN
 . S UFIO=$$GET1^DIQ(8991.9,DNDEAIEN,.06),$P(NPDEALST(CNT),U,3)=$S(UFIO="YES":"YES",1:"NO")
 . S:UFIO="YES" UFIOCNTY=UFIOCNTY+1
 . S:UFIO'="YES" UFIOCNTN=UFIOCNTN+1
 . S DEACNT=CNT
 Q:DEACNT=0
 ;
 I DEACNT=1,$P(NPDEALST(1),U,3)="YES" Q
 I DEACNT=1,$P(NPDEALST(1),U,3)'="YES" D  Q
 . K FDA S FDA(1,8991.9,$P(NPDEALST(1),U,2)_",",.06)=1 D UPDATE^DIE("","FDA(1)") K FDA
 ;
 ; Write the list to the screen, identifying the current DEA NUMBER to "USE FOR INPATIENT ORDERS?"
 W "USE FOR INPATIENT ORDERS",!
 S CNT=0 F  S CNT=$O(NPDEALST(CNT)) Q:'CNT  D
 . W $E("    ",1,5-$L(CNT)),CNT," - ",$P(NPDEALST(CNT),U,1)," - "_$P(NPDEALST(CNT),U,3)
 . W:$O(NPDEALST(CNT)) !
 ;
IPSLOOP ; Loop to prevent the user from existing without selecting a DEA number for inpatient usage.
 ; Set up the user interface prompt to select the "ONE" DEA NUMBER to be used for inpatient orders.
 ; If there are more than one DEA NUMBER currently and none selected, make it a required response.
 ; If there are more than one DEA NUMBER currently selected, make it a required response.
 ; If there is only one DEA NUMBER, make it a required response, and default to 1.
 K DIRUT,DIR S DIR(0)="F"_$S(UFIOCNTY=0:"",UFIOCNTY>1:"",DEACNT=1:"",1:"O")_"^1:9^K:'$D(NPDEALST(X)) X"
 S DIR("A")="SELECT a DEA NUMBER to change INPATIENT USAGE"
 S:DEACNT=1 DIR("B")=1
 S DIR("?",1)="Select a choice from the list above."
 S DIR("?")="Must be a numeric value from the list above."
 D ^DIR
 I UFIOCNTY=0,((X="^")!(X="^^")) W !!,"THERE MUST BE ONE DEA SELECTED FOR INPATIENT ORDERS." G IPSLOOP
 I UFIOCNTY>1,((X="^")!(X="^^")) W !!,"THERE CAN BE ONLY ONE DEA SELECTED FOR INPATIENT ORDERS." G IPSLOOP
 I $G(DIRUT) W ! Q
 W !
 S XSAVE=X
 ;
 ; Set up the FDA array; marking the selected DEA NUMBER equal to YES(1) and the other DEA NUMBERS equal to NO(0)
 S CNT=0,MULTIP=0 F  S CNT=$O(NPDEALST(CNT)) Q:'CNT  D
 . I CNT=XSAVE S FDA(1,8991.9,$P(NPDEALST(CNT),U,2)_",",.06)=1 Q
 . I $P(NPDEALST(CNT),U,3)="YES" D
 .. S MULTIP=MULTIP+1
 .. W !,"DEA # "_$P(NPDEALST(CNT),U,1)_" is already flagged as ""Use for Inpatient Orders""."
 .. S FDA(1,8991.9,$P(NPDEALST(CNT),U,2)_",",.06)=0
 ;
 ; Ask the user to verify the "Update".  Apply the FDA array for a "YES" response.
 K DIRUT,DIR
 I MULTIP D
 . S DIR(0)="Y",DIR("B")="YES"
 . S DIR("A",1)="The previous DEA # will no longer be flagged as ""Use for Inpatient Orders""."
 . S DIR("A")="Do you want to proceed with this change"
 . D ^DIR
 I Y=1 D UPDATE^DIE("","FDA(1)")
 I 'MULTIP D UPDATE^DIE("","FDA(1)")
 ;
 ; Re-Display the changes.
 W !
 N NPDEATXT S NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  D
 . S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I") Q:'DNDEAIEN
 . Q:$$GET1^DIQ(8991.9,DNDEAIEN,.07,"I")'=2
 . S NPDEATXT=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN,.01)
 . S UFIO=$$GET1^DIQ(8991.9,DNDEAIEN,.06)
 . W "        ",NPDEATXT," - "_$S(UFIO="YES":"YES",1:"NO"),!
 Q
 ;
DELDEA(NPDEALST) ; -- Code used to add/edit/delete the VA Number
 N ACNT,D,DA,DEATYPE,DI,DIC,DIE,DIE1,DIEDA,DIEL,DIETMP,DIEXREF,DIFLD,DIR,DNDEAIEN
 N DNDETOX,DR,NPDEACNT,NPDEATXT,RESPONSE,VANUMBER,X,Y,SELECTED
 S RESPONSE=0
 I '$G(NPDEALST(0)) D  Q RESPONSE
 . W " ** No DEA Numbers to Delete ** "
 K DIRUT,DIR S DIR(0)="NO^1:"_NPDEALST(0)_":0^"
 S DIR("A",1)=" "
 S DIR("A")="Select a choice from the list for DELETION."
 S DIR("?")="Enter a number from the list above."
 D ^DIR I $G(DIRUT) G DELDEAQ
 S SELECTED=X
 S DIIENS=$P(NPDEALST(SELECTED),"^",4)
 I $L(DIIENS,",")'=3 G DELDEAQ
 S NPDEACNT=$$NPDEACNT($P(DIIENS,",",2))
 S VANUMBER=$$GET1^DIQ(200,$P(DIIENS,",",2),53.3)
 S NPDEATXT=$$GET1^DIQ(200.5321,DIIENS,.01)
 S DNDEAIEN=$$GET1^DIQ(200.5321,DIIENS,.03,"I")
 S DNDETOX=$$GET1^DIQ(8991.9,DNDEAIEN,.03)
 S DEATYPE=$$GET1^DIQ(8991.9,DNDEAIEN,.07,"I")
 S DA=$P(DIIENS,",",1),DA(1)=$P(DIIENS,",",2)
 S DIR("A")="DO YOU STILL WANT TO DELETE THIS DEA NUMBER"
 S ACNT=0
 S ACNT=ACNT+1,DIR("A",ACNT)=" "
 S ACNT=ACNT+1,DIR("A",ACNT)="Removing the DEA number does not affect previously written prescriptions."
 I VANUMBER="",NPDEACNT=1 D
 . S ACNT=ACNT+1,DIR("A",ACNT)="This is the only DEA number on file for this provider. The provider will no"
 . S ACNT=ACNT+1,DIR("A",ACNT)="longer be able to prescribe controlled substances at the VA."
 I DNDETOX'="" D
 . S ACNT=ACNT+1,DIR("A",ACNT)="This DEA # contains Detox # "_DNDETOX_". To maintain the Detox #,"
 . S ACNT=ACNT+1,DIR("A",ACNT)="please add it to another DEA # on the provider's profile."
 S ACNT=ACNT+1,DIR("A",ACNT)=" "
 S DIR(0)="Y" D ^DIR K DIR G:Y'=1 DELDEAQ
 S DIE="^VA(200,"_DA(1)_",""PS4"",",DR=".01///@" D ^DIE K DIE,DR,DA
 I DEATYPE=2 S DA=DNDEAIEN,DIK="^XTV(8991.9," D ^DIK K DIK,DA
 S RESPONSE=1
DELDEAQ  ; -- Common Exit Point
 Q RESPONSE
 ;
NPDEACNT(NPIEN) ; -- Function used to count the number of DEA numbers for a provider.
 N NPDEAIEN,NPDEACNT
 S NPDEAIEN=0 F NPDEACNT=0:1 S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:+NPDEAIEN=0
 Q NPDEACNT
 ;
DEAHELP ; DEA prompt help text for ^DIR(0)
 I $G(X)'="?" D REDISP Q
 W !,"Enter a New DEA Number."
 I $O(^VA(200,+$G(NPIEN),"PS4",0)) W !,"Select a choice from the list above or,"
 I $O(^VA(200,+$G(NPIEN),"PS4",0)) W !,"Or type '@' to delete an existing entry."
 W !,"DEA NUMBERS must be valid, 2 letters and 7 numbers."
 ;
 D REDISP
 Q
 ;
REDISP ; Redisplay DEA numbers
 N NPDEALST,CNT
 S NPDEALST(0)=0
 S NPDEAIEN=0 F CNT=1:1 S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  D
 . S NPDEALST(CNT)=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.01)
 . S $P(NPDEALST(CNT),U,2)=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.02)
 . S $P(NPDEALST(CNT),U,3)=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 . N F8991P9IE,F8991P9ER S F8991P9IE=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 . I '$$FIND1^DIC(8991.9,,"AX",F8991P9IE,,,"F8991P9ER"),($P(NPDEALST(CNT),U,3)="") S $P(NPDEALST(CNT),U,2)="  **ERROR-MISSING FROM DEA NUMBERS FILE**"
 . S $P(NPDEALST(CNT),U,4)=NPDEAIEN_","_NPIEN_","
 . S:$P(NPDEALST(CNT),U,3) $P(NPDEALST(CNT),U,5)=$$GET1^DIQ(8991.9,$P(NPDEALST(CNT),U,3)_",",1.6)
 . S:$P(NPDEALST(CNT),U,3) $P(NPDEALST(CNT),U,6)=$$GET1^DIQ(8991.9,$P(NPDEALST(CNT),U,3)_",",.03)
 . S NPDEALST("B",$P(NPDEALST(CNT),U,1))=NPDEALST(CNT)
 . S NPDEALST(0)=CNT
 W !!,"DEA NUMBERS",!
 I 'NPDEALST(0) W ?5," * NO DEA NUMBERS ON FILE *",!
 F CNT=1:1:NPDEALST(0) D
 . Q:'$D(NPDEALST(CNT))
 . W $E("    ",1,5-$L(CNT)),CNT," - ",$P(NPDEALST(CNT),U,1)
 . W:$P(NPDEALST(CNT),U,2)'="" "-",$P(NPDEALST(CNT),U,2)
 . W " ",$P(NPDEALST(CNT),U,5)
 . W:$P(NPDEALST(CNT),U,6)'="" "  Contains Detox # ",$P(NPDEALST(CNT),U,6)
 . W:$O(NPDEALST(CNT)) !
 Q
