DG53688P ;ALB/CKN,BAJ,ERC - Patch DG*5.3*688 Install Utility Routine ; 8/15/08 12:03pm
 ;;5.3;Registration;**688**;AUG 13, 1993;Build 29
 Q
EP ;Entry point - Driver
 N ELEMNT,I,J,ABORT,EXIST,DMSG,ACTION
 ;
 ; Run trigger clean-up on Patient file per EVC_CR5834
 D START^DG53688A
 D START^DG53688B    ;Run field defintion clean-up per EVC_CR7473
 ;
 S GLOBAL="^IVM",ABORT=0,DMSG="",ACTION="create"
 F I=1:1 S ELEMNT=$P($T(TEXT+I),";;",2) Q:ELEMNT="QUIT"!(ABORT)  D
 . S FILE=$P(ELEMNT,";",1),EXIST=0
 . K DGDATA S (DATA,SUB)="" F J=2:1:$L(ELEMNT,";") S DATA=$P(ELEMNT,";",J) D  Q:EXIST
 . . S SUB=$P(DATA,"~",1),VALUE=$P(DATA,"~",2)
 . . S DGDATA(SUB)=VALUE
 . . I SUB=.01,$$ISTHERE(FILE,.DGDATA,GLOBAL) S EXIST=1
 . I 'EXIST D
 . . I '$$ADD^DGENDBS(FILE,,.DGDATA) S ABORT=1
 ; setup message variable
 S DMSG=$G(DGDATA(.01))
 ; if Ok so far, install #506 modification & #88 addition
 ; 
 I 'ABORT S ACTION="modify",DMSG="INCONSISTENT DATA ELEMENT #506",ABORT=$$506()
 I 'ABORT S DMSG="INCONSISTENT DATA ELEMENT #88",ABORT=$$88()
 ;
 ;add NOT APPLICABLE Enrollment Status to file 27.15
 I 'ABORT D
 . N DGABORT
 . S ACTION="add",DMSG="ENROLLMENT STATUS #23",ABORT=$$ENRSTAT()
 ;
 I ABORT D
 . S XPDABORT=2
 . D BMES^XPDUTL("Install process could not "_ACTION_" an entry in file for "_DMSG)
 . D BMES^XPDUTL("                        <<<< INSTALLATION ABORTED >>>>")
 Q
 ;
ISTHERE(FILE,DGDATA,GLOBAL) ;
 N FOUND,GLOB
 S FOUND=0
 S GLOB=GLOBAL_"(FILE,""B"",DGDATA(.01))"
 I $D(@GLOB) D
 . D BMES^XPDUTL("   Internal Entry Value for .01 -- "_DGDATA(.01)_" -- already exists in file "_FILE)
 . S FOUND=1
 Q FOUND
 ;
HECMSG ; Send message to HEC Legacy that install is complete.
 ;
 ;also index the Other Federal Agency file (#35) with the new "C" cross reference
 D CREF
 ;
 N SITE,STATN,PRODFLG,XMDUZ,XMSUB,XMY,XMTEXT,MSG,DIFROM
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),U,3)
 S PRODFLG=$$GET1^DIQ(869.3,"1,",.03,"I")="P"
 S XMDUZ="EVC I2 Install"
 S XMSUB=XMDUZ_" - "_STATN_" (DG*5.3*688)"
 S:PRODFLG XMY("S.IVMB*2*860 MESSAGE@IVM.MED.VA.GOV")=""
 S:'PRODFLG XMY(DUZ)=""
 S XMTEXT="MSG("
 S $P(MSG(1),U)="IVMB*2*860"
 S $P(MSG(1),U,2)=STATN
 S $P(MSG(1),U,3)="DG*5.3*688 "_$$FMTE^XLFDT($$NOW^XLFDT(),"5D")
 S $P(MSG(1),U,4)=PRODFLG
 S $P(MSG(1),U,5)=1
 D ^XMD
 D BMES^XPDUTL("    *** Install Message Sent to HEC Legacy ***")
 Q
 ;
