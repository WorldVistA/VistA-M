XUMF4 ;OIFO-OAK/RAM - Institution File Clean Up; 06/28/00
 ;;8.0;KERNEL;**206,209,212,261**;Jul 10, 1995
 ;
 ;
EN ; -- entry point
 ;
 K ^TMP("XUMF ARRAY",$J)
 ;
 N PARAM,XUMFLAG,ERROR,TEST,ERR
 ;
 S (ERROR,XUMFLAG,TEST)=0
 ;
 I $P($$PARAM^HLCS2,U,3)="T" S TEST=1
 ;
 L +^TMP("XUMF ARRAY",$J):0 D:'$T
 .S ERROR="1^another process is using the Master File Server"
 ;
 I ERROR D EXIT1 Q
 ;
 I '$D(^TMP("XUMF ARRAY",$J)) D
 .W !!,"...connecting with master file server..."
 .D MFS0
 ;
 I ERROR D EXIT1 Q
 ;
 I '$D(^TMP("XUMF ARRAY",$J)) D  D EXIT1 Q
 .S ERROR="1^Connection to master file server failed!"
 ;
 D FTCLEAN^XUMF4A I ERROR D EXIT1 Q
 ;
 K ^TMP("XUMF ARRAY",$J),^TMP("XUMF MFS",$J)
 ;
 W !!,"...connecting with master file server..."
 D MFS1
 ;
 I ERROR D EXIT1 Q
 ;
 I '$D(^TMP("XUMF ARRAY",$J)) D  Q
 .S ERROR="1^Connection to master file server failed!"
 .D EXIT1
 ;
 D EN^VALM("XUMF NAME")
 ;
 D EXIT1
 ;
 Q
 ;
RDSN ; - resolve duplicate station number
 ;
 I '$O(@VALMAR@("INDEX",0)) D  Q
 .W !!,"No duplicates to select from!",!
 .S VALMBCK="R" H 2
 ;
 N ENTRY,VALMY,DA,DR,DIE,STA,MERGED,FROM
 ;
 D EN^VALM2(XQORNOD(0),"OS")
 Q:'$D(VALMY)  Q:'$D(VALMAR)
 ;
 S DA=@VALMAR@("INDEX",+$O(VALMY(0)))
 S DR="99///@",DIE=4
 I DA D
 .I $O(^HLCS(870,"C",DA,0)) D  Q
 ..W !!?20,"Pointed to by HL7 Logical Link"
 ..W !?22,"*select other entry*",!!
 .D ^DIE
 ;
 D @($E($P(VALMAR,"XUMF ",2),1,4)_"^XUMF4")
 S VALMBCK="R"
 ;
 Q
 ;
 ;
DSTA ; -- duplicate station #s
 ;
 K ^TMP("XUMF DSTA",$J),^TMP("XUMF TMP",$J)
 ;
 I 'XUMFLAG D LOCAL
 ;
 S STA="",IEN=0
 F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  D
 .F  S IEN=$O(^DIC(4,"D",STA,IEN)) Q:'IEN  D
 ..Q:'$D(^TMP("XUMF ARRAY",$J,STA))
 ..S ^TMP("XUMF TMP",$J,STA,IEN)=$P(^DIC(4,IEN,0),U)
 ;
 S STA="",(VALMCNT,IEN)=0
 F  S STA=$O(^TMP("XUMF TMP",$J,STA)) Q:STA=""  D
 .Q:'$O(^TMP("XUMF TMP",$J,STA,+$O(^TMP("XUMF TMP",$J,STA,0))))
 .F  S IEN=$O(^TMP("XUMF TMP",$J,STA,IEN)) Q:'IEN  D
 ..S VALMCNT=VALMCNT+1
 ..S VAR="",NAME=$P(^TMP("XUMF TMP",$J,STA,IEN),U)
 ..S VAR=$$SETFLD^VALM1(VALMCNT,VAR,"ENTRY NUMBER")
 ..S VAR=$$SETFLD^VALM1(STA,VAR,"STATION NUMBER")
 ..S VAR=$$SETFLD^VALM1(NAME,VAR,"INSTITUTION NAME")
 ..S VAR=$$SETFLD^VALM1(IEN,VAR,"IEN")
 ..D SET^VALM10(VALMCNT,VAR,VALMCNT)
 ..S @VALMAR@("INDEX",VALMCNT)=IEN
 ;
 D:'VALMCNT
 .S VAR="",VAR=$$SETFLD^VALM1("***No duplicates***",VAR,"INSTITUTION NAME")
 .S VALMCNT=1
 .D SET^VALM10(VALMCNT,VAR,VALMCNT)
 ;
 K ^TMP("XUMF TMP",$J)
 ;
 Q
 ;
