LRUTIL3 ;DALOI/JDB - Lab Utilities ;11/04/11  11:07
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;CREATE^XUSAP/4677
 Q
 ;
FMERR(ERR,RTN,FDA,TXT,CONFIG,QUIET,MORE,HOOK) ;
 ; Process a FileMan filing error.
 ; Stores info into ^TMP(TMPNM,$J,timestamp:seq)
 ; Purges existing ^TMP entries as needed.
 ; Displays FM error text and additional text.
 ; Inputs
 ;    ERR: Name of FileMan error array.
 ;    RTN:<opt> Routine info (ie TAG^RTN).
 ;    FDA:<opt> Name of FileMan FDA array.
 ;    TXT:<byref><opt> Additional error message text.
 ;       :  TXT(0) used to indicate if text should be placed above
 ;       :  or below the FileMan error text. (0=above<dflt>  1=below)
 ; CONFIG:<byref><opt> Array for additional config info.
 ;       :  CONFIG("CJ"):<opt> Center Justify? 1=yes  0=no <dflt=0>
 ;       :  CONFIG("LM"):<opt> Left Margin <dflt=1>
 ;  QUIET:<opt> 1=no screen display  0=Display  <dflt=0>
 ;  MORE:<opt> Display "MORE" prompt  0=no  1=yes  <dflt=0>
 ;  HOOK:<opt> Executable code to add custom functionality.
 ;
 N NOW,ERRNUM,ZZZFMERR,ZZZMSG,TXTPOS,X,I,FMT,DIERR,TMPNM
 S ERR=$G(ERR)
 S RTN=$G(RTN)
 S FDA=$G(FDA)
 S QUIET=$G(QUIET)
 S MORE=$G(MORE)
 S HOOK=$G(HOOK)
 Q:ERR=""
 Q:'$D(@ERR) 0
 S TMPNM="LRUTIL3-FMERR"
 S NOW=$$NOW^XLFDT()
 ; remove entries older than 1 day
 S I=""
 F  S I=$O(^TMP(TMPNM,$J,I)) Q:'I  D  ;
 . S X=$P(I,":",1)
 . I $$FMDIFF^XLFDT(X,NOW,1)'>1 Q
 . K ^TMP(TMPNM,$J,I)
 ;
 ; add sequence # to end of timestamp
 S ERRNUM=$$NOW^XLFDT()_":0"
 ; increment sequence # if needed
 I $D(^TMP(TMPNM,$J,ERRNUM)) D  ;
 . S X=$P(ERRNUM,":",2)
 . S X=X+1
 . S ERRNUM=$P(ERRNUM,":",1)_":"_X
 ;
 D MSG^DIALOG("AEHMS",.ZZZFMERR,"","",ERR)
 Q:'$D(ZZZFMERR) 0
 S ^TMP(TMPNM,$J,ERRNUM,0)=NOW_"^"_DUZ
 I RTN'="" S ^TMP(TMPNM,$J,ERRNUM,1)=RTN
 M ^TMP(TMPNM,$J,ERRNUM,"FDA")=@FDA
 M ^TMP(TMPNM,$J,ERRNUM,"ERR")=@ERR
 S X=RTN
 D ADDNODE(.ZZZMSG,"A FileMan error occurred"_$S(X'="":" in "_X,1:"")_":")
 S TXTPOS=$G(TXT(0))
 S TXTPOS=$S(TXTPOS=1:1,1:0)
 I 'TXTPOS D ADDNODE(.ZZZMSG,.TXT) S ZZZMSG(1,"F")="$C(7),!!"
 K FMT S FMT(1)="!,$C(32,32,32,32)"
 D ADDNODE(.ZZZMSG,.ZZZFMERR,.FMT)
 K FMT S FMT(0)="!!"
 D ADDNODE(.ZZZMSG,"More info available in ^TMP("""_TMPNM_""","_$J_")",.FMT)
 I TXTPOS D ADDNODE(.ZZZMSG,.TXT) S ZZZMSG(1,"F")="$C(7),!!"
 I '$D(XPDNM) I 'QUIET D EN^DDIOL(.ZZZMSG)
 I $D(XPDNM) I 'QUIET D
 . D BMES^XPDUTL(" ")
 . D MES^LRUTIL2(.ZZZMSG,$G(CONFIG("CJ")),$G(CONFIG("LM")))
 ;
 K ZZZMSG,TXT
 I HOOK'="" X HOOK
 ; Display any text added by external call
 I $D(ZZZMSG) D  ;
 . Q:QUIET
 . I '$D(XPDNM) D EN^DDIOL(.ZZZMSG)
 . I $D(XPDNM) D MES^LRUTIL2(.ZZZMSG,$G(CONFIG("CJ")),$G(CONFIG("LM")))
 ;
 I 'QUIET I MORE D MORE^LRUTIL($$TRIM^XLFSTR($$CJ^XLFSTR("Press 'ENTER' to continue",$G(IOM,80)," "),"R"," "),1)
 Q ERRNUM
 ;
ADDNODE(ARR,TXT,FMT) ;
 ; Private helper method for FMERR above.
 ; Kills the FMT array when done.
 ; Inputs
 ;  ARR:<byref> Target array (See Outputs)
 ;  TXT:<byval><byref> Text to add to target array.
 ;  FMT:<byref><opt> Format array
 ;     :  FMT(1)="!!"
 ; Outputs
 ;  ARR: The modified array.
 N I,J
 I $G(TXT)'="" D  ;
 . S J=$O(ARR("A"),-1)+1
 . S ARR(J)=TXT
 . I $D(FMT(0)) S ARR(J,"F")=FMT(0)
 ;
 S I=0
 F  S I=$O(TXT(I)) Q:'I  D  ;
 . S J=$O(ARR("A"),-1)+1
 . S ARR(J)=TXT(I)
 . I $D(FMT(I)) S ARR(J,"F")=FMT(I)
 K FMT
 Q
 ;
PRXYUSR(SUFFIX,CREATE) ;
 ;CREATE^XUSAP/4677
 ; Returns IEN of Lab Application Proxy (HL7, POC, TASKMAN) user.
 ; If Proxy user doesnt exist, will create.
 ; Inputs
 ;   SUFFIX:"LRLAB," suffix  ie HL7, POC, TASKMAN
 ;   CREATE:<opt> Create user when needed? 0=no 1=yes <dflt>=no
 ; Outputs
 ;  Returns the IEN of the proxy user or 0 with error code+message
 ;
 N IEN,DIC,DA,DIE,SUB,X,I,NAME,ISPRXY,R200
 N LRFDA,LRIEN,LRIENS,LRMSG,LRTARG,DIERR
 S SUFFIX=$G(SUFFIX)
 S CREATE=$G(CREATE)
 I "^HL^POC^TASKMAN^"'[("^"_SUFFIX_"^") Q "0^1^Invalid suffix."
 S NAME="LRLAB,"_SUFFIX
 ; Use FIND instead of FIND1 in case there's more than one entry
 ; so we avoid creating duplicate entries.
 K LRTARG,LRMSG,DIERR
 D FIND^DIC(200,"","@","X",NAME,"B",,,,"LRTARG","LRMSG")
 S X=$G(LRTARG("DILIST",0))
 S X=$P(X,"^",1) ;# of matches
 I 'X D  Q IEN
 . I 'CREATE S IEN="0^3^Create not enabled." Q
 . I "^LRLAB,HL^LRLAB,POC^LRLAB,TASKMAN^"'[("^"_NAME_"^") S IEN="0^4^Invalid proxy user" Q
 . S X=$$CREATE^XUSAP(NAME,"@",)
 . I X>0 S IEN=X Q
 . S IEN="0^5^$$CREATE error"
 ;
 ; Are any of the #200 matches set to "APP PROXY"
 S (I,IEN,ISPRXY)=0
 F  S I=$O(LRTARG("DILIST",2,I)) Q:'I  D  Q:ISPRXY  ;
 . N LRTARG2
 . S R200=LRTARG("DILIST",2,I)
 . K LRMSG,DIERR,LRTARG2
 . S X=","_R200_","
 . D FIND^DIC(200.07,X,"@","X","APPLICATION PROXY","B",,,,"LRTARG2","LRMSG")
 . S X=$G(LRTARG2("DILIST",0))
 . S X=$P(X,"^",1) ;# of matches
 . Q:'X
 . S (IEN,ISPRXY)=R200
 ;
 ; Sets #200 entry's field USER CLASS to "APPLICATION PROXY"
 ; File #200 update approved by Wally Fort (email 03/27/2006)
 I 'ISPRXY D  ;
 . K DIERR
 . S SUB="?+1,"_R200_","
 . S LRFDA(200.07,SUB,.01)="APPLICATION PROXY"
 . S LRFDA(200.07,SUB,2)=1
 . D UPDATE^DIE("E","LRFDA","LRIENS","LRMSG")
 . I $D(LRMSG) S IEN="0^2^Error while updating entry"
 Q IEN
