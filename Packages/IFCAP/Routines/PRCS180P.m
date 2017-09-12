PRCS180P ;RB-POST INSTALL PRC*180 TO ADD 410.9 entry ;4-26-94/3:45 PM
V ;;5.1;IFCAP;**180**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
START ;PRC*5.1*180 Updating file 410.9 [Authority of Request File] with new
 ;            sub authority 'R', PC Patient-Centered Community Care
A S DIC="^PRCS(410.9,",X="R"
 S DLAYGO=410.9,DIC(0)="LXZ" D ^DIC S DA=+Y
 S DESCRIP="PATIENT-CENTERED COMMUNITY CARE (PC3) CENTRALIZED ADMIN FEE",FMSCODE="3R"
 S DIE="^PRCS(410.9,",DR=".02///^S X=DESCRIP;.03////3;.05///1;.06///0;.07///^S X=FMSCODE"
 D ^DIE
 D BMES^XPDUTL("Update of Authority of Request File *completed*:")
 D MES^XPDUTL("  Added ==> R - PATIENT-CENTERED COMMUNITY CARE (PC3) CENTRALIZED ADMIN FEE")
 K DIC,DIE,Y,DLAYGO,MREC,DA,DR,X,DLAYGO,DESCRIP,FMSCODE
 Q
