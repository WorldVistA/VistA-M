IBDFN4 ;ALB/CJM - ENCOUNTER FORM - (entry points for selection routines) ;5/21/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38,51,64,63**;APR 24, 1997;Build 80
 ;
 ;
CPT ;select ambulatory procedures
 N NAME,CODE,SCREEN,IBDESCR,IBDESCLG,QUIT
 S QUIT=0
 S SCREEN="I $P($$CPT^ICPTCOD(Y),U,7)=1" ;List only active codes
 K DIC S DIC=81,DIC(0)="AEMQZ",DIC("S")=SCREEN
 I $D(^ICPT) D ^DIC K DIC I +Y>0 D
 .;;change to api cpt;dhh
 .S CODE=$P(Y(0),U)
 .S CODE=$$CPT^ICPTCOD(CODE)
 .I +CODE=-1 K @IBARY Q
 .S NAME=$P(CODE,"^",3)
 .S IBDESCLG=$$CPTD^ICPTCOD(+CODE,.IBCPTD)
 .S IBDESCR=$G(IBCPTD(1))_" "_$G(IBCPTD(2))
 .S @IBARY=$P(CODE,"^",2)_"^"_NAME_"^"_IBDESCR
 E  K @IBARY ;kill either if file doesn't exist or nothing chosen
 Q
CPTSCRN ;This code is probably not called, but will modify to be safe.
 S SCREEN="I $P($$CPT^ICPTCOD(Y),U,7)=1"
 ;
 ;don't ask the user about categories - it doesn't work well 
 S @IBARY@("SCREEN")=SCREEN
 Q
 ;
