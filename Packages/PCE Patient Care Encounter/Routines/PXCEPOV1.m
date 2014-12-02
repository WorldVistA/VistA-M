PXCEPOV1 ;ISL/dee - Used to edit and display V POV ;8/31/05
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**134,149,124,170,203,199**;Aug 12, 1996;Build 51
 ;; ;
 Q
 ;
 ;********************************
 ;Special cases for display.
 ;
DNARRAT(PNAR) ;Provider Narrative for ICD-9 / ICD-10
 N PXCEPNAR,PXDXDATE,SNARR
 I PNAR<0 Q ""
 S PXCEPNAR=$P(^AUTNPOV(PNAR,0),"^")
 I $G(VIEW)="B",$D(ENTRY)>0 D
 . N DIC,DR,DA,DIQ,PXCEDIQ1
 . S DA=$P(ENTRY(0),"^",1)
 . S PXDXDATE=$S($D(PXCEVIEN)=1:$$CSDATE^PXDXUTL(PXCEVIEN),$D(PXCEAPDT)=1:PXCEAPDT,1:DT)
 . S SNARR=$P($$ICDDATA^ICDXCODE("DIAG",DA,PXDXDATE,"I"),"^",4)
 . ;S:$G(PXCEDIQ1(80,DA,3,"E"))=PXCEPNAR PXCEPNAR=""
 . S:SNARR=PXCEPNAR PXCEPNAR=""
 Q PXCEPNAR
 ;
DPRIMSEC(PRIMSEC) ;
 I $G(VIEW)="B" Q $S(PRIMSEC="P":"PRIMARY",1:"")
 Q $S(PRIMSEC="P":"PRIMARY",PRIMSEC="S":"SECONDARY",1:"")
 ;
 ;********************************
 ;Special cases for edit.
 ;
ENARRAT(REQUIRED,ASK,DEFAULT,FILE,FIELD1,FIELD2) ;Provider Narrative  --  Used by ALL V-Files with Prov. Nar.
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
 S PXDXDATE=$S($D(PXCEVIEN)=1:$$CSDATE^PXDXUTL(PXCEVIEN),$D(PXCEAPDT)=1:PXCEAPDT,1:DT)
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
EINJURY ;Date/Time of Injury
 ;If not an injury code Q
 N DIC,DR,DA,DASV,DIQ,PXCEDIQ1
 S DIC=80
 S DR=".01"
 S (DA,DASV)=$P(PXCEAFTR(0),"^",1)
 S DIQ="PXCEDIQ1("
 S DIQ(0)="E"
 D EN^DIQ1
 I PXCEDIQ1(80,DASV,.01,"E")'<800,PXCEDIQ1(80,DASV,.01,"E")'>999.999 D E1201^PXCEPOV1(-1,-1,0)
 ; ICD-10 Injury Code logic immediately below -- codes beginning with S or T will be considered Injury codes.
 I "^S^T^"[("^"_$E(PXCEDIQ1(80,DASV,.01,"E"))_"^") D E1201^PXCEPOV1(-1,-1,0)
 Q
 ;
 ;********************************
 ;Special cases for edit for Event Date and Time field number 1201
 ; and other date and times.
 ;
E1201(REQTIME,BEFORE,AFTER,DEFAULT) ;
 ;REQTIME is 1 if time is required,
 ;           0 if time is optional
 ;          -1 if the date can be imprecise
 ;BEFORE  is the number of days before the visit that the date can
 ;        not be before or -1 for any amount before.
 ;AFTER   is the number of days after the visit that the date can
 ;        not be after or -1 for any amount.  In any case the date
 ;        cannot be later than today.
 ;DEFAULT is the default date/time if there is not one in the file.
 ;        If it is -1 then NOW will be used as the default.
 ;        If it is 0 then TODAY will be used as the default.
 N X1,X2,X,%Y,%H,%I,%
 N PXCEVST S PXCEVST=$P(+^TMP("PXK",$J,"VST",1,0,"BEFORE"),".")
 N PXCEBEF,PXCEAFT S (PXCEBEF,PXCEAFT)=""
 I $D(AFTER)#2,AFTER'<0 D
 . I AFTER=0 S PXCEAFT=PXCEVST+.9
 . E  D
 .. S X1=DT
 .. S X2=$P(+^TMP("PXK",$J,"VST",1,0,"BEFORE"),".")
 .. D ^%DTC
 .. I X'>AFTER S PXCEAFT=DT+.9
 .. E  D
 ... S X1=$P(+^TMP("PXK",$J,"VST",1,0,"BEFORE"),".")
 ... S X2=AFTER
 ... D C^%DTC
 ... S PXCEAFT=X+.9
 I $D(BEFORE)#2,BEFORE'<0 D
 . I BEFORE=0 S PXCEBEF=PXCEVST
 . E  D
 .. S X1=$P(+^TMP("PXK",$J,"VST",1,0,"BEFORE"),".")
 .. S X2=-BEFORE
 .. D C^%DTC
 .. S PXCEBEF=X
 S DIR(0)="DO^"_PXCEBEF_":"_PXCEAFT_":ESP"
 I $G(REQTIME)=1 S DIR(0)=DIR(0)_"RX"
 E  I $G(REQTIME)=-1 S DIR(0)=DIR(0)_"T"
 E  S DIR(0)=DIR(0)_"TX"
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" S DIR("B")=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 E  I ($D(DEFAULT)#2) D
 . I DEFAULT>0 S DIR("B")=DEFAULT
 . E  I DEFAULT=0 S DIR("B")=DT
 . E  I DEFAULT=-1 D NOW^%DTC S DIR("B")=%
 I $D(DIR("B"))#2 S Y=DIR("B") D DD^%DT S DIR("B")=Y
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S PXCEEND=1 Q
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^")
 Q
 ;
ICDCODE ;enter ICD9/ICD10 code using lexicon
 ; DBIA # 1571 AND 1609
 N CODE,PXACS,PXACSREC,PXDXDATE,PXDEF
 S PXDXDATE=$S($D(PXCEVIEN)=1:$$CSDATE^PXDXUTL(PXCEVIEN),$D(PXCEAPDT)=1:PXCEAPDT,1:DT)
 S PXACSREC=$$ACTDT^PXDXUTL(PXDXDATE),PXACS=$P(PXACSREC,"^",3)
 I PXACS["-" S PXACS=$P(PXACS,"-",1,2)
 K X
 I +$G(PXCEAFTR(0))>0 D
 . S CODE=$P(PXCEAFTR(0),"^")
 . S X=$P($$ICDDATA^ICDXCODE("DIAG",CODE,PXDXDATE,"I"),"^",2)
 I $P(PXACSREC,U,1)'="ICD" D
 . S PXDEF=$G(X),PXAGAIN=0,PXDATE=PXDXDATE D ^PXDSLK I PXXX=-1 S Y=-1 Q
 . S Y($P(PXACSREC,U,2))=$P($P(PXXX,U,1),";",2)
 . S Y=$P(PXXX,";",1)_U_$P(PXXX,U,2)
 I $P(PXACSREC,U,1)="ICD" D
 . D CONFIG^LEXSET($P(PXACSREC,"^",1),,PXDXDATE)
 . S DIC("A")="Select "_PXACS_" Diagnosis: "
 . S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"A",1:"")_"EQM"
 . D ^DIC
 I $G(X)="@" Q
 I Y=-1 S DIRUT=-1 Q
 S CODE=Y($P(PXACSREC,"^",2))
 S Y=+$$ICDDATA^ICDXCODE("DIAG",CODE,PXDXDATE,"E")
 Q
