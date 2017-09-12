PRCG147P ;VMP/RB-COPY INVALID FILE TO TEMP SAVE AREA
 ;;5.1;IFCAP;**147**;Sept 22, 2010;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;  Post install routine in patch PRC*5.1*147 that will copy invalid file
 ;  ^PRC(410,... to a temporary save file for 120 days. 
 ;;
 Q
START ;Copy invalid file ^PRC(410,... to temp save
 I $D(^XTMP("PRCG147P")) Q
 K ^XTMP("PRCG147P") D NOW^%DTC S RMSTART=%
 S ^XTMP("PRCG147P","START COMPILE")=RMSTART
 S ^XTMP("PRCG147P","END COMPILE")="RUNNING"
 S ^XTMP("PRCG147P",0)=$$FMADD^XLFDT(RMSTART,120)_"^"_RMSTART
1 M ^XTMP("PRCG147P","PRC",410)=^PRC(410)
 K ^PRC(410)  ;KILL INVALID FILE, NOT DEFINED IN ^DD
EXIT ;
 D NOW^%DTC S RMEND=%
 S ^XTMP("PRCG147P","END COMPILE")=RMEND
 K RMSTART,RMEND,%
 Q
