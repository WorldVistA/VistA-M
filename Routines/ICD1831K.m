ICD1831K   ; ALB/ECF - FY 2007 UPDATE; 10/23/07 2:50 pm;
 ;;18.0;DRG Grouper;**31**;Oct 13,2000;Build 7
 Q
 ;
DRG(ICDTMP) ;post-install driver for file ICD Operation/Procedure
 ; file(#80.1) DRG updates
 ;This procedure loops through the ICD OPERATION/PROCDURE file (80.1)
 ;to create a DRG GROUPER EFFECTIVE DATE entry for FY08 
 ; Input:
 ;   ICDTMP - Temp file of error msg's
 ; Output:
 ;   ICDTMP - Temp file of error msg's
 ;   ICDTOT - Total MS-DRG codes filed
 ;   ICDERTOT - Total error records - cannot file
 ;
 N ICDI,ICDCRCD,ICDFOK,ICDNWCD,ICDTOT,ICDX,ICDY,ICDVAL,ICDETOT,ICDYY,ICDZZ
 S U="^"
 ;
 D BMES^XPDUTL(">>> Adding FY08 DRG Grouper updates to ICD OP/PR file (#80.1)...")
 ;Error log
 S ICDTMP=$G(ICDTMP)
 I ICDTMP']"" S ICDTMP=$NA(^TMP("ICDDGFY2008OP",$J)) D
 . K @ICDTMP
 . S @ICDTMP@(0)="PATCH #? FY08 ICD DIAG DRG UPDATE^"_$$NOW^XLFDT
 ;
 ;Skip inactive
 S (ICDETOT,ICDI,ICDTOT,ICDYY)=0
 ;
 F  S ICDI=$O(^ICD0(ICDI)) Q:ICDI=""!(ICDI'?.N)  D
 .;quit if no zero node
 .Q:$G(^ICD0(ICDI,0))=""
 .;quit if zero node corrupt
 .Q:$P($G(^ICD0(ICDI,0)),U)']""
 .S ICDVAL=$P($G(^ICD0(ICDI,0)),U)
 .Q:ICDVAL=""
 .;quit if code is inactive
 .S ICDZZ=$$ICDOP^ICDCODE(ICDVAL,3071001) Q:$P($G(ICDZZ),U,10)=0
 .;check if already created in case patch being re-installed
 .Q:$D(^ICD0(ICDI,2,"B",3071001))
 .;
 .;Get ien of latest Grouper Effective Date
 .S ICDX=$O(^ICD0(ICDI,2,"B",9999999),-1)
 .;No Grp Eff Dt means this is a new code
 .I ICDX']"" D
 ..;Call API
 ..K ICDNCDAR
 ..D NEW801^ICD1831L(ICDVAL,.ICDNCDAR)
 ..Q:'$D(ICDNCDAR)
 ..;Build code array for UPDDIAG()
 ..K ICDCONAR
 ..D GETNCRCD(ICDI,.ICDNCDAR,.ICDCONAR)
 ..Q:'$D(ICDCONAR(0))
 ..D UPDDIAG(ICDI,.ICDCONAR,.ICDTOT)
 .;
 .I ICDX]"" D
 ..;Old codes to convert
 ..;Call will be $$CONV801^ICD1831L(<ien of code>)for each MDC/DRG set
 ..S ICDLEDI=$O(^ICD0(ICDI,2,"B",ICDX,0))
 ..S (ICDFYMI,ICDY)=0
 ..;Loop through MDCs for this ICD PROC - DRG EFF DATE
 ..F  S ICDFYMI=$O(^ICD0(ICDI,2,ICDLEDI,1,ICDFYMI)) Q:ICDFYMI=""!(ICDFYMI'?.N)  D
 ...K ICDNWCD,ICDNWCDA
 ...S ICDDGCD=$$GETCRCD(ICDI,ICDLEDI,ICDFYMI) ;Build code string for conversion API 
 ...;If no code string for this MDC, nothing to convert
 ...Q:ICDDGCD']""
 ...;Code string is ok, pass to conversion function
 ...S ICDNWCD=$$CONV801^ICD1831L(ICDDGCD)
 ...;Return codes are in string ICDCRCD <.01>^<MDC ien>^<DRG ien)^<DRG ien>.........
 ...;Filer requires an array - at least a zero node is needed
 ...I ICDNWCD]"" K ICDNWCDA S ICDNWCDA(0)=ICDNWCD
 ...;Now process the array of code strings for this ICD Proc IEN
 ...Q:ICDNWCDA(0)']""
 ...;pass new codes to update procedure
 ...;D UPDDIAG(ICDI,"X",.ICDNWCDA,.ICDTOT)
 ...D UPDDIAG(ICDI,.ICDNWCDA,.ICDTOT)
 ...K ICDNWCDA
 .
 ;Back to top level - processing is over - do final tasks
 K ICDCONAR,ICDDGCD,ICDETOT,ICDFYMI,ICDNCDAR,ICDNWCDA
 ;HANDLE ERRORS
 ;No errors present
 ;
 S (ICDTOT,ICDYY)=0
 F  S ICDYY=$O(^TMP("ICDFILEOK",$J,ICDYY)) Q:ICDYY=""  I ^TMP("ICDFILEOK",$J,ICDYY)=1 S ICDTOT=ICDTOT+1
 I '$D(@ICDTMP@("ERROR")) D
 . D MES^XPDUTL(">>> ICD PROCEDURE File DRG Updates Completed...")
 . D MES^XPDUTL("    ...Total Codes Edited: "_ICDTOT)
 . D MES^XPDUTL("")
 Q
 ;Errors present
 ;
 I $D(@ICDTMP@("ERROR")) D
 . F  S ICDXX=$O(^TMP("ICDDGFY2008OP",$J,"ERROR",ICDXX)) Q:ICDXX=""  D
 ..S ICDETOT=ICDETOT+1
 . D MES^XPDUTL(">>> ...Total Errors "_ICDETOT_" ERRORS")
 . D MES^XPDUTL("")
 . D MES^XPDUTL("Error are in ^TMP(""ICDDGFY2008OP"",$J)")
 ;
 K ICDCRCD,ICDVAL,ICDZZ
 K ^TMP("ICDFILEOK")
 Q
 ;
 ;END OF DRIVER
 ;Start of helper functions and procedures
 ;
