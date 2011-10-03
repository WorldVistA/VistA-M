RMPRN6XM ;Hines OIFO/HNC - NPPD Auto-Fix ;9/16/02  11:14
 ;;3.0;PROSTHETICS;**70,90**;Feb 09, 1996
 Q
TASK ;main entry point
 ;look at file 660, field #2 Type.
 ;this will need to be updated with 1=new and 2=repair.
 ;
 ;"I" = initial issue = new
 ;"R" = replace = new
 ;"S" = spare = new
 ;"X" = repair = repair
 ; 5  = rental = repair added with patch 90
 ;
 K ^TMP($J)
 S B=0,LINE=""
 F  S B=$O(^RMPR(660,B)) Q:B'>0  D
 .S TYPE=$P($G(^RMPR(660,B,0)),U,4)
 .I TYPE=5 Q  ;No change if Rental just quit.
 .;if type is null, then Home Oxygen Posted with no type, and that is
 .;a repair NPPD line. Or, shipping and that is repair.
 .I TYPE="" S TYPE="X"
 .S PHCPCS=$P($G(^RMPR(660,B,1)),U,4)
 .;junk in the global - alpha
 .Q:PHCPCS'>0
 .Q:PHCPCS=""
 .I TYPE'="X" S LINE=$P(^RMPR(661.1,PHCPCS,0),U,7)
 .I LINE="" D
 .    .S ERR=""
 .    .S LINE=$P(^RMPR(661.1,PHCPCS,0),U,6)
 .    .S TYPE="X"
 .    .S DIE="^RMPR(660,",DA=B,DR="2///^S X=TYPE"
 .    .L +^RMPR(660,B):1 I '$T S ERR=1
 .    .W !,B,"  ",ERR
 .    .I ERR=1 S ^TMP($J,"RMPRA",B)="NO UPDATE!"
 .    .I ERR="" D ^DIE L -^RMPR(660,B)
 .    .K DIE,DA,DR
 .    .I ERR="" S ^TMP($J,"RMPRA",B)="NEW TO REPAIR"
 .    .D DATA
 .I TYPE="X" S LINE=$P(^RMPR(661.1,PHCPCS,0),U,6)
 .I LINE="" D
 .    .S ERR=""
 .    .S LINE=$P(^RMPR(661.1,PHCPCS,0),U,7)
 .    .S TYPE="I"
 .    .S DIE="^RMPR(660,",DA=B,DR="2///^S X=TYPE"
 .    .L +^RMPR(660,B):1 I '$T S ERR=1
 .    .I ERR=1 S ^TMP($J,"RMPRA",B)="NO UPDATE!"
 .    .I ERR="" D ^DIE L -^RMPR(660,B)
 .    .K DIE,DA,DR
 .    .I ERR="" S ^TMP($J,"RMPRA",B)="REPAIR TO NEW "
 .    .D DATA
 K B,LINE,PHCPCS,TYPE
 D FMT
 I $D(^TMP($J,"RMPR")) D MAIL
 G EXIT
 Q
DATA ;delimited tmp with data
 D GETS^DIQ(660,B,".01;.02;4.5;5;7;8.3;14;4;24;27","","RMXM")
 S $P(^TMP($J,"RMPRA",B),U,2)=$G(RMXM(660,B_",",.01))
 S $P(^TMP($J,"RMPRA",B),U,3)=$G(RMXM(660,B_",",.02))
 S $P(^TMP($J,"RMPRA",B),U,4)=$G(RMXM(660,B_",",4.5))
 S $P(^TMP($J,"RMPRA",B),U,5)=$G(RMXM(660,B_",",5))
 S $P(^TMP($J,"RMPRA",B),U,6)=$G(RMXM(660,B_",",7))
 S $P(^TMP($J,"RMPRA",B),U,7)=$G(RMXM(660,B_",",8.3))
 S $P(^TMP($J,"RMPRA",B),U,8)=$G(RMXM(660,B_",",14))
 S $P(^TMP($J,"RMPRA",B),U,9)=$G(RMXM(660,B_",",4))
 S $P(^TMP($J,"RMPRA",B),U,10)=$G(RMXM(660,B_",",27))
 S $P(^TMP($J,"RMPRA",B),U,11)=LINE
 S $P(^TMP($J,"RMPRA",B),U,12)=$G(RMXM(660,B_",",24))
 K RMXM
 Q
FMT ;format the records for report display
 S B=0,^TMP($J,"RMPRFMT")="",CNT=0
 F  S B=$O(^TMP($J,"RMPRA",B)) Q:B'>0  D
 .S DATA=^TMP($J,"RMPRA",B)
 .S (B1,BX,B3,B4,B5,B6,B7,B8)=""
 .S B2="^TMP($J,""RMPRFMT"")"
 .S B1=$$SETSTR^VALM1($P(DATA,U,1),@B2,1,14)
 .S BX=$$SETSTR^VALM1($P(DATA,U,2),@B2,1,14)
 .S B3=$$SETSTR^VALM1($P(DATA,U,3),@B2,1,11)
 .S B4=$$SETSTR^VALM1($P(DATA,U,4),@B2,1,6)
 .S B5=$$SETSTR^VALM1($P(DATA,U,9),@B2,1,10)
 .S B6=$$SETSTR^VALM1($P(DATA,U,6),@B2,2,11)
 .S B7=$$SETSTR^VALM1($P(DATA,U,10),@B2,2,12)
 .S OLDLN=$P(DATA,U,1)
 .I OLDLN["REPAIR TO NEW" S OLDLN="R99 X"
 .I OLDLN["NEW TO REPAIR" S OLDLN="999 X"
 .I OLDLN["NO UPDATE!" S OLDLN="????"
 .;
 .S CNT=CNT+1
 .S ^TMP($J,"RMPR",CNT)=B1
 .S CNT=CNT+1
 .S ^TMP($J,"RMPR",CNT)="Create Date   Patient    HCPCS Item       Vendor      PA"
 .S CNT=CNT+1
 .S ^TMP($J,"RMPR",CNT)=BX_B3_B4_B8_B5_B6_B7
 .S CNT=CNT+1
 .S ^TMP($J,"RMPR",CNT)=""
 .S CNT=CNT+1
 .S ^TMP($J,"RMPR",CNT)="Brief Description: "_$P(DATA,U,12)
 .S CNT=CNT+1
 .S ^TMP($J,"RMPR",CNT)=""
 .S CNT=CNT+1
 .I OLDLN'="????" S ^TMP($J,"RMPR",CNT)="Changed From Line "_OLDLN_" To NPPD Line: "_$P(DATA,U,11)_"  Local Record #:"_B
 .I OLDLN="????" S ^TMP($J,"RMPR",CNT)="Nothing Changed, Someone Was Editing Record.  Local Record #:"_B
 .S CNT=CNT+1
 .S ^TMP($J,"RMPR",CNT)="-------------------------------------------------------------------------------"
 Q
 ;
MAIL ;send report via message to mail group RMPR INVENTORY
 ;
 S XMY("G.RMPR INVENTORY")=""
 S XMDUZ=.5
 S XMTEXT="^TMP($J,""RMPR"","
 S XMSUB="Prosthetics Auto-Fix"
 D ^XMD
 Q
 ;
EXIT ;common exit point
 K ^TMP($J,"RMPRA"),^TMP($J,"RMPR")
 Q
 ;END
