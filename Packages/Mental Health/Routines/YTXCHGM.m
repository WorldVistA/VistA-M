YTXCHGM ;SLC/KCM - MH Exchange, JSON-Fileman Map ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**121,123**;Dec 30, 1994;Build 72
 ;
BLDMAP(MAP) ; map file,field to JSON names in .MAP
 K MAP ; ensure rebuild
 N I,J,X,FILE,FIELD,TYPE,LOOP,SEQ
 F I=1:1 S X=$P($T(MAPJSON+I),";;",2,9) Q:X="zzzzz"  D
 . F J=3,4,5 S FILE=+$P(X,U,J) I FILE D
 . . S FIELD=$P($P(X,U,J),":",2),TYPE=$P(X,U,2)
 . . I FIELD'="*" S FIELD=+FIELD
 . . S MAP(FILE,FIELD)=$P(X,U)
 . . I $L(TYPE) S MAP(FILE,FIELD,"type")=TYPE
 S SEQ=0
 F I=1:1 S X=$P($T(MAPLOOP+I),";;",2,9) Q:X="zzzzz"  D
 . S FILE=$P(X,U),SEQ=SEQ+1
 . S MAP("store",SEQ,"file")=$P(X,U)
 . S MAP("store",SEQ,"loop")=$P(X,U,2)
 Q
 ;
