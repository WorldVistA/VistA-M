GMRCIRSN ;ALB/WTC - MANIPULATE REASON FOR REQUEST ON IFC ; Jan 09, 2025@09:45
 ;;3.0;CONSULT/REQUEST TRACKING;**201**;DEC 27, 1997;Build 7
 ;
 Q  ;don't start here!
 ;
RESEQNCE(IEN) ;
 ;
 ;  Re-sequence reason for request OBX segments before filing.
 ;
 ;  IEN = pointer to IFC REASON FOR REQUEST MAPPING file (#123.7)
 ;
 ;  OBX segments are stored in ^TMP("GMRCIN",$J,"OBX",1,i).  They are returned there after they are re-sequenced.
 ;
 Q:$G(IEN)=""  Q:'$D(^GMR(123.7,IEN))  ;
 ;
 N DATAFLD,SEQUENCE,IEN2,N,X,IDX,NOTSTOR,ORDRNAME,M,IDX1 ;
 ;
 K ^TMP("GMRCIRSN",$J) S ORDRNAME=$P(^GMR(123.7,IEN,0),U,1) ;
 ;
 ;  Save order name from 1st OBX segment at top of resequenced list.
 ;
 S IDX=0,X=$G(^TMP("GMRCIN",$J,"OBX",1,1)) I $$UP^XLFSTR($P(X,"|",5))=$$UP^XLFSTR(ORDRNAME) S IDX=IDX+1,^TMP("GMRCIRSN",$J,"OBX",1,IDX)=X K ^TMP("GMRCIN",$J,"OBX",1,1)
 ;
 ;  Scan data fields in the desired sequence order.
 ;
 S SEQUENCE=0 F  S SEQUENCE=$O(^GMR(123.7,IEN,1,"SEQUENCE",SEQUENCE)) Q:'SEQUENCE  D  ;
 . S IEN2=0 F  S IEN2=$O(^GMR(123.7,IEN,1,"SEQUENCE",SEQUENCE,IEN2)) Q:'IEN2  S DATAFLD=$P(^GMR(123.7,IEN,1,IEN2,0),U,1),NOTSTOR=$P(^(0),U,3) D  ;
 .. W !,DATAFLD ;
 .. ;
 .. ;  Find data field in the OBX segments and save it in the desired sequence.  
 .. ;
 .. S N=0 F  S N=$O(^TMP("GMRCIN",$J,"OBX",1,N)) Q:'N  S X=^(N) I $$UP^XLFSTR($P($P(X,"|",5),":",1))=$$UP^XLFSTR(DATAFLD) D  Q  ;
 ... W !,"N",N,".",X ;
 ... I 'NOTSTOR S IDX=IDX+1,^TMP("GMRCIRSN",$J,"OBX",1,IDX)=X K ^TMP("GMRCIN",$J,"OBX",1,N) ;
 ... I NOTSTOR K ^TMP("GMRCIN",$J,"OBX",1,N) ;  Delete data fields that are marked DO NOT STORE.
 ... ;
 ... ;  If the preceding OBX seqment(s) do(es) not contain a data field, it's a comment about the data field.  Include it.
 ... ;
 ... S M=N,IDX1=IDX F  S M=$O(^TMP("GMRCIN",$J,"OBX",1,M),-1) Q:'M  S X=^(M) Q:$P(X,"|",5)[":"  D  ;
 .... W !,"M",M,".",X ;
 .... I 'NOTSTOR S IDX1=IDX1-.1,^TMP("GMRCIRSN",$J,"OBX",1,IDX1)=X K ^TMP("GMRCIN",$J,"OBX",1,M) ;
 .... I NOTSTOR K ^TMP("GMRCIN",$J,"OBX",1,M) ;  Delete data fields that are marked DO NOT STORE.
 ... ;
 ... ;  If the next OBX segment(s) do(es) not contain a data field, it's a continuation of the line before.  Save it as well.
 ... ;
 ... F  S N=$O(^TMP("GMRCIN",$J,"OBX",1,N)) Q:'N  S X=^(N) Q:$P(X,"|",5)[":"  Q:$E($P(X,"|",5),1)'=" "  D  ;
 .... W !,"N",N,X ;
 .... I 'NOTSTOR S IDX=IDX+1,^TMP("GMRCIRSN",$J,"OBX",1,IDX)=X K ^TMP("GMRCIN",$J,"OBX",1,N) ;
 .... I NOTSTOR K ^TMP("GMRCIN",$J,"OBX",1,N) ;  Delete data fields that are marked DO NOT STORE.
 ;
 ;  Add unmatched reasons for request to the end.
 ;  
 S N=0 F  S N=$O(^TMP("GMRCIN",$J,"OBX",1,N)) Q:'N  S X=^(N),IDX=IDX+1,^TMP("GMRCIRSN",$J,"OBX",1,IDX)=X ;
 ;
 ;  Re-sequence OBX-4.
 ;
 S SEQUENCE=0 F IDX=1:1 S SEQUENCE=$O(^TMP("GMRCIRSN",$J,"OBX",1,SEQUENCE)) Q:'SEQUENCE  S $P(^(SEQUENCE),"|",4)=IDX ;
 ;
 ;  Restore re-sequenced OBX segments in ^TMP("GMRCIN",$J)
 ;
 K ^TMP("GMRCIN",$J,"OBX",1) M ^TMP("GMRCIN",$J,"OBX",1)=^TMP("GMRCIRSN",$J,"OBX",1) ;
 K ^TMP("GMRCIRSN",$J) ;
 Q  ;
 ;
LIST ;
 ;
 ;  Formatted list of IFC REASON FOR REQUEST MAPPING file (#123.7) entry
 ;
 N DIC,X,Y,IEN,DUOUT,DTOUT,POP,SEQUENCE,IEN2 ;
 ;
 S DIC=123.7,DIC(0)="AEQM" D ^DIC Q:$D(DUOUT)  Q:$D(DTOUT)  Q:Y<0  S IEN=+Y ;
 ;
 D ^%ZIS Q:POP  ;
 ;
 W !,"Order Name: ",$P(^GMR(123.7,IEN,0),U,1),! ;
 W !,"Sequence",?10,"Data Field",?62,"Do not Store",!,"--------",?10,"------------------------------",?62,"------------",! ;
 ;
 S SEQUENCE=0 F  S SEQUENCE=$O(^GMR(123.7,IEN,1,"SEQUENCE",SEQUENCE)) Q:'SEQUENCE  S IEN2=0 F  S IEN2=$O(^GMR(123.7,IEN,1,"SEQUENCE",SEQUENCE,IEN2)) Q:'IEN2  D  ;
 . ;
 . W $P(^GMR(123.7,IEN,1,IEN2,0),U,2),?10,$P(^(0),U,1),?62,$S($P(^(0),U,3):"YES",1:""),! ;
 ;
 D ^%ZISC Q  ;
 ;
LISTALL ;
 ;
 ;  Formatted list of all IFC REASON FOR REQUEST MAPPING file (#123.7) entries
 ;
  N DIC,X,Y,IEN,DUOUT,DTOUT,POP,SEQUENCE,IEN2 ;
 ;
 D ^%ZIS Q:POP  ;
 ;
 S ORDRNAME="" F  S ORDRNAME=$O(^GMR(123.7,"B",ORDRNAME)) Q:ORDRNAME=""  S IEN=0 F  S IEN=$O(^GMR(123.7,"B",ORDRNAME,IEN)) Q:'IEN  D  ;
 . W !,"Order Name: ",$P(^GMR(123.7,IEN,0),U,1),! ;
 . W !,"Sequence",?10,"Data Field",?62,"Do not Store",!,"--------",?10,"------------------------------",?62,"------------",! ;
 . ;
 . S SEQUENCE=0 F  S SEQUENCE=$O(^GMR(123.7,IEN,1,"SEQUENCE",SEQUENCE)) Q:'SEQUENCE  S IEN2=0 F  S IEN2=$O(^GMR(123.7,IEN,1,"SEQUENCE",SEQUENCE,IEN2)) Q:'IEN2  D  ;
 .. ;
 .. W $P(^GMR(123.7,IEN,1,IEN2,0),U,2),?10,$P(^(0),U,1),?62,$S($P(^(0),U,3):"YES",1:""),! ;
 . W ! ;
 ;
 D ^%ZISC Q  ;
 ;
LOAD ;
 ;
 ;  Add entry to #123.7.  Code expects lines of text as follows: order name, data set name #1, #2, #3,...  It looks for *** to end the sequence of data set names.
 ;
 N ORDRNAME,X,LIST,I,DA,DIC,Y,N,DIK,COUNT ;
 ;
 F  R !,"ORDER NAME: ",ORDRNAME:DTIME Q:ORDRNAME=""  W ! D  ;
 . ;
 . S DA=$O(^GMR(123.7,"B",$E(ORDRNAME,1,30),0)) I DA,$P(^GMR(123.7,DA,0),U,1)=ORDRNAME W "...ALDREADY ON FILE.",! Q  ;
 . ;
 . W !!,"ENTER OR PASTE ORDERED SEQUENCE OF DATA FIELDS: " ;
 . K LIST F I=1:1 R X:DTIME Q:X=""  Q:X?1"*"."*"  S LIST(I)=$$RSTRIP(X) W ! ;
 . W ! S COUNT=I-1 ;
 . ;
 . ;  Add common data set names.
 . ;
 . F I=1:1:6 S COUNT=COUNT+1,LIST(COUNT)=$P("Delivery Method,Special Instructions,Opt. in for Item's final status,Facility,Point of Care,Address",",",I) ;
 . ;
 . K DA,DIC S X=ORDRNAME,DIC=^DIC(123.7,0,"GL"),DIC(0)="L" D FILE^DICN S DA=+Y ;
 . ;
 . S ^GMR(123.7,DA,1,0)="^123.71^"_(I-1)_"^"_(I-1) ;
 . F N=1:1:COUNT S ^GMR(123.7,DA,1,N,0)=LIST(N)_U_N ;
 . ;
 . S DIK=^DIC(123.7,0,"GL") D IX^DIK ;
 ;
 Q  ;
 ;
RSTRIP(X) ;
 ;
 Q:$E(X,$L(X))'=" " X ;
 S X=$E(X,1,$L(X)-1) Q $$RSTRIP(X) ;
 ;
