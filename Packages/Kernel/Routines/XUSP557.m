XUSP557 ;JLI/FO-OAK-INSTALL DATA FOR MDWS APPS IN REMOTE APPLICATION FILE ;05/25/11  09:20
 ;;8.0;KERNEL;**557**;Jul 10, 1995;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; the following is run as a part of the install for patch XU*8*557
ENTRY ; enters the values following tag DATA into file 8994.5
 N FDA,FDA1,FDA2,NSET1,NSET2,OFFSET,LINE,XUSIEN1,XUSMSG1,NEW,XUSIEN2,XUSMSG2
 ; 110217 added to remove entries if already entered, e.g., at test sites, so they can be entered correctly
 F OFFSET=1:1 S LINE=$P($T(DATA+OFFSET),";;",2) Q:LINE=""  S NEW=$P(LINE,"^") I NEW'="" D
 . F XUSIEN2=0:0 S XUSIEN2=$O(^XWB(8994.5,"B",NEW,XUSIEN2)) Q:XUSIEN2'>0  D
 . . N DA,DIK S DA=XUSIEN2,DIK="^XWB(8994.5,"  D ^DIK
 . . Q
 . Q
 ; 110217 end of addition
 S NSET1=0
 F OFFSET=1:1 S LINE=$P($T(DATA+OFFSET),";;",2) Q:LINE=""  S NEW=($P(LINE,"^")'="") D
 . I NEW S NSET1=NSET1+1,NSET2=0 D ADD1(.FDA1,LINE,NSET1) Q
 . S NSET2=NSET2+1 D SET2(.FDA,LINE,NSET1,NSET2)
 . Q
 D UPDATE^DIE("E","FDA1","XUSIEN1","XUSMSG1")
 I $D(XUSMSG1) W !,"ERROR MESSAGES:",! F OFFSET=0:0 S OFFSET=$O(XUSMSG1(OFFSET)) Q:OFFSET'>0  W !,"   ",XUSMSG1(OFFSET)
 D ADD2(.FDA2,.FDA,.XUSIEN1)
 ; 110310 added to insure OR CPRS GUI CHART gets added correctly to context option
 S XUSIEN1=$$FIND1^DIC(19,"","B","MWVS MEDICAL DOMAIN WEB SVCS")
 I $G(^DIC(19,XUSIEN1,10,1,0))'>0 D
 . S XUSIEN2=$$FIND1^DIC(19,"","B","OR CPRS GUI CHART") Q:XUSIEN2'>0
 . K FDA
 . ; if already present, but incorrect
 . I $D(^DIC(19,XUSIEN1,10,1)) S FDA(19.01,"1,"_XUSIEN1_",",.01)=XUSIEN2 D FILE^DIE("","FDA") I 1
 . ; if not already present
 . E  N NEWIEN S NEWIEN(1)=1 S FDA(19.01,"+1,"_XUSIEN1_",",.01)=XUSIEN2 D UPDATE^DIE("","FDA","NEWIEN","MESSG")
 . Q
 ; end of 110310 insertion
 ; 110401 need to force NHIN GET VISTA DATA in as an RPC if not there already
 S XUSIEN2=$$FIND1^DIC(19.05,","_XUSIEN1_",","B","NHIN GET VISTA DATA")
 I XUSIEN2'>0 D
 . K FDA S FDA(19.05,"+1,"_XUSIEN1_",",.01)="NHIN GET VISTA DATA"
 . D UPDATE^DIE("E","FDA","NEWIEN","MESSG")
 . Q
 ; end of 110401 insertion
 Q
 ;
ADD1(FDA,LINE,SET1) ; build data for primary file entry
 ; FDA - passed by reference - FileMan data array
 ; LINE - contains text of current line with data
 ; SET1 - current data set number for primary file
 N IENS S IENS="+"_SET1_","
 S FDA(8994.5,IENS,.01)=$P(LINE,"^")
 S FDA(8994.5,IENS,.02)=$P(LINE,"^",2)
 S FDA(8994.5,IENS,.03)=$P(LINE,"^",3)
 Q
 ;
SET2(FDA,LINE,SET1,SET2) ; capture data for sub-file entry
 ; FDA - passed by reference - FileMan data array
 ; LINE - contains text of current line with data
 ; SET1 - current data set number for primary file
 ; SET2 - current data set number for sub-file
 S FDA(SET1,SET2,.01)=$P(LINE,"^",2)
 S FDA(SET1,SET2,.02)=$P(LINE,"^",3)
 S FDA(SET1,SET2,.03)=$P(LINE,"^",4)
 S FDA(SET1,SET2,.04)=$P(LINE,"^",5)
 Q
 ;
ADD2(FDA2,FDA,IENSVALS) ; build data for sub-file entry
 N I,J,FLD,IENS,XUSMSG1,IENS1,OFFSET
 F I=1:1 D:$D(FDA2)  K FDA2 Q:'$D(FDA(I))  F J=1:1 Q:'$D(FDA(I,J))  S IENS="+"_J_","_IENSVALS(I)_"," F FLD=0:0 S FLD=$O(FDA(I,J,FLD)) Q:FLD'>0  S FDA2(8994.51,IENS,FLD)=FDA(I,J,FLD)
 . K XUSMSG1,IENS1
 . D UPDATE^DIE("E","FDA2","IENS1","XUSMSG1")
 . I $D(XUSMSG1) W !,"ERRORS:",!  F OFFSET=0:0 S OFFSET=$O(XUSMSG1(OFFSET)) Q:OFFSET'>0  W !,XUSMSG1(OFFSET)
 . Q
 Q
 ;
DATA ;
 ;;MYHEALTHEVET^MWVS MEDICAL DOMAIN WEB SVCS^41-WAcN_=NSXJ+ok4g_J
 ;;^H^80^VAAACAPPL.AAC.DVA.VA.GOV^/MDWS2/Web/Validate.aspx
 ;;^H^80^10.224.43.3^/MDWS2/Web/Validate.aspx
 ;;^H^80^VHAANNWEB2.V11.MED.VA.GOV^/UserValidation/Validate.aspx
 ;;NATIONAL SUICIDE HOTLINE^MWVS MEDICAL DOMAIN WEB SVCS^$wq`WLq(0jWV2f`4xf*
 ;;^H^80^VHAV08SHS1.V08.MED.VA.GOV^/MDWS2/Web/Validate.aspx
 ;;^H^80^10.71.38.77^/MDWS2/Web/Validate.aspx
 ;;^H^80^VHAANNWEB2.V11.MED.VA.GOV^/UserValidation/Validate.aspx
 ;;NATIONAL HOMELESS HOTLINE^MWVS MEDICAL DOMAIN WEB SVCS^cy2jzn)*;U%%3~,0p@4
 ;;^H^80^VHAV08SHS1.V08.MED.VA.GOV^/MDWS2/Web/Validate.aspx
 ;;^H^80^10.71.38.77^/MDWS2/Web/Validate.aspx
 ;;^H^80^VHAANNWEB2.V11.MED.VA.GOV^/UserValidation/Validate.aspx
 ;;NUMI^MWVS MEDICAL DOMAIN WEB SVCS^\8,c,LP$5.qu]l\D@xA$
 ;;^H^80^VANCRWEBV4.VHA.MED.VA.GOV^/MDWS2/Web/Validate.aspx
 ;;^H^80^VANCRWEBV5.VHA.MED.VA.GOV^/MDWS2/Web/Validate.aspx
 ;;^H^80^10.208.20.108^/MDWS2/Web/Validate.aspx
 ;;^H^80^VAISHWEBV1.VHA.MED.VA.GOV^/MDWS2/Web/Validate.aspx
 ;;MOVE^MWVS MEDICAL DOMAIN WEB SVCS^<9-SaNOYLMyTo.=Okk;
 ;;^H^80^VHAANNWEB2.V11.MED.VA.GOV^/UserValidation/Validate.aspx
 ;;^H^80^10.93.160.32^/UserValidation/Validate.aspx
 ;;^H^80^VHAANNVISTAWEB.V11.MED.VA.GOV^/UserValidation/Validate.aspx
 ;;TBI SCREENING^MWVS MEDICAL DOMAIN WEB SVCS^PvUv9RSQ.9W@FD3DcB_?
 ;;^H^80^VHAANNWEB2.V11.MED.VA.GOV^/UserValidation/Validate.aspx
 ;;^H^80^10.93.160.32^/UserValidation/Validate.aspx
 ;;^H^80^VHAANNVISTAWEB.V11.MED.VA.GOV^/UserValidation/Validate.aspx
 ;;MEDICAL DOMAIN WEB SERVICES^MWVS MEDICAL DOMAIN WEB SVCS^WHgafhAkItJqu&]Cbp<H
 ;;^H^80^VHAANNWEB2.V11.MED.VA.GOV^/UserValidation/Validate.aspx
 ;;^H^80^10.93.160.32^/UserValidation/Validate.aspx
 ;;^H^80^VHAANNVISTAWEB.V11.MED.VA.GOV^/UserValidation/Validate.aspx
 ;;PCS ANALYTICS^MWVS MEDICAL DOMAIN WEB SVCS^]y7`bj-T=*Elz6Q#wYM0
 ;;^H^80^VHAANNWEB2.V11.MED.VA.GOV^/UserValidation/Validate.aspx
 ;;^H^80^10.93.160.32^/UserValidation/Validate.aspx
 ;;^H^80^VHAANNVISTAWEB.V11.MED.VA.GOV^/UserValidation/Validate.aspx
