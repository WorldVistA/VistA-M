VBECDCU2 ;hoifo/gjc-data conversion & pre-implementation utilities;Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$DEL^%ZISH is supported by IA: 2320
 ;Call to $$GET1^DID is supported by IA: 2052
 ;Call to FILE^DID is supported by IA: 2052
 ;Call to ^DIE is supported by IA: 10018
 ;Call to FILE^DIE is supported by IA: 2053
 ;Call to $$ROOT^DILFD is supported by IA: 2055
 ;Call to ^DIR is supported by IA: 10026
 ;Call to $$FMDIFF^XLFDT is supported by IA: 10103
 ;Call to ^DIK is supported by IA: 10013
 ;
SPARAM ; Site parameter enter edit.
 S DIE="^VBEC(6000,",DR=".01;.06R;.07R",DA=1 D ^DIE
 Q
 ;
NOMAP() ; check if the user has mapped VistA data (blood products, antigen/
 ; antibodies, blood supplier, and transfusion reactions) to their
 ; SQL Server equivalents.
 ; returns: '1' if any of the attributes identified above are not mapped
 N VBEC S VBEC=0
 ;I $O(^VBEC(6005,"AB",61.3,""))="" W !!,"Antigen/Antibodies have not been mapped, please resolve this issue before running the data conversion." S VBEC=1
 I $O(^VBEC(6005,"AB",61.3,""))="" W !!,"Antigen/Antibodies have not been mapped" D  ;RLM 10/27/05
  . S DIR("A")="Do you wish to continue? ",DIR(0)="Y",DIR("B")="No" D ^DIR Q:Y
  . S VBEC=1 W !,"Please resolve this issue before running the data conversion." Q
 I VBEC Q 1
 I $O(^VBEC(6005,"AB",65.4,""))="" W !!,"Transfusion Reactions have not been mapped" D  ;RLM 10/27/05
  . S DIR("A")="Do you wish to continue? ",DIR(0)="Y",DIR("B")="No" D ^DIR Q:Y
  . S VBEC=1 W !,"Please resolve this issue before running the data conversion." Q
 ;I $O(^VBEC(6005,"AB",66,""))="" W !!,"Blood Products have not been mapped, please resolve this issue before running the data conversion." S VBEC=1
 ;I $O(^VBEC(6005,"AB",66.01,""))="" W !!,"Blood Suppliers have not been mapped, please resolve this issue before running the data conversion." S VBEC=1
 Q VBEC
 ;
LOCK(VBECFN) ;file lock utility
 ; Input: VBECNUM=file number
 ;blood supplier is a multiple in the Blood Product file.
 ; Output: one if the file was locked, else return zero
 N VBECAT,VBECFLE,VBECRT,VBECLOCK
 S VBECRT=$$ROOT^DILFD($S(VBECFN=66.01:66,1:VBECFN),"",1)
 S VBECAT=$S(VBECFN=61.3:"antigens/antibodies",VBECFN=65.4:"transfusion reactions",VBECFN=66:"blood products",VBECFN=66.01:"blood suppliers",1:$$GET1^DID(VBECFN,.01,"","LABEL"))
 D FILE^DID(VBECFN,"","NAME","VBECTMP")
 L +@(VBECRT):5 S VBECLOCK=$T
 I '$T W !!,"Another person is editing "_VBECAT_" in the "_VBECTMP("NAME")_$S(VBECFN=66.01:" sub-file.",1:" file."),!,"Try again later...",$C(7)
 Q VBECLOCK
 ;
UNLOCK(VBECFN) ; unlock a file
 ; Input: X=file number
 S:VBECFN=66.01 VBECFN=66
 L -@($$ROOT^DILFD(VBECFN,"",1))
 Q
 ;
