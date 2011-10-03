TIUPUTC ; SLC/JER - Document filer - captioned header ;5/20/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**3,21,81,100,113,112,173,184**;Jun 20, 1997
 ;
MAIN ; ---- Controls branching.
 ;      Attempts to file upload documents in the target file.
 ;      Requires DA = IEN of 8925.2 upload buffer entry.
 N TIUDA,TIUBGN,TIUI,TIUHSIG,TIULIM,TIULCNT,TIULINE,TIUREC,TIUPOST
 N TIUTYPE,TIUINST K ^TMP("TIUPUTC",$J)
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 S TIUHSIG=$P(TIUPRM0,U,10),TIUBGN=$P(TIUPRM0,U,12)
 I TIUHSIG']"" D MAIN^TIUPEVNT(DA,1,1) Q
 I TIUBGN']"" D MAIN^TIUPEVNT(DA,1,7) Q
 ; ---- Strip controls when kermit:
 I $P(TIUPRM0,U,17)="k" D PREPROC(DA)
 S TIUI=0 F  S TIUI=$O(^TIU(8925.2,+DA,"TEXT",TIUI)) Q:+TIUI'>0  D
 . S TIULINE=$G(^TIU(8925.2,+DA,"TEXT",TIUI,0))
 . I TIULINE[TIUHSIG D  Q
 . . ; ---- Hdr signal line.  GETREC^TIUPUTC1 resets TIUI to $TXT line:
 . . N TIUHDR,TIUFRST,TIUJ S TIUFRST=TIUI
 . . ; ---- If after first hdr signal, finish previous docmt
 . . ;      before going on w/ current docmt:
 . . I +$G(TIULCNT),$D(TIUREC("TROOT")),$D(@(TIUREC("TROOT")_"0)")) D FINISH
 . . K TIUREC D GETREC^TIUPUTC1(TIULINE,.TIUREC,.TIUHDR)
 . . I +$G(TIUREC("#"))'>0!($G(TIUREC("ROOT"))']"") Q
 . . D STUFREC(.TIUHDR,.TIUREC)
 . . S TIUREC("TROOT")=TIUREC("ROOT")_TIUREC("#")_","_TIUREC("TEXT")_","
 . . S:'$D(@(TIUREC("TROOT")_"0)")) @(TIUREC("TROOT")_"0)")="^^^^^"
 . . S TIULCNT=+$P(@(TIUREC("TROOT")_"0)"),U,4)
 . . F TIUJ=TIUFRST:1:TIUI D
 . . . ; ---- Delete header lines from buffer once filed;
 . . . ;      (TIUI was reset in GETREC^TIUPUTC1 to $TXT line):
 . . . K ^TIU(8925.2,+DA,"TEXT",TIUJ,0)
 . . I TIUREC("FILE")=8925,+$G(TIUREC("#")),+$G(TIUREC("BOILON")) D BOILRPLT(.TIUREC)
 . I TIULINE'[TIUHSIG,(TIULINE'[TIUBGN),(+$G(TIUREC("FILE"))=8925),+$G(TIUREC("BOILON")) D
 . . I TIULINE]"",$D(^TIU(8925.1,"B",$P(TIULINE,":"))) D  I 1
 . . . S TIULCNT=$$LOCATE(TIULINE,TIUREC("#"))
 . . E  S TIULCNT=+$G(TIULCNT)+.01
 . . S ^TIU(8925,+TIUREC("#"),"TEMP",TIULCNT,0)=TIULINE
 . . ; ---- Delete text line from buffer once xferred:
 . . K ^TIU(8925.2,+DA,"TEXT",TIUI,0)
 . I TIULINE'[TIUHSIG,(TIULINE'[TIUBGN),$D(TIUREC("TROOT")),$D(@(TIUREC("TROOT")_"0)")),(+$G(TIUREC("BOILON"))'>0) D
 . . S TIULCNT=+$G(TIULCNT)+1,@(TIUREC("TROOT")_TIULCNT_",0)")=TIULINE
 . . ; ---- Delete text line once xferred:
 . . K ^TIU(8925.2,+DA,"TEXT",TIUI,0)
 . . ; ---- Remove leading buffer garbage
 . I TIULINE'[TIUHSIG,(TIULINE'[TIUBGN),'$D(TIUREC("TROOT")),($G(TIUREC("#"))'=-1) K ^TIU(8925.2,+DA,"TEXT",TIUI,0)
 . I TIULINE[TIUBGN K ^TIU(8925.2,+DA,"TEXT",TIUI,0)
 ; ---- Finish last docmt in buffer file:
 I +$G(TIULCNT),$D(TIUREC("TROOT")),$D(@(TIUREC("TROOT")_"0)")) D FINISH
 I '+$O(^TIU(8925.2,+DA,"TEXT",0)) D BUFPURGE(DA)
 ; ---- Write upload results:
 I '$D(ZTQUEUED),$D(^TMP("TIUPUTC",$J)) D
 . W !!,"TOTALS FOR CURRENT BATCH:",!
 . W !?14,"TOTAL Document(s) RECEIVED: ",$J((+$G(^TMP("TIUPUTC",$J,"SUCC"))+$G(^("MISS"))+$G(^("FAIL"))),5),!
 . W !?18," Document(s) NOT FILED: ",$J(+$G(^TMP("TIUPUTC",$J,"FAIL")),5)
 . W !?3,"Document(s) FILED with MISSING FIELDS: ",$J(+$G(^TMP("TIUPUTC",$J,"MISS")),5),!
 K ^TMP("TIUPUTC",$J)
 Q
LOCATE(LINE,REC) ; ---- Locate line in boilerplate text
 N TIUJ,HIT,BTXT S (TIUJ,HIT)=0
 F  Q:+HIT  S TIUJ=$O(^TIU(8925,+REC,"TEMP",TIUJ)) Q:+TIUJ'>0!HIT  D
 . S BTXT=$G(^TIU(8925,+REC,"TEMP",TIUJ,0))
 . I BTXT[$P(LINE,":")_":" S HIT=1
 Q +$G(TIUJ)
 ;
STUFREC(HEADER,RECORD) ; ---- Stuffs record with known fixed fields;
 ;                      Checks for missing fields.
 N FDA,FDARR,IENS,FLAGS,TIUI,TIUMSG,TIUPC
 S IENS=""""_+RECORD("#")_","""
 S FDARR="FDA("_+RECORD("FILE")_","_IENS_")",FLAGS="KE"
 ; ---- Set up FDA Array:
 S TIUI=0
 F  S TIUI=$O(HEADER(TIUI)) Q:+TIUI'>0  D
 . ; if field is Author/Dictator and title is OPERATION REPORT, ignore uploaded data *173
 . I (TIUI=1202!(TIUI=1209)),TIUREC("TYPE")=$$CHKFILE^TIUADCL(8925.1,"OPERATION REPORT","I $P(^(0),U,4)=""DOC""") S @FDARR@(1303)="U" Q
 . S:TIUI'=.001 @FDARR@(TIUI)=$$TRNSFRM^TIULX(.RECORD,TIUI,HEADER(TIUI))
 I $D(FDA) D FILE^DIE(FLAGS,"FDA","TIUMSG")
 I $D(TIUMSG) D
 . ; ---- If FILE^DIC fails, log 8925.4 error w/ hdr info.  Create new
 . ;      8925.2 buffer entry with hdr, text, & 8925.4 log #.
 . ;      Kill most of old buffer. Send missing field alerts:
 . D MAIN^TIUPEVNT(DA,2,"",$P($G(^TIU(8925.1,+RECORD("TYPE"),0)),U),.FDA,.TIUMSG)
 . S ^TMP("TIUPUTC",$J,"MISS")=+$G(^TMP("TIUPUTC",$J,"MISS"))+1
 I '$D(TIUMSG) D
 . S ^TMP("TIUPUTC",$J,"SUCC")=+$G(^TMP("TIUPUTC",$J,"SUCC"))+1
 Q
BOILRPLT(TIUREC) ; ---- Execute/Interleave Boilerplates w/uploaded text
 N TIU
 D GETTIU^TIULD(.TIU,TIUREC("#"))
 D LOADDFLT^TIUEDI4(TIUREC("#"),TIUREC("TYPE")) ;100
 Q
SETROOT(LINECNT,RECORD) ; ---- Sets root of WP field
 S @(RECORD("TROOT")_"0)")="^^"_LINECNT_"^"_LINECNT_"^"_DT_"^^"
 Q
BUFPURGE(DA) ; ---- Call ^DIK to purge buffer record when all's well
 N DIK S DIK="^TIU(8925.2," D ^DIK
 Q
PREPROC(DA) ; ---- Strip controls & white space from headers
 N TIUI,TIUHLIN,X S (TIUI,TIUHLIN)=0
 F  S TIUI=$O(^TIU(8925.2,+DA,"TEXT",TIUI)) Q:+TIUI'>0  D
 . S X=$G(^TIU(8925.2,+DA,"TEXT",TIUI,0))
 . S:X[TIUHSIG TIUHLIN=1 S:X[TIUBGN TIUHLIN=0
 . S:TIUHLIN ^TIU(8925.2,+DA,"TEXT",TIUI,0)=$$STRIP^TIUUPLD(X)
 Q
DADTYPE(DA) ; ---- Get type of original document for addenda
 N TIUDAD,Y
 S TIUDAD=$P($G(^TIU(8925,DA,0)),U,6)
 S Y=+$G(^TIU(8925,+TIUDAD,0))
 Q Y
 ;
FINISH ; ---- Finish document: feedback, postfile code, merge boil,
 ;      log file event
 N ISADDNDM S ISADDNDM=0
 D SETROOT(TIULCNT,.TIUREC)
 S ISADDNDM=+$$ISADDNDM^TIULC1(TIUREC("#"))
 S TIUTYPE=$S(ISADDNDM:+$$DADTYPE(TIUREC("#")),1:TIUREC("TYPE"))
 I '$D(ZTQUEUED) W !,">>> ",$S(ISADDNDM:"Addendum",1:"Document")," Filed Successfully.",! ;TIU*1*81
 ; ---- TIU*1*81 Tell error handler that retrying filer was successful:
 S TIUDONE=1
 S TIUTYPE=$S(+$$ISADDNDM^TIULC1(TIUREC("#")):+$$DADTYPE(TIUREC("#")),1:TIUREC("TYPE"))
 S TIUPOST=$$POSTFILE^TIULC1(TIUTYPE)
 I TIUPOST]"" X TIUPOST K ^TMP("TIUPRFUP",$J)
 I TIUREC("FILE")=8925,+$G(TIUREC("BOILON")) D
 . N TIU D GETTIU^TIULD(.TIU,TIUREC("#"))
 . D MERGTEXT^TIUEDI1(TIUREC("#"),.TIU)
 . K ^TIU(8925,+TIUREC("#"),"TEMP")
 D MAIN^TIUPEVNT(DA,0,"",$P($G(^TIU(8925.1,+TIUREC("TYPE"),0)),U))
 Q
 ;
