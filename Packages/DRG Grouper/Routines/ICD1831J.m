ICD1831J   ; ALB/ECF - FY 2008 UPDATE; 8/27/07 14:50
 ;;18.0;DRG Grouper;**31**;Oct 13,2000  2:30 pm;Build 7
 Q
 ;
DRG(ICDTMP) ;post-install driver for file ICD Diagnosis file(#80) DRG updates
 ;This procedure creates and files the MSv25DRG updates
 ;
 ; Input:
 ;   ICDTMP - Temp file of error msg's
 ;   ICDTOT - Total MS-DRG codes filed
 ; Output:
 ;   ICDTMP - Temp file of error msg's
 ;   ICDTOT - Total MS-DRG codes filed
 ;   ICDERTOT - Total error records of type "cannot file"
 ;
 N ICDI,ICDCRCD,ICDNWCD,ICDTOT,ICDETOT,ICDVAL,ICDXX,ICX1,ICDZZ  ; This is a rough but growing list of variables 
 S U="^"
 S (ICDI,ICDTOT,ICDETOT)=0
 S ICDXX=""
 S (ICDINAC,ICDAD)=0
 ;
 ;ANNOUNCE PROJECT
 ;
 D BMES^XPDUTL(">>> Adding FY 2008 DRG Grouper updates to ICD Diagnosis file (#80)...")
 ;
 ;Set up reference to error log
 ;
 S ICDTMP=$G(ICDTMP)
 I ICDTMP']"" S ICDTMP=$NA(^TMP("ICDDGFY2008D",$J)) D
 . K @ICDTMP
 . S @ICDTMP@(0)="PATCH FY 2008 ICD DIAGNOSIS DRG UPDATE^"_$$NOW^XLFDT
 ;
 ;LOOP THROUGH FILE 80 - PROCESS EACH ENTRY
 ;All except inactive entries may have new DRGs
 ;
 F  S ICDI=$O(^ICD9(ICDI)) Q:ICDI=""!(ICDI'?.N)  D
 .;quit if no zero node
 .Q:$G(^ICD9(ICDI,0))=""
 .;quit if zero node corrupt
 .Q:$P($G(^ICD9(ICDI,0)),U,1)']""
 .;quit if code is inactive
 .;
 .S ICDVAL=$P($G(^ICD9(ICDI,0)),U)
 .Q:ICDVAL=""
 .;quit if code is inactive
 .S ICDZZ=$$ICDDX^ICDCODE(ICDVAL,3071001)
 .Q:$P($G(ICDZZ),U,10)=0
 .;
 .;check if already created in case patch being re-installed
 .S:$D(^ICD9(ICDI,3,"B",3071001)) ICDAD=ICDAD+1
 .Q:$D(^ICD9(ICDI,3,"B",3071001))
 .;
 .;Capture latest set of DRG codes (80.07) and latest MDC Effective Date's MDC (80.072)
 .;
 .S ICDCRCD=$$GETCRCD(ICDI)
 .Q:ICDCRCD']""
 .;
 .;Codes are passed to converter in string ICDCRCD <.01 field>^<MDC ien>^<DRG ien)^<DRG ien>...
 .;Function returns one set of codes, format is <.01 field>^<MDC ien>^<DRG ien)^<DRG ien>...
 .;If no converion values, then return format is  <.01_field>_^_<mdc_ien>
 .;
 .S ICDNWCD=$$CONV80^ICD1831L(ICDCRCD)
 .Q:$P($G(ICDNWCD),U,1)']""
 .Q:$P($G(ICDNWCD),U,2)']""
 .Q:$P($G(ICDNWCD),U,3)']""
 .;pass new codes to update procedure
 .;
 .D UPDDIAG(ICDI,ICDNWCD,ICDTMP,.ICDTOT)
 ;
 ;
 ;HANDLE ERRORS
 ;No errors present
 ;
 I '$D(@ICDTMP@("ERROR")) D
 . D MES^XPDUTL(">>> ICD PROCEDURE File DRG Updates Completed...")
 . D MES^XPDUTL("    ...Total Codes Edited: "_ICDTOT)
 . D MES^XPDUTL("")
 ;Q
 ;Errors present
 ;
 I $D(@ICDTMP@("ERROR")) D
 . F  S ICDXX=$O(^TMP("ICDDGFY2008D",$J,ICDXX)) Q:ICDXX=""  D
 ..S ICDETOT=ICDETOT+1
 . D MES^XPDUTL(">>> ...Total Errors "_ICDETOT_" ERRORS")
 . D MES^XPDUTL("")
 . D MES^XPDUTL("Error are in ^TMP(""ICDDGFY2008D"",$J)")
 ;
 K ICDCRCD,ICDVAL,ICDZZ
 Q
 ;
 ;END OF DRIVER
 ;
 ;Start of helper functions and procedures
 ;
