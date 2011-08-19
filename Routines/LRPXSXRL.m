LRPXSXRL ; SLC/PKR - Build indexes for Lab. ;9/27/03  22:37
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
 Q
 ;===============================================================
LAB ; this entry point is called to rebuild ALL Lab indexes in ^PXRMINDX(63
 ; dbia 4247
 ;Build the indexes for LAB DATA.
 N DAE,DAS,DAT,DATE,DFN,DNODE,END,ENTRIES,ETEXT,GLOBAL,IND
 N LRDFN,LRDN,LRIDT,NE,NERROR
 N START,TEMP,TENP,TEST,TEXT
 K ^TMP("LRPXTEST",$J)
 ;Dont leave any old stuff around.
 D CLEANL
 S GLOBAL=$$GET1^DID(63,"","","GLOBAL NAME")_"""CH"")"
 S NERROR=0
 S ENTRIES=$P(^LR(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for LAB DATA - CH")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (IND,NE)=0
 K ^TMP("LRPXSXRL",$J)
 S TEST=0
 F  S TEST=$O(^LAB(60,TEST)) Q:TEST<1  D  ; preset values (lrdn)=test#
 . S DNODE=$P($G(^LAB(60,TEST,0)),U,5)
 . I $P(DNODE,";")'="CH" Q
 . I $P(DNODE,";",3)'=1 Q
 . S LRDN=+$P(DNODE,";",2)
 . I 'LRDN Q
 . S ^TMP("LRPXSXRL",$J,LRDN)=TEST_U_$D(^TMP("LRPXSXRL",$J,LRDN))
 S LRDFN=.9
 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  D
 . S TEMP=$G(^LR(LRDFN,0))
 . I $P(TEMP,U,2)'=2 Q
 . S DFN=+$P(TEMP,U,3)
 . I LRDFN'=$$LRDFN^LRPXAPIU(DFN) Q
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . S LRIDT=0
 . F  S LRIDT=$O(^LR(LRDFN,"CH",LRIDT)) Q:LRIDT<1  D
 .. I '$P($G(^LR(LRDFN,"CH",LRIDT,0)),U,3) Q  ; check for completed
 .. S DAT=LRDFN_";CH;"_LRIDT
 .. S DATE=9999999-LRIDT
 .. S LRDN=1
 .. F  S LRDN=$O(^LR(LRDFN,"CH",LRIDT,LRDN)) Q:LRDN<1  D
 ... S DAS=DAT_";"_LRDN
 ... S TEMP=^LR(LRDFN,"CH",LRIDT,LRDN)
 ... S TEST=+$P($P(TEMP,U,3),"!",6) ; get test, use ^LR node
 ... I 'TEST D  ; if not available on ^LR node
 .... I $P($G(^TMP("LRPXSXRL",$J,LRDN)),U,2) D  ; if duplicates, use file 60
 ..... S TEST=+$O(^LAB(60,"C","CH;"_$G(LRDN)_";1",0))
 .... E  S TEST=+$G(^TMP("LRPXSXRL",$J,LRDN)) ; otherwise, use preset value
 ... I 'TEST D
 .... S DAE=LRDFN_","_"""CH"""_","_LRIDT_","_LRDN
 .... S ETEXT=DAE_" No lab test"
 .... I $D(^TMP("LRPXTEST",$J,LRDN)) Q
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) ; dbia 4113
 .... S ^TMP("LRPXTEST",$J,LRDN)=""
 ... E  D
 .... D SLAB^LRPX(DFN,DATE,TEST,DAS)
 .... S NE=NE+1
 K ^TMP("LRPXSXRL",$J),^TMP("LRPXTEST",$J)
 S TEXT=NE_" LAB DATA (CH) results indexed."
 D MES^XPDUTL(TEXT)
 S END=$H
 D DETIME^PXRMSXRM(START,END) ; dbia 4113
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL) ; dbia 4113
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR) ; dbia 4113
 ;
 D AP^LRPXSXRA
 D MICRO^LRPXSXRB
 Q
 ;
FRESH ; deletes all Lab, Micro, and AP ^PXRMINDX(63 indexes
 K ^PXRMINDX(63) ; dbia 4114
 Q
 ;
CLEANL ;
 D BMES^XPDUTL("Cleaning up old Lab entries")
 D FRESH ; remove all lab indexes
 Q
 ;
RESETAP ; reindex AP
 D BMES^XPDUTL("Reindex Anatomic Pathology Data")
 D REMOVE("A")
 D AP^LRPXSXRA
 Q
 ;
RESETMI ; reindex Micro
 D BMES^XPDUTL("Reindex Microbiology Data")
 D REMOVE("M")
 D MICRO^LRPXSXRB
 Q
 ;
RESETAM ; reindex AP and Micro
 D RESETAP
 D RESETMI
 Q
 ;
REMOVE(TYPE) ; remove these types of indexes
 N DATE,DFN,ITEM,REF,STOP
 S STOP=TYPE_"Z"
 S ITEM=TYPE
 F  S ITEM=$O(^PXRMINDX(63,"IP",ITEM)) Q:ITEM=""  Q:ITEM]STOP  D
 . S DFN=0
 . F  S DFN=$O(^PXRMINDX(63,"IP",ITEM,DFN)) Q:DFN<1  D
 .. S DATE=0
 .. F  S DATE=$O(^PXRMINDX(63,"IP",ITEM,DFN,DATE)) Q:DATE<1  D
 ... S REF=""
 ... F  S REF=$O(^PXRMINDX(63,"IP",ITEM,DFN,DATE,REF)) Q:REF=""  D
 .... D KLAB^LRPX(DFN,DATE,ITEM,REF)
 Q
