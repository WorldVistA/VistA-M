DG53231P ;ISA/Zoltan - Post-install for DG*5.3*231;April 7, 1999
 ;;5.3;Registration;**231**;Aug 13, 1993
 ;
POST ; Re-compiles print and input templates for those fields
 ; included in the patch.
 N FLDLIST,FLD,PTEMP,ETEMP,TEMPLATE,ROUTINE,MAXSIZE,X,Y,DMAX
 D LOADFLDS(.FLDLIST) ; Obtain list of fields being sent.
 S FLD="" ; For each field...
 F  S FLD=$O(FLDLIST(FLD)) Q:FLD=""  D
 . M PTEMP=^DIPT("AF",2,FLD) ; ...note affected print templates...
 . M ETEMP=^DIE("AF",2,FLD) ; ...note affected edit templates.
 ; Determine maximum routine size...
 S MAXSIZE=$$ROUSIZE^DILF
 ; Recompile print templates...
 D BMES^XPDUTL(" *****************************")
 D BMES^XPDUTL(" * Compiling Print Templates *")
 D BMES^XPDUTL(" *****************************")
 S TEMPLATE=""
 F  S TEMPLATE=$O(PTEMP(TEMPLATE)) Q:TEMPLATE=""  D
 . S ROUTINE=$G(^DIPT(TEMPLATE,"ROU")) ; Note Routine Name
 . I ROUTINE="" Q  ; Not a compiled template.
 . ; Set up bulletproof FileMan call.
 . S X=ROUTINE,Y=TEMPLATE,DMAX=MAXSIZE
 . S $E(X)="" ; Remove initial ^.
 . ; This NEW only lasts for one loop iteration...
 . N ROUTINE,TEMPLATE,MAXSIZE,PTEMP,ETEMP
 . D EN^DIPZ ; Classic FileMan--Trust No One.
 ; Recompile edit templates...
 D BMES^XPDUTL("   ")
 D BMES^XPDUTL(" *****************************")
 D BMES^XPDUTL(" * Compiling Input Templates *")
 D BMES^XPDUTL(" *****************************")
 S TEMPLATE=""
 F  S TEMPLATE=$O(ETEMP(TEMPLATE)) Q:TEMPLATE=""  D
 . S ROUTINE=$G(^DIE(TEMPLATE,"ROU")) ; Note Routine Name
 . I ROUTINE="" Q
 . ; Set up bulletproof FileMan call.
 . S X=ROUTINE,Y=TEMPLATE,DMAX=MAXSIZE
 . S $E(X)="" ; Remove initial ^.
 . ; This NEW only lasts for one loop iteration...
 . N ROUTINE,TEMPLATE,MAXSIZE,PTEMP,ETEMP
 . D EN^DIEZ ; Classic FileMan--Trust No One.
 Q
LOADFLDS(ARR) ; Load field list.
 N FNUM,FNAME,LINE,TEXT
 F TEXT=1:1 S LINE=$T(FLDS+TEXT) Q:$P(LINE," ")'=""  D
 . S FNUM=$P(LINE,";",3)
 . S FNAME=$P(LINE,";",4)
 . S ARR(FNUM)=FNAME
 Q
FLDS ; Fields included in this patch.
 ;;.02;SEX
 ;;.03;DATE OF BIRTH
 ;;.05;MARITAL STATUS
 ;;.08;RELIGIOUS PREFERENCE
 ;;.09;SOCIAL SECURITY NUMBER
 ;;.111;STREET ADDRESS [LINE 1]
 ;;.1112;ZIP+4
 ;;.112;STREET ADDRESS [LINE 2]
 ;;.113;STREET ADDRESS [LINE 3]
 ;;.114;CITY
 ;;.115;STATE
 ;;.117;COUNTY
 ;;.131;PHONE NUMBER [RESIDENCE]
 ;;.132;PHONE NUMBER [WORK]
 ;;.211;K-NAME OF PRIMARY NOK
 ;;.219;K-PHONE NUMBER
 ;;.2403;MOTHER'S MAIDEN NAME
 ;;.301;SERVICE CONNECTED?
 ;;.302;SERVICE CONNECTED PERCENTAGE
 ;;.31115;EMPLOYMENT STATUS
 ;;.323;PERIOD OF SERVICE
 ;;.351;DATE OF DEATH
 ;;391;TYPE
 ;;1901;VETERAN
END ;End of field list.
