PXCEPOV1 ;ISL/dee - Used to edit and display V POV ;8/31/05
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**134,149,124,170**;Aug 12, 1996
 ;; ;
 Q
 ;
 ;********************************
 ;Special cases for display.
 ;
DNARRAT(PNAR) ;Provider Narrative for ICD-9
 N PXCEPNAR,SNARR
 I PNAR<0 Q ""
 S PXCEPNAR=$P(^AUTNPOV(PNAR,0),"^")
 I $G(VIEW)="B",$D(ENTRY)>0 D
 . N DIC,DR,DA,DIQ,PXCEDIQ1
 . ;S DIC=80
 . ;S DR="3"
 . S DA=$P(ENTRY(0),"^",1)
 . ;S DIQ="PXCEDIQ1("
 . ;S DIQ(0)="E"
 . ;D EN^DIQ1
 . S SNARR=$P($$ICDDX^ICDCODE(DA,$G(IDATE)),"^",4)
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
 . S DIR("?",2)="characters and must not contain embedded uparrow."
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
 I DEFAULT,PXCEX="" S PXCEX=$$EXTTEXT^PXUTL1($P(PXCEAFTR(0),"^",1),REQUIRED,$G(FILE),$G(FIELD1),$G(FIELD2))
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
 ;I not an injury code Q
 N DIC,DR,DA,DIQ,PXCEDIQ1
 S DIC=80
 S DR=".01"
 S DA=$P(PXCEAFTR(0),"^",1)
 S DIQ="PXCEDIQ1("
 S DIQ(0)="E"
 D EN^DIQ1
 I PXCEDIQ1(80,DA,.01,"E")'<800,PXCEDIQ1(80,DA,.01,"E")'>999.999 D E1201^PXCEPOV1(-1,-1,0)
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
 ;        can not be later than today.
 ;DEFAULT is the default date/time is there is not one in the file.
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
ICDCODE ;enter ICD9 code using lexicon
 ; DBIA # 1571 AND 1609
 N CODE
 K X
 I +$G(PXCEAFTR(0))>0 D
 . S CODE=$P(PXCEAFTR(0),"^")
 . S X=$P($$ICDDX^ICDCODE(CODE,$G(PXCEAPDT)),"^",2)
 D CONFIG^LEXSET("ICD",,$G(PXCEAPDT))
 S DIC("A")="Select Diagnosis: "
 S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"A",1:"")_"EQM"
 D ^DIC
 I X="@" Q
 I Y=-1 S DIRUT=-1 Q
 S CODE=Y(1)
 S Y=+$$ICDDX^ICDCODE(CODE)
 Q
