PXRMUSAGE ; SLC/AGP - Routines for patient data source. ;11/19/2019
 ;;2.0;CLINICAL REMINDERS;**45**;Feb 04, 2005;Build 566
 ;
 ;====================================
HUSAGE ;Usage field executable help text.
 ;;This is a free text field and can contain any combination of the
 ;;following codes:
 ;;
 ;;    Code   Usage
 ;;     A     Action
 ;;     C     CPRS
 ;;     L     Reminder Patient List
 ;;     O     Reminder Order Checks
 ;;     P     Patient
 ;;     R     Reminder Reports
 ;;     X     Reminder Extracts
 ;;     *     All of the above, excpet L, O, and P.
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
