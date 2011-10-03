TIUSRVF1 ; SLC/JM - Server calls for Template Fields ; 02/06/2002
 ;;1.0;TEXT INTEGRATION UTILITIES;**105,127,132**;Jun 20, 1997
ISUNIQUE(TIUY,NAME,IEN) ; Is Name Unique?
 N FLD
 S FLD=+$O(^TIU(8927.1,"B",NAME,0))
 I +FLD,FLD'=IEN S TIUY=0
 E  S TIUY=1
 Q
LOCK(TIUY,TIUDA) ; Lock Template Field
 L +^TIU(8927.1,TIUDA,0):1
 S TIUY=$T
 Q
UNLOCK(TIUY,TIUDA) ; Unlock Template Field
 L -^TIU(8927.1,TIUDA,0)
 S TIUY=1
 Q
DELETE(TIUY,TIUDA) ; Call ^DIK to remove a Template Field
 N DIK,DA
 S DA=+TIUDA
 D UNLOCK(.TIUY,.TIUDA)
 S DIK="^TIU(8927.1," D ^DIK
 S TIUY=1
 Q
LIST(Y,FROM,DIR)    ; Long list of Template Fields
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction
 N I,DA,CNT,TIUD0,NODE
 S I=0,CNT=80,DIR=$G(DIR,1)
 F  Q:I'<CNT  S FROM=$O(^TIU(8927.1,"B",FROM),DIR) Q:FROM=""  D
 . S DA=0
 . F  Q:I'<CNT  S DA=$O(^TIU(8927.1,"B",FROM,DA)) Q:+DA'>0  D
 .. S I=I+1,Y(I)=DA_U_FROM
 .. S NODE=$G(^TIU(8927.1,DA,0))
 .. I +$P(NODE,U,3) S Y(I)=Y(I)_" <Inactive>"
 .. S Y(I)=Y(I)_U_$P(NODE,U,2)_U_$P(NODE,U,8)_U_$P(NODE,U,16)
 Q
CANEDIT(TIUY) ; Returns TRUE if the current user can edit dialog fields
 S TIUY=0
 I '+DUZ Q
 N TIUCLASS,TIUERR,IDX,SRV
 S SRV=$P($G(^VA(200,DUZ,5)),U)
 D GETLST^XPAR(.TIUCLASS,DUZ_";VA(200,^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","TIU FIELD EDITOR CLASSES","Q",.TIUERR)
 I TIUERR>0 Q
 S IDX=0
 F  S IDX=$O(TIUCLASS(IDX)) Q:'IDX  D  Q:+TIUY
 .I $$ISA^USRLM(DUZ,$P(TIUCLASS(IDX),U,2),.TIUERR) S TIUY=1
 Q
DOLMLINE(TIUX) ; finds Template Fields in a Line and replaces with LM Text
 N I,J,OUT,NAME,LMTEXT,IDX
 S OUT=TIUX
 F  S I=$F(OUT,"{FLD:") Q:'I  D
 . S J=$F(OUT,"}",I)
 . I J>0 S NAME=$E(OUT,I,J-2)
 . E  S NAME="",J=I
 . S LMTEXT=""
 . I NAME'="" D
 . . S IDX=$O(^TIU(8927.1,"B",NAME,0))
 . . I +IDX S LMTEXT=$P($G(^TIU(8927.1,IDX,0)),U,6)
 . S OUT=$E(OUT,1,I-6)_LMTEXT_$E(OUT,J,512)
 Q OUT
DOLMTEXT(TIUY,TIULIST) ; finds Template Fields and replaces with LM Text
 N I,LINE
 S I=0
 F  S I=$O(TIULIST(I)) Q:'I  D
 . S TIUY(I)=$$DOLMLINE(TIULIST(I,0))
 Q