506() ; Update entry #506 in the INCONSISTENT DATA ELEMENTS file (#38.6)
 ;-----------------------------------------------------------------
 ;-----------------------------------------------------------------
 N DATA,DGENDA,DGERR,FILE,DGTITL,ABORT,DGWP
 S FILE=38.6,DGENDA=506,DGTITL="Entry #506 SW ASIA CONDITIONS",ABORT=0
 D BMES^XPDUTL("  >> Modifying entry #506 in the INCONSISTENT DATA ELEMENTS file (#38.6)")
 S DATA(.01)="VALUE FOR SW ASIA COND INVALID"
 S DATA(2)="THE VALUE FOR SW ASIA CONDITIONS MUST BE EITHER YES, NO, OR UNKNOWN"
 S DATA(50)="DGWP"
 S DGWP(1,0)="If completed, the value for Southwest Asia Conditions must be"
 S DGWP(2,0)="Yes, No or Unknown."
 I '$$UPD^DGENDBS(FILE,.DGENDA,.DATA,.DGERR) D
 . D BMES^XPDUTL("   >>> ERROR! "_DGTITL_" not changed in file #38.6")
 . D MES^XPDUTL("       "_$G(DGERR))
 . S ABORT=1
 D:'ABORT BMES^XPDUTL("      "_DGTITL_" successfully modified.")
 Q ABORT
 ;
88() ; Add entry #88 TEMP. ADDRESS DATA INCOMPLETE
 N DATA,DGERR,DGTITL,ABORT,I,DGWP,ROOT,QUIT,DGFDA,DGIEN
 S DGIEN(1)=88,(ABORT,QUIT)=0
 S DGTITL="Entry #88 'TEMPORARY ADDRESS' DATA IS INCOMPLETE"
 D BMES^XPDUTL("  >> Modifying entry #88 in the INCONSISTENT DATA ELEMENTS file (#38.6)")
 S ROOT="DGFDA(38.6,""?+1,"")"
 S @ROOT@(.01)="TEMP. ADDRESS DATA INCOMPLETE"
 I $D(^DGIN(38.6,88,0)) D  Q ABORT
 . I $P(^DGIN(38.6,88,0),U,1)'=@ROOT@(.01) D  Q
 . . D MES^XPDUTL("     >>> ERROR: Entry # 88 needs to be reviewed by NVS! <<<")
 . . D MES^XPDUTL("           Existing entry: "_$P($G(^DGIN(38.6,88,0)),"^"))
 . . D MES^XPDUTL("           Incoming entry: "_$G(@ROOT@(.01)))
 . . D BMES^XPDUTL("                        <<<< INSTALLATION ABORTED >>>>")
 . . S ABORT=1
 . D BMES^XPDUTL("  >> Entry #88 already exists in the INCONSISTENT DATA ELEMENTS file (#38.6)")
 S @ROOT@(2)="'TEMPORARY ADDRESS' DATA IS INCOMPLETE"
 F I=3:1:6 S @ROOT@(I)=0
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results if a record with an active temporary"
 S DGWP(2,0)="address does not contain the first line of the street address, city, state,"
 S DGWP(3,0)="and zip code for a domestic temporary address, or, for a foreign temporary"
 S DGWP(4,0)="address, the first line of the street address and the city."
 D UPDATE^DIE("","DGFDA","DGIEN","DGERR")
 I $D(DGERR) D
 . D BMES^XPDUTL("   >>> ERROR! "_DGTITL_" not added to file #38.6")
 . D MES^XPDUTL("     "_DGERR("DIERR",1)_": "_DGERR("DIERR",1,"TEXT",1))
 . D BMES^XPDUTL("                        <<<< INSTALLATION ABORTED >>>>")
 . S ABORT=1
 D:'ABORT BMES^XPDUTL("      "_DGTITL_" successfully added.")
 Q ABORT
 ;
