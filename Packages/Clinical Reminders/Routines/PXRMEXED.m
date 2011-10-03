PXRMEXED ; SLC/PKR - Special code for education topics. ;02/25/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;=========================================================
EXISTS(FLIST,IEN) ;Return true if IEN exists anywhere on the list.
 N EXISTS,IND
 S EXISTS=0,IND=""
 F  S IND=$O(FLIST("EDUCATION TOPICS",IND)) Q:(EXISTS)!(IND="")  D
 . I $D(FLIST("EDUCATION TOPICS",IND,IEN)) S EXISTS=1
 Q EXISTS
 ;
 ;=========================================================
SUB(FLIST) ;Add a finding to the list of findings.
 I '$D(FLIST("EDUCATION TOPICS")) Q
 N IEN,IND,JND,LEVEL,NEXT,SUB,SUBIEN
 S IEN="",LEVEL=1
 F  S IEN=$O(FLIST("EDUCATION TOPICS","F",IEN)) Q:IEN=""  D
 . S JND=0
 . F  S JND=+$O(^AUTTEDT(IEN,10,JND)) Q:JND=0  D
 .. S SUBIEN=$P(^AUTTEDT(IEN,10,JND,0),U,1)
 .. S SUB(LEVEL,SUBIEN)=""
 F  Q:'$D(SUB(LEVEL))  D
 . S IND=LEVEL-1,NEXT=LEVEL+1
 . F  S IND=$O(SUB(IND)) Q:IND=""  D
 .. S IEN=""
 .. F  S IEN=$O(SUB(IND,IEN)) Q:IEN=""  D
 ... S JND=0
 ...;DBIA #3085
 ... F  S JND=+$O(^AUTTEDT(IEN,10,JND)) Q:JND=0  D
 .... S SUBIEN=$P(^AUTTEDT(IEN,10,JND,0),U,1)
 .... S SUB(NEXT,SUBIEN)=""
 . S LEVEL=NEXT
 M SUB(0)=FLIST("EDUCATION TOPICS","F")
 K FLIST("EDUCATION TOPICS","F")
 S LEVEL=LEVEL-1,JND=0
 F IND=LEVEL:-1:0 D
 . S JND=JND+1,SUBIEN="F"_JND
 . S IEN=""
 . F  S IEN=$O(SUB(IND,IEN)) Q:IEN=""  D
 .. I '$$EXISTS(.FLIST,IEN) S FLIST("EDUCATION TOPICS",SUBIEN,IEN)=""
 Q
 ;