ICD9 ;select ICD-9 codes
 N IBDX,CODE,SCREEN,IBDESCR,QUIT
 S QUIT=0
 S SCREEN="I $P($$ICDDX^ICDCODE(Y),U,10)=1" ;List only active codes
 I $G(DIC("A"))="" S DIC("A")="SELECT ICD-9 DIAGNOSIS CODE NUMBER: "
 S DIC=80,DIC(0)="AEMQZI",DIC("S")=SCREEN
 D ^DIC K DIC I +Y>0 D
 .S CODE=$P(Y(0),U),IBDX=$$GETIDX("ICD9",CODE,DT),IBDESCR=$$GETDSCR("ICD9",CODE,DT) ;(#10) DESCRIPTION in the old ICD9 DD
 .S IBDX=$P(IBDX,U,2)
 .S @IBARY=CODE_"^"_IBDX_"^"_IBDESCR
 E  K @IBARY ;kill if either file doesn't exist or nothing chosen - this is how to let the encounter form utilities know nothing was selected
 Q
ICD9SCRN ;This code is probably not called, but will modify to be safe.
 S SCREEN="I $P($$ICDDX^ICDCODE(Y),U,10)=1"
 ;
 S @IBARY@("SCREEN")=SCREEN
 Q
NULL ;returns NOTHING for selection
 S @IBARY=""
 Q
 ;
VSIT ; -- Select only visit cpt codes
 N NAME,CODE,IBDESCR,QUIT,DIC,X,Y,IBHDR,IBTXT
 S QUIT=0
 ;
 ;;S DIC="^IBE(357.69,",DIC(0)="AEMQZ",DIC("S")="I '$P(^(0),U,4)"
 S DIC="^IBE(357.69,",DIC(0)="AEMQZ"
 S DIC("S")="I $P($$CPT^ICPTCOD(Y),U,7)=1" ;List only active codes
 D ^DIC K DIC I +Y>0 D
 .;;----change to api cpt;dhh
 .S CODE=$P(Y(0),U),IBHDR=$P(Y(0),U,2),IBTXT=$P(Y(0),U,3)
 .S NODE=$$CPT^ICPTCOD(CODE)
 .I +NODE=-1 S IBSNM="" Q
 .S IBSNM=$P(NODE,U,3)
 .S @IBARY=CODE_"^"_IBTXT_"^"_IBHDR_"^"_IBSNM
 E  K @IBARY ;kill if nothing chosen
 Q
 ;
PRVDR ;for selecting provider
 D GETPRO^IBDF18B(IBCLINIC,IBARY)
 Q
 ;
IBPFID ;for printing the form # assigned by form tracking
 S @IBARY=$G(IBPFID)
 Q
 ;
PCPR ; -- get primary care provider for a patient
 S @IBARY=$P($$OUTPTPR^SDUTL3(DFN,DT),"^",2)
 Q
 ;
PCTM ; -- get primary care team for a patient
 S @IBARY=$P($$OUTPTTM^SDUTL3(DFN,DT),"^",2)
 Q
 ;
SCCOND ; -- display sc conditions
 Q:'$G(DFN)
 D DIS^DGRPDB
 W !
 Q
 ;
 ;
CPTMOD ;- Select active CPT Modifiers
 ;- (used in selecting CPT Modifier(s) when creating the CPT Modifier
 ;   Display ToolKit Block)
 ;
 N CODE,DIC,NAME,SCREEN
 Q:$G(IBARY)=""
 ;
 ;- Screen out inactive CPT modifiers
 ;;S SCREEN="I '$P(^(0),U,5)"
 ;;I '$D(@IBARY@("SCREEN")) S @IBARY@("SCREEN")=SCREEN
 ;
 ;List only active modifiers
 S SCREEN="I $P($$MOD^ICPTMOD(Y,""I""),U,7)=1"
 S DIC=81.3
 S DIC(0)="AEMQZ"
 S DIC("S")=SCREEN
 D ^DIC
 I +Y>0 D
 . ;- Use first 35 chars of modifier description
 . S CODE=$P(Y(0),"^"),NAME=$E($P(Y(0),"^",2),1,35)
 . S @IBARY=CODE_"^"_NAME
 ;
 ;- Kill if file doesn't exist or nothing chosen
 E  K @IBARY
 Q
 ;------new code------
 ; IBDSERCH 1=Wildcard Search, 2=Lexicon Search
ICD10 ; Wildcard search for ICD-10 codes.
 N DIR,%,IBDANS,IBDAUTO,IBDNEXT,IBDOUT,IBDTEXT,IBDWORD,IBDX,IBDY
 ; IBDSERCH 1=Wildcard ICD code search, 2=Lexicon ICD code search
 I '$D(IBDSERCH) S IBDSERCH=1 ;Set Wildcard ICD code search as default search.
 I IBDSERCH=2 D LXSEARCH Q  ;Do Lexicon Partial Code ICD search.
 ;Wildcard ICD code search.
 K ^TMP("IBDFN4_ASSOCIATE_WCSEARCH",$J),^TMP("IBDFN4_ASSOCIATE",$J)
 I $G(DIC("A"))="" K ^TMP("IBDFN4_WCSEARCH",$J)
 ;I $G(DIC("A"))'="" W !
 S IBDAUTO=0
 S DIR("A")=$S($G(DIC("A"))'="":$TR(DIC("A"),":",""),1:"SELECT ICD-10 DIAGNOSIS CODE NUMBER")
 S DIR(0)="FO^3:8"
 S DIR("?")="Enter 3 to 8 characters or '??' for more help"
 S DIR("??")="^D HELP^IBDFN4A"
 D ^DIR K DIR
 I Y="^"!(Y="")!($D(DTOUT)) K @IBARY Q
 ;Do wildcard search.
 S IBDANS=$P(Y,U)
 I $G(DIC("A"))="" S IBDY=$$CODELIST^IBDUTICD("10D",IBDANS,"IBDFN4_WCSEARCH",DT,"",1)
 I $G(DIC("A"))'="" S IBDY=$$CODELIST^IBDUTICD("10D",IBDANS,"IBDFN4_ASSOCIATE_WCSEARCH",DT,"",1)
 I +IBDY<1 D 
 .S IBDWORD=$P($P(IBDY,U,2)," ")
 .S IBDWORD=$TR($E(IBDWORD,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(IBDWORD,2,99) ;Capitalize first character of text message.
 .S $P(IBDY,U,2)=IBDWORD_" "_$P(IBDY," ",2,99)
 .W !!,$P(IBDY,U,2)_"."
 I +IBDY<1 G ICD10
 I $P(IBDY,U,2)=0 D  G ICD10
 .W !!,"No data found for selected search, please enter partial code'*' for"
 .W !,"additional selections e.g. E11* .",!
 ;Do wildcard selection for SECOND and THIRD associated ICD-10 codes.
 S IBDOUT=0
 I $G(DIC("A"))'="" K Y D ASSOCIAT(.Y,.IBDOUT) G:Y=0!(IBDOUT) ICD10 Q
 I +IBDY'<1 D  ;
 .S %=1
 .I $P(IBDY,U,2)>1 D
 ..W !!,"There are "_$P(IBDY,U,2)_" ICD-10-CM diagnosis codes that begin with "_IBDANS_". Do you wish to"
 ..W !,"automatically add all of these diagnosis codes to this block"
 ..S %=2 D YN^DICN
 .I %=1 S IBDAUTO=1
 .I ($G(DTOUT)) Q
 .I %=-1!(%=2) W !!,"Continue to select from the (# of items in list) ICD-10 diagnoses" S %=2 D YN^DICN I $G(DTOUT)!(%=-1)!(%=2) Q
 .D WCSEARCH(IBDAUTO)  ;Wildcard Search
 I '$D(^TMP("IBDFN4_DISPLAY",$J)) K ^TMP("IBDFN4_SELECTED",$J),@IBARY G ICD10
 D DISPLAY
 K @IBARY,^TMP("IBDFN4_SELECTED",$J),^TMP("IBDFN4_DISPLAY",$J),^TMP("IBDFN4_WCSEARCH",$J),^TMP("IBDFN4_ASSOCIATE",$J)
 K ^TMP("IBDFN4_ASSOCIATE_WCSEARCH",$J)
 I +IBDY W !,"Now for another!"
 G ICD10
 Q
 ;
 ;Loop through ^TMP global created by wildcard search.
WCSEARCH(IBDAUTO) ;
 ;
 N IBDBEGN,IBDCNT,IBDCODE,IBDCONTU,IBDESCR,IBDNOE,IBDNDEX,IBDNO,IBDQUIT,IBDSEL,IBDX
 I 'IBDAUTO W !
 S (IBDNDEX,IBDCNT,IBDQUIT,IBDBEGN)=0
 S IBDCONTU=1
 F  S IBDNDEX=$O(^TMP("IBDFN4_WCSEARCH",$J,IBDNDEX)) Q:IBDNDEX=""!(IBDQUIT)!('IBDCONTU)  D  ;
 .S IBDNOE=^TMP("IBDFN4_WCSEARCH",$J,0)  ;Number of entries in wildcard search.
 .S IBDCODE=^TMP("IBDFN4_WCSEARCH",$J,IBDNDEX,1)
 .S IBDCODE=$P(IBDCODE,U,2)
 .S IBDX=$P($$GETIDX("10D",IBDCODE,DT),U,2)
 .S IBDESCR=$P(^TMP("IBDFN4_WCSEARCH",$J,IBDNDEX,2),U,2)
 .S IBDCNT=IBDCNT+1
 .I IBDCNT=1 S IBDBEGN=1 I IBDNOE>5,'IBDAUTO W @IOF
 .I IBDAUTO D  Q  ;User chose to automatically add ICD-10 codes or user only chose 1 ICD code so SELECT tag is by-passed.
 ..I IBDCNT>1 W !!,"Automatic selection continued:",!
 ..;Display automatic selected wildcard search ICD code to user one at a time.
 ..S IBDNO=0
 ..D OKPROMPT($S(IBDNOE=1:1,1:""),IBDCODE,IBDX,.IBDQUIT,.IBDNO)
 ..I IBDNO!(IBDQUIT) Q
 ..S @IBARY=IBDCODE_U_IBDX_U_IBDESCR
 ..N IBDSLIEN
 ..;Add the Group and bring back the IEN Selection from ^IBE(357.3.
 ..D ADDGROUP(.IBDQUIT,.IBDSLIEN,IBDCODE)
 ..I IBDQUIT D:$D(IBDSLIEN) KILL3573(IBDSLIEN) S IBDQUIT=0 Q
 ..D SETMSG(IBDSLIEN,IBDCODE,IBDX,IBDCNT)
 .;User chose to select which ICD-10 codes he/she wants to add to form.
 .;Set ^TMP global for ICD selections.
 .S ^TMP("IBDFN4_SELECTED",$J,IBDCNT)=IBDCODE_U_IBDX_U_IBDESCR
 .W !,IBDCNT_".",?4,IBDCODE,?15,IBDX  ;Display wildcard selected ICD codes
 .I IBDCNT#22=0 D  Q  ;Display every 22 ICD codes to user.
 ..D SELECT(IBDBEGN,IBDCNT,.IBDQUIT,.IBDNDEX,.IBDSEL,.IBDCONTU)
 ..S IBDBEGN=IBDCNT+1
 ..;I IBDSEL="",$O(^TMP("IBDFN4_WCSEARCH",$J,IBDNDEX))'="",'IBDQUIT,IBDCONTU W @IOF
 I IBDAUTO!(IBDQUIT)!('IBDCONTU) Q
 ;Less than 22 ICD codes displayed.
 D SELECT(IBDBEGN,IBDCNT,.IBDQUIT,"",.IBDSEL,.IBDCONTU)
 Q
 ;Allow user to select a range of ICD codes.
SELECT(IBDBEGN,IBDCNT,IBDQUIT,IBDNDEX,IBDSEL,IBDCONTU) ;
 N IBDCODE,IBDESCR,IBDI,IBDNEXT,IBDNO,IBDNODE,IBDSELN,IBDSKIP,IBDTEXT,IBDTEMP,IBDTEMPY,IBDX
 S IBDSKIP=0
 S IBDSEL=$G(IBDSEL)
 I IBDNDEX'="" S IBDNEXT=$O(^TMP("IBDFN4_WCSEARCH",$J,IBDNDEX))
 K Y
 S DIR("A")="Select ICD-10 DIAGNOSIS CODE or '?' for more help"
 S DIR("?")=$S(IBDCNT#22=0:"press Enter for more or '^' to exit.",1:"press Enter to continue or '^' to exit.")
 S DIR("?",1)="Enter a single number from the list or range (e.g., 1,3,5 or 2-4,8) or"
 S DIR(0)="LO^"_IBDBEGN_":"_IBDCNT D ^DIR K DIR
 I $D(DTOUT) S IBDQUIT=1 Q
 I Y="",$G(IBDNEXT) W @IOF Q
 I $D(DUOUT) S IBDSKIP=1  ;Allows user to terminate with '^' out of selection list.
 S IBDTEMPY=Y
 I '$D(DUOUT),Y'="" S IBDTEMP=Y
 K Y
 I $G(IBDNEXT),'IBDSKIP D
 .S DIR("A")="Save selections and continue to (# of remaining items) in list"
 .S DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR
 .I Y W @IOF
 .I Y=0 S IBDTEMP=""
 S Y=$G(Y)
 I $D(DTOUT) S IBDQUIT=1 Q
 I $D(DUOUT)!(Y=0) D
 .I IBDSEL="" S IBDCONTU=0
 Q:'IBDCONTU
 I IBDTEMPY="^",IBDSEL="" S IBDCONTU=0 Q
 I '$D(DUOUT),$G(IBDTEMP)'="" S IBDSEL=$G(IBDSEL)_IBDTEMP I $G(IBDNEXT) Q
 I IBDSEL="" Q
 S IBDTEXT=$S($L(IBDSEL,",")=2:"this diagnosis",1:"these diagnoses")
 W !,"Do you really want to select "_IBDTEXT
 S %=2 D YN^DICN
 I $G(DTOUT)!(%=2)!(%=-1) S IBDQUIT=1 K ^TMP("IBDFN4_DISPLAY",$J) Q
 W !
 F IBDI=1:1 Q:$P(IBDSEL,",",IBDI)=""  D  Q:IBDQUIT
 .I IBDI>1 W !!,"Selected list continued:",!
 .S IBDSELN=$P(IBDSEL,",",IBDI)
 .S IBDNODE=^TMP("IBDFN4_SELECTED",$J,IBDSELN)
 .S IBDCODE=$P(IBDNODE,U)
 .S IBDX=$P(IBDNODE,U,2)
 .S IBDESCR=$P(IBDNODE,U,3)
 .;W !,?4,IBDCODE,?15,IBDX
 .S IBDNO=0
 .D OKPROMPT("",IBDCODE,IBDX,.IBDQUIT,.IBDNO)
 .I IBDQUIT!(IBDNO) Q
 .S @IBARY=IBDCODE_"^"_IBDX_"^"_IBDESCR
 .N IBDSLIEN
 .;Adds the Group, files the entry and brings back the IEN Selection from ^IBE(357.3.
 .D ADDGROUP(.IBDQUIT,.IBDSLIEN,IBDCODE)
 .I IBDQUIT D:$D(IBDSLIEN) KILL3573(IBDSLIEN) S IBDQUIT=0 Q
 .D SETMSG(IBDSLIEN,IBDCODE,IBDX,IBDSELN)
 S IBDCONTU=0
 Q
 ;
 ;IBDEXTCD - the external code that we are adding to the group (optional)
ADDGROUP(IBDQUIT,IBDSLIEN,IBDEXTCD) ;
 N DIC
 W !
 I '$D(@IBRTN("DATA_LOCATION")) W !,"Data location not established. Unable to file data." S IBDQUIT=1 Q
 I $G(IBGRP)'>0 D  Q
 .S DIC="^IBE(357.4,",DIC(0)="AEMN",DIC("S")="I $P(^IBE(357.4,+Y,0),""^"",3)=IBLIST" D ^DIC K DIC S:X="^"!($D(DTOUT)) IBDQUIT=1 Q:IBDQUIT  S IBGRP=+Y I Y<0 D  Q:IBDQUIT=1
 ..W !!,"A SELECTION GROUP HEADER IS REQUIRED.... The selection will not be added if none is provided....Enter '??' for a list of choices.",!!
 ..S DIC="^IBE(357.4,",DIC(0)="AEMN",DIC("S")="I $P(^IBE(357.4,+Y,0),""^"",3)=IBLIST" D ^DIC K DIC S IBGRP=+Y I Y<0!($D(DTOUT)) S IBDQUIT=1 Q
 .D ADDREC^IBDF4(.IBDQUIT,"",.IBDSLIEN,$G(IBDEXTCD))
 .S IBGRP=""
 ;Adds Second and Third Associated ICD-10 codes,
 ;editing of subcolumn 3, Narrative to PCE, Clinical Lexicon Entry,
 ;files the entry and brings back the IEN Selection from ^IBE(357.3.
 D ADDREC^IBDF4(.IBDQUIT,"",.IBDSLIEN,$G(IBDEXTCD))
 Q
 ;Get the second and third associated codes.
ASSOCIAT(Y,IBDOUT) ;
 N IBDCNT,IBDCODE,IBDESCR,IBDIEN,IBDNEXT,IBDNDEX,IBDNO,IBDNODE,IBDNOE,IBDQUIT,IBDX
 S (IBDAUTO,IBDCNT,IBDQUIT)=0
 S Y=""
 S (IBDNDEX,IBDNO)=0
 F  S IBDNDEX=$O(^TMP("IBDFN4_ASSOCIATE_WCSEARCH",$J,IBDNDEX)) Q:IBDNDEX=""!(IBDQUIT)!(IBDNO)  D
 .S IBDNEXT=$O(^TMP("IBDFN4_ASSOCIATE_WCSEARCH",$J,IBDNDEX))
 .S IBDCNT=IBDCNT+1
 .I IBDCNT=1 D
 ..S IBDBEGN=1
 ..S IBDNOE=^TMP("IBDFN4_ASSOCIATE_WCSEARCH",$J,0)  ;Number of entries in wildcard search.
 ..I IBDNOE>5 W @IOF
 .I IBDCNT=1,IBDNOE>1 W !,"There are "_IBDNOE_" associated codes beginning with "_IBDANS_":"
 .S IBDCODE=^TMP("IBDFN4_ASSOCIATE_WCSEARCH",$J,IBDNDEX,1)
 .S IBDIEN=+$P(IBDCODE,U) ;+ to resolve both direct and variable pointers
 .S IBDCODE=$P(IBDCODE,U,2)
 .S IBDX=$P($$GETIDX("10D",IBDCODE,DT),U,2)
 .S IBDESCR=$P(^TMP("IBDFN4_ASSOCIATE_WCSEARCH",$J,IBDNDEX,2),U,2)
 .S ^TMP("IBDFN4_ASSOCIATE",$J,IBDCNT)=IBDIEN_U_IBDCODE_U_IBDX_U_IBDESCR
 .I IBDNOE>1 W !,IBDCNT_".",?4,IBDCODE,?15,IBDX
 .I IBDNOE=1 D
 ..D OKPROMPT(1,IBDCODE,IBDX,.IBDQUIT,.IBDNO)
 .I IBDQUIT!(IBDNO) Q
 .;Display every 22 ICD codes to user.
 .I IBDCNT#22=0 D
 ..K Y
 ..S DIR("A")="Press Enter for more, ^ to exit or Select ICD-10 ASSOCIATED CODE"
 ..S DIR(0)="NO^"_IBDBEGN_":"_IBDCNT
 ..D ^DIR K DIR
 ..S IBDBEGN=IBDCNT+1
 ..I Y="" W @IOF
 .I $D(DUOUT)!($D(DTOUT)) S (IBDQUIT,IBDOUT)=1 Q
 .I IBDCNT#22'=0,IBDNEXT="",IBDNOE'=1 D  ;
 ..K Y
 ..S DIR("A")="Press Enter to continue, ^ to exit or Select ICD-10 ASSOCIATED CODE"
 ..S DIR(0)="NO^"_IBDBEGN_":"_IBDCNT
 ..D ^DIR K DIR
 .I $D(DUOUT)!($D(DTOUT)) S (IBDQUIT,IBDOUT)=1 Q
 .I Y?1N.N!(IBDNOE=1) D  ;
 ..S IBDNODE=$S(IBDNOE=1:^TMP("IBDFN4_ASSOCIATE",$J,1),1:^TMP("IBDFN4_ASSOCIATE",$J,Y))
 ..S IBDIEN=$P(IBDNODE,U),IBDCODE=$P(IBDNODE,U,2),IBDX=$P(IBDNODE,U,3),IBDESCR=$P(IBDNODE,U,4)
 ..S @IBARY=IBDCODE_U_IBDX_U_IBDESCR
 ..S IBDQUIT=1
 ..I IBDNOE>1 W !,?4,IBDCODE,?15,IBDX
 ..K Y ;set up Y array to be passed back for filing of ^IBE(357.3.
 ..S Y=IBDIEN_U_IBDCODE
 ..S Y(0)=IBDCODE
 ..S Y(0,0)=IBDCODE
 Q
 ;Display the selected ICD-10 code(s) to user.
DISPLAY ; 
 ;
 N IBDCNT,IBDCODE,IBDNODE,IBDQUIT,IBDSUB,IBDX
 S (IBDCNT,IBDQUIT)=0
 W !!,^TMP("IBDFN4_DISPLAY",$J,0)_" Diagnosis Added.",!
 S IBDSUB=0
 F  S IBDSUB=$O(^TMP("IBDFN4_DISPLAY",$J,IBDSUB)) Q:IBDSUB=""  D  ;
 .;Display wildcard selections to user.
 .S IBDCNT=IBDCNT+1
 .S IBDNODE=^TMP("IBDFN4_DISPLAY",$J,IBDSUB)
 .S IBDCODE=$P(IBDNODE,U)
 .S IBDX=$P(IBDNODE,U,2)
 .W !,IBDX_" (ICD-10-CM "_IBDCODE_")"
 .I IBDCNT#18=0 D  ;
 ..W !
 ..S DIR(0)="E"
 ..D ^DIR
 ..I 'Y S IBDQUIT=1 Q
 ..W @IOF
 I IBDCNT#18=0 H 5
 W !
 Q
 ;get description
GETDSCR(IBDCSYS,IBDCODE,IBDT) ;
 N IBDZZ,IBDRETV
 S IBDRETV=$$ICDDESC^ICDXCODE(IBDCSYS,IBDCODE,IBDT,.IBDZZ)
 I IBDRETV<1 Q $P(IBDRETV,U,2)
 Q IBDZZ(1)_" "_$G(IBDZZ(3))
 ;get ien and diagnosis description
 ;IBDCSYS - "ICD-9" if ICD9 code, "10D" if ICD-10 code
 ;IBDCODE - Actual ICD code (ie S62.011P)
 ;IBDT    - Today's date.
GETIDX(IBDCSYS,IBDCODE,IBDT) ;
 N IBDICDX
 S IBDICDX=$$ICDDATA^ICDXCODE(IBDCSYS,IBDCODE,IBDT)
 I IBDICDX<1 Q $P(IBDICDX,U,2)
 Q $P(IBDICDX,U)_U_$P(IBDICDX,U,4)
 ;Set ^TMP global to display selected ICD-10 code and ICD-10 description to the user.
 ;Selected ICD-10 codes will be displayed to the user in line tag DISPLAY.
 ;NOTE: ICD-10 description could have been edited by the user.
SETMSG(IBDSLIEN,IBDCODE,IBDX,IBDSUB) ;
 N IBDI,IBDINDEX,IBDNODE,IBDSCHDR
 F IBDI=1:1:8 I $G(IBLIST("SCPIECE",IBDI)) D  ;
 .S IBDSCHDR=$G(IBLIST("SCHDR",IBDI)) I IBDSCHDR'="" D  ;
 ..I IBDSCHDR'="CODE",IBDSCHDR'="DIAGNOSIS" Q
 ..S IBDINDEX=0 F  S IBDINDEX=$O(^IBE(357.3,IBDSLIEN,1,IBDINDEX)) Q:'IBDINDEX  D  ;
 ...S IBDNODE=^IBE(357.3,IBDSLIEN,1,IBDINDEX,0)
 ...I $P(IBDNODE,U)=IBDI,IBDSCHDR="DIAGNOSIS" S IBDX=$P(IBDNODE,U,2)
 ...I $P(IBDNODE,U)=IBDI,IBDSCHDR="CODE" S IBDCODE=$P(IBDNODE,U,2)
 S ^TMP("IBDFN4_DISPLAY",$J,0)=$G(^TMP("IBDFN4_DISPLAY",$J,0))+1
 S ^TMP("IBDFN4_DISPLAY",$J,IBDSUB)=IBDCODE_U_IBDX
 Q
 ;To kill incomplete entries in ^IBE(357.3
KILL3573(IBDSEL) ;
 N DA,DIK
 S DA=IBDSEL,DIK="^IBE(357.3," D ^DIK K DIK
 Q
 ;Ask user with 'OK? Yes' prompt.
OKPROMPT(IBDONE,IBDCODE,IBDX,IBDQUIT,IBDNO) ;
 N DIR,IBDI
 I '$D(IBDONE) S IBDONE=0
 S DIR("A")="OK? (Yes/No) "
 F IBDI=1:1:4 D
 .I IBDONE D
 ..I IBDI=1 S DIR("A",1)="One match found."
 ..I IBDI=2 S DIR("A",2)=" "
 ..I IBDI=3 S DIR("A",3)=IBDCODE_"  "_IBDX
 ..I IBDI=4 S DIR("A",4)=" "
 .I 'IBDONE D
 ..I IBDI=1 S DIR("A",1)=" "
 ..I IBDI=2 S DIR("A",2)=IBDCODE_"  "_IBDX
 ..I IBDI=3 S DIR("A",3)=" "
 S DIR(0)="YAO",DIR("B")="Yes" D ^DIR K DIR
 W !
 I $D(DUOUT)!($D(DTOUT)) S IBDQUIT=1 Q
 I Y=0 S IBDNO=1
 Q
 ;Partial Code Lexicon ICD code search.
LXSEARCH ;
 N IBDCODE,IBDESCR,IBDINDEX,IBDQUIT,IBDX,IBDY
 S IBDQUIT=0
 I $G(DIC("A"))'="" D  Q:IBDQUIT
 .S DIR("A")=DIC("A")
 .S DIR(0)="FAO^0:245"
 .S DIR("?")="^D INPHLP^IBDLXDG"
 .S DIR("??")="^D INPHLP^IBDLXDG"
 .D ^DIR
 .I Y="^"!(Y="")!($D(DTOUT)) K @IBARY,DIC S IBDQUIT=1 Q
 .D SETPARAM^IBDLXDG(.IBDPARAM)
 .S IBDY=$$LEXICD10^IBDLXDG(Y,$$ICD10DT^IBDUTICD(DT),.IBDPARAM)
 I $G(DIC("A"))="" D
 .D SETPARAM^IBDLXDG(.IBDPARAM)
 .S IBDY=$$DIAG10^IBDLXDG($$ICD10DT^IBDUTICD(DT),"",.IBDPARAM)
 I IBDY="" W !!,IBDPARAM("NO DATA FOUND"),!,IBDPARAM("NO DATA FOUND 2"),! G LXSEARCH
 I IBDY=-1!(IBDY=-2)!(IBDY=-3)!(IBDY=-4) Q  ;Timed out or was aborted.
 S IBDCODE=$P($P(IBDY,U),";",2)
 S IBDX=$$GETIDX("10D",IBDCODE,DT)
 S IBDX=$P(IBDX,U,2)
 S IBDESCR=$P(IBDY,U,2)
 S @IBARY=IBDCODE_"^"_IBDX_"^"_IBDESCR
 K DIC
 Q
 ;IBDFN4
