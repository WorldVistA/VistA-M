MDARSET ; HOIFO/NCA - High Volume Check-In Setup ;6/30/09  10:00
 ;;1.0;CLINICAL PROCEDURES;**21**;Apr 01, 2004;Build 30
 ; Reference IA # 2263 [Supported] XPAR parameter calls
 ;               10104 [Supported] XLFSTR call
 ;
EN1 ; Entry Point for the setup option
 N MDAPT,MDAR,MDCP,MDCP1,MDCT,MDDEF,MDERR,MDKK,MDLST,MDLST1,MDMF,MDNOD,MDVAL,MDX,MDX1,X,Y S (MDMF,MDCT)=0
 D GETLST^XPAR(.MDLST,"SYS","MD GET HIGH VOLUME")
 F MDKK=0:0 S MDKK=$O(MDLST(MDKK)) Q:MDKK<1  S MDX=$G(MDLST(MDKK)),MDLST1(+MDX)=MDKK_"^"_$P(MDX,"^",2),MDCT=MDCT+1
 S MDAR=$$GET^XPAR("SYS","MD NOT ADMN CLOSE MUSE NOTE",1)
A1 ; Ask for procedure parameter
 S (MDCP1,MDDEF)="",MDCP1="NO"
 W !!,"Procedure: " R X:DTIME G:'$T!("^"[X) KIL
 I X["?" D PHELP
 K DIC S DIC="^MDS(702.01,",DIC(0)="EQMZ",DIC("S")="I +$P(^(0),U,9)>0&(+$P(^(0),U,6)'=2)&(+$P(^(0),U,11)'=2)"
 D ^DIC K DIC G A1:"^"[X!$D(DTOUT),A1:Y<1
 S MDCP=+Y,MDNOD=""
 S MDMF=$$MUSE(MDCP)
 I $G(MDLST1(MDCP))'="" S MDDEF=+$P($G(MDLST1(MDCP)),"^",2),MDCP1=+$P($P($G(MDLST1(MDCP)),"^",2),";",2)
 I $G(MDLST1(MDCP))="" G A2
A11 ; Ask to delete an existing entry
 K DIR S DIR(0)="YA",DIR("A")="Delete current procedure setup? ",DIR("B")="NO",DIR("?")="Enter either 'Y' or 'N'."
 S DIR("?",1)="Enter Yes or No, if you want to delete the setup for the procedure."
 D ^DIR G:$D(DIRUT)!$D(DIROUT)!(Y<0) KIL K DIR
 I +Y D EN^XPAR("SYS","MD GET HIGH VOLUME",$P($G(^MDS(702.01,+MDCP,0)),"^",1),"@") D:+MDMF EN^XPAR("SYS","MD NOT ADMN CLOSE MUSE NOTE",1,0) W "...Procedure deleted" D  G A1
 .S MDNOD=+MDLST1(MDCP) K MDLST1(MDCP),MDLST(+MDNOD) Q
A2 ; Get Text
 K DIR S DIR(0)="YA",DIR("A")="Get Text? " S:MDDEF'="" DIR("B")=$S(+MDDEF:"Yes",1:"No") S DIR("?")="Enter either 'Y' or 'N'."
 S DIR("?",1)="Indicate whether the text from the result should or should not"
 S DIR("?",2)="be obtained."
 D ^DIR G:$D(DIRUT)!$D(DIROUT)!(Y<0) KIL K DIR
 S MDDEF=Y
 I '+MDDEF S MDVAL=MDDEF_";"_0 D:+MDMF EN^XPAR("SYS","MD NOT ADMN CLOSE MUSE NOTE",1,0) G SET
 I '+MDMF G A4
A3 ; Use Interpreter to close the note
 K DIR S DIR(0)="YA",DIR("A")="Use Interpreter to close note? " S:MDAR'="" DIR("B")=$S(+MDAR:"Yes",1:"No") S DIR("?")="Enter either 'Y' or 'N'."
 S DIR("?",1)="If 'YES', the interpreter of the result will be used to close"
 S DIR("?",2)="the note.  If 'NO', the Proxy service will be used."
 D ^DIR G:$D(DIRUT)!$D(DIROUT)!(Y<0) KIL K DIR
 D EN^XPAR("SYS","MD NOT ADMN CLOSE MUSE NOTE",1,Y)
 I +Y S MDVAL=MDDEF_";"_0 D EN^XPAR("SYS","MD GET HIGH VOLUME","`"_+MDCP,MDVAL) D  G A1
 .S MDNOD=$G(MDLST1(MDCP)) I MDNOD="" S MDCT=MDCT+1,MDLST1(MDCP)=MDCT_"^"_MDVAL,MDLST(MDCT)=MDCP_"^"_MDVAL Q
 .I MDNOD'="" S $P(MDNOD,"^",2)=MDVAL,MDLST1(MDCP)=MDNOD,$P(MDLST(+MDNOD),"^",2)=MDVAL Q
 .Q
A4 ; Use CP Method
 K DIR S DIR(0)="YA",DIR("A")="Do Not Auto Close Note? " S:MDCP1'="" DIR("B")=$S(+MDCP1:"Yes",1:"No") S DIR("?")="Enter either 'Y' or 'N'."
 S DIR("?",1)="If 'YES', the text of the result will be in the significant finding of the procedure."
 S DIR("?",2)="If 'NO', the default auto closure will be used."
 D ^DIR G:$D(DIRUT)!$D(DIROUT)!(Y<0) KIL K DIR
 S MDCP1=Y,MDVAL=MDDEF_";"_MDCP1
SET ; Set parameter
 D EN^XPAR("SYS","MD GET HIGH VOLUME","`"_+MDCP,MDVAL)
 S MDNOD=$G(MDLST1(MDCP)) I MDNOD="" S MDCT=MDCT+1,MDLST1(MDCP)=MDCT_"^"_MDVAL,MDLST(MDCT)=MDCP_"^"_MDVAL G A1
 I MDNOD'="" S $P(MDNOD,"^",2)=MDVAL,MDLST1(MDCP)=MDNOD,$P(MDLST(+MDNOD),"^",2)=MDVAL
 G A1
KIL ; kill DIR variables
 K DIC,DIR,DIROUT,DIRUT,DTOUT
 Q
MUSE(MDP) ; Check if procedure has Muse as a device
 N MDM,MDLL,MDINL S MDM=0
 Q:'$G(MDP)
 S MDLL=0 F  S MDLL=$O(^MDS(702.01,+MDP,.1,MDLL)) Q:MDLL<1  S MDINL=+$G(^(MDLL,0)) D  Q:+MDM
 .S:$$UP^XLFSTR($$GET1^DIQ(702.09,MDINL_",",".01","E"))["MUSE" MDM=1
 Q MDM
PHELP ; Procedure list
 N MDCH,MDACN,MDNAU
 S MDNAU=+$$GET^XPAR("SYS","MD USE NOTE",1)
 S MDACN=$$GET^XPAR("SYS","MD NOT ADMN CLOSE MUSE NOTE",1)
 W ! F MDKK=0:0 S MDKK=$O(MDLST(MDKK)) Q:MDKK<1  S MDX=$G(MDLST(MDKK)),MDX1=$P(MDX,"^",2) D
 .S MDCH=0 S:+$$MUSE(+MDX) MDCH=1
 .W !,$P($G(^MDS(702.01,+MDX,0)),"^"),?45,$S(+$P(MDX1,";"):"Text",1:"No Text")
 .W ?55,$S((+$P(MDX1,";",2)&'+MDNAU):"SF",(+MDCH&+MDACN):"Muse Interpreter",(+$P(MDX1,";",2)&+MDNAU):"Not Auto",1:"Auto")
 W !
 Q
