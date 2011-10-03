GMPLEDT1 ; SLC/MKB/KER/AJB -- Edit Problem List fields ; 04/21/2003
 ;;2.0;Problem List;**17,20,26,28,35**;Aug 25, 1994;Build 26
 ;
 ; External References
 ;   DBIA 10006  ^DIC
 ;   DBIA 10026  ^DIR
 ;   DBIA   341  DIS^SDROUT2
 ;                
ONSET ; Edit Date of Onset - field .13
 N X,Y,ENTERED,PROMPT,HELPMSG,DEFAULT
 S ENTERED=$S($G(GMPFLD(.08)):+GMPFLD(.08),1:DT),DEFAULT=$G(GMPFLD(.13))
 S PROMPT="DATE OF ONSET: ",HELPMSG="Enter the date this problem was first observed, as precisely as known."
O1 ;   Get Date of Onset
 D DATE^GMPLEDT2 Q:$D(GMPQUIT)!($G(GMPLJUMP))
 I Y>ENTERED W !!,"Date of Onset cannot be later than the date the problem was entered!",$C(7) G O1
 I +$P(GMPDFN,U,4),Y>$P(GMPDFN,U,4) W !!,"Date of Onset cannot be later than the date of death!",$C(7) G O1
 S GMPFLD(.13)=Y S:Y'="" GMPFLD(.13)=GMPFLD(.13)_U_$$EXTDT^GMPLX(Y)
 Q
STATUS ; Edit Status - field .12
 ;   Then Edit Date Resolved - Field 1.07, if inactive
 N DIR,X,Y
 S DIR(0)="9000011,.12"
 S:$L($G(GMPFLD(.12))) DIR("B")=$P(GMPFLD(.12),U,2)
ST1 ;   Get Status
 D ^DIR I $D(DTOUT)!(Y="^") S GMPQUIT=1 Q
 I Y?1"^".E D JUMP^GMPLEDT3(Y) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G ST1
 S:Y'="" Y=Y_U_$S(Y="A":"ACTIVE",1:"INACTIVE") S GMPFLD(.12)=Y
 S:$E(Y)'="I" GMPFLD(1.07)="" S:$E(Y)'="A" GMPFLD(1.14)=""
 D:$E(GMPFLD(.12))="I" RESOLVED^GMPLEDT4
 D:$E(GMPFLD(.12))="A" PRIORITY^GMPLEDT4
 Q
RECORDED ; Edit Date Recorded - field 1.09
 N X,Y,PROMPT,HELPMSG,DEFAULT,ENTERED
 S ENTERED=$S($G(GMPFLD(.08)):+GMPFLD(.08),1:DT),DEFAULT=$G(GMPFLD(1.09))
 S PROMPT="DATE RECORDED: ",HELPMSG="Enter the date this problem was first recorded, as precisely as known."
RC1 ;   Get Date
 D DATE^GMPLEDT2 Q:$D(GMPQUIT)!($G(GMPLJUMP))
 I Y>ENTERED W !!,"Date Recorded cannot be later than the problem was entered!",$C(7) G RC1
 S GMPFLD(1.09)=Y S:Y'="" GMPFLD(1.09)=GMPFLD(1.09)_U_$$EXTDT^GMPLX(Y)
 Q
SC ; Edit Service Connected - field 1.1
 N DFN,DIR,X,Y
 ;
 ;   The following allows changing a problem's SC/NSC to
 ;   NSC if there is no SC on file for patient and Problem 
 ;   original SC was set to "YES"
 ;
 I +$G(GMPORIG(1.1))=1 D
 . W !!,">>>  Currently known service-connection data for "_$P(GMPDFN,U,2)_":"
 ELSE  Q:'GMPSC
 S DFN=+GMPDFN D DIS^SDROUT2
 I +GMPSC=0,+$G(GMPORIG(1.1))=1 D
 . S DIR("A")="Patient has no service-connected condition !! "
 . S DIR("B")="NO"
 ELSE  D
 . S DIR("A")="Is this problem related to a service-connected condition? "
 . S:$L($G(GMPFLD(1.1))) DIR("B")=$P(GMPFLD(1.1),U,2) W !
 S DIR("?",1)="If this problem is due to a service-connected condition, enter YES;",DIR("?")="press <return> and leave blank if this is unknown.",DIR(0)="YAO"
SC1 ;   Get Service Connection
 D ^DIR I $D(DTOUT)!(Y="^") S GMPQUIT=1 Q
 I Y?1"^".E D JUMP^GMPLEDT3(Y) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G SC1
 I X="@" G:'$$SURE^GMPLX SC1 S Y=""
 S GMPFLD(1.1)=Y S:Y'="" GMPFLD(1.1)=GMPFLD(1.1)_U_$S(Y:"YES",1:"NO")
 Q
SP ; Edit Exposures/Conditions
 ;   Agent Orange - field 1.11
 ;   Ionizing Radiation - field 1.12
 ;   Persian Gulf/Environmental Contaminants - field 1.13
 ;   Head and/or Neck Cancer - field 1.15
 ;   Military Sexual Trauma - field 1.16
 ;   Combat Vet - field 1.17
 ;   SHAD - field 1.18
 G SPEXP^GMPLEDT2
 Q
