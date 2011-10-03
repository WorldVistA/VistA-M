MAGXIDX0 ;WOIFO/JSL - MAG INDEX TERMS BUILD/UPDATE Utilities
 ;;3.0;IMAGING;**61**;Feb 07, 2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed             |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 Q
WARNMSG ;called by PRECHK^MAGMIDXU
 N DIWR,DIWL,DIWF K ^UTILITY($J,"W")
 S ANS="",DIWR=80,DIWL=1
 U IO(0) W !
 S X="|NOWRAP|" D ^DIWP
 S X="======================================================================" D ^DIWP
 S X=">>>                   PATIENT SAFETY WARNING                       <<<" D ^DIWP
 S X=">>>     Read This Notice Before Installing the Term Update File    <<<" D ^DIWP
 S X="======================================================================" D ^DIWP
 S X="|WRAP|" D ^DIWP
 S X="Index term files are nationally standard files that are maintained by the VistA Imaging Team. Sites are only permitted to modify the value of the STATUS" D ^DIWP
 S X="(active/inactive) field on two index term files : IMAGE INDEX FOR PROCEDURE/EVENT and IMAGE INDEX FOR SPECIALTY/SUBSPECIALTY." D ^DIWP
 S X="Except for these two STATUS fields, NO LOCAL ADDITIONS, DELETIONS, OR MODIFICATIONS ARE PERMITTED to the index term files. Files to which additions, deletions and modifications are NOT to be made locally" D ^DIWP
 S X="include the following:" D ^DIWP
 S X="|NOWRAP|" D ^DIWP
 S X="    IMAGE INDEX FOR CLASS (#2005.82)" D ^DIWP
 S X="    IMAGE INDEX FOR TYPES (#2005.83)" D ^DIWP
 S X="    IMAGE INDEX FOR SPECIALTY/SUBSPECIALTY (#2005.84) (except the STATUS field)" D ^DIWP
 S X="    IMAGE INDEX FOR PROCEDURE/EVENT (#2005.85) (except the STATUS field)" D ^DIWP
 S X="|WRAP|" D ^DIWP
 S X="Additions, deletions or modifications to index term files by local sites risk overwriting or other loss of information as distributions from the VistA Imaging Team are installed." D ^DIWP
 S X="Loss of information that is used to make patient treatment decisions could have a negative impact on patient safety." D ^DIWP
 S X="If you believe that any entries on your index term files may have been added, deleted or modified locally, DO NOT INSTALL THIS UPDATE!" D ^DIWP
 S X="Instead, please place a Remedy call IMMEDIATELY to VistA Imaging Support." D ^DIWP
 D ^DIWW H 5
 Q
INXMB() ;DBIA #2723 - get last IN mail msg
 Q:'$G(DUZ) 0
 N SUBJ,N
 K ^TMP("XMLIST",$J)
 S SUBJ("SUBJ")="MAG INDEX TERMS UPDATE"
 D LISTMSGS^XMXAPIB(DUZ,1,"SUBJ","B",10,,.SUBJ)
 F N=1:1:10 I $G(^TMP("XMLIST",$J,N,"SUBJ"))=SUBJ("SUBJ") Q
 Q +$G(^TMP("XMLIST",$J,N))
SPEC ;MENU OPT - IMAGE INDEX SPECIALTY/SUBSPECIALTY
 N DIC,DLAYGO,DA,DIE,DR
 S (DIC,DLAYGO)=2005.84,DIC(0)="AMEQ" D ^DIC Q:Y=-1
 S DA=+Y,DIE="^MAG(2005.84,",DR="4//" D ^DIE
 G SPEC
PROC ;MENU OPT - IMAGE INDEX PROCEDURE/EVENT
 N DIC,DLAYGO,DA,DIE,DR
 S (DIC,DLAYGO)=2005.85,DIC(0)="AMEQ" D ^DIC Q:Y=-1
 S DA=+Y,DIE="^MAG(2005.85,",DR="4//" D ^DIE
 G PROC
