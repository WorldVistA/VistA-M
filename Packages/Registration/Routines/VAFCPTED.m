VAFCPTED ;ISA/RJS,Zoltan-EDIT EXISTING PATIENT ;4/15/22  16:30
 ;;5.3;Registration;**149,333,756,837,974,1059,1071**;Aug 13, 1993;Build 4
 ;
EDIT(DGDFN,ARRAY,STRNGDR) ;-- Edits existing patient
 ;Input:
 ;  DGDFN - IEN in the PATIENT (#2) file
 ;  ARRAY - Array containing fields to be edited.
 ;          Ex. ARRAY(.111)="123 STREET" or ARRAY(2,.111)="123...
 ;  STRNGDR - String of delimited PATIENT (#2) file fields in the order
 ;            in which the fields will be processed by DIE.
 ;            Ex. ".01;.03;.05..."
 ;Output:
 ;  No output
 ;
 S U="^"
 N LOCKFLE,FLD,ZTQUEUED,DIQUIET,VAFCX,STRNG
 S (ZTQUEUED,DIQUIET)=1
 L +^DPT(DGDFN):60
 S LOCKFLE=$T ; Need to remember whether the lock went through.
 ;process the given PATIENT file DR string in the given order
 S STRNG=STRNGDR F VAFCX=1:1 Q:STRNG=""  S FLD=$P(STRNGDR,";",VAFCX) S STRNG=$P(STRNGDR,";",VAFCX+1,$L(STRNGDR,";")) D LOAD
 ;
 ;Do Address Bulletin if incoming Address does not equal existing
 ;Address - removed bulletin with patch DG*5.3*333
 ;I $D(@ARRAY@(.111))!$D(@ARRAY@(.112))!$D(@ARRAY@(.113))!$D(@ARRAY@(.114))!$D(@ARRAY@(.115))!$D(@ARRAY@(.117))!$D(@ARRAY@(.1112)) D
 ;. D ADDRESS^RGRSBULL(DGDFN,$G(@ARRAY@(.01)),$G(@ARRAY@(.111)),$G(@ARRAY@(.112)),$G(@ARRAY@(.113)),@ARRAY@("SENDING SITE"),$G(@ARRAY@(.114)),$G(@ARRAY@(.117)),$G(@ARRAY@(.115)),$G(@ARRAY@(.1112)))
 ;
 I LOCKFLE L -^DPT(DGDFN)
 ;
 K DIE,DA
 Q
 ;
LOAD ; -- Loads fields to patient file
 N DR,DIE
 ;**756 check if updating ALIAS
 I FLD=1 D  Q
 . ;**974,Story 841921 (mko): If flag is not set, compare and update the Alias .01;
 . ;  If the flag is set, compare and update the Alias Name Components
 . I '$$GETFLAG D ALIAS Q
 . D ALIASNC(ARRAY,DGDFN,.RGER)
 ;**974,Story 841921 (mko): File name components
 I FLD=1.01 D  Q
 . N NAME
 . M NAME=@ARRAY@(1.01)
 . D UPDNC(DGDFN,.NAME)
 I FLD=.025 D UPDSEXOR(ARRAY,DGDFN,.RGER) Q  ;**1059, VAMPI-11114 (dri) file sexual orientation
 I FLD=.2406 D UPDPRON(ARRAY,DGDFN,.RGER) Q  ;**1059, VAMPI-11118 (dri) file pronoun
 S DA=DGDFN,DIE="^DPT("
 I $G(@ARRAY@(FLD))="" Q
 I $G(@ARRAY@(FLD))["@" S @ARRAY@(FLD)="@"
 I $G(@ARRAY@(FLD))[U Q
 S DR=FLD_"///^S X=$G(@ARRAY@(FLD))"
 D ^DIE
 Q
 ;
UPDNC(DGDFN,NAME) ;
 N FDA,IEN,MSG,DIERR
 ;Call updater to add or edit entry in Name Component file
 S FDA(20,"?+1,",.01)=2
 S FDA(20,"?+1,",.02)=.01
 S FDA(20,"?+1,",.03)=DGDFN_","
 S:$D(NAME("FAMILY"))#2 FDA(20,"?+1,",1)=NAME("FAMILY")
 S:$D(NAME("GIVEN"))#2 FDA(20,"?+1,",2)=NAME("GIVEN")
 S:$D(NAME("MIDDLE"))#2 FDA(20,"?+1,",3)=NAME("MIDDLE")
 S:$D(NAME("SUFFIX"))#2 FDA(20,"?+1,",5)=NAME("SUFFIX")
 D UPDATE^DIE("K","FDA","IEN","MSG")
 Q
 ;
ALIAS ;update Alias multiple **756
 ;allow the synchronizing of the Alias multiple with the data passed in the array
 ;array(1,x)=name (last, first middle suffix format)^ssn
 N HAVE,I,MIEN,ADD,DONE,FDA,MPIFERR,DEL,ALIAS,CNT,DGALIAS
 M HAVE=^DPT(DGDFN,.01)
 S CNT=0
 ;see if any need to be added
 S I=0 F  S I=$O(@ARRAY@(1,I)) Q:'I  D  ;loop through incoming data
 .S ADD=1,(DONE,MIEN)=0 F  S MIEN=$O(HAVE(MIEN)) Q:'MIEN  D  I DONE Q  ;loop through existing data
 ..I $P(@ARRAY@(1,I),"^",1,2)=$P($G(HAVE(MIEN,0)),"^",1,2) S ADD=0,DONE=1 Q  ;compare to existing data to see if already in subfile, if not then
 .I ADD S ALIAS=@ARRAY@(1,I) D  ;add new entry to subfile
 ..S FDA(2.01,"+"_I_","_DGDFN_",",.01)=$P(@ARRAY@(1,I),"^")
 ..S FDA(2.01,"+"_I_","_DGDFN_",",1)=$P(@ARRAY@(1,I),"^",2)
 I $D(FDA) D UPDATE^DIE("E","FDA",,"MPIFERR") I $G(MPIFERR("DIERR",1,"TEXT",1))'="" S RGER="-1^"_MPIFERR("DIERR",1,"TEXT",1)
 ;delete entries
 K FDA,MPIFERR
 S MIEN=0 F  S MIEN=$O(HAVE(MIEN)) Q:'MIEN  D  ;loop through existing data
 . ; **837,MVI_805 check for duplicates (name + ssn combination)
 . S HAVE=$P($G(HAVE(MIEN,0)),"^",1,2)
 . X $S(HAVE="":"",$D(DGALIAS(HAVE)):"S FDA(2.01,MIEN_"",""_DGDFN_"","",.01)=""@"" Q",1:"S DGALIAS(HAVE)=HAVE")
 . ;
 . S DEL=1,(DONE,I)=0 F  S I=$O(@ARRAY@(1,I)) Q:'I  D  I DONE Q  ;loop through incoming data
 . . I HAVE=$P(@ARRAY@(1,I),"^",1,2) S DEL=0,DONE=1 Q  ;compare to existing data to see if data should be deleted
 . I DEL S FDA(2.01,MIEN_","_DGDFN_",",.01)="@" ;existing entry to delete
 I $D(FDA) D FILE^DIE("E","FDA","MPIERR") I $G(MPIFERR("DIERR",1,"TEXT",1))'=""  S RGER="-1^"_MPIFERR("DIERR",1,"TEXT",1) ;delete entry
 Q
 ;
ALIASNC(ARRAY,DGDFN,RGER) ;Compare incoming Alias Name Components with existing Alias Name Components and add or delete as necessary
 ;**974,Story 841921 (mko): New subroutine
 N FDA,HAVE,IEN,IENROOT,IN,NC,NCIEN,NCIENS,ORIG,SEQ,SUB
 ;
 ;Create IN("surname^firstname^middlename^suffix^ssn",seq#)="" from incoming data
 S SEQ=0 F  S SEQ=$O(@ARRAY@(1,SEQ)) Q:'SEQ  D
 . S IN(@ARRAY@(1,SEQ,"NC")_"^"_$P(@ARRAY@(1,SEQ),"^",2),SEQ)=""
 ;
 ;Create ORIG("surname^firstname^middlename^suffix^ssn",subien)="" from existing data
 M HAVE=^DPT(DGDFN,.01)
 S IEN=0 F  S IEN=$O(HAVE(IEN)) Q:'IEN  D
 . S NCIEN=$P(HAVE(IEN,0),"^",3)
 . D:$P(HAVE(IEN,0),"^",3)>0
 .. S NC=$G(^VA(20,NCIEN,1))
 .. S SUB=$P(NC,"^",1,3)_"^"_$P(NC,"^",5)_"^"_$P(HAVE(IEN,0),"^",2)
 .. ;If this is a duplicate, set the FDA for deletion here
 .. S:$D(ORIG(SUB)) FDA(2.01,IEN_","_DGDFN_",",.01)="@"
 .. S ORIG(SUB,IEN)=""
 ;
 ;Loop through ORIG to delete Aliases that aren't in IN array
 S SUB="" F  S SUB=$O(ORIG(SUB)) Q:SUB=""  D
 . D:'$D(IN(SUB))
 .. S IEN=$O(ORIG(SUB,0)) Q:'IEN
 .. S FDA(2.01,IEN_","_DGDFN_",",.01)="@"
 D:$D(FDA)
 . D FILE^DIE("E","FDA","MSG") K FDA
 . I $G(DIERR) S RGER="-1^"_$$BLDERR("MSG") K MSG
 ;
 ;Loop through IN and add Aliases that aren't in ORIG array; we need to add the Alias, before the Name Components entry can be updated
 S SUB="" F  S SUB=$O(IN(SUB)) Q:SUB=""  D
 . D:'$D(ORIG(SUB))
 .. S SEQ=$O(IN(SUB,0))
 .. S FDA(2.01,"+"_SEQ_","_DGDFN_",",.01)=$$FMTNAME(@ARRAY@(1,SEQ,"NC"))
 .. S FDA(2.01,"+"_SEQ_","_DGDFN_",",1)=$P(@ARRAY@(1,SEQ),"^",2)
 D:$D(FDA)
 . ;Add the Alias and Alias SSN
 . D UPDATE^DIE("E","FDA","IENROOT","MSG") K FDA
 . I $G(DIERR) S RGER="-1^"_$$BLDERR("MSG") K MSG
 . ;For each Alias added, update the corresponding Name Components entry
 . S SEQ=0 F  S SEQ=$O(IENROOT(SEQ)) Q:'SEQ  D
 .. S IEN=$G(IENROOT(SEQ)) Q:IEN'>0
 .. S NCIENS=$P($G(^DPT(DGDFN,.01,IEN,0)),"^",3)_"," Q:'NCIENS
 .. S NC=$G(@ARRAY@(1,SEQ,"NC"))
 .. S FDA(20,NCIENS,1)=$P(NC,"^")
 .. S FDA(20,NCIENS,2)=$P(NC,"^",2)
 .. S FDA(20,NCIENS,3)=$P(NC,"^",3)
 .. S FDA(20,NCIENS,5)=$P(NC,"^",4)
 .. D FILE^DIE("E","FDA","MSG") K FDA
 .. I $G(DIERR) S RGER="-1^"_$$BLDERR("MSG") K MSG
 Q
 ;
BLDERR(MSGROOT) ;Build an error from the error message array
 ;**974,Story 841921 (mko): New subroutine
 N ERRARR,ERRMSG,I
 D MSG^DIALOG("AE",.ERRARR,"","",MSGROOT)
 S ERRMSG="",I=0 F  S I=$O(ERRARR(I)) Q:'I  S ERRMSG=ERRMSG_$S(ERRMSG]"":" ",1:"")_$G(ERRARR(I))
 Q ERRMSG
 ;
FMTNAME(ARRAY,LEN) ;Return a formatted name from cleaned Name Components that doesn't exceed LEN characters in length.
 ;**974,Story 841921 (mko): New function (duplicate of FMTNAME^RGADTP3)
 N NC
 S:'$G(LEN) LEN=30
 ;
 ;If ARRAY is passed as a string and doesn't have descendants assume it equals "surname^first^middle^suffix"
 D:$D(ARRAY)=1
 . S ARRAY("SURNAME")=$P(ARRAY,"^")
 . S ARRAY("FIRST")=$P(ARRAY,"^",2)
 . S ARRAY("MIDDLE")=$P(ARRAY,"^",3)
 . S ARRAY("SUFFIX")=$P(ARRAY,"^",4)
 ;
 ;Clean the components
 S NC("FAMILY")=$$CLEANC^XLFNAME($G(ARRAY("SURNAME")))
 S NC("GIVEN")=$$CLEANC^XLFNAME($G(ARRAY("FIRST")))
 S NC("MIDDLE")=$$CLEANC^XLFNAME($G(ARRAY("MIDDLE")))
 S NC("SUFFIX")=$$CLEANC^XLFNAME($G(ARRAY("SUFFIX")))
 ;
 ;Build a full name, maximum length LEN
 Q $$NAMEFMT^XLFNAME(.NC,"F","CL"_LEN)
 ;
GETFLAG() ;Get the value of the name components flag
 ;**974,Story 841921 (mko): New function
 I $T(GETFLAG^MPIFNAMC)]"" Q $$GETFLAG^MPIFNAMC
 Q 0
 ;
UPDSEXOR(ARRAY,DGDFN,RGER) ;**1059, VAMPI-11114 (dri) compare incoming sexual orientation multiple with existing and add/update
 ;**1071 VAMPI-13755 (dri) - include status, date created, date last updated to compare and file
 ;  Input:
 ;    ARRAY = ARAY(2)
 ;    ARAY(2,.025,n) = sexual orientation code ^ status ^ date created ^ date last update
 ;    DGDFN = patient's dfn
 ;
 ;  Example:
 ;    ARAY(2,.025,1)="CND^I^3220128^3220128"
 ;    ARAY(2,.025,2)="DTK^E^3220128^3220128"
 ;    ARAY(2,.025,3)="OTH^A^3220128^3220128"
 ;
 N CUR,FDA,I,INC,SOCODE,SOIEN,VAFCERR
 I $G(@ARRAY@(.025,1))["@" S @ARRAY@(.025,1)="@" ;change "@" to @, since no so's received in obx's delete all so's at the vista
 I $G(@ARRAY@(.025,1))'="@" S I=0 F  S I=$O(@ARRAY@(.025,I)) Q:'I  S SOCODE=$P($G(@ARRAY@(.025,I)),"^",1) I SOCODE'="",(SOCODE'["@"),(SOCODE'="""""") S INC(SOCODE)=I ;incoming so's
 S I=0 F  S I=$O(^DPT(DGDFN,.025,I)) Q:'I  S SOIEN=+$P($G(^(I,0)),"^",1),SOCODE=$P($G(^DG(47.77,SOIEN,0)),"^",2) I SOCODE'="" S CUR(SOCODE)=I ;current so's at vista
 ;
 ;loop through incoming sexual orientations and add/update
 S SOCODE="" F  S SOCODE=$O(INC(SOCODE)) Q:SOCODE=""  D
 .I '$D(CUR(SOCODE)) D  Q  ;an add to vista
 ..F I=1:1:4 S FDA(2.025,"+"_INC(SOCODE)_","_DGDFN_",",I*.01)=$P($G(@ARRAY@(.025,INC(SOCODE))),"^",I)
 ..S FDA(2.025,"+"_INC(SOCODE)_","_DGDFN_",",.06)="R" ;since this entry is new to vista and via hl7 it came from somewhere else, type of update is 'R'emote
 .;
 .I $D(CUR(SOCODE)) D  ;an update to vista if something changed
 ..F I=2:1:4 I $P($G(@ARRAY@(.025,INC(SOCODE))),"^",I)'=$P($G(^DPT(DGDFN,.025,CUR(SOCODE),0)),"^",I) D
 ...S FDA(2.025,CUR(SOCODE)_","_DGDFN_",",I*.01)=$P($G(@ARRAY@(.025,INC(SOCODE))),"^",I)
 ...;S FDA(2.025,CUR(SOCODE)_","_DGDFN_",",.05)="@"
 ...S FDA(2.025,CUR(SOCODE)_","_DGDFN_",",.06)="R" ;since this entry is being modified via hl7 it came from somewhere else, note is deleted and type of update is 'R'emote
 ;
 ;loop through vista and delete if not in incoming so's
 S SOCODE="" F  S SOCODE=$O(CUR(SOCODE)) Q:SOCODE=""  I '$D(INC(SOCODE)) S FDA(2.025,CUR(SOCODE)_","_DGDFN_",",.01)="@"
 ;
 I $D(FDA) D UPDATE^DIE("E","FDA",,"VAFCERR") I $G(VAFCERR("DIERR",1,"TEXT",1))'="" S RGER="-1^"_VAFCERR("DIERR",1,"TEXT",1)
 Q
 ;
UPDPRON(ARRAY,DGDFN,RGER) ;**1059, VAMPI-11118 (dri) compare incoming pronoun multiple with existing and add/update
 ;  Input:
 ;    ARRAY = ARAY(2)
 ;    ARAY(2,.2406,n) = pronoun code
 ;    DGDFN = patient's dfn
 ;
 ;  Example:
 ;    ARAY(2,.2406,1)="OTH"
 ;    ARAY(2,.2406,2)="PTN"
 ;
 N CUR,FDA,I,INC,PRCODE,PRIEN,VAFCERR
 I $G(@ARRAY@(.2406,1))["@" S @ARRAY@(.2406,1)="@" ;change "@" to @, since no pronouns received in obx's delete all pronouns at the vista
 I $G(@ARRAY@(.2406,1))'="@" S I=0 F  S I=$O(@ARRAY@(.2406,I)) Q:'I  S PRCODE=$P($G(@ARRAY@(.2406,I)),"^",1) I PRCODE'="",(PRCODE'["@"),(PRCODE'="""""") S INC(PRCODE)=I ;incoming pronouns
 S I=0 F  S I=$O(^DPT(DGDFN,.2406,I)) Q:'I  S PRIEN=+$P($G(^(I,0)),"^",1),PRCODE=$P($G(^DG(47.78,PRIEN,0)),"^",2) I PRCODE'="" S CUR(PRCODE)=I ;current pronouns at vista
 ;
 ;loop through incoming pronoun's and add if not in vista
 S PRCODE="" F  S PRCODE=$O(INC(PRCODE)) Q:PRCODE=""  I '$D(CUR(PRCODE)) S FDA(2.2406,"+"_INC(PRCODE)_","_DGDFN_",",.01)=PRCODE
 ;
 ;loop through vista and delete if not in incoming pronouns
 S PRCODE="" F  S PRCODE=$O(CUR(PRCODE)) Q:PRCODE=""  I '$D(INC(PRCODE)) S FDA(2.2406,CUR(PRCODE)_","_DGDFN_",",.01)="@"
 ;
 I $D(FDA) D UPDATE^DIE("E","FDA",,"VAFCERR") I $G(VAFCERR("DIERR",1,"TEXT",1))'="" S RGER="-1^"_VAFCERR("DIERR",1,"TEXT",1)
 Q
 ;
