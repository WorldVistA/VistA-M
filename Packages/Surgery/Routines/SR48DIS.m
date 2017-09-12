SR48DIS ;BIR/ADM-Disposition conversion from set of codes to file; [ 09/19/96  8:22 PM ]
 ;;3.0; Surgery ;**48**;24 Jun 93
ENV Q:$P(^DD(130,.43,0),"^",2)'["S"
 W !!,"This patch will convert the code in each of the following fields to a",!,"pointer to the SURGERY DISPOSITION file (#131.6):",!,?5,"REQ POSTOP CARE (#.43)",!,?5,"OP DISPOSITION (#.46)",!,?5,"PACU DISPOSITION (#.79)"
 W !!,"If your facility has modified the set of codes for any of these 3 fields,",!,"the conversion process may not be able to convert those fields completely."
 W !,"If dispositions have been added locally, the conversion process will attempt",!,"to add them to the SURGERY DISPOSITION file (#131.6)."
 W !!,"Checking for local modifications to these fields..." S NOMOD=1
 S MOD=0,SRX=$P(^DD(130,.43,0),"^",3),SRX1="M:MICU;S:SICU;C:CCU;I:STEPDOWN;W:WARD;O:OUTPATIENT;" S:SRX'=SRX1 MOD=1,NOMOD=0
 I MOD W !!,">>> Local modifications detected in REQ POSTOP CARE (#.43)" D MOD
 S MOD=0,SRX=$P(^DD(130,.46,0),"^",3),SRX1="R:PACU (RECOVERY ROOM);W:WARD;M:MICU;S:SICU;C:CCU;O:OUTPATIENT;I:STEP DOWN;D:MORGUE;" S:SRX'=SRX1 MOD=1,NOMOD=0
 I MOD W !!,">>> Local modifications detected in OP DISPOSITION (#.46)" D MOD
 S MOD=0,SRX=$P(^DD(130,.79,0),"^",3),SRX1="M:MICU;S:SICU;C:CCU;I:STEP DOWN;O:OUTPATIENT;D:DEATH;W:WARD;OR:OPERATING ROOM;" S:SRX'=SRX1 MOD=1,NOMOD=0
 I MOD W !!,">>> Local modifications detected in PACU DISPOSITION (#.79)" D MOD
 I 'NOMOD W !!,"Any fields that cannot be converted will be listed and will have to be",!,"converted manually using VA FileMan.",!
 I NOMOD W !!,"No local modifications found."
 W ! K DIR S DIR("?",1)="Enter YES to proceed with this patch installation.  Enter NO or '^' to exit",DIR("?")="without making any changes."
 S DIR("A")="Are you sure you want to continue (Y/N)",DIR(0)="Y" D ^DIR K DIR I 'Y!$D(DTOUT)!$D(DUOUT) S XPDQUIT=2 G END
 Q
PRE ; entry for pre-init process
 Q:$P(^DD(130,.43,0),"^",2)'["S"
 N %
 S %=$$NEWCP^XPDUTL("SR481","GO^SR48DIS","0")
 Q
GO ; install data in file 131.6
 D BMES^XPDUTL("Installing data for SURGERY DISPOSITION file (#131.6)...")
 D ^SR48DIS0
 S SRX=$P(^DD(130,.43,0),"^",3),SRX1="M:MICU;S:SICU;C:CCU;I:STEPDOWN;W:WARD;O:OUTPATIENTI;" D COMP
 S SRX=$P(^DD(130,.46,0),"^",3),SRX1="R:PACU (RECOVERY ROOM);W:WARD;M:MICU;S:SICU;C:CCU;O:OUTPATIENT;I:STEP DOWN;D:MORGUE;" D COMP
 S SRX=$P(^DD(130,.79,0),"^",3),SRX1="M:MICU;S:SICU;C:CCU;I:STEP DOWN;O:OUTPATIENT;D:DEATH;W:WARD;OR:OPERATING ROOM;" D COMP
