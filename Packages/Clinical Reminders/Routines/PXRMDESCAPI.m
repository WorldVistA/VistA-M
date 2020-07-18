PXRMDESCAPI ; SLC/AGP - Clinical Reminders Description APIs.;05/08/2020
 ;;2.0;CLINICAL REMINDERS;**46**;Feb 04, 2005;Build 236
 ;========================================================
 ;
 ;Computed finding description
CF(SUB,ITEM) ;
 N GLB,IEN
 K ^TMP(SUB,$J)
 I ITEM=+ITEM S IEN=ITEM
 E  S ITEM=$O(^PXRMD(811.4,"B",ITEM,""))
 ;perform checks
 I ITEM="" Q -1_U_"Non-existent computed finding"
 I $D(^PXRMD(811.4,IEN))<10 Q -1_U_"Non-existent computed finding"
 I '$D(^PXRMD(811.4,IEN,1,0)) Q 0
 ;
 S GLB="^PXRMD(811.4,"_IEN_","_1_")"
 D WPFORMAT(SUB,GLB,0,78)
 Q 1
 ;
 ;Reminder Definition General/Technical Descriptions
DEF(SUB,ITEM,FIELD) ;
 N GLB,IEN,NUM
 K ^TMP(SUB,$J)
 I ITEM=+ITEM S IEN=ITEM
 E  S ITEM=$O(^PXD(811.9,"B",ITEM,""))
 ;perform checks
 I ITEM="" Q -1_U_"Non-existent reminder definition"
 I $D(^PXD(811.9,IEN))<10 Q -1_U_"Non-existent reminder definition"
 S NUM=$S(FIELD=2:1,FIELD=3:2,1:0)
 I NUM=0 Q -1_U_"Description field not defined"
 I '$D(^PXD(811.9,IEN,NUM,1,0)) Q 0
 ;
 S GLB="^PXD(811.9,"_IEN_","_NUM_")"
 D WPFORMAT(SUB,GLB,0,78)
 Q 1
 ;
 ;Function Finding description
FFIND(SUB,ITEM,FUNCTNUM) ;
 N GLB,FFIEN,IEN,NUM
 K ^TMP(SUB,$J)
 I ITEM=+ITEM S IEN=ITEM
 E  S ITEM=$O(^PXD(811.9,"B",ITEM,""))
 ;perform checks
 I ITEM="" Q -1_U_"Non-existent reminder definition"
 I $D(^PXD(811.9,IEN))<10 Q -1_U_"Non-existent reminder definition"
 I FUNCTNUM="" Q -1_U_"Function Finding number not defined"
 S FFIEN=+$O(^PXD(811.9,IEN,25,"B",FUNCTNUM,""))
 I FFIEN=0 Q -1_U_"Function Number: "_FUNCTNUM_" not found"
 I '$D(^PXD(811.9,IEN,25,FFIEN,20,1,0)) Q 0
 ;
 S GLB="^PXD(811.9,"_IEN_",25,"_FFIEN_",20)"
 D WPFORMAT(SUB,GLB,0,78)
 Q 1
 ;
 ;List Rule description
LIST(SUB,ITEM) ;
 N IEN,NODE
 K ^TMP(SUB,$J)
 I ITEM=+ITEM S IEN=ITEM
 E  S ITEM=$O(^PXRM(810.4,"B",ITEM,""))
 ;perform checks
 I ITEM="" Q -1_U_"Non-existent list rule"
 I $D(^PXRM(810.4,IEN))<10 Q -1_U_"Non-existent list rule"
 ;
 S NODE=$G(^PXRMD(810.4,IEN,0))
 I $P(NODE,U,2)="" Q 0
 I $P(NODE,U,2)'="" S ^TMP(SUB,$J,1,0)=$P(NODE,U,2)
 Q 1
 ;
 ;Order Check Group description
OCG(SUB,ITEM) ;
 N GLB,IEN
 K ^TMP(SUB,$J)
 I ITEM=+ITEM S IEN=ITEM
 E  S ITEM=$O(^PXD(801,"B",ITEM,""))
 ;perform checks
 I ITEM="" Q -1_U_"Non-existent order check group"
 I $D(^PXD(801,IEN))<10 Q -1_U_"Non-existent order check group"
 I '$D(^PXD(801,IEN,1,1,0)) Q 0
 ;
 S GLB="^PXD(801,"_IEN_","_1_")"
 D WPFORMAT(SUB,GLB,0,78)
 Q 1
 ;
 ;Order Check Rules description
OCR(SUB,ITEM) ;
 N GLB,IEN
 K ^TMP(SUB,$J)
 I ITEM=+ITEM S IEN=ITEM
 E  S ITEM=$O(^PXD(801.1,"B",ITEM,""))
 ;Perform checks
 I ITEM="" Q -1_U_"Non-existent order check rule"
 I $D(^PXD(801.1,IEN))<10 Q -1_U_"Non-existent order check rule"
 I '$D(^PXD(801.1,IEN,1,1,0)) Q 0
 ;
 S GLB="^PXD(801.1,"_IEN_","_1_")"
 D WPFORMAT(SUB,GLB,0,78)
 Q 1
 ;
 ;Taxonomy Description
TAX(SUB,ITEM) ;
 N GLB,IEN
 K ^TMP(SUB,$J)
 I ITEM=+ITEM S IEN=ITEM
 E  S ITEM=$O(^PXD(811.2,"B",ITEM,""))
 ;Perform checks
 I ITEM="" Q -1_U_"Non-existent taxonomy"
 I $D(^PXD(811.2,IEN))<10 Q -1_U_"Non-existent taxonomy"
 I '$D(^PXD(811.2,IEN,1,1,0)) Q 0
 ;
 S GLB="^PXD(811.2,"_IEN_","_1_")"
 D WPFORMAT(SUB,GLB,0,78)
 Q 1
 ;
 ;Term Description
TERM(SUB,ITEM) ;
 N GLB,IEN
 K ^TMP(SUB,$J)
 I ITEM=+ITEM S IEN=ITEM
 E  S ITEM=$O(^PXRMD(811.5,"B",ITEM,""))
 ;Perform checks
 I ITEM="" Q -1_U_"Non-existent reminder term"
 I $D(^PXRMD(811.5,IEN))<10 Q -1_U_"Non-existent reminder term"
 I '$D(^PXRMD(811.5,IEN,1,1,0)) Q 0
 ;
 S GLB="^PXRMD(811.5,"_IEN_","_1_")"
 D WPFORMAT(SUB,GLB,0,78)
 Q 1
 ;
 ;Generic Formatter
WPFORMAT(SUB,GBL,RJC,LENGTH) ;
 N DIWF,DIWL,DIWR,IND,NLINES,SC,X
 K ^UTILITY($J,"W")
 S DIWF="|",DIWL=RJC,DIWR=LENGTH
 S IND=0
 F  S IND=$O(@GBL@(IND)) Q:+IND=0  D
 .S X=$G(@GBL@(IND,0))
 .D ^DIWP
 ;Find where this stuff went.
 S SC=$O(^UTILITY($J,"W",""))
 ;Save into ^TMP.
 S NLINES=^UTILITY($J,"W",SC)
 F IND=1:1:NLINES D
 .S ^TMP(SUB,$J,IND,0)=^UTILITY($J,"W",SC,IND,0)
 K ^UTILITY($J,"W")
 Q
 ;
