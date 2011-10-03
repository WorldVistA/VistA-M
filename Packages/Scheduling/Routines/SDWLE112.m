SDWLE112 ;;IOFO BAY PINES/TEH - WAITING LIST-ENTER/EDIT;06/12/2002 ; 20 Aug 2002  2:10 PM
 ;;5.3;scheduling;**263,273**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;  11/27/02                                     SD*5.3*273                              Add "/" to line EN+14 
 ;   
 ;   
 ;
EN ;
 ;Set record status to 'OPEN'
 ;
 S DR="23///^S X=""O""",DIE="^SDWL(409.3," D ^DIE
 ;
 ;Ask comments
 ;
 S DIR(0)="FAOU^^",DIR("A")="Comments: " D ^DIR
 I Y["^" S SDWLERR=2 Q
 S DR="25////^S X=SDWLCOME " D ^DIE
 ;
 ;
 ;Set Editing User
 ;
 S DR="28////^S X=DUZ",DIE="^SDWL(409.3," D ^DIE
 ;
 S SDWLERR=0 Q
 Q
END K SDWLCN,SDWLCN,SDWLPS,SDWLY,SDWLNEW,SDWLSSN,SDWLNAM,SDWLDATA,SDWLIN,SDWLCL,SDWLTY,SDWLST,SDWLSP,SDWLSS
 K SDWLSC,SDWLPRI,SDWLRB,SDWLPROV,SDWLDAPT,SDWLST,SDWLCOM,SDWLDUZ,SDWLEDT,SDCL,SDWLTYE,SDWLINE,SDWLS,SDWLX,SDWLPRIE,SDWLPRVE
 K SDWLDAPE,SDWLRBE,SDWL,VA,VADM,VAIN,D0,DA,DI,DIC,DIE,DQ,DR,SDWLCLN,SDWLCNT,SDWLDIS,SDWLDISN,SDWLDT,SDWLDTP,SDWLINN,SDWLPRIN,SDWLTYN
 K SDWLWR,VAERR,YY,MM,DD,SDWLSCP,SDWLVAR,SDWLF,SDWLSX,SDWLCP1,SCWLCP2,SDWLCP2,SDWLCP3,SDWLCP4,SDWLCP5,SDWLCP6,E,SDWLCOME,SDWLDFN,SDWLPCMM
 K DIR
 I $D(SDWLDA),$D(^SDWL(409.3,SDWLDA,0)),$P(^SDWL(409.3,SDWLDA,0),U,17)'["O" D
 .W !!,?15,"***  Patient being Removed from Wait List  ***" S DIK="^SDWL(409.3,",DA=SDWLDA D ^DIK
 K SDWLDA
 Q
