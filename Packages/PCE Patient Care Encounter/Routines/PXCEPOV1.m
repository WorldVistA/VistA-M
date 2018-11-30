PXCEPOV1 ;ISL/dee - Used to edit and display V POV ;08/09/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**134,149,124,170,203,199,211**;Aug 12, 1996;Build 244
 ;;
 Q
 ;
 ;********************************
DINJHELP ;Date of Injury help.
 N RESULT,TEXT
 S RESULT=$$GET1^DID(9000010.07,.13,"","DESCRIPTION","TEXT","ERR")
 D BROWSE^DDBR("TEXT(""DESCRIPTION"")","NR","V POV Date of Injury Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
 ;********************************
 ;Special cases for display.
 ;
DNARRAT(PNAR,PXCEDT) ;Provider Narrative for ICD-9 / ICD-10
 N PXCEPNAR,PXDXDATE,SNARR
 I PNAR<0 Q ""
 S PXCEPNAR=$P(^AUTNPOV(PNAR,0),"^")
 I $G(VIEW)="B",$D(ENTRY)>0 D
 . N DIC,DR,DA,DIQ,PXCEDIQ1
 . S DA=$P(ENTRY(0),"^",1)
 . S PXDXDATE=$S($D(PXCEVIEN)=1:$$CSDATE^PXDXUTL(PXCEVIEN),$D(PXCEAPDT)=1:PXCEAPDT,1:DT)
 . S SNARR=$P($$ICDDATA^ICDXCODE("DIAG",DA,PXDXDATE,"I"),"^",4)
 . S:SNARR=PXCEPNAR PXCEPNAR=""
 Q PXCEPNAR
 ;
 ;********************************
DPRIMSEC(PRIMSEC,PXCEDT) ;
 I $G(VIEW)="B" Q $S(PRIMSEC="P":"PRIMARY",1:"")
 Q $S(PRIMSEC="P":"PRIMARY",PRIMSEC="S":"SECONDARY",1:"")
 ;
 ;********************************
 ;Special cases for edit.
 ;
ENARRAT(REQUIRED,ASK,DEFAULT,FILE,FIELD1,FIELD2) ;Provider Narrative
 ;Used by ALL V-Files with Prov. Nar.
 ; REQUIRED  0 for not required
 ;           1 for required
 ; ASK       0 for do not ask
 ;           1 for ask
 ;           2 for ask only if there is already a value
 ; DEFAULT   0 for do not default
 ;           1 for do default
 ;           changed to 1 if REQUIRED is 1
 ;
 N PXKLAYGO,ASKING
 S PXKLAYGO=""
 S ASKING=ASK#2
 S:REQUIRED DEFAULT=1
 I PXCEKEYS["C" S ASKING=1
ENARRAT1 ;
 K DIR,DA,X,Y,C
 S (X,Y)=""
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 . N DIERR,PXCEDILF,PXCEEXT,PXCEINT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S (DIR("B"),X,Y)=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIR(0)="FAO^1:245"
 S DIR("A")=$P(PXCETEXT,"~",4)
 I $P(PXCETEXT,"~",8)]"" S DIR("?")=$P(PXCETEXT,"~",8)
 E  D
 . S DIR("?",1)="This response must have at least 2 characters and no more than 245"
 . S DIR("?",2)="characters and must not contain embedded uparrows."
 . I REQUIRED S DIR("?")="This field is required."
 . E  S DIR("?")="This field is optional."
 I ASK=2,(Y]"") S ASKING=1
 I ASKING D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S PXCEEND=1 S:REQUIRED PXCEQUIT=1 Q
 N PXCEX,PXCEY
 I $E(Y,1)="=" S PXCEX=$E(PXCEIN01_" "_$E($P(Y,"^"),2,245),1,245)
 E  S PXCEX=Y
 ; ***
 ; PX*1.0*199 - ICD-10 Remediation note.  
 ; Fields 5 and 10 in file #80 have been modified by STS for ICD-10.
 ; In the following lines of code these two field numbers are intercepted
 ; and an appropriate, alternative data retrieval is implemented.
 ; Other file and field numbers will behave as they previously did.
 ; ***
 N DXCATIEN,PXDXDATE
 S PXDXDATE=$P($G(PXCEAFTR(12)),U,1)
 I PXDXDATE="" S PXDXDATE=$S($D(PXCEVIEN)=1:$$CSDATE^PXDXUTL(PXCEVIEN),$D(PXCEAPDT)=1:PXCEAPDT,1:DT)
 I DEFAULT,PXCEX="" D
 . I $G(FILE)=80,$G(FIELD1)=10 D  Q
 .. S PXCEX=$$DXNARR^PXUTL1($P(PXCEAFTR(0),"^",1),PXDXDATE)
 . I $G(FILE)=80,$G(FIELD1)=5 D  Q
 .. S DXCATIEN=$P($$ICDDATA^ICDXCODE("DIAG",$P(PXCEAFTR(0),"^",1),PXDXDATE,"I"),"^",6)
 .. I $L(DXCATIEN) S PXCEX=$$GET1^DIQ(80.3,DXCATIEN,.01)
 . S PXCEX=$$EXTTEXT^PXUTL1($P(PXCEAFTR(0),"^",1),REQUIRED,$G(FILE),$G(FIELD1),$G(FIELD2))
 I ASKING D
 . W !,PXCEX
 I $L(PXCEX)=1,PXCEX'="@" W !,"Must be 2 to 245 characters." G ENARRAT1
 I PXCEX="@"!(PXCEX=""),REQUIRED W !,"This field is required.",$C(7) G ENARRAT1
 ;
 I PXCEX="@"!(PXCEX="") S PXCEY=PXCEX
 E  S PXCEY=$$PROVNARR^PXAPI(PXCEX,PXCEFILE) I ASKING,+PXCEY'>0 W "??",$C(7) G ENARRAT1
 E  I +PXCEY'>0 S PXCEY=""
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(PXCEY,"^")
 Q
 ;
 ;********************************
