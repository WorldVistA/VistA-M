DIPR129 ;OOIFO/SO- REMOVE DANGLING AUDIT XREFS ;8:09 AM  24 Nov 2003
 ;;22.0;VA FileMan;**129**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I $$TM^%ZTLOAD,$G(XPDNM)]"" D  Q
 . N ZTSAVE,ZTRTN,ZTDTH,ZTDESC,ZTIO
 . S ZTSAVE("XPD*")="",ZTRTN="DEQUE^DIPR129",ZTDTH=$H,ZTIO=""
 . S ZTDESC="DI*22*129 Post Installation"
 . D ^%ZTLOAD
 . D MES^XPDUTL("Post Install Task Number is: "_$G(ZTSK))
DEQUE ;
 N ZZ
 D MES^XPDUTL(" ")
 I $G(ZTSK)]"" D MES^XPDUTL("Queued Post Install Dialog, Task#: "_$G(ZTSK))
 D TIME
 D MES^XPDUTL("Began checking Audit cross reference: "_ZZ_"...")
 N FILE
 S FILE=1.99999 ;Begin after Fileman Files
 F  S FILE=$O(^DIC(FILE)) Q:'FILE  D
 . I '$D(^DIA(FILE)) Q
 . N I
 . S I=$$DANGLE^DIAU(FILE)
 . I I D MES^XPDUTL("File: "_FILE_" had a total of:"_I_" dangling cross references removed.")
 . Q
 D TIME
 D MES^XPDUTL("Finished checking Audit cross references: "_ZZ_".")
 Q
 ;
TIME ; GET CURRENT DATE/TIME
 N %,%H,%I,Y
 D NOW^%DTC
 S Y=%
 D DD^%DT
 S ZZ=Y
 Q
