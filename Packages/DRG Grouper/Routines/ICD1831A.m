ICD1831A ;ALB/RBS - FY 2008 DRG UPDATE ; 11/13/07 3:37pm
 ;;18.0;DRG Grouper;**31**;Oct 13, 2000;Build 7
 ;
 ;Update the (#80.2) DRG file with FY 2008 DRG Grouper MS-DRG codes.
 ;The last DRG code filed for FY 2007 was DRG579.
 ;
 Q
 ;
 ;Routines ICD1831* contain each FY 2008 MS-DRG code update values
 ;in a line of text delimited by up-arrow "^".
 ; $TEXT line field names
 ; MS-DRG^MDC^TYPE^MS-DRG TITLE^WEIGHTS^GEOMETRIC MEAN LOS^
 ; routine    MS-DRG codes
 ; ICD1831B -   1 to 168
 ; ICD1831C - 175 to 329
 ; ICD1831D - 330 to 480
 ; ICD1831E - 481 to 639
 ; ICD1831F - 640 to 809
 ; ICD1831G - 810 to 999
 ;
 ;The following nodes/fields will be updated or created:
 ;  .001 NUMBER (same as DRG Number)
 ;  0 node   - .01 NAME (composed of prefix "DRG"_Number... DRG579)
 ;               5 MDC#
 ;             .06 SURGERY
 ;  1 node   -  #1 DESCRIPTION   *** don't update existing records ***
 ;                 80.21A, .01 DESCRIPTION Multiple
 ;  2 node   - #71 DRG GROUPER EFFECIVE DATE
 ;                 80.271D, .01 DRG GROUPER EFFECIVE DATE
 ;                            1 REFERENCE - MUMPS Routine name
 ; 66 node   - #66 EFFECTIVE DATE
 ;                 80.266D, .01 EFFECTIVE DATE
 ;                          .03 STATUS
 ;                          .05 MDC#
 ;                          .06 SURGERY
 ; 68 node   - #68 DESCRIPTION (VERSIONED)
 ;                 80.268D, .01 EFFECTIVE DATE
 ;                            1 DESCRIPTION
 ;                      80.2681, .01 DESCRIPTION
 ; "FY" node - #20 FISCAL YEAR WEIGHTS&TRIM
 ;                 80.22D, .01 FISCAL YEAR WEIGHTS&TRIMS
 ;                           2 WEIGHT                
 ;                           3 LOW TRIM(days)
 ;                           4 HIGH TRIM(days)
 ;                         4.5 AVG LENGTH OF STAY(days)
 ;
DRG ;post-install driver (#80.2) DRG updates
 ;This procedure calls a series of routines that contain the data
 ;element values used to create the FY 2008 MS-DRG updates.
 ; Input:
 ;   ICDTMP - Temp file of error msg's
 ;   ICDTOT - Total MS-DRG codes filed
 ; Output:
 ;   ICDTMP - Temp file of error msg's
 ;   ICDTOT - Total MS-DRG codes filed
 ;
 D BMES^XPDUTL(">>> Adding FY 2008 DRG Grouper updates to (#80.2) DRG file...")
 N ICDRTN,ICDI,ICDSUB,ICDEDIT,ICDADD
 S (ICDEDIT,ICDADD)=0
 S ICDTOT=$G(ICDTOT) I ICDTOT']"" S ICDTOT=0
 S ICDTMP=$G(ICDTMP)
 I ICDTMP']"" S ICDTMP=$NA(^TMP("DRGFY2008",$J)) D
 . K @ICDTMP
 . S @ICDTMP@(0)="PATCH FY 2008 DRG UPDATE^"_$$NOW^XLFDT
 ;
 ;loop each sub-routine
 S ICDSUB="BCDEFG"
 F ICDI=1:1:6 S ICDRTN="^ICD1831"_$E(ICDSUB,ICDI) D
 . Q:($T(@ICDRTN)="")
 . D GETDRG(ICDRTN,ICDTMP,.ICDTOT,.ICDEDIT,.ICDADD)
 ;
 I '$D(@ICDTMP@("ERROR")) D
 . D MES^XPDUTL(">>> DRG Updates Completed...")
 . D MES^XPDUTL("    ...Total Codes Edited: "_ICDEDIT)
 . D MES^XPDUTL("    ...Total Codes Added:  "_ICDADD)
 . D MES^XPDUTL("    ................Total: "_ICDTOT)
 . D MES^XPDUTL("")
 Q
 ;
GETDRG(ICDRTN,ICDTMP,ICDTOT,ICDEDIT,ICDADD) ;get and file MS-DRG data
 ; Input:
 ;   ICDRTN - Post Install routine to process MS-DRG codes
 ;   ICDTMP - Temp file of error msg's
 ;   ICDTOT - Total MS-DRG codes filed
 ; Output:
 ;   ICDTMP - Temp file of error msg's
 ;   ICDTOT - Total MS-DRG codes filed
 ;
 N ICDLN,ICDLINE,ICDTAG,ICDDRG,ICDTEXT
 ;
 F ICDLN=1:1 S ICDTAG="MSDRG+"_ICDLN_ICDRTN,ICDTEXT=$T(@ICDTAG) S ICDLINE=$P(ICDTEXT,";;",2) Q:ICDLINE="EXIT"  D
 . ; check if DRG exists or is a new one
 . I $D(^ICD(+$P(+ICDLINE,U),0)) D EDITDRG(ICDLINE,ICDTMP,.ICDTOT,.ICDEDIT)
 . E  D NEWDRG(ICDLINE,ICDTMP,.ICDTOT,.ICDADD)
 Q
 ;
EDITDRG(ICDLINE,ICDTMP,ICDTOT,ICDEDIT) ; edit existing (#80.2) DRG record
 ; Input:
 ;   ICDLINE - $TEXT line of MS-DRG code data
 ;   ICDTMP - Temp file of error msg's
 ;   ICDTOT - Total MS-DRG codes filed
 ; Output:
 ;   ICDTMP - Temp file of error msg's
 ;   ICDTOT - Total MS-DRG codes filed
 ;
 N X,Y,DA,DIE,DR,ICDDRG,ICDDESC,ICDMDC,ICDSURG,ICDFDA,ICDFY,ICDERR,ICDREF
 ;
 S ICDFY=3071001
 S ICDDRG=+$P(ICDLINE,U)
 S ICDDESC=$P(ICDLINE,U,4)
 I '$D(^ICD(ICDDRG,0)) D  Q
 . S @ICDTMP@("ERROR",ICDDRG,0)="MISSING (#80.2) DRG FILE RECORD"
 ;
 ; check if already done in case patch being re-installed
 Q:$D(^ICD(ICDDRG,66,"B",ICDFY))
 ;
 ;-- 80.271D subfile - #71 DRG GROUPER EFFECIVE DATE
 ;S ICDREF="ICDTLB6D"     ;*** REFERENCE routine not defined yet ???
 ;S ICDREF=""             ;*** ECF commented out-see next line
 S ICDREF="ICDTBL"_$S(ICDDRG<100:"0",1:$E(ICDDRG,1)) ;ECF new line
 D DRGEFFDT(ICDDRG,ICDFY,ICDREF,ICDTMP)
 ;
 ;-- 80.266D subfile - #66 EFFECTIVE DATE
 S ICDMDC=$P(ICDLINE,U,2) S:ICDMDC="PRE" ICDMDC=98
 I ICDMDC]"" S ICDMDC=+ICDMDC
 S ICDSURG=$P(ICDLINE,U,3) S ICDSURG=$S(ICDSURG="SURG":1,1:0)
 D EFFDATE(ICDDRG,ICDFY,ICDMDC,ICDSURG,ICDTMP)
 ;
 ;-- 80.268D subfile - #68 DESCRIPTION
 D DESCA(ICDDRG,ICDFY,ICDTMP)
 ;
 ;-- 80.2681 subfile - #68 DESCRIPTION
 D DESCB(ICDDRG,ICDFY,ICDDESC,ICDTMP)
 ;
 ;--80.22D subfile - #20 FISCAL YEAR WEIGHTS&TRIM
 D WEIGHTS(ICDLINE,ICDTMP)
 ;
 S ICDTOT=ICDTOT+1,ICDEDIT=ICDEDIT+1
 Q
 ;
NEWDRG(ICDLINE,ICDTMP,ICDTOT,ICDADD) ; add new (#80.2) DRG record
 ; Input:
 ;   ICDLINE - $TEXT line of MS-DRG code data
 ;    ICDTMP - Temp file of error msg's
 ;    ICDTOT - Total MS-DRG codes filed
 ; Output:
 ;   ICDTMP - Temp file of error msg's
 ;   ICDTOT - Total MS-DRG codes filed
 ;
 N DA,DIC,DIE,DR,X,Y
 N ICDDRG,ICDDESC,ICDMDC,ICDSURG,ICDFDA,ICDFY,ICDERR,ICDREF,ICDIEN
 S ICDFY=3071001
 S ICDDRG=+$P(ICDLINE,U)
 ; check for duplicates in case install is being rerun
 I $D(^ICD(ICDDRG,0)) Q
 ;
 S ICDMDC=$P(ICDLINE,U,2) I ICDMDC="PRE" S ICDMDC=98
 I ICDMDC]"" S ICDMDC=+ICDMDC
 S ICDSURG=$P(ICDLINE,U,3) S ICDSURG=$S(ICDSURG="SURG":1,1:"")
 S ICDDESC=$P(ICDLINE,U,4)
 ;
 ;-- #.001 NUMBER and 0 node fields
 K ICDFDA,ICDIEN,ICDERR
 S ICDFDA(80.2,"+1,",.01)="DRG"_ICDDRG
 S ICDFDA(80.2,"+1,",5)=ICDMDC
 S ICDFDA(80.2,"+1,",.06)=ICDSURG
 S ICDIEN(1)=ICDDRG
 D UPDATE^DIE("","ICDFDA","ICDIEN","ICDERR") K ICDFDA,ICDIEN
 I $D(ICDERR) D  K ICDERR       ;*** quit here if can't setup IEN ???
 . S @ICDTMP@("ERROR",ICDDRG,.001)="FILING TO (#.001) NUMBER FIELD"
 ;
 ;-- 80.21A subfile - #1 DESCRIPTION
 K DIC,DA
 S DA(1)=ICDDRG
 S DIC="^ICD("_DA(1)_",1,"
 S DIC(0)="L"
 S X=ICDDESC
 K DO D FILE^DICN
 K DIC,DA
 I Y=-1 D
 . S @ICDTMP@("ERROR",ICDDRG,1)="FILING TO (#1) DESCRIPTION FIELD"
 ;
 ;-- 80.271D subfile - #71 DRG GROUPER EFFECIVE DATE
 ;S ICDREF="ICDTLB6D"     ;*** REFERENCE routine not defined yet ???
 ;S ICDREF=""             ;ECF commented out - see next line
 S ICDREF="ICDTBL"_$S(ICDDRG<100:"0",1:$E(ICDDRG,1)) ;ECF new line
 D DRGEFFDT(ICDDRG,ICDFY,ICDREF,ICDTMP)
 ;
 ;-- 80.266D subfile - #66 EFFECTIVE DATE
 I ICDSURG="" S ICDSURG=0
 D EFFDATE(ICDDRG,ICDFY,ICDMDC,ICDSURG,ICDTMP)
 ;
 ;-- 80.268D subfile - #68 DESCRIPTION
 D DESCA(ICDDRG,ICDFY,ICDTMP)
 ;
 ;-- 80.2681 subfile - #68 DESCRIPTION
 D DESCB(ICDDRG,ICDFY,ICDDESC,ICDTMP)
 ;
 ;-- 80.22D subfile - update weights&trims/ALOS
 D WEIGHTS(ICDLINE,ICDTMP)
 ;
 S ICDTOT=ICDTOT+1,ICDADD=ICDADD+1
 Q
 ;
DRGEFFDT(ICDDRG,ICDFY,ICDREF,ICDTMP) ;-- 80.271D - #71 DRG GROUPER EFFECIVE DATE
 I '$G(ICDDRG)!'$G(ICDFY)!($G(ICDTMP)']"") Q
 K ICDFDA,ICDERR
 S ICDFDA(80.2,"?1,",.01)=ICDDRG
 S ICDFDA(80.271,"+2,?1,",.01)=ICDFY
 S ICDFDA(80.271,"+2,?1,",1)=ICDREF
 D UPDATE^DIE("","ICDFDA","","ICDERR") K ICDFDA
 I $D(ICDERR) D  K ICDERR
 . S @ICDTMP@("ERROR",ICDDRG,71)="FILING TO (#71) DRG GROUPER EFFECIVE DATE FIELD"
 Q
 ;
EFFDATE(ICDDRG,ICDFY,ICDMDC,ICDSURG,ICDTMP) ;-- 80.266D - #66 EFFECTIVE DATE
 I '$G(ICDDRG)!'$G(ICDFY)!($G(ICDTMP)']"") Q
 K ICDFDA,ICDERR
 S ICDFDA(80.2,"?1,",.01)=ICDDRG
 S ICDFDA(80.266,"+2,?1,",.01)=ICDFY
 S ICDFDA(80.266,"+2,?1,",.03)=1
 S ICDFDA(80.266,"+2,?1,",.05)=ICDMDC
 S ICDFDA(80.266,"+2,?1,",.06)=ICDSURG
 D UPDATE^DIE("","ICDFDA","","ICDERR") K ICDFDA
 I $D(ICDERR) D  K ICDERR
 . S @ICDTMP@("ERROR",ICDDRG,66)="FILING TO (#66) EFFECTIVE DATE FIELD"
 Q
 ;
DESCA(ICDDRG,ICDFY,ICDTMP) ;-- 80.268D - #68 DESCRIPTION
 I '$G(ICDDRG)!'$G(ICDFY)!($G(ICDTMP)']"") Q
 K ICDFDA,ICDERR
 S ICDFDA(80.2,"?1,",.01)=ICDDRG
 S ICDFDA(80.268,"+2,?1,",.01)=ICDFY
 D UPDATE^DIE("","ICDFDA","","ICDERR") K ICDFDA
 I $D(ICDERR) D  K ICDERR
 . S @ICDTMP@("ERROR",ICDDRG,68)="FILING TO (#68) DESCRIPTION FIELD"
 Q
 ;
DESCB(ICDDRG,ICDFY,ICDDESC,ICDTMP) ;-- 80.2681 - #68 DESCRIPTION
 I '$G(ICDDRG)!'$G(ICDFY)!($G(ICDDESC)']"")!($G(ICDTMP)']"") Q
 K ICDFDA,ICDERR
 S ICDFDA(80.2,"?1,",.01)=ICDDRG
 S ICDFDA(80.268,"?2,?1,",.01)=ICDFY
 S ICDFDA(80.2681,"+3,?2,?1,",.01)=ICDDESC
 D UPDATE^DIE("","ICDFDA","","ICDERR") K ICDFDA
 I $D(ICDERR) D  K ICDERR
 . S @ICDTMP@("ERROR",ICDDRG,68)="FILING TO (#68) DESCRIPTION SUB-FIELD"
 Q
 ;
WEIGHTS(ICDLINE,ICDTMP) ;--80.22D subfile - #20 FISCAL YEAR WEIGHTS&TRIM
 ; Input:
 ;   ICDLINE - $TEXT line of MS-DRG code data
 ;    ICDTMP - Temp file of error msg's
 ; Output:
 ;   ICDTMP - Temp file of error msg's
 ;
 I $G(ICDLINE)'[""!($G(ICDTMP)'["") Q
 N ICDDRG,ICDWT,ICDLOS,ICDSTR,ICDX,ICDJ,ICDFYR,ICDLOW,ICDHIGH
 S ICDFYR=3080000,ICDLOW=1,ICDHIGH=99  ; *** default Low/High ???
 S ICDDRG=+$P(ICDLINE,U)
 I '$D(^ICD(ICDDRG,0)) D  Q
 . S @ICDTMP@("ERROR",ICDDRG,0)="MISSING (#80.2) DRG FILE RECORD"
 ;
 ; check if being re-installed
 Q:$D(^ICD(ICDDRG,"FY",ICDFYR))
 ;
 I ICDDRG=998!(ICDDRG=999) S (ICDLOW,ICDHIGH)=0
 S ICDWT=$P(ICDLINE,U,5),ICDLOS=$P(ICDLINE,U,6)
 I ICDLOS["*" S ICDLOS=0
 S $P(ICDSTR,U)=ICDFYR,$P(ICDSTR,U,2)=ICDWT,$P(ICDSTR,U,3)=ICDLOW,$P(ICDSTR,U,4)=ICDHIGH,$P(ICDSTR,U,9)=ICDLOS
 ;
 S ^ICD(ICDDRG,"FY",ICDFYR,0)=ICDSTR
 ;
 I '$D(^ICD(ICDDRG,"FY",0)) S ^ICD(ICDDRG,"FY",0)="^80.22D^"_ICDFYR_"^1" Q
 E  D
 . S ICDX=0 F ICDJ=0:1 S ICDX=$O(^ICD(ICDDRG,"FY",ICDX)) Q:ICDX=""
 . S $P(^ICD(ICDDRG,"FY",0),"^",3,4)=ICDFYR_"^"_ICDJ
 Q
