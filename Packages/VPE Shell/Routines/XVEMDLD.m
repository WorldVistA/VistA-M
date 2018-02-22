XVEMDLD ;DJB/VEDD**Data: Look-up [08/12/94];2017-08-15  12:13 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
 I $G(ZGL)["^DIA(" D  D PAUSE^XVEMKC(3) Q
 . D ENDSCR^XVEMKT2
 . W $C(7),!?1,"You can't view data from ^DIA"
 NEW D0,D1,D2,D3,D4,D5,D6,DA,DIC,DICHOLD,DIQ,DR
 NEW FILE,FILEUP,FLAGLONG,FLAGQ,FLAGT,FLAGWP,FLD,FLDUP,FNAM
 NEW ANS,I,II,NODE,REF,REF1,TEMP,TYPE,WP,XXUP,ZDIC,ZDIQ
 S FLAGQ=0 D ACCESS^XVEMDLE Q:FLAGQ
 KILL ^UTILITY("DIQ1",$J),^TMP("XVV","VEDD",$J,"DATA")
 S FLAGLONG=0 ;FLAGLONG set to 1 if DR string too long.
 S REF=$$GETRANG^XVEMKTR("VEDD"_VEDDS) Q:REF="^"
 D ENDSCR^XVEMKT2 D GETTYPE^XVEMDLE Q:FLAGQ
 I REF["^" F REF1=$P(REF,"^",1):1:$P(REF,"^",2) D SET,BUILD
 I REF["," F I=1:1:$L(REF,",") S REF1=$P(REF,",",I) D SET,BUILD
 D DR F  D DA Q:FLAGQ  D DIQ,PRINT^XVEMDLE KILL ^UTILITY("DIQ1",$J) Q:FLAGQ
KILL ;
 KILL ^UTILITY("DIQ1",$J),^TMP("XVV","VEDD",$J,"DATA")
 Q
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SET ;Set Variables FILE & FLD
 S FILE=$P(^TMP("XVV","VEDD"_VEDDS,$J,REF1),U)
 S FLD=$P(^(REF1),U,2)
 I $P(^DD(FILE,FLD,0),U,2)["W" S FLAGWP(FILE)="" ;Word Processing Fld
 Q
BUILD ;Set ^TMP("XVV","VEDD",$J,"DATA") to sort FILE and FLD to be used to build DR variable.
 S FLAGT=0 F  D  Q:FLAGT
 . I '$D(^DD(FILE,0,"UP")) S ^TMP("XVV","VEDD",$J,"DATA",FILE,FLD)="",FLAGT=1 Q
 . S ^TMP("XVV","VEDD",$J,"DATA",FILE,FLD)=""
 . S FILEUP=^DD(FILE,0,"UP"),FLDUP=$O(^DD(FILEUP,"SB",FILE,""))
 . S NODE(FILE)=$P($P(^DD(FILEUP,FLDUP,0),U,4),";")
 . I +NODE(FILE)'=NODE(FILE) S NODE(FILE)=""""_NODE(FILE)_"""" ;If NODE(FILE) is a string, enclose in quotes.
 . S FILE=FILEUP,FLD=FLDUP
 Q
DR ;Build DR variable
 S (DR,FILE)="" F I=1:1 S FILE=$O(^TMP("XVV","VEDD",$J,"DATA",FILE)) Q:FILE=""!FLAGLONG  S:I=1 DR="" S:I>1 DR(FILE)="" S FLD="" F II=1:1 S FLD=$O(^TMP("XVV","VEDD",$J,"DATA",FILE,FLD)) Q:FLD=""!FLAGLONG  D
 . I I=1 S DR=DR_$S(II>1:";",1:"")_FLD S:$L(DR)>225 FLAGLONG=1 Q
 . S DR(FILE)=DR(FILE)_$S(II>1:";",1:"")_FLD
 . S:$L(DR(FILE))>225 FLAGLONG=1
 Q
DA ;Set DA Variable for each layer
 S FLAGQ=0,DIC=ZGL,DIC(0)="QEAM"
 W ! D ^DIC I Y<0 S FLAGQ=1 S:X="^^" FLAGE=1 Q
 S (DA,D0)=+Y,ZDIC(ZNUM)=DIC_+Y_"," ;EN^DIQ1 needs D0 defined
 S FILE="" F  S FILE=$O(DR(FILE)) Q:FILE=""!FLAGQ  D
 . I $D(FLAGWP(FILE)) S DA(FILE)=1 Q
 . S FILEUP=^DD(FILE,0,"UP"),TEMP=ZDIC(FILEUP)_NODE(FILE)_",0)"
 . I $O(@TEMP)'>0 D  Q
 . . I ZDIQ'["N" F I=1:1:$L(DR(FILE),";") S ^UTILITY("DIQ1",$J,FILE,DA,$P(DR(FILE),";",I),TYPE)="" ;No data at this node. This will display each field as blank.
 . . S ZDIC(FILE)=ZDIC(FILEUP)_NODE(FILE)_",""VEDD""," ;So any levels below this will be null.
 . S DIC=ZDIC(FILEUP)_NODE(FILE)_","
 . D ^DIC I Y<0 S FLAGQ=1 S:X="^^" FLAGE=1 Q
 . S DA(FILE)=+Y,ZDIC(FILE)=DIC_+Y_","
 Q
DIQ ;Call EN^DIQ1 to set up VEDD array.
 S DIC=ZGL,DIQ(0)=ZDIQ D EN^DIQ1
 Q
