XVEMDXK ;DJB/VEDD**List Keys ;2017-08-15  12:24 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
KEYS(ZNUM) ;Get all Keys for this file and any subfiles.
 ;ZNUM = File number.
 ;
 D LOOP("K")
 Q
 ;
KEYS1(FILE) ;Keys for a particular file
 ;FILE = File number
 ;
 NEW FLD,FNAM,I,IEN,INAM,INDEX,ND,MULT,NUM,PRIOR
 ;
 Q:'$G(FILE)
 Q:'$D(^DD("KEY","BB",FILE))
 ;
 ;Get file name
 S MULT=0
 I '$D(^DD(FILE,0,"UP")) S FNAM=$P($G(^DIC(FILE,0)),"^",1)
 E  S MULT=1,FNAM=$P($G(^DD(FILE,0)),"^",1) ;...Subfile
 Q:FNAM']""
 ;
 ;Heading
 I CNTKEY=1 D  Q:FLAGQ
 . I FLAGP,$E(XVVIOST,1,2)="P-" D  Q  ;...Printer
 .. W !!,"<<< KEYS >>>",!
 . W !,@XVV("RON")," KEYS ",@XVV("ROFF") ;...CRT
 S CNTKEY=CNTKEY+1
 W ! D:$Y>XVVSIZE PAGE Q:FLAGQ
 W !,$S(MULT:"Subfile: #",1:"File: #")_FILE
 D:$Y>XVVSIZE PAGE Q:FLAGQ
 ;
 S INAM=""
 F  S INAM=$O(^DD("KEY","BB",FILE,INAM)) Q:INAM=""!FLAGQ  D  ;
 . S IEN=$O(^DD("KEY","BB",FILE,INAM,0)) Q:'IEN
 . S ND=$G(^DD("KEY",IEN,0))
 . S PRIOR=$P(ND,"^",3)
 . D KEYSHD(IEN,INAM,PRIOR) ;...Index heading
 . S NUM=0
 . F I=1:1 S NUM=$O(^DD("KEY",IEN,2,"S",NUM)) Q:'NUM!FLAGQ  D  ;
 .. S FLD=$O(^DD("KEY",IEN,2,"S",NUM,0)) Q:'FLD
 .. W !
 .. W:I=1 ?6,"Field(s):"
 .. W ?16,NUM_") "
 .. W $P($G(^DD(FILE,FLD,0)),"^",1)
 .. W " (#"_FLD_")"
 .. S CNTKEY=CNTKEY+1
 .. D:$Y>XVVSIZE PAGE
 Q
 ;
INDEX(ZNUM) ;Get all Indexes for this file and any subfiles.
 ;ZNUM = File number.
 ;
 ;The file number displayed is either:
 ;     ROOT FILE field for non-field type xrefs
 ;     FILE field in the CROSS-REFERENCE VALUES multiple
 ;
 D LOOP("I")
 Q
 ;
