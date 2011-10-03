PSGPLD ;BIR/CML3-DELETE A PICK LIST ;14 OCT 97 / 9:57 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 D ENCV^PSGSETU I $D(XQUIT) Q
 K DIC F  S DIC="^PS(57.5,",DIC(0)="QEAM",DIC("S")="I $P(^(0),""^"",2)=""P""" W ! D ^DIC K DIC G:Y'>0 DONE Q:$S($D(^PS(53.5,"AB",+Y))&$D(^PS(57.5,+Y,2)):^(2)]"",1:0)  W !!,"NO PICK LIST FOUND FOR THIS WARD GROUP."
 S WG=+Y,WGN=$P(Y,"^",2),RU=^PS(57.5,WG,2),PLP=+RU I '$$LOCK^PSGPLUTL(PLP,"PSGPL")  W $C(7),$C(7),!!,"  *** THE LATEST PICK LIST FOR THIS WARD GROUP IS CURRENTLY RUNNING! ***" G PSGPLD
 I $D(^PS(53.5,"AF",PLP)) W !!,"THE LATEST PICK LIST FOR THIS WARD GROUP IS BEING FILED AWAY." D ENQ^PSGPLDP,UNLOCK^PSGPLUTL(PLP,"PSGPL") G PSGPLD
 S RD=$P(RU,"^",2),(SD,XD)=$P(RU,"^",3),FD=$P(RU,"^",4),RU=$P(RU,"^",5),RUN=$P($G(^VA(200,+RU,0)),"^") S:RUN="" RUN=RU F X="FD","RD","SD" S @X=$$ENDTC^PSGMI(@X)
 I $D(^PS(53.5,"AO",WG,XD,PLP)) W !!,"THE LATEST PICK LIST FOR THIS WARD GROUP HAS ALREADY BEEN FILED AWAY." D UNLOCK^PSGPLUTL(PLP,"PSGPL") G PSGPLD
 D INFO F  W !!,"DO YOU WANT TO DELETE THIS PICK LIST" S %=0 D YN^DICN Q:%  D:%Y?1."?" QUES W:%Y'?1."?" $C(7),"  (Answer required.)"
 I %'=1 D UNLOCK^PSGPLUTL(PLP,"PSGPL") G PSGPLD
 W !!,"...a few moments, please..."
 F  L +^PS(57.5,WG,2):0 I  D  Q
 .; Naked Ref. below is from the lock on the line below
 .S ^(2)=$P(^PS(57.5,WG,2),"^",6,15) K ^PS(53.5,PLP),^PS(53.5,"AC",PLP),^PS(53.5,"AU",PLP),^PS(53.5,"A",WG,PLP),^PS(53.5,"B",PLP),^PS(53.5,"AB",WG,XD,PLP),^PS(53.5,"AO",WG,XD,PLP),^PS(53.5,"AF",PLP) W "." D:RU'=DUZ MMSG W "." Q
 L -^PS(57.5,WG,2) D UNLOCK^PSGPLUTL(PLP,"PSGPL") W ".DONE!"
 ;
DONE ;
 D ENKV^PSGSETU K FD,L,PLP,RD,RU,RUN,SD,WG,WGN,XD,XMZ Q
 ;
QUES ;
 W !!,"  Enter a 'Y' to delete this Pick List.  Enter an 'N' to leave this Pick List asit is.  PLEASE NOTE that deleted Pick Lists are gone completely and are",!,"irretrievable." Q:%Y'?2."?"
 ;
INFO ;
 W !!,"The last Pick List was last run for ",WGN,!,"by ",$S(RU'=RUN:RUN,1:RUN_" (NOT FOUND)")," on ",RD,!,"Pick List number ",PLP,", for ",SD," through ",FD,"." Q
 ;
MMSG ;
 K PSG S ND=$P($G(^VA(200,DUZ,0)),"^") S:ND="" ND=DUZ
 S XMSUB="PICK LIST DELETION",XMTEXT="PSG(",XMDUZ="MEDICATIONS,UNIT DOSE" K XMY S (XMY(RU),XMY(+DUZ))=1 F Q=0:0 S Q=$O(^XUSEC("PSJU MGR",Q)) Q:'Q  S XMY(Q)=""
 ; I 'XMDUZ D ENNU^PSGPLFM S XMDUZ=$O(^VA(200,"B","MEDICATIONS,UNIT DOSE",0))
 S X="  "_ND_" has deleted the Pick List for ward group "_WGN_" run by "_RUN_" on "_RD_".  The coverage dates for this pick list were "_SD_" through "_FD_"."
 S Y=1,PSG(1,0)="  " F Q=1:1 Q:$P(X," ",Q,999)=""  X:$L(PSG(Y,0))+$L($P(X," ",Q))>72 "S Y=Y+1,PSG(Y,0)=""""" S PSG(Y,0)=PSG(Y,0)_$P(X," ",Q)_" "
 D ^XMD K ND,PSG Q