CONV ; convert data in file 130
 K ^TMP("SR48",$J) S SRNODE=5,SRCASES=0 D BMES^XPDUTL("Beginning automatic conversion of disposition data fields...")
 ; get parameter value to initialize SRTN
 S SRTN=$$PARCP^XPDUTL("SR481")
 F  S SRTN=$O(^SRF(SRTN)) Q:'SRTN  D DISP S %=$$UPCP^XPDUTL("SR481",SRTN)
 D MES^XPDUTL("Automatic conversion process is finished.")
 I SRNODE=5 D MES^XPDUTL("No manual conversions will be necessary.")
 I SRNODE>5 D
 .D MES^XPDUTL("Some manual conversions will be necessary.  See mail message for details.")
 .D NOW^%DTC S SRNOW=$E(%,1,12),SRNOW=$$FMTE^XLFDT(SRNOW)
 .S ^TMP("SR48",$J,1)="The patch SR*3*48 data conversion process finished "_SRNOW_".",^TMP("SR48",$J,2)=""
 .S ^TMP("SR48",$J,3)="The following is a list of disposition fields that could not be converted.",^TMP("SR48",$J,4)=""
 .S XMSUB="SR*3*48 Disposition Data Conversion",XMDUZ=DUZ,XMY(DUZ)="",XMTEXT="^TMP(""SR48"",$J," D ^XMD K XMSUB,XMTEXT,XMY,^TMP("SR48",$J)
END K MOD,NOMOD,SRTN D ^SRSKILL
 Q
COMP I SRX=SRX1 Q
 F SRI=1:1 S SRJ=$P(SRX,";",SRI) Q:SRJ=""  S SRCODE=$P(SRJ,":"),SRDISP=$P(SRJ,":",2) D
 .S SRE=$O(^SRO(131.6,"B",SRDISP,0)) S:'SRE SRE=$O(^SRO(131.6,"D",SRDISP,0)) I SRE,SRCODE'=$P(^SRO(131.6,SRE,0),"^",2) S ^SRO(131.6,"C",SRCODE,SRE)="" Q
 .I 'SRE D
 ..S SR(0)=^SRO(131.6,0),X=$P(SR(0),"^",3)+1,Y=$P(SR(0),"^",4)+1,^SRO(131.6,Y,0)=SRDISP_"^"_SRCODE,^SRO(131.6,"B",SRDISP,Y)="",^SRO(131.6,"C",SRCODE,Y)="",$P(^SRO(131.6,0),"^",3,4)=X_"^"_Y
 ..D MES^XPDUTL(SRDISP_" added to SURGERY DISPOSITION file (#131.6)")
 Q
DISP ; point fields .43, .46 and .79 to SURGERY DISPOSITION file
 S SRC=0,SRL=.43,SRY=$P($G(^SRF(SRTN,.4)),"^",3) D C I SRC S $P(^SRF(SRTN,.4),"^",3)=SRX
 S SRC=0,SRL=.46,SRY=$P($G(^SRF(SRTN,.4)),"^",6) D C I SRC S $P(^SRF(SRTN,.4),"^",6)=SRX
 S SRC=0,SRL=.79,SRY=$P($G(^SRF(SRTN,.7)),"^",9) D C I SRC S $P(^SRF(SRTN,.7),"^",9)=SRX
 S SRCASES=SRCASES+1 I '(SRCASES#1000) D MES^XPDUTL("    "_SRCASES_" cases processed...")
 Q
C Q:SRY=""  S (SRCT,SRZ)=0 F  S SRZ=$O(^SRO(131.6,"C",SRY,SRZ)) Q:'SRZ  S SRCT=SRCT+1,SRX=SRZ
 I SRCT=1 S SRC=1 Q
NOMTCH ; if match for code cannot cannot be determined, write message
 S ^TMP("SR48",$J,SRNODE)="Cannot convert field "_SRL_" on case #"_SRTN_".  Must convert manually.",SRNODE=SRNODE+1
 Q
MOD ; if local mods, display standard codes and site codes
 W !!,"* Standard Set *",?30,"* Your Set *",!,"Code:Stands For",?30,"Code:Stands For",!,"---------------",?30,"---------------",!
 F I=1:1 S X=$P(SRX1,";",I) W:X'="" X S Y=$P(SRX,";",I) W:Y'="" ?30,Y Q:X=""&(Y="")  W !
 Q