BLDSEQ(MAP) ; build display sequence
 ; COLUMN("num",num)=count
 ; COLUMN("used",num,name)=mult
 N I,J,K,X,CURCOL,COLUMN,MULT,NM,REF,SEQ
 F I=1:1 S X=$P($P($T(MAPJSON+I),";;",2,9),U) Q:X="zzzzz"  D
 . ;S MAP(I)=X
 . S CURCOL=0,REF=""
 . F J=1:1:$L(X,",") S NM=$TR($P(X,",",J),"""","") D
 . . S MULT=$E($P(X,",",J+1))="?" I MULT S NM="?"_NM,J=J+1 ; skip next
 . . S CURCOL=CURCOL+1
 . . I '$D(COLUMN("used",CURCOL,NM)) D  ; new label for this column
 . . . S SEQ=$G(COLUMN("num",CURCOL))+1,COLUMN("num",CURCOL)=SEQ
 . . . S COLUMN("used",CURCOL,NM)=MULT
 . . . S K=CURCOL F  S K=$O(COLUMN("num",K)) Q:'K  K COLUMN("num",K),COLUMN("used",K)
 . . E  D
 . . . S SEQ=COLUMN("num",CURCOL)
 . . S REF=REF_$S($L(REF):",",1:"")_SEQ_","""_NM_""""
 . S @("MAP("_REF_")")=""
 Q
SHOJSON ; show JSON map
 N I,X
 F I=1:1 S X=$P($T(MAPJSON+I),";;",2,9) Q:X="zzzzz"  D
 . W !,$P(X,U),?57,$P(X,U,2),?61,$P(X,U,3,7)
 Q
SHOFILE ; show file map
 N MAP,SEQ
 D BLDMAP(.MAP)
 S SEQ=0 F  S SEQ=$O(MAP("store",SEQ)) Q:'SEQ  D
 . W !,MAP("store",SEQ,"file"),?20,MAP("store",SEQ,"loop")
 Q
 ;
MAPLOOP ; file^loopType
 ;;601.71^
 ;;601.88^display
 ;;601.75^content:choice
 ;;601.751^content:choice
 ;;601.89^content
 ;;601.74^content
 ;;601.73^content
 ;;601.72^content
 ;;601.76^content
 ;;601.81^section
 ;;601.86^scaleGroup
 ;;601.87^scaleGroup:scale
 ;;601.91^scaleGroup:scale:scoringKey
 ;;601.82^rule
 ;;601.83^rule
 ;;601.79^rule:skippedQuestion
 ;;601.93^
 ;;zzzzz
 ;
 ; Note:  The following fields should not be sent to a site, since
 ;        they may be modified locally.
 ;
 ;         8  A PRIVILEGE
 ;         9  R PRIVILEGE
 ;        27  DAYS TO RESTART
 ;        28  GENERATE PNOTE
 ;        29  TIU TITLE
 ;        30  CONSULT NOTE TITLE
 ;
 ; Note:  Special Handling Codes
 ;        d: MH DISPLAY entry
 ;        e: edit date -- change at end
 ;        t: date/time
 ;        y: boolean - yes/no
 ;        w: word processing
 ;
MAPJSON ;; name^handling^primaryFile:primaryField^refFile1:refField1^...
 ;;"info","id"^^601.71:0.001
 ;;"info","name"^^601.71:0.01
 ;;"info","printTitle"^^601.71:2
 ;;"info","version"^^601.71:3
 ;;"info","author"^^601.71:4
 ;;"info","publisher"^^601.71:5
 ;;"info","publicationDate"^t^601.71:7
 ;;"info","operational"^^601.71:10
 ;;"info","requiresLicense"^^601.71:11
 ;;"info","licenseCurrent"^y^601.71:20
 ;;"info","wasOperational"^y^601.71:10.5
 ;;"info","purpose"^^601.71:12
 ;;"info","normSample"^^601.71:13
 ;;"info","targetPopulation"^^601.71:14
 ;;"info","enteredBy"^^601.71:15
 ;;"info","entryDate"^t^601.71:16
 ;;"info","lastEditedBy"^^601.71:17
 ;;"info","lastEditDate"^e^601.71:18
 ;;"info","national"^y^601.71:19
 ;;"info","copyrightText"^^601.71:21
 ;;"info","reference"^^601.71:7.5
 ;;"info","requireSignature"^y^601.71:22
 ;;"info","legacy"^y^601.71:23
 ;;"info","submitNational"^y^601.71:24
 ;;"info","copyrighted"^y^601.71:25
 ;;"info","fullText"^y^601.71:26
 ;;"info","scoringTag"^^601.71:91
 ;;"info","scoringRoutine"^^601.71:92
 ;;"info","scoringRevision"^^601.71:93
 ;;"info","dllVersion"^^601.71:100.01
 ;;"info","dllDate"^t^601.71:100.02
 ;;"info","auxVersion"^^601.71:100.03
 ;;"info","auxDate"^t^601.71:100.04
 ;;"section",?1,"id"^^601.81:0.01
 ;;"section",?1,"instrument"^^601.81:1
 ;;"section",?1,"firstQuestion"^^601.81:2
 ;;"section",?1,"tabCaption"^^601.81:3
 ;;"section",?1,"sectionCaption"^^601.81:4
 ;;"section",?1,"displayId"^d^601.81:6
 ;;"content",?1,"id"^^601.76:0.01
 ;;"content",?1,"instrument"^^601.76:1
 ;;"content",?1,"sequence"^^601.76:2
 ;;"content",?1,"questionId"^^601.76:3^601.72:0.01
 ;;"content",?1,"designator"^^601.76:4
 ;;"content",?1,"questionText"^w^601.72:1
 ;;"content",?1,"introId"^^601.72:2^601.73:0.01
 ;;"content",?1,"introText"^w^601.73:1
 ;;"content",?1,"responseTypeId"^^601.72:3^601.74:0.01
 ;;"content",?1,"responseTypeText"^^601.74:1
 ;;"content",?1,"min"^^601.72:5
 ;;"content",?1,"max"^^601.72:6
 ;;"content",?1,"required"^y^601.72:7
 ;;"content",?1,"hint"^^601.72:8
 ;;"content",?1,"questionDisplay"^d^601.76:7
 ;;"content",?1,"introDisplay"^d^601.76:8
 ;;"content",?1,"choiceDisplay"^d^601.76:9
 ;;"content",?1,"choiceTypeId"^^601.72:4^601.751:0.01^601.89:0.01
 ;;"content",?1,"choiceIdentifierIen"^^601.89:0.001
 ;;"content",?1,"choiceIdentifier"^^601.89:1
 ;;"content",?1,"choice",?2,"ien"^^601.751:0.001
 ;;"content",?1,"choice",?2,"sequence"^^601.751:1
 ;;"content",?1,"choice",?2,"choiceId"^^601.751:2^601.75:0.01^^
 ;;"content",?1,"choice",?2,"choiceText"^^601.75:3
 ;;"content",?1,"choice",?2,"legacyValue"^^601.75:4
 ;;"display",?1,"id"^^601.88:0.01
 ;;"display",?1,"fontName"^^601.88:1
 ;;"display",?1,"fontBold"^y^601.88:2
 ;;"display",?1,"fontItalic"^y^601.88:3
 ;;"display",?1,"fontUnderlined"^y^601.88:4
 ;;"display",?1,"fontSize"^^601.88:5
 ;;"display",?1,"fontColor"^^601.88:6
 ;;"display",?1,"alignment"^^601.88:7
 ;;"display",?1,"left"^^601.88:8
 ;;"display",?1,"mask"^^601.88:9
 ;;"display",?1,"columns"^^601.88:10
 ;;"display",?1,"component"^^601.88:11
 ;;"scaleGroup",?1,"id"^^601.86:0.01
 ;;"scaleGroup",?1,"name"^^601.86:2
 ;;"scaleGroup",?1,"instrument"^^601.86:1
 ;;"scaleGroup",?1,"sequence"^^601.86:3
 ;;"scaleGroup",?1,"ordTitle"^^601.86:4
 ;;"scaleGroup",?1,"ordMin"^^601.86:5
 ;;"scaleGroup",?1,"ordInc"^^601.86:6
 ;;"scaleGroup",?1,"ordMax"^^601.86:7
 ;;"scaleGroup",?1,"grid1"^^601.86:8
 ;;"scaleGroup",?1,"grid2"^^601.86:9
 ;;"scaleGroup",?1,"grid3"^^601.86:10
 ;;"scaleGroup",?1,"scale",?2,"id"^^601.87:0.01
 ;;"scaleGroup",?1,"scale",?2,"groupId"^^601.87:1
 ;;"scaleGroup",?1,"scale",?2,"sequence"^^601.87:2
 ;;"scaleGroup",?1,"scale",?2,"name"^^601.87:3
 ;;"scaleGroup",?1,"scale",?2,"xLabel"^^601.87:4
 ;;"scaleGroup",?1,"scale",?2,"scoringKey",?3,"id"^^601.91:0.01
 ;;"scaleGroup",?1,"scale",?2,"scoringKey",?3,"scaleId"^^601.91:1
 ;;"scaleGroup",?1,"scale",?2,"scoringKey",?3,"questionId"^^601.91:2
 ;;"scaleGroup",?1,"scale",?2,"scoringKey",?3,"targetText"^^601.91:3
 ;;"scaleGroup",?1,"scale",?2,"scoringKey",?3,"value"^^601.91:4
 ;;"rule",?1,"id"^^601.82:0.01^601.83:3
 ;;"rule",?1,"indexQuestionId"^^601.82:1
 ;;"rule",?1,"indexValue"^^601.82:2
 ;;"rule",?1,"indexValueDataType"^^601.82:3
 ;;"rule",?1,"indexOperator"^^601.82:4
 ;;"rule",?1,"booleanOperator"^^601.82:5
 ;;"rule",?1,"targetQuestionId"^^601.82:6
 ;;"rule",?1,"targetValue"^^601.82:7
 ;;"rule",?1,"targetValueDataType"^^601.82:8
 ;;"rule",?1,"targetOperator"^^601.82:9
 ;;"rule",?1,"messageText"^^601.82:10
 ;;"rule",?1,"consistencyCheck"^y^601.82:11
 ;;"rule",?1,"instrumentId"^^601.83:1
 ;;"rule",?1,"instrumentRuleId"^^601.83:0.01
 ;;"rule",?1,"instrumentQuestionId"^^601.83:2
 ;;"rule",?1,"skippedQuestion",?2,"id"^^601.79:0.01
 ;;"rule",?1,"skippedQuestion",?2,"instrumentId"^^601.79:1
 ;;"rule",?1,"skippedQuestion",?2,"ruleId"^^601.79:2
 ;;"rule",?1,"skippedQuestion",?2,"questionId"^^601.79:3
 ;;"report","id"^^601.93:0.01
 ;;"report","instrument"^^601.93:1
 ;;"report","template"^w^601.93:2
 ;;zzzzz
 ;
