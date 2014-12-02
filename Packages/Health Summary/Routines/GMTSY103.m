GMTSY103 ;WAT - INSTALL FOR GMTS*2.7*103 ;08/07/13  06:09
 ;;2.7;Health Summary;**103**;Oct 20, 1995;Build 7
 ;
 ;UPDATE^DIE 2053
 ;^DIK 10013
 ;FIND and $$FIND1^DIC 2051
 ;CLEAN^DILF 2054
 ;B/MES^XPDUTL, $$PATCH^XPDUTL 10141
 ;^PXRMEXSI 4371
 ;5687 - allows GMTS to transport Reminder Exchange files in KIDS build
 N GMTSABRT
 I $$PATCH^XPDUTL("GMTS*2.7*103") D BMES^XPDUTL("GMTS*2.7*103 has been previously installed.  Environment check complete.") Q
 D BMES^XPDUTL(" Verifying installation environment...")
 D MES^XPDUTL("Checking Health Summary Component file (#142.1).")
 D MES^XPDUTL("Any environment errors will abort the install and unload the transport global.")
 I $D(^GMT(142.1,257))>0 D
 .D MES^XPDUTL(" Environment Error:  IEN collision with CAT I PT RECORD FLAG STATUS.") S GMTSABRT=1
 .D BMES^XPDUTL("  Health Summary Component file IEN 257 must be empty/non-existent.")
 I +$G(GMTSABRT)<1&(+$$LU(142.1,"CAT I PT RECORD FLAG STATUS","X",,"B")>0) D
 .D MES^XPDUTL(" Environment Error:  NAME collision with CAT I PT RECORD FLAG STATUS.") S GMTSABRT=1
 .D BMES^XPDUTL("  Local Health Summary Component file entry matched to NAME=CAT I PT RECORD FLAG STATUS.")
 I +$G(GMTSABRT)<1&(+$$LU(142.1,"PRF1","X",,"C")>0) D
 .D MES^XPDUTL(" Environment Error:  ABBREVIATION collision with CAT I PT RECORD FLAG STATUS.") S GMTSABRT=1
 .D BMES^XPDUTL("  Local Health Summary Component file entry matched to ABBREVIATION=PRF1.")
 ;
 I +$G(GMTSABRT) D BMES^XPDUTL(" Please re-install GMTS*2.7*103 after the necessary changes have been made.") S XPDABORT=1 Q
 I +$G(GMTSABRT)<1 D BMES^XPDUTL("Environment check passed.  Install will continue...")
 Q
 ;
LU(FILE,NAME,FLAGS,SCREEN,INDEXES) ; call FileMan Finder to look up file entry
 Q $$FIND1^DIC(FILE,"",$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN),"MSGERR")
 ;
PRE ;pre
 D DELEX
 Q
 ;
POST ;post
 D BMES^XPDUTL("Installing Health Summary Component...")
 D CI
 D BMES^XPDUTL("Installing Health Summary Types...")
 D STUB
 D SMEXINS^PXRMEXSI("EXARRAY","GMTSY103")
 Q
 ;