GETCRCD(ICDIEN,ICDDGIEN,ICDMDIEN) ;
 ;Create input string for conversion API - only for non-New DRGs
 ;
 ;INPUT    ICDIEN   = ien in file 80.1 ICD OPERATION/PROCEDURE
 ;         ICDDGIEN = ien of last DRG GROUPER EFFECTIVE DATE
 ;         ICDMDIEN = ien of Major Diagnostic Category
 ;OUTPUT   ICDCRDCS = string of codes formatted for API
 ;                   
 N ICDCRCDS,ICDXS
 ;
 S (ICDCRCD)=""
 S (ICDX)=0
 ;
 ;START STRING WITH THE .01 FIELD
 S ICDCRCDS=$P(^ICD0(ICDI,0),U)
 ;
 ;Add MDC ien to string
 S ICDCRCDS=ICDCRCDS_"^"_$P($G(^ICD0(ICDIEN,2,ICDDGIEN,1,ICDMDIEN,0)),U)
 ;
 ;Loop thru DRGs this ICD procedure, this eff date, this MDC
 ;
 F  S ICDX=$O(^ICD0(ICDIEN,2,ICDDGIEN,1,ICDMDIEN,1,ICDX)) Q:ICDX=""!(ICDX'?.N)  D
 .Q:$G(^ICD0(ICDIEN,2,ICDDGIEN,1,ICDMDIEN,1,ICDX,0))=""
 .S ICDCRCDS=ICDCRCDS_"^"_$P($G(^ICD0(ICDIEN,2,ICDDGIEN,1,ICDMDIEN,1,ICDX,0)),U)
 Q ICDCRCDS
 ;
GETNCRCD(ICDIENP,ICDOAR,ICDCAR) ;
 ;Quit if input not correct, passing back a null zero node
 I '$D(ICDIENP) S ICDCAR(0)="" Q
 ;
 N ICDK,ICDJ,ICDL
 S (ICDJ,ICDK,ICDL)=0
 F  S ICDJ=$O(ICDOAR(ICDJ)) Q:ICDJ=""  D
 .S ICDCAR(ICDL)=ICDIENP_"^"_ICDJ_"^"
 .F  S ICDK=$O(ICDOAR(ICDJ,ICDK)) Q:ICDK=""  D
 ..S ICDCAR(ICDL)=ICDCAR(ICDL)_ICDK_"^"
 .S ICDL=ICDL+1
 Q
 ;
 ;
UPDDIAG(ICDIP,ICDNWCDA,ICDTOTP) ; 
 ;File 80.1 updater
 ;
 N ICDX1
 ; F ICDZ=1:1:3 I $P(ICDIAGP,U,ICDZ)']"" D Q
 ; .S @ICDTMP@("ERROR",ICDIP,"80.1")="Missing field "_ICDZ_" filing "_ICDIAGP
 ; 
 ;Quit if complete data not passed
 Q:'$D(ICDIP)
 Q:'$D(ICDNWCDA(0))
 Q:$P($G(ICDNWCDA(0)),U,1)']""
 Q:$P($G(ICDNWCDA(0)),U,2)']""
 Q:$P($G(ICDNWCDA(0)),U,3)']""
 ;
 S ^TMP("ICDFILEOK",$J,ICDIP)=1
 ;
 K FDA(1831)
 ;
 ;Passed in array will trigger DRG Effective Date Multiple ONLY IF NEEDED
 ;
 I '$D(^ICD0(ICDIP,2,"B",3071001)) D
 .;DRG GROUPER EFFECTIVE DATE MULTIPLE
 .S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.171,"+2,?1,",.01)=3071001
 .D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 ;
 S ICDX1=""
 ;
 F  S ICDX1=$O(ICDNWCDA(ICDX1)) Q:ICDX1=""  D
 .;ADD MDC MULTIPLE only if there are DRG codes for the MDC
 .I $P(ICDNWCDA(ICDX1),U,2)]"" D  K FDA
 ..Q:$P(ICDNWCDA(ICDX1),U,3)']""
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"+3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .;
 .;ADD DRG MULTIPLES - first code in Piece 3
 .I $P(ICDNWCDA(ICDX1),U,3)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+4,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,3)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .;
 .;ADD DRG MULTIPLES - second code in piece 4
 .I $P(ICDNWCDA(ICDX1),U,4)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+5,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,4)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .;
 .I $P(ICDNWCDA(ICDX1),U,5)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+6,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,5)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .; 
 .I $P(ICDNWCDA(ICDX1),U,6)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+7,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,6)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .;
 .I $P(ICDNWCDA(ICDX1),U,7)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+8,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,7)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .;
 .I $P(ICDNWCDA(ICDX1),U,8)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+9,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,8)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .;
 .I $P(ICDNWCDA(ICDX1),U,9)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+10,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,9)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .; 
 .I $P(ICDNWCDA(ICDX1),U,10)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+11,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,10)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .;
  .I $P(ICDNWCDA(ICDX1),U,11)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+12,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,11)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .;
 .I $P(ICDNWCDA(ICDX1),U,12)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+13,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,12)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .; 
 .I $P(ICDNWCDA(ICDX1),U,13)]"" D
 ..S FDA(1831,80.1,"?1,",.01)="`"_ICDIP
 ..S FDA(1831,80.171,"?2,?1,",.01)=3071001
 ..S FDA(1831,80.1711,"?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,2)
 ..S FDA(1831,80.17111,"+14,?3,?2,?1,",.01)=$P(ICDNWCDA(ICDX1),U,13)
 ..D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 .;
 .I $D(^TMP("DIERR",$J)) S @ICDTMP@("ERROR",ICDIP,"80.1")="CAN'T FILE CODES FOR IEN"_$P(ICDNWCDA(ICDX1),U)_" CODES "_$P(ICDNWCDA(ICDX1),3,99)
 .I $D(^TMP("DIERR",$J,ICDIP)) S ^TMP("ICDFILEOK",$J,ICDIP)=0
 Q
