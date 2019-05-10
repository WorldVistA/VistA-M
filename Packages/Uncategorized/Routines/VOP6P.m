OSEP6P ; OSE/SMH - Install Plan 6 changes into VistA ;Nov 07, 2018@16:38
 ;;0.1;PLAN 6;;
 ;
ENV  ; [KIDS Environment Check]
 ; ZEXCEPT: XPDQUIT
 I ^%ZOSF("OS")'["GT.M" D  QUIT
 . D MES^XPDUTL("GT.M/YDB only supported right now")
 . S XPDQUIT=1
 I $TR($$VERSION^%ZOSV(),"-")<6.3001 D  QUIT
 . D MES^XPDUTL("GT.M min version is v6.3-001")
 . S XPDQUIT=1
 QUIT
 ;
POST ; [KIDS Post install]
 D %
 D KLANGDT
 D KSP
 QUIT
 ;
% ; % Routines rename
 D MES^XPDUTL("ZISTCPS -> %ZISTCPS")
 D RENAME("ZISTCPS","_ZISTCPS")
 D MES^XPDUTL("DIDT -> %DT")
 D RENAME("DIDT","_DT")
 QUIT
 ;
KLANGDT ; Korean Date Utilities in the Language file
 N KLANG S KLANG=$$FIND1^DIC(.85,,"QX","KOREAN","B")
 I 'KLANG S $EC=",U-KOREAN-NOT-FOUND,"
 N FDA,DIERR
 S FDA(.85,KLANG_",",20.2)="S:$G(%DT)'[""I"" %DT=$G(%DT)_""I"" G CONT^%DT"
 S FDA(.85,KLANG_",",10.2)="S Y=$$FMTE^UKOUTL(Y,$G(%F))"
 S FDA(.85,KLANG_",",10.21)="S Y=$$FMTE^UKOUTL(Y,$G(%F))"
 D FILE^DIE(,"FDA")
 I $D(DIERR) S $EC=",U-FDA-FILE-FAILED,"
 QUIT
 ;
KSP ; Change default language to Korean
 N FDA,DIERR
 S FDA(8989.3,"1,",207)="KOREAN"
 D FILE^DIE("E","FDA")
 I $D(DIERR) S $EC=",U-FDA-FILE-FAILED,"
 QUIT
 ;
RENAME(FROM,TO) ;Do the rename
 N DIF,XCNP,X,DIE,XCN
 K ^TMP($J)
 S DIF="^TMP($J,",XCNP=0,X=FROM X ^%ZOSF("LOAD")
 S DIE="^TMP($J,",XCN=0,X=TO X ^%ZOSF("SAVE")
 K ^TMP($J)
 Q
