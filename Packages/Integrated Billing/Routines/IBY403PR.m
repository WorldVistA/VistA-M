IBY403PR ;BP/YMG - Pre-Installation for IB patch 403 ;26-Aug-2008
 ;;2.0;INTEGRATED BILLING;**403**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 D DELOF       ; delete all output formatter data elements included in build
 D DEFDIV      ; check default division
 Q
 ;
DELOF ; Delete included output formatter entries
 NEW FILE,DIK,LN,TAG,DATA,PCE,DA,Y
 F FILE=5,6,7 S DIK="^IBA(364."_FILE_"," F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 . Q
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are non-functioning or obsolete entries
 ; in file 364.6.
 S DIK="^IBA(364.6,",TAG="DEL6+2",DATA=$P($T(@TAG),";;",2)
 I DATA'="" D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA(364.6,DA,0)) D ^DIK
 . Q
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are non-functioning or obsolete entries
 ; in file 364.7.
 S DIK="^IBA(364.7,",TAG="DEL7+2",DATA=$P($T(@TAG),";;",2)
 I DATA'="" D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA(364.7,DA,0)) D ^DIK
 . Q
 ;
DELOFX ;
 Q
 ;
DEFDIV ; check and report on default division (350.9,1.25)
 N DEF,MAIN,DEFDN,MAINDN,DEFINST,MAININST,SITE,SUBJ,MSG,XMTO
 ;
 S DEF=+$P($G(^IBE(350.9,1,1)),U,25)          ; default division field from the IB site params
 S MAIN=+$$PRIM^VASITE()                      ; main division for VistA database
 I 'DEF G DEFDIVX                             ; exit if no default division
 I DEF=MAIN G DEFDIVX                         ; exit if they're the same
 I '$$PROD^XUPROD(1) G DEFDIVX                ; not a production account
 ;
 ; default division is different than main division - report on both
 S DEFDN=$$GET1^DIQ(40.8,DEF_",",.01)         ; default division name
 S MAINDN=$$GET1^DIQ(40.8,MAIN_",",.01)       ; main division name
 ;
 S DEFINST=$$SITE^VASITE($$DT^XLFDT,DEF)      ; default institution information
 S MAININST=$$SITE^VASITE($$DT^XLFDT,MAIN)    ; main institution information
 ;
 ; send email
 S SITE=$$SITE^VASITE
 S SUBJ="Station# "_$P(SITE,U,3)_" - "_$P(SITE,U,2)_" - Default/Main Division"
 S SUBJ=$E(SUBJ,1,65)
 S MSG(1)="Default Division Name:  "_DEFDN
 S MSG(2)="            Inst Name:  "_$P(DEFINST,U,2)
 S MSG(3)="             Station#:  "_$P(DEFINST,U,3)
 S MSG(4)=""
 S MSG(5)="   Main Division Name:  "_MAINDN
 S MSG(6)="            Inst Name:  "_$P(MAININST,U,2)
 S MSG(7)="             Station#:  "_$P(MAININST,U,3)
 ;
 S XMTO("Eric.Gustafson@domain.ext")=""
 ;
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO)
 ;
DEFDIVX ;
 Q
 ;
INCLUDE(FILE,Y) ; function to determine if output formatter entry should be
 ; included in the build
 ; FILE=5,6,7 indicating file 364.x
 ; Y=ien to file
 ;
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
INCLUDEX ;
 Q OK
 ;
INC3508(Y) ; function to determine if entry in IB ERROR file (350.8) should be included in the build
 ; Y - ien to file
 N DATA,ENTRY,LN,OK,TAG
 S OK=0,ENTRY=U_$P($G(^IBE(350.8,Y,0)),U,3)_U
 F LN=2:1 S TAG="ENT3508+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,ENTRY) S OK=1 Q
 Q OK
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 entries modified:
 ;
ENT5 ; output formatter entries in file 364.5 to be included
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries modified:
 ;
ENT6 ; output formatter entries in file 364.6 to be included
 ;
 ;;^93^952^1879^
 ;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries modified:
 ;
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^27^41^84^924^1015^1298^1371^1383^1384^1385^1386^1387^1388^1389^1390^1391^1392^1393^
 ;;^1394^1395^1396^1397^1398^1399^1400^1411^1579^
 ;;
 ;
 ;
 ;-----------------------------------------------------------------------
DEL6 ; remove output formatter entries in file 364.6 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
DEL7 ; remove output formatter entries in file 364.7 (not re-added)
 ;
 ;;
 ;
ENT3508 ; entries in file 350.8 to be included
 ;
 ;;^IB071^IB117^
 ;;
 ; 
