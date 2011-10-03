TIUSRVT1 ; SLC/JER - Server calls for Templates ; 7/16/2001
 ;;1.0;TEXT INTEGRATION UTILITIES;**76,102,105,119**;Jun 20, 1997
SETXT0(TIUDA,FLD) ; Set the root node of the "TEMP" WP-field
 N TIUC,TIUI S (TIUC,TIUI)=0
 I '+$G(FLD) S FLD=2
 F  S TIUI=$O(^TIU(8927,TIUDA,FLD,TIUI)) Q:+TIUI'>0  D
 . S:$D(^TIU(8927,TIUDA,FLD,TIUI,0)) TIUC=TIUC+1
 S ^TIU(8927,TIUDA,FLD,0)="^^"_TIUC_U_TIUC_U_DT_"^^"
 Q
FILE(SUCCESS,IENS,TIUX) ; Call FM Filer to commit updates to DB
 N FDA,FDARR,FLAGS,TIUMSG
 S FDARR="FDA(8927,"_IENS_")",FLAGS="K"
 M @FDARR=TIUX
 D FILE^DIE(FLAGS,"FDA","TIUMSG") ; File record
 I $D(TIUMSG)>9 S SUCCESS=0_U_$G(TIUMSG("DIERR",1,"TEXT",1)) Q
 Q
UPDATE(SUCCESS,IENS,TIUX) ; Call FM Filer to commit updates to DB
 N FDA,FDARR,FLAGS,TIUMSG,TIUIENS
 S FDARR="FDA(8927.03,"_IENS_")",FLAGS=""
 M @FDARR=TIUX
 D UPDATE^DIE(FLAGS,"FDA","TIUIENS","TIUMSG") ; File record
 I $D(TIUMSG)>9 S SUCCESS=0_U_$G(TIUMSG("DIERR",1,"TEXT",1)) Q
 Q
CLPAC() ; Get pointer to CLINICAL COORDINATOR User Class
 N TIUY
 S TIUY=$O(^USR(8930,"B","CLINICAL COORDINATOR",0))
 Q TIUY
 ;
LONGLIST(Y,FROM,DIR) ; Long list of titles with boilerplate
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,DA,CNT,TIUD0
 S I=0,CNT=44,DIR=$G(DIR,1)
 F  Q:I'<CNT  S FROM=$O(^TIU(8925.1,"B",FROM),DIR) Q:FROM=""  D
 . S DA=0
 . F  Q:I'<CNT  S DA=$O(^TIU(8925.1,"B",FROM,DA)) Q:+DA'>0  D
 . . S TIUD0=$G(^TIU(8925.1,DA,0))
 . . I +$P(TIUD0,U,7)'=11 Q  ; Only allow Active Entries
 . . I $P(TIUD0,U,4)'="DOC" Q  ; Only allow TITLES
 . . ; Quit if no Boilerplate Text is present
 . . I '+$O(^TIU(8925.1,DA,"DFLT",0)) Q
 . . I $S(+$$CANENTR^TIULP(DA)'>0:1,+$$CANPICK^TIULP(DA)'>0:1,1:0) Q
 . . S I=I+1,Y(I)=DA_"^"_FROM
 Q
TITLEBP(Y,IEN) ; Returns a Titles Boilerplate
 Q:+$G(IEN)'>0
 N I,IDX
 S (I,IDX)=0
 F  S IDX=$O(^TIU(8925.1,IEN,"DFLT",IDX)) Q:+IDX=0  D
 .S I=I+1
 .S Y(I)=^TIU(8925.1,IEN,"DFLT",IDX,0)
 Q
GETDESC(TIUY,TIUDA) ;Returns Template Description
 I (TIUDA>0),$D(^TIU(8927,TIUDA,5)) D
 .N IDX,CNT S (IDX,CNT)=0
 .F  S IDX=$O(^TIU(8927,TIUDA,5,IDX)) Q:IDX'>0  D
 ..S CNT=CNT+1,TIUY(CNT)=^TIU(8927,TIUDA,5,IDX,0)
 Q
CLSLIST(ORY,FROM,DIR)    ; Long List of Active User Classes
 N I,IEN,CNT S I=0,CNT=44
 F  Q:(I'<CNT)  S FROM=$O(^USR(8930,"B",FROM),DIR) Q:(FROM="")  D
 . S IEN=$O(^USR(8930,"B",FROM,0)) I $P(^USR(8930,IEN,0),U,3)="0" Q
 . S I=I+1,ORY(I)=IEN_"^"_FROM
 Q
USERINFO(ORY,USER) ; Returns List of User Divisions and ASU Classes
 N TIUI,I,IDX,IEN,TIUERR,SRV
 S I=0,IDX=1
 F  S I=$O(^VA(200,USER,2,I)) Q:'I  D
 . I USER=DUZ,I=DUZ(2) S ORY(1)="D^"_I
 . E  S IDX=IDX+1,ORY(IDX)="D^"_I
 S TIUI=""
 F  S TIUI=$O(^USR(8930,"B",TIUI)) Q:(TIUI="")  D
 . S IEN=$O(^USR(8930,"B",TIUI,0))
 . I $P(^USR(8930,IEN,0),U,3)="0" Q
 . I '$$ISA^USRLM(USER,IEN,.TIUERR) Q
 . S IDX=IDX+1,ORY(IDX)="C^"_IEN
 S SRV=$P($G(^VA(200,USER,5)),U)
 I +SRV S IDX=IDX+1,ORY(IDX)="S^"_SRV
 Q
GETLINK(ORY,LINK) ; Returns template linked to title or reason for request
 N IDX
 S ORY="",IDX=$O(^TIU(8927,"AL",LINK,0))
 I +IDX,$P($G(^TIU(8927,IDX,0)),U,4)'="I" S ORY=$$NODEDATA^TIUSRVT(IDX)
 Q
TITLELST(Y,FROM,DIR) ; Long list of titles
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,DA,CNT,TIUD0
 S I=0,CNT=44,DIR=$G(DIR,1)
 F  Q:I'<CNT  S FROM=$O(^TIU(8925.1,"B",FROM),DIR) Q:FROM=""  D
 . S DA=0
 . F  Q:I'<CNT  S DA=$O(^TIU(8925.1,"B",FROM,DA)) Q:+DA'>0  D
 . . S TIUD0=$G(^TIU(8925.1,DA,0))
 . . I +$P(TIUD0,U,7)'=11 Q  ; Only allow Active Entries
 . . I $P(TIUD0,U,4)'="DOC" Q  ; Only allow TITLES
 . . S I=I+1,Y(I)=DA_"^"_FROM
 Q
