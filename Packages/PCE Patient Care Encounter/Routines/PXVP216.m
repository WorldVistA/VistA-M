PXVP216 ;BPFO/LMT - PX*1*216 KIDS Routine ;07/12/16  14:36
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**216**;Aug 12, 1996;Build 11
 ;
 ;
 ; Reference to ^DD(9000010.11,0,AUDPURGEFORBID) supported by ICR #6410
 ;
 ;
PRE ; ; KIDS Pre install for PX*1*216
 D BMES("*** Pre install started ***")
 ;
 ; Delete Trigger on #1201 (as Trigger is being moved to #.01)
 D DELIX^DDMOD(9000010.11,1201,1)
 ;
 D BMES("*** Pre install completed ***")
 Q
 ;
 ;
POST ; KIDS Post install for PX*1*216
 D BMES("*** Post install started ***")
 ;
 ; Prevent purging of V Immunization audits
 S ^DD(9000010.11,0,"AUDPURGEFORBID")=""  ; ICR 6410
 ;
 D BMES("*** Post install completed ***")
 Q
 ;
 ;-------------------------------------------------------------------------
 ;
BMES(STR) ;
 ; Write string
 D BMES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
MES(STR) ;
 ; Write string
 D MES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
