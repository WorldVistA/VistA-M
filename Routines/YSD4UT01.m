YSD4UT01 ;DALISC/LJA - DSM-IV Conversion Utilities ; [ 04/04/94  12:06 PM ]
 ;;5.01;MENTAL HEALTH;**1**;Dec 30, 1994
 ;
KILLALL ;  Kill all local and global variables created by DSM-Converson.
 K A7U0,A7U3,A7U70,A7U7D,A7UIEN,A7U7K,A7U7Q,A7UIEN,A7UK,A7UQ,AYUX
 K ACTION,CHOICE,CT,DA,DD,DIC,DIE,DIFQ,DIK,DIQ,DIR,DIU
 K D0,DO,DR,FF,FILE,GREF,IEN,IENDSM,J,LINE,MSG,N0,ND,NK,NM,NO,NODE,NQ
 K OK,ONO,POP,POS,POSTLF,PRELF,QNO,STOP,TYPE,USERS,V,VT,X,Y
 K YSD4,YSD40,YSD41,YSD42,YSD43,YSD430,YSD49N
 K YSD4ABRT,YSD4ACT,YSD4ALL,YSD4CFLD,YSD4CFLG,YSD4CIEN
 K YSD4CNT3,YSD4CNTR,YSD4COND,YSD4CONT,YSD4CONV,YSD4CT,YSD4D
 K YSD4DATA,YSD4DDNO,YSD4DFN,YSD4DIEN,YSD4DIRA,YSD4DR0
 K YSD4DSP,YSD4DT,YSD4DUZ,YSD4DX1,YSD4DX1C,YSD4DX1F,YSD4DXNO,YSD4E
 K YSD4E0,YSD4E1,YSD4EABT,YSD4ECON,YSD4ECTR,YSD4EDE,YSD4EDR
 K YSD4EDT,YSD4EFN,YSD4EIEN,YSD4EL,YSD4EMIN,YSD4EMR
 K YSD4END,YSD4ENO,YSD4EOTH,YSD4EP,YSD4EPID
 K YSD4EPN,YSD4EQID,YSD4ERD,YSD4ERR,YSD4EREP,YSD4ESMD,YSD4ESME,YSD4ESTE
 K YSD4ETXT,YSD4FND,YSD4GCT,YSD4I,YSD4IDT,YSD4IEN,YSD4INO,YSD4KF
 K YSD4L,YSD4LINE,YSD4M,YSD4MCH,YSD4MENU,YSD4MIEN,YSD4MLC
 K YSD4MNO,YSD4N,YSD4NC,YSD4ND,YSD4NDN,YSD4NDX,YSD4NM
 K YSD4NMNU,YSD4NO,YSD4NODE,YSD4NREA,YSD4NV,YSD4ODX,YSD4ODX1
 K YSD4OK,YSD4P,YSD4PDX,YSD4R,YSD4REA,YSD4REF,YSD4RFLG
 K YSD4S1,YSD4S2,YSD4SCR,YSD4SITE,YSD4ST,YSD4STE,YSD4STR,YSD4TXT,YSD4V
 K YSD4VAR,YSD4X,YSNM,YSNO,YSPNOPT
 K ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE
 QUIT
 ;
DELDATA ;  Delete all data in the DSM Conversion file
 ;
 ;  Any data?
 I '$O(^YSD(627.99,0)) D  QUIT  ;->
 .  W !!,"The DSM Conversion file contains no data!!"
 .  H 4
 ;
 ;  Inform...
 W !!,"The DSM Conversion (#627.99) file holds data generated during the Mental"
 W !,"Health V. 5.01 post init repointing of DSM patient data.  This file will be"
 W !,"deleted when the next version of Mental Health is installed.  However, you"
 W !,"may wish to delete the data in this file now.  (This should not be done"
 W !,"until Mental Health V. 5.01 has been used by clinicians entering, editing,"
 W !,"and viewing DSM data, for a sufficient length of time to detect"
 W !,"any conversion problems.)",!!
 W !!,"You are about to delete the data contained in the DSM Conversion file!!",!!
 ;
 ;  Ask permission...
 N DIR
 S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="No"
 D ^DIR
 I +Y'=1 D  QUIT  ;->
 .  W "  ... No action taken ..."
 .  H 3
 ;
 ;  Ask for one more verification...
 W !!,"The data in the DSM Conversion file will now be deleted!!!",!!
 H 1
 K DIR
 S DIR(0)="EA",DIR("A")="Press RETURN, or any other key to begin deletion... "
 D ^DIR
 I +Y'=1 D  QUIT  ;->
 .  W "   ... No action taken ..."
 .  H 3
 ;
 ;  OK.  Now, delete...
 S X=$G(^YSD(627.99,0)),YSNEW0=$P(X,U,1,2)_U_U
 I YSNEW0'["DSM CONVERSION" D  QUIT  ;->
 .  W "  ... Invalid 0 node!! No action taken ..."
 .  H 3
 K ^YSD(627.99)
 S ^YSD(627.99,0)=YSNEW0
 K YSNEW0
 W "  ... All data deleted ..."
 H 3
 QUIT
 ;
EOR ;YSD4UT01 - DSM-IV Conversion Utilities ; 3/24/94 16:12
