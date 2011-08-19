XUGOT ; DBA/CJS - COMPARE LOCAL/NATIONAL CHECKSUMS REPORT ;10/20/2006
 ;;8.0;KERNEL;**369**;Jul 10, 1995;Build 27
 Q
LOAD ; -- use MFS to get ROUTINE file from FORUM (background job)
 W !!,">>>This processing will take about thirty minutes. Please wait..."
 D CLEAN
 D ARRAY^XUMF(9.8)
 D INPUT
 Q
 ;----------------------------
CLEAN ; clean all entries in subfile 9.818 if $G(^DIC(9.8,RTNIEN,6))=2 (national tracking)
 N RTNIEN,XUTR S RTNIEN=0
 F  S RTNIEN=$O(^DIC(9.8,RTNIEN)) Q:RTNIEN'>0  D
 . S XUTR=$P($G(^DIC(9.8,RTNIEN,6)),"^")
 . I XUTR="National - report" S XUTR=2
 . I XUTR=2 D CLN(RTNIEN) S $P(^DIC(9.8,RTNIEN,6),"^")=""
 Q
 ;------------------------------
CLN(RTNIEN) ; clean all entries in sub-file #9.818
 N XI S XI=0 F  S XI=$O(^DIC(9.8,RTNIEN,8,XI)) Q:XI'>0  D
 . N DA,DIK S DA(1)=RTNIEN,DA=XI,DIK="^DIC(9.8,"_DA(1)_","_"8," D ^DIK
 Q
 ;------------------------------
INPUT ; input routines' information in Routine file
 N IDX98,ERROR,NAME,HLFS,XXX,YYY,ZZZ,AAA,BBB,CCC,FDA,X,HFLS,NODE,XUSIEN
 S HLFS="^",IDX98=0
 F  S IDX98=$O(^TMP("XUMF ARRAY",$J,IDX98)) Q:'IDX98  D
 .S NODE=$G(^TMP("XUMF ARRAY",$J,IDX98)),NODE=$P(NODE,"^",2,99)
 .S NAME=$P(NODE,HLFS,1)
 . I $L(NAME)>8 Q
 .S XXX=$P(NODE,HLFS,2)
 . I XXX'="National - report" Q
 .S YYY=$P(NODE,HLFS,3)
 .S ZZZ=$P(NODE,HLFS,4)
 . I +$E(ZZZ,2,10)'>0 Q
 .S AAA=$P(NODE,HLFS,5)
 .S BBB=$P(NODE,HLFS,6)
 .S CCC=$P(NODE,HLFS,7)
 .S FDA(1,9.8,"?+1,",.01)=NAME
 .S FDA(1,9.8,"?+1,",1)="R"
 .;S FDA(1,9.8,"?+1,",6)=2
 .S FDA(1,9.8,"?+1,",7.1)=YYY
 .S FDA(1,9.8,"?+1,",7.2)=ZZZ
 .S FDA(1,9.8,"?+1,",7.3)=CCC
 .S FDA(1,9.818,"+2,?+1,",.01)=AAA
 .S FDA(1,9.818,"+2,?+1,",2)=BBB
 .D UPDATE^DIE("","FDA(1)")
 .D SETFLD6(NAME)
 ;
 K ^TMP("XUMF ARRAY",$J)
 Q
 ;
SETFLD6(NAME) ;
 N XUIEN S XUIEN=0
 S XUIEN=$$FIND1^DIC(9.8,"","MX",NAME,"","","ERR")
 I XUIEN'>0 Q
 I $P($G(^DIC(9.8,XUIEN,6)),"^")="" S $P(^DIC(9.8,XUIEN,6),"^")=2
 Q
 ; -------------------- FOR XUGOT1-------------------------------
PACK(RTN,SL) ; get package name
 N XUS,XUS1,XUS2 S (XUS,XUS1,XUS2)=""
 S XUS=$$RT(RTN) I XUS'>0 Q ""
 S XUS2=$P(XUS,"^",2)
 S XUS1=$$SL(SL) I XUS1'="" S XUS2=XUS1
 Q XUS2_"*"_+$P(XUS,"^",3)_"*"
 ;
XUN4(XUS) ;
 N XUN4,XUA,XUB,XUC
 I $G(XUS)="" Q ""
 S XUN4=+$P(XUS,"*",2) ;Last Version number from the last patch name
 I XUN4>0 Q XUN4
 S XUA=$L(XUS)
 F XUB=1:1:XUA S XUN4=+$E(XUS,XUB,XUA) I XUN4>0 Q
 Q XUN4
NPL2(IEN) ; get Package name from Patch multiple
 I '$D(^DIC(9.8,IEN,8,0)) Q ""
 N XUIEN,XUPK,XUPK1,XUPK2 S (XUPK2,XUPK1,XUPK)="",XUIEN=0
 F  S XUIEN=$O(^DIC(9.8,IEN,8,XUIEN)) Q:XUIEN'>0  D
 . S XUA=$G(^DIC(9.8,IEN,8,XUIEN,0)),XUPK2=$P(XUA,"^"),XUPK=$P(XUPK2,"*"),XUPK2=$P(XUPK2,"*",2)
 . I XUPK'="",$D(^DIC(9.4,"C",XUPK)) S XUPK1=XUPK_"*"_XUPK2
 Q XUPK1
 ;
LSLPN(SL) ; return package name from the second line (piece 3rd of the second line)
 Q $$TRIM^XLFSTR($P(SL,";",4))
 ;
SL(SL) ; get Prefix_Package from the second line
 N PCK,XUST,XUIEN,Y,X
 S (PCK,XUIEN)="",XUST=$$LSLPN(SL)
 S X=XUST X ^%ZOSF("UPPERCASE") I Y'="" S XUIEN=$O(^DIC(9.4,"B",Y,0))
 I XUIEN S PCK=$P($G(^DIC(9.4,XUIEN,0)),"^",2)
 Q PCK
 ;
 ;-----------------------CHECK PACKAGE NAME AND VERSION---------------------------
RT(RTN) ; get Package and Version base on routine name
 I $G(RTN)="" Q ""
 N XUST,VERSION,XUIEN,XUI,PCK,PCKNAME,XUQUIT S (PCK,PCKNAME,XUST,VERSION)="",XUIEN=""
 F XUI=4,3,2 I $D(^DIC(9.4,"C",$E(RTN,1,XUI))) D  Q:XUIEN>0
 . S XUIEN=$O(^DIC(9.4,"C",$E(RTN,1,XUI),0)) ;IEN FOR PACKAGE
 . I XUIEN="" S XUIEN=-1 Q  ;no package found (yet)
 . I $D(^DIC(9.4,XUIEN,0)) S XUST=$G(^DIC(9.4,XUIEN,0)),VERSION=$G(^DIC(9.4,XUIEN,"VERSION")),PCKNAME=$P(XUST,"^",1),PCK=$P(XUST,"^",2)
 Q XUIEN_"^"_PCK_"^"_VERSION_"^"_PCKNAME
 ;
GETSL(RTN) ;
 N XUSL
 N DIF,XCNP K ^TMP($J,369)
 S DIF="^TMP($J,369,",XCNP=0 X ^%ZOSF("LOAD")
 Q $G(^TMP($J,369,2,0))