LOCAL ; -- auto-delete local/duplicate station numbers
 ;
 W !!,"This action will auto-delete local/duplicate station numbers."
 N Y S DIR(0)="Y",DIR("B")="YES" W !
 S DIR("A")="Do you wish to proceed"
 D ^DIR K DIR I 'Y Q
 ;
 S XUMFLAG=1
 D DXRF
 ;
 N IEN,STA,STANUM,VAR,NAME,FLAG,CNT
 ;
 S STA="",(IEN,CNT)=0
 F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  D
 .Q:'$O(^DIC(4,"D",STA,+$O(^DIC(4,"D",STA,0))))
 .S FLAG=0
 .F  S IEN=$O(^DIC(4,"D",STA,IEN)) Q:'IEN  D
 ..S:$O(^HLCS(870,"C",IEN,0)) FLAG=1
 .Q:'FLAG
 .F  S IEN=$O(^DIC(4,"D",STA,IEN)) Q:'IEN  D
 ..Q:$O(^HLCS(870,"C",IEN,0))
 ..W !?5,"deleting duplicate station number ",STA," from IEN: ",IEN
 ..H 1
 ..S DR="99///@",DIE=4,DA=IEN,CNT=CNT+1
 ..N IEN,STA,FLAG D ^DIE
 I CNT D EOP S CNT=0
 ;
 S STA="",IEN=0
 F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  D
 .Q:$D(^TMP("XUMF ARRAY",$J,STA))
 .Q:'$D(^TMP("XUMF ARRAY",$J))
 .F  S IEN=$O(^DIC(4,"D",STA,IEN)) Q:'IEN  D
 ..S DR="99///@",DIE=4,DA=IEN,CNT=CNT+1
 ..W !?5,"deleting local station number ",STA," from IEN: ",IEN
 ..H 1
 ..N IEN,STA D ^DIE
 I CNT D EOP S CNT=0
 ;
 Q
 ;
 ;
DXRF ; -- re-index "D" cross-reference
 ;
 N DIK
 ;
 K ^DIC(4,"D")
 ;
 S DIK="^DIC(4,",DIK(1)="99^D" D ENALL^DIK
 ;
 Q
 ;
 ;
LLCL ; -- local data
 ;
 K ^TMP("XUMF LLCL",$J)
 ;
 N STA,IEN,STANUM,VAR,NAME,FTYP
 ;
 S STA="",VALMCNT=0
 F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  D
 .S IEN=$O(^DIC(4,"D",STA,0))
 .S FTYP=$P($G(^DIC(4.1,+$G(^DIC(4,+IEN,3)),0)),U)
 .Q:$D(^TMP("XUMF ARRAY",$J,STA))
 .S VALMCNT=VALMCNT+1
 .S VAR="",NAME=$P(^DIC(4,IEN,0),U)
 .S VAR=$$SETFLD^VALM1(STA,VAR,"STATION NUMBER")
 .S VAR=$$SETFLD^VALM1(NAME,VAR,"INSTITUTION NAME")
 .S VAR=$$SETFLD^VALM1(IEN,VAR,"IEN")
 .S VAR=$$SETFLD^VALM1(FTYP,VAR,"FACILITY TYPE")
 .D SET^VALM10(VALMCNT,VAR,VALMCNT)
 .S @VALMAR@("INDEX",VALMCNT)=IEN
 ;
 D:'VALMCNT
 .S VAR="",VAR=$$SETFLD^VALM1("***None found***",VAR,"INSTITUTION NAME")
 .D SET^VALM10(1,VAR,1)
 ;
 Q
 ;
 ;
NATL ; -- national data to merge
 ;
 K ^TMP("XUMF NATL",$J)
 ;
 N STA,VAR,NAME,TYPE,STATE
 ;
 S STA="",VALMCNT=0
 F  S STA=$O(^TMP("XUMF ARRAY",$J,STA)) Q:STA=""  D
 .Q:$D(^DIC(4,"D",STA))
 .S VALMCNT=VALMCNT+1
 .S VAR="",NAME=$P(^TMP("XUMF ARRAY",$J,STA),U,2)
 .S TYPE=$P($P(^TMP("XUMF ARRAY",$J,STA),U,5),"~")
 .S STATE=$P(^TMP("XUMF ARRAY",$J,STA),U,8)
 .S VAR=$$SETFLD^VALM1(STA,VAR,"STATION NUMBER")
 .S VAR=$$SETFLD^VALM1(NAME,VAR,"NATIONAL NAME")
 .S VAR=$$SETFLD^VALM1(STATE,VAR,"STATE")
 .S VAR=$$SETFLD^VALM1(TYPE,VAR,"TYPE")
 .D SET^VALM10(VALMCNT,VAR,VALMCNT)
 ;
 D:'VALMCNT
 .S VAR="",VAR=$$SETFLD^VALM1("***None found***",VAR,"NATIONAL NAME")
 .D SET^VALM10(1,VAR,1)
 ;
 Q
 ;
 ;