GETCRCD(ICDI) ;
 ;INPUT    ICDI = ien in file 80.1 ICD Diagnosis Codes
 ;OUTPUT   ICCRCDS = string of current DRG Codes for latest DRG Grouper Effective Date
 ;                   and the latest MDC (80.072, #1)
 ;                   
 N ICDLDGED,ICDLMDED,ICDDGD2,ICDDGD3,ICDMDD1,ICDX,ICDCRCDS,ICDMDC
 ;LAST DRG EFFECTIVE DATE, LAST MDC EFFECTIVE DATE, IEN IN DRG EF DT, IEN IN DRG
 ;IEN IN MDC EFF DATE, STRING OF RETURN CODES, SCRATCH VARIABLE
 ;
 ;RETURN IEN^MDC^DRG^DRG^DRG..... (values are pointers)
 ;
 S (ICDMDC,ICDCRCDS)=""
 ;
 ;START STRING WITH THE .01 FIELD OF THE ENTRY (ICDI)
 ;
 S ICDCRCDS=$P(^ICD9(ICDI,0),U,1)
 ;
 ;NEXT GET THE MDC ATTACHED TO THE LATEST MDC EFFECTIVE DATE
 ;
 S ICDLMDED=$O(^ICD9(ICDI,4,"B",9999999),-1)
 I ICDLMDED]"" D
 .S ICDMDD1=$O(^ICD9(ICDI,4,"B",ICDLMDED,0))
 .S ICDMDC=$P($G(^ICD9(ICDI,4,ICDMDD1,0)),U,2)
 S ICDCRCDS=ICDCRCDS_"^"_$S((ICDMDC)]"":ICDMDC,1:"")
 ;
 ;THEN GET THE DRG MULTIPLE CODES
 ;
 S ICDLDGED=$O(^ICD9(ICDI,3,"B",9999999),-1)
 Q:ICDLDGED="" ICDCRCDS  ; new record - is active but has no DRG entries
 S ICDDGD2=$O(^ICD9(ICDI,3,"B",ICDLDGED,0)) ;GET IEN IN DRG MULTIPLE
 Q:$G(^ICD9(ICDI,3,ICDDGD2,1,0))']"" ""  ;QUIT, SOMETHING IS WRONG
 S ICDDGD3=0
 F  S ICDDGD3=$O(^ICD9(ICDI,3,ICDDGD2,1,ICDDGD3)) Q:ICDDGD3=""  D
 .S ICDCRCDS=ICDCRCDS_"^"_$G(^ICD9(ICDI,3,ICDDGD2,1,ICDDGD3,0))
 Q ICDCRCDS
 ;
 ;