CI ; Component Install
 N GMTSIN,GMTSLIM,GMTSINST,GMTSTL,GMTSINST,GMTSTOT,GMTSBLD,GMTSCPS,GMTSCP,GMTSCI
 S GMTSCPS="PRF1"
 F GMTSCI=1:1 Q:'$L($P(GMTSCPS,";",GMTSCI))  D
 . S GMTSCP=$P(GMTSCPS,";",GMTSCI) K GMTSIN
 . D ARRAY Q:'$D(GMTSIN)
 . I $L($G(GMTSIN("TIM"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"TIM")=$G(GMTSIN("TIM"))
 . I $L($G(GMTSIN("OCC"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"OCC")=$G(GMTSIN("OCC"))
 . S GMTSINST=$$ADD^GMTSXPD1(.GMTSIN),GMTSTOT=+($G(GMTSTOT))+($G(GMTSINST))
 ; Rebuild Ad Hoc Health Summary Type
 D:+($G(GMTSTOT))>0 BUILD^GMTSXPD3
 D LIM
 I +$$ROK("GMTSXPS1")>0 D
 . N GMTSHORT S GMTSHORT=1,GMTSINST="",GMTSBLD="GMTS*2.7*103" D SEND^GMTSXPS1
 Q
ARRAY ; Build Array
 K GMTSIN N GMTSI,GMTSTXT,GMTSEX,GMTSFLD,GMTSUB,GMTSVAL,GMTSPDX S GMTSPDX=1,GMTSCP=$G(GMTSCP) Q:'$L(GMTSCP)
 F GMTSI=1:1 D  Q:'$L(GMTSTXT)
 . S GMTSTXT="",GMTSEX="S GMTSTXT=$T("_GMTSCP_"+"_GMTSI_")" X GMTSEX S:$L(GMTSTXT,";")'>3 GMTSTXT="" Q:'$L(GMTSTXT)
 . S GMTSFLD=$P(GMTSTXT,";",2),GMTSUB=$P(GMTSTXT,";",3),GMTSVAL=$P(GMTSTXT,";",4)
 . S:$E(GMTSFLD,1)=1&(+GMTSFLD<2) GMTSVAL=$P(GMTSTXT,";",4,5)
 . S:$E(GMTSFLD,1)=" "!('$L(GMTSFLD)) GMTSTXT="" Q:GMTSTXT=""
 . S:$L(GMTSFLD)&('$L(GMTSUB)) GMTSIN(GMTSFLD)=GMTSVAL Q:$L(GMTSFLD)&('$L(GMTSUB))  S:$L(GMTSFLD)&($L(GMTSUB)) GMTSIN(GMTSFLD,GMTSUB)=GMTSVAL
 . S:$G(GMTSFLD)=7&(+($G(GMTSUB))>0) GMTSPDX=0
 K:+($G(GMTSPDX))=0 GMTSIN("PDX")
 Q
LIM ; Limits
 N GMTSI,GMTST,GMTSO,GMTSA S GMTSI=0 F  S GMTSI=$O(GMTSLIM(GMTSI)) Q:+GMTSI=0  D
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",3),GMTST=$G(GMTSLIM(+GMTSI,"TIM")) S:'$L(GMTST) GMTST=$S(GMTSA="Y ":"1Y ",1:"")
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",5),GMTSO=$G(GMTSLIM(+GMTSI,"OCC")) S:'$L(GMTSO) GMTSO=$S(GMTSA="Y ":"10 ",1:"")
 . D TO^GMTSXPD3(GMTSI,GMTST,GMTSO)
 Q
ROK(X) ; Routine OK
 S X=$G(X) Q:'$L(X) 0 N GMTSEX,GMTSTXT S GMTSEX="S GMTSTXT=$T(+1^"_X_")" X GMTSEX
 Q:'$L(GMTSTXT) 0  Q 1
 ;
PRF1 ; CAT I PT RECORD FLAG STATUS Component Data
 ;0;;257
 ;.01;;CAT I PT RECORD FLAG STATUS
 ;1;;EN;GMTSRFHX
 ;1.1;;0
 ;2;;
 ;3;;PRF1
 ;3.5;;4
 ;3.5;1;This component displays the Active and Inactive Category 1 Patient Record
 ;3.5;2;Flags assigned to a given patient.  The full assignment history is
 ;3.5;3;included with each instance of flag assignment.  Active flag assignments
 ;3.5;4;are displayed first, followed by Inactive flag assignments.
 ;4;;
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 ;
 Q
 ;
STUB ;create stub entries
 ;UPDATE^DIE(FLAGS,FDA_ROOT,IEN_ROOT,MSG_ROOT)
 D BMES^XPDUTL("Creating stub entries for Remote Health Summary Type.")
 D DELRTYPE
 N FDA,MSG,HSIEN,NAME,NUMBER
 S FDA(142,"+1,",.01)="REMOTE PT RECORD FLAG STATUS"
 S HSIEN(1)=5000021
 D UPDATE^DIE("","FDA","HSIEN","MSG")
 I $D(MSG)>0 D AWRITE("MSG")
 D CLEAN^DILF
 Q
 ;
DELRTYPE ;remove previous version of type
 D BMES^XPDUTL("Removing any previous version of Remote Health Summary Type")
 N DA,DIK,X,Y
 S DIK="^GMT(142,"
 S DA=5000021 D ^DIK
 S DA=$O(^GMT(142,"B","REMOTE PT RECORD FLAG STATUS","")) D:+$G(DA) ^DIK
 Q
 ;
DELEX ;remove prior version of exchange entry
 N ARRAY,IC,IND,LIST,GMTSVAL,NUM
 D BMES^XPDUTL("Cleaning up any previous versions of Reminder Exchange file entry")
 D EXARRAY("L",.ARRAY)
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:'IC  D
 . S GMTSVAL(1)=ARRAY(IC,1)
 . D FIND^DIC(811.8,"","","U",.GMTSVAL,"","","","","LIST")
 . I '$D(LIST) Q
 . S NUM=$P(LIST("DILIST",0),U,1)
 . I NUM'=0 D
 .. F IND=1:1:NUM D
 ... N DA,DIK
 ... S DIK="^PXD(811.8,"
 ... S DA=LIST("DILIST",2,IND)
 ... D ^DIK
 Q
 ;
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-HS TYPES GMTS*2.7*103"
 I MODE["I" S ARRAY(LN,2)="07/18/2013@12:40:38"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 Q
 ;
AWRITE(REF) ;Write all the descendants of the array reference.
 ;REF is the starting array reference, for example A or ^TMP("PXRM",$J).
 ;coied from PXRMUTIL
 N DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP,GMTSTEXT
 I REF="" Q
 S LN=0
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S LN=LN+1,GMTSTEXT(LN)=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 D MES^XPDUTL(.GMTSTEXT)
 Q
 ;