INDEX1(FILE) ;Get all Indexes for this file and any subfiles.
 ;FILE = File number
 ;
 NEW FLD,FNAM,GL,I,IEN,IEN1,IFILE,INDEX,MARK,ND,NUM
 ;
 Q:'$G(FILE)
 Q:'$D(^DD("IX","BB",FILE))
 ;
 ;Heading
 I CNTKEY>1,CNTINDEX=1 W ! D:$Y>XVVSIZE PAGE Q:FLAGQ
 ;
 I CNTINDEX=1 D  Q:FLAGQ
 . I FLAGP,$E(XVVIOST,1,2)="P-" D  ;...Printer
 .. W !!,"<<< NEW-STYLE INDEXES >>>",!
 . E  D  ;...CRT
 .. W !,@XVV("RON")," NEW-STYLE INDEXES ",@XVV("ROFF")
 . D:$Y>XVVSIZE PAGE Q:FLAGQ
 . W ! D:$Y>XVVSIZE PAGE Q:FLAGQ
 . D HD^XVEMDX
 ;
 S CNTKEY=CNTKEY+1
 S CNTINDEX=CNTINDEX+1
 ;
 S INDEX=""
 F  S INDEX=$O(^DD("IX","BB",FILE,INDEX)) Q:INDEX=""!FLAGQ  D  ;
 . S IEN=$O(^DD("IX","BB",FILE,INDEX,0)) Q:'IEN
 . S ND=$G(^DD("IX",IEN,0))
 . ;
 . ;Mark Index if it's at top level and it has data.
 . S MARK=" "
 . I '$D(^DD(FILE,0,"UP")) D  ;
 .. S GL=ZGL_""""_INDEX_""""_")"
 .. S MARK=$S($D(@GL):"*",1:MARK)
 . ;
 . W ! D:$Y>XVVSIZE PAGE^XVEMDX Q:FLAGQ
 . W !,MARK_INDEX
 . ;
 . ;Display a xref that's 'Mumps' rather than 'Regular'.
 . I $P(ND,U,4)="MU" D  Q
 .. W ?20,$P(ND,U,9) ;...Root file
 .. W ?37,"Mumps code..."
 .. D:$Y>XVVSIZE PAGE^XVEMDX Q:FLAGQ
 . ;
 . I '$D(^DD("IX",IEN,11.1,"AC")) D  Q
 .. W ?20,$P(ND,U,9) ;...Root file
 . ;
 . S NUM=0
 . F I=1:1 S NUM=$O(^DD("IX",IEN,11.1,"AC",NUM)) Q:'NUM!FLAGQ  D  ;
 .. S IEN1=$O(^DD("IX",IEN,11.1,"AC",NUM,0)) Q:'IEN1
 .. S ND=$G(^DD("IX",IEN,11.1,IEN1,0))
 .. ;
 .. S CNTINDEX=CNTINDEX+1
 .. W:I>1 !
 .. ;
 .. ;Computed field
 .. I $P(ND,U,2)="C" D  Q
 ... I I=1 W ?20,$P($G(^DD("IX",IEN,0)),U,9) ;...Root file
 ... W ?37,"Computed..."
 ... D:$Y>XVVSIZE PAGE^XVEMDX
 .. ;
 .. S IFILE=$P(ND,U,3)
 .. S FLD=$P(ND,U,4)
 .. S FNAM=$P($G(^DD(IFILE,FLD,0)),U,1)
 .. ;
 .. W:I=1 ?20,IFILE ;.........File
 .. W ?37,FNAM_" (#"_FLD_")" ;Field
 .. ;
 .. D:$Y>XVVSIZE PAGE^XVEMDX  Q:FLAGQ
 Q
 ;
 ;==================================================================
 ;
LOOP(TYPE) ;Loop thru ^DD to get numbers for file and all subfiles.
 ;TYPE: K=Keys, I=Indexes
 ;
 NEW CNT,DATA,FILE,FLD,KEY,LEV,PAGE
 S (CNT,LEV,PAGE)=1
 S FILE(LEV)=ZNUM
 I TYPE="K" D KEYS1(FILE(LEV)) ;Check for keys
 I TYPE="I" D INDEX1(FILE(LEV)) ;Check for indexes
 ;
 S FLD(LEV)=0
 F  S FLD(LEV)=$O(^DD(FILE(LEV),FLD(LEV))) D  Q:'LEV!FLAGQ
 . I +FLD(LEV)=0 S LEV=LEV-1 Q
 . Q:'$D(^DD(FILE(LEV),FLD(LEV),0))
 . S DATA=^DD(FILE(LEV),FLD(LEV),0)
 . Q:$P($P(DATA,U,4),";",2)'=0
 . S LEV=LEV+1
 . S FILE(LEV)=+$P(DATA,U,2)
 . S FLD(LEV)=0
 . ;
 . I TYPE="K" D KEYS1(FILE(LEV)) ;Check for keys
 . I TYPE="I" D INDEX1(FILE(LEV)) ;Check for indexes
 Q
 ;
KEYSHD(IEN,INAM,PRIOR) ;Write Index heading
 ;INAM...Index name
 ;PRIOR..Priority
 ;
 NEW UINDEX
 W ! D:$Y>XVVSIZE PAGE Q:FLAGQ
 W !?3,$S(PRIOR="P":"PRIMARY",1:"SECONDARY")
 W " KEY: "_INAM
 S UINDEX=$P($G(^DD("KEY",IEN,0)),"^",4) Q:'UINDEX
 S UINDEX=$P($G(^DD("IX",UINDEX,0)),"^",2)
 W ?30,"Uniqueness Index: ",UINDEX
 D:$Y>XVVSIZE PAGE Q:FLAGQ
 Q
 ;
PAGE ;
 S (CNTKEY,CNTINDEX)=1
 I FLAGP,$E(XVVIOST,1,2)="P-" W @XVV("IOF"),!!! Q
 D PAUSEQE^XVEMKC(2) Q:FLAGQ
 W @XVV("IOF")
 Q
