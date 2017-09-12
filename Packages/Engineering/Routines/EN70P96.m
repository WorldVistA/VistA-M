EN70P96 ;ALB/CXW - EN V7.0 POST INIT, NX BOC Update; 05/05/14 1:03 pm
 ;;7.0;ENGINEERING;**96**;Aug 17, 1993;Build 5
 Q
 ;
POST ; entry point for post-init
 ; Updates to the NX BOC file (#6914.4)
 N ENX
 D MSG("    EN*7.0*96 Post-Install .....")
 D UPBOC
 D MSG("    EN*7.0*96 Post-Install Complete")
 Q
 ;
UPBOC ; add 1 new BOC and deactivate 3 BOCs
 N U,ENI,ENBOC,ENBOC1,ENDDT,ENDDT1,ENRC,ENSGL,ENSGL1,ENTL,DIC,DIE,DR,X,Y,DA
 S U="^" D MSG("")
 D MSG(">>> Updating Budget Object Code (BOC) in the NX BOC file (#6914.4)...")
 F ENI=1:1 S ENRC=$P($T(NXBOC+ENI),";;",2) Q:ENRC="QUIT"  D
 . S ENBOC=$P(ENRC,U)
 . S ENBOC1=$O(^ENG(6914.4,"B",ENBOC,0))
 . S ENTL=$P(ENRC,U,2)
 . S ENDDT=$P(ENRC,U,4)
 . S ENSGL=$P(ENRC,U,3)
 . S ENSGL1=$O(^ENG(6914.3,"B",ENSGL,0))
 . ; add a new code
 . I 'ENBOC1 D  Q
 .. I 'ENSGL1 D MSG(" >> SGL "_ENSGL_" for BOC "_ENBOC_" not defined in the NX SGL file (#6914.3), no update") Q
 .. ; the old code should already exist in the file
 .. I ENDDT D MSG(" >> "_ENBOC_" not defined in the NX BOC file (#6914.4). no update") Q
 .. S X=ENBOC,DIC="^ENG(6914.4,",DIC(0)="" D FILE^DICN
 .. I Y<0 D MSG(" >> ERROR when adding "_ENBOC_" to the file, Log a Remedy ticket!") Q
 .. S DA=+Y,DIE=DIC,DR="1///"_$P(ENRC,U,2)_";2///"_ENSGL1 D ^DIE
 .. D MSG(" >> "_ENBOC_" "_ENTL_" added")
 . S ENRC=$G(^ENG(6914.4,ENBOC1,0))
 . S ENDDT1=$P(ENRC,U,5)
 . ; deactivate the code
 . I ENDDT'=ENDDT1 D  Q
 .. S DA=ENBOC1,DIE="^ENG(6914.4,",DR="4///"_ENDDT D ^DIE
 .. D MSG(" >> "_ENBOC_" "_ENTL_" deactivated with date "_$$FMTE^XLFDT(ENDDT))
 . D MSG(" >> "_ENBOC_" "_ENTL_" has already been "_$S(ENDDT:"deactivated in",1:"added to")_" the file")
 D MSG("")
 Q
 ;
MSG(ENX) ;
 D MES^XPDUTL(ENX)
 Q
 ;
NXBOC ; capitalized budget object code^boc title^corresponding sgl^deactivated date
 ;;3105^TRUST EQUIPMENT^1750^3080828
 ;;3122^OFFICE AUTOMATION/WORD PROCESSING, PURCHASED^1750^3140508
 ;;3123^ADP EQUIPMENT^1751^3140508
 ;;3138^IT HARDWARE-CAPITALIZED^1751
 ;;QUIT
 ;
 Q
