A7R3NT2 ; SLCISC/RJS - ENGINEERING FILES DATA COMPARE (IEN match);7/06/10  8:30
 ;;1.0;NDBI-ENGINEERING 7.0;;July 08, 2010
 ;
ST ;Start
 ;
 N SFILE,HOME,POP,LOOP,EODS,EOF,TEXT,STATS,DATAERR,REMSITE,RECCNT,RECSKIP
 ;
 S HOME=$I,REMSITE=0
 K STATS
 S (RECCNT,RECSKIP)=0
 ;
 W !!,"Select Host File device" K IOP D ^%ZIS
 I POP W !!,"Data Install Aborted..." Q
 I (IO=HOME) W !!,"Operation Aborted..." Q
 ;
 ;  Main process loop
 ;
 S FILENUM=0
 S DATAERR=0
 S (EOF,EODS)=0 F LOOP=1:1 D  Q:EODS
 .;
 .U IO R TEXT
 .;
 .;U HOME:132 W !,TEXT
 .;
 .I (TEXT["$$END_DATA_STREAM") S EODS=1 Q
 .;
 .I (TEXT["$$START_DATA_STREAM") D  Q
 ..N ANS
 ..S REMSITE=$P(TEXT,"^",3)
 ..U HOME:132 W !,$P(TEXT,"^",2),"  (remote)",!!,"Alright to compare this data? NO//" R ANS
 ..Q:($E(ANS)="Y")
 ..Q:($E(ANS)="y")
 ..S EODS=1
 .;
 .I (TEXT["$$START_FILE") D  Q
 ..S FILENUM=$P(TEXT,"^",2)
 ..S GLREF=$G(^DIC(FILENUM,0,"GL"))
 ..I '$L(GLREF) S FILENUM=0 Q     ;     Invalid File Number
 ..K FILEDEF
 ..D SCANDD(FILENUM,0,GLREF)
 ..;
 ..U HOME:132 W !!,"Compare File: ",$P(TEXT,"^",3)
 .;
 .I FILENUM,(TEXT["$$START_RECORD") D COMPREC(TEXT) Q
 .;
 .I EOF S FILENUM=0
 .;
 ;
 I '(IO=HOME) U IO D ^%ZISC
 ;
 U HOME W !!!,?40,"   Records   IEN Err  Data Err"
 S SFILE="" F  S SFILE=$O(STATS(SFILE)) Q:'$L(SFILE)  D
 .U HOME W !,SFILE,?40
 .U HOME W $J($FN(+$G(STATS(SFILE,"TOT")),","),10)
 .U HOME W $J($FN(+$G(STATS(SFILE,"IERR")),","),10)
 .U HOME W $J($FN(+$G(STATS(SFILE,"DERR")),","),10)
 ;
 U HOME W !!,RECCNT," Records Loaded."
 U HOME W !!,RECSKIP," Records Skipped."
 ;
 Q
 ;
 ;
COMPREC(LDTEXT) ;
 ;
 N EOREC,SUBFILE,KEY,DIALOG,PRINT
 ;
 S SUBFILE=$$FILENAME(+$P(LDTEXT,"^",2))
 S KEY=$P(LDTEXT,"^",4)
 S PRINT=0
 ;
 D ADD("   Compare "_SUBFILE_": "_KEY)
 ;
 S RECID=$$LKUP(LDTEXT)
 I 'RECID S RECSKIP=RECSKIP+1 Q
 S RECID=+RECID
 S RECCNT=RECCNT+1
 ;
 S EOREC=0 F  D  Q:EOREC  Q:EODS
 .;
 .U IO R TEXT
 .;
 .I (TEXT["$$END_DATA_STREAM") S EODS=1 Q
 .I (TEXT["$$END_FILE") S EOF=1 Q
 .I (TEXT["$$END_RECORD") S EOREC=1 Q
 .;
 .I (TEXT["$$START_MULTIPLE") D COMPMLT(TEXT) Q
 .;
 .D COMPFLD(TEXT,6,1)
 ;
 S STATS(SUBFILE,"TOT")=$G(STATS(SUBFILE,"TOT"))+1
 I PRINT U HOME:132 D
 .N LOOP 
 .W !!
 .S LOOP=0 F  S LOOP=$O(DIALOG(LOOP)) Q:'LOOP  U HOME:132 W !,DIALOG(LOOP)
 .I (PRINT=1) S STATS(SUBFILE,"DERR")=$G(STATS(SUBFILE,"DERR"))+1,DATAERR=DATAERR+1
 .I (PRINT=2) S STATS(SUBFILE,"IERR")=$G(STATS(SUBFILE,"IERR"))+1
 .;W !!,SUBFILE,"  " R ANS
 ;
 Q
 ;
COMPMLT(LDTEXT) ;
 ;
 N EOMLT,SUBFILE,KEY,RIENS
 ;
 S RIENS=$P(LDTEXT,"^",2)
 S SUBFILE=$$FILENAME(+$P(RIENS,";",$L(RIENS,";")))
 ;
 I (SUBFILE["SUB-FIELD"),(SUBFILE["EFFECTIVE DATE/TIME") D  Q
 .F  U IO R TEXT Q:(TEXT["$$END_MULTIPLE")
 ;
 I (SUBFILE["SUB-FIELD") S SUBFILE=$P(SUBFILE,"SUB-FIELD",1)_"Multiple"
 S KEY=$P(LDTEXT,"^",4)
 ;
 D ADD("         Compare "_SUBFILE_": "_KEY)
 ;
 S EOMLT=0 F  D  Q:EOREC  Q:EODS  Q:EOMLT
 .;
 .U IO R TEXT
 .;
 .I (TEXT["$$START_MULTIPLE") D COMPMLT(TEXT) Q
 .I (TEXT["$$END_DATA_STREAM") S EODS=1 Q
 .I (TEXT["$$END_FILE") S EOF=1 Q
 .I (TEXT["$$END_RECORD") S EOREC=1 Q
 .I (TEXT["$$END_MULTIPLE") S EOMLT=1 Q
 .;
 .D COMPFLD(TEXT,12,1)
 ;
 Q
 ;
COMPFLD(TXT,TAB,ROOT) ;
 ;
 N FLD,FLDNAME,FILE,LOOP,SUBTXT,REMDATA,LOCDATA,INTVAL,ANS,IENS,IEN,ERROR,PTRFLD,PMLOC,PMREM,PMIEN
 S FLD=$P(TXT,"^",2)
 ;
 D GETCV(TXT)
 ;
 S REMDATA=$P(TXT,"^",4)
 ;
 Q:$$EXFIELD(FILE,FLD)
 X FILEDEF(FILE,FLD,"GETCODE")
 S LOCDATA=$$EXTVAL(FILE,FLD,INTVAL)
 S:'$L(LOCDATA) LOCDATA="<Data Missing>"
 ;
 S (PMREM,PMLOC)=0
 S PTRFLD=0 I ($G(FILEDEF(FILE,FLD,"FLDTYPE"))["P") S PTRFLD=+$P(FILEDEF(FILE,FLD,"FLDTYPE"),"P",2)    ; IS THIS A POINTER FIELD?
 S PMREM=+$P(TXT,"^",3)
 S PMLOC=INTVAL
 S PMIEN=$O(^A7R3(17004.6,"B",REMSITE_";"_PTRFLD_";"_PMREM,0))
 ;
 I PMIEN,($P($G(^A7R3(17004.6,PMIEN,0)),"^",2)=PMLOC) Q   ;   POINTER MATCHED IN VCB POINTER MASTER FILE
 ;
 ;
 S ERROR=""
 I '(LOCDATA=REMDATA) S ERROR="****************  ",PRINT=1
 I '(LOCDATA=REMDATA),ROOT,(FLD=.01) S ERROR="****************  ",PRINT=2
 ;
 ;
 D ADD($$TAB(TAB)_$J("(remote) "_$P(^DD(FILE,FLD,0),"^",1)_" #"_IEN_": ",40)_"|"_REMDATA_"|")
 D ADD($$TAB(TAB)_$J(" (local) "_$P(^DD(FILE,FLD,0),"^",1)_" #"_IEN_": ",40)_"|"_LOCDATA_"|"_ERROR)
 ;
 Q
 ;
 ;
GETCV(DATA) ;
 ;
 F LOOP=0:1:10 K @("D"_LOOP)
 S IENS=$P(DATA,"^",1)
 F LOOP=0:1 S SUBTXT=$P(IENS,";",LOOP+1) Q:'$L(SUBTXT)  D
 .S FILE=+$P(SUBTXT,",",1)
 .S IEN=+$P(SUBTXT,",",2)
 .S @("D"_LOOP)=+$P(SUBTXT,",",2)
 ;
 I RECID S D0=RECID    ;   If  then Local IEN will be different than Remote IEN
 ;
 F LCV=0:1 Q:'$G(@("D"_LCV))
 S LCV=LCV-1
 ;
 K DA
 S SDA=0 F LDA=LCV:-1:0 S DA(SDA)=@("D"_LDA),SDA=SDA+1
 S DA=DA(0) K DA(0)
 ;
 Q
 ;
ADD(TEXT) ;
 ;
 S DIALOG=$G(DIALOG)+1
 S DIALOG(DIALOG)=TEXT
 Q
 ;
TAB(X) ;
 ;
 N SPACE
 S SPACE="",$P(SPACE," ",X)=" "
 ;
 Q SPACE
 ;
TODAY() ;   What is todays date?
 N %DT,X,Y
 S %DT="",X="T" D ^%DT
 Q Y
 ;
NOW() ;   What time is it?
 N %DT,X,Y
 S %DT="T",X="N" D ^%DT
 D DD^%DT
 Q Y
 ;
FILENAME(FNUM) ;
 ;
 I $L($G(^DIC(+FNUM,0))) Q $P(^DIC(+FNUM,0),"^",1)
 I $L($G(^DD(FNUM,0))) Q $P(^DD(+FNUM,0),"^",1)
 Q ""
 ;
SCANDD(FILE,LVL,GLREF) ;
 ;
 N FIELD
 ;
 ; Build Collect code
 ;
 S GLREF=GLREF_"D"_LVL_","
 ;
 S FIELD=0 F  S FIELD=$O(^DD(FILE,FIELD)) Q:'FIELD  D
 .N TYPE1,TYPE2,NODE,NAME,SUBS,PIECE,GL,LOC
 .;
 .S NODE=$G(^DD(FILE,FIELD,0)) Q:'$L(NODE)
 .;
 .Q:'($P(NODE,"^",4)[";")    ; No data stored for this field, (Computed field)
 .S NAME=$P(NODE,"^",1)
 .S TYPE1=$P(NODE,"^",2)
 .I ($E(TYPE1,1)="C") Q
 .S SUBS=$P($P(NODE,"^",4),";",1)
 .I '(SUBS=+SUBS) S SUBS=""""_SUBS_""""
 .S PIECE=$P($P(NODE,"^",4),";",2)
 .S GL=GLREF_SUBS
 .I 'PIECE S LOC=GL_","
 .I PIECE S LOC="$P($G("_GL_"))"_",""^"","_PIECE_")"
 .I (PIECE?1"E"1.N1","1.N) S LOC="$G("_GL_"))"
 .S TYPE2=""
 .S PTR=0
 .;
 .I 'PIECE,+TYPE1 D  Q   ;   This Field is a multiple
 ..;
 ..S FILEDEF(FILE,FIELD,"SUBFILE")=+TYPE1_"^"_SUBS_"^"_"D"_(LVL+1)
 ..D SCANDD(+TYPE1,LVL+1,LOC) Q
 .;
 .S FILEDEF(FILE,FIELD,"GETCODE")="S INTVAL="_LOC
 .S FILEDEF(FILE,FIELD,"FLDTYPE")=TYPE1
 .;
 ;
 Q
 ;
LKUP(LKVAL) ;
 ;
 N D0,FILE,INTVAL,EXTVAL,DIC,X,Y,PMIEN,PMNAM,REMIEN
 ;S X=D0
 ;
 ;   LKVAL = $$START_RECORD^6914,103430^103430^103430^
 ;
 S FILE=$P(LKVAL,"^",2)
 S REMIEN=+$P(LKVAL,",",2)
 S FILE=+FILE
 S INTVAL=$P(LKVAL,"^",3)
 S EXTVAL=$P(LKVAL,"^",4)
 S PMIEN=0
 S D0=0
 S DIC=FILE,DIC(0)="BX",X=EXTVAL D ^DIC I (+Y>0) S D0=+Y
 I 'D0 U HOME W !!,EXTVAL,"  not found."
 Q +D0
 ;
 ;
EXTVAL(FILE,FLD,VAL) ;   Convert Internal Value to External Value
 ;
 N TYP,NODE
 S NODE=$G(^DD(FILE,FLD,0))
 S TYP=$P(NODE,"^",2)
 ;
 Q:'$L(VAL) VAL   ;   RETURN NULL IF VAL IS NULL
 ;
 ; Strip off the prefixes
 ;
 I ($E(TYP,1)="R") S TYP=$E(TYP,2,$L(TYP))
 I ($E(TYP,1)="M") S TYP=$E(TYP,2,$L(TYP))
 I ($E(TYP,1)="X") S TYP=$E(TYP,2,$L(TYP))
 I ($E(TYP,1)="*") S TYP=$E(TYP,2,$L(TYP))
 ;
 I '$L(TYP) S TYP="F"
 ;
 I ($E(TYP,1)="K") Q VAL  ;  Mumps Kode
 I ($E(TYP,1)="F") Q VAL  ;  Free Text
 I ($E(TYP,1)="W") Q VAL  ;  Word Processing
 I ($E(TYP,1)="N") Q +VAL ;  Numeric
 ;
 I ($E(TYP,1)="S") D  Q VAL  ; Set of Codes
 .N CODES,TRY
 .S CODES=$P(NODE,"^",3)
 .F TRY=1:1:$L(CODES,";"),0 I TRY Q:($P($P(CODES,";",TRY),":",1)=VAL)
 .I 'TRY S VAL="********************* Undefined Code "_VAL_"*************************" Q
 .S VAL=$P($P(CODES,";",TRY),":",2)
 ;
 I ($E(TYP,1)="D") D  Q VAL   ;  Date/Time
 .N X,Y,%DT
 .S Y=VAL D DD^%DT S VAL=Y
 ;
 I ($E(TYP,1)="P") D  Q VAL   ;  Pointer
 .N PTR,GLREF,PVAL
 .S PTR=+$P(TYP,"P",2)
 .S GLREF=$G(^DIC(PTR,0,"GL"))
 .I '$L(GLREF) S VAL="********************* Undefined Pointer File "_PTR_"*************************" Q
 .S PVAL=$P($G(@(GLREF_VAL_",0)")),"^",1)
 .I '$L(PVAL) S VAL="********************* Undefined Entry #"_VAL_" in File "_PTR_"*************************" Q
 .S VAL=PVAL
 ;
 ;
 Q "********************* Undefined Type "_TYP_"*************************"
 ;
 ;
EXFIELD(F1,F2) ;   EXCLUDE THESE FIELDS
 ;
 ; F1 = FILE   F2 = FIELD
 ;
 ; 0 = INCLUDE
 ; 1 = EXCLUDE
 ;
 I ($P($G(^DD(F1,F2,0)),"^",1)["EFFECTIVE DATE/TIME") Q 1
 ;
 Q 0
 ;
EXFILE(F1) ;   EXCLUDE THIS FILE
 ;
 ; F1 = FILE
 ;
 ; 0 = INCLUDE
 ; 1 = EXCLUDE
 ;
 I ($P($G(^DD(F1,0)),"^",1)["EFFECTIVE DATE/TIME") Q 1
 ;
 Q 0
 ;
DANGPTR ;
 ;
 K ^TMP($J)
 ;
 S D0=0 F  S D0=$O(^A7R3(17004.6,D0)) Q:'D0  D
 .S N0=$G(^A7R3(17004.6,D0,0))
 .Q:$P(N0,"^",2)
 .S N1=$G(^A7R3(17004.6,D0,1))
 .S ^TMP($J,$P(N0,"^",1))=N1
 ;
 S PTR="" F  S PTR=$O(^TMP($J,PTR)) Q:'$L(PTR)  D
 .S FILE=$P($G(^DIC(+$P(PTR,";",2),0)),"^",1)
 .W !,FILE,": ",^TMP($J,PTR)
 ;
 Q
 ;