SOURCE ; Edit Service - field 1.06
 ; or Clinic - field 1.08
 N DIC,X,Y,HELPMSG,PROMPT,DEFAULT,VIEW S VIEW=$E(GMPLVIEW("VIEW"))
 S DIC=$S(VIEW="S":"^DIC(49,",1:"^SC("),DIC(0)="EMQ"
 S DIC("S")="I $P(^(0),U,"_$S(VIEW="S":9,1:3)_")=""C"""
 I VIEW="S" S PROMPT="SERVICE: ",DEFAULT=$P(GMPFLD(1.06),U,2)
 E  S PROMPT="CLINIC: ",DEFAULT=$P(GMPFLD(1.08),U,2)
 S HELPMSG="Enter the clinic"_$S(VIEW="S":"al service",1:"")_" to be associated with this problem."
S1 ;   Get Service/Clinic
 W !,PROMPT_$S($L(DEFAULT):DEFAULT_"//",1:"")
 R X:DTIME S:'$T X="^",DTOUT=1 S:X="^" GMPQUIT=1 Q:(X="^")!(X="")
 I X?1"^".E D JUMP^GMPLEDT3(X) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G S1
 I X="?" W !!,HELPMSG,! G S1
 I X["??" D @("LIST"_$S(VIEW="S":"SERV",1:"CLIN")_"^GMPLMGR1") W !,HELPMSG G S1
 I X="@" G:'$$SURE^GMPLX S1 S Y="" G SQ
 D ^DIC I Y'>0 W !?5,"Only clinic"_$S(VIEW="S":"al service",1:"")_"s are allowed!",! G S1
SQ ;   Quit Service/Clinic
 S:VIEW'="S" GMPFLD(1.08)=Y S:VIEW="S" GMPFLD(1.06)=Y
 Q
AUTHOR ; Edit Recording Provider - field 1.04
 N X,Y,PROMPT,HELPMSG,DEFAULT S PROMPT="RECORDING PROVIDER: "
 S DEFAULT=$G(GMPFLD(1.04)),HELPMSG="Enter the name of the provider responsible for the recording of this data."
 D NPERSON^GMPLEDT2 Q:$D(GMPQUIT)!($G(GMPLJUMP))
 S GMPFLD(1.04)=$S(+Y>0:Y,1:"")
 Q
PROV ; Edit Responsible Provider - field 1.05
 N X,Y,PROMPT,DEFAULT,HELPMSG S DEFAULT=$G(GMPFLD(1.05))
 S PROMPT="PROVIDER: ",HELPMSG="Enter the name of the local provider treating this problem."
 D NPERSON^GMPLEDT2 Q:$D(GMPQUIT)!($G(GMPLJUMP))
 S GMPFLD(1.05)=$S(+Y>0:Y,1:"")
 Q
ICD ; Edit ICD-9-CM Code - field .01
 N DIC,DIR,X,Y
ICD0 ;   Prompt for ICD Code
 K DIR S DIR(0)="FAO^2:6",DIR("A")="ICD CODE: "
 S:$P($G(GMPFLD(.01)),U,2)="799.9" DIR("A")=IORVON_"ICD CODE: "
 S:+$G(GMPFLD(.01)) DIR("B")=$P(GMPFLD(.01),U,2)
 S DIR("?")="Enter the ICD code to be associated with this problem"
ICD1 ;   Get ICD Code
 D ^DIR W IORVOFF I $D(DTOUT)!(Y="^") S GMPQUIT=1 Q
 I Y?1"^".E D JUMP^GMPLEDT3(Y) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G ICD1
 I X="@" W !!,"ICD Code may not be deleted!",!,$C(7) G ICD1
 Q:X=""  Q:$P($G(GMPFLD(.01)),U,2)=Y
 S DIC=80,DIC(0)="EQM" D ^DIC G:Y'>0 ICD0
 S GMPFLD(.01)=Y
 Q
NOTE ; Attach a note to problem - field 11
 N X,Y,I,DEFAULT,PROMPT,DONE,NXT,NCNT S (I,NCNT,DONE)=0
 ; added for Code Set Versioning (CSV)
 I $G(GMPICD),'+$$STATCHK^ICDAPIU(GMPICD,DT) D  Q
 . W !!,"This problem has an inactive ICD code. Please edit the problem before using.",! H 3
 I $G(GMPIFN),'$$CODESTS^GMPLX(GMPIFN,DT) D  Q
 . W !!,"This problem has an inactive ICD code. Please edit the problem before using.",! H 3
 F  D  Q:$D(GMPQUIT)!($G(GMPLJUMP))!DONE
 . S NXT=$O(GMPFLD(10,"NEW",I)) S:'NXT NXT=I+1
 . S I=NXT,NCNT=NCNT+1
 . S PROMPT=$S(NCNT=1:"",1:"ANOTHER ")_"COMMENT"_$S(NCNT=1:" (<60 char): ",1:": "),DEFAULT=$G(GMPFLD(10,"NEW",I))
 . D EDNOTE^GMPLEDT4 Q:$D(GMPQUIT)!($G(GMPLJUMP))
 . I X="@" K GMPFLD(10,"NEW",I) Q
 . I Y="" S DONE=1 Q
 . S GMPFLD(10,"NEW",I)=Y
 Q
TERM ; Edit Problem - field 1.01
 G TERM^GMPLEDT4
 Q
Q ; No Editing
 Q
