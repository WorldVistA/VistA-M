KMPDU5 ;OAK/RAK - CM Tools Utilities ;8/25/04  08:56
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**2**;Mar 22, 2002
 ;
FILEINQ(KMPDY,KMPDFN,KMPDIEN,KMPDGBL) ;-- file inquiry.
 ;-----------------------------------------------------------------------
 ; KMPDFN.... File number.
 ; KMPDIEN... Ien for above file.
 ; KMPDGBL... Global where data is stored.
 ;-----------------------------------------------------------------------
 ;
 K KMPDY
 ;
 I '$G(KMPDFN) S KMPDY="[File Number not defined]" Q
 I '$D(^DD(KMPDFN)) S KMPDY="[File #"_KMPDFN_" is not defined]" Q
 ;
 I '$G(KMPDIEN) S KMPDY="[IEN not defined]" Q
 ;
 I KMPDGBL="" S KMPDY="[Global for storage is not defined]" Q
 ;
 N ARRAY,CNT,DATA,ERROR,FIELD,FILE,I,IEN,LN,TITLE
 ;
 ; kill global with check for ^tmp or ^utility.
 D KILL^KMPDU(.DATA,KMPDGBL)
 ; if error.
 I $E(DATA)="[" S KMPDY=DATA Q
 ;
 S ARRAY=$NA(^TMP("KMPD FILE INQ",$J))
 K @ARRAY
 ;
 S FIELD="**"
 I KMPDFN=9.4 S FIELD="" D 
 .F I=0:0 S I=$O(^DD(KMPDFN,I)) Q:'I  D 
 ..I $P($G(^DD(KMPDFN,I,0)),U,2)'["C"&($P($G(^(0)),U,2)'["M")&($E($G(^(0)))'="*")&($P($G(^(0)),U,3)'="") S FIELD=FIELD_I_";"
 .S FIELD=FIELD_"3;" ;4;5;"
 ;
 D GETS^DIQ(KMPDFN,KMPDIEN,FIELD,"R",ARRAY,"ERROR")
 ;
 I $D(ERROR) S KMPDY="[Error occurred while getting info.]" Q
 ;
 I '$D(@ARRAY) S KMPDY="<No Data to Report>" Q
 ;
 S FILE="",LN=0
 F  S FILE=$O(@ARRAY@(FILE)) Q:FILE=""  D 
 .S IEN=""
 .F  S IEN=$O(@ARRAY@(FILE,IEN)) Q:IEN=""  D 
 ..S FIELD=""
 ..F  S FIELD=$O(@ARRAY@(FILE,IEN,FIELD)) Q:FIELD=""  D 
 ...; if not a multiple.
 ...I '$O(@ARRAY@(FILE,IEN,FIELD,0)) D  Q
 ....S @KMPDGBL@(LN)=FIELD,@KMPDGBL@(LN)=@KMPDGBL@(LN)_$$REPEAT^XLFSTR(".",30-$L(@KMPDGBL@(LN)))
 ....S @KMPDGBL@(LN)=@KMPDGBL@(LN)_": "_@ARRAY@(FILE,IEN,FIELD)
 ....S LN=LN+1
 ...;
 ...; if multiple
 ...S @KMPDGBL@(LN)=FIELD
 ...S @KMPDGBL@(LN)=@KMPDGBL@(LN)_$$REPEAT^XLFSTR(".",30-$L(@KMPDGBL@(LN)))
 ...S @KMPDGBL@(LN)=@KMPDGBL@(LN)_": "
 ...;S LN=LN+1
 ...S CNT=1
 ...F I=0:0 S I=$O(@ARRAY@(FILE,IEN,FIELD,I)) Q:'I  D 
 ....;S @KMPDGBL@(LN)=FIELD,@KMPDGBL@(LN)=@KMPDGBL@(LN)_$$REPEAT^XLFSTR(" ",30-$L(@KMPDGBL@(LN)))
 ....I CNT=1 S @KMPDGBL@(LN)=$G(@KMPDGBL@(LN))_@ARRAY@(FILE,IEN,FIELD,I)
 ....E  D 
 .....S @KMPDGBL@(LN)=$G(@KMPDGBL@(LN))_$$REPEAT^XLFSTR(" ",30-$L($G(@KMPDGBL@(LN))))
 .....S @KMPDGBL@(LN)=@KMPDGBL@(LN)_"  "_@ARRAY@(FILE,IEN,FIELD,I)
 ....S LN=LN+1,CNT=CNT+1
 ;
 S KMPDY=$NA(@KMPDGBL)
 S:'$D(@KMPDGBL) KMPDY="<No Data To Report>"
 ;
 Q
 ;