EINJURY ;Date/Time of Injury
 ;If not an injury code Q
 N CODEIEN,DIRUT,DOINJ,HELP,INJCODE,PROMPT
 S CODEIEN=$P(PXCEAFTR(0),U,1)
 S INJCODE=$$INJURYC(CODEIEN)
 I INJCODE=0 Q
 S HELP="D DINJHELP^PXCEPOV1"
 S DOINJ=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 S PROMPT=$P(PXCETEXT,"~",4)
 S DOINJ=$$GETDT^PXDATE(-1,-1,0,DOINJ,PROMPT,HELP)
 I $D(DIRUT),(DOINJ'="@") S PXCEEND=1 Q
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=DOINJ
 Q
 ;
 ;********************************
EVDTHELP ;Event Date and Time help.
 N ERR,RESULT,TEXT
 S RESULT=$$GET1^DID(9000010.07,1201,"","DESCRIPTION","TEXT","ERR")
 D BROWSE^DDBR("TEXT(""DESCRIPTION"")","NR","V POV Event Date and Time Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
 ;********************************
ICDCODE ;Enter ICD code using Lexicon.
 N CODE,CODEIEN,CODESYS,EVENTDT,HELP,PXCEDT,SRCHTERM
 ;Prompt the user for the Lexicon search term.
 S SRCHTERM=$$GETST^PXLEX
 I SRCHTERM="" S DIRUT=1,(X,Y)="" Q
 ;Prompt the user for the Event Date and Time.
 S HELP="D EVDTHELP^PXCEPOV1"
 S EVENTDT=$$EVENTDT^PXDATE(HELP)
 S PXCEDT=EVENTDT
 ;If the Event Date and Time is null use the Visit Date.
 I PXCEDT="" S PXCEDT=$P(^TMP("PXK",$J,"VST",1,0,"BEFORE"),U,1)
 ;Set the coding system based on the Date.
 S CODESYS=$P($$ACTDT^PXDXUTL(PXCEDT),U,1)
 ;Let the user select the code, only return active codes.
 S CODE=$$GETCODE^PXLEXS(CODESYS,SRCHTERM,PXCEDT,1)
 I CODE="" S DIRUT=1,(X,Y)="" Q
 ;ICR #5747
 S CODEIEN=$P($$CODEN^ICDCODE(CODE),"~",1)
 S $P(PXCEAFTR(0),U,1)=CODEIEN
 S $P(PXCEAFTR(12),U,1)=EVENTDT
 Q
 ;
 ;********************************
INJURYC(CODEIEN) ;Return 1 if the ICD code is an injury code.
 ;If not an injury code Q
 N CODE,CODESYS,INJCODE
 S CODE=$$CODEC^ICDCODE(CODEIEN)
 S CODESYS=$$CSI^ICDEX(80,CODEIEN)
 S INJCODE=0
 ;ICD-9 codes between 800 and 999.999 are considered injury codes.
 I (CODESYS=1),(CODE'<800),(CODE'>999.999) S INJCODE=1
 ;ICD-10 Codes beginning with S or T are considered Injury codes.
 I CODESYS=30 D
  . N C1
  . S C1=$E(CODE,1)
  . I (C1="S")!(C1="T") S INJCODE=1
 Q INJCODE
 ;