NAME ; -- compare INSTITUTION name vs national name
 ;
 K ^TMP("XUMF NAME",$J),^TMP("XUMF TABLE",$J)
 ;
 N STA,IEN,NAME,GOLD,NAME,VAR,ARRAY
 ;
 D DXRF
 ;
 S STA="",(IEN,VALMCNT)=0
 F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  D
 .S IEN=$O(^DIC(4,"D",STA,0))
 .S GOLD=$P($G(^TMP("XUMF ARRAY",$J,STA)),U,2)
 .S NAME=$P(^DIC(4,IEN,0),U)
 .S ^TMP("XUMF TABLE",$J,STA,IEN)=NAME_U_GOLD
 ;
 F  S STA=$O(^TMP("XUMF ARRAY",$J,STA)) Q:STA=""  D
 .Q:$D(^TMP("XUMF TABLE",$J,STA))
 .S NAME=$P(^TMP("XUMF ARRAY",$J,STA),U,2)
 .S ^TMP("XUMF TABLE",$J,STA,9999)="^"_NAME
 ;
 S (IEN,VALMCNT)=0
 F  S STA=$O(^TMP("XUMF TABLE",$J,STA)) Q:STA=""  D
 .F  S IEN=$O(^TMP("XUMF TABLE",$J,STA,IEN)) Q:'IEN  D
 ..S GOLD=$P(^TMP("XUMF TABLE",$J,STA,IEN),U,2)
 ..S NAME=$P(^TMP("XUMF TABLE",$J,STA,IEN),U)
 ..S VALMCNT=VALMCNT+1,VAR=""
 ..S VAR=$$SETFLD^VALM1(STA,VAR,"STATION NUMBER")
 ..S VAR=$$SETFLD^VALM1(NAME,VAR,"INSTITUTION NAME")
 ..S VAR=$$SETFLD^VALM1(GOLD,VAR,"GOLD NAME")
 ..D SET^VALM10(VALMCNT,VAR,VALMCNT)
 ;
 D:'VALMCNT
 .S VAR="",VAR=$$SETFLD^VALM1("***None found***",VAR,"INSTITUTION NAME")
 .D SET^VALM10(1,VAR,1)
 ;
 K ^TMP("XUMF TABLE",$J)
 ;
 Q
 ;
 ;
MFS0 ; -- get national facility type file from Master File Server
 ;
 D FACTYP^XUMF4A
 D STATE^XUMF4A
 ;
 S PARAM("LLNK")="XUMF MFR^XUMF "_$S('TEST:"FORUM",1:"TEST")
 S PARAM("PROTOCOL")=$O(^ORD(101,"B","XUMF MFQ",0))
 ;
 W !!,"...getting FACILITY TYPE file..."
 D MAIN^XUMFP(4.1,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFI(4.1,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFH
 ;
 Q
 ;
MFS1 ; -- get national facility type file from Master File Server
 ;
 S PARAM("LLNK")="XUMF MFR^XUMF "_$S('TEST:"FORUM",1:"TEST")
 S PARAM("PROTOCOL")=$O(^ORD(101,"B","XUMF MFQ",0))
 ;
 W !!,"...getting INSTITUTION file..."
 W !,"...please wait...(approx. 5 minutes)..."
 D MAIN^XUMFP(4,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFI(4,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFH
 ;
 Q
 ;
EXIT ; -- cleanup and quit
 ;
 K:$D(VALMAR) @VALMAR
 ;
 Q
 ;
EXIT1 ;
 ;
 K ^TMP("XUMF ARRAY",$J),^TMP("XUMF MFS",$J)
 K ^TMP("DIERR",$J)
 ;
 L -^TMP("XUMF ARRAY",$J)
 ;
 I ERROR D
 .N XMY S XMY("G.XUMF INSTITUTION")=""
 .D EM^XUMFH(ERROR,.ERR,"IFR CLEANUP",.XMY)
 .W !!,ERROR,!,$G(ERR),!
 ;
 Q
 ;
EOP ; -- End-of-Page
 ;
 S DIR(0)="E"
 D ^DIR,CLEAR^VALM1
 S VALMBCK="R"
 ;
 Q
 ;