FILESRC(KMPDY,KMPDFN,KMPDFLD,KMPDSRC,KMPDGBL) ;-- file search.
 ;-----------------------------------------------------------------------
 ; KMPDFN... File Number.
 ; KMPDFLD.. Fields to be returned, seperated by commas.
 ;           Example: ".01,.04,1" would return fields .01, .04 and 1.
 ; KMPDSRC.. (optional). Search text.  This will search the .01 field for
 ;           a match.  If KMPDSRC="*" or is null then all entries will be
 ;           returned.
 ; KMPDGBL... Global where data is stored.
 ;-----------------------------------------------------------------------
 ;
 K KMPDY
 ;
 S KMPDFN=+$G(KMPDFN),KMPDFLD=$G(KMPDFLD)
 S KMPDSRC=$$UP^XLFSTR($G(KMPDSRC)),KMPDGBL=$G(KMPDGBL)
 ;
 I 'KMPDFN S KMPDY="[File Number not defined]" Q
 ;
 I KMPDFLD="" S KMPDY="[No fields have been requested]" Q
 ;
 I KMPDGBL="" S KMPDY="[Global for storage is not defined]" Q
 ;
 N DATA,GLOBAL,I,IEN,LN,NAME,NODE,PIECE
 ;
 ; kill global with check for ^tmp or ^utility.
 D KILL^KMPDU(.DATA,KMPDGBL)
 ; if error.
 I $E(DATA)="[" S KMPDY=DATA Q
 ;
 S GLOBAL=$G(^DIC(KMPDFN,0,"GL"))
 I GLOBAL="" S KMPDY="[File #"_KMPDFN_" is not defined]" Q
 ; make sure global name is closed () for use with subscript indirection.
 S:$E(GLOBAL,$L(GLOBAL))="," $E(GLOBAL,$L(GLOBAL))=")"
 ;
 ; set zero node to field titles.
 S $P(@KMPDGBL@(0),U)="IEN"
 F I=1:1 S DATA=$P(KMPDFLD,",",I) Q:DATA=""  D 
 .; try title first.
 .S TITLE=$G(^DD(KMPDFN,DATA,.1))
 .; if no title use name.
 .S:TITLE="" TITLE=$P($G(^DD(KMPDFN,DATA,0)),U)
 .S $P(@KMPDGBL@(0),U,(I+1))=TITLE
 ;
 S:KMPDSRC="*" KMPDSRC=""
 ; remove '*' if last character
 S:$E($RE(KMPDSRC))="*" $E(KMPDSRC,$L(KMPDSRC))=""
 S LN=1,NAME=KMPDSRC
 ; if exact match.
 I NAME]"" S IEN=$O(@GLOBAL@("B",NAME,0)) I IEN D 
 .Q:'$D(@GLOBAL@(IEN,0))  S DATA=^(0)
 .; ien.
 .S $P(@KMPDGBL@(LN),U)=IEN
 .; user defined data.
 .F I=1:1 S DATA=$P(KMPDFLD,",",I) Q:DATA=""  D 
 ..S $P(@KMPDGBL@(LN),U,(I+1))=$$GET1^DIQ(KMPDFN,IEN,DATA)
 .S LN=LN+1
 ;
 F  S NAME=$O(@GLOBAL@("B",NAME)) Q:NAME=""!($E(NAME,1,$L(KMPDSRC))'=KMPDSRC)  D 
 .F IEN=0:0 S IEN=$O(@GLOBAL@("B",NAME,IEN)) Q:'IEN  D 
 ..Q:'$D(@GLOBAL@(IEN,0))  S DATA=^(0)
 ..; ien.
 ..S $P(@KMPDGBL@(LN),U)=IEN
 ..; user defined data.
 ..F I=1:1 S DATA=$P(KMPDFLD,",",I) Q:DATA=""  D 
 ...S $P(@KMPDGBL@(LN),U,(I+1))=$$GET1^DIQ(KMPDFN,IEN,DATA)
 ..S LN=LN+1
 ;
 S KMPDY=$NA(@KMPDGBL)
 S:'$O(@KMPDGBL@(0)) @KMPDGBL@(1)="<No Data To Report>"
 ;
 Q
 ;
ENV(KMPDRES) ;-- get uci/volume set
 ;-----------------------------------------------------------------------
 ; KMPDRES(0)="uci,volumeset"
 ; KMPDRES(1)="facilityinfo" as returned by $$SITE^VASITE
 ;-----------------------------------------------------------------------
 ;
 K KMPDRES
 N Y X ^%ZOSF("UCI")
 S KMPDRES(0)=Y
 ;S KMPDRES(1)=$$SITE^VASITE
 ;
 Q
 ;
VERSION(KMPDY) ;-- version^patch info
 ; cm tools version^patch
 S KMPDY(0)=$P($G(^KMPD(8973,1,0)),U,2)
 ; operating system version
 S KMPDY(1)=$P($G(^%ZOSF("OS")),U)  ;$ZV
 ;
 Q