DEL ; delete the VMS or Microsoft legacy Blood Bank files from the
 ; server.  This will be an entry point for an option.
 S LR6001=$G(^VBEC(6001,+$O(^VBEC(6001,$C(32)),-1),0))
 S LRPROC=$P(LR6001,U,2),LRDATE=$P(LR6001,U,3)
 ;
 I LRDATE=""
 I  W !!?3,"The completion process timestamp does not exist.  There are"
 I  W !?3,"no system files to delete at this time."
 I  K LR6001,LRDATE Q
 ;
 I LRPROC'=1
 I  W !!?3,"The data conversion has not been run.  There are no system"
 I  W !?3,"files to delete at this time."
 I  K LR6001,LRDATE Q
 ;
 S LRPATH=$P($G(^VBEC(6000,1,0)),U,6)
 I LRPATH="" W !!,"Default Directory (file path) not defined.  Cannot"
 I  W !,"delete system level legacy Blood Bank files.",$C(13)
 I  D DELXIT Q
 ;
 ;check the number of days the system files have been resident
 S LRELPSE=$$FMDIFF^XLFDT(DT,LRDATE\1,1)
 I LRELPSE<10 D
 .W !!,"Due to the length of time the conversion process runs, it's best if the system",!,"files remain in their specified directory for a minimum of ten (10) days."
 .W !!,"Reports can be generated from these extract files which can be compared to",!,"legacy Blood Bank reports in order to validate the extract data.",!
 .Q
 K DIR S DIR(0)="Y",DIR("?")="Enter 'Yes' to delete system files, or 'No' to preserve them.",DIR("B")="No",DIR("A")="Purge system level data extract files" D ^DIR
 I Y=0!($D(DIRUT)) D DELXIT Q
 ;
 F LRI=1:1 S LRFILE=$P($T(FILES+LRI^VBECDCU1),";;",2) Q:LRFILE=""  D
 .S LRARY(LRFILE_".TXT")=""
 .Q
 I $O(LRARY(""))="" W !!,"System level legacy Blood Bank files not found.",$C(13)
 I  D DELXIT Q
 S LRARY("DBCONV.INI")=""
 S LRSLT=$$DEL^%ZISH(LRPATH,$NA(LRARY)) ;file names stored in an array
 W !!,"All system level legacy Blood Bank files "_$S(LRSLT=1:"have",1:"have not")_" been deleted.",$C(13)
 ;
DELXIT K DIR,DIRUT,DIROUT,DTOUT,DUOUT,LR6001,LRDATE,LRELPSE,LRFILE,LRHLP,LRI,LRPATH,LRPROC,LRSLT,X,Y
 Q
 ;
CHECKSUM(STR) ;This tag builds a checksum value for a string
 ; input: string value to be converted
 ;return: numeric checksum of the string
 ;
 N J,X,Y S X=$L(STR),Y=0
 F J=1:1:X S Y=$A(STR,J)*(J+1)+Y
 Q Y
 ;
DEL6001 ;Delete all data conversion and anomaly check history from the
 ;VBECS DATA INTEGRITY/CONVERSION STATISTICS (#6001) file.
 I '$O(^VBEC(6001,0)) W !!?3,"No data conversion and anomaly check history data to delete, exiting.",$C(7) Q
 W !!?3,"This option deletes all data conversion and anomaly check history"
 W !?3,"from the VBECS DATA INTEGRITY/CONVERSION STATISTICS (#6001) file.",!
 S DIR(0)="Y",DIR("A",1)="Are you sure you want to delete data conversion and anomaly check",DIR("A")="histories",DIR("B")="No"
 S DIR("?",1)="Enter 'Y'es to delete data conversion and anomaly check histories",DIR("?")="or 'N'o to prevent deletion."
 D ^DIR
 I Y=1 D  ;user answered 'yes' to the above question
 .S DIK="^VBEC(6001,",(DA,VBECNT)=0
 .F  S DA=$O(^VBEC(6001,DA)) Q:'DA  D ^DIK S VBECNT=VBECNT+1
 .W !!?3,"Done; "_VBECNT_" data conversion and anomaly check histor"_$S(VBECNT=1:"y",1:"ies")_" deleted."
 .K DA,DIC,DIK,VBECNT,X,Y
 .Q
 W:$D(DTOUT)#2 " Timed out without response, no data has been deleted.",$C(7)
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
