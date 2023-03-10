LR553A ;SLC/JNM - LAB ANATOMIC PATHOLOGY UPDATE ;Mar 01, 2022@13:19:07
 ;;5.2;LAB SERVICE;**553**;Feb 14, 1996;Build 21
 ;
 Q
 ;
 ;
PRE ; Pre Install of LR*5.2*553
 ;
 N DIU
 ;
 ;Backup Data in 69.73
 I '$D(^XTMP("LR*5.2*553","BACKUP")) D
 . D BMES("Backing up file 69.73 to ^XTMP.")
 . M ^XTMP("LR*5.2*553","BACKUP")=^LAB(69.73)
 S ^XTMP("LR*5.2*553",0)=$$FMADD^XLFDT(DT,180)_U_DT_U_"Backup of File 69.73"
 ;
 ; delete file 69.73 (including data and templates)
 D BMES("Deleting file 69.73.")
 S DIU="^LAB(69.73,"
 S DIU(0)="DT"
 D EN^DIU2
 ;
 Q
 ;
RESTORE ; Restore File 69.73 from backup
 I $D(^XTMP("LR*5.2*553","BACKUP")) D
 . K ^LAB(69.73)
 . M ^LAB(69.73)=^XTMP("LR*5.2*553","BACKUP")
 Q
 ;
BMES(STR) ;
 ; Write string
 D BMES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