ENRSTAT() ;Add NOT APPLICABLE to the Enrollment Status file (#27.15)
 N DGCAT,DGMSG,DGSTAT
 S DGSTAT="NOT APPLICABLE"
 S DGCAT="N"
 S DGABORT=1
 ;check to see if there is an entry already
 I $D(^DGEN(27.15,23)) D  Q DGABORT
 . I $P(^DGEN(27.15,23,0),U)="NOT APPLICABLE" D  Q
 . . D CHKSTAT
 . . I DGABORT=0 S DGMSG=("  >> NOT APPLICABLE already exists in Enrollment Status file (#27.15)") D MSG(1)  Q
 . . I DGABORT=1 D SETSTAT
 . . I DGABORT=0 S DGMSG=("  >> NOT APPLICABLE updated in Enrollment Status file (#27.15)") D MSG(1)
 . I $P(^DGEN(27.15,23,0),U)'="NOT APPLICABLE" D  Q
 . . S DGMSG="  >> File 27.15 has an existing, invalid Entry #23" D MSG(1)
 . . S DGABORT=1
NEWSTAT ;set .01 and .02 fields
 ;  .01 - NOT APPLICABLE
 ;  .02 - N:NOT ENROLLED
 ;
 N DGFDA,DGIEN
 S DGFDA(1,27.15,"+1,",.01)=DGSTAT
 S DGFDA(1,27.15,"+1,",.02)=DGCAT
 S DGIEN=23
 K DGERR
 D UPDATE^DIE("","DGFDA(1)","DGIEN","DGERR")
 I $D(DGERR) D ERR Q DGABORT
 S DGMSG=("  >> NOT APPLICABLE added to Enrollment Status file (#27.15)") D MSG(1)
 S DGABORT=0
 Q DGABORT
CHKSTAT ;check to see if existing NOT APPLICABLE entry has "N" for .02 field
 I $P(^DGEN(27.15,23,0),U,2)="N" S DGABORT=0
 Q
SETSTAT ;set .02 field (Enr Category) to "N" (Not Enrolled) on existing N/A entry
 N DGFDA
 S DGFDA(27.15,23_",",.02)=DGCAT
 K DGERR
 D FILE^DIE("","DGFDA","DGERR")
 I $D(DGERR) D ERR S DGABORT=1 Q  ;S DGMSG="Unable to update ""NOT APPLICABLE"" Enrollment Status in file 27.15." D MSG(0) S DGOK=2 Q
 I '$D(DGERR) S DGABORT=0 ;DGMSG="    NOT APPLICABLE entry in file 27.15 successfully updated." D MSG(1) S DGOK=1
 Q
ERR ;set error message into DGMSG for installation message
 N DGC,DGCC
 S (DGC,DGCC)=0
 F  S DGC=$O(DGERR("DIERR",DGC)) Q:'DGC  D
 . F  S DGCC=$O(DGERR("DIERR",DGC,"TEXT",DGCC)) Q:'DGCC  D
 . . S DGMSG=DGERR("DIERR",DGC,"TEXT",DGCC) I DGC=1,(DGCC=1) D MSG(1) Q
 . . D MSG(0)
 K DGERR
 Q
MSG(DGB) ;generate installation message
 ;if DGB=1, need a blank line before message
 I DGB=1 D BMES^XPDUTL(DGMSG) Q
 D MES^XPDUTL(DGMSG)
 Q
 ;
CREF ;index fuile #35 with new "C" cross reference
 N DIK
 S DIK="^DIC(35,",DIK(1)="1^C"
 D ENALL^DIK
 ;
TEXT ;FILE#;FIELD#~VALUE;FIELD#~VALUE;FIELD#~VALUE.....
 ;;301.92;.01~PROVINCE;.02~PID114F;.03~1;.04~2;.05~.1171;.08~1;10~S DR=.1171 D LOOK^IVMPREC9;20~S DR=.1171 D LOOK^IVMPREC9
 ;;301.92;.01~POSTAL CODE;.02~PID115F;.03~1;.04~2;.05~.1172;.08~1;10~S DR=.1172 D LOOK^IVMPREC9;20~S DR=.1172 D LOOK^IVMPREC9
 ;;301.92;.01~COUNTRY;.02~PID116;.03~1;.04~2;.05~.1173;.08~1;10~S DR=.1173 D LOOK^IVMPREC9;20~S DR=.1173 D LOOK^IVMPREC9
 ;;301.92;.01~BAD ADDRESS INDICATOR;.02~PID117;.03~1;.04~2;.05~.121;.08~1;10~S DR=.121 D LOOK^IVMPREC9;20~S DR=.121 D LOOK^IVMPREC9
 ;;301.92;.01~STREET ADDRESS [LINE 3];.02~PID118;.03~1;.04~2;.05~.113;.08~1;10~S Y=$P(VAPA(3),"^");20~S Y=VAPA(3)
 ;;301.92;.01~PAGER NUMBER;.02~PID13B;.03~1;.04~2;.05~.135;.08~1;10~S DR=.135 D LOOK^IVMPREC9;20~S DR=.135 D LOOK^IVMPREC9
 ;;301.92;.01~CELLULAR NUMBER;.02~PID13C;.03~1;.04~2;.05~.134;.08~1;10~S DR=.134 D LOOK^IVMPREC9;20~S DR=.134 D LOOK^IVMPREC9
 ;;301.92;.01~EMAIL ADDRESS;.02~PID13E;.03~1;.04~2;.05~.133;.08~1;10~S DR=.133 D LOOK^IVMPREC9;20~S DR=.133 D LOOK^IVMPREC9
 ;;301.92;.01~PAGER CHANGE DT/TM;.02~RF171B;.03~1;.04~2;.05~.1312;.08~1;10~S DR=.1312 D LOOK^IVMPREC9;20~S DR=.1312 D LOOK^IVMPREC9
 ;;301.92;.01~PAGER CHANGE SOURCE;.02~RF162B;.03~1;.04~2;.05~.1313;.08~1;10~S DR=.1313 D LOOK^IVMPREC9;20~S DR=.1313 D LOOK^IVMPREC9
 ;;301.92;.01~PAGER CHANGE SITE;.02~RF161B;.03~1;.04~2;.05~.1314;.08~1;10~S DR=.1314 D LOOK^IVMPREC9;20~S DR=.1314 D LOOK^IVMPREC9
 ;;301.92;.01~CELL PHONE CHANGE DT/TM;.02~RF171C;.03~1;.04~2;.05~.139;.08~1;10~S DR=.139 D LOOK^IVMPREC9;20~S DR=.139 D LOOK^IVMPREC9
 ;;301.92;.01~CELL PHONE CHANGE SOURCE;.02~RF162C;.03~1;.04~2;.05~.1311;.08~1;10~S DR=.1311 D LOOK^IVMPREC9;20~S DR=.1311 D LOOK^IVMPREC9
 ;;301.92;.01~CELL PHONE CHANGE SITE;.02~RF161C;.03~1;.04~2;.05~.13111;.08~1;10~S DR=.13111 D LOOK^IVMPREC9;20~S DR=.13111 D LOOK^IVMPREC9
 ;;301.92;.01~EMAIL CHANGE DT/TM;.02~RF171E;.03~1;.04~2;.05~.136;.08~1;10~S DR=.136 D LOOK^IVMPREC9;20~S DR=.136 D LOOK^IVMPREC9
 ;;301.92;.01~EMAIL CHANGE SOURCE;.02~RF162E;.03~1;.04~2;.05~.137;.08~1;10~S DR=.137 D LOOK^IVMPREC9;20~S DR=.137 D LOOK^IVMPREC9
 ;;301.92;.01~EMAIL CHANGE SITE;.02~RF161E;.03~1;.04~2;.05~.138;.08~1;10~S DR=.138 D LOOK^IVMPREC9;20~S DR=.138 D LOOK^IVMPREC9
 ;;QUIT