CHKFLD(RESULT) ;Input: <None>
 ;Output: RESULT (see below for description)
 ;Similar to IMPORT^TIUSRVF; takes and parses XML fields to
 ;see if they have a matching field in the database.  Also resolves self
 ;referencing fields, and updates the XML.  Returns RESULT, which is a 
 ;list of fields in format ORIGINAL_FIELD_NAME^CODE^NEW_FIELD_NAME.
 ;If the CODE is 1 or 2, then the NEW_FIELD_NAME is blank.  If the CODE
 ;is 0, then the NEW_FIELD_NAME has the renamed field name.  In that 
 ;case, the XML has been updated with the new name where ever the 
 ;original name had occurred.
 N FIRST,RENAME,SAVESET,I,J,X,Y,OLD,ERR,CURS,CUR,RSET,K,FSET
 S FIRST=1,RENAME=0,I=0,ERR=0,FSET="^TMP(""TIUFLDXML"",$J)"
 ;LOOP UNTIL THE XML FIELD NAMES DON'T NEED TO BE RENAMED AND THE 
 ;XML NO LONGER NEEDS TO BE UPDATED
 F  D  Q:ERR!('RENAME)
 .D IMPORT2^TIUSRVF(.RSET,FSET,0)
 .I FIRST S FIRST=0,I=0 F  S I=$O(RSET(I)) Q:I'>0  S SAVESET(I)=$P(RSET(I),U,1)
 .S I=0
 .F  S I=$O(RSET(I)) Q:(I'>0)!ERR  I $P(RSET(I),U,3)="XML FORMAT ERROR" S ERR=1
 .Q:ERR
 .S I=0,RENAME=0
 .;LOOP THROUGH THE NAMES AND RENAME DUPLICATE NAMES
 .F  S I=$O(RSET(I)) Q:I'>0  D
 ..S CURS=$P(RSET(I),U,2),X=1
 ..I CURS="0" S X=3,RENAME=1
 ..I $L(CURS)>1 D
 ...S CURS=$E(CURS,3,$L(CURS)),OLD=$P(RSET(I),U,1)
 ...I CURS=OLD S RSET(I)=CURS_U_2
 ...E  S RSET(I)=OLD_U_0_U_CURS,X=3,RENAME=1
 ..S CUR=$P(RSET(I),U,X),J=0
 ..F  S J=$O(RSET(J)) Q:(J'<I)  D
 ...S K=$P(RSET(J),U,2),Y=1 I +K=0 S Y=3
 ...S OLD=$P(RSET(J),U,Y)
 ...I OLD=CUR D  ;SAME NAME FOUND; RENAME CURRENT ITEM
 ....S Y=1
 ....I X=3 S Y=1+(+$E(CUR,$L($P(RSET(I),U,1))+1,$L(CUR)))
 ....S $P(RSET(I),U,2)=0,$P(RSET(I),U,3)=$P(RSET(I),U,1)_Y
 ....S X=3,J=0,CUR=$P(RSET(I),U,X),RENAME=1
 .I RENAME D UPDTXML(.RSET,FSET)
 I 'ERR D
 .S I=0,J=0
 .F  S I=$O(SAVESET(I)) S J=$O(RSET(J)) Q:(I'>0)!(J'>0)  D
 ..I SAVESET(I)'=$P(RSET(J),U,1) D
 ...S Y=$P(RSET(J),U,2)
 ...I +Y=1 S X=0 ; CHANGE THIS X=0 TO X=3 WHEN THE GUI IS READY
 ...E  S X=0
 ...S $P(RSET(J),U,2)=X,$P(RSET(J),U,3)=$P(RSET(J),U,1),$P(RSET(J),U,1)=SAVESET(I)
 S I=0,J=0
 F  S I=$O(RSET(I)),J=J+1 Q:I'>0  S RESULT(J)=RSET(I)
 Q
UPDTXML(NAMESET,XSET) ; UPDATES THE XSET WITH UPDATED NAMES IN THE NAMESET
 N FND,I,J,PA1,PA2,PB1,PB2,P1,P2,P3
 S I=0,J=0
 F  S I=$O(NAMESET(I)) Q:I'>0  D
 .I $P(NAMESET(I),U,2)="0" S J=J+1
 .E  K NAMESET(I)
 Q:J'>0
 S I=0
 F  S I=$O(NAMESET(I)) Q:I'>0  D
 .S P1=$P(NAMESET(I),U,1),P2=$P(NAMESET(I),U,2),P3=$P(NAMESET(I),U,3)
 .S NAMESET(I)=$$XMLCONV^TIUSRVF(P1,0,1)_U_P2_U_$$XMLCONV^TIUSRVF(P3,0,1)
 S I=0
 ;MAIN LOOP - CURRENT XML LINE
 F  S I=$O(@XSET@(I)),FND=0,J=0 Q:I'>0  D
 .S PA1=$F(@XSET@(I),"<FIELD NAME="""),PA2=$F(@XSET@(I),"""",PA1)
 .S PB1=$F(@XSET@(I),"{FLD:"),PB2=$F(@XSET@(I),"}",PB1)
 .I (PA1&PA2) S PA2=PA2-2,FND=1
 .I (PB1&PB2) S PA1=PB1,PA2=PB2-2,FND=1
 .I FND F  S J=$O(NAMESET(J)) Q:J'>0  D  Q:J'>0
 ..I $P(NAMESET(J),U,2)=0,$E(@XSET@(I),PA1,PA2)=$P(NAMESET(J),U,1) D
 ...S $E(@XSET@(I),PA1,PA2)=$P(NAMESET(J),U,3),J=0
 Q
XFLDLD(RESULT,IN) ; RESETS/UPDATES THE TMP("TIUFLDXML",$J) GLOBAL
 ;WITH THE STRING PASSED IN "IN".  IF THE 1ST LINE IS SUBSCRIPTED
 ;AS 1, THE PROGRAM CLEARS THE TMP GLOBAL FIRST.  RETURNS "1" IF
 ;THIS CALL WAS SUCCESSFUL, "0" OTHERWISE.
 N X
 S X=0
 S X=$O(IN(X))
 I +X=1 K ^TMP("TIUFLDXML",$J)
 M ^TMP("TIUFLDXML",$J)=IN
 S RESULT(1)=1
 Q
LIMPORT(RESULT) ; Calls the import process to import all of the fields in the
 ;^TMP global for this process.  Result contains a list of NAME^X^RENAME
 ;strings.
 D IMPORT2^TIUSRVF(.RESULT,"^TMP(""TIUFLDXML"",$J)",1)
 Q
