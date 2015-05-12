PSN4P406 ;ALB/HW-Pre Install Patients with Inactive Ingredients as Causative Agents Report ; 8/14/14 4:03pm
 ;;4.0;NATIONAL DRUG FILE;**406**; 30 Oct 98;Build 7
 ;      This routine uses the following IAs:
 ;      #5843  - Read file 120.8   (controlled)
 ;      #10061 - DEM^VADPT         (supported)
 ;      #10070 - ^XMD              (supported)
 Q  ;Must be called at entry point
 ;Only looking for patients that are not deceased and
 ;where the inactive ingredient has been entered directly as a causative agent.
EN N PSNIEN,PSNINING,DFN,PSNCOUNT,DIFROM
 K ^TMP("PSN",$J)
 S PSNIEN=0,PSNCOUNT=0
 D BMES^XPDUTL("Patients with Inactive Ingredient(s) Entered as Causative Agent(s)")
 S ^TMP("PSN",$J,0)="       "_"Patients with Inactive Ingredient(s) Entered as Causative Agent(s)"
 D MES^XPDUTL("                                                                       ")
 D BMES^XPDUTL("DFN                            Inactive Ingredient to be Corrected   ")
 D BMES^XPDUTL("                                                                       ")
 S ^TMP("PSN",$J,1)="DFN"_"                            "_"Inactive Ingredient to be Corrected   "
 F  S PSNIEN=$O(^PS(50.416,PSNIEN)) Q:PSNIEN'>0  D
 .I $G(^PS(50.416,PSNIEN,2))'>0 Q
 .S PSNINING=$P(^PS(50.416,PSNIEN,0),"^") D FINDPAL(PSNINING,PSNIEN,.PSNCOUNT) Q
 I PSNCOUNT<1 D
 .D BMES^XPDUTL("No patient allergies with inactive ingredient as causative agent found")
 .D MES^XPDUTL("                                                                       ")
 .S ^TMP("PSN",$J,PSNCOUNT+2)="No patient allergies with inactive ingredient as causative agent found"
 S XMSUB="Patient Allergies with Inactive Ingredients",XMTEXT="^TMP(""PSN"",$J,",XMY(DUZ)=""
 D BMES^XPDUTL("                                                                       ")
 D BMES^XPDUTL("                                                                       ")
 D ^XMD K XMSUB,XMTEXT,XMY
 Q
FINDPAL(PSNINING,PSNIEN,PSNCOUNT) ;Search C cross-ref for matching ingr name to get 120.8 data                                           
 N PSNPALR,PSNOUT,PSNPIEN,PSNX,PSNDGMAL,DFN,VADM,VAERR,VA,PSNSP1,PSNSPN1
 D FIND^DIC(120.8,"","@;.01EI;.02;1I;22I","X",PSNINING,"","C","","","PSNPALR($J)","PSNOUT($J)")
 I $D(PSNOUT($J,"DIERR"))>0 D
 .S ^XTMP("PSN4P406",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^Errors matching ingredients"
 .M ^XTMP("PSN4P406")=PSNOUT($J)
 .D MES^XPDUTL("Error matching ingredient name")
 .S PSNCOUNT=PSNCOUNT+1,^TMP("PSN",$J,PSNCOUNT+2)="Error: Problem matching ingredient name"
 ;Check if entered in error and if GMR Allergy value matches 
 I $P($G(PSNPALR($J,"DILIST",0)),"^")<1 Q
 S PSNPIEN=0
 F  S PSNPIEN=$O(PSNPALR($J,"DILIST",2,PSNPIEN)) Q:PSNPIEN'>0  D
 .I PSNPALR($J,"DILIST","ID",PSNPIEN,22)>0 Q
 .S PSNDGMAL=PSNPALR($J,"DILIST","ID",PSNPIEN,1)
 .I PSNDGMAL'["PS(50.416" Q
 .I +PSNDGMAL'=PSNIEN Q
 .;Check if patient has DATE OF DEATH
 .S DFN=PSNPALR($J,"DILIST","ID",PSNPIEN,.01,"I")
 .D DEM^VADPT
 .I VAERR D  Q
 ..D MES^XPDUTL("Error: Problem retrieving demographic data for DFN: "_DFN)
 ..S PSNCOUNT=PSNCOUNT+1,^TMP("PSN",$J,PSNCOUNT+2)="Error: Problem retrieving demographic data for DFN: "_DFN
 .I VADM(6)<1 D
 ..S PSNSP1=" "
 ..S PSNSPN1=30-$L(DFN) F PSNX=1:1:PSNSPN1 S PSNSP1=PSNSP1_" "
 ..S PSNCOUNT=PSNCOUNT+1,^TMP("PSN",$J,PSNCOUNT+2)=DFN_PSNSP1_PSNINING
 ..D MES^XPDUTL(DFN_PSNSP1_PSNINING)
