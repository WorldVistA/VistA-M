ONCSAPIU ;Hines OIFO/SG - COLLABORATIVE STAGING (UTILITIES)  ; 12/7/06 9:08am
 ;;2.11;ONCOLOGY;**40,47**;Mar 07, 1995;Build 19
 ;
 Q
 ;
 ;***** RETURNS THE CS WEB-SERVICE URL
 ;
 ; Return values:
 ;       <0  Error Descriptor
 ;      ...  The CS URL
 ;
GETCSURL() ;
 N DIV,HOST,IEN,ONCMSG,PATH,PORT,RC,URL
 ;--- Try to get the URL from the site parameters
 S DIV=+$G(DUZ(2)),IEN=+$O(^ONCO(160.1,"C",DIV,""))
 I IEN'>0  S IEN=+$O(^ONCO(160.1,0))  Q:IEN'>0 $$ERROR^ONCSAPIE(-22)
 S URL=$$GET1^DIQ(160.1,IEN,19,,,"ONCMSG")
 Q:URL="" $$ERROR^ONCSAPIE(-22)
 ;--- Parse the URL and supply the missing parts
 S RC=$$PARSE^ONCXURL(URL,.HOST,.PORT,.PATH)
 Q:RC<0 $$ERROR^ONCSAPIE(-11,URL)
 S:$G(PORT)'>0 PORT=7005
 S:$G(PATH)="" PATH="/cgi-bin/CStage"
 ;--- Construct the resulting URL
 Q $$CREATE^ONCXURL(HOST,PORT,PATH)
 ;
 ;***** PAUSES THE OUTPUT AT PAGE END
 ;
 ; Return values:
 ;       -2  Timeout
 ;       -1  User entered a '^'
 ;        0  Continue
 ;
PAGE() ;
 I $E(IOST,1,2)'="C-"  S $Y=0  Q 0
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E"  D ^DIR  S $Y=0
 Q $S($D(DUOUT):-1,$D(DTOUT):-2,1:0)
 ;
 ;***** UPDATES THE CS WEB-SERVICE URL
 ;
 ; URL           New URL of the CS web-service
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor
 ;        0  Ok
 ;
UPDCSURL(URL) ;
 N IEN,IENS,ONCFDA,ONCMSG,RC
 Q:$G(URL)?." " $$ERROR^ONCSAPIE(-6,,"URL",$G(URL))
 ;--- Lock the ONCOLOGY SITE PARAMETERS file
 L +^ONCO(160.1):1  E  D  Q RC
 . S RC=$$ERROR^ONCSAPIE(-15,,"ONCOLOGY SITE PARAMETERS file")
 ;--- Update the record(s)
 S (IEN,RC)=0
 F  S IEN=$O(^ONCO(160.1,IEN))  Q:IEN'>0  D  Q:RC<0
 . S IENS=IEN_","  K ONCFDA,ONCMSG
 . S ONCFDA(160.1,IENS,19)=URL
 . D FILE^DIE(,"ONCFDA","ONCMSG")
 . S:$G(DIERR) RC=$$DBS^ONCSAPIE("ONCMSG",-9,160.1,IENS)
 ;--- Cleanup and error processing
 L -^ONCO(160.1)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** WRAPS THE STRING AND PRINTS IT
 ;
 ; X             Source string
 ; [DIWR]        Output width (IOM, by default)
 ;
WW(X,DIWR) ;
 N DIWF,DIWL,I,TMP
 S:$G(DIWR)'>0 DIWR=$G(IOM,80)
 K ^UTILITY($J,"W")
 ;--- Wrap the string
 S DIWL=1,DIWF="|"  D ^DIWP
 ;--- Print the text
 S I=""
 F  S I=$O(^UTILITY($J,"W",DIWL,I))  Q:I=""  D
 . S TMP=$G(^UTILITY($J,"W",DIWL,I,0))
 . D EN^DDIOL($$TRIM^XLFSTR(TMP,"R"))
 ;--- Cleanup
 K ^UTILITY($J,"W")
 Q
 ;
 ;***** EMULATES AND EXTENDS THE ZWRITE COMMAND :-)
 ;
 ; ROR8NODE      Closed root of the sub-tree to display
 ;               (either local array or global variable)
 ; [TITLE]       Title of the output
 ; [NONAME]      Do not print node names
 ;
ZW(ONC8NODE,TITLE,NONAME) ;
 Q:ONC8NODE=""  Q:'$D(@ONC8NODE)
 N FLT,L,PI  W !
 W:$G(TITLE)'="" TITLE,!!
 S NONAME=+$G(NONAME)
 W:$D(@ONC8NODE)#10 ONC8NODE_"="""_@ONC8NODE_"""",!
 S L=$L(ONC8NODE)  S:$E(ONC8NODE,L)=")" L=L-1
 S FLT=$E(ONC8NODE,1,L),PI=ONC8NODE
 F  S PI=$Q(@PI)  Q:$E(PI,1,L)'=FLT  D
 . W:'NONAME PI_"="  W """"_@PI_"""",!
 Q
