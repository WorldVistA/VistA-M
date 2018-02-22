XVEMKI4 ;DJB/KRN**Indiv Fld DD - Keys, New-Style Indexes ;2017-08-15  12:57 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
KEYS ;Get Keys for this file/field.
 NEW IEN,IEN1,NAME,PRIOR,SEQ,ND,ND1,UNIQ
 ;
 Q:'$D(^DD("KEY","F",DD,FNUM))
 ;
 ;Heading
 I $G(FLAGP),$E(XVVIOST,1,2)="P-" D  Q  ;...Printer
 . W !!,"<<< KEYS >>>",!
 W ! Q:$$CHECK
 W !,@XVV("RON")," KEYS ",@XVV("ROFF") ;...CRT
 Q:$$CHECK
 ;
 S IEN=0
 F  S IEN=$O(^DD("KEY","F",DD,FNUM,IEN)) Q:'IEN!FLAGQ  D  ;
 . S IEN1=0
 . F  S IEN1=$O(^DD("KEY","F",DD,FNUM,IEN,IEN1)) Q:'IEN1!FLAGQ  D  ;
 .. S ND=$G(^DD("KEY",IEN,0))
 .. S ND1=$G(^DD("KEY",IEN,2,IEN1,0))
 .. S NAME=$P(ND,"^",2)
 .. S PRIOR=$P(ND,"^",3)
 .. S SEQ=$P(ND1,"^",3)
 .. S UNIQ=$P(ND,U,4)
 .. I UNIQ S UNIQ=$P($G(^DD("IX",UNIQ,0)),U,2)
 .. ;
 .. W ! Q:$$CHECK
 .. W !?C1,$S(PRIOR="P":"PRIMARY",1:"SECONDARY")_" KEY: "_NAME
 .. Q:$$CHECK
 .. W !?C2,"Sequence: ",SEQ
 .. Q:$$CHECK
 .. W !?C2,"Uniqueness Index: ",UNIQ
 .. Q:$$CHECK
 Q
 ;
INDEX ;Get Indexes for this file/field.
 NEW IEN,IEN1,ND,STRING
 NEW VENODE,VENODE0,VENODE2,VENODE3
 ;
 Q:'$D(^DD("IX","F",DD,FNUM))
 ;
 ;Heading
 I $G(FLAGP),$E(XVVIOST,1,2)="P-" D  Q  ;...Printer
 . W !!,"<<< NEW-STYLE INDEXES >>>",!
 W ! Q:$$CHECK
 W !,@XVV("RON")," NEW-STYLE INDEXES",@XVV("ROFF") ;...CRT
 Q:$$CHECK
 ;
 ;
 S IEN=0
 F  S IEN=$O(^DD("IX","F",DD,FNUM,IEN)) Q:'IEN!FLAGQ  D  ;
 . S IEN1=0
 . F  S IEN1=$O(^DD("IX","F",DD,FNUM,IEN,IEN1)) Q:'IEN1!FLAGQ  D  ;
 .. S VENODE=$G(^DD("IX",IEN,0))
 .. S VENODE0=$G(^DD("IX",IEN,11.1,IEN1,0))
 .. S VENODE2=$G(^DD("IX",IEN,11.1,IEN1,2))
 .. S VENODE3=$G(^DD("IX",IEN,11.1,IEN1,3))
 .. ;
 .. W ! Q:$$CHECK
 .. W !?C1,"INDEX: ",$P(VENODE,U,2) Q:$$CHECK
 .. D INDEXTYP Q:FLAGQ
 .. D INDEXCD^XVEMKI5 Q:FLAGQ
 Q
 ;
INDEXTYP ;Type of index info
 NEW ACT,EXEC,I,NUM,RFILE,RTYPE,TYPE,USE
 ;
 S TYPE=$P(VENODE,U,4) ;....Type
 S EXEC=$P(VENODE,U,6) ;....Execution
 S ACT=$P(VENODE,U,7) ;.....Activity
 S RTYPE=$P(VENODE,U,8) ;...Root type
 S RFILE=$P(VENODE,U,9) ;...Root file
 S USE=$P(VENODE,U,14) ;....Use
 ;
 W !?C2,"Type:"
 W ?C4,$S(TYPE="R":"REGULAR",TYPE="MU":"MUMPS",1:"")
 Q:$$CHECK
 ;
 W !?C2,"Root File:",?C4,RFILE
 I RTYPE="I" W " - Index & fields at same level"
 I RTYPE="W" W " - Whole file index on subfile fields"
 Q:$$CHECK
 ;
 ;Display fields in the CROSS-REFERENCE VALUES multiple
 D INDEXFLD Q:FLAGQ
 ;
 W !?C2,"Execute:"
 W ?C4,$S(EXEC="F":"After an index field changes",EXEC="R":"After all fields in a record are updated",1:"")
 Q:$$CHECK
 ;
 W !?C2,"Use:"
 W ?C4,$S(USE="LS":"Lookup & Sorting",USE="S":"Sorting only",USE="A":"Performs an action. Does not build an index.",1:"")
 Q:$$CHECK
 ;
 D  Q:FLAGQ
 . Q:$P(VENODE,U,3)']""
 . W !?C2,"Short Desc:"
 . S STRING=$P(VENODE,U,3) D STRING^XVEMKI3
 ;
 D  Q:FLAGQ
 . Q:'$D(^DD("IX",IEN,.1))
 . W !?C2,"Description:"
 . D WORDA^XVEMKI3("^DD(""IX"","_IEN_",.1)",0)
 ;
 W !?C2,"Activity:"
 I ACT["I" D  Q:FLAGQ
 . W ?C4,"Fired when installing an entry at a site"
 . Q:$$CHECK
 . W:ACT["R" !
 I ACT["R" W ?C4,"Fired when re-cross-referenced"
 Q:$$CHECK
 Q
 ;
INDEXFLD ;Display fields in the CROSS-REFERENCE VALUES multiple
 ;
 NEW COLL,LOOKUP,MAX
 ;
 W !?C2,"Order #:"
 W ?C4,$P(VENODE0,U,1)
 S MAX=$P(VENODE0,U,5)
 W ?C6,"Max Length:"
 W ?C7,MAX
 Q:$$CHECK
 ;
 W !?C2,"Subscript #:"
 W ?C4,$P(VENODE0,U,6)
 S COLL=$P(VENODE0,U,7)
 W ?C6,"Collation:"
 W ?C7,$S(COLL="B":"Back",1:"Forward")
 Q:$$CHECK
 ;
 S LOOKUP=$P(VENODE0,U,8)
 I LOOKUP]"" D  ;
 . W !?C2,"Lookup Prompt:"
 . W ?C4,LOOKUP
 Q:$$CHECK
 Q
 ;
CHECK() ;Check page length. 0=Ok  1=Quit
 I $Y'>(XVVSIZE+1) Q 0
 D PAGE^XVEMKI3 I FLAGQ Q 1
 Q 0
