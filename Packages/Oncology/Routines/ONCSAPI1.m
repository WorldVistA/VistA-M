ONCSAPI1 ;Hines OIFO/SG - COLLABORATIVE STAGING (DD TOOLS) ;06/23/10
 ;;2.11;ONCOLOGY;**40,41,47,51**;Mar 07, 1995;Build 65
 ;
 Q
 ;
 ;***** DISPLAYS THE ERRORS
ERRORS(MODE,ERRCODE) ;
 S ERRCODE=+$G(ERRCODE)
 ;--- Display the explanations (for the user)
 I MODE="HLP"  D:(ERRCODE=-10)
 . D ERROR^ONCSAPIE(-19,"Please try later.")
 E  I MODE="INP"  D:(ERRCODE'=-2)
 . D ERROR^ONCSAPIE(-20,"Please inform IRM about the problem.")
 E  I MODE="CDN"  D:(ERRCODE=-10)
 . D ERROR^ONCSAPIE(-21,"Please try later.")
 ;--- Display the error stack (for the IRM)
 D PRTERRS^ONCSAPIE()
 Q
 ;
 ;***** DISPLAYS THE HELP FOR A FIELD
 ;
 ; TABLE         Table number (see the ^ONCSAPI routine)
 ;
 ; [IEN]         IEN of the record in the file #165.5
 ;
 ; [SITE]        Primary site
 ; [HIST]        Histology
 ;
 ; Either the IEN or both the SITE and HIST must be provided.
 ;
HELP(TABLE,IEN,SITE,HIST) ;
 N DISCRIM,EXIT,I,MNL,NODE,NOTE,ONCMSG,ONCSAPI,RC,ROW,SHNS,TBLIEN,TMP
 S SHNS=$S($G(X)="":1,1:X="??")
 D CLEAR^ONCSAPIE(1)
 D:$G(IEN)>0
 . S SITE=$TR($$GET1^DIQ(165.5,IEN,20.1,,,"ONCMSG"),".")
 . S HIST=$E($$HIST^ONCFUNC(IEN),1,4)
 . S DISCRIM=$$GET1^DIQ(165.5,IEN,240)
 I ($G(SITE)="")&($G(HIST)="")  D  Q
 . S TMP=""
 . S:$D(IEN)#10 TMP=TMP_", IEN="_IEN
 . S:$D(SITE)#10 TMP=TMP_", SITE="_SITE
 . S:$D(HIST)#10 TMP=TMP_", HIST="_HIST
 . S TMP=$P(TMP,", ",2,999)
 . D PRTERRS^ONCSAPIE($$ERROR^ONCSAPIE(-16,TMP,"IEN, SITE, HIST"))
 ;---
 L +^XTMP("ONCSAPI","TABLES","JOB",$J):5  E  D  Q
 . D ERROR^ONCSAPIE(-15,,"access control node")
 . D ERRORS("HLP")
 ;
 S RC=0  D
 . ;--- Get the table IEN
 . S TBLIEN=$$GETCSTBL^ONCSAPIT(.ONCSAPI,SITE,HIST,TABLE)
 . I TBLIEN<0  S RC=TBLIEN  Q
 . ;--- Initialize constants and variables
 . S NODE=$NA(^XTMP("ONCSAPI","TABLES",TBLIEN))
 . S MNL=$S($G(IOSL)>3:IOSL-3,1:20),$Y=0
 . ;--- Display the title and optional subtitle
 . S TMP=$G(@NODE@(0))
 . D WW^ONCSAPIU($P(TMP,U,5))
 . D:$P(TMP,U,6)'="" WW^ONCSAPIU($P(TMP,U,6))
 . ;--- Display top notes
 . I SHNS  D  I $Y'<MNL  S EXIT=$$PAGE^ONCSAPIU()  Q:EXIT
 . . S (EXIT,NOTE)=0
 . . F  S NOTE=$O(@NODE@("TN",NOTE))  Q:NOTE'>0  D  Q:EXIT
 . . . D EN^DDIOL(" ")
 . . . I $Y'<MNL  S EXIT=$$PAGE^ONCSAPIU()  Q:EXIT
 . . . S I=0
 . . . F  S I=$O(@NODE@("TN",NOTE,I))  Q:I'>0  D  Q:EXIT
 . . . . D EN^DDIOL(@NODE@("TN",NOTE,I))
 . . . . S:$Y'<MNL EXIT=$$PAGE^ONCSAPIU()
 . ;--- Display the table
 . D EN^DDIOL(" ")
 . S (EXIT,ROW)=0
 . F  S ROW=$O(@NODE@(ROW))  Q:ROW'>0  D  Q:EXIT
 . . D EN^DDIOL($J($P(@NODE@(ROW,1),U),7))
 . . D:$D(@NODE@(ROW,3,1)) EN^DDIOL(@NODE@(ROW,3,1),,"?9")
 . . I $Y'<MNL  S EXIT=$$PAGE^ONCSAPIU()  Q:EXIT
 . . S I=1
 . . F  S I=$O(@NODE@(ROW,3,I))  Q:I=""  D  Q:EXIT
 . . . D EN^DDIOL(@NODE@(ROW,3,I),,"!?9")
 . . . S:$Y'<MNL EXIT=$$PAGE^ONCSAPIU()
 . ;--- Display footnotes
 . I SHNS  D  I $Y'<MNL  S EXIT=$$PAGE^ONCSAPIU()  Q:EXIT
 . . S (EXIT,NOTE)=0
 . . F  S NOTE=$O(@NODE@("FN",NOTE))  Q:NOTE'>0  D  Q:EXIT
 . . . D EN^DDIOL(" ")
 . . . I $Y'<MNL  S EXIT=$$PAGE^ONCSAPIU()  Q:EXIT
 . . . S I=0
 . . . F  S I=$O(@NODE@("FN",NOTE,I))  Q:I'>0  D  Q:EXIT
 . . . . D EN^DDIOL(@NODE@("FN",NOTE,I))
 . . . . S:$Y'<MNL EXIT=$$PAGE^ONCSAPIU()
 . . D EN^DDIOL(" ")
 ;
 L -^XTMP("ONCSAPI","TABLES","JOB",$J)
 D:RC<0 ERRORS("HLP",RC)
 Q
 ;
 ;***** VALIDATES AND TRANSFORMS THE INPUT (CODES)
 ;
 ; X             Input value should be assigned to the X local
 ;               variable before calling this procedure. The
 ;               variable is KILL'ed if it has an invalid value.
 ;
 ; TABLE         Table number (see the ^ONCSAPI routine)
 ;
 ; CODELEN       Valid length of the code
 ;
 ; [IEN]         IEN of the record in the file #165.5
 ;
 ; [SITE]        Primary site
 ; [HIST]        Histology
 ;
 ; [SILENT]      Silent mode flags (can be combined):
 ;                 D  Do not display code description
 ;                 E  Do not display error messages
 ;
 ; Either the IEN or both the SITE and HIST must be provided.
 ;
INPUT(TABLE,CODELEN,IEN,SITE,HIST,SILENT) ;
 N CODE,ONCBUF,ONCSAPI,RC,TBLIEN,TMP
 S X=$$TRIM^XLFSTR($G(X))
 I X'?@(CODELEN_"N")  K X  Q
 S:'($D(SILENT)#10) SILENT=$S($G(DIUTIL)="VERIFY FIELDS":"DE",1:"")
 D CLEAR^ONCSAPIE(1)
 ;---
 D:$G(IEN)>0
 . S SITE=$TR($$GET1^DIQ(165.5,IEN,20.1,,,"ONCMSG"),".")
 . S HIST=$E($$HIST^ONCFUNC(IEN),1,4)
 . S DISCRIM=$$GET1^DIQ(165.5,IEN,240)
 I ($G(SITE)="")&($G(HIST)="")  D  K X  Q
 . D PRTERRS^ONCSAPIE($$ERROR^ONCSAPIE(-16,,"IEN, SITE, HIST"))
 ;---
 L +^XTMP("ONCSAPI","TABLES","JOB",$J):5  E  D  K X  Q
 . D ERROR^ONCSAPIE(-15,,"access control node")
 . D ERRORS("INP")
 ;
 S RC=0  D
 . ;--- Get the table IEN
 . S TBLIEN=$$GETCSTBL^ONCSAPIT(.ONCSAPI,SITE,HIST,TABLE)
 . I TBLIEN<0  S RC=TBLIEN  Q
 . ;--- Check the single code
 . S CODE=+$G(X)
 . Q:$D(^XTMP("ONCSAPI","TABLES",TBLIEN,"C",CODE))
 . ;--- Check the interval
 . S TMP=$O(^XTMP("ONCSAPI","TABLES",TBLIEN,"C",CODE),-1)
 . I TMP'=""  D  Q:CODE'>$P(TMP,U,2)
 . . S TMP=$G(^XTMP("ONCSAPI","TABLES",TBLIEN,"C",TMP))
 . ;--- Invalid value
 . K X
 ;
 I $D(X)&(RC'<0)  D:SILENT'["D"
 . Q:$$CODEDESC^ONCSAPIT(.ONCSAPI,SITE,HIST,TABLE,X,"ONCBUF")<0
 . I ONCBUF(1)["OBSOLETE" K X  W " OBSOLETE code" Q 
 . S TMP=""
 . F  S TMP=$O(ONCBUF(TMP))  Q:TMP=""  S ONCBUF(TMP,"F")="!?2"
 . D EN^DDIOL(.ONCBUF),EN^DDIOL(" ")
 ;
 L -^XTMP("ONCSAPI","TABLES","JOB",$J)
 I RC<0  D:SILENT'["E" ERRORS("INP",RC)  K X
 Q
 ;
CLEANUP ;Cleanup
 K DIUTIL