UPDDIAG(ICDIP,ICDIAGP,ICDTMPP,ICDTOTP) ;
 ;Add 80.071 and 80.711 records for DRG Effective Date 10/1/07
 ;for both new and existing records
 ;  
 ;Input   ICDIP     IEN in file 80
 ;        ICDIAGP   DRG string from CONV80^ICD1831L function
 ;                  format: <.01_field>^<mdc_ien>^<drg1_ien>^<drg2_ien>...
 ;        ICDTMPP   Error tracker - ^TMP(""CDDGFY2008D",$J)
 ;        ICDTOT    ICD Diagnosis Code File records sucessfully filed
 ;                  
 ;--------------------------------------------------------------------                  
 ;
 ; N ICDZ
 ; F ICDZ=1:1:3 I $P(ICDIAGP,U,ICDZ)']"" D  Q
 ; .S @ICDTMP@("ERROR",ICDIP,68)="Missing field "_ICDZ_" filing "_ICDIAGP
 ; 
 ;Add DRG FY08 Multiple
 ;
 K FDA(1831)
 S FDA(1831,80,"?1,",.01)="`"_ICDIP
 S FDA(1831,80.071,"+2,?1,",.01)=3071001
 D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ;
 I $P(ICDIAGP,U,3)]"" D
 .S FDA(1831,80,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.071,"?2,?1,",.01)=3071001
 .S FDA(1831,80.711,"+3,?2,?1,",.01)=$P(ICDIAGP,U,3)
 .D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ;
 ; 
 I $P(ICDIAGP,U,4)]"" D
 .S FDA(1831,80,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.071,"?2,?1,",.01)=3071001
 .S FDA(1831,80.711,"+4,?2,?1,",.01)=$P(ICDIAGP,U,4)
 .D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ; 
 I $P(ICDIAGP,U,5)]"" D
 .S FDA(1831,80,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.071,"?2,?1,",.01)=3071001
 .S FDA(1831,80.711,"+5,?2,?1,",.01)=$P(ICDIAGP,U,5)
 .D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ;
 I $P(ICDIAGP,U,6)]"" D
 .S FDA(1831,80,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.071,"?2,?1,",.01)=3071001
 .S FDA(1831,80.711,"+6,?2,?1,",.01)=$P(ICDIAGP,U,6)
 .D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ;
 I $P(ICDIAGP,U,7)]"" D
 .S FDA(1831,80,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.071,"?2,?1,",.01)=3071001
 .S FDA(1831,80.711,"+7,?2,?1,",.01)=$P(ICDIAGP,U,7)
 .D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ;
 ; 
 I $P(ICDIAGP,U,8)]"" D
 .S FDA(1831,80,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.071,"?2,?1,",.01)=3071001
 .S FDA(1831,80.711,"+8,?2,?1,",.01)=$P(ICDIAGP,U,8)
 .D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ;
 I $P(ICDIAGP,U,9)]"" D
 .S FDA(1831,80,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.071,"?2,?1,",.01)=3071001
 .S FDA(1831,80.711,"+9,?2,?1,",.01)=$P(ICDIAGP,U,9)
 .D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ;
 I $P(ICDIAGP,U,10)]"" D
 .S FDA(1831,80,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.071,"?2,?1,",.01)=3071001
 .S FDA(1831,80.711,"+10,?2,?1,",.01)=$P(ICDIAGP,U,10)
 .D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ;
 I $P(ICDIAGP,U,11)]"" D
 .S FDA(1831,80,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.071,"?2,?1,",.01)=3071001
 .S FDA(1831,80.711,"+11,?2,?1,",.01)=$P(ICDIAGP,U,11)
 .D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ;
 I $P(ICDIAGP,U,12)]"" D
 .S FDA(1831,80,"?1,",.01)="`"_ICDIP
 .S FDA(1831,80.071,"?2,?1,",.01)=3071001
 .S FDA(1831,80.711,"+12,?2,?1,",.01)=$P(ICDIAGP,U,12)
 .D UPDATE^DIE("","FDA(1831)")
 K FDA(1831)
 ;
 I $O(^ICD9(ICDIP,4,0))="" D
 .S FDA(1831,80,"?13,",.01)="`"_ICDIP
 .S FDA(1831,80.072,"+14,?13,",.01)=3071001
 .S FDA(1831,80.072,"+14,?13,",1)=$P(ICDIAGP,U,2)
 .D UPDATE^DIE("","FDA(1831)")
 .K FDA(1831)
 K FDA(1831)
 ;
 ;for new Dx, place MDC in field #5
 I $$GET1^DIQ(80,ICDIP_",",5,"I")="" D
 .Q:($P(ICDIAGP,U,2)="")
 .S FDA(1831,80,ICDIP_",",5)=$P(ICDIAGP,U,2)
 .D FILE^DIE("","FDA(1831)")
 .K FDA(1831)
 ;
 I '$D(^TMP("DIERR",$J)) S ICDTOTP=ICDTOTP+1
 ; 
 I $D(^TMP("DIERR",$J)) D  K ^TMP("DIERR",$J)
 .S @ICDTMP@("ERROR",ICDIP,"80.1")="CANNOT FILE CODES FOR FY08 FOR IEN"_$P(ICDIAGP,U)_" CODES "_$P(ICDIAGP,3,99)
 Q
