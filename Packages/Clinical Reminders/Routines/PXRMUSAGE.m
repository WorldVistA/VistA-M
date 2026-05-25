PXRMUSAGE ; SLC/AGP - Routines for patient data source. ;Jun 30, 2025@12:31:34
 ;;2.0;CLINICAL REMINDERS;**45,87**;Feb 04, 2005;Build 35
 ;
 ;====================================
HUSAGE ;Usage field executable help text.
 ;;This is a free text field and can contain any combination of the
 ;;following codes:
 ;;
 ;;    Code   Usage
 ;;     A     Action
 ;;     B     Branching Logic
 ;;     C     CPRS
 ;;     I     Information Panel
 ;;     L     Reminder Patient List
 ;;     O     Reminder Order Checks
 ;;     P     Patient
 ;;     R     Reminder Reports
 ;;     X     Reminder Extracts
 ;;     *     All of the above, except L, O, and P.
 ;;
 ;; If the Usage field contains either a L or an O value the Reminder
 ;; definition will not be evalauted in CPRS no matter if the Usage field
 ;; contains C.
 ;;
 ;;Examples:
 ;;C  = Can be used in CPRS
 ;;CL = Cannot be used in CPRS, can be used in Reminder List Rules
 ;;CO = Cannot be used in CPRS, can be used in Reminder Order Check Groups
 ;;CP = Can be used in CPRS
 ;;A  = Can be used in CPRS, this value is used by Reminder Definitions used for
 ;;     Business Logic
 ;;CI = Can be used in CPRS, and CPRS Information Panel
 ;;*I = Can be used in CPRS, Reminder Components (except Patient List,
 ;;     and Order Checks), can be used in CPRS Information Panel
 ;;*P = Can be used in CPRS, Reminder Components (except Patient List,
 ;;     and Order Checks)
 ;;*  = Can be used in CPRS
 ;;
 ;;**End Text**
 Q
 ;
 ;====================================
USAGEXHELP ;Taxonomy field Patient Data Source executable help.
 N DONE,DIR0,IND,TEXT
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(HUSAGE+IND),";",3)
 . I TEXT(IND)="**End Text**" K TEXT(IND) S DONE=1 Q
 D BROWSE^DDBR("TEXT","NR","Usage Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
