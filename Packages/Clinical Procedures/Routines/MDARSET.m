MDARSET ; HOIFO/NCA,WOIFO/KLM - High Volume Check-In Setup ;31 Oct 2018 10:02 AM
 ;;1.0;CLINICAL PROCEDURES;**21,65,73**;Apr 01, 2004;Build 2
 ; Reference IA # 2263 [Supported] XPAR parameter calls
 ;               10104 [Supported] XLFSTR call
 ;                6924 [Private  ] ^TIU(8925.1
 ;
EN1 ; Entry Point for the setup option
 N MDAPT,MDAR,MDCP,MDCP1,MDCT,MDDEF,MDERR,MDKK,MDLST,MDLST1,MDMF,MDNOD,MDVAL,MDX,MDX1,X,Y S (MDMF,MDCT)=0
 D GETLST^XPAR(.MDLST,"SYS","MD GET HIGH VOLUME")
 F MDKK=0:0 S MDKK=$O(MDLST(MDKK)) Q:MDKK<1  S MDX=$G(MDLST(MDKK)),MDLST1(+MDX)=MDKK_"^"_$P(MDX,"^",2),MDCT=MDCT+1
 S MDAR=$$GET^XPAR("SYS","MD NOT ADMN CLOSE MUSE NOTE",1)
A1 ; Ask for procedure parameter
 N MDTIU
 S (MDCP1,MDDEF)="",MDCP1="NO"
 W !!,"Procedure: " R X:DTIME G:'$T!("^"[X) KIL
 I X["?" D PHELP
 K DIC S DIC="^MDS(702.01,",DIC(0)="EQMZ",DIC("S")="I +$P(^(0),U,9)>0&(+$P(^(0),U,6)'=2)&(+$P(^(0),U,11)'=2)"
 D ^DIC K DIC G A1:"^"[X!$D(DTOUT),A1:Y<1
 S MDCP=+Y,MDNOD="" D CHKTL I MDTIU']"" G A1 ;KLM/p65 -note title information. /p73 If no title, can't proceed
 S MDMF=$$MUSE(MDCP)
 I $G(MDLST1(MDCP))'="" S MDDEF=+$P($G(MDLST1(MDCP)),"^",2),MDCP1=+$P($P($G(MDLST1(MDCP)),"^",2),";",2)
 I $G(MDLST1(MDCP))="" G A2
A11 ; Ask to delete an existing entry
 K DIR S DIR(0)="YA",DIR("A")="Delete current procedure setup? ",DIR("B")="NO",DIR("?")="Enter either 'Y' or 'N'."
 S DIR("?",1)="Enter Yes or No, if you want to delete the setup for the procedure."
 D ^DIR G:$D(DIRUT)!$D(DIROUT)!(Y<0) KIL K DIR
 I +Y D EN^XPAR("SYS","MD GET HIGH VOLUME",$P($G(^MDS(702.01,+MDCP,0)),"^",1),"@") D:+MDMF EN^XPAR("SYS","MD NOT ADMN CLOSE MUSE NOTE",1,0) W "...Procedure deleted" D  S MDR=1 G TIU
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
 I +Y S MDVAL=MDDEF_";"_0 D EN^XPAR("SYS","MD GET HIGH VOLUME","`"_+MDCP,MDVAL) D  G TIU ;P73
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
 S MDNOD=$G(MDLST1(MDCP)) I MDNOD="" S MDCT=MDCT+1,MDLST1(MDCP)=MDCT_"^"_MDVAL,MDLST(MDCT)=MDCP_"^"_MDVAL
 I MDNOD'="" S $P(MDNOD,"^",2)=MDVAL,MDLST1(MDCP)=MDNOD,$P(MDLST(+MDNOD),"^",2)=MDVAL
 I $G(MDCP1)=1 G A1 ;p73 -If SIG FINDINGS do not set tech fields
TIU ;KLM/P65 -Set tech fields COMMIT ACTION and POST-SIGNATURE CODE for note title
 N MDIENS,MDTS
 I MDTIU']"" W !,"Note title not found!" G A1
 S MDIENS=MDTIU_","
 I $D(MDR)=0 G TIU1 ;p73 - Skip asking for SET action.
 W !,"Do you want to "_$S($D(MDR):"delete",1:"set")_" the technical fields for the "_MD01_" title?"
 K Y,DIR S DIR(0)="Y",DIR("B")="Yes",DIR("?")="Enter 'Yes' to update the technical fields or 'No' to bypass this step"
 S DIR("??")="^D TLH2^MDARSET" D ^DIR
 I +Y=0 G A1
TIU1 ;Check title's status (#.07), it must be inactive to continue
 S MDTS=$$GET1^DIQ(8925.1,MDTIU,.07)
 I MDTS'="INACTIVE" D  K MDR,MD41,MD49 G A1 ;p73
 .W:$D(MDR)=1 !!,"Cannot update technical fields - Please INACTIVATE the note title first"
 .I $D(MDR)=0 D
 ..I (MD41="")&(MD49="") D
 ...W !!,"Cannot update technical fields - Please INACTIVATE the note title first"
 ...W !!,"** Deleting procedure from High Volume Setup **"
 ...D EN^XPAR("SYS","MD GET HIGH VOLUME",$P($G(^MDS(702.01,+MDCP,0)),"^",1),"@") D:+MDMF EN^XPAR("SYS","MD NOT ADMN CLOSE MUSE NOTE",1,0)
 ...S MDNOD=+MDLST1(MDCP) K MDLST1(MDCP),MDLST(+MDNOD)
 ...Q
 ..E  W !!,"Technical fields already set to 'QUIT', Procedure setup OK"
 ..Q
 .Q
 ;MDR set if procedure's HV setup is deleted...
 S MDFDA(8925.1,MDIENS,4.1)=$S($D(MDR):"",1:"Q") ;COMMIT ACTION
 S MDFDA(8925.1,MDIENS,4.9)=$S($D(MDR):"",1:"Q") ;POST-SIGNATURE CODE
 L +^TIU(8925.1,MDTIU):1 I '$T W !,"Record is locked." G XIT
 D FILE^DIE("E","MDFDA","MDERR")
 I $D(MDERR) D  G XIT
 .W !,"Update failed due to the following reason: "
 .S MDI="" F  S MDI=$O(MDERR("DIERR",1,"TEXT",MDI)) Q:MDI=""  W !,?5,$G(MDERR("DIERR",1,"TEXT",MDI))
 .Q
 L -^TIU(8925.1,MDTIU)
 W !!,"Update successful!  Don't forget to REACTIVATE the title."
 K MDFDA,MDR,MD01,MDERR,Y,DIR,MD41,MD49
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
CHKTL ;KLM/P65 -Display the associated note title information
 Q:'MDCP
 N MDIENS S MDTIU=$$GET1^DIQ(702.01,MDCP,.04,"I") I MDTIU']"" W !,"Note title not found!" Q
 S MDIENS=MDTIU_"," D GETS^DIQ(8925.1,MDIENS,".01;.07;4.1;4.9","","MDROOT")
 S MD01=$G(MDROOT(8925.1,MDIENS,.01)) ;TITLE
 S MD41=$G(MDROOT(8925.1,MDIENS,4.1)) ;COMMIT ACTION
 S MD49=$G(MDROOT(8925.1,MDIENS,4.9)) ;POST-SIGNATURE CODE
 S MD07=$G(MDROOT(8925.1,MDIENS,.07)) ;STATUS
 W !!,?5,"This procedure has note title "_MD01_" associated with it."
 W !!,?5,"The current setup is as follows:"
 W !,?10,"STATUS:",?32,MD07
 W !,?10,"COMMIT ACTION:",?32,$S(MD41]"":MD41,1:"<NULL>")
 W !,?10,"POST-SIGNATURE CODE:",?32,$S(MD49]"":MD41,1:"<NULL>")
 W !!,?5,"When a procedure is setup for High Volume, the COMMIT ACTION and"
 W !,?5,"POST-SIGNATURE CODE fields must contain a 'Q'. If you need to update"
 W !,?5,"these fields, the title ("_MD01_") must be inactivated first.",!!
 K MDROOT,MD07
 Q
TLH2 ;Help for ?? on update title prompt
 W !!,"Select 'Yes' to "_$S($D(MDR):"delete",1:"set")_" the COMMIT ACTION and POST-SIGNATURE CODE"
 W !,"technical fields of the associated note title. Note that if you"
 W !,"are deleting a procedure from the High Volume setup, but the note"
 W !,"title is shared with other procedures still configured for High"
 W !,"Volume, then you should not delete these fields, but instead"
 W !,"create a new title to be used separately (unless the procedure"
 W !,"is being decommissioned)."
 Q
XIT ;clean up and go
 K MDFDA,MDIENS,MDR,MD01,MDTS,MDERR,MDI,MDTIU,Y,DIR
 Q
