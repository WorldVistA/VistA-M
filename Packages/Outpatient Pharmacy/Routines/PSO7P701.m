PSO7P701 ;DAL/JCH - Post Install routine for patch PSO*7*701 ;08/30/2022
 ;;7.0;OUTPATIENT PHARMACY;**701**;DEC 1997;Build 3
 Q
EN ; Post-Installation Entry Point
 N ERR,OPTNAME,MENUTEXT
 N DIFROM
 S DUZ=$S($G(DUZ):+$G(DUZ),1:.5)
 ;
 S OPTNAME="PSO EPCS PSDRPH KEY"
 S MENUTEXT="Allocate/De-Allocate of PSDRPH Key (Audited)"
 D EDMNUTXT(OPTNAME,MENUTEXT)
 ;
 I $D(ZTQUEUED) S ZTREQ="@"  ; Kernel Environment variables. If queued, remove task when complete.
 Q
 ;
EDMNUTXT(NAME,TEXT) ; Edit Menu Text
 ; NAME - The NAME field (#.01) in the OPTION file (#19) of the option to edit.
 ; TEXT - The new value of the MENU TEXT field (#1) in the OPTION file (#19) of the option being edited.
 ;
 N PSOFDA
 ;
 S OPTIEN=$$FIND1^DIC(19,"","X","PSO EPCS PSDRPH KEY")
 Q:'OPTIEN  ; Option doesn't exist, can't edit
 ;
 S PSOFDA(19,OPTIEN_",",1)=TEXT
 D FILE^DIE(,"PSOFDA") K FDA
 Q
